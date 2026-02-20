local EquipMagic = {}
EquipMagic.cfg = include("QuestDiary/config/EquipMagicCfg.lua")
local position ={13,9,12,2,14}

function EquipMagic:getStarTab(actor)
    local makeIndexTab = {}
    local starTab ={}
    for index, value in ipairs(position) do
        table.insert(makeIndexTab,GetItemByPos(actor,value))
        if makeIndexTab[index]=="0" then
            table.insert(starTab,0)
        else
            table.insert(starTab,GetItemStar(actor,makeIndexTab[index]) or 0)
        end
    end
    return starTab
end
function EquipMagic:click(actor)
    if CheckOpenState(actor, 1) then return end
    local str = tbl2json(self:getStarTab(actor))
    lualib:ShowNpcUi(actor, "EquipMagicOBJ", str)
end

function EquipMagic:upEvent(actor,leftIndex) --#region 提升
    if CheckOpenState(actor, 1) then return end
    leftIndex=tonumber(leftIndex)
    local equipTab={"终极斗笠","终极护符","终极血石","终极勋章","终极军鼓"}
    local starTab = self:getStarTab(actor)
    if not isInTable({1,2,3,4,5},leftIndex) then
        return Sendmsg9(actor, "ff0000", "当前特殊附魔装备序列异常！", 1)
    elseif not checkitemw(actor,equipTab[leftIndex],1) then
        return Sendmsg9(actor, "ff0000", "当前并未穿戴特殊附魔装备"..equipTab[leftIndex].."！", 1)
    elseif starTab[leftIndex]>=15 then
        return Sendmsg9(actor, "ff0000", "当前特殊附魔装备"..equipTab[leftIndex].."附魔已满！", 1)
    end

    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[starTab[leftIndex]+1] or (self.cfg[starTab[leftIndex]+1] and self.cfg[starTab[leftIndex]+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        for j = 1, self.cfg[starTab[leftIndex]+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[starTab[leftIndex]+1][keyName]
            itemIndex = getstditeminfo(itemName,0)
            itemCount = self.cfg[starTab[leftIndex]+1][keyItemCount]
            if i==1 then
                number=number+1
                if getbagitemcount(actor,itemName,"0") < itemCount then
                    lualib:FlushNpcUi(actor, "EquipMagicOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==2 then
                number=number+1
                if querymoney(actor,itemIndex) < itemCount then
                    lualib:FlushNpcUi(actor, "EquipMagicOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==3 then
                number=number+1
                if getbindmoney(actor,itemName) < itemCount then
                    lualib:FlushNpcUi(actor, "EquipMagicOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            end
        end
        ::continue::
    end

    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[starTab[leftIndex]+1] or (self.cfg[starTab[leftIndex]+1] and self.cfg[starTab[leftIndex]+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        for j = 1, self.cfg[starTab[leftIndex]+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[starTab[leftIndex]+1][keyName]
            itemIndex = getstditeminfo(itemName,0)
            itemCount = self.cfg[starTab[leftIndex]+1][keyItemCount]
            if i==1 then
                if not takeitem(actor,itemName,itemCount,0,itemName.."特殊附魔扣物品") then
                    return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
                end
            elseif i==2 then
                if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."特殊附魔扣非通用货币",true) then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            elseif i==3 then
                if not consumebindmoney(actor,itemName,itemCount,itemName.."特殊附魔扣通用货币") then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            end
        end
        ::continue::
    end

    if math.random(100)>self.cfg[starTab[leftIndex]+1]["odd_arr"][1] then --#region 失败
        if math.random(100)<self.cfg[starTab[leftIndex]+1]["odd_arr"][2] then --#region 降星
            self:changeStar(actor,leftIndex,starTab[leftIndex]-1)
        end
        -- Sendmsg9(actor,"ff0000","当前装备·"..equipTab[leftIndex].."附魔失败！",1)
        local str = tbl2json(self:getStarTab(actor))
        lualib:FlushNpcUi(actor,"EquipMagicOBJ","失败#"..str)
    else
        self:changeStar(actor,leftIndex,starTab[leftIndex]+1)
        -- Sendmsg9(actor,"00ff00","恭喜您成功将当前装备·"..equipTab[leftIndex].."附魔成功！",1)
        -- sendmsgnew(actor,255,0,"特殊附魔：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功附魔装备"
        -- .."<『"..equipTab[leftIndex].."至"..(starTab[leftIndex]+1).."星』/FCOLOR=251>,获得属性提升！",1,2)
        local str = tbl2json(self:getStarTab(actor))
        lualib:FlushNpcUi(actor,"EquipMagicOBJ","提升#"..str)
    end
end

function EquipMagic:changeStar(actor,leftIndex,nextStar) --#region 改星
    local nowPosition = position[leftIndex]
    local itemmakeid = GetItemByPos(actor,nowPosition)
    local infoTab = self.cfg[nextStar] and self.cfg[nextStar]["add_map0"]
    for key, value in pairs(self.cfg[nextStar]["add_map"..leftIndex]or {}) do
        infoTab[key]=value
    end
    SetItemStar(actor,itemmakeid,nextStar)
    delitemattr(actor,itemmakeid,96,0)
    additemattrEX(actor,itemmakeid,96,3,infoTab)
    SendItemVarToc(actor,itemmakeid)
    self:setVarStar(actor,nowPosition)
end

function EquipMagic:setVarStar(actor,where) --#region 穿戴装备改星变量(玩家,位置)
    -- if not isInTable(position,where) then return end
    -- local starTab = self:getStarTab(actor)
    -- for index, value in ipairs(starTab) do
    --     VarApi.setPlayerUIntVar(actor,"U_equipMagic_star"..position[index],value,false)
    -- end
end

return EquipMagic