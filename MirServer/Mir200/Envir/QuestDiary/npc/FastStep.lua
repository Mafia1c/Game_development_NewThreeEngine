local FastStep = {}
FastStep.cfg1 = { --#region pc
    {101,530,"<Button|ax=0.5|ay=0.5|x=300|y=260|nimg=custom/top/an22.png|link=@fast_step_jump>"},
    {101,531,"<COUNTDOWN|ax=0.5|x=300|y=293|size=18|count=1|outline=1|showWay=1|time=%s|color=250|link=@delay_del_fast_step>"}
}
FastStep.cfg2 = { --#region mob
    {101,530,"<Button|ax=0.5|ay=0.5|x=360|y=240|nimg=custom/top/an22.png|link=@fast_step_jump>"},
    {101,531,"<COUNTDOWN|ax=0.5|x=360|y=273|size=18|count=1|outline=1|showWay=1|time=%s|color=250|link=@delay_del_fast_step>"}
}
FastStep.needMoney={"元宝",100}


function FastStep:addBtn(actor) --#region 登陆按钮
    local todayTime=VarApi.getPlayerJIntVar(actor, VarJIntDef.OnLine_TimeStamp)
    if VarApi.getPlayerUIntVar(actor,"U_fastStep_buy")==1 then
        return
    end
    local is_pc = getconst(actor,"<$CLIENTFLAG>") or 2
    for index, v in ipairs(self["cfg"..is_pc] or self["cfg2"]) do
        delbutton(actor,v[1],v[2])
        local temp=v[3]
        if index==1 then
            addbutton(actor,v[1],v[2],temp)
        elseif index==2 and (1800-todayTime)>0 then
            temp=string.format(temp,1800-todayTime)
            addbutton(actor,v[1],v[2],temp)
        end
    end
    if (1800-todayTime)>0 then
        delaygoto(actor,(1800-todayTime)*1000,"delay_del_fast_step",0)
    end
end
function delay_del_fast_step(actor)
    FastStep:delay_del_fast_step(actor)
end
function FastStep:delay_del_fast_step(actor)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") or 2
    if VarApi.getPlayerUIntVar(actor,"U_fastStep_buy")==1 then
        for index, v in ipairs(self["cfg"..is_pc] or self["cfg2"]) do
            delbutton(actor,v[1],v[2])
        end
    else
        local tab=self["cfg"..is_pc] or self["cfg2"]
        delbutton(actor,tab[2][1],tab[2][2])
    end
end

function fast_step_jump(actor)
    FastStep:fast_step_jump(actor)
end
function FastStep:fast_step_jump(actor)
    local todayTime=VarApi.getPlayerJIntVar(actor, VarJIntDef.OnLine_TimeStamp)
    if VarApi.getPlayerUIntVar(actor,"U_fastStep_buy")==1 then
        return
    end
    lualib:ShowNpcUi(actor,"FastStepOBJ",(1800-todayTime)<0 and "0" or (1800-todayTime))
end


function FastStep:btnEvent1(actor) --#region 绑元刷
    if querymoney(actor,4) < self.needMoney[2] then
        return Sendmsg9(actor, "ff0000", "当前玩家货币绑定元宝数量少于" .. self.needMoney[2] .. "！", 1)
    end
    if not ChangeMoney(actor,4,"-",self.needMoney[2],"快人一步扣绑元",true) then
        return Sendmsg9(actor, "ff0000", "货币绑定元宝扣除失败！", 1)
    end
    local price=math.random(2,3)
    VarApi.setPlayerUIntVar(actor,"U_fastStep_price",price,true)
    Sendmsg9(actor,"00ff00","恭喜您成功获得"..price.."折扣！",1)
    lualib:FlushNpcUi(actor,"FastStepOBJ","refresh")
end
function FastStep:btnEvent2(actor) --#region 元宝刷
    if querymoney(actor,2) < self.needMoney[2] then
        return Sendmsg9(actor, "ff0000", "当前玩家货币元宝数量少于" .. self.needMoney[2] .. "！", 1)
    end
    if not ChangeMoney(actor,2,"-",self.needMoney[2],"快人一步扣元宝",true) then
        return Sendmsg9(actor, "ff0000", "货币元宝扣除失败！", 1)
    end
    VarApi.setPlayerUIntVar(actor,"U_fastStep_price",1,true)
    Sendmsg9(actor,"00ff00","恭喜您成功获得1折扣！",1)
    lualib:FlushNpcUi(actor,"FastStepOBJ","refresh")
end
function FastStep:btnEvent3(actor) --#region 买
    if VarApi.getPlayerUIntVar(actor,"U_fastStep_buy")>0 then
        return Sendmsg9(actor, "ff0000", "当前礼包已购买过！", 1)
    end
    local priceTab={[0]=188,[1]=18,[2]=37,[3]=56}
    local tag=VarApi.getPlayerUIntVar(actor,"U_fastStep_price")
    IncludeMainClass("Recharge"):showType(actor,"gift_kryb_"..priceTab[tag],1,"FastStepOBJ") --#region 礼包名,次数,前端obj
end

return FastStep