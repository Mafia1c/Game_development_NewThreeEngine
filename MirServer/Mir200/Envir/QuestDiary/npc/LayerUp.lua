local LayerUp = {}
LayerUp.cfg = include("QuestDiary/config/LayerUpCfg.lua")

function LayerUp:click(actor)
    if CheckOpenState(actor, 2) then return end
    local zsLevel = getbaseinfo(actor,39)
    if zsLevel<20 then
        return Sendmsg9(actor, "ff0000", "请先将转生等级提升至20级再来飞升！", 1)
    elseif VarApi.getPlayerUIntVar(actor,"U_LayerStudy")<14 then
        return Sendmsg9(actor, "ff0000", "请先将境界修炼至大道再来飞升！", 1)
    end
    lualib:ShowNpcUi(actor, "LayerUpOBJ", "")
end

function LayerUp:upEvent(actor) --#region 提升
    if CheckOpenState(actor, 2) then return end
    local layer = VarApi.getPlayerUIntVar(actor,"U_LayerUp") --#region 当前layer在表中index
    if layer>= #self.cfg then
        return Sendmsg9(actor, "ff0000", "当前已经飞升至最高境界"..self.cfg[layer]["type"].."！", 1)
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
                    lualib:FlushNpcUi(actor, "LayerUpOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==2 then
                number=number+1
                if querymoney(actor,itemIndex) < itemCount then
                    lualib:FlushNpcUi(actor, "LayerUpOBJ", "不足#"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==3 then
                number=number+1
                if getbindmoney(actor,itemName) < itemCount then
                    lualib:FlushNpcUi(actor, "LayerUpOBJ", "不足#"..number)
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
                if not takeitem(actor,itemName,itemCount,0,itemName.."境界飞升扣物品") then
                    return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
                end
            elseif i==2 then
                if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."境界飞升扣非通用货币",true) then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            elseif i==3 then
                if not consumebindmoney(actor,itemName,itemCount,itemName.."境界飞升扣通用货币") then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            end
        end
        ::continue::
    end

    VarApi.setPlayerUIntVar(actor,"U_LayerUp",layer+1,true)
    if layer+1>1 then
        deprivetitle(actor,"飞升·"..self.cfg[layer]["type"])
    end
    confertitle(actor,"飞升·"..self.cfg[layer+1]["type"],0)
    Sendmsg9(actor,"00ff00","恭喜您成功将境界提升至飞升·"..self.cfg[layer+1]["type"].."！",1)
    sendmsgnew(actor,255,0,"境界飞升：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功修炼至"
    .."<『".."飞升·"..self.cfg[layer+1]["type"].."境界』/FCOLOR=251>,获得属性提升！",1,2)
    lualib:FlushNpcUi(actor,"LayerUpOBJ","提升")
end


return LayerUp