local BossHomeNpc = {}
BossHomeNpc.MapCfg = {
    "boss之家1",
    "boss之家2",
}
BossHomeNpc.NeedItem = {
    {"恶魔令牌", 1},
    {"恶魔令牌", 2},
}

function BossHomeNpc:click(actor)
    local tmp_tab = {}
    for index, map in ipairs(self.MapCfg) do
        local num = getmoncount(map, -1, true)
        tmp_tab[index] = num
    end
    lualib:ShowNpcUi(actor, "BossHomeOBJ", tmp_tab)
end

function BossHomeNpc:onMapMove(actor, index)
    index = tonumber(index)
    if not isInTable({1, 2}, index) then
        return
    end
    local map_id = self.MapCfg[index]
    local guild = getmyguild(actor)
    if 2 == index and not kuafuconnected() then
        Sendmsg9(actor, "ff0000", "跨服服务器未连接!", 1)
        return
    end
    local need_guild = true
    local need = self.NeedItem[index]
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state > 0 then
        need = {}
        need_guild = false
    end
    if need_guild and "0" == guild then
        Sendmsg9(actor, "ff0000", string.format("进入%s需要加入行会!", map_id), 1)
        return
    end
    if #need > 0 then
        local item = need[1]
        local num = need[2]
        local count = getbagitemcount(actor, item, 0)
        if count < num then
            Sendmsg9(actor, "ff0000", "非 [盟重令] 用户进入需要 [" .. item .. "*"..num .. "]", 1)
            return
        end
        if not takeitem(actor, item, num, 0, string.format("进入%s地图扣除!", map_id)) then
            Sendmsg9(actor, "ff0000", item .. "扣除失败", 1)
            return
        end
    end

    lualib:CloseNpcUi(actor, "BossHomeOBJ")
    mapmove(actor, map_id, 207, 207, 1)

    if mzl_state <= 0 and 1 == index then
        senddelaymsg(actor, "<BOSS之家停留倒计时： %s!/FCOLOR=250>", 7200, 255, 1, "@_on_exit_boss_home", nil)
    end
    local map_name = getmapname(map_id)
    OtherTrigger.TipsMsg(actor, map_name)
end

function _on_exit_boss_home(actor)
    mapmove(actor, 3, 303, 336, 1)
    Sendmsg9(actor, "ff0000", "【BOSS之家】停留结束，传送回城！", 1)
end

return BossHomeNpc