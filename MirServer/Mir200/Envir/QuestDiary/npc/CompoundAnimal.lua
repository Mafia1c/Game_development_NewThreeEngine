local CompoundAnimal = {}
CompoundAnimal.cfg = include("QuestDiary/config/CompoundAnimalCfg.lua") --#region 合成
CompoundAnimal.cfg2 = include("QuestDiary/config/CompoundAnimalCfg2.lua") --#region 注灵
function CompoundAnimal:onClick(actor, npc_id,leftIndex,rightIndex)
    leftIndex = leftIndex or 1
    rightIndex = rightIndex or 1
    if tonumber(npc_id)==91 then
        if CheckOpenState(actor, 1) then return end
    elseif tonumber(npc_id)==121 then
        if CheckOpenState(actor, 2) then return end
    end
    lualib:ShowNpcUi(actor, "CompoundAnimalOBJ", npc_id.."#"..leftIndex.."#"..rightIndex)
    TaskTrigger.CompleteTask(actor, 9)
end

function CompoundAnimal:upEvent11(actor,leftIndex,rightIndex) --#region 背包合成
    leftIndex = tonumber(leftIndex)
    rightIndex = tonumber(rightIndex)
    if not self.cfg[leftIndex] or not self.cfg[leftIndex]["item_arr"][rightIndex] then
        return Sendmsg9(actor, "ff0000", "生肖背包合成序列异常！", 1)
    elseif isInTable({2,3},leftIndex) and VarApi.getPlayerUIntVar(actor,"U_bigMap")<2 then
        return Sendmsg9(actor, "ff0000", "请先前往白日门大陆后再来合成！", 1)
    elseif leftIndex==4 and VarApi.getPlayerUIntVar(actor,"U_bigMap")<3 then
        return Sendmsg9(actor, "ff0000", "请先前往封魔谷大陆后再来合成！", 1)
    end

    local equipName = self.cfg[leftIndex]["item_arr"][rightIndex]
    for i, v in ipairs(self.cfg[equipName]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if getbagitemcount(actor,itemName,"0") < itemCount then
                lualib:FlushNpcUi(actor, "CompoundAnimalOBJ", "不足#1"..i)
                return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 1 then
            if querymoney(actor,itemIndex) < itemCount then
                lualib:FlushNpcUi(actor, "CompoundAnimalOBJ", "不足#1"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 2 then
            if getbindmoney(actor,itemName) < itemCount then
                lualib:FlushNpcUi(actor, "CompoundAnimalOBJ", "不足#1"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        end
    end
    for i, v in ipairs(self.cfg[equipName]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if not takeitem(actor,itemName,itemCount,0,itemName.."生肖合成背包扣物品") then
                return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 1 then
            if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."生肖合成背包扣非通用货币",true) then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 2 then
            if not consumebindmoney(actor,itemName,itemCount,itemName.."生肖合成背包扣通用货币") then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        end
    end

    GiveItem(actor,equipName,1,0,"生肖合成背包"..equipName)
    local position = self.cfg[leftIndex]["position"]
    refreshitem(actor,GetItemByPos(actor,position))
    -- sendmsgnew(actor,255,0,"生肖锻造：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功锻造生肖"
    -- .."<『"..equipName.."』/FCOLOR=251>,获得属性提升！",1,2)
    -- Sendmsg9(actor,"00ff00","恭喜您成功合成获得"..equipName.."！",1)
    lualib:FlushNpcUi(actor,"CompoundAnimalOBJ","背包")
end

function CompoundAnimal:upEvent12(actor,leftIndex,rightIndex) --#region 身上合成
    leftIndex = tonumber(leftIndex)
    rightIndex = tonumber(rightIndex)
    local position = 29+rightIndex
    local makeIndex = GetItemByPos(actor,position)
    local nowEquipName = getiteminfo(actor,makeIndex,7)
    local equipName = self.cfg[leftIndex]["item_arr"][rightIndex]
    if not self.cfg[leftIndex] or not self.cfg[leftIndex]["item_arr"][rightIndex] or leftIndex==1 then
        return Sendmsg9(actor, "ff0000", "身上合成序列异常！", 1)
    elseif isInTable({2,3},leftIndex) and VarApi.getPlayerUIntVar(actor,"U_bigMap")<2 then
        return Sendmsg9(actor, "ff0000", "请先前往白日门大陆后再来合成！", 1)
    elseif leftIndex==4 and VarApi.getPlayerUIntVar(actor,"U_bigMap")<3 then
        return Sendmsg9(actor, "ff0000", "请先前往封魔谷大陆后再来合成！", 1)
    end
    if nowEquipName ~= self.cfg[leftIndex-1]["item_arr"][rightIndex] then
        return Sendmsg9(actor, "ff0000", "当前装备位置没有穿戴"..self.cfg[leftIndex-1]["item_arr"][rightIndex].."！", 1)
    end

    for i, v in ipairs(self.cfg[equipName]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if i==3 then
                itemCount=itemCount-1
            end
            if getbagitemcount(actor,itemName,"0") < itemCount then
                lualib:FlushNpcUi(actor, "CompoundAnimalOBJ", "不足#1"..i)
                return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 1 then
            if querymoney(actor,itemIndex) < itemCount then
                lualib:FlushNpcUi(actor, "CompoundAnimalOBJ", "不足#1"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 2 then
            if getbindmoney(actor,itemName) < itemCount then
                lualib:FlushNpcUi(actor, "CompoundAnimalOBJ", "不足#1"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        end
    end
    for i, v in ipairs(self.cfg[equipName]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if i==3 then
                itemCount=itemCount-1
                if not takew(actor,itemName,1,"生肖合成身上扣装备"..itemName) then
                    return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
                end
            end
            if itemCount>0 and not takeitem(actor,itemName,itemCount,0,itemName.."生肖合成身上扣物品") then
                return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 1 then
            if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."生肖合成身上扣非通用货币",true) then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 2 then
            if not consumebindmoney(actor,itemName,itemCount,itemName.."生肖合成身上扣通用货币") then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        end
    end

    GiveOnItem(actor,position,equipName,1,0,"生肖合成穿装备"..equipName)
    refreshitem(actor,GetItemByPos(actor,position))
    -- sendmsgnew(actor,255,0,"生肖锻造：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功锻造生肖"
    -- .."<『"..equipName.."』/FCOLOR=251>,获得属性提升！",1,2)
    -- Sendmsg9(actor,"00ff00","恭喜您成功合成获得"..equipName.."！",1)
    lualib:FlushNpcUi(actor,"CompoundAnimalOBJ","身上")
end

function CompoundAnimal:upEvent3(actor,rightIndex) --#region 注灵
    rightIndex = tonumber(rightIndex)
    local position = 29+rightIndex
    local makeIndex = GetItemByPos(actor,position)
    local nowEquipName = getiteminfo(actor,makeIndex,7)
    if not self.cfg2[rightIndex] then
        return Sendmsg9(actor, "ff0000", "注灵序列异常！", 1)
    elseif VarApi.getPlayerUIntVar(actor,"U_bigMap")<3 then
        return Sendmsg9(actor, "ff0000", "请先前往封魔谷大陆后再来注灵！", 1)
    end
    if nowEquipName ~= self.cfg2[rightIndex]["type"] then
        return Sendmsg9(actor, "ff0000", "当前装备位置没有穿戴"..self.cfg2[rightIndex]["type"].."！", 1)
    end

    for i, v in ipairs(self.cfg2[rightIndex]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if getbagitemcount(actor,itemName,"0") < itemCount then
                lualib:FlushNpcUi(actor, "CompoundAnimalOBJ", "不足#2"..i)
                return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 1 then
            if querymoney(actor,itemIndex) < itemCount then
                lualib:FlushNpcUi(actor, "CompoundAnimalOBJ", "不足#2"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 2 then
            if getbindmoney(actor,itemName) < itemCount then
                lualib:FlushNpcUi(actor, "CompoundAnimalOBJ", "不足#2"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        end
    end
    for i, v in ipairs(self.cfg2[rightIndex]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if itemCount>0 and not takeitem(actor,itemName,itemCount,0,itemName.."生肖注灵身上扣物品") then
                return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 1 then
            if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."生肖注灵身上扣非通用货币",true) then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 2 then
            if not consumebindmoney(actor,itemName,itemCount,itemName.."生肖注灵身上扣通用货币") then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        end
    end
    if math.random(100)>self.cfg2[rightIndex]["odd_arr"][1] then
        return lualib:FlushNpcUi(actor,"CompoundAnimalOBJ","失败")
    end

    local allPoint = 0 --#region 总权重
    for index, value in ipairs(self.cfg2) do
        allPoint=allPoint+value["weight"]
    end
    local number = math.random(3) --#region 几条属性
    local endPoint = 0 --#region 随出来的权重
    local endTab = {} --#region 随出来归属index
    while #endTab<number do
        endPoint=math.random(allPoint)
        local temp = 0
        for j = #self.cfg2, 1, -1 do
            temp=temp+self.cfg2[j]["weight"]
            if endPoint<=temp and not isInTable(endTab,j) then
                table.insert(endTab,j)
                break
            end
        end
    end
    local infoTab = {}
    for index, value in ipairs(endTab) do
        infoTab[self.cfg2[value]["attId"]] = math.random(self.cfg2[value]["range_arr"][1],self.cfg2[value]["range_arr"][2])
        *self.cfg2[value]["number"]
    end
    delitemattr(actor,makeIndex,98,0)
    additemattrEX(actor,makeIndex,98,3,infoTab)
    refreshitem(actor,makeIndex)
    -- sendmsgnew(actor,255,0,"生肖注灵：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功注灵生肖"
    -- .."<『"..nowEquipName.."』/FCOLOR=251>,获得属性提升！",1,2)
    -- Sendmsg9(actor,"00ff00","恭喜您成功为"..nowEquipName.."注灵成功！",1)
    lualib:FlushNpcUi(actor,"CompoundAnimalOBJ","注灵")
end

function CompoundAnimal:getInfo(actor,rightIndex) --#region 获取注灵属性
    rightIndex = tonumber(rightIndex)
    local position = 29+rightIndex
    local makeIndex = GetItemByPos(actor,position)
    local nowEquipName = getiteminfo(actor,makeIndex,7)
    local attStr = getitemattr(actor,GetItemByPos(actor,29+rightIndex),98)
    if not self.cfg2[rightIndex] or nowEquipName ~= self.cfg2[rightIndex]["type"] or attStr=="" then
        return
    end
    local tab = {}
    for num1, num2, num3 in string.gmatch(attStr, "(%d+)#(%d+)#(%d+)") do
        tab[#tab+1] = {num2,num3}
    end
    lualib:FlushNpcUi(actor,"CompoundAnimalOBJ","属性#"..tbl2json(tab))
end

return CompoundAnimal