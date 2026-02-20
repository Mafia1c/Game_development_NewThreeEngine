----------------------------------主界面顶部按钮
-- 点击按钮回调
local function onClickTopBtn(id)
    if nil == id then
        SL:Print("id is nil!")
        return
    end
    if type(id) == "string" then
        SendMsgClickMainBtn("0#MainTopBtn#"..id)
    else
        SL:JumpTo(id)
    end
end

local row1Info = {
    -- 按钮id, 图片资源路径, 函数名, 是否一直显示, 参数
    {"_top_btn1_1", "res/custom/top/an01.png",func = onClickTopBtn, id = "RechargeShopping"},                    -- 充值商城
    {"_top_btn1_2", "res/custom/top/an02.png",func = onClickTopBtn, id = "WelfareHall"},                         -- 福利大厅
    {"_top_btn1_3", "res/custom/top/an03.png",func = onClickTopBtn, id = "ActivityCenter"},                      -- 活动中心
    {"_top_btn1_6", "res/custom/top/an11.png",func = onClickTopBtn, id = "CrossServerWorld"},                   -- 跨服世界
    {"_top_btn1_4", "res/custom/top/an18.png",func = onClickTopBtn, id = "DailyActive"},                        -- 每日活跃
    {"_top_btn1_5", "res/custom/top/an19.png",func = onClickTopBtn, id = "WelfareToday"},                        -- 专享福利
    {"_top_btn1_7", "res/custom/top/an21.png",func = onClickTopBtn, id = "Cornucopia",show=true},                        -- 专享福利
}

local row2Info = {
    -- 按钮id, 图片资源路径, 函数名, 是否一直显示, 参数
    {"_top_btn2_1", "res/custom/top/an00.png",func = onClickTopBtn, id = "AuctionHouse"},                                               -- 拍卖行
    {"_top_btn2_2", "res/custom/top/an06.png",func = onClickTopBtn, id = "Rampage"},                                                    -- 狂暴之力
    {"_top_btn2_3", "res/custom/top/an07.png",func = onClickTopBtn, id = "AllianceOrder"},                                              -- 盟重令
    {"_top_btn2_4", "res/custom/top/an09.png",func = onClickTopBtn, id = "FirstRechargeGift", var = {"U_firstRecharge_gift", 0}},       -- 首充豪礼
    {"_top_btn1_8", "res/custom/top/an10.png",func = onClickTopBtn, id = "ChallengeBoss"},
    {"_top_btn2_6", "res/custom/npc/113cjtq/top.png",func = onClickTopBtn, id = "SuperPrivileges"},-- 超级特权
}

local row3Info = {

}


local isPC = SL:Get_IS_PC_OPER_MODE()
local topUi = {}
local layout_102 = GUI:Win_FindParent(102)
local startX = 0
local startY = 0
local switch_btns = {}
local show_btns = false
jbp_text_node = nil
-- 创建按钮
local function create_switch_btn()
    switch_btns = {}
    jbp_text_node = nil
    layout_102 = GUI:Win_FindParent(102)
    local btn_parent = GUI:GetWindow(layout_102,"btn_parent")
    --若已创建顶部
    if btn_parent and GUI:Win_IsNotNull(btn_parent) then
        GUI:removeFromParent(btn_parent)
    end
    local parent = GUI:Node_Create(layout_102, "btn_parent", 0, 0)
    local size = {width = 70, height = 60}
    startX = -126 - size.width / 2
    startY = -10 - size.height / 2
    if isPC then
        -- pc重新计算x,y
        startX = startX - 10
        startY = startY
    end
    local switch_btn = GUI:Button_Create(parent, "switch", startX, startY, "res/custom/top/top_01.png", "res/custom/top/top_02.png")
    GUI:setAnchorPoint(switch_btn, 0.5, 0.5)

    local length = math.max(#row1Info, #row2Info, #row3Info)
    for i = 1, length do
        local row1 = row1Info[i]
        local row2 = row2Info[i]
        local row3 = row3Info[i]
        local x1 = (startX - 20) - i * 80
        local x2 = (startX - 20) - i * 80
        local x3 = (startX - 20) - i * 80
        local y1 = startY - 40
        local y2 = startY - 120
        local y3 = startY - 200
        if row1 then
            local btn1 = GUI:Button_Create(parent, row1[1], x1, y1, row1[2])
            local tab = {
                btn = btn1,
                row = 1,
                show = row1.show,
                merge = row1.merge,
                week = row1.weekday,
                var = row1.var,
            }
            table.insert(switch_btns, tab)
            GUI:addOnClickEvent(btn1, function()
                if row1.func then
                    row1.func(row1.id)
                end
            end)
            if row1[1] == "_top_btn1_7" then
                jbp_text_node = GUI:Text_Create(btn1, "jbp_countdown", 38, -10, 18, "#00ff00","")
                GUI:setAnchorPoint(jbp_text_node,0.5,0.5)
                local time =  GameData.GetData("U_jubaopen_award_1") or 0
                if 600 - time <= 0 then
                    GUI:Text_setTextColor(jbp_text_node,"#00ff00")
                    GUI:Text_setString(jbp_text_node,"可领取")
                end
            end
        end
        if row2 then
            local btn2 = GUI:Button_Create(parent, row2[1], x2, y2, row2[2])
            local tab = {
                btn = btn2,
                row = 2,
                show = row2.show,
                merge = row2.merge,
                week = row2.weekday,
                var = row2.var,
            }
            table.insert(switch_btns, tab)
            GUI:addOnClickEvent(btn2, function()
                if row2.func then
                    row2.func(row2.id)
                end
            end)
        end
        if row3 then
            local btn3 = GUI:Button_Create(parent, row3[1], x3, y3, row3[2])
            local tab = {
                btn = btn3,
                row = 3,
                show = row3.show,
                merge = row3.merge,
                week = row3.weekday,
                var = row3.var,
            }
            table.insert(switch_btns, tab)
            GUI:addOnClickEvent(btn3, function()
                if row3.func then
                    row3.func(row3.id)
                end
            end)
        end
    end
  

    local function switch_show()
        local merge_count = GameData.GetData("HeFuCount", false) or 0
        show_btns = not show_btns
        local tmp_list = {}
        for k, v in pairs(switch_btns) do
            local is_show = v.show or show_btns
            if is_show and v.merge then
                is_show = merge_count >= v.merge
            end
            if is_show and v.week then
                local wDay = tonumber(GetWeekDay())
                is_show = isInTable(v.week, wDay)
            end
            if is_show and v.var then
                local value = GameData.GetData(v.var[1], false)
                if v.var[2] == 0 then
                    is_show = v.var[2] >= (value or 0)
                else
                    is_show = v.var[2] <= (value or 100)
                end
            end
            if is_show then
                tmp_list[v.row] = tmp_list[v.row] or {}
                table.insert(tmp_list[v.row], v.btn)
            end
            GUI:setVisible(v.btn,  is_show)
        end
        -- 常亮按钮重新排列
        for _, btns in pairs(tmp_list) do
            for k, v in pairs(btns) do
                local x = (startX - 20) - k * 80
                if _ == 2 then
                    x = (startX - 20) - k * 80
                end
                GUI:setPositionX(v, x)
            end
        end
        tmp_list = {}
        local path = "res/custom/top/top_01.png"
        local path2 = "res/custom/top/top_02.png"
        if not show_btns then
            path = "res/custom/top/top_11.png"
            path2 = "res/custom/top/top_12.png"
        end
        GUI:Button_loadTextureNormal(switch_btn, path)
        GUI:Button_loadTexturePressed(switch_btn, path2)
    end
    GUI:addOnClickEvent(switch_btn, function()
        switch_show()
    end)
    show_btns = false
    switch_show()
    topUi = GUI:ui_delegate(layout_102)
    SL:onLUAEvent(MAIN_TOP_BTN_CHANGE)
end

SL:ScheduleOnce(function ()
    create_switch_btn()
end, 0.5)

function plardark()
    local width = SL:GetMetaValue("SCREEN_WIDTH")
    local height = SL:GetMetaValue("SCREEN_HEIGHT")

    local parent = GUI:Attach_LeftTop()
    parent = GUI:getParent(parent)
    parent = GUI:getParent(parent)

    local Image_bg = GUI:getChildByName(parent, 'FrameBG')
    if Image_bg then
        GUI:removeFromParent(Image_bg)
    end

    local Image_bg = GUI:Image_Create(parent, "FrameBG", width / 2, height / 2, "res/custom/dark.png")
    GUI:setLocalZOrder(Image_bg, -1)
    GUI:Image_setScale9Slice(Image_bg, 100, 100, 100, 100)
    GUI:setContentSize(Image_bg, width, height)
    GUI:setAnchorPoint(Image_bg, 0.5, 0.5)
    -- 删除图片
    SL:ScheduleOnce(function ()
        local Image_bg = GUI:getChildByName(parent, 'FrameBG')
        if Image_bg then
            GUI:removeFromParent(Image_bg)
        end
    end, 3)
end

-- 更新顶部按钮显示
local function update_callBack(sMsg)
    -- 开区天数
    if string.find(sMsg, "OpenCount") then

    end
    -- 合区次数
    if string.find(sMsg, "HeFuCount") or string.find(sMsg, "U_firstRecharge_gift") or string.find(sMsg, "U_firstRecharge_gift")  then
        create_switch_btn()
    end
    if string.find(sMsg,"U_jubaopen_award_1") then
        if jbp_text_node and GUI:Win_IsNotNull(jbp_text_node)  then
            local time =  GameData.GetData("U_jubaopen_award_1") or 0
            if 600 - time > 0 then
                GUI:Text_setTextColor(jbp_text_node,"#ff0000")
                GUI:Text_setString(jbp_text_node,secondsToExtendedTime(600 - GameData.GetData("U_jubaopen_award_1")))
            else
                GUI:Text_setTextColor(jbp_text_node,"#00ff00")
                GUI:Text_setString(jbp_text_node,"可领取")
            end
        end
    end
    if type(sMsg) == "string" and string.find(sMsg,"open_buff_dark") then
        plardark()
    end
end
SL:RegisterLUAEvent(LUA_EVENT_GAME_DATA, "update_top_btn_show", update_callBack)
