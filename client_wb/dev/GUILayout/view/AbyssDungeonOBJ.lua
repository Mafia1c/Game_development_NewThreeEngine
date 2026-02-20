local AbyssDungeonOBJ = {}
AbyssDungeonOBJ.Name = "AbyssDungeonOBJ"
AbyssDungeonOBJ.RunAction = true
AbyssDungeonOBJ.cfg = GetConfig("AbyssCaveCfg")
AbyssDungeonOBJ.HideMain = true

function AbyssDungeonOBJ:main(index, point)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/AbyssDungeonUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_index = index
    self.remain_point = point

    self:initClickEvents()
    self:updateUiState(tonumber(index), point)
end

function AbyssDungeonOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("AbyssDungeonOBJ")
    end)

    for i = 1, 2 do
        GUI:addOnClickEvent(self.ui["ChallengeBtn_" .. i], function()
            SendMsgCallFunByNpc(37, "AbyssPassageNpc", "onChallenge", self.cur_index .. "#" .. i)
        end)
    end
end

function AbyssDungeonOBJ:updateUiState(index, point)
    GUI:Text_setString(self.ui["pointTxt"], string.format("当前拥有疲劳值: %s点", point))
    GUI:Image_loadTexture(self.ui.FrameBG, string.format("res/custom/npc/21fb/symj/sybg%s.png", index))

    -- 掉落展示
    local posy_list = {314,306,314,308,260}
    local y = 474 - posy_list[index]
    local _cfg = self.cfg[index] or {}
    local eff = GUI:Effect_Create(self.ui.effNode, "mon_eff", 550, y, 2, _cfg.bossicon, 0, 0, 4)
    GUI:setScale(eff, 0.8)

    local item_cell = {}
    for key, v in ipairs(_cfg.reward_arr or {}) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(v)
        local item = GUI:ItemShow_Create(self.ui.itemNode, item_id, 0, 0, {index = item_id, look = true, bgVisible = true})
        GUI:setAnchorPoint(item, 0.5, 0.5)
        item_cell[#item_cell + 1] = item
    end
    self:arrangeNodesFromCenter(item_cell, 0, 0, 70, 60)
end

-- 从中间往两边排列
function AbyssDungeonOBJ:arrangeNodesFromCenter(nodes, startX, startY, spacingX, spacingY)
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

return AbyssDungeonOBJ