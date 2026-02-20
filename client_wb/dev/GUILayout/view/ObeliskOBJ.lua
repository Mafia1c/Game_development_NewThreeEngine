local ObeliskOBJ = {}
ObeliskOBJ.Name = "ObeliskOBJ"
ObeliskOBJ.RunAction = true
ObeliskOBJ.cfg = GetConfig("ObeliskCfg")
ObeliskOBJ.NpcId = {129, 1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030}

function ObeliskOBJ:main(npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ObeliskUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.npc_id = npc_id

    self:initClickEvents()
    self:updateUiInfo()
    GUI:setVisible(self.ui.maskLayout, false)
end

function ObeliskOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("ObeliskOBJ")
    end)
    GUI:addOnClickEvent(self.ui.enterBtn, function()
        SendMsgCallFunByNpc(self.npc_id, "ObeliskNpc", "onMoveObelisk", self.npc_id)
    end)
    GUI:addOnClickEvent(self.ui.Frames_1, function()
        GUI:setVisible(self.ui.maskLayout, true)
    end)
    GUI:addOnClickEvent(self.ui.okBtn, function()
        GUI:setVisible(self.ui.maskLayout, false)
    end)
end

function ObeliskOBJ:updateUiInfo()
    local cfg = self.cfg[self.npc_id]
    local tips_str = "进入条件: <10转/FCOLOR=250> + <仙石*9/FCOLOR=250>"
    if cfg.needlevel then
        tips_str = string.format("进入条件: <人物%s级/FCOLOR=250>", cfg.needlevel)
    end
    if cfg.needvar then
        tips_str = string.format("进入条件: <%s/FCOLOR=250>", cfg.needvar)
    end
    GUI:RichTextFCOLOR_Create(self.ui["infoNode"], "_map", 0, -51, tips_str, 300, 18, "#ffffff")
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(ObeliskOBJ.NpcId, npc_info.index) then
        ViewMgr.open(ObeliskOBJ.Name, npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "ObeliskOBJ", onClickNpc)

return ObeliskOBJ