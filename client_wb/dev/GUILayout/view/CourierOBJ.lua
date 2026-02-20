local CourierOBJ = {}
CourierOBJ.Name = "CourierOBJ"
CourierOBJ.NpcId = 1001

function CourierOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GoToMap1UI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvents()
end

function CourierOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("CourierOBJ")
    end)

    local map_names = {
        ["map_tjp"] = 1,
        ["map_bld"] = 1,
        ["map_ssd"] = 1,
        ["map_kz"] = 1,
        ["map_mf"] = 1,
    }
    for k, v in pairs(map_names) do
        GUI:addOnClickEvent(self.ui[k], function()
            SendMsgCallFunByNpc(self.NpcId, "CourierNpc", "onClickCourier", k)
        end)
    end
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if CourierOBJ.NpcId == npc_info.index then
        ViewMgr.open("CourierOBJ")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "CourierOBJ", onClickNpc)

return CourierOBJ