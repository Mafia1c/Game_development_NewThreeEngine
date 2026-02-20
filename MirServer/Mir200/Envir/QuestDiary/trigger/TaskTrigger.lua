-- 任务系统
TaskTrigger = TaskTrigger or {}
-- 缓存玩家已经领取的任务id
TaskTrigger.TaskCache = TaskTrigger.TaskCache or {}
-- 任务系统  任务信息   变量  地图  杀怪数量  提示文本  标记
TaskTrigger.TaskInfo = {
    [1] = {tips = "领取豪礼"},
    [3] = {tips = "职业觉醒"},
    [4] = {tips = "天命符文"},
    [5] = {var = "U_srgm_kill_mon_count", map = {"兽人古墓", "兽王墓穴"}, killNum = 10, tips = "前往击杀", tag = false},
    [6] = {var = "U_jskq_kill_mon_count", map = {"僵尸矿区", "尸王领地"}, killNum = 20, tips = "前往击杀", tag = false},
    [7] = {tips = "特殊合成"},
    [8] = {var = "U_wgdx_kill_mon_count", map = {"蜈蚣洞穴", "死亡棺材"}, killNum = 20, tips = "前往击杀", tag = false},
    [9] = {tips = "生肖合成"},
    [10] = {tips = "官职晋升"},
    [11] = {var = "U_wmsm_kill_mon_count", map = {"沃玛寺庙", "沃玛神殿"}, killNum = 20, tips = "前往击杀", tag = false},
    [12] = {tips = "打野刀"},
    [13] = {tips = "转生轮回"},
    [14] = {var = "U_smzd_kill_mon_count", map = {"石墓猪洞", "石墓禁地"}, killNum = 30, tips = "前往击杀", tag = false},
    [15] = {tips = "技能强化"},
    [16] = {var = "U_zmsm_kill_mon_count", map = {"祖玛寺庙", "教主之家"}, killNum = 30, tips = "前往击杀", tag = false},
    [17] = {tips = "奇经八脉"},
    [18] = {var = "U_jzzd_kill_mon_count", map = {"抉择之地", "赤月巢穴"}, killNum = 30, tips = "前往击杀", tag = false},
    [19] = {tips = "福利大厅"},
    [20] = {tips = "首充礼包"},
    [21] = {tips = "盟重令"},
}
local _cfg = GetConfig("TaskInfoCfg")
local child_cfg = {}
local tmp_cfg = {}
for key, v in ipairs(_cfg) do
    tmp_cfg[v.taskid] = tmp_cfg[v.taskid] or {}
    tmp_cfg[v.taskid].equipid_arr = v.equipid_arr or tmp_cfg[v.taskid].equipid_arr
    tmp_cfg[v.taskid].reward_arr = v.give_arr or tmp_cfg[v.taskid].reward_arr
    tmp_cfg[v.taskid].rewardnum_arr = v.rewardnum_arr or tmp_cfg[v.taskid].rewardnum_arr
    tmp_cfg[v.taskid].needitem_map = v.needitem_map or tmp_cfg[v.taskid].needitem_map
    tmp_cfg[v.taskid].mapStr = v.taskcondition
    tmp_cfg[v.taskid].place_arr = v.place_arr or tmp_cfg[v.taskid].place_arr

    local info = v
    info.var = "U_kill_mon_"..v.childrenId
    info.map_ids = {}
    local maps = strsplit(v.taskcondition, "#")
    for index, value in ipairs(maps) do
        if "" ~= value then
            table.insert(info.map_ids, value)
        end
    end
    table.insert(tmp_cfg[v.taskid], info)
    child_cfg[v.childrenId] = info
end
TaskTrigger.NewTask = tmp_cfg
TaskTrigger.ChildTask = child_cfg
TaskTrigger.RewardCfg = GetConfig("TaskRewardCfg")
TaskTrigger.KillTips = {
    [250] = "<font color='#00ff00'>击杀绿色怪物 + 1</font>",
    [253] = "<font color='#9b00ff'>击杀粉色怪物 + 1</font>",
    [243] = "<font color='#ff9b00'>击杀金色怪物 + 1</font>",
}

-- 登录时接任务 初始化任务
function TaskTrigger.onLogin(actor, callback)
    TaskTrigger.TaskCache[actor] = TaskTrigger.TaskCache[actor] or {}

    if callback then
        callback()
    end
    local server_id = GetServerIDX()
    local task_state = VarApi.getPlayerUIntVar(actor, "U_task_step_info")
    local delay_time = 1000
    if task_state < 1 and server_id > 10000 then
        delay_time = 4500
    end
    delaygoto(actor, delay_time, "delay_pick_task", 0)
end

function delay_pick_task(actor)
    -- 主线任务
    local task_state = VarApi.getPlayerUIntVar(actor, "U_task_step_info")
    local main_task_id = task_state + 1
    if task_state == 21 then
        main_task_id = 1001
    end
    if main_task_id < 1037 then
        NewPickTask(actor, main_task_id)
    end

    -- 支线任务1
    local branch_line = VarApi.getPlayerUIntVar(actor, "U_task_branch_line")
    if branch_line >= 100000 then
        NewPickTask(actor, branch_line)
    end
    
    -- 每日历练任务
    if task_state >= 21 then
        NewPickTask(actor, 200100)
        UpdateTask(actor, 200100, 0)
    end
end

-- 进入而大陆时检查一下主线任务
function TaskTrigger.checkMainTask(actor)
    local task_state = VarApi.getPlayerUIntVar(actor, "U_task_step_info")
    local main_task_id = task_state + 1
    if task_state == 21 then
        main_task_id = 1001
    end
    if main_task_id < 1037 then
        NewPickTask(actor, main_task_id)
    end
end

-- 接取任务触发  显示任务引导
function TaskTrigger.onPickTask(actor, task_id)
    if task_id > 1000 then
        TaskTrigger.onUpdateTask(actor)
        return
    end
    local v = TaskTrigger.TaskInfo[task_id]
    if v then
        if v.killNum then
            local count = VarApi.getPlayerUIntVar(actor, v.var)
            UpdateTask(actor, task_id, count)
            if count >= v.killNum and not v.tag then
                v.tag = true
                navigation(actor, 110, task_id, "点击完成")
            else
                navigation(actor, 110, task_id, v.tips or "继续任务")
            end
        else
            navigation(actor, 110, task_id, v.tips or "继续任务")
        end
    else
        navigation(actor, 110, task_id, "继续任务")
    end
end

-- 点击任务触发 完成/前往完成
function TaskTrigger.onClickTask(actor, task_id)
    if not TaskTrigger.TaskCache[actor][task_id] then
        Sendmsg9(actor, "ff0000", "没有对应任务: "..task_id, 1)
        return
    end
    local map_id = getbaseinfo(actor, 3)
    
    if task_id > 1000 and task_id < 10000 then
        local npc_class = IncludeNpcClass("MaFaGuJiNpc")
        if npc_class then
            npc_class:onClickTask(actor, task_id)
        end
        return
    elseif task_id >= 200100 then
        local title_index = VarApi.getPlayerUIntVar(actor, "U_lilian_title_index")
        local value = VarApi.getPlayerUIntVar(actor, "U_lilian_reward")
        local today_value = VarApi.getPlayerJIntVar(actor, "J_lilian_reward_data")
        lualib:ShowNpcUi(actor, "MFExperienceOBJ", title_index .. "#"..value .. "#" .. today_value)
        local npc_class = IncludeNpcClass("MaFaGuJiNpc")
        if npc_class then
            npc_class:LoginCheckLiLianTitle(actor)
        end
    elseif task_id > 100000 then
        local cfg = TaskTrigger.ChildTask[task_id]
        local maps = strsplit(cfg.taskcondition, "#")
        if isInTable(maps, map_id) then
            Sendmsg9(actor, "ffffff", "你已经在<font color='#00ff00'>【任务地图】</font>，快去杀怪吧！", 1)
            return
        end
        local level = tonumber(getbaseinfo(actor, 6))
        local main_cfg = TaskTrigger.NewTask[cfg.taskid] or {}
        for name, value in pairs(main_cfg.needitem_map) do
            if value == 3 and level < 80 then
                Sendmsg9(actor, "ffffff", "80级后开放!", 1)
                return
            end
        end

        local target_map = nil
        for key, value in pairs(maps) do
            if "" ~= value then
                target_map = value
                break
            end
        end
        if target_map then
            local npc_class = IncludeNpcClass("MapMoveNpc")
            if npc_class then
                local id, v = npc_class:checkRecordNpcId(actor, target_map)
                local npc = getnpcbyindex(id)
                local npc_map = getbaseinfo(npc, 3)
                local mark_map = VarApi.getPlayerTStrVar(actor, "T_mark_maps")
                if "" == mark_map then
                    mark_map = {}
                else
                    mark_map = json2tbl(mark_map)
                end
                if isInTable(mark_map, npc_map.."") then
                    opennpcshowex(actor, id, 20, 2)
                else
                    Sendmsg9(actor, "ff0000", "传送失败, 你还未进入过该npc所在的地图!", 1)
                end
            end
        end
        return
    end

    local v = TaskTrigger.TaskInfo[task_id] or {}
    if isInTable(v.map or {}, map_id) then
        Sendmsg9(actor, "ffffff", "你已经在<font color='#00ff00'>【任务地图】</font>，快去杀怪吧！", 1)
        return
    end
    
    if task_id == 1 then
        lualib:ShowNpcUi(actor, "NewPlayerGifeOBJ", "")
        lualib:CallFuncByClient(actor, "navigation", "NewPlayerGifeOBJ#Button_1#点击领取#onGetNewGift")
    elseif task_id == 2 then
        opennpcshowex(actor, 1, 20, 2)
    elseif task_id == 3 then
        opennpcshowex(actor, 73, 20, 2)
    elseif task_id == 4 then
        openhyperlink(actor, 1, 1)
        delaygoto(actor, 300, "delay_navigation_task,202,10001,继续任务", 0)
    elseif task_id == 5 then
        local kill_count = VarApi.getPlayerUIntVar(actor, v.var)
        if kill_count >= v.killNum then
            CompleteTask(actor, 5)
        else
            opennpcshowex(actor, 2, 20, 2)
        end
    elseif task_id == 6 then
        local kill_count = VarApi.getPlayerUIntVar(actor, v.var)
        if kill_count >= v.killNum then
            CompleteTask(actor, 6)
        else
            opennpcshowex(actor, 3, 20, 2)
        end
    elseif task_id == 7 then
        opennpcshowex(actor, 64, 20, 2)
    elseif task_id == 8 then
        local kill_count = VarApi.getPlayerUIntVar(actor, v.var)
        if kill_count >= v.killNum then
            CompleteTask(actor, 8)
        else
            opennpcshowex(actor, 4, 20, 2)
        end
    elseif task_id == 9 then
        opennpcshowex(actor, 65, 20, 2)
    elseif task_id == 10 then
        opennpcshowex(actor, 66, 20, 2)
    elseif task_id == 11 then
        local kill_count = VarApi.getPlayerUIntVar(actor, v.var)
        if kill_count >= v.killNum then
            CompleteTask(actor, 11)
        else
            opennpcshowex(actor, 5, 20, 2)
        end
    elseif task_id == 12 then
        opennpcshowex(actor, 1032, 20, 2)
    elseif task_id == 13 then
        opennpcshowex(actor, 69, 20, 2)
    elseif task_id == 14 then
        local kill_count = VarApi.getPlayerUIntVar(actor, v.var)
        if kill_count >= v.killNum then
            CompleteTask(actor, 14)
        else
            opennpcshowex(actor, 6, 20, 2)
        end
    elseif task_id == 15 then
        opennpcshowex(actor, 70, 20, 2)
    elseif task_id == 16 then
        local kill_count = VarApi.getPlayerUIntVar(actor, v.var)
        if kill_count >= v.killNum then
            CompleteTask(actor, 16)
        else
            opennpcshowex(actor, 7, 20, 2)
        end
    elseif task_id == 17 then
        opennpcshowex(actor, 71, 20, 2)
    elseif task_id == 18 then
        local kill_count = VarApi.getPlayerUIntVar(actor, v.var)
        if kill_count >= v.killNum then
            CompleteTask(actor, 18)
        else
            opennpcshowex(actor, 8, 20, 2)
        end
    elseif task_id == 19 then
        local npc_class = IncludeMainClass("MainTopBtn")
        if npc_class then
            npc_class:WelfareHall(actor)
        end
    elseif task_id == 20 then
        local npc_class = IncludeMainClass("MainTopBtn")
        if npc_class then
            npc_class:FirstRechargeGift(actor)
        end
    elseif task_id == 21 then
        local npc_class = IncludeMainClass("MainTopBtn")
        if npc_class then
            npc_class:AllianceOrder(actor)
        end
    end
end

-- 刷新任务触发
function TaskTrigger.onChangeTask(actor, task_id)
    
end

-- 完成任务触发
function TaskTrigger.onCompleteTask(actor, task_id)
    if task_id < 1037 then
        VarApi.setPlayerUIntVar(actor, "U_task_step_info", task_id, true)       -- 主线
    end
    newdeletetask(actor, task_id)

    local main_new_id = task_id + 1
    if task_id == 21 then
        main_new_id = 1001
        NewPickTask(actor, 200100)
        UpdateTask(actor, 200100, 0)
    end
    if main_new_id < 1037 then
        NewPickTask(actor, main_new_id)
    end
end

-- 删除任务触发  发放任务奖励
function TaskTrigger.onDeleteTask(actor, task_id)
    TaskTrigger.TaskCache[actor][task_id] = nil
    if task_id == 1 then
        
    else
        local cfg = TaskTrigger.RewardCfg[task_id]
        if cfg then
            if cfg.item then
                Gives(actor, cfg.item, "完成任务获得!")
            else
                local job = getbaseinfo(actor, 7)
                local ret = cfg["job"..job]
                if ret then
                    Gives(actor, ret, "完成任务获得!")
                end
            end
            if task_id == 7 then
                ShowReward.showReward(actor, cfg.item, 3)
            end
        end
    end
    if VarApi.getPlayerUIntVar(actor, "U_task_branch_line") == task_id then
        VarApi.setPlayerUIntVar(actor, "U_task_branch_line", 0, false)
    end
    if task_id == 21 then
        GiveItem(actor, "100万经验珠", 1, 370, "完成新人引导任务赠送!")
    end

    -- 任务红点  不知道为什么删除任务的时候任务红点特效会暂停
    local red_id = GetTempInt(0, actor, "UTemp_task_red_id")
    if red_id > 0 then
        reddel(actor, 110, red_id)
        SetTempInt(0, actor, "UTemp_task_red_id", 0)
    end
    local red_id2 = GetTempInt(0, actor, "UTemp_lilian_task_red_id")
    if red_id2 > 0 then
        reddel(actor, 110, red_id2)
        SetTempInt(0, actor, "UTemp_lilian_task_red_id", 0)
    end
end

-- 检查是否有该任务
function TaskTrigger.CheckTask(actor, task_id)
    if nil == TaskTrigger.TaskCache[actor] then
        return false
    end
    return TaskTrigger.TaskCache[actor][task_id]
end

-- 完成某个任务
function TaskTrigger.CompleteTask(actor, task_id)
    if TaskTrigger.CheckTask(actor, task_id) then
        CompleteTask(actor, task_id)
    end
end

-- 刷新任务
function TaskTrigger.onUpdateTask(actor)
    local npc_class = IncludeNpcClass("MaFaGuJiNpc")
    for id, bool in pairs(TaskTrigger.TaskCache[actor] or {}) do
        local cfg = TaskTrigger.NewTask[id]
        if cfg and bool then
            for index, v in pairs(cfg) do
                if index == 1 or index == 2 or index == 3 then
                    if TaskTrigger.CheckTask(actor, v.childrenId) then
                        local state, value = false, 0
                        if npc_class then
                            state, value = npc_class:CheckTaskState(actor, id, index)
                        end
                        UpdateTask(actor, v.childrenId, value)
                    end
                end
            end
            if npc_class then
                local show_red = false
                local count = 0
                local data, state = npc_class:GetData(actor, id)
                for index, v in ipairs(state) do
                    if v > 0 then
                        count = count + 1
                    end
                    if v == 1 then
                        show_red = true
                    end
                end
                UpdateTask(actor, id, count)
                local red_id = GetTempInt(0, actor, "UTemp_task_red_id")
                if show_red or count >= 3 then
                    if red_id == 0 then
                        openhyperlink(actor, 110, 1)
                        reddot(actor, 110, id, 0, 0, 1, 16076)
                        SetTempInt(0, actor, "UTemp_task_red_id", id)
                    end
                else
                    if 0 ~= red_id then
                        reddel(actor, 110, id)
                        SetTempInt(0, actor, "UTemp_task_red_id", 0)
                    end
                end
            end
        end
        if id == 200100 then
            if npc_class then
                local add = npc_class:CheckRedData(actor)
                local red_id = GetTempInt(0, actor, "UTemp_lilian_task_red_id")
                if add then
                    if red_id >= 0 then
                        openhyperlink(actor, 110, 1)
                        reddot(actor, 110, id, 0, 0, 1, 16076)
                        SetTempInt(0, actor, "UTemp_lilian_task_red_id", 200100)
                    end
                else
                    if red_id ~= 0 then
                        reddel(actor, 110, id)
                        SetTempInt(0, actor, "UTemp_lilian_task_red_id", 0)
                    end
                end
            end
        end
    end
end

-- 任务 地图杀怪
function TaskTrigger.OnKillMon(actor, monObj, killerType, kill, monName, mapID)
    local color = getbaseinfo(monObj, 56)
    local tmp_complete = {}
    for key, b in pairs(TaskTrigger.TaskCache[actor] or {}) do
        local task = TaskTrigger.TaskInfo[key]
        if task and task.killNum and isInTable(task.map, mapID) then
            local state = GetTempInt(0, actor, "UTemp_task_"..key)
            local count = VarApi.getPlayerUIntVar(actor, task.var) + 1
            if count >= task.killNum and state == 0 then
                SetTempInt(0, actor, "UTemp_task_"..key, 1)
                tmp_complete[#tmp_complete + 1] = key
            else
                UpdateTask(actor, key, count)
            end
            VarApi.setPlayerUIntVar(actor, task.var, count, false)
        end
        
        local new = TaskTrigger.NewTask[key]
        if new and key < 10000 then
            local npc_class = IncludeNpcClass("MaFaGuJiNpc")
            for index, v in pairs(new) do
                if type(index) == "number" then
                    local is_get = npc_class and npc_class:CheckRewardGetState(actor, key, index) or false
                    local count = VarApi.getPlayerUIntVar(actor, v.var) + 1
                    if isInTable(v.map_ids, mapID) and color == v.color then
                        if count >= v.num then
                            count = v.num
                            if not is_get then
                                tmp_complete[#tmp_complete + 1] = v.childrenId
                            end
                        else
                            local tips = TaskTrigger.KillTips[color]
                            if tips then
                                Sendmsg9(actor, "ffffff", tips, 9)
                            end
                        end
                        VarApi.setPlayerUIntVar(actor, v.var, count, false)
                        break
                    end
                end
            end
        end
    end
    for index, value in ipairs(tmp_complete) do
        TaskTrigger.CompleteTask(actor, value)
    end

    if isInTable({250, 253, 249, 243}, color) then
        local npc_class = IncludeMainClass("DailyActive")
        if npc_class then
            npc_class:UpdateActivePoint(actor, color)
        end
    end
    if isInTable({255,250,253}, color) then
        local npc_class = IncludeMainClass("Cornucopia")
        if npc_class then
            npc_class:SetCornucopiaState(actor,2,color)
        end
    end
    if GetItemByPos(actor,106) ~= "0" then
        local cornucopia_class = IncludeMainClass("Cornucopia")
        if cornucopia_class then
            cornucopia_class:CornucopiaEquipAddMonry(actor,color)
        end
    end


    local npc_class = IncludeNpcClass("MaFaGuJiNpc")
    if npc_class then
        npc_class:UpdateLiLianData(actor, mapID)
    end
end

-- 延迟引导任务
function delay_navigation_task(actor, viewId, btnId, desc)
    viewId = tonumber(viewId)
    navigation(actor, viewId, btnId, desc or "继续任务")
end

-- 给予新人豪礼
function give_role_data(actor)
    local task_state = VarApi.getPlayerUIntVar(actor, "U_task_step_info")
    if task_state ~= 1 then
        return
    end
    local sex = tonumber(getbaseinfo(actor, 8))
    local equip_list = {{"打野刀",89},{"龙骨刀", 1}, {"龙骨盔", 4}, {"龙骨链", 3}, {"龙骨镯", 5}, {"龙骨镯", 6}, {"龙骨戒", 7}, {"龙骨戒", 8}, {"龙骨带", 10}, {"龙骨靴", 11}}
    if sex == 0 then
        equip_list[#equip_list + 1] = {"龙骨甲(男)", 0}
    else
        equip_list[#equip_list + 1] = {"龙骨甲(女)", 0}
    end
    for index, info in ipairs(equip_list) do
        local delay_time = (index - 1) * 100
        delaygoto(actor, delay_time, "on_delay_take_equip,"..info[1] .. "," .. info[2], 0)
    end
    if IncludeNpcClass("GodEquip") then --#region 打野刀进度条刀魂
        IncludeNpcClass("GodEquip"):changeExp(actor,0,0,100)
    end
    changelevel(actor, "=", 41)
    NewPickTask(actor, 2)
    addhpper(actor, "=", 100)
    addmpper(actor, "=", 100)
    VarApi.setPlayerUIntVar(actor, "U_auto_use_yb", 1, true)
    VarApi.setPlayerUIntVar(actor, "U_auto_use_exp", 1, true)
    VarApi.setPlayerUIntVar(actor, "U_auto_recycle", 1, true)
    local ret = "二级背包#1#370&自动拾取#1#370&自动回收#1#370&自动经验#1#370&自动货币#1#370&仓库全开#1#370&远程仓库#1#370&行会大礼包#1#370"
    local mail_str = "恭喜你，成功获得<【新人豪礼】/FCOLOR=250>请查收！\\<【自动拾取】/FCOLOR=253>　<【自动回收】/FCOLOR=249>　<【自动经验】/FCOLOR=242>　<【自动货币】/FCOLOR=254>\\<【仓库全开】/FCOLOR=244>　<【远程仓库】/FCOLOR=243>　<【二级背包】/FCOLOR=251>  <【行会大礼包】/FCOLOR=251>"
    SendMail(actor, 11911, "新人豪礼", mail_str, ret)

    local str =  "恭喜{[%s]/FCOLOR=254}成功领取{[新人豪礼]/FCOLOR=250}！"
    sendmsgnew(actor,255,0,string.format(str, getbaseinfo(actor, 1)),1,1)
end
function on_delay_take_equip(actor, name, index)
    GiveOnItem(actor, tonumber(index), name, 1, 0, "新人豪礼"..name)
end

-- ====================================================== API 封装 ==================================================================
-- 封装 新建任务
---@param actor string              玩家对象
---@param nId number                任务id
---@param ... string/number         参数1 - 10，
function NewPickTask(actor, nId , ...)
    if nId >= 1025 and nId < 1037 then
        local temp = VarApi.getPlayerUIntVar(actor,"U_bigMap")
        if temp < 2 then
            return
        end
    end

    local tab = {...}
    newpicktask(actor, nId, unpack(tab, 1))
    TaskTrigger.TaskCache[actor][nId] = true
end

-- 封装 刷新任务
---@param actor string              玩家对象
---@param nId number                任务id
---@param ... string/number         参数1 - 10，
function UpdateTask(actor, nId, ...)
    local tab = {...}
    newchangetask(actor, nId, unpack(tab, 1))
end

-- 封装  完成任务
---@param actor string          -- 玩家对象
---@param nId number            -- 任务ID
function CompleteTask(actor, nId)
    newcompletetask(actor,nId)
end

-- 封装   删除任务
---comment
---@param actor string          -- 玩家对象
---@param task_id number        -- 任务ID
function DelTask(actor, task_id)
    newdeletetask(actor, task_id)
end