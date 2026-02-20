local MapMoveNpc = {}
MapMoveNpc.cfg = GetConfig("MapMoveCfg")
local tmp_list = {}
for key, v in pairs(MapMoveNpc.cfg) do
    tmp_list[v.mapid..""] = v
end
MapMoveNpc.record_cfg = tmp_list

function MapMoveNpc:checkRecordNpcId(actor, map_id)
    local _cfg = self.record_cfg[map_id] or {}
    return _cfg.key_name, _cfg
end

function MapMoveNpc:onMove(actor, npc_id, map_id, x, y, op_type)
    npc_id = tonumber(npc_id) or self:checkRecordNpcId(actor, map_id)
    local _cfg = self.cfg[npc_id]
    if nil == _cfg then
        if nil ~= map_id and op_type == 99998 then
            mapmove(actor, map_id, x, y, 0)
            return
        end
        Sendmsg9(actor, "ff0000", "数据异常!", 1)
        return
    end
    if _cfg.kuafu == 1 and not kuafuconnected() then
        Sendmsg9(actor, "ffffff", "跨服服务器未连接!", 1)
        return
    end
    local npc_map = getbaseinfo(getnpcbyindex(npc_id), 3)
    local cur_map = getbaseinfo(actor, 3)
    if npc_map ~= cur_map and nil == op_type then
        Sendmsg9(actor, "ff0000", "数据异常!", 1)
        return
    end
    local open_day = GetSysInt(VarEngine.OpenDay)
    local merge_count = GetSysInt(VarEngine.HeFuCount)
    local map_close = _cfg.mapclose
    if map_close and map_close == 1 then
        if merge_count >= map_close then
            Sendmsg9(actor, "ffffff", "合区之后地图关闭, 请前往新区体验!", 1)
            return
        end
    end
    if map_close and map_close > 1 then
        if open_day > map_close then
            Sendmsg9(actor, "ffffff", string.format("开区%s天开放!", map_close), 1)
            return
        end
    end
    local hequ_open = _cfg.hequ
    if hequ_open then
        if merge_count < hequ_open then
            if hequ_open <= 1 then
                Sendmsg9(actor, "ff0000", "合区后开放!", 1)
            else
                Sendmsg9(actor, "ff0000", hequ_open .. "合开放!", 1)
            end
            return
        end
    end
    -- 检查等级
    local level = getbaseinfo(actor, 6)
    if _cfg.needlevel and level < _cfg.needlevel then
        Sendmsg9(actor, "ff0000", string.format("等级不足%d级!", _cfg.needlevel), 1)
        return
    end
    -- 检查转生等级
    local relevel = getbaseinfo(actor, 39)
    if _cfg.needzs and relevel < _cfg.needzs then
        Sendmsg9(actor, "ff0000", string.format("转生等级不足%d转!", _cfg.needzs), 1)
        return
    end

    -- 检查狂暴
    if _cfg.openkb and _cfg.openkb ~= 0 then
        if VarApi.getPlayerUIntVar(actor, VarUIntDef.RAMPAGE_STATE) == 0 then
            Sendmsg9(actor, "ff0000", "未开启狂暴之力!", 1)
            return
        end
    end

    -- 检查变量
    local varname = _cfg.varname
    if type(varname) == "string" then
        local _tab = strsplit(varname, "#")
        local value = self:GetActorVarValue(actor, _tab[2])
        if tonumber(_tab[3]) and value < tonumber(_tab[3]) then
            Sendmsg9(actor, "ff0000", _tab[1], 1)
            return
        end
    end
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL) -- 盟重令
    -- 检查道具
    local tmp_tab = {}
    local needitem = _cfg.needitem
    if type(needitem) == "string" then
        local t = strsplit(needitem, "|")
        for index, item in ipairs(t) do
            local tab = strsplit(item, "#")
            local count = tonumber(tab[2]) or 1
            local num = getbagitemcount(actor, tab[1], 0)
            if num < count then
                Sendmsg9(actor, "ff0000", tab[1] .. "数量不足!", 1)
                return
            end
            tmp_tab[#tmp_tab + 1] = {tab[1], count}
        end
    end
    local needitem1 = _cfg.needitem1
    if type(needitem1) == "string" and mzl_state <= 0 then
        local tab = strsplit(needitem1, "#")
        local count = tonumber(tab[2]) or 1
        local item_id = getstditeminfo(tab[1], 0)
        local num = getbindmoney(actor, tab[1])
        if item_id and item_id > 100 then
            num = getbagitemcount(actor, tab[1], 0)
        end
        if num < count then
            Sendmsg9(actor, "ff0000", tab[1] .. "数量不足!", 1)
            return
        end
        tmp_tab[#tmp_tab + 1] = {tab[1], count}
    end

    if #tmp_tab > 0 then
        for key, info in pairs(tmp_tab) do 
            local item_id = getstditeminfo(info[1], 0)
            if item_id <= 100 then
                if not consumebindmoney(actor, info[1], info[2], "地图传送扣除!") then
                    Sendmsg9(actor, "ff0000", info[1] .. "扣除失败!", 1)
                    return
                end
            else
                if not takeitem(actor, info[1], info[2], 0, "地图传送扣除!") then
                    Sendmsg9(actor, "ff0000", info[1] .. "扣除失败!", 1)
                    return
                end
            end
        end
    end
    lualib:CloseNpcUi(actor, "MapMoveOBJ")
    if  op_type ~= 99999 then
        local enter_map = _cfg.mapid
        if _cfg.kuafu == 2 and kuafuconnected() then
            enter_map = enter_map .. "kf"
        end
        local enter_x = x or _cfg.posx or 0
        local enter_y = y or _cfg.posy or 0
        if enter_x == 0 and enter_y == 0 then
            map(actor, enter_map)
        else
            mapmove(actor, enter_map, enter_x, enter_y, 1)
        end
    end

    if type(_cfg.reward_arr) == "table" then
        OtherTrigger.TipsMsg(actor, _cfg.btnName)
        delaygoto(actor, 500, "delay_auto_fight", 0)
    end
    if _cfg.time and _cfg.time > 0 then
        senddelaymsg(actor, string.format("【%s】停留倒计时：%s", _cfg.btnName, "%s"), _cfg.time, 250, 1, "@delay_call_back_tc")
    end
    return true
end

function delay_auto_fight(actor)
    startautoattack(actor)
end

function delay_call_back_tc(actor)
    mapmove(actor, 3, 322, 333, 3)
    Sendmsg9(actor, "00ff00", "停留时间到!", 9)
end

function MapMoveNpc:GetActorVarValue(actor, varName)
    -- release_print("var name = "..varName)
    local old_value = nil
    local var_name = varName
    if string.find(var_name, "U_") or string.find(var_name, "U") then
        old_value = VarApi.getPlayerUIntVar(actor, var_name)
    elseif string.find(var_name, "T_") then
        old_value = VarApi.getPlayerTStrVar(actor, var_name)
    elseif string.find(var_name, "J_") then
        old_value = VarApi.getPlayerJIntVar(actor, var_name)
    elseif string.find(var_name, "Z_") then
        old_value = VarApi.getPlayerZStrVar(actor, var_name)
    end
    return old_value
end

function MapMoveNpc:EnterHideMap(actor,npcId)
    local npc = getnpcbyindex(npcId)
    local name = getbaseinfo(npc,1)
    local str = [[<Img|bg=1|loadDelay=0|move=0|img=public/bg_npc_01.png|reset=1|show=4>
        <Layout|x=545|y=0|width=80|height=80|link=@exit>
        <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Layout|id=100|children={10001,10002,10003,10004,10005,10006}|x=10|y=23.0|width=108|height=29|color=X>
        <RText|id=10001|x=220|y=06|outline=1|color=250|size=17|text=%s>
        <RText|id=10002|x=130|y=36|outline=1|color=255|size=17|text=来自远古的恶魔被囚禁在封印之地>
        <RText|id=10005|x=160|y=66|outline=1|color=255|size=17|text=它携带着神秘的未知宝藏>
        <Text|id=10003|x=100|y=106|outline=1|color=251|size=18|text=立即前往|link=@enter_hide_map,%s>
        <Text|id=10006|x=180|y=106|outline=1|color=251|size=18|text=(飞行符*5)>
        <Text|id=10004|x=350|y=106|outline=1|color=251|size=18|text=关闭对话|link=@exit>
    ]]
    say(actor,string.format(str,name,npcId) )
end
function enter_hide_map(actor,npcId)
    npcId = tonumber(npcId)
    MapMoveNpc:onMove(actor, npcId)
end


return MapMoveNpc