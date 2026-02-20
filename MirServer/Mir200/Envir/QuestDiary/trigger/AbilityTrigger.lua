AbilityTrigger = {}
--角色属性变化时触发
function AbilityTrigger.sendability(actor)
    local upLevel=getbaseinfo(actor,51,299)
    local level = getbaseinfo(actor,6) --#region 人物等级
    if level>=100 and upLevel~= VarApi.getPlayerUIntVar(actor,"U_upLevel") then --#region 人物等级提升维护
        if upLevel-VarApi.getPlayerUIntVar(actor,"U_upLevel")>0 then
            changelevel(actor,"+",upLevel-VarApi.getPlayerUIntVar(actor,"U_upLevel"))
        else
            changelevel(actor,"-",VarApi.getPlayerUIntVar(actor,"U_upLevel")-upLevel)
        end
        VarApi.setPlayerUIntVar(actor,"U_upLevel",upLevel,false)
    end
    --幸运属性变化
    if getbaseinfo(actor,25)  ~= VarApi.getPlayerUIntVar(actor,"U_listening_attr_39") then
        if hasbuff(actor,80014)  then
            if  getbaseinfo(actor,25) > 0  then
                local curse_value =  getbaseinfo(actor,25)
                local attr_str = "3#89#"..curse_value * 200
                delbuff(actor,60106)
                local tab = ParserAttrStrToTable(attr_str)
                addbuff(actor,60106,0,1,actor,tab)
                sendattackeff(actor,314,0,"*")
            else
                delbuff(actor,60106)
            end
        end
        if hasbuff(actor,80001) then
            if getbaseinfo(actor,25) < 0 then
                local dc = getbaseinfo(actor,19)
                local mc = getbaseinfo(actor,21)
                local sc = getbaseinfo(actor,23) 
                local curse_value =  0 - getbaseinfo(actor,25)
                local random_value = math.random(5)
                local attr_str = "3#3#"..curse_value * math.ceil((random_value /100)* dc) .. "|3#5#"..curse_value * (math.ceil((random_value /100) * mc)).."|3#7#"..curse_value * (math.ceil((random_value /100) * sc))
                delbuff(actor,60105)
                local tab = ParserAttrStrToTable(attr_str)
                addbuff(actor,60105,0,1,actor,tab)
                sendattackeff(actor,225,0,"*")
            else
                delbuff(actor,60105)
            end
        end
        if hasbuff(actor,80055) then
            if getbaseinfo(actor,25) >= 9 then
                addbuff(actor,60112,0,1,actor,{[35]=1000})
                sendattackeff(actor,355,0,"*")
            else
                delbuff(actor, 60112)
            end
        end
        VarApi.setPlayerUIntVar(actor,"U_listening_attr_39",getbaseinfo(actor,25))
    end
    if hasbuff(actor,80015) and  getbaseinfo(actor,12) ~= VarApi.getPlayerUIntVar(actor,"U_listening_attr_2") then
        VarApi.setPlayerUIntVar(actor,"U_listening_attr_2",getbaseinfo(actor,12))
        local value =  math.floor(getbaseinfo(actor,12)/100) 
        local attr_str = "3#10#"..value.."|3#12#"..value
        local tab = ParserAttrStrToTable(attr_str)
        delbuff(actor,60109)
        addbuff(actor,60109,0,1,actor,tab)
    end
    --#region 打野刀神器额外buff
    local godEquip_buff_key=VarApi.getPlayerTStrVar(actor,"T_godEquip_buff_key")
    local cdTime=VarApi.getPlayerUIntVar(actor,"U_godEquip_buff_cd"..(godEquip_buff_key)) --#region 当前神器cd
    if godEquip_buff_key=="53" and (getbaseinfo(actor,9)/getbaseinfo(actor,10))<0.3 and os.time()-cdTime>30 then
        VarApi.setPlayerUIntVar(actor,"U_godEquip_buff_cd"..(godEquip_buff_key),os.time(),false)
        addbuff(actor,40066,8)
        Sendmsg9(actor,"00ff00","神器霸者重装【每秒恢复最大生命值】1%，持续8秒！",1)
    elseif godEquip_buff_key=="54" and (getbaseinfo(actor,9)/getbaseinfo(actor,10))<0.3 and os.time()-cdTime>30 then
        VarApi.setPlayerUIntVar(actor,"U_godEquip_buff_cd"..(godEquip_buff_key),os.time(),false)
        addbuff(actor,40067,10)
        Sendmsg9(actor,"00ff00","神器永夜守护【每秒恢复最大生命值】2%，持续10秒！",1)
    elseif godEquip_buff_key=="55" and (getbaseinfo(actor,9)/getbaseinfo(actor,10))<0.3 and os.time()-cdTime>30 then
        VarApi.setPlayerUIntVar(actor,"U_godEquip_buff_cd"..(godEquip_buff_key),os.time(),false)
        addbuff(actor,40068,15)
        Sendmsg9(actor,"00ff00","神器贤者庇护【每秒恢复最大生命值】3%，持续15秒！",1)
    end

end