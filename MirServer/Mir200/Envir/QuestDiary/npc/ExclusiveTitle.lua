local ExclusiveTitle = {}
ExclusiveTitle.cfg= GetConfig("ExclusiveTitleCfg")
function ExclusiveTitle:click(actor,npcid)
    local cfg = self.cfg[npcid]   
    local is_active = checktitle(actor,cfg.name)
    lualib:ShowNpcUi(actor,"ExclusiveTitleOBJ",npcid.."#".. (is_active and 1 or 0))
end
function ExclusiveTitle:DazaoClick(actor,npcid)
    local npc_id = tonumber(npcid)
    local cfg = self.cfg[npc_id]   
    local cur_map_id = getbaseinfo(actor,3)
    if checktitle(actor,cfg.name) then
        return Sendmsg9(actor, "ffffff","称号已经激活过！", 1)  
    end
    if getmapname(cur_map_id)  ~= cfg.map_name then
       return Sendmsg9(actor, "ffffff","请前往"..cfg.map_name.."打造！", 1)  
    end
    if getbagitemcount(actor,cfg.need_item) < cfg.need_item_count then
       return Sendmsg9(actor, "ffffff",string.format("打造需要：<font color='#FF0B0B'>%sX%s</font>",cfg.need_item,cfg.need_item_count), 1) 
    end

    if getbindmoney(actor, cfg.need_item2) < cfg.need_item_count2 then
        return Sendmsg9(actor, "FF0000", string.format("打造需要：%s*%s!",cfg.need_item2,cfg.need_item_count2), 1)
    end

    if not takeitem(actor,cfg.need_item,cfg.need_count,0,"专属时装扣除") then
        return Sendmsg9(actor, "FD0000",cfg.need_item.."扣除失败！" , 1) 
    end

    if not consumebindmoney(actor,cfg.need_item2,cfg.need_item_count2,"专属时装扣除") then
        return  Sendmsg9(actor, "FF0000", string.format("%s扣除失败!",cfg.need_item2), 1)
    end

    confertitle(actor,cfg.name)
    lualib:FlushNpcUi(actor,"ExclusiveTitleOBJ",1)
    Sendmsg9(actor, "00ff00",cfg.name.."晋升成功！" , 1) 
    sendmsgnew(actor,255,0,"恭喜: <『"..getbaseinfo(actor,1).. string.format("』/FCOLOR=254>成功晋升称号:<%s/FCOLOR=250>！",cfg.name) , 1, 2)
end
return ExclusiveTitle