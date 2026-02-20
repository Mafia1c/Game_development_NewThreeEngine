local Recharge = {}
Recharge.giftCfg = include("QuestDiary/config/RechargeGiftCfg.lua") --#region 礼包表

--#region 充值商场
function Recharge:storeBtnState(actor) -- 刷新今日按钮领取信息
    -- lualib:FlushNpcUi(actor,"StoreRechargePanel","recharge#"..VarApi.getPlayerJIntVar(actor,"J_gift_zdy866"))
end
function Recharge:storeBtnEvent(actor,index) -- 购买按钮
    -- index=tonumber(index)
    -- if not isInTable({1,2,3,4,5,6,7},index) then
    --     return Sendmsg9(actor,"ff0000","充值商场异常！",1)
    -- end
    -- local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "T_Recharge_hasGift")) --#region 充值过的礼包
    -- if hasGift == "" then hasGift = {} end
    -- if index==7 and hasGift["gift_zdy866"] then
    --     return Sendmsg9(actor,"ff0000","当前礼包已购买过！",1)
    -- end
    -- local giftKey={"gift_zdy18","gift_zdy68","gift_zdy98","gift_zdy128","gift_zdy328","gift_zdy648","gift_zdy866"}
    -- Recharge:showType(actor,giftKey[index],1,"StoreRechargePanel")
end
function Recharge:getReward(actor) -- 领取每日奖励
    -- local hasGift = json2tbl(VarApi.getPlayerTStrVar(actor, "T_Recharge_hasGift")) --#region 充值过的礼包 
    -- local time1 = VarApi.getPlayerUIntVar(actor,"U_gift_zdy866") --#region 是否首次领取
    -- local time2 = VarApi.getPlayerJIntVar(actor,"J_gift_zdy866") --#region 是否今日领取
    -- if hasGift == "" then hasGift = {} end
    -- if not hasGift["gift_zdy866"] then
    --     return Sendmsg9(actor,"ff0000","当前还未一键打包866礼包！",1)
    -- elseif time2>0 then
    --     return Sendmsg9(actor,"ff0000","今日奖励已领取过！",1)
    -- end
    -- local infoTab={{"大神豪(称号)",1},{"古纪卷轴",3},{"幸运钥匙",6}}
    -- local emailStr=""
    -- if time1==0 then
    --     VarApi.setPlayerUIntVar(actor,"U_gift_zdy866",1,false)
    --     emailStr = emailStr.."&"..infoTab[1][1].."#"..infoTab[1][2].."#370"
    -- end
    -- if time2==0 then
    --     VarApi.setPlayerJIntVar(actor,"J_gift_zdy866",1,0,true)
    --     emailStr = emailStr.."&"..infoTab[2][1].."#"..infoTab[2][2].."#370".."&"..infoTab[3][1].."#"..infoTab[3][2].."#370"
    -- end
    -- if emailStr~="" then
    --     emailStr = emailStr:sub(2)
    --     SendMail(actor,1,"充值商场每日领取",
    --     "恭喜您成功领取充值商场每日礼包！\\所有道具已到账，请查收！\\邮箱数据不定时清理，为了保护您的权益，请及时领取邮件！",emailStr)
    --     Sendmsg9(actor, "ffffff", "领取成功，奖励已通过邮箱发送！", 1)
    --     lualib:FlushNpcUi(actor,"StoreRechargePanel","recharge#"..VarApi.getPlayerJIntVar(actor,"J_gift_zdy866"))
    -- end
end
--#endregion




function Recharge:showType(actor,...) --#region 选类别(对象,礼包名,购买次数,前端obj)
    if checkkuafu(actor) then
        return Sendmsg9(actor,"ff0000","跨服禁止拉取充值！",1)
    end
    local param = {...}
    local giftName = param[1] --#region 礼包名
    local number = tonumber(param[2]) --#region 购买次数
    local objName = param[3] --#region 类名
    if not self.giftCfg[giftName] then
        return Sendmsg9(actor,"ff0000","选类别礼包内容异常！",1)
    elseif not isInTable(self.giftCfg[giftName]["time_arr"],number) then
        return Sendmsg9(actor,"ff0000","购买次数异常！",1)
    end
    local needMoney = Recharge.giftCfg[giftName]["money"] * number
    --#region 礼包名|次数|前端obj|产品id
    VarApi.setPlayerTStrVar(actor,"T_Recharge_gift",
    giftName.."|"..number.."|"..objName.."|"..self.giftCfg[giftName]["productId"],false)

    if getbagitemcount(actor,"代币","0") >= needMoney then --#region 判断直购
        messagebox(actor,string.format("充值项目：%s ×%s\\本次项目金额：%s元\\当前背包代币数量：%s      扣除比例 1:1"
        ,self.giftCfg[giftName]["typeText"],number,needMoney,getbagitemcount(actor,"代币","0"))
        ,"@recharge_confirm","@recharge_close") --#region 跳转在trigger
    else
        lualib:ShowNpcUi(actor, "RechargeTypeOBJ", needMoney)
    end
end


function Recharge:confirmType(actor,index) --#region 确认类型拉取充值
    index=tonumber(index)
    local giftTab = strsplit(VarApi.getPlayerTStrVar(actor, "T_Recharge_gift"),"|") --#region 礼包名|次数|前端obj|产品id
    if VarApi.getPlayerTStrVar(actor, "T_Recharge_gift")=="" then
        return
    elseif not isInTable({1,2,3},index) then
        return Sendmsg9(actor,"ff0000","选取充值类型异常！",1)
    elseif not self.giftCfg[giftTab[1]] then
        return Sendmsg9(actor,"ff0000","拉取充值礼包内容异常！",1)
    elseif not isInTable(self.giftCfg[giftTab[1]]["time_arr"],tonumber(giftTab[2])) then
        return Sendmsg9(actor,"ff0000","拉取充值购买次数异常！",1)
    end
    local Gold = self.giftCfg[giftTab[1]]["money"] * tonumber(giftTab[2])
    pullpay(actor,Gold,index,tonumber(giftTab[4]))
    lualib:CloseNpcUi(actor,"RechargeTypeOBJ")
end
function Recharge:cancelType(actor) --#region 取消类型拉取充值
    VarApi.setPlayerTStrVar(actor,"T_Recharge_gift","",false)
end


return Recharge