-- 被攻击前触发
BeforeBeingAttackedTrigger = {}
BeforeBeingAttackedTrigger.DunPaiInfo = {
    ["玄铁盾"] = 5,
    ["蛟鳞盾"] = 6,
    ["血纹盾"] = 7,
    ["磐岩盾"] = 8,
    ["龙魂盾"] = 10,
    ["圣光盾"] = 12,
    ["天罡盾"] = 14,
    ["幽冥盾"] = 16,
    ["罗刹盾"] = 18,
    ["九霄雷音盾"] = 20,
    ["太初鸿蒙盾"] = 25,
    ["创世源初盾"] = 30
}
BeforeBeingAttackedTrigger.filter_mons = {
    "爆不爆谁知道6",
    "爆不爆谁知道61",
    "红方峡谷神龙",
    "红方峡谷守卫1",
    "红方峡谷守卫2",
    "蓝方峡谷神龙",
    "蓝方峡谷守卫1",
    "蓝方峡谷守卫2",
    "冥界之花"
}

local function LayerUp(actor,Hiter)
    VarApi.setPlayerUIntVar(Hiter,"U_LayerUpTime",os.time(),false)
    makeposion(actor,5,2,0,1)
    sendmsg(Hiter, 1, '{"Msg":"【境界飞升】：将对方麻痹2s！","FColor":251,"BColor":0,"Type":6,"Time":1}')
    sendmsg(actor, 1, '{"Msg":"【境界飞升】：被对方麻痹2s！","FColor":251,"BColor":0,"Type":6,"Time":1}')
end
--#region 人物被攻击前触发(玩家对象，攻击对象，受击对象(玩家)，技能id，伤害，return为修改后伤害)
function BeforeBeingAttackedTrigger.struckdamage(actor,Hiter,Target,MagicId,Damage)
    -- 设置战斗状态
    local cur_hp = getbaseinfo(Target, 9)
    local cur_time = os.time()
    VarApi.setPlayerUIntVar(Target,"U_battele_time",cur_time+3)
    if getbaseinfo(Hiter, -1) then --#region 攻击者为玩家
        if cur_hp > 0 then      -- 死人不加buff
            addbuff(Target, 50000)
        end
        local layerUp1 = VarApi.getPlayerUIntVar(Hiter,"U_LayerUp") --#region 对面境界
        local layerUp2 = VarApi.getPlayerUIntVar(actor,"U_LayerUp") --#region 自己境界
        local timestamp = VarApi.getPlayerUIntVar(Hiter,"U_LayerUpTime")
        if layerUp1==0 then
        elseif layerUp1==1 and layerUp1>layerUp2 then
            Damage = math.floor(Damage*1.05)
            if math.random(100)<2 and (cur_time-timestamp>60) then LayerUp(actor,Hiter) end
        elseif layerUp1==2 and layerUp1>layerUp2 then
            Damage = math.floor(Damage*1.06)
            if math.random(100)<2 and (cur_time-timestamp>60) then LayerUp(actor,Hiter) end
        elseif layerUp1==3 and layerUp1>layerUp2 then
            Damage = math.floor(Damage*1.08)
            if math.random(100)<2 and (cur_time-timestamp>60) then LayerUp(actor,Hiter) end
        elseif layerUp1==4 and layerUp1>layerUp2 then
            Damage = math.floor(Damage*1.1)
            if math.random(100)<2 and (cur_time-timestamp>60) then LayerUp(actor,Hiter) end
        end
    else --#region 为怪物
        if isInTable(BeforeBeingAttackedTrigger.filter_mons, getbaseinfo(Target, 1, 1)) then
            return Damage
        end
    end
    local godEquip_buff_key=VarApi.getPlayerTStrVar(Target,"T_godEquip_buff_key")
    if godEquip_buff_key=="43" or godEquip_buff_key=="44" or godEquip_buff_key=="45" then --#region 打野刀神器额外buff
        BeforeBeingAttackedTrigger.godEquipBuff(Target,godEquip_buff_key)
    end
    --魔戒
    if checkitemw(actor,"魔戒·死亡悲鸣",1)  then 
        Damage = math.floor(Damage*0.9)
    end
    if checkitemw(actor,"魔戒·毁灭之眼",1)  then
        Damage = math.floor(Damage*0.9)
    end
    if checkitemw(actor,"魔戒·裁决之殇",1) then
        Damage = math.floor(Damage*0.9)
    end
    
    --强化技能  魔法盾
    if checkhumanstate(Target,1) and getbaseinfo(Target, -1) then
        local level = getskillinfo(Target, 31, 2)
        if level and level > 0  then
            local odds = 0
            if level >= 3 then
                odds = 1
            end
            if math.random(100)<= odds then
                Damage = 0
                addbuff(Target,70032,3)
            end
        end
    end
    --法师 反噬
    if hasbuff(Target,60074) and math.random(100) <= 1 then
        humanhp(Hiter,"-",math.floor(Damage * 0.5)) 
        playeffect(Hiter,13423,0,0,1,0,0)
    end
    --法师 天启
    local timestamp = VarApi.getPlayerUIntVar(Target,"U_60079_buff_cd_timestamp") 
    if hasbuff(Target,60079) and cur_time - timestamp > 60 then
        VarApi.setPlayerUIntVar(Target,"U_60079_buff_cd_timestamp",cur_time) 
        addbuff(Target,70026,30)
    end
    if hasbuff(Target,70026) then
        Damage = Damage - Damage * 0.2
    end
     --法师 圣光结界
    timestamp = VarApi.getPlayerUIntVar(Target,"U_60080_buff_cd_timestamp") 
    local cur_hp = getbaseinfo(Target,9)
    local max_hp = getbaseinfo(Target,10)
    if hasbuff(Target,60080) and cur_time - timestamp > 120 and cur_hp / max_hp < 0.3 then
        VarApi.setPlayerUIntVar(Target,"U_60080_buff_cd_timestamp",cur_time) 
        local mf_attack = getbaseinfo(Target,22)
        local value =  math.floor(mf_attack * 0.1) 
        addbuff(Target,70030,10,1,Target,{[6] = value})
        playeffect(Target,13428,0,0,1,0,0)
    end

    --法师 阴阳盾
    if hasbuff(Target,60086)  then
        humanhp(Target,"+",math.floor(Damage * 0.2)) 
    end

    --道士 瘟神
    if hasbuff(Target,60093) and isplayer(Hiter)  then
        local max_hp = getbaseinfo(Hiter,10)
        humanhp(Hiter,"-",math.floor(max_hp*0.01)) 
        playeffect(Hiter,13442,0,0,1,0,0)
    end
    --血脉 抗击
    if hasbuff(Target,60008) then
        local layer = getbuffinfo(Target,60008,1) * 10
        setsuckdamage(Target,"=",Damage,layer,100)
    end

    -- [足迹]火麒麟  永久免疫30%火墙伤害
    if MagicId == 22 and hasbuff(Hiter, 50018) then
        Damage = Damage * 0.7
    end
    Damage = BeforeBeingAttackedTrigger.equipVariation1(actor,Hiter,Target,MagicId,Damage) or Damage --#region 装备极品变异

    -- 盾牌减伤
    if isplayer(Target) then
        -- local dp_name = getiteminfo(Target, GetItemByPos(Target, 16), 7)
        -- local rate = BeforeBeingAttackedTrigger.DunPaiInfo[dp_name]
        -- if rate then
        -- end
        
        for name, value in pairs(BeforeBeingAttackedTrigger.DunPaiInfo) do
            if checkitemw(Target, name, 1) then
                Damage = Damage - Damage * (value / 100)
                break
            end
        end
        
        -- 白衣剑仙坐骑免伤
        local sword_state = VarApi.getPlayerUIntVar(Target, "U_mont_sword_state")
        local cd = VarApi.getPlayerUIntVar(Target, "U_mont_sword_state_cd")
        if sword_state > 0 and GlobalTimer.server_run_time - cd >= 30 then
            VarApi.setPlayerUIntVar(Target, "U_mont_sword_state_cd", GlobalTimer.server_run_time, false)
            SetTempInt(0, Target, "UT_activation_state", GlobalTimer.server_run_time + 5)
            Sendmsg9(Target, "00ff00", "【坐骑】剑气护体触发·5秒内所受伤害减少10%！", 9)
        end
        local time = GetTempInt(0, Target, "UT_activation_state")
        if time - GlobalTimer.server_run_time >= 0 then
            Damage = Damage * 0.9
        end
    end
    return Damage
end

-- 宝宝被攻击前触发
function BeforeBeingAttackedTrigger.struckdamagebb()
end

--玩家被物理/魔法攻击后触发（玩家对象，受击对象，攻击对象，技能id,是否是魔法受击）
function BeforeBeingAttackedTrigger.PlayerstruckdamageEnd(actor,target,hitter,magicId,is_magic)
    local cur_time = os.time() 
    local timestamp = VarApi.getPlayerUIntVar(hitter,"U_map_cruise_attack_cd_timestamp") 
    if VarApi.getPlayerUIntVar(hitter,"U_map_cruise_state") > 0  then
        local map_cruise_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_map_cruise_info"))
        local setting_info = {}
        if map_cruise_info ~= "" and map_cruise_info.setting_info then
            setting_info = map_cruise_info.setting_info
        end
        if isplayer(hitter) and setting_info[2] > 0 and cur_time- timestamp > 60 then  -- 玩家攻击自动随机
            VarApi.setPlayerUIntVar(hitter,"U_map_cruise_attack_cd_timestamp",cur_time) 
            map(hitter,getbaseinfo(hitter,3))
        end
        timestamp = VarApi.getPlayerUIntVar(hitter,"U_map_cruise_gohome_cd_timestamp") 
        if getbaseinfo(hitter,9) < (getbaseinfo(hitter,10) * 0.5) and setting_info[1] > 0 and cur_time - timestamp > 60 then ----血量低于50% 自动回城
            VarApi.setPlayerUIntVar(hitter,"U_map_cruise_gohome_cd_timestamp",cur_time) 
            gohome(hitter)
        end

        local class = IncludeNpcClass("MapCruise")
        if class then
            class:CheckCanRandomMap(hitter)
        end
    end
    --无双  狡诈之人
     timestamp = VarApi.getPlayerUIntVar(hitter,"U_80030_buff_cd_timestamp") 
    if hasbuff(hitter,80030) and math.random(100) <= 1 and isplayer(target)  and cur_time - timestamp > 30 then
        makeposion(target,5,2,1,1)
        sendattackeff(target,330,0,"*")
        VarApi.setPlayerUIntVar(hitter,"U_80030_buff_cd_timestamp",cur_time)
    end
    --无双 绝处逢生
    timestamp = VarApi.getPlayerUIntVar(hitter,"U_80039_buff_cd_timestamp") 
    if hasbuff(hitter,80039) and  cur_time - timestamp > 30  and getbaseinfo(hitter,9) < (getbaseinfo(hitter,10) * 0.2) then
        VarApi.setPlayerUIntVar(hitter,"U_80039_buff_cd_timestamp",cur_time)
        addbuff(hitter,70013,10)
        sendattackeff(hitter,339,0,"*")
    end

    --无双 风骚走位
    timestamp = VarApi.getPlayerUIntVar(target,"U_80011_buff_cd_timestamp") 
    if hasbuff(target,80011) and cur_time -timestamp > 30  and math.random(100)<= 5 then
        addbuff(target,70011,math.random(4))
        VarApi.setPlayerUIntVar(target,"U_80011_buff_cd_timestamp",cur_time) 
        sendattackeff(target,311,0,"*")
    end
    --无双 死战不退
    timestamp = VarApi.getPlayerUIntVar(target,"U_80024_buff_cd_timestamp") 
    if hasbuff(target,80024) and cur_time-timestamp > 30 then
        local max_hp = getbaseinfo(target,10)
        local cur_hp = getbaseinfo(target,9)
        if cur_hp / max_hp < 0.6 then
            VarApi.setPlayerUIntVar(target,"U_80024_buff_cd_timestamp",cur_time) 
            changehumability(target,1,math.floor(getbaseinfo(target,15)/100 *20),10)
            changehumability(target,2,math.floor(getbaseinfo(target,16)/100 *20),10)
            changehumability(target,3,math.floor(getbaseinfo(target,17)/100 *20),10)
            changehumability(target,4,math.floor(getbaseinfo(target,18)/100 *20),10)
            sendattackeff(target,324,0,"*")
        end
    end
    --无双 身经百战
    timestamp = VarApi.getPlayerUIntVar(target,"U_80038_buff_cd_timestamp") 
    if hasbuff(target,80038) and cur_time-timestamp > 30 and not checkkuafu(target) then
        local max_hp = getbaseinfo(target,10)
        local cur_hp = getbaseinfo(target,9)
        if cur_hp < (max_hp * 0.3) then
            changehumnewvalue(target,23,100,5)
            VarApi.setPlayerUIntVar(target,"U_80038_buff_cd_timestamp",cur_time) 
            sendattackeff(target,338,0,"*")
        end
    end
    --无双 枯木逢春
    if hasbuff(target,80041) and math.random(100) <= 1  then
        local cur_hp = getbaseinfo(target,9)
        humanhp(actor,"+",math.floor(cur_hp * 0.01)) 
        sendattackeff(target,341,0,"*")
    end
    --无双 命运抵抗
    timestamp = VarApi.getPlayerUIntVar(target,"U_80044_buff_cd_timestamp") 
    if hasbuff(target,80044) and  cur_time - timestamp > 30 and math.random(100) <= 1 and not hasbuff(target,70012) and isplayer(hitter) then
        addbuff(target,70012,8)
        VarApi.setPlayerUIntVar(target,"U_80044_buff_cd_timestamp",cur_time) 
        sendattackeff(target,344,0,"*")
    end
    --无双 以守为攻
    if hasbuff(hitter,80048) and (getbuffinfo(hitter,70018,1) or 0) < 10 and isplayer(target) then
        addbuff(hitter,70018,3)
        sendattackeff(hitter,348,0,"*")
    end
    --无双 避其锋芒
    timestamp = VarApi.getPlayerUIntVar(target,"U_80032_buff_cd_timestamp") 
    if hasbuff(target,80032) and math.random(100) <= 1 and cur_time - timestamp > 30 then
        VarApi.setPlayerUIntVar(target,"U_80032_buff_cd_timestamp",cur_time) 
        changehumability(target,19, 200,10)
        sendattackeff(target,332,0,"*")
    end
end

--#region 人物被攻击前触发(打野刀神器额外buff)(受击对象，key)
function BeforeBeingAttackedTrigger.godEquipBuff(Target,key)
    local cdTime=VarApi.getPlayerUIntVar(Target,"U_godEquip_buff_cd"..(key)) --#region 当前神器cd
    local godEquipTab={
        ["43"]=function () --#region 反伤刺甲(防御) 
            addattlist(Target,"godEquip_buff_str_43","=","3#29#2",0)
            delaygoto(Target,8000,"del_godequip_str,43",0)
            Sendmsg9(Target,"00ff00","神器反伤刺甲【伤害反弹增加】2%，持续8秒！",1)
        end,
        ["44"]=function () --#region 不祥征兆
            addattlist(Target,"godEquip_buff_str_44","=","3#29#3",0)
            delaygoto(Target,10000,"del_godequip_str,44",0)
            Sendmsg9(Target,"00ff00","神器不祥征兆【伤害反弹增加】3%，持续10秒！",1)
        end,
        ["45"]=function () --#region 魔女斗篷
            addattlist(Target,"godEquip_buff_str_45","=","3#29#5",0)
            delaygoto(Target,15000,"del_godequip_str,45",0)
            Sendmsg9(Target,"00ff00","神器魔女斗篷【伤害反弹增加】5%，持续15秒！",1)
        end,
    }
    if os.time()-cdTime>30 and math.random(100)<20 then
        VarApi.setPlayerUIntVar(Target,"U_godEquip_buff_cd"..(key),os.time(),false)
        delattlist(Target,"godEquip_buff_str_"..key)
        godEquipTab[key]()
    end
end
--#region 装备变异,被攻击前(玩家对象，攻击对象，受击对象(玩家)，技能id，伤害)
function BeforeBeingAttackedTrigger.equipVariation1(actor,Hiter,Target,MagicId,Damage)
    local tab={"[法抗]","[反击]","[反震]","[神佑附体]","[幸运]"}
    local nowTrigger=tab[math.random(#tab)]
    local nowVariationTag=VarApi.getPlayerUIntVar(actor,"U_equipVariation_tag"..nowTrigger) --#region 当前拥有几个tag
    local variationTab={
        ["[法抗]"]=function ()
            if MagicId and MagicId~=0 then
                return math.floor(Damage*0.95)
            end
        end,
        ["[反击]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12701")
            if os.time()-cdTime>30 and math.random(100)<10 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12701",os.time(),false)
                humanhp(Hiter,"-",math.floor(Damage),0,0,actor,1,1)
                playeffect(Hiter,13457,0,0,1,0,0)
                return 1
            end
        end,
        ["[反震]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12702")
            if os.time()-cdTime>30 and math.random(100)<10 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12702",os.time(),false)
                humanhp(Hiter,"-",math.floor(getbaseinfo(actor,10)*0.005),0,0,actor,1,1)
                playeffect(Hiter,13459,0,0,1,0,0)
            end
        end,
        ["[神佑附体]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12717")
            if os.time()-cdTime>30 and math.random(100)<5 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12717",os.time(),false)
                humanhp(actor,"+",math.floor(getbaseinfo(actor,10)*0.1),0,0,actor,1,1)
                playeffect(actor,13456,0,0,1,0,0)
            end
        end,
        ["[幸运]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12718")
            if os.time()-cdTime>30 and math.random(100)<2 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12718",os.time(),false)
                playeffect(actor,13467,0,0,1,0,0)
                return 1
            end
        end,
    }
    if nowVariationTag>0 then
        return variationTab[nowTrigger]()
    end
end