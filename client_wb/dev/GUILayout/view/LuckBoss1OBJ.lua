local LuckBoss1OBJ = {}
LuckBoss1OBJ.Name = "LuckBoss1OBJ"
-- LuckBoss1OBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
LuckBoss1OBJ.NpcId = 1054
-- LuckBoss1OBJ.cfg = GetConfig("LuckBoss1Cfg")


function LuckBoss1OBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LuckBoss1UI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("LuckBoss1OBJ")
    end)
    GUI:addOnClickEvent(self.ui.Text_3,function ()
        SendMsgCallFunByNpc(self.NpcId, "LuckBoss", "getDice","")
    end)
end

--#region 后端消息刷新ui
function LuckBoss1OBJ:flushView(...)
    local tab = {...}
    local functionTab = {
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if LuckBoss1OBJ.NpcId == npc_info.index then
        ViewMgr.open("LuckBoss1OBJ")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "LuckBoss1OBJ", onClickNpc)

return LuckBoss1OBJ