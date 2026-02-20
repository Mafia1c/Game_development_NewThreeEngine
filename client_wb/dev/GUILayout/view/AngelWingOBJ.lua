local AngelWingOBJ = {}
AngelWingOBJ.Name = "AngelWingOBJ"
AngelWingOBJ.RunAction = true
AngelWingOBJ.NpcId = 208
AngelWingOBJ.cfg = GetConfig("AngelWingCfg")
AngelWingOBJ.attr_text = {
    {"双      防:  %s", 90010, 254},
    {"攻 魔 道:  %s", 30004, 251},
    {"体力增加:  %s", 30, 250},
    {"魔力增加:  %s", 31, 253},
    {"破防抵抗:  %s", 85, 253},
}

function AngelWingOBJ:main(level)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/AngelWingUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_level = tonumber(level) or 0

    local _cfg = self.cfg[self.cur_level + 1] or self.cfg[#self.cfg]
    self.cur_cfg = _cfg
    self.equip_id = SL:Get_ITEM_INDEX_BY_NAME(_cfg.name)
    self.equip_eff = nil
    self.attr_txt_tab = {}

    self:initClickEvents()
    self:updateUiInfo()
end

function AngelWingOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("AngelWingOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.NpcId, "AngelWingNpc", "onClickUpLevel", self.cur_level)
    end)
end

function AngelWingOBJ:updateUiInfo()
    GUI:ItemShow_updateItem(self.ui.ItemShow_1, {index = self.equip_id, look = true, bgVisible = true})
    GUI:Text_setString(self.ui.Text_1, self.cur_cfg.name)

    if self.equip_eff then
        GUI:removeFromParent(self.equip_eff)
        self.equip_eff = nil
    end
    self.equip_eff = GUI:Effect_Create(self.ui.FrameLayout, "eff_", 292, 215, 0, self.cur_cfg.effect, 0, 0, 0)

    local money_id = SL:Get_ITEM_INDEX_BY_NAME(self.cur_cfg.needmoney)
    local num = tonumber(SL:Get_MONEY_ASSOCIATED(money_id)) or 0
    local color = 250
    if num < self.cur_cfg.moneynum then
        color = 249
    end
    GUI:ItemShow_updateItem(self.ui.needItem_1, {index = money_id, look = true, bgVisible = true, count = self.cur_cfg.moneynum, color = color})
    local item_id = SL:Get_ITEM_INDEX_BY_NAME(self.cur_cfg.needitem)
    local count = tonumber(SL:Get_ITEM_COUNT(item_id))
    color = 250
    if count < self.cur_cfg.itemnum then
        color = 249
    end
    GUI:ItemShow_updateItem(self.ui.needItem_2, {index = item_id, look = true, bgVisible = true, count = self.cur_cfg.itemnum, color = color})

    local data = SL:Get_ITEM_DATA(self.equip_id)
    local attr_tab = GUIFunction:ParseItemBaseAtt(data.Attribute, 3)
    local curAttList = GUIFunction:GetAttDataShow(attr_tab, nil, true)

    GUI:removeAllChildren(self.ui.attrLayout)

    local y = 160
    for index, v in ipairs(self.attr_text) do
        local info = curAttList[v[2]] or {}
        local str = string.format(v[1], info.value or 0)
        str = string.format("<%s/FCOLOR=%s>", str, v[3])
        local txt = GUI:RichTextFCOLOR_Create(self.ui["attrLayout"], "_attr_"..index, 101, y, str, 200, 18, "#ffffff")
        GUI:setAnchorPoint(txt, 0.5, 0)
        y = y - 35
    end
end

function AngelWingOBJ:flushView(sMsg)
    self.cur_level = tonumber(sMsg) or self.cur_level
    local _cfg = self.cfg[self.cur_level + 1] or self.cfg[#self.cfg]
    self.cur_cfg = _cfg
    self.equip_id = SL:Get_ITEM_INDEX_BY_NAME(_cfg.name)
    self:updateUiInfo()
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "AngelWingOBJ",["node"] = self,["is_all"] = true})
end

function AngelWingOBJ:UpBtnRed()
    if AngelWingOBJ.cur_level == nil then return false end
    if AngelWingOBJ.cur_level >= 9 then return false end
    local _cfg = AngelWingOBJ.cfg[AngelWingOBJ.cur_level + 1] or AngelWingOBJ.cfg[#AngelWingOBJ.cfg]
    local money_id = SL:Get_ITEM_INDEX_BY_NAME(_cfg.needmoney)
    local num = tonumber(SL:Get_MONEY_ASSOCIATED(money_id)) or 0
    if num < _cfg.moneynum then
        return false
    end
    local item_id = SL:Get_ITEM_INDEX_BY_NAME(_cfg.needitem)
    local count = tonumber(SL:Get_ITEM_COUNT(item_id))
    if count < self.cur_cfg.itemnum then
        return false
    end
    return true
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable({AngelWingOBJ.NpcId}, npc_info.index) then
        SendMsgClickNpc(npc_info.index.."#AngelWingNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "AngelWingOBJ", onClickNpc)

return AngelWingOBJ