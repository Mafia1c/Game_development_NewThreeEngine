local AbyssPassageOBJ = {}
AbyssPassageOBJ.Name = "AbyssPassageOBJ"
AbyssPassageOBJ.RunAction = true
AbyssPassageOBJ.cfg = GetConfig("AbyssCaveCfg")
AbyssPassageOBJ.NpcId = {37}

function AbyssPassageOBJ:main(sMsg, point)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/AbyssPassageUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.remain_point = point

    self:initClickEvents()
    self:updateUiState(sMsg, point)
end

function AbyssPassageOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("AbyssPassageOBJ")
    end)

    for i = 1, 5 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            SendMsgCallFunByNpc(37, "AbyssPassageNpc", "onSelectDungeon", i)
        end)
    end
end

function AbyssPassageOBJ:updateUiState(sMsg, point)
    local tab = SL:JsonDecode(sMsg, false)
    for i = 1, 5 do
        GUI:Text_setString(self.ui["txt_"..i], string.format("[ 通关 %s 次 ]", tab[i] or 0))
    end

    GUI:Text_setString(self.ui["Text_1"], string.format("当前拥有疲劳值: %s点", point))
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(AbyssPassageOBJ.NpcId, npc_info.index) then
        SendMsgClickNpc(npc_info.index .. "#AbyssPassageNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "AbyssPassageOBJ", onClickNpc)

return AbyssPassageOBJ