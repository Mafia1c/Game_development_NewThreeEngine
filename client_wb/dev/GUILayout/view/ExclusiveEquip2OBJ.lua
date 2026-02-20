local ExclusiveEquip2OBJ = {}
ExclusiveEquip2OBJ.Name = "ExclusiveEquip2OBJ"
ExclusiveEquip2OBJ.RunAction = true
ExclusiveEquip2OBJ.cfg = GetConfig("ExclusiveCfg")

function ExclusiveEquip2OBJ:main(npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ExclusiveEquip2UI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.npc_id = tonumber(npc_id) or 0
    self.cur_cfg = self.cfg[self.npc_id]
    

    self:initClickEvents()
    self:updateUiInfo()
end

function ExclusiveEquip2OBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("ExclusiveEquip2OBJ")
    end)
    GUI:addOnClickEvent(self.ui.Button_1, function()
        SendMsgCallFunByNpc(self.npc_id, "ExclusiveEquipNpc", "onCreateEquip", self.npc_id .. "#1")
    end)
end

function ExclusiveEquip2OBJ:updateUiInfo()
    local equip1 = SL:Get_EQUIPBYPOS(self.cur_cfg.place_arr[1])
    local btn_txt = "打造神器"
    if self.cur_cfg.name == equip1 then
        btn_txt = "查看神器"
    end

    GUI:Button_setTitleText(self.ui.Button_1, btn_txt)

    for i = 1, 5, 1 do
        local item = self.cur_cfg.needitem1_arr
        local num = self.cur_cfg.itemnum1_arr
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(item[i])
        local color = 255
        local count = tonumber(SL:Get_ITEM_COUNT(item_id))
        if item_id <= 100 then
            count = tonumber(SL:Get_MONEY_ASSOCIATED(item_id))
        end
        if count < num[i] then
            color = 249
        end
        ItemShow_updateItem(self.ui["ItemShow_"..i], {index = item_id, bgVisible = false, look = true, count = num[i], color = color})
    end

    local item_id = SL:Get_ITEM_INDEX_BY_NAME(self.cur_cfg.name)
    GUI:ItemShow_updateItem(self.ui.EquipItem, {index = item_id, bgVisible = false, look = true})

    local str = string.format("<font color='#ffffff' size='16' ><a enableUnderline ='false' href = 'jump#item_tips#%s'><u><font color ='#FFFF00'>%s</font></u></a></font>", item_id, self.cur_cfg.name)
    GUI:RichText_Create(self.ui.Image_1, "_equip_name", 36, 8, str, 80, 16)
end

function ExclusiveEquip2OBJ:flushView()
    self:updateUiInfo()
end

return ExclusiveEquip2OBJ