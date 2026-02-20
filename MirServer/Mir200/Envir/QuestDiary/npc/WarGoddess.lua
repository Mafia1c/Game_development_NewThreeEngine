local WarGoddess = {}
WarGoddess.cfg = GetConfig("WarGoddessCfg")

function WarGoddess:click(actor,npcId)
    lualib:ShowNpcUi(actor,"WarGoddessOBJ",npcId)
end
function WarGoddess:UpLevelClick(actor,key_name)
    key_name = tonumber(key_name)
    local cfg = self.cfg[key_name]
    if cfg == nil then
        Sendmsg9(actor, "ffffff", "战争女神数据异常！", 1)
        return  
    end
    local map_id = getbaseinfo(actor,3)
    local map_name = getmapname(map_id)
    if cfg.drop_map ~= map_name then
        return Sendmsg9(actor, "FF0000",  "请前往"..map_name.."打造！", 1)
    end
    local makeIndex = GetItemByPos(actor,cfg.equip_pos)
    if makeIndex then
        local equip_name = getiteminfo(actor,makeIndex,7)
        if equip_name == cfg.name then
           return  Sendmsg9(actor, "FF0000",  string.format("你已经拥有【%s】",cfg.name), 1)
        end
    end
    if getbagitemcount(actor,cfg.need_item,0) < cfg.need_item_count then
       return  Sendmsg9(actor, "FF0000", string.format("打造需要：%s*%s!",cfg.need_item,cfg.need_item_count), 1)
    end

    if getbindmoney(actor, cfg.need_item2) < cfg.need_item_count2 then
        return Sendmsg9(actor, "FF0000", string.format("打造需要：%s*%s!",cfg.need_item2,cfg.need_item_count2), 1)
    end
   

    if not takeitem(actor,cfg.need_item,cfg.need_item_count,0,"战争女神扣除") then
        return  Sendmsg9(actor, "FF0000", string.format("%s扣除失败!",cfg.need_item), 1)
    end

    if not consumebindmoney(actor,cfg.need_item2,cfg.need_item_count2,"元神之力扣除") then
        return  Sendmsg9(actor, "FF0000", string.format("%s扣除失败!",cfg.need_item2), 1)
    end
    
    GiveOnItem(actor,cfg.equip_pos,cfg.name,1,370,"战争女神获得")
    local itemmakeid = GetItemByPos(actor,45)
    setitemstate(actor,itemmakeid,65536,1)
    Sendmsg9(actor, "00ff00", cfg.name .. "·打造成功！", 1)
    local player_name = getbaseinfo(actor,1)
    local str =  "恭喜:<「%s」/FCOLOR=254>成功打造出：<%s/FCOLOR=250>属性暴涨！"
    sendmsgnew(actor,255,0,string.format(str,player_name,cfg.name),1,1)
    lualib:FlushNpcUi(actor,"WarGoddessOBJ")
end

return WarGoddess