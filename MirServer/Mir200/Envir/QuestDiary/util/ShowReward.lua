ShowReward = {}
ShowReward.show_ui_state = {}
ShowReward.reward_pool = {}
-- 显示奖励弹框
-- rewards 奖励道具信息 支持  string/table
-- 绑定元宝#1000|木剑#1|灵符#100                2#1000|50001#1|7#100
-- {{"绑定元宝", 1000}, {"木剑", 1}, {灵符, 100}}
-- showType  显示类型  0.恭喜获得  2.卖出获得   3.任务奖励
function ShowReward.showReward(actor, rewards, showType)
    ShowReward.reward_pool[actor] = ShowReward.reward_pool[actor] or {}
    showType = showType or 0
    if ShowReward.show_ui_state[actor] then
        table.insert(ShowReward.reward_pool[actor], {rewards, showType})
        return
    end
    local tmp_reward = {}
    if type(rewards) == "string" then
        local tmp = strsplit(rewards, "|")
        if #tmp <= 1 then
            tmp = strsplit(rewards, "&")
        end
        for key, v in ipairs(tmp) do
            local _t = strsplit(v, "#")
            local item_id = tonumber(_t[1])
            local count = tonumber(_t[2]) or 1
            if nil == item_id then
                item_id = getstditeminfo(_t[1], 0)
            end
            local data = {item_id, count}
            if item_id then
                tmp_reward[#tmp_reward + 1] = data
            else
                release_print("item_id is nil ***", v[1])
            end
        end
    else
        if "table" ~= type(rewards[1]) then
            rewards = {rewards}
        end
        for key, v in ipairs(rewards) do
            local item_id = tonumber(v[1])
            if nil == item_id then
                item_id = getstditeminfo(v[1], 0)
            end
            local data = {item_id, v[2] or 1}
            if item_id then
                tmp_reward[#tmp_reward + 1] = data
            else
                release_print("item_id is nil ***", v[1])
            end
        end
    end
    if #tmp_reward <= 6 then
        local say_ui = [[
            <Img|move=0|img=custom/additem/additem_bg.png|loadDelay=1|bg=1|reset=1|show=4>
            <Frames|x=90|y=-43|suffix=.png|prefix=custom/additem/hd|count=12|loop=-1|speed=5>
            <Img|move=0|img=custom/additem/bag_text_%s.png|x=232|y=43>
            <Layout|x=-500|y=-500|width=2000|height=2000|link=@_close_reward_view>
            <ListView|children={%s}|width=%d|height=70|x=301|y=180|ax=0.5|ay=0.5|direction=2|bounce=1|margin=5|reload=0>
            <Text|x=425.0|y=250|color=250|size=16|text=后自动关闭>
            <COUNTDOWN|x=400|y=250|time=5|count=1|size=16|color=250|link=@_close_reward_view>
            ]]
        local item_str = "<ItemShow|id=%s|x=0|y=0|width=70|height=70|itemid=%s|itemcount=%s|showtips=1|bgtype=1>"
        local ret = ""
        local id = ""
        local len = 0
        local item_index= 1
        for _, v in ipairs(tmp_reward) do
            id = item_index .. "," .. id
            len = len + 1
            ret = ret .. string.format(item_str, item_index, v[1], v[2])
            item_index = item_index + 1
        end
        local width = len * 70 + (len - 1) * 5
        say_ui = string.format(say_ui, showType, id, width)
        say_ui = say_ui .. ret
        say(actor, say_ui)
    else
        local say_ui = [[
            <Img|move=0|img=custom/additem/additem_bg.png|loadDelay=1|bg=1|reset=1|show=4>
            <Frames|x=90|y=-43|suffix=.png|prefix=custom/additem/hd|count=12|loop=-1|speed=5>
            <Img|move=0|img=custom/additem/bag_text_%s.png|x=232|y=43>
            <Layout|x=-500|y=-500|width=2000|height=2000|link=@_close_reward_view>
            <ListView|children={%s}|width=450|height=140|x=315|y=174|ax=0.5|ay=0.5|direction=1|bounce=1|margin=5|reload=0>
            <COUNTDOWN|x=400|y=250|time=5|count=1|size=16|color=250|link=@_close_reward_view>
            <Text|x=425.0|y=250|color=250|size=16|text=后自动关闭>
            ]]
        local count = math.ceil(#tmp_reward/6)
        local list_view_str_ret = ""
        local list_view_str = "<ListView|id=%s|children={%s}|width=480|height=70|x=0|y=0|ax=0.5|ay=0.5|direction=2|bounce=0|margin=5|reload=0|cantouch=0>"
        local id = 100
        local list_view_id_ret = "" 
        for i = 1, count do
            local id_str = ""
            for s = 1, 6 do
                if id < 100 + #tmp_reward then
                    id = id + 1
                    id_str = id_str == "" and "" .. id or  id_str .. ","..id
                end
            end
            list_view_id_ret = list_view_id_ret == "" and "" .. i or  list_view_id_ret .. ","..i
            list_view_str_ret = list_view_str_ret .. string.format(list_view_str,i,id_str)
        end
        say_ui =  string.format(say_ui, showType, list_view_id_ret) ..list_view_str_ret
        local item_str = "<ItemShow|id=%s|x=0|y=0|width=70|height=70|itemid=%s|itemcount=%s|showtips=1|bgtype=1>"
        local item_index= 101
        local ret = ""
        for _, v in ipairs(tmp_reward) do
            ret = ret .. string.format(item_str, item_index, v[1], v[2])
            item_index = item_index + 1
        end
        say_ui =  say_ui .. ret
        say(actor,say_ui) 
    end
    ShowReward.show_ui_state[actor] = true
end

function _close_reward_view(actor)
    close(actor)
    ShowReward.show_ui_state[actor] = false
    if nil == ShowReward.reward_pool[actor] then
        return
    end
    local ret = table.remove(ShowReward.reward_pool[actor])
    if ret then
        ShowReward.showReward(actor, ret[1], ret[2])
    end
end


-- 调用示例
-- ShowReward.showReward(actor, "绑定元宝#1000|乌木剑#1", 0)
-- ShowReward.showReward(actor, {"绑定元宝", 1000}, 0)
-- ShowReward.showReward(actor, {{"绑定元宝", 1000}, {50000, 1}}, 0)
