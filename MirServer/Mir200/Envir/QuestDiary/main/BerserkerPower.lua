local BerserkerPower = {}
function BerserkerPower:onClickBtn(actor)
    local kill_count = GetSysInt(VarEngine.KuangBaoDieCount)
    local auto = VarApi.getPlayerUIntVar(actor, "U_auto_rampage_state")
    local state = VarApi.getPlayerUIntVar(actor, VarUIntDef.RAMPAGE_STATE)
    lualib:ShowNpcUi(actor, "BerserkerPowerOBJ", kill_count .. "#" .. auto .. "#" .. state)
end

function BerserkerPower:onEnterRampageMap(actor)
    local state = VarApi.getPlayerUIntVar(actor, VarUIntDef.RAMPAGE_STATE)
    if state <= 0 then
        Sendmsg9(actor, "ff0000", "未开启 [狂暴之力]!", 1)
        return
    end
    lualib:CloseNpcUi(actor, "BerserkerPowerOBJ")
    local merge_count = GetSysInt(VarEngine.HeFuCount)
    if merge_count > 0 and kuafuconnected() then
        map(actor, "狂暴霸主kf")
    else
        map(actor, "狂暴霸主")
    end
end

function BerserkerPower:onOpenRampage(actor, open_type, auto_open)
    open_type = tonumber(open_type)
    local state = VarApi.getPlayerUIntVar(actor, VarUIntDef.RAMPAGE_STATE)
    if state > 0 then
        Sendmsg9(actor, "ffffff", "你已开启 [狂暴之力]!", 1)
        return
    end
    local tips = "开启 [狂暴之力] 需要200元宝"
    local money_id = 2
    if open_type == 2 then
        money_id = 4
        tips = "开启 [狂暴之力] 需要200绑定元宝"
    end
    if auto_open == true then
        if querymoney(actor, 4) >= 200 then
            money_id = 4
        end
    end
    local money = querymoney(actor, money_id)
    if money < 200 then
        Sendmsg9(actor, "ff0000", tips, 1)
        return
    end
    if ChangeMoney(actor, money_id, "-", 200, "开启狂暴之力扣除!") then
        confertitle(actor, "狂暴之力", 0)
        VarApi.setPlayerUIntVar(actor, VarUIntDef.RAMPAGE_STATE, money_id, true)
        seticon(actor, 1, 1, 12415, 0, 0, 1, 0, 0)
        Sendmsg9(actor, "00ff00", "开启 [狂暴之力] 成功!", 1)
        addskill(actor, 75, 3)

        local str = string.format("玩家「%s」开启了%s, 请各位小心!", "<"..getbaseinfo(actor, 1) .. "/FCOLOR=250>", "<[狂暴之力]/FCOLOR=251>")
        sendmsgnew(actor, 255, 0, str, 1, 2)
    end
    lualib:FlushNpcUi(actor,"BerserkerPower")
end

function BerserkerPower:onChangeAutoOpen(actor, open)
    open = tonumber(open)
    if nil == open then
        return
    end
    VarApi.setPlayerUIntVar(actor, "U_auto_rampage_state", open, false)
end

function BerserkerPower:onPlayerDie(actor, killer)
    if not getbaseinfo(killer, -1) then
        return
    end
    local state = VarApi.getPlayerUIntVar(actor, VarUIntDef.RAMPAGE_STATE)
    if state > 0 then
        if state == 2 then 
            ChangeMoney(killer, 2, "+", 100, "击杀狂暴之力玩家获得100元宝!", true)
        end
        delskill(actor, 75)
        deprivetitle(actor, "狂暴之力")
        seticon(actor, 1, -1)
        VarApi.setPlayerUIntVar(actor, VarUIntDef.RAMPAGE_STATE, 0, true)
        local die_count = GetSysInt(VarEngine.KuangBaoDieCount)
        die_count = die_count + 1
        if die_count >= 99 then
            SetSysInt("G_kbbz_activity_state2", 1)
            for i = 1, 3 do
                sendmovemsg("0", 0, 250, 0, 60 + (i - 1 ) * 30, 1, "<【活动提示】∶/FCOLOR=250><〖狂暴霸主〗/FCOLOR=253><已出现在活动地图，必爆高级装备！/FCOLOR=250>")
            end
            Sendmsg1("0",255,249,"【系统】：全服活动→狂暴之地，狂暴霸主已出现在活动地图，必爆高级装备！",2)
            local merge_count = GetSysInt(VarEngine.HeFuCount)

            if merge_count > 0 and kuafuconnected()  then  --跨服狂暴霸主
                KuaFuTrigger.bfbackcall(nil, "跨服狂暴霸主_开始", "狂暴霸主")
            else
                killmonsters("狂暴霸主","*",0,true,true)
                genmonex("狂暴霸主",28,34,"狂暴霸主",0,1,0,249)
            end

            local player_list = getplayerlst(1)
            for i, player  in ipairs(player_list or {}) do
                lualib:CallFuncByClient(player, "activity_state", "G_kbbz_activity_state2#".. 1)
                local activity_class =  IncludeMainClass("ActivityCenter")
                if activity_class  then
                    activity_class:ShowActitityStartTip(player,8)
                end
            end 
            die_count = 0
        end
        local auto = VarApi.getPlayerUIntVar(actor, "U_auto_rampage_state")
        if auto > 0 then
            self:onOpenRampage(actor, 1, true)
        end
        SetSysInt(VarEngine.KuangBaoDieCount, die_count)
    end
end

return BerserkerPower