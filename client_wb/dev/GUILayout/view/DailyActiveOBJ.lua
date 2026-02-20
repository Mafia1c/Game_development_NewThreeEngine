local DailyActiveOBJ = {}
DailyActiveOBJ.Name = "DailyActiveOBJ"
DailyActiveOBJ.RunAction = true
DailyActiveOBJ.jindu_list = {30,80,150,240,360,420,500}
local _cfg = GetConfig("DailyActiveCfg")
local tmp_cfg = {}
for index, v in ipairs(_cfg) do
    tmp_cfg[v.type] = tmp_cfg[v.type] or {}
    table.insert(tmp_cfg[v.type], v)
end
DailyActiveOBJ.cfg = tmp_cfg

function DailyActiveOBJ:main(sMsg, point, total, state)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/DailyActiveUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.task_cell_list = {}
    self.cur_info = BitMgr.NumToTab(tonumber(state))

    self:initClickEvent()
    self:CreateTaskCell()
    self:ShowRewardData()
    self:UpdateUiInfo(sMsg, point, total)
end

function DailyActiveOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    for i = 1, 7, 1 do
        GUI:addOnClickEvent(self.ui["get_reward_"..i], function()
            SendMsgClickMainBtn("0#DailyActive#onGetReward#"..i)
        end)
    end
    for i = 1, 3, 1 do
        GUI:addOnClickEvent(self.ui["ex_btn_"..i], function()
            SendMsgClickMainBtn("0#DailyActive#onExchangeReward#"..i)
        end)
    end

    GUI:addOnClickEvent(self.ui.jackpotBtn, function()
        SendMsgClickMainBtn("0#DailyActive#onOpenJackpotView")
    end)
end

function DailyActiveOBJ:ShowRewardData()
    local reward_data = self.cfg["达成奖励"]
    for index, v in ipairs(reward_data) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(v.reward_arr[1])
        local count = v.reward_arr[2]
        ItemShow_updateItem(self.ui["ItemShow_"..index], {index = item_id, look = true, bgVisible = true, count = count})
    end

    local exchange_data = self.cfg["兑换奖励"]
    for index, v in ipairs(exchange_data) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(v.reward_arr[1])
        local count = v.reward_arr[2]
        ItemShow_updateItem(self.ui["exchange_item_"..index], {index = item_id, look = true, bgVisible = true, count = count})
    end
end

function DailyActiveOBJ:CreateTaskCell()
    local task_data = self.cfg["每日任务"]
    for index, v in ipairs(task_data) do
        local value = GameData.GetData("J_daily_active_"..v.param, false) or 0
        local ui = {}
        ui.item_cell = GUI:Image_Create(self.ui.taskList, "cell_"..index, 0, 0, "res/custom/npc/19fl/k1.png")
        GUI:setContentSize(ui.item_cell, 484, 50)
        GUI:Image_setScale9Slice(ui.item_cell, 10, 10, 10, 10)

        ui.task_name = GUI:ScrollText_Create(ui.item_cell, "name", 99, 25, 200, 16, "#ff9b00", v.task, 10)
        GUI:setAnchorPoint(ui.task_name, 0.5, 0.5)
        ui.progress = GUI:Text_Create(ui.item_cell, "progress", 245, 25, 16, value < v.count and "#ff0000" or "#00ff00", value .. "/"..v.count)
        GUI:setAnchorPoint(ui.progress, 0.5, 0.5)
        ui.ret_point = GUI:Text_Create(ui.item_cell, "ret_point", 335, 25, 16, "#ffffff", string.format("每次%s点", v.rewardhyd))
        GUI:setAnchorPoint(ui.ret_point, 0.5, 0.5)
        ui.state = GUI:Text_Create(ui.item_cell, "state", 433, 25, 16, value < v.count and "#ff0000" or "#00ff00", value < v.count and "立即前往" or "已达成")
        GUI:setAnchorPoint(ui.state, 0.5, 0.5)
        GUI:Text_enableUnderline(ui.state)
        GUI:setTouchEnabled(ui.state, true)
        GUI:addOnClickEvent(ui.state, function()
            SendMsgClickMainBtn("0#DailyActive#onGoCompleteTask#"..index)
        end)
        self.task_cell_list[index] = ui
    end
end

function DailyActiveOBJ:UpdateUiInfo(sMsg, point, total)
    point = tonumber(point) or 0
    total = tonumber(total) or 0
    GUI:Text_setString(self.ui.my_active_txt, "今日活跃: "..point)
    GUI:Text_setString(self.ui.total_active_txt, "累计活跃: "..total)

    local info = SL:JsonDecode(sMsg, false)
    if "" == info or nil == info then
        info = {}
    end
    for i = 1, 7, 1 do
        local has = isInTable(info, i)
        GUI:setVisible(self.ui["get_reward_"..i], not has)
        GUI:setVisible(self.ui["btn_txt_"..i], not has)
        GUI:setVisible(self.ui["get_tag_"..i], has)
    end

    for index, value in ipairs(self.cur_info) do
        local ui = self.task_cell_list[index]
        if ui then
            if GUI:Text_getString(ui.state) == "已达成" and value == 0 then
                local red = GUI:Image_Create(ui.state, "red_icon", 40, 10, "res/custom/red1.png")
            else
                GUI:removeAllChildren(ui.state)
            end
            if value == 1 then
                GUI:Text_setString(ui.state, "已领取")
            end
        end
    end
end

function DailyActiveOBJ:flushView(sMsg, point, total, state)
    self.cur_info = BitMgr.NumToTab(tonumber(state))
    self:UpdateUiInfo(sMsg, point, total)
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "DailyActiveOBJ",["node"] = self,["is_all"] = true})
end

function DailyActiveOBJ:GetBtnRedShow(index)
    index = tonumber(index)
    if  index == nil then return false end
    local point = GameData.GetData("J_today_point_value", false) or 0
    local need_point = DailyActiveOBJ.jindu_list[index]
    if point < need_point then
        return false
    end
    local get_state = GameData.GetData("Z_active_reward",true)or{}
    if isInTable(get_state,index)  then
        return false
    end
    return true
end

function DailyActiveOBJ:CheckTopBtnRed()
    local task = DailyActiveOBJ.cfg["每日任务"]
    local get_state = GameData.GetData("J_daily_active_data", false) or 0
    local tab = BitMgr.NumToTab(get_state)
    for key, v in ipairs(task) do
        local count = GameData.GetData("J_daily_active_"..v.param, false) or 0
        if count >= v.count and tab[key] == 0 then
            return true
        end
    end
    return false
end

return DailyActiveOBJ