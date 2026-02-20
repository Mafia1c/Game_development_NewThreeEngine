local AbyssGuardianNpc = {}
AbyssGuardianNpc.cfg = GetConfig("AbyssCaveCfg")
AbyssGuardianNpc.VarTab = {
    "U_ahyj_clearance_times",
    "U_ymfx_clearance_times",
    "U_zxkj_clearance_times",
    "U_hdzy_clearance_times",
    "U_mylh_clearance_times"
}

function AbyssGuardianNpc:click(actor)
    local sMsg, times, get_times = self:getUiData(actor)
    lualib:ShowNpcUi(actor, "AbyssGuardianOBJ", sMsg .. "#" .. times .. "#" .. get_times)
end

function AbyssGuardianNpc:onGetTitle(actor)
    local sMsg, times, get_times = self:getUiData(actor)
    local reward_times = 10
    if get_times < 10 then
        reward_times = 10
    elseif get_times < 30 then
        reward_times = 30
    else
        reward_times = 90
    end
    if get_times >= reward_times then
        Sendmsg9(actor, "ff0000", "ÇëÎðÖØ¸´ÁìÈ¡!", 1)
        return
    end
    local _cfg = nil
    if times >= reward_times then
        for i = 9, 11, 1 do
            local v = self.cfg[i]
            if v.time == reward_times then
                _cfg = v
                break
            end
        end
    end
    if nil == _cfg then
        return
    end
    if checktitle(actor, _cfg.giveitem1) then
        Sendmsg9(actor, "ff0000", "ÇëÎðÖØ¸´ÁìÈ¡!", 1)
        return
    else
        confertitle(actor, _cfg.giveitem1, 1)
    end
    VarApi.setPlayerUIntVar(actor, "U_get_clearance_times", reward_times, false)
    lualib:FlushNpcUi(actor, "AbyssGuardianOBJ", sMsg .. "#" .. times .. "#" .. reward_times)
end

function AbyssGuardianNpc:getUiData(actor)
    local tab = {}
    local times = 100
    for index, var in ipairs(self.VarTab) do
        local value = VarApi.getPlayerUIntVar(actor, var)
        tab[index] = value
        if times > value then
            times = value
        end
    end
    local get_times = VarApi.getPlayerUIntVar(actor, "U_get_clearance_times")
    return tbl2json(tab), times, get_times
end

function AbyssGuardianNpc:getPlayerInfo(actor)
    local _actor = actor
    local v = {}
    -- ÒÂ·þ
    local cloth = GetItemByPos(_actor, 0)
    local _id = getiteminfo(_actor, cloth, 2)
    if _id then
        v.clothID = getdbitemfieldvalue(_id, "Looks")
        local sEffect = getdbitemfieldvalue(_id, "sEffect")
        if type(sEffect) == "string" and string.find(sEffect, "#") then
            v.clothEffectID = strsplit(sEffect, "#")[1]
        else
            v.clothEffectID = sEffect or 0
        end
    end

    -- ÎäÆ÷
    local weapon = GetItemByPos(_actor, 1)
    _id = getiteminfo(_actor, weapon, 2)
    if _id then
        v.weaponID = getdbitemfieldvalue(_id, "Looks")
        sEffect = getdbitemfieldvalue(_id, "sEffect")
        if type(sEffect) == "string" and string.find(sEffect, "#") then
            v.weaponEffectID = strsplit(sEffect, "#")[1]
        else
            v.weaponEffectID = sEffect or 0
        end
    end

    -- Í·¿ø
    local head = GetItemByPos(_actor, 4)
    _id = getiteminfo(_actor, head, 2)
    if _id  then
        v.headID = getdbitemfieldvalue(_id, "Looks")
        sEffect = getdbitemfieldvalue(_id, "sEffect")
        if type(sEffect) == "string" and string.find(sEffect, "#") then
            v.headEffectID = strsplit(sEffect, "#")[1]
        else    
            v.headEffectID = sEffect or 0
            release_print("Í·¿ø", _id)
        end
    end

    -- ¶·óÒ
    local cap = GetItemByPos(_actor, 13)
    _id = getiteminfo(_actor, cap, 2)
    if _id then
        v.capID = getdbitemfieldvalue(_id, "Looks")
        sEffect = getdbitemfieldvalue(_id, "sEffect")
        if type(sEffect) == "string" and string.find(sEffect, "#") then
            v.capEffectID = strsplit(sEffect, "#")[1]
        else
            v.capEffectID = sEffect or 0
        end
    end

    -- ¶ÜÅÆ
    local shield = GetItemByPos(_actor, 16)
    _id = getiteminfo(_actor, shield, 2)
    if _id  then
        v.shieldID = getdbitemfieldvalue(_id, "Looks")
        sEffect = getdbitemfieldvalue(_id, "sEffect")
        if type(sEffect) == "string" and string.find(sEffect, "#") then
            v.shieldEffectID = strsplit(sEffect, "#")[1]
        else
            v.shieldEffectID = sEffect or 0
        end
    end
    return tbl2json(v)
end

return AbyssGuardianNpc