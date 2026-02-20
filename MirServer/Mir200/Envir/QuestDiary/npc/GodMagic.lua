local GodMagic = {}
GodMagic.cfg = include("QuestDiary/config/GodMagicCfg.lua")
GodMagic.equipTab1={[10]={"圣辉·初曦",91},[20]={"神谕·净世",92},[30]={"天罚·裁罪",93},[40]={"穹苍·织星",94}}
GodMagic.equipTab2={[10]={"魔骸·蚀骨",97},[20]={"渊狱·泣血",98},[30]={"寂灭·吞灵",99},[40]={"永夜·无妄",100}}

function GodMagic:click(actor)
    if CheckOpenState(actor, 2) then return end
    if VarApi.getPlayerUIntVar(actor,"U_LayerStudy")<14 then
        return Sendmsg9(actor, "ff0000", "请先修炼至大道境再来提升！", 1)
    end
    lualib:ShowNpcUi(actor, "GodMagicOBJ", "")
end
function GodMagic:upEvent(actor,index)
    if CheckOpenState(actor, 2) then return end
    index = tonumber(index)
    local layer = VarApi.getPlayerUIntVar(actor,"U_GodMagic"..index) --#region 神或魔阶段
    if not isInTable({1,2},index) then
        return Sendmsg9(actor, "ff0000", "升级序列异常！", 1)
    elseif layer>=#self.cfg then
        return Sendmsg9(actor, "ff0000", "当前真元已升至最高等级！", 1)
    end

    local itemName = self.cfg[layer+1]["need"..index]
    local itemIndex = getstditeminfo(itemName,0)
    local itemCount = self.cfg[layer+1]["number"..index]
    if getbagitemcount(actor,itemName,"0") < itemCount then
        return Sendmsg9(actor, "ff0000", "当前背包物品"..itemName.."数量少于"..itemCount.."！", 1)
    end
    if not takeitem(actor,itemName,itemCount,0,itemName.."神魔升级背包扣物品") then
        return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
    end

    local name={"神之真元","魔之真元"}
    if self["equipTab"..index][layer+1] then
        GiveOnItem(actor,self["equipTab"..index][layer+1][2],self["equipTab"..index][layer+1][1],1,8503,"神魔真元获得")
    end
    local str = self.cfg[layer+1]["attStr0"].."|"..self.cfg[layer+1]["attStr"..index]
    delattlist(actor,"godMagic_attr"..index)
    delbuff(actor,40100+index)
    addbuff(actor,40100+index,0,0,actor,ParserAttrStrToTable(str))
    VarApi.setPlayerTStrVar(actor,"T_godMagic_attr"..index,str,false)
    VarApi.setPlayerUIntVar(actor,"U_GodMagic"..index,layer+1,true)
    -- sendmsgnew(actor,255,0,"神魔真元：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功升级"
    -- .."<『"..name[index].."』至"..(layer+1).."/FCOLOR=251>,获得属性提升！",1,2)
    lualib:FlushNpcUi(actor,"GodMagicOBJ","提升")
end

return GodMagic