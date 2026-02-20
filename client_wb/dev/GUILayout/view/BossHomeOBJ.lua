local BossHomeOBJ = {}
BossHomeOBJ.Name = "BossHomeOBJ"
BossHomeOBJ.RunAction = true
BossHomeOBJ.NpcId = {39}
BossHomeOBJ.MapCfg = {
    "boss之家1层",
    "boss之家2层",
}

function BossHomeOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/BossHomeUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.boss_info = SL:JsonDecode(sMsg, false)

    self:initClickEvents()
    self:ShowUIData()
end

function BossHomeOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("BossHomeOBJ")
    end)

    for i = 1, 2, 1 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            SendMsgCallFunByNpc(39, "BossHomeNpc", "onMapMove", i)
        end)
    end
end

function BossHomeOBJ:ShowUIData()
    for i = 1, 2 do
        local cell = GUI:Image_Create(self.ui.BossList, "cell_"..i, 0, 0, "res/custom/npc/21fb/pmlist.png")
        local map_name = GUI:Text_Create(cell, "map_name"..i, 35, 2, 16, "#ff0000", self.MapCfg[i])
        local boss_num = GUI:Text_Create(cell, "boss_num"..i, 185, 2, 16, "#00ff00", (self.boss_info[i] or 0) .. "只")
    end
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(BossHomeOBJ.NpcId, npc_info.index) then
        SendMsgClickNpc(npc_info.index .. "#BossHomeNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "BossHomeOBJ", onClickNpc)

return BossHomeOBJ