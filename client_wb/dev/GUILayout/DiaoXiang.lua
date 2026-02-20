npclist = {
    --                  名字|等级|战斗力|武器|衣服 |性别
    ["天下第一战"] = { "A_world_n175", "0", -88, -34, "#F7DE39"},
    ["天下第一法"] = { "A_world_n176", "1", -88, -34, "#E317B3"},
    ["天下第一道"] = { "A_world_n177", "2", -88, -34, "#39B5EF"},
}

function worldTopStatue()
    -- 遍历视野内的 NPC 列表
    for k, v in ipairs(SL:GetMetaValue("FIND_IN_VIEW_NPC_LIST")) do
        local actor = global.actorManager:GetActor(v)

        if npclist[actor.mName] then
            actor.mONameStr = ""
            GUI:removeAllChildren(actor.mCurrMountNode)

            -- 获取服务器变量
			local data_str = GameData.GetData(npclist[actor.mName][1], false)
			local tmp_tab = {"", "", "", "", "", "", ""}
			if data_str and "" ~= data_str then
				tmp_tab = SL:Split(data_str,  "|")
			end

            local playname 	= tmp_tab[1]  -- 玩家名字
            local weapon 	= tmp_tab[4]  -- 玩家武器
            local player 	= tmp_tab[5]  -- 玩家衣服
            local sex 		= tonumber(tmp_tab[6]) or 0  -- 玩家性别


            if playname ~= "" then

				-- 底座
				local diaox = GUI:Image_Create(actor.mCurrMountNode, "d", -88, -34, "res/custom/myui/3.png")
				-- GUI:setScale(diaox, 1)

				-- 武器
				if weapon ~= "" then
					local itemtab = SL:GetMetaValue("ITEM_DATA", SL:GetMetaValue("ITEM_INDEX_BY_NAME", weapon))
					GUI:setScale(GUI:Effect_Create(actor.mCurrMountNode, "wq", 0, 70, 5, itemtab.Shape, sex, 0, 5, 1), 1)
					if itemtab.AniCount > 0 then
						GUI:setScale(GUI:Effect_Create(actor.mCurrMountNode, "wq1", 0, 70, 5, itemtab.AniCount, sex, 0, 5, 1), 1)
					end
				end

				-- 衣服
				if player ~= "" then
					local itemtab = SL:GetMetaValue("ITEM_DATA", SL:GetMetaValue("ITEM_INDEX_BY_NAME", player))
					GUI:setScale(GUI:Effect_Create(actor.mCurrMountNode, "yf", 0, 70, 4, itemtab.Shape, sex, 0, 5, 1), 1)
					if itemtab.AniCount > 0 then
						GUI:setScale(GUI:Effect_Create(actor.mCurrMountNode, "yf1", 0, 70, 4, itemtab.AniCount, sex, 0, 5, 1), 1)
					end
				else
					-- 裸模
					GUI:setScale(GUI:Effect_Create(actor.mCurrMountNode, "yf", 0, 70, 4, 9999, sex, 0, 5, 1), 1)
				end

				-- 名称
				GUI:setAnchorPoint(GUI:Text_Create(actor.mCurrMountNode, "name", 24, 52, 12, npclist[actor.mName][5], playname), 0.5, 0.5)
            else
                -- 默认
                GUI:removeAllChildren(actor.mCurrMountNode)
                local diaoxiang = GUI:Image_Create(actor.mCurrMountNode, "d", npclist[actor.mName][3], npclist[actor.mName][4], "res/custom/myui/".. npclist[actor.mName][2] ..".png")
				--GUI:setScale(diaoxiang, 0.9)
				GUI:setAnchorPoint(GUI:Text_Create(actor.mCurrMountNode, "name", 28, 52, 12, npclist[actor.mName][5], actor.mName), 0.5, 0.5)
            end
        end
    end
end

-- 注册事件：当玩家进入视野或服务器变量改变时触发 worldTopStatue 函数
local function update_callBack(sMsg)
    if string.find(sMsg, "A_world_n1") then
		worldTopStatue()
    end
	if string.find(sMsg, "U_item_collimator") then
		local collimator = GameData.GetData("U_item_collimator", false) or 0
		if collimator >= 1 then
			SL:onLUAEvent(LUA_EVENT_SIGHT_BEAD_SHOW)
		else
			SL:onLUAEvent(LUA_EVENT_SIGHT_BEAD_HIDE)
		end
	end
end
SL:RegisterLUAEvent(LUA_EVENT_GAME_DATA, "update_diao_xiang", update_callBack)
SL:RegisterLUAEvent(LUA_EVENT_ACTOR_IN_OF_VIEW, "进视野", worldTopStatue)

-- 任务特效
local function onDelTask(data)
	if nil == data or data.taskid >= 100000 then
		return
	end
    local _Handle = GUI:Attach_UITop()
	local effect = GUI:getChildByName(_Handle, "14810")
    if effect then
		GUI:removeFromParent(effect)
        effect = nil
    end
    local w = SL:GetMetaValue("SCREEN_WIDTH")
    local h = SL:GetMetaValue("SCREEN_HEIGHT")
    effect = GUI:Effect_Create(_Handle, "14810", 0, 0, 0, 14810, 0, 0, 0, 1)
    GUI:Effect_addOnCompleteEvent(effect, function()
        GUI:removeFromParent(effect)
        effect = nil
    end)
	local pos_x = w * 0.5
	local pos_y = h * 0.5
	GUI:setPosition(effect, pos_x, pos_y)
end
SL:RegisterLUAEvent(LUA_EVENT_TASK_DEL, "GUIUtil", onDelTask)
