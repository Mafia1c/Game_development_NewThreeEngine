-- 穿脱装备触发
TakeEquipTrigger = {}
TakeEquipTrigger.cfg1={["战神项链[变异]"]=1,["战神手镯[变异]"]=1,["战神戒指[变异]"]=1,["战神腰带[变异]"]=1,["战神靴子[变异]"]=1
,["圣魔项链[变异]"]=1,["圣魔手镯[变异]"]=1,["圣魔戒指[变异]"]=1,["圣魔腰带[变异]"]=1,["圣魔靴子[变异]"]=1
,["真魂项链[变异]"]=1,["真魂手镯[变异]"]=1,["真魂戒指[变异]"]=1,["真魂腰带[变异]"]=1,["真魂靴子[变异]"]=1}

--#region 角色穿戴装备前触发(玩家对象，装备唯一ID，装备位置)true允许操作
function TakeEquipTrigger.takeonbeforeex(actor,makeIndex,where)

    return true
end

--#region 角色穿戴装备后触发(玩家对象，装备唯一ID，装备位置，装备名称)
function TakeEquipTrigger.takeonex(actor,makeIndex,where,itemName)
    if where == 0 then
        VarApi.setPlayerTStrVar(actor, "T_dress_equip_name", itemName, false)    -- 衣服
    end
    if where == 1 then
        VarApi.setPlayerTStrVar(actor, "T_weapon_equip_name", itemName, false)   -- 武器
        --兵魂buff
        if hasbuff(actor, 60059) then 
            local value = getitemattidvalue(actor,2,4,1)
            addbuff(actor,60121,0,1,actor,{[4]=value})
            playeffect(actor,13408,0,0,1,0,0)
        end
    end

    local positionTab1 = {[0]=1,[1]=2,[3]=3,[4]=4,[5]=5,[6]=6,[7]=7,[8]=8,[10]=9,[11]=10} --#region 装备强化
    local positionTab2 = {[13]=1,[9]=2,[12]=3,[2]=4,[14]=5} --#region 特殊附魔
    if positionTab1[where] then --#region 装备强化
        local star = VarApi.getPlayerUIntVar(actor,"U_equipStar"..where)
        SetItemStar(actor,makeIndex,star)
        refreshitem(actor, makeIndex)
        if TakeEquipTrigger.cfg1[getiteminfo(actor,makeIndex,7)] then
            IncludeNpcClass("EquipVariation"):setEquipVariation(actor,makeIndex,1) --#region 特殊必变异
        end
        IncludeNpcClass("EquipVariation"):addPlayerEquipVariationBuff(actor,makeIndex,where) --#region 装备变异
    elseif positionTab2[where] then --#region 特殊附魔
        local star = GetItemStar(actor,makeIndex)
        VarApi.setPlayerUIntVar(actor,"U_equipMagic_star"..where,star,false)
    end
end

--#region 角色脱下装备前触发(玩家对象，装备唯一ID，装备位置)true允许操作
function TakeEquipTrigger.takeoffbeforeex(actor,makeIndex,where,idx)
    local fashion_index = {17,18,19,20,21,22,23,24,25,26,27,28,29,42,43,44,45,46}
    if isInTable(fashion_index, where) then         -- 时装不能脱
        return false
    end
    return true
end

--#region 角色脱下装备后触发(玩家对象，装备唯一ID，装备位置，装备名称)
function TakeEquipTrigger.takeoffex(actor,makeIndex,where,itemName)
    if where == 0 then
        VarApi.setPlayerTStrVar(actor, "T_dress_equip_name", "", false)    -- 衣服
    end
    if where == 1 then
        VarApi.setPlayerTStrVar(actor, "T_weapon_equip_name", "", false)   -- 武器
        delbuff(actor,60121)
    end

    local positionTab1 = {[0]=1,[1]=2,[3]=3,[4]=4,[5]=5,[6]=6,[7]=7,[8]=8,[10]=9,[11]=10} --#region 装备强化
    local positionTab2 = {[13]=1,[9]=2,[12]=3,[2]=4,[14]=5} --#region 特殊附魔
    if positionTab1[where] then --#region 装备强化
        SetItemStar(actor,makeIndex,0)
        refreshitem(actor, makeIndex)
        IncludeNpcClass("EquipVariation"):delPlayerEquipVariationBuff(actor,makeIndex) --#region 装备变异
    elseif positionTab2[where] then --#region 特殊附魔
        VarApi.setPlayerUIntVar(actor,"U_equipMagic_star"..where,0,false)
    end

    local item_id = getiteminfo(actor, makeIndex, 2)
    local item_id_list = {50003,50004,50005,50006,50007,50008,50009,50010,50011}
    if isInTable(item_id_list, item_id) then
        delaygoto(actor, 500, "delay_del_equip,"..itemName, 0)
    end
end

function delay_del_equip(actor, name)
    takeitem(actor, name, 1, 0, "移除新人装备!")
end
