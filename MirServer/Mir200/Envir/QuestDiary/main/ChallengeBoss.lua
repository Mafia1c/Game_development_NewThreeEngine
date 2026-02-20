local ChallengeBoss = {}
ChallengeBoss.boss_cfg = GetConfig("ChallengeBossCfg")
ChallengeBoss.MapCfg = GetConfig("CanMapCruiseCfg")

local tmp_cfg = {}
for index, v in ipairs(ChallengeBoss.boss_cfg) do
    local tab = strsplit(v.monname, "/FCOLOR=")
    local mon_name = string.gsub(tab[1], "<", "")
    tmp_cfg[mon_name] = v
end
ChallengeBoss.KillBoss = tmp_cfg

function ChallengeBoss:onClickBtn(actor)
    local tab, state = self:GetBossInfo(1)
    lualib:ShowNpcUi(actor, "ChallengeBossOBJ", tbl2json(tab) .. "#" .. tbl2json(state))
end

function ChallengeBoss:onPageChange(actor, page)
    page = tonumber(page)
    local tab, state = self:GetBossInfo(page)
    lualib:FlushNpcUi(actor, "ChallengeBossOBJ", page.."#"..tbl2json(tab) .. "#" .. tbl2json(state))
end

function ChallengeBoss:gotoChallenge(actor, page, index)
    page = tonumber(page)
    index = tonumber(index)
    if nil == page or nil == index then
        return
    end
    index = (page - 1) * 6 + index
    local cfg = self.boss_cfg[index]
    if nil == cfg then
        return
    end
    local info = self.MapCfg[cfg.mapname] or {}
    local map_id = getbaseinfo(actor, 3)
    if map_id == cfg.mapname or map_id == info.checkmapid then
        Sendmsg9(actor, "ffffff", "你已在该地图中, 快去杀怪吧", 1)
        return
    end
    local npc_class = IncludeNpcClass("MapMoveNpc")
    if npc_class then
        local npc_id, v = npc_class:checkRecordNpcId(actor, cfg.mapname)
        if nil == npc_id and info then
            npc_id, v = npc_class:checkRecordNpcId(actor, info.checkmapid)
        end
        if npc_id then
            opennpcshowex(actor, npc_id, 20,  2)
        else
            Sendmsg9(actor, "ffffff", "未检测到对应传送npc, "..cfg.mapname, 1)
        end
    end
    lualib:CloseNpcUi(actor, "ChallengeBossOBJ")
end

function ChallengeBoss:GetBossInfo(page)
    local ret, time = GetSysTLStr("TL_first_kill_boss")
    if nil == ret or "" == ret then
        ret = {}
    else
        ret = json2tbl(ret)
    end
    local st = (page - 1) * 6 + 1
    local ed = st + 5
    local tmp_times = {}
    local kill_state = {}
    for i = st, ed do
        local cfg = self.boss_cfg[i]
        if cfg then
            local tab = strsplit(cfg.monname, "/FCOLOR=")
            local mon_name = string.gsub(tab[1], "<", "")
            local mon_id = getdbmonfieldvalue(mon_name, "idx")
            local count = getmoncount(cfg.mapname, mon_id, true)
            tmp_times[#tmp_times + 1] = count > 0 and 0 or cfg.time
            kill_state[#kill_state + 1] = ret[mon_name] or 0
        end
    end
    return tmp_times, kill_state
end

-- 每日首次击杀挑战boss
function ChallengeBoss:DailyFirstKillBoss(actor, boss_name, map_id)
    local v = self.KillBoss[boss_name]
    if nil == v then
        return
    end
    if v.mapname ~= map_id then
        return
    end
    local ret, time = GetSysTLStr("TL_first_kill_boss")
    if nil == ret or "" == ret then
        ret = {}
    else
        ret = json2tbl(ret)
    end
    if nil ~= ret[boss_name] then
        return
    end
    ret[boss_name] = getbaseinfo(actor, 1) .. "|" .. os.time()
    SetSysTLStr("TL_first_kill_boss", tbl2json(ret), GetDayTick() + 86400)

    local format = "恭喜成功击杀<[%s]/FCOLOR=250>, 获得每日首杀奖励"
    local reward_count = v.firstkill_arr[2]
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state > 0 then
        reward_count = reward_count + reward_count
        format = "恭喜成功击杀<[%s]/FCOLOR=250>, 获得每日首杀奖励(盟重令双倍)"
    end
    local center = string.format(format, boss_name)
    SendMail(actor, 1, "每日首杀奖励", center, v.firstkill_arr[1] .. "#" .. reward_count)
end

return ChallengeBoss