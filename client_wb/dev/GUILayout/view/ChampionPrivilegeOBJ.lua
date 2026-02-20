local ChampionPrivilegeOBJ = {}
ChampionPrivilegeOBJ.Name = "ChampionPrivilegeOBJ"
ChampionPrivilegeOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
ChampionPrivilegeOBJ.NpcId = 1062

function ChampionPrivilegeOBJ:main(active)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ChampionPrivilegeUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("ChampionPrivilegeOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("ChampionPrivilegeOBJ")
    end)

    GUI:addOnClickEvent(self.ui.upBtn,function ()
        SendMsgCallFunByNpc(self.NpcId, "ChampionPrivilege", "activeEvent","")
    end)
    ChampionPrivilegeOBJ:refreshBtn(active)
end
function ChampionPrivilegeOBJ:refreshBtn(active)
    GUI:setVisible(self.ui.upBtn,active=="0")
    GUI:setVisible(self.ui.activeImg,active=="1")
end
--#region 后端消息刷新ui
function ChampionPrivilegeOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["refresh"] = function ()
            ChampionPrivilegeOBJ:refreshBtn(tab[2])
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if ChampionPrivilegeOBJ.NpcId==npc_info.index then
        -- ViewMgr.open("ChampionPrivilegeOBJ")
        SendMsgClickNpc(ChampionPrivilegeOBJ.NpcId.."#ChampionPrivilege")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "ChampionPrivilegeOBJ", onClickNpc)

return ChampionPrivilegeOBJ