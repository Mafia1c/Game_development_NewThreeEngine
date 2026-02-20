function unpack(arr, pos)
    pos = pos or 1
    if pos >= #arr then
        return arr[pos]
    end
    return arr[pos], unpack(arr, pos + 1)
end

--序列化
function serialize(obj, player)
    local text = ""
    local t = type(obj)
    if t == "number" then
        text = text .. obj
    elseif t == "boolean" then
        text = text .. tostring(obj)
    elseif t == "string" then
        --text = text .. tostring(obj)
        --text = text .. string.format('%q', obj)
        text = text .. "'" .. obj .. "'"
    elseif t == "table" then
        text = text .. "{\n"

        for k, v in pairs(obj) do
            text = text .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
        end

        local metatable = getmetatable(obj)
        if metatable ~= nil and type(metatable.__index) == "table" then
            for k, v in pairs(metatable.__index) do
                text = text .. "[" .. serialize(k) .. "]=" .. serialize(v) .. ",\n"
            end
        end

        text = text .. "}"
    elseif t == "nil" then
        return nil
    else
        error("can not serialize a " .. t .. " type.")
    end

    return text
end

--反序列化
function deserialize(text)
    local t = type(text)
    if t == "nil" or text == "" then
        return nil
    elseif t == "number" or t == "string" or t == "boolean" then
        text = tostring(text)
    else
        error("can not unserialize a " .. t .. " type.")
    end

    text = "return " .. text

    local func = load(text)
    if func == nil then
        return nil
    end
    return func()
end

--字符串分割，返回表
function strsplit(str, char)
    splitRet = {}
    repeat
        local _Ret =
            string.gsub(
            str,
            "^(.-)%" .. char .. "(.-)$",
            function(a, b)
                splitRet[#splitRet + 1] = a
                str = b
            end
        )
        if str == _Ret then
            splitRet[#splitRet + 1] = _Ret
            break
        end
    until (str == "")
    return splitRet
end

function strreplace(str, index, value)
    if not str or str == "" then
        return
    end
    local len = str:len()
    local front = str:sub(1, index - 1)
    local center = str:sub(index, index)
    local last = str:sub(index + 1, len)

    front = front or ""
    last = last or ""
    return front .. value .. last
end

--表格分割，返回表
function tablesplit(tab, pos)
    local t1, t2 = {}, {}

    for i = 1, pos do
        t1[#t1 + 1] = tab[i]
    end

    for i = pos + 1, #tab do
        t2[#t2 + 1] = tab[i]
    end
    return t1, t2
end

-- 检查是否为连续的一天（相差1天）
function IsConsecutiveDay(prevDate, currentDate)
    if not prevDate then return false end
    
    local prevYear = math.floor(prevDate / 10000)
    local prevMonth = math.floor((prevDate % 10000) / 100)
    local prevDay = prevDate % 100
    
    local currYear = math.floor(currentDate / 10000)
    local currMonth = math.floor((currentDate % 10000) / 100)
    local currDay = currentDate % 100
    
    local prevTime = os.time({year = prevYear, month = prevMonth, day = prevDay})
    local currTime = os.time({year = currYear, month = currMonth, day = currDay})
    
    local diffDays = (currTime - prevTime) / (24 * 3600)
    return diffDays == 1
end

--放回0点时间戳
function GetDayTick(iTime)
    iTime = iTime or os.time()
    local sTime = os.date("%Y-%m-%d", iTime) .. " 00:00:00"
    local _, _, y, m, d, _hour, _min, _sec = string.find(sTime, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
    local timestamp = os.time({year = y, month = m, day = d, hour = _hour, min = _min, sec = _sec})
    return timestamp
end

--返回16:00:00
function GetClock(iTime)
    iTime = iTime or os.time()
    return os.date("%X", iTime)
end

function GetDate(iTime)
    iTime = iTime or os.time()
    return os.date("%Y-%m-%d %H:%M:%S", iTime)
end

function GetCurrentDate(iTime)
    local now = iTime or os.time()
    return os.date("%Y%m%d", now)
end

function GetYear(iTime)
    iTime = iTime or os.time()
    local t = os.date("*t", iTime)
    return t.year
end

function GetMonth(iTime)
    iTime = iTime or os.time()
    local t = os.date("*t", iTime)
    return t.month
end

function GetDay(iTime)
    iTime = iTime or os.time()

    local t = os.date("*t", iTime)
    return t.day
end

function GetHour(iTime)
    iTime = iTime or os.time()

    local t = os.date("*t", iTime)
    return t.hour
end

function GetMin(iTime)
    iTime = iTime or os.time()
    local t = os.date("*t", iTime)
    return t.min
end

function GetSec(iTime)
    iTime = iTime or os.time()
    local t = os.date("*t", iTime)
    return t.sec
end

function GetWday(iTime)
    iTime = iTime or os.time()
    local t = os.date("*t", iTime)
    --周日 t.wday = 1
    if t.wday == 1 then
        --周日
        return 7
    else
        return t.wday - 1
    end
end

--获取时刻字符串
function GetClockShow(iTime, showHour)
    local hour = math.floor(iTime / 3600)
    local min = math.floor(iTime / 60) - hour * 60
    local sec = iTime % 60
    if showHour then
        return string.format("%02d:%02d:%02d", hour, min, sec)
    else
        return string.format("%02d:%02d", min, sec)
    end
end

--根据日期获取时间戳
function GetTimestamp(sTime)
    local len = sTime:len()
    if len > 19 then
        return
    end

    if len <= 10 then
        sTime = sTime .. " 00:00:00"
    end

    local _, _, y, m, d, _hour, _min, _sec = string.find(sTime, "(%d+)-(%d+)-(%d+)%s*(%d+):(%d+):(%d+)")
    local timestamp = os.time({year = y, month = m, day = d, hour = _hour, min = _min, sec = _sec})
    return timestamp
end

--根据2个时间戳获取间隔天数
function GetTimeBetweenDays(sTime, eTime)
    eTime = eTime or os.time()
    local ret = strsplit(GetDate(sTime), " ")
    local sTime0 = GetTimestamp(ret[1])
    return math.floor((eTime - sTime0) / 86400)
end

--根据2个日期获取间隔天数
function GetDateBetweenDays(sDate, eDate)
    eDate = eDate or GetDate()
    local ret = strsplit(sDate, " ")
    local sTime0 = GetTimestamp(ret[1])
    local eTime = GetTimestamp(strsplit(eDate, " ")[1])
    return math.floor((eTime - sTime0) / 86400)
end

--根据日期获取显示日期
function GetDateShow(sTime)
    local len = sTime:len()
    if len == 10 or len == 19 then
    else
        return
    end

    if len == 19 then
        sTime = sTime:sub(1, 10)
    end

    local _, _, y, m, d = string.find(sTime, "(%d+)-(%d+)-(%d+)")
    return y .. "年" .. tonumber(m) .. "月" .. tonumber(d) .. "日"
end

--当前周一日期
function GetWeekDate(iTime)
    iTime = iTime or os.time()
    local wDay = GetWday(iTime)
    local date = GetDate(iTime - 86400 * (wDay - 1))
    local ret = date:sub(1, 10)
    return ret
end

function dbg(...)
    release_print(...)
end

function dbgt(tbl, front, parent)
    if type(tbl) ~= "table" then
        return
    end
    local space = "    "
    front = front or space

    if parent then
        release_print(parent)
    end
    release_print(front .. "{")

    for k, v in pairs(tbl) do
        local msg = space .. front

        if type(k) == "string" then
            msg = msg .. string.format('["%s"] = ', k)
        elseif type(k) == "number" then
            msg = msg .. string.format("[%d] = ", k)
        end

        if type(v) == "number" then
            msg = msg .. string.format("%d", v)
        elseif type(v) == "string" then
            msg = msg .. string.format('"%s"', v)
        elseif type(v) == "table" then
            dbgt(v, front .. space, msg)
        end

        if type(v) ~= "table" then
            msg = msg .. ","
            release_print(msg)
        end
    end

    if parent then
        release_print(front .. "},")
    else
        release_print(front .. "}")
    end
end

--根据元素固定间隔和元素数量计算起始坐标
function CalAveragePos(_PSize, _Size, _IX, _Count, _IsCenter)
    if _IsCenter then
        return _PSize / 2 - _IX * (_Count - 1) / 2
    else
        return (_PSize - _Size) / 2 - _IX * (_Count - 1) / 2
    end
end

--根据中心点，一行元素的x坐标(每个元素是ax = 0.5)
--输入中点，间隔，元素宽，个数，第几个
function GetCenterGroupPos(ox,ix,width,count,i)
    if bitAnd(count,1) == 1 then
        return ox + (ix+width) * (i-math.ceil(count/2))
    else
        return ox + (ix+width) * (i-(count+1)/2)
    end
end

--输入元素总数 每行个数 间距 返回坐标
function GetGridPos(_Count, _LineCount, _IX, _IY)
    local tPos = {}
    for i = 1, _Count do
        local line = math.ceil(i / _LineCount) - 1
        local pos = i - line * _LineCount - 1
        local _X = pos * _IX
        local _Y = line * _IY
        tPos[#tPos + 1] = {_X, _Y}
    end
    return tPos
end


--获取一个json串里的key值
function GetJsonValue(strJson, key)
    if type(strJson) ~= "string" or strJson == "" then
        return
    end

    if type(key) ~= "string" and type(key) ~= "number" then
        return
    end

    local ret
    local function _GetJsonValue()
        local tJson = json.decode(strJson)
        ret = tJson[key]
    end

    local _, errinfo = pcall(_GetJsonValue)
    if errinfo then
        release_print("GetJsonValue", errinfo)
        return
    end

    return ret
end

--设置一个json串里的key值并返回
function SetJsonValue(strJson, key, value)
    if not strJson then
        return
    end

    if type(key) ~= "string" and type(key) ~= "number" then
        return
    end

    if type(value) ~= "string" and type(value) ~= "number" then
        return
    end
    local ret

    local function _SetJsonValue()
        local tJson = {}
        if strJson ~= "" then
            tJson = json.decode(strJson)
        end

        tJson[key] = value
        ret = json.encode(tJson)
    end

    local _, errinfo = pcall(_SetJsonValue)
    if errinfo then
        release_print("SetJsonValue", errinfo)
        return
    end

    return ret
end

--计算table总和
function TableSum(tbl)
    local function sum(...)
        local num = 0
        for i = 1, select("#", ...) do
            num = num + select(i, ...)
        end
        return num
    end
    return sum(unpack(tbl))
end

--根据权重随机
function WeightRandom(tab, weightIndex)
    if #tab <= 0 then
        return
    end
    local t = {}
    
    for i = 1,#tab do
        if weightIndex then
            t[i] = tab[i][weightIndex]
        elseif type(tab[i]) == "table" and tab[i].Weight then
            t[i] = tab[i].Weight
        elseif type(tab[i]) == "number" then
            t[i] = tab[i]
        else
            return
        end
    end

    local sum = 0
    for i = 1, #t do
        sum = sum + t[i]
    end

    local comparew = math.random(1, sum)
    local windex = 1
    while sum > 0 do
        sum = sum - t[windex]
        if sum < comparew then
            return windex
        end
        windex = windex + 1
    end

    return nil
end

--简化数值 （超万显示万为单位 超亿显示亿为单位）
function GetSimplenum(num)
    num = tonumber(num)
    if num <= 10000 then
        return tostring(num)
    end

    if num >= 100000000 then
        --亿
        return string.format("%.2f", num / 100000000) .. "亿"
    elseif num > 10000 then
        --万
        return string.format("%.1f", num / 10000) .. "万"
    end
end

--获取通用资源路径
function GetCommonRes(name)
    return "custom/common/" .. name .. ".png"
end

--获取数字资源路径
function GetNumberRes(number, type)
    return "custom/number/" .. type .. "_" .. number .. ".png"
end

--根据方法名执行
function RunFuncName(funcName, ...)
    local func = load("return " .. funcName)
    func = func()
    if func then
        return func(...)
    end
end

----获取属性值显示
--function GetAttrValueStr(attyType, value)
--    attyType = tonumber(attyType)
--    local type = cfg_att_score[attyType].type
--    local str = value
--    if type == 2 then
--        str = value / 100 .. "%"
--    elseif type == 3 then
--        str = value .. "%"
--    end
--    return str
--end
--
----获取属性显示格式
--function GetAttrShow(attyType, value)
--    attyType = tonumber(attyType)
--    return cfg_att_score[attyType].name .. "：" .. GetAttrValueStr(attyType, value)
--end

--100以下阿拉伯数字转中文
function Ara2CN(num)
    local tChar = {
        [0] = "零",
        [1] = "一",
        [2] = "二",
        [3] = "三",
        [4] = "四",
        [5] = "五",
        [6] = "六",
        [7] = "七",
        [8] = "八",
        [9] = "九",
        [10] = "十"
    }

    if num < 11 then
        return tChar[num]
    elseif num < 20 then
        return tChar[10] .. tChar[num % 10]
    elseif num < 100 then
        if num % 10 == 0 then
            return tChar[math.floor(num / 10)] .. tChar[10]
        else
            return tChar[math.floor(num / 10)] .. tChar[10] .. tChar[num % 10]
        end
    end

    return
end

--中文星期几
function CHWeekDay(wDay)
    local tChar = {
        [1] = "一",
        [2] = "二",
        [3] = "三",
        [4] = "四",
        [5] = "五",
        [6] = "六",
        [7] = "日"
    }
    return tChar[wDay]
end

--十进制转二进制
function dec2bin(n)
    local t = {}
    for i = 31, 0, -1 do
        t[#t + 1] = math.floor(n / 2 ^ i)
        n = n % 2 ^ i
    end
    return table.concat(t)
end

--返回一串数字某个位的数值
function GetNumValueByIndex(actor, value, index)
    value = tonumber(value)
    index = tonumber(index)

    local ret = value % (10 ^ index)
    ret = math.floor(ret / (10 ^ (index - 1)))
    return ret
end

--根据总时间(秒数)获取 天,时,分,秒
function GetDetailTime(_TotleTime)
    if _TotleTime <= 0 then
        return 0, 0, 0, 0
    end
    local s = _TotleTime
    local m = math.floor(s / 60)
    local h = math.floor(m / 60)
    local d = math.floor(h / 24)
    s = s % 60
    m = m % 60
    h = h % 24
    return d, h, m, s
end

--根据秒数获取时间剩余的字符串
function GetLeaveTimeString(_TotleTime)
    local d, h, m, s = GetDetailTime(_TotleTime)
    local _Ret = ""
    if d ~= 0 then
        _Ret = d .. "天" .. h .. "时" .. m .. "分" .. s .. "秒"
    elseif h ~= 0 then
        _Ret = h .. "时" .. m .. "分" .. s .. "秒"
    else
        _Ret = m .. "分" .. s .. "秒"
    end
    return _Ret
end

function GetLeaveTimeString2(_TotleTime)
    local d, h, m, s = GetDetailTime(_TotleTime)
    local _Ret = ""
    if h > 0 then
        if h < 10 then
            _Ret = _Ret .. "0" .. h .. ":"
        else
            _Ret = _Ret .. h .. ":"
        end
    end
    if m < 10 then
        _Ret = _Ret .. "0" .. m .. ":"
    else
        _Ret = _Ret .. m .. ":"
    end
    if s < 10 then
        _Ret = _Ret .. "0" .. s
    else
        _Ret = _Ret .. s
    end
    return _Ret
end

--解析邮件道具字符串 返回 tItem,tAmount,tBind
function DecodeMailItems(str)
    if type(str) == "string" and str ~= "" then
        local tItem, tAmount, tBind = {}, {}, {}
        local tItemString = strsplit(str, "&")
        for i = 1, #tItemString do
            local tRet = strsplit(tItemString[i], "#")
            tItem[#tItem + 1] = tRet[1]
            tAmount[#tAmount + 1] = tRet[2]

            if not tRet[3] or tRet[3] == "0" then
                tBind[#tBind + 1] = false
            else
                tBind[#tBind + 1] = true
            end
        end

        return tItem, tAmount, tBind
    end
end

function encodeBase64(source_str)
    local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
    return ((source_str:gsub(
        ".",
        function(x)
            local r, b = "", x:byte()
            for i = 8, 1, -1 do
                r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
            end
            return r
        end
    ) .. "0000"):gsub(
        "%d%d%d?%d?%d?%d?",
        function(x)
            if (#x < 6) then
                return ""
            end
            local c = 0
            for i = 1, 6 do
                c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
            end
            return b:sub(c + 1, c + 1)
        end
    ) .. ({"", "==", "="})[#source_str % 3 + 1])
end

--检测行会名玩家名是否这个服务器的, 是则返回原名称
function IsThisServer(name)
    local serverKey = "k" .. lualib:GetServerId() .. "_"
    if name:find(serverKey) then
        --是本服行会
        name = name:gsub(serverKey, "")
        return name
    end
    return false
end

--【位运算】 https://stackoverflow.com/questions/5977654/how-do-i-use-the-bitwise-operator-xor-in-lua
--异或
function bitXor(a, b)
    if type(a) == "table" or type(b) == "table" then return end
    a = tonumber(a)
    b = tonumber(b)
    local p, c = 1, 0
    while a > 0 and b > 0 do
        local ra, rb = a % 2, b % 2
        if ra ~= rb then
            c = c + p
        end
        a, b, p = (a - ra) / 2, (b - rb) / 2, p * 2
    end
    if a < b then
        a = b
    end
    while a > 0 do
        local ra = a % 2
        if ra > 0 then
            c = c + p
        end
        a, p = (a - ra) / 2, p * 2
    end
    return c
end
--或
function bitOr(a, b)
    if type(a) == "table" or type(b) == "table" then return end
    a = tonumber(a)
    b = tonumber(b)
    local p, c = 1, 0
    while a + b > 0 do
        local ra, rb = a % 2, b % 2
        if ra + rb > 0 then
            c = c + p
        end
        a, b, p = (a - ra) / 2, (b - rb) / 2, p * 2
    end
    return c
end
--与
function bitAnd(a, b)
    if type(a) == "table" or type(b) == "table" then return end
    a = tonumber(a)
    b = tonumber(b)
    local p, c = 1, 0
    while a > 0 and b > 0 do
        local ra, rb = a % 2, b % 2
        if ra + rb > 1 then
            c = c + p
        end
        a, b, p = (a - ra) / 2, (b - rb) / 2, p * 2
    end
    return c
end
--非
function bitNot(n)
    if type(n) == "table" then return end
    n = tonumber(n)
    local p, c = 1, 0
    while n > 0 do
        local r = n % 2
        if r < 1 then
            c = c + p
        end
        n, p = (n - r) / 2, p * 2
    end
    return c
end
--左移
function bitLmove(x, by)
    if type(x) == "table" or type(by) == "table" then return end
    x = tonumber(x)
    by = tonumber(by)
    return x * 2 ^ by
end
--右移
function bitRmove(x, by)
    if type(x) == "table" or type(by) == "table" then return end
    x = tonumber(x)
    by = tonumber(by)
    return math.floor(x / 2 ^ by)
end

--k,v属性table转换成装备表属性字段配置格式
function AttTbl2EquipAttStr(tTotalAttr)
    --tTotalAttr = {["1"] =1000, ["3"] = 50}
    local allStr = {}
    for k, v in pairs(tTotalAttr) do
        local singleStr = {3}
        singleStr[#singleStr + 1] = k
        singleStr[#singleStr + 1] = v
        allStr[#allStr + 1] = table.concat(singleStr, "#")
    end

    --"3#76#3500|3#77#3500"
    return table.concat(allStr, "|")
end

--两个表的键值合并,返回一张不重复的键值表，顺序会变
--({"123","222","333","123"},{"123","222","777"})->{"123,"222","333","777"}
function MergeTable(table1, table2)
    local tMap = {}
    if type(table1) == "table" then
        for k,v in pairs(table1) do
            if type(v) ~= "table" then
                tMap[v] = 1
            end
        end
    end
    if type(table2) == "table" then
        for k,v in pairs(table2) do
            if type(v) ~= "table" then
                tMap[v] = 1
            end
        end
    end

    local ret = {}
    for k,v in pairs(tMap) do
        ret[#ret+1] = k
    end

    return ret
end

function isInTable(tb, v)
    if "table" ~= type(tb) or nil == v then
        return false
    end
    for _, cur_v in pairs(tb) do
        if cur_v == v then
            return true
        end
    end
    return false
end

function getTabLen(tab)
    if "table" ~= type(tab) then
        return 0
    end
    local len = 0
    for k, v in pairs(tab) do
        len = len + 1
    end
    return len
end

function indexOfTable(tbl, v)
    local index = -1
    if "table" ~= type(tbl) or nil == v then
        return index
    end
    for k, _v in pairs(tbl) do
        if _v == v then
            index = k
            break
        end
    end
    return index
end

function gettimestamp(hour, min, sec)
    -- 设置想要的时间（例如，中午12点）
    local t = {year = os.date("%Y"), month = os.date("%m"), day = os.date("%d"), hour = hour, min = min, sec = sec}
    -- 将时间表转换为时间戳
    local timestamp = os.time(t)
    
    return timestamp
end

-- 获取毫秒级时间戳
function GetCurrentTime()
    local current_time = os.time() * 1000 + math.floor(os.clock() * 1000)
    return current_time
end

function weightedRandom(items)
    -- 计算总权重
    local totalWeight = 0
    for _, item in pairs(items) do
        if item.weight and tonumber(item.weight) ~= nil then
            totalWeight = totalWeight + item.weight
        end
    end
    
    -- 生成随机数
    local randomValue = math.random() * totalWeight
    
    -- 选择对应的项目
    local currentWeight = 0
    for _, item in pairs(items) do
        if item.weight and tonumber(item.weight) ~= nil then
            currentWeight = currentWeight + item.weight
            if randomValue <= currentWeight then
                return item
            end
        end
    end
    
    -- 如果所有检查都失败(理论上不应该发生)，返回最后一个项目
    return items[1]
end

-- txt权重转为lua权重
-- 值#权重
-- str: 1#500|2#300|3#200|4#100|5#50|6#10|7#5|8#3|9#2|10#1"
function getWeightedCfg(str)
    local tab = strsplit(str, "|")
    local tmp_list = {}
    for k, v in pairs(tab) do
        local _t = strsplit(v, "#")
        tmp_list[#tmp_list + 1] = {value = tonumber(_t[1]) or _t[1], weight = tonumber(_t[2])}
    end
    return tmp_list    
end

-- 检查变量值
---comment
---@param actor string      玩家对象
---@param var_name string   变量名  
---@param op_type string    比较符   >  <   >=   <=  ==  ~= 
---@param value any         要比较的值
---@return boolean          --返回  true/false
function CheckVar(actor, var_name, op_type, value)
    local expression = ""
    if string.find(var_name, "U") == 1 then
        expression = "VarApi.getPlayerUIntVar(\"" .. actor .. "\", \"" .. var_name .. "\")"
    elseif string.find(var_name, "J") == 1 then
        expression = "VarApi.getPlayerJIntVar(\"" .. actor .. "\", \"" .. var_name .. "\")"
    elseif string.find(var_name, "T") == 1 then
        expression = "VarApi.getPlayerTStrVar(\"" .. actor .. "\", \"" .. var_name .. "\")"
    elseif string.find(var_name, "Z") == 1 then
        expression = "VarApi.getPlayerZStrVar(\"" .. actor .. "\", \"" .. var_name .. "\")"
    else
        return false
    end
    expression = expression .. op_type.. value
    return eval(expression)
end

function eval(expression)
    local func, err = load("return " .. expression)
    if func then
        return func()
    else
        release_print("格式错误 ** ")
        return 0
    end
end

function convertName(name)
    -- 参数检查
    if type(name) ~= "string" or #name == 0 then
        return name
    end

    -- 获取第一个字符
    local firstChar = string.sub(name, 1, 2)
    local stars = string.rep("*", 3)
    return firstChar .. stars
end

function isTimeAfter(targetHour, targetMinute, targetSecond)
    local now = os.date("*t")
    local nowSeconds = now.hour * 3600 + now.min * 60 + now.sec
    local targetSeconds = targetHour * 3600 + targetMinute * 60 + targetSecond
    
    return nowSeconds > targetSeconds
end

-- 获取多层九宫格（类似同心方形）
function getMultiLayerNineGrid(centerX, centerY, n)
    local coordinates = {}
    -- 计算第n层的相关信息
    local layerStartNumber = (2 * n - 1) * (2 * n - 1) + 1
    local sideLength = 2 * n  -- 每边的长度（不包括角落）
    -- 相对于起始点的坐标偏移
    local startX, startY = n, -n + 1  -- 第n层起始点相对坐标
    -- 四个边的起始点（相对坐标）
    local edgeStarts = {
        {x = n, y = -n + 1, direction = "up"},     -- 右边，向上移动
        {x = n - 1, y = n, direction = "left"},    -- 上边，向左移动
        {x = -n, y = n - 1, direction = "down"},   -- 左边，向下移动
        {x = -n + 1, y = -n, direction = "right"}  -- 下边，向右移动
    }
    -- 生成每一层的四个边
    for edgeIndex = 1, 4 do
        local startPos = edgeStarts[edgeIndex]
        local currentRelativeX, currentRelativeY = startPos.x, startPos.y

        -- 每个边有 sideLength 个点
        for i = 1, sideLength do
            -- 计算绝对坐标
            local absoluteX = centerX + currentRelativeX
            local absoluteY = centerY + currentRelativeY

            table.insert(coordinates, {
                x = absoluteX,           -- 绝对X坐标
                y = absoluteY,           -- 绝对Y坐标
                relativeX = currentRelativeX,  -- 相对X坐标
                relativeY = currentRelativeY,  -- 相对Y坐标
                edge = edgeIndex,
                positionInEdge = i
            })

            -- 根据方向移动相对坐标
            if startPos.direction == "up" then
                currentRelativeY = currentRelativeY + 1
            elseif startPos.direction == "left" then
                currentRelativeX = currentRelativeX - 1
            elseif startPos.direction == "down" then
                currentRelativeY = currentRelativeY - 1
            elseif startPos.direction == "right" then
                currentRelativeX = currentRelativeX + 1
            end
        end
    end

    return coordinates
end

-- 解析装备属性 区分职业
---comment  3#30#1|3#31#1|3#3#1|3#4#2|3#5#1|3#6#2|3#7#1|3#8#2|3#85#100
---@param item_name string    道具名称
function ParserEquipAttr(actor, item_name)
    local job = tonumber(getbaseinfo(actor, 7))
    local attr_tab = {}
    local str_attr = getdbitemfieldvalue(item_name, "Attribute")
    if nil == str_attr or "" == str_attr or type(str_attr) ~= "string" then
        return attr_tab
    end
    local tmp_tab = strsplit(str_attr, "|")
    for index, str in ipairs(tmp_tab) do
        local tab = strsplit(str, "#")
        local attr_job = tonumber(tab[1])
        local attr_id = tonumber(tab[2])
        local attr_value = tonumber(tab[3])
        if (job == attr_job or attr_job == 3) and attr_id then
            attr_tab[attr_id] = attr_value
        end
    end
    return attr_tab
end
---comment 字符串属性str转buff属性table
---@param arrtStr string
---@return table table
function ParserAttrStrToTable(arrtStr)
    local attr_tab = {}
    local tmp_tab = strsplit(arrtStr, "|")
    for index, str in ipairs(tmp_tab) do
        local tab = strsplit(str, "#")
        local attr_job = tonumber(tab[1])
        local attr_id = tonumber(tab[2])
        local attr_value = tonumber(tab[3])
        if attr_id and attr_value then
            if attr_tab[attr_id] then
                attr_tab[attr_id] = attr_tab[attr_id]+attr_value
            else
                attr_tab[attr_id] = attr_value
            end
        end
    end
    return attr_tab
end
-- 合并属性
---@return table
function MergeAndSum(...)
    local result = {}
    local tables = {...}
    -- 处理每个输入表
    for _, t in ipairs(tables) do
        for key, value in pairs(t) do
            if result[key] then
                result[key] = result[key] + value
            else
                result[key] = value
            end
        end
    end
    return result
end

-- 检查功能是否开放 针对1大陆以后的功能
---comment
---@param check_type number  检测类型   1.等级   2.转生等级
---@return boolean          -- 是否开放
function CheckOpenState(actor, check_type)
    check_type = check_type or 1
    if check_type == 1 then
        local level = getbaseinfo(actor, 6)
        if level < 80 then
            Sendmsg9(actor, "ffffff", "等级不足80级!", 1)
            return true
        end
    end
    if check_type == 2 then
        local level = getbaseinfo(actor, 6)
        if level < 80 then
            Sendmsg9(actor, "ffffff", "等级不足80级!", 1)
            return true
        end
        local re_level = getbaseinfo(actor, 39)
        if re_level < 10 then
            Sendmsg9(actor, "ffffff", "转生等级不足10转!", 1)
            return true
        end
    end
    return false
end

function GetConfig(cfg_name)
    local path = string.format("QuestDiary/config/%s.lua", cfg_name)
    local ret = include(path)
    return ret or {}
end

-- 封装 设置人物货币
--- @param actor  string  玩家对象
--- @param id number       货币id
--- @param opt string       操作符 + - =
--- @param count number    数量
--- @param msg  string     描述
--- @param send  boolean   是否更新到客户端            
function ChangeMoney(actor, id, opt, count, msg, send)
    if nil == send then
        send = true
    end
    return changemoney(actor, id, opt, count, msg, send)
end

-- 封装 gives
---comment
---@param actor string      玩家对象
---@param itemStr string    物品参数
---@param desc string       描述
function Gives(actor, itemStr, desc)
    local tab = strsplit(itemStr, "&")
    local blank_num = getbagblank(actor)
    if blank_num >= 6 and blank_num > #tab then
        gives(actor, itemStr, desc)
    else
        SendMail(actor, 1, "背包已满", desc.."\\您的背包已满, 物品已发放至邮箱,请及时领取!", itemStr)
        Sendmsg9(actor, "ffffff", "背包已满, 物品已进入邮箱!", 1)
    end
end

-- 封装一个giveitem
---comment
---@param actor string      玩家对象
---@param itemName string   物品名称
---@param qty number        物品数量
---@param bind number       绑定类型
---@param desc string       描述
---@param param any         其他参数
function GiveItem(actor, itemName, qty, bind, desc, param)
    qty = qty or 1
    bind = bind or 370
    desc = desc or ""
    local blank_num = getbagblank(actor)
    -- 格子够 进背包
    if blank_num >= 6 then
        giveitem(actor, itemName, qty, bind, desc)
    else
        SendMail(actor, 1, "背包已满", desc.."\\您的背包已满, 物品已发放至邮箱,请及时领取!", itemName.."#"..qty.."#"..bind)
        Sendmsg9(actor, "ffffff", "背包已满, 物品已进入邮箱!", 1)
    end
end

-- 封装 给物品直接装备  
---comment
---@param actor string      玩家对象
---@param where number      装备位置
---@param itemName string   装备名称
---@param qty number        数量
---@param bind number       物品规则
---@param desc string       描述
function GiveOnItem(actor, where, itemName, qty, bind, desc)
    qty = qty or 1
    bind = bind or 370
    desc = desc or ""
    if not giveonitem(actor, where, itemName, qty, bind, desc) then
        SendMail(actor, 1, "给物品直接穿戴失败", desc.."\\物品已发放至邮箱,请及时领取!", itemName.."#"..qty.."#"..bind)
    end
end

-- 封装 发送邮件
---comment
---@param actor string      玩家对象
---@param id number         邮件id
---@param title string      邮件标题
---@param memo string       邮件内容
---@param rewards string    附件内容 物品1#数量#绑定规则&
function SendMail(actor, id, title, memo, rewards)
    if nil == actor or not isnotnull(actor) then
        Sendmsg9(actor, "ff0000", "邮件发送失败!", 1)
        return
    end
    local userid = getbaseinfo(actor, 2)
    sendmail(userid, id, title, memo, rewards)
    local auto_open = VarApi.getPlayerUIntVar(actor, "U_auto_open_mail")
    --特殊邮件id 不自动打开邮件
    if auto_open > 0 and not isInTable({20},id) then
        openhyperlink(actor, 16, 0)
    end
end
