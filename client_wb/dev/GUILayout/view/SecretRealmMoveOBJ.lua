local SecretRealmMoveOBJ = {}
SecretRealmMoveOBJ.Name = "SecretRealmMoveOBJ"
SecretRealmMoveOBJ.cfg = GetConfig("SecretRealmCfg")

function SecretRealmMoveOBJ:main(npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GoToMap3UI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.npc_id = tonumber(npc_id)
    self.boss_eff = nil

    self:initClickEvents()
    self:updateUiInfo()
end

function SecretRealmMoveOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("SecretRealmMoveOBJ")
    end)
    GUI:addOnClickEvent(self.ui.enterBtn, function()
        SendMsgCallFunByNpc(self.npc_id, "SecretRealmMoveNpc", "onMove", self.npc_id)
    end)
end

function SecretRealmMoveOBJ:updateUiInfo()
    local _cfg = self.cfg[self.npc_id] or {}

    local id = self.npc_id - 259
    if self.npc_id < 284 then
        id = string.match(_cfg.mapid, "%-?%d+%.?%d*")
    else
        local boss = string.format(_cfg.text1, _cfg.genmob)
        GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_tips_1", 95, 310, boss, 500, 18, "#ffffff")
        GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_tips_2", 95, 275, _cfg.text2 or "", 500, 18, "#ffffff")
    end
    GUI:Image_loadTexture(self.ui["FrameBG"], string.format("res/custom/npc/32mj/bg%s.png", id))

    -- 掉落展示
    local item_cell = {}
    for key, v in ipairs(_cfg.reward_arr or {}) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(v)
        local item = GUI:ItemShow_Create(self.ui.dropItems, item_id, 0, 0, {index = item_id, look = true, bgVisible = true})
        GUI:setAnchorPoint(item, 0.5, 0.5)
        item_cell[#item_cell + 1] = item
    end
    self:arrangeNodesFromCenter(item_cell, 0, 0, 70, 60)

    self.boss_eff = GUI:Effect_Create(self.ui.FrameLayout, "_boss_eff", 553, 185, 2, _cfg.bossicon or 1, 0, 0, 4, 1)
    GUI:setScale(self.boss_eff, _cfg.bosssize or 1)
end

-- 从中间往两边排列
function SecretRealmMoveOBJ:arrangeNodesFromCenter(nodes, startX, startY, spacingX, spacingY)
    if #nodes == 0 then
        return
    end
    -- 计算中间索引
    local centerIndex = math.ceil(#nodes / 2)
    -- 先放置中间节点
    if nodes[centerIndex] then
        GUI:setPosition(nodes[centerIndex], startX, startY)
    end
    -- 从中间向两边放置其他节点
    for i = 1, centerIndex - 1 do
        -- 放置左侧节点
        local leftIndex = centerIndex - i
        if nodes[leftIndex] then
            GUI:setPosition(nodes[leftIndex], startX - i * spacingX, 0)
        end
        -- 放置右侧节点
        local rightIndex = centerIndex + i
        if nodes[rightIndex] then
            GUI:setPosition(nodes[rightIndex], startX + i * spacingX, 0)
        end
    end
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if nil ~= SecretRealmMoveOBJ.cfg[npc_info.index] then
        ViewMgr.open("SecretRealmMoveOBJ", npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "SecretRealmMoveOBJ", onClickNpc)

return SecretRealmMoveOBJ