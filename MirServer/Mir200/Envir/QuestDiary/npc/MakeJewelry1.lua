local MakeJewelry1 = {}
MakeJewelry1.cfg = include("QuestDiary/config/MakeJewelry1Cfg.lua")

function MakeJewelry1:upEvent(actor,leftIndex,makeIndex1,makeIndex2,makeIndex3) --#region 锻造
    if CheckOpenState(actor, 1) then return end
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

    if getbindmoney(actor,self.cfg[leftIndex]["money1"]) < self.cfg[leftIndex]["money2"] then
        return Sendmsg9(actor, "ff0000", "当前玩家货币"..self.cfg[leftIndex]["money1"].."数量少于"..self.cfg[leftIndex]["money2"].."！", 1)
    end
    if not consumebindmoney(actor,self.cfg[leftIndex]["money1"],self.cfg[leftIndex]["money2"],"首饰锻造1扣通用货币") then
        return Sendmsg9(actor, "ff0000", "货币" .. self.cfg[leftIndex]["money1"] .. "扣除失败！", 1)
    end
    for i = 1, 3 do
        if not delitembymakeindex(actor,makeIndexTab[i],1,"首饰锻造1扣除"..equipNameTab[i]) then
            return Sendmsg9(actor, "ff0000", equipNameTab[i].."物品扣除失败！", 1)
        end
    end

    local endEquipName = self.cfg[leftIndex]["end_arr"..indexTab[1]-1][math.random(#self.cfg[leftIndex]["end_arr"..indexTab[1]-1])]
    GiveItem(actor,endEquipName,1,0,"首饰锻造1"..endEquipName)
    sendmsgnew(actor,255,0,"上古锻造师：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功锻造"
    .."<『"..endEquipName.."』/FCOLOR=251>,获得属性提升！",1,2)
    Sendmsg9(actor,"00ff00","恭喜您成功锻造获得"..endEquipName.."！",1)
    lualib:FlushNpcUi(actor,"MakeJewelry1OBJ","成功#"..endEquipName)
end

return MakeJewelry1