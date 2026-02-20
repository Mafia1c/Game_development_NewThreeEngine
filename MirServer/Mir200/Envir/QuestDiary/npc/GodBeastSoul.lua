local GodBeastSoul = {}
GodBeastSoul.cfg = GetConfig("GodBeastSoulCfg")
GodBeastSoul.list_cfg = {"青龙之力","白虎之力","朱雀之力","玄武之力"}
function GodBeastSoul:click(actor)
    if CheckOpenState(actor, 2) then return end
    local level = VarApi.getPlayerUIntVar(actor,"U_god_beast_soul_level")
    lualib:ShowNpcUi(actor,"GodBeastSoulOBJ",level)
end
function GodBeastSoul:UpLevelClick(actor)
    if CheckOpenState(actor, 2) then return end
    local level = VarApi.getPlayerUIntVar(actor,"U_god_beast_soul_level")
    if level >= #self.cfg then
       return Sendmsg9(actor, "ffffff","神兽之灵已满级！", 1)
    end
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_god_beast_info"))
    if data == "" then
        data = {0,0,0,0}
    end
    local is_can_level = true
    for i,v in ipairs(data) do
        if v < 15 then
            is_can_level = false
            Sendmsg9(actor, "ffffff",string.format("升级需要：<font color='#FF0B0B'>【%s·Lv15】</font> <font color='#00FF00'>当前：【Lv%s】</font>",self.list_cfg[i],v)  , 1)
        end
    end
    if not is_can_level  then
       return 
    end
   
    local cfg = self.cfg[level]
    for i = 1, 4 do
        if cfg["need_count"..i] > 0 and getbagitemcount(actor, cfg["need_item"..i], 0) < cfg["need_count"..i] then
            return  Sendmsg9(actor, "ffffff",string.format("升级需要：<font color='#FF0B0B'>%sX%s</font>",cfg["need_item"..i],cfg["need_count"..i]), 1)
        end
    end
    if cfg.need_money and  getbindmoney(actor,cfg.need_money) < cfg.need_money_count then
        return  Sendmsg9(actor, "ffffff",string.format("升级需要：<font color='#FF0B0B'>%sX%s</font>",cfg.need_money,cfg.need_money_count), 1)
    end

    for i = 1, 4 do
        if cfg["need_count"..i]  > 0  then
            if not takeitem(actor, cfg["need_item"..i],cfg["need_count"..i],0,"神兽之灵扣除")then
                return  Sendmsg9(actor, "ffffff","道具"..cfg["need_item"..i].."扣除失败！", 1)
            end
        end
    end
    if cfg.need_money and  not consumebindmoney(actor,cfg.need_money,cfg.need_money_count,"神兽之灵扣除") then
        return Sendmsg9(actor, "ff0000", "货币" .. cfg.need_money .. "扣除失败！", 1)
    end
    local w = getconst(actor, "<$SCREENWIDTH>")
    local h = getconst(actor, "<$SCREENHEIGHT>")
    local effect_id = level %10 == 9 and 14847 or 14811
    
    local next_cfg = self.cfg[level+1]
    delbuff(actor, 60118)
    delbuff(actor, 60119)
    local level_attr_str = string.format("3#9#%s|3#10#%s|3#11#%s|3#12#%s|3#89#%s",next_cfg.attr1,next_cfg.attr2,next_cfg.attr1,next_cfg.attr2,next_cfg.attr3*100)
    local attr_tab = ParserAttrStrToTable(level_attr_str)
    addbuff(actor,60118,0,1,actor,attr_tab)
    local topo_attr_str = string.format("3#55#%s|3#57#%s|3#59#%s|3#25#%s",next_cfg.attr4*100,next_cfg.attr5*100,next_cfg.attr6*100,next_cfg.attr7)
    local attr_tab2 = ParserAttrStrToTable(topo_attr_str)
    addbuff(actor,60119,0,1,actor,attr_tab2)


    lualib:CallFuncByClient(actor, "screffects", effect_id)
    VarApi.setPlayerUIntVar(actor,"U_god_beast_soul_level",level + 1)
    lualib:FlushNpcUi(actor,"GodBeastSoulOBJ",level + 1)
end

return GodBeastSoul