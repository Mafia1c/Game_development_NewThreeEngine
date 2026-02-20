local FengMoJieJieNpc = {}
FengMoJieJieNpc.cfg = GetConfig("FengMoJieJieCfg")

function FengMoJieJieNpc:click(actor)
    if CheckOpenState(actor, 1) then return end
    local sMsg = self:getUiData(actor)
    lualib:ShowNpcUi(actor, "FengMoJieJieOBJ", sMsg)
end

function FengMoJieJieNpc:onMapMove(actor, index)
    if CheckOpenState(actor, 1) then return end
    index = tonumber(index)
    if getbaseinfo(actor, 3) ~= "bairi" then
        return
    end
    local _cfg = self.cfg[index]
    if nil == _cfg then
        return
    end
    if index ~= 1 and not kuafuconnected() then
        Sendmsg9(actor, "ffffff", "跨服服务器未连接!", 1)
        return
    end
    -- local myNum = VarApi.getPlayerJIntVar(actor, "J_launch_count")
    -- if myNum < 3 then
    --     Sendmsg9(actor, "ff0000", "投放三次即可进入!", 1)
    --     return
    -- end
    local num = getbagitemcount(actor, _cfg.needvar_arr[1], 0)
    if num < _cfg.needvar_arr[2] then
        Sendmsg9(actor, "ff0000", "帝王印记数量不足!", 1)
        return
    end
    if not takeitem(actor, _cfg.needvar_arr[1], _cfg.needvar_arr[2], 0, "进入地图 ".._cfg.mapid .. " 扣除!") then
        Sendmsg9(actor, "ff0000", "帝王印记扣除失败", 1)
        return
    end
    lualib:CloseNpcUi(actor, "FengMoJieJieOBJ")
    map(actor, _cfg.mapid)

    local map_name = getmapname(_cfg.mapid)
    OtherTrigger.TipsMsg(actor, map_name)
end

function FengMoJieJieNpc:onLaunchItem(actor)
    if CheckOpenState(actor, 1) then return end
    if getbaseinfo(actor, 3) ~= "bairi" then
        return
    end
    local _cfg = self.cfg[3]
    local num = getbagitemcount(actor, _cfg.needitem, 0)
    if num < _cfg.itemnum then
        Sendmsg9(actor, "ff0000", "需要 ".._cfg.needitem .. "*".._cfg.itemnum, 1)
        return
    end
    if takeitem(actor, _cfg.needitem, _cfg.itemnum, 0, "仙石投放!") then
        GiveItem(actor, _cfg.giveitem, _cfg.num, 370, "投放仙石赠与!")
        local total = GetSysInt("G_launch_count")
        total = total + 1
        if total >= 999 then
            _cfg = self.cfg[7]
            genmon(_cfg.mapid, 199, 203, _cfg.mobmon, 0, 1, 249)

            for i = 1, 3 do
                sendmovemsg("0", 0, 255, 0, 60 + (i - 1 ) * 30, 1, "<【永夜帝王·米尔迦兰】/FCOLOR=254>降临<【结界之地】/FCOLOR=253>各位勇士速速前往击杀！")
            end
            total = 0
        end
        SetSysInt("G_launch_count", total)
        local myNum = VarApi.getPlayerJIntVar(actor, "J_launch_count")
        myNum = myNum + 1
        VarApi.setPlayerJIntVar(actor, "J_launch_count", myNum, nil)

        Sendmsg9(actor, "00ff00", "成功投入 [仙石*10] 获得 [帝王印记*1]", 1)
    end
    local sMsg = self:getUiData(actor)
    lualib:FlushNpcUi(actor, "FengMoJieJieOBJ", sMsg)
end

function FengMoJieJieNpc:onGetReward(actor, index)
    if CheckOpenState(actor, 1) then return end
    index = tonumber(index)
    local tab = {[1] = 10, [2] = 20, [3] = 30}
    local num = tab[index]
    if nil == num then
        return
    end
    local myNum = VarApi.getPlayerJIntVar(actor, "J_launch_count")
    if myNum < num then
        Sendmsg9(actor, "ff0000", "当前投放次数不足!", 1)
        return
    end
    local sMsg2 = VarApi.getPlayerZStrVar(actor, "Z_get_state")
    if "" == sMsg2 then
        sMsg2 = {0, 0, 0}
    else
        sMsg2 = json2tbl(sMsg2)
    end
    if sMsg2[index] == 1 then
        Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
        return
    end
    sMsg2[index] = 1
    VarApi.setPlayerZStrVar(actor, "Z_get_state", tbl2json(sMsg2), nil)
    local _cfg = self.cfg[index + 3]
    GiveItem(actor, _cfg.giveitem, _cfg.num, 370, "领取投放仙石奖励!")
    local sMsg = self:getUiData(actor)
    lualib:FlushNpcUi(actor, "FengMoJieJieOBJ", sMsg)
    Sendmsg9(actor, "00ff00", string.format("成功领取封魔结界投放【%s次】奖励: %sx".._cfg.num, num, _cfg.giveitem), 1)
    local str =  "封魔结界：玩家{「%s」/FCOLOR=251}投放仙石达到{【%s次】/FCOLOR=250}，获得奖励{「%s×1」/FCOLOR=253}！"
    sendmsgnew(actor, 255, 0, string.format(str, getbaseinfo(actor,1), num, _cfg.giveitem), 1, 2)
end

function FengMoJieJieNpc:onExchangeItem(actor, index)
    if CheckOpenState(actor, 1) then return end
    index = tonumber(index)
    if nil == index or not isInTable({1, 2, 3}, index) then
        return
    end
    local sMsg3 = VarApi.getPlayerZStrVar(actor, "Z_exchange_state")
    if "" == sMsg3 then
        sMsg3 = {0, 0, 0}
    else
        sMsg3 = tbl2json(sMsg3)
    end
    if sMsg3[index] == 1 then
        Sendmsg9(actor, "ff0000", "今日已兑换完!", 1)
        return
    end
    sMsg3[index] = 1
    index = index + 7
    local _cfg = self.cfg[index]
    local num = getbagitemcount(actor, _cfg.needitem)
    if num < _cfg.itemnum then
        Sendmsg9(actor, "ff0000", "需要".._cfg.needitem .. "*" .._cfg.itemnum  , 1)
        return
    end
    if takeitem(actor, _cfg.needitem, _cfg.itemnum, 0, "帝王印记兑换扣除!") then
        GiveItem(actor, _cfg.giveitem, _cfg.num, 370, "帝王印记兑换".._cfg.giveitem)
    end
    VarApi.setPlayerZStrVar(actor, "Z_exchange_state", tbl2json(sMsg3), nil)
    local sMsg = self:getUiData(actor)
    lualib:FlushNpcUi(actor, "FengMoJieJieOBJ", sMsg)
end

function FengMoJieJieNpc:getUiData(actor)
    local total = GetSysInt("G_launch_count")
    local myNum = VarApi.getPlayerJIntVar(actor, "J_launch_count")
    local sMsg1 = tbl2json({total, myNum})
    local sMsg2 = VarApi.getPlayerZStrVar(actor, "Z_get_state")
    if "" == sMsg2 then
        sMsg2 = {0, 0, 0}
        sMsg2 = tbl2json(sMsg2)
    end
    local sMsg3 = VarApi.getPlayerZStrVar(actor, "Z_exchange_state")
    if "" == sMsg3 then
        sMsg3 = {0, 0, 0}
        sMsg3 = tbl2json(sMsg3)
    end
    return sMsg1 .. "#" .. sMsg2 .. "#" .. sMsg3
end

function _on_goto_compound(actor)
    lualib:CloseNpcUi(actor, "JieJieMessengerOBJ")
    lualib:ShowNpcUi(actor, "CompoundSysOBJ", 2)
end

return FengMoJieJieNpc