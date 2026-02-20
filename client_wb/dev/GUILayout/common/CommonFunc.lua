
function unpack(arr, pos)
    pos = pos or 1
    if pos >= #arr then
        return arr[pos]
    end
    return arr[pos], unpack(arr, pos + 1)
end

function isInTable(tab, value)
    if "table" ~= type(tab) or nil == value then
        return false
    end
    for _, cur_v in pairs(tab) do
        if cur_v == value then
            return true
        end
    end
    return false
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

function GetNpcDistance(npc_id)
    local main_role = SL:GetMetaValue("MAIN_ACTOR_ID")
    local p1x = SL:GetMetaValue("ACTOR_MAP_X", main_role)
    local p1y = SL:GetMetaValue("ACTOR_MAP_Y", main_role)
    local p2x = SL:GetMetaValue("ACTOR_MAP_X", npc_id)
    local p2y = SL:GetMetaValue("ACTOR_MAP_Y", npc_id)

	local x_step = math.abs(p1x - p2x)
	local y_step = math.abs(p1y - p2y)
	 local maxValue = math.max(x_step, y_step)
	return maxValue
end

local weekday_str = { "星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日" }
function timeWeekdayStr(time)
    local weekday = os.date("%w", time)
    return weekday_str[weekday + 1]
end

-- 获取周几   1-7  周一到周日
function GetWeekDay()
    local weekday = os.date("%w", os.time())
    if weekday == 0 then
        return 7
    end
    return weekday
end

---移除当前控件并监听parent。
---*  removeObj : 当前需要移除的控件
---*  nowObj : 当前脚本类
---@param removeObj obj
---@param nowObj class
---@return any
function removeOBJ(removeObj,nowObj)
    if removeObj then
        GUI:removeFromParent(removeObj)
        nowObj.ui = GUI:ui_delegate(nowObj._parent)
    end
end


local CONST_3600 = 3600
local CONST_3600_INTERVAL = 1 / CONST_3600
local CONST_60 = 60
local CONST_60_INTERVAL = 1 / CONST_60
local CONST_24 = 24
local CONST_24_INTERVAL = 1 / CONST_24
local CONST_60_60_24_INTERVAL = CONST_3600_INTERVAL * CONST_24_INTERVAL
function FormatSecond2CN_DHMS2(time)
    time = tonumber(time)
    if time and time > 0 then
        local day = math.floor(time * CONST_60_60_24_INTERVAL)
        local hour = math.floor((time * CONST_3600_INTERVAL) % 24)
        local minute = math.floor((time * CONST_60_INTERVAL) % 60)
        local second = math.floor(time % 60)

        local format_str = ""
        if second >= 0 then
            format_str = format_str .. tostring(second) .. "秒"
        end
        if minute > 0 or hour > 0 or day > 0 then
            format_str = tostring(minute) .. "分" .. format_str
        end
        if hour > 0 or day > 0 then
            format_str = tostring(hour) .. "时" .. format_str
        end
        if day > 0 then
            format_str = tostring(day) .. "天" .. format_str
        end

        if format_str == "" then
            return "0秒"
        end
        return format_str
    end

    return "0秒"
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

function GetDate(iTime)
    iTime = iTime or os.time()
    return os.date("%Y-%m-%d %H:%M:%S", iTime)
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

function ItemShow_updateItem(widget, setData)
    local isPC = SL:Get_IS_PC_OPER_MODE()
    if nil ~= setData.index then
        GUI:ItemShow_updateItem(widget, setData)
    end
    local node = GUI:getChildByName(widget, "_show_count")
    if node then
        GUI:removeFromParent(node)
        node = nil
    end    
    if setData.showCount and (setData.count==1 or setData.count==0)  then     -- 显示数字1和0
        local size = GUI:getContentSize(widget)
        local str = "<%s/FCOLOR=%d>"
        GUI:RichTextFCOLOR_Create(widget, "_show_count", size.width - 10, 0, string.format(str, setData.count, setData.color or 249), 20, isPC and 14 or 16, "#ffffff")
    end
end

function GetConfig(path)
    if not SL:IsFileExist("GUILayout/config/"..path..".lua") then
        return {}
    end
    return  SL:Require("GUILayout/config/"..path, true)
end

function findMaxConsecutiveIncrement(nums)
    if #nums == 0 then
        return 0
    end
    local maxCount = 1
    local currentCount = 1
    
    for i = 2, #nums do
        if nums[i] == nums[i-1] + 1 then
            currentCount = currentCount + 1
        else
            if currentCount > maxCount then
                maxCount = currentCount
            end
            currentCount = 1
        end
    end
    
    -- 处理最后一个连续序列
    if currentCount > maxCount then
        maxCount = currentCount
    end
    
    return maxCount
end

-- 从中间往两边排列
function arrangeNodesFromCenter(nodes, startX, startY, spacingX, spacingY)
    if type(nodes) ~= "table" or #nodes == 0 then
        return
    end
    -- 计算中间索引
    local centerIndex = math.ceil(#nodes / 2)
    -- 先放置中间节点
    if nodes[centerIndex] then
        GUI:setPosition(nodes[centerIndex], startX, startY)
    end
    -- 从中间向两边放置其他节点
    for i = 1, centerIndex - 1 do
        -- 放置左侧节点
        local leftIndex = centerIndex - i
        if nodes[leftIndex] then
            GUI:setPosition(nodes[leftIndex], startX - i * spacingX, 0)
        end
        -- 放置右侧节点
        local rightIndex = centerIndex + i
        if nodes[rightIndex] then
            GUI:setPosition(nodes[rightIndex], startX + i * spacingX, 0)
        end
    end
end

-- 获取人物内观数据
---comment
---@param get_dl boolean  是否显示斗笠      默认不显示
---@param get_tk boolean  是否显示头盔      默认不显示
---@return table
function GetModelInfo(get_dl, get_tk)
    local yf = SL:Get_EQUIP_DATA(0)     -- 衣服
    local wq = SL:Get_EQUIP_DATA(1)     -- 武器
    local tk = SL:Get_EQUIP_DATA(4)     -- 头盔
    local dl = SL:Get_EQUIP_DATA(13)     -- 斗笠
    local dp = SL:Get_EQUIP_DATA(16)    -- 盾牌
    local mj = SL:Get_EQUIP_DATA(55)    -- 面巾

    local feature= {}
    feature.clothID = yf and yf.Looks or nil                -- 衣服
    feature.clothEffectID = yf and yf.sEffect or nil        -- 衣服特效id
    feature.weaponID = wq and wq.Looks or nil                -- 武器id
    feature.weaponEffectID = wq and wq.sEffect or nil        -- 武器特效id
    feature.headID = tk and tk.Looks or nil                  -- 头盔id
    feature.headEffectID = tk and tk.sEffect or nil          -- 头盔特效id
    feature.capID = dl and dl.Looks or nil                   -- 斗笠id
    feature.capEffectID = dl and dl.sEffect or nil           -- 斗笠特效id
    feature.shieldID = dp and dp.Looks or nil                -- 盾牌id
    feature.shieldEffectID = dp and dp.sEffect or nil        -- 盾牌特效id
    feature.veilID = mj and mj.Looks or nil                  -- 面巾id
    feature.veilEffectID = mj and mj.sEffect or nil          -- 面巾特效id

    feature.showNodeModel = true
    feature.showHair = false

    if not get_dl then
        feature.capID = nil
        feature.capEffectID = nil
    end
    if not get_tk then
        feature.headID = nil
        feature.headEffectID = nil
    end
    return feature
end

function secondsToExtendedTime(seconds)
    seconds = tonumber(seconds) or 0
    seconds = math.max(0, seconds)
    
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local minutes = math.floor((seconds % 3600) / 60)
    local secs = math.floor(seconds % 60)
    
    if days > 0 then
        return string.format("%d天 %02d:%02d:%02d", days, hours, minutes, secs)
    else
        return string.format("%02d:%02d:%02d", hours, minutes, secs)
    end
end