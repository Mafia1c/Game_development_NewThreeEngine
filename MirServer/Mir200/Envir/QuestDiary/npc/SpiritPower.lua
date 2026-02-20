local SpiritPower = {}
SpiritPower.cfg = GetConfig("SpiritPowerCfg")
local npc_key_map  = {[164]=1,[175]=2,[190]=3} 
function SpiritPower:click(actor,npcId)
    local key = npc_key_map[npcId]
    lualib:ShowNpcUi(actor,"SpiritPowerOBJ",key)
end
function SpiritPower:UpLevelClick(actor,key_name)
    key_name = tonumber(key_name)
    local cfg = self.cfg[key_name]
    if cfg == nil then
        Sendmsg9(actor, "ffffff", "元神之力数据异常！", 1)
        return  
    end
    local map_id = getbaseinfo(actor,3)
    local map_name = getmapname(map_id)
    if cfg.drop_map ~= map_name then
        return Sendmsg9(actor, "FF0000",  "请前往"..map_name.."打造！", 1)
    end
    local level = VarApi.getPlayerUIntVar(actor,"U_spirit_level")
    if level >= cfg.key_name then
       return Sendmsg9(actor, "FF0000",  string.format("你已经拥有【%s】",cfg.name), 1)
    end

    if cfg.key_name ~= 1 and level < 1 then
       return  Sendmsg9(actor, "FF0000", "请先前往【风暴峡谷】打造【元神之力·三魂】", 1)
    end

    if cfg.key_name == 3 and level < 2 then
       return Sendmsg9(actor, "FF0000", "请先前往【雪原】打造【元神之力·七魄】", 1)
    end

    for i = 1, 2 do
        if VarApi.getPlayerUIntVar(actor,"U_GodMagic"..i) < cfg.need_level then
            return Sendmsg9(actor, "FF0000", "打造需要：".. (i==1 and "神之真元" or "魔之真元") .. "Lv"..cfg.need_level, 1)
        end
    end

    if getbagitemcount(actor,cfg.need_item1,0) < cfg.need_item_count1 then
       return  Sendmsg9(actor, "FF0000", string.format("打造需要：%s*%s!",cfg.need_item1,cfg.need_item_count1), 1)
    end
    local std_mode = getstditeminfo(cfg.need_item2,2)
    local count = 0
    if std_mode == 41 then
        count = getbindmoney(actor, cfg.need_item2)
    else
        count = getbagitemcount(actor,cfg.need_item2,0)
    end

    if count < cfg.need_item_count2 then
        return Sendmsg9(actor, "FF0000", string.format("打造需要：%s*%s!",cfg.need_item2,cfg.need_item_count2), 1)
    end

    if not takeitem(actor,cfg.need_item1,cfg.need_item_count1,0,"元神之力扣除") then
        return  Sendmsg9(actor, "FF0000", string.format("%s扣除失败!",cfg.need_item1), 1)
    end
    if std_mode == 41 then
        if not consumebindmoney(actor,cfg.need_item2,cfg.need_item_count2,"元神之力扣除") then
            return  Sendmsg9(actor, "FF0000", string.format("%s扣除失败!",cfg.need_item2), 1)
        end
    else
        if not takeitem(actor,cfg.need_item2,cfg.need_item_count2,0,"元神之力扣除") then
            return  Sendmsg9(actor, "FF0000", string.format("%s扣除失败!",cfg.need_item2), 1)
        end
    end
    
    VarApi.setPlayerUIntVar(actor,"U_spirit_level",level + 1,true)
    delbodyitem(actor,45,"元神之力扣除")
    GiveOnItem(actor,45,cfg.name,1,370,"元神之力获得")
    local itemmakeid = GetItemByPos(actor,45)
    setitemstate(actor,itemmakeid,65536,1)

    local player_name = getbaseinfo(actor,1)
    local str =  "恭喜:<「%s」/FCOLOR=254>成功打造出：<%s/FCOLOR=250>！"
    sendmsgnew(actor,255,0,string.format(str,player_name,cfg.name),1,1)
    Sendmsg9(actor, "00ff00", cfg.name .. "·打造成功！", 1)
    lualib:FlushNpcUi(actor,"SpiritPowerOBJ")
end

function SpiritPower:ExchangeClick(actor,key_name,num)
    key_name = tonumber(key_name)
    num = tonumber(num)
    num = num > 1 and 10 or 1

    local cfg = self.cfg[key_name]
    if cfg == nil then
        Sendmsg9(actor, "ffffff", "元神之力数据异常！", 1)
        return  
    end
    if getbagitemcount(actor,"黄金钥匙",0) < num * 5 then
        return Sendmsg9(actor, "FF0000", "兑换需要：黄金钥匙*"..num * 5, 1)
    end
    if not takeitem(actor,"黄金钥匙",num * 5,0,"元神之力兑换") then
        return Sendmsg9(actor, "FF0000", "黄金钥匙扣除失败", 1)
    end
    GiveItem(actor,cfg.need_item,num,370,"元神之力兑换")
    Sendmsg9(actor, "1EFF00", "成功兑换："..cfg.need_item.."*"..num, 1)
    lualib:FlushNpcUi(actor,"SpiritPowerOBJ")
end

return SpiritPower