local CustomBoxNpc = {}
CustomBoxNpc.cfg = GetConfig("CustomBoxCfg")

function CustomBoxNpc:onSelectItem(actor, box, item, itemNum)
    local blank_num = getbagblank(actor)
    if blank_num < 6 then
        Sendmsg9(actor, "ff0000", "请至少留出6格背包空格！", 1)
        return
    end
    local num = getbagitemcount(actor, box)
    if num <= 0 then
        Sendmsg9(actor, "ff0000", box .. "数量不足!", 1)
        return
    end

    local _cfg = self.cfg[box]
    if nil == _cfg then
        Sendmsg9(actor, "ff0000", "数据异常!", 1)
        return
    end

    if not string.find(_cfg.item, item .. "#" .. itemNum, 1, true) then
        Sendmsg9(actor, "ff0000", "数据异常!", 1)
        return
    end

    if not takeitem(actor, box, 1, 0, "自选宝箱") then
        Sendmsg9(actor, "ff0000", box .. "扣除失败!", 1)
        return
    end
    lualib:CloseNpcUi(actor, "CustomBoxOBJ")
    item = item .. "#" .. itemNum
    Gives(actor, item .. "#370", "消耗自选宝箱获得!")
    ShowReward.showReward(actor, item, 1)

    local str =  "恭喜：玩家{「%s」/FCOLOR=254}成功开启{【%s】/FCOLOR=251}，获得{「%s」/FCOLOR=250}！"
    sendmsgnew(actor, 255, 0, string.format(str, getbaseinfo(actor,1), box, string.gsub(item, "#", "x")), 1, 2)
end

function CustomBoxNpc:RandomItem(actor, box)
    local blank_num = getbagblank(actor)
    if blank_num < 6 then
        Sendmsg9(actor, "ff0000", "请至少留出6格背包空格！", 1)
        return
    end
    local num = getbagitemcount(actor, box)
    if num <= 0 then
        Sendmsg9(actor, "ff0000", box .. "数量不足!", 1)
        return
    end

    local _cfg = self.cfg[box]
    if nil == _cfg then
        Sendmsg9(actor, "ff0000", "数据异常!", 1)
        return
    end

    local item_tab = strsplit(_cfg.item, "|")
    local index = math.random(#item_tab)
    local item = item_tab[index]
    if nil == item then
        return
    end
    if not takeitem(actor, box, 1, 0, "自选宝箱") then
        Sendmsg9(actor, "ff0000", box .. "扣除失败!", 1)
        return
    end
    Gives(actor, item .. "#370", "消耗自选宝箱获得!")
    ShowReward.showReward(actor, item, 1)

    local str =  "恭喜：玩家{「%s」/FCOLOR=254}成功开启{【%s】/FCOLOR=251}，获得{「%s」/FCOLOR=250}！"
    sendmsgnew(actor, 255, 0, string.format(str, getbaseinfo(actor,1), box, string.gsub(item, "#", "x")), 1, 2)
end

return CustomBoxNpc