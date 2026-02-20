RedPointParser = RedPointParser or {}
RedPointParser.cachedExpress = {}
-- 主解析函数
function RedPointParser.ParseExpression(str)
    local expressions = {}

    for var, param, operator, value in str:gmatch("%$([%w_]+)%[([^%]]+)%]([<>!~=]=?)([^%s)&andor]+)") do
        table.insert(expressions, {
            var_tag = var,
            var_name = param,
            opt = operator,
            value = value,
            oldExpression = "$" .. var .. "[" .. param .. "]" .. operator .. value
        })
    end
    return expressions
end

function RedPointParser.CheckRedPointVars(str)
    if RedPointParser.cachedExpress[str] then
        return RedPointParser.cachedExpress[str]()
    end
    local expressions = RedPointParser.ParseExpression(str)
    local result = str
    local str2LuaCode = "return "
    -- 将每个完整表达式替换为 true
    for _, expr in ipairs(expressions) do
        local expressions_str = RedPointParser.GetExpressionValue(expr)
       result = RedPointParser.manualReplace(result,expr.oldExpression,expressions_str)
    end
    local resultFunc, err = load(str2LuaCode..result)
    RedPointParser.cachedExpress[str] = resultFunc
    return RedPointParser.cachedExpress[str]()
end

function RedPointParser.manualReplace(str, pattern, replacement)
    local result = str
    local pos = 1
    while true do
        local start_pos, end_pos = result:find(pattern, pos, true)  -- 使用字面匹配
        if not start_pos then break end
        -- 检查边界：下一个字符不是数字
        if end_pos == #result or not result:sub(end_pos + 1, end_pos + 1):match("%d") then
            local before = result:sub(1, start_pos - 1)
            local after = result:sub(end_pos + 1)
            result = before .. replacement .. after
            pos = start_pos + #replacement
        else
            -- 跳过部分匹配
            pos = start_pos + 1
        end
    end

    return result
end

function RedPointParser.GetExpressionValue(expr)
    local str = "false"
    if expr.var_tag == "item_count" then --道具数量
        str = string.format('SL:Get_ITEM_COUNT("%s") %s %s',expr.var_name,expr.opt,expr.value)
    elseif expr.var_tag == "check_bind_money_count" then  --货币数量
        str =  string.format('tonumber(SL:Get_MONEY_ASSOCIATED(SL:Get_ITEM_INDEX_BY_NAME("%s"))) %s %s',expr.var_name,expr.opt,expr.value)
    elseif expr.var_tag == "money_count" then  --货币数量
        str =  string.format('tonumber(SL:Get_MONEY(SL:Get_ITEM_INDEX_BY_NAME("%s"))) %s %s',expr.var_name,expr.opt,expr.value)
    elseif expr.var_tag == "inside_list" then --是否在列表内
        str = string.format('RedPointParser.GetIsIntableList("%s","%s","%s")',expr.var_name,expr.opt,expr.value) 
    elseif expr.var_tag == "inside_map" then --是否在列表内
        str = string.format('RedPointParser.GetIsIntable("%s","%s","%s")',expr.var_name,expr.opt,expr.value) 
    elseif expr.var_tag == "call_fun" then
        str = string.format('RedPointParser.GetFunReturn("%s")',expr.var_name) 
    elseif expr.var_tag == "view_red_name" then  --检测内部变量
        str = string.format('RedPointParser.GetInsideMainBtnCondition("%s")',expr.var_name)
    elseif expr.var_tag == "child_node_cache" then  
        str = string.format('RedPointParser.GetChildNodeCache("%s")',expr.var_name)
    elseif expr.var_tag == "var_int" then
        str = string.format('(GameData.GetData("%s",false) or 0) %s %s',expr.var_name,expr.opt,expr.value) 
    elseif expr.var_tag == "job" then
        str = string.format("SL:Get_JOB() %s %s",expr.opt,expr.value) 
    elseif expr.var_tag == "map_id" then 
        str = string.format("SL:Get_MAP_ID() %s '%s'",expr.opt,expr.var_name) 
    elseif expr.var_tag == "get_equipbypos" then
        if expr.value == "Nil" then
            str = string.format("SL:Get_EQUIPBYPOS(%s) %s ''",expr.var_name,expr.opt) 
        else
            str = string.format("SL:Get_EQUIPBYPOS(%s) %s '%s'",expr.var_name,expr.opt,expr.value) 
        end
    elseif expr.var_tag == "actor_level" then
        str = string.format("SL:Get_LEVEL() %s %s",expr.opt,expr.value) 
    elseif expr.var_tag == "skill_level" then
        str = string.format("SL:Get_SKILL_LEVEL(%s) %s %s",expr.var_name,expr.opt,expr.value) 
    elseif expr.var_tag == "open_view_var" then
        str = string.format('RedPointParser.CheckViewVar("%s") %s %s',expr.var_name,expr.opt,expr.value)
    elseif expr.var_tag == "permanent" then
        str = "true"
    end
   return " "..str .. " "
end

function RedPointParser.CheckViewVar(var_name)
    local name_list = string.split(var_name,",")
    if RedPointMgr.open_view_list[name_list[1]] and name_list[2] then
        return RedPointMgr.open_view_list[name_list[1]][name_list[2]]
    end
    return 0
end

function RedPointParser.GetChildNodeCache(var_name)
    local ids = string.split(var_name,",")
    for i,v in ipairs(ids) do
        if  RedPointMgr.red_point_data_cache[tonumber(v)] and #RedPointMgr.red_point_data_cache[tonumber(v)] > 0 then
            return true
        end
    end
    return false
end

function RedPointParser.GetInsideMainBtnCondition(view_name)
    for k,v in pairs(RedPointMgr.red_view_point_data[view_name] or {}) do
        if v.mainbtn_check then
            if RedPointParser.CheckRedPointVars(v.varCondition) then
                RedPointMgr:SetViewPointCache(v,true)
                return true
            else
                RedPointMgr:SetViewPointCache(v,false)
            end
        end
    end
    return false
end

function RedPointParser.GetFunReturn(var_name)
    local list = string.split(var_name,"#")
    local ui = ViewMgr.GetViewUi(list[1])
    if ui then
        local fun_list = string.split(list[2],",")
        return ui[fun_list[1]](ui,fun_list[2],fun_list[3])
    end
    return false
end

function RedPointParser.GetIsIntable(var_name,opt,value)
    local list = GameData.GetData(var_name, true)
    if type(list) == "table" then
        if opt == "!" then
            for k,v in pairs(list) do
               if type(v) == "table" then
                    for _,name in ipairs(v) do
                        if name == value then
                            return false
                        end
                    end
               else
                    if v == value then
                        return false
                    end 
               end
            end
            return true
        else
            for k,v in pairs(list) do
               if type(v) == "table" then
                    for _,name in ipairs(v) do
                        if name == value then
                            return true
                        end
                    end
               else
                    if v == value then
                        return true
                    end 
               end
            end
            return false
        end
    else
        if opt == "!" then
            return true
        else
            return false
        end
    end   
    return false
end

function RedPointParser.GetIsIntableList(var_name,opt,value)
    local list = GameData.GetData(var_name, true)
    if type(list) == "table" then
        value = tonumber(value) or value
        if opt == "!" then
            return not isInTable(list,value)
        else
           return isInTable(list,value)
        end
    else
        if opt == "!" then
            return true
        else
            return false
        end
    end   
    return false
end
