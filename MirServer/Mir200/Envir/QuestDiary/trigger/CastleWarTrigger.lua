CastleWarTrigger = {}
CastleWarTrigger.winner_people = 0
CastleWarTrigger.loser_people = 0

-- 攻城开始触发
function CastleWarTrigger.CastleWarStart(sysobj)
    release_print("攻沙开始!")
    for i = 1, 3 do
        sendmovemsg("0", 0, 250, 0, 60+(i - 1 )*30, 1,"【活动提示】: [决胜沙城] 活动已开放")
    end
    local str = string.format("【系统】:全服活动→%s", "[决胜沙城(本服)] 活动已开放")
    local msg = string.format('{"Msg":"%s","FColor":255,"BColor":249,"Type":1}',str)
    sendmsg("0", 2, msg)
    SetSysInt("G_castle_city_state", 1)
    setofftimerex(GlobalTimer.global_castleWa_id)
end

function CastleWarTrigger.CastleWarEnd(sysobj)
    release_print("攻沙结束!")
    SetSysInt("G_castle_city_state", 2)
    setontimerex(GlobalTimer.global_castleWa_id, 1800)
    sendmovemsg("0", 0, 250, 0, 60, 1,"【决胜沙城(本服)】: 活动已结束, 少侠们可前往沙巴克皇宫 [沙城主] 处领取攻城奖励")

    local loser_people = 0
    local winner_people = 0

    local player_list = getplayerlst(1)
    for i, player in ipairs(player_list or {}) do
        local guild_name = getbaseinfo(player, 36)
        local city_time = VarApi.getPlayerJIntVar(player, "J_city_total_time")
        local identity = castleidentity(player)
        if city_time >= 900 and nil ~= guild_name and "" ~= guild_name then
            if identity == 0 then
                loser_people = loser_people + 1
            else
                winner_people = winner_people + 1
            end
        end
    end
    SetSysInt("G_loser_people", loser_people)
    SetSysInt("G_winner_people", winner_people)

    SetSysInt("G_total_jackpot_value", GetSysInt("G_city_jackpot_value") + 500000)      -- 沙巴克总奖池数量
end

-- 操作攻沙
function CastleWarTrigger.opCastleWar(obj, tag, isKf)
    if tag == "open" then
        addtocastlewarlistex("*")
        gmexecute(obj, "攻城")
    else
        gmexecute(obj, "攻城")
    end
end

-- 攻城 or 后台攻城   重置沙巴克状态
function ontimerex9502()
    setofftimerex(GlobalTimer.global_castleWa_id)
    SetSysInt("G_city_jackpot_value", 0)     -- 清空新区沙巴克奖池
    SetSysInt("G_castle_city_state", 3)
    SetSysInt("G_loser_people", 0)
    SetSysInt("G_winner_people", 0)
end