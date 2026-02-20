local MountMessengerOBJ = {}
MountMessengerOBJ.Name = "MountMessengerOBJ"
MountMessengerOBJ.RunAction = true
MountMessengerOBJ.NpcId = 170
MountMessengerOBJ.attr_text = {
    {"防攻魔道:  11 - 12", 255},
    {"体力增加:  10%", 250},
    {"魔力增加:  10%", 250},
    {"对战增伤:  5%", 253},
    {"对法增伤:  5%", 253},
    {"对道增伤:  5%", 253},
}

function MountMessengerOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/MountMessengerUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.equip_id = 50914
    self.equip_eff = nil
    self.attr_txt_tab = {}

    self:initClickEvents()
    self:updateUiInfo()
end

function MountMessengerOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("MountMessengerOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.NpcId, "MountMessengerNpc", "onClickUp", self.NpcId)
    end)
end

function MountMessengerOBJ:updateUiInfo()
    GUI:ItemShow_updateItem(self.ui.ItemShow_1, {index = self.equip_id, look = true, bgVisible = true})
    GUI:Text_setString(self.ui.Text_1, "[坐骑]白衣剑仙")

    if self.equip_eff then
        GUI:removeFromParent(self.equip_eff)
        self.equip_eff = nil
    end
    self.equip_eff = GUI:Effect_Create(self.ui.FrameLayout, "eff_", 285, 205, 4, 17030, 0, 1, 5)

    local item_id = SL:Get_ITEM_INDEX_BY_NAME("幻灵石")
    local count = tonumber(SL:Get_ITEM_COUNT(item_id))
    local color = 250
    if count < 999 then
        color = 249
    end
    GUI:ItemShow_updateItem(self.ui.needItem_2, {index = item_id, look = true, bgVisible = true, count = 999, color = color})

    GUI:removeAllChildren(self.ui.attrLayout)
    local y = 180
    for index, v in ipairs(self.attr_text) do
        local str = string.format("<%s/FCOLOR=%s>", v[1], v[2])
        local txt = GUI:RichTextFCOLOR_Create(self.ui["attrLayout"], "_attr_"..index, 69, y, str, 200, 18, "#ffffff")
        GUI:setAnchorPoint(txt, 0.5, 0)
        y = y - 35
    end
end

function MountMessengerOBJ:flushView()
    self:updateUiInfo()
     SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "MountMessengerOBJ",["node"] = self,["is_all"] = true})
end

function MountMessengerOBJ:UpBtnRed()
    if SL:Get_ITEM_COUNT("幻灵石") < 999 then
        return false
    end
    local str = GameData.GetData("T_mount_equip") or ""
    if string.find(str, "[坐骑]白衣剑仙", 1, true) then
        return false
    end
    return true
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable({MountMessengerOBJ.NpcId}, npc_info.index) then
        ViewMgr.open("MountMessengerOBJ")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MountMessengerOBJ", onClickNpc)

return MountMessengerOBJ