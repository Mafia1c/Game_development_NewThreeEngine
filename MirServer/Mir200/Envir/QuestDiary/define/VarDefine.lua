-- 引擎全局变量 engine
VarEngine = {}
VarEngine.ItemDescVar = "item_desc_info"    -- 物品显示自定义属性/备注信息固定用这个变量   新三端使用

-- 王的遗迹怪物爆率变量(直播服 100   正式服10)
VarEngine.G_dorp_rate = "G220"
VarEngine.MiningVar = {
    ["G400"] = 10,
    ["G401"] = 10,
    ["G402"] = 10,
    ["G403"] = 10,
    ["G411"] = 70,
}

-- 字符型系统变量 重启服务器保存.500个(A0 - A499) 存放在Mir200/GlobalVal.ini文件里面
VarEngine.SysOpLog = "A_backend_log"
VarEngine.ActivityState = "A_activityState"                -- 活动状态 
VarEngine.DropTreasure = "A_dropTreasure"                  -- 珍宝掉落


-- 数字型系统变量 重启服务器保存.500个(G0 - G499) 存放在Mir200/GlobalVal.ini文件里面
VarEngine.ServerRunTime = "G_ServerRunTime"            -- 开服时间  秒
VarEngine.OpenDay = "G_OpenDay"                          -- 开服天数
VarEngine.HeFuCount = "G_HeFuCount"                      -- 合服次数
VarEngine.KuangBaoDieCount = "G_KuangBaoDieCount"        -- 狂暴死亡次数
VarEngine.MonUpdateVar = {                               -- 怪物刷新时间
    ["G101"] = 60,
    ["G102"] = 60,
    ["G103"] = 60,
    ["G104"] = 60,
    ["G105"] = 60,
    ["G106"] = 60,
}

--  用来存玩家所有的变量
VarEngine.Var_Key_Value = "Var_Key_Value"

-- 玩家个人变量的一些定义
-- int型   返回值为int
VarUIntDef = {}
VarUIntDef.ZSTQ_LEVEL = "U_allianceOrder"                 -- 盟重令
VarUIntDef.RAMPAGE_STATE = "U_rampage_state"              -- 狂暴之力      >0.开启   0.未开启
VarUIntDef.TRUE_RECHARGE = "U_recharge_true"              -- 真实充值金额   总充值
VarUIntDef.DAY_RECHARGE = "J_DayRecharge"                 -- 今日充值金额  
VarUIntDef.ENTER_TIME = "U_first_enter_time"              -- 玩家第一次进入游戏时间
VarUIntDef.LOGIN_DAY = "U_login_day"                      -- 玩家累计登录天数
VarUIntDef.FirstRecharge = "U_firstRecharge_gift"             -- 首充豪礼 首充礼包


-- string型  返回值为string
VarTStrDef = {}
VarTStrDef.LookPlayer = "T_look_player_name"                    -- 查看别人装备
VarTStrDef.LookPlayerId = "T_look_player_id"                    -- 查看别人装备
VarTStrDef.ICON_0 = "T_icon_0"                        -- 角色0号位顶戴(特效id#称号名称) 作为称号顶戴用

--引擎个人变量 数字型 每晚自动12点重置,
VarJIntDef = {}
VarJIntDef.OnLine_TimeStamp = "J_OnLine_TimeStamp"                  --玩家今日在线时长

-- gm 白名单
GMWhiteList = {
    "2010217372", --#regioin Mafia
    "2026824461", -- mir.wu  
    "1354735642", --#region luzhan
    "2028690495", --#region maxin
    "3011015",    -- 老白1
    "arey198",    -- 老白2
    "bvn321",     -- mir.wu
    "Mafia1z",    -- #regioin Mafia
    "maxin4",     -- #region maxin
    "luzhan31528", --#region luzhan

    -- 新增白名单
    "1618175020",
    "40166215",
    "47200336",
    "41546800",
    "1053102755",
    "27556086",
    "1861107",

    "1643555260",
    "1197573351",
    "1303285924",

    "1902857415",
    "1089158622",
    "1633378286",

    -- 联运白名单
    "2710_1102_1768362161",
    "2710_1107_1768362352",
    "2710_861_1768309646",
    "2710_1112_1768362674",
    
    "2710_783_1768302200",
    "2710_1266_1768381031",
    "2710_1224_1768376379",
    "2710_1300_1768384696",
    "2710_1311_1768385072",
    "2710_200_1767950440",
    "2710_2072_1768469066",
    "2710_1411_1768390725",
    "2710_1420_1768392088",
}


-- 角色面板按钮
RoleBtnDefine = {
    [1] = [[
        <Img|a=0|x=%s|y=150|img=custom/mbtn/mbg3.png>
        <Button|id=10001|a=0|x=%s|y=195|nimg=custom/mbtn/a11.png|pimg=custom/mbtn/a12.png|color=255|size=18|link=@role_tianming>
        <Button|id=10002|a=0|x=%s|y=255|nimg=custom/mbtn/jm1.png|pimg=custom/mbtn/jm2.png|color=255|size=18|link=@role_jinmai>
        <Button|id=10004|a=0|x=%s|y=315|nimg=custom/mbtn/a31.png|pimg=custom/mbtn/a32.png|color=255|size=18|link=@role_mishu>
    ]],
    [2] = [[
        <Img|a=0|x=%s|y=150|img=custom/mbtn/mbg3.png>
        <Button|id=10001|a=0|x=%s|y=195|nimg=custom/mbtn/a11.png|pimg=custom/mbtn/a12.png|color=255|size=18|link=@role_tianming>
        <Button|id=10002|a=0|x=%s|y=255|nimg=custom/mbtn/jm1.png|pimg=custom/mbtn/jm2.png|color=255|size=18|link=@role_jinmai>
        <Button|id=10004|a=0|x=%s|y=315|nimg=custom/mbtn/a31.png|pimg=custom/mbtn/a32.png|color=255|size=18|link=@role_mishu>
    ]],
    [3] = [[
        <Img|a=0|x=%s|y=100|img=custom/mbtn/mbg4.png>
        <Button|id=10001|a=0|x=%s|y=145|nimg=custom/mbtn/a11.png|pimg=custom/mbtn/a12.png|color=255|size=18|link=@role_tianming>
        <Button|id=10002|a=0|x=%s|y=205|nimg=custom/mbtn/jm1.png|pimg=custom/mbtn/jm2.png|color=255|size=18|link=@role_jinmai>
        <Button|id=10004|a=0|x=%s|y=265|nimg=custom/mbtn/a31.png|pimg=custom/mbtn/a32.png|color=255|size=18|link=@role_mishu>
        <Button|id=10005|a=0|x=%s|y=325|nimg=custom/mbtn/a41.png|pimg=custom/mbtn/a42.png|color=255|size=18|link=@role_zhuanshu>
    ]],
    [4] = [[
        <Img|a=0|x=%s|y=100|img=custom/mbtn/mbg4.png>
        <Button|id=10001|a=0|x=%s|y=145|nimg=custom/mbtn/a11.png|pimg=custom/mbtn/a12.png|color=255|size=18|link=@role_tianming>
        <Button|id=10002|a=0|x=%s|y=205|nimg=custom/mbtn/jm1.png|pimg=custom/mbtn/jm2.png|color=255|size=18|link=@role_jinmai>
        <Button|id=10004|a=0|x=%s|y=265|nimg=custom/mbtn/a31.png|pimg=custom/mbtn/a32.png|color=255|size=18|link=@role_mishu>
        <Button|id=10005|a=0|x=%s|y=325|nimg=custom/mbtn/a41.png|pimg=custom/mbtn/a42.png|color=255|size=18|link=@role_zhuanshu>
    ]],
    [5] = [[
        <Img|a=0|x=%s|y=100|img=custom/mbtn/mbg4.png>
        <Button|id=10001|a=0|x=%s|y=145|nimg=custom/mbtn/a11.png|pimg=custom/mbtn/a12.png|color=255|size=18|link=@role_tianming>
        <Button|id=10002|a=0|x=%s|y=205|nimg=custom/mbtn/jm1.png|pimg=custom/mbtn/jm2.png|color=255|size=18|link=@role_jinmai>
        <Button|id=10004|a=0|x=%s|y=265|nimg=custom/mbtn/a31.png|pimg=custom/mbtn/a32.png|color=255|size=18|link=@role_mishu>
        <Button|id=10005|a=0|x=%s|y=325|nimg=custom/mbtn/a41.png|pimg=custom/mbtn/a42.png|color=255|size=18|link=@role_zhuanshu>
    ]],
}
-- 跨服活动变量
ActivityVar = {
    "G_cross_dfxg_state",               -- 跨服世界  巅峰峡谷
    "G_cross_wxzc_state",               -- 跨服世界  无限战场
    "G_cross_yyjl_state",               -- 跨服世界  永夜降临
    "G_cross_emgc_state",               -- 跨服世界  恶魔广场
}


