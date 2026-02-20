local FirstRechargeGift = {}
function FirstRechargeGift:onClickBtn(actor)
    local get_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.FirstRecharge)
    lualib:ShowNpcUi(actor, "FirstRechargeGiftOBJ", get_state)
    TaskTrigger.CompleteTask(actor, 20)
end

function FirstRechargeGift:getFirstRechargeGift(actor)
    local value = VarApi.getPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE)
    if value <= 0 then
        local npc_class = IncludeMainClass("WelfareToday")
        if npc_class then
            npc_class:onClickBtn(actor)
        end
        return
    end
    local blank_num = getbagblank(actor)
    if blank_num < 10 then
        Sendmsg9(actor, "ff0000", "背包空间不足!", 1)
        return
    end
    local get_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.FirstRecharge)
    if get_state > 0 then
        Sendmsg9(actor, "ff0000", "请勿重复领取!", 1)
        return
    end
    VarApi.setPlayerUIntVar(actor, VarUIntDef.FirstRecharge, 1, true)
    lualib:CloseNpcUi(actor, "FirstRechargeGiftOBJ")

    local gift_tab = {
        {"魅影之刃",1},
        {"龙魂盾",1},
        {"吸星大法",1},
        {"三级背包",1},
    }
    local job = tonumber(getbaseinfo(actor, 7))
    local skill_book = {"开天斩", 1}
    if job == 1 then
        skill_book = {"流星火雨", 1}
    elseif job == 2 then
        skill_book = {"召唤月灵", 1}
    elseif job == 0 then
        skill_book = {"开天斩", 1}
    end
    table.insert(gift_tab, skill_book)

    local ret = ""
    for index, info in ipairs(gift_tab) do
        ret = info[1] .. "#" .. info[2] .. "#370&" .. ret
    end
    SendMail(actor, 1, "首充豪礼", "恭喜你，成功领取<【首充豪礼】/FCOLOR=250>请查收！", ret)
    local str = string.format("恭喜「%s」成功领取「%s」!", "<"..getbaseinfo(actor, 1).."/FCOLOR=254>", "<首充豪礼/FCOLOR=250>")
    sendmsgnew(actor, 255, 0, str, 1, 2)
    Sendmsg9(actor, "00ff00", "首充豪礼已发放至邮箱, 请及时领取!", 1)
end

return FirstRechargeGift