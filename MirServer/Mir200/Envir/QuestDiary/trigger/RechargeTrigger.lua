-- 充值触发
RechargeTrigger = {}
RechargeTrigger.giftCfg = include("QuestDiary/config/RechargeGiftCfg.lua") --#region 礼包表

--#region 充值触发(玩家对象，充值金额，产品id，货币id，1=真充0=扶持，订单时间，实际到账货币金额，额外赠送金额，开启积分金额)
function RechargeTrigger.onRecharge(actor, Gold, ProductId, MoneyId, isReal, orderTime, rechargeAmount, giftAmount, refundAmount)
    local gold = tonumber(Gold)
    if not actor or not gold or gold<=0 then
        return Sendmsg9(actor,"ff0000","充值触发异常！",1)
    elseif not MoneyId then
        return Sendmsg9(actor, "ff0000", "非法商品或货币ID", 1)
    elseif isReal ~= 0 and isReal ~= 1 then
        return Sendmsg9(actor, "ff0000", "非法充值类型", 1)
    end

    if tonumber(MoneyId)==2 then
        VarApi.setPlayerJIntVar(actor, VarUIntDef.DAY_RECHARGE,VarApi.getPlayerJIntVar(actor, VarUIntDef.DAY_RECHARGE) + Gold,0,nil) -- 今日充值
        VarApi.setPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE, VarApi.getPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE) + Gold,true) -- 总充值
        SetSysInt("G_allMoney",GetSysInt("G_allMoney")+gold,4)
        RechargeTrigger.RecordRechargeData(actor)
    elseif tonumber(MoneyId)==11 then
        SetSysInt("G_allMoney",GetSysInt("G_allMoney")+gold,4)
        RechargeTrigger.gift(actor,Gold)
        RechargeTrigger.RecordRechargeData(actor)
    end

end
function recharge_confirm(actor) --#region 扣直购跳转奖励
    local giftTab = strsplit(VarApi.getPlayerTStrVar(actor, "T_Recharge_gift"),"|") --#region 礼包名|次数|前端obj|产品id
    if VarApi.getPlayerTStrVar(actor, "T_Recharge_gift")=="" then
        return Sendmsg9(actor,"ff0000","直购跳转异常！",1)
    end
    local needMoney = RechargeTrigger.giftCfg[giftTab[1]]["money"] * tonumber(giftTab[2])
    if not takeitem(actor,"代币",needMoney,0,giftTab[1]..giftTab[2].."扣代币") then
        return Sendmsg9(actor, "ff0000", giftTab[1].."扣"..needMoney.."代币异常！", 1)
    end
    -- local zdy=tonumber(string.match(giftTab[1],"gift_zdy(.*)"))
    -- if zdy~=nil and zdy~="" then --#region 在线充值扣直购 手动送后台
    --     if not changemoney(actor,7,"+",zdy*100,"在线充值扣直购,手动送后台",true) then
    --         return Sendmsg9(actor,"ff0000",giftTab[1].."送后台异常！",1)
    --     end
    -- end
    RechargeTrigger.gift(actor,needMoney)
    RechargeTrigger.RecordRechargeData(actor)
end
function recharge_close(actor) --#region 扣直购取消跳转
    VarApi.setPlayerTStrVar(actor,"T_Recharge_gift","",false)
end

function RechargeTrigger.gift(actor,Gold) --#region 充值赠送(玩家对象，充值金额)
    if VarApi.getPlayerTStrVar(actor, "T_Recharge_gift")=="" then
        return Sendmsg9(actor,"ff0000","充值触发礼包内容异常！",1)
    end
    local username = getbaseinfo(actor,1) --#region 玩家名称
    local giftTab = strsplit(VarApi.getPlayerTStrVar(actor, "T_Recharge_gift"),"|") --#region 礼包名|次数|前端obj|产品id
    VarApi.setPlayerTStrVar(actor,"T_Recharge_gift","",false)
    if not actor or not Gold or Gold <= 0 then
        return Sendmsg9(actor, "ff0000", "玩家或金额异常！", 1)
    elseif Gold ~= RechargeTrigger.giftCfg[giftTab[1]]["money"] * tonumber(giftTab[2]) then
        return Sendmsg9(actor, "ff0000", "当前礼包金额异常请求", 1)
    end
    giftTab[2]=tonumber(giftTab[2])

    --#region 获取奖励邮件内容
    local emailTab = RechargeTrigger.giftCfg[giftTab[1]]["email_arr"]
    local emailItemStr = ""
    for i = 1, #(RechargeTrigger.giftCfg[giftTab[1]]["reward_arr1"] or {}) do
        local infoTab = RechargeTrigger.giftCfg[giftTab[1]]
        emailItemStr = emailItemStr.."&"..infoTab["reward_arr1"][i].."#"..infoTab["reward_arr2"][i]*giftTab[2].."#370"
    end

    local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "T_Recharge_hasGift")) --#region 充值过的礼包 
    if hasGift == "" then hasGift = {} end
    if not hasGift[giftTab[1]] then
        hasGift[giftTab[1]] = 1
        local str = tbl2json(hasGift)
        VarApi.setPlayerTStrVar(actor,"T_Recharge_hasGift",str,true)
    end

    local job=getbaseinfo(actor,7)
    local refreshTag=true --#region 是否刷前端obj
    local refershInfo = "" --#region 带回前端数据(刷新界面用)
    --#region 特殊判断(首次或给予变量)
    local funcTab = {
        ["gift_mzl"] = function () --#region 盟重令
            if not checktitle(actor, "盟重令") then
                confertitle(actor,"盟重令",0)
            end
            VarApi.setPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL, 1, true)
            refershInfo = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)

            local merge_count = GetSysInt(VarEngine.HeFuCount)
            if merge_count < 1 then
                local jackpot = GetSysInt("G_city_jackpot_value")
                jackpot = jackpot + 50000
                SetSysInt("G_city_jackpot_value", jackpot, 4)       -- 所有区服奖池累加
            end

            if GetItemByPos(actor, 106) == "0" then
                GiveOnItem(actor,106,"聚宝盆[神器]",1,65536,"聚宝盆领取")
            end
        end,
        ["gift_zxlb"] = function (result) --#region 专享福利
            if result=="10" then --#region 今日专享
                VarApi.setPlayerJIntVar(actor,"J_WelfareToday_buyToday",1,nil,true)
            elseif result=="68" then --#region 七日专享
                local hasTime=VarApi.getPlayerUIntVar(actor,"U_WelfareToday_hasTime") --#region 专享礼包拥有领取时间
                local firstBuyTime=VarApi.getPlayerUIntVar(actor,"U_gift_zxlb_firstTime") --#region 上次买礼包时间
                if hasTime==0 or firstBuyTime==0 then --#region 第一次买
                    VarApi.setPlayerUIntVar(actor,"U_gift_zxlb_firstTime",os.time()-(os.time()-GetDayTick()),true)
                    VarApi.setPlayerUIntVar(actor,"U_WelfareToday_hasTime",(604800),true)
                elseif os.time()-firstBuyTime<firstBuyTime then --#region 续买
                    VarApi.setPlayerUIntVar(actor,"U_WelfareToday_hasTime",hasTime+(604800),true)
                else --#region 重新买
                    VarApi.setPlayerUIntVar(actor,"U_gift_zxlb_firstTime",os.time()-(os.time()-GetDayTick()),true)
                    VarApi.setPlayerUIntVar(actor,"U_WelfareToday_hasTime",(604800),true)
                end
            end
            local buyToday=VarApi.getPlayerJIntVar(actor,"J_WelfareToday_buyToday") --#region 今日礼包是否购买
            local hasTime=VarApi.getPlayerUIntVar(actor,"U_WelfareToday_hasTime") --#region 专享礼包拥有领取时间
            local getToday=VarApi.getPlayerJIntVar(actor,"J_WelfareToday_getToday") --#region 今日专享是否领取
            local firstBuyTime=VarApi.getPlayerUIntVar(actor,"U_gift_zxlb_firstTime") --#region 上次买礼包时间
            local showTime=0 --#region 前端显示时间
            if hasTime==0 or firstBuyTime==0 or (os.time()-hasTime>firstBuyTime) then
                showTime=0
            else
                showTime=firstBuyTime-(os.time()-hasTime)
            end
            refershInfo=buyToday.."#"..(showTime).."#"..getToday
        end,
        ["gift_xlbz"] = function () --#region 寻龙宝藏
            local day_limit_count = VarApi.getPlayerJIntVar(actor,"J_dragon_day_limit_count")
            VarApi.setPlayerJIntVar(actor,"J_dragon_day_limit_count",day_limit_count+giftTab[2],0,nil)
            refershInfo=VarApi.getPlayerJIntVar(actor,"J_dragon_day_limit_count")
        end,
        ["gift_lcjl"] = function () --#region 累充奖励648
            if job==0 then
                emailItemStr=emailItemStr.."&擒龙手#1#370"
            elseif job==1 then
                emailItemStr=emailItemStr.."&分身术#1#370"
            elseif job==2 then
                emailItemStr=emailItemStr.."&无极真气#1#370"
            end
            VarApi.setPlayerUIntVar(actor,"U_gift_lcjl",1,false)
            IncludeMainClass("WelfareHall"):onBuy648Success(actor)
            refreshTag=false
        end,
        ["gift_kryb_"] = function (result) --#region 快人一步
            if job==0 then
                emailItemStr=emailItemStr.."&战神变异宝箱#1#370"
            elseif job==1 then
                emailItemStr=emailItemStr.."&圣魔变异宝箱#1#370"
            elseif job==2 then
                emailItemStr=emailItemStr.."&真魂变异宝箱#1#370"
            end
            VarApi.setPlayerUIntVar(actor,"U_fastStep_buy",1,false)
        end,
        ["gift_ldcs"] = function () --#region 落地成神688
            if job==0 then
                emailItemStr=emailItemStr.."&战神变异宝箱#1#370"
            elseif job==1 then
                emailItemStr=emailItemStr.."&圣魔变异宝箱#1#370"
            elseif job==2 then
                emailItemStr=emailItemStr.."&真魂变异宝箱#1#370"
            end
            --#region 快人一步
            VarApi.setPlayerUIntVar(actor,"U_fastStep_buy",1,false)
            IncludeNpcClass("FastStep"):delay_del_fast_step(actor)
            --#region 盟重令
            if not checktitle(actor, "盟重令") then
                confertitle(actor,"盟重令",0)
            end
            VarApi.setPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL, 1, true)

            local merge_count = GetSysInt(VarEngine.HeFuCount)
            if merge_count < 1 then
                local jackpot = GetSysInt("G_city_jackpot_value")
                jackpot = jackpot + 50000
                SetSysInt("G_city_jackpot_value", jackpot, 4)       -- 所有区服奖池累加
            end
            if GetItemByPos(actor, 106) == "0" then
                GiveOnItem(actor,106,"聚宝盆[神器]",1,65536,"聚宝盆领取")
            end
            --#region 七日专享
            local hasTime=VarApi.getPlayerUIntVar(actor,"U_WelfareToday_hasTime") --#region 专享礼包拥有领取时间
            local firstBuyTime=VarApi.getPlayerUIntVar(actor,"U_gift_zxlb_firstTime") --#region 上次买礼包时间
            if hasTime==0 or firstBuyTime==0 then --#region 第一次买
                VarApi.setPlayerUIntVar(actor,"U_gift_zxlb_firstTime",os.time()-(os.time()-GetDayTick()),true)
                VarApi.setPlayerUIntVar(actor,"U_WelfareToday_hasTime",(604800),true)
            elseif os.time()-firstBuyTime<firstBuyTime then --#region 续买
                VarApi.setPlayerUIntVar(actor,"U_WelfareToday_hasTime",hasTime+(604800),true)
            else --#region 重新买
                VarApi.setPlayerUIntVar(actor,"U_gift_zxlb_firstTime",os.time()-(os.time()-GetDayTick()),true)
                VarApi.setPlayerUIntVar(actor,"U_WelfareToday_hasTime",(604800),true)
            end
            --#region 998拉满
            IncludeMainClass("WelfareHall"):onBuy688Success(actor)
            refreshTag=false
        end,
    }
    local gift_name = giftTab[1]
    local result = "" --#region 适用匹配(传参)
    if string.match(giftTab[1],"gift_zxlb(.*)") ~= nil and string.match(giftTab[1],"gift_zxlb(.*)") ~= "" then
        gift_name = "gift_zxlb"
        result = string.match(giftTab[1],"gift_zxlb(.*)") --#region 专享福利
    elseif string.match(giftTab[1],"gift_kryb_(.*)") ~= nil then
        gift_name = "gift_kryb_"
        result = string.match(giftTab[1],"gift_kryb_(.*)") --#region 快人一步
    end
    if funcTab[gift_name] then
        funcTab[gift_name](result)
    end


    --#region 发奖励邮件
    if emailItemStr~="" then
        emailItemStr = emailItemStr:sub(2)
        SendMail(actor,1,emailTab[1],emailTab[2],emailItemStr)
        Sendmsg9(actor, "00ff00", "购买成功，奖励已通过邮箱发送！", 1)
    end
    sendmsgnew(actor, 255, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功获得{【"..RechargeTrigger.giftCfg[giftTab[1]]["typeText"].."】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
    sendcentermsg(actor, 250, 0, "恭喜玩家{"..username.."/FCOLOR=251}成功购买了{【"..RechargeTrigger.giftCfg[giftTab[1]]["typeText"].."】/FCOLOR=249}！您也想获得赶快购买吧！", 1, 3)
    --#region 更新总充值累计
    VarApi.setPlayerJIntVar(actor, VarUIntDef.DAY_RECHARGE,VarApi.getPlayerJIntVar(actor, VarUIntDef.DAY_RECHARGE) + Gold,0,nil) -- 今日充值
    VarApi.setPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE, VarApi.getPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE) + Gold,true) -- 总充值
    if refreshTag then
        lualib:FlushNpcUi(actor, giftTab[3], "recharge#"..refershInfo)
    end
end


-- 记录玩家累计充值天数
function RechargeTrigger.RecordRechargeData(actor)
    -- 每日活跃
    local npc_class = IncludeMainClass("DailyActive")
    if npc_class then
        npc_class:UpdateActivePoint(actor, "今日充值")
    end

    -- 获取最近一次充值日期（格式：YYYYMMDD）
    local lastRechargeDate = VarApi.getPlayerUIntVar(actor, "U_last_recharge_day")
    -- 当前连续充值天数
    local consecutiveDays = VarApi.getPlayerUIntVar(actor, "U_consecutive_days")
    -- 当前日期
    local currentDate = tonumber(GetCurrentDate())

    -- 如果是第一次充值
    if lastRechargeDate <= 0 then
        VarApi.setPlayerUIntVar(actor, "U_last_recharge_day", currentDate, false)
        VarApi.setPlayerUIntVar(actor, "U_consecutive_days", 1, true)
        return
    end

    -- 如果是同一天充值，不增加连续天数（防止重复操作）
    if lastRechargeDate == currentDate then
        return
    end
    VarApi.setPlayerUIntVar(actor, "U_last_recharge_day", currentDate, false)
    VarApi.setPlayerUIntVar(actor, "U_consecutive_days", consecutiveDays + 1, true)

end
