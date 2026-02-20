local AbyssCaveNpc = {}
AbyssCaveNpc.cfg = GetConfig("AbyssCaveCfg")

function AbyssCaveNpc:click(actor)
    if CheckOpenState(actor, 1) then return end
    local sMsg = self:getUiData(actor)
    lualib:ShowNpcUi(actor, "AbyssCaveOBJ", sMsg)
end

function AbyssCaveNpc:onEnterMap(actor)
    if getbaseinfo(actor, 3) ~= "bairi" then
        return
    end
    if CheckOpenState(actor, 1) then return end
    lualib:CloseNpcUi(actor, "AbyssCaveOBJ")
    map(actor, "深渊秘境")
end

function AbyssCaveNpc:onGetReward(actor, index)
    if CheckOpenState(actor, 1) then return end
    index = tonumber(index)
    if not isInTable({1,2,3}, index) then
        return
    end
    local times = VarApi.getPlayerJIntVar(actor, "J_clearance_times")
    local cfg = self.cfg[index + 5]
    if nil == cfg then
        return
    end
    if times < cfg.time then
        Sendmsg9(actor, "ff0000", "今日累计通关次数不足 "..cfg.time .. "次", 1)
        return
    end
    local reward = VarApi.getPlayerZStrVar(actor, "Z_clearance_reward")
    if "" == reward then
        reward = {0, 0, 0}
    else
        reward = json2tbl(reward)
    end
    if reward[index] == 1 then
        Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
        return
    end
    reward[index] = 1
    VarApi.setPlayerZStrVar(actor, "Z_clearance_reward", tbl2json(reward), nil)
    GiveItem(actor, cfg.giveitem1, cfg.itemnum1, 307, "领取深渊秘境通关"..cfg.time .. "次奖励!")
    local sMsg = self:getUiData(actor)
    lualib:FlushNpcUi(actor, "AbyssCaveOBJ", sMsg)
    Sendmsg9(actor, "00ff00", string.format("成功领取通关深渊秘境【%s次】奖励: %sx"..cfg.itemnum1, cfg.time, cfg.giveitem1), 1)
    local str =  "深渊秘境：玩家{「%s」/FCOLOR=251}通关次数达到{【%s次】/FCOLOR=250}，获得奖励{「%s×%s」/FCOLOR=253}！"
    sendmsgnew(actor, 255, 0, string.format(str, getbaseinfo(actor,1), cfg.time, cfg.giveitem1, cfg.itemnum1), 1, 2)
end


function AbyssCaveNpc:getUiData(actor)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    local myPoint = VarApi.getPlayerJIntVar(actor, "J_fatigue_value")
    local remain_value = 100 - myPoint
    if mzl_state > 0 then
        remain_value = 200 - myPoint
    end
    local num = VarApi.getPlayerJIntVar(actor, "J_clearance_times")
    local sMsg1 = tbl2json({remain_value, num})
    local sMsg2 = VarApi.getPlayerZStrVar(actor, "Z_clearance_reward")
    if "" == sMsg2 then
        sMsg2 = {0, 0, 0}
        sMsg2 = tbl2json(sMsg2)
    end
    return sMsg1 .. "#" .. sMsg2
end

return AbyssCaveNpc