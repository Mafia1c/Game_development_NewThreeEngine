LoginTrigger = {}
local add_skills = {
    [0] = {3, 7, 12, 25, 26, 27},
    [1] = {8, 10, 11, 20, 22, 24, 31, 32, 33},
    [2] = {2, 4, 6, 13, 14, 15, 16, 18, 19, 29, 30}
}

function LoginTrigger.firstLogin(actor)
    VarApi.setPlayerUIntVar(actor, VarUIntDef.ENTER_TIME, os.time(), true)
    VarApi.setPlayerUIntVar(actor, VarUIntDef.LOGIN_DAY, 1, true)
    VarApi.setPlayerUIntVar(actor, "U_auto_open_mail", 1, false)
    VarApi.setPlayerUIntVar(actor, "U_daoshi_auto_call", 1, false)
    VarApi.setPlayerUIntVar(actor, "U_role_btn_index", 1, false)
    VarApi.setPlayerUIntVar(actor, VarUIntDef.FirstRecharge, 0, true)       -- 初始化一下  客户端top按钮要用到这个变量值
    VarApi.setPlayerUIntVar(actor, "U_task_step_info", 0, true)       -- 主线
    mapmove(actor, "hero001", 48, 42, 5)        --　跳转到新手村
    -- setbagcount(actor, 126)                     --  设置背包格子
    changestorage(actor, 240)
    setsndaitembox(actor,1)
    LoginTrigger.loginAddSkills(actor)
    local cdTime=GetSysInt("G_fakeCd")
    if not IsDummy(actor) and os.time()>cdTime and GetSysInt("G_fakeNumber")<30 then
        SetSysInt("G_fakeCd",os.time()+600)
        dummylogon(actor,"3",322,330,3,3,30,20,0,math.random(0,1))
    end
    if IsDummy(actor) then
        FakeHumanTrigger.fakeLogin(actor)
    end
end

function LoginTrigger.login(actor)
    VarApi.setPlayerUIntVar(actor, "U_item_collimator", 0, true)
    VarApi.Init(actor)
    --#region 玩家首次登陆触发
    if VarApi.getPlayerUIntVar(actor, VarUIntDef.ENTER_TIME) == 0 then
        LoginTrigger.firstLogin(actor)
    end
    HeFuTrigger.userLogin(actor) --#region 合服触发
    LoginAddStrAttrTrigger.addStrAttr(actor)
    LoginAddStrAttrTrigger.addButton(actor)

    if not IsDummy(actor) then
        local login_func = function ()
        end
        TaskTrigger.onLogin(actor, login_func)
        PlayerTimer.initPlayerTimer(actor)
    end

    LoginTrigger.changeSkillEffect(actor)

    LoginTrigger.addBtns(actor)

    local npc_class = IncludeNpcClass("WorldN1Npc")
    if npc_class then
        npc_class:loginCheckWorldN1Data(actor)
        npc_class:SendWorldDataClient(actor)
    end
    
    local mishu_class = IncludeNpcClass("FengShuiOccult")
    if mishu_class then
        mishu_class:FlushOccultAttr(actor)
    end

    local class = IncludeNpcClass("SkillReinforce")
    if class then
        class:FlushSkillEffect(actor)
    end
    local activit_class = IncludeMainClass("ActivityCenter")
    if activit_class then
        activit_class:LoginByClient(actor)
    end
    local cornucopia_class = IncludeMainClass("Cornucopia")
    if cornucopia_class then
        cornucopia_class:CheckJbpIsGet(actor)
    end

    for i,v in ipairs(ActivityVar) do
        lualib:CallFuncByClient(actor, "kf_word_state", v.."#".. GetSysInt(v))
    end 

    if not getbaseinfo(actor, 48) then
        gohome(actor)
    end
    -- 战斗力
    OtherTrigger.CountFightPower(actor)
    LoginTrigger.loginTipsMsg(actor)
    -- 狂暴之力
    local state = VarApi.getPlayerUIntVar(actor, VarUIntDef.RAMPAGE_STATE)
    if state > 0 then
        seticon(actor, 1, 1, 12415, 0, 0, 1, 0, 0)
    end
    local chang_job_item_num = VarApi.getPlayerUIntVar(actor,"U_change_job_flag")
    if chang_job_item_num > 0 then
        local name_list = {"战士","法师","道士"}
        local job = getbaseinfo(actor,7)
        SendMail(actor, 1, "转职补偿",string.format("恭喜你转为%s，返还职业觉醒材料：%s*%s",name_list[job+1],"书页",chang_job_item_num), "书页".."#"..chang_job_item_num)
        VarApi.setPlayerUIntVar(actor,"U_change_job_flag",0)
    end

    local skill_changjob_item_num = VarApi.getPlayerUIntVar(actor,"U_change_job_flag2")
    if skill_changjob_item_num > 0 then
        local name_list = {"战士","法师","道士"}
        local job = getbaseinfo(actor,7)
        SendMail(actor, 1, "转职补偿",string.format("恭喜你转为%s，返还技能强化材料：%s*%s",name_list[job+1],"书页",skill_changjob_item_num), "书页".."#"..skill_changjob_item_num)
        VarApi.setPlayerUIntVar(actor,"U_change_job_flag2",0)
    end

    --读取通区变量
    local path = GetUserAccount(actor)..".txt"
    tongdownload(100, path, path)

    --#region 装扮重新赋值
    if IncludeNpcClass("Disguise") then
        IncludeNpcClass("Disguise"):logEvent(actor)
    end

    if VarApi.getPlayerUIntVar(actor,"U_equipVariation_tag[永恒]")>0 and VarApi.getPlayerJIntVar(actor,"J_equipVariation_12719")==0 then
        VarApi.setPlayerJIntVar(actor,"J_equipVariation_12719",1,nil)
        addbuff(actor,40208)
    end

    -- 玛法历练称号
    npc_class = IncludeNpcClass("MaFaGuJiNpc")
    if npc_class then
        npc_class:LoginCheckLiLianTitle(actor)
    end

    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    if is_pc then
        delaygoto(actor, 650, "_delay_jump_to_func", 0)
    else
        delaygoto(actor, 650, "_delay_jump_to_func", 0)
    end

    if GetSysInt("G200") > 0 then
        local job = getbaseinfo(actor, 7)
        local attr_id = 153
        local attack_speed = 380
        if job == 0 then
        else
            attr_id = 154
            attack_speed = 500
        end
        local rate = VarApi.getPlayerUIntVar(actor, "U200")
        if rate == 0 then
            rate = 30
        end
        changehumnewvalue(actor, attr_id, attack_speed * rate / 100 * -1, 86400)
    end
    IncludeNpcClass("FastStep"):addBtn(actor)
end
-- 登录触发延时跳转
function _delay_jump_to_func(actor)
    local rate = VarApi.getPlayerUIntVar(actor, "U_exit_game_hp_rate")
    if rate ~= 0 then
        addhpper(actor, "+", rate)
    end
end

--跨天
function LoginTrigger.resetdayLogin(actor)
    local day = VarApi.getPlayerUIntVar(actor, VarUIntDef.LOGIN_DAY)
    VarApi.setPlayerUIntVar(actor, VarUIntDef.LOGIN_DAY,day + 1, true)
end

function LoginTrigger.loginAddSkills(actor)
    local job = getbaseinfo(actor, 7)
    local _tab = add_skills[job]
    for k, v in pairs(_tab) do
        addskill(actor, v, 3)
    end
end

-- 登录提示消息
function LoginTrigger.loginTipsMsg(actor)

end

-- 改变技能特效
function LoginTrigger.changeSkillEffect(actor)

end

function LoginTrigger.addBtns(actor)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    -- 小地图按钮
    local map_btn = {
        {8, 10000, "<Button|a=0|x=575|y=70|nimg=private/minimap/mbtn11.png|pimg=private/minimap/mbtn12.png|color=255|size=18|link=@call_map_func,1>"},
        {8, 10001, "<Button|a=0|x=575|y=140|nimg=private/minimap/mbtn21.png|pimg=private/minimap/mbtn22.png|color=255|size=18|link=@call_map_func,2>"},
        {8, 10002, "<Button|a=0|x=575|y=210|nimg=private/minimap/mbtn31.png|pimg=private/minimap/mbtn32.png|color=255|size=18|link=@call_map_func,3>"},
        {8, 1002, "<Text|text=飞行符剩余: $STM(ITEMCOUNT_飞行符)|x=590|y=255|size=16|color=250>"},

        {8, 10003, "<Button|a=0|x=575|y=370|nimg=private/minimap/mbtn41.png|pimg=private/minimap/mbtn42.png|color=255|size=18|link=@go_random>"},
        {8, 10004, "<Button|a=0|x=575|y=440|nimg=private/minimap/mbtn51.png|pimg=private/minimap/mbtn52.png|color=255|size=18|link=@go_home>"},
    }
    if is_pc then
        map_btn = {
            {8, 10000, "<Button|a=0|x=545|y=50|nimg=private/minimap/mbtn11.png|pimg=private/minimap/mbtn12.png|color=255|size=18|link=@call_map_func,1>"},
            {8, 10001, "<Button|a=0|x=545|y=110|nimg=private/minimap/mbtn21.png|pimg=private/minimap/mbtn22.png|color=255|size=18|link=@call_map_func,2>"},
            {8, 10002, "<Button|a=0|x=545|y=170|nimg=private/minimap/mbtn31.png|pimg=private/minimap/mbtn32.png|color=255|size=18|link=@call_map_func,3>"},
            {8, 1002, "<Text|text=飞行符剩余: $STM(ITEMCOUNT_飞行符)|x=560|y=215|size=16|color=250>"},

            {8, 10003, "<Button|a=0|x=545|y=340|nimg=private/minimap/mbtn41.png|pimg=private/minimap/mbtn42.png|color=255|size=18|link=@go_random>"},
            {8, 10004, "<Button|a=0|x=545|y=400|nimg=private/minimap/mbtn51.png|pimg=private/minimap/mbtn52.png|color=255|size=18|link=@go_home>"},
        }
    end
    for k, v in pairs(map_btn) do
        addbutton(actor, v[1], v[2], v[3])
    end

    -- 背包按钮
    local bag_btns = {
        {7, 10000,"<Button|a=0|x=25|y=400|nimg=custom/top/bag11.png|pimg=custom/top/bag12.png|color=255|size=18|link=@call_bag_func,0>"},
        {7, 10001,"<Button|a=0|x=150|y=400|nimg=custom/top/bag21.png|pimg=custom/top/bag22.png|color=255|size=18|link=@call_bag_func,1>"},
        {7, 10002,"<Button|a=0|id=10002|x=275|y=400|nimg=custom/top/bag31.png|pimg=custom/top/bag32.png|color=255|size=18|link=@call_bag_func,2>"},
        {7, 10003,"<Button|a=0|x=395|y=400|nimg=custom/top/bag41.png|pimg=custom/top/bag42.png|color=255|size=18|link=@call_bag_func,3>"},
        {7, 10004,"<Button|a=0|id=10004|x=535|y=280|nimg=private/bag_ui/bag_ui_mobile/tj11.png|pimg=private/bag_ui/bag_ui_mobile/tj12.png|color=255|size=18|link=@call_bag_func,4>"},
        {7, 10005,"<Button|a=0|id=10005|x=535|y=377|nimg=private/bag_ui/bag_ui_mobile/tj21.png|pimg=private/bag_ui/bag_ui_mobile/tj22.png|color=255|size=18|link=@call_bag_func,5>"},
        
        {7, 10007,"<Button|a=0|x=375|y=8|nimg=private/bag_ui/bag_ui_mobile/btn01.png|pimg=private/bag_ui/bag_ui_mobile/btn02.png|color=128|text=销 毁|size=16|link=@call_bag_func,6>"},
        -- 元宝
        {7, 10006, [[
            <Img|x=90|y=378.0|width=120|height=22|img=public/icon_paihangbang_05.png|esc=0>
            <ItemShow|itemid=2|showtips=1|x=75|y=355|scale=0.6>
            <Text|text=$STM(ITEMCOUNT_元宝)|x=125|y=380|size=18>

            <Img|x=340|y=378.0|width=120|height=22|img=public/icon_paihangbang_05.png|esc=0>
            <ItemShow|itemid=4|showtips=1|x=325|y=355|scale=0.6>
            <Text|text=$STM(ITEMCOUNT_绑定元宝)|x=375|y=380|size=18>
        ]]},
    }
    if is_pc then
        bag_btns = {
            {7, 10000,"<Button|a=0|x=350|y=470|nimg=public/1900000679.png|pimg=public/1900000679_1.png|color=128|text=交易行|size=16|link=@call_bag_func,0>"},
            {7, 10001,"<Button|a=0|x=350|y=510|nimg=public/1900000679.png|pimg=public/1900000679_1.png|color=128|text=仓库|size=16|link=@call_bag_func,1>"},
            {7, 10002,"<Button|a=0|id=10002|x=435|y=470|nimg=public/1900000679.png|pimg=public/1900000679_1.png|color=128|text=回收|size=16|link=@call_bag_func,2>"},
            {7, 10003,"<Button|a=0|x=435|y=510|nimg=public/1900000679.png|pimg=public/1900000679_1.png|color=128|text=整理|size=16|link=@call_bag_func,3>"},
            {7, 10004,"<Button|a=0|id=10004|x=532|y=370|nimg=private/bag_ui/bag_ui_mobile/tj11.png|pimg=private/bag_ui/bag_ui_mobile/tj12.png|color=255|size=18|link=@call_bag_func,4>"},
            {7, 10005,"<Button|a=0|id=10005|x=532|y=470|nimg=private/bag_ui/bag_ui_mobile/tj21.png|pimg=private/bag_ui/bag_ui_mobile/tj22.png|color=255|size=18|link=@call_bag_func,5>"},
            
            {7, 10007,"<Button|a=0|x=265|y=470|nimg=public/1900000679.png|pimg=public/1900000679_1.png|color=128|text=销 毁|size=16|link=@call_bag_func,6>"},
            -- 元宝
            {7, 10006, [[
                <Img|x=50.0|y=478.0|width=120|height=22|img=public/icon_paihangbang_05.png|esc=0>
                <ItemShow|itemid=2|showtips=1|x=5|y=455|scale=0.6>
                <Text|text=$STM(ITEMCOUNT_元宝)|x=55|y=480|size=18>
                <Img|x=50.0|y=513.0|width=120|height=22|img=public/icon_paihangbang_05.png|esc=0>
                <ItemShow|itemid=4|showtips=1|x=5|y=490|scale=0.6>
                <Text|text=$STM(ITEMCOUNT_绑定元宝)|x=55|y=515|size=18>
            ]]},

        }
    end

    for k, v in pairs(bag_btns) do
        addbutton(actor, v[1], v[2], v[3])
    end

    LoginTrigger.UpdatePlayerBtn(actor)
    local job_awake_class = IncludeNpcClass("JobAwake")
    if job_awake_class then
        job_awake_class:FlushPlayerBtn(actor)
    end
    
    -- 技能面板按钮
    local skill_str = [[
        <Button|x=70|y=-47|width=104|height=33|nimg=public/1900000680.png|pimg=public/1900000680_1.png|color=246|size=18|text=技能强化|link=@on_skill_strengthen>
    ]]
    if is_pc then
        skill_str = [[]]
    end
    addbutton(actor, 6, 10000, skill_str)

    -- 邮件勾选框
    local mail_str = [[
        <Layout|x=530|y=84|width=190|height=30|link=@om_change_state>
        <Img|x=530.0|y=85.0|img=custom/0xun/sec%s1.png>
        <RText|x=560.0|y=90|size=18|text=<获得邮件自动打开/FCOLOR=250>>
    ]]
    if is_pc then
        mail_str = [[
            <Layout|x=230|y=354|width=190|height=30|link=@om_change_state>
            <Img|x=230.0|y=355.0|img=custom/0xun/sec%s1.png>
            <RText|x=260.0|y=360|size=16|text=<获得邮件自动打开/FCOLOR=250>>
        ]]
    end
    mail_str = string.format(mail_str, VarApi.getPlayerUIntVar(actor, "U_auto_open_mail"))
    addbutton(actor, 14, 100, mail_str)

    -- 道士自动召唤
    LoginTrigger.UpdateDaoShiCallBtn(actor)
    --快捷买药
    LoginTrigger.QuickBuy(actor)
    -- 万倍高爆
    OtherTrigger.showAddButton(actor)

    -- 加权限
    local account_id = getconst(actor, "<$USERACCOUNT>")
    if isInTable(GMWhiteList, account_id) then
        setgmlevel(actor, 10)
    end

    -- GM按钮
    local server_id = GetServerIDX()
    if server_id < 10000 and isInTable(GMWhiteList, account_id) then
        local gm_str = "<Button|a=0|x=10|y=-50|nimg=public/gm/cs1.png|color=255|size=18|link=@call_gm_func>"
        addbutton(actor, 105, 105, gm_str)

        -- 主界面测试按钮
        -- local test_btn = {
        --     {102, 100000,"<Button|a=0|x=-885|y=280|nimg=public/1900000652.png|text=测试1|color=255|size=18|link=@call_test_func,1>"},
        --     {102, 100001,"<Button|a=0|x=-885|y=320|nimg=public/1900000652.png|text=测试2|color=255|size=18|link=@call_test_func,2>"},
        -- }
        -- for k, v in pairs(test_btn) do
        --     addbutton(actor, v[1], v[2], v[3])
        -- end
    end
end
function LoginTrigger.UpdatePlayerBtn(actor, id)
    delbutton(actor, 2, 10000)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    local x1 = -38
    local x2 = -34
    if is_pc then
        x1 = -45
        x2 = -40
    end
    local index = id or VarApi.getPlayerUIntVar(actor, "U_role_btn_index")
    if 0 >= index then
        index = 1
    end
    local role_str = RoleBtnDefine[index] or RoleBtnDefine[1]
    -- 只要进了2大陆就全部显示
    if VarApi.getPlayerUIntVar(actor,"U_bigMap") >= 2 then
        role_str = RoleBtnDefine[5]
    end
    role_str = string.format(role_str, x1, x2, x2, x2, x2, x2)
    addbutton(actor, 2, 10000, role_str)
end

-- 道士自动召唤
function LoginTrigger.UpdateDaoShiCallBtn(actor)
    delbutton(actor, 302, 1000)
    local job = getbaseinfo(actor, 7)
    if job == 2 then
        local open_state = VarApi.getPlayerUIntVar(actor, "U_daoshi_auto_call")
        local auto_str = [[
            <Text|children={an}|x=500|y=270|outline=1|color=255|size=16|text=自动召唤>
        ]]
        local pos_x = 122
        if getconst(actor,"<$CLIENTFLAG>") == "1" then
            auto_str = [[
                <Text|children={an}|x=420|y=270|outline=1|color=255|size=13|text=自动召唤>
            ]]
            pos_x = 105
        end
        if open_state == 0 then
            auto_str = auto_str .. "<Button|id=an|x=%s|y=0|nimg=custom/off1.png|link=@auto_call_open>"
        else
            auto_str = auto_str .. "<Button|id=an|x=%s|y=0|nimg=custom/on1.png|link=@auto_call_open>"
        end
        auto_str = string.format(auto_str, pos_x)
        addbutton(actor, 302, 1000, auto_str)
    end
end
function auto_call_open(actor)
    local open_state = VarApi.getPlayerUIntVar(actor, "U_daoshi_auto_call")
    if open_state == 1 then
        open_state = 0
    else
        open_state = 1
    end
    VarApi.setPlayerUIntVar(actor, "U_daoshi_auto_call", open_state, false)
    LoginTrigger.UpdateDaoShiCallBtn(actor)
    if open_state == 1 then
        ontimer887(actor)
    end
end
--保护界面购买药品
function LoginTrigger.QuickBuy(actor)
    delbutton(actor, 303, 303001)
    local is_pc =  getconst(actor,"<$CLIENTFLAG>") == "1"
    local height = is_pc and 170 or 220
    local auto_str = [[
        <ListView|children={1,2,3,4}|x=25|y=200|width=680|height=%s|direction=1|bounce=0|margin=-30|cantouch=1>
        <Layout|id=1|children={1_1,1_2,1_3,1_4,1_5,1_6,1_7,1_8}|width=680|height=100>
        <ItemShow|id=1_1|x=0|y=0|width=70|height=70|itemid=10569|itemcount=1|showtips=1|bgtype=1>
        <Text|id=1_2|x=130|y=15|a=4|outline=1|color=255|size=16|text=拥有数量：%s>
        <Text|id=1_3|x=130|y=45|a=4|outline=1|color=255|size=16|text=售价：1元宝>
        <Img|id=1_4|x=220|y=20|img=public/1900000676.png>
        <Input|id=1_5|x=220|y=20|width=73|height=31|rotate=0|inputid=1|color=255|isChatInput=0|size=16|type=0|text=%s>
        <Img|id=1_6|x=400|y=20||width=30|height=30|img=%s|link=@change_auto_state,1>
        <Text|id=1_7|x=470|y=33|a=4|outline=1|color=255|size=16|text=自动购买>
        <Button|id=1_8|x=300|y=20|nimg=public/zhunxing20.png|submitInput=1|link=@set_auto_num,1>
        

        <Layout|id=2|children={2_1,2_2,2_3,2_4,2_5,2_6,2_7,2_8}|width=680|height=100>
        <ItemShow|id=2_1|x=0|y=0|width=70|height=70|itemid=10571|itemcount=1|showtips=1|bgtype=1>
        <Text|id=2_2|x=130|y=15|a=4|outline=1|color=255|size=16|text=拥有数量：%s>
        <Text|id=2_3|x=130|y=45|a=4|outline=1|color=255|size=16|text=售价：2元宝>
        <Img|id=2_4|x=220|y=20|img=public/1900000676.png>
        <Input|id=2_5|x=220|y=20|width=73|height=31|rotate=0|inputid=2|color=255|isChatInput=0|size=16|type=0|text=%s>
        <Img|id=2_6|x=400|y=20||width=30|height=30|img=%s|link=@change_auto_state,2>
        <Text|id=2_7|x=470|y=33|a=4|outline=1|color=255|size=16|text=自动购买>
        <Button|id=2_8|x=300|y=20|nimg=public/zhunxing20.png|submitInput=2|link=@set_auto_num,2>

        <Layout|id=3|children={3_1,3_2,3_3,3_4,3_5,3_6,3_7,3_8}|width=680|height=100>
        <ItemShow|id=3_1|x=0|y=0|width=70|height=70|itemid=10572|itemcount=1|showtips=1|bgtype=1>
        <Text|id=3_2|x=130|y=15|a=4|outline=1|color=255|size=16|text=拥有数量：%s>
        <Text|id=3_3|x=130|y=45|a=4|outline=1|color=255|size=16|text=售价：5元宝>
        <Img|id=3_4|x=220|y=20|img=public/1900000676.png>
        <Input|id=3_5|x=220|y=20|width=73|height=31|rotate=0|inputid=3|color=255|isChatInput=0|size=16|type=0|text=%s>
        <Img|id=3_6|x=400|y=20||width=30|height=30|img=%s|link=@change_auto_state,3>
        <Text|id=3_7|x=470|y=33|a=4|outline=1|color=255|size=16|text=自动购买>
        <Button|id=3_8|x=300|y=20|nimg=public/zhunxing20.png|submitInput=3|link=@set_auto_num,3>

        <Layout|id=4|children={4_1,4_2,4_3,4_4,4_5,4_6,4_7,4_8}|width=680|height=100>
        <ItemShow|id=4_1|x=0|y=0|width=70|height=70|itemid=10573|itemcount=1|showtips=1|bgtype=1>
        <Text|id=4_2|x=130|y=15|a=4|outline=1|color=255|size=16|text=拥有数量：%s>
        <Text|id=4_3|x=130|y=45|a=4|outline=1|color=255|size=16|text=售价：10元宝>
        <Img|id=4_4|x=220|y=20|img=public/1900000676.png>
        <Input|id=4_5|x=220|y=20|width=73|height=31|rotate=0|inputid=4|color=255|isChatInput=0|size=16|type=0|text=%s>
        <Img|id=4_6|x=400|y=20||width=30|height=30|img=%s|link=@change_auto_state,4>
        <Text|id=4_7|x=470|y=33|a=4|outline=1|color=255|size=16|text=自动购买>
        <Button|id=4_8|x=300|y=20|nimg=public/zhunxing20.png|submitInput=4|link=@set_auto_num,4>
        ]]
    local value1 = VarApi.getPlayerUIntVar(actor, "U_auto_buy_1") 
    local value2 = VarApi.getPlayerUIntVar(actor, "U_auto_buy_2") 
    local value3 = VarApi.getPlayerUIntVar(actor, "U_auto_buy_3") 
    local value4 = VarApi.getPlayerUIntVar(actor, "U_auto_buy_4") 
    local img1_path = value1 <= 0 and  "public/000263.png" or "public/000266.png"
    local img2_path = value2 <= 0 and  "public/000263.png" or "public/000266.png"
    local img3_path = value3 <= 0 and  "public/000263.png" or "public/000266.png"
    local img4_path = value4 <= 0 and  "public/000263.png" or "public/000266.png"
    local num1 = VarApi.getPlayerUIntVar(actor, "U_auto_buy_num_1") 
    local num2 = VarApi.getPlayerUIntVar(actor, "U_auto_buy_num_2") 
    local num3 = VarApi.getPlayerUIntVar(actor, "U_auto_buy_num_3") 
    local num4 = VarApi.getPlayerUIntVar(actor, "U_auto_buy_num_4") 
    auto_str = string.format(auto_str,height,getbagitemcount(actor,"疗伤药"),num1,img1_path,getbagitemcount(actor,"大还丹"),num2,img2_path,
    getbagitemcount(actor,"大补鸡"),num3,img3_path,getbagitemcount(actor,"雪莲"),num4,img4_path)
    addbutton(actor, 303, 303001, auto_str)
end
function set_auto_num(actor,index)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state <= 0 then
        return Sendmsg9(actor, "ffffff", "请先开通盟重令", 1)  
    end
    index = tonumber(index)
    local num = getconst(actor,  string.format("<$NPCINPUT(%s)>",index))
    if tonumber(num) == nil then
        return Sendmsg9(actor, "ffffff", "请正确输入数量", 1) 
    end
    VarApi.setPlayerUIntVar(actor, "U_auto_buy_num_"..index,num) 
    LoginTrigger.QuickBuy(actor)
end
function change_auto_state(actor,index)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state <= 0 then
        return Sendmsg9(actor, "ffffff", "请先开通盟重令", 1)  
    end
    index = tonumber(index)
    if VarApi.getPlayerUIntVar(actor, "U_auto_buy_num_"..index) <= 0 then
        return Sendmsg9(actor, "ffffff", "请先设置自动购买数量", 1)  
    end
    local state = VarApi.getPlayerUIntVar(actor, "U_auto_buy_"..index) 
    if state > 0 then
        VarApi.setPlayerUIntVar(actor, "U_auto_buy_"..index,0) 
    else
        VarApi.setPlayerUIntVar(actor, "U_auto_buy_"..index,1) 
    end
    LoginTrigger.QuickBuy(actor)
end
-- 技能强化
function on_skill_strengthen(actor)
    local class = IncludeNpcClass("SkillReinforce")
    if class then
        class:click(actor)
    end
end

-- 改变邮件自动打开状态
function om_change_state(actor)
    delbutton(actor, 14, 100)
    local state = VarApi.getPlayerUIntVar(actor, "U_auto_open_mail")
    if state == 1 then
        state = 0
    else
        state = 1
    end
    VarApi.setPlayerUIntVar(actor, "U_auto_open_mail", state, false)
    local mail_str = [[
        <Layout|x=530|y=84|width=190|height=30|link=@om_change_state>
        <Img|x=530.0|y=85.0|img=custom/0xun/sec%s1.png>
        <RText|x=560.0|y=90|size=18|text=<获得邮件自动打开/FCOLOR=250>>
    ]]
    if getconst(actor,"<$CLIENTFLAG>") == "1" then
        mail_str = [[
            <Layout|x=230|y=354|width=190|height=30|link=@om_change_state>
            <Img|x=230.0|y=355.0|img=custom/0xun/sec%s1.png>
            <RText|x=260.0|y=360|size=16|text=<获得邮件自动打开/FCOLOR=250>>
        ]]
    end
    mail_str = string.format(mail_str, state)
    addbutton(actor, 14, 100, mail_str)
end

function rank_page(actor, page)
end

function go_home(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end       
    local go_hone_item = {"盟重传送石"}
    local item_name = nil
    for k, v in pairs(go_hone_item) do
        local item_num = getbagitemcount(actor, v, 0)
        if item_num > 0 then
            item_name = v
            break
        end
    end
    if item_name then
        eatitem(actor,item_name, 1)
    else
        Sendmsg9(actor, "ffffff", "盟重传送石数量不足!", 1)
        return
    end
    openhyperlink(actor, 24, 2)
end

function go_random(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end
    local go_hone_item = {"随机传送石"}
    local item_name = nil
    for k, v in pairs(go_hone_item) do
        local item_num = getbagitemcount(actor, v, 0)
        if item_num > 0 then
            item_name = v
            break
        end
    end
    if item_name then
        eatitem(actor, item_name, 1)
    else
        Sendmsg9(actor, "ffffff", "随机传送石数量不足!", 1)
        return
    end
end

-- 天命
function role_tianming(actor)
    local class = IncludeNpcClass("BloodlineAwaken")
    if class then
        class:click(actor)
    end
end
-- 血脉
function role_wsxuemai(actor)
    local class = IncludeNpcClass("WsBloodLineAwaken")
    if class then
        class:click(actor)
    end
end
-- 筋脉
function role_jinmai(actor)
    lualib:ShowNpcUi(actor, "PulseOBJ", "")
end

-- 秘术
function role_mishu(actor)
    local npc_class = IncludeNpcClass("FengShuiOccult")
    if npc_class then
        npc_class:click(actor)
    end
end
-- 专属
function role_zhuanshu(actor)
    lualib:ShowNpcUi(actor, "ExclusiveEquip")
end

-- gm 入口
function call_gm_func(actor)
    if check_gmlevel(actor) then return end
    local server_id = GetServerIDX()
    if server_id < 10000 then
        GmBackSystem.showSystem(actor)
    else
        GmBackSystem.password(actor)
    end
end

function get_world_map_str(actor)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    local WorldMapCfg = GetConfig("WorldMapMoveCfg")
    local tmp_tab = {}
    for index, v in ipairs(WorldMapCfg or {}) do
        tmp_tab[#tmp_tab + 1] = v
    end
    local world_str = [[
        <Img|x=15|y=45|esc=0|img=private/minimap/word/wordmapbg.png>
        <Button|a=0|x=487|y=50|nimg=private/minimap/close.png|color=255|size=18|link=@close_world_ui>
    ]]
    local img = "<Img|x=15|y=45|grey=%s|esc=0|img=private/minimap/word/%s.png>"
    local btn = "<Button|a=0|x=%s|y=%s|nimg=private/minimap/word/%s.png|grey=%s|link=@world_map_move,%s>"
    local img_str = ""
    local btn_str = ""
    if is_pc then
        world_str = [[
            <Img|x=5|y=40|esc=0|img=private/minimap/word/wordmapbg.png>
            <Button|a=0|x=477|y=45|nimg=private/minimap/close.png|color=255|size=18|link=@close_world_ui>
        ]]
        img = "<Img|x=5|y=40|grey=%s|esc=0|img=private/minimap/word/%s.png>"
        btn = "<Button|a=0|x=%s|y=%s|nimg=private/minimap/word/%s.png|grey=%s|link=@world_map_move,%s>"
    end
    for index, v in ipairs(tmp_tab) do
        img_str = img_str .. string.format(img, v.grey or 0, v.img)
        btn_str = btn_str .. string.format(btn, is_pc and v.btnx - 10 or v.btnx, is_pc and v.btny - 5 or v.btny, v.btn, v.grey or 0,v.key_name)
    end
    return world_str .. img_str .. btn_str
end

-- op_type: 1.世界地图  2.记忆传送   3.定点传送 
function call_map_func(actor, op_type)
    op_type = tonumber(op_type)
    delbutton(actor, 8, 888)
    delbutton(actor, 8, 999)
    if 1 == op_type then
        local world_str = get_world_map_str(actor)
        addbutton(actor, 8, 999, world_str)
    elseif op_type == 2 then
        -- 记忆传送
        local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
        local point_str = [[
            <Img|x=15|y=45|esc=0|img=private/minimap/jybg.png>
            <Button|a=0|x=487|y=47|nimg=private/minimap/close.png|color=255|size=18|link=@close_world_ui>
            <RText|x=127.0|y=133|size=18|text=%s>
            <RText|x=127.0|y=201|size=18|text=%s>
            <RText|x=127.0|y=269|size=18|text=%s>
            <RText|x=127.0|y=337|size=18|text=%s>
            <RText|x=127.0|y=405|size=18|text=%s>
            <Button|a=0|x=332|y=122|nimg=private/minimap/jyji1.png|pimg=private/minimap/jyji2.png|color=255|size=18|link=@record_map,1>
            <Button|a=0|x=432|y=122|nimg=private/minimap/jycs1.png|pimg=private/minimap/jycs2.png|color=255|size=18|link=@record_map_move,1>
            <Button|a=0|x=332|y=190|nimg=private/minimap/jyji1.png|pimg=private/minimap/jyji2.png|color=255|size=18|link=@record_map,2>
            <Button|a=0|x=432|y=190|nimg=private/minimap/jycs1.png|pimg=private/minimap/jycs2.png|color=255|size=18|link=@record_map_move,2>  
            <Button|a=0|x=332|y=258|nimg=private/minimap/jyji1.png|pimg=private/minimap/jyji2.png|color=255|size=18|link=@record_map,3>
            <Button|a=0|x=432|y=258|nimg=private/minimap/jycs1.png|pimg=private/minimap/jycs2.png|color=255|size=18|link=@record_map_move,3> 
            <Button|a=0|x=332|y=326|nimg=private/minimap/jyji1.png|pimg=private/minimap/jyji2.png|color=255|size=18|link=@record_map,4>
            <Button|a=0|x=432|y=326|nimg=private/minimap/jycs1.png|pimg=private/minimap/jycs2.png|color=255|size=18|link=@record_map_move,4>
            <Button|a=0|x=332|y=394|nimg=private/minimap/jyji1.png|pimg=private/minimap/jyji2.png|color=255|size=18|link=@record_map,5>
            <Button|a=0|x=432|y=394|nimg=private/minimap/jycs1.png|pimg=private/minimap/jycs2.png|color=255|size=18|link=@record_map_move,5>  
            <RText|x=37.0|y=445|size=18|text=<提示: 开通盟重令特权可记录5个传送点, 沙巴克丶跨服禁止使用!/FCOLOR=251>>
        ]]
        if is_pc then
            point_str = [[
                <Img|x=5|y=40|esc=0|img=private/minimap/jybg.png>
                <Button|a=0|x=477|y=45|nimg=private/minimap/close.png|color=255|size=18|link=@close_world_ui>
                <RText|x=117.0|y=130|size=18|text=%s>
                <RText|x=117.0|y=209|size=18|text=%s>
                <RText|x=117.0|y=277|size=18|text=%s>
                <RText|x=117.0|y=345|size=18|text=%s>
                <RText|x=117.0|y=413|size=18|text=%s>
                <Button|a=0|x=322|y=117|nimg=private/minimap/jyji1.png|pimg=private/minimap/jyji2.png|color=255|size=18|link=@record_map,1>
                <Button|a=0|x=422|y=117|nimg=private/minimap/jycs1.png|pimg=private/minimap/jycs2.png|color=255|size=18|link=@record_map_move,1>
                <Button|a=0|x=322|y=185|nimg=private/minimap/jyji1.png|pimg=private/minimap/jyji2.png|color=255|size=18|link=@record_map,2>
                <Button|a=0|x=422|y=185|nimg=private/minimap/jycs1.png|pimg=private/minimap/jycs2.png|color=255|size=18|link=@record_map_move,2>  
                <Button|a=0|x=322|y=253|nimg=private/minimap/jyji1.png|pimg=private/minimap/jyji2.png|color=255|size=18|link=@record_map,3>
                <Button|a=0|x=422|y=253|nimg=private/minimap/jycs1.png|pimg=private/minimap/jycs2.png|color=255|size=18|link=@record_map_move,3> 
                <Button|a=0|x=322|y=321|nimg=private/minimap/jyji1.png|pimg=private/minimap/jyji2.png|color=255|size=18|link=@record_map,4>
                <Button|a=0|x=422|y=321|nimg=private/minimap/jycs1.png|pimg=private/minimap/jycs2.png|color=255|size=18|link=@record_map_move,4>
                <Button|a=0|x=322|y=389|nimg=private/minimap/jyji1.png|pimg=private/minimap/jyji2.png|color=255|size=18|link=@record_map,5>
                <Button|a=0|x=422|y=389|nimg=private/minimap/jycs1.png|pimg=private/minimap/jycs2.png|color=255|size=18|link=@record_map_move,5>  
                <RText|x=32.0|y=440|size=18|text=<提示: 开通至尊特权可记录5个传送点, 沙巴克丶跨服禁止使用!/FCOLOR=251>>
            ]]
        end
        local record_map_str = VarApi.getPlayerTStrVar(actor, "T_record_map")
        local record_map = {}
        if "" == record_map_str then
            record_map = {"","","","",""}
        else
            record_map = json2tblex(record_map_str)
        end
        local format = "<%s/FCOLOR=255><%s/FCOLOR=250>"
        local tmp_tab = {}
        for k, v in pairs(record_map) do
            local str = v
            if v ~= "" then
                local _t = strsplit(v, ",")
                str = string.format(format, _t[1], " (" .._t[2] .. "," .. _t[3] .. ")")
            end
            tmp_tab[k] = str
        end
        local show_ui = string.format(point_str, unpack(tmp_tab))
        addbutton(actor, 8, 888, show_ui)
    else
        -- 定点传送
        move_point(actor)
    end
end
-- 世界传送
function world_map_move(actor, index)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end
    index = tonumber(index)
    if nil == index then
        return
    end
    if hasbuff(actor, 50000) then
        Sendmsg9(actor, "00ff00", "战斗中，请稍后操作", 9)
        return
    end
    local ret = false
    local WorldMapCfg = GetConfig("WorldMapMoveCfg")
    local cfg = WorldMapCfg[index]
    if cfg and cfg.npcid then
        local npc_id = cfg.npcid
        if npc_id == 0 then
            mapmove(actor, cfg.mapid, cfg.posx, cfg.posy,cfg.scope or 1)
            ret = true
        elseif npc_id == 1 then
            Sendmsg9(actor, "ffff00", "需要从【封魔谷】NPC传送进入", 9)
            return
        else
            local npc_class = IncludeNpcClass("MapMoveNpc")
            if npc_class then
                ret = npc_class:onMove(actor, npc_id, cfg.mapid, cfg.posx, cfg.posy, 99998)
            end
        end
    else
        Sendmsg9(actor, "ffffff", string.format("【%s】暂未开放", cfg.mapname), 9)
        return
    end
    if ret then
        delbutton(actor, 8, 888)
        delbutton(actor, 8, 999)
        openhyperlink(actor, 24, 2)
    end
end
-- 记录地图 record_id: 1.记录免费  
function record_map(actor, record_id)
    local map_name = getbaseinfo(actor, 45)
    local map_id = getbaseinfo(actor, 3)
    local x = getbaseinfo(actor, 4)
    local y = getbaseinfo(actor, 5)
    if getbaseinfo(object, 60) then
        Sendmsg9(actor, "ffffff", "沙巴克禁止使用!", 1)
        return
    end
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服地图禁止使用!", 1)
        return
    end
    if isInTable({"0150"}, map_id) then
        Sendmsg9(actor, "ffffff", "沙巴克禁止记录!", 1)
        return
    end
    if string.find(map_id, "王的遗迹") then
        Sendmsg9(actor, "ffffff", "当前地图禁止记录!", 1)
        return
    end
    local npc_class = IncludeNpcClass("MapMoveNpc")
    if npc_class then
        local npc_id, cfg = npc_class:checkRecordNpcId(actor, map_id)
        if nil == npc_id then
            local map_cfg = GetConfig("CanMapCruiseCfg")
            local v = map_cfg[map_id]
            if v then
                npc_id, cfg = npc_class:checkRecordNpcId(actor, v.checkmapid)
            end
        end
        if nil == npc_id or nil == cfg or (cfg.kuafu and cfg.kuafu >= 1) then
            Sendmsg9(actor, "ffffff", "当前地图禁止记录!", 1)
            return
        end
    end
    record_id = tonumber(record_id)
    local zztq = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if record_id > 1 and zztq == 0 then
        Sendmsg9(actor, "ffffff", "开通盟重令可记录5个传送点!", 1)
        return
    end
    local record_map_str = VarApi.getPlayerTStrVar(actor, "T_record_map")
    local record_map = {}
    if "" == record_map_str then
        record_map = {"","","","",""}
    else
        record_map = json2tblex(record_map_str)
    end
    record_map[record_id] = map_name .. "," .. x .. "," .. y .. "," .. map_id
    VarApi.setPlayerTStrVar(actor, "T_record_map", tbl2jsonex(record_map))
    call_map_func(actor, 2)
end
-- 记忆传送
function record_map_move(actor, record_id)   
    record_id = tonumber(record_id)
    if getbaseinfo(object, 60) then
        Sendmsg9(actor, "ffffff", "沙巴克禁止使用!", 1)
        return
    end    
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end
    if hasbuff(actor, 50000) then
        Sendmsg9(actor, "00ff00", "战斗中，请稍后操作", 9)
        return
    end
    local record_map_str = VarApi.getPlayerTStrVar(actor, "T_record_map")
    local record_map = {}
    if "" == record_map_str then
        record_map = {"","","","",""}
    else
        record_map = json2tblex(record_map_str)
    end    
    local map_info = record_map[record_id]
    if nil == map_info or "" == map_info then
        return
    end
    local tab = strsplit(map_info, ",")
    local map_id = tab[4]
    local npc_class = IncludeNpcClass("MapMoveNpc")
    if npc_class then
        local npc_id, cfg = npc_class:checkRecordNpcId(actor, map_id)
        if nil == npc_id then
            local map_cfg = GetConfig("CanMapCruiseCfg")
            local v = map_cfg[map_id]
            if v then
                npc_id, cfg = npc_class:checkRecordNpcId(actor, v.checkmapid)
            end
        end
        if npc_class:onMove(actor, npc_id, map_id, tonumber(tab[2]), tonumber(tab[3]), 99999) then
            mapmove(actor,map_id,tonumber(tab[2]), tonumber(tab[3]))
        end
    end

    openhyperlink(actor, 24, 2)
end
-- 定点传送
function move_point(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服区域禁止使用！", 1)
        return
    end
    local maps = {"天降财宝", "激情派对", "武林至尊", "夺宝奇兵", "行会战场","乱斗之王1", "0150", "跨服沙巴克", "狂暴霸主"}
    local map_id = getbaseinfo(actor, 3)
    if checkmirrormap(map_id) or isInTable(maps, map_id) then
        Sendmsg9(actor, "ffffff", "禁止使用传送功能!", 1)
        return
    end
    if hasbuff(actor, 50000) then
        Sendmsg9(actor, "00ff00", "战斗中，请稍后操作", 9)
        return
    end
    if string.find(map_id, "高爆") then
        Sendmsg9(actor, "ffffff", "禁止使用传送功能!", 1)
        return
    end
    if not takeitem(actor, "飞行符", 1, 0, "定点传送消耗") then
        Sendmsg9(actor, "ff0000", "飞行符数量不足!", 1)
        return
    end
    mapmove(actor, map_id, getconst(actor, "<$ToPointX>"), getconst(actor, "<$ToPointY>"))
end
-- 关闭ui
function close_world_ui(actor)
    delbutton(actor, 8, 888)
    delbutton(actor, 8, 999)
end

-- op_type: 0.交易行 1.仓库  2.回收   3.整理  4.装扮图鉴   5.恶魔图鉴  6.销毁
function call_bag_func(actor, op_type)
    op_type = tonumber(op_type)
    if op_type == 0 then
        if checkkuafu(actor) then
            Sendmsg9(actor, "ffffff", "跨服区域无法使用!", 1)
            return
        end 
        if VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL) <= 0 then
            Sendmsg9(actor, "ffffff", "开通 [盟重令] 后才可使用!", 1)
            return
        end
        openhyperlink(actor, 35, 0)
    elseif op_type == 1 then
        openstorage(actor)
    elseif op_type == 2 then
        local npc_class = IncludeNpcClass("RecycleNpc")
        if npc_class then
            npc_class:click(actor)
        end
    elseif op_type == 3 then
        refreshbag(actor)
    elseif op_type == 4 then
        local npc_class = IncludeNpcClass("EquipTuJian")
        if npc_class then
            npc_class:click(actor)
        end
    elseif op_type == 5 then
        local npc_class = IncludeNpcClass("DemonContract")
        if npc_class then
            npc_class:click(actor)
        end
    elseif op_type == 6 then
        VarApi.setPlayerUIntVar(actor, "U_item_collimator", 1, true)
    end
end

function _change_cs_state(actor)
end

function call_test_func(actor, op_type)
    op_type = tonumber(op_type)
    if op_type == 1 then
        --  addhpper(actor,"+",20)
        -- addhpper(actor,"+",100)
        -- addmpper(actor,"+",100)
        -- rangeharm(actor,getbaseinfo(actor,4),getbaseinfo(actor,5)
        -- ,1,0,2,5,0,0,0,2)
        -- openhyperlink(actor, 36, 0)
        -- seticon(actor, 9, 1, 46125, 0, 0, 1, 0, 1)
        -- sendmapmsg("hd_cfgc", '{"Msg":"测试发送地图消息!","FColor":249,"BColor":255,"Type":11,"Time":3,"SendName":"[提示]","SendId":"123"}')
        -- sendmsgnew(actor, 255,249, "测试主屏幕弹出公告!", 1, 5)
        -- ChuanQiPuBg.initPubg("hd_cfgc",  0)
        -- map(actor, ChuanQiPuBg.cfg.map_id)
        -- ChuanQiPuBg.startPubg(ChuanQiPuBg.cfg.map_id) -- 开启吃鸡
        -- addtocastlewarlistex("*")
        -- gmexecute("0","ForcedWallConQuestwar")
        -- Sendmsg9(actor, "ffffff", "所有行会加入攻城列表!", 1)
        -- 更新月光祈福排行榜

        -- local say_ui = [[
        --     <Img|children={11,22,33,44,55,66,77,88}|img=public/bg_npc_01.png|loadDelay=1|bg=1|reset=1|show=4>
        --     <Layout|id=11|x=545|y=0|width=80|height=80|link=@exit>
        --     <Button|id=22|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        --     <Text|id=33|x=25|y=20|size=16|color=255|text=每日活跃兑换奖励>
        --     <RText|id=44|x=25|y=45|color=255|size=16|text=哈哈哈<哈哈/FCOLOR=250>>
        --     <Text|id=55|x=25|y=70|color=251|size=16|text=【盟重令】兑换，仅需一半活跃点>
        --     <Button|id=66|x=50|y=120|nimg=public/1900000662.png|pimg=public/1900000663.png|text=前往开通|link=@on_open_alliance>
        --     <Button|id=77|x=210|y=120|nimg=public/1900000662.png|pimg=public/1900000663.png|text=确定|link=@on_open_alliance>
        --     <Button|id=88|x=370|y=120|nimg=public/1900000662.png|pimg=public/1900000663.png|text=取消|link=@exit>
        -- ]]
        -- say(actor, say_ui)
        -- OtherTrigger.showAddButton(actor)
    else
        -- local tab1={{101, 530,"<Button|ax=0.5|ay=0.5|x=300|y=240|nimg=custom/top/an22.png|link=@fast_step_jump>"}
        -- ,{101,531,"<COUNTDOWN|ax=0.5|x=300|y=240|size=18|count=1|outline=1|showWay=1|time=%s|color=250|link=@delay_del_fast_step>"}}
        -- local tab2={{101, 530,"<Button|ax=0.5|ay=0.5|x=360|y=220|nimg=custom/top/an22.png|link=@fast_step_jump>"}}
        -- local is_pc = getconst(actor,"<$CLIENTFLAG>") or 2
        -- for index, v in ipairs(tab1) do
        --     delbutton(actor,v[1],v[2])
        --     local temp=v[3]
        --     if index==2 then
        --         temp=string.format(temp,1800)
        --     end
        --     addbutton(actor,v[1],v[2],temp)
        -- end
        -- dummylogon(actor,"3",322,330,3,3,1,0,0,math.random(0,1))
        -- IncludeNpcClass("GodEquip"):click(actor)
        -- local cfg = GetConfig("DisguiseCfg")
        -- for i = 1, 7 do
        --     for index, value in ipairs(cfg[i]["item_arr"]) do
        --         -- VarApi.setPlayerTStrVar(actor,cfg[i].varStr,"",true)
        --         VarApi.setPlayerTStrVar(actor,cfg[i].varStr,value.."|"..VarApi.getPlayerTStrVar(actor,cfg[i].varStr),true)
        --     end
        -- end
        -- ChuanQiPuBg.gameOver(true)
        -- if castleinfo(5) then
        --     gmexecute("0","ForcedWallConQuestwar")
        -- end
        -- giveonitem(actor,21,"[经典]祖玛之盔",1,0,"")
    end
end