local WelfareHallOBJ = {}
WelfareHallOBJ.Name = "WelfareHallOBJ"
WelfareHallOBJ.RunAction = false
-- 登录
local _login_cfg = {}
for key, v in ipairs(GetConfig("LoginRewardCfg")) do
    local data = v
    data.item_arr = {}
    local tab = SL:Split(v.giveitem, "&")
    for index, value in ipairs(tab) do
        local t = SL:Split(value, "#")
        local tmp = {t[1], tonumber(t[2])}
        table.insert(data.item_arr , tmp)
    end
    _login_cfg[key] = data
end
WelfareHallOBJ.LoginCfg = _login_cfg
-- 每日充值
local _daily_cfg = {}
for index, v in ipairs(GetConfig("DailyRewardCfg")) do
    local data = v
    data.item_arr = {}
    local tab = SL:Split(v.giveitem, "&")
    for key, value in ipairs(tab) do
        local t = SL:Split(value, "#")
        local tmp = {t[1], tonumber(t[2])}
        table.insert(data.item_arr , tmp)
    end
    _daily_cfg[index] = data
end
WelfareHallOBJ.DailyGiftCfg = _daily_cfg
WelfareHallOBJ.UpLevelCfg = GetConfig("UpLevelRewardCfg")
-- 首爆奖励
WelfareHallOBJ.FirstDropCfg = GetConfig("FirstDropCfg")
-- 累充奖励
WelfareHallOBJ.RechargeCfg = GetConfig("TotalRechargeCfg")
-- 客服礼包
WelfareHallOBJ.ServiceGiftCfg = GetConfig("ServiceGiftCfg")


function WelfareHallOBJ:main(sMsg, sMsg2, page)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/WelfareHallUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_page_index = tonumber(page) or 1
    self.login_item_cell = {}            -- 登录奖励
    self.up_level_item = {}              -- 升级奖励
    self.first_item_cell = {}            -- 首爆奖励
    self.recharge_item_cell = {}         -- 累充奖励
    self.cur_first_drop_page = 1         -- 当前首爆第几页
    self.boss_drop_total = math.ceil(#self.FirstDropCfg / 10)

    self.all_first_data = {}
    self.person_first_dorp = {}

    self:initClickEvent()
    self:onChangePage()
    self:showPageInfo(self.cur_page_index, sMsg, sMsg2)

    local mzl_cfg = self.LoginCfg[8]
    if mzl_cfg then
        for index, v in ipairs(mzl_cfg.item_arr) do
            local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", v[1]) or 0
            ItemShow_updateItem(self.ui["day_item_"..index], {showCount = true, count = v[2], color = 255,index = item_id, look = true, bgVisible = true})
        end
    end

    local str = "全服首曝打到即可获得奖励,每次合区重置刷新首爆(可再次进行全服首爆)。"
    GUI:Text_setString(self.ui.Text_1, str)
end

function WelfareHallOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    for i = 1, 7 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            if i == self.cur_page_index then
                return
            end
            SendMsgClickMainBtn("0#WelfareHall#onPageChange#"..i)
        end)
    end

    GUI:addOnClickEvent(self.ui.DayGiftBtn, function()
        SendMsgClickMainBtn("0#WelfareHall#onGetTodayGift")
    end)

    for i = 1, 8 do
        GUI:addOnClickEvent(self.ui["getRechareBtn_"..i], function()
            SendMsgClickMainBtn("0#WelfareHall#onGetDayRechargeReward#"..i)
        end)
    end

    GUI:addOnClickEvent(self.ui.L_btn, function()
        self.cur_first_drop_page = self.cur_first_drop_page - 1
        if self.cur_first_drop_page < 1 then
            self.cur_first_drop_page = 1
            SL:ShowSystemTips("当前已是第一页!")
            return
        end
        self:updateFirstDropInfo()
    end)
    GUI:addOnClickEvent(self.ui.R_btn, function()
        self.cur_first_drop_page = self.cur_first_drop_page + 1
        if self.cur_first_drop_page > self.boss_drop_total then
            self.cur_first_drop_page = self.boss_drop_total
            SL:ShowSystemTips("当前已是最后一页!")
            return
        end
        self:updateFirstDropInfo()
    end)
    GUI:addOnClickEvent(self.ui.exchange_btn, function()
        SendMsgClickMainBtn("0#WelfareHall#onCDKExchange#1")
    end)

    -- 648一键打包
    if self.ui.allBuyBtn then
        GUI:addOnClickEvent(self.ui.allBuyBtn, function()
            SendMsgClickMainBtn("0#WelfareHall#onBuy648Gift")
        end)
    end
    GUI:addOnClickEvent(self.ui.exchange_btn_1, function()
        local cdk_str = GUI:TextInput_getString(self.ui.TextInput_1)
        if "" == cdk_str then
            SL:ShowSystemTips("请输入CDK码!")
            return
        end
        SendMsgClickMainBtn("0#WelfareHall#onCDKExchange#"..cdk_str)
    end)

    GUI:addOnClickEvent(self.ui.callBtn, function()
        GUI:setVisible(self.ui.er_wei_ma, true)
    end)

    -- 688一键打包
    if self.ui.allBuyBtn then
        GUI:addOnClickEvent(self.ui.buy688gift, function()
            SendMsgClickMainBtn("0#WelfareHall#onBuy688Gift")
        end)
    end
end

function WelfareHallOBJ:CreateLoginItemCell()

    -- 登录奖励
    for key, v in pairs(self.LoginCfg) do
        if key > 7 then
            break
        end
        local _ui = {}
        _ui.item_cell = GUI:Image_Create(self.ui.loginListView, "login_cell"..key, 0, 0, "res/custom/npc/19fl/k0.png")
        _ui.title_txt = GUI:RichTextFCOLOR_Create(_ui.item_cell, "title_txt"..key, 10, 75, string.format("累计登录<%d/FCOLOR=250>天", v.day), 500, 18, "#ffffff")
        _ui.reward_list = {}
        local x = 16
        for _, info in pairs(v.item_arr) do
            local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", info[1])
            local item = GUI:ItemShow_Create(_ui.item_cell, "reward_"..info[1], x, 12, {index = item_id, count = info[2], bgVisible = true, look = true})
            ItemShow_updateItem(item, {showCount = true, count = info[2], color = 255})
            _ui.reward_list[#_ui.reward_list + 1] = item
            x = x + 66
        end
        _ui.tag = GUI:Image_Create(_ui.item_cell, "icon_tag"..key, 218, 17, "res/custom/tag/ty-15.png")
        _ui.getBtn = GUI:Button_Create(_ui.item_cell, "get_btn"..key, 210, 25, "res/custom/npc/19fl/ztn2_1.png")
        GUI:Button_setTitleText(_ui.getBtn, "领  取")
        GUI:Button_setTitleFontSize(_ui.getBtn, 18)
        GUI:addOnClickEvent(_ui.getBtn, function()
            SendMsgClickMainBtn("0#WelfareHall#onGetLoginReward#"..v.day)
        end)
        GUI:setVisible(_ui.tag, false)

        self.login_item_cell[key] = _ui
    end

end

function WelfareHallOBJ:CreateFirstDorpItemCell()
    -- 首爆奖励
    local function create_first_reward_cell()
        for k = 1, 10 do
            local cfg = self.FirstDropCfg[k]
            local _ui = {}
            _ui.item_cell = GUI:Image_Create(self.ui.firstDropList, "drop_cell"..k, 0, 0, "res/custom/npc/19fl/k1.png")
            GUI:setContentSize(_ui.item_cell, 600, 70)
            GUI:Image_setScale9Slice(_ui.item_cell, 10, 10, 10, 10)
            
            _ui.item_name = GUI:Text_Create(_ui.item_cell, "item_name"..k, 90, 35, 18, "#ff9b00", cfg.name)
            GUI:setAnchorPoint(_ui.item_name, 0.5, 0.5)
            -- _ui.reward_list = {}
            local item_id1 = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.givemoney)
            local item1 = GUI:ItemShow_Create(_ui.item_cell, "reward_1", 265, 5, {index = item_id1, count = cfg.moneynum, bgVisible = true, look = true})
            _ui.item = item1
            _ui.player_name = GUI:ScrollText_Create(_ui.item_cell, "name_txt"..k, 508, 35, 150, 18, "#00ff00", "虚位以待", 5)
            GUI:setAnchorPoint(_ui.player_name, 0.5, 0.5)
            self.first_item_cell[k] = _ui
        end
    end
    create_first_reward_cell()
end

function WelfareHallOBJ:CreateUpLevelItemCell()
    -- 升级奖励
    local function create_up_level_cell()
        for index, v in ipairs(self.UpLevelCfg) do
            local _ui = {}
            _ui.item_cell = GUI:Image_Create(self.ui.levelListView, "level_cell"..index, 0, 0, "res/custom/npc/19fl/k1.png")
            GUI:setContentSize(_ui.item_cell, 604, 64)
            GUI:Image_setScale9Slice(_ui.item_cell, 10, 10, 10, 10)
    
            _ui.level_txt = GUI:Text_Create(_ui.item_cell, "level_txt"..index, 50, 32, 20, "#00ff00", v.level .. "级")
            GUI:setAnchorPoint(_ui.level_txt, 0.5, 0.5)
    
            _ui.reward_list = {}
            local x = 143
            local item_tab = SL:Split(v.giveitem, "&")
            for key, info in ipairs(item_tab) do
                local tab = SL:Split(info, "#")
                local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", tab[1]) or 0
                local count = tonumber(tab[2]) or 1
                local item = GUI:ItemShow_Create(_ui.item_cell, "item_"..key, x, 2, {showCount = true, count = count, color = 255, index = item_id, look = true, bgVisible = true})
                ItemShow_updateItem(item, {showCount = true, count = count, color = 255})
                table.insert(_ui.reward_list, item)
                x = x + 70
            end
            
            x = 335
            item_tab = SL:Split(v.giveitem1, "&")
            for key, info in ipairs(item_tab) do
                local tab = SL:Split(info, "#")
                local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", tab[1]) or 0
                local count = tonumber(tab[2]) or 1
                local item = GUI:ItemShow_Create(_ui.item_cell, "add_item_"..key, x, 2, {showCount = true, count = count, color = 255, index = item_id, look = true, bgVisible = true})
                ItemShow_updateItem(item, {showCount = true, count = count, color = 255})
                table.insert(_ui.reward_list, item)
                x = x + 70
            end

            _ui.tag = GUI:Image_Create(_ui.item_cell, "icon_tag", 480, 9, "res/custom/tag/fuli_zt_1.png")
            _ui.getBtn = GUI:Button_Create(_ui.item_cell, "getLevelBtn_"..index, 445, 15, "res/custom/npc/19fl/an55.png")
            GUI:addOnClickEvent(_ui.getBtn, function()
                SendMsgClickMainBtn("0#WelfareHall#onGetLevelReward#"..index)
            end)
            _ui.addBtn = GUI:Button_Create(_ui.item_cell, "addLevelBtn_"..index, 525, 15, "res/custom/npc/19fl/an13.png")
            GUI:addOnClickEvent(_ui.addBtn, function()
                SendMsgClickMainBtn("0#WelfareHall#onGetAddLevelReward#"..index)
            end)

            self.up_level_item[index] = _ui
        end
    end
    create_up_level_cell()
end

function WelfareHallOBJ:CreateRechargeItemCell()
    -- 累充奖励
    local function create_recharge_cell()
        local job = tonumber(SL:Get_JOB())
        for index, v in ipairs(self.RechargeCfg) do
            local _ui = {}
            _ui.item_cell = GUI:Image_Create(self.ui.rechargeListView, "recharge_cell"..index, 0, 0, "res/custom/npc/19fl/k1.png")
            GUI:setContentSize(_ui.item_cell, 602, 64)
            GUI:Image_setScale9Slice(_ui.item_cell, 10, 10, 10, 10)

            _ui.recharge_txt = GUI:RichTextFCOLOR_Create(_ui.item_cell, "recharge_txt"..index, 80, 32, "累计 <" .. v.num .. "/FCOLOR=250> 元", 150, 20, "#ffffff")
            GUI:setAnchorPoint(_ui.recharge_txt, 0.5, 0.5)

            _ui.reward_list = {}
            local x = 165
            local item_tab = v.giveitem_arr
            if index == 2 then
                if job == 1 then
                    item_tab = v.giveitem1_arr
                elseif job == 2 then
                    item_tab = v.giveitem2_arr
                else
                    item_tab = v.giveitem_arr
                end
            end
            for key, name in ipairs(item_tab) do
                local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", name) or 0
                local count = v.itemnum_arr[key]
                local item = GUI:ItemShow_Create(_ui.item_cell, "item_"..key, x, 2, {showCount = true, count = count, color = 255, index = item_id, look = true, bgVisible = true})
                ItemShow_updateItem(item, {showCount = true, count = count, color = 255})
                _ui.reward_list[key] = item
                x = x + 70
            end

            _ui.tag = GUI:Image_Create(_ui.item_cell, "icon_tag", 475, 9, "res/custom/tag/fuli_zt_1.png")
            _ui.getBtn = GUI:Button_Create(_ui.item_cell, "getRechargeBtn_"..index, 480, 15, "res/custom/npc/19fl/an55.png")
            GUI:addOnClickEvent(_ui.getBtn, function()
                SendMsgClickMainBtn("0#WelfareHall#onGetRechargeReward#"..index)
            end)
            if nil ~= v.ybbuy then
                _ui.buyBtn = GUI:Button_Create(_ui.item_cell, "buyBtn_"..index, 525, 15, "res/custom/npc/19fl/an11.png")
                GUI:addOnClickEvent(_ui.buyBtn, function()
                    SendMsgClickMainBtn("0#WelfareHall#onBuyRechargeReward#"..index)
                end)

                GUI:setPositionX(_ui.getBtn, 450)
            end

            self.recharge_item_cell[index] = _ui
        end
    end
    create_recharge_cell()
end

function WelfareHallOBJ:onChangePage(index)
    index = index or self.cur_page_index
    GUI:Button_loadTextureNormal(self.ui["Button_"..self.cur_page_index], "res/custom/npc/ta1.png")
    GUI:Button_loadTextureNormal(self.ui["Button_"..index], "res/custom/npc/ta0.png")

    local bg_path = {
        "res/custom/npc/19fl/bg1.png",
        "res/custom/npc/19fl/bg14.png",
        "res/custom/npc/19fl/bg11.png",
        "res/custom/npc/19fl/bg8.png",
        "res/custom/npc/19fl/bg111.png",
        "res/custom/npc/19fl/bg9.png",
        "res/custom/npc/19fl/bg15.png",
    }
    GUI:Image_loadTexture(self.ui.bg_Image, bg_path[index])

    for i = 1, 7 do
        GUI:setVisible(self.ui["Node_"..i], index == i)
    end
    self.cur_page_index = index

    if index == 1 and #self.login_item_cell <= 0 then
        self:CreateLoginItemCell()
    elseif index == 2 then
        for key, v in ipairs(self.DailyGiftCfg) do
            local ui = self.ui["dayReward_cell_"..key]
            for ket, info in pairs(v.item_arr) do
                local item = GUI:getChildByName(ui, "item_"..ket)
                local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", info[1]) or 0
                ItemShow_updateItem(item, {showCount = true, count = info[2], color = 255, index = item_id, look = true, bgVisible = true})
            end
        end
    elseif index == 3 and #self.up_level_item <= 0 then
        self:CreateUpLevelItemCell()
    elseif index == 4 and #self.first_item_cell <= 0 then
        self:CreateFirstDorpItemCell()
    elseif index == 5 and #self.recharge_item_cell <= 0 then
        self:CreateRechargeItemCell()
    elseif index == 6 then
        local v = self.ServiceGiftCfg[1]
        local tmp_tab = {}
        for key, num in pairs(v.giveitem_map) do
            tmp_tab[#tmp_tab + 1] = {key, num}
        end
        for i = 1, 6, 1 do
            local info = tmp_tab[i]
            local item = self.ui["service_item_"..i]
            local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", info[1])
            ItemShow_updateItem(item, {showCount = true, count = info[2], color = 255, index = item_id, look = true, bgVisible = true})
        end
    elseif index == 7 then
    end
    GUI:setVisible(self.ui.er_wei_ma, false)
end

-- 0. 未爆出   1.已爆出未领奖  2.已爆出已领奖
function WelfareHallOBJ:updateFirstDropInfo()
    local st = self.cur_first_drop_page
    for key, ui in ipairs(self.first_item_cell) do
        local index = (st - 1) * 10 + key
        local cfg = self.FirstDropCfg[index] or {}
        if cfg then
            GUI:Text_setString(ui.item_name, cfg.name)
        end
        local str = "虚位以待"
        local color = "#ffffff"
        local info = self.all_first_data[cfg.name]
        if info then
            local tbl = SL:Split(info, "|")
            str = tbl[2] .. "  " .. GetDate(tonumber(tbl[3]) or os.time())
            color = "#00ff00"
        end
        GUI:ScrollText_setString(ui.player_name, str)
        GUI:ScrollText_setTextColor(ui.player_name, color)

        GUI:setVisible(ui.item_cell, cfg.key_name ~= nil)

        local item_id1 = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.givemoney) or 0
        ItemShow_updateItem(ui.item, {index = item_id1, bgVisible = true, look = true, count = cfg.moneynum or 1})
    end

    -- 更新全服首爆丶个人首爆信息
    GUI:Text_setString(self.ui.page_txt, self.cur_first_drop_page .. " / "..self.boss_drop_total)
end

-- page:  1.登录奖励    2.每日奖励   3.升级奖励   4.首曝奖励   5.累充奖励   6.客服礼包    7.落地成神
function WelfareHallOBJ:showPageInfo(page, sMsg, sMsg2)
    sMsg = sMsg or ""
    sMsg2 = sMsg2 or ""
    if page == 1 then
        sMsg = tonumber(sMsg) or 0
        GUI:setVisible(self.ui.DayGiftBtn, sMsg == 0)
        GUI:setVisible(self.ui.getTag, sMsg ~= 0)
        local ret = SL:JsonDecode(sMsg2, false)
        for key, value in pairs(ret or {}) do
            local ui = self.login_item_cell[value]
            GUI:setVisible(ui.tag, true)
            GUI:setVisible(ui.getBtn, false)
        end
        local red_check_list = {}
        red_check_list.view_name = "WelfareHallOBJ"
        red_check_list.node = self
        red_check_list.Button_1 = RedPointMgr.GetRedDataByBtnName("WelfareHallOBJ","Button_1")
        red_check_list.DayGiftBtn = RedPointMgr.GetRedDataByBtnName("WelfareHallOBJ","DayGiftBtn")
        for i=1,7 do
            red_check_list["get_btn"..i] = RedPointMgr.GetRedDataByBtnName("WelfareHallOBJ","get_btn"..i)
        end
        SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_check_list)
    elseif page == 2 then
        GUI:Text_setString(self.ui.Text_2, string.format("累计充值:  %s天", sMsg))
        local ret = SL:JsonDecode(sMsg2, false)
        local state = GameData.GetData("J_today_free_recharge_reward", false) or 0
        if state ~= 0 then
            ret = ret or {}
            table.insert(ret, 8)
        end
        for key, value in pairs(ret or {}) do
            local cell = self.ui["dayReward_cell_"..value]
            GUI:setVisible(self.ui["getRechareBtn_"..value], false)
            GUI:setVisible(GUI:getChildByName(cell, "icon_tag"), true)
        end
        local red_check_list = {}
        red_check_list.view_name = "WelfareHallOBJ"
        red_check_list.node = self
        red_check_list.Button_2 = RedPointMgr.GetRedDataByBtnName("WelfareHallOBJ","Button_2")
        for i=1,8 do
            red_check_list["getRechareBtn_"..i] = RedPointMgr.GetRedDataByBtnName("WelfareHallOBJ","getRechareBtn_"..i)
        end
        SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_check_list)
    elseif page == 3 then
        local level = tonumber(SL:Get_LEVEL())
        local value = tonumber(sMsg) or 0
        local state_tab = BitMgr.NumToTab(value)
        local add_value = tonumber(sMsg2) or 0
        local add_tab = BitMgr.NumToTab(add_value)

        for index, v in ipairs(self.UpLevelCfg) do
            local cell = self.up_level_item[index]
            GUI:setVisible(cell.getBtn, state_tab[index] == 0)
            GUI:setVisible(cell.tag, state_tab[index] == 1 and add_tab[index] == 1)
            GUI:removeAllChildren(cell.getBtn)
            if state_tab[index] == 0 and level >= v.level then
                local red = GUI:Image_Create(cell.getBtn, "red_icon", 60, 20, "res/custom/red1.png")
            end

            if state_tab[index] == 1 then
                GUI:setPositionX(cell.addBtn, 485)
            end
            if add_tab[index] == 1 then
                GUI:setPositionX(cell.getBtn, 485)
            end

            GUI:setVisible(cell.addBtn, add_tab[index] == 0)
            GUI:removeAllChildren(cell.addBtn)
            if add_tab[index] == 0 and level >= v.level then
                local red = GUI:Image_Create(cell.addBtn, "red_add", 60, 20, "res/custom/red1.png")
            end
        end
    elseif page == 4 then
        self.all_first_data = SL:JsonDecode(sMsg2, false)
        if type(self.all_first_data) ~= "table" then
            self.all_first_data = {}
        end
        self:updateFirstDropInfo()
    elseif page == 5 then
        local state = tonumber(sMsg) or 0
        local value = tonumber(sMsg2) or 0
        local state_tab = BitMgr.NumToTab(value)
        local cell = self.recharge_item_cell[1]
        GUI:setVisible(cell.getBtn, state == 0)
        GUI:setVisible(cell.tag, state == 1)
        for i = 2, #self.recharge_item_cell, 1 do
            local v = self.recharge_item_cell[i]
            GUI:setVisible(v.getBtn, state_tab[i - 1] == 0)
            GUI:setVisible(v.tag, state_tab[i - 1] == 1)
            if v.buyBtn then
                GUI:setVisible(v.buyBtn, state_tab[i - 1] == 0)
            end
        end
        local recharge = string.format("累计充值: %s 元", GameData.GetData("U_recharge_true", false) or 0)
        GUI:Text_setString(self.ui.recharge, recharge)
    elseif page == 6 then
        GUI:setVisible(self.ui.exchange_btn, tonumber(sMsg) == 0)
        GUI:setVisible(self.ui.exchange_tag, tonumber(sMsg) ~= 0)
        GUI:TextInput_setString(self.ui.TextInput_1, "")

        local red_check_list = {}
        red_check_list.view_name = "WelfareHallOBJ"
        red_check_list.node = self
        red_check_list.Button_6 = RedPointMgr.GetRedDataByBtnName("WelfareHallOBJ","Button_6")
        red_check_list.exchange_btn = RedPointMgr.GetRedDataByBtnName("WelfareHallOBJ","exchange_btn")
        SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_check_list)
    elseif page == 7 then
        GUI:setVisible(self.ui.buy688gift, tonumber(sMsg) == 0)
        GUI:setVisible(self.ui.buy688_tag, tonumber(sMsg) ~= 0)
    end
    GUI:setVisible(self.ui.node_7_effect, (GameData.GetData("U_688_buy_all_gift") or 0) < 1)

    -- 累充红点
    self:UpdateViewRedShow()

    local add_red = self:CheckRechargeBtnRed2()
    if add_red then
        local red = GUI:Image_Create(self.ui.Button_7, "red_icon", 0, 20, "res/custom/red1.png")
    else
        GUI:removeAllChildren(self.ui.Button_7)
    end
end

function WelfareHallOBJ:flushView(page, sMsg, sMsg2)
    page = tonumber(page)
    self:onChangePage(page)
    self:showPageInfo(page, sMsg, sMsg2)
end

function WelfareHallOBJ:UpdateViewRedShow()
    GUI:removeAllChildren(self.ui.Button_5)
    local recharge = GameData.GetData("U_recharge_true", false) or 0
    local state = GameData.GetData("J_total_recharge_reward", false) or 0
    local get_value = GameData.GetData("U_total_recharge_reward", false) or 0
    local tab = BitMgr.NumToTab(get_value)
    local btn_red = false
    local yb_num = tonumber(SL:Get_MONEY(2))
    for index, v in ipairs(self.RechargeCfg) do
        local add_red = false
        local cell = self.recharge_item_cell[index]
        if index == 1 then
            if state == 0 then
                add_red = true
                btn_red = true
            end
        else
            if recharge > v.num and tab[index - 1] == 0 then
                add_red = true
                btn_red = true
            end
        end
        if cell then
            GUI:removeAllChildren(cell.getBtn)
            if add_red then
                local red = GUI:Image_Create(cell.getBtn, "red_icon", 50, 20, "res/custom/red1.png")
            end
            if cell.buyBtn then
                GUI:removeAllChildren(cell.buyBtn)
                if GUI:getVisible(cell.buyBtn) and yb_num >= v.ybbuy then
                    GUI:Image_Create(cell.buyBtn, "red_icon", 50, 20, "res/custom/red1.png")
                end
            end
        end
    end
    if btn_red then
        local red = GUI:Image_Create(self.ui.Button_5, "red_icon", 0, 20, "res/custom/red1.png")
    end
end

function WelfareHallOBJ:CheckBtnRed()
    local level = tonumber(SL:Get_LEVEL())
    local get_value = GameData.GetData("U_uplevel_reward", false) or 0
    local tab = BitMgr.NumToTab(get_value)
    local add_value = GameData.GetData("U_add_uplevel_reward", false) or 0
    local add_tab = BitMgr.NumToTab(add_value)

    for index, v in ipairs(self.UpLevelCfg) do
        if level >= v.level and (tab[index] == 0 or add_tab[index] == 0) then
            return true
        end
    end
    return false
end

function WelfareHallOBJ:CheckRechargeBtnRed()
    local recharge = GameData.GetData("U_recharge_true", false) or 0
    local state = GameData.GetData("J_total_recharge_reward", false) or 0
    local get_value = GameData.GetData("U_total_recharge_reward", false) or 0
    local tab = BitMgr.NumToTab(get_value)
    for index, v in ipairs(self.RechargeCfg) do
        if index == 1 then
            if state == 0 then
                return true
            end
        else
            if recharge >= v.num and tab[index - 1] == 0 then
                return true
            end
        end
    end
    return false
end

-- 落地成盒红点
function WelfareHallOBJ:CheckRechargeBtnRed2()
    local state = GameData.GetData("U_688_buy_all_gift", false) or 0
    return state == 0
end

return WelfareHallOBJ