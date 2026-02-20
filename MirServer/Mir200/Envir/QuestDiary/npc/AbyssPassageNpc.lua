local AbyssPassageNpc = {}
AbyssPassageNpc.cfg = GetConfig("AbyssCaveCfg")
AbyssPassageNpc.VarTab = {
    "U_ahyj_clearance_times",
    "U_ymfx_clearance_times",
    "U_zxkj_clearance_times",
    "U_hdzy_clearance_times",
    "U_mylh_clearance_times"
}
function AbyssPassageNpc:click(actor)
    local remain_value = self:getRemainPoint(actor)
    local sMsg, times, get_times = self:getUiData(actor)
    lualib:ShowNpcUi(actor, "AbyssPassageOBJ", sMsg .. "#" .. remain_value)
end

function AbyssPassageNpc:onSelectDungeon(actor, index)
    local remain_value = self:getRemainPoint(actor)
    lualib:ShowNpcUi(actor, "AbyssDungeonOBJ", index .. "#" .. remain_value)
end

function AbyssPassageNpc:onChallenge(actor, id, index)
    id = tonumber(id)
    index = tonumber(index)
    if not isInTable({1,2}, index) or not isInTable({1,2,3,4,5}, id) then
        return
    end
    local remain_value = self:getRemainPoint(actor)
    local need_point = 10
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state > 0 then
        need_point = 5
    end
    if remain_value < need_point then
        Sendmsg9(actor, "ff0000", "剩余疲劳值不足!", 1)
        return
    end
    local _cfg = self.cfg[id]
    if nil == _cfg then
        return
    end
    local mon_name = _cfg.ptmobmon
    if index == 2 then
        mon_name = _cfg.emmobmon
        if math.random(100) < 10 then
            index = 3
        end
    end
    if index == 3 then
        local v = weightedRandom(getWeightedCfg(_cfg.Weight))
        mon_name = _cfg.dymobmon_arr[v.value]
    end
    if index > 1 then
        local num = getbagitemcount(actor, _cfg.needitem_map, 0)
        if num < _cfg.itemnum then
            Sendmsg9(actor, "ff0000", "挑战恶魔深渊需要[秘境卷轴*10]", 1)
            -- messagebox(actor, "挑战恶魔深渊需要: 秘境卷轴*10\\是否前往查看合成方式?", "@_on_go_compound", "@______")
            return
        end
        if not takeitem(actor, _cfg.needitem_map, _cfg.itemnum, 0, "挑战恶魔深渊扣除!") then
            Sendmsg9(actor, "ff0000", "深渊挑战书扣除失败!", 1)
            return
        end
    end
    VarApi.setPlayerJIntVar(actor, "J_fatigue_value", VarApi.getPlayerJIntVar(actor, "J_fatigue_value") + need_point, nil)
    lualib:CloseNpcUi(actor, "AbyssDungeonOBJ")
    lualib:CloseNpcUi(actor, "AbyssPassageOBJ")
    local eff_ids = {18024,18025,18026}
    lualib:CallFuncByClient(actor, "screffects", eff_ids[index])

    local old_map = _cfg.mapid
    local new_map = old_map .. getbaseinfo(actor, 1)
    if checkmirrormap(new_map) then
        delmirrormap(new_map)
    end
    addmirrormap(old_map, new_map, _cfg.name, _cfg.time, 3, 0, 322, 330)
    genmon(new_map, _cfg.monx, _cfg.mony, mon_name, 1, 1, 249)
    mapmove(actor, new_map, _cfg.posx, _cfg.posy, 1)
    self:ShowTaskUI(actor, id)
    VarApi.setPlayerUIntVar(actor, "U_cur_challenge_index", id, false)
    OtherTrigger.TipsMsg(actor, _cfg.name)
end

function AbyssPassageNpc:ShowTaskUI(actor, id)
    delbutton(actor, 110, "_654321")
    local btn_str = [[
        <Img|x=1|y=1|children={bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9}|img=custom/npc/21fb/symj/rwbg.png>
        <Frames|id=bg1|x=100|y=50|a=4|suffix=.png|prefix=custom/npc/21fb/symj/tx/tx%s_|count=30|loop=-1|finishhide=0|speed=6>
        <RText|id=bg2|x=78|y=138|a=4|outline=2|color=255|size=16|text=副本倒计时：>
        <COUNTDOWN|id=bg3|ay=0.5|x=122|y=138|size=16|count=1|outline=2|time=1800|color=250|link=@_on_back_abyss_cave,0>
        <RText|id=bg4|x=101|y=166|a=4|outline=2|color=70|size=16|text=当前副本已通关 %s 次>
        <Button|id=bg5|x=252|y=158|a=4|nimg=custom/npc/32mj/exit.png|clickInterval=1000|link=@_on_back_abyss_cave,1>
    ]]
    local value = VarApi.getPlayerUIntVar(actor, self.VarTab[id])
    btn_str = string.format(btn_str, id, value)
    addbutton(actor, 110, "_654321", btn_str)
end

function AbyssPassageNpc:getRemainPoint(actor)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    local myPoint = VarApi.getPlayerJIntVar(actor, "J_fatigue_value")
    local remain_value = 100 - myPoint
    if mzl_state > 0 then
        remain_value = 200 - myPoint
    end
    return remain_value
end

function AbyssPassageNpc:getUiData(actor)
    local tab = {}
    local times = 0
    for index, var in ipairs(self.VarTab) do
        local value = VarApi.getPlayerUIntVar(actor, var)
        tab[index] = value
        if times < value then
            times = value
        end
    end
    local get_times = VarApi.getPlayerUIntVar(actor, "U_get_clearance_times")
    return tbl2json(tab), times, get_times
end

function _on_back_abyss_cave(actor, back_type)
    back_type = tonumber(back_type)
    local map_id = getbaseinfo(actor, 3)
    if not checkmirrormap(map_id) then
        return
    end
    local mon_num = getmoncount(map_id, -1, true)
    if back_type == 1 and mon_num > 0 then
        messagebox(actor, "副本挑战还未完成，确定要退出副本？", "@_on_back_abyss_cave", "______")
    else
        local VarTab = {
            "U_ahyj_clearance_times",
            "U_ymfx_clearance_times",
            "U_zxkj_clearance_times",
            "U_hdzy_clearance_times",
            "U_mylh_clearance_times"
        }
        if mon_num <= 0 then
            local index = VarApi.getPlayerUIntVar(actor, "U_cur_challenge_index")
            local var_name = VarTab[index]
            if var_name then
                local times = VarApi.getPlayerUIntVar(actor, var_name) + 1
                VarApi.setPlayerUIntVar(actor, var_name, times, false)
            end
            local num = VarApi.getPlayerJIntVar(actor, "J_clearance_times") + 1
            VarApi.setPlayerJIntVar(actor, "J_clearance_times", num, nil)
        end
        map(actor, "深渊秘境")
    end
end

function _on_go_compound(actor)
    lualib:ShowNpcUi(actor, "CompoundSysOBJ", 2)
end

return AbyssPassageNpc