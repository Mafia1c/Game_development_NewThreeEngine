local OtherSysFunc = {}
OtherSysFunc.bubble_cfg = GetConfig("BubbleCfg")
OtherSysFunc.MFBDCfg = GetConfig("MaFaBaoDianCfg")
OtherSysFunc.PrivilegesCfg = GetConfig("PrivilegesCfg")

-- 查看其他玩家信息     look_type:  1.查看专属装备   2.查看五行装备
function OtherSysFunc:lookPlayerInfo(actor, look_type)
    look_type = tonumber(look_type)
    local look_id = VarApi.getPlayerTStrVar(actor, VarTStrDef.LookPlayerId)
    local look_name = VarApi.getPlayerTStrVar(actor, VarTStrDef.LookPlayer)
    local player = getplayerbyid(look_id)
    if not isnotnull(player) then
        player = getplayerbyname(look_name)
    end
    if not isnotnull(player) then
        return Sendmsg9(actor, "ffffff", "该玩家不在线!", 1)
    end
    local equip_index = {}
    local client_class_name = nil
    local sMsg = {}
    if look_type == 1 then              -- 天命
        sMsg = VarApi.getPlayerTStrVar(player,"T_bloodline_state")
        sMsg = sMsg .. "#"..look_name
        client_class_name = "LookBloodlineAwakenOBJ"
    elseif look_type == 2 then          -- 经脉
        lualib:ShowNpcUi(actor, "Pulse_LookOBJ", VarApi.getPlayerUIntVar(player,"U_pulseLayer"))
    elseif look_type == 3 then          -- 秘术
        sMsg = VarApi.getPlayerTStrVar(player,"T_occult_level")
        if sMsg == "" then
           return  Sendmsg9(actor, "ffffff", "玩家【"..look_name.."】还未激活【风水秘术】", 1)
        end
        sMsg = sMsg .."#"..look_name
        client_class_name = "LookFengShuiOccultOBJ"
        
    elseif look_type == 4 then          -- 专属
        local index = VarApi.getPlayerUIntVar(player, "U_role_btn_index")
        if index <= 2 then
            Sendmsg9(actor, "ffffff", "该玩家未激活专属装备", 1)
            return
        end
        equip_index = {82,84,86,87,85,83,81,80,78,79}
        client_class_name = "ExclusiveEquip_LookOBJ"
    elseif look_type == 5 then          -- 血脉
        -- local data1 = VarApi.getPlayerTStrVar(player,"T_ws_xuemai_info"..1)
        -- local data2 =  VarApi.getPlayerTStrVar(player,"T_ws_xuemai_info"..2)
        -- lualib:ShowNpcUi(actor, "LookWsBloodlineActiveOBJ", data1 .. "#"..data2 .. "#".. VarApi.getPlayerUIntVar(player,"U_main_xuemai").."#"..look_name)
        return
    elseif look_type == 6 then --#region 增幅
        local position_index={0,1,3,4,5,6,7,8,10,11}
        for index, position in ipairs(position_index) do
            sMsg[#sMsg+1]={VarApi.getPlayerUIntVar(player, "U_equipStar"..position)}
        end
        lualib:ShowNpcUi(actor, "EquipReinforce_LookOBJ", tbl2json(sMsg))
    elseif look_type == 7 then --#region 神魔
        local layer1 = VarApi.getPlayerUIntVar(player,"U_GodMagic1") --#region 神境界
        local layer2 = VarApi.getPlayerUIntVar(player,"U_GodMagic2") --#region 神境界
        if layer1==0 and layer2==0 then
            return Sendmsg9(actor, "ff0000", "玩家【"..look_name.."】还未晋升神魔真元！", 1)
        end
        lualib:ShowNpcUi(actor, "GodMagic_LookOBJ", layer1.."#"..layer2)
    elseif look_type == 8 then --#region 魔戒
        client_class_name = "MagicRing_LookOBJ"
    end
    for k, v in pairs(equip_index) do
        local equip = GetItemByPos(player, v)
        sMsg[k] = equip
    end
    if client_class_name then
        lualib:ShowNpcUi(actor, client_class_name, tbl2json(sMsg))
    end
end


function OtherSysFunc:onOpenMiniMap(actor)
    delbutton(actor, 8, 888)
    delbutton(actor, 8, 999)
    delbutton(actor, 8, 777)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    local ui_str = [[
        <Img|x=13|y=425|width=536|height=80|esc=0|img=public/bg_hhdb_01.jpg>
        <Img|x=80|y=433|esc=0|img=custom/npc/52minimap/a1.png>
        <Img|x=160|y=433|esc=0|img=custom/npc/52minimap/a2.png>
        <Img|x=240|y=433|esc=0|img=custom/npc/52minimap/a3.png>
        <Img|x=320|y=433|esc=0|img=custom/npc/52minimap/a4.png>
        <Img|x=400|y=433|esc=0|img=custom/npc/52minimap/a5.png>
        <RText|x=78|y=465|size=12|text=<绿色BOSS/FCOLOR=250>>
        <RText|x=158|y=465|size=12|text=<粉色BOSS/FCOLOR=253>>
        <RText|x=238|y=465|size=12|text=<金色BOSS/FCOLOR=243>>
        <RText|x=318|y=465|size=12|text=<红色BOSS/FCOLOR=249>>
        <RText|x=398|y=465|size=12|text=<橙色BOSS/FCOLOR=70>>
        <RText|x=85|y=480|size=13|text=<存活: %s/FCOLOR=250>>
        <RText|x=165|y=480|size=13|text=<存活: %s/FCOLOR=253>>
        <RText|x=245|y=480|size=13|text=<存活: %s/FCOLOR=243>>
        <RText|x=325|y=480|size=13|text=<存活: %s/FCOLOR=249>>
        <RText|x=405|y=480|size=13|text=<存活: %s/FCOLOR=70>>
    ]]
    if is_pc then
        ui_str = [[
            <Img|x=13|y=392|width=510|height=80|esc=0|img=public/bg_hhdb_01.jpg>
            <Img|x=80|y=400|esc=0|img=custom/npc/52minimap/a1.png>
            <Img|x=160|y=400|esc=0|img=custom/npc/52minimap/a2.png>
            <Img|x=240|y=400|esc=0|img=custom/npc/52minimap/a3.png>
            <Img|x=320|y=400|esc=0|img=custom/npc/52minimap/a4.png>
            <Img|x=400|y=400|esc=0|img=custom/npc/52minimap/a5.png>
            <RText|x=78|y=435|size=12|text=<绿色BOSS/FCOLOR=250>>
            <RText|x=158|y=435|size=12|text=<粉色BOSS/FCOLOR=253>>
            <RText|x=238|y=435|size=12|text=<金色BOSS/FCOLOR=243>>
            <RText|x=318|y=435|size=12|text=<红色BOSS/FCOLOR=249>>
            <RText|x=398|y=435|size=12|text=<橙色BOSS/FCOLOR=70>>
            <RText|x=85|y=450|size=13|text=<存活: %s/FCOLOR=250>>
            <RText|x=165|y=450|size=13|text=<存活: %s/FCOLOR=253>>
            <RText|x=245|y=450|size=13|text=<存活: %s/FCOLOR=243>>
            <RText|x=325|y=450|size=13|text=<存活: %s/FCOLOR=249>>
            <RText|x=405|y=450|size=13|text=<存活: %s/FCOLOR=70>>
        ]]
    end
    -- 1.绿色boss  2.粉色boss  3.金色boss  4.红色boss  5.橙色boss
    local counts = {0, 0, 0, 0, 0}
    local color_tab = {{250}, {253}, {243}, {249}, {70}}
    local mon_list = getmapmon(getbaseinfo(actor,3), "*", getbaseinfo(actor,4), getbaseinfo(actor,5), 1000)
    for _, mon in ipairs(mon_list or {}) do
        local color = getbaseinfo(mon, 56)
        for index, tab in ipairs(color_tab) do
            if isInTable(tab, color) then
                counts[index] = counts[index] + 1
            end
        end
    end
    ui_str = string.format(ui_str, unpack(counts, 1))
    addbutton(actor, 8, 777, ui_str)
    openhyperlink(actor, 24, 0)
end

function OtherSysFunc:onUseExpItem(actor, use_type, name)
    local all_state = VarApi.getPlayerUIntVar(actor, "U_all_use_exp_state")
    use_type = tonumber(use_type)
    local need_ybs = {100,1000,10000}
    local exp_item = {"100万经验珠","1000万经验珠","1亿经验珠"}
    if not isInTable({1, 2}, use_type) or not isInTable(exp_item, name) then
        Sendmsg9(actor, "ff0000", "无效参数!", 1)
        return
    end
    local count = getbagitemcount(actor, name, 0)
    if nil == count or count < 1 then
        Sendmsg9(actor, "ffffff", name .. "数量不足!", 9)
        return
    end
    local use_count = 1
    if all_state == 1 then
        use_count = count
    end

    local index = indexOfTable(exp_item, name)
    local need_value = need_ybs[index] * use_count
    local rate = 1
    if use_type == 2 then
        if getbindmoney(actor, "元宝") < need_value then
            Sendmsg9(actor, "ff0000", "元宝/绑定元宝数量不足!", 1)
            return
        end
        if not consumebindmoney(actor, "元宝", need_value, "双倍使用经验道具扣除!") then
            Sendmsg9(actor, "ff0000", "元宝扣除失败!", 1)
            return
        end
        rate = 2
    end

    if takeitem(actor, name, use_count, 0, "使用"..name) then
        local _const1 = string.format("<$GetDBItemFieldValue(%s,ITEMPAEAM1)>", name)
        local ret1 = getconst(actor, _const1)
        local tab = strsplit(ret1, "#")
        local value = (tonumber(tab[2]) or 0) * rate * use_count
        changeexp(actor, "+", value, false)
    end

    if name == "1亿经验珠" then
        for i = 1, use_count, 1 do
            local npc_class = IncludeMainClass("DailyActive")
            if npc_class then
                npc_class:UpdateActivePoint(actor, "100万经验珠")
            end
        end
    end
end
function OtherSysFunc:onChangeDoubleTipsState(actor, state)
    VarApi.setPlayerUIntVar(actor, "U_hide_double_tips", (tonumber(state) or 0), false)
end

function OtherSysFunc:onChangeAllState(actor, state)
    VarApi.setPlayerUIntVar(actor, "U_all_use_exp_state", (tonumber(state) or 0), false)
end

function OtherSysFunc:onUseMFBDItem(actor)
    local num = getbagitemcount(actor, "玛法宝典", 0)
    if num < 1 then
        Sendmsg9(actor, "ff0000", "玛法宝典数量不足!", 1)
        return
    end
    local items = getWeightedCfg(self.MFBDCfg[1].weight)
    local ret = weightedRandom(items)
    if not ret or ret.value == nil then
        return
    end
    local bag_num = getbagblank(actor)
    if bag_num < 8 then
        Sendmsg9(actor, "ffffff", "背包剩余空间不足!", 1)
        return
    end
    if takeitem(actor, "玛法宝典", 1, 0, "玛法宝典抽奖扣除!") then
        local index = ret.value
        lualib:FlushNpcUi(actor, "MaFaBaoDianOBJ", ret.value)
        local reward = self.MFBDCfg[1].name_arr[index]
        local count = self.MFBDCfg[1].num_arr[index]
        delaygoto(actor, 3000, "delay_give_reward,"..reward .. "#"..count, 0)

        -- local jackpot = GetSysStr("A_jackpot_ret")
        -- if nil == jackpot or "" == jackpot then
        --     jackpot = {}
        -- else
        --     jackpot = json2tbl(jackpot)
        -- end
        -- jackpot[#jackpot + 1] = getbaseinfo(actor, 1) .. "|" .. reward
        -- SetSysStr("A_jackpot_ret", tbl2json(jackpot))
    end
end
function delay_give_reward(actor, ret)
    Gives(actor, ret.."#370", "消耗玛法宝典活得道具")
    local tab = strsplit(ret, "#")
    Sendmsg9(actor, "00ff00", "恭喜获得 ["..tab[1] .. "*" .. tab[2].."]", 1)
    sendmsgnew(actor, 255, 0, string.format("恭喜: <『%s』/FCOLOR=254>在<玛法宝典抽奖/FCOLOR=251>中获得<[%s*%s]/FCOLOR=250>！", getbaseinfo(actor, 1), tab[1], tab[2]), 1, 2)
end

-- 领取新人礼包
function OtherSysFunc:onGetNewPlayerGift(actor)
    local task_state = VarApi.getPlayerUIntVar(actor, "U_task_step_info")
    if task_state > 0 then
        return
    end
    lualib:CloseNpcUi(actor, "NewPlayerGifeOBJ")
    TaskTrigger.CompleteTask(actor, 1)
    give_role_data(actor)
end

-- 激活特权
function OtherSysFunc:onActivation(actor, index)
    index = tonumber(index)
    if not isInTable({1,2,3}, index) then
        return
    end
    local v = self.PrivilegesCfg[index]
    if nil == v then
        return
    elseif VarApi.getPlayerUIntVar(actor,"U_superTitle"..index)>0 then
        return Sendmsg9(actor, "ff0000", v.givech.."称号已激活过!", 1)
    end
    local need_item = v.needitem
    local num = getbagitemcount(actor, need_item, 0)
    if num <= 0 then
        Sendmsg9(actor, "ff0000", need_item .. "数量不足!", 1)
        local sMsg = IncludeMainClass("WelfareHall"):getPageUiData(actor,6)
        lualib:ShowNpcUi(actor, "WelfareHallOBJ", sMsg .. "#6")
        return
    end
    if not takeitem(actor, need_item, 1, 0, "消耗特权激活卡激活特权") then
        Sendmsg9(actor, "ff0000", "扣除失败!", 1)
        return
    end
    local max_id = index
    for key, t in ipairs(self.PrivilegesCfg) do
        if checktitle(actor, t.givech) then
            max_id = key > max_id and key or max_id
        end
        deprivetitle(actor, t.givech)
    end
    local title = self.PrivilegesCfg[max_id]
    if title and not checktitle(actor, title.givech) then
        confertitle(actor, title.givech, 1)
    end
    local ret = ""
    for key, value in ipairs(v.giveitem_arr) do
        local count = v.itemnum_arr[key]
        ret = value .. "#" .. count .. "#370&" .. ret
    end
    local tips = "激活成功, 奖励以发放至邮箱,请及时领取!"
    VarApi.setPlayerUIntVar(actor,"U_superTitle"..v.key_name,1,true)
    if not checkkuafu(actor) then
        SendMail(actor, 1, v.givech, "恭喜你成功激活<"..v.givech.."/FCOLOR=250>, 奖励已发放至邮箱, 请及时领取!", ret)
    else
        Gives(actor, ret, "激活特权奖励!")
        tips = "激活成功, 奖励以发放"
    end
    Sendmsg9(actor, "00ff00", tips, 1)
    lualib:FlushNpcUi(actor,"SuperPrivilegesOBJ","refresh")
end

function OtherSysFunc:onDelBagItem(actor, makeIndex)
    local item_name = getiteminfo(actor, makeIndex, 7)
    if nil ~= item_name and "" ~= item_name then
        messagebox(actor, string.format("是否确定销毁 <font color='#00ff00'>[%s]</font> ，一经销毁，无法找回", item_name), "@on_sure_del_item,"..makeIndex..","..item_name, "@______")
    end
end
function on_sure_del_item(actor, makeIndex)
    local item_name = getiteminfo(actor, makeIndex, 7)
    local ret = delitembymakeindex(actor, makeIndex, nil, "准星删除物品!")
    if ret then
        Sendmsg9(actor, "ffffff", item_name .. "删除成功!", 1)
    else
        Sendmsg9(actor, "ff0000", "删除失败!", 1)
    end
end

function OtherSysFunc:onHideCollimator(actor)
    VarApi.setPlayerUIntVar(actor, "U_item_collimator", 0, true)
end

function OtherSysFunc:bubble_jump(actor,key_name)
    local cfg = OtherSysFunc.bubble_cfg[tonumber(key_name)]
    if cfg.jump_path then
        local class = nil
        if cfg.jump_path == "npc" then
            class = IncludeNpcClass(cfg.jump_view)
            if class and class[cfg.jump_fun] then
                class[cfg.jump_fun](class,actor,cfg.param1,cfg.param2,cfg.param3,cfg.param4)
            end
        elseif cfg.jump_path == "TaskTrigger" then
            TaskTrigger.onClickTask(actor,cfg.param1,cfg.param2,cfg.param3,cfg.param4)
        end
    end
end
return OtherSysFunc