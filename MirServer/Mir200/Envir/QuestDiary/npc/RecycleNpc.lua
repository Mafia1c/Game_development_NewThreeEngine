local RecycleNpc = {}
local _cfg = include("QuestDiary/config/RecycleCfg.lua")
RecycleNpc.cfg = _cfg
RecycleNpc.title = {
    ["白银特权"] = 10,
    ["黄金特权"] = 30,
    ["钻石特权"] = 50,
}

function RecycleNpc:click(actor)
    local rate = getbaseinfo(actor, 51, 298)
    for name, value in pairs(self.title) do
        if checktitle(actor, name) then
            rate = rate + value
        end
    end
    local tab, auto = self:getRecycleState(actor)
    local nav = VarApi.getPlayerUIntVar(actor, "U_bag_navigation")
    if nav == 10 then
        lualib:ShowNpcUi(actor, "RecycleOBJ", tbl2json(tab) .. "#" .. tbl2json(auto) .. "#" .. rate)
        VarApi.setPlayerUIntVar(actor, "U_bag_navigation", 110, false)
        delaygoto(actor, 300, "delay_navigation_recycle", 0)
    else
        lualib:ShowNpcUi(actor, "RecycleOBJ", tbl2json(tab) .. "#" .. tbl2json(auto) .. "#" .. rate)
    end
end

function delay_navigation_recycle(actor)
    cleardelaygoto(actor, "delay_navigation_recycle")
    lualib:CallFuncByClient(actor, "navigation", "RecycleOBJ#allBtn#点击回收#onAllRecycle#1")
end

-- 一键全选
function RecycleNpc:onAllSelect(actor)
    local tab, auto = self:getRecycleState(actor)
    local state = 0
    for key, value in ipairs(tab or {}) do
        local ret_tab = strsplit(value, "|")
        if tonumber(ret_tab[1]) == 0 then
            state = 1
            break
        end
    end

    local value = "0"
    if state == 0 then
        value = "1"
    end

    for i = 1, #tab , 1 do
        tab[i] = string.gsub(tab[i], value, state)
    end

    VarApi.setPlayerTStrVar(actor, "T_recycle_info", tbl2json(tab))
    lualib:FlushNpcUi(actor, "RecycleOBJ", tbl2json(tab))
end

-- 一键回收
function RecycleNpc:onAllRecycle(actor, is_auto)
    local tab, auto = self:getRecycleState(actor)
    local zztq = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)              -- 盟重令 回收+100%
    local total_yb = 0          -- 元宝
    local total_sp = 0          -- 装备碎片
    local yb_item_id = 4
    local yb_prefix = "绑定元宝x"
    local sp_prefix = "装备碎片x"
    if zztq > 0 then
        yb_item_id = 2
        yb_prefix = "元宝x"
    end
    local list = self.cfg
    local tmp_tab = tab or {}
    for key, v in ipairs(list) do
        local ret_tab = strsplit(tmp_tab[key], "|")
        for index, name in ipairs(v.equipname_arr) do
            local state = tonumber(ret_tab[index + 1])
            if state == 1 then
                local rate = 1
                if isInTable(v.doublename_arr, name) then
                    rate = 2
                end
                local num = getbagitemcount(actor, name, 0) or 0
                if num > 0 and takeitem(actor, name, num, 0, "回收") then
                    if v.money == "元宝" then
                        total_yb = total_yb + v.moneynum * rate * num
                    end
                    if v.money1 == "装备碎片" then
                        total_sp = total_sp + v.moneynum1 * rate * num
                    end
                end
            end
        end
    end

    local add_rate = 0
    if zztq > 0 then
        add_rate = add_rate + 100
    end
    local title_rate = 0
    for name, value in pairs(self.title) do     -- 特权称号回收加成取最高比例
        if checktitle(actor, name) then
            if title_rate < value then
                title_rate = value
            end
        end
    end
    add_rate = add_rate + title_rate
    if add_rate > 0 then
        total_yb = total_yb + total_yb * (add_rate / 100)
        total_sp = total_sp + total_sp * (add_rate / 100)
    end

    total_yb = math.ceil(total_yb)
    total_sp = math.ceil(total_sp)
    local yb_tips = ""
    if total_yb > 0 then
        yb_tips = yb_prefix..total_yb
        ChangeMoney(actor, yb_item_id, "+", total_yb, "回收获得元宝", true)
    end
    local sp_tips = ""
    if total_sp > 0 then
        -- sp_tips = sp_prefix .. total_sp
        -- Gives(actor, "装备碎片#"..total_sp .. "#370", "回收装备获得装备碎片!")
    end
    if "" ~= yb_tips or "" ~= sp_tips then
        Sendmsg9(actor, "ffffff", "回收获得: "..yb_tips .. sp_tips, 1)
    end
    if not is_auto then
        lualib:FlushNpcUi(actor, "RecycleOBJ", tbl2json(tab))
    end
end

function RecycleNpc:onChangeAutoSate(actor, _type)
    _type = tonumber(_type)
    local var_name = "U_auto_use_yb"
    if _type == 2 then
        var_name = "U_auto_use_exp"
    elseif _type == 3 then
        var_name = "U_auto_recycle"
    end
    local auto_state = VarApi.getPlayerUIntVar(actor, var_name)
    if auto_state == 0 then
        auto_state = 1
    else
        auto_state = 0
    end
    VarApi.setPlayerUIntVar(actor, var_name, auto_state, true)
end

function RecycleNpc:onChangeRecycleState(actor, _index)
    local index = tonumber(_index)
    if nil == index then
        return
    end
    local state = VarApi.getPlayerTStrVar(actor, "T_recycle_info")
    if "" == state then
        local tab, auto = self:getRecycleState(actor)
        state = tab
    else
        state = json2tbl(state)
    end
    local ret = state[index]
    local info = strsplit(ret, "|")
    if info[1] == "1" then
        ret = string.gsub(ret, "1", "0")
    else
        ret = string.gsub(ret, "0", "1")
    end
    state[index] = ret
    VarApi.setPlayerTStrVar(actor, "T_recycle_info", tbl2json(state))
    lualib:FlushNpcUi(actor, "RecycleOBJ", tbl2json(state))
end

function RecycleNpc:onChangeItemRecycleState(actor, _type, _index)
    _type = tonumber(_type)
    local index = tonumber(_index)
    if nil == _type or nil == index then
        return
    end
    local tab, auto = self:getRecycleState(actor)
    local ret = tab[_type]
    if nil == ret then
        return
    end

    local info = strsplit(ret, "|")
    info[index + 1] = info[index + 1] == "0" and "1" or "0"
    if info[index + 1] == "1" then
        info[1] = "1"
    end

    tab[_type] = table.concat(info, "|")
    VarApi.setPlayerTStrVar(actor, "T_recycle_info", tbl2json(tab))
    lualib:FlushNpcUi(actor, "RecycleOBJ", tbl2json(tab) .. "#" .. _type)
end

function RecycleNpc:getRecycleState(actor)
    local state = VarApi.getPlayerTStrVar(actor, "T_recycle_info")
    local tab = {}
    if "" == state then
        local tb1 = {}
        for index, v in ipairs(self.cfg) do
            local ret = index <= 4 and 1 or 0
            local tmp = {}
            for key, name in ipairs(v.equipname_arr) do
                table.insert(tmp, ret)
            end
            tb1[index] = ret .. "|" .. table.concat(tmp, "|")
        end
        tab = tb1
    else
        tab = json2tbl(state)
    end
    local yb = VarApi.getPlayerUIntVar(actor, "U_auto_use_yb")
    local exp = VarApi.getPlayerUIntVar(actor, "U_auto_use_exp")
    local auto = VarApi.getPlayerUIntVar(actor, "U_auto_recycle")
    return tab, {yb, exp, auto}
end

return RecycleNpc