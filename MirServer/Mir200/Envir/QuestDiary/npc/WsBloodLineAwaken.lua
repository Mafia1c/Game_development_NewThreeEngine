local WsBloodLineAwaken = {}
WsBloodLineAwaken.cfg = GetConfig("WsbloodLineCfg")
function WsBloodLineAwaken:click(actor)
    -- if CheckOpenState(actor, 1) then return end
    -- local cur_main_xuemai = VarApi.getPlayerUIntVar(actor,"U_main_xuemai")
    -- local xuemai_index = cur_main_xuemai
    -- if xuemai_index <= 0 then
    --     xuemai_index = 1 
    -- end
    -- local xuemai_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_ws_xuemai_info"..xuemai_index)) 
    -- if xuemai_info == "" then
    --     xuemai_info = {}
    -- end
    -- for i = 1, 12 do
    --     if xuemai_info[i] == nil or xuemai_info[i] < 0 then
    --         xuemai_info[i] = self:PosIsUnLock(actor,i)
    --     end
    -- end
    -- local ws_xuemai_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_ws_xuemai_list")) 
    -- if ws_xuemai_list == "" then
    --     ws_xuemai_list = {}
    -- end
    -- VarApi.setPlayerTStrVar(actor,"T_ws_xuemai_info"..xuemai_index,tbl2json(xuemai_info))
    -- lualib:ShowNpcUi(actor,"WsBloodLineAwakenOBJ",tbl2json(xuemai_info).."#"..cur_main_xuemai.. "#"..tbl2json(ws_xuemai_list) )
end

function WsBloodLineAwaken:PosIsUnLock(actor,pos)
    -- --境界
    -- local layer = VarApi.getPlayerUIntVar(actor,"U_LayerStudy") 
    -- if layer >= pos -1  then
    --    return 0 
    -- end
    -- return -1
end
function WsBloodLineAwaken:OnClickChangeXueMaiBtn(actor,index)
    -- if CheckOpenState(actor, 1) then return end
    -- index = tonumber(index)
    -- if  index < 1 or  index > 2 then
    --    return Sendmsg9(actor, "ffffff", "无双血脉数据异常!", 1) 
    -- end
    -- if index == 2 then
    --     local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    --     if mzl_state < 1  then
    --         Sendmsg9(actor, "ffffff", "激活盟重令可解锁第二页配置!", 1)
    --         return
    --     end
    -- end
    -- local xuemai_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_ws_xuemai_info"..index)) 
    -- if xuemai_info == "" then
    --     xuemai_info = {}
    -- end
    -- for i = 1, 12 do
    --     if xuemai_info[i] == nil or xuemai_info[i] < 0 then
    --         xuemai_info[i] = self:PosIsUnLock(actor,i)
    --     end
    -- end
    -- VarApi.setPlayerTStrVar(actor,"T_ws_xuemai_info"..index,tbl2json(xuemai_info))
    -- lualib:FlushNpcUi(actor,"WsBloodLineAwakenOBJ","xuemai_change_flush#"..tbl2json(xuemai_info).."#"..index)
end
--重置血脉
function WsBloodLineAwaken:OnClickReset(actor,index)
    -- if CheckOpenState(actor, 1) then return end
    -- index = tonumber(index)
    -- if  index < 1 or  index > 2 then 
    --    return Sendmsg9(actor, "ffffff", "无双血脉数据异常!", 1) 
    -- end
    -- if index == 2 then
    --     local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    --     if mzl_state < 1  then
    --         Sendmsg9(actor, "ffffff", "重置异常，配置2尚未激活!", 1)
    --         return
    --     end
    -- end
    
    -- local xuemai_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_ws_xuemai_info"..index)) 
    -- if xuemai_info == "" then
    --     xuemai_info = {}
    -- end
    -- for i = 1, 12 do
    --     xuemai_info[i] = self:PosIsUnLock(actor,i)
    -- end
    --  local cur_active_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_ws_cur_info")) 
    -- if cur_active_list == "" then
    --     cur_active_list = {}
    -- end
    -- for i,v in ipairs(cur_active_list) do
    --     if v > 0 then
    --         local buff_id = self.cfg[v].xuemai_buff
    --         if hasbuff(actor,buff_id) then
    --             delbuff(actor,buff_id) 
    --         end
    --     end
    -- end
    -- VarApi.setPlayerUIntVar(actor,"U_main_xuemai",0)
    -- Sendmsg9(actor, "ffffff", "已重置当前血脉配置！", 1)
    -- VarApi.setPlayerTStrVar(actor,"T_ws_xuemai_info"..index,tbl2json(xuemai_info))
    -- VarApi.setPlayerTStrVar(actor,"T_ws_cur_info","")
    -- lualib:FlushNpcUi(actor,"WsBloodLineAwakenOBJ","xuemai_reset_flush#"..tbl2json(xuemai_info).."#"..index.."#0")
end
--保存激活
function WsBloodLineAwaken:ClickSaveActive(actor,index)
    -- if CheckOpenState(actor, 1) then return end
    -- index = tonumber(index)
    -- if index < 1 or  index > 2 then
    --    return Sendmsg9(actor, "ffffff", "无双血脉数据异常!", 1) 
    -- end
    -- if index == 2 then
    --     local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    --     if mzl_state < 1  then
    --         Sendmsg9(actor, "ffffff", "重置异常，配置2尚未激活!", 1)
    --         return
    --     end
    -- end
    -- local xuemai_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_ws_xuemai_info"..index)) 
    -- if xuemai_info == "" then
    --     return Sendmsg9(actor, "ffffff", "无双血脉数据异常", 1)
    -- end
    -- local is_can_save = false
    -- for i,v in ipairs(xuemai_info) do
    --     if v  > 0 then
    --         is_can_save = true
    --         break        
    --     end
    -- end
    -- if not is_can_save then
    --     return Sendmsg9(actor, "ffffff", "请先选择需要配置的血脉！", 1)
    -- end
    -- Sendmsg9(actor, "ffffff", "保存成功，已激活使用！", 1)
    -- VarApi.setPlayerUIntVar(actor,"U_main_xuemai",index)
    -- local cur_active_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_ws_cur_info")) 
    -- if cur_active_list == "" then
    --     cur_active_list = {}
    -- end
    -- for i,v in ipairs(cur_active_list) do
    --     if v > 0 and not isInTable(xuemai_info,v) then
    --         local buff_id = self.cfg[v].xuemai_buff
    --         if hasbuff(actor,buff_id) then
    --             delbuff(actor,buff_id) 
    --         end
    --     end
    -- end
    -- VarApi.setPlayerTStrVar(actor,"T_ws_cur_info",tbl2json(xuemai_info))
    -- for k, v in pairs(xuemai_info) do
    --     if v > 0 and self.cfg[v] then
    --         addbuff(actor,self.cfg[v].xuemai_buff)
    --     end
    -- end
    -- lualib:FlushNpcUi(actor,"WsBloodLineAwakenOBJ","save_active#"..index)
end

function WsBloodLineAwaken:OpenActiveView(actor)
    -- if CheckOpenState(actor, 1) then return end
    -- if getbagitemcount(actor,"血脉石", 0) <= 0 then
    --     return Sendmsg9(actor, "ffffff", "血脉石不足！", 1)
    -- end
    -- if not takeitem(actor,"血脉石",1,0,"无双血脉激活") then
    --     return Sendmsg9(actor, "ffffff", "血脉石扣除失败！", 1)
    -- end
    -- local weight_str = ""
    -- for i,v in ipairs(WsBloodLineAwaken.cfg) do
    --     weight_str = weight_str .. v.key_name .."#".. v.weight.."|" 
    -- end
    
    -- local data = {}
    -- data.list = {}
    -- data.select_flag = 0 
    -- while #data.list < 3 do
    --     local key_name = self:GetRandomKeyName(weight_str)
    --     if not isInTable(data.list,key_name) then
    --         table.insert(data.list,key_name)  
    --     end
    -- end
    -- SetTempStr(0,actor,"T_ws_xuemai_select_info",tbl2json(data))
    -- lualib:ShowNpcUi(actor,"WsBloodlineActiveOBJ",tbl2json(data)) 
end

function WsBloodLineAwaken:GetRandomKeyName(weight_str)
    -- local tab = getWeightedCfg(weight_str)
    -- local value = weightedRandom(tab).value
    -- return value
end
function WsBloodLineAwaken:ClickFlushBtn(actor)
    -- if CheckOpenState(actor, 1) then return end
    -- if getbagitemcount(actor,"血脉石", 0) <= 0 then
    --     return Sendmsg9(actor, "ffffff", "血脉石不足！", 1)
    -- end
    -- local data = json2tbl(GetTempStr(0,actor,"T_ws_xuemai_select_info")) 
    -- if data ~= "" and (data.select_flag == nil or data.select_flag <= 0) then
    --    messagebox(actor,"是否放弃选择当前血脉？","@resert_ok_select","@resert_no_select")
    -- else
    --     resert_ok_select(actor)
    -- end
end
function resert_ok_select(actor)
    -- if getbagitemcount(actor,"血脉石", 0) <= 0 then
    --     return Sendmsg9(actor, "ffffff", "血脉石不足！", 1)
    -- end
    -- if not takeitem(actor,"血脉石",1,0,"无双血脉激活") then
    --     return Sendmsg9(actor, "ffffff", "血脉石扣除失败！", 1)
    -- end
    -- local weight_str = ""
    -- for i,v in ipairs(WsBloodLineAwaken.cfg) do
    --     weight_str = weight_str .. v.key_name .."#".. v.weight.."|" 
    -- end
    
    -- local data = {}
    -- data.list = {}
    -- data.select_flag = 0 
    -- while #data.list < 3 do
    --     local key_name = WsBloodLineAwaken:GetRandomKeyName(weight_str)
    --     if not isInTable(data.list,key_name) then
    --         table.insert(data.list,key_name)  
    --     end
    -- end
    -- SetTempStr(0,actor,"T_ws_xuemai_select_info",tbl2json(data))
    -- lualib:FlushNpcUi(actor,"WsBloodlineActiveOBJ",tbl2json(data)) 
end
function WsBloodLineAwaken:SetXueMaiList(actor,index)
    -- if CheckOpenState(actor, 1) then return end
    -- index = tonumber(index)
    -- if index < 1 or  index > 3 then
    --    return Sendmsg9(actor, "ffffff", "无双血脉数据异常!", 1) 
    -- end
    -- local data = json2tbl(GetTempStr(0,actor,"T_ws_xuemai_select_info")) 
    -- if data == "" or  data.list[index] == nil then
    --     return Sendmsg9(actor, "ffffff", "选中血脉异常", 1)  
    -- end

    -- if data.select_flag ~= 0 then
    --     return Sendmsg9(actor, "ffffff", "已经选择过血脉！", 1)  
    -- end
    -- local ws_xuemai_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_ws_xuemai_list")) 
    -- if ws_xuemai_list == "" then
    --     ws_xuemai_list = {}
    -- end
    -- data.select_flag = index
    -- SetTempStr(0,actor,"T_ws_xuemai_select_info",tbl2json(data) )
    -- if not isInTable(ws_xuemai_list,data.list[index]) then
    --     table.insert( ws_xuemai_list,data.list[index])
    --     VarApi.setPlayerTStrVar(actor,"T_ws_xuemai_list",tbl2json(ws_xuemai_list))
    -- end
    -- lualib:FlushNpcUi(actor,"WsBloodlineActiveOBJ",tbl2json(data)) 
end
--配置血脉
function WsBloodLineAwaken:ConfigurationXueMai(actor,index,select_xuemai_index,pos)
    -- if CheckOpenState(actor, 1) then return end
    -- index = tonumber(index) 
    -- select_xuemai_index = tonumber(select_xuemai_index)
    -- if select_xuemai_index < 1 or  select_xuemai_index > 2 then
    --    return Sendmsg9(actor, "ffffff", "无双血脉数据异常!", 1) 
    -- end
    -- pos = tonumber(pos)
    -- if self:PosIsUnLock(actor,pos) < 0 then
    --     return Sendmsg9(actor, "ffffff", "该血脉位置未激活！", 1)
    -- end
    -- if select_xuemai_index == 2 then
    --     local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    --     if mzl_state < 1  then
    --         Sendmsg9(actor, "ffffff", "激活盟重令可解锁第二页配置!", 1)
    --         return
    --     end
    -- end
    -- if index == nil then
    --     return Sendmsg9(actor, "ffffff", "配置血脉异常", 1)  
    -- end
    -- local ws_xuemai_list = json2tbl(VarApi.getPlayerTStrVar(actor,"T_ws_xuemai_list")) 
    -- if ws_xuemai_list == "" or ws_xuemai_list[index] == nil then
    --     return Sendmsg9(actor, "ffffff", "配置血脉异常，未获得血脉"..index, 1)  
    -- end

    -- local xuemai_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_ws_xuemai_info"..select_xuemai_index)) 
    -- if xuemai_info == "" then
    --     return Sendmsg9(actor, "ffffff", "血脉初始化异常", 1)  
    -- end
    -- if isInTable(xuemai_info,ws_xuemai_list[index]) then
    --    return  Sendmsg9(actor, "ffffff", "当前符文已添加！", 1)  
    -- end
    -- xuemai_info[pos] = ws_xuemai_list[index]
    -- VarApi.setPlayerTStrVar(actor,"T_ws_xuemai_info"..select_xuemai_index,tbl2json(xuemai_info))
    -- lualib:FlushNpcUi(actor,"WsBloodLineAwakenOBJ","xuemai_change_flush#"..tbl2json(xuemai_info).."#"..select_xuemai_index)
end

function WsBloodLineAwaken:FlushWsBuffAttr(actor)
    --   --无双 单打独斗
    -- if hasbuff(actor,80006) then
    --     if getbaseinfo(actor,35) <= 0  then
    --         local attr_str = "3#66#5000|3#75#1000"
    --     else
    --         delattlist(actor,"80006_attr")
    --     end
    -- end
   
end

return WsBloodLineAwaken