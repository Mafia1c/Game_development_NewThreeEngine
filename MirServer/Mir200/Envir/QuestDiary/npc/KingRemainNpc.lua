local KingRemainNpc = {}
KingRemainNpc.cfg = GetConfig("KingRemainCfg")
KingRemainNpc.cfg2 = GetConfig("KingRemainCfg2")
KingRemainNpc.say_ui = [[
    <Img|bg=1|loadDelay=0|move=0|img=public/bg_npc_01.png|height=400|reset=1|show=0>
    <Layout|x=545|y=0|width=80|height=80|link=@exit>
    <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
    <Layout|id=100|children={10001,10002,10003}|x=10|y=23.0|width=108|height=29>
    <RText|id=10001|x=22|y=06|outline=1|color=255|size=17|text=五行之力是万物一切的源泉，异世界的能力者掌控神力！>
    <RText|id=10002|x=22|y=36|outline=1|color=255|size=17|text=勇敢的人们啊，选择一种奖励，<击败召唤出的守卫必定爆出/FCOLOR=251>>
    
    <Layout|id=103|children={10015,10016,10017}|x=20.0|y=90|width=108|height=29>
    <Img|id=10015|x=6.0|y=9.0|esc=0|img=public/btn_npcfh_03.png>
    <Text|id=10016|x=28.0|y=6.0|outline=1|color=251|size=18|text=我要经验|link=@on_get_exp,%s>
    <Text|id=10017|x=110.0|y=6.0|outline=1|color=250|size=16|text=→ 击败守卫，最高掉落1亿经验珠>
    
    <Layout|id=104|children={1041,1042,1043}|x=20.0|y=150|width=108|height=29>
    <Img|id=1041|x=6.0|y=9.0|esc=0|img=public/btn_npcfh_03.png>
    <Text|id=1042|x=28.0|y=6.0|outline=1|color=251|size=18|text=我要技能|link=@on_get_skill,%s>
    <Text|id=1043|x=110.0|y=6.0|outline=1|color=250|size=16|text=→ 击败守卫，必定掉落随机一本高级技能>
    
    <Layout|id=105|children={1051,1052,1053}|x=20.0|y=210|width=108|height=29>
    <Img|id=1051|x=6.0|y=9.0|esc=0|img=public/btn_npcfh_03.png>
    <Text|id=1052|x=28.0|y=6.0|outline=1|color=251|size=18|text=我要装备|link=@on_get_equip,%s>
    <Text|id=1053|x=110.0|y=6.0|outline=1|color=250|size=16|text=→ 击败守卫，必定掉落【70级至上古装备】随机一件>
    
    <Layout|id=106|children={1061,1062,1063}|x=20.0|y=270|width=108|height=29>
    <Img|id=1061|x=6.0|y=9.0|esc=0|img=public/btn_npcfh_03.png>
    <Text|id=1062|x=28.0|y=6.0|outline=1|color=251|size=18|text=全部都要|link=@on_get_all,%s>
    <RText|id=1063|x=110.0|y=6.0|outline=1|color=253|size=15|text=→ 小朋友才做选择，我都要。(<[需1万元宝]/FCOLOR=250>50%%几率什么都不爆)>
    
    <Text|x=30|y=340|outline=1|color=250|size=18|text=距离可召唤守卫剩余时间:>
    <COUNTDOWN|a=0|x=240|y=342|time=%s|size=18|showWay=1|color=249>
]]

KingRemainNpc.enter_next_level = [[
    <Layout|id=107|children={1071,1072}|x=400.0|y=335|width=108|height=29>
    <Img|id=1071|x=6.0|y=9.0|esc=0|img=public/btn_npcfh_03.png>
    <Text|id=1072|x=28.0|y=6.0|outline=1|color=251|size=18|text=进入下一层|link=@on_enter_next_level>
]]

function KingRemainNpc:click(actor, npc_id)
    local time = GetSysInt("G_call_guard_time_"..npc_id)
    local remain_time = time - os.time()
    if remain_time <= 0 then
        remain_time = 0
    end
    local ui_str = string.format(self.say_ui, npc_id, npc_id, npc_id, npc_id, remain_time)
    if remain_time > 0 then
        ui_str = ui_str .. self.enter_next_level
    end
    say(actor, ui_str)
end

function KingRemainNpc:onIntervalOpen()
    SetSysInt("G_king_open_state", 1)
    self:onResetKing()
    for i = 1, 3 do
        sendmovemsg("0", 0, 250, 0, 60 + (i - 1 ) * 30, 1, "【王的遗迹】活动已开始, 各位少侠可从【盟重土城】NPC【不灭之王】处进入参与!")
    end
end

-- 重置
function KingRemainNpc:onResetKing(actor)
    local info_data = {
        [1042] = {"王的遗迹1"},
        [1043] = {"王的遗迹2"},
        [1044] = {"王的遗迹3"},
        [1045] = {"王的遗迹4"},
        [1046] = {"王的遗迹5"},
        [1047] = {"王的遗迹6"},
        [1048] = {"王的遗迹7"},
    }
    for npc_id, info in pairs(info_data) do
        SetSysInt("G_call_guard_time_"..npc_id, 0)
        killmonsters(info[1], nil, 0, true, true)
    end
end

-- 召唤怪物
---@param actor string           玩家对象
---@param npc_id number          对应npc
---@param dorp_type number       怪物掉落类型  1.经验    2.技能    3.装备   4.所有
function KingRemainNpc:onCallMon(actor, npc_id, dorp_type)
    npc_id = tonumber(npc_id)
    local mon_list = {
        [1042] = {"王的金之守卫", "王的遗迹1"},
        [1043] = {"王的木之守卫", "王的遗迹2"},
        [1044] = {"王的水之守卫", "王的遗迹3"},
        [1045] = {"王的火之守卫", "王的遗迹4"},
        [1046] = {"王的土之守卫", "王的遗迹5"},
        [1047] = {"王的光之守卫", "王的遗迹6"},
        [1048] = {"不灭之王", "王的遗迹7"},
    }
    if GetSysInt("G200") >= 1 then
        mon_list = {
            [1042] = {"王的金之守卫1", "王的遗迹1"},
            [1043] = {"王的木之守卫1", "王的遗迹2"},
            [1044] = {"王的水之守卫1", "王的遗迹3"},
            [1045] = {"王的火之守卫1", "王的遗迹4"},
            [1046] = {"王的土之守卫1", "王的遗迹5"},
            [1047] = {"王的光之守卫1", "王的遗迹6"},
            [1048] = {"不灭之王1", "王的遗迹7"},
        }
    end
    local mon_info = mon_list[npc_id]
    if nil == mon_info then
        return
    end
    local mon_name = mon_info[1]
    SetSysStr("A_call_mon_name_"..npc_id, mon_name)             -- 当前场景召唤怪物名称
    SetSysInt("G_"..mon_name, dorp_type)                        -- 当前怪物掉落类型
    local mons = genmon(mon_info[2], 0, 0, mon_name, 300, 1, 249)
    if mons and mons[1] then
        sendmsgnew(actor,255,0,"召唤成功: <『"..getbaseinfo(mons[1], 1).."』/FCOLOR=254>已出现在地图<["..mon_info[2] .."]/FCOLOR=251>某个角落，快前往击杀！", 1, 3)
    end
end

-- 更新npc面板
---@param actor string           玩家对象
---@param npc_id string          对应npc
---@param dorp_type number       怪物掉落类型  1.经验    2.技能    3.装备   4.所有
function update_call_say_ui(actor, npc_id, dorp_type)
    close(actor)
    local npc_class = IncludeNpcClass("KingRemainNpc")
    if npc_class then
        -- npc_class:click(actor, npc_id)
        npc_class:onCallMon(actor, npc_id, dorp_type)
    end
end

-- 经验
function on_get_exp(actor, npc_id)
    local cur_time = os.time()
    local time = GetSysInt("G_call_guard_time_"..npc_id)
    if cur_time - time <= 0 then
        Sendmsg9(actor, "ff0000", "当前不可召唤!", 1)
        return
    end
    local update_time = GetSysInt("G199")
    if update_time == 0 then
        local open_day = GetSysInt(VarEngine.OpenDay)
        if open_day > 0 then
            update_time = 7200
        else
            update_time = 3600
        end
    end
    SetSysInt("G_call_guard_time_"..npc_id, cur_time + update_time)
    update_call_say_ui(actor, npc_id, 1)
end
-- 技能
function on_get_skill(actor, npc_id)
    local cur_time = os.time()
    local time = GetSysInt("G_call_guard_time_"..npc_id)
    if cur_time - time <= 0 then
        Sendmsg9(actor, "ff0000", "当前不可召唤!", 1)
        return
    end
    local update_time = GetSysInt("G199")
    if update_time == 0 then
        local open_day = GetSysInt(VarEngine.OpenDay)
        if open_day > 0 then
            update_time = 7200
        else
            update_time = 3600
        end
    end
    SetSysInt("G_call_guard_time_"..npc_id, cur_time + update_time)
    SetSysInt("G_cur_select_dorp_type", 2)
    update_call_say_ui(actor, npc_id, 2)
end
-- 装备
function on_get_equip(actor, npc_id)
    local cur_time = os.time()
    local time = GetSysInt("G_call_guard_time_"..npc_id)
    if cur_time - time <= 0 then
        Sendmsg9(actor, "ff0000", "当前不可召唤!", 1)
        return
    end
    local update_time = GetSysInt("G199")
    if update_time == 0 then
        local open_day = GetSysInt(VarEngine.OpenDay)
        if open_day > 0 then
            update_time = 7200
        else
            update_time = 3600
        end
    end
    SetSysInt("G_call_guard_time_"..npc_id, cur_time + update_time)
    update_call_say_ui(actor, npc_id, 3)
end
-- 全要
function on_get_all(actor, npc_id)
    local cur_time = os.time()
    local time = GetSysInt("G_call_guard_time_"..npc_id)
    if cur_time - time <= 0 then
        Sendmsg9(actor, "ff0000", "当前不可召唤!", 1)
        return
    end
    local money = querymoney(actor, 2)
    if money < 10000 then
        Sendmsg9(actor, "ff0000", "元宝数量不足1万!", 1)
        return
    end
    if not ChangeMoney(actor, 2, "-", 10000, "王的遗迹我全要召唤怪物扣除!", true) then
        Sendmsg9(actor, "ff0000", "元宝扣除失败!", 1)
        return
    end
    local update_time = GetSysInt("G199")
    if update_time == 0 then
        local open_day = GetSysInt(VarEngine.OpenDay)
        if open_day > 0 then
            update_time = 7200
        else
            update_time = 3600
        end
    end
    SetSysInt("G_call_guard_time_"..npc_id, cur_time + update_time)
    update_call_say_ui(actor, npc_id, 4)
end
-- 进入下一层
function on_enter_next_level(actor)
    local level = 0
    local map_id = getbaseinfo(actor, 3)
    local mon_num = getmoncount(map_id, -1, true)
    if mon_num > 0 then
        Sendmsg9(actor, "ff0000", "击杀全部怪物后才可进入下一层!", 1)
        return
    end
    for num in map_id:gmatch("[-+]?%d*%.?%d+") do
        level = tonumber(num) or num
    end
    map_id = "王的遗迹" .. (level + 1)
    if level == 7 then
        mapmove(actor, "3", 322, 330, 3)
    else
        map(actor, map_id)
    end
end
function KingRemainNpc:addKingRemainMondroplist(actor,monObj,monName)
    local map_id = getbaseinfo(actor, 3)
    local level = 0
    for num in map_id:gmatch("[-+]?%d*%.?%d+") do
        level = tonumber(num) or num
    end
    local cfg = self.cfg[level]
    if GetSysInt("G200") >= 1 then
        cfg = self.cfg2[level]
    end
    if cfg == nil then return end
    local drop_type = GetSysInt("G_"..monName)
    local dorp_str = self:GetDropTypeItem(cfg,drop_type)
    if dorp_str then
        additemtodroplist(actor,monObj,dorp_str)
    end
end
function KingRemainNpc:GetDropTypeItem(cfg,drop_type)
    if drop_type == 4 then
        -- 王的遗迹 怪物爆率 变量
        local rate_value = GetSysInt(VarEngine.G_dorp_rate)
        if rate_value == 0 then
            if GetSysInt("G200") >= 1 then
                rate_value = 100
            else
                rate_value = 10
            end
        end
        local dorp_rate = rate_value
        if math.random(100) <= dorp_rate then
            return self:GetDropTypeItem(cfg,1) .. "|" .. self:GetDropTypeItem(cfg,2).."|"..self:GetDropTypeItem(cfg,3)
        end
        return nil
    else
        local drop_str = cfg["drop_type"..drop_type]
        if type(drop_str) == "string" then
           return drop_str
        else
            local value = math.random(1,#drop_str)
            return drop_str[value]
        end
    end
end

return KingRemainNpc