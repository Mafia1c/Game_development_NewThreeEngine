local WorldN1Npc = {}
-- 75   战
-- 76   法
-- 77   道
function WorldN1Npc:click(actor, npc_id)
    npc_id = tonumber(npc_id)
    if not isInTable({75, 76, 77}, npc_id) then
        return
    end
    local map_id = getbaseinfo(actor, 3)
    if map_id ~= "3" then
        Sendmsg9(actor, "ff0000", "距离npc过远!", 1)
        return
    end
    local rank_str = GetSysStr("A_world_n1"..npc_id)
    local sMsg = npc_id
    if "" ~= rank_str then
        sMsg = sMsg .. "#" .. rank_str
    end
    lualib:ShowNpcUi(actor, "WorldN1OBJ", sMsg)
end

function WorldN1Npc:onApplyUp(actor, npc_id)
    local my_power = VarApi.getPlayerUIntVar(actor, "U100")
    npc_id = tonumber(npc_id)
    if not isInTable({75, 76, 77}, npc_id) then
        return
    end
    local my_level = getbaseinfo(actor, 6)
    local job = getbaseinfo(actor, 7)
    if job ~= npc_id - 75 then
        Sendmsg9(actor, "ff0000", "申请失败, 职业不符!", 1)
        return
    end
    local up_name = nil
    local up_level = 50
    local up_power = 0
    if my_level < up_level then
        Sendmsg9(actor, "ff0000", "申请失败, 等级不足50级!", 1)
        return
    end
    local rank_str = GetSysStr("A_world_n1"..npc_id)
    if "" == rank_str then
    else
        local tab = strsplit(rank_str, "|")
        up_name = tab[1]
        up_level = tonumber(tab[2]) or up_level
        up_power = tonumber(tab[3]) or up_power
    end
    if my_level < up_level then
        Sendmsg9(actor, "ffffff", "申请失败, 等级低于榜上玩家!", 1)
        return
    elseif my_level == up_level then
        if my_power <= up_power then
            Sendmsg9(actor, "ffffff", "申请失败, 战力低于榜上玩家!", 1)
            return
        end
    end
    local yifu = VarApi.getPlayerTStrVar(actor, "T_dress_equip_name")
    local wuqi = VarApi.getPlayerTStrVar(actor, "T_weapon_equip_name")
    local sex = getbaseinfo(actor, 8)
    local name = getbaseinfo(actor, 1)
    local str = name .. "|" .. my_level .. "|" .. my_power .. "|" .. wuqi .. "|" .. yifu .. "|" .. sex
    SetSysStr("A_world_n1"..npc_id, str)
    lualib:FlushNpcUi(actor, "WorldN1OBJ", str)
    Sendmsg9(actor, "00ff00", "恭喜荣登天下第一榜单!", 1)
    
    if up_name then
        local up_player = getplayerbyname(up_name)
        if up_player and isnotnull(up_player) then
            deprivetitle(up_player, "头号玩家")
        end
    end
    confertitle(actor, "头号玩家")

    self:SendWorldDataClient()
end

-- 玩家登录时推送天下第一数据道客户端
function WorldN1Npc:SendWorldDataClient(actor)
    local player_list = getplayerlst(1) or {}
    if nil ~= actor and isnotnull(actor) then
        player_list = {actor}
    end
    for key, obj in pairs(player_list) do
        for index, id in ipairs({75, 76, 77}) do
            lualib:CallFuncByClient(obj, "A_world_n1"..id, GetSysStr("A_world_n1"..id))
        end
    end
end

-- 玩家登录时判断头号玩家称号是否删除
function WorldN1Npc:loginCheckWorldN1Data(actor)
    local job = getbaseinfo(actor, 7)
    local name = getbaseinfo(actor, 1)
    local tmp_tab = {
        GetSysStr("A_world_n175"),
        GetSysStr("A_world_n176"),
        GetSysStr("A_world_n177")
    }

    local var_str = tmp_tab[job + 1]
    local tab = strsplit(var_str or "", "|")
    if tab[1] == name then
        if not checktitle(actor, "头号玩家") then
            confertitle(actor, "头号玩家", 0)
        end
    else
        deprivetitle(actor, "头号玩家")
    end
end

-- 玩家转职时更新天下第一信息
function WorldN1Npc:ChangeJobDeleteRank(actor)
    if not checktitle(actor, "头号玩家") then
        return
    end
    local _name = getbaseinfo(actor, 1)
    local job = getbaseinfo(actor, 7)
    local tmp_tab = {
        "A_world_n175",
        "A_world_n176",
        "A_world_n177"
    }
    local var_str = GetSysStr(tmp_tab[job + 1])
    local tab = strsplit(var_str or "", "|")
    if tab[1] == _name then
        deprivetitle(actor, "头号玩家")
        SetSysStr(tmp_tab[job + 1], "")
        self:SendWorldDataClient()
    end
end

return WorldN1Npc