local DailyActive = {}
local _cfg = GetConfig("DailyActiveCfg")
local tmp_cfg = {}
local point_cfg = {}
for index, v in ipairs(_cfg) do
    tmp_cfg[v.type] = tmp_cfg[v.type] or {}
    table.insert(tmp_cfg[v.type], v)
    if v.param then
        point_cfg[v.param] = v
    end
end
DailyActive.cfg = tmp_cfg
DailyActive.PointCfg = point_cfg

function DailyActive:onClickBtn(actor)
    local sMsg = self:GetUiData(actor)
    lualib:ShowNpcUi(actor, "DailyActiveOBJ", sMsg)
end

-- 玛法宝典抽奖
function DailyActive:onOpenJackpotView(actor)
    lualib:CloseNpcUi(actor, "DailyActiveOBJ")
    lualib:ShowNpcUi(actor, "MaFaBaoDianOBJ", "玛法宝典#" .. GetSysStr("A_jackpot_ret"))
end
-- 领取活跃奖励
function DailyActive:onGetReward(actor, index)
    index = tonumber(index)
    local task = self.cfg["达成奖励"]
    local v = task[index]
    if nil == v then
        Sendmsg9(actor, "ff0000", "无效参数", 1)
        return
    end
    local point = self:GetActivePoint(actor)
    if point < v.totalhyd then
        Sendmsg9(actor, "ff0000", "今日活跃度不足, 无法领取!", 1)
        return
    end
    local blank_num = getbagblank(actor)
    if blank_num <= 6 then
        Sendmsg9(actor, "ffffff", "背包剩余空间不足!", 1)
        return
    end
    local get_state = VarApi.getPlayerZStrVar(actor, "Z_active_reward")
    if "" == get_state then
        get_state = {}
    else
        get_state = json2tbl(get_state)
    end
    if isInTable(get_state, index) then
        Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
        return
    end
    get_state[#get_state + 1] = index
    VarApi.setPlayerZStrVar(actor, "Z_active_reward", tbl2json(get_state), nil,true)
    Gives(actor, v.reward_arr[1] .. "#" .. v.reward_arr[2] .. "#370", "领取每日活跃奖励!")
    Sendmsg9(actor, "00ff00", "领取成功, 获得: "..v.reward_arr[1] .. "*" .. v.reward_arr[2], 9)
    local sMsg = self:GetUiData(actor)
    lualib:FlushNpcUi(actor, "DailyActiveOBJ", sMsg)
end

-- 兑换奖励
function DailyActive:onExchangeReward(actor, index)
    index = tonumber(index)
    local task = self.cfg["兑换奖励"]
    local v = task[index]
    if nil == v then
        Sendmsg9(actor, "ff0000", "无效参数", 1)
        return
    end

    local say_ui = [[
        <Img|children={11,22,33,44,55,66,77,88}|img=public/bg_npc_01.png|loadDelay=1|bg=1|reset=1|show=4>
        <Layout|id=11|x=545|y=0|width=80|height=80|link=@exit>
        <Button|id=22|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Text|id=33|x=25|y=20|size=16|color=255|text=每日活跃兑换奖励>
        <RText|id=44|x=25|y=45|color=255|size=16|text=%s>
        <Text|id=55|x=25|y=70|color=251|size=16|text=【盟重令】特权兑换，仅需一半活跃点!>
        <Button|id=66|x=50|y=120|nimg=public/1900000662.png|pimg=public/1900000663.png|text=前往开通|link=@on_open_alliance>
        <Button|id=77|x=210|y=120|nimg=public/1900000662.png|pimg=public/1900000663.png|text=确定|link=@_on_exchange_item,%s>
        <Button|id=88|x=370|y=120|nimg=public/1900000662.png|pimg=public/1900000663.png|text=取消|link=@exit>
    ]]
    local center_str = "你确定要消耗 <[" .. v.needhyd .. "活跃点]/FCOLOR=250> 兑换 [<"..v.reward_arr[1] .."/FCOLOR=250>] 吗？"
    say_ui = string.format(say_ui, center_str, index)
    say(actor, say_ui)
end
function on_open_alliance(actor)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state <= 0 then
        local npc_class = IncludeMainClass("MainTopBtn")
        if npc_class then
            npc_class:AllianceOrder(actor)
        end
    else
        Sendmsg9(actor, "00ff00", "你已开通盟重令特权!", 9)
    end
end
function _on_exchange_item(actor, index)
    index = tonumber(index)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    local class = IncludeMainClass("DailyActive")
    local task = class.cfg["兑换奖励"]
    local v = task[index]
    local total = VarApi.getPlayerUIntVar(actor, "U_total_active_point")
    local need_point = v.needhyd
    local tips_str = "!"
    if mzl_state > 0 then
        need_point = v.needhyd * 0.5
        tips_str = "【盟重令】兑换消耗减半!"
    end
    if total < need_point then
        Sendmsg9(actor, "ff0000", "当前累计活跃点不足"..need_point.."点", 1)
        return
    end
    local blank_num = getbagblank(actor)
    if blank_num <= 6 then
        Sendmsg9(actor, "ffffff", "背包剩余空间不足!", 1)
        return
    end
    total = total - need_point
    VarApi.setPlayerUIntVar(actor, "U_total_active_point", total, false)
    Gives(actor, v.reward_arr[1] .. "#" .. v.reward_arr[2] .. "#370", "领取每日活跃奖励!")
    Sendmsg9(actor, "00ff00", "兑换成功, 获得: "..v.reward_arr[1] .. "*1 " .. tips_str, 9)
    local sMsg = class:GetUiData(actor)
    lualib:FlushNpcUi(actor, "DailyActiveOBJ", sMsg)
    close(actor)
end

function DailyActive:onGoCompleteTask(actor, index)
    local total = VarApi.getPlayerUIntVar(actor, "U_total_active_point")
    index = tonumber(index)
    local task = self.cfg["每日任务"]
    local v = task[index]
    if nil == v then
        Sendmsg9(actor, "ff0000", "无效参数", 1)
        return
    end
    local today_value = VarApi.getPlayerJIntVar(actor, "J_today_point_value")
    local get_state = VarApi.getPlayerJIntVar(actor, "J_daily_active_data")
    local tab = BitMgr.NumToTab(get_state)
    local count = VarApi.getPlayerJIntVar(actor, "J_daily_active_"..v.param)
    if count >= v.count then
        if tab[index] == 0 then
            today_value = today_value + v.rewardhyd * v.count
            total = total + v.rewardhyd * v.count
            Sendmsg9(actor, "00ff00", v.task .. ", 活跃点+" .. v.rewardhyd * v.count, 9)
            VarApi.setPlayerUIntVar(actor, "U_total_active_point", total, false)
            tab[index] = 1
            get_state = BitMgr.TabToNum(tab)
            VarApi.setPlayerJIntVar(actor, "J_daily_active_data", get_state, nil, true)
            VarApi.setPlayerJIntVar(actor, "J_today_point_value", today_value, nil, true)
            local sMsg = self:GetUiData(actor)
            lualib:FlushNpcUi(actor, "DailyActiveOBJ", sMsg)
        else
            Sendmsg9(actor, "00ff00", "活跃奖励已领取!", 9)
        end
        return
    end
    lualib:CloseNpcUi(actor, "DailyActiveOBJ")
    if isInTable({"今日任意击杀绿名怪物", "今日任意击杀粉名怪物", "今日任意击杀红名怪物", "今日任意击杀金名怪物"}, v.task) then       -- 杀怪
        local task_state = VarApi.getPlayerUIntVar(actor, "U_task_step_info")
        local main_task_id = task_state + 1
        if task_state == 21 then
            main_task_id = 1001
        end
        if main_task_id > 1000 and main_task_id < 1037 then
            TaskTrigger.onClickTask(actor, main_task_id)
        end
        Sendmsg9(actor, "00ff00", "前往杀怪获取每日活跃点", 9)
    elseif isInTable({"今日使用【医疗包】", "今日使用【能量饮料】"}, v.task) then                            -- 使用道具
        Sendmsg9(actor, "00ff00", "使用道具获取每日活跃点", 9)
        openhyperlink(actor, 7, 0)
    elseif isInTable({"今日挑战【恶魔秘境】"}, v.task) then                                                                      -- 挑战恶魔秘境
        Sendmsg9(actor, "00ff00", "前往挑战恶魔秘境获取每日活跃点", 9)
        opennpcshowex(actor, 27, 20, 2)
    elseif isInTable({"今日领取周享礼包"}, v.task) then                                                                          -- 今日领取周享礼包
        Sendmsg9(actor, "00ff00", "前往领取今日周享礼包获取每日活跃点", 9)
        local npc_class = IncludeMainClass("MainTopBtn")
        if npc_class then
            npc_class:WelfareToday(actor)
        end
    elseif isInTable({"今日任意充值"}, v.task) then                                                                              -- 今日任意充值
        local npc_class = IncludeMainClass("MainTopBtn")
        if npc_class then
            npc_class:RechargeShopping(actor)
        end
    elseif isInTable({"今日使用100万经验珠", "今日使用1亿经验珠"}, v.task) then                                                                       -- 今日使用经验珠
        lualib:ShowNpcUi(actor, "UseExpItemObj", "")
    end
end

function DailyActive:GetUiData(actor)
    local get_state = VarApi.getPlayerZStrVar(actor, "Z_active_reward")
    local point = self:GetActivePoint(actor)
    local total = VarApi.getPlayerUIntVar(actor, "U_total_active_point")
    local state = VarApi.getPlayerJIntVar(actor, "J_daily_active_data")
    return get_state .. "#" .. point .. "#" .. total .. "#" .. state
end

function DailyActive:GetActivePoint(actor)
    local point_value = VarApi.getPlayerJIntVar(actor, "J_today_point_value")
    return point_value
end

-- 1. 杀怪     2.使用道具    3.挑战恶魔秘境    4.领取周享礼包
function DailyActive:UpdateActivePoint(actor, param)
    local count = VarApi.getPlayerJIntVar(actor, "J_daily_active_"..param) + 1
    local v = self.PointCfg[param]
    if nil == v then
        return
    end
    if count > v.count then
        count = v.count
    end
    VarApi.setPlayerJIntVar(actor, "J_daily_active_"..param, count, nil, true)
end

return DailyActive