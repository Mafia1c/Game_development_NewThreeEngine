-- 引擎玩家变量
VarApi = VarApi or {}

-- 缓存键值对
VarApi.KeyValueCacheData = {}

-- 初始化系统变量  针对直播需要的变量
function VarApi.InitSysVar()
    local open_day = GetSysInt(VarEngine.OpenDay)

    for var, num in pairs(VarEngine.MiningVar) do
        if GetSysInt(var) == 0 then
            SetSysInt(var, num)
        end
    end

    -- 王的遗迹 召唤怪物时间变量
    local time = GetSysInt("G199")
    if time == 0 then
        if open_day > 0 then
            SetSysInt("G199", 7200)
        else
            SetSysInt("G199", 3600)
        end
    end

    -- 判断一下
    if GetSysInt("first_player_login_in") == 0 then
        SetSysInt(VarEngine.ServerRunTime, 0)
    end
end

-- 初始化个人变量
function VarApi.Init(actor)
    lualib:CallFuncByClient(actor, "OpenCount", GetSysInt(VarEngine.OpenDay))
    lualib:CallFuncByClient(actor, "HeFuCount", GetSysInt(VarEngine.HeFuCount))

    local var_keys = VarApi.cacheVar(nil)
    for k, v in pairs(var_keys) do
        if string.find(v, "U_") or string.find(v, "U") then
            local value = GetInt(0, actor, v)
            lualib:SendDataClient(actor, v.."#"..value)
        elseif string.find(v, "T_") then
            local value = GetStr(0, actor, v)
            lualib:SendDataClient(actor, v.."#"..value)
        elseif string.find(v, "J_") then
            local value = GetTLInt(0, actor, v)
            lualib:SendDataClient(actor, v.."#"..value)
        elseif string.find(v, "Z_") then
            local value = GetTLStr(0, actor, v)
            lualib:SendDataClient(actor, v.."#"..value)
        else
            messagebox(actor, "非法玩家变量: "..v, "@___aaa", "@___bbb")
            break
        end
    end

    if checkkuafu(actor) then
        lualib:CallFuncByClient(actor, "HiedMainTopBtn", "")
    end
end


--- 设置玩家数字型个人变量  U
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
--- @param value  number   对应的值
--- @param sendClient  boolean  是否同步客户端缓存    true.同步
function VarApi.setPlayerUIntVar(actor, key, value, sendClient)
    key = tostring(key)
    SetInt(0, actor, key, value)
     -- 发送到客户端  
    if sendClient then
        lualib:SendDataClient(actor, key.."#"..value)
    end
    VarApi.cacheVar(key)
end
--- 获取玩家数字型个人变量  U
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
function VarApi.getPlayerUIntVar(actor, key)
    return GetInt(0, actor, key)
end


--- 设置玩家字符型个人变量      T
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
--- @param value  string   对应的值
--- @param sendClient  boolean  是否同步客户端缓存  true.同步
function VarApi.setPlayerTStrVar(actor, key, value, sendClient)
    key = tostring(key)
    SetStr(0, actor, key, value)
    if sendClient then
        lualib:SendDataClient(actor, key.."#"..value)
    end
    VarApi.cacheVar(key)
end
--- 获取玩家字符型个人变量      T
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
function VarApi.getPlayerTStrVar(actor, key)
    return GetStr(0, actor, key)
end


--- 设置玩家数字型个人变量  J   每晚自动12点重置
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
--- @param value  number   对应的值
--- @param time number 	到期清理时间戳(整型)    默认晚上12点
function VarApi.setPlayerJIntVar(actor, key, value, time, sendClient)
    if nil == time or 0 == time then
        time = GetDayTick() + 86400     -- 默认晚上12点
    end
    SetTLInt(0, actor, key, value, time)
    if sendClient then
        lualib:SendDataClient(actor, key.."#"..value)
    end    
    VarApi.cacheVar(key)
end
--- 获取玩家数字型个人变量  J   每晚自动12点重置
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
function VarApi.getPlayerJIntVar(actor, key)
    key = tostring(key)
    return GetTLInt(0, actor, key)
end


--- 设置玩家字符型个人变量      Z   每晚自动12点重置
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
--- @param value  string   对应的值
--- @param time number 	到期清理时间戳(整型)    默认晚上12点
function VarApi.setPlayerZStrVar(actor, key, value, time,sendClient)
    if nil == time or 0 == time then
        time = GetDayTick() + 86400     -- 默认晚上12点
    end
    SetTLStr(0, actor, key, value, time)
    if sendClient then
        lualib:SendDataClient(actor, key.."#"..value)
    end  
    VarApi.cacheVar(key)
end
--- 获取玩家字符型个人变量      Z   每晚自动12点重置
--- @param actor string     玩家对象
--- @param key  string      唯一变量标识
function VarApi.getPlayerZStrVar(actor, key)
    key = tostring(key)
    return GetTLStr(0, actor, key)
end

function VarApi.cacheVar(var_key)
    if nil == var_key or not isInTable(VarApi.KeyValueCacheData, var_key) then
        local tmp_tab = {}
        local str = GetSysStr(VarEngine.Var_Key_Value)
        if "" == str then
        else
            tmp_tab = json2tbl(str)
        end
        if "" == tmp_tab or nil == tmp_tab then
            tmp_tab = {}
        end
        VarApi.KeyValueCacheData = tmp_tab
    end

    if var_key and not isInTable(VarApi.KeyValueCacheData, var_key) then
        table.insert(VarApi.KeyValueCacheData, var_key)
        SetSysStr(VarEngine.Var_Key_Value, tbl2json(VarApi.KeyValueCacheData), 0)
    end

    return VarApi.KeyValueCacheData
end

-- 变量合并
function VarApi.VarMerge(var_str)
    local tmp_tab = {}
    local str = var_str
    if "" == str then
    else
        tmp_tab = json2tbl(str)
    end
    if "" == tmp_tab or nil == tmp_tab then
        tmp_tab = {}
    end
    local tmp_tab1 = {}
    local str1 = GetSysStr(VarEngine.Var_Key_Value)
    if "" == str1 then
    else
        tmp_tab1 = json2tbl(str1)
    end
    if "" == tmp_tab1 or nil == tmp_tab1 then
        tmp_tab1 = {}
    end
    VarApi.KeyValueCacheData = tmp_tab1
    local update = false
    for index, value in ipairs(tmp_tab) do
        if not isInTable(VarApi.KeyValueCacheData, value) then
            table.insert(VarApi.KeyValueCacheData, value)
            update = true
        end
    end
    if update then
        SetSysStr(VarEngine.Var_Key_Value, tbl2json(VarApi.KeyValueCacheData), 0)
    end
end

