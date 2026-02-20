local FourCell = {}
FourCell.cfg = include("QuestDiary/config/FourCellCfg.lua")
function FourCell:onClick(actor,leftIndex,rightIndex)
    leftIndex = leftIndex or ""
    rightIndex = rightIndex or ""
    lualib:ShowNpcUi(actor, "FourCellOBJ", leftIndex .. "#"..rightIndex)
    TaskTrigger.CompleteTask(actor, 7)
end

function FourCell:upEvent1(actor,leftIndex,rightIndex) --#region 背包合成
    leftIndex = tonumber(leftIndex)
    rightIndex = tonumber(rightIndex)
    -- if leftIndex~=1 or not self.cfg[leftIndex]["equip_arr"][rightIndex] then
    --     return Sendmsg9(actor, "ff0000", "背包合成序列异常！", 1)
    -- end
    if not self.cfg[leftIndex]["equip_arr"][rightIndex] then
        return Sendmsg9(actor, "ff0000", "背包合成序列异常！", 1)
    end

    local equipName = self.cfg[leftIndex]["equip_arr"][rightIndex]
    for i, v in ipairs(self.cfg[equipName]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if getbagitemcount(actor,itemName,"0") < itemCount then
                lualib:FlushNpcUi(actor, "FourCellOBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 1 then
            if querymoney(actor,itemIndex) < itemCount then
                lualib:FlushNpcUi(actor, "FourCellOBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 2 then
            if getbindmoney(actor,itemName) < itemCount then
                lualib:FlushNpcUi(actor, "FourCellOBJ", "不足#"..i)
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
            if not takeitem(actor,itemName,itemCount,0,itemName.."特殊四格背包扣物品") then
                return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 1 then
            if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."特殊四格背包扣非通用货币",true) then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 2 then
            if not consumebindmoney(actor,itemName,itemCount,itemName.."特殊四格背包扣通用货币") then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        end
    end

    GiveItem(actor,equipName,1,0,"特殊四格背包"..equipName)
    local position = self.cfg[leftIndex]["position"]
    refreshitem(actor,GetItemByPos(actor,position))
    sendmsgnew(actor,255,0,"特殊合成：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功合成"
    .."<『"..equipName.."』/FCOLOR=251>,获得属性提升！",1,2)
    Sendmsg9(actor,"00ff00","恭喜您成功合成获得"..equipName.."！",1)
    lualib:FlushNpcUi(actor,"FourCellOBJ","refresh")
end

function FourCell:upEvent2(actor,leftIndex,rightIndex) --#region 身上合成
    leftIndex = tonumber(leftIndex)
    rightIndex = tonumber(rightIndex)
    local position = self.cfg[leftIndex]["position"]
    local makeIndex = GetItemByPos(actor,position)
    local nowEquipName = getiteminfo(actor,makeIndex,7)
    local equipName = self.cfg[leftIndex]["equip_arr"][rightIndex]
    if not self.cfg[leftIndex] or not self.cfg[leftIndex]["equip_arr"][rightIndex] then
        return Sendmsg9(actor, "ff0000", "身上合成序列异常！", 1)
    elseif rightIndex==#self.cfg[leftIndex]["equip_arr"] and nowEquipName==equipName then
        return Sendmsg9(actor, "ff0000", "当前已合成至最高等级！", 1)
    end
    if nowEquipName~=self.cfg[equipName]["need_config"][1][1] then
        return Sendmsg9(actor, "ff0000", "当前装备位置没有穿戴"..self.cfg[equipName]["need_config"][1][1].."！", 1)
    end
    -- if leftIndex==1 and rightIndex==1 and nowEquipName~="玄铁盾" then
    --     return Sendmsg9(actor, "ff0000", "当前装备位置没有穿戴玄铁盾！", 1)
    -- elseif rightIndex>1 and nowEquipName ~= self.cfg[leftIndex]["equip_arr"][rightIndex-1] then
    --     return Sendmsg9(actor, "ff0000", "当前装备位置没有穿戴"..self.cfg[leftIndex]["equip_arr"][rightIndex-1].."！", 1)
    -- end

    for i, v in ipairs(self.cfg[equipName]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if i==1 then
                itemCount=itemCount-1
            end
            if getbagitemcount(actor,itemName,"0") < itemCount then
                lualib:FlushNpcUi(actor, "FourCellOBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 1 then
            if querymoney(actor,itemIndex) < itemCount then
                lualib:FlushNpcUi(actor, "FourCellOBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 2 then
            if getbindmoney(actor,itemName) < itemCount then
                lualib:FlushNpcUi(actor, "FourCellOBJ", "不足#"..i)
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
            if i==1 then
                itemCount=itemCount-1
                if not takew(actor,itemName,1,"特殊四格身上扣装备") then
                    return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
                end
            end
            if itemCount>0 and not takeitem(actor,itemName,itemCount,0,itemName.."特殊四格身上扣物品") then
                return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 1 then
            if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."特殊四格身上扣非通用货币",true) then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 2 then
            if not consumebindmoney(actor,itemName,itemCount,itemName.."特殊四格身上扣通用货币") then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        end
    end

    GiveOnItem(actor,position,equipName,1,0,"特殊四格穿装备"..equipName)
    sendmsgnew(actor,255,0,"特殊合成：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功合成"
    .."<『"..equipName.."』/FCOLOR=251>,获得属性提升！",1,2)
    refreshitem(actor,GetItemByPos(actor,position))
    Sendmsg9(actor,"00ff00","恭喜您成功合成获得"..equipName.."！",1)
    -- if leftIndex==1 then
    --     lualib:FlushNpcUi(actor,"FourCellOBJ","盾牌")
    -- elseif rightIndex==#self.cfg[leftIndex]["equip_arr"] then
    --     lualib:FlushNpcUi(actor,"FourCellOBJ","最后")
    -- else
    --     lualib:FlushNpcUi(actor,"FourCellOBJ","身上")
    -- end
    lualib:FlushNpcUi(actor,"FourCellOBJ","refresh")
end

return FourCell