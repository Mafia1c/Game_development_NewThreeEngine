local ExclusiveEquip = {}
ExclusiveEquip.Name = "ExclusiveEquip"
ExclusiveEquip.RunAction = true
ExclusiveEquip.index_ids = {82,84,86,87,85,83,81,80}
ExclusiveEquip.RunDrag = true

function ExclusiveEquip:main(npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ExclusiveEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvents()
    self:showEquipInfo()
end

function ExclusiveEquip:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("ExclusiveEquip")
    end)

    GUI:addOnClickEvent(self.ui.wqLayout, function()
        local p = SL:Get_MOUSE_MOVE_POS()
        local v = SL:Get_EQUIP_DATA(78)
        local data = {
            itemData = v,
            pos = p
        }
        if v then
            UIOperator:OpenItemTips(data)
        end
    end)
    GUI:addOnClickEvent(self.ui.yfLayout, function()
        local p = SL:Get_MOUSE_MOVE_POS()
        local v = SL:Get_EQUIP_DATA(79)
        local data = {
            itemData = v,
            pos = p
        }
        if v then
            UIOperator:OpenItemTips(data)
        end
    end)
end

function ExclusiveEquip:showEquipInfo()
    for i = 1, 8 do
        local v = self.index_ids[i]
        local eq = SL:GetMetaValue("EQUIP_DATA", v)
        local setData  = {}
        setData.index = eq and eq.Index or 0
        setData.look  = true
        setData.bgVisible = true
        setData.count = 1
        setData.itemData = eq
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)
    end
    local wq = SL:Get_EQUIP_DATA(78)
    local yf = SL:Get_EQUIP_DATA(79)
    local wq_eff = nil
    local yf_eff = nil
    local info = {}
    if wq then
        info = SL:Get_ITEM_DATA(wq.Index) or {}
        wq_eff = info.ITEMPAEAM1
    end
    if yf then
        info = SL:Get_ITEM_DATA(yf.Index) or {}
        yf_eff = info.ITEMPAEAM1
    end

    local feature= {}
    feature.weaponID = wq and wq.Looks or nil-- 武器id
    feature.clothID = yf and yf.Looks or nil
    feature.weaponEffectID = wq_eff
    feature.clothEffectID = yf_eff
    feature.showNodeModel = true
    feature.showHair = false
    local sex = SL:GetMetaValue("SEX")
    local job = SL:GetMetaValue("JOB")
    local UIModel = GUI:UIModel_Create(self.ui.ModeNode, "UIMODEL", 160, 190, sex, feature, nil, true, job)
end

return ExclusiveEquip