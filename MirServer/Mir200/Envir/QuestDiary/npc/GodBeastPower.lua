local GodBeastPower = {}
GodBeastPower.cfg = GetConfig("GodBeastPowerCfg")
GodBeastPower.list_cfg = {
	[1] ={name = "ÇàÁúÖ®Á¦",need_item = "ÇàÁú»êÊ¯"},
	[2] ={name = "°×»¢Ö®Á¦",need_item = "°×»¢»êÊ¯"},
	[3] ={name = "ÖìÈ¸Ö®Á¦",need_item = "ÖìÈ¸»êÊ¯"},
	[4] ={name = "ÐþÎäÖ®Á¦",need_item = "ÐþÎä»êÊ¯"},
}
function GodBeastPower:click(actor)
    if CheckOpenState(actor, 1) then return end
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_god_beast_info"))
    if  data == "" then
        data = {}
        for i = 1, 4 do
            data[i] = 0
        end
        VarApi.setPlayerTStrVar(actor,"T_god_beast_info",tbl2json(data))
    end
    lualib:ShowNpcUi(actor,"GodBeastPowerOBJ",tbl2json(data))
end
function GodBeastPower:UpLevelClick(actor,btn_index)
    if CheckOpenState(actor, 1) then return end
    btn_index = tonumber(btn_index) or 0
    local cfg = self.list_cfg[btn_index]
    if cfg == nil then
        return  Sendmsg9(actor, "FF0000", cfg.name.."ÉñÊÞÖ®Á¦Êý¾ÝÒì³£", 1)   
    end
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_god_beast_info"))
    if  data == "" then
        for i = 1, 4 do
            data[i] = 0
        end
        VarApi.setPlayerTStrVar(actor,"T_god_beast_info",tbl2json(data))
    end
    local level = data[btn_index]
    if level >= #self.cfg then
        return  Sendmsg9(actor, "FF0000", cfg.name.."µÈ¼¶ÒÑÂú£¡", 1)
    end
    local level_cfg = self.cfg[level] 
    if getbagitemcount(actor, cfg.need_item, 0) < level_cfg.need_item_count then
        return  Sendmsg9(actor, "ffffff", "½úÉýÐèÒª"..cfg.need_item.."X"..level_cfg.need_item_count.."!", 1)
    end
    if getbindmoney(actor,level_cfg.need_money) < level_cfg.need_money_count then
        return  Sendmsg9(actor, "ffffff", "½úÉýÐèÒª"..level_cfg.need_money.."X"..level_cfg.need_money_count.."!", 1)
    end
    if not takeitem(actor,cfg.need_item,level_cfg.need_item_count,0,"ÉñÊÞÖ®Á¦½úÉý¿Û³ý") then
        return  Sendmsg9(actor, "ffffff", cfg.need_item.."¿Û³ýÊ§°Ü", 1)
    end
    if not consumebindmoney(actor,level_cfg.need_money,level_cfg.need_money_count,"ÉñÊÞÖ®Á¦½úÉý¿Û³ý") then
        return Sendmsg9(actor, "ff0000", "»õ±Ò" .. level_cfg.need_money .. "¿Û³ýÊ§°Ü£¡", 1)
    end
    data[btn_index] = level + 1
    VarApi.setPlayerTStrVar(actor,"T_god_beast_info",tbl2json(data))
    local new_title_name = cfg.name .. "Lv" .. data[btn_index]
    if data[btn_index] -1 > 0 then
        local old_title_name = cfg.name .. "Lv" .. data[btn_index] - 1
        deprivetitle(actor,old_title_name)
    end
    confertitle(actor,new_title_name)
    lualib:FlushNpcUi(actor,"GodBeastPowerOBJ",tbl2json(data))
    self:FlushGodBeastSuitBuff(actor)
end
function GodBeastPower:FlushGodBeastSuitBuff(actor)
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_god_beast_info"))
    if data == "" then
        return
    end
    local god_beast_suit_title = VarApi.getPlayerTStrVar(actor,"U_god_beast_suit_title")
    local level = 0
    for i,v in ipairs(data) do
        level = level + v
    end
    if level >= 60 and god_beast_suit_title ~= "60ÐÇÊÞ»êBUFF" then
        deprivetitle(actor,"45ÐÇÊÞ»êBUFF")
        deprivetitle(actor,"30ÐÇÊÞ»êBUFF")
        confertitle(actor,"60ÐÇÊÞ»êBUFF")
    elseif level >= 45 and god_beast_suit_title ~= "45ÐÇÊÞ»êBUFF"  then
        deprivetitle(actor,"30ÐÇÊÞ»êBUFF")
        confertitle(actor,"45ÐÇÊÞ»êBUFF")
    elseif level >= 30 and god_beast_suit_title ~= "30ÐÇÊÞ»êBUFF"then
        confertitle(actor,"30ÐÇÊÞ»êBUFF")
    end
end
return GodBeastPower