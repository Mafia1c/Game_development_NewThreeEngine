local MiningDemand = {}
MiningDemand.DirOffset = {
	[0] = {x = 0, y = -1},			-- 上
	[1] = {x = 1, y = -1},			-- 右上
	[2] = {x = 1, y = 0},			-- 右
	[3] = {x = 1, y = 1},			-- 右下
	[4] = {x = 0, y = 1},			-- 下
	[5] = {x = -1, y = 1},			-- 左下
	[6] = {x = -1, y = 0},			-- 左
	[7] = {x = -1, y = -1},			-- 左上
}
MiningDemand.boss_pos = {x = 161, y = 29}     -- boss位置
-- 正常的
MiningDemand.update_mon = {
    [1] = "僵尸王·十倍爆率",
    [2] = "僵尸王·百倍爆率",
    [3] = "僵尸王·千倍爆率",
    [4] = "僵尸王·万倍爆率",
    [5] = "僵尸王·十万倍爆率",
}
-- 直播的
MiningDemand.update_mon2 = {
    [1] = "僵尸王·十倍爆率1",
    [2] = "僵尸王·百倍爆率1",
    [3] = "僵尸王·千倍爆率1",
    [4] = "僵尸王·万倍爆率1",
    [5] = "僵尸王·十万倍爆率1",
}
MiningDemand.MiningCfg = GetConfig("MiningCfg")         -- 直播的
MiningDemand.MiningCfg2 = GetConfig("MiningCfg2")       -- 正常的
local npc_say_ui1 = [[
    <Img|bg=1|loadDelay=0|move=0|img=public/bg_npc_01.png|reset=1|show=0>
    <Layout|x=545|y=0|width=80|height=80|link=@exit>
    <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
    <Layout|id=100|children={10001,10002,10003}|x=10|y=23.0|width=108|height=29>
    <Text|id=10001|x=22|y=5|outline=1|color=255|size=17|text=少侠且慢！老夫观你步履生风，目含精光，一身根骨绝非常人>
    <Text|id=10002|x=22|y=30|outline=1|color=250|size=17|text=——乃是百年罕见的练武奇才！>
    <Text|id=10003|x=22|y=55|outline=1|color=255|size=17|text=只是……（捻须沉吟）>
    
    <Layout|id=103|children={10015,10016,10017}|x=390|y=125|width=108|height=29>
    <Img|id=10015|x=6.0|y=9.0|esc=0|img=public/btn_npcfh_03.png>
    <Text|id=10016|x=28.0|y=6.0|outline=1|color=251|size=18|text=领取鹤嘴锄|link=@on_get_hzc_equip>
]]
local npc_say_ui2 = [[
    <Img|bg=1|loadDelay=0|move=0|img=public/bg_npc_01.png|reset=1|show=0>
    <Layout|x=545|y=0|width=80|height=80|link=@exit>
    <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
    <Layout|id=100|children={10001,10002,10003}|x=10|y=23.0|width=108|height=29>
    <RText|id=10001|x=22|y=10|outline=1|color=250|size=17|text=领取成功，罡风已聚于掌中。>
    <RText|id=10002|x=22|y=35|outline=1|color=250|size=17|text=少侠，此去江湖路远，愿神兵与你心血相通，劈波斩浪。>
    <RText|id=10003|x=22|y=60|outline=1|color=250|size=17|text=【踏入风云】>
]]
function MiningDemand:clickNpc(actor)
    local say_ui = npc_say_ui1
    local num = getbagitemcount(actor, "鹤嘴锄", 0)
    if checkitemw(actor, "鹤嘴锄", 1) or num > 0 then
        say_ui = npc_say_ui2
    end
    say(actor, say_ui)
end

function on_get_hzc_equip(actor)
    local get_state = VarApi.getPlayerJIntVar(actor, "J_get_mining_equip")
    if get_state ~= 0 and GetSysInt("G200") == 0 then
        Sendmsg9(actor, "ff0000", "今日[鹤嘴锄]已领取!", 1)
        return
    end
    GiveOnItem(actor, 1, "鹤嘴锄", 1, 370, "领取鹤嘴锄")
    say(actor, npc_say_ui2)
    VarApi.setPlayerJIntVar(actor, "J_get_mining_equip", 1, nil)
end
-- 挖矿地图刷怪
function MiningDemand:MapUpdateMon(actor)
    killmonsters("地下矿洞", nil, 0, true, true)
    globaldelaygoto(500, "delay_update_mon")
end
function delay_update_mon()
    local map_id = "地下矿洞"
    local boss_name = "贞子王"
    if GetSysInt("G200") >= 1 then
        boss_name = "贞子王1"
    end
    genmon(map_id, 161, 29, boss_name, 0, 1, 255)
    globalcleardelaygoto("delay_update_mon", 1)
end

-- 挖矿地图清怪
function MiningDemand:KillMiningMon(actor)
    local mon_tab = getobjectinmap("地下矿洞", self.boss_pos.x, self.boss_pos.y, 100, 2)
    for key, mon in pairs(mon_tab or {}) do
        local name = getbaseinfo(mon, 1, 1) or ""
        if string.find(name, "僵尸") or string.find(name, "矿石") or name == "贞子王" or name == "贞子王1" then
            killmonbyobj(actor, mon, false, false, false)
        end
    end
end

function MiningDemand:onMining(actor, index)
    local wq = GetItemByPos(actor, 1)
    local wq_name = getiteminfo(actor, wq, 7)
    if wq_name ~= "鹤嘴锄" or "0" == wq then
        Sendmsg9(actor, "ff0000", "你未佩戴鹤嘴锄!", 9)
        return
    end
    local times = GetSysInt("G30"..index) + 1
    local run_time = GetSysInt("G_mining_state_run_time")
    local cfg_index = 1
    local first_time = 5
    if GetSysInt("G200") > 0 then
        first_time = 8
    end
    if run_time <= 60 * first_time then
        cfg_index = 1
    elseif run_time <= 60 * (first_time + 5) then
        cfg_index = 2
    elseif run_time <= 60 * (first_time + 5 + 5) then
        cfg_index = 3
    else
        cfg_index = 4
    end
    if times % 5 == 0 then
        self:MonDropInfo(actor, cfg_index)
    end
    SetSysInt("G30"..index, times)
end

function MiningDemand:MonDropInfo(actor, index)
    local v = self.MiningCfg[index]
    if GetSysInt("G200") >= 1 then
        v = self.MiningCfg2[index]
    end
    if nil == v then
        release_print("参数异常: ", index)
        return
    end
    local x = getbaseinfo(actor, 4)
    local y = getbaseinfo(actor, 5)
    local probability = GetSysInt("G411")
    if probability == 0 then
        probability = 70
        SetSysInt("G411", probability)
    end
    local _type = math.random(100)
    if _type > probability then
        local mon_name = self.update_mon[index]
        if GetSysInt("G200") >= 1 then
            mon_name = self.update_mon2[index]
        end
        if mon_name then
            genmon("地下矿洞", x, y, mon_name, v.range, 1, 255)
        end
    else
        local drop_data = {}
        local random = math.random(100)
        if GetSysInt("G200") >= 1 then
            drop_data = v.ceshi_arr
            if random <= 10 then
                drop_data = v.ceshi2_arr
            end
        else
            drop_data = v.drop_arr
            if random <= 10 then
                drop_data = v.drop1_arr
            end
        end
        local tmp_tab = {}
        for key, value in pairs(drop_data) do
            tmp_tab[#tmp_tab + 1] = value
        end
        local reward = tmp_tab[math.random(#tmp_tab)]
        throwitem(actor, "地下矿洞", x, y, v.range, reward, 1, 0, true, false, false, true, 1, false)
    end
end

-- 挖矿活动开始
function MiningDemand:onOpen()
    setenvirontimer("地下矿洞", 111, 1, "@mining_map_schedule")
    SetSysInt("G_mining_state", 1)
    SetSysInt("G_mining_state_run_time", 0)
    self:MapUpdateMon("0")

    for i = 1, 3 do
        sendmovemsg("0", 0, 250, 0, 60 + (i - 1 ) * 30, 1, "【地下矿洞】挖矿活动已开始, 各位少侠可从【盟重土城】307.307进入挖掘!")
    end
end

-- 挖矿活动结束
function MiningDemand:onClose()
    setenvirofftimer("地下矿洞", 111)
    SetSysInt("G_mining_state", 0)
    SetSysInt("G_mining_state_run_time", 0)
    self:KillMiningMon("0")

    for i = 1, 3 do
        sendmovemsg("0", 0, 249, 0, 60 + (i - 1 ) * 30, 1, "【地下矿洞】挖矿活动已结束!")
    end
end

function mining_map_schedule()
    local run_time = GetSysInt("G_mining_state_run_time") + 1
    SetSysInt("G_mining_state_run_time", run_time)

    -- local list = getplaycount("地下矿洞", 0, 1)
    -- for key, actor in pairs(type(list) == "table" and list or {}) do
        
    -- end
end

return MiningDemand