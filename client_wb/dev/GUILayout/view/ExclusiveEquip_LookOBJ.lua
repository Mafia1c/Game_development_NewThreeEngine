local ExclusiveEquip_LookOBJ = {}
ExclusiveEquip_LookOBJ.Name = "ExclusiveEquip_LookOBJ"
ExclusiveEquip_LookOBJ.RunAction = true
ExclusiveEquip_LookOBJ.RunDrag = true

function ExclusiveEquip_LookOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ExclusiveEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.equip_id_tab = SL:JsonDecode(sMsg)
    self:initClickEvent()
    self:showEquipInfo()
end

function ExclusiveEquip_LookOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function ()
        ViewMgr.close(ExclusiveEquip_LookOBJ.Name)
    end)

    GUI:addOnClickEvent(self.ui.wqLayout, function()
        local p = SL:Get_MOUSE_MOVE_POS()
        local v = SL:GetMetaValue("LOOKPLAYER_DATA_BY_MAKEINDEX", self.equip_id_tab[9])
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
        local v = SL:GetMetaValue("LOOKPLAYER_DATA_BY_MAKEINDEX", self.equip_id_tab[10])
        local data = {
            itemData = v,
            pos = p
        }
        if v then
            UIOperator:OpenItemTips(data)
        end
    end)
end

function ExclusiveEquip_LookOBJ:showEquipInfo()
    for i = 1, 8 do
        local eq = SL:GetMetaValue("LOOKPLAYER_DATA_BY_MAKEINDEX", self.equip_id_tab[i])
        local setData  = {}
        setData.index = eq and eq.Index or 0
        setData.look  = true
        setData.bgVisible = true
        setData.count = 1
        setData.itemData = eq
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..i], setData)
    end
    local wq = SL:GetMetaValue("LOOKPLAYER_DATA_BY_MAKEINDEX", self.equip_id_tab[9])
    local yf = SL:GetMetaValue("LOOKPLAYER_DATA_BY_MAKEINDEX", self.equip_id_tab[10])
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

    local look_actor = SL:Get_LOOK_TARGET_ID()
    local sex = SL:Get_ACTOR_SEX(look_actor)
    local job = SL:Get_ACTOR_JOB_ID(look_actor)
    local UIModel = GUI:UIModel_Create(self.ui.ModeNode, "UIMODEL", 160, 190, sex, feature, nil, true, job)
end

return ExclusiveEquip_LookOBJ