local ExclusiveFashion = {}
ExclusiveFashion.cfg = GetConfig("ExclusiveFashionCfg")
ExclusiveFashion.cfg_map = {}
for i,v in ipairs(ExclusiveFashion.cfg) do
	ExclusiveFashion.cfg_map[v.npc_id] = ExclusiveFashion.cfg_map[v.npc_id] or {}
	table.insert(ExclusiveFashion.cfg_map[v.npc_id],v)
end
function ExclusiveFashion:click(actor,npc_id)
    local fashion_type = self.cfg_map[npc_id][1].fashion_type
    local active_str = ""
    if fashion_type == 1 then --魔兽
        active_str = VarApi.getPlayerTStrVar(actor, "T_warcraft_info")
    elseif fashion_type == 2 then --时装
        active_str =  VarApi.getPlayerTStrVar(actor, "T_fashion_info")
    elseif fashion_type == 3 then --魂环
        active_str = VarApi.getPlayerTStrVar(actor, "T_soul_ring_info")
    elseif fashion_type == 4 then -- 称号
    
    end
    lualib:ShowNpcUi(actor,"ExclusiveFashionOBJ",fashion_type .. "#" .. active_str) 
end
function ExclusiveFashion:DaZaoClick(actor,key)
    key = tonumber(key)
    local cfg = self.cfg[key]
    local cur_map_id = getbaseinfo(actor,3)
    if cur_map_id ~= cfg.mapid then
       return Sendmsg9(actor, "ffffff","专属时装数据异常", 1)  
    end
    local var_str = ""
    local buff_id = ""
    local tip_str = ""
    if cfg.fashion_type == 1 then --魔兽
        var_str = "T_warcraft_info"
        buff_id = 50017
        tip_str = "魔兽"
    elseif cfg.fashion_type == 2 then --时装
        var_str = "T_fashion_info"
        buff_id = 50011
        tip_str = "时装"
        
    elseif cfg.fashion_type == 3 then --魂环
        var_str = "T_soul_ring_info"
        buff_id = 50014
        tip_str = "魂环"
    end
    if var_str == "" then
       return Sendmsg9(actor, "ffffff","专属时装类型异常", 1) 
    end
    local active_str = VarApi.getPlayerTStrVar(actor, var_str)
    if string.find(active_str,cfg.name,1,true)  then
        return Sendmsg9(actor, "FD0000",string.format("你已经拥有【%s】",cfg.name) , 1) 
    end
          
    if getbagitemcount(actor,cfg.need_item) < cfg.need_count then
       return Sendmsg9(actor, "ffffff",string.format("打造需要：<font color='#FF0B0B'>%sX%s</font>",cfg.need_item,cfg.need_count), 1) 
    end
    local item_indx = getstditeminfo(cfg.need_item2, 0)
    if item_indx > 10000 then
        if getbagitemcount(actor,cfg.need_item2) < cfg.need_count2 then
           return Sendmsg9(actor, "ffffff",string.format("打造需要：<font color='#FF0B0B'>%sX%s</font>",cfg.need_item2,cfg.need_count2), 1) 
        end
    else
        if tonumber(getbindmoney(actor, cfg.need_item2)) < cfg.need_count2 then
            return Sendmsg9(actor, "ffffff",string.format("打造需要：<font color='#FF0B0B'>%sX%s</font>",cfg.need_item2,cfg.need_count2), 1) 
        end
    end
    if not takeitem(actor,cfg.need_item,cfg.need_count,0,"专属时装扣除") then
        return Sendmsg9(actor, "FD0000",cfg.need_item.."扣除失败！" , 1) 
    end
    
    if item_indx > 10000 then
        if not takeitem(actor,cfg.need_item2,cfg.need_count2,0,"专属时装扣除") then
            return Sendmsg9(actor, "FD0000",cfg.need_item2.."扣除失败！" , 1) 
        end    
    else
        if not consumebindmoney(actor, cfg.need_item2, cfg.need_count2, "专属时装扣除") then
           return  Sendmsg9(actor, "FD0000",cfg.need_item2.."扣除失败！" , 1) 
        end
    end
    
    active_str = cfg.name .. "|" .. active_str
    VarApi.setPlayerTStrVar(actor, var_str, active_str, true)
    OtherTrigger.AttributeTransformation(actor, active_str, buff_id)
    lualib:FlushNpcUi(actor,"ExclusiveFashionOBJ",cfg.fashion_type.."#"..active_str)
    sendmsgnew(actor,255,0,"恭喜: <『"..getbaseinfo(actor,1).. string.format("』/FCOLOR=254>成功打造出:<%s/FCOLOR=250>！",cfg.name) , 1, 2)
    Sendmsg9(actor, "ffffff", string.format("成功激活装扮，可前往<font color='#00FF00'>[装扮→%s]</font>查看！",tip_str) , 1) 
end
return ExclusiveFashion
