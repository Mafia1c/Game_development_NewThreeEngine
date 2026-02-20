local WelfareToday = {}
WelfareToday.cfg4 = "5倍高爆地图卷#3#370&绑定元宝#30000#370&1亿经验珠#1#370&五行精华#18#370&生肖精华#18#370"
-- 总拥有时间  U_WelfareToday_hasTime
-- 第1次买  U_gift_zxlb_firstTime  os.time()
-- 总拥有时间==0  第一次买时间==0  没买
-- 当前时间-总拥有时间》第一次买时间  没有  《 还有没领完
--  第一次 设总拥有时间=7  设第1次买 os。time
--  中途买  设总拥有时间  
--  重置  
-- 前端显示  总拥有时间==0  第一次买时间==0  没买  当前时间-总拥有时间》第一次买时间 没有=0
-- 第一次买时间-（当前时间-总拥有时间）

function WelfareToday:getVarInfo(actor)
    self.buyToday=VarApi.getPlayerJIntVar(actor,"J_WelfareToday_buyToday") --#region 今日礼包是否购买
    self.hasTime=VarApi.getPlayerUIntVar(actor,"U_WelfareToday_hasTime") --#region 专享礼包拥有领取时间
    self.getToday=VarApi.getPlayerJIntVar(actor,"J_WelfareToday_getToday") --#region 今日专享是否领取
    self.firsetTime=VarApi.getPlayerUIntVar(actor,"U_gift_zxlb_firstTime") --#region 上次买的时间
    self.showTime=0 --#region 前端显示时间
    if self.hasTime==0 or self.firsetTime==0 or (os.time()-self.hasTime>self.firsetTime) then
        self.showTime=0
    else
        self.showTime=self.firsetTime-(os.time()-self.hasTime)
    end
end
function WelfareToday:onClickBtn(actor)
    self:getVarInfo(actor)
    lualib:ShowNpcUi(actor, "WelfareTodayOBJ", self.buyToday.."#"..self.showTime.."#"..self.getToday)
end


function WelfareToday:buyEvent1(actor) --#region 买每日专享
    self:getVarInfo(actor)
    if self.buyToday>0 then
        return Sendmsg9(actor, "ff0000", "今日每日专享礼包已购买过！", 1)
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):showType(actor,"gift_zxlb10",1,"WelfareTodayOBJ") --#region 礼包名,次数,前端obj
    end
end
function WelfareToday:buyEvent2(actor) --#region 买七日专享
    self:getVarInfo(actor)
    if self.showTime==0 then
        WelfareToday:buy_gift_zxlb68(actor)
    else
        messagebox(actor,"当前七日专享还有剩余领取天数\\继续购买将额外获得七日领取天数\\是否确定继续购买？","@func_buy_gift_zxlb68","@func_buy_gift_zxlb68_")
    end
end
function func_buy_gift_zxlb68(actor)
    WelfareToday:buy_gift_zxlb68(actor)
end
function WelfareToday:buy_gift_zxlb68(actor)
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):showType(actor,"gift_zxlb68",1,"WelfareTodayOBJ") --#region 礼包名,次数,前端obj
    end
end
function WelfareToday:getReward(actor) --#region 领取七日专享
    self:getVarInfo(actor)
    if self.showTime<=0 then
        return Sendmsg9(actor, "ff0000", "当前并未开通七日专享礼包！", 1)
    elseif self.getToday>0 then
        return Sendmsg9(actor, "ff0000", "今日专享福利已领取过！", 1)
    end
    local npc_class = IncludeMainClass("DailyActive")
    if npc_class then
        npc_class:UpdateActivePoint(actor, "每日周享礼包")
    end
    VarApi.setPlayerJIntVar(actor,"J_WelfareToday_getToday",1,nil,true)
    SendMail(actor, 1, "七日专享", "恭喜你，成功领取<【七日专享】每日奖励/FCOLOR=250>请查收！", self.cfg4)
    self:getVarInfo(actor)
    lualib:FlushNpcUi(actor,"WelfareTodayOBJ","recharge#"..self.buyToday.."#"..self.showTime.."#"..self.getToday)
end

return WelfareToday