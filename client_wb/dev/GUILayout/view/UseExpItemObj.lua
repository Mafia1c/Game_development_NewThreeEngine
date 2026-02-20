local UseExpItemObj = {}
UseExpItemObj.Name = "UseExpItemObj"
UseExpItemObj.CheckBox_Res = {
    [0] = "res/public/000263.png",
    [1] = "res/public/000266.png"
}
UseExpItemObj.ItemCfg = {
    ["100万经验珠"] = 100,
    ["1000万经验珠"] = 1000,
    ["1亿经验珠"] = 10000,
}

function UseExpItemObj:main(state, all)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/UesExpItemUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.exp_items = {"100万经验珠","1000万经验珠","1亿经验珠"}
    self.exp_values = {1000000, 10000000, 100000000}
    self.cur_level_txt = nil
    self.next_level_txt = nil
    self.item_cell_list = {}
    self.double_state = tonumber(state) or 0
    self.all_use_state = tonumber(all) or 0

    self:initClickEvents()
    self:CreateExpItemCell()
    self:ShowLevelInfo()
    self:RegistEvent()

    local path = self.CheckBox_Res[self.double_state]
    GUI:Image_loadTexture(self.ui.Image_1, path)

    local path = self.CheckBox_Res[self.all_use_state]
    GUI:Image_loadTexture(self.ui.Image_2, path)
end

function UseExpItemObj:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("UseExpItemObj")
    end)

    GUI:addOnClickEvent(self.ui.layout_check, function()
        self.double_state = self.double_state == 1 and 0 or 1
        local path = self.CheckBox_Res[self.double_state]
        GUI:Image_loadTexture(self.ui.Image_1, path)
        SendMsgClickSysBtn("0#OtherSysFunc#onChangeDoubleTipsState#"..self.double_state)
    end)

    GUI:addOnClickEvent(self.ui.all_check, function()
        self.all_use_state = self.all_use_state == 1 and 0 or 1
        local path = self.CheckBox_Res[self.all_use_state]
        GUI:Image_loadTexture(self.ui.Image_2, path)
        SendMsgClickSysBtn("0#OtherSysFunc#onChangeAllState#"..self.all_use_state)
    end)
end
function UseExpItemObj:CreateExpItemCell()
    local jy_item = self.exp_items
    for index, name in ipairs(jy_item) do
        local _ui = {}
        local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", name)
        local count = SL:Get_ITEM_COUNT(name)
        local value = self.exp_values[index]
        _ui.item_cell = GUI:Layout_Create(self.ui.ItemCellList, "item_cell"..index, 0, 0, 425, 72, true)
        _ui.item = GUI:ItemShow_Create(_ui.item_cell, "exp_item_"..index, 10, 6, {index = item_id, count = 1, bgVisible = true, look = true})
        _ui.line = GUI:Image_Create(_ui.item_cell, "line_"..index, 0, 0, "res/custom/npc/54jyj/xian.png")
        _ui.tips_1 = GUI:Text_Create(_ui.item_cell, "tips_1_"..index, 80, 40, 15, "#ffffff", "拥有:")
        _ui.item_count = GUI:Text_Create(_ui.item_cell, "item_num"..index, 120, 40, 15, "#00ff00", count)
        _ui.tips_2 = GUI:Text_Create(_ui.item_cell, "tips_2_"..index, 80, 12, 15, "#ffffff", "可得:")
        local exp = SL:GetSimpleNumber((count * value), 1)
        _ui.exp_value = GUI:Text_Create(_ui.item_cell, "exp_num"..index, 120, 12, 15, "#00ff00", exp .. "经验")
        _ui.use_btn_1 = GUI:Button_Create(_ui.item_cell, "use_1_"..index, 210, 19, "res/custom/npc/an.png")
        GUI:Button_setTitleText(_ui.use_btn_1, "普通使用")
        GUI:Button_setTitleColor(_ui.use_btn_1, "#FFFF00")
        GUI:Button_setTitleFontSize(_ui.use_btn_1, 17)
        GUI:setContentSize(_ui.use_btn_1, 94, 36)
        GUI:addOnClickEvent(_ui.use_btn_1, function()
            SendMsgClickSysBtn("0#OtherSysFunc#onUseExpItem#1#"..name)
        end)
        _ui.use_btn_2 = GUI:Button_Create(_ui.item_cell, "use_2_"..index, 325, 19, "res/custom/npc/an.png")
        GUI:Button_setTitleText(_ui.use_btn_2, "双倍使用")
        GUI:Button_setTitleColor(_ui.use_btn_2, "#FFFF00")
        GUI:Button_setTitleFontSize(_ui.use_btn_2, 17)
        GUI:setContentSize(_ui.use_btn_2, 94, 36)
        GUI:addOnClickEvent(_ui.use_btn_2, function()
            if self.double_state == 1 then
                SendMsgClickSysBtn("0#OtherSysFunc#onUseExpItem#2#"..name)
            else
                self:onDoubleUseExpItem(name)
            end
        end)
        self.item_cell_list[index] = _ui
    end
end

function UseExpItemObj:onDoubleUseExpItem(name)
    local num = SL:Get_ITEM_COUNT(name)
    if num <= 0 then
        SL:ShowSystemTips(name.."数量不足!")
        return
    end
    local format = "本次双倍使用<font color='#FFFF00'>%s</font>需要消耗<font color='#00ff00'>%s元宝</font>，获得双倍经验!"
    local value = self.ItemCfg[name]
    if self.all_use_state == 1 then
        value = value * num
        format = "本次双倍使用所有<font color='#FFFF00'>%s</font>需要消耗<font color='#00ff00'>%s元宝</font>，获得双倍经验!"
    end
    local data = {}
    data.str = string.format(format, name,value)
    data.btnType = 2
    data.callback = function(atype, param)
        if atype == 1 then
            SendMsgClickSysBtn("0#OtherSysFunc#onUseExpItem#2#"..name)
        end
    end
    UIOperator:OpenCommonTipsUI(data)
end

function UseExpItemObj:ShowLevelInfo()
    local level = SL:Get_LEVEL()
    if self.cur_level_txt then
        GUI:removeFromParent(self.cur_level_txt)
        self.cur_level_txt = nil
    end
    self.cur_level_txt = GUI:RichTextFCOLOR_Create(self.ui["Image_bg"], "_cur_level", 96, 352, string.format("当前<%s/FCOLOR=250>级", level), 80, 16, "#ffffff")
    GUI:setAnchorPoint(self.cur_level_txt, 1, 0)
    if self.next_level_txt then
        GUI:removeFromParent(self.next_level_txt)
        self.next_level_txt = nil
    end
    self.next_level_txt = GUI:RichTextFCOLOR_Create(self.ui["Image_bg"], "_next_level", 325, 352, string.format("冲刺<%s/FCOLOR=250>级", level + 1), 80, 16, "#ffffff")
    GUI:setAnchorPoint(self.next_level_txt, 0, 0)

    self:UpdateExpPro()
end

function UseExpItemObj:UpdateExpPro()
    local cur_exp = SL:GetValue("EXP")
    local up_level_exp = SL:GetValue("MAXEXP")
    GUI:Text_setString(self.ui.LoadingBar_value, cur_exp .. "/"..up_level_exp)
    local value = math.floor(cur_exp / up_level_exp * 100)
    GUI:LoadingBar_setPercent(self.ui.LoadingBar_1, value)
end

function UseExpItemObj:flushView()
    local jy_item = self.exp_items
    for index, name in ipairs(jy_item) do
        local count = SL:Get_ITEM_COUNT(name)
        local value = self.exp_values[index]
        local ui = self.item_cell_list[index]
        if ui then
            GUI:Text_setString(ui.item_count, count)
            local exp = SL:GetSimpleNumber((count * value), 1)
            GUI:Text_setString(ui.exp_value, exp .. "经验")
        end
    end
end

function UseExpItemObj:ItemDataChange(data, tag, event)
    if not data or not next(data) then
        return
    end
    local itemData = data.operID
    if not itemData or not next(itemData) then
        return
    end
    local op_type = data.opera
    if op_type ~= 0 then
        self:flushView()
    end
end

function UseExpItemObj:RegistEvent()
    SL:RegisterLUAEvent(LUA_EVENT_EXP_CHANGE, "UseExpItemObj", handler(UseExpItemObj, UseExpItemObj.ShowLevelInfo))
    SL:RegisterLUAEvent(LUA_EVENT_BAG_ITEM_CHANGE, "UseExpItemObj", handler(UseExpItemObj, UseExpItemObj.ItemDataChange))
end

function UseExpItemObj:onClose()
    SL:UnRegisterLUAEvent(LUA_EVENT_EXP_CHANGE, "UseExpItemObj")
    SL:UnRegisterLUAEvent(LUA_EVENT_BAG_ITEM_CHANGE, "UseExpItemObj")
end

return UseExpItemObj