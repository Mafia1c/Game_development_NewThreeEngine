local MakeJewelry2 = {}
MakeJewelry2.cfg = include("QuestDiary/config/MakeJewelry2Cfg.lua")

function MakeJewelry2:upEvent(actor,leftIndex,makeIndex1,makeIndex2,makeIndex3) --#region 锻造
    if CheckOpenState(actor, 2) then return end
    leftIndex = tonumber(leftIndex)
    local makeIndexTab={(makeIndex1),(makeIndex2),(makeIndex3)}
    local equipNameTab ={getiteminfo(actor,makeIndexTab[1],7),getiteminfo(actor,makeIndexTab[2],7),getiteminfo(actor,makeIndexTab[3],7)}
    if not self.cfg[leftIndex] then
        return Sendmsg9(actor, "ff0000",  "当前序列数据异常" , 1)
    elseif not makeIndex1 or not makeIndex2 or not makeIndex3 then
        return Sendmsg9(actor, "ff0000",  "当前物品数据异常" , 1)
    end
    local indexTab={}
    for index, value in ipairs(equipNameTab) do
        for i = 1, 3 do
            if isInTable(self.cfg[leftIndex]["need_arr"..i-1],value) then
                table.insert(indexTab,i)
                break
            end
        end
    end
    if indexTab[1]~=indexTab[2] or indexTab[2]~=indexTab[3] or indexTab[1]~=indexTab[3] then
        return Sendmsg9(actor, "ff0000",  "请选择同类型的3个首饰！" , 1)
    end

    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[leftIndex] or (self.cfg[leftIndex] and self.cfg[leftIndex]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        for j = 1, self.cfg[leftIndex]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[leftIndex][keyName]
            itemIndex = getstditeminfo(itemName,0)
            itemCount = self.cfg[leftIndex][keyItemCount]
            if i==1 then
                number=number+1
                if getbagitemcount(actor,itemName,"0") < itemCount then
                    lualib:FlushNpcUi(actor, "MakeJewelry2OBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==2 then
                number=number+1
                if querymoney(actor,itemIndex) < itemCount then
                    lualib:FlushNpcUi(actor, "MakeJewelry2OBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==3 then
                number=number+1
                if getbindmoney(actor,itemName) < itemCount then
                    lualib:FlushNpcUi(actor, "MakeJewelry2OBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            end
        end
        ::continue::
    end
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[leftIndex] or (self.cfg[leftIndex] and self.cfg[leftIndex]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        for j = 1, self.cfg[leftIndex]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[leftIndex][keyName]
            itemIndex = getstditeminfo(itemName,0)
            itemCount = self.cfg[leftIndex][keyItemCount]
            if i==1 then
                if not takeitem(actor,itemName,itemCount,0,itemName.."首饰锻造2扣物品") then
                    return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
                end
            elseif i==2 then
                if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."首饰锻造2扣非通用货币",true) then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            elseif i==3 then
                if not consumebindmoney(actor,itemName,itemCount,itemName.."首饰锻造2扣通用货币") then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            end
        end
        ::continue::
    end

    for i = 1, 3 do
        if not delitembymakeindex(actor,makeIndexTab[i],1,"首饰锻造2扣除"..equipNameTab[i]) then
            return Sendmsg9(actor, "ff0000", equipNameTab[i].."物品扣除失败！", 1)
        end
    end

    local endEquipName = self.cfg[leftIndex]["end_arr"..indexTab[1]-1][math.random(#self.cfg[leftIndex]["end_arr"..indexTab[1]-1])]
    GiveItem(actor,endEquipName,1,0,"首饰锻造2"..endEquipName)
    sendmsgnew(actor,255,0,"乾坤炉：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功锻造"
    .."<『"..endEquipName.."』/FCOLOR=251>,获得属性提升！",1,2)
    Sendmsg9(actor,"00ff00","恭喜您成功锻造获得"..endEquipName.."！",1)
    lualib:FlushNpcUi(actor,"MakeJewelry2OBJ","成功")
end

return MakeJewelry2