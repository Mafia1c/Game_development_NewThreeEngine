local GodHammer = {}
GodHammer.cfg = GetConfig("GodHammerCfg")
GodHammer.cfg_map = {}
GodHammer.cfg_map[1] ={tag_name= "乾坤宝炉",
put_in_equip1 = {"阎罗战盔","阎罗战链","阎罗战镯","阎罗战戒","阎罗战带","阎罗战靴"},target_equip1 = {"圣山战盔","圣山战链","圣山战镯","圣山战戒","圣山战带","圣山战靴"},
put_in_equip2 = {"毁灭魔盔","毁灭魔链","毁灭魔镯","毁灭魔戒","毁灭魔带","毁灭魔靴"},target_equip2 = {"冥王魔盔","冥王魔链","冥王魔镯","冥王魔戒","冥王魔带","冥王魔靴"},
put_in_equip3 = {"避邪道盔","避邪道链","避邪道镯","避邪道戒","避邪道带","避邪道靴"},target_equip3 = {"如来道盔","如来道链","如来道镯","如来道戒","如来道带","如来道靴"},}
for i,v in ipairs(GodHammer.cfg) do
	GodHammer.cfg_map[v.tag_type] = GodHammer.cfg_map[v.tag_type] or {}
	GodHammer.cfg_map[v.tag_type].tag_name = v.tag_name
	table.insert(GodHammer.cfg_map[v.tag_type],v)
end
function GodHammer:click(actor)
    lualib:ShowNpcUi(actor,"GodHammerOBJ")
end
function GodHammer:ForgeClick(actor,makeIndex1,makeIndex2,makeIndex3)
    if not makeIndex1 or not makeIndex2 or not makeIndex3 then
        return Sendmsg9(actor, "ff0000",  "当前物品数据异常" , 1)
    end
    local makeIndexTab={(makeIndex1),(makeIndex2),(makeIndex3)}
    local equipNameTab ={getiteminfo(actor,makeIndexTab[1],7),getiteminfo(actor,makeIndexTab[2],7),getiteminfo(actor,makeIndexTab[3],7)}
    local indexTab={}
    for index, value in ipairs(equipNameTab) do
        for i = 1, 3 do
            if isInTable(self.cfg_map[1]["put_in_equip"..i],value) then
                table.insert(indexTab,i)
                break
            end
        end
    end
    if indexTab[1]~=indexTab[2] or indexTab[2]~=indexTab[3] or indexTab[1]~=indexTab[3] then
        return Sendmsg9(actor, "ff0000",  "请选择同类型的3个首饰！" , 1)
    end

    if getbagitemcount(actor,"仙石",0) < 199 then
        return Sendmsg9(actor, "ff0000", "当前背包物品仙石数量少于199！", 1) 
    end

    -- if getbindmoney(actor,"元宝") < 20000 then
    --     return Sendmsg9(actor, "ff0000", "当前元宝数量少于20000！", 1) 
    -- end
    if not takeitem(actor,"仙石",199,0,"天神之锤 宝炉扣除") then
        return Sendmsg9(actor, "ff0000", "仙石扣除失败", 1) 
    end
    -- if not consumebindmoney(actor,"元宝",20000,"天神之锤 宝炉扣除") then
    --     return Sendmsg9(actor, "ff0000", "元宝扣除失败", 1) 
    -- end
    for i = 1, 3 do
        if not delitembymakeindex(actor,makeIndexTab[i],1,"天神之锤 宝炉扣除"..equipNameTab[i]) then
            return Sendmsg9(actor, "ff0000", equipNameTab[i].."物品扣除失败！", 1)
        end
    end
    local target_list = self.cfg_map[1]["target_equip"..indexTab[1]]
    local endEquipName = target_list[math.random(1,#target_list)]  
    GiveItem(actor,endEquipName,1,0,"天神之锤 宝炉获得")
    lualib:CallFuncByClient(actor, "screffects", 14801)
    Sendmsg9(actor, "00ff00", "成功锻造出："..endEquipName.."!", 1) 
    sendmsgnew(actor,255,0,"恭喜: <『"..getbaseinfo(actor,1).."』/FCOLOR=250>人品爆发，成功锻造出：<『"..endEquipName.."』/FCOLOR=251>！", 1, 2)
    lualib:FlushNpcUi(actor,"GodHammerOBJ","flush_baolu#"..endEquipName)
end
function GodHammer:DazaoClick(actor,left_index,index)
    index = tonumber(index)
    left_index = tonumber(left_index)
    if index == nil or index <= 0 or self.cfg_map[left_index] == nil then
        return Sendmsg9(actor, "ff0000",  "请先选中要锻造的装备页签" , 1)
    end
    local cfg = self.cfg_map[left_index][index]
    for i,v in ipairs(cfg.need_item_list_map) do
        if getbagitemcount(actor,v[1],0) < v[2] then
            return Sendmsg9(actor, "ff0000", "当前背包物品"..v[1].."数量少于"..v[2].."！", 1) 
        end
    end
 
    -- if getbindmoney(actor,cfg.need_money) < cfg.need_money_count then
    --     return Sendmsg9(actor, "ff0000", "当前"..cfg.need_money.. "数量少于"..cfg.need_money_count.."！", 1) 
    -- end

    for i,v in ipairs(cfg.need_item_list_map) do
        if not takeitem(actor,v[1],v[2],0,"天神之锤 神话扣除") then
            return Sendmsg9(actor, "ff0000", v[1].."扣除失败", 1) 
        end
    end
    
    -- if not consumebindmoney(actor,cfg.need_money,cfg.need_money_count,"天神之锤 神话扣除") then
    --     return Sendmsg9(actor, "ff0000",cfg.need_money.. "扣除失败", 1) 
    -- end
    GiveItem(actor,cfg.target_name,1,0,"天神之锤 神话打造")
    lualib:CallFuncByClient(actor, "screffects", 14801)
    Sendmsg9(actor, "00ff00", "成功锻造出："..cfg.target_name.."!", 1) 
    sendmsgnew(actor,255,0,"恭喜: <『"..getbaseinfo(actor,1).."』/FCOLOR=250>人品爆发，成功锻造出：<『"..cfg.target_name.."』/FCOLOR=251>！", 1, 2)
    lualib:FlushNpcUi(actor,"GodHammerOBJ","flush_baolu#"..cfg.target_name)
end
return GodHammer