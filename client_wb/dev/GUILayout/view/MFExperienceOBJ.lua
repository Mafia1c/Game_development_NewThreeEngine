local MFExperienceOBJ = {}
MFExperienceOBJ.Name = "MFExperienceOBJ"
MFExperienceOBJ.RunAction = true
MFExperienceOBJ.cfg = GetConfig("MaFaLiLianCfg")

function MFExperienceOBJ:main(index, value, info)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/MFExperienceUI", function() end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_index = tonumber(index) + 1
    self.info_data = BitMgr.NumToTab(value)
    self.today_info = BitMgr.NumToTab(info)
    self.lilian_cell_list = {}
    self.title_eff = nil
    self.cur_page = 1

    self:initClickEvents()
    self:onPageChange()
    self:ShowTitleEffect()
end

function MFExperienceOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("MFExperienceOBJ")
    end)

    GUI:addOnClickEvent(self.ui.activeBtn, function()
        SendMsgCallFunByNpc(0, "MaFaGuJiNpc", "onChangeTitle", self.cur_index)
    end)

    for i = 1, 3, 1 do
        GUI:addOnClickEvent(self.ui["page_btn_"..i], function()
            if i == self.cur_page then
                return
            end
            self:onPageChange(i)
        end)
    end
end

function MFExperienceOBJ:onPageChange(index)
    index = index or self.cur_page
    local big_map = GameData.GetData("U_bigMap", false) or 0
    local map_tab = {
        [1] = {3, "【盟重土城】"},
        [2] = {"bairi", "【白日门】"},
        [3] = {"4", "【封魔谷】"}
    }
    local info = map_tab[index]
    local map_id = info[1]
    if index > 1 then
        if big_map < index then
            SL:ShowSystemTips("你还未探索过<font color='#ffff00'>"..info[2].."</font>大陆!")
            return
        end
    end
    self:UpdatePageBtnColor(index)
    self.cur_page = index
    GUI:ListView_removeAllItems(self.ui.taskList)
    self.lilian_cell_list = {}
    local task_data = {}
    for key, v in ipairs(self.cfg) do
        local value = GameData.GetData("J_lilian_kill_"..v.key_name, false) or 0
        local num = v.num
        if self.info_data[key] == 1 then
            num = v.nextnum
        end
        local sort = 1000 + key
        if value >= num and self.today_info[key] == 0 then
            sort = key
        end
        if self.today_info[key] == 1 then
            sort = 2000 + key
        end
        local data = v
        if v.mapid == map_id then
            data.sort = sort
            task_data[#task_data + 1] = data
        end
    end
    table.sort(task_data, function (a,b)
        return a.sort < b.sort
    end)
    if #task_data <= 0 then
        SL:ShowSystemTips("暂无"..info[2] .. "大陆历练信息!")
        return
    end
    self:CreateTaskCell(task_data)
end

function MFExperienceOBJ:UpdatePageBtnColor(index)
    GUI:Button_setTitleColor(self.ui["page_btn_"..self.cur_page], "#ffffff")
    GUI:Button_setTitleColor(self.ui["page_btn_"..index], "#00ff00")
end

function MFExperienceOBJ:CreateTaskCell(ui_date)
    for index, v in ipairs(ui_date) do
        local value = GameData.GetData("J_lilian_kill_"..v.key_name, false) or 0
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(v.firstreward_arr[1])
        local count = v.firstreward_arr[2]
        local progress = v.progress
        local num = v.num
        if self.info_data[v.key_name] == 1 then
            item_id = SL:Get_ITEM_INDEX_BY_NAME(v.dailyreward_arr[1])
            count = v.dailyreward_arr[2]
            progress = v.nextprogress
            num = v.nextnum
        end
        local ui = {}

        ui.item_cell = GUI:Image_Create(self.ui.taskList, "cell_"..v.key_name, 0, 0, "res/custom/npc/19fl/k1.png")
        GUI:setContentSize(ui.item_cell, 484, 66)
        GUI:Image_setScale9Slice(ui.item_cell, 10, 10, 10, 10)

        ui.task_name = GUI:ScrollText_Create(ui.item_cell, "name", 99, 33, 200, 16, "#ff9b00", v.mapname, 10)
        GUI:setAnchorPoint(ui.task_name, 0.5, 0.5)
        ui.progress = GUI:Text_Create(ui.item_cell, "progress", 245, 33, 16, value < num and "#ff0000" or "#00ff00", string.format(progress, value))
        GUI:setAnchorPoint(ui.progress, 0.5, 0.5)
        local item = GUI:ItemShow_Create(ui.item_cell, "item_"..v.key_name, 335, 33, {showCount = true, count = count, color = 255, index = item_id, look = true, bgVisible = true})
        GUI:setAnchorPoint(item, 0.5, 0.5)
        ui.item = item
        ui.state = GUI:Text_Create(ui.item_cell, "state", 433, 33, 16, value < num and "#ff0000" or "#00ff00", value < num and "立即前往" or "已达成")
        GUI:setAnchorPoint(ui.state, 0.5, 0.5)
        GUI:Text_enableUnderline(ui.state)
        GUI:setTouchEnabled(ui.state, true)
        GUI:addOnClickEvent(ui.state, function()
            SendMsgCallFunByNpc(0, "MaFaGuJiNpc", "onGoToKillMon", v.key_name)
        end)
        self.lilian_cell_list[v.key_name] = ui
    end
end

function MFExperienceOBJ:ShowTitleEffect()
    if self.title_eff then
        GUI:removeFromParent(self.title_eff)
        self.title_eff = nil
    end
    local sex = SL:GetMetaValue("SEX")
    local cfg = self.cfg[self.cur_index] or self.cfg[#self.cfg]
    self.title_eff = GUI:Effect_Create(self.ui.FrameLayout, "title", 680, 400, 0, cfg.effectid or 1, sex, 0, 0, 1)

    local value = tonumber(SL:Get_MONEY(25))
    GUI:Text_setString(self.ui.Text_1, "历练称号: "..cfg.chreward)
    GUI:Text_setString(self.ui.Text_2, "所需历练值: "..cfg.neednum)
    GUI:Text_setString(self.ui.Text_3, "当前历练值: "..value)
    GUI:Text_setTextColor(self.ui.Text_3, value < cfg.neednum and "#ff0000" or "#00ff00")
    
    local item_id = SL:Get_ITEM_INDEX_BY_NAME(cfg.chreward .. "(称号)")
    ItemShow_updateItem(self.ui.ItemShow_1, {index = item_id, look = true, bgVisible = true})

    local show_red = true
    local title = SL:Get_TITLES()
    local max_item_id = SL:Get_ITEM_INDEX_BY_NAME("剑荡千万里")
    for index, v in ipairs(title) do
        if v.id == item_id or v.id == max_item_id then
            show_red = false
        end
    end

    if value >= cfg.neednum and show_red then
        local red = GUI:Image_Create(self.ui.activeBtn, "red_icon", 100, 25, "res/custom/red1.png")
    else
        GUI:removeAllChildren(self.ui.activeBtn)
    end

    for index, state in ipairs(self.today_info) do
        local ui = self.lilian_cell_list[index]
        if ui then
            if GUI:Text_getString(ui.state) == "已达成" and state == 0 then
                local red = GUI:Image_Create(ui.state, "red_icon", 40, 10, "res/custom/red1.png")
            else
                GUI:removeAllChildren(ui.state)
            end
            if state == 1 then
                GUI:Text_setString(ui.state, "已领取")
            end
        end
    end
end

function MFExperienceOBJ:flushView(index, reward, info)
    self.cur_index = tonumber(index) + 1
    self.info_data = BitMgr.NumToTab(tonumber(reward))
    self.today_info = BitMgr.NumToTab(tonumber(info))
    self:ShowTitleEffect()
end

function MFExperienceOBJ:CheckBubble()
    local index = GameData.GetData("U_lilian_title_index", false) or 0
    index = index + 1
    local cfg = self.cfg[index]
    if nil == cfg then
        return false
    end
    local value = tonumber(SL:Get_MONEY(25))
    if cfg.neednum and value >= cfg.neednum then
        return true
    end
    return false
end

return MFExperienceOBJ