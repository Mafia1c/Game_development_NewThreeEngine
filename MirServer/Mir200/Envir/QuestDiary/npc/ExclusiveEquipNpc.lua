local ExclusiveEquipNpc = {}
ExclusiveEquipNpc.cfg = GetConfig("ExclusiveCfg")
ExclusiveEquipNpc.equip_list = {
    "影魅之刃",
    "天地の防",
    "幽灵の魔",
    "精灵の翔",
    "守护の神",
    "傀儡の隐",
    "凤凰の飞",
    "诅咒の亡",
    "仙女の带",
    "追日の靴"
}

function ExclusiveEquipNpc:click(actor, npc_id)
    local file_name = self:GetFileName(npc_id)
    lualib:ShowNpcUi(actor, file_name, npc_id)
end

function ExclusiveEquipNpc:onCreateEquip(actor, npc_id, index)
    npc_id = tonumber(npc_id)
    index = tonumber(index) or 1
    if nil == npc_id then
        return
    end
    local npc = getnpcbyindex(npc_id)
    if getbaseinfo(npc, 3) ~= getbaseinfo(actor, 3) then
        Sendmsg9(actor, "ff0000", "距离npc过远!", 1)
        return
    end
    local _cfg = self.cfg[npc_id]
    if nil == _cfg then
        return
    end
    local equip_index = _cfg.place_arr[index]
    local equip = GetItemByPos(actor, equip_index)
    local cur_name = getiteminfo(actor, equip, 7)
    local file_name = self:GetFileName(npc_id)

    local is_next = true
    if npc_id < 305 then
        if isInTable(self.equip_list, cur_name) then
            is_next = false
        elseif "0" ~= equip then
            is_next = false
        end
    else
        if cur_name == _cfg.name then
            is_next = false
        end
    end
    if not is_next then
        lualib:CloseNpcUi(actor, file_name)
        lualib:ShowNpcUi(actor, "ExclusiveEquip")
        return
    end

    for key, value in ipairs(_cfg.needitem1_arr) do
        local need_count = _cfg.itemnum1_arr[key]
        local item_id = getstditeminfo(value, 0)
        local num = getbagitemcount(actor, value, 0)
        if item_id <= 100 then
            num = getbindmoney(actor, value)
        end
        if isInTable(self.equip_list, value) then
            if "0" == equip then
                Sendmsg9(actor, "ff0000", "合成需要穿戴"..value, 1)
                return
            end
        else
            if num < need_count then
                Sendmsg9(actor, "ff0000", value.. "数量不足!", 1)
                return
            end
        end
    end

    for key, value in ipairs(_cfg.needitem1_arr) do
        local need_count = _cfg.itemnum1_arr[key]
        local item_id = getstditeminfo(value, 0)
        if isInTable(self.equip_list, value) then
            if not delbodyitem(actor, equip_index, "打造专属装备"..value .. "扣除!") then
                Sendmsg9(actor, "ff0000", value .. "扣除失败!", 1)
                return
            end
        else
            if item_id <= 100 then
                if not consumebindmoney(actor, value, need_count, "打造专属装备"..value .. "扣除!") then
                    Sendmsg9(actor, "ff0000", value .. "扣除失败!", 1)
                    return
                end
            else
                if not takeitem(actor, value, need_count, 0, "打造专属装备"..value .. "扣除!") then
                    Sendmsg9(actor, "ff0000", value .. "扣除失败!", 1)
                    return
                end
            end
        end
    end
    lualib:CloseNpcUi(actor, file_name)
    local names = strsplit(_cfg.name, "#")
    local equip_name = names[index]
    GiveOnItem(actor, equip_index, equip_name, 1, 370, npc_id .. "打造专属装备获得!")
    lualib:CallFuncByClient(actor, "screffects", 14801)
    sendmsgnew(actor,255,0,"恭喜: <『"..getbaseinfo(actor,1).."』/FCOLOR=254>成功打造出专属<『"..equip_name.."』/FCOLOR=250>！", 1, 2)
end

function ExclusiveEquipNpc:GetFileName(npc_id)
    local equip = self.cfg[npc_id]
    local file_name = "ExclusiveEquip1OBJ"
    local tab = strsplit(equip.name, "#")
    if #tab <= 1 then
        file_name = "ExclusiveEquip2OBJ"
    end 
    return file_name
end

return ExclusiveEquipNpc
