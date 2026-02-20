-- ===================================== 版本功能GM后台 =============================================
GsBackFunc = {}
local gs_ui_tab = {
    "<Img|x=0|y=0|width=800|height=502|img=public/gm/1900000677.png|scale9r=5|show=4|bg=1|scale9b=5|scale9l=5|esc=0|scale9t=5>",
    "<Img|ay=0|x=134.0|y=503.0|width=2|height=451|esc=0|img=public/gm/line2.png>",
    "<Img|x=0|y=50|width=800|height=3|img=public/gm/line1.png|esc=0>",
    "<Text|x=20.0|y=14.0|size=18|color=255|text=GS后台>",
    "<Text|x=570.0|y=16.0|size=18|color=243|text=<$YEAR>年<$MONTH>月<$DAY>日  %s>",
    "<Button|x=772.0|y=2.0|size=18|color=255|nimg=public/gm/11.png|pimg=public/gm/12.png|link=@exit>",
    "<ListView|children={10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010}|x=8|y=55|width=130|height=442|direction=1|bounce=1|margin=5|reload=0>",
    "<Button|id=10000|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=角色信息|link=@gs_role_info>",
    "<Button|id=10001|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=装备发射器|link=@gs_give_equip>",
    "<Button|id=10002|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=变量丶货币|link=@gs_change_var>",
    "<Button|id=10003|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=区服信息|link=@gs_game_info>",
    -- "<Button|id=10004|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=一键重置|link=@gs_resert_live>",

    -- 日志按钮放最下面
    "<Button|id=10010|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=后台日志|link=@show_gs_backend_log>"
}
local gs_back_sys_ui = ""
for key, str in pairs(gs_ui_tab) do
    gs_back_sys_ui = gs_back_sys_ui .. str
end

local gs_page_ui = {
    -- 1. 角色信息
    [1] = [[
        <Text|x=390|y=60.0|size=18|color=251|text=【当前角色信息】>
        <Img|x=138.0|y=413.0|width=658|rotate=0|img=public/gm/line1.png|esc=0>
        <RText|x=590|y=455|size=18|text=[<GM: /FCOLOR=255><%s/FCOLOR=250>]>
        <Text|x=190.0|y=100.0|size=18|color=254|text=角色名称><RText|x=270.0|y=100.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=190.0|y=130.0|size=18|color=254|text=累计充值><RText|x=270.0|y=130.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=251>>
        <Text|x=190.0|y=160.0|size=18|color=254|text=今日充值><RText|x=270.0|y=160.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=251>>
        <Text|x=190.0|y=190.0|size=18|color=254|text=当前等级><RText|x=270.0|y=190.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=190.0|y=220.0|size=18|color=254|text=转生等级><RText|x=270.0|y=220.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=190.0|y=250.0|size=18|color=254|text=金币><RText|x=270.0|y=250.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=251>>
        <Text|x=190.0|y=280.0|size=18|color=254|text=元宝><RText|x=270.0|y=280.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=251>>
        <Text|x=190.0|y=310.0|size=18|color=254|text=灵符><RText|x=270.0|y=310.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=251>>
        <Text|x=190.0|y=340.0|size=18|color=254|text=直购点><RText|x=270.0|y=340.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=251>>
        <Text|x=190.0|y=370.0|size=18|color=254|text=充值金额><RText|x=270.0|y=370.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=251>>
        <Text|x=450.0|y=100.0|size=18|color=254|text=唯一ID><RText|x=530.0|y=100.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=450.0|y=130.0|size=18|color=254|text=所在地图><RText|x=530.0|y=130.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=450.0|y=160.0|size=18|color=254|text=当前坐标><RText|x=530.0|y=160.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=450.0|y=190.0|size=18|color=254|text=登录天数><RText|x=530.0|y=190.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=450.0|y=250.0|size=18|color=254|text=绑定金币><RText|x=530.0|y=250.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=450.0|y=280.0|size=18|color=254|text=绑定元宝><RText|x=530.0|y=280.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=450.0|y=310.0|size=18|color=254|text=绑定灵符><RText|x=530.0|y=310.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=151.0|y=425.0|size=18|color=7|text=输入角色名称:>
        <Img|x=152.0|y=460.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=154.0|y=463.0|width=158|height=25|rotate=0|inputid=1|color=255|isChatInput=0|size=16|type=0|place=请输入角色名称>
        <Button|x=330.0|y=450.0|size=18|nimg=public/gm/btnm3.png|color=249|submitInput=1|text=查询玩家|link=@gs_check_player> 

        <Button|x=730.0|y=90.0|size=18|nimg=public/gm/key_id.png|color=250|link=@gs_copy_id>
        <Button|x=670.0|y=220.0|size=18|nimg=public/gm/btnm3.png|color=249|text=货币查询|link=@@inputstring2013_0(输入格式：货币id或名称)>
        <Button|x=670.0|y=270.0|size=18|nimg=public/gm/btnm3.png|color=249|text=跟踪玩家|link=@gs_follow_obj>
        <Button|x=670.0|y=320.0|size=18|nimg=public/gm/btnm3.png|color=249|text=踢他下线|link=@gs_kick_offline> 
        <Button|x=670.0|y=370.0|size=18|nimg=public/gm/btnm3.png|color=249|text=权限设置|link=@@inputstring2000_0(输入格式：权限等级[0-10])> 
    ]],
    -- 装备发射器
    [2] = [[
        <Text|x=150.0|y=70.0|size=18|color=94|text=玩家名:>
        <Img|x=215.0|y=60.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=217.0|y=63.0|width=158|height=25|rotate=0|inputid=0|color=255|isChatInput=0|size=16|type=0|place=请输入玩家名称>

        <Text|x=150.0|y=120.0|size=18|color=94|text=道具名称:>
        <Img|x=235.0|y=110.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=237.0|y=113.0|width=158|height=25|rotate=0|inputid=1|color=255|isChatInput=0|size=16|type=0|place=请输入道具/货币名称>
        <Text|x=150.0|y=170.0|size=18|color=94|text=道具数量:>
        <Img|x=235.0|y=160.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=237.0|y=163.0|width=158|height=25|rotate=0|inputid=2|color=255|isChatInput=0|size=16|type=0|place=请输入道具/货币数量>

        <Button|x=155.0|y=220.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=发送道具|link=@gs_send_item>
        <Button|x=155.0|y=270.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=清理背包|link=@gs_clean_bag>
        <Button|x=155.0|y=320.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=清理货币|link=@gs_clean_money>
        <Button|x=155.0|y=370.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=清除所有属性|link=@gs_clean_attr>
        <Button|x=155.0|y=420.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=查字符串属性|link=@@inputstring3000_0(输入格式：字符串名称)>

        <Button|x=450.0|y=70.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=等级+1|link=@gs_op_level,1>
        <Button|x=580.0|y=70.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=0,1,2|text=等级-1|link=@gs_op_level,2>

        <Button|x=450.0|y=120.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=生命值+100|link=@gs_op_hp,1>
        <Button|x=580.0|y=120.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=0,1,2|text=生命值-100|link=@gs_op_hp,2>

        <Button|x=450.0|y=170.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=每秒回血+100|link=@gs_op_recover_hp,1>
        <Button|x=580.0|y=170.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=0,1,2|text=每秒回血-100|link=@gs_op_recover_hp,2>

        <Button|x=450.0|y=220.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=攻速+1|link=@gs_op_att_speed,1>
        <Button|x=580.0|y=220.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=0,1,2|text=攻速-1|link=@gs_op_att_speed,2>

        <Button|x=450.0|y=270.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=移速+1|link=@gs_op_move_speed,1>
        <Button|x=580.0|y=270.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=0,1,2|text=移速-1|link=@gs_op_move_speed,2>

        <Button|x=450.0|y=320.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=切割伤害+100|link=@gs_op_qiege,1>
        <Button|x=580.0|y=320.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=0,1,2|text=切割伤害-100|link=@gs_op_qiege,2>

        <Button|x=450.0|y=370.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=对人真伤+100|link=@gs_op_attack,1>
        <Button|x=580.0|y=370.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=0,1,2|text=对人真伤-100|link=@gs_op_attack,2>

        <Button|x=450.0|y=420.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=攻击吸血+1|link=@gs_op_attack_addhp,1>
        <Button|x=580.0|y=420.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=0,1,2|text=攻击吸血-1|link=@gs_op_attack_addhp,2>
    ]],
    -- 变量修改
    [3] = [[
        <Text|x=150.0|y=70.0|size=18|color=94|text=玩家名:>
        <Img|x=215.0|y=60.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=217.0|y=63.0|width=158|height=25|rotate=0|inputid=0|color=255|isChatInput=0|text=%s|size=16|type=0|place=请输入玩家名称>
        <Text|x=150.0|y=120.0|size=18|color=94|text=变量名:>
        <Img|x=215.0|y=110.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=217.0|y=113.0|width=158|height=25|rotate=0|inputid=1|color=255|isChatInput=0|size=16|type=0|place=请输入玩家变量名>
        <Text|x=150.0|y=170.0|size=18|color=94|text=变量值:>
        <Img|x=215.0|y=160.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=217.0|y=163.0|width=158|height=25|rotate=0|inputid=2|color=255|isChatInput=0|size=16|type=0|place=请输入玩家变量值>
        <Button|x=145.0|y=220.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=查询玩家变量|link=@find_player_var>
        <Button|x=265.0|y=220.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=0,1,2|text=修改玩家变量|link=@change_player_var>
        <Button|x=145.0|y=260.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2|text=查询玩家buff|link=@find_player_buff_var>


        <Text|x=450.0|y=120.0|size=18|color=94|text=道具名称:>
        <Img|x=535.0|y=110.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=537.0|y=113.0|width=158|height=25|rotate=0|inputid=3|color=255|isChatInput=0|size=16|type=0|place=请输入道具/货币名称>
        <Text|x=450.0|y=170.0|size=18|color=94|text=道具数量:>
        <Img|x=535.0|y=160.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=537.0|y=163.0|width=158|height=25|rotate=0|inputid=4|color=255|isChatInput=0|size=16|type=0|place=请输入道具/货币数量>
        <Button|x=448.0|y=220.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=0,3,4|text=查询玩家道具|link=@find_player_item>
        <Button|x=580.0|y=220.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=0,3,4|text=修改玩家道具|link=@change_player_item>        
        
        <Img|x=138.0|y=300.0|width=658|rotate=0|img=public/gm/line1.png|esc=0>

        <Text|x=150.0|y=330.0|size=18|color=94|text=系统变量名:>
        <Img|x=265.0|y=320.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=267.0|y=323.0|width=158|height=25|rotate=0|inputid=5|color=255|isChatInput=0|size=16|type=0|place=请输入系统变量名>
        <Text|x=150.0|y=380.0|size=18|color=94|text=系统变量值:>
        <Img|x=265.0|y=370.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=267.0|y=373.0|width=158|height=25|rotate=0|inputid=6|color=255|isChatInput=0|size=16|type=0|place=请输入系统变量值>
        <Button|x=450.0|y=320.0|size=16|nimg=public/gm/btnm3.png|color=250|submitInput=5,6|text=查询系统变量|link=@find_sys_var>
        <Button|x=450.0|y=370.0|size=16|nimg=public/gm/btnm3.png|color=249|submitInput=5,6|text=修改系统变量|link=@change_sys_var>
    ]],
    -- 区服信息
    [4] = [[
        <Text|x=190.0|y=70.0|size=18|color=94|text=当前区服名称><Text|x=310.0|y=70.0|size=18|color=250|text=: %s>
        <Text|x=190.0|y=110.0|size=18|color=94|text=服务器ID><Text|x=310.0|y=110.0|size=18|color=250|text=: %s>
        <Text|x=190.0|y=150.0|size=18|color=94|text=开区天数><Text|x=310.0|y=150.0|size=18|color=250|text=: %s天>
        <Text|x=190.0|y=190.0|size=18|color=94|text=开区分钟><Text|x=310.0|y=190.0|size=18|color=250|text=: %s分钟>
        <Text|x=190.0|y=230.0|size=18|color=94|text=合区次数><Text|x=310.0|y=230.0|size=18|color=250|text=: %s>
        <Text|x=190.0|y=270.0|size=18|color=94|text=合服天数><Text|x=310.0|y=270.0|size=18|color=250|text=: %s>
        <Text|x=190.0|y=310.0|size=18|color=94|text=跨服连接状态><Text|x=310.0|y=310.0|size=18|color=250|text=: %s>
        <Text|x=190.0|y=350.0|size=18|color=94|text=攻城状态><Text|x=310.0|y=350.0|size=18|color=250|text=: %s>
        <Text|x=190.0|y=390.0|size=18|color=94|text=游戏ID><Text|x=310.0|y=390.0|size=18|color=250|text=: %s>
        <Text|x=450.0|y=70.0|size=18|color=94|text=在线人数><Text|x=550.0|y=70.0|size=18|color=250|text=: %s>

        <Button|x=400.0|y=340.0|size=18|nimg=public/gm/btnm3.png|color=251|text=开启攻城|link=@gs_shacheng_state,1> 
        <Button|x=520.0|y=340.0|size=18|nimg=public/gm/btnm3.png|color=251|text=结束攻城|link=@gs_shacheng_state,2> 

        <Button|x=660.0|y=70|size=16|nimg=public/gm/btnm3.png|color=250|text=修改开区天数|link=@@inputstring2010_0(输入格式：开区天数)>
        <Button|x=660.0|y=120|size=16|nimg=public/gm/btnm3.png|color=250|text=修改合服次数|link=@@inputstring2011_0(输入格式：合服次数)> 
        <Button|x=660.0|y=170|size=16|nimg=public/gm/btnm3.png|color=250|text=修改开服时间|link=@@inputstring2012_0(输入格式：开服时间)>
    ]],
    -- 重置
    [5] = [[
        <Button|x=180.0|y=60.0|size=16|nimg=public/gm/btnm3.png|color=251|text=诡异空间|link=@gs_reset_live_data,1> 
        <Button|x=180.0|y=105.0|size=16|nimg=public/gm/btnm3.png|color=251|text=地下矿洞|link=@gs_reset_live_data,2>
        <Button|x=180.0|y=150.0|size=16|nimg=public/gm/btnm3.png|color=251|text=幸运老板娘|link=@@inputstring6001_0(输入格式：清理的gs玩家名称)>
        <Button|x=180.0|y=195.0|size=16|nimg=public/gm/btnm3.png|color=251|text=重置全服首爆|link=@gs_reset_live_data,3> 
    ]]
}
GsBackFunc.op_player = nil                -- 当前查询的玩家   <$USERCOUNT>
GsBackFunc.cur_page = 1                   -- 当前UI页签
-- 显示GS后台
function GsBackFunc.showGsSystem(actor)
    if check_gmlevel(actor) then return end
    local wday_str = CHWeekDay(GetWday())
    gs_back_sys_ui = parsetext(gs_back_sys_ui, actor)
    gs_back_sys_ui = string.format(gs_back_sys_ui, "星期"..wday_str)
    GsBackFunc.op_player = nil
    GsBackFunc.cur_page = 1
    local tab = {0,0,0,0,0,0,0,0,0,0,0,0,"0,0",0,0,0,0}
    local name = getbaseinfo(actor, 1)
    local ui_str = string.format(gs_back_sys_ui..gs_page_ui[1], name, unpack(tab))
    say(actor, ui_str)
end
-- 密码验证
function GsBackFunc.password(actor)
    local ui_str = [[
        <Img|x=-503.0|y=-168.0|width=2000|height=2000|bg=1|img=public/1900000651_1.png>
        <Img|x=-503.0|y=-168.0|width=2000|height=2000|img=public/1900000651_1.png>
        <Img|x=-503.0|y=-168.0|width=2000|height=2000|img=public/1900000651_1.png>
        <Img|x=446.0|y=179.0|img=public/lock_2.png>
        <Text|x=484.0|y=230.0|color=255|size=40|text=限制登录>
        <Img|x=486.0|y=294.0|img=public/1900000668.png>
        <Img|x=486.0|y=294.0|img=public/1900000668.png>
        <Img|x=486.0|y=294.0|img=public/1900000668.png>
        <Input|x=492.0|y=297.0|width=158|height=25|rotate=0|inputid=1|color=255|isChatInput=0|size=16|maxcount=12|type=0|place=请输入密码>
        <Button|x=513.0|y=341.0|nimg=public/1900000660.png|submitInput=1|pimg=public/1900000661.png|size=18|color=2533|text=密码登录|link=@on_gs_password>
        <Text|x=25|y=20|color=255|size=22|text=Ver 1.0.0>
        <Layout|width=2000|height=2000>
    ]]
    say(actor,ui_str)
end
function on_gs_password(actor)
    local password = getconst(actor, "<$NPCINPUT(1)>")
    if isInTable({"3699"}, password) then
        close(actor)
        GsBackFunc.showGsSystem(actor)
    else
        Sendmsg9(actor, "ff0000", "密码错误", 9)
    end
end

-- 显示查询角色信息
function GsBackFunc.showRoleInfo(actor)
    if check_gmlevel(actor) then return end
    local obj = GsBackFunc.op_player
    if nil == obj then
        GsBackFunc.showGsSystem(actor)
        return
    end
    local tmp_tab = {}
    local obj_name = getbaseinfo(obj, 1)
    local gm_name = getbaseinfo(actor, 1)
    -- 货币id列表  金币  元宝  灵符  直购点  充值金额  绑定金币  绑定元宝  绑定灵符
    local money_ids = {1, 2, 7, 23, 22, 3, 4, 21}

    local total_recharge = VarApi.getPlayerUIntVar(obj, VarUIntDef.TRUE_RECHARGE)
    local today_recharge = VarApi.getPlayerJIntVar(obj, VarUIntDef.DAY_RECHARGE)
    local level = getbaseinfo(obj, 6)
    local re_level = getbaseinfo(obj, 39)
    local jin_bi = querymoney(obj, money_ids[1])
    local yuan_bao = querymoney(obj, money_ids[2])
    local ling_fu = querymoney(obj, money_ids[3])
    local zhi_gou_point = querymoney(obj, money_ids[4])
    local cz_point = querymoney(obj, money_ids[5]) or 0
    local account = GetUserAccount(obj)
    local map_name = getbaseinfo(obj, 45)
    local pos = getbaseinfo(obj, 4) .. "," .. getbaseinfo(obj, 5)
    local login_day = VarApi.getPlayerUIntVar(obj, VarUIntDef.LOGIN_DAY)
    local bind_jb = querymoney(obj, money_ids[6]) or 0
    local bind_yb = querymoney(obj, money_ids[7]) or 0
    local bind_lf = querymoney(obj, money_ids[8]) or 0
    tmp_tab = {gm_name, obj_name, total_recharge, today_recharge, level, re_level, jin_bi, yuan_bao, ling_fu, zhi_gou_point, cz_point, account, map_name, pos, login_day, bind_jb, bind_yb, bind_lf}
    local ui_str = string.format(gs_back_sys_ui..gs_page_ui[1], unpack(tmp_tab))
    say(actor, ui_str)
end
-- 查询玩家
function gs_check_player(actor)
    if check_gmlevel(actor) then return end
    local role_name = getconst(actor, "<$NPCINPUT(1)>")
    if "" == role_name then
        Sendmsg9(actor, "ffffff", "请输入要查询的玩家名称!", 1)
        return
    end
    local obj = getplayerbyname(role_name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    GsBackFunc.op_player = obj
    GsBackFunc.showRoleInfo(actor)
end
-- 复制玩家唯一ID
function gs_copy_id(actor)
    if check_gmlevel(actor) then return end
    local obj = GsBackFunc.op_player
    if nil == obj or "" == obj then
        return
    end
    local id = GetUserAccount(obj)
    mircopy(actor, id)
    Sendmsg9(actor, "ffffff", "复制成功: "..id, 1)
end

-- 跟踪玩家
function gs_follow_obj(actor)
    if check_gmlevel(actor) then return end
    local obj = GsBackFunc.op_player
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    local map_id = getbaseinfo(obj, 3)
    local pos_x = getbaseinfo(obj, 4)
    local pos_y = getbaseinfo(obj, 5)
    mapmove(actor, map_id, pos_x, pos_y)
end

-- 踢他下线
function gs_kick_offline(actor)
    if check_gmlevel(actor) then return end
    local obj = GsBackFunc.op_player
    if nil == obj or "" == obj then
        return
    end
    lualib:CallFuncByClient(obj, "GmBackSystem", "")
    RecordBackendOperationLog(actor, obj, "踢他下线", "", "")
end

-- 权限设置
function inputstring2000(actor)
    if check_gmlevel(actor) then return end
    local obj = GsBackFunc.op_player
    if nil == obj or "" == obj then
        return
    end
    local gm_level = getconst(actor,"<$NPCPARAMS(1,S22)>")
    gm_level = tonumber(gm_level)
    if "" == gm_level or nil == gm_level then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return
    end
    setgmlevel(obj, gm_level)
    Sendmsg9(actor, "ffffff", "设置成功!", 1)
    RecordBackendOperationLog(actor, obj, "设置权限", "权限等级", gm_level)
end
-- 修改开区天数
function inputstring2010(actor)
    if check_gmlevel(actor) then return end
    local num_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    local open_day = tonumber(num_str)
    if "" == num_str or nil == open_day then
        return
    end
    SetSysInt(VarEngine.OpenDay, open_day)
    Sendmsg9(actor, "ffffff", "修改成功, 当前开区天数: "..open_day .. " 天", 1)
    RecordBackendOperationLog(actor, actor, "修改开区天数", "开区天数", open_day)
end
-- 修改合服次数
function inputstring2011(actor)
    if check_gmlevel(actor) then return end
    local num_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if "" == num_str or nil == tonumber(num_str) then
        return
    end
    SetSysInt(VarEngine.HeFuCount, tonumber(num_str))
    local player_list = getplayerlst(1)
    for i, player in ipairs(player_list or {}) do
        lualib:CallFuncByClient(player, "HeFuCount", tonumber(num_str))
    end
    if tonumber(num_str) == 0 then
        SetSysInt("G_cross_dfxg_state", 0)
        SetSysInt("G_cross_wxzc_state", 0)
        SetSysInt("G_cross_yyjl_state", 0)
        SetSysInt("G_cross_emgc_state", 0)
    end
    Sendmsg9(actor, "ffffff", "修改成功, 当前合服次数: "..num_str .. " 次", 1)
    RecordBackendOperationLog(actor, actor, "修改合服次数", "合服次数", num_str)
end
-- 修改开服时间
function inputstring2012(actor)
    if check_gmlevel(actor) then return end
    local min = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if "" == min or nil == tonumber(min) then
        Sendmsg9(actor, "ffffff", "请正确输入时间", 1)
        return
    end
    SetSysInt(VarEngine.ServerRunTime, tonumber(min) * 60)
    Sendmsg9(actor, "ffffff", "修改成功, 当前开服时间: "..tonumber(min).."分钟", 1)
    RecordBackendOperationLog(actor, actor, "修改开服时间", "开服时间", min.."分钟")
end
-- 货币查询
function inputstring2013(actor)
    if check_gmlevel(actor) then return end
    local obj = GsBackFunc.op_player
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "缺少查询玩家!", 1)
        return
    end
    local name = getbaseinfo(obj, 1)
    local money_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    local money_id = tonumber(money_str)
    if nil == money_id then
        money_id = getstditeminfo(money_str, 0)
    else
        money_str = getstditeminfo(money_id, 1)
    end
    local value = querymoney(obj, money_id)
    messagebox(actor, "玩家 [" ..name.. "] " ..money_str .. "数量为: " .. value, "@______", "@______")
end

-- 角色信息
function gs_role_info(actor)
    if check_gmlevel(actor) then return end
    if getgmlevel(actor) ~= 10 then
        Sendmsg9(actor, "ff0000", "权限不足!", 1)
        return
    end
    if GsBackFunc.cur_page == 1 then
        return
    end
    GsBackFunc.cur_page = 1
    GsBackFunc.showRoleInfo(actor)
end

-- 装备发射器
function gs_give_equip(actor)
    if check_gmlevel(actor) then return end
    if GsBackFunc.cur_page == 2 then
        return
    end
    GsBackFunc.cur_page = 2
    local ui_str = gs_back_sys_ui..gs_page_ui[2]
    say(actor, ui_str)
end

-- 变量修改
function gs_change_var(actor)
    if check_gmlevel(actor) then return end
    if GsBackFunc.cur_page == 3 then
        return
    end
    GsBackFunc.cur_page = 3
    local obj = GsBackFunc.op_player
    local name = ""
    if obj then
        name = getbaseinfo(obj, 1)
    end
    local str = string.format(gs_page_ui[3], name)
    local ui_str = gs_back_sys_ui..str
    say(actor, ui_str)
end

-- 区服信息
function gs_game_info(actor)
    if check_gmlevel(actor) then return end
    if GsBackFunc.cur_page == 4 then
        return
    end
    GsBackFunc.cur_page = 4
    local server_name = GetServerName()
    local server_id = GetServerIDX()
    local open_day =  GetSysInt(VarEngine.OpenDay)
    local open_time = math.floor( GetSysInt(VarEngine.ServerRunTime) / 60)
    local hefu_count = GetSysInt(VarEngine.HeFuCount)
    local hefu_day = getconst("0", "<$HFDAYS>")
    local kuafu_str = kuafuconnected() and "已连接" or "未连接"
    local gongsha_str = castleinfo(5) and "攻沙中" or "未开启"
    local game_id = GetGameID()
    local onLine_num = getconst("0", "<$USERCOUNT>")
    local tmp_tab = {server_name, server_id, open_day, open_time, hefu_count, hefu_day, kuafu_str, gongsha_str, game_id, onLine_num}
    local str = string.format(gs_page_ui[4], unpack(tmp_tab))
    say(actor, gs_back_sys_ui..str)    
end

-- 一键重置
function gs_resert_live(actor)
    if check_gmlevel(actor) then return end
    if GsBackFunc.cur_page == 5 then
        return
    end
    GsBackFunc.cur_page = 5
    local ui_str = gs_back_sys_ui..gs_page_ui[5]
    say(actor, ui_str)
end

-- 开启/关闭攻城
function gs_shacheng_state(actor, op_type)
    if check_gmlevel(actor) then return end
    op_type = tonumber(op_type)
    local state = castleinfo(5)
    local tag = "open"
    if op_type == 1 and not state then
        CastleWarTrigger.opCastleWar(actor, tag)
    end
    if op_type == 2 and state then
        tag = "close"
        CastleWarTrigger.opCastleWar(actor, tag)
    end
    RecordBackendOperationLog(actor, actor, "操作攻城", "op", tag)
    GsBackFunc.cur_page = nil
    gs_game_info(actor)
end

-- 显示后台操作日志
function show_gs_backend_log(actor)
    if check_gmlevel(actor) then return end
    if GsBackFunc.cur_page == 10 then
        return
    end
    GsBackFunc.cur_page = 10
    local op_log_tab = GetBackendOperationLog()
    local list = [[
        <Layout|x=140|y=54|width=655|height=444>
        <ListView|children={%s}|x=140|y=54|width=655|height=444|direction=1|bounce=1|margin=10|reload=1|loadStep=3|loadCount=4|loadDelay=1>
    ]]
    local format = "<Text|id=%s|x=0|y=0|size=14|color=150|text=%s>"
    local show_str = ""
    local id = ""
    for i = 1, #op_log_tab do
        show_str = show_str .. string.format(format, i, op_log_tab[i])
        id = i .. "," ..id
    end
    local say_str = string.format(list, id)
    say_str = gs_back_sys_ui .. say_str .. show_str
    say(actor, say_str)
end

-- ================================================= 装备发射器 ============================================
-- 发送道具
function gs_send_item(actor)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    local item_name = getconst(actor, "<$NPCINPUT(1)>") or ""
    local item_value = getconst(actor, "<$NPCINPUT(2)>") or "1"
    if "" == item_name then
        Sendmsg9(actor, "ffffff", "道具名称不能为空!", 1)
        return
    end
    item_value = tonumber(item_value) or 1
    messagebox(actor, string.format("确定给玩家<font color='#00ff00'>【%s】</font>发送道具<font color='#ffff00'>[%s*%s]</font>吗?", name, item_name, item_value), "@_on_send_item,"..name..","..item_name..","..item_value, "@______")
end
function _on_send_item(actor, name, item, count)
    if check_gmlevel(actor) then return end
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    count = tonumber(count)
    GiveItem(obj, item, count, 370, "gs后台给玩家发送道具!")
    Sendmsg9(actor, "00ff00", "发送成功!", 1)
    RecordBackendOperationLog(actor, obj, "gs后台发送道具", item, count)
end
-- 清理背包
function gs_clean_bag(actor)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    messagebox(actor, "确定要清理玩家<font color='#00ff00'>【"..name.."】</font>的背包吗", "@on_clean_player_bag,"..name, "@______")
end
function on_clean_player_bag(actor, name)
    if check_gmlevel(actor) then return end
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    local count = 0
    local max_num = GetBagMaxCount(obj)
    for i = 1, max_num, 1 do
        local make = getiteminfobyindex(actor, 0)
        if make then
            delitembymakeindex(obj, make, nil, "gs后台删除物品")
            count = count + 1
        end
    end
    Sendmsg9(actor, "ffffff", "操作成功", 1)
    RecordBackendOperationLog(actor, obj, "gs后台清理背包", "数量", count)
end
-- 清理货币
function gs_clean_money(actor)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    messagebox(actor, "确定要清理玩家<font color='#00ff00'>【"..name.."】</font>的货币吗", "@on_clean_player_money,"..name, "@______")
end
function on_clean_player_money(actor, name)
    if check_gmlevel(actor) then return end
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    for i = 1, 100, 1 do
        ChangeMoney(obj, i, "=", 0, "gs后台清理货币", true)
    end
    Sendmsg9(actor, "ffffff", "操作成功", 1)
    RecordBackendOperationLog(actor, obj, "gs后台清理货币", "货币", "")
end
-- 查字符串属性
function inputstring3000(actor)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local add_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    local obj = getplayerbyname(name)
    if nil == obj or "" == add_str then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线或字符串输入错误!", 1)
        return
    end
    messagebox(actor,add_str.."属性为:"..getattlist(obj,add_str),"","")
end

-- 清除所有属性
function gs_clean_attr(actor)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    delattlist(obj, "gs_后台加血")
    delattlist(obj, "gs_后台回血")
    delattlist(obj, "gs_后台切割伤害")
    delattlist(obj, "gs_后台对人真伤")
    delattlist(obj, "gs_后台攻击吸血")
    changespeedex(obj, 1, 0, 65535)
    VarApi.setPlayerUIntVar(obj, "U_gs_move_speed_value", 0, false)
    changespeedex(obj, 2, 0, 65535)
    VarApi.setPlayerUIntVar(obj, "U_gs_attack_speed_value", 0, false)

    Sendmsg9(actor, "ffffff", "清理成功, 等级需在右边按钮处操作!", 9)
    RecordBackendOperationLog(actor, obj, "gs后台清除所有属性", "清除", "all")
end

-- 等级+1 -1
function gs_op_level(actor, op_type)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    op_type = tonumber(op_type)
    if op_type == 1 then
        changelevel(obj, "+", 1)
    else
        changelevel(obj, "-", 1)
    end
    Sendmsg9(actor, "00ff00", "操作成功", 1)
end
-- 生命值 +100  -100
function gs_op_hp(actor, op_type)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    op_type = tonumber(op_type)
    if op_type == 1 then
        addattlist(obj, "gs_后台加血", "+", "3#1#100", 1)
    else
        addattlist(obj, "gs_后台加血", "-", "3#1#100", 1)
    end
    Sendmsg9(actor, "00ff00", "操作成功", 1)
end
-- 每秒回血 +100  -100
function gs_op_recover_hp(actor, op_type)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    op_type = tonumber(op_type)
    local str = "+100"
    if op_type == 1 then
        addattlist(obj, "gs_后台回血", "+", "3#71#100", 1)
    else
        addattlist(obj, "gs_后台回血", "-", "3#71#100", 1)
        str = "-100"
    end
    Sendmsg9(actor, "00ff00", "操作成功, 每秒回血"..str, 1)
end
-- 攻速+1  -1
function gs_op_att_speed(actor, op_type)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    op_type = tonumber(op_type)
    local att_speed = VarApi.getPlayerUIntVar(obj, "U_gs_attack_speed_value")
    if op_type == 1 then
        att_speed = att_speed + 1
    else
        att_speed = att_speed - 1
    end
    changespeedex(obj, 2, att_speed * 10, 65535)
    VarApi.setPlayerUIntVar(obj, "U_gs_attack_speed_value", att_speed, false)
    Sendmsg9(actor, "00ff00", "操作成功", 1)
end
-- 移速+1  -1
function gs_op_move_speed(actor, op_type)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    op_type = tonumber(op_type)
    local move_speed = VarApi.getPlayerUIntVar(obj, "U_gs_move_speed_value")
    if op_type == 1 then
        move_speed = move_speed + 1
    else
        move_speed = move_speed - 1
    end
    changespeedex(obj, 1, move_speed * 10, 65535)
    VarApi.setPlayerUIntVar(obj, "U_gs_move_speed_value", move_speed, false)
    Sendmsg9(actor, "00ff00", "操作成功", 1)
end
-- 切割伤害+100  -100
function gs_op_qiege(actor, op_type)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    op_type = tonumber(op_type)
    if op_type == 1 then
        addattlist(obj, "gs_后台切割伤害", "+", "3#74#100", 1)
    else
        addattlist(obj, "gs_后台切割伤害", "-", "3#74#100", 1)
    end
    Sendmsg9(actor, "00ff00", "操作成功", 1)
end
-- 对人真伤+100  -100
function gs_op_attack(actor, op_type)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    op_type = tonumber(op_type)
    if op_type == 1 then
        addattlist(obj, "gs_后台对人真伤", "+", "3#68#100", 1)
    else
        addattlist(obj, "gs_后台对人真伤", "-", "3#68#100", 1)
    end
    Sendmsg9(actor, "00ff00", "操作成功", 1)
end
-- 攻击吸血+1   -1
function gs_op_attack_addhp(actor, op_type)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    op_type = tonumber(op_type)
    if op_type == 1 then
        addattlist(obj, "gs_后台攻击吸血", "+", "3#34#100", 1)
    else
        addattlist(obj, "gs_后台攻击吸血", "-", "3#34#100", 1)
    end
    Sendmsg9(actor, "00ff00", "操作成功", 1)
end

-- ================================================= 玩家变量 ============================================
-- 查询玩家变量
function find_player_var(actor)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    local var_name = getconst(actor, "<$NPCINPUT(1)>")
    if string.find(var_name, "U_") or string.find(var_name, "U") then
        old_value = VarApi.getPlayerUIntVar(obj, var_name)
    elseif string.find(var_name, "T_") then
        old_value = VarApi.getPlayerTStrVar(obj, var_name)
    elseif string.find(var_name, "J_") then
        old_value = VarApi.getPlayerJIntVar(obj, var_name)
    elseif string.find(var_name, "Z_") then
        old_value = VarApi.getPlayerZStrVar(obj, var_name)
    else
        Sendmsg9(actor, "ffffff", "修改失败, 未找到对应变量名!", 1)
        return
    end
    messagebox(actor, "["..name.."] 变量: "..var_name .."值为: \\ "..old_value, "@_____", "@_____")
end
function find_player_buff_var(actor) --#region 查询玩家buff信息
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    local list_buff = getallbuffid(obj)
    local buff_info = ""
    for i, buffid in ipairs(list_buff) do
        buff_info = buff_info.."buffID: "..buffid.. "，name："..getstdbuffinfo(buffid,1):gsub("[<>/]", "")
        .."，层数："..getbuffinfo(obj,buffid,1).."，time："..getbuffinfo(obj,buffid,2)
        .."，att："..getbuffinfo(obj,buffid,4).."\\"
    end
    messagebox(actor, buff_info, "", "")
end
-- 设置玩家变量
function change_player_var(actor)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    local var_name = getconst(actor, "<$NPCINPUT(1)>") or ""
    local var_value = getconst(actor, "<$NPCINPUT(2)>") or ""
    if nil == var_name or "" == var_name then
        Sendmsg9(actor, "ff0000", "请正确输入变量名称!", 1)
        return
    end
    if var_value=='""' then var_value="" end --#region str变量设空值
    if string.find(var_name, "U_") or string.find(var_name, "U") then
        var_value = tonumber(var_value) or 0
        VarApi.setPlayerUIntVar(obj, var_name, var_value, true)
    elseif string.find(var_name, "T_") then
        VarApi.setPlayerTStrVar(obj, var_name, var_value, true)
    elseif string.find(var_name, "J_") then
        var_value = tonumber(var_value) or 0
        VarApi.setPlayerJIntVar(obj, var_name, var_value, nil)
    elseif string.find(var_name, "Z_") then
        VarApi.setPlayerZStrVar(obj, var_name, var_value, nil)
    else
        Sendmsg9(actor, "ffffff", "修改失败, 未找到对应变量名!", 1)
        return
    end
    messagebox(actor, "修改成功, ["..name.."] 变量: "..var_name .."值为: \\ "..var_value, "@_____", "@_____")
    RecordBackendOperationLog(actor, obj, "修改玩家变量", var_name, var_value)
end
--============================================ 玩家道具 货币 =============================================
-- 查询玩家道具
function find_player_item(actor)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    release_print(name)
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end    
    local item_name = getconst(actor, "<$NPCINPUT(3)>")
    if nil == item_name or "" == item_name then
        Sendmsg9(actor, "ff0000", "请正确输入道具名称!", 1)
        return
    end
    local item_id = getstditeminfo(item_name, 0)
    local bag_count = getbagitemcount(obj, item_name, 0) or 0
    if item_id and item_id <= 100 then
        bag_count = querymoney(obj, item_id)
    end

    messagebox(actor, name.." ["..item_name .. "] ".."道具数量为: "..bag_count, "@_____", "@_____")
end
-- 修改玩家道具
function change_player_item(actor)
    if check_gmlevel(actor) then return end
    local name = getconst(actor, "<$NPCINPUT(0)>")
    local obj = getplayerbyname(name)
    if nil == obj then
        Sendmsg9(actor, "ffffff", "未找到对应玩家或该玩家不在线!", 1)
        return
    end
    local item_name = getconst(actor, "<$NPCINPUT(3)>")
    local item_count = getconst(actor, "<$NPCINPUT(4)>")
    item_count = tonumber(item_count) or 0
    if nil == item_name or "" == item_name then
        Sendmsg9(actor, "ff0000", "请正确输入道具名称!", 1)
        return
    end
    local item_id = getstditeminfo(item_name, 0)
    local bag_count = getbagitemcount(obj, item_name, 0) or 0
    if nil == item_id then
        Sendmsg9(actor, "ff0000", item_name.."道具id为空, 道具名称输入是否正确?", 1)
        return
    end
    local tip_desc = ""
    if item_id <= 100 then
        ChangeMoney(obj, item_id, "=", item_count, "GS后台修改玩家货币", true)
        tip_desc = "修改 [%s] 货币 [" .. item_name .. "] 数量: "..item_count
    else
        if item_count == 0 then
            takeitem(obj, item_name, bag_count, 0, "GS后台扣除玩家道具")
            tip_desc = "删除 [%s] 道具 [" .. item_name .. "] 数量: "..bag_count
        else
            GiveItem(obj, item_name, item_count, 307, "GS后台修改玩家道具数量")
            tip_desc = "给予 [%s] 道具 [" .. item_name .. "] 数量: "..item_count
        end
    end
    tip_desc = string.format(tip_desc, name)

    messagebox(actor, "操作成功, "..tip_desc, "@_____", "@_____")
    RecordBackendOperationLog(actor, obj, "修改玩家道具", item_name, item_count)
end

-- =============================================== 系统变量 =============================================
-- 查询系统变量
function find_sys_var(actor)
    if check_gmlevel(actor) then return end
    local var_name = getconst(actor, "<$NPCINPUT(5)>")
    if nil == var_name or "" == var_name then
        Sendmsg9(actor, "ff0000", "请正确输入变量名称!", 1)
        return
    end
    local old_value = nil
    if string.find(var_name, "G_") then
        old_value = GetSysInt(var_name)
    elseif string.find(var_name, "A_") then
        old_value = GetSysStr(var_name)
    else
        Sendmsg9(actor, "ffffff", "查询失败, 未找到对应变量名!", 1)
        return
    end
    messagebox(actor, "系统变量: "..var_name .."值为: \\ "..old_value, "@_____", "@_____")
end
-- 修改系统变量
function change_sys_var(actor)
    if check_gmlevel(actor) then return end
    local var_name = getconst(actor, "<$NPCINPUT(5)>")
    local var_value = getconst(actor, "<$NPCINPUT(6)>")
    if nil == var_name or "" == var_name then
        Sendmsg9(actor, "ff0000", "请正确输入变量名称!", 1)
        return
    end
    if string.find(var_name, "G_") then
        var_value = tonumber(var_value) or 0
        SetSysInt(var_name, var_value)
    elseif string.find(var_name, "A_") then
        SetSysStr(var_name, var_value)
    elseif string.find(var_name, "GT_") then
        SetSysTLInt(var_name, var_value, GetDayTick() + 86400)
    else
        Sendmsg9(actor, "ffffff", "修改失败, 未找到对应变量名!", 1)
        return
    end
    if var_name == VarEngine.HeFuCount and var_value == 0 then
        SetSysInt("G_cross_dfxg_state", 0)
        SetSysInt("G_cross_wxzc_state", 0)
        SetSysInt("G_cross_yyjl_state", 0)
        SetSysInt("G_cross_emgc_state", 0)
    end
    messagebox(actor, "修改成功, 系统变量: "..var_name .."值为: \\ "..var_value, "@_____", "@_____")
    RecordBackendOperationLog(actor, actor, "修改系统变量", var_name, var_value)
end

-- ========================================== 一键重置  =====================================
function gs_reset_live_data(actor, index)
    if check_gmlevel(actor) then return end
    index = tonumber(index)
    if index == 1 then
        local class = IncludeNpcClass("AnswerNpc")
        if class then
           class:AnswerGenMon() 
        end
        Sendmsg9(actor, "ffffff", "重置诡异空间!", 1)
    elseif index == 2 then
        local state = GetSysInt("G_mining_state")
        local npc_class = IncludeNpcClass("MiningDemand")
        if npc_class then
            if state == 0 then
                npc_class:onOpen(actor)
            else
                npc_class:onClose(actor)
            end
        end
        Sendmsg9(actor, "ffffff", "重置地下矿洞!", 1)
    elseif index == 3 then
        SetSysStr("A_all_server_first_drop", "")
        Sendmsg9(actor, "ffffff", "重置全服首爆!", 1)
    end
end

--============== 权限检测 ============
function check_gmlevel(actor)
    local account_id = getconst(actor, "<$USERACCOUNT>")
    if getgmlevel(actor) ~= 10 or not isInTable(GMWhiteList, account_id) then
        Sendmsg9(actor, "ff0000", "权限不足!", 1)
        return true
    end
    return false
end

--#region gs_后台
function usercmd9002(actor)
    if check_gmlevel(actor) then return end
    local server_id = GetServerIDX()
    if server_id < 10000 or GetSysInt("G200") > 0 then
        GsBackFunc.showGsSystem(actor)
    else
        GsBackFunc.password(actor)
    end
end
