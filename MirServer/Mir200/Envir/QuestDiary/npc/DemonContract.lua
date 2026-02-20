local DemonContract = {}
DemonContract.cfg = GetConfig("DemonContractCfg")
DemonContract.talent_cfg = GetConfig("DemonContractTalentCfg")
DemonContract.cfg_map = {}
DemonContract.pre_talent_tab = {}
DemonContract.pre_talent_value={}
for i,v in ipairs(DemonContract.cfg) do
	DemonContract.cfg_map[v.map_type] = DemonContract.cfg_map[v.map_type] or {}
	DemonContract.cfg_map[v.map_type][v.tujian_type] = DemonContract.cfg_map[v.map_type][v.tujian_type] or {}
	table.insert(DemonContract.cfg_map[v.map_type][v.tujian_type],v) 
end
function DemonContract:click(actor, npc_id, map_type,index,page_index)
    page_index = page_index or 1
    map_type = map_type or 1
    if page_index == 1 then
        index = index or 1
        local star_data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_mon_tujian_star")) 
        if star_data == "" then
            star_data = {}
            for i,v in ipairs(DemonContract.cfg) do
                table.insert(star_data,0)
            end
            VarApi.setPlayerTStrVar(actor,"T_mon_tujian_star",tbl2json(star_data) )
        end
        lualib:ShowNpcUi(actor,"DemonContractOBJ",page_index .."#"..tbl2json(star_data) .. "#" .. index.."#"..map_type)
    else
        local cur_talent = VarApi.getPlayerUIntVar(actor,"U_total_talent_value")
        local talent_tab = {}
        for i = 1, 13 do
            talent_tab[i]= VarApi.getPlayerUIntVar(actor,"U_talent_value"..i)
        end
        self.pre_talent_tab[actor] = {0,0,0,0,0,0,0,0}
        self.pre_talent_value[actor] = VarApi.getPlayerUIntVar(actor,"U_total_talent_value")
        lualib:ShowNpcUi(actor,"DemonContractOBJ",page_index .."#"..cur_talent.."#"..tbl2json(talent_tab) )
    end
end
function DemonContract:PageClick(actor,page_index)
    page_index = tonumber(page_index)
    if page_index == nil then return end
    if page_index == 1 then
        local star_data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_mon_tujian_star")) 
        if star_data == "" then
            star_data = {}
            for i,v in ipairs(DemonContract.cfg) do
                table.insert(star_data,0)
            end
            VarApi.setPlayerTStrVar(actor,"T_mon_tujian_star",tbl2json(star_data) )
        end
        lualib:FlushNpcUi(actor,"DemonContractOBJ","change_page#"..page_index .."#"..tbl2json(star_data))
    else
        local cur_talent = VarApi.getPlayerUIntVar(actor,"U_total_talent_value")
        local talent_tab = {}
        for i = 1, 13 do
            talent_tab[i]= VarApi.getPlayerUIntVar(actor,"U_talent_value"..i)
        end
        self.pre_talent_tab[actor] = {0,0,0,0,0,0,0,0}
        self.pre_talent_value[actor] = VarApi.getPlayerUIntVar(actor,"U_total_talent_value")
        lualib:FlushNpcUi(actor,"DemonContractOBJ","change_page#".. page_index .."#"..cur_talent.."#"..tbl2json(talent_tab) )
    end
end

function DemonContract:SubmitBtnClick(actor,map_type,type_index)
    map_type = tonumber(map_type)
    type_index = tonumber(type_index)
    local temp = VarApi.getPlayerUIntVar(actor,"U_bigMap") --#region 进入大陆标识
    if  map_type >=2 and temp < 2 then
        return  Sendmsg9(actor, "ff0000", "请先前往白日门后再激活！", 1)
    end
    if map_type >= 3 and temp < 3 then
        return  Sendmsg9(actor, "ff0000", "请先前往封魔谷后再激活！", 1)
    end
    local cfg = self.cfg_map[map_type][type_index]
    if cfg == nil then
        return  Sendmsg9(actor, "ff0000", "页签选中异常~"..type_index, 1)
    end

    local star_data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_mon_tujian_star")) 
    if star_data == "" then
        star_data = {}
    end
    local is_submit = false
    for i,v in ipairs(cfg) do
        local item_count = getbagitemcount(actor, v.need_item,0)
        local cur_star = star_data[v.key_name] or 0
        if item_count > 0 then
            if takeitem(actor,v.need_item,item_count,0) then
                if cur_star < 3  then
                    local num = item_count > 3 - cur_star and 3 - cur_star or item_count
                    VarApi.setPlayerUIntVar(actor,"U_total_talent_value",VarApi.getPlayerUIntVar(actor,"U_total_talent_value") + num * v.talent_value,true)
                end
                star_data[v.key_name] = cur_star + item_count > 3 and 3 or cur_star + item_count
                ChangeMoney(actor,15,"+",v.prestige_value * item_count,"恶魔契约激活",true)
                is_submit = true
            end
        end
    end
    if not is_submit then
       return  Sendmsg9(actor, "ffffff", "你没有可提交的图鉴卡片！", 1)
    end
    VarApi.setPlayerTStrVar(actor,"T_mon_tujian_star",tbl2json(star_data) )
    Sendmsg9(actor, "ffffff", "提交成功", 1)
    lualib:FlushNpcUi(actor,"DemonContractOBJ","submit#"..tbl2json(star_data).."#"..VarApi.getPlayerUIntVar(actor,"U_total_talent_value"))
end
function DemonContract:CommonSubmitBtnClick(actor,map_type,type_index,select_index)    
    map_type = tonumber(map_type)
    type_index = tonumber(type_index)
    select_index = tonumber(select_index)
    local temp = VarApi.getPlayerUIntVar(actor,"U_bigMap") --#region 进入大陆标识
    if  map_type >= 2 and temp < 2 then
        return  Sendmsg9(actor, "ff0000", "请先前往白日门后再激活！", 1)
    end
    if map_type >= 3 and temp < 3 then
        return  Sendmsg9(actor, "ff0000", "请先前往封魔谷后再激活！", 1)
    end
    local cfg = self.cfg_map[map_type][type_index]
    if cfg == nil then
        return  Sendmsg9(actor, "ff0000", "页签选中异常~"..type_index, 1)
    end

    local star_data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_mon_tujian_star")) 
    if star_data == "" then
        star_data = {}
    end
    local is_submit = false
    for i,v in ipairs(cfg) do
        local cur_star = star_data[v.key_name] or 0
        local item_count = getbagitemcount(actor, "万能恶魔图鉴",0)
        if item_count >= v.need_common_count and select_index and  i == select_index  then
            if takeitem(actor,"万能恶魔图鉴",v.need_common_count,0) then
                if cur_star < 3  then
                    VarApi.setPlayerUIntVar(actor,"U_total_talent_value",VarApi.getPlayerUIntVar(actor,"U_total_talent_value") + v.talent_value,true)
                end
                star_data[v.key_name] = cur_star + 1 > 3 and 3 or cur_star + 1
                ChangeMoney(actor,15,"+",v.prestige_value * 1,"恶魔契约激活",true)
                is_submit = true
                break
            end
        end
    end
    if not is_submit then
       return  Sendmsg9(actor, "ffffff", "你没有可提交的图鉴卡片！", 1)
    end
    VarApi.setPlayerTStrVar(actor,"T_mon_tujian_star",tbl2json(star_data) )
    Sendmsg9(actor, "ffffff", "提交成功", 1)
    lualib:FlushNpcUi(actor,"DemonContractOBJ","common_submit#"..tbl2json(star_data).."#"..map_type.."#"..type_index.."#"..select_index)
end
function DemonContract:SetPreTalentAttr(actor,index,add_flag,value)
    add_flag = tonumber(add_flag)   
    index = tonumber(index)
    value = tonumber(value)
    if index > 9 then
        return Sendmsg9(actor, "ffffff", "恶魔契约数据异常！增加不存在属性！", 1)
    end
    if add_flag == nil then
       return  Sendmsg9(actor, "ffffff", "恶魔契约数据异常！", 1)
    end
    if self.pre_talent_tab[actor] == nil then
        return  Sendmsg9(actor, "ffffff", "恶魔契约数据异常！请刷新界面！", 1)
    end

    local cfg =	self.talent_cfg[index]
    local pre_value = self.pre_talent_tab[actor][index]
    local cur_value =  VarApi.getPlayerUIntVar(actor,"U_talent_value"..index)
    if add_flag == 1 then
        if self.pre_talent_value[actor] - cfg.need_talent < 0 then
            Sendmsg9(actor, "FF0000", "天赋点不足"..cfg.need_talent, 1)
            return
        end
        if (pre_value + cur_value + 1) > cfg.attr_max then
            return Sendmsg9(actor, "FF0000", "当前加点超过最大限度".. cfg.attr_max, 1)
        end
        self.pre_talent_value[actor] = self.pre_talent_value[actor] - cfg.need_talent
        self.pre_talent_tab[actor][index] = pre_value + cfg.attr_value
    elseif add_flag == 0 then
        if pre_value <= 0 then
            return
        end
        self.pre_talent_value[actor] = self.pre_talent_value[actor] + cfg.need_talent
        self.pre_talent_tab[actor][index] = pre_value - cfg.attr_value
    elseif add_flag == 3  then
        if value == nil then
           return Sendmsg9(actor, "FF0000", "请输入点数", 1)
        end
        if self.pre_talent_value[actor] - (cfg.need_talent* value) < 0 then
            Sendmsg9(actor, "FF0000", "天赋点不足"..cfg.need_talent*value, 1)
            return
        end
        if (value + cur_value) > cfg.attr_max then
            return Sendmsg9(actor, "FF0000", "当前加点超过最大限度".. cfg.attr_max, 1)
        end
        if value <= pre_value then 
            self.pre_talent_value[actor] = self.pre_talent_value[actor] + cfg.need_talent* (pre_value - value)
        else
            self.pre_talent_value[actor] = self.pre_talent_value[actor] - cfg.need_talent * (value - pre_value)
        end
        self.pre_talent_tab[actor][index] =  value
    end
    lualib:FlushNpcUi(actor,"DemonContractOBJ","pre_change#"..tbl2json(self.pre_talent_tab[actor]).."#"..self.pre_talent_value[actor])
end
function DemonContract:SetTalentAttr(actor)
    local talent_tab = {}
    if self.pre_talent_tab[actor] == nil then
        Sendmsg9(actor, "FF0000", "加点异常，关闭界面后重试！", 1)
        return
    end
    local expend_value = 0
    for i,v in ipairs(self.pre_talent_tab[actor]) do
        if v > 0 then
            local cfg =	self.talent_cfg[i]
            local total_talent = VarApi.getPlayerUIntVar(actor,"U_total_talent_value")
            if total_talent >= (cfg.need_talent * v) then
                VarApi.setPlayerUIntVar(actor,"U_talent_value"..i, VarApi.getPlayerUIntVar(actor,"U_talent_value"..i) + v)
                VarApi.setPlayerUIntVar(actor,"U_total_talent_value",total_talent - cfg.need_talent*v,true)
                VarApi.setPlayerUIntVar(actor,"U_allocat_talent",VarApi.getPlayerUIntVar(actor,"U_allocat_talent")+cfg.need_talent*v)
                expend_value = expend_value + cfg.need_talent*v
            end
        end
    end
    if expend_value >0 then
        Sendmsg9(actor, "00ff00", "本次消耗点数："..expend_value, 1)
    end

    local allot_talent = VarApi.getPlayerUIntVar(actor,"U_allocat_talent")
    local random_count = math.floor(allot_talent/10)
    if random_count > 0 then
        VarApi.setPlayerUIntVar(actor,"U_allocat_talent",allot_talent%10)
        for i = 1, random_count do
            local weight_str = ""
            for s,v in ipairs(self.talent_cfg) do
                if s > 8 and VarApi.getPlayerUIntVar(actor,"U_talent_value" .. s) < v.attr_max then
                    weight_str = weight_str .. v.key_name .."#".. v.weight.."|" 
                end
            end
            local tab = getWeightedCfg(weight_str)
            local value = weightedRandom(tab).value
            talent_tab[value] = 1
            VarApi.setPlayerUIntVar(actor,"U_talent_value"..value,VarApi.getPlayerUIntVar(actor,"U_talent_value"..value)+1)
            Sendmsg9(actor, "ffffff", string.format("恭喜获得随机属性【%s】！",self.talent_cfg[value].attr_name) , 1)
        end
    end
    local comm_attr_str = ""
    local random_attr_str = ""
    local job = getbaseinfo(actor,7)
    local job_attr_id = 0
    local job_attr_id2 = 0
    if job == 0 then
        job_attr_id = 3
        job_attr_id2 = 4
    elseif job == 1 then
        job_attr_id = 5
        job_attr_id2 = 6
    else
        job_attr_id = 7
        job_attr_id2 = 8
    end
    for i = 1, 13 do
        local value = VarApi.getPlayerUIntVar(actor,"U_talent_value"..i)
        talent_tab[i] =value
        local attr_id = self.talent_cfg[i].attrid
        if i < 9 and value >0 then
            if i == 7 then
                comm_attr_str =  comm_attr_str .."3#"..job_attr_id.."#"..value.."|"
            elseif i== 8 then
                comm_attr_str =  comm_attr_str .."3#"..job_attr_id2.."#"..value.."|"
            else
                comm_attr_str = comm_attr_str.."3#"..self.talent_cfg[i].attrid.."#"..value.."|"
            end
        else
            if value > 0  then
                if attr_id ~= 22 and attr_id ~= 67 then
                    value = value * 100
                end
                random_attr_str = random_attr_str.."3#"..self.talent_cfg[i].attrid.."#"..value .."|"
            end
        end
    end
    delbuff(actor,60113)
    delbuff(actor,60114)
    local attr_tab1 = ParserAttrStrToTable(comm_attr_str)
    addbuff(actor,60113,0,1,actor,attr_tab1)
    local attr_tab2 = ParserAttrStrToTable(random_attr_str)
    addbuff(actor,60114,0,1,actor,attr_tab2)
    self.pre_talent_tab[actor] = {0,0,0,0,0,0,0,0}
    self.pre_talent_value[actor] = VarApi.getPlayerUIntVar(actor,"U_total_talent_value")
    lualib:FlushNpcUi(actor,"DemonContractOBJ","attr_change#"..tbl2json(talent_tab).."#".. VarApi.getPlayerUIntVar(actor,"U_total_talent_value"))
end
function DemonContract:ChangeJobReset(actor)
    local star_data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_mon_tujian_star")) 
    if star_data == "" then
        star_data = {}
    end
    local cur_talent =0
    for i,v in ipairs(self.cfg) do
        local star = star_data[v.key_name] or 0
        if star > 0 then
            cur_talent = cur_talent + (v.talent_value * star)
        end
    end
    VarApi.setPlayerUIntVar(actor,"U_total_talent_value",cur_talent,true)
    for i = 1, 13 do
        VarApi.setPlayerUIntVar(actor,"U_talent_value"..i,0)
    end
    VarApi.setPlayerUIntVar(actor,"U_allocat_talent",0)
    delbuff(actor,60113)
    delbuff(actor,60114)
end
return DemonContract