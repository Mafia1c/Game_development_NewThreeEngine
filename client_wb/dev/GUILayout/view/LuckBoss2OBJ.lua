local LuckBoss2OBJ = {}
LuckBoss2OBJ.Name = "LuckBoss2OBJ"
-- LuckBoss2OBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
LuckBoss2OBJ.NpcId = {1051,1052,1053}
LuckBoss2OBJ.cfg = {[1051]="如意：(可使用骰子与老板娘猜点数)",[1052]="如花：(可使用骰子与老板娘猜点数)",[1053]="如玉：(可使用骰子与老板娘猜点数)",}


function LuckBoss2OBJ:main(npcId,time)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LuckBoss2UI", function () end)
    self.ui = GUI:ui_delegate(parent)

    npcId=tonumber(npcId)
    time=tonumber(time)
    GUI:Text_setString(self.ui.Text_1,self.cfg[npcId])
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("LuckBoss2OBJ")
    end)
    for i = 1, 6 do
        GUI:addOnClickEvent(self.ui["dice"..i],function ()
            SendMsgCallFunByNpc(npcId, "LuckBoss", "playDice",npcId.."#"..i)
        end)
    end
    self:refreshTime(time)
end
function LuckBoss2OBJ:refreshTime(time)
    removeOBJ(self.ui.hasTime,self)
    GUI:Text_Create(self.ui.timeText,"hasTime",100,0,16,"#00ff00","")
    GUI:Text_COUNTDOWN(self.ui.hasTime,time,function () end,0)
end

--#region 后端消息刷新ui
function LuckBoss2OBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["time"]=function ()
            if ViewMgr.IsOpen("LuckBoss2OBJ") then
                LuckBoss2OBJ:refreshTime(tonumber(tab[2]))
            end
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(LuckBoss2OBJ.NpcId,npc_info.index) then
        -- ViewMgr.open("LuckBoss2OBJ",npc_info.index)
        SendMsgCallFunByNpc(npc_info.index, "LuckBoss", "onclick",npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "LuckBoss2OBJ", onClickNpc)

return LuckBoss2OBJ