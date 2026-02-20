PickupItemexTrigger = {}

--#region 拾取前触发(玩家对象，物品唯一ID)return false阻止拾取
function PickupItemexTrigger.pickupitemfrontex(actor,makeIndex)
    local itemId = getiteminfo(actor, makeIndex, 2) --#region 物品id
    local itemName = getiteminfo(actor, makeIndex, 7) --#region 物品名称
    local tag = GetInt(3, makeIndex, "U_throw_tag")
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if tag ~= 1 and mzl_state == 0 then
        setitemstate(actor, makeIndex, 370, 1)
    end
    
    IncludeNpcClass("EquipVariation"):setEquipVariation(actor, makeIndex) --#region 装备变异
    return true
end

--#region 拾取触发(玩家对象,物品唯一id,物品id)
function PickupItemexTrigger.pickupitemex(actor,itemMakeIndex,itemIndex)
    
end