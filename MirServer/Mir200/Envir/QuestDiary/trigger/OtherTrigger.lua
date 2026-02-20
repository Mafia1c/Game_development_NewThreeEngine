-- 一些杂七杂八的触发 写到这里
OtherTrigger = {}
OtherTrigger.CompoundItemCfg = {}
OtherTrigger.FightPowerCfg = GetConfig("FightPowerCfg")
OtherTrigger.PickUpCfg = GetConfig("PickUpCfg")
OtherTrigger.KF_Maps = {"断魂战场","潘夜神殿1","流放之地1","遗落绝境1","风暴禁地王座","风暴血渊之巅","风暴神庙祭坛","风暴地牢秘境","风暴山谷祭坛","雪原峡谷暗殿","雪原密道圣殿","雪原宫殿王座","雪原古堡魔宫","蛮荒血域幻境","蛮荒荒漠祭坛","蛮荒古城天宫","蛮荒神庙王座","蛮荒暗殿禁地","蛮荒森林深渊",
"镇魂塔1","镇魂塔2","镇魂塔3","镇魂塔4","镇魂塔5","镇魂塔6","镇魂塔7","镇魂塔8","镇魂塔9","镇魂塔10","镇魂塔11","镇魂塔12","镇魂塔13","镇魂塔14","镇魂塔15","镇魂塔16","镇魂塔17","镇魂塔18","上古剑阵","藏宝大殿","藏宝神庙",
"七星宫殿","终极之地","精绝遗迹","魔国圣殿","恶魔广场kf","风暴壁垒kf","龙柩地宫kf","遗忘书冢kf","星璇迷宫kf","毒龙深渊kf","巫祭禁地kf","瘴雾沼泽kf","冰晶回廊kf","遗骸禁区kf", "bossz之家2",
"mj01kf","mj02kf","mj03kf","mj04kf","mj05kf","mj06kf","mj07kf","mj08kf","mj09kf","mj10kf","mj11kf","mj12kf","mj13kf","mj14kf","mj15kf","mj16kf","mj17kf","mj18kf","mj19kf","mj20kf","mj21kf","mj22kf","mj23kf","mj24kf","boss之家2","世界bosskf","行会战场kf",
"乱斗之王1kf","乱斗之王2kf","乱斗之王2kf","乱斗之王4kf","乱斗之王5kf","乱斗之王6kf","乱斗之王7kf","乱斗之王8kf","乱斗之王9kf","乱斗之王10kf","乱斗之王11kf","乱斗之王12kf","乱斗之王13kf","乱斗之王14kf","乱斗之王15kf","乱斗之王16kf","乱斗之王17kf","乱斗之王18kf",
"1kf高爆5","1kf高爆10","1kf高爆20","1kf高爆30","1kf高爆50","1kf高爆100","2kf高爆5","2kf高爆10","2kf高爆20","2kf高爆30","2kf高爆50","2kf高爆100","3kf高爆5","3kf高爆10","3kf高爆20","3kf高爆30","3kf高爆50","3kf高爆100","封魔结界2","生肖神殿kf",}


-- 玩家跳转地图触发 actor.玩家对象  map_id.进入的地图id x.进入的坐标x y.进入的坐标y  leave_map.离开的地图id
function OtherTrigger.onMapChange(actor, map_id, x, y, leave_map)
    local level = getbaseinfo(actor, 6)
    local re_level = getbaseinfo(actor, 39)
    if map_id == "bairi" and level < 80 then
        map(actor, 3)
        Sendmsg9(actor, "ff0000", "地图暂未开放!", 9)
        return
    end

    if map_id == "4" and (re_level < 10 or level < 80) then
        map(actor, 3)
        Sendmsg9(actor, "ff0000", "地图暂未开放!", 9)
        return
    end

    local map_name = getbaseinfo(actor, 45)         -- 地图名字
    local map_cruise = IncludeNpcClass("MapCruise")
    if map_cruise then
        map_cruise:CheckContinueCruise(actor,map_id)
    end 
    -- 镜像图
    if checkmirrormap(map_id) then
        pickupitems(actor, 0, 6, 600)
    else
        -- 记录玩家到过的地图
        OtherTrigger.MarkMaps(actor, map_id)
        -- 拾取小精灵
        OtherTrigger.CheckPickUpItem(actor, map_id)
    end
    if isInTable({"风暴禁地王座","风暴血渊之巅","风暴神庙祭坛","风暴地牢秘境","风暴山谷祭坛","雪原峡谷暗殿","雪原密道圣殿","雪原宫殿王座","雪原古堡魔宫","蛮荒血域幻境","蛮荒荒漠祭坛","蛮荒古城天宫","蛮荒神庙王座","蛮荒暗殿禁地","蛮荒森林深渊"}, map_id) then
        senddelaymsg(actor, string.format("【%s】停留倒计时：%s", map_name, "%s"), 3600, 250, 1, "@delay_go_back")
    end

    if isInTable({"永夜降临1kf", "永夜降临2kf", "永夜降临3kf", "永夜降临4kf"}, map_id) then
        local npc_class = IncludeMainClass("CrossWorld")
        if npc_class then
            npc_class:YYJLTaskUi(actor, map_id)
        end
    end

    -- 跨服地图
    if isInTable(OtherTrigger.KF_Maps, map_id) then
        OtherTrigger.ShowKFTaskUI(actor, map_name)
    end
    if map_id == "九层妖塔10" then
        delbutton(actor, 110, "_654321")
        local ui_str = [[
            <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9}|img=custom/npc/ytrwbg.png>
            <RText|id=bg1|x=100|y=082|a=4|outline=2|color=243|size=18|text=妖塔祭坛·跨服>
            <Button|id=bg2|x=100|y=150|a=4|nimg=custom/npc/18hd//exit.png|clickInterval=1000|link=@delay_go_back>
        ]]
        addbutton(actor, 110, "_654321", ui_str)
    end
    if map_id == "诡异空间一层" or map_id == "诡异空间二层" or map_id == "老板娘的闺房" then 
        delbutton(actor, 110, "_654321")
        local ui_str = [[
            <RText|id=bg1|x=100|y=80|a=4|outline=2|color=243|size=18|text=%s>
            <Button|id=bg2|x=100|y=130|a=4|nimg=custom/npc/18hd//exit.png|clickInterval=1000|link=@delay_go_back>
        ]]
        addbutton(actor, 110, "_654321", string.format(ui_str, getmapname(map_id)) )
    end
    if isInTable({"钳虫巢穴kf","死亡神殿kf","地狱烈焰kf", "深渊魔域kf", "堕落坟场kf", "困惑殿堂kf","狂暴霸主kf"},map_id) then
        delbutton(actor, 110, "_654321")
        local ui_str = [[
            <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9}|img=custom/npc/rwbg999.png>
            <RText|id=bg1|x=100|y=60|a=4|outline=2|color=243|size=18|text=%s>
            <RText|id=bg3|x=100|y=90|a=4|outline=2|color=243|size=18|text=上古稻草人数量：%s>
            <Button|id=bg2|x=100|y=150|a=4|nimg=custom/npc/18hd//exit.png|clickInterval=1000|link=@delay_go_back>
        ]]
        local num = getmoncount(map_id, 2457, true)
        addbutton(actor, 110, "_654321",  string.format(ui_str,getmapname(map_id),num) )
    end
    if map_id ~= leave_map then
        if map_id == "激情派对" then
            local npc_class = IncludeMainClass("ActivityCenter")
            if npc_class then
                npc_class:JQPDTaskUi(actor)
            end 
        end
        if map_id == "武林至尊" then
            setattackmode(actor,0,9999)
        end
        if map_id == "天降财宝" then
            makeposion(actor,5,99999,0,0)
            local ncount=getbaseinfo(actor,38)
            local mon
            for i = 0 ,ncount-1 do
                mon = getslavebyindex(actor, i)
                killmonbyobj(actor,mon,false,false,false)
            end
        end
    end
    if string.find(map_id,"乱斗之王") then
        setontimer(actor,PlayerTimer.ldzw_timer_id,1,0) 
    end
    if map_id == "跨服沙巴克" or map_id == "跨服皇宫" then
        if map_id == "跨服皇宫" and GetSysStr("A_kfsc_guild_name") == "" and getbaseinfo(actor,36) ~= "" then
            SetSysStr("A_kfsc_guild_name",getbaseinfo(actor,36))
        end
        local activity_class = IncludeMainClass("ActivityCenter")
        if activity_class then
            activity_class:KfscTaskUi(actor)
        end
    end
    if map_id == "跨服沙巴克" and leave_map == "跨服沙巴克" then
        if not hastimer(actor,PlayerTimer.updata_kfsc_timer_id) then
            setontimer(actor,PlayerTimer.updata_kfsc_timer_id,1)
        end
        if not hastimer(actor,PlayerTimer.kfsc_addmoney_timer_id) then
            setontimer(actor,PlayerTimer.kfsc_addmoney_timer_id,10)
        end
    end
    if string.find(map_name, "高爆") then
        local rate = string.match(map_name, "%-?%d+%.?%d*")
        local old_rate = getbaseinfo(actor,43)
        setbaseinfo(actor,43,old_rate*rate)
        
        senddelaymsg(actor, "<将在%s后自动退出该地图!/FCOLOR=251>", 1800, 255, 1, "@_high_drop_timer_callback")
    end
    if string.find(map_name, "王的遗迹")  then
        senddelaymsg(actor, "<将在%s后自动退出该地图!/FCOLOR=251>", 1800, 255, 1, "@_high_drop_timer_callback")
    end
    if map_id == "龙虎山" then
        local class = IncludeNpcClass("TowerDefence")
        if class then
            class:FlushDefenceTaskUi(actor)
        end
    end
    if map_id == "魔龙岭" then
        JoinNation(actor, 1)
    end
end
function _high_drop_timer_callback(actor)
    mapmove(actor,3,322,332,5)
end
function OtherTrigger.ShowKFTaskUI(actor, param)
    delbutton(actor, 110, "_654321")
    local ui_str = [[
        <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9}|img=custom/npc/rwbg999.png>
        <RText|id=bg1|x=100|y=082|a=4|outline=2|color=249|size=18|text=%s>
        <Button|id=bg2|x=100|y=150|a=4|nimg=custom/npc/18hd//exit.png|clickInterval=1000|link=@delay_go_back>
    ]]
    ui_str = string.format(ui_str, param or "未知")
    addbutton(actor, 110, "_654321", ui_str)
end

function delay_go_back(actor)
    mapmove(actor, 3, 322, 332, 5)
end

-- 离开地图触发
function OtherTrigger.onLeaveMapChange(actor, map_id, x, y, enter_map)
    if map_id ~= enter_map then
        delbutton(actor, 110, "_654321")
        if map_id == "天降财宝"  then
            makeposion(actor,5,0)
        end
        if map_id == "武林至尊" then
           setattackmode(actor,0,1)
        end
        if map_id == "夺宝奇兵" then
            if getbagitemcount(actor,"终极宝箱",0) > 0 then
                takeitem(actor,"终极宝箱",1,0)
                throwitem("0","夺宝奇兵",26,34,0,"终极宝箱",1,3,false,true,false)
                seticon(actor,8,-1)
                PlayerTimer.removePlayerTimer(actor, PlayerTimer.dbqb_timer_id)
                SetTempInt(0,actor,"dbqb_box_time",0)
            end
        end
        if string.find(map_id,"乱斗之王") then
            setofftimer(actor,PlayerTimer.ldzw_timer_id)
        end
        if (map_id == "跨服沙巴克" or map_id == "跨服皇宫") and enter_map ~= "跨服沙巴克" and enter_map ~= "跨服皇宫" then
            delbutton(actor,110,901) 
            delbutton(actor,110,902) 
            setofftimer(actor,PlayerTimer.updata_kfsc_timer_id)
            setofftimer(actor,PlayerTimer.kfsc_addmoney_timer_id)
        end
        local map_name = getmapname(map_id)
        if string.find(map_name, "高爆") then
            local rate = string.match(map_name, "%-?%d+%.?%d*")
            local old_rate = getbaseinfo(actor,43)
            setbaseinfo(actor,43,old_rate/rate)
        end

        if map_id == "地下矿洞" then
            DelItem(actor, {[51147] = 1}, 0, 2, "离开挖矿地图收回鹤嘴锄!")
        end
        if map_id == "魔龙岭" then
            JoinNation(actor, 0)
        end
    end
end

--#region 角色扔掉任意物品前触发(玩家对象，物品唯一id，掉落物品名，行为id【0=扔掉触发】【1=人物掉落触发】，true=允许掉落)
function OtherTrigger.dropitemfrontex(actor,makeIndex,itemName,model)
    SetInt(3, makeIndex, "U_throw_tag", 1)          -- 玩家丢弃加个标记
    return true
end

--#region 人物死亡装备掉落前触发(玩家对象，装备位，装备index，true=允许掉落)
function OtherTrigger.checkdropuseitems(actor,where,itemIndex)
    
    
    return true
end

--#region 角色升级触发(玩家对象，升级后等级)
function OtherTrigger.playlevelup(actor,level)
    
end

-- 记录玩家到过的地图
function OtherTrigger.MarkMaps(actor, map_id)
    local mark_map = VarApi.getPlayerTStrVar(actor, "T_mark_maps")
    if "" == mark_map then
        mark_map = {}
    else
        mark_map = json2tbl(mark_map)
    end
    
    local index = VarApi.getPlayerUIntVar(actor, "U_role_btn_index")
    if not isInTable(mark_map, map_id) then
        mark_map[#mark_map + 1] = map_id
        VarApi.setPlayerTStrVar(actor, "T_mark_maps", tbl2json(mark_map), false)
        local zs_map = {"幽灵船1","火龙洞1","雷炎洞窟1","雪域山谷","诺玛沙漠"}
        local ms_map = {"霸者大厅","牛魔寺庙一层","尸魔洞穴","骨魔石窟","沙影之道一层","未知暗殿","王者禁地","圣域之门","玛雅神殿","炼狱禁地","堕落魔域","琅琊宝阁","幽冥圣地","情缘峡谷","蚂蚁巢穴","真天魔宫"}
        if index < 4 then
            local navigation = nil
            if isInTable(ms_map, map_id) and (index == 1 or index == 3) then                       -- 秘术图
                index = index + 1
                navigation = "delay_navigation_task,202,10004,查看秘术"
            end
            if isInTable(zs_map, map_id) and (index == 1 or index == 2) then                       -- 专属图
                index = index + 2
                navigation = "delay_navigation_task,202,10005,查看专属"
            end
            if navigation then
                VarApi.setPlayerUIntVar(actor, "U_role_btn_index", index, false)
                LoginTrigger.UpdatePlayerBtn(actor, index)
                openhyperlink(actor, 1, 1)
                delaygoto(actor, 300, navigation, 0)
            end
        end
    end

    local temp = VarApi.getPlayerUIntVar(actor,"U_bigMap") --#region 进入大陆标识
    if map_id=="bairi" and temp<2 then
        VarApi.setPlayerUIntVar(actor,"U_bigMap",2,true)
        LoginTrigger.UpdatePlayerBtn(actor)
        TaskTrigger.checkMainTask(actor)
    elseif map_id=="4" and temp<3 then
        VarApi.setPlayerUIntVar(actor,"U_bigMap",3,true)
        LoginTrigger.UpdatePlayerBtn(actor)
    end
end

-- 计算人物战斗力
function OtherTrigger.CountFightPower(actor)
    _count_fight_power(actor)
end
-- 计算人物战斗力
function _count_fight_power(actor)
    if isnotnull(actor) and not IsDummy(actor) then
        local job = getbaseinfo(actor, 7)
        local power = 0
        for key, v in ipairs(OtherTrigger.FightPowerCfg) do
            local num = getbaseinfo(actor, 51, v.attrId)
            if num and type(num) == "number" then
                local value = eval(num .. v[job])
                power = power + value
            end
        end
        VarApi.setPlayerUIntVar(actor, "U100", math.floor(power), false)
    end
end

-- 拾取小精灵
function OtherTrigger.CheckPickUpItem(actor, enter_map)
    local range = 6
    if GetSysInt("G200") > 0 then
        range = 10
    end
    if OtherTrigger.PickUpCfg[enter_map] then
        range = 0
    end
    setpickitemtobag(actor, 107, 1000)
    pickupitems(actor, 0, range, 600)
end

-- 提示消息
function OtherTrigger.TipsMsg(actor, map_name)
    local name = convertName(getbaseinfo(actor, 1))
    local str = string.format("玩家 「%s」 前往: 「%s」 挑战, 祝愿他满载而归!", "<font color = '#00ff00'>"..name .. "</font>", "<font color = '#ffff00'>"..map_name .. "</font>")
    local msg = string.format('{"Msg":"%s","FColor":255,"BColor":249,"Type":1}',str)
    sendmsg(actor, 2, msg)
end

-- 刷怪消息
function OtherTrigger.TipsMsg2(actor, mon_name, map_name)
    local str = string.format("「%s」 降临 「%s」 各位勇士速速前往击杀!", "<font color = '#00ff00'>"..mon_name .. "</font>", "<font color = '#ffff00'>"..map_name .. "</font>")
    local msg = string.format('{"Msg":"%s","FColor":255,"BColor":249,"Type":1}',str)
    sendmsg(actor, 2, msg)
end

-- 字符串属性转buff属性
---comment
---@param actor string         玩家对象
---@param equip_names string   装备道具名称
---@param buff_id number        buffid
function OtherTrigger.AttributeTransformation(actor, equip_names, buff_id)
    delbuff(actor, buff_id)
    local equip = strsplit(equip_names, "|")
    if type(equip) ~= "table" then
        equip = {equip}
    end
    local attr_tab = {}
    for index, name in ipairs(equip) do
        attr_tab[index] = ParserEquipAttr(actor, name)
    end
    local ret = MergeAndSum(unpack(attr_tab, 1))
    addbuff(actor, buff_id, 0, 1, actor, ret)
end

-- 万倍爆率地图
function OtherTrigger.showAddButton(actor)
    delbutton(actor, 101, 9527)
    local time = VarApi.getPlayerJIntVar(actor, "J_wan_rate_map_time")
    local remain_time = time - os.time()
    if remain_time <= 0 then
        return
    end
    local ui_str = [[
        <Img|id=1|children={11}|x=270|y=6|img=custom/top/an100.png|link=@on_click_button>
        <COUNTDOWN|id=11|ax=0.5|x=38|y=69|size=18|count=1|outline=1|showWay=1|time=%s|color=250|link=@on_clean_button>
    ]]
    ui_str = string.format(ui_str, remain_time)
    addbutton(actor, 101, 9527, ui_str)
end
function on_click_button(actor)
    local map_id = getbaseinfo(actor, 3)
    if map_id == "" then
        Sendmsg9(actor, "ffffff", "你已在诡异空间二层!", 1)
        return
    end
    messagebox(actor, "是否进入诡异空间二层?\\免费进入", "@on_enter_map", "@______")
end
function on_enter_map(actor)
    local time = VarApi.getPlayerJIntVar(actor, "J_wan_rate_map_time")
    local remain_time = time - os.time()
    if remain_time <= 0 then
        Sendmsg9(actor, "ff0000", "免费进入时间已过!", 1)
        return
    end
    mapmove(actor, "诡异空间二层", 6, 51, 0)
end

function on_clean_button(actor)
    delbutton(actor, 101, 9527)
end