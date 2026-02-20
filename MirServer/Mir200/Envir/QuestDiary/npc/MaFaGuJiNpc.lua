local MaFaGuJiNpc = {}
MaFaGuJiNpc.TaskCfg = TaskTrigger.NewTask
local _cfg = GetConfig("MaFaLiLianCfg")
MaFaGuJiNpc.LiLianCfg = _cfg
local tmp_cfg = {}
for index, v in ipairs(_cfg) do
    for key, map_id in pairs(v.taskcondition_arr) do
        tmp_cfg[map_id] = v
    end
end
MaFaGuJiNpc.MapCfg = tmp_cfg

function MaFaGuJiNpc:onClickTask(actor, task_id)
    local data, state = self:GetData(actor, task_id)
    data = tbl2json(data)
    state = tbl2json(state)
    local task = VarApi.getPlayerUIntVar(actor, "U_mfgj_reward_id")
    lualib:ShowNpcUi(actor, "MaFaGuJiOBJ", task_id .. "#" .. data .. "#" .. state .. "#" .. task)
end

function MaFaGuJiNpc:onGoToComplete(actor, id, index)
    id = tonumber(id)
    index = tonumber(index)
    if not TaskTrigger.CheckTask(actor, id) then
        Sendmsg9(actor, "ff0000", "你没有对应任务!", 1)
        return
    end
    local cfg = self.TaskCfg[id]
    if nil == cfg or nil == cfg[index] then
        return
    end
    local is_complete = self:CheckTaskState(actor, id, index)
    cfg = cfg[index]
    local child_task_id = cfg.childrenId
    if cfg.tasktype == 4 then
        child_task_id = child_task_id + getbaseinfo(actor, 7)
    end
    if is_complete then
        self:GiveReward(actor, id, index)
    else
        lualib:CloseNpcUi(actor, "MaFaGuJiOBJ")
        if TaskTrigger.CheckTask(actor, child_task_id) then
            TaskTrigger.onClickTask(actor, child_task_id)
            return
        end
        local branch_line = VarApi.getPlayerUIntVar(actor, "U_task_branch_line")
        if branch_line then
            DelTask(actor, branch_line)
        end
        NewPickTask(actor, child_task_id)
        VarApi.setPlayerUIntVar(actor, "U_task_branch_line", child_task_id, false)
        TaskTrigger.onClickTask(actor, child_task_id)
    end
    self:onUpdateUi(actor, id)
end

function oncompletetask(actor, id, give)
    id = tonumber(id)
    local npc_class = IncludeNpcClass("MaFaGuJiNpc")
    if nil == npc_class then
        return
    end
    local cfg = npc_class.TaskCfg[id]
    if not TaskTrigger.CheckTask(actor, id) or nil == cfg then
        Sendmsg9(actor, "ff0000", "你没有对应任务!", 1)
        return
    end
    local blank_num = getbagblank(actor)
    if blank_num < 9 then
        Sendmsg9(actor, "ffffff", "背包空间不足!", 9)
        return
    end
    if not give then
        for name, value in pairs(cfg.needitem_map) do
            if not takeitem(actor, name, value, 0, "") then
                Sendmsg9(actor, "ff0000", "扣除 "..name .. " 失败", 1)
                return
            end
        end
    end

    for i = 1, 3, 1 do
        npc_class:GiveReward(actor, id, i)
    end

    for key, value in ipairs(cfg.reward_arr) do
        local count = cfg.rewardnum_arr[key]
        if key == 1 then
            for i = 1, count, 1 do
                delbodyitem(actor, cfg.place_arr[i], "删除玛法任务老装备!")
                GiveOnItem(actor, cfg.place_arr[i], value, 1, 370, "完成玛法古纪任务给与装备!")
            end
        elseif key == 2 then
            Gives(actor, value.."#"..count .. "#370", "完成玛法古纪任务!")
        else
            return
        end
    end
    VarApi.setPlayerUIntVar(actor, "U_mfgj_reward_id", id, false)
    TaskTrigger.CompleteTask(actor, id)
    npc_class:onUpdateUi(actor, id + 1)
end

function MaFaGuJiNpc:onGetReward(actor, id)
    id = tonumber(id)
    local cfg = self.TaskCfg[id]
    if not TaskTrigger.CheckTask(actor, id) or nil == cfg or nil == id then
        Sendmsg9(actor, "ff0000", "你没有对应任务!", 1)
        return
    end
    local task = VarApi.getPlayerUIntVar(actor, "U_mfgj_reward_id")
    if id <= task then
        Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
        return
    end
    -- 检测等级  装备佩戴   打怪进度    图鉴进度    其他变量
    local is_give_reward = true                             -- 是否可以发放对应奖励
    local is_need_item = false                              -- 消耗道具跳过
    for i = 1, 3, 1 do
        local is_complete = self:CheckTaskState(actor, id, i)
        if not is_complete then
            is_need_item = true
            is_give_reward = false
            break
        end
    end
    if is_need_item then
        local need_value = 1
        for name, value in pairs(cfg.needitem_map) do
            local num = getbagitemcount(actor, name, 0)
            need_value = value
            if num < value then
                is_give_reward = false
                Sendmsg9(actor, "ffffff", "请先完成上面三个任务!", 1)
                return
            end
        end
        messagebox(actor, string.format("确定要消耗 [古纪卷轴*%s] 直接完成当前任务吗?", need_value), "@oncompletetask,"..id, "@______")
    else
        if is_give_reward and not is_need_item then
            local data, state = self:GetData(actor, id)
            for index, value in ipairs(state) do
                if value ~= 2 then
                    Sendmsg9(actor, "ffffff", "请先领取上面任务 [" .. index .. "] 的奖励!", 1)
                    return
                end
            end
            oncompletetask(actor, id, true)
        else
            Sendmsg9(actor, "ffffff", "请先完成上面三个任务!", 1)
        end
    end
end

function MaFaGuJiNpc:CheckTaskState(actor, task_id, index)
    local cfg = self.TaskCfg[task_id]
    if nil == cfg or nil == cfg[index] or task_id <= 1000 then
        return false
    end
    local v = cfg[index]
    local value = VarApi.getPlayerUIntVar(actor, v.var)
    return value >= v.num, value
end

function MaFaGuJiNpc:GetData(actor, task_id)
    local data = {0,0,0}
    local state = {0,0,0}
    local info = self.TaskCfg[task_id]
    if nil == info then
        return data, state
    end

    for index, v in pairs(info) do
        if index == 1 or index == 2 or index == 3 then
            local value = VarApi.getPlayerUIntVar(actor, v.var)
            local tag = 0
            data[index] = value

            tag = value >= v.num and 1 or 0
            local is_get = self:CheckRewardGetState(actor, task_id, index)      -- 已领取
            if is_get then
                tag = 2
            end
            state[index] = tag
        end
    end

    return data, state
end

function MaFaGuJiNpc:CheckRewardGetState(actor, task_id, index)
    local key = tostring(task_id)
    local str = VarApi.getPlayerTStrVar(actor, "T_mfgj_reward")
    if "" == str then
        str = {}
    else
        str = json2tblex(str)
    end
    if nil == str[key] then
        str[key] = {}
    end
    return isInTable(str[key], index)
end

function MaFaGuJiNpc:GiveReward(actor, task_id, index)
    local cfg = self.TaskCfg[task_id]
    if nil == cfg or nil == cfg[index] then
        return
    end
    local key = tostring(task_id)
    local str = VarApi.getPlayerTStrVar(actor, "T_mfgj_reward")
    if "" == str then
        str = {}
    else
        str = json2tblex(str)
    end
    if nil == str[key] then
        str[key] = {}
    end
    if isInTable(str[key], index) then
        -- release_print("已经领取过了 ***", key, index)
        return
    end
    table.insert(str[key], index)

    VarApi.setPlayerTStrVar(actor, "T_mfgj_reward", tbl2jsonex(str), false)
    local ret = ""
    for i, value in pairs(cfg[index].taskitem_arr) do
        local count = cfg[index].itemnum_arr[i]
        ret = value .. "#" .. count .. "#370&"..ret
    end
    Gives(actor, ret, "完成玛法古纪任务获得 [" .. key .. "]")

    local child_task_id = 0
    local tmp = cfg[index]
    if tmp then
        child_task_id = tmp.childrenId
    end
    TaskTrigger.CompleteTask(actor, child_task_id)
end

function MaFaGuJiNpc:onUpdateUi(actor, task_id)
    if task_id > 1036 then
        task_id = 1036
    end
    local data, state = self:GetData(actor, task_id)
    data = tbl2json(data)
    state = tbl2json(state)
    local task = VarApi.getPlayerUIntVar(actor, "U_mfgj_reward_id")
    lualib:FlushNpcUi(actor, "MaFaGuJiOBJ", task_id .. "#" .. data .. "#" .. state .. "#" .. task)
end


-- ====================== 玛法历练 =============================
function MaFaGuJiNpc:onGoToKillMon(actor, index)
    if not TaskTrigger.CheckTask(actor, 200100) then
        return
    end
    local my_map = getbaseinfo(actor, 3)
    index = tonumber(index)
    local v = self.LiLianCfg[index]
    if nil == v then
        return
    end
    local temp = VarApi.getPlayerUIntVar(actor,"U_bigMap")
    if v.mapid == "bairi" then
        if temp < 2 then
            Sendmsg9(actor, "ff0000", "你还未探索过该大陆!", 1)
            return
        end
    end
    local value = VarApi.getPlayerUIntVar(actor, "U_lilian_reward")
    local tab = BitMgr.NumToTab(value)
    local count = VarApi.getPlayerJIntVar(actor, "J_lilian_kill_"..v.key_name)
    local today_value = VarApi.getPlayerJIntVar(actor, "J_lilian_reward_data")
    local t_tab = BitMgr.NumToTab(today_value)
    local item_name = v.firstreward_arr[1]
    local num = v.firstreward_arr[2]
    local kill_num = v.num
    if tab[index] == 1 then
        item_name = v.dailyreward_arr[1]
        num = v.dailyreward_arr[2]
        kill_num = v.nextnum
    end
    if t_tab[index] == 1 then
        Sendmsg9(actor, "ff0000", "今日已领取当前历练奖励, 请勿重复领取!", 1)
        return
    end
    if count >= kill_num then
        tab[index] = 1
        value = BitMgr.TabToNum(tab)
        VarApi.setPlayerUIntVar(actor, "U_lilian_reward", value, false)
        t_tab[index] = 1
        today_value = BitMgr.TabToNum(t_tab)
        VarApi.setPlayerJIntVar(actor, "J_lilian_reward_data", today_value, nil)
        gives(actor, item_name.."#"..num, "完成每日历练任务获得")
        Sendmsg9(actor, "00ff00", string.format("恭喜完成今日[%s]地图历练任务", v.mapname), 9)
        self:FlushLiLianView(actor)
        return
    end
    if isInTable(v.taskcondition_arr, my_map) then
        Sendmsg9(actor, "ffffff", "你已经在<font color='#00ff00'>【任务地图】</font>，快去杀怪吧！", 1)
        return
    end
    local target_map = v.mapname
    if target_map then
        local npc_class = IncludeNpcClass("MapMoveNpc")
        if npc_class then
            local id, v1 = npc_class:checkRecordNpcId(actor, target_map)
            if nil == id then
                id, v1 = npc_class:checkRecordNpcId(actor, v.taskcondition_arr[1])
            end
            local mark_map = VarApi.getPlayerTStrVar(actor, "T_mark_maps")
            if "" == mark_map then
                mark_map = {}
            else
                mark_map = json2tbl(mark_map)
            end
            if isInTable(mark_map, v.mapid.."") then
                opennpcshowex(actor, id, 20, 2)
            else
                Sendmsg9(actor, "ff0000", "传送失败, 当前不满足该地图进入条件!", 1)
            end
        end
    end
    lualib:CloseNpcUi(actor, "MFExperienceOBJ")
end

function MaFaGuJiNpc:onChangeTitle(actor, index)
    if not TaskTrigger.CheckTask(actor, 200100) then
        return
    end
    index = tonumber(index)
    local title_index = VarApi.getPlayerUIntVar(actor, "U_lilian_title_index")
    if title_index >= #self.LiLianCfg then
        Sendmsg9(actor, "00ff00", "该系列称号已全部激活!", 9)
       return 
    end
    local v = self.LiLianCfg[index]
    if nil == v then
        return
    end
    local value = querymoney(actor, 25)
    if value < v.neednum then
        Sendmsg9(actor, "ff0000", "历练值不足!", 1)
        return
    end
    local old = self.LiLianCfg[title_index]
    if title_index >= #self.LiLianCfg or title_index >= index then
        Sendmsg9(actor, "ffffff", "当前没有可激活称号或已全部激活!", 1)
        return
    end
    if title_index > 0 and old then
        deprivetitle(actor, old.chreward)
    end
    confertitle(actor, v.chreward, 1)
    Sendmsg9(actor, "00ff00", "[" .. v.chreward .. "] 激活成功", 9)
    VarApi.setPlayerUIntVar(actor, "U_lilian_title_index", index, true)
    self:FlushLiLianView(actor)
end

function MaFaGuJiNpc:LoginCheckLiLianTitle(actor)
    local title_index = VarApi.getPlayerUIntVar(actor, "U_lilian_title_index")
    for index, v in ipairs(self.LiLianCfg) do
        if index < title_index then
            if checktitle(actor, v.chreward) then
                deprivetitle(actor, v.chreward)
            end
        end
    end
end

function MaFaGuJiNpc:CheckRedData(actor)
    local today_value = VarApi.getPlayerJIntVar(actor, "J_lilian_reward_data")
    local t_tab = BitMgr.NumToTab(today_value)
    local value = VarApi.getPlayerUIntVar(actor, "U_lilian_reward")
    local tab = BitMgr.NumToTab(value)
    for index, v in ipairs(self.LiLianCfg) do
        local count = VarApi.getPlayerJIntVar(actor, "J_lilian_kill_"..v.key_name)
        local num = v.num
        if tab[index] == 1 then
            num = v.nextnum
        end
        if count >= num and t_tab[index] == 0 then
            return true
        end
    end

    local lilian_value = tonumber(querymoney(actor, 25))
    local title_index = VarApi.getPlayerUIntVar(actor, "U_lilian_title_index")
    local v = self.LiLianCfg[title_index + 1]
    if v then
        if lilian_value >= v.neednum then
            return true
        end
    end
    return false
end

function MaFaGuJiNpc:UpdateLiLianData(actor, map_id)
    if not TaskTrigger.CheckTask(actor, 200100) then
        return
    end
    local v = self.MapCfg[map_id]
    if v ~= nil then
        local value = VarApi.getPlayerUIntVar(actor, "U_lilian_reward")
        local tab = BitMgr.NumToTab(value)
        local num = v.num
        if tab[v.key_name] == 1 then
            num = v.nextnum
        end
        local count = VarApi.getPlayerJIntVar(actor, "J_lilian_kill_"..v.key_name) + 1
        if count >= num then
            count = num
        end
        VarApi.setPlayerJIntVar(actor, "J_lilian_kill_"..v.key_name, count, nil, true)
    end
end

function MaFaGuJiNpc:FlushLiLianView(actor)
    local title_index = VarApi.getPlayerUIntVar(actor, "U_lilian_title_index")
    local value = VarApi.getPlayerUIntVar(actor, "U_lilian_reward")
    local today_value = VarApi.getPlayerJIntVar(actor, "J_lilian_reward_data")
    lualib:FlushNpcUi(actor, "MFExperienceOBJ", title_index .. "#" .. value .. "#" .. today_value)
end

return MaFaGuJiNpc