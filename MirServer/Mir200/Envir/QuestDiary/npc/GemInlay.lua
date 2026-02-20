local GemInlay = {}
GemInlay.cfg = GetConfig("GemInlayCfg")
GemInlay.compoundcfg = {
	[1]={tab_name = "普通宝石",need_item = {"黑铁#888","仙石#188"},need_money = {"元宝",2000},
    compound_list = "红宝石Lv1|黄宝石Lv1|蓝宝石Lv1|绿宝石Lv1|紫水晶Lv1"},
	[2]={tab_name = "传说宝石",need_item = {"红宝石Lv1#1","黄宝石Lv1#1","蓝宝石Lv1#1","绿宝石Lv1#1","紫水晶Lv1#1"},need_money = {"元宝",20000},
    compound_list = "憎恨结晶Lv1#1000|地狱熔核Lv1#1000|毁灭之心Lv1#1000|闪电水晶Lv1#100|亡者低语Lv1#100|裂界回响Lv1#1000|恶念具现Lv1#1000|时缚诅咒Lv1#1000|狱炎星火Lv1#100|圣裁余晖Lv1#100|炼狱魔石Lv1#1000|暮光契约Lv1#1000|盟约星光Lv1#1000|双生镜像Lv1#100|缚能咒印Lv1#100"},
    }

function GemInlay:click(actor)
    if CheckOpenState(actor, 2) then return end
    lualib:ShowNpcUi(actor,"GemInlayOBJ")
end
function GemInlay:InlayClick(actor,key_name,pos)
    if CheckOpenState(actor, 2) then return end
    key_name = tonumber(key_name)
    pos = tonumber(pos)
    local cfg = self.cfg[key_name]
    if cfg == nil then
       return Sendmsg9(actor, "ffffff", "请先选中要镶嵌的装备！", 1)  
    end
    local itemmakeid = GetItemByPos(actor,cfg.equip_pos)
    local equipName = getiteminfo(actor,itemmakeid,7)
    if key_name < 7 and (equipName == nil or equipName ~= cfg.can_inlay_name) then
        return Sendmsg9(actor, "ff0000", string.format("只有【%s】才能镶嵌宝石！",cfg.can_inlay_name) , 1)  
    end
    if key_name < 6 and GetItemStar(actor,itemmakeid) < 15 then
        return Sendmsg9(actor, "ff0000", string.format("【%s】需要在【白日门】附魔到【15星】才可以镶嵌宝石！",cfg.can_inlay_name) , 1)  
    end
    local gen_id =  GetInlayGem(actor,itemmakeid,pos-1)
    local level = 0
    if gen_id ~= nil and gen_id > 0 then
        local name =  getstditeminfo(gen_id,1)
        level = tonumber(strsplit(name,"Lv")[2]) 
        if level >= cfg.max_level then
           return  Sendmsg9(actor, "ff0000", string.format("【%s】最高只能镶嵌至<font color='#00ff00'>【Lv%s】</font>！",cfg.can_inlay_name,cfg.max_level) , 1)  
        end
    end
    local base_gen_name = cfg["inlay_pos"..pos].."Lv1"
    if getbagitemcount(actor,base_gen_name,0) < 1 then
       return Sendmsg9(actor, "ffffff", string.format("镶嵌需要：<font color='#ff0000'>%s</font>！",base_gen_name) , 1)  
    end
  
    if getbindmoney(actor,"元宝") < 1000 then
        return Sendmsg9(actor, "ffffff", "元宝不足1000！", 1)
    end
    if not takeitem(actor,base_gen_name,1,0,"宝石镶嵌扣除") then
        return Sendmsg9(actor, "ffffff", "宝石扣除失败！", 1)
    end
    if not consumebindmoney(actor,"元宝",1000,"宝石镶嵌扣除") then
        return Sendmsg9(actor, "ff0000", "货币元宝扣除失败！", 1)
    end

    local inlay_gen_name = cfg["inlay_pos"..pos] .. "Lv".. level + 1
    local item_id = getstditeminfo(inlay_gen_name,0)
    SetInlayGem(actor,itemmakeid,pos-1,0)
    SetInlayGem(actor,itemmakeid,pos-1,item_id)
    lualib:CallFuncByClient(actor, "screffects", 14813)
    lualib:FlushNpcUi(actor,"GemInlayOBJ","flush_inlay")
end
function GemInlay:CompoundClick(actor,key_name)
    if CheckOpenState(actor, 2) then return end
    key_name = tonumber(key_name)
    local cfg = self.compoundcfg[key_name]
    if cfg == nil then
        return Sendmsg9(actor, "ffffff", "请先选中合成页签！", 1)
    end
    for i,v in ipairs(cfg.need_item) do
        local data = strsplit(v,"#")
        local name = data[1]
        local count= tonumber(data[2]) 
        if getbagitemcount(actor,name,0) < count then
            return Sendmsg9(actor, "ffffff", string.format("合成需要：<font color='#ff0000'>%s*%s</font>！",name,count) , 1)  
        end
    end
    
    if getbindmoney(actor,cfg.need_money[1]) < cfg.need_money[2] then
        return Sendmsg9(actor, "ffffff",cfg.need_money[1].. "不足"..cfg.need_money[2].."!", 1)
    end

    for i,v in ipairs(cfg.need_item) do
        local data = strsplit(v,"#")
        local name = data[1]
        local count= tonumber(data[2]) 
        if not takeitem(actor,name,count,0,"宝石合成扣除") then
            return Sendmsg9(actor, "ffffff",name.. "扣除失败!", 1)  
        end
    end
    if not consumebindmoney(actor,cfg.need_money[1],cfg.need_money[2],"宝石合成扣除") then
       return Sendmsg9(actor, "ffffff", cfg.need_money[1].."扣除失败！", 1)
    end

    local compound_target = self.compoundcfg[key_name].compound_list 
    local result1 = ""
    if key_name == 1 then
        result1 = ransjstr(compound_target,0,1)
    else
        result1 = ransjstr(compound_target,1,1)
    end
    GiveItem(actor,result1,1,370,"宝石合成获得")
    ShowReward.showReward(actor, result1.."#1", 0)
    lualib:FlushNpcUi(actor,"GemInlayOBJ","flush_compound#"..result1)
    lualib:CallFuncByClient(actor, "screffects", 14802)
    
end
return GemInlay