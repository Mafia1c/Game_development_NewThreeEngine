KillmonTrigger = {}
KillmonTrigger.MonDropCfg = GetConfig("KFMonDropCfg")

--#region 任意地图杀死怪物触发(攻击者对象，怪物对象，凶手类型[0=宝宝,1=英雄,2=人物,4=全局触发]，击杀者对象(凶手)，怪物名称，当前地图编号)
function KillmonTrigger.onKillMon(actor, monObj, killerType, kill, monName, mapID)
    if isnotnull(actor) then
        --狂战-嗜血_斩魄
        if hasbuff(actor,60054) then
            addhpper(actor,"+",5)
            playeffect(actor,13403,0,0,1,0,0)
        end
        --法师 摄魂
        if hasbuff(actor,60072) then
            addmpper(actor,"+",10)
            addhpper(actor,"+",1)
            playeffect(actor,13421,0,0,1,0,0)
        end
    
        --法师 深渊召唤
        if hasbuff(actor,60075) and math.random(100) <= 1 then
            local cfg_str = getconst(actor,string.format("<$CURRMONPARAM(%s)>",monName))
            if string.find(cfg_str or "","BOSS") then
                recallmob(actor,monName,7,2,0,0,1)
                playeffect(actor,13424,0,0,1,0,0)
            end
        end
       
        --道士 尸爆
        if hasbuff(actor,60094) and math.random(100)<= 1 and not checkkuafu(actor) then
            local cfg_str = getconst(actor,string.format("<$CURRMONPARAM(%s)>",monName))
            if string.find(cfg_str or "","BOSS") then
                local x,y = getbaseinfo(monObj,4),getbaseinfo(monObj,5)
                local mon = genmon(mapID,x,y,monName,0,1)
                playeffect(mon[1],13443,0,0,1,0,0)
                addhpper(mon[1],"=",20)
            end
        end
        KillmonTrigger.KillSecretRealmBoss(actor, monObj, killerType, kill, monName, mapID)
        KillmonTrigger.KillChallengeBoss(actor, monObj, killerType, kill, monName, mapID)
        TaskTrigger.OnKillMon(actor, monObj, killerType, kill, monName, mapID)          -- 任务 => 记录地图杀怪数量

        local class = IncludeNpcClass("MapCruise")
        if class then
            class:CheckCanRandomMap(actor)
        end

        if IncludeNpcClass("GodEquip") then --#region 杀怪打野刀加经验
            IncludeNpcClass("GodEquip"):killMonExpEvent(actor,monObj,killerType)
        end

        if isInTable({"永夜降临1kf", "永夜降临2kf", "永夜降临3kf"}, mapID) and monName == "冥界之花" then
            local exploit_value = VarApi.getPlayerJIntVar(actor, "J_exploit_value") + 1
            VarApi.setPlayerJIntVar(actor, "J_exploit_value", exploit_value, nil)
            local new_map_id = nil
            if exploit_value >= 3 and mapID == "永夜降临1kf" then
                new_map_id = "永夜降临2kf"
            elseif exploit_value >= 10 and mapID == "永夜降临2kf" then
                new_map_id = "永夜降临3kf"
            elseif exploit_value >= 20 and mapID == "永夜降临3kf" then
                new_map_id = "永夜降临4kf"
            end
            if new_map_id then
                map(actor, new_map_id)
            end
            local npc_class = IncludeMainClass("CrossWorld")
            if npc_class then
                npc_class:YYJLTaskUi(actor, new_map_id)
            end
        end
        --#region 大神豪鞭尸
        local isBoss = getdbmonfieldvalue(monName, "type")
        if hasbuff(actor, 50021) and not checkkuafu(actor) and (isBoss and isBoss >= 1) and math.random(100) < 30 then
            monitemsex(actor,monName,1,20)
            sendattackeff(actor,233,0,"*")
            Sendmsg9(actor, "00FF00", "[大神豪]鞭尸:怪物"..monName.."再爆一次！", 1)
        end
        if isInTable({"钳虫巢穴kf","死亡神殿kf","地狱烈焰kf","深渊魔域kf","堕落坟场kf","困惑殿堂kf","狂暴霸主kf"},mapID) and monName == "上古稻草人" then
            local num = 0
            for i,v in ipairs({"钳虫巢穴kf","死亡神殿kf","地狱烈焰kf","深渊魔域kf","堕落坟场kf","困惑殿堂kf","狂暴霸主kf"}) do
                num = num + getmoncount(v, 2457, true)
            end
            KuaFuTrigger.kfbackcall("0", "同步跨服稻草人数量",num)
            delbutton(actor, 110, "_654321")
            local ui_str = [[
                <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9}|img=custom/npc/rwbg999.png>
                <RText|id=bg1|x=100|y=60|a=4|outline=2|color=243|size=18|text=%s>
                <RText|id=bg3|x=100|y=90|a=4|outline=2|color=243|size=18|text=上古稻草人数量：%s>
                <Button|id=bg2|x=100|y=150|a=4|nimg=custom/npc/18hd//exit.png|clickInterval=1000|link=@delay_go_back>
            ]]
            addbutton(actor, 110, "_654321",  string.format(ui_str,getmapname(mapID),getmoncount(mapID, 2457, true)) )
        end
        if isInTable({"王的金之守卫","王的木之守卫","王的水之守卫","王的火之守卫","王的土之守卫","王的光之守卫","不灭之王",
            "王的金之守卫1","王的木之守卫1","王的水之守卫1","王的火之守卫1","王的土之守卫1","王的光之守卫1","不灭之王1"},monName)  then
            local npc_class = IncludeNpcClass("KingRemainNpc")
            if npc_class then
                npc_class:addKingRemainMondroplist(actor, monObj,monName)
            end  
        end
        if mapID == "龙虎山" then
            local npc_class = IncludeNpcClass("TowerDefence")
            if npc_class then
                npc_class:SetMonDrop(actor, monObj,monName)
            end  
    
        end
        if mapID == "魔龙岭" then
            local npc_class = IncludeNpcClass("TowerDefence2")
            if npc_class then
                npc_class:SetMllMonDrop(actor, monObj,monName)
            end  
    
        end
        KillmonTrigger.DropDemonContract(actor,monName,mapID,monObj)
    end

    if mapID == "巅峰峡谷kf" and (monName == "红方峡谷神龙" or monName == "蓝方峡谷神龙") then
        for i = 1, 3 do
            sendmovemsg("0", 0, 255, 0, 60 + (i - 1 ) * 30, 1, string.format("<【跨服对抗赛·巅峰峡谷】∶/FCOLOR=250>{【%s】/FCOLOR=251}已被击杀，对抗赛已分出胜负，恭喜获胜方！", monName))
        end
        KuaFuTrigger.DFXG_Settlement(monName == "红方峡谷神龙" and 52 or 49)
    end

    
    if mapID == "世界boss" and monName == "终极大魔王" then
        sendmovemsg("0", 0, 0, 0, 30, 1, "<【活动提示】∶/FCOLOR=250><终极大魔王/FCOLOR=251><已被击杀，/FCOLOR=255><【世界BOSS】/FCOLOR=253><活动结束！/FCOLOR=255>")
        SetSysTLInt("J_sjbs_close_flag",1,GetDayTick() + 86400) 
    end
    if mapID == "世界bosskf" and monName == "终极大魔王" then
        local player_list = getplayerlst(1)
        for i, player in ipairs(player_list or {}) do
            lualib:CallFuncByClient(player, "activity_state", "G_sjbs_activity_state3#".. 3)
        end
        SetSysInt("G_kf_sjbs_moneychange_time",0)
        setenvirofftimer("世界bosskf",88888)
        KuaFuTrigger.kfbackcall("0", "跨服世界boss结束")
    end
    if mapID == "行会战场" and monName == "行会大魔王" then
        sendmovemsg("0", 0, 0, 0, 30, 1, "<【活动提示】∶/FCOLOR=250><行会大魔王/FCOLOR=251><已被击杀，/FCOLOR=255><入口关闭！/FCOLOR=253>")
        SetSysTLInt("J_hhzc_close_flag",1,GetDayTick() + 86400) 
    end
    
    if mapID == "行会战场kf" and monName == "行会大魔王" then
        local player_list = getplayerlst(1)
        for i, player  in ipairs(player_list or {}) do
            lualib:CallFuncByClient(player, "activity_state", "G_hhzc_activity_state3#".. 3)
        end
        setenvirofftimer("行会战场kf",666666)
        KuaFuTrigger.kfbackcall("0", "行会战场boss结束")
    end
    

    if mapID == "狂暴霸主" and monName == "狂暴霸主" then
        local player_list = getplayerlst(1)
        sendmovemsg("0", 0, 0, 0, 30, 1, "<【活动提示】∶/FCOLOR=250><狂暴霸主/FCOLOR=251><已被击杀，期待下一次活动尽快开启！/FCOLOR=255>")
        if GetSysInt("G_kbbz_activity_state1") ==1 then
            SetSysTLInt("J_kbbz_close_flag",1,GetDayTick() + 86400)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "activity_state", "G_kbbz_activity_state1#".. 0)
            end
        elseif GetSysInt("G_kbbz_activity_state2") == 1 then
            SetSysInt(VarEngine.KuangBaoDieCount, 0)
            SetSysInt("G_kbbz_activity_state2",0)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "activity_state", "G_kbbz_activity_state2#".. 0)
            end
        end
    end
    if mapID == "狂暴霸主kf" and monName == "狂暴霸主" then
        KuaFuTrigger.kfbackcall("0", "跨服狂霸霸主结束")
    end
   
    KillmonTrigger.KillTreeMapBoss(actor, monObj, killerType, kill, monName, mapID)
end
function KillmonTrigger.DropDemonContract(actor,monName,mapID,monObj)
    local str = getconst(actor,string.format("<$CURRMONPARAM(%s)>",monName))
    if string.find(str,"【图鉴】") and math.random(10) <= 1 then
        local list = strsplit(str,"|")
        for i,v in ipairs(list) do
            if string.find(v,"【图鉴】") then
                local x,y = getbaseinfo(monObj,4),getbaseinfo(monObj,5)
                local items = {
                    [v] = 1
                }
                local data = {
                    ["map"] =  mapID, --地图号
                    ["source"] =  5,  --来源：1-GM生成，2-NPC，3-商城，4-NPC商店, 5-怪物掉落，6-系统给["与，7-挖矿，8-批量生成，9-宝箱
                    ["mon"] = monName,  --掉落的怪物
                    ["player"] = getbaseinfo(actor, 1),
                }
                gendropitem(mapID,actor, x, y, tbl2json(items), tbl2json(data), 5, 0)
                break
            end
        end
    end
    -- 跨服怪物掉落
    local cfg = KillmonTrigger.MonDropCfg[monName]
    if cfg and iskuafuserver() then
        local x, y = getbaseinfo(monObj,4),getbaseinfo(monObj,5)
        local items = {
            [cfg.item] = 1
        }
        local data = {
            ["map"] =  mapID, --地图号
            ["source"] =  5,  --来源：1-GM生成，2-NPC，3-商城，4-NPC商店, 5-怪物掉落，6-系统给["与，7-挖矿，8-批量生成，9-宝箱
            ["mon"] = monName,  --掉落的怪物
            ["player"] = getbaseinfo(actor, 1),
        }
        gendropitem(mapID,actor, x, y, tbl2json(items), tbl2json(data))
    end
end
-- 秘境副本击杀boss
function KillmonTrigger.KillSecretRealmBoss(actor, monObj, killerType, kill, monName, mapID)

end

-- 屠魔令击杀boss
function KillmonTrigger.KillChallengeBoss(actor, monObj, killerType, kill, monName, mapID)
    local npc_class = IncludeMainClass("ChallengeBoss")
    if npc_class then
        npc_class:DailyFirstKillBoss(actor, monName, mapID)
    end
end

-- 木之幻境地图杀怪
function KillmonTrigger.KillTreeMapBoss(actor, monObj, killerType, kill, monName, mapID)
    if mapID == "木之幻境" and string.find(monName, "爆不爆谁知道") then
        local npc_class = IncludeNpcClass("TreeDreamland")
        if npc_class then
            npc_class:onKillTreeMapMon(actor, monName)
        end
    end
end