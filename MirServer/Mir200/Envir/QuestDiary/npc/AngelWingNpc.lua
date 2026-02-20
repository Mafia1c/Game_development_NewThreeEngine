local AngelWingNpc = {}
AngelWingNpc.cfg = GetConfig("AngelWingCfg")

function AngelWingNpc:click(actor)
    if CheckOpenState(actor, 1) then return end
    local cur_level = self:GetCurMaxWing(actor)
    lualib:ShowNpcUi(actor, "AngelWingOBJ", cur_level)
end

function AngelWingNpc:onClickUpLevel(actor, level)
    if CheckOpenState(actor, 1) then return end
    local cur_level = self:GetCurMaxWing(actor)
    local _wing_str = VarApi.getPlayerTStrVar(actor, "T_angel_wing_info")

    if cur_level >= 9 or string.find(_wing_str, "神话之翼") then
        Sendmsg9(actor, "ff0000", "你已拥有神话之翼!", 1)
        return
    end
    cur_level = cur_level + 1

    local cfg = self.cfg[cur_level]
    local money_id = getstditeminfo(cfg.needmoney, 0)
    local money = getbindmoney(actor,cfg.needmoney)
    if money < cfg.moneynum then
        Sendmsg9(actor, "ff0000", cfg.needmoney .. "数量不足!", 1)
        return
    end

    local item_num = getbagitemcount(actor, cfg.needitem, 0)
    if item_num < cfg.itemnum then
        Sendmsg9(actor, "ff0000", cfg.needitem .. "数量不足!", 1)
        return
    end

    if not consumebindmoney(actor, cfg.needmoney,cfg.moneynum, "升级天使之翼扣除!") then
        Sendmsg9(actor, "ff0000", cfg.needmoney .. "扣除失败!", 1)
        return
    end

    if not takeitem(actor, cfg.needitem, cfg.itemnum, 0, "打造".. cfg.name .."扣除"..cfg.needitem) then
        Sendmsg9(actor, "ff0000", cfg.needitem .. "扣除失败!", 1)
        return
    end
    _wing_str = cfg.name .. "|" .. _wing_str
    VarApi.setPlayerTStrVar(actor, "T_angel_wing_info", _wing_str, true)
    lualib:FlushNpcUi(actor, "AngelWingOBJ", cur_level)
    -- VarApi.setPlayerTStrVar(actor, "T_disguiseName5", cfg.name, true)      --#region 当前装扮的羽翼名称

    OtherTrigger.AttributeTransformation(actor, _wing_str, 50015)
end

function AngelWingNpc:GetCurMaxWing(actor)
    local _wing_str = VarApi.getPlayerTStrVar(actor, "T_angel_wing_info")
    local wing_tab = {}
    if "" == _wing_str then
    else
        wing_tab = strsplit(_wing_str, "|")
    end
    local max = 0
    for key, v in pairs(self.cfg) do
        if isInTable(wing_tab, v.name) and max < v.key_name then
            max = v.key_name
        end
    end
    return max
end


return AngelWingNpc