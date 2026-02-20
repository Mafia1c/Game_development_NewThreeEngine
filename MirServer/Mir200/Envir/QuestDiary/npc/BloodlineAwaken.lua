local BloodlineAwaken = {}
BloodlineAwaken.cfg =  include("QuestDiary/config/BloodlineAwakenCfg.lua")
function BloodlineAwaken:click(actor)
    local bloodline_list = VarApi.getPlayerTStrVar(actor,"T_bloodline_state")
    if bloodline_list == "" then
        bloodline_list = {}
        bloodline_list = tbl2json(bloodline_list)
    end
    local can_active_count = self:GetCanActiveCount(actor)
    lualib:ShowNpcUi(actor,"BloodlineAwakenOBJ",bloodline_list.."#"..can_active_count)

    if #json2tbl(bloodline_list) > 0 then
        TaskTrigger.CompleteTask(actor, 4)
    elseif TaskTrigger.CheckTask(actor, 4) then
        lualib:CallFuncByClient(actor, "navigation", "BloodlineAwakenOBJ#active_btn#点击激活#onActiveBtn")
    end
end

function BloodlineAwaken:GetCanActiveCount(actor)
    local level = getbaseinfo(actor,6)
    if  level <= 40 then
        return 0
    end
    local bloodline_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_state"))
    if  bloodline_list == "" then
        bloodline_list = {}
    end
    if level > 100 then
        level = 100
    end
    return level - 40 - #bloodline_list
end
--激活
function BloodlineAwaken:OnClickOpenActiveView(actor)
    if self:GetCanActiveCount(actor) <= 0 then
       return Sendmsg9(actor, "ffffff", "可激活次数不足！", 1) 
    end
    local bloodline_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_state"))
    if  bloodline_list == "" then
        bloodline_list = {}
    end
    local active_index = #bloodline_list + 1
    local is_big_xuemai = active_index % 6 == 0
    local random_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_random_list"))
    if random_list == "" then
        random_list = self:GetRandomList(actor,is_big_xuemai,3)
        VarApi.setPlayerTStrVar(actor,"T_bloodline_random_list",tbl2json(random_list))
    end
    lualib:ShowNpcUi(actor,"BloodlineActiveOBJ",tbl2json(random_list))
end
--获得随机血脉列表
function BloodlineAwaken:GetRandomList(actor,is_big_xuemai,count)
    local temp_list = {}
    local list = {}
    if is_big_xuemai then
        for i,v in ipairs(self.cfg) do
            if v.xuemai_type == 444 and not self:IsLayerMax(actor,v.key_name) then
                table.insert(temp_list,v.key_name)
            end
        end
       
        while #list < count do
            local index = math.random(1,#temp_list)
            if not isInTable(list,temp_list[index])  then
                table.insert(list,temp_list[index]) 
            end
        end
    else
        local weight_str = ""
        local mustbe_weight_str = ""
        for i,v in ipairs(self.cfg) do
            if v.xuemai_type ~= 444 and not self:IsLayerMax(actor,v.key_name) then
                weight_str = weight_str .. v.key_name .."#".. v.weight.."|" 
            end
            if v.xuemai_type == 333 and not self:IsLayerMax(actor,v.key_name) then
                mustbe_weight_str = mustbe_weight_str .. v.key_name .."#".. v.weight.."|" 
            end
        end
        -- release_print("sssss",VarApi.getPlayerUIntVar(actor,"U_mustbe_num"))
        --必出传说级
        if VarApi.getPlayerUIntVar(actor,"U_mustbe_num") >= 10 then
            local key =ransjstr(mustbe_weight_str, 1,1)
            table.insert(list, tonumber(key))
            VarApi.setPlayerUIntVar(actor,"U_mustbe_num",0) 
        end

        while #list < 3 do
            local key =ransjstr(weight_str, 1,1)
            if not isInTable(list,tonumber(key)) then
                table.insert(list, tonumber(key))
            end
        end
    end
    return list
end
function BloodlineAwaken:SetActiveXueMai(actor,index)
    index = tonumber(index)
    if index == nil then
        return Sendmsg9(actor, "ffffff", "激活血脉异常", 1) 
    end
    local can_active_count = self:GetCanActiveCount(actor)
    if can_active_count <= 0 then
       return Sendmsg9(actor, "ffffff", "可激活次数不足！", 1) 
    end
    local random_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_random_list"))
    if random_list == "" or random_list[index] == nil then
        return Sendmsg9(actor, "ffffff", "激活血脉异常", 1) 
    end
    local bloodline_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_state"))
    if  bloodline_list == "" then
        bloodline_list = {}
    end
    local key = random_list[index]
    table.insert(bloodline_list,key)
    local cfg = self.cfg[key]
    addbuff(actor,cfg.buff_id,0,1,actor) 
    Sendmsg9(actor, "ffffff", "成功激活天命符文"..cfg.name, 1) 
    VarApi.setPlayerTStrVar(actor,"T_bloodline_random_list","")
    VarApi.setPlayerTStrVar(actor,"T_bloodline_state",tbl2json(bloodline_list),true)
    lualib:CloseNpcUi(actor,"BloodlineActiveOBJ")
    lualib:FlushNpcUi(actor,"BloodlineAwakenOBJ","active_flush#"..tbl2json(bloodline_list).."#"..self:GetCanActiveCount(actor))

    TaskTrigger.CompleteTask(actor, 4)
end
--是否满级
function BloodlineAwaken:IsLayerMax(actor,key_name)
    local bloodline_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_state"))
    if  bloodline_list == "" then
        return false
    end
    local max_layer = self.cfg[key_name].max_layer
    local count = 0
    for i,v in ipairs(bloodline_list) do
        if v == key_name then
            count = count + 1
        end
    end  
    return count >= max_layer
end
--刷新血脉
function BloodlineAwaken:ReFlushBloodLine(actor)
    local can_active_count = self:GetCanActiveCount(actor)
    if can_active_count <= 0 then
        return Sendmsg9(actor, "ffffff", "可激活次数不足！", 1) 
    end

    if getbagitemcount(actor, "天命石",0)  <= 0 then
        return Sendmsg9(actor, "ffffff", "天命石不足", 1)
    end
    if not takeitem(actor,"天命石",1,0,"血脉激活刷新扣除") then
        return Sendmsg9(actor, "ffffff", "天命石扣除失败!", 1)
    end
    local bloodline_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_state"))
    if  bloodline_list == "" then
        bloodline_list = {}
    end
    local active_index = #bloodline_list + 1
    local is_big_xuemai = active_index % 6 == 0
    local num = VarApi.getPlayerUIntVar(actor,"U_mustbe_num")
    VarApi.setPlayerUIntVar(actor,"U_mustbe_num",num + 1)
    local random_list = self:GetRandomList(actor,is_big_xuemai,3)
    VarApi.setPlayerTStrVar(actor,"T_bloodline_random_list",tbl2json(random_list))
    lualib:FlushNpcUi(actor,"BloodlineActiveOBJ",tbl2json(random_list))
end
-----重修
function BloodlineAwaken:OnClickOpenRebuildView(actor,select_pos)
    select_pos = tonumber(select_pos)
    if select_pos == nil or select_pos <= -1 then
       return Sendmsg9(actor, "ffffff", "请先选中需要重修的符文!", 1)
    end
    local bloodline_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_state"))
    if bloodline_list == "" or bloodline_list[select_pos] == nil then
        return Sendmsg9(actor, "ffffff", "当前位置没有激活符文!", 1)
    end
    if getbagitemcount(actor, "天命石",0) <= 0 then
        return Sendmsg9(actor, "ffffff", "天命石不足", 1)
    end
    local key_name = bloodline_list[select_pos]
    lualib:ShowNpcUi(actor,"BloodlineRebuildOBJ","show_select#"..select_pos.."#"..key_name)
end
--开始重修
function BloodlineAwaken:OnClickRebuildBtn(actor,select_pos)
    select_pos = tonumber(select_pos)
    if select_pos == nil or select_pos <= -1 then
       return Sendmsg9(actor, "ffffff", "请先选中需要重修的符文!", 1)
    end
    local bloodline_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_state"))
    if bloodline_list == "" or bloodline_list[select_pos] == nil then
        return Sendmsg9(actor, "ffffff", "当前位置没有激活符文!", 1)
    end

    if getbagitemcount(actor, "天命石",0) <= 0 then
        return Sendmsg9(actor, "ffffff", "天命石不足", 1)
    end

    if not takeitem(actor,"天命石",1,0,"血脉激活刷新扣除") then
        return Sendmsg9(actor, "ffffff", "天命石扣除失败!", 1)
    end
    local is_big_xuemai = select_pos % 6 == 0
    local num = VarApi.getPlayerUIntVar(actor,"U_mustbe_num")
    VarApi.setPlayerUIntVar(actor,"U_mustbe_num",num + 1)
    local random_list = self:GetRandomList(actor,is_big_xuemai,is_big_xuemai and 1 or 3)
    VarApi.setPlayerTStrVar(actor,"T_bloodline_rebuild_random_list",tbl2json(random_list))
    lualib:FlushNpcUi(actor,"BloodlineRebuildOBJ","show_rebuld#"..select_pos.. "#" ..tbl2json(random_list))
end
function BloodlineAwaken:SetRebuildXueMai(actor,index,pos)
    index = tonumber(index)
    pos = tonumber(pos)
    if index == nil then
        return Sendmsg9(actor, "ffffff", "激活血脉异常", 1) 
    end
    local random_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_rebuild_random_list"))
    if random_list == "" or random_list[index] == nil then
        return Sendmsg9(actor, "ffffff", "激活血脉异常", 1) 
    end
    local bloodline_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_state"))
    if  bloodline_list == "" or bloodline_list[pos] == nil then
        return Sendmsg9(actor, "ffffff", "血脉尚未激活！", 1) 
    end
    local key = random_list[index]
    local old_key = bloodline_list[pos]
    local old_cfg = self.cfg[old_key]
    local layer = getbuffinfo(actor,old_cfg.buff_id,1) or 0
    if layer <= 1 then
        delbuff(actor,old_cfg.buff_id)
    else
        buffstack(actor,old_cfg.buff_id,"-",1,false)
    end
    bloodline_list[pos] = key
    local cfg = self.cfg[key]
    addbuff(actor,cfg.buff_id,0,1,actor) 
    VarApi.setPlayerTStrVar(actor,"T_bloodline_rebuild_random_list","")
    VarApi.setPlayerTStrVar(actor,"T_bloodline_state",tbl2json(bloodline_list),true)
    lualib:CloseNpcUi(actor,"BloodlineRebuildOBJ")
    lualib:FlushNpcUi(actor,"BloodlineAwakenOBJ","rebuild#"..tbl2json(bloodline_list).."#"..pos)
end

--重修刷新血脉
function BloodlineAwaken:RebuildFlushBloodLine(actor,select_pos)
    select_pos = tonumber(select_pos)
    if select_pos == nil or select_pos <= -1 then
       return Sendmsg9(actor, "ffffff", "请先选中需要重修的符文!", 1)
    end

    local bloodline_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_bloodline_state"))
    if  bloodline_list == "" or bloodline_list[select_pos] == nil then
        return Sendmsg9(actor, "ffffff", "血脉尚未激活！", 1) 
    end

    if getbagitemcount(actor, "天命石",0)  <= 0 then
        return Sendmsg9(actor, "ffffff", "天命石不足", 1)
    end

    if not takeitem(actor,"天命石",1,0,"血脉激活刷新扣除") then
        return Sendmsg9(actor, "ffffff", "天命石扣除失败!", 1)
    end
    local num = VarApi.getPlayerUIntVar(actor,"U_mustbe_num")
    VarApi.setPlayerUIntVar(actor,"U_mustbe_num",num + 1)
    local is_big_xuemai = select_pos % 6 == 0
    local random_list = self:GetRandomList(actor,is_big_xuemai,is_big_xuemai and 1 or 3)
    VarApi.setPlayerTStrVar(actor,"T_bloodline_rebuild_random_list",tbl2json(random_list))
    lualib:FlushNpcUi(actor,"BloodlineRebuildOBJ","show_rebuld#"..select_pos.. "#" ..tbl2json(random_list))
end

return BloodlineAwaken