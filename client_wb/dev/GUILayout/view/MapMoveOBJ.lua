local MapMoveOBJ = {}
MapMoveOBJ.Name = "MapMoveOBJ"
MapMoveOBJ.RunAction = true
MapMoveOBJ.cfg = GetConfig("MapMoveCfg")

function MapMoveOBJ:main(npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GoToMap2UI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.npc_id = tonumber(npc_id)


    self:initClickEvents()
    self:updateUiInfo()
end

function MapMoveOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("MapMoveOBJ")
    end)
    GUI:addOnClickEvent(self.ui.enterBtn, function()
        SendMsgCallFunByNpc(self.npc_id, "MapMoveNpc", "onMove", self.npc_id)
    end)
end

function MapMoveOBJ:updateUiInfo()
    local _cfg = self.cfg[self.npc_id] or {}
    local boss_res_path = string.format("res/custom/npc/01dtcs/boss/%s.png", _cfg.bossicon)
    local title_res_path = string.format("res/custom/npc/01dtcs/dtm/%s.png", _cfg.maptitle)
    if _cfg.kuafu == 1 then
        boss_res_path = string.format("res/custom/npc/01dtcs/kf/%s.png", _cfg.bossicon)
        title_res_path = string.format("res/custom/npc/01dtcs/kf/%s.png", _cfg.maptitle)
    end
    GUI:Image_loadTexture(self.ui["title_icon"], title_res_path)
    GUI:Image_loadTexture(self.ui["bossImg"], boss_res_path)

    local mini_map = _cfg.minimap
    local map_img_path = "scene/uiminimap/"..mini_map..".png"
    if SL:IsFileExist(map_img_path) then
        GUI:Image_loadTexture(self.ui["miniMapImg"], map_img_path)
    else
        local function downloadcallback(isOk, path)
            if isOk then
                GUI:Image_loadTexture(self.ui["miniMapImg"], path)
            end
            SL:release_print("down load mini img === ", isOk, path, mini_map)
        end
        SL:DownloadMiniMapRes(mini_map + 1, downloadcallback)
    end

    -- 地图说明
    local rich1 = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_map", 85, 86, _cfg.maplevel, 500, 18, "#ffffff")
    local rich2 = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_boos", 85, 60, _cfg.bossname, 500, 18, "#ffffff")
    local rich3 = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_mon", 85, 33, _cfg.updatetime, 500, 18, "#ffffff")
    local rich4 = GUI:RichTextFCOLOR_Create(self.ui["mapInfo"], "_nandu", 85, 6, _cfg.difficulty, 500, 18, "#ffffff")

    -- 进入条件
    local pos_y = 0
    if _cfg.joinvalue and _cfg.joinvalue1 then
        pos_y = 12
    end
    local rich5 = GUI:RichTextFCOLOR_Create(self.ui["joinInfo"], "_join", 0, pos_y, _cfg.joinvalue, 500, 18, "#ffffff")
    GUI:setAnchorPoint(rich5, 0.5, 0.5)

    if _cfg.joinvalue1 then
        local rich6 = GUI:RichTextFCOLOR_Create(self.ui["joinInfo"], "_join2", 0, pos_y * -1, _cfg.joinvalue1, 500, 18, "#00ff00")
        GUI:setAnchorPoint(rich6, 0.5, 0.5)
    end

    -- 掉落展示
    local item_cell = {}
    for key, v in ipairs(_cfg.reward_arr or {}) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(v)
        local item = GUI:ItemShow_Create(self.ui.dropItems, item_id, 0, 0, {index = item_id, look = true, bgVisible = true})
        GUI:setAnchorPoint(item, 0.5, 0.5)
        item_cell[#item_cell + 1] = item
    end

    self:arrangeNodesFromCenter(item_cell, 0, 0, 70, 60)

    GUI:setVisible(self.ui.kf_eff, _cfg.kuafu == 1)
end

-- 从中间往两边排列
function MapMoveOBJ:arrangeNodesFromCenter(nodes, startX, startY, spacingX, spacingY)
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

return MapMoveOBJ