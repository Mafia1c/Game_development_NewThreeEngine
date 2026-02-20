-- 全局定时器
GlobalTimer = {}
GlobalTimer.server_run_time = 0                 -- 当前服务器运行时间(秒)
GlobalTimer.global_server_time_id = 9500        -- 服务器运行时间       定时器id
GlobalTimer.global_new_activity_id = 9501       -- 新区活动             定时器id
GlobalTimer.global_castleWa_id = 9502            -- 新区攻沙            定时器id
GlobalTimer.tjcb_award_list = {["生肖精华"]=10,["蛟鳞盾"]=3,["洗髓丹"]=5,["血丹"]=5,["天命石"]=3,["罗盘"]=3,["10万经验珠"]=20,["100经验珠"]=10,["1亿经验珠"]=1,["100元宝"]=10,["1000元宝"]=5,["1万元宝"]=1}

-- 全局定时器 每秒执行  对应老版本机器人(全局共用一个机器人, 函数内避免出现过多的逻辑运算)
function GlobalTimer.RunGlobalScheduled(run_time)
    GlobalTimer.server_run_time = run_time
    local is_kf_server = iskuafuserver()                            -- 是否是跨服服务器
    local is_kf_connect = kuafuconnected()                          -- 跨服服务器是否正常连接
    local is_merge = getconst("0", "<$HFDAYS>")                     -- 当天是否合区
    local open_day = GetSysInt(VarEngine.OpenDay)                   -- 开区天数
    local merge_count = GetSysInt(VarEngine.HeFuCount)              -- 合服次数
    local _run_time = run_time                                      -- 服务器运行时间(秒)
    local time = os.time()                                          -- 当前时间戳
    local wDay = GetWday(time)                                      -- 星期几   1-7 周一至周日
    local _t = os.date("*t", time)
    local day = _t.day                                              -- 日
    local hour = _t.hour                                            -- 时
    local min = _t.min                                              -- 分
    local sec = _t.sec                                              -- 秒

    local time_str = string.format("%02d:%02d:%02d", hour, min, sec)-- 时刻字符串 15:00:12
    -- 一分钟更新一次排行榜
    if _run_time % 60 == 0 then
        gmexecute("0", "开始提问", "_count_fight_power")
    end

    -- 恶魔秘境刷怪
    if _run_time % 3600 == 0 then
        if is_kf_connect then
            KuaFuTrigger.bfbackcall(nil, "恶魔秘境_genmon", "恶魔秘境")
        else
            local npc_class = IncludeNpcClass("SecretRealmMoveNpc")
            if npc_class then
                npc_class:UpdateMon(false)
            end
        end
    end
    --上古稻草人 每半小时刷怪 
    if _run_time % 3600 == 0 and GetSysInt("G_scarecrow_gen") == 0 then
        SetSysInt("G_scarecrow_gen", 1)
        if not is_kf_connect then
            globaldelaygoto(15 * 60 * 1000, "clearscarecrow_mon")
            local npc_class = IncludeMainClass("ActivityCenter")
            if npc_class then
                npc_class:RandomGenMon()
            end
        else
            KuaFuTrigger.bfbackcall(nil, "稻草人_genmon", "稻草人")
            SetSysInt("G_kf_scarecrow_num",7)
        end
        local tips_str = "<【BOSS来袭】∶/FCOLOR=250><上古稻草人已刷新在盟重省隐藏地图及狂暴霸主，击杀后获得元宝及经验，限时15分钟！！！/FCOLOR=253>"
        if tips_str then
            for i = 1, 3 do
                sendmovemsg("0", 0, 255, 0, 60 + (i - 1 ) * 30, 1, tips_str)
            end
        end
        Sendmsg1("0", 255, 249, "【BOSS来袭】∶上古稻草人已刷新在盟重省隐藏地图及狂暴霸主，击杀后获得元宝及经验，限时15分钟！！！", 2)
    end
    -- 开服第一天 塔防贞子开启  60分钟刷新
    if _run_time < 7200 and (_run_time == 600 or _run_time == 3000 ) then
        --龙虎山塔防
        -- --正常开启
        -- if GetSysTLInt("G_J_gs_Defence_state") <= 0 then 
        --     local class = IncludeNpcClass("TowerDefence")
        --     if class then
        --         class:OpenDefenceActivity()
        --     end
        -- end
        --  --gs开启过
        -- if GetSysTLInt("G_J_gs_Defence_state") > 0 and getmoncount("龙虎山", 2497,true) <= 0 and getmoncount("龙虎山", 2528,true) <= 0 and GetSysInt("G_Defence_level") > 9 then
        --     SetSysTLInt("G_J_gs_Defence_state",0)
        --     local class = IncludeNpcClass("TowerDefence")
        --     if class then
        --         class:OpenDefenceActivity()
        --     end
        -- end 

        --魔龙岭塔防
        local state = GetSysInt("G_mll_defence_state")
        if state <= 0 then
            local class = IncludeNpcClass("TowerDefence2")
            if class then
                class:OpenMllDefence()
            end
        end
    end
  
    
    if  _run_time > 7200 and isInTable({"13:15:00", "15:15:00", "17:15:00", "19:15:00", "21:15:00", "23:15:00"}, time_str) then
        -- if GetSysTLInt("G_J_gs_Defence_state") <= 0 then 
        --     local class = IncludeNpcClass("TowerDefence")
        --     if class then
        --         class:OpenDefenceActivity()
        --     end
        -- end
        
        -- if GetSysTLInt("G_J_gs_Defence_state") > 0 and getmoncount("龙虎山", 2497,true) <= 0 and getmoncount("龙虎山", 2528,true) <= 0 and GetSysInt("G_Defence_level") > 9 then
        --     SetSysTLInt("G_J_gs_Defence_state",0)
        --     local class = IncludeNpcClass("TowerDefence")
        --     if class then
        --         class:OpenDefenceActivity()
        --     end
        -- end

        --魔龙岭塔防
        local state = GetSysInt("G_mll_defence_state")
        if state <= 0 then
            local class = IncludeNpcClass("TowerDefence2")
            if class then
                class:OpenMllDefence()
            end
        end
    end


    --答题直播刷怪
    if isInTable({"12:15:00", "14:15:00", "16:15:00", "18:15:00", "20:15:00", "22:15:00", "24:15:00"}, time_str) then

        if GetSysTLInt("G_J_answer_state") <= 0 then
            -- 答题直播需求
            local class = IncludeNpcClass("AnswerNpc")
            if class then
                class:AnswerGenMon()
            end
        end

        if GetSysTLInt("G_J_answer_state") > 0 and getmoncount("诡异空间一层", -1, true) <= 0 and getmoncount("诡异空间二层", -1, true)<= 0 then
            SetSysTLInt("G_J_answer_state",0)
            local class = IncludeNpcClass("AnswerNpc")
            if class then
                class:AnswerGenMon()
            end
        end
    end

    -- 镇魂塔刷怪
    if isInTable({"01:15:00", "04:15:00", "07:15:00", "10:15:00", "13:15:00", "16:15:00", "19:15:00", "22:15:00"}, time_str) and is_kf_connect then
        KuaFuTrigger.bfbackcall(nil, "镇魂塔_genmon", "镇魂塔")
    end

    -- 跨服世界
    if merge_count > 0 and is_kf_connect then
        local tips_str = nil
        if time_str == "19:15:00" then
            SetSysInt("G_cross_dfxg_state", 1)          -- 巅峰峡谷入口开启
            KuaFuTrigger.bfbackcall(nil, "巅峰峡谷_genmon", "巅峰峡谷")
            SetSysInt("G_dfxg_open_time",time)
            tips_str = "<【跨服世界】∶/FCOLOR=250><【跨服对抗赛·巅峰峡谷】/FCOLOR=251>活动已开启报名，报名时间3分钟，勇士们速度前往报名啦！"
            Sendmsg1("0", 255, 249, "【跨服世界】：【跨服对抗赛·巅峰峡谷】活动已开启报名，报名时间3分钟，勇士们速度前往报名啦！", 2)
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "kf_word_state", "G_cross_dfxg_state#".. 1)
            end
        end
        if time_str == "19:18:00" then
            KuaFuTrigger.bfbackcall(nil, "巅峰峡谷_map_move", "巅峰峡谷")
            SetSysInt("G_cross_dfxg_state", 2)          -- 巅峰峡谷入口关闭
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "kf_word_state", "G_cross_dfxg_state#".. 2)
            end
        end
        if time_str == "18:15:00" then
            SetSysInt("G_cross_wxzc_state", 1)          -- 无限战场入口开启
            tips_str = "<【跨服世界】∶/FCOLOR=250><【跨服大乱斗·无限战场】/FCOLOR=251>活动已开启，勇士们速度前往参与，活动奖励非常丰厚！"
            Sendmsg1("0", 255, 249, "【跨服世界】：【跨服大乱斗·无限战场】活动已开启，勇士们速度前往参与，活动奖励非常丰厚！", 2)
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "kf_word_state", "G_cross_wxzc_state#".. 1)
            end
        end
        if time_str == "18:45:00" then
            SetSysInt("G_cross_wxzc_state", 2)          -- 无限战场入口关闭
            tips_str = "<【跨服世界】∶/FCOLOR=250><【跨服大乱斗·无限战场】/FCOLOR=251>活动已结束，期待下一次活动尽快开启！"
            Sendmsg1("0", 255, 249, "【跨服世界】：【跨服大乱斗·无限战场】活动已结束！", 2)
            KuaFuTrigger.bfbackcall(nil, "无限战场_end", "end")
        end
        if time_str == "18:45:03" then                  -- 无限战场结算
            KuaFuTrigger.WXZC_Settlement()
        end
        if time_str == "21:15:00" then
            SetSysInt("G_cross_yyjl_state", 1)          -- 永夜降临入口开启
            KuaFuTrigger.bfbackcall(nil, "永夜降临_genmon", "永夜降临")
            tips_str = " <【跨服世界】∶/FCOLOR=250><【跨服大逃杀·永夜降临】/FCOLOR=251>活动已开启，勇士们速速前往活动场地，一决高下！"
            Sendmsg1("0", 255, 249, "【跨服世界】：【跨服大逃杀·永夜降临】活动已开启，勇士们速速前往活动场地，一决高下！", 2)
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "kf_word_state", "G_cross_yyjl_state#".. 1)
            end
        end
        if time_str == "21:25:00" then
            SetSysInt("G_cross_yyjl_state", 2)          -- 永夜降临入口关闭
            tips_str = " <【跨服世界】∶/FCOLOR=250><【跨服大逃杀·永夜降临】/FCOLOR=251>活动入口已关闭，期待下一次活动尽快开启！"
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "kf_word_state", "G_cross_yyjl_state#".. 2)
            end
        end

        -- 恶魔广场入口开启1
        if isInTable({"03:00:00", "09:00:00", "15:00:00", "21:00:00"}, time_str) then
            SetSysInt("G_cross_emgc_state", 1)
            KuaFuTrigger.bfbackcall(nil, "恶魔广场_genmon", "跨服boss·冥界守护神")
            tips_str = "<【跨服世界】∶/FCOLOR=250><【跨服boss·冥界守护神】/FCOLOR=251>已降临<〖跨服·恶魔广场〗/FCOLOR=253>击杀必爆·<上古[1→3阶]/FCOLOR=254>盔甲！"
            Sendmsg1("0", 255, 249, "【跨服世界】：【跨服boss·冥界守护神】已降临【跨服·恶魔广场】，击杀必爆·上古[1→3阶]武器！", 2)
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "kf_word_state", "G_cross_emgc_state#".. 1)
            end
        end
        -- 恶魔广场入口关闭1
        if isInTable({"03:10:00", "09:10:00", "15:10:00", "21:10:00"}, time_str) then
            SetSysInt("G_cross_emgc_state", 2)
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "kf_word_state", "G_cross_emgc_state#".. 2)
            end
        end
        -- 恶魔广场入口开启2
        if isInTable({"06:00:00", "12:00:00", "19:00:00", "00:00:00"}, time_str) then
            SetSysInt("G_cross_emgc_state", 1)
            KuaFuTrigger.bfbackcall(nil, "恶魔广场_genmon", "跨服boss·魔界守护神")
            tips_str = "<【跨服世界】∶/FCOLOR=250><【跨服boss·魔界守护神】/FCOLOR=251>已降临<〖跨服·恶魔广场〗/FCOLOR=253>击杀必爆·<上古[1→3阶]/FCOLOR=254>武器！"
            Sendmsg1("0", 255, 249, "【跨服世界】：【跨服boss·魔界守护神】已降临【跨服·恶魔广场】，击杀必爆·上古[1→3阶]武器！", 2)
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "kf_word_state", "G_cross_emgc_state#".. 1)
            end
        end
        -- 恶魔广场入口关闭2
        if isInTable({"06:10:00", "12:10:00", "19:10:00", "00:10:00"}, time_str) then
            SetSysInt("G_cross_emgc_state", 2)
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "kf_word_state", "G_cross_emgc_state#".. 2)
            end
        end
        --世界boss
        if time_str == "18:30:00" then
            SetSysInt("G_sjbs_activity_state3", 1)          -- 世界boss
            KuaFuTrigger.bfbackcall(nil, "世界boss_genmon", "世界boss")
            tips_str = "<【活动提示】∶/FCOLOR=250><终极大魔王/FCOLOR=251>已出现在<〖跨服·世界BOSS〗/FCOLOR=253>地图，击杀必爆超级装备！"
            Sendmsg1("0",255,249,"【系统】：全服活动→世界BOSS，【终极大魔王】已出现在【跨服·世界BOSS】地图，击杀必爆超级装备！",2)
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "activity_state", "G_sjbs_activity_state3#".. 1)
                local activity_class =  IncludeMainClass("ActivityCenter")
                if activity_class  then
                    activity_class:ShowActitityStartTip(player,5)
                end
            end
        end
        --行会战场
        if time_str == "23:01:00" then
            SetSysInt("G_hhzc_activity_state3", 1)          -- 行会战场
            KuaFuTrigger.bfbackcall(nil, "行会战场_genmon", "行会战场")
            tips_str = "<【活动提示】∶/FCOLOR=250><行会大魔王/FCOLOR=251>已出现在<〖跨服·行会战场〗/FCOLOR=253>击杀必爆超级装备！"
            Sendmsg1("0",255,249,"【系统】：全服活动→行会战场，【行会大魔王】已出现在【跨服·行会战场】，击杀必爆超级装备！",2)
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "activity_state", "G_hhzc_activity_state3#".. 1)
                local activity_class =  IncludeMainClass("ActivityCenter")
                if activity_class  then
                    activity_class:ShowActitityStartTip(player,6)
                end
            end
        elseif time_str == "23:11:00" then
            KuaFuTrigger.bfbackcall(nil, "跨服行会战场结束", "行会战场")
            SetSysInt("G_hhzc_activity_state3", 2)          -- 行会战场 关门
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "activity_state", "G_hhzc_activity_state3#".. 2)
            end 
            tips_str = "<【活动提示】∶/FCOLOR=250><跨服·行会战场/FCOLOR=251>入口<〖已经关闭〗/FCOLOR=253>各行会尽快清理敌人！"
        end
        --乱斗之王
        if time_str == "19:10:00" then
            SetSysInt("G_ldzw_activity_state3", 1)   
            KuaFuTrigger.bfbackcall(nil, "乱斗之王_genmon", "乱斗之王")    
            tips_str = "<【活动提示】∶/FCOLOR=250><暗黑帝王/FCOLOR=251>已出现在<〖跨服·乱斗之王〗/FCOLOR=253>勇士们快去击杀！"  
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "activity_state", "G_ldzw_activity_state3#".. 1)
                local activity_class =  IncludeMainClass("ActivityCenter")
                if activity_class  then
                    activity_class:ShowActitityStartTip(player,7)
                end
            end 
        end
        if time_str == "19:20:00" then
            SetSysInt("G_ldzw_activity_state3", 2)          -- 乱斗之王 关门
            KuaFuTrigger.bfbackcall(nil, "乱斗之王_结束", "乱斗之王")
            local player_list = getplayerlst(1)
            for i, player in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "activity_state", "G_ldzw_activity_state3#".. 2)
            end
        end 
        if tonumber(is_merge)  ~= 1 and( time_str == "19:00:00" or time_str == "19:10:00" or
            time_str == "19:20:00" or time_str == "19:30:00" or time_str == "19:40:00" or time_str == "19:50:00") and (wDay == 3 or wDay == 6) then
            tips_str = "{【跨服攻沙】∶/FCOLOR=253}今晚{〖20:00〗/FCOLOR=250}进行跨服攻沙，请所有行会提前作好准备！"
        end
        if tonumber(is_merge) ~= 1 and time_str == "20:00:00" and (wDay == 3 or wDay == 6) then --跨服沙城 开始
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
        end
        if tonumber(is_merge) ~= 1 and time_str == "21:00:00" and (wDay == 3 or wDay == 6) then  --跨服沙城 结束
            SetSysInt("G_kfsc_activity_state",2) 
            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "activity_state", "G_kfsc_activity_state#".. 2)
            end 
            KuaFuTrigger.bfbackcall(nil, "跨服沙城_结束", "跨服沙城")
        end
        --结界禁地
        if _run_time % 10800 == 0 then  
            KuaFuTrigger.bfbackcall(nil, "结界禁地_genmon", "结界禁地")
            tips_str = "<【永夜帝王·米尔迦兰】/FCOLOR=254>降临<【结界禁地】/FCOLOR=253>各位勇士速速前往击杀！"
        end

        --藏宝大殿
        if isInTable({"01:30:00","05:30:00","09:30:00","13:30:00","17:30:00","21:30:00"},time_str) then
            KuaFuTrigger.bfbackcall(nil, "跨服boss_刷怪", "藏宝大殿")
            tips_str = "<【跨服BOSS】∶/FCOLOR=250><【永夜帝王·米尔迦兰】/FCOLOR=251>已出现在<〖藏宝大殿〗/FCOLOR=253>勇士们快快前往击杀！"
        end
        --藏宝神庙
        if isInTable({"02:30:00","06:30:00","10:30:00","14:30:00","18:30:00","22:30:00"},time_str) then
            KuaFuTrigger.bfbackcall(nil, "跨服boss_刷怪", "藏宝神庙")
            tips_str = "<【跨服BOSS】∶/FCOLOR=250><【永夜帝王·米尔迦兰】/FCOLOR=251>已出现在<〖藏宝神庙〗/FCOLOR=253>勇士们快快前往击杀！"
        end
        --七星宫殿
        if isInTable({"04:00:00","08:00:00","12:00:00","16:00:00","20:00:00","23:59:00"},time_str) then
            KuaFuTrigger.bfbackcall(nil, "跨服boss_刷怪", "七星宫殿")
            tips_str =  "<【跨服BOSS】∶/FCOLOR=250><【跨服boss·铁面骑士】/FCOLOR=251>已出现在<〖七星宫殿〗/FCOLOR=253>勇士们快快前往击杀！"
        end
        --终极之地
        if isInTable({"03:00:00","07:00:00","11:00:00","15:00:00","19:00:00","23:00:00"},time_str) then
            KuaFuTrigger.bfbackcall(nil, "跨服boss_刷怪", "终极之地")
            tips_str =  "<【跨服BOSS】∶/FCOLOR=250><【跨服boss·万奴王】/FCOLOR=251>已出现在<〖终极之地〗/FCOLOR=253>勇士们快快前往击杀！"
        end
        --精绝遗迹
        if isInTable({"02:00:00","06:00:00","10:00:00","14:00:00","18:00:00","22:00:00"},time_str) then
            KuaFuTrigger.bfbackcall(nil, "跨服boss_刷怪", "精绝遗迹")
            tips_str =  "<【跨服BOSS】∶/FCOLOR=250><【跨服boss·魔国鬼母】/FCOLOR=251>已出现在<〖精绝遗迹〗/FCOLOR=253>勇士们快快前往击杀！"
        end
        --魔国圣殿
        if isInTable({"01:00:00","05:00:00","09:00:00","13:00:00","17:00:00","21:00:00"},time_str) then
            KuaFuTrigger.bfbackcall(nil, "跨服boss_刷怪", "魔国圣殿")
            tips_str =  "<【跨服BOSS】∶/FCOLOR=250><【跨服boss·魔国鬼母】/FCOLOR=251>已出现在<〖魔国圣殿〗/FCOLOR=253>勇士们快快前往击杀！"
        end
        if tips_str then
            for i = 1, 3 do
                sendmovemsg("0", 0, 255, 0, 60 + (i - 1 ) * 30, 1, tips_str)
            end
        end
    end
    --天降财宝刷新掉落
    if _run_time == 18*60 or _run_time == 21*60 or _run_time == 63*60 or _run_time == 66*60  then
        for k, v in pairs(GlobalTimer.tjcb_award_list) do
            throwitem("0","天降财宝",25,25,25,k,v,1,false,true,false)
        end
    end

    -- 挖矿
    -- if GetSysInt("G200") <= 0 then
    --     if _run_time > 1 and _run_time < 1800 and GetSysInt("G_mining_state") == 0 then
    --         local npc_class = IncludeNpcClass("MiningDemand")
    --         if npc_class then
    --             npc_class:onOpen("0")
    --         end
    --     elseif _run_time == 1800 and GetSysInt("G_mining_state") == 1 then
    --         local npc_class = IncludeNpcClass("MiningDemand")
    --         if npc_class then
    --             npc_class:onClose("0")
    --         end
    --     end
    -- end

    -- 木之幻境 每3小时刷新一次
    if isInTable({"01:00:00", "04:00:00", "07:00:00", "10:00:00", "13:00:00", "16:00:00", "19:00:00", "22:00:00"}, time_str) then
        local npc_class = IncludeNpcClass("TreeDreamland")
        if npc_class then
            npc_class:onTreeOpen(true)
        end
    end

    -- 王的遗迹每4小时开一次 入口开启
    if isInTable({"09:00:00", "13:00:00", "17:00:00", "21:00:00", "01:00:00", "05:00:00"}, time_str) then
        local npc_class = IncludeNpcClass("KingRemainNpc")
        if npc_class then
            npc_class:onIntervalOpen(true)
        end
    -- 王的遗迹入口关闭
    elseif isInTable({"09:10:00", "13:10:00", "17:10:00", "21:10:00", "01:10:00", "05:10:00"}, time_str) then
        SetSysInt("G_king_open_state", 0)
    end
end

function clearscarecrow_mon()
    globalcleardelaygoto("clearscarecrow_mon", 1)
    SetSysInt("G_scarecrow_gen",0)
    for i,v in ipairs({"钳虫巢穴","死亡神殿","地狱烈焰","深渊魔域","堕落坟场","困惑殿堂","狂暴霸主"}) do
        killmonsters(v, "上古稻草人", 0, true,true)
    end
    gmexecute("0","开始提问","clearscare_send_msg")
end