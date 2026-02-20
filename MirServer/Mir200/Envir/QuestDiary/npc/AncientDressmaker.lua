local  AncientDressmaker = {}
AncientDressmaker.cfg = GetConfig("AncientDressmakerCfg")
AncientDressmaker.cfg_map = {}
for i,v in ipairs(AncientDressmaker.cfg) do
    AncientDressmaker.cfg_map[v.npc_id] = AncientDressmaker.cfg_map[v.npc_id] or {}
    table.insert(AncientDressmaker.cfg_map[v.npc_id],v) 
end 
function AncientDressmaker:click(actor,npc_id)
    lualib:ShowNpcUi(actor,"AncientDressmakerOBJ",npc_id)
end
function AncientDressmaker:ForgeClick(actor,npcid,index)
    npcid = tonumber(npcid)
    index = tonumber(index)
    if self.cfg_map[npcid] == nil or self.cfg_map[npcid][index] == nil then
       return Sendmsg9(actor, "ffffff", "上古裁缝数据异常！", 1) 
    end
    local cfg = self.cfg_map[npcid][index]
    local map_id = getbaseinfo(actor,3)
    if map_id ~= cfg.map_id then
       return Sendmsg9(actor, "ffffff", string.format("请前往%s打造！",getmapname(cfg.map_id)) , 1) 
    end
    for i,v in ipairs(cfg.need_item_list_map) do
        if getbagitemcount(actor,v[1],0) < v[2] then
            return Sendmsg9(actor, "ffffff",string.format("锻造需要：<font color='#FF0B0B'>%sX%s</font>",v[1],v[2]) , 1) 
        end
    end
    -- if querymoney(actor,getstditeminfo(cfg.need_money,0)) < cfg.need_money_count then
    --    return Sendmsg9(actor, "ffffff",string.format("锻造需要：<font color='#FF0B0B'>%sX%s</font>",cfg.need_money,cfg.need_money_count) , 1) 
    -- end

    for i,v in ipairs(cfg.need_item_list_map) do
        if not takeitem(actor,v[1],v[2],0,"上古裁缝扣除")  then
           return  Sendmsg9(actor, "FF0000",v[1].."扣除失败！", 1) 
        end
    end
    -- if not ChangeMoney(actor,getstditeminfo(cfg.need_money,0),"-",cfg.need_money_count,"上古裁缝扣除",true) then
    --     return  Sendmsg9(actor, "FF0000",cfg.need_money.."扣除失败！", 1) 
    -- end
    GiveItem(actor,cfg.tag_name,1,0,"上古裁缝打造")
    Sendmsg9(actor, "00FF00","成功锻造出："..cfg.tag_name,1) 
    sendmsgnew(actor,255,0,"恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=250>人品爆发，成功锻造出：<"..cfg.tag_name.."/FCOLOR=251>！",1,2)
    lualib:FlushNpcUi(actor,"AncientDressmakerOBJ")
end
return AncientDressmaker