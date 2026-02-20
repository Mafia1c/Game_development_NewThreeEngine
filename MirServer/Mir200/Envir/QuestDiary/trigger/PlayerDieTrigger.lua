PlayerDieTrigger = {}
PlayerDieTrigger.kill_play_effect_cd = {}
PlayerDieTrigger.point_pos_list = {{190,200},{228,244},{191,222},{211,197}}

-- 	actor: 被杀玩家(死者)     killed:凶手或凶手主人 
function PlayerDieTrigger.onPlayDie(actor, killer)
    local map_id = getbaseinfo(actor, 3)
    local name = getbaseinfo(killer, 1)
    local kf_die_str = nil
    if map_id == "巅峰峡谷kf" then
        kf_die_str = [[
            <Img|x=0|y=0|bg=1|show=4|children={di1,di2,di3,di4,di5,di6,di7,di8,di9}|img=custom/die/die.png|link=@none>
            <RText|id=di1|a=4|x=350|y=240|color=255|outline=1|size=20|text=你被[{%s/FCOLOR=251}]无情的击败！>
            <Button|id=di2|x=350|y=290|a=4|nimg=custom/die/btnlj1.png|pimg=custom/die/btnlj2.png|link=@revive_on_the_spot>
            <COUNTDOWN|id=di4|a=4|x=286|y=332|size=18|count=1|outline=1|time=3|color=249|link=@revive_on_the_spot>
            <RText|id=di5|a=4|x=364|y=332|color=249|outline=1|size=18|text=后回复活点复活>
        ]]
    elseif map_id == "无限战场kf" then
        kf_die_str = [[
            <Img|x=0|y=0|bg=1|show=4|children={di1,di2,di3,di4,di5,di6,di7,di8,di9}|img=custom/die/die.png|link=@none>
            <RText|id=di1|a=4|x=350|y=240|color=255|outline=1|size=20|text=你被[{神秘人/FCOLOR=251}]无情的击败！>
            <Button|id=di2|x=350|y=290|a=4|nimg=custom/die/btnyd1.png|pimg=custom/die/btnyd2.png|link=@on_revive>
            <COUNTDOWN|id=di4|a=4|x=286|y=332|size=18|count=1|outline=1|time=3|color=249|link=@on_revive>
            <RText|id=di5|a=4|x=364|y=332|color=249|outline=1|size=18|text=后自动原地复活>
        ]]
        local value = VarApi.getPlayerJIntVar(actor, "J_killing_value") + 1
        VarApi.setPlayerJIntVar(actor, "J_killing_value", value, nil)
        local str = VarApi.getPlayerTStrVar(actor, "T_task_ui_txt")
        if str ~= "" then
            delbutton(actor, 110, "_654321")
            addbutton(actor, 110, "_654321", parsetext(str, actor))
        end
    elseif isInTable({"永夜降临1kf", "永夜降临2kf", "永夜降临3kf", "永夜降临4kf", "恶魔广场kf"}, map_id) then
        kf_die_str = [[
            <Img|x=0|y=0|bg=1|show=4|children={di1,di2,di3,di4,di5,di6,di7,di8,di9}|img=custom/die/die.png|link=@none>
            <RText|id=di1|a=4|x=350|y=240|color=255|outline=1|size=20|text=你被[{%s/FCOLOR=251}]无情的击败！>
            <Button|id=di2|x=350|y=290|a=4|nimg=custom/die/btnhc1.png|pimg=custom/die/btnhc2.png|link=@click_go_back_revive>
            <COUNTDOWN|id=di4|a=4|x=286|y=332|size=18|count=1|outline=1|time=3|color=249|link=@go_back_revive>
            <RText|id=di5|a=4|x=364|y=332|color=249|outline=1|size=18|text=后自动回城复活>
        ]]
    elseif map_id == "激情派对" then
        kf_die_str = [[
            <Img|x=0|y=0|bg=1|show=4|children={di1,di2,di3,di4,di5,di6,di7,di8,di9}|img=custom/die/die.png|link=@none>
            <RText|id=di1|a=4|x=350|y=240|color=255|outline=1|size=20|text=你被[{%s/FCOLOR=251}]无情的击败！>
            <Button|id=di2|x=350|y=290|a=4|nimg=custom/die/btnhc1.png|pimg=custom/die/btnhc2.png|link=@click_go_back_revive>
            <COUNTDOWN|id=di4|a=4|x=286|y=332|size=18|count=1|outline=1|time=9|color=249|link=@go_back_revive>
            <RText|id=di5|a=4|x=364|y=332|color=249|outline=1|size=18|text=后自动回城复活>
        ]]
    elseif map_id == "武林至尊" and GetSysInt("G_wlzz_activity_state") == 1 then
        kf_die_str = [[
            <Img|x=0|y=0|bg=1|show=4|children={di1,di2,di3,di4,di5,di6,di7,di8,di9}|img=custom/die/die.png|link=@none>
            <RText|id=di1|a=4|x=350|y=240|color=255|outline=1|size=20|text=你被[{神秘人/FCOLOR=251}]无情的击败！>
            <Button|id=di2|x=350|y=290|a=4|nimg=custom/die/btnyd1.png|pimg=custom/die/btnyd2.png|link=@on_revive>
            <COUNTDOWN|id=di4|a=4|x=286|y=332|size=18|count=1|outline=1|time=3|color=249|link=@on_revive>
            <RText|id=di5|a=4|x=364|y=332|color=249|outline=1|size=18|text=后自动原地复活>
        ]]
    elseif map_id == "跨服沙巴克" or map_id == "跨服皇宫" then
        kf_die_str = [[
            <Img|x=0|y=0|bg=1|show=4|children={di1,di2,di3,di4,di5,di6,di7,di8,di9}|img=custom/die/die.png|link=@none>
            <RText|id=di1|a=4|x=350|y=240|color=255|outline=1|size=20|text=你被[{%s/FCOLOR=251}]无情的击败！>
            <Button|id=di2|x=145|y=290|a=4|nimg=custom/die/btn1.png|pimg=custom/die/btn2.png|color=249|outline=2|text=回沙大门|link=@kfsc_revive,2>
            <Button|id=di3|x=275|y=290|a=4|nimg=custom/die/btn1.png|pimg=custom/die/btn2.png|color=251|outline=2|text=回武器店|link=@kfsc_revive,3>
            <Button|id=di4|x=405|y=290|a=4|nimg=custom/die/btn1.png|pimg=custom/die/btn2.png|color=251|outline=2|text=回衣服店|link=@kfsc_revive,4>
            <Button|id=di5|x=535|y=290|a=4|nimg=custom/die/btn1.png|pimg=custom/die/btn2.png|color=250|outline=2|text=回复活点|link=@kfsc_revive,1>
            <COUNTDOWN|id=di6|a=4|x=294|y=332|size=18|count=1|outline=1|time=5|color=159|link=@kfsc_revive,2>
            <RText|id=di7|a=4|x=354|y=332|color=159|outline=1|size=18|text=后回沙大门>
        ]]
    end
    if kf_die_str then
        kf_die_str =  string.format(kf_die_str, name)
        say(actor, kf_die_str)
        return
    end
    local drop_str = ""
    local drop_item = VarApi.getPlayerTStrVar(actor, "T_drop_items")
    if drop_item == "" then
        drop_str = "无"
    else
        for key, item in pairs(json2tbl(drop_item)) do
            drop_str = item .. "," .. drop_str
        end
    end    
    local is_player = false
    local str = "尊敬的玩家:\\您被%s<%s/FCOLOR=249>于<%s/FCOLOR=149>在<[%s]/FCOLOR=149>击败，死亡掉落:<%s/FCOLOR=249>，建议您提升实力后再前往复仇!"
    local tag = "怪物"
    if getbaseinfo(killer, -1) then
        tag = "玩家"
        is_player = true
    end

    local time = GetDate()
    local map_name = getbaseinfo(killer, 45) .. " :" .. getbaseinfo(killer, 4) .. "," .. getbaseinfo(killer, 5)
    str = string.format(str, tag, name, time, map_name, drop_str)
    sendmail(getbaseinfo(actor, 2), 1, "死亡通知", str, "")

    VarApi.setPlayerTStrVar(actor, "T_drop_items", "")

    local die_str = [[
        <Img|x=0|y=0|bg=1|show=4|children={di1,di2,di3,di4,di5,di6,di7,di8,di9}|img=custom/die/die.png|link=@none>
        <RText|id=di1|a=4|x=350|y=240|color=255|outline=1|size=20|text=你被[{%s/FCOLOR=251}]无情的击败！>
        <Button|id=di2|x=340|y=290|a=4|nimg=custom/die/btnhc1.png|pimg=custom/die/btnhc2.png|link=@click_go_back_revive>
        <COUNTDOWN|id=di4|a=4|x=276|y=332|size=18|count=1|outline=1|time=9|color=249|link=@go_back_revive>
        <RText|id=di5|a=4|x=354|y=332|color=249|outline=1|size=18|text=后自动回城复活>
    ]]
    if is_player then
        die_str = [[
            <Img|x=0|y=0|bg=1|show=4|children={di1,di2,di3,di4,di5,di6,di7,di8,di9}|img=custom/die/die.png|link=@none>
            <RText|id=di1|a=4|x=350|y=240|color=255|outline=1|size=20|text=你被[{%s/FCOLOR=251}]无情的击败！>
            <Button|id=di2|x=350|y=290|a=4|nimg=custom/die/btnhc1.png|pimg=custom/die/btnhc2.png|link=@click_go_back_revive>
            <COUNTDOWN|id=di4|a=4|x=286|y=332|size=18|count=1|outline=1|time=9|color=249|link=@go_back_revive>
            <RText|id=di5|a=4|x=364|y=332|color=249|outline=1|size=18|text=后自动回城复活>
        ]]
    end
    local say_str = string.format(die_str, name)
    say(actor, say_str)

    --法师 摄魂
    if hasbuff(killer,60072) then
        addmpper(killer,"+",10)
        addhpper(killer,"+",1)
        playeffect(killer,13421,0,0,1,0,0)
    end

    -- 凶手是玩家
    if is_player then
        local npc_class = IncludeMainClass("BerserkerPower")
        if npc_class then
            npc_class:onPlayerDie(actor, killer)
        end
    end

end

function kfsc_revive(actor,point_index)
    on_revive(actor)
    point_index = tonumber(point_index)
    local pos = PlayerDieTrigger.point_pos_list[point_index]
    mapmove(actor,"跨服沙巴克",pos[1],pos[2],3)
end

function click_go_back_revive(actor)
    delaygoto(actor, 250, "go_back_revive", 1)
end

function go_back_revive(actor)
    delbuff(actor, 50000)
    realive(actor)
    mapmove(actor, "3", 322, 333, 3)
end

function revive_on_the_spot(actor)
    on_revive(actor)
    local nation = GetPlayNation(actor)
    if nation == 49 then
        mapmove(actor, "巅峰峡谷kf", 105, 20, 1)
    else
        mapmove(actor, "巅峰峡谷kf", 19, 109, 1)
    end
end

function on_revive(actor)
    delbuff(actor, 50000)
    realive(actor)
end

-- 玩家死亡触发  actor:凶手或凶手主人   killed: 被杀玩家(死者)
function PlayerDieTrigger.onKillPlay(actor, killed)
    -- 击杀特效
    if getbaseinfo(actor, -1) then
        if nil == PlayerDieTrigger.kill_play_effect_cd[actor] then
            PlayerDieTrigger.kill_play_effect_cd[actor] = GlobalTimer.server_run_time
        end
        if PlayerDieTrigger.kill_play_effect_cd[actor] + 60 < GlobalTimer.server_run_time then
            PlayerDieTrigger.kill_play_effect_cd[actor] = nil
            VarApi.setPlayerUIntVar(actor, "U_kill_play_count", 0, false)
            return
        end
        local kill_count = VarApi.getPlayerUIntVar(actor, "U_kill_play_count")
        kill_count = kill_count + 1
        local effect_id = 14900 + kill_count
        if effect_id > 14908 then
            effect_id = 14908
        end
        playeffect(actor, effect_id, 5, 120, 1, 0, 0)
        VarApi.setPlayerUIntVar(actor, "U_kill_play_count", kill_count, false)
    end

    local map_id = getbaseinfo(actor, 3)
    if map_id == "无限战场kf" then
        local value = VarApi.getPlayerJIntVar(actor, "J_killing_value") + 3
        VarApi.setPlayerJIntVar(actor, "J_killing_value", value, nil)
        local str = VarApi.getPlayerTStrVar(actor, "T_task_ui_txt")
        if str ~= "" then
            delbutton(actor, 110, "_654321")
            addbutton(actor, 110, "_654321", parsetext(str, actor))
        end

    end
    if map_id == "激情派对" then
        local rank_list = json2tbl(GetSysStr("A_jfpd_rank")) 
        if rank_list == "" then
            rank_list = {}
        end
        local userid = getbaseinfo(actor,2)
        if ismob(actor) and GetObjType(actor) == 5 then
            userid = getbaseinfo(actor, 54)
        end
        rank_list[userid] ={obj =actor,value = (rank_list[userid] and rank_list[userid].value or 0) + 10} 

        local killed_userid = getbaseinfo(killed,2)
        rank_list[killed_userid] ={obj =killed,value = (rank_list[killed_userid] and rank_list[killed_userid].value or 0) + 5} 
        SetSysStr("A_jfpd_rank",tbl2json(rank_list))
        local npc_class = IncludeMainClass("ActivityCenter")
        if npc_class then
            npc_class:JQPDTaskUi(actor)
            npc_class:JQPDTaskUi(killed)
        end 
    end
    if getbaseinfo(killed, 3) == "夺宝奇兵" then
        if getbagitemcount(killed,"终极宝箱",0) > 0 then
            takeitem(killed,"终极宝箱",1,0)
            throwitem("0","夺宝奇兵",26,34,0,"终极宝箱",1,3,false,true,false)
        end
        if hastimer(killed,PlayerTimer.dbqb_timer_id) then
            seticon(killed,8,-1)
            PlayerTimer.removePlayerTimer(killed, PlayerTimer.dbqb_timer_id)
            SetTempInt(0,killed,"dbqb_box_time",0)
        end
    end

end