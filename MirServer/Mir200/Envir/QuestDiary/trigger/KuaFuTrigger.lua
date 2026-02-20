KuaFuTrigger = {}
KuaFuTrigger.open_kf_update_mon = false
KuaFuTrigger.people_count = KuaFuTrigger.people_count or 0

--#region 跨服成功跨服qf触发
function KuaFuTrigger.kflogin(actor)
    local account_id = getconst(actor, "<$USERACCOUNT>")
    if isInTable(GMWhiteList, account_id) then
        setgmlevel(actor, 10)
    end
    local map_id = getbaseinfo(actor, 3)
    LoginAddStrAttrTrigger.addButton(actor)
    KuaFuTrigger.kfbackcall(actor, "remove_timers", "all")
    KuaFuTrigger.kfbackcall(actor, "var_transfer", "all")           -- 变量传递
    local class = IncludeNpcClass("SkillReinforce")
    if class then
        class:FlushSkillEffect(actor)
    end
    if map_id == "巅峰等待kf" then
        local nation_id = 49
        if KuaFuTrigger.people_count % 2 == 0 then
            nation_id = 52
        end
        local id = VarApi.getPlayerJIntVar(actor, "J_nation_id")
        if id ~= 0 then
            nation_id = id
        end
        JoinNation(actor, nation_id, 7)
        local color = 200 + nation_id
        changenamecolor(actor, color)
        changeattackmode(actor, 7)
        VarApi.setPlayerJIntVar(actor, "J_nation_id", nation_id, nil)
        KuaFuTrigger.people_count = KuaFuTrigger.people_count + 1

        KuaFuTrigger.kfbackcall(actor, "ShowTaskUI_dfxg", nation_id)
    elseif isInTable({"永夜降临1kf", "永夜降临2kf", "永夜降临3kf", "永夜降临4kf"}, map_id) then
        local npc_class = IncludeMainClass("CrossWorld")
        if npc_class then
            npc_class:YYJLTaskUi(actor)
        end
    elseif map_id == "无限战场kf" then
        local npc_class = IncludeMainClass("CrossWorld")
        if npc_class then
            npc_class:WXZCTaskUi(actor)
        end
    end
    delbutton(actor, 101, 99999)
    PlayerTimer.initPlayerKFTimer(actor)        -- 跨服定时器
    LoginTrigger.addBtns(actor)                 -- 进入跨服addbutton

    local positionTab = {0,1,3,4,5,6,7,8,10,11}
    local addInfoTab={"1000","1200","1400","1600","1800","2000","3000","4000","5000","6000","7000","8000","9000","10000","12000"}
    for index, value in ipairs(positionTab) do
        local star = VarApi.getPlayerUIntVar(actor,"U_equipStar"..value)
        setequipaddvalue(actor, value, "=", addInfoTab[star])
    end

    -- 进入跨服图隐藏top按钮
    lualib:CallFuncByClient(actor, "HiedMainTopBtn", "")

    IncludeNpcClass("EquipVariation"):del_equip_variation_up1(actor) --#region 移除变异
    IncludeNpcClass("EquipVariation"):del_equip_variation_side1(actor) --#region 移除变异
    delaygoto(actor, 1000, "delay_reset_hp", 0)
end
-- 进入跨服时新套装属性会重新计算  这里恢复一下人物血量
function delay_reset_hp(actor)
    cleardelaygoto(actor, "delay_reset_hp")
    addhpper(actor, "=", 100)
end

--#region 跨服结束本服qf触发
function KuaFuTrigger.kfend(actor)
    delbutton(actor, 101, 110)
    delbutton(actor, 110, "_123456")
    KuaFuTrigger.bfbackcall(actor, "remove_timers", "移除跨服定时器")
    KuaFuTrigger.bfbackcall(nil, "var_transfer", "all")
    PlayerTimer.initPlayerTimer(actor)
    local class = IncludeNpcClass("SkillReinforce")
    if class then
        class:FlushSkillEffect(actor)
    end
    local activity_class = IncludeMainClass("ActivityCenter")
    if activity_class then
        activity_class:LoginByClient(actor)
    end
    for i,v in ipairs(ActivityVar) do
        lualib:CallFuncByClient(actor, "kf_word_state", v.."#".. GetSysInt(v))
    end 
    lualib:CallFuncByClient(actor, "ShowMainTopBtn", "")
    OtherTrigger.showAddButton(actor)
    IncludeNpcClass("EquipVariation"):del_equip_variation_up1(actor) --#region 移除变异
    IncludeNpcClass("EquipVariation"):del_equip_variation_side1(actor) --#region 移除变异
end
-- 跨服返回本服
function kuafu_back_func(actor)
    showprogressbardlg(actor, 3, "@kf_go_back_func1", "正在退出跨服服务器..", 1, "@kf_go_back_func2")
end
function kf_go_back_func1(actor)
    mapmove(actor, "3", 322, 330, 3)
end
function kf_go_back_func2(actor)
    -- 打断
end


--#region 跨服通知触发本服QF(传递的字符串1(字符串),传递的字符串2(字符串))
function KuaFuTrigger.kfbackcall(actor, key, value)
    local user_id = (actor and actor ~= "0") and getbaseinfo(actor, 2) or "0"
    kfbackcall(1, user_id, key, value)
end
--跨服通知本服触发  在本服服务器触发
function KuaFuTrigger.kfsyscall1(actor, key, value)
    if key == "巅峰峡谷结算" then
        
    elseif key == "永夜降临领奖" then
        SendMail(actor, 1, "跨服·永夜降临", "恭喜你，在【跨服·永夜降临】活动中胜出！\\活动奖励已发放，请查收！", "荣誉点#3000")
        Sendmsg9(actor, "ffffff", "<font color='#00ff00'>活动奖励已通过邮件发放，请及时提取！</font>", 1)
        local str = string.format("恭喜{【%s】/FCOLOR=254}在活动{【跨服·永夜降临】/FCOLOR=250}中胜出，获得{3000荣誉点/FCOLOR=250}！", value)
        sendmovemsg(actor, 0, 255, 0, 150, 1, str)
    elseif key == "remove_timers" then
        PlayerTimer.removeAllTimer(actor)
    elseif key == "ShowTaskUI_dfxg" then
        KuaFuTrigger.bfbackcall(actor, key, value .. "#"..(GetSysInt("G_dfxg_open_time") + 180 - os.time()))
    elseif key ==  "跨服世界boss结束" then
        SetSysInt("G_sjbs_activity_state3", 3)          -- 世界boss 
        sendmovemsg("0", 0, 0, 0, 30, 1, "<【活动提示】∶/FCOLOR=250><终极大魔王/FCOLOR=251><已被击杀，/FCOLOR=255><【世界BOSS】/FCOLOR=253><活动结束！/FCOLOR=255>")
    elseif key == "行会战场boss结束" then
        sendmovemsg("0", 0, 0, 0, 30, 1, "<【活动提示】∶/FCOLOR=250><跨服·行会大魔王/FCOLOR=251><已被击杀，/FCOLOR=255><入口关闭！/FCOLOR=253>")
        SetSysInt("G_hhzc_activity_state3", 3)          -- 行会战场 
    elseif key == "乱斗之王boss结束" then
        sendmovemsg("0", 0, 0, 0, 30, 1, "<【活动提示】∶/FCOLOR=250><暗黑帝王/FCOLOR=251><已被击杀，/FCOLOR=255><【跨服·乱斗之王】/FCOLOR=253><活动结束！/FCOLOR=255>")
        SetSysInt("G_ldzw_activity_state3", 3)          -- 乱斗之王 
    elseif key == "跨服沙城结束" then
        if  value ~= "" then
            sendmsgnew(0,255,0,string.format("【跨服沙城】：恭喜<【%s】/FCOLOR=253>行会成功占领跨服沙城，胜方奖励已经发放！",value) ,1,2)
        else
            sendmsgnew(0,255,0,"【跨服沙城】结束 <【未有行会】/FCOLOR=253>占领跨服沙城！" ,1,2)
        end
    elseif key == "跨服狂霸霸主结束" then
        sendmovemsg("0", 0, 0, 0, 30, 1, "<【活动提示】∶/FCOLOR=250><狂暴霸主/FCOLOR=251><已被击杀，期待下一次活动尽快开启！/FCOLOR=255>")
        SetSysInt(VarEngine.KuangBaoDieCount, 0)
        SetSysInt("G_kbbz_activity_state2",0)
        local player_list = getplayerlst(1)
        for i, player in ipairs(player_list or {}) do
            lualib:CallFuncByClient(player, "activity_state", "G_kbbz_activity_state2#".. 0)
        end
    elseif key ==  "跨服稻草人清空" then
        gmexecute("0","开始提问","clearscare_send_msg")
        SetSysInt("G_kf_scarecrow_num",0)
        SetSysInt("G_scarecrow_gen",0)
    elseif key ==  "同步跨服稻草人数量" then
        SetSysInt("G_kf_scarecrow_num",value)
    elseif key == "var_transfer" then
        local sys_var = GetSysStr(VarEngine.Var_Key_Value)
        KuaFuTrigger.bfbackcall(actor, "merge_sys_var", sys_var)
    elseif key == "merge_sys_var" then
        VarApi.VarMerge(value)
    end
end

--#region 本服通知触发跨服QF(传递的字符串1(字符串),传递的字符串2(字符串))
function KuaFuTrigger.bfbackcall(actor, key, value)
    local user_id = (actor and actor ~= "0") and getbaseinfo(actor, 2) or "0"
    bfbackcall(99, user_id, key, value)
end
--本服通知跨服触发  在跨服服务器触发
function KuaFuTrigger.bfsyscall99(actor, key, value)
    -- 跨服攻沙
    if key == "Castle" then
        
    elseif key == "巅峰峡谷_genmon" then
        KuaFuTrigger.Open_DFXG()
    elseif key == "巅峰峡谷_map_move" then
        KuaFuTrigger.Close_DFXG()
    elseif key == "永夜降临_genmon" then
        KuaFuTrigger.GenMon_YYJL()
    elseif key == "恶魔广场_genmon" then
        KuaFuTrigger.GenMon_EMGC(value)
    elseif key == "镇魂塔_genmon" then
        local npc_class = IncludeNpcClass("ObeliskNpc")
        if npc_class then
            npc_class:UpdateObeliskBoss()
        end
    elseif key == "ShowTaskUI_dfxg" then
        local tab = strsplit(value, "#")
        local npc_class = IncludeMainClass("CrossWorld")
        if npc_class then
            npc_class:DFXGTaskUi(actor, 1, tonumber(tab[1]), tab[2])
        end
    elseif key == "世界boss_genmon" then
        KuaFuTrigger.Open_KfSJBS()
    elseif key == "行会战场_genmon" then
        KuaFuTrigger.Open_KfHHZC()
    elseif key == "乱斗之王_genmon" then
        KuaFuTrigger.Open_KfLDZW()
    elseif key ==  "跨服沙城_开始" then
        KuaFuTrigger.Open_KfSC()
    elseif key == "跨服沙城_结束" then
        KuaFuTrigger.Close_KfSC()
    elseif key == "乱斗之王_结束" then
        KuaFuTrigger.Close_LDZW()
    elseif key == "恶魔秘境_genmon" then
        local npc_class = IncludeNpcClass("SecretRealmMoveNpc")
        if npc_class then
            npc_class:UpdateMon(true)
        end
    elseif key == "remove_timers" then
        PlayerTimer.removePlayerTimer(actor, PlayerTimer.kf_func_timer_id)
        PlayerTimer.removePlayerTimer(actor, PlayerTimer.kf_fun_two_sec_timer_id)
    elseif key == "跨服狂暴霸主_开始" then
        KuaFuTrigger.Open_Kfkbbz()
    elseif key == "稻草人_genmon" then
        KuaFuTrigger.Open_KfDCR()
    elseif key == "var_transfer" then
        local sys_var = GetSysStr(VarEngine.Var_Key_Value)
        KuaFuTrigger.kfbackcall(nil, "merge_sys_var", sys_var)           -- 变量传递
    elseif key == "merge_sys_var" then
        VarApi.VarMerge(value)
    elseif key == "无限战场_end" then
        KuaFuTrigger.End_WXZC()
    elseif key == "结界禁地_genmon" then
        if getmoncount("封魔结界2",-1,true) <= 0 then
            genmon("封魔结界2", 20, 23, "永夜帝王·米尔迦兰", 0, 1, 249)
        end
    elseif key == "跨服boss_刷怪" then
        KuaFuTrigger.KfBossGenMon(value)
    elseif key == "跨服行会战场结束" then
        KuaFuTrigger.Close_KfHHZC()
    end
    
        
end


-- ========================================================== 跨服地图相关逻辑 ================================================================
-- 巅峰峡谷入口开启
function KuaFuTrigger.Open_DFXG()
    delnation(49)
    delnation(52)
    createnation(49, "红方", 500)
    createnation(52, "蓝方", 500)
    killmapmon("巅峰峡谷kf", 0, 0, 1000, "*", 0, 1)
    -- 红方怪
    genmonex("巅峰峡谷kf", 97, 26, "红方峡谷神龙", 0, 1, 0, 58, "红方峡谷神龙", 0, "红方", 0, 0, 1, 0)
    genmonex("巅峰峡谷kf", 94, 77, "红方峡谷守卫1", 0, 1, 0, 58, "红方峡谷守卫1", 0, "红方", 0, 0, 1, 0)
    genmonex("巅峰峡谷kf", 104, 59, "红方峡谷守卫1", 0, 1, 0, 58, "红方峡谷守卫1", 0, "红方", 0, 0, 1, 0)
    genmonex("巅峰峡谷kf", 72, 23, "红方峡谷守卫2", 0, 1, 0, 58, "红方峡谷守卫2", 0, "红方", 0, 0, 1, 0)
    genmonex("巅峰峡谷kf", 54, 36, "红方峡谷守卫2", 0, 1, 0, 58, "红方峡谷守卫2", 0, "红方", 0, 0, 1, 0)
    -- 蓝方怪
    genmonex("巅峰峡谷kf", 25, 96, "蓝方峡谷神龙", 0, 1, 0, 252, "蓝方峡谷神龙", 0, "蓝方", 0, 0, 1, 0)
    genmonex("巅峰峡谷kf", 36, 54, "蓝方峡谷守卫1", 0, 1, 0, 252, "蓝方峡谷守卫1", 0, "蓝方", 0, 0, 1, 0)
    genmonex("巅峰峡谷kf", 24, 73, "蓝方峡谷守卫1", 0, 1, 0, 252, "蓝方峡谷守卫1", 0, "蓝方", 0, 0, 1, 0)
    genmonex("巅峰峡谷kf", 58, 105, "蓝方峡谷守卫2", 0, 1, 0, 252, "蓝方峡谷守卫2", 0, "蓝方", 0, 0, 1, 0)
    genmonex("巅峰峡谷kf", 77, 94, "蓝方峡谷守卫2", 0, 1, 0, 252, "蓝方峡谷守卫2", 0, "蓝方", 0, 0, 1, 0)
end
-- 巅峰峡谷入口关闭
function KuaFuTrigger.Close_DFXG()
    local player_list = getplaycount("巅峰等待kf", 0, 0)
    for key, role in pairs(type(player_list) == "table" and player_list or {}) do
        local id = GetPlayNation(role)
        if id == 49 then
            mapmove(role, "巅峰峡谷kf", 105, 20, 2)
            KuaFuTrigger.DFXG_TaskUi(role, "红方", 249)
        elseif id == 52 then
            mapmove(role, "巅峰峡谷kf", 19, 109, 2)
            KuaFuTrigger.DFXG_TaskUi(role, "蓝方", 252)
        end
    end
end
-- 巅峰峡谷kf  任务栏UI
function KuaFuTrigger.DFXG_TaskUi(actor, camp, color)
    delbutton(actor, 110, "_654321")
    local btn_str = [[
        <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4}|img=custom/npc/0kf/rwbg1.png>
        <RText|id=bg1|x=100|y=082|a=4|outline=2|color=255|size=18|text=阵营：{%s/FCOLOR=%s}>
        <Button|id=bg4|x=100|y=150|a=4|nimg=custom/npc/0kf/ex.png|link=@_on_exit_dfxg_map,0>
    ]]
    btn_str = string.format(btn_str, camp, color)
    addbutton(actor, 110, "_654321", btn_str)
end
-- 巅峰峡谷 结算
function KuaFuTrigger.DFXG_Settlement(nationID)
    local player_list = getplaycount("巅峰峡谷kf", 0, 0)
    for key, role in pairs(type(player_list) == "table" and player_list or {}) do
        local id = GetPlayNation(role)
        local point = 500
        if nationID == id then
            point = 2000
        end
        ChangeMoney(role, 15, "+", point, "巅峰峡谷结算获得声望!", true)
        senddelaymsg(role, string.format(" 巅峰对抗赛已结束，即将退出巅峰峡谷中，%s后自动退出！", "%s"), 10, 250, 1, "@kf_go_back_func1")
    end
end
-- 退出巅峰峡谷
function _on_exit_dfxg_map(actor, exit_type)
    exit_type = tonumber(exit_type)
    if exit_type == 0 then
        messagebox(actor, "巅峰峡谷活动激烈进行中！！\\你确定要退出峡谷吗？\\退出后将无法获得奖励哦？", "@_on_exit_dfxg_map,1", "@______")
    else
        mapmove(actor, 3, 322, 332, 5)
        JoinNation(actor, 0)
    end
end
-- 无限战场排名
function KuaFuTrigger.WXZC_Rank(actor)
    local ui_str = [[
        <Img|x=270|y=6|bg=1|esc=1|show=0|move=0|children={ms0,ms1,ms2,ms3,ms4,ms5,ms6,ms7,ms8,ms9,ms10,ms11,ms12,ms13}|width=320|height=366|scale9t=10|scale9r=10|scale9l=10|scale9b=10|img=custom/npc/0kf/tips.png>
        <Button|id=ms0|x=319|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Img|id=ms1|x=16|y=020|children={rank1}|img=custom/npc/18hd/no1.png>
        <Img|id=ms2|x=16|y=070|children={rank2}|img=custom/npc/18hd/no2.png>
        <Img|id=ms3|x=16|y=120|children={rank3}|img=custom/npc/18hd/no3.png>

        <RTextX|id=ms4|x=100|y=180|a=4|size=17|outline=1|color=255|text=第１名：<a enableUnderline ='false' href='jump#item_tips#10140'> <u><font color ='#FFFF00'>觉醒嗜杀者</font></u></a>>
        <RTextX|id=ms5|x=100|y=210|a=4|size=17|outline=1|color=255|text=第２名：<a enableUnderline ='false' href='jump#item_tips#10141'> <u><font color ='#FFFF00'>混沌狂暴者</font></u></a>>
        <RTextX|id=ms6|x=100|y=240|a=4|size=17|outline=1|color=255|text=第３名：<a enableUnderline ='false' href='jump#item_tips#10142'> <u><font color ='#FFFF00'>乾坤审判者</font></u></a>>
        <RTextX|id=ms7|x=100|y=270|a=4|size=17|outline=1|color=255|text=参与奖：<a enableUnderline ='false' href='jump#item_tips#10148'> <u><font color ='#FFFF00'>开天大武神</font></u></a>>

        <RText|id=ms9|x=160|y=304|a=4|outline=1|color=249|size=17|text=活动结束，自动邮件发放奖励>
        <RText|id=ms10|x=160|y=334|a=4|outline=1|color=253|size=17|text=你的排名：{%s/FCOLOR=159}>
    ]]
    local rank_list = KuaFuTrigger.WXZC_Settlement(true)
    local my_rank = indexOfTable(rank_list, actor)
    ui_str = string.format(ui_str, my_rank == - 1 and "暂无" or my_rank)
    local rank_str = "<RText|id=%s|x=40|y=17|ay=0.5|outline=1|color=243|size=17|text=%s　{杀戮值：%s/FCOLOR=250}>"
    for index, role in ipairs(rank_list) do
        if role and isnotnull(role) then
            local str = string.format(rank_str, "rank"..index, getbaseinfo(role, 1), VarApi.getPlayerJIntVar(role, "J_killing_value"))
            ui_str = ui_str .. str
        end
    end
    say(actor, ui_str)
end
-- 无限战场活动结束
function KuaFuTrigger.End_WXZC()
    local player_list = getplaycount("无限战场kf", 0, 0)
    for key, role in pairs(type(player_list) == "table" and player_list or {}) do
        delaymsggoto(role, 500, "@kf_go_back_func1")
    end
end
-- 无限战场结算
function KuaFuTrigger.WXZC_Settlement(is_give)
    local role1, role2, role3 = nil, nil, nil
    local first, second, third = 0, 0, 0
    local player_list = getplayerlst(1)
    for i, player  in ipairs(player_list or {}) do
        local num = VarApi.getPlayerJIntVar(player, "J_killing_value")
        num = num or 0
        if num > first then
            third = second
            role3 = role2
            second = first
            role2 = role1
            first = num
            role1 = player
        elseif num > second then
            third = second
            role3 = role2
            second = num
            role2 = player
        elseif num > third then
            third = num
            role3 = player
        end
        if num >= 100 and not is_give then
            -- ChangeMoney(player, 12, "+", 200, "无限战场杀戮值达到100点,奖励200名望值!", true)
            SendMail(player, 1, "无限战场名望奖励", "感谢你参与本次<【跨服·大乱斗】/FCOLOR=250>活动，你在活动中，杀戮值达到100，以下是活动声望奖励，请查收！", "声望#500")
        end
        if num > 0 and not is_give then
            confertitle(player, "开天大武神", 0)
        end
    end
    if not is_give then
        if role1 and isnotnull(role1) then
            deprivetitle(role1, "开天大武神")
            confertitle(role1, "觉醒嗜杀者", 0)
            sendmsgnew(role1, 255, 0, "恭喜: <『"..getbaseinfo(role1, 1).."』/FCOLOR=254>获得<【跨服·大乱斗·第1名/FCOLOR=250>奖励！", 1, 2)
        end
        if role2 and isnotnull(role2) then
            deprivetitle(role2, "开天大武神")
            confertitle(role2, "混沌狂暴者", 0)
            sendmsgnew(role2, 255, 0, "恭喜: <『"..getbaseinfo(role2, 1).."』/FCOLOR=254>获得<【跨服·大乱斗·第2名/FCOLOR=250>奖励！", 1, 2)
        end
        if role3 and isnotnull(role3) then
            deprivetitle(role3, "开天大武神")
            confertitle(role3, "乾坤审判者", 0)
            sendmsgnew(role3, 255, 0, "恭喜: <『"..getbaseinfo(role3, 1).."』/FCOLOR=254>获得<【跨服·大乱斗·第3名/FCOLOR=250>奖励！", 1, 2)
        end
    end
    return {role1, role2, role3}
end
-- 永夜降临刷怪
function KuaFuTrigger.GenMon_YYJL()
    genmonex("永夜降临1kf", 0, 0, "冥界之花", 1000, 300, 0, 250)
    genmonex("永夜降临2kf", 0, 0, "冥界之花", 1000, 350, 0, 250)
    genmonex("永夜降临3kf", 0, 0, "冥界之花", 1000, 400, 0, 250)
    genmonex("永夜降临4kf", 32, 24, "跨服boss·永夜冥王·哈迪斯", 0, 1, 0, 249)

end
-- 恶魔广场刷怪
function KuaFuTrigger.GenMon_EMGC(mon_name)
    genmonex("恶魔广场kf", 40, 40, mon_name, 0, 1, 0, 249)
end
--kf世界boss 刷怪
function KuaFuTrigger.Open_KfSJBS()
    SetSysInt("G_kf_sjbs_moneychange_time", os.time()+ 600)
    if not hasenvirtimer("世界bosskf",88888) then
        setenvirontimer("世界bosskf", 88888, 1, "@sjbs_kf_moneychang")
    end
    killmonsters("世界bosskf","*",0,true,true)
    genmonex("世界bosskf", 53, 52, "终极大魔王", 0, 1, 0, 249)
end
--kf行会战场 刷怪
function KuaFuTrigger.Open_KfHHZC()
    killmonsters("行会战场kf","*",0,true,true)
    genmonex("行会战场kf", 53, 52, "行会大魔王", 0, 1, 0, 249)
    if not hasenvirtimer("行会战场kf",666666) then
        setenvirontimer("行会战场kf", 666666, 1, "@hhzc_kf_moneychang")
    end
end
function KuaFuTrigger.Close_KfHHZC()
    if not hasenvirtimer("行会战场kf",666666) then
        setenvirofftimer("行会战场kf", 666666)
    end
end
function KuaFuTrigger:Open_KfLDZW()
    killmonsters("乱斗之王1kf","*",0,true,true)
    genmonex("乱斗之王1kf", 25, 32, "暗黑帝王", 0, 1, 0, 249)
    mapeffect(518, "乱斗之王1kf", 21, 31, 518, 0, 0, nil, 0)
    mapeffect(519, "乱斗之王1kf", 30, 31, 518, 0, 0, nil, 0)
    mapeffect(520, "乱斗之王1kf", 26, 36, 518, 0, 0, nil, 0)
end
function KuaFuTrigger:Close_LDZW()
    delmapeffect(518)
    delmapeffect(519)
    delmapeffect(520)
    local player_list = getplayerlst(0)
    for i, player  in ipairs(player_list or {}) do
        setofftimer(player,PlayerTimer.ldzw_timer_id)
    end 
end
function KuaFuTrigger:Open_KfSC()
    SetSysInt("G_kfsc_start_time",os.time()+3600)
    SetSysStr("A_kfsc_guild_name","")
    
    if not hastimerex(99533) then
        setontimerex(99533,1)
    end
end
function KuaFuTrigger:Close_KfSC()
    setofftimerex(99533)
    local win_hanghui =  GetSysStr("A_kfsc_guild_name")
    KuaFuTrigger.kfbackcall("0", "跨服沙城结束",win_hanghui)
    local player_list = getplayerlst(1)
    for k, v in pairs(player_list or {}) do
        setofftimer(v,PlayerTimer.kfsc_addmoney_timer_id)
        if checkkuafu(v) and getbaseinfo(v,3) == "跨服沙巴克" or getbaseinfo(v,3) == "跨服皇宫" then
            local guild_name = getbaseinfo(v, 36)
            if win_hanghui ~= ""  then
                if guild_name == win_hanghui then
                    gives(v,"荣誉点#500","跨服沙城胜利方奖励")
                else
                    gives(v,"荣誉点#300","跨服沙城失败方奖励")
                end
            else
                if guild_name and guild_name ~= "" then
                    gives(v,"荣誉点#300","跨服沙城失败方奖励")
                end
            end
            senddelaymsg(v,"跨服攻沙已结束，即将退出跨服中，%s后自动退出！",11,250,1,"@kfsc_end_count_quit")
        end
    end
end
function KuaFuTrigger:Open_Kfkbbz()
    killmonsters("狂暴霸主kf","*",0,true,true)
    genmonex("狂暴霸主kf",28,34,"狂暴霸主",0,1,0,249)
end
function KuaFuTrigger:Open_KfDCR()
    local npc_class = IncludeMainClass("ActivityCenter")
    if npc_class then
        npc_class:RandomGenMon(true)
    end
    local player_list = getplayerlst(1)
    for k, v in pairs(player_list or {}) do
        local map_id = getbaseinfo(v,3)
        if isInTable({"钳虫巢穴kf","死亡神殿kf","地狱烈焰kf", "深渊魔域kf", "堕落坟场kf", "困惑殿堂kf","狂暴霸主kf"},map_id) then
            delbutton(v, 110, "_654321")
            local ui_str = [[
                <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9}|img=custom/npc/rwbg999.png>
                <RText|id=bg1|x=100|y=60|a=4|outline=2|color=243|size=18|text=%s>
                <RText|id=bg3|x=100|y=90|a=4|outline=2|color=243|size=18|text=上古稻草人数量：%s>
                <Button|id=bg2|x=100|y=150|a=4|nimg=custom/npc/18hd//exit.png|clickInterval=1000|link=@delay_go_back>
            ]]
            addbutton(v, 110, "_654321",  string.format(ui_str,getmapname(map_id),1) )
        end
    end
    globaldelaygoto(15 * 60 * 1000, "kf_clearscarecrow_mon")

end
function KuaFuTrigger.KfBossGenMon(map_id)
    killmonsters(map_id,"*",0,true,true)
    if map_id == "藏宝大殿" then
        genmonex(map_id,28,34,"永夜帝王·米尔迦兰",0,1,0,249)
    elseif map_id == "藏宝神庙" then
        genmonex(map_id,32,40,"永夜帝王·米尔迦兰",0,1,0,249)
    elseif map_id == "七星宫殿" then
        genmonex(map_id,26,34,"跨服boss·铁面骑士",0,1,0,249)
    elseif map_id == "终极之地" then
        genmonex(map_id,29,18,"跨服boss·万奴王",0,1,0,249)
    elseif map_id == "精绝遗迹" then
        genmonex(map_id,30,26,"跨服boss·魔国鬼母",0,1,0,249)
    elseif map_id == "魔国圣殿" then
        genmonex(map_id,52,52,"跨服boss·魔国鬼母",0,1,0,249)
    end
end
function kf_clearscarecrow_mon()
    globalcleardelaygoto("kf_clearscarecrow_mon", 1)
    for i,v in ipairs({"钳虫巢穴kf","死亡神殿kf","地狱烈焰kf","深渊魔域kf","堕落坟场kf","困惑殿堂kf","狂暴霸主kf"}) do
        killmonsters(v, "上古稻草人", 0, true,true)
        local players = getplaycount(v,1,1)
        for index, player in ipairs(type(players) == "table" and players or {}) do
            delbutton(player, 110, "_654321")
            local ui_str = [[
                <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9}|img=custom/npc/rwbg999.png>
                <RText|id=bg1|x=100|y=60|a=4|outline=2|color=243|size=18|text=%s>
                <RText|id=bg3|x=100|y=90|a=4|outline=2|color=243|size=18|text=上古稻草人数量：%s>
                <Button|id=bg2|x=100|y=150|a=4|nimg=custom/npc/18hd//exit.png|clickInterval=1000|link=@delay_go_back>
            ]]
            addbutton(player, 110, "_654321",  string.format(ui_str,getmapname(v),0) )
        end
    end
    KuaFuTrigger.kfbackcall("0", "跨服稻草人清空")
end
function kfsc_end_count_quit(actor)
    mapmove(actor,3,322,333,5)
end
function ontimerex99533()
    local players = getplaycount("跨服皇宫",1,1)
    if players == "0" then
        SetSysStr("A_kfsc_guild_name","")
    end
    local capture_guild_name = ""
    local capture = true
    for index, player in ipairs(type(players) == "table" and players or {}) do
        local guild_name = getbaseinfo(player, 36)
        if guild_name ~= "" then
            if capture_guild_name == "" then
                capture_guild_name = guild_name
            end
            if capture_guild_name ~= guild_name  then
                capture = false
                break
            end
        end
    end
    if capture and capture_guild_name ~= "" then
        SetSysStr("A_kfsc_guild_name",capture_guild_name)
    end
end
function sjbs_kf_moneychang()
    if GetSysInt("G_kf_sjbs_moneychange_time") > os.time() then
        local players = getplaycount("世界bosskf",0,1)
        for index, player in ipairs(type(players) == "table" and players or {}) do
            changeexp(player,"+",20000)
        end
    else
        SetSysInt("G_kf_sjbs_moneychange_time",0)
        setenvirofftimer("世界bosskf",88888)
    end
end
function hhzc_kf_moneychang()
    local players = getplaycount("行会战场kf",0,1)
    for index, player in ipairs(type(players) == "table" and players or {}) do
        -- changeexp(player,"+",20000)
        ChangeMoney(player,4,"+",math.random(50,100),"跨服行会战场每秒获得",true)
    end
end
