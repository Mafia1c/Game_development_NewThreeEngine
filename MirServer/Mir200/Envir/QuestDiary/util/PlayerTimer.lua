-- 个人定时器
PlayerTimer = {}
PlayerTimer.kf_func_timer_id = 886
PlayerTimer.other_func_timer_id = 887            -- 杂七杂八
PlayerTimer.recycle_timer_id = 888            -- 回收
PlayerTimer.red_point_timer_id = 900          -- 红点相关
PlayerTimer.check_other_timer_id = 901        --其他检查 玩家在线时长
PlayerTimer.buff_60045_timer_id = 903         --守护回血buff
PlayerTimer.dbqb_timer_id = 904               --夺宝奇兵宝箱倒计时
PlayerTimer.ldzw_timer_id = 905               --乱斗之王进入下一地图倒计时
PlayerTimer.updata_kfsc_timer_id = 906        --跨服沙城
PlayerTimer.kfsc_addmoney_timer_id = 907        --跨服沙城 加货币
PlayerTimer.kf_fun_two_sec_timer_id = 908        --跨服计时器 两秒一次
PlayerTimer.Disguise_timer_id = 909             -- 装扮定时器

PlayerTimer.auto_buy_list = {{"疗伤药",1},{"大还丹",2},{"大补鸡",5},{"雪莲",10}}
PlayerTimer.DisguiseCfg = include("QuestDiary/config/DisguiseCfg.lua")

-- 本服定时器  玩家登录时需要加的定时器都放这个函数里
function PlayerTimer.initPlayerTimer(actor)
    PlayerTimer.addPlayerTimer(actor, PlayerTimer.recycle_timer_id, 3)                -- 回收
    PlayerTimer.addPlayerTimer(actor, PlayerTimer.red_point_timer_id, 1, 0)
    PlayerTimer.addPlayerTimer(actor, PlayerTimer.check_other_timer_id, 2)
    PlayerTimer.addPlayerTimer(actor, PlayerTimer.other_func_timer_id, 10)          -- 道士自动召唤 

    PlayerTimer.addPlayerTimer(actor, PlayerTimer.Disguise_timer_id, 1)
end

-- 跨服定时器
function PlayerTimer.initPlayerKFTimer(actor)
    PlayerTimer.addPlayerTimer(actor, PlayerTimer.kf_func_timer_id, 10) -- 跨服定时器
    PlayerTimer.addPlayerTimer(actor, PlayerTimer.kf_fun_two_sec_timer_id, 2) -- 跨服定时器
    PlayerTimer.addPlayerTimer(actor, PlayerTimer.recycle_timer_id, 3)                -- 回收

    PlayerTimer.addPlayerTimer(actor, PlayerTimer.Disguise_timer_id, 1)
end

-- 添加个人定时器 玩家对象   定时器ID   执行间隔(秒)   执行次数
function PlayerTimer.addPlayerTimer(actor, timer_id, interval, time)
    setontimer(actor, timer_id, interval, time or 0)
end
-- 移除个人定时器
function PlayerTimer.removePlayerTimer(actor, timer_id)
    setofftimer(actor, timer_id)
end
-- 移除个人全部定时器
function PlayerTimer.removeAllTimer(actor)
    for key, v in pairs(PlayerTimer) do
        local timer_id = v
        if type(timer_id) == "number" then
            PlayerTimer.removePlayerTimer(actor, timer_id)
        end
    end
end
-- 跨服定时器
function ontimer886(actor)
    local map_id = getbaseinfo(actor, 3)
    if isInTable({"永夜降临1kf", "永夜降临2kf", "永夜降临3kf"}, map_id) then
        local is_update = false
        local survival_value = VarApi.getPlayerJIntVar(actor, "J_survival_value")
        if map_id == "永夜降临3kf" then
            survival_value = survival_value - 2
            is_update = true
        elseif isInTable({"永夜降临1kf", "永夜降临2kf"}, map_id) then
            survival_value = survival_value - 1
            is_update = true
        end
        if is_update then
            VarApi.setPlayerJIntVar(actor, "J_survival_value", survival_value, nil)
            local npc_class = IncludeMainClass("CrossWorld")
            if npc_class then
                npc_class:YYJLTaskUi(actor)
            end
            if survival_value <= 0 then
                mapmove(actor, 3, 322, 332, 5)
                Sendmsg9(actor, "ff0000", "生存值已耗尽，送你回城！", 1)
            end
        end
    end
    local job = getbaseinfo(actor, 7)
    local open_state = VarApi.getPlayerUIntVar(actor, "U_daoshi_auto_call")
    if open_state == 0 or job ~= 2 then
        return
    end
    local count = getbaseinfo(actor, 38)
    local total_count = 3
    local pet = VarApi.getPlayerTStrVar(actor, "T_disguiseName6")
    if pet == "" then
        total_count = 2
    end
    local yl_skill = getskilllevel(actor,55)
    if yl_skill > 0 then
        total_count = total_count + 1
        if count < total_count then
            releasemagic(actor, 55, 1, 3, 2, 1)
        end
    end
    if hasbuff(actor, 60082) then
        total_count = total_count + 2
    end
    local ss_skill = getskilllevel(actor,30)
    if ss_skill > 0 then
        if count < total_count then
            releasemagic(actor, 30, 1, 3, 2, 1)
        end
    end
end

-- 杂七杂八
function ontimer887(actor)
    local map_id = getbaseinfo(actor, 3)
    if map_id == "天降财宝" then
       return  
    end
    local job = getbaseinfo(actor, 7)
    local open_state = VarApi.getPlayerUIntVar(actor, "U_daoshi_auto_call")
    if open_state == 0 or job ~= 2 then
        return
    end
    local count = getbaseinfo(actor, 38)
    local total_count = 3
    local pet = VarApi.getPlayerTStrVar(actor, "T_disguiseName6")
    if pet == "" then
        total_count = 2
    end
    local yl_skill = getskilllevel(actor, 55)
    if yl_skill > 0 then
        total_count = total_count + 1
        if count < total_count then
            releasemagic(actor, 55, 1, 3, 2, 1)
        end
    end
    if hasbuff(actor, 60082) then
        total_count = total_count + 1
    end

    local ss_skill = getskilllevel(actor,30)
    if ss_skill > 0 then
        if count < total_count then
            releasemagic(actor, 30, 1, 3, 2, 1)
        end
    end
end

-- 回收
local yb_item = {
    ["1万元宝"] = 10000,
    ["10元宝"] = 10,
    ["100元宝"] = 100,
    ["1000元宝"] = 1000,
}

function ontimer888(actor)
    local yb = VarApi.getPlayerUIntVar(actor, "U_auto_use_yb")
    local exp = VarApi.getPlayerUIntVar(actor, "U_auto_use_exp")
    local auto = VarApi.getPlayerUIntVar(actor, "U_auto_recycle")
    -- 自动元宝
    if yb == 1 then
        for name, value in pairs(yb_item) do
            local count = getbagitemcount(actor, name, 0)
            if count and count > 0 then
                if takeitem(actor, name, count, 0, "自动使用元宝道具扣除!") then
                    local money_id = 4
                    ChangeMoney(actor, money_id, "+", value * count, "自动使用元宝道具获得绑定元宝", true)
                end
            end
        end
    end
    -- 自动经验
    if exp == 1 then
        local jy_item = {"1万经验珠","10万经验珠"}
        for index, name in ipairs(jy_item) do
            local count = getbagitemcount(actor, name, 0)
            if count and count > 0 then
                local _const1 = string.format("<$GetDBItemFieldValue(%s,ITEMPAEAM1)>", name)
                local ret1 = getconst(actor, _const1)
                local tab = strsplit(ret1, "#")
                local value = (tonumber(tab[2]) or 0) * count
                if value > 0 and takeitem(actor, name, count, 0, "自动使用经验道具") then
                    changeexp(actor, "+", value, false)
                end
            end
        end
    end
    -- 自动回收
    local npc_class = IncludeNpcClass("RecycleNpc")
    if npc_class and auto == 1 then
        local num = getbagblank(actor)
        if num <= 10 then
            npc_class:onAllRecycle(actor, true)
        end
    end

    for i = 1, 100 do
        local level = getskillinfo(actor, i, 1)
        if level and level == 0 then
            setskillinfo(actor, i, 1, 3)
        end
    end
end

--数据检查
function ontimer900(actor)
    TaskTrigger.onUpdateTask(actor)      -- 更新任务
    -- --魔女
    -- local end_time = VarApi.getPlayerUIntVar(actor,"U_battele_time")
    -- if end_time > 0 and end_time - os.time() <= 0 and  hasbuff(actor,60046) and not getbaseinfo(actor,0)  then
    --     addhpper(actor,"+",30)
    --     VarApi.setPlayerUIntVar(actor,"U_battele_time",0)
    --     sendattackeff(actor,246,0,"*")
    -- end

    if GetSysInt("G_scarecrow_gen") > 0 and not checkkuafu(actor) then
        delbutton(actor, 101, 99999)
        local str = [[
            <Img|id=1|x=320|y=80|img=custom/daocaoren.png|link=@click_scarecrow>
            <Text|text=剩余:%s|x=350|y=175|size=16|color=250>
        ]]
        local num = 0
        if kuafuconnected() then
            num = GetSysInt("G_kf_scarecrow_num")
        else
            for i,v in ipairs({"钳虫巢穴","死亡神殿","地狱烈焰","深渊魔域","堕落坟场","困惑殿堂","狂暴霸主"}) do
               num  = num + getmoncount(v, 2457, true)
            end
        end 
        if num == 0 then
            SetSysInt("G_scarecrow_gen",0)
            delbutton(actor, 101, 99999)
            return
        end
        addbutton(actor, 101, 99999,string.format(str,num))
    else
        delbutton(actor, 101, 99999)
    end
    
end

-- 在线时长
function ontimer901(actor)
    local cur_time = VarApi.getPlayerJIntVar(actor, VarJIntDef.OnLine_TimeStamp)
    cur_time = cur_time + 2
    VarApi.setPlayerJIntVar(actor, VarJIntDef.OnLine_TimeStamp, cur_time, nil)

    if getbaseinfo(actor, 60) then
        local city_time = VarApi.getPlayerJIntVar(actor, "J_city_total_time")
        city_time = city_time + 2
        VarApi.setPlayerJIntVar(actor, "J_city_total_time", city_time, nil)
    end
    
   
    PlayerTimer.FlushTimeBuff(actor)
  
end
function ontimer903(actor)
    -- local max_hp = getbaseinfo(actor,10)
    -- local cur_hp = getbaseinfo(actor,9)
    -- if cur_hp < (max_hp*0.3) then
    --     humanhp(actor,"+",math.floor(cur_hp*0.1) )
    --     sendattackeff(actor,245,0,"*")
    -- end
end
function ontimer904(actor)
    local time = GetTempInt(0,actor,"dbqb_box_time")
    SetTempInt(0,actor,"dbqb_box_time",time + 1)
    if time + 1 >= 120 then
        seticon(actor,8,-1)
        if takeitem(actor,"终极宝箱",1,0) then
            SendMail(actor, 1,"夺宝奇兵奖励" , "<恭喜你成功持有【终极宝箱】达到120秒/FCOLOR=250>\\<以下是【夺宝奇兵奖励】请查收！/FCOLOR=250>", "80级首饰自选宝箱#1#370")
            Sendmsg9(actor, "ffffff", "<font color='#fff000'>【夺宝奇兵奖励】</font>已通过邮件发放，请查收领取!", 1)
            sendmsgnew(actor, 255, 0, string.format("恭喜<[%s]/FCOLOR=253>,成功领取<[夺宝奇兵奖励]/FCOLOR=254>", getbaseinfo(actor,1)), 1, 2)
            SetSysTLInt("J_dbqb_close_flag",1,GetDayTick() + 86400) 
        end
        SetTempInt(0,actor,"dbqb_box_time",0)
        PlayerTimer.removePlayerTimer(actor, PlayerTimer.dbqb_timer_id)
    end
    if getbaseinfo(actor,3) == "夺宝奇兵" then
        sendcentermsg("0",251,0, string.format("%s已持有宝箱%s秒,持有120秒可自动获得奖励！",getbaseinfo(actor,1),time+1),4,1)
    end
end
function ontimer905(actor)
    local map_id = getbaseinfo(actor, 3)
    if not string.find(map_id, "乱斗之王") then
        return
    end
    -- local cur_radius = 2
    local x = getbaseinfo(actor, 4)
    local y = getbaseinfo(actor, 5)
    local center_pos = {{21, 31}, {30, 31}, {26, 36}}
    for index, v in ipairs(center_pos) do
        if x == v[1] and y == v[2] then
            changeexp(actor, "+", 200000, false)
        end
    --     local dx = (x - v[1]) * 48
    --     local dy = (y - v[2]) * 32
    --     local distanceSquared = dx * dx + dy * dy
    --     local tmp_radius = cur_radius * 48 + 12
    --     local in_duquan = distanceSquared <= (tmp_radius * tmp_radius)
    --     if in_duquan then
        -- end
    end
end

function ontimer906(actor)
    local guild_name = GetSysStr("A_kfsc_guild_name") 
    local guishu_str = [[<RText|ax=0.5|x=100|y=55|color=149|size=16|outline=1|text=<归属行会：/FCOLOR=149><%s/FCOLOR=149>>]]
    addbutton(actor,110,902,string.format(guishu_str,guild_name == "" and "暂无行会占领" or guild_name) )
end

function ontimer907(actor)
    local map_id = getbaseinfo(actor,3)
    if map_id == "跨服沙巴克" then
        ChangeMoney(actor,9,"+",1,"跨服沙巴克获得",true)
    elseif map_id == "跨服皇宫" then
        ChangeMoney(actor,9,"+",3,"跨服皇宫获得",true)
    end
end

function ontimer908(actor)
   PlayerTimer.FlushTimeBuff(actor)
end

-- 虚空魂环  每秒对自身1*1范围的怪物造成自身主属性20%真实伤害
function ontimer909(actor)
    local map_id = getbaseinfo(actor, 3)
    local filter_map = {"地下矿洞", "龙虎山", "木之幻境", "巅峰峡谷kf"}
    if hasbuff(actor, 50019) and not isInTable(filter_map, map_id) then
        local x = getbaseinfo(actor, 4)
        local y = getbaseinfo(actor, 5)
        local attr_value = getbaseinfo(actor, 20)
        local job = tonumber(getbaseinfo(actor, 7))
        if job == 1 then
            attr_value = getbaseinfo(actor, 22)
        elseif job == 2 then
            attr_value = getbaseinfo(actor, 24)
        end
        local value = attr_value * 0.2
        rangeharm(actor, x, y, 1, 0, 6, value, 0, 2, 133, 10)
    end
    local cornucopia_class = IncludeMainClass("Cornucopia")
    if cornucopia_class then
        cornucopia_class:SetCornucopiaState(actor,1)
    end
end

function click_scarecrow(actor)
    local str = [[
        <Img|move=0|img=public/bg_npc_01.png|children={bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9}|loadDelay=1|bg=1|reset=1|show=4>
        <Layout|x=545|y=0|width=80|height=80|link=@exit>
        <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <RText|id=bg1|x=25|y=20|size=18|color=255|text=上古稻草人每{1小时/FCOLOR=250}刷新盟重省隐藏地图随机位置\击杀上古稻草人{1/10/FCOLOR=250}的几率掉落{1亿经验珠/FCOLOR=250}\同时狂暴之地刷新一只上古稻草人，必定掉落{1亿经验珠/FCOLOR=250}！>
        <Button|id=bg2|x=80|y=120|nimg=custom/npc/an.png|pimg=custom/npc/an2.png|text=前往|link=@dcr_enter_kbbz>
        <Button|id=bg3|x=350|y=120|nimg=custom/npc/an.png|pimg=custom/npc/an2.png|text=取消|link=@exit>
    ]]
        
    say(actor,str)
end
function PlayerTimer.FlushTimeBuff(actor)
    --无双 战士克星
    if hasbuff(actor,80016) then
        local max_hp = getbaseinfo(actor,10)
        local cur_hp = getbaseinfo(actor,9)
        if cur_hp / max_hp > 0.8 then
            addbuff(actor,60101)
        else
            delbuff(actor, 60101)
        end
    end
    --无双 暗夜行者
    if hasbuff(actor,80025) then
        local timeTable = os.date("*t", os.time())
        if timeTable.hour <= 11 and not hasbuff(actor,60102) then  
            addbuff(actor,60102)
            sendattackeff(actor,325,0,"*")
        elseif timeTable.hour > 11 then
            delbuff(actor,60102)
        end
    end
    --无双 光明使者
    if hasbuff(actor,80035) then
        local timeTable = os.date("*t", os.time())
        if timeTable.hour >=6 and timeTable.hour <= 17 and not hasbuff(actor,60103) then  
            addbuff(actor,60103)
            sendattackeff(actor,335,0,"*")
        elseif not (timeTable.hour >=6 and timeTable.hour <= 17) then
            delbuff(actor,60103)
        end
    end
    --无双 走火入魔
    if hasbuff(actor,80031) then
        if getbaseinfo(actor,51,25) > 100 and not hasbuff(actor,70031)  then
            addbuff(actor,70031)    
            sendattackeff(actor,331,0,"*")
        elseif getbaseinfo(actor,51,25) <= 100 and hasbuff(actor,70031) then
            delbuff(actor,70031)    
        end
    end
      --道士 四象归一
    if hasbuff(actor,60085) then
        local ncount=getbaseinfo(actor,38)
        local count = 0
        for i = 0 ,ncount-1 do
            local _mon = getslavebyindex(actor, i)
            if _mon and  not isInTable(PlayerTimer.DisguiseCfg[6].item_arr,getbaseinfo(_mon,1,1)) then
                count = count + 1
            end
        end
        count = count > 10 and 10 or count
        delbuff(actor, 60104)
        addbuff(actor, 60104,0,1,actor,{[35]=count * 500})
    end
    for i = 1, 4 do
        local buy_num = VarApi.getPlayerUIntVar(actor, "U_auto_buy_num_"..i)
        if VarApi.getPlayerUIntVar(actor, "U_auto_buy_"..i) >= 1 and buy_num > 0  then
            local need_name = PlayerTimer.auto_buy_list[i][1]
            if getbagitemcount(actor,need_name,0) <= 0 then
                local need_num = PlayerTimer.auto_buy_list[i][2]
                if getbindmoney(actor, "元宝") < need_num * buy_num then
                    VarApi.setPlayerUIntVar(actor, "U_auto_buy_"..i,0)
                    VarApi.setPlayerUIntVar(actor, "U_auto_buy_num_"..i,0)
                    Sendmsg9(actor, "ffffff", "元宝不足，停止自动购买", 1) 
                    LoginTrigger.QuickBuy(actor) 
                else
                    if consumebindmoney(actor, "元宝", need_num * buy_num) then
                        GiveItem(actor,need_name,buy_num,0,"自动购买获得")
                    end
                end
            end
        end
    end
end
function dcr_enter_kbbz(actor)
    local class = IncludeSysClass("OtherSysFunc")
    if class then
        class:onOpenMiniMap(actor)
    end
end