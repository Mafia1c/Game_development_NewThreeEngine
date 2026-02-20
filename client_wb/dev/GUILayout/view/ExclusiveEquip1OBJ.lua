local ExclusiveEquip1OBJ = {}
ExclusiveEquip1OBJ.Name = "ExclusiveEquip1OBJ"
ExclusiveEquip1OBJ.HideMain = true
ExclusiveEquip1OBJ.RunAction = true
ExclusiveEquip1OBJ.cfg = GetConfig("ExclusiveCfg")

function ExclusiveEquip1OBJ:main(npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ExclusiveEquip1UI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.npc_id = tonumber(npc_id) or 0
    self.cur_cfg = self.cfg[self.npc_id]

    self:initClickEvents()
    self:CreateEffect()
    self:updateUiInfo()
end

function ExclusiveEquip1OBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("ExclusiveEquip1OBJ")
    end)
    GUI:addOnClickEvent(self.ui.Button_1, function()
        SendMsgCallFunByNpc(self.npc_id, "ExclusiveEquipNpc", "onCreateEquip", self.npc_id .. "#1")
    end)
    GUI:addOnClickEvent(self.ui.Button_2, function()
        SendMsgCallFunByNpc(self.npc_id, "ExclusiveEquipNpc", "onCreateEquip", self.npc_id .. "#2")
    end)
end

function ExclusiveEquip1OBJ:CreateEffect()
    if nil == self.cur_cfg then
        return
    end
    local effect = self.cur_cfg.effectid_arr
    local pos_x = self.cur_cfg.effectx_arr or {}
    local pos_y = self.cur_cfg.effecty_arr or {}
    GUI:Effect_Create(self.ui.effectNode, "123", pos_x[1] or 190, (pos_y[1] and 618 - pos_y[1]) or 338, 0, effect[1] or 0, 0, 0, 0, 1)
    GUI:Effect_Create(self.ui.effectNode, "456", pos_x[2] or 772, (pos_y[2] and 618 - pos_y[2]) or 378, 0, effect[2] or 0, 0, 0, 0, 1)

    local format = "<font color='#ffffff' size='16' ><a enableUnderline ='false' href = 'jump#item_tips#%s'><u><font color ='#FFFF00'>%s</font></u></a></font>"
    local equip = self.cur_cfg.name
    equip = SL:Split(equip, "#")

    for i = 1, #equip do
        local equip_name = equip[i]
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(equip_name)
        local str = string.format(format, item_id, equip_name)
        GUI:RichText_Create(self.ui["Image_"..i], "_txt_"..i, 52, 7, str, 80, 20, "#FFFF00")
    end
end

function ExclusiveEquip1OBJ:updateUiInfo()
    if nil == self.cur_cfg then
        return
    end

    local equip1 = SL:Get_EQUIPBYPOS(self.cur_cfg.place_arr[1])
    GUI:Button_setTitleText(self.ui.Button_1, "" == equip1 and "复原装备" or "查看专属")
    local equip2 = SL:Get_EQUIPBYPOS(self.cur_cfg.place_arr[2])
    GUI:Button_setTitleText(self.ui.Button_2, "" == equip2 and "复原装备" or "查看专属")

    for i = 1, 4, 1 do
        local item = self.cur_cfg.needitem1_arr
        local num = self.cur_cfg.itemnum1_arr
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(item[i]) or 0
        local color = 255
        local count = tonumber(SL:Get_ITEM_COUNT(item_id))
        if item_id <= 100 then
            count = tonumber(SL:Get_MONEY_ASSOCIATED(item_id))
        end
        if count < num[i] then
            color = 249
        end
        ItemShow_updateItem(self.ui["L_Item_"..i], {index = item_id, bgVisible = false, look = true, count = num[i], color = color})
        ItemShow_updateItem(self.ui["R_Item_"..i], {index = item_id, bgVisible = false, look = true, count = num[i], color = color})
    end

end

function ExclusiveEquip1OBJ:flushView()
    self:updateUiInfo()
end

return ExclusiveEquip1OBJ