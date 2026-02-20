local LifeUp = {}
LifeUp.cfg = include("QuestDiary/config/LifeUpCfg.lua")
function LifeUp:onClick(actor, npcId)
    local zsLevel = getbaseinfo(actor,39)
    local temp = VarApi.getPlayerUIntVar(actor, "U_bigMap")
    if nil == npcId then
        if zsLevel < 10 then
            npcId = 69
        elseif zsLevel < 15 then
            npcId = 93
        else
            npcId = 119
        end
        if temp == 0 then
            npcId = 69
        elseif temp == 2 and npcId == 119 then
            npcId = 93
        end
    elseif npcId==93 then
        if CheckOpenState(actor, 1) then return end
    elseif npcId==119 then
        if CheckOpenState(actor, 2) then return end
    end

    lualib:ShowNpcUi(actor, "LifeUpOBJ", npcId)
    TaskTrigger.CompleteTask(actor, 13)
end

function LifeUp:upEvent(actor,npcId) --#region 提升
    npcId = tonumber(npcId)
    if npcId==93 then
        if CheckOpenState(actor, 1) then return end
    elseif npcId==119 then
        if CheckOpenState(actor, 2) then return end
    end
    local zsLevel = getbaseinfo(actor,39) --#region 转生等级
    local layer = VarApi.getPlayerUIntVar(actor,"U_lifeUp") --#region 当前layer在表中index
    if (npcId==69 and zsLevel>=10) or (npcId==93 and zsLevel>=15) then
        return Sendmsg9(actor, "ff0000", "当前大陆已提升至最高等级，请前往下一大陆继续提升！", 1)
    elseif zsLevel>=20 then
        return Sendmsg9(actor, "ff0000", "当前转生已提升至最高等级！", 1)
    elseif layer>= #self.cfg then
        return Sendmsg9(actor, "ff0000", "当前转生已提升至最高等级！", 1)
    end

    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[layer+1] or (self.cfg[layer+1] and self.cfg[layer+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        for j = 1, self.cfg[layer+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[layer+1][keyName]
            itemIndex = getstditeminfo(itemName,0)
            itemCount = self.cfg[layer+1][keyItemCount]
            if i==1 then
                number=number+1
                if getbagitemcount(actor,itemName,"0") < itemCount then
                    lualib:FlushNpcUi(actor, "LifeUpOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==2 then
                number=number+1
                if querymoney(actor,itemIndex) < itemCount then
                    lualib:FlushNpcUi(actor, "LifeUpOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==3 then
                number=number+1
                if getbindmoney(actor,itemName) < itemCount then
                    lualib:FlushNpcUi(actor, "LifeUpOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            end
        end
        ::continue::
    end

    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[layer+1] or (self.cfg[layer+1] and self.cfg[layer+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        for j = 1, self.cfg[layer+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[layer+1][keyName]
            itemIndex = getstditeminfo(itemName,0)
            itemCount = self.cfg[layer+1][keyItemCount]
            if i==1 then
                if not takeitem(actor,itemName,itemCount,0,itemName.."转生提升扣物品") then
                    return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
                end
            elseif i==2 then
                if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."转生提升扣非通用货币",true) then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            elseif i==3 then
                if not consumebindmoney(actor,itemName,itemCount,itemName.."转生提升扣通用货币") then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            end
        end
        ::continue::
    end

    local job = getbaseinfo(actor,7)
    VarApi.setPlayerUIntVar(actor,"U_lifeUp",layer+1,true)
    local addStr = self.cfg[layer+1]["attStr"..job].."|"..(self.cfg[layer+1]["attStr3"] or "") --#region 职业属性+攻击倍数
    delattlist(actor,"liftUp_attr")
    delbuff(actor,40103)
    addbuff(actor,40103,0,1,actor,ParserAttrStrToTable(addStr))
    if (layer+1)%10==0 then
        setbaseinfo(actor,39,zsLevel+1)
        VarApi.setPlayerUIntVar(actor,"U101",zsLevel+1,false)
        Sendmsg9(actor,"00ff00","恭喜您成功转生至"..(zsLevel+1).."转！",1)
        sendmsgnew(actor,255,0,"转生轮回：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功突破转生至"
        .."<『"..(zsLevel+1).."转』/FCOLOR=251>,获得属性提升！",1,2)
    else
        Sendmsg9(actor,"00ff00","当前转生进度 "..((layer+1)%10).." / 9",1)
    end
    lualib:FlushNpcUi(actor,"LifeUpOBJ","提升")
end

function LifeUp:addStrInfo(actor) --#region 登陆加属性
    local job = getbaseinfo(actor,7)
    local layer = VarApi.getPlayerUIntVar(actor,"U_lifeUp") --#region 当前layer在表中index
    if not self.cfg[layer] then
        return
    end
    local addStr = self.cfg[layer]["attStr"..job].."|"..(self.cfg[layer]["attStr3"] or "") --#region 职业属性+攻击倍数
    delattlist(actor,"liftUp_attr")
    delbuff(actor,40103)
    addbuff(actor,40103,0,1,actor,ParserAttrStrToTable(addStr))
end

function LifeUp:getEvent(actor) --#region 得飞升凭证
    local zsLevel = getbaseinfo(actor,39)
    if zsLevel<10 then
        return Sendmsg9(actor, "ff0000", "10转后才可来合成！", 1)
    end
    local tab={"转生凭证",99}
    if getbagitemcount(actor,tab[1],"0") < tab[2] then
        return Sendmsg9(actor, "ff0000", "当前背包物品" .. tab[1] .. "数量少于" .. tab[2] .. "！", 1)
    end
    if not takeitem(actor,tab[1],tab[2],0,tab[1].."合飞升凭证扣物品") then
        return Sendmsg9(actor, "ff0000", "物品" .. tab[1] .. "扣除失败！", 1)
    end
    GiveItem(actor,"飞升凭证",1,0,"合成飞升凭证")
    Sendmsg9(actor,"00ff00","成功合成获得飞升凭证*1",1)
end

return LifeUp