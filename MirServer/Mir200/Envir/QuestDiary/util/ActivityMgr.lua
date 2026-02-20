ActivityMgr = {}
local _cfg = include("QuestDiary/config/ActivityCfg.lua");
if nil == _cfg then
    _cfg = {}
end
ActivityMgr.new_activity_cfg = _cfg["newServer"]               -- 新区活动配置
ActivityMgr.old_activity_cfg = _cfg["oldServer"]               -- 老区活动配置
ActivityMgr.ActivityFunc = {}

-- ========================================================= 新区活动 ===================================================================
-- 更新新区活动状态   0.未开始    1.进行中   2.入口关闭    3.已结束
function ActivityMgr.initNewActivity(run_time)
    local is_merge = getconst("0", "<$HFDAYS>")                     -- 当天是否合区
    local open_day = GetSysInt(VarEngine.OpenDay)                   -- 开区天数
    local merge_count = GetSysInt(VarEngine.HeFuCount)              -- 合服次数
    local _run_sec = run_time                                      -- 服务器运行时间(秒)
    for key, v in pairs(ActivityMgr.new_activity_cfg or {}) do
        local old_state = GetSysInt(v.SysIntVarName)
        local state = 0
        if open_day > 0 or merge_count > 0 or kuafuconnected() then
            state = 3
        else
            if v.openTime and _run_sec < v.openTime and v.customCloseVar and GetSysTLInt(v.customCloseVar) > 0  then
                SetSysTLInt(v.customCloseVar,0)
            end
            if v.openTime and _run_sec >= v.openTime  then
                state = 1
            end
            if v.closeTime and _run_sec >= v.closeTime then
                state = 2
            end
            if v.endTime and _run_sec > v.endTime then
                state = 3
            end
        end
        if v.customCloseVar and GetSysTLInt(v.customCloseVar) > 0 then
            state = 3
            if GetSysInt(v.SysIntVarName.."gm") > 0 then
                globalcleardelaygoto("close_gm_activity,"..key, 0)
                SetSysInt(v.SysIntVarName.."gm",0)
            end
        end
        if state ~= old_state and GetSysInt(v.SysIntVarName.."gm") <= 0 then
            SetSysInt(v.SysIntVarName, state)
            local func = ActivityMgr.ActivityFunc[v.funcName]
            if func then
                func(v, state)
            end
        end
    end
end
-- 新区活动 天降财宝
ActivityMgr.ActivityFunc["WorldTreasure"] = function (cfg, state)
    local tip_desc = cfg.openDesc
    local color = 250
    if state == 2 then
        tip_desc = cfg.closeDesc
        color = 251
    elseif state == 3 then
        tip_desc = nil--cfg.endDesc
        Sendmsg1("0",255,249,cfg.endDesc,2)
        color = 249
        clearitemmap("天降财宝",21,25,100,"*")
    elseif state == 0 then
        tip_desc = nil
    else
        
    end
    if tip_desc then
        for i = 1, 3 do
            sendmovemsg("0", 0, color, 0, 60 + (i - 1 ) * 30, 1, tip_desc)
        end
    end
    local player_list = getplayerlst(1)
    if state == 1 then
        Sendmsg1("0",255,249,"【系统】：全服活动→天降财宝，已开启，活动地图掉落海量经验、元宝、材料，快快前往！",2)
        for k, v in pairs(GlobalTimer.tjcb_award_list) do
            throwitem("0","天降财宝",25,25,25,k,v,1,false,true,false)
        end
        for i, player  in ipairs(player_list or {}) do
            local activity_class =  IncludeMainClass("ActivityCenter")
            if activity_class  then
                activity_class:ShowActitityStartTip(player,1)
            end
        end
    else
        local players = getplaycount("天降财宝",1,1)
        for index, player in ipairs(type(players) == "table" and players or {}) do
            lualib:CallFuncByClient(player, "activity_state", cfg.SysIntVarName.."#".. state)
            mapmove(player,3,322,333,5)
        end
    end
    for i, player  in ipairs(player_list or {}) do
        lualib:CallFuncByClient(player, "activity_state", cfg.SysIntVarName.."#".. state)
    end
   
    
end
-- 新区活动 激情派对
ActivityMgr.ActivityFunc["PassionParty"] = function (cfg, state)
    local tip_desc = cfg.openDesc
    local color = 250
    if state == 2 then
        tip_desc = nil--cfg.closeDesc
        color = 251
    elseif state == 3 then
        tip_desc = nil--cfg.endDesc
        color = 249
        Sendmsg1("0",255,249,cfg.endDesc,2)
    elseif state == 0 then
        tip_desc = nil
    end
    if tip_desc then
        for i = 1, 3 do
            sendmovemsg("0", 0, color, 0, 60 + (i - 1 ) * 30, 1, tip_desc)
        end
    end
    local player_list = getplayerlst(1)
    if state == 1 then
        SetSysStr("A_jfpd_rank","")
        Sendmsg1("0",255,249,"【系统】：全服活动→激情派对，已开启，活动地图每秒可获得大量经验、元宝，快快前往！",2)
        -- RegRankVar("J_jqpd_jifen",0,0,3,0) 
        for i, player  in ipairs(player_list or {}) do
            -- VarApi.setPlayerJIntVar(player,"J_jqpd_jifen",0)
            local activity_class =  IncludeMainClass("ActivityCenter")
            if activity_class  then
                activity_class:ShowActitityStartTip(player,2)
            end
        end
        if not hasenvirtimer("激情派对",55555) then
            setenvirontimer("激情派对",55555,1,"@jqpd_money_change")
        end
        killmonsters("激情派对", "上古稻草人", 0, true, true)
        local x,y= ActivityMgr.GetRandomXY("激情派对")
        genmonex("激情派对", x,y,"上古稻草人",5,1)
        if not hasenvirtimer("激情派对",66666) then
            setenvirontimer("激情派对",66666,120,"@jqpd_daocaoren")
        end
    else
        local players = getplaycount("激情派对",0,1)
        for index, player in ipairs(type(players) == "table" and players or {}) do
            lualib:CallFuncByClient(player, "activity_state", cfg.SysIntVarName.."#".. state)
            if getbaseinfo(player,0) then
               realive(player) 
            end
            mapmove(player,3,322,333,5)
        end
        local activity_class =  IncludeMainClass("ActivityCenter")
        if activity_class  then
            local rank_list = activity_class:GetJqpdRankList()
            for i,v in ipairs(rank_list or {}) do
                if i == 1 then
                    sendmail(v.role_id, 1,"激情派对第1名奖励" , "恭喜你，在<【激情派对活动】/FCOLOR=250>中勇夺第1名，奖励请查收", "绑定元宝#100000")
                elseif i == 2 then
                    sendmail(v.role_id, 1,"激情派对第2名奖励" , "恭喜你，在<【激情派对活动】/FCOLOR=250>中勇夺第2名，奖励请查收", "绑定元宝#50000")
                elseif i == 3 then
                    sendmail(v.role_id, 1,"激情派对第3名奖励" , "恭喜你，在<【激情派对活动】/FCOLOR=250>中勇夺第3名，奖励请查收", "绑定元宝#20000")
                end
            end
        end
        SetSysStr("A_jfpd_rank","")
        setenvirofftimer("激情派对",55555)
        setenvirofftimer("激情派对",66666)
    end
    for i, player  in ipairs(player_list or {}) do
        lualib:CallFuncByClient(player, "activity_state", cfg.SysIntVarName.."#".. state)
    end
end
function ActivityMgr.GetRandomXY(map_name)
    local x,y = GetMapRandXY("0", map_name)
    if not gridattr(map_name, x, y, 1) then
       return  ActivityMgr.GetRandomXY(map_name)
    end
    return x,y
end
function jqpd_money_change(sysobj)
    local players = getplaycount("激情派对",1,1)
    for index, player in ipairs(type(players) == "table" and players or {}) do
        ChangeMoney(player,4,"+",10)
        changeexp(player,"+",50000)
    end
end
function jqpd_daocaoren(sysobj)
    if getmoncount("激情派对", 2457, true) < 5 then
        local x,y= ActivityMgr.GetRandomXY("激情派对")
        genmonex("激情派对", x,y,"上古稻草人",5,1)
    end
end
-- 新区活动 武林至尊
ActivityMgr.ActivityFunc["WuLinMaster"] = function (cfg, state)
    local tip_desc = cfg.openDesc
    local color = 250
    if state == 2 then
        tip_desc = cfg.closeDesc
        color = 251
    elseif state == 3 then
        tip_desc = cfg.endDesc
        color = 249
    elseif state == 0 then
        tip_desc = nil
    else
        
    end
    if tip_desc then
        for i = 1, 3 do
            sendmovemsg("0", 0, color, 0, 60 + (i - 1 ) * 30, 1, tip_desc)
        end
    end
    local player_list = getplayerlst(1)
    if state == 1 then
        for i = 1, 3 do
            Sendmsg1("0",255,249,"【系统】：全服活动→武林至尊，已开启，最终胜出者可以获得〖武林盟主〗称号！",2)
        end
        for i, player  in ipairs(player_list or {}) do
            local activity_class =  IncludeMainClass("ActivityCenter")
            if activity_class  then
                activity_class:ShowActitityStartTip(player,3)
            end
        end
    elseif state == 2 then
        for i = 1, 3 do
            Sendmsg1("0",255,249,"【系统】：全服活动→武林至尊，大门已关闭，可以开始领奖了！",2)
        end
    end
    for i, player  in ipairs(player_list or {}) do
        lualib:CallFuncByClient(player, "activity_state", cfg.SysIntVarName.."#".. state)
    end
end
-- 新区活动 夺宝奇兵
ActivityMgr.ActivityFunc["LootSoldier"] = function (cfg, state)
    local tip_desc = cfg.openDesc
    local color = 250
    if state == 2 then
        tip_desc = cfg.closeDesc
        color = 251
    elseif state == 3 then
        tip_desc = cfg.endDesc
        color = 249
    elseif state == 0 then
        tip_desc = nil
    else
        
    end
    if tip_desc then
        for i = 1, 3 do
            sendmovemsg("0", 0, color, 0, 60 + (i - 1 ) * 30, 1, tip_desc)
        end
    end
    local player_list = getplayerlst(1)
    if state == 1 then
        killmonsters("夺宝奇兵","*",0,true,true)
        genmonex("夺宝奇兵",26,34,"宝藏守护者",0,1,0,249)
        Sendmsg1("0",255,249,"【系统】：全服活动→夺宝奇兵，已开启，持有宝箱120秒会获得【超级装备】！",2)
        for i, player  in ipairs(player_list or {}) do
            local activity_class =  IncludeMainClass("ActivityCenter")
            if activity_class  then
                activity_class:ShowActitityStartTip(player,4)
            end
        end
    end
    for i, player  in ipairs(player_list or {}) do
        lualib:CallFuncByClient(player, "activity_state", cfg.SysIntVarName.."#".. state)
    end
end
-- 新区活动 狂暴霸主
ActivityMgr.ActivityFunc["RageMaster"] = function (cfg, state)
    local tip_desc = cfg.openDesc
    local color = 250
    if state == 2 then
        tip_desc = cfg.closeDesc
        color = 251
    elseif state == 3 then
        tip_desc = cfg.endDesc
        color = 249
    elseif state == 0 then
        tip_desc = nil
    else
        
    end
    if tip_desc then
        for i = 1, 3 do
            sendmovemsg("0", 0, color, 0, 60 + (i - 1 ) * 30, 1, tip_desc)
        end
    end
    local player_list = getplayerlst(1)
    if state == 1 then
        killmonsters("狂暴霸主","*",0,true,true)
        genmonex("狂暴霸主",28,34,"狂暴霸主",0,1,0,249)
        Sendmsg1("0",255,249,"【系统】：全服活动→狂暴之地，狂暴霸主已出现在活动地图，必爆高级装备！",2)
        for i, player  in ipairs(player_list or {}) do
            local activity_class =  IncludeMainClass("ActivityCenter")
            if activity_class  then
                activity_class:ShowActitityStartTip(player,8)
            end
        end 
    end
    for i, player  in ipairs(player_list or {}) do
        lualib:CallFuncByClient(player, "activity_state", cfg.SysIntVarName.."#".. state)
    end
end
-- ========================================================= 老区活动 ===================================================================
function ActivityMgr.initOldActivity(run_time)
    local is_merge = getconst("0", "<$HFDAYS>")                     -- 当天是否合区
    local open_day = GetSysInt(VarEngine.OpenDay)                   -- 开区天数
    local merge_count = GetSysInt(VarEngine.HeFuCount)              -- 合服次数
    local is_kf_connect = kuafuconnected()
    local _run_time = run_time                                      -- 服务器运行时间(秒)
    local time = os.time()                                          -- 当前时间戳
    local wDay = GetWday(time)                                      -- 星期几   1-7 周一至周日
    local _t = os.date("*t", time)
    local day = _t.day                                              -- 日
    local hour = _t.hour                                            -- 时
    local min = _t.min                                              -- 分
    local sec = _t.sec                                              -- 秒    
    local time_str = string.format("%02d:%02d:%02d", hour, min, sec)-- 时刻字符串 15:00:12

    if merge_count > 0 then
        local is_gs = 0
        if is_merge == 1 or "1" == is_merge then
            is_gs = 1
        end
        if time_str == "20:00:00" and is_gs > 0 then
            CastleWarTrigger.opCastleWar("0", "open")
        end
        if time_str == "21:00:00" then
            if GetSysInt("G_castle_city_state") == 1 then
                CastleWarTrigger.opCastleWar("0", "close")
            end
        end
    end
    for key, v in pairs(ActivityMgr.old_activity_cfg or {}) do
        local old_state = GetSysInt(v.SysIntVarName)
        local state = 0
        if (merge_count <= 0 and v.openDay and open_day >= v.openDay and not is_kf_connect)  then
            if v.openTime then
                local start_time_str_list = strsplit(v.openTime,":") 
                if (hour < tonumber(start_time_str_list[1]) or (hour == tonumber(start_time_str_list[1]) and min < tonumber(start_time_str_list[2]))) and GetSysTLInt(v.customCloseVar) > 0 then
                    SetSysTLInt(v.customCloseVar,0)
                end
                if hour == tonumber(start_time_str_list[1]) and min >= tonumber(start_time_str_list[2]) then
                    state = 1
                end
            end
            if v.closeTime then
                local close_time_str_list = strsplit(v.closeTime,":") 
                if hour >= tonumber(close_time_str_list[1]) and min >= tonumber(close_time_str_list[2]) then
                    state = 2
                end
            end
            if v.endTime then
                local end_time_str_list = strsplit(v.endTime,":") 
                if hour >= tonumber(end_time_str_list[1]) and min >= tonumber(end_time_str_list[2]) then
                    state = 3
                end
            end
            if v.customCloseVar and GetSysTLInt(v.customCloseVar) > 0 then
                state = 3
            end
        end
        if state ~= old_state and v.funcName then
            SetSysInt(v.SysIntVarName, state)
            local func = ActivityMgr.ActivityFunc[v.funcName]
            if func then
                func(v, state)
            end
        end
    end
end

-- 老区活动 世界boss
ActivityMgr.ActivityFunc["WordBoss"] = function (cfg, state)
    local tip_desc = cfg.openDesc
    local color = 250
    if state == 2 then
        tip_desc = cfg.closeDesc
        color = 251
    elseif state == 3 then
        tip_desc = cfg.endDesc
        color = 249
    elseif state == 0 then
        tip_desc = nil
    else
        
    end

    if tip_desc then
        for i = 1, 3 do
            sendmovemsg("0", 0, color, 0, 60 + (i - 1 ) * 30, 1, tip_desc)
        end
    end
    local player_list = getplayerlst(1)
    if state == 1 then
        local merge_count = GetSysInt(VarEngine.HeFuCount)   
        if merge_count <= 0 or (not kuafuconnected()) then
            killmonsters("世界BOSS","*",0,true,true)
            genmonex("世界BOSS",53,52,"终极大魔王",0,1,0,249)
        end
        for i, player  in ipairs(player_list or {}) do
            local activity_class =  IncludeMainClass("ActivityCenter")
            if activity_class  then
                activity_class:ShowActitityStartTip(player,5)
            end
        end
        SetSysInt("G_sjbs_moneychange_time", os.time()+ 600)
        if not hasenvirtimer("世界BOSS",999999) then
            setenvirontimer("世界BOSS", 999999, 1, "@sjbs_moneychang")
        end
    else
        setenvirofftimer("世界BOSS",999999)
    end
    for i, player  in ipairs(player_list or {}) do
        lualib:CallFuncByClient(player, "activity_state", cfg.SysIntVarName.."#".. state)
    end
end
--行会战场
ActivityMgr.ActivityFunc["GuildBattlefield"] = function (cfg, state)
    
    local tip_desc = cfg.openDesc
    local color = 250
    if state == 2 then
        tip_desc = cfg.closeDesc
        color = 251
    elseif state == 3 then
        tip_desc = cfg.endDesc
        color = 249
    elseif state == 0 then
        tip_desc = nil
    else
        
    end
    if tip_desc then
        for i = 1, 3 do
            sendmovemsg("0", 0, color, 0, 60 + (i - 1 ) * 30, 1, tip_desc)
        end
    end
    local player_list = getplayerlst(1)
    if state == 1 then
        local merge_count = GetSysInt(VarEngine.HeFuCount)   
        if merge_count <= 0 or (not kuafuconnected()) then
            Sendmsg1("0",255,249,"【系统】：全服活动→行会战场，【行会大魔王】已出现在【行会战场】，击杀必爆超级装备！",2)
            killmonsters("行会战场","*",0,true,true)
            genmonex("行会战场",57,44,"行会大魔王",0,1,0,249)
        end
        for i, player  in ipairs(player_list or {}) do
            local activity_class =  IncludeMainClass("ActivityCenter")
            if activity_class  then
                activity_class:ShowActitityStartTip(player,6)
            end
        end
        if not hasenvirtimer("行会战场",77777) then
            setenvirontimer("行会战场", 77777, 1, "@hhzc_moneychang")
        end
    else
        setenvirofftimer("行会战场",77777)
    end
    for i, player  in ipairs(player_list or {}) do
        lualib:CallFuncByClient(player, "activity_state", cfg.SysIntVarName.."#".. state)
    end
end
--乱斗之王
ActivityMgr.ActivityFunc["MeleeBattleKing"] = function (cfg, state)
    local tip_desc = cfg.openDesc
    local color = 250
    if state == 2 then
        tip_desc = cfg.closeDesc
        color = 251
    elseif state == 3 then
        tip_desc = cfg.endDesc
        color = 249
    elseif state == 0 then
        tip_desc = nil
    else
        
    end
    if tip_desc then
        for i = 1, 3 do
            sendmovemsg("0", 0, color, 0, 60 + (i - 1 ) * 30, 1, tip_desc)
        end
    end
    local player_list = getplayerlst(1)
    if state == 1 then
        Sendmsg1("0",255,249,"【系统】：全服活动→乱斗之王，【暗黑帝王】已出现在【乱斗之王1层】，勇士们快去击杀！",2)
        killmonsters("乱斗之王1","*",0,true,true)
        genmonex("乱斗之王1",25,32,"暗黑帝王",0,1,0,249)
        for i, player  in ipairs(player_list or {}) do
            local activity_class =  IncludeMainClass("ActivityCenter")
            if activity_class then
                activity_class:ShowActitityStartTip(player,7)
            end
        end
        mapeffect(518, "乱斗之王1", 21, 31, 518, 0, 0, nil, 0)
        mapeffect(519, "乱斗之王1", 30, 31, 518, 0, 0, nil, 0)
        mapeffect(520, "乱斗之王1", 26, 36, 518, 0, 0, nil, 0)
    else
        delmapeffect(518)
        delmapeffect(519)
        delmapeffect(520)
    end
    for i, player in ipairs(player_list or {}) do
        if state ~= 1 then
            setofftimer(player,PlayerTimer.ldzw_timer_id)
        end
        lualib:CallFuncByClient(player, "activity_state", cfg.SysIntVarName.."#".. state)
    end
end
function ActivityMgr.GmOpenActivity(actor,index)
    if index == 11 and not kuafuconnected() then
        return Sendmsg9(actor,"#ffffff","跨服沙城必须开启跨服服务器！！！",1) 
    end
    --跨服沙城  
    if index == 11 then
        if GetSysInt("G_kfsc_activity_state") == 1 then
            close_gm_activity(nil,11)
        else
            SetSysInt("G_kfsc_activity_state",1) 
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "activity_state", "G_kfsc_activity_state#".. 1)
                local activity_class =  IncludeMainClass("ActivityCenter")
                if activity_class  then
                    activity_class:ShowActitityStartTip(player,9)
                end
            end 
            KuaFuTrigger.bfbackcall(nil, "跨服沙城_开始", "跨服沙城")
            globaldelaygoto(3600 * 1000,"close_gm_activity,"..index) 
        end
    else
        local cfg =  ActivityMgr.new_activity_cfg[index]
        local state = 3
        if GetSysInt(cfg.SysIntVarName) == 1 then
            state = 3
            SetSysInt(cfg.SysIntVarName.."gm", 0)
        else
            state = 1
            if cfg.customCloseVar then
                SetSysTLInt(cfg.customCloseVar,0)
            end
            SetSysInt(cfg.SysIntVarName.."gm", 1)
            Sendmsg9(actor,"#ffffff","再次点击关闭活动",1) 
        end
        SetSysInt(cfg.SysIntVarName, state)
        local func = ActivityMgr.ActivityFunc[cfg.funcName]
        if func then
            func(cfg, state)
            if state == 1 and cfg.endTime then
               globaldelaygoto((cfg.endTime - cfg.openTime) * 1000,"close_gm_activity,"..index) 
            elseif state == 1 and cfg.closeTime then
               globaldelaygoto((cfg.closeTime - cfg.openTime) * 1000,"close_gm_activity,"..index) 
            end
            if state == 3 then
                globalcleardelaygoto("close_gm_activity,"..index, 0)
            end
        end
    end
end
function close_gm_activity(sys,index)
    index = tonumber(index)
    if index == 11 then
        SetSysInt("G_kfsc_activity_state",2) 
        local player_list = getplayerlst(1)
        for i, player  in ipairs(player_list or {}) do
            lualib:CallFuncByClient(player, "activity_state", "G_kfsc_activity_state#".. 2)
        end 
        KuaFuTrigger.bfbackcall(nil, "跨服沙城_结束", "跨服沙城")
    else
        local cfg =  ActivityMgr.new_activity_cfg[index]
        local func = ActivityMgr.ActivityFunc[cfg.funcName]
        SetSysInt(cfg.SysIntVarName.."gm", 0)
        if func then
            func(cfg, 3)
        end
    end
    globalcleardelaygoto("close_gm_activity,"..index, 0)
end
function sjbs_moneychang()
    if GetSysInt("G_sjbs_moneychange_time") > os.time() then
        local players = getplaycount("世界BOSS",1,1)
        for index, player in ipairs(type(players) == "table" and players or {}) do
            changeexp(player,"+",10000)
        end
    else
        SetSysInt("G_sjbs_moneychange_time",0)
        setenvirofftimer("世界BOSS",999999)
    end
end
function hhzc_moneychang()
    local players = getplaycount("行会战场",1,1)
    for index, player in ipairs(type(players) == "table" and players or {}) do
        ChangeMoney(player,4,"+",math.random(50,100),"行会战场每秒获得",true)
    end
end
