local EquipMaster = {}
EquipMaster.cfg = include("QuestDiary/config/EquipMasterCfg.lua")

function EquipMaster:click(actor)
    VarApi.setPlayerUIntVar(actor,"U_equipLuck",0,true)
    lualib:ShowNpcUi(actor, "EquipMasterOBJ", "")
end
function EquipMaster:luck(actor,leftIndex) --#region 幸运符
    -- leftIndex = tonumber(leftIndex)
    -- local temp = VarApi.getPlayerUIntVar(actor,"U_equipLuck")
    -- local position = self.cfg[leftIndex]["type_arr"][2]
    -- local star = VarApi.getPlayerUIntVar(actor,"U_equipStar"..position)
    -- if temp == 0 then
    --     if 2000 > getbindmoney(actor, "金符") then
    --         Sendmsg9(actor, "ff0000", "当前玩家货币金符数量少于2000！", 1)
    --         -- openhyperlink(actor,11,0)
    --     elseif star<8 then
    --         Sendmsg9(actor, "ff0000", "请将当前强化至8星再来开启增幅！", 1)
    --     else
    --         Sendmsg9(actor, "00FF00", "成功开启强化增幅！", 1)
    --         VarApi.setPlayerUIntVar(actor,"U_equipLuck",1,true)
    --         lualib:FlushNpcUi(actor, "EquipMasterOBJ", "luck")
    --     end
    -- elseif temp==1 then
    --     Sendmsg9(actor, "00FF00", "取消开启强化增幅！", 1)
    --     VarApi.setPlayerUIntVar(actor,"U_equipLuck",0,true)
    --     lualib:FlushNpcUi(actor, "EquipMasterOBJ", "luck")
    -- end
end
function EquipMaster:judgeEvent(actor,leftIndex) --#region 判断增幅
    leftIndex = tonumber(leftIndex)
    local temp = VarApi.getPlayerUIntVar(actor,"U_equipLuck")
    local position = self.cfg[leftIndex]["type_arr"][2]
    local star = VarApi.getPlayerUIntVar(actor,"U_equipStar"..position)
    if temp==1 and star<8 then
        VarApi.setPlayerUIntVar(actor,"U_equipLuck",0,true)
        lualib:FlushNpcUi(actor, "EquipMasterOBJ", "luck")
    end
end

function EquipMaster:upEvent(actor,leftIndex)
    leftIndex = tonumber(leftIndex)
    local position = self.cfg[leftIndex]["type_arr"][2]
    local star = VarApi.getPlayerUIntVar(actor,"U_equipStar"..position)
    local itemmakeid = GetItemByPos(actor,position)
    local equipName = getiteminfo(actor,itemmakeid,7)

    if not self.cfg[leftIndex]["type_arr"] then
        return Sendmsg9(actor, "ff0000",  "当前数据异常" , 1)
    elseif itemmakeid == nil or itemmakeid == "" then
        return Sendmsg9(actor, "ff0000",  "当前装备位数据异常！" , 1)
    elseif star >= 15 then
        return Sendmsg9(actor, "ff0000",  "当前装备位已强化至最高等级！" , 1)
    end

    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[star+1] or (self.cfg[star+1] and self.cfg[star+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        for j = 1, self.cfg[star+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[star+1][keyName]
            itemIndex = getstditeminfo(itemName,0)
            itemCount = self.cfg[star+1][keyItemCount]
            if i==1 then
                number=number+1
                if getbagitemcount(actor,itemName,"0") < itemCount then
                    lualib:FlushNpcUi(actor, "EquipMasterOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==2 then
                number=number+1
                if querymoney(actor,itemIndex) < itemCount then
                    lualib:FlushNpcUi(actor, "EquipMasterOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==3 then
                number=number+1
                if getbindmoney(actor,itemName) < itemCount then
                    lualib:FlushNpcUi(actor, "EquipMasterOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            end
        end
        ::continue::
    end

    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[star+1] or (self.cfg[star+1] and self.cfg[star+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        for j = 1, self.cfg[star+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[star+1][keyName]
            itemIndex = getstditeminfo(itemName,0)
            itemCount = self.cfg[star+1][keyItemCount]
            if i==1 then
                if not takeitem(actor,itemName,itemCount,0,itemName.."装备强化扣物品") then
                    return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
                end
            elseif i==2 then
                if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."装备强化扣非通用货币",true) then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            elseif i==3 then
                if not consumebindmoney(actor,itemName,itemCount,itemName.."装备强化扣通用货币") then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            end
        end
        ::continue::
    end

    local luck = self.cfg[star+1]["odd"]
    local nowOpen = VarApi.getPlayerUIntVar(actor,"U_equipLuck") --#region 本次是否使用强化增幅
    if nowOpen == 1 then
        if not consumebindmoney(actor,"金符",2000,"金符强化增幅扣通用货币") then
            return Sendmsg9(actor, "ff0000", "货币金符扣除失败！", 1)
        end
        if 2000 > getbindmoney(actor, "金符") then
            VarApi.setPlayerUIntVar(actor,"U_equipLuck",0,true)
        end
        luck = luck +10
    end

    if math.random(100) >= luck then --#region 失败
        local temp = math.random(100)
        if star>8 and nowOpen==0 and temp<=45 then --#region 扣星
            local endStar = 0
            if temp<=20 then
                endStar=star-math.random(3)
            elseif temp<=45 then
                endStar=8
            end
            VarApi.setPlayerUIntVar(actor,"U_equipStar"..position,endStar,true)
            self:addInfo(actor,position)
            self:addSuitInfo(actor)
            -- Sendmsg9(actor, "ff0000", "当前装备"..equipName.."强化失败,并降至"..endStar.."星！", 1)
        else
            -- Sendmsg9(actor, "ff0000", "当前装备"..equipName.."强化失败！", 1)
        end
        lualib:FlushNpcUi(actor, "EquipMasterOBJ", "失败")
    else
        VarApi.setPlayerUIntVar(actor,"U_equipStar"..position,star+1,true)
        self:addInfo(actor,position)
        self:addSuitInfo(actor)
        sendmsgnew(actor,255,0,"装备增幅：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功强化装备"
        .."<『"..(equipName).."』至"..(star+1).."星/FCOLOR=251>,获得属性提升！",1,2)
        -- Sendmsg9(actor, "00FF00", "当前装备"..equipName.."强化成功！", 1)
        lualib:FlushNpcUi(actor,"EquipMasterOBJ","成功")
    end
end

function EquipMaster:addInfo(actor,position) --#region 添加属性和星(穿戴装备也用)
    local positionTab = {[0]=1,[1]=2,[3]=3,[4]=4,[5]=5,[6]=6,[7]=7,[8]=8,[10]=9,[11]=10}
    if not positionTab[position] then
        return
    end
    local star = VarApi.getPlayerUIntVar(actor,"U_equipStar"..position)
    local itemmakeid = GetItemByPos(actor,position)
    -- local tag = self.cfg[positionTab[position]]["type_arr"][3]
    if not self.cfg[star] then
        return
    end
    -- local infoTab={[30]=star}
    -- for key, value in pairs(self.cfg[star]["attStr_map"..tag]) do
    --     infoTab[key]=value
    -- end
    SetItemStar(actor,itemmakeid,star)
    -- delitemattr(actor,itemmakeid,97,0)
    -- additemattrEX(actor,itemmakeid,97,3,infoTab)
    local addInfoTab={"1000","1200","1400","1600","1800","2000","3000","4000","5000","6000","7000","8000","9000","10000","12000"}
    setequipaddvalue(actor, position, "=", addInfoTab[star])
    SendItemVarToc(actor,itemmakeid)
    refreshitem(actor, itemmakeid)
end
function EquipMaster:delInfo(actor,position,makeIndex) --#region 脱装备删属性
    -- local positionTab = {[0]=1,[1]=2,[3]=3,[4]=4,[5]=5,[6]=6,[7]=7,[8]=8,[10]=9,[11]=10}
    -- if not positionTab[position] then
    --     return
    -- elseif VarApi.getPlayerUIntVar(actor,"U_equipStar"..position)==0 then
    --     return
    -- end
    -- SetItemStar(actor,makeIndex,0)
    -- setequipaddvalue(actor, position, "=", 0)
    -- -- delitemattr(actor,makeIndex,97,0)
    -- SendItemVarToc(actor,makeIndex)
    -- refreshitem(actor, makeIndex)
end

function EquipMaster:addSuitInfo(actor) --#region 套装属性
    local titleTab = {{150,"强化150星"},{140,"强化140星"},{130,"强化130星"},{120,"强化120星"},{110,"强化110星"},{100,"强化100星"},{80,"强化80星"}}
    local allStar = 0
    for index, value in ipairs({0,1,3,4,5,6,7,8,10,11}) do
        allStar = allStar + VarApi.getPlayerUIntVar(actor,"U_equipStar"..value)
    end
    for index, value in ipairs(titleTab) do
        deprivetitle(actor,value[2])
    end
    for index, value in ipairs(titleTab) do
        if allStar>=value[1] then
            confertitle(actor,value[2],0)
            break
        end
    end
end

return EquipMaster