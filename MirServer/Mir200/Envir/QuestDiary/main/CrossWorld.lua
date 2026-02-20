local CrossWorld = {}
CrossWorld.CrossMap = {
    {"G_cross_dfxg_state", "巅峰等待kf", 19, 18, 4},
    {"G_cross_wxzc_state", "无限战场kf"},
    {"G_cross_yyjl_state", "永夜降临1kf"},
    {"G_cross_emgc_state", "恶魔广场kf", 40, 40, 6},
}
CrossWorld.total_count = 0

function CrossWorld:onClickBtn(actor)
    local tmp_tab = {}
    for index, info in ipairs(self.CrossMap) do
        local value = GetSysInt(info[1])
        tmp_tab[#tmp_tab + 1] = value
    end
    lualib:ShowNpcUi(actor, "CrossWorldUI", tmp_tab)
end

function CrossWorld:onSelectCross(actor, index)
    index = tonumber(index)
    if not isInTable({1,2,3,4}, index) then
        return
    end
    if not kuafuconnected() then
        Sendmsg9(actor, "ff0000", "合区跨服开启可前往!", 1)
        return
    end
    
    local cfg = self.CrossMap[index]
    local state = GetSysInt(cfg[1])
    if state ~= 1 then
        Sendmsg9(actor, "ff0000", "活动未开启或已结束!", 1)
        return
    end
    lualib:CloseNpcUi(actor, "CrossWorldUI")
    lualib:CloseNpcUi(actor, "SelectCrossWorldOBJ")

    local map_id = cfg[2]

    if index == 1 then

    elseif index == 2 then

    elseif index == 3 then
        local enter = VarApi.getPlayerJIntVar(actor, "J_first_enter_yyzc")
        local survival_value = VarApi.getPlayerJIntVar(actor, "J_survival_value")
        local exploit_value = VarApi.getPlayerJIntVar(actor, "J_exploit_value")
        if enter == 0 then
            VarApi.setPlayerJIntVar(actor, "J_survival_value", 100, nil)
            VarApi.setPlayerJIntVar(actor, "J_exploit_value", 0, nil)
            VarApi.setPlayerJIntVar(actor, "J_first_enter_yyzc", 1, nil)
        else
            if survival_value <= 0 then
                Sendmsg9(actor, "ff0000", "<font color='#ff0000'>你已没有生存值了，无法进入活动场地！</font>", 1)
                return
            end
            if exploit_value >= 20 then
                map_id = "永夜降临4kf"
            elseif exploit_value >= 10 then
                map_id = "永夜降临3kf"
            elseif exploit_value >= 3 then
                map_id = "永夜降临2kf"
            else
                map_id = "永夜降临1kf"
            end
        end
    else
        local guild_obj = getmyguild(actor)
        if "0" == guild_obj then
            Sendmsg9(actor, "ff0000", "你未加入行会, 无法进入!", 1)
            return
        end
    end
    
    if #cfg > 2 then
        mapmove(actor, map_id, cfg[2], cfg[3], cfg[4])
    else
        map(actor, map_id)
    end
    local map_name = getmapname(map_id)
    OtherTrigger.TipsMsg(actor, map_name)
end
-- 巅峰峡谷
function CrossWorld:DFXGTaskUi(actor, index, id, time)
    if index == 1 then
        local txt = {[49] = "红方", [52] = "蓝方"}
        delbutton(actor, 110, "_654321")
        local remain_time = time or GetSysInt("G_dfxg_open_time") + 180 - os.time()
        local btn_str = [[
            <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4}|img=custom/npc/0kf/rwbg1.png>
            <RText|id=bg1|x=100|y=056|a=4|outline=2|color=255|size=18|text=阵营：{%s/FCOLOR=2%s}>
            <RText|id=bg2|x=078|y=092|a=4|outline=2|color=255|size=16|text=报名倒计时：>
            <COUNTDOWN|id=bg3|ay=0.5|x=122|y=092|size=16|count=1|outline=2|time=%s|color=250>
            <Button|id=bg4|x=100|y=150|a=4|nimg=custom/npc/0kf/ex.png|link=@_on_exit_wait_map,0>
        ]]
        btn_str = string.format(btn_str, txt[id], id, remain_time)
        addbutton(actor, 110, "_654321", btn_str)
    end
end
-- 无限战场
function CrossWorld:WXZCTaskUi(actor)
    delbutton(actor, 110, "_654321")
    local btn_str = [[
        <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4}|img=custom/npc/0kf/rwbg2.png>
        <RText|id=bg1|x=100|y=082|a=4|outline=2|color=243|size=18|text=杀戮值：{<$STR(J_killing_value)>/FCOLOR=250}>
        <Button|id=bg2|x=140|y=150|a=4|nimg=custom/npc/0kf/pm.png|link=@_kf_wxzc_rank>
        <Button|id=bg3|x=060|y=150|a=4|nimg=custom/npc/0kf/ex.png|link=@_on_exit_wait_map,1>
    ]]
    VarApi.setPlayerTStrVar(actor, "T_task_ui_txt", btn_str, false)
    btn_str = parsetext(btn_str, actor)
    addbutton(actor, 110, "_654321", btn_str)
end
-- 永夜降临
function CrossWorld:YYJLTaskUi(actor, map)
    local map_id = getbaseinfo(actor, 3)
    delbutton(actor, 110, "_654321")
    local btn_str = [[
        <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4}|img=custom/npc/0kf/rwbg3.png>
        <RText|id=bg1|x=100|y=056|a=4|outline=2|color=243|size=18|text=生存值：{<$STR(J_survival_value)>/FCOLOR=250}>
        <RText|id=bg2|x=100|y=092|a=4|outline=2|color=243|size=18|text=功勋值：{<$STR(J_exploit_value)>/FCOLOR=250}>
        <Button|id=bg3|x=140|y=150|a=4|nimg=custom/npc/0kf/xc.png|link=@_goto_next_level>
        <Button|id=bg3|x=060|y=150|a=4|nimg=custom/npc/0kf/ex.png|link=@_on_exit_wait_map,1>
    ]]
    if map_id == "永夜降临4kf" or map == "永夜降临4kf" then
        btn_str = [[
            <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4}|img=custom/npc/0kf/rwbg3.png>
            <RText|id=bg1|x=100|y=056|a=4|outline=2|color=243|size=18|text=生存值：{<$STR(J_survival_value)>/FCOLOR=250}>
            <RText|id=bg2|x=100|y=092|a=4|outline=2|color=243|size=18|text=功勋值：{<$STR(J_exploit_value)>/FCOLOR=250}>
            <Button|id=bg3|x=140|y=150|a=4|nimg=custom/npc/0kf/lq.png|link=@_on_yyjl_get_reward>
            <Button|id=bg4|x=060|y=150|a=4|nimg=custom/npc/0kf/ex.png|link=@_on_exit_wait_map,1>
        ]]
    end
    VarApi.setPlayerTStrVar(actor, "T_task_ui_txt", btn_str, false)
    addbutton(actor, 110, "_654321", parsetext(btn_str, actor))
end

-- 退出跨服
function _on_exit_wait_map(actor, exit_type)
    exit_type = tonumber(exit_type)
    if exit_type == 0 then
        messagebox(actor, "报名时间结束，活动立即开始！\\你确定要退出等待地图吗？\\退出将会错过本次活动哦？", "@_on_exit_wait_map,1", "@______")
    else
        mapmove(actor, 3, 322, 332, 5)
        JoinNation(actor, 0)
    end
end
-- 无限战场排名
function _kf_wxzc_rank(actor)
    close(actor)
    KuaFuTrigger.WXZC_Rank(actor)
end
-- 永夜降临传送到下一层
function _goto_next_level(actor)
    local map_id = getbaseinfo(actor, 3)
    if not checkkuafu(actor) then
        return
    end
    local tips = nil
    if map_id == "永夜降临1kf" then
        tips = "功勋值达到<font color='#ff0000'>【3点】</font>自动传送到二层，击杀<font color='#00ff00'>【冥界之花】</font>获得<font color='#00ff00'>【1功勋值】</font>！"
    end
    if map_id == "永夜降临2kf" then
        tips = "功勋值达到<font color='#ff0000'>【10点】</font>自动传送到三层，击杀<font color='#00ff00'>【冥界之花】</font>获得<font color='#00ff00'>【1功勋值】</font>！"
    end
    if map_id == "永夜降临3kf" then
        tips = "功勋值达到<font color='#ff0000'>【20点】</font>自动传送到四层，击杀<font color='#00ff00'>【冥界之花】</font>获得<font color='#00ff00'>【1功勋值】</font>！"
    end
    if tips then
        Sendmsg9(actor, "ffffff", tips, 1)
    end
end
-- 永夜降临领奖
function _on_yyjl_get_reward(actor)
    local map_id = getbaseinfo(actor, 3)
    if not checkkuafu(actor) then
        return
    end
    if not isTimeAfter(21,25,0) then
        Sendmsg9(actor, "ff0000", "请等待活动入口关闭之后，才能领奖！", 1)
        return
    end
    if map_id ~= "永夜降临4kf" then
        return
    end
    local get_play_name = GetSysTLStr("At_yyjl_reward")
    if get_play_name ~= "" then
        local str = string.format("<font color='#ff0000'>活动奖励已被【%s】领取！</font>", get_play_name)
        Sendmsg9(actor, "ffffff", str, 1)
        return
    end
    local play_count = getplaycountinmap(actor, "永夜降临4kf", 0)
    if play_count > 1 then
        Sendmsg9(actor, "ffffff", "<font color='#ff0000'>地图内还有其他玩家，请先将他们清理出去！</font>", 1)
        return
    end
    local name = getbaseinfo(actor, 1)
    SetSysTLStr("At_yyjl_reward", name, GetDayTick() + 86400)
    KuaFuTrigger.kfbackcall(actor, "永夜降临领奖", name)
    delaygoto(actor, 3000, "go_back_tucheng", 1)
end

function go_back_tucheng(actor)
    mapmove(actor, "3", 322, 333, 3)
end

return CrossWorld