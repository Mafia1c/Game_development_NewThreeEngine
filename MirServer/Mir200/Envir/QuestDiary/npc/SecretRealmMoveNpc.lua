local SecretRealmMoveNpc = {}
SecretRealmMoveNpc.cfg = GetConfig("SecretRealmCfg")

function SecretRealmMoveNpc:onMove(actor, npc_id)
    npc_id = tonumber(npc_id)
    local npc = getnpcbyindex(npc_id)
    local _cfg = self.cfg[npc_id]
    if nil == _cfg or nil == npc or not isnotnull(npc) or nil == npc_id then
        return
    end
    local map_suffix = ""
    if _cfg.kuafu == 1 then
        if not kuafuconnected() then
            Sendmsg9(actor, "ffffff", "跨服服务器未连接!", 1)
            return
        end
    else
        if kuafuconnected() then
            map_suffix = "kf"
        end
    end
    -- 检查道具
    local tmp_tab = {}
    local needitem = _cfg.needitem
    if type(needitem) == "string" then
        local tab = strsplit(needitem, "#")
        local count = tonumber(tab[2]) or 1
        local num = getbagitemcount(actor, tab[1], 0)
        if num < count then
            Sendmsg9(actor, "ff0000", tab[1] .. "不足!", 1)
            -- messagebox(actor, "挑战秘境需要: 秘境卷轴*1\\是否前往查看合成方式?", "@_on_open_compound", "@______")
            return
        end
        tmp_tab = {tab[1], count}
    end
    if #tmp_tab > 0 then
        if not takeitem(actor, tmp_tab[1], tmp_tab[2], 0, "恶魔秘境地图传送扣除!") then
            Sendmsg9(actor, "ff0000", tmp_tab[1] .. "扣除失败!", 1)
            return
        end
    else
        return
    end
    lualib:CloseNpcUi(actor, "SecretRealmMoveOBJ")

    local npc_class = IncludeMainClass("DailyActive")
    if npc_class then
        npc_class:UpdateActivePoint(actor, "恶魔秘境")
    end

    local map_name = getmapname(_cfg.mapid .. map_suffix)
    OtherTrigger.TipsMsg(actor, map_name)
    mapmove(actor, _cfg.mapid .. map_suffix, _cfg.posx, _cfg.posy, 1)
end

function _on_open_compound(actor)
    lualib:ShowNpcUi(actor, "CompoundSysOBJ", 2)
end

-- 恶魔秘境刷怪
function SecretRealmMoveNpc:UpdateMon(is_kuafu)
    for key, v in pairs(self.cfg) do
        if 1 ~= v.kuafu then
            local map_id = v.mapid
            if is_kuafu then
                map_id = map_id .. "kf"
            end
            local count = getmoncount(map_id, -1, true)
            if count <= 0 then
                genmon(map_id, v.bossx or 23, v.bossy or 18, v.genmob, 1, 1, 249)
            end
        end
    end
end

return SecretRealmMoveNpc