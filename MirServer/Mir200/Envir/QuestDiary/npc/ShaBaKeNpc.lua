local ShaBaKeNpc = {}
ShaBaKeNpc.moveCfg = {
    {"sbk",155,163},
    {"sbk",181,192},
    {"sbk",189,224},
    {"sbk",215,193},
    {"sbk",227,242},
}
ShaBaKeNpc.reward = 500000
function ShaBaKeNpc:click(actor, npc_id)
    local jackpot = GetSysInt("G_city_jackpot_value")
    jackpot = jackpot + 500000
    local city_time = VarApi.getPlayerJIntVar(actor, "J_city_total_time")
    city_time = math.ceil(city_time / 60)
    city_time = city_time .. "|" .. GetSysInt("G_winner_people") .. "|" .. GetSysInt("G_loser_people")
    local guild_name = castleinfo(2)
    local guile_role = castleinfo(3)
    local guild = guild_name .. "|" .. guile_role
    lualib:ShowNpcUi(actor, "ShaBaKeOBJ", jackpot .. "#" .. city_time .. "#" .. guild)
end

function ShaBaKeNpc:onMapMove(actor, point)
    local guild_name = getbaseinfo(actor, 36)
    if nil == guild_name or "" == guild_name then
        Sendmsg9(actor, "00ff00", "你还未加入行会!", 1)
        return
    end
    point = tonumber(point)
    local tab = self.moveCfg[point]
    if nil == tab then
        return
    end
    if not castleinfo(5) or GetSysInt("G_castle_city_state") ~= 1 then
        Sendmsg9(actor, "ffffff", "沙巴克攻城未开启!", 1)
        return
    end
    lualib:CloseNpcUi(actor, "ShaBaKeOBJ")
    mapmove(actor, tab[1], tab[2], tab[3], 1)
end

function ShaBaKeNpc:onGetGongShaReward(actor)
    local state = GetSysInt("G_castle_city_state")
    if state ~= 2 then
        Sendmsg9(actor, "ffffff", "现在不是领奖时间!", 1)
        return
    end
    local guild_name = getbaseinfo(actor, 36)
    if nil == guild_name or "" == guild_name then
        Sendmsg9(actor, "ff0000", "你还未加入行会!", 1)
        return
    end
    local level = getbaseinfo(actor, 6)
    if level < 70 then
        Sendmsg9(actor, "ff0000", "等级不足70级, 无法领取攻沙奖励!", 1)
        return
    end
    local city_time = VarApi.getPlayerJIntVar(actor, "J_city_total_time")
    city_time = math.ceil(city_time / 60)
    if city_time < 15 then
        Sendmsg9(actor, "ff0000", "攻城期间在攻沙区域参与时间不足15分钟!", 1)
        return
    end
    local get_state = VarApi.getPlayerJIntVar(actor, "J_get_castle_reward")
    if get_state > 0 then
        Sendmsg9(actor, "ff0000", "请勿重复领取", 1)
        return
    end
    local loser_people = GetSysInt("G_loser_people")
    local winner_people = GetSysInt("G_winner_people")

    -- 0 非沙巴克成员   1  沙巴克成员    2  沙巴克老大
    local identity = castleidentity(actor)
    if identity > 0 and winner_people == 0 then
        Sendmsg9(actor, "ffffff", "暂无本服攻沙奖励可领取!", 1)
    end

    if identity == 0 and loser_people == 0 then
        Sendmsg9(actor, "ffffff", "暂无本服攻沙奖励可领取!", 1)
        return
    end
    local remain_jackpot = GetSysInt("G_total_jackpot_value")
    if remain_jackpot <= 0 then
        Sendmsg9(actor, "ffffff", "暂无攻沙奖励可领取!", 1)
        return
    end

    local jackpot = GetSysInt("G_city_jackpot_value")
    local total = jackpot + self.reward
    local lao_da_value = math.ceil(total * 0.1)
    total = total - lao_da_value
    local winner_value = math.ceil(total * 0.7)
    local loser_value = math.ceil(total * 0.3)
    local value = lao_da_value
    local desc = ""
    if identity == 2 then
        value = lao_da_value + math.ceil(winner_value / winner_people)
        desc = "沙巴克城主领取攻沙奖励!"
        confertitle(actor, "大城主", 1)
    elseif identity == 1 then
        value = math.ceil(winner_value / winner_people)
        desc = "沙巴克胜利方领取攻沙奖励!"
    else
        value = math.ceil(loser_value / loser_people)
        desc = "沙巴克失败方领取攻沙奖励!"
    end
    if value > 0 then
        ChangeMoney(actor, 4, "+", value, desc, true)
    end
    VarApi.setPlayerJIntVar(actor, "J_get_castle_reward", value, nil)
    Sendmsg9(actor, "00ff00", "领取成功, 获得绑定元宝*"..value, 9)

    remain_jackpot = remain_jackpot - value
    if remain_jackpot <= 0 then
        remain_jackpot = 0
    end
    SetSysInt("G_total_jackpot_value", remain_jackpot)
end


return ShaBaKeNpc