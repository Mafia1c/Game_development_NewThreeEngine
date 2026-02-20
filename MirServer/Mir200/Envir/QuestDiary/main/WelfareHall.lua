local WelfareHall = {}
-- 登录
local _login_cfg = {}
for key, v in ipairs(GetConfig("LoginRewardCfg")) do
    local data = v
    _login_cfg[key] = data
end
WelfareHall.LoginCfg = _login_cfg
-- 每日充值
local _daily_cfg = {}
for index, v in ipairs(GetConfig("DailyRewardCfg")) do
    local data = v
    _daily_cfg[index] = data
end
WelfareHall.DailyGiftCfg = _daily_cfg
WelfareHall.UpLevelCfg = GetConfig("UpLevelRewardCfg")
-- 累充奖励
WelfareHall.RechargeCfg = GetConfig("TotalRechargeCfg")
-- 客服礼包 cdk 兑换
local _cfg_cfg = {}
for index, v in ipairs(GetConfig("ServiceGiftCfg")) do
    local data = v
    data.item_arr = {}
    for key, value in pairs(v.giveitem_map) do
        table.insert(data.item_arr, {key, value})
    end
    _cfg_cfg[index] = data
end
WelfareHall.ServiceGiftCfg = _cfg_cfg

function WelfareHall:onClickBtn(actor, page)
    page = tonumber(page) or 1
    local sMsg = self:getPageUiData(actor, page)
    lualib:ShowNpcUi(actor, "WelfareHallOBJ", sMsg .. "#" .. page)

    if TaskTrigger.CheckTask(actor, 19) then
        if self:CheckTask19(actor) then
            TaskTrigger.CompleteTask(actor, 19)
        else
            lualib:CallFuncByClient(actor, "navigation", "WelfareHallOBJ#get_btn1#点击查看#onGetLoginReward")
        end
    end
end

function WelfareHall:onPageChange(actor, page)
    page = tonumber(page)
    local sMsg = self:getPageUiData(actor, page)
    lualib:FlushNpcUi(actor, "WelfareHallOBJ", page.."#"..sMsg)
end

-- 领取盟重令每日专享
function WelfareHall:onGetTodayGift(actor)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state < 1 then
        Sendmsg9(actor, "ffffff", "你未开通 [盟重令] 无法领取!", 1)
        return
    end
    local get_state = VarApi.getPlayerJIntVar(actor, "J_today_mzl_reward")
    if get_state ~= 0 then
        Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
        return
    end
    local ret_cfg = self.LoginCfg[8]
    if nil == ret_cfg then
        return
    end
    local ret = ret_cfg.giveitem
    VarApi.setPlayerJIntVar(actor, "J_today_mzl_reward", 1, nil,true)
    ShowReward.showReward(actor, ret_cfg.giveitem, 0)
    self:FlushWelfareHallUI(actor, 1)
    Gives(actor, ret, "领取盟重令每日专享奖励")
end
-- 领取登录奖励
function WelfareHall:onGetLoginReward(actor, day)
    day = tonumber(day)
    local login_day = VarApi.getPlayerUIntVar(actor, VarUIntDef.LOGIN_DAY)
    if login_day < day then
        Sendmsg9(actor, "ff0000", "累计登录天数不足!", 1)
        return
    end
    local get_ret = VarApi.getPlayerTStrVar(actor, "T_login_reward_state")
    if "" == get_ret then
        get_ret = {}
    else
        get_ret = json2tbl(get_ret)
    end
    if isInTable(get_ret, day) then
        Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
        return
    end
    get_ret[#get_ret + 1] = day
    VarApi.setPlayerTStrVar(actor, "T_login_reward_state", tbl2json(get_ret), true)
    local ret_cfg = nil
    for key, v in ipairs(self.LoginCfg) do
        if v.day == day then
            ret_cfg = v
            break
        end
    end
    if nil == ret_cfg then
        return
    end
    local ret = ret_cfg.giveitem
    ShowReward.showReward(actor, ret_cfg.giveitem, 0)
    self:FlushWelfareHallUI(actor, 1)
    Gives(actor, ret, string.format("领取累计登录%s天奖励", day))
    TaskTrigger.CompleteTask(actor, 19)
end

-- 累计充值奖励
function WelfareHall:onGetDayRechargeReward(actor, index)
    index = tonumber(index)
    local cfg = self.DailyGiftCfg[index]
    if nil == cfg then
        return
    end
    if cfg.recharge == 0 then
        local state = VarApi.getPlayerJIntVar(actor, "J_today_free_recharge_reward")
        if state > 0 then
            Sendmsg9(actor, "ff0000", "今日已领取!", 1)
            return
        end
        VarApi.setPlayerJIntVar(actor, "J_today_free_recharge_reward", 8, nil, true)
    else
        local consecutiveDays = VarApi.getPlayerUIntVar(actor, "U_consecutive_days")
        if cfg.recharge > consecutiveDays then
            Sendmsg9(actor, "ff0000", "累计充值"..cfg.recharge .. "天即可领取!", 1)
            return
        end
        local get_state = VarApi.getPlayerTStrVar(actor, "T_daily_recharge_reward")
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
        VarApi.setPlayerTStrVar(actor, "T_daily_recharge_reward", tbl2json(get_state), true)
        if index == 7 then
            VarApi.setPlayerUIntVar(actor, "U_last_recharge_day", 0, false)
            VarApi.setPlayerUIntVar(actor, "U_consecutive_days", 0, true)
            VarApi.setPlayerTStrVar(actor, "T_daily_recharge_reward", "", true)
            for i = 1, 3, 1 do
                Sendmsg9(actor, "00ff00", "你已领取累计7天充值奖励, 累计充值计数将从新计算!", 1)
            end
        end
    end
    local ret = cfg.giveitem
    ShowReward.showReward(actor, cfg.giveitem, 0)
    Gives(actor, ret, string.format("领取每日充值%s元奖励", cfg.recharge))
    TaskTrigger.CompleteTask(actor, 19)
    self:FlushWelfareHallUI(actor, 2)
end
-- 升级奖励
function WelfareHall:onGetLevelReward(actor, index)
    index = tonumber(index)
    if nil == index then
        return
    end
    local cfg = self.UpLevelCfg[index]
    if nil == cfg then
        return
    end
    local level = getbaseinfo(actor, 6)
    if level < cfg.level then
        Sendmsg9(actor, "ff0000", string.format("等级不足%s级!", cfg.level), 1)
        return
    end
    local get_level = VarApi.getPlayerUIntVar(actor, "U_uplevel_reward")
    local tab = BitMgr.NumToTab(get_level)
    if tab[index] == 1 then
        Sendmsg9(actor, "ff0000", "调皮, 你已领取该等级奖励!", 1)
        return
    end
    local num = getbagblank(actor)
    if num < 7 then
        Sendmsg9(actor, "ffffff", "背包剩余空间不足", 9)
        return
    end
    tab[index] = 1
    get_level = BitMgr.TabToNum(tab)
    VarApi.setPlayerUIntVar(actor, "U_uplevel_reward", get_level, true)
    local ret = cfg.giveitem
    ShowReward.showReward(actor, cfg.giveitem, 0)
    self:FlushWelfareHallUI(actor, 3)
    Gives(actor, ret, string.format("领取%s级奖励", cfg.level))
end
-- 额外升级奖励
function WelfareHall:onGetAddLevelReward(actor, index)
    index = tonumber(index)
    if nil == index then
        return
    end
    local cfg = self.UpLevelCfg[index]
    if nil == cfg then
        return
    end
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state <= 0 then
        messagebox(actor, "盟重令用户才能领取额外奖励,\\是否现在立即前往开启盟重令", "@on_open_ui_panel", "@______")
        return
    end
    local level = getbaseinfo(actor, 6)
    if level < cfg.level then
        Sendmsg9(actor, "ff0000", string.format("等级不足%s级!", cfg.level), 1)
        return
    end
    local num = getbagblank(actor)
    if num < 6 then
        Sendmsg9(actor, "ffffff", "背包剩余空间不足", 9)
        return
    end
    local get_level = VarApi.getPlayerUIntVar(actor, "U_add_uplevel_reward")
    local tab = BitMgr.NumToTab(get_level)
    if tab[index] == 1 then
        Sendmsg9(actor, "ff0000", "调皮, 你已领取该等级额外奖励!", 1)
        return
    end
    tab[index] = 1
    get_level = BitMgr.TabToNum(tab)
    VarApi.setPlayerUIntVar(actor, "U_add_uplevel_reward", get_level, true)
    local ret = cfg.giveitem1
    ShowReward.showReward(actor, ret, 0)
    self:FlushWelfareHallUI(actor, 3)
    Gives(actor, ret, string.format("额外领取%s级奖励", cfg.level))
end

function on_open_ui_panel(actor)
    local npc_class = IncludeMainClass("MainTopBtn")
    if npc_class then
        npc_class:AllianceOrder(actor)
    end
end

-- 累充奖励
function WelfareHall:onGetRechargeReward(actor, index)
    index = tonumber(index) or 0
    local v = self.RechargeCfg[index]
    if nil == v then
        Sendmsg9(actor, "ff0000", "无效参数!", 1)
        return
    end
    if index == 1 then
        local state = VarApi.getPlayerJIntVar(actor, "J_total_recharge_reward")
        if state == 1 then
            Sendmsg9(actor, "00ff00", "今日累充0元奖励已领取!", 1)
            return
        end
        VarApi.setPlayerJIntVar(actor, "J_total_recharge_reward", 1, nil, true)
        local reward = v.giveitem_arr
        local ret = ""
        for key, value in ipairs(reward) do
            local count = v.itemnum_arr[key]
            ret = value .. "#" .. count .. "#370&" .. ret
        end
        ShowReward.showReward(actor, ret, 0)
        self:FlushWelfareHallUI(actor, 5)
        Gives(actor, ret, string.format("领取累计充值%s元奖励", v.num))
        Sendmsg9(actor, "00ff00", "领取成功!", 9)
        return
    end
    local job = tonumber(getbaseinfo(actor, 7))
    local num = getbagblank(actor)
    if num < 8 then
        Sendmsg9(actor, "ffffff", "背包剩余空间不足", 9)
        return
    end
    local total_recharge = VarApi.getPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE)
    if total_recharge < v.num then
        Sendmsg9(actor, "ff0000", "当前累计充值不足"..v.num.."元", 1)
        return
    end
    local get_state = VarApi.getPlayerUIntVar(actor, "U_total_recharge_reward")
    local tab = BitMgr.NumToTab(get_state)
    if tab[index - 1] == 1 then
        Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
        return
    end
    tab[index - 1] = 1
    get_state = BitMgr.TabToNum(tab)
    VarApi.setPlayerUIntVar(actor, "U_total_recharge_reward", get_state, true)
    local reward = v.giveitem_arr
    if index == 2 then
        if job == 1 then
            reward = v.giveitem1_arr
        elseif job == 2 then
            reward = v.giveitem2_arr
        else
            reward = v.giveitem_arr
        end
    end
    local ret = ""
    for key, value in ipairs(reward) do
        local count = v.itemnum_arr[key]
        ret = value .. "#" .. count .. "#0&" .. ret
    end
    ShowReward.showReward(actor, ret, 0)
    self:FlushWelfareHallUI(actor, 5)
    Gives(actor, ret, string.format("领取累计充值%s元奖励", v.num))
    Sendmsg9(actor, "00ff00", "领取成功!", 9)
end

-- 购买累充奖励
function WelfareHall:onBuyRechargeReward(actor, index)
    index = tonumber(index) or 0
    local v = self.RechargeCfg[index]
    if nil == v or nil == v.ybbuy then
        Sendmsg9(actor, "ff0000", "无效参数!", 1)
        return
    end
    messagebox(actor, "购买累充礼包\\确定消耗 <font color='#00ff00'>["..v.ybbuy.."元宝]</font>购买累计<font color='#00ff00'>"..v.num.."元</font>充值奖励吗?", "@on_buy_recharge_reward,"..index, "@______")
end
function on_buy_recharge_reward(actor, index)
    index = tonumber(index) or 0
    local class = IncludeMainClass("WelfareHall")
    if nil == class then
        return
    end
    local v = class.RechargeCfg[index]

    if nil == v or nil == v.ybbuy then
        Sendmsg9(actor, "ff0000", "无效参数!", 1)
        return
    end
    local num = querymoney(actor, 2)
    if num < v.ybbuy then
        Sendmsg9(actor, "ff0000", "元宝数量不足!", 1)
        return
    end
    local bag_num = getbagblank(actor)
    if bag_num < 8 then
        Sendmsg9(actor, "ffffff", "背包剩余空间不足", 9)
        return
    end
    local get_state = VarApi.getPlayerUIntVar(actor, "U_total_recharge_reward")
    local tab = BitMgr.NumToTab(get_state)
    if tab[index - 1] == 1 then
        Sendmsg9(actor, "ff0000", "请勿重复购买!", 1)
        return
    end
    if not ChangeMoney(actor, 2, "-", v.ybbuy, "购买累充礼包扣除", true) then
        Sendmsg9(actor, "ff0000", "元宝扣除失败!", 1)
        return
    end
    tab[index - 1] = 1
    get_state = BitMgr.TabToNum(tab)
    VarApi.setPlayerUIntVar(actor, "U_total_recharge_reward", get_state, true)
    local ret = ""
    for key, value in ipairs(v.giveitem_arr) do
        local count = v.itemnum_arr[key]
        ret = value .. "#" .. count .. "#0&" .. ret
    end
    ShowReward.showReward(actor, ret, 0)
    class:FlushWelfareHallUI(actor, 5)
    Gives(actor, ret, string.format("消耗元宝购买累计充值%s元奖励", v.num))
    Sendmsg9(actor, "00ff00", "购买成功!", 9)
end

-- 648 一键打包
function WelfareHall:onBuy648Gift(actor)
    if VarApi.getPlayerUIntVar(actor,"U_gift_lcjl")>0 then
        return Sendmsg9(actor, "ff0000", "当前礼包只能购买一次!", 1)
    elseif VarApi.getPlayerUIntVar(actor, "U_688_buy_all_gift")>0 then
        return Sendmsg9(actor, "ff0000", "当前礼包已在落地成神购买!", 1)
    end
    messagebox(actor, "648打包即可获得各个累充奖励\\同时可获得对应充值比例元宝", "@confirm_buy648", "@______")
end
function confirm_buy648(actor)
    WelfareHall:confirm_buy648(actor)
end
function WelfareHall:confirm_buy648(actor)
    if VarApi.getPlayerUIntVar(actor,"U_gift_lcjl")>0 then
        return Sendmsg9(actor, "ff0000", "当前礼包只能购买一次!", 1)
    elseif VarApi.getPlayerUIntVar(actor, "U_688_buy_all_gift")>0 then
        return Sendmsg9(actor, "ff0000", "当前礼包已在落地成神购买!", 1)
    end
    IncludeMainClass("Recharge"):showType(actor,"gift_lcjl",1,"WelfareHallOBJ") --#region 礼包名,次数,前端obj
end

function WelfareHall:onBuy648Success(actor, page)
    VarApi.setPlayerJIntVar(actor, "J_total_recharge_reward", 1, nil, true)
    local tab = {}
    for i = 1, 9, 1 do
        tab[i] = 1
    end
    VarApi.setPlayerUIntVar(actor, "U_total_recharge_reward", BitMgr.TabToNum(tab), true)
    self:FlushWelfareHallUI(actor, page or 5)
end

-- cdk兑换
function WelfareHall:onCDKExchange(actor, index)
    index = tonumber(index) or index
    local cfg = nil
    if index == 1 then
        local free_cdk = VarApi.getPlayerUIntVar(actor, "U_free_cdk_exchange_state")
        if free_cdk ~= 0 then
            Sendmsg9(actor, "ffffff", "请勿重复领取!", 1)
            return
        end
        cfg = self.ServiceGiftCfg[index]
        VarApi.setPlayerUIntVar(actor, "U_free_cdk_exchange_state", 1, true)
    else
        for key, v in ipairs(self.ServiceGiftCfg) do
            if v.cdk == index and v.cdk ~= "直接领取" then
                cfg = v
                break
            end
        end
    end
    if nil == cfg then
        Sendmsg9(actor, "ffffff", "CDK兑换码输入错误!", 1)
        return
    end
    local cdk_exchange_state = VarApi.getPlayerTStrVar(actor, "T_cdk_exchange_state")
    if "" == cdk_exchange_state then
        cdk_exchange_state = {}
    else
        cdk_exchange_state = json2tbl(cdk_exchange_state)
    end
    if isInTable(cdk_exchange_state, index) then
        Sendmsg9(actor, "ffffff", "请勿重复领取!", 1)
        return
    end
    cdk_exchange_state[#cdk_exchange_state + 1] = index
    VarApi.setPlayerTStrVar(actor, "T_cdk_exchange_state", tbl2json(cdk_exchange_state), false)
    local ret = ""
    for key, v in ipairs(cfg.item_arr) do
        ret = v[1] .. "#" .. v[2] .. "#370&" .. ret
    end
    ShowReward.showReward(actor, cfg.item_arr, 0)
    self:FlushWelfareHallUI(actor, 6)
    SendMail(actor, 1, "CDK礼包", "恭喜兑换成功, 礼包奖励已发放至邮箱, 请及时领取!", ret)
    TaskTrigger.CompleteTask(actor, 19)
end
-- 落地成神 688元直购，一键拉满自动获得【首充激活】【快人一步】【盟重令】【七日专享】【累充拉满】
function WelfareHall:onBuy688Gift(actor)
    local state = VarApi.getPlayerUIntVar(actor, "U_688_buy_all_gift")
    if state > 0 then
        Sendmsg9(actor, "ff0000", "你已购买落地成神礼包!", 1)
        return
    end
    IncludeMainClass("Recharge"):showType(actor,"gift_ldcs",1,"WelfareHallOBJ") --#region 礼包名,次数,前端obj
end

-- 购买落地成神礼包成功 (包含648累充拉满)
function WelfareHall:onBuy688Success(actor)
    VarApi.setPlayerUIntVar(actor, "U_688_buy_all_gift", 688, true)
    self:onBuy648Success(actor, 7)
end

function WelfareHall:FlushWelfareHallUI(actor, page)
    local sMsg = self:getPageUiData(actor, page)
    lualib:FlushNpcUi(actor, "WelfareHallOBJ", page .. "#" .. sMsg)
end

-- page:  1.登录奖励    2.每日奖励   3.升级奖励   4.首曝奖励   5.累充奖励   6.客服礼包   7.落地成神
function WelfareHall:getPageUiData(actor, page)
    local sMsg = ""
    local sMsg2 = nil
    if page == 1 then
        sMsg = VarApi.getPlayerJIntVar(actor, "J_today_mzl_reward")
        sMsg2 = VarApi.getPlayerTStrVar(actor, "T_login_reward_state")
    elseif page == 2 then
        sMsg = VarApi.getPlayerUIntVar(actor, "U_consecutive_days")
        sMsg2 = VarApi.getPlayerTStrVar(actor, "T_daily_recharge_reward")
    elseif page == 3 then
        sMsg = VarApi.getPlayerUIntVar(actor, "U_uplevel_reward")
        sMsg2 = VarApi.getPlayerUIntVar(actor, "U_add_uplevel_reward")
    elseif page == 4 then
        sMsg2 = GetSysStr("A_all_server_first_drop")
    elseif page == 5 then
        sMsg = VarApi.getPlayerJIntVar(actor, "J_total_recharge_reward")
        sMsg2 = VarApi.getPlayerUIntVar(actor, "U_total_recharge_reward")
    elseif page == 6 then
        sMsg = VarApi.getPlayerUIntVar(actor, "U_free_cdk_exchange_state")
        sMsg2 = VarApi.getPlayerTStrVar(actor, "T_cdk_exchange_state")
    elseif page == 7 then
        sMsg = VarApi.getPlayerUIntVar(actor, "U_688_buy_all_gift")
    end
    if sMsg2 then
        sMsg = sMsg .. "#" .. sMsg2
    end
    return sMsg
end

function WelfareHall:CheckTask19(actor)
    local cdk_exchange_state = VarApi.getPlayerTStrVar(actor, "T_cdk_exchange_state")
    if "" == cdk_exchange_state then
        cdk_exchange_state = {}
    else
        cdk_exchange_state = json2tbl(cdk_exchange_state)
    end
    if isInTable(cdk_exchange_state, 1) then
        return true
    end
    local get_state = VarApi.getPlayerTStrVar(actor, "T_daily_recharge_reward")
    if "" == get_state then
        get_state = {}
    else
        get_state = json2tbl(get_state)
    end
    if isInTable(get_state, 1) then
        return true
    end
    local get_ret = VarApi.getPlayerTStrVar(actor, "T_login_reward_state")
    if "" == get_ret then
        get_ret = {}
    else
        get_ret = json2tbl(get_ret)
    end
    if isInTable(get_ret, 1) then
        return true
    end
    return false
end

return WelfareHall