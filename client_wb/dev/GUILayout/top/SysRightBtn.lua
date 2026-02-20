--[[
    101 主界面左上 建议开始微调坐标 0 0
    102 主界面右上 建议开始微调坐标 -65 0
    103 主界面左下 建议开始微调坐标 0 -92
    104 主界面右下 建议开始微调坐标 -62 -92
    105 主界面左中 建议开始微调坐标 0 0
    106 主界面上中 建议开始微调坐标 0 0
    107 主界面右中 建议开始微调坐标 -62 0
    108 主界面下中 建议开始微调坐标 0 -92
    109 主界面切换按钮
    110 主界面任务界面
    1101 主界面最顶左上
    1102 主界面最顶右上
    1103 主界面最顶左下
    1104 主界面最顶右下
--]]
main_sys_ui = {}
local isPC = SL:Get_IS_PC_OPER_MODE()
local parent107 = GUI:Win_FindParent(107)
local parent108 = GUI:Win_FindParent(108)
local parent109 = GUI:Win_FindParent(109)
SL:SetMetaValue("DROPITEM_FLY_WORLD_POSITION", 1100, 400) --#region 飞背包

--- 点击按钮回调 109
--- @param id integer/string        string类型代表Npc面板 
local function onClick109Btn(id)
    if nil == id then
        return
    end
    if type(id) == "string" then
        SendMsgClickSysBtn("109#SysRightBtn#onClickBtn#"..id)
    else
        if SL:Get_KFSTATE() and isInTable({16, 31}, id) then
            SL:ShowSystemTips("跨服区域禁止使用!")
            return
        end
        SL:JumpTo(id)
    end
end
local mobile_btns_109 = {
    {"_relevel", "res/private/main/bottom/1900012592.png", func = onClick109Btn, id = "LifeUpOBJ", x = 162, y = 195},            -- 转生
    {"_forge", "res/private/main/bottom/1900013030.png", func = onClick109Btn, id = "FourCellOBJ", x = 92, y = 195},               -- 锻造
    {"_skill", "res/private/main/bottom/1900012593.png", func = onClick109Btn, id = "DisguiseOBJ", x = 92, y = 130},               -- 装扮
    {"_guild", "res/private/main/bottom/1900013013.png", func = onClick109Btn, id = 31, x = 162, y = 130},              -- 行会
    {"_godequip", "res/private/main/bottom/dayedao.png", func = onClick109Btn, id = "GodEquipOBJ", x = 22, y = 195},         -- 打野刀
    {"_email", "res/private/main/bottom/1900012590.png", func = onClick109Btn, id = 16, x = 162, y = 65},              -- 邮件
    {"_zengfu", "res/private/main/bottom/1900013031.png", func = onClick109Btn, id = "EquipMasterOBJ", x = 92, y = 65},               -- 增幅
    {"_exit", "res/private/main/bottom/1900013018.png", func = onClick109Btn, id = 29, x = 162, y = 0},               -- 退出
    {"_setting", "res/private/main/bottom/1900013017.png", func = onClick109Btn, id = 300, x = 92, y = 0},           -- 设置
}
local pc_btns_109 = {

}

--- 点击按钮回调 108
--- @param id integer/string        string类型代表Npc面板 
local function onClick108Btn(id)
    if nil == id then
        return
    end
    if type(id) == "string" then
        SendMsgClickSysBtn("108#SysRightBtn#onClickBtn#"..id)
    else
        if id == 32 and SL:Get_LEVEL() < 70 then
            SL:ShowSystemTips("大于等于70级才可查看!")
            return
        end
        SL:JumpTo(id)
    end
end
local mobile_btns_108 = {
    {"_rank", "res/private/main/Button_3/1900012054.png", func = onClick108Btn, id = 32, x = -292, y = 28},
    {"_shop", "res/private/main/Button_3/shop1.png", func = onClick108Btn, id = 9, x = 160, y = 40},
    {"_setting", "res/private/main/Button_3/set1.png", func = onClick108Btn, id = 23, x = 230, y = 25},
    {"_xunhang", "res/custom/0xun/btn1.png", func = onClick108Btn, id = "xunhang", x = 160, y = 140},
}
local pc_btns_108 = {
    {"_xunhang", "res/custom/0xun/btn1.png", func = onClick108Btn, id = "xunhang", x = 270, y = 205},
}

--- 点击按钮回调 107
local function onClick107Btn(id, sender)
    if nil == id then
        return
    end
    if type(id) == "string" then
        if id == "_ciSha" then
            local tab = SL:Get_SETTING_VALUE(56)
            local state = 0
            if isInTable(tab, 1) then
                state = 0
            else
                state = 1
            end
            local path = "res/private/new_setting/icon/off.png"
            if state == 1 then
                path = "res/private/new_setting/icon/on.png"
            end
            GUI:Button_loadTextureNormal(main_sys_ui["_ciSha"], path)
            SL:Set_SETTING_VALUE(56, {state})
        elseif id == "_fight" then
            local is_auto_fight = SL:GetMetaValue("BATTLE_IS_AFK")
            if not is_auto_fight then
                SL:SetMetaValue("BATTLE_AFK_BEGIN")
            else
                SL:SetMetaValue("BATTLE_AFK_END")
            end
        elseif id == "_15job" then
            ViewMgr.open("JobAwakeMainOBJ")
        end
    else
        SL:JumpTo(id)
    end
end
local mobile_btns_107 = {
    {"_role", "res/private/main/bottom/1900013010.png", func = onClick107Btn, x = -135, y = 65, id = 1},
    {1000, "res/private/main/bottom/1900013011.png", func = onClick107Btn, x = -65, y = 65, id = 7},
    {"_fight", "res/private/main/bottom/g.png", func = onClick107Btn, x = -135, y = -7, id = "_fight"},
    {"_ciSha", "res/private/new_setting/icon/off.png", func = onClick107Btn, x = -200, y = -7, id = "_ciSha"},                  -- 移动各位刺杀
    {"_15job", "res/custom/npc/115job/15jobIcon.png", func = onClick107Btn, x = -205, y = 65, id = "_15job"},
}
local pc_btns_107 = {
    {"_fight", "res/private/main/bottom/g.png", func = onClick107Btn, x = -170, y = -40, id = "_fight"},                        -- 自动
    {"_email", "res/private/main/bottom/1900012590.png", func = onClick109Btn, id = 16, x = -65, y = 130},                      -- 邮件
    {"_relevel", "res/private/main/bottom/1900012592.png", func = onClick109Btn, id = "LifeUpOBJ", x = -65, y = 65},            -- 转生
    {"_forge", "res/private/main/bottom/1900013030.png", func = onClick109Btn, id = "FourCellOBJ", x = -65, y = 0},             -- 锻造
    {"_skill", "res/private/main/bottom/1900012593.png", func = onClick109Btn, id = "DisguiseOBJ", x = -65, y = -65},           -- 装扮
    {"_zengfu", "res/private/main/bottom/1900013031.png", func = onClick109Btn, id = "EquipMasterOBJ", x = -65, y = -130},      -- 增幅
    {"_godequip", "res/private/main/bottom/dayedao.png", func = onClick109Btn, id = "GodEquipOBJ", x = -115, y = -180}, --#region 打野刀

    {"_ciSha", "res/private/new_setting/icon/off.png", func = onClick107Btn, x = -170, y = 130, id = "_ciSha"},                  -- 移动各位刺杀
}


local function addMainSysBtn()
    isPC = SL:Get_IS_PC_OPER_MODE()
    parent107 = GUI:Win_FindParent(107)
    parent108 = GUI:Win_FindParent(108)
    parent109 = GUI:Win_FindParent(109)
    GUI:removeAllChildren(parent107)
    GUI:removeAllChildren(parent108)
    GUI:removeAllChildren(parent109)
    local job = SL:GetMetaValue("JOB")

    local btns_107 = mobile_btns_107
    local btns_108 = mobile_btns_108
    local btns_109 = mobile_btns_109
    if isPC then
        btns_107 = pc_btns_107
        btns_108 = pc_btns_108
        btns_109 = pc_btns_109
    end
    for k, v in ipairs(btns_107) do
        local btn = GUI:Button_Create(parent107, v[1], v.x or 0, v.y or 0, v[2])
        main_sys_ui[v[1]] = btn
        GUI:addOnClickEvent(btn, function()
            if v.func then
                v.func(v.id, btn)
            end
        end)
        if v.id == "_fight" then
            local ext = {
                count = 10,
                speed = 100,
                loop = -1,
            }
            local fight_frames = GUI:Frames_Create(btn, "fight_frames", -20, -20, "res/private/main/bottom/g", ".png", 1, 10, ext)
            main_sys_ui["fight_frames"] = fight_frames
            GUI:setVisible(main_sys_ui["fight_frames"], SL:GetMetaValue("BATTLE_IS_AFK"))
        end
        if v.id == "_ciSha" then
            GUI:setVisible(btn, job == 0 and SL:GetMetaValue("SKILL_DATA", 12) ~= nil)
            local tab = SL:Get_SETTING_VALUE(56)
            local path = "res/private/new_setting/icon/off.png"
            if tab[1] == 1 then
                path = "res/private/new_setting/icon/on.png"
            end
            GUI:Button_loadTextureNormal(btn, path)
        end
    end

    for k, v in pairs(btns_108) do
        local btn = GUI:Button_Create(parent108, v[1], v.x or 0, v.y or 0, v[2])
        main_sys_ui[v[1]] = btn
        GUI:addOnClickEvent(btn, function()
            if v.func then
                v.func(v.id)
            end
        end)
    end

    for k, v in pairs(btns_109) do
        local btn = GUI:Button_Create(parent109, v[1], v.x or 0, v.y or 0, v[2])
        main_sys_ui[v[1]] = btn
        GUI:addOnClickEvent(btn, function()
            if v.func then
                v.func(v.id)
            end
        end)
    end
end

-- 自动挂机开始
local function onStartAutoFight()
    if main_sys_ui["fight_frames"] then
        GUI:setVisible(main_sys_ui["fight_frames"], true)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_AFKBEGIN, "SysRightBtn", onStartAutoFight)
-- 自动挂机结束
local function onEndAutoFight()
    if main_sys_ui["fight_frames"] then
        GUI:setVisible(main_sys_ui["fight_frames"], false)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_AFKEND, "SysRightBtn", onEndAutoFight)

-- 各位刺杀
local function onSettingChange(info)
    if info and info.id == 56 then
        local value = info.values[1]
        local res = "res/private/new_setting/icon/off.png"
        if value == 1 then
            res = "res/private/new_setting/icon/on.png"
        end
        if main_sys_ui["_ciSha"] then
            GUI:Button_loadTextureNormal(main_sys_ui["_ciSha"], res)
        end
    end
end
SL:RegisterLUAEvent(LUA_EVENT_SETTING_CAHNGE, "SysRightBtn", onSettingChange)

-------------- 延迟半秒
SL:ScheduleOnce(function () addMainSysBtn() end, 0.5)
