local AncientSwordNpc = {}
AncientSwordNpc.cfg = GetConfig("AncientSwordCfg")

function AncientSwordNpc:onForgeEquip(actor, index)
    index = tonumber(index)
    if nil == index then
        return
    end

    local _cfg = self.cfg[index]
    if nil == _cfg then
        return
    end
    local npc = getnpcbyindex(_cfg.npcid)
    if nil == npc or getbaseinfo(npc, 3) ~= getbaseinfo(actor, 3) then
        Sendmsg9(actor, "ff0000", "距离npc过远~", 1)
        return
    end

    local need_items = {_cfg.needequip, _cfg.needitem, _cfg.needitem1, _cfg.needitem2, _cfg.needitem3}
    local need_num = {_cfg.equipnum, _cfg.itemnum, _cfg.itemnum1, _cfg.itemnum2, _cfg.itemnum3}
    for key, v in ipairs(need_items) do
        local num = need_num[key]
        local count = getbagitemcount(actor, v, 0)
        if count < num then
            Sendmsg9(actor, "ff0000", "锻造需要: "..v .. "*" .. num, 1)
            return
        end
    end

    for key, v in ipairs(need_items) do
        local num = need_num[key]
        if not takeitem(actor, v , num, 0, "上古剑仙扣除") then
            Sendmsg9(actor, "ff0000", v.. "扣除失败!", 1)
            return
        end
    end

    GiveItem(actor, _cfg.name, 1, 0, "NPC锻造获得!")
    lualib:CallFuncByClient(actor, "screffects", 14801)
    Sendmsg9(actor, "ffffff", "锻造成功, 获得 [" .. _cfg.name .. "*1]", 1)
    sendmsgnew(actor,255,0,"恭喜: <『"..getbaseinfo(actor,1).."』/FCOLOR=250>人品爆发, 成功锻造出<『".._cfg.name.."』/FCOLOR=251>！", 1, 2)
    lualib:FlushNpcUi(actor, "AncientSwordOBJ", "")
end


return AncientSwordNpc