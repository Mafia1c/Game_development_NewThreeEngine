local EquipTuJian = {}
EquipTuJian.cfg = GetConfig("EquipTuJianCfg")
function EquipTuJian:click(actor, index)
    local jump_flag = 0
    if index  then
        jump_flag = 1
    end
    index = index or 0
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_equip_tujian_active_info"))  
    if data == "" then
        data = {}
    end
    lualib:ShowNpcUi(actor,"EquipTuJianOBJ",tbl2json(data) .. "#" .. index .. "#" .. jump_flag)
end
function EquipTuJian:SubmitOnClick(actor,key_name)
    key_name = tonumber(key_name)
    local cfg = self.cfg[key_name]
    if cfg == nil then
        return Sendmsg9(actor, "ffffff", "请先选择装备!", 1)
    end
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_equip_tujian_active_info"))  
    if data == "" then
        data = {}
    end
    local is_active = false
    for i,v in ipairs(cfg.equip_list) do
        if not self:GetSigleIsActive(actor,key_name,v) then
            if getbagitemcount(actor, v,0) >= 1 and takeitem(actor,v,1,0,"装备图鉴扣除") then
                is_active = true
                data[key_name..""] = data[key_name..""] or {}
                table.insert(data[key_name..""],v) 
            end
        end
    end
    if is_active then
        Sendmsg9(actor, "ffffff", "已激活图鉴!", 1)
        VarApi.setPlayerTStrVar(actor,"T_equip_tujian_active_info",tbl2json(data),true)
        lualib:FlushNpcUi(actor,"EquipTuJianOBJ",tbl2json(data))
        self:FlushSuitAttr(actor)
    else
        return Sendmsg9(actor, "ffffff", "没有可提交的装备!", 1)
    end
end
function EquipTuJian:FlushSuitAttr(actor)
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_equip_tujian_active_info"))  
    if data == "" then
        return
    end
    delbuff(actor,60115)
    local list ={0,0,0,0}
    for k, v in pairs(data) do
        if self:GetSuitIsActive(actor,k) then
            local cfg = self.cfg[tonumber(k)]
            list[1] = list[1] + cfg.hp_attr
            if cfg.attack_attr1 then
                list[2] = list[2] + cfg.attack_attr1 * 100
            end 
            if cfg.attack_attr2 then
                list[3] = list[3] + cfg.attack_attr2 * 100
            end

            if cfg.attack_attr3 then
                list[4] = list[4] + cfg.attack_attr3 * 100
            end
           
        end
    end
    local attr_str = "3#30#"..list[1].."|3#35#"..list[2].."|3#37#"..list[3].."|3#36#"..list[4]
    local attr_tab = ParserAttrStrToTable(attr_str)
    addbuff(actor,60115,0,1,actor,attr_tab)
end
function EquipTuJian:GetSuitIsActive(actor,key_name)
    local cfg = self.cfg[tonumber(key_name)]
    for i,v in ipairs(cfg.equip_list) do
        if not self:GetSigleIsActive(actor,key_name,v) then
            return false
        end
    end
    return true
end
function EquipTuJian:GetSigleIsActive(actor,key_name,equip_name)
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_equip_tujian_active_info"))  
    if data == "" then
        return false
    end
    return isInTable(data[key_name..""],equip_name)  
end
return EquipTuJian