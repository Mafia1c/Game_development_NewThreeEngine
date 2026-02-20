-- 攻击前触发
BeforeAttackTrigger = {}
BeforeAttackTrigger.filter_mons = {
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

-- 人物攻击前触发
--#region 人物攻击前触发(玩家对象，受击对象，攻击对象，技能id，伤害，当前攻击模式，return为修改后伤害)
function BeforeAttackTrigger.onPlayerAttack(actor, Target, Hiter, MagicId, Damage, Model)
    local is_player = isplayer(Target)
    -- 设置战斗状态  
    local cur_hp = getbaseinfo(Hiter, 9)
    local cur_time = os.time() 
    VarApi.setPlayerUIntVar(Hiter,"U_battele_time",cur_time+3)
    if is_player then --#region 为玩家
        if cur_hp > 0 then  -- 死人不加buff
            addbuff(Hiter, 50000)
        end
    else --#region 为怪物
        local mon_name = getbaseinfo(Target, 1)
        local map_id = getbaseinfo(Hiter, 3)
        if map_id == "地下矿洞" and string.find(mon_name or "", "矿石") then
            Damage = 0
            return Damage
        end

        if VarApi.getPlayerUIntVar(Hiter,"U_LayerUp")>0 and 
        (cur_time-VarApi.getPlayerUIntVar(actor,"U_LayerUpTime")>60) and math.random(100)<2 then --#region 境界飞升
            VarApi.setPlayerUIntVar(actor,"U_LayerUpTime",cur_time,false)
            makeposion(Target,5,2,0,1)
            sendmsg(actor, 1, '{"Msg":"【境界飞升】：将对方麻痹2s！","FColor":251,"BColor":0,"Type":6,"Time":1}')
        end

        if map_id == "世界boss" and mon_name == "终极大魔王" and GetSysInt("G_sjbs_moneychange_time") > cur_time then
            changeexp(Hiter,"+",10000,false)
            -- ChangeMoney(Hiter,4,"+",math.random(100,500),"攻击世界boss获得",true)
        elseif  map_id == "世界bosskf" and mon_name == "终极大魔王" and GetSysInt("G_kf_sjbs_moneychange_time") > cur_time then
            changeexp(Hiter,"+",20000,false)
            -- ChangeMoney(Hiter,4,"+",math.random(100,500),"攻击kf世界boss获得",true)
        elseif  (map_id == "行会战场" or map_id == "行会战场kf")  and mon_name == "行会大魔王" then
            if not hasbuff(Target,50004) then
                local players = getplaycount(map_id,1,1)
                local hanghui_name = ""
                for index, player in ipairs(type(players) == "table" and players or {}) do
                    if hanghui_name == "" then
                        hanghui_name = getbaseinfo(player,36) 
                    end
                    if hanghui_name ~= "" and hanghui_name ~= getbaseinfo(player,36)  then
                        sendcentermsg(actor,251,249,"当前地图存在其他行会成员，BOSS进入无敌状态！",4,1)
                        addbuff(Target,50004,3)
                    end
                end
            end
        end

        -- 只能打一点血的怪物
        if isInTable(BeforeAttackTrigger.filter_mons, getbaseinfo(Target, 1, 1)) then
            return 1
        end
    end

    Damage = BeforeAttackTrigger.UseMasterSkillTrigger(actor,Target,Hiter , MagicId,Damage)
    Damage = BeforeAttackTrigger.UseJobAwakeTrigger(actor,Target,Hiter , MagicId,Damage,Model)

    if VarApi.getPlayerTStrVar(Hiter,"T_godEquip_buff_key")~="" then --#region 打野刀神器额外buff
        BeforeAttackTrigger.godEquipBuff(actor, Target, Hiter, MagicId, Damage, Model)
    end
    BeforeAttackTrigger.drumChangeHp(actor,Hiter,Damage) --#region 军鼓吸血
    Damage = BeforeAttackTrigger.equipVariation1(actor, Target, Hiter, MagicId, Damage, Model)or Damage --#region 装备变异

    return Damage
end

--#region 宠物攻击伤害前触发(玩家对象,目标对象,宠物对象,技能id,伤害值,是否主目标,return 修改后伤害)
function BeforeAttackTrigger.attackdamagepet(actor,target,petObj,magicID,damage,isImportant)
    if isInTable(BeforeAttackTrigger.filter_mons, getbaseinfo(target, 1, 1)) then
        damage = 1
    end
    return damage
end

-- 宝宝攻击前触发
function BeforeAttackTrigger.onPetAttack(actor,target,hitter,magicId,damage)
    --道士 驱神
    if hitter and isnotnull(hitter) then
        local bb_name = getbaseinfo(hitter, 1) or ""
        if (string.find(bb_name, "白虎") or string.find(bb_name, "神兽") or string.find(bb_name, "月灵")) then
            if hasbuff(actor,60081) then
                -- 只能打一点血的怪物
                if isInTable(BeforeAttackTrigger.filter_mons, getbaseinfo(target, 1, 1)) then
                    damage = 0
                else
                    local ds_attack = getbaseinfo(actor,24)
                    damage = damage + (ds_attack * 0.5)
                end
                playeffect(actor,13430,0,0,1,0,0)
            end
        end
    end
    return damage
end

--玩家物理攻击/魔法攻击后触发 (玩家对象，受击对象，攻击对象，技能id)
--is_magicid 是否魔法攻击触发
function BeforeAttackTrigger.onTypePlayerAttack(actor,Target,Hiter,MagicId,is_magicid)
    if isInTable(BeforeAttackTrigger.filter_mons, getbaseinfo(Target, 1, 1)) then
        return
    end
    local cur_time = os.time() 
    if VarApi.getPlayerUIntVar(Hiter,"U_godEquip_xx")>0 then --#region 打野刀神器特殊属性吸血
        humanhp(Hiter,"+",VarApi.getPlayerUIntVar(Hiter,"U_godEquip_xx"),0,0,nil,nil,nil)
    end
    local timestamp = 0
    local is_immune = (isnotnull(Target) and ismon(Target) and getbaseinfo(Target,1) == "狂暴霸主")
    local job =  getbaseinfo(Hiter,7)
    if isnotnull(Target) and ismon(Target) and not is_immune then -- 攻击怪物
    
        -- 宠物汪星人 攻击boss时 20%触发幸运斩杀 斩杀boss最大生命值1%
        local mon_name = getbaseinfo(Target, 1)
        local isBoss = getdbmonfieldvalue(mon_name, "type")
        if hasbuff(Hiter, 50020) and (isBoss and isBoss >= 1) and math.random(100) < 2 then
            rangeharm(Hiter, getbaseinfo(Target, 4), getbaseinfo(Target, 5), 0, 0, 12, 1, 0, 2, 0, 1)
            Sendmsg9(Hiter, "ffff00", "装扮[[宠物]汪星人]触发幸运斩杀", 9)
        end
    elseif isnotnull(Target) and isplayer(Target) then--攻击玩家
         --无双血脉 以下犯上
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80000_buff_cd_timestamp") 
        if hasbuff(Hiter,80000) and cur_time - timestamp > 30  and getbaseinfo(Target,6) > getbaseinfo(Hiter,6) then
            VarApi.setPlayerUIntVar(Hiter,"U_80000_buff_cd_timestamp",cur_time) 
            addbuff(Hiter,70008,10,math.random(2,10))
            sendattackeff(Hiter,300,0,"*")
        end
        --无双 以恶制恶
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80002_buff_cd_timestamp") 
        if hasbuff(Hiter,80002) and cur_time - timestamp > 30  and math.random(100) <= 2  then
            VarApi.setPlayerUIntVar(Hiter,"U_80002_buff_cd_timestamp",cur_time) 
            addbuff(Target,70009,8,math.random(1,10))
            sendattackeff(Hiter,302,0,"*")
        end
        --无双 制裁之力
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80009_buff_cd_timestamp") 
        if hasbuff(Hiter,80009) and cur_time - timestamp > 30 and not hasbuff(Target,70010) then
            VarApi.setPlayerUIntVar(Hiter,"U_80009_buff_cd_timestamp",cur_time) 
            addbuff(Target,70010,10)
            sendattackeff(Target,309,0,"*")
        end
        --无双  看透一切
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80018_buff_cd_timestamp") 
        if hasbuff(Hiter,80018) and math.random(100) <= 2 and cur_time-timestamp > 30  then
            if VarApi.getPlayerUIntVar(Target,"U_spirit_level") < 1 then 
                VarApi.setPlayerUIntVar(Hiter,"U_80018_buff_cd_timestamp",cur_time) 
                local job = getbaseinfo(Hiter,7)
                local value = 0 
                if job == 0 then
                    value = getbaseinfo(Hiter,20)
                elseif job == 1 then
                    value = getbaseinfo(Hiter,22)
                else
                    value = getbaseinfo(Hiter,24)
                end
                humanhp(Target,"-",math.floor(value * 0.1) ) 
                sendattackeff(Target,318,0,"*")
            end
        end
        --无双 致命打击
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80050_buff_cd_timestamp") 
        if hasbuff(Hiter,80050) and cur_time - timestamp > 30  and math.random(100) <= 1 then
            VarApi.setPlayerUIntVar(Hiter,"U_80050_buff_cd_timestamp",cur_time) 
            changehumability(Target,2,- math.floor(getbaseinfo(Target,16)*0.3), 10)
            changehumability(Target,4,- math.floor(getbaseinfo(Target,18)*0.3),10)
            sendattackeff(Hiter,350,0,"*")
        end

         --无双 我比你大
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80051_buff_cd_timestamp") 
        if hasbuff(Hiter,80051) and cur_time - timestamp > 30  and getbaseinfo(Hiter,6) > getbaseinfo(Target,6) then
            changehumability(Target,11,-math.floor(getbaseinfo(Target,10)*0.1),10)
            VarApi.setPlayerUIntVar(Hiter,"U_80051_buff_cd_timestamp",cur_time) 
            sendattackeff(Hiter,351,0,"*")
        end
    end

    if isnotnull(Target) and isnotnull(Hiter) and not is_immune  then
        -- 吸星大法buff
        if (hasbuff(Hiter, 50008) or hasbuff(Hiter, 50022)) and not hasbuff(Target, 80058) then
            local job = getbaseinfo(Hiter, 7)
            if job == 0 or job == 1 then
                makeposion(Target, 0, 10, 3, 1)
            end
        end
        --血脉 毒牙
        if hasbuff(Hiter,60015) then
            local layer = getbuffinfo(Hiter,60015,1)
            makeposion(Target,0,3,layer *10,1)
        end
        --无双 我本沉默
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80007_buff_cd_timestamp") 
        if hasbuff(Hiter,80007) and cur_time - timestamp > 30 and not hasbuff(Target,50003) and math.random(100) <=2 then
            if VarApi.getPlayerUIntVar(Target,"U_spirit_level") <= 0 then 
                VarApi.setPlayerUIntVar(Hiter,"U_80007_buff_cd_timestamp",cur_time) 
                addbuff(Target,50003,math.random(5))
                sendattackeff(Target,307,0,"*")
            end
        end
        --无双 妙影无踪
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80020_buff_cd_timestamp") 
        if hasbuff(Hiter,80020) and cur_time- timestamp > 30 and math.random(100) <= 2 then
            VarApi.setPlayerUIntVar(Hiter,"U_80020_buff_cd_timestamp",cur_time) 
            changemode(Hiter,2,3)
            sendattackeff(Target,320,0,"*")
        end
        --无双 独来独往
          timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80022_buff_cd_timestamp") 
        if hasbuff(Hiter,80022) and math.random(100) <= 1 and cur_time - timestamp > 60 and getbaseinfo(actor,35) <= 0 and not hasbuff(Hiter,70017) then
            VarApi.setPlayerUIntVar(Hiter,"U_80022_buff_cd_timestamp",cur_time) 
            addbuff(Hiter,70017,5)
            sendattackeff(Target,322,0,"*")
        end
        if job == 0 then
            --天剑
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60065_buff_cd_timestamp") 
            if hasbuff(Hiter,60065) and math.random(100) <= 1 and cur_time - timestamp > 120 then
                VarApi.setPlayerUIntVar(Hiter,"U_60065_buff_cd_timestamp",cur_time)
                local max_attack = getbaseinfo(Hiter,20)
                changemode(Target,10,2)
                humanhp(Target,"-",math.floor(max_attack*3))
                playeffect(Target,13414,0,0,1,0,0)
                playeffect(Target,52,0,0,3,0,0)
            end

              --链舞
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60058_buff_cd_timestamp") 
            if hasbuff(Hiter,60058) and math.random(100) <= 1 and cur_time - timestamp > 30 then
                VarApi.setPlayerUIntVar(Hiter,"U_60058_buff_cd_timestamp",cur_time) 
                playeffect(Target,13407,0,0,1,0,0)
                local max_attack = getbaseinfo(Hiter,20)
                BeforeAttackTrigger.RangeHarmDamage(Hiter,Target,10,2,0,0,max_attack*2)
            end

            --千钧
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60060_buff_cd_timestamp") 
            local cur_hp = getbaseinfo(Target, 9)
            local max_hp = getbaseinfo(Target, 10)
            if hasbuff(Hiter,60060) and  math.random(100) <= 1 and (cur_hp > max_hp * 0.8) and cur_time - timestamp > 120  then
                local is_trigger = false
                if (ismon(Target) and GetInt(5,Target,"U_has_trigger") <= 0) then
                    is_trigger = true
                    SetInt(5,Target,"U_has_trigger",1)
                elseif not ismon(Target) then
                    is_trigger = true
                end
                if is_trigger then
                    VarApi.setPlayerUIntVar(Hiter,"U_60060_buff_cd_timestamp",cur_time) 
                    local x, y = getbaseinfo(Target, 4), getbaseinfo(Target, 5)
                    local cur_hp = getbaseinfo(Target,9)
                    humanhp(Target,"-",math.floor(cur_hp *0.2))
                    rangeharm(Hiter,x,y,0,0,1,2)
                    playeffect(Target,13409,0,0,1,0,0)
                end
            end

            --剑罡
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60064_buff_cd_timestamp") 
            if hasbuff(Hiter,60064) and cur_time - timestamp > 120 then
                addbuff(Hiter,70027,10)
                local layer = getbuffinfo(Hiter,70027,1)
                if layer and layer >= 10 then
                    VarApi.setPlayerUIntVar(Hiter,"U_60064_buff_cd_timestamp",cur_time) 
                end
                playeffect(Hiter,13413,0,0,1,0,0)
            end
            

        elseif job == 1 then
            --法师 烈焰
            if hasbuff(Hiter,60066) and math.random(100)<=1 and not hasbuff(Target,70024) then
                addbuff(Target,70024,3)
                playeffect(Target,13415,0,0,1,0,0)
            end
            --法师 寒髓
            if hasbuff(Hiter,60067) and math.random(100)<=1 then
                local x, y = getbaseinfo(Target, 4), getbaseinfo(Target, 5)
                if isplayer(Target) then
                    local target_lv = getbaseinfo(Target,6)
                    local self_lv = getbaseinfo(Hiter,6)
                    if self_lv > target_lv then
                        rangeharm(Hiter,x,y,0,0,2,2,0,0,-1,1)
                        playeffect(Hiter,13416,0,0,1,0,0)
                    end
                else
                    rangeharm(Hiter,x,y,0,0,2,2,0,0,-1,1)
                    playeffect(Hiter,13416,0,0,1,0,0)
                end
            end

            --法师 蚀骨
            if hasbuff(Hiter,60071) and math.random(100) <= 1  then
                local mf_attack = getbaseinfo(Hiter,22) 
                makeposion(Target,0,3,mf_attack,1)
                playeffect(Target,13420,0,0,1,0,0)
            end
        
            --法师 魔藤
            if hasbuff(Hiter,60073) and math.random(100)<=1 then
                local x, y = getbaseinfo(Target, 4), getbaseinfo(Target, 5)
                if isplayer(Target) then
                    local target_lv = getbaseinfo(Target,6)
                    local self_lv = getbaseinfo(Hiter,6)
                    if self_lv > target_lv then
                        changemode(Target,11, 2, 1, 0)
                        playeffect(Target,13422,0,0,1,0,0)
                    end
                else
                    changemode(Target,11, 2, 1, 0)
                    playeffect(Target,13422,0,0,1,0,0)
                end
            end
        elseif job == 2 then
             --道士 八卦阵
            if hasbuff(Hiter,60084) and MagicId == 13 and math.random(100) <= 1 then
                local x, y = getbaseinfo(Target, 4), getbaseinfo(Target, 5)
                local effect_type = math.random(3)
                rangeharm(Hiter,x,y,0,0,effect_type,1,1,0,-1,1)
                playeffect(Hiter,13433,0,0,1,0,0)
            end
            --道士 禁魔
            if hasbuff(Hiter,60087) and math.random(100) <= 1 then
                if ismon(Target)  then
                    makeposion(Target,12,3)
                elseif isplayer(Target) then
                    humanmp(Target,"=",0)
                end
                playeffect(Hiter,13436,0,0,1,0,0)
            end

            --道士 逆转
            if hasbuff(Hiter,60088) then
                local mp = getbaseinfo(Hiter,11)
                humanhp(Target,"-",mp)
                playeffect(Hiter,13437,0,0,1,0,0)
            end 
            if MagicId and is_magicid then
                timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60095_buff_cd_timestamp") 
                --道士 万毒体
                if hasbuff(Hiter,60095) and cur_time-timestamp > 60 then
                    local acttack = getbaseinfo(Hiter,24)
                    BeforeAttackTrigger.RangeHarmDamage(Hiter,Target,6,2,0,0,acttack,13444,1)
                    VarApi.setPlayerUIntVar(Hiter,"U_60095_buff_cd_timestamp",cur_time) 
                end
            end
        end
        
        --无双 先发至人
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80026_buff_cd_timestamp") 
        if hasbuff(Hiter,80026) and math.random(100)<= 2 and cur_time-timestamp > 30 then
            if VarApi.getPlayerUIntVar(Target,"U_spirit_level") < 3 then 
                VarApi.setPlayerUIntVar(Hiter,"U_80026_buff_cd_timestamp",cur_time) 
                changemode(Target,10,math.random(3))
                sendattackeff(Target,326,0,"*")
            end
        end
       
        --无双 兵器精通 10秒内
        if hasbuff(Hiter,100003) then
            local weapon = GetItemByPos(Hiter, 1)
            local itemid = getiteminfo(Hiter,weapon,2)
            if itemid then
                local job = getbaseinfo(Hiter,7)
                local value = getstditematt(itemid, job * 2 + 4)
                humanhp(Target,"-",value)
            end
        end
        --无双 雪上加霜
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80052_buff_cd_timestamp") 
        if hasbuff(Hiter,80052) and Model == 1 and cur_time - timestamp > 30 then
            VarApi.setPlayerUIntVar(Hiter,"U_80052_buff_cd_timestamp",cur_time) 
            changehumability(Target,2,- math.floor(getbaseinfo(Target,16)*0.5), 10)
            changehumability(Target,4,- math.floor(getbaseinfo(Target,18)*0.5),10)
            sendattackeff(Target,352,0,"*")
        end

        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_god_beast_buff_cd_timestamp") 
        if checktitle(Hiter,"30星兽魂BUFF") and math.random(100) <= 1 and cur_time - timestamp > 30 then
            makeposion(Target,12,1,0,1)
            sendmsg(Hiter, 1, '{"Msg":"【30星兽魂buff】：将对方冰冻1s！","FColor":251,"BColor":0,"Type":6,"Time":1}')
            VarApi.setPlayerUIntVar(Hiter,"U_god_beast_buff_cd_timestamp",cur_time)
        end

        if checktitle(Hiter,"45星兽魂BUFF") and math.random(100) <= 2 and cur_time - timestamp > 30 then
            makeposion(Target,12,2,0,1)
            sendmsg(Hiter, 1, '{"Msg":"【45星兽魂buff】：将对方冰冻2s！","FColor":251,"BColor":0,"Type":6,"Time":1}')
            VarApi.setPlayerUIntVar(Hiter,"U_god_beast_buff_cd_timestamp",cur_time)
        end

        if checktitle(Hiter,"60星兽魂BUFF") and math.random(100) <= 3 and cur_time - timestamp > 30 then
            makeposion(Target,12,3,0,1)
            sendmsg(Hiter, 1, '{"Msg":"【60星兽魂buff】：将对方冰冻3s！","FColor":251,"BColor":0,"Type":6,"Time":1}')
            VarApi.setPlayerUIntVar(Hiter,"U_god_beast_buff_cd_timestamp",cur_time)
        end
        if MagicId  then  --烈火
            local level = getskillinfo(Hiter, MagicId, 2)
            if math.random(100) <= 1 and level and  level > 0 then
                if MagicId == 26 then
                    if not hasbuff(Hiter, 70020) then
                        addbuff(Target,70020,3) 
                    end
                    sendattackeff(Hiter,502,0,"*")
                elseif MagicId == 66 then --开天
                    changemode(Target,10,1)
                    sendattackeff(Hiter,503,0,"*")
                elseif MagicId == 22 then  --火墙
                    if not hasbuff(Target,70021) then
                        addbuff(Target,70021,3,0,1) 
                    end
                    makeposion(Target,0,3)
                    sendattackeff(Hiter,511,0,"*")
                end
            end
        end
    end

    if isnotnull(Hiter) and not is_immune then
        --无双 血色契约
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80034_buff_cd_timestamp") 
        if hasbuff(Hiter,80034) and math.random(100) <=1 and not hasbuff(Hiter,70016) and cur_time-timestamp > 30 then
            VarApi.setPlayerUIntVar(Hiter,"U_80034_buff_cd_timestamp",cur_time) 
            addbuff(Hiter,70016,10)
            sendattackeff(Hiter,334,0,"*")
        end
    
        --无双 兵器精通
        timestamp = VarApi.getPlayerUIntVar(Hiter,"U_80049_buff_cd_timestamp") 
        if hasbuff(Hiter,80049) and math.random(100)<= 10 and cur_time-timestamp > 30  then
            local weapon = GetItemByPos(Hiter, 1)
            local itemid = getiteminfo(Hiter,weapon,2)
            if itemid then
                VarApi.setPlayerUIntVar(Hiter,"U_80049_buff_cd_timestamp",cur_time) 
                sendattackeff(Hiter,349,0,"*")
                addbuff(Hiter,100003,10)
            end
        end
        if job == 1 then
            --法师 祷言
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60078_buff_cd_timestamp") 
            if is_magicid and  not checkkuafu(Hiter) and hasbuff(Hiter,60078) and cur_time - timestamp > 60  then
                addbuff(Hiter,70025,5) 
                local layer = getbuffinfo(Hiter,70025,1)
                if layer and layer <= 1 then
                    VarApi.setPlayerUIntVar(Hiter,"U_60078_buff_layer_timestamp",cur_time + 5) 
                end
                local layer_time = VarApi.getPlayerUIntVar(Hiter,"U_60078_buff_layer_timestamp") 
                if layer_time - cur_time <= 0 then
                    VarApi.setPlayerUIntVar(Hiter,"U_60078_buff_cd_timestamp",cur_time) 
                end
                playeffect(Hiter,13427,0,0,1,0,0)
            end
        elseif job == 2 then
            if MagicId and is_magicid then
                --道士 毒瘴
               timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60091_buff_cd_timestamp") 
               if hasbuff(Hiter,60091) and cur_time - timestamp > 5 and math.random(100) <= 1 then
                   VarApi.setPlayerUIntVar(Hiter,"U_60091_buff_cd_timestamp",cur_time) 
                   buff_60091_fun(actor)
                   delaygoto(actor,1000,"@buff_60091_fun")
                   delaygoto(actor,2000,"@buff_60091_fun")
                   playeffect(Hiter,13440,0,0,1,0,0)
               end
            end
        end
    end
    local class = IncludeNpcClass("MapCruise")
    if class then
        class:CheckCanRandomMap(Hiter)
    end
    BeforeAttackTrigger.equipVariation2(actor,Target,Hiter,MagicId,is_magicid) --#region 装备变异
end
-- 强化技能触发
function BeforeAttackTrigger.UseMasterSkillTrigger(actor,Target,Hiter,MagicId,Damage)
    local is_immune = (isnotnull(Target) and ismon(Target) and getbaseinfo(Target,1) == "狂暴霸主")
    if is_immune then return end
    local level = getskillinfo(Hiter, MagicId, 2)
    if level == nil then return Damage end
    if VarApi.getPlayerUIntVar(actor,"U_equipVariation_tag[魔心]")>0 then
        Damage=math.floor(Damage*1.05)
    end
    local odds = 0
    if level >= 3 then
        odds = 1
    end
    if math.random(100) <= odds and level > 0 then
        if MagicId == 12 then  --刺杀剑术
            Damage = Damage + Damage * 1.5
            sendattackeff(Hiter,501,0,"*")
        elseif MagicId == 56 then  --逐日
            local cur_hp = getbaseinfo(Target,9)
            Damage =Damage + cur_hp * 0.2
            local max_hp = getbaseinfo(Hiter,10)
            humanhp(Hiter,"+",math.floor(max_hp*0.1) )
            sendattackeff(Hiter,504,0,"*")
        elseif MagicId == 45 then --灭天火
            local max_hp = getbaseinfo(Target,10)
            local self_max_hp = getbaseinfo(Hiter,10)
            Damage = Damage +  max_hp * 0.05
            playeffect(Target,121,0,0,1,0,0)
            humanhp(Hiter,"+",math.floor(self_max_hp*0.1) )
            sendattackeff(Hiter,513,0,"*")
        elseif MagicId == 58 then --流星火雨
            BeforeAttackTrigger.RangeHarmDamage(Hiter,Target,6,3,0,0,Damage,2)
            sendattackeff(Hiter,514,0,"*")
        elseif  MagicId == 13 then --灵魂火符
            changemode(Target,11,1,1,1)
            BeforeAttackTrigger.RangeHarmDamage(Hiter,Target,5,3,0,0,Damage,1100,0)
            sendattackeff(Hiter,522,0,"*")
        elseif MagicId == 52 and ismon(Target) then --飓风破
            local num = 0
            if level >= 9 then
                num = 9
            elseif level >= 6 then
                num = 6
            elseif level >= 3 then
                num = 3
            end
            local x, y = getbaseinfo(Hiter, 4), getbaseinfo(Hiter, 5)
            rangeharm(Hiter,x,y,10,0,1,1,0,0,512,num)
            sendattackeff(Hiter,524,0,"*")
        end
    end
    return Damage
end
function BeforeAttackTrigger.UseJobAwakeTrigger(actor,Target,Hiter,MagicId,Damage,Model)
    local is_immune = (isnotnull(Target) and ismon(Target) and getbaseinfo(Target,1) == "狂暴霸主")
    if not is_immune then
        local timestamp = 0
        local cur_time = os.time()
        local job = getbaseinfo(Hiter,7)
        if job == 0 then
            --战士血怒
            if hasbuff(Hiter,60051) and math.random(100) <= 1 then  
                local max_hp = getbaseinfo(Hiter,10)
                local cur_hp = getbaseinfo(Hiter,9)
                local num = math.floor((max_hp - cur_hp) / (max_hp * 0.05)) 
                if num > 0 then
                    num = num  > 10 and 10 or num
                    local target_cur_hp = getbaseinfo(Target,9)
                    Damage = Damage + ((num /100) * target_cur_hp)
                    playeffect(Hiter,13400,0,0,1,0,0)
                end
            end
            --无尽怒火
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60055_buff_cd_timestamp") 
            if hasbuff(Hiter, 60055) and cur_time - timestamp > 30 then 
                VarApi.setPlayerUIntVar(Hiter,"U_60055_buff_cd_timestamp",cur_time) 
                addbuff(Hiter,70023,10)
                playeffect(Hiter,13404,0,0,1,0,0)
            end
             --双流
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60057_buff_cd_timestamp") 
            if hasbuff(Hiter,60057) and math.random(100) <= 1 and cur_time - timestamp > 30 then 
                VarApi.setPlayerUIntVar(Hiter,"U_60057_buff_cd_timestamp",cur_time) 
                Damage = Damage * 2
                playeffect(Hiter,13406,0,0,1,0,0)
            end

            --剑心
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60061_buff_cd_timestamp") 
            if hasbuff(Hiter,60061) and cur_time - timestamp > 120 then
                addbuff(Hiter,70029,10)
                local layer = getbuffinfo(Hiter,70029,1)
                if layer and layer >= 10 then
                    VarApi.setPlayerUIntVar(Hiter,"U_60061_buff_cd_timestamp",cur_time) 
                end
                playeffect(Target,13410,0,0,1,0,0)
            end
            --分影
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60063_buff_cd_timestamp") 
            if hasbuff(Hiter,60063) and  math.random(100) <= 1 and cur_time - timestamp > 120 and #clonelist(Hiter) < 1 then
                recallself(actor,30,1,100)
                VarApi.setPlayerUIntVar(Hiter,"U_60063_buff_cd_timestamp",cur_time) 
                playeffect(Hiter,13412,0,0,1,0,0)
            end
            
            --重刃
            if hasbuff(Hiter, 60056) then 
                if GetItemByPos(actor,1) ~= "0" then
                    local attr_str = getitemattidvalue(actor,2,4,1)
                    Damage = Damage + tonumber(attr_str) or 0 
                    playeffect(Target,13405,0,0,1,0,0)
                end
            end
        elseif job == 1 then
            --法师 雷域
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60068_buff_cd_timestamp") 
            if hasbuff(Hiter,60068) and math.random(100) <= 1 and cur_time - timestamp > 60 then
                VarApi.setPlayerUIntVar(Hiter,"U_60068_buff_cd_timestamp",cur_time)
                local radom_value = math.random(5,10)
                BeforeAttackTrigger.RangeHarmDamage(Hiter,Target,6,2,0,0,Damage*(radom_value/10),1042,0)
                playeffect(Hiter,13417,0,0,1,0,0)
            end
            --法师 法神附体
            timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60070_buff_cd_timestamp") 
            if hasbuff(Hiter,60070) and math.random(100) <= 1 and cur_time - timestamp > 30 then
                VarApi.setPlayerUIntVar(Hiter,"U_60070_buff_cd_timestamp",cur_time)
                playeffect(Target,13419,0,0,1,0,0)
                Damage = Damage * 2
            end
             --法师 圣愈
            if hasbuff(Hiter,60076) and math.random(100)<=1 then
                humanhp(Hiter,"+",math.floor(Damage*0.1) )
                playeffect(Hiter,13425,0,0,1,0,0)
            end
        elseif job == 2 then
            if MagicId and isInTable({13,86,52},MagicId) then
                --道士 乾坤颠倒
                timestamp = VarApi.getPlayerUIntVar(Hiter,"U_60090_buff_cd_timestamp") 
                if hasbuff(Hiter,60090) and cur_time - timestamp > 5 then
                    BeforeAttackTrigger.RangeHarmDamage(Hiter,Target,6,4,0,0,Damage*2,536,2)
                    VarApi.setPlayerUIntVar(Hiter,"U_60090_buff_cd_timestamp",cur_time) 
                    playeffect(Hiter,104,0,0,2,0,0)
                end
            end
            --道士 蚀体
            if hasbuff(Hiter,60092) and checkhumanstate(Target,11,0) then
                BeforeAttackTrigger.RangeHarmDamage(Hiter,Target,1,6,0,0,math.floor(Damage * 0.2))
                playeffect(Target,13441,0,0,1,0,0)
            end
        end
    end
    ---------------------------血脉buff------------------------
    return Damage
end
function buff_60091_fun(actor)
    BeforeAttackTrigger.RangeHarmDamage(actor,actor,10,3,0,0,getbaseinfo(actor,24),1060,0)
end

--#region 人物攻击前触发(打野刀神器额外buff)(玩家对象，受击对象，攻击对象，技能id，伤害，当前攻击模式)
function BeforeAttackTrigger.godEquipBuff(actor, Target, Hiter, MagicId, Damage, Model)
    local key=VarApi.getPlayerTStrVar(Hiter,"T_godEquip_buff_key")
    local godEquipTab={
        ["13"]=function () --#region 暗影巨斧(穿透)
            addattlist(Hiter,"godEquip_buff_str_13","=","3#28#3",0)
            delaygoto(Hiter,8000,"del_godequip_str,13",0)
            Sendmsg9(Hiter,"00ff00","神器暗影巨斧【忽视目标防御】3%，持续8秒！",1)
        end,
        ["14"]=function () --#region 制裁之刃
            addattlist(Hiter,"godEquip_buff_str_14","=","3#28#5",0)
            delaygoto(Hiter,10000,"del_godequip_str,14",0)
            Sendmsg9(Hiter,"00ff00","神器制裁之刃【忽视目标防御】5%，持续10秒！",1)
        end,
        ["15"]=function () --#region 破军战刃
            addattlist(Hiter,"godEquip_buff_str_15","=","3#28#8",0)
            delaygoto(Hiter,15000,"del_godequip_str,15",0)
            Sendmsg9(Hiter,"00ff00","神器破军战刃【忽视目标防御】8%，持续15秒！",1)
        end,
        ["23"]=function () --#region 闪电巨剑(暴伤)
            addattlist(Hiter,"godEquip_buff_str_23","=","3#22#3",0)
            delaygoto(Hiter,8000,"del_godequip_str,23",0)
            Sendmsg9(Hiter,"00ff00","神器闪电巨剑【暴击伤害增加】3%，持续8秒！",1)
        end,
        ["24"]=function () --#region 破魔刀
            addattlist(Hiter,"godEquip_buff_str_24","=","3#22#5",0)
            delaygoto(Hiter,10000,"del_godequip_str,24",0)
            Sendmsg9(Hiter,"00ff00","神器破魔刀【暴击伤害增加】5%，持续10秒！",1)
        end,
        ["25"]=function () --#region 无尽战刃
            addattlist(Hiter,"godEquip_buff_str_25","=","3#22#8",0)
            delaygoto(Hiter,15000,"del_godequip_str,25",0)
            Sendmsg9(Hiter,"00ff00","神器无尽战刃【暴击伤害增加】8%，持续15秒！",1)
        end,
        ["33"]=function () --#region 末世之刃(吸血)
            addattlist(Hiter,"godEquip_buff_str_33","=","3#34#100",0)
            delaygoto(Hiter,8000,"del_godequip_str,33",0)
            Sendmsg9(Hiter,"00ff00","神器末世之刃【吸血增加】1%，持续8秒！",1)
        end,
        ["34"]=function () --#region 饮血刀
            addattlist(Hiter,"godEquip_buff_str_34","=","3#34#200",0)
            delaygoto(Hiter,10000,"del_godequip_str,34",0)
            Sendmsg9(Hiter,"00ff00","神器饮血刀【吸血增加】2%，持续10秒！",1)
        end,
        ["35"]=function () --#region 破晓
            addattlist(Hiter,"godEquip_buff_str_35","=","3#34#300",0)
            delaygoto(Hiter,15000,"del_godequip_str,35",0)
            Sendmsg9(Hiter,"00ff00","神器破晓【吸血增加】3%，持续15秒！",1)
        end,
        ["63"]=function () --#region 逐日之弓(攻速)
            addattlist(Hiter,"godEquip_buff_str_63","=","3#25#3",0)
            delaygoto(Hiter,8000,"del_godequip_str,63",0)
            Sendmsg9(Hiter,"00ff00","神器逐日之弓【攻击伤害加】3%，持续8秒！",1)
        end,
        ["64"]=function () --#region 影刃
            addattlist(Hiter,"godEquip_buff_str_64","=","3#25#5",0)
            delaygoto(Hiter,10000,"del_godequip_str,64",0)
            Sendmsg9(Hiter,"00ff00","神器影刃【攻击伤害加】5%，持续10秒！",1)
        end,
        ["65"]=function () --#region 纯净苍穹
            addattlist(Hiter,"godEquip_buff_str_65","=","3#25#8",0)
            delaygoto(Hiter,15000,"del_godequip_str,65",0)
            Sendmsg9(Hiter,"00ff00","神器纯净苍穹【攻击伤害加】8%，持续15秒！",1)
        end,
    }
    local cdTime=VarApi.getPlayerUIntVar(Hiter,"U_godEquip_buff_cd"..(key)) --#region 当前神器cd
    if godEquipTab[key] and os.time()-cdTime>30 and math.random(100)<20 then
        VarApi.setPlayerUIntVar(Hiter,"U_godEquip_buff_cd"..(key),os.time(),false)
        delattlist(Hiter,"godEquip_buff_str_"..key)
        godEquipTab[key]()
    end
end
function del_godequip_str(actor,key) --#region 延迟删打野刀神器buff
    delattlist(actor,"godEquip_buff_str_"..key)
end
function BeforeAttackTrigger.drumChangeHp(actor,Hiter,Damage) --#region 军鼓吸血
    if not isplayer(Hiter) then return end
    local makeIndex=GetItemByPos(Hiter,14)
    if makeIndex=="0" then return end
    local att360=getconst(actor,"<$CUSTABIL[360]>")
    local tab={
        ["军鼓·Lv1"] = function () humanhp(Hiter,"+",math.floor(att360+(att360*0.05)),0,0,nil,nil,nil) end,
        ["军鼓·Lv2"] = function () humanhp(Hiter,"+",math.floor(att360+(att360*0.06)),0,0,nil,nil,nil) end,
        ["军鼓·Lv3"] = function () humanhp(Hiter,"+",math.floor(att360+(att360*0.07)),0,0,nil,nil,nil) end,
        ["军鼓·Lv4"] = function () humanhp(Hiter,"+",math.floor(att360+(att360*0.08)),0,0,nil,nil,nil) end,
        ["军鼓·Lv5"] = function () humanhp(Hiter,"+",math.floor(att360+(att360*0.1)),0,0,nil,nil,nil) end,
        ["军鼓·Lv6"] = function () humanhp(Hiter,"+",math.floor(att360+(att360*0.12)),0,0,nil,nil,nil) end,
        ["军鼓·Lv7"] = function () humanhp(Hiter,"+",math.floor(att360+(att360*0.14)),0,0,nil,nil,nil) end,
        ["军鼓·Lv8"] = function () humanhp(Hiter,"+",math.floor(att360+(att360*0.16)),0,0,nil,nil,nil) end,
        ["军鼓·Lv9"] = function () humanhp(Hiter,"+",math.floor(att360+(att360*0.18)),0,0,nil,nil,nil) end,
        ["终极军鼓"] = function () humanhp(Hiter,"+",math.floor(att360+(att360*0.2)),0,0,nil,nil,nil) end,
    }
    if tab[getiteminfo(Hiter,makeIndex,7)] then
        tab[getiteminfo(Hiter,makeIndex,7)]()
    end
end
--#region 装备变异,攻击前(玩家对象，受击对象，攻击对象，技能id，伤害，当前攻击模式，return为修改后伤害)
function BeforeAttackTrigger.equipVariation1(actor, Target, Hiter, MagicId, Damage, Model)
    local tab={"[连击]","[必杀]","[法术连击]","[剧毒]","[雷击]","[烈焰]","[偷袭]","[隐身]","[堡垒击破]","[奔雷击]","[地狱烈焰]","[剑荡八方]","[惊天一剑]","[力劈华山]","[善恶有报]","[上古符咒]","[死亡召唤]"}
    local nowTrigger=tab[math.random(#tab)] --#region 本次触发
    local nowVariationTag=VarApi.getPlayerUIntVar(actor,"U_equipVariation_tag"..nowTrigger) --#region 当前拥有几个tag
    local variationTab={
        ["[连击]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12735")
            if os.time()-cdTime>20 and MagicId==0 and math.random(100)<5 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12735",os.time(),false)
                humanhp(Target,"-",math.floor(Damage),0,0,actor,1,1)
                playeffect(Target,13460,0,0,1,0,0)
            end
        end,
    }
    VarApi.setPlayerTStrVar(actor,"T_attack_equipVariation",nowTrigger,false) --#region 当前触发buff(攻击)
    if variationTab[nowTrigger] and nowVariationTag>0 then
        return variationTab[nowTrigger]()
    end
end
--#region 装备变异,物理魔法攻击后(玩家对象，受击对象，攻击对象，技能id，伤害，当前攻击模式，return为修改后伤害)
function BeforeAttackTrigger.equipVariation2(actor,Target,Hiter,MagicId,is_magicid)
    if VarApi.getPlayerUIntVar(actor,"U_equipVariation_tag[冥想]")>0 then
        delbuff(actor,40207)
        addbuff(actor,40207,1)
    end
    if VarApi.getPlayerUIntVar(actor,"U_equipVariation_tag[再生]")>0 then
        delbuff(actor,40209)
        addbuff(actor,40209,1)
    end
    local allAttrSum=getbaseinfo(actor,20)+getbaseinfo(actor,22)+getbaseinfo(actor,24) --#region 攻魔道总和
    local mainAttrSum=0 --#region 主属性上限
    if getbaseinfo(actor,7)==0 then
        mainAttrSum=getbaseinfo(actor,20)
    elseif getbaseinfo(actor,7)==1 then
        mainAttrSum=getbaseinfo(actor,22)
    elseif getbaseinfo(actor,7)==2 then
        mainAttrSum=getbaseinfo(actor,24)
    end
    local variationTab={
        ["[必杀]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12722")
            if os.time()-cdTime>30 and math.random(100)<5 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12722",os.time(),false)
                changehumnewvalue(actor,21,100,3)
                playeffect(Target,13476,0,0,1,0,0)
            end
        end,
        ["[法术连击]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12723")
            if os.time()-cdTime>30 and is_magicid and MagicId and MagicId~=0 and math.random(100)<10 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12723",os.time(),false)
                releasemagic(actor,MagicId,2,3,1,1)
                playeffect(actor,13441,0,0,1,0,0)
            end
        end,
        ["[剧毒]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12733")
            if os.time()-cdTime>30 and isplayer(Target) and math.random(100)<3 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12733",os.time(),false)
                makeposion(Target,0,5,3,1)
                for i = 1, 5 do
                    humanhp(Target,"-",math.floor(getbaseinfo(Target,10)*0.03),0,i,actor,1,1)
                end
                playeffect(Target,13475,0,0,1,0,0)
            end
        end,
        ["[雷击]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12734")
            if os.time()-cdTime>10 and math.random(100)<10 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12734",os.time(),false)
                releasemagic(actor,11,2,3,1,1)
                humanhp(Target,"-",math.floor(mainAttrSum*0.8),0,0,actor,1,1)
                playeffect(Target,43024,0,0,1,0,0)
            end
        end,
        ["[烈焰]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12736")
            if os.time()-cdTime>10 and math.random(100)<10 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12736",os.time(),false)
                releasemagic(actor,11,2,3,1,1)
                humanhp(Target,"-",math.floor(mainAttrSum*0.8),0,0,actor,1,1)
                playeffect(Target,13507,0,0,1,0,0)
            end
        end,
        ["[偷袭]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12741")
            if isplayer(Target) and os.time()-cdTime>30 then
                local nowHp=getbaseinfo(Target,9)
                local maxHp=getbaseinfo(Target,10)
                if nowHp>maxHp*0.8 then
                    VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12741",os.time(),false)
                    humanhp(Target,"-",math.floor(maxHp*0.05),0,0,actor,1,1)
                    playeffect(Target,13508,0,0,1,0,0)
                end
            end
        end,
        ["[隐身]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12743")
            if isplayer(Target) and os.time()-cdTime>30 and math.random(100)<5 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12743",os.time(),false)
                playeffect(actor,13425,0,0,1,0,0)
                changemode(actor,2,2,nil,nil)
            end
        end,
        ["[堡垒击破]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12744")
            if os.time()-cdTime>30 and math.random(100)<5 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12744",os.time(),false)
                playeffect(actor,13425,0,0,1,0,0)
                addattlist(Hiter,"godEquip_buff_str_12744","=","3#28#50",0)
                delaygoto(actor,5000,"del_godequip_str,"..12744,0)
            end
        end,
        ["[奔雷击]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12745")
            if os.time()-cdTime>30 and math.random(100)<10 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12745",os.time(),false)
                releasemagic(actor,37,2,3,1,1)
                local allObject={}
                for key, value in pairs(getobjectinmap(getbaseinfo(Hiter,3),getbaseinfo(Hiter,4),getbaseinfo(Hiter,5),3,1)) do
                    if value~=actor then
                        table.insert(allObject,value)
                    end
                end
                for key, value in pairs(getobjectinmap(getbaseinfo(Hiter,3),getbaseinfo(Hiter,4),getbaseinfo(Hiter,5),3,2)) do
                    table.insert(allObject,value)
                end
                for key, value in pairs(allObject) do
                    humanhp(value,"-",math.floor(allAttrSum*0.5),0,0,actor,1,1)
                    playeffect(value,43033,0,0,1,0,0)
                end
            end
        end,
        ["[地狱烈焰]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12746")
            if os.time()-cdTime>30 and math.random(100)<10 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12746",os.time(),false)
                releasemagic(actor,58,2,3,1,1)
                local allObject={}
                for key, value in pairs(getobjectinmap(getbaseinfo(Hiter,3),getbaseinfo(Hiter,4),getbaseinfo(Hiter,5),3,1)) do
                    if value~=actor then
                        table.insert(allObject,value)
                    end
                end
                for key, value in pairs(getobjectinmap(getbaseinfo(Hiter,3),getbaseinfo(Hiter,4),getbaseinfo(Hiter,5),3,2)) do
                    table.insert(allObject,value)
                end
                for key, value in pairs(allObject) do
                    humanhp(value,"-",math.floor(allAttrSum*0.5),0,0,actor,1,1)
                    playeffect(value,43010,0,0,1,0,0)
                end
            end
        end,
        ["[剑荡八方]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12747")
            if os.time()-cdTime>30 and math.random(100)<10 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12747",os.time(),false)
                local allObject={}
                for key, value in pairs(getobjectinmap(getbaseinfo(Hiter,3),getbaseinfo(Hiter,4),getbaseinfo(Hiter,5),3,1)) do
                    if value~=actor then
                        table.insert(allObject,value)
                    end
                end
                for key, value in pairs(getobjectinmap(getbaseinfo(Hiter,3),getbaseinfo(Hiter,4),getbaseinfo(Hiter,5),3,2)) do
                    table.insert(allObject,value)
                end
                for key, value in pairs(allObject) do
                    humanhp(value,"-",math.floor(mainAttrSum),0,0,actor,1,1)
                    playeffect(value,43038,0,0,1,0,0)
                end
                playeffect(actor,43039,0,0,1,0,0)
            end
        end,
        ["[惊天一剑]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12748")
            if isplayer(Target) and os.time()-cdTime>30 and math.random(100)<5 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12748",os.time(),false)
                humanhp(Target,"-",math.floor(getbaseinfo(Target,9)*0.15),0,0,actor,1,1)
                playeffect(Target,43022,0,0,1,0,0)
            end
        end,
        ["[力劈华山]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12749")
            if os.time()-cdTime>30 and math.random(100)<5 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12749",os.time(),false)
                humanhp(Target,"-",math.floor(allAttrSum*2),0,0,actor,1,1)
                playeffect(Target,43025,0,0,1,0,0)
            end
        end,
        ["[善恶有报]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12750")
            if os.time()-cdTime>30 then
                if math.random(100)<5 then
                    VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12750",os.time(),false)
                    humanhp(Target,"-",math.floor(allAttrSum*2),0,0,actor,1,1)
                    playeffect(actor,13473,0,0,1,0,0)
                end
                if math.random(100)<3 then
                    VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12750",os.time(),false)
                    humanhp(Target,"+",math.floor(getbaseinfo(Target,10)*0.05),0,0,actor,1,1)
                    playeffect(actor,13473,0,0,1,0,0)
                end
            end
        end,
        ["[上古符咒]"]=function ()
            local cdTime=VarApi.getPlayerUIntVar(actor,"U_equipVariation_CD_12751")
            if isplayer(Target) and os.time()-cdTime>30 and math.random(100)<5 then
                VarApi.setPlayerUIntVar(actor,"U_equipVariation_CD_12751",os.time(),false)
                local rand=math.random(3)
                if rand==1 then
                    makeposion(Target,12,2,0,1)
                    playeffect(actor,43023,0,0,1,0,0)
                    playeffect(Target,13503,0,0,1,0,0)
                elseif rand==2 then
                    playeffect(actor,43023,0,0,1,0,0)
                    for i = 1, 5 do
                        humanhp(Target,"-",math.floor(getbaseinfo(Target,10)*0.05),0,i,actor,1,1)
                    end
                    playeffect(Target,13507,0,0,1,0,0)
                else
                    makeposion(Target,5,2,0,1)
                    playeffect(actor,43023,0,0,1,0,0)
                    playeffect(Target,13450,0,0,1,0,0)
                end
            end
        end,
        ["[死亡召唤]"]=function ()
            if isplayer(Target) and VarApi.getPlayerUIntVar(Target,"U_equipVariation_12753_layer")<4 and math.random(100)<10 then
                changehumability(Target,11,math.floor(getbaseinfo(Target,10)*0.95),10)
                VarApi.setPlayerUIntVar(Target,"U_equipVariation_12753_layer",VarApi.getPlayerUIntVar(Target,"U_equipVariation_12753_layer")+1,false)
                delaygoto(Target,1000,"delay_setVar_swzh",0)
                -- for i = 1, 10 do
                --     humanhp(Target,"-",num,0,i,actor,1,1)
                -- end
                playeffect(Target,41320,0,0,1,0,0)
            end
        end,
    }
    local nowTrigger=VarApi.getPlayerTStrVar(actor,"T_attack_equipVariation") --#region 当前触发buff(攻击)
    if variationTab[nowTrigger] and VarApi.getPlayerUIntVar(actor,"U_equipVariation_tag"..nowTrigger)>0 then
        variationTab[nowTrigger]()
    end
    VarApi.setPlayerTStrVar(actor,"T_attack_equipVariation","",false)
end
function delay_setVar_swzh(player)
    local layer=VarApi.getPlayerUIntVar(player,"U_equipVariation_12753_layer")
    if layer>0 then
        VarApi.setPlayerUIntVar(player,"U_equipVariation_12753_layer",layer-1,false)
    end
end

--flag 0 怪物和玩家；1 怪物 ；2玩家 
--attack_type== 0 造成伤害
--eff_type 特效播放对象  0 所有受击对象; 1 自己; 2对象;
function BeforeAttackTrigger.RangeHarmDamage(actor,Target,hit_num,range,flag,attack_type,value,eff_id,eff_type)
    local map_id = getbaseinfo(actor,3)
    local x, y = getbaseinfo(Target, 4), getbaseinfo(Target, 5)
    local obj_list = {}
    local num = 0
    if flag == 0 or flag == 1 then
        local mon_list = getobjectinmap(map_id, x, y, range, 2)
        for k, v in pairs(mon_list) do
            if v and v ~= Target and not isInTable(BeforeAttackTrigger.filter_mons, getbaseinfo(v, 1, 1)) and num < hit_num then
                if (ismob(v) and getbaseinfo(v,59) ~= actor) or ismon(v)  then
                    num = num + 1
                    table.insert(obj_list,v)
                end
            end
        end
    end
    if (flag == 0 or flag == 2) and num < hit_num then
        local actor_list = getobjectinmap(map_id, x, y, range, 1)
        for k, v in pairs(actor_list) do
            if v and isnotnull(v) and v ~= actor and v ~= Target and num < hit_num then
                num = num + 1
                table.insert(obj_list,v)
            end
        end
    end
    for k, v in pairs(obj_list) do
        if v and isnotnull(v) then
            if attack_type and attack_type == 0 then
                humanhp(v, "-",math.floor(value) )
                if eff_id and eff_type == 0  then
                    playeffect(v,eff_id,0,0,1,0,0)
                end
            end
        end
    end
    if eff_id and eff_type and eff_type == 1 then
        playeffect(actor,eff_id,0,0,1,0,0)
    end
    if eff_id and eff_type and eff_type == 2 then
        playeffect(Target,eff_id,0,0,1,0,0)
    end
end