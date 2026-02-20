-- ======================================================================== 开发环境 常用gm后台
GmBackSystem = {}
local ui_tab = {
    "<Img|x=0|y=0|width=800|height=502|img=public/gm/1900000677.png|scale9r=5|show=4|bg=1|scale9b=5|scale9l=5|esc=0|scale9t=5>",
    "<Img|ay=0|x=134.0|y=503.0|width=2|height=451|esc=0|img=public/gm/line2.png>",
    "<Img|x=0|y=50|width=800|height=3|img=public/gm/line1.png|esc=0>",
    "<Text|x=20.0|y=14.0|size=18|color=255|text=管理系统>",
    "<Text|x=570.0|y=16.0|size=18|color=243|text=<$YEAR>年<$MONTH>月<$DAY>日  %s>",
    "<Button|x=772.0|y=2.0|size=18|color=255|nimg=public/gm/11.png|pimg=public/gm/12.png|link=@exit>",
    "<ListView|children={10000,10001,10002,10003,10004,10005,10006,10007,10008,10009,10010}|x=8|y=55|width=130|height=442|direction=1|bounce=1|margin=5|reload=0>",
    "<Button|id=10000|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=角色信息|link=@role_info>",
    "<Button|id=10001|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=系统补发|link=@system_give>",
    "<Button|id=10002|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=常用功能|link=@chang_yong>",
    "<Button|id=10003|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=区服信息|link=@game_info>",
    "<Button|id=10004|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=活动中心|link=@activity_center>",
    "<Button|id=10005|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=一键重置|link=@resert_live>",

    -- 日志按钮放最下面
    "<Button|id=10010|x=8|y=0|size=18|nimg=public/gm/t3.png|color=250|text=后台日志|link=@show_backend_log>"
}
local gm_back_sys_ui = ""
for key, str in pairs(ui_tab) do
    gm_back_sys_ui = gm_back_sys_ui .. str
end
local page_ui = {
    -- 角色信息
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
        <Text|x=450.0|y=340.0|size=18|color=254|text=代币数量><RText|x=530.0|y=340.0|size=18|color=250|text=<: /FCOLOR=255><%s/FCOLOR=250>>
        <Text|x=151.0|y=425.0|size=18|color=7|text=输入角色名称:>
        <Img|x=152.0|y=460.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=154.0|y=463.0|width=158|height=25|rotate=0|inputid=1|color=255|isChatInput=0|size=16|type=0|place=请输入角色名称>
        <Button|x=330.0|y=450.0|size=18|nimg=public/gm/btnm3.png|color=249|submitInput=1|text=查询玩家|link=@check_player> 

        <Button|x=670.0|y=70.0|size=18|nimg=public/gm/btnm3.png|color=249|text=货币查询|link=@@inputstring105_0(输入格式：货币id或名称)>
        <Button|x=670.0|y=120.0|size=18|nimg=public/gm/btnm3.png|color=249|text=补发充值|link=@@inputstring102_0(输入格式：补发金额)>
        <Button|x=670.0|y=170.0|size=18|nimg=public/gm/btnm3.png|color=249|text=封禁角色|link=@@inputstring101_0(输入格式：0代表临时禁止，1代表永久禁止)>
        <Button|x=670.0|y=220.0|size=18|nimg=public/gm/btnm3.png|color=249|text=跟踪玩家|link=@follow_obj>
        <Button|x=670.0|y=270.0|size=18|nimg=public/gm/btnm3.png|color=249|text=权限设置|link=@@inputstring100_0(输入格式：权限等级[0-10])> 
        <Button|x=670.0|y=320.0|size=18|nimg=public/gm/btnm3.png|color=249|text=踢他下线|link=@kick_offline> 
        <Button|x=670.0|y=370.0|size=18|nimg=public/gm/btnm3.png|color=249|text=清理信息|link=@clean_player> 

        <Button|x=430.0|y=370.0|size=18|nimg=public/gm/btnm3.png|color=250|text=变量查询|link=@@inputstring103_0(输入格式：个人变量名)>
        <Button|x=550.0|y=370.0|size=18|nimg=public/gm/btnm3.png|color=250|text=变量修改|link=@@inputstring104_0(输入格式：个人变量名#修改后的值)>
    ]],
    -- 系统补发
    [2] = [[
        <Img|x=138.0|y=413.0|width=658|rotate=0|img=public/gm/line1.png|esc=0>
        <Text|x=150.0|y=70.0|size=18|color=94|text=1.物品名称:>
        <Img|x=255.0|y=60.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=257.0|y=63.0|width=158|height=25|rotate=0|inputid=0|color=255|isChatInput=0|size=16|type=0|place=请输入物品名称>
        <Text|x=470.0|y=70.0|size=18|color=94|text=1.物品数量:>
        <Img|x=575.0|y=60.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=577.0|y=63.0|width=158|height=25|rotate=0|inputid=1|color=255|isChatInput=0|size=16|type=0|place=请输入物品数量>
        <Text|x=150.0|y=120.0|size=18|color=94|text=2.物品名称:>
        <Img|x=255.0|y=110.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=257.0|y=113.0|width=158|height=25|rotate=0|inputid=2|color=255|isChatInput=0|size=16|type=0|place=请输入物品名称>
        <Text|x=470.0|y=120.0|size=18|color=94|text=2.物品数量:>
        <Img|x=575.0|y=110.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=577.0|y=113.0|width=158|height=25|rotate=0|inputid=3|color=255|isChatInput=0|size=16|type=0|place=请输入物品数量>
        <Text|x=150.0|y=170.0|size=18|color=94|text=3.物品名称:>
        <Img|x=255.0|y=160.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=257.0|y=163.0|width=158|height=25|rotate=0|inputid=4|color=255|isChatInput=0|size=16|type=0|place=请输入物品名称>
        <Text|x=470.0|y=170.0|size=18|color=94|text=3.物品数量:>
        <Img|x=575.0|y=160.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=577.0|y=163.0|width=158|height=25|rotate=0|inputid=5|color=255|isChatInput=0|size=16|type=0|place=请输入物品数量>  
        <Text|x=150.0|y=220.0|size=18|color=94|text=4.物品名称:>
        <Img|x=255.0|y=210.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=257.0|y=213.0|width=158|height=25|rotate=0|inputid=6|color=255|isChatInput=0|size=16|type=0|place=请输入物品名称>
        <Text|x=470.0|y=220.0|size=18|color=94|text=4.物品数量:>
        <Img|x=575.0|y=210.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=577.0|y=213.0|width=158|height=25|rotate=0|inputid=7|color=255|isChatInput=0|size=16|type=0|place=请输入物品数量>

        <Text|a=4|x=210|y=440|size=18|color=249|text=*补发角色*>
        <Text|a=4|x=210|y=470|size=18|color=250|text=%s>
        <Text|x=300|y=425|size=18|color=7|text=邮件标题:>
        <Img|x=390.0|y=420.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=392.0|y=423.0|width=158|height=25|rotate=0|inputid=10|color=255|isChatInput=0|size=16|type=0|place=请输入邮件标题>
        <Text|x=300|y=467|size=18|color=7|text=邮件内容:>
        <Img|x=390.0|y=460.0|esc=0|img=public/gm/bg_cjzy_00.png>
        <Input|x=392.0|y=463.0|width=158|height=25|rotate=0|inputid=11|color=255|isChatInput=0|size=16|type=0|place=请输入邮件内容>        
        <Button|x=560.0|y=420.0|size=18|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2,3,4,5,6,7,10,11|text=绑定发送|link=@send_mail,0> 
        <Button|x=560.0|y=460.0|size=18|nimg=public/gm/btnm3.png|color=250|submitInput=0,1,2,3,4,5,6,7,10,11|text=非绑定发送|link=@send_mail,1> 
        <Button|x=680.0|y=420.0|size=18|nimg=public/gm/btnm3.png|color=250|text=修改货币|link=@@inputstring10000_0(输入格式：元宝#3000，输入元宝#0为清空)> 
        <Button|x=680.0|y=460.0|size=18|nimg=public/gm/btnm3.png|color=250|text=预留按钮|link=@aaaaaa> 
    ]],    
    -- 常用功能
    [3] = [[
        <Button|x=180.0|y=60.0|size=18|nimg=public/gm/btnm3.png|color=251|text=开启攻城|link=@shacheng_state,1> 
        <Button|x=180.0|y=105.0|size=18|nimg=public/gm/btnm3.png|color=251|text=结束攻城|link=@shacheng_state,2> 
        <Button|x=180|y=150|size=18|nimg=public/gm/btnm3.png|color=251|text=道具操作|link=@@inputstring1000_0(输入格式：元宝#3000，输入元宝#0为清空)>
        <Button|x=180|y=195|size=16|nimg=public/gm/btnm3.png|color=251|text=查询个人变量|link=@@inputstring1004_0(输入格式：个人变量名[key])>
        <Button|x=180|y=240|size=16|nimg=public/gm/btnm3.png|color=251|text=修改个人变量|link=@@inputstring1001_0(输入格式：个人变量名#变量值[key#value])>
        <Button|x=180|y=285|size=14|nimg=public/gm/btnm3.png|color=251|text=查询系统int变量|link=@@inputstring1005_0(输入格式：系统int变量名[key])>
        <Button|x=180|y=330|size=14|nimg=public/gm/btnm3.png|color=251|text=修改系统int变量|link=@@inputstring1002_0(输入格式：系统int变量名#变量值[G101#100])>
        <Button|x=180|y=375|size=14|nimg=public/gm/btnm3.png|color=251|text=查询系统str变量|link=@@inputstring1006_0(输入格式：系统str变量名[key])>
        <Button|x=180|y=420|size=14|nimg=public/gm/btnm3.png|color=251|text=修改系统str变量|link=@@inputstring1003_0(输入格式：系统str变量名#变量值[A100#张三])>

        <Button|x=330.0|y=60.0|size=16|nimg=public/gm/btnm3.png|color=250|text=修改开区天数|link=@@inputstring1010_0(输入格式：开区天数)>
        <Button|x=330.0|y=105.0|size=16|nimg=public/gm/btnm3.png|color=250|text=修改合服次数|link=@@inputstring1011_0(输入格式：合服次数)> 
        <Button|x=330.0|y=150.0|size=16|nimg=public/gm/btnm3.png|color=250|text=修改开服时间|link=@@inputstring1014_0(输入格式：开服时间)>
        <Button|x=330.0|y=195.0|size=18|nimg=public/gm/btnm3.png|color=250|text=调整等级|link=@@inputstring1007_0(输入格式：等级)> 
        <Button|x=330.0|y=240.0|size=18|nimg=public/gm/btnm3.png|color=250|text=调整转生|link=@@inputstring1008_0(输入格式：转生次数#转生后等级0为不改变人物当前等级#分配点数)> 
        <Button|x=330.0|y=285.0|size=18|nimg=public/gm/btnm3.png|color=250|text=清理背包|link=@clean_my_bag> 
        <Button|x=330.0|y=330.0|size=18|nimg=public/gm/btnm3.png|color=250|text=无敌模式|link=@change_mode,1> 
        <Button|x=330.0|y=375.0|size=18|nimg=public/gm/btnm3.png|color=250|text=隐身模式|link=@change_mode,2>
        <Button|x=330.0|y=420.0|size=18|nimg=public/gm/btnm3.png|color=250|text=一键满血|link=@reset_hpmp>

        <Button|x=480.0|y=60.0|size=18|nimg=public/gm/btnm3.png|color=251|text=开启秒怪|link=@open_kill_mon> 
        <Button|x=480.0|y=105.0|size=18|nimg=public/gm/btnm3.png|color=251|text=学习技能|link=@get_skill> 
        <Button|x=480.0|y=150.0|size=18|nimg=public/gm/btnm3.png|color=251|text=清除技能|link=@clean_skill>
        <Button|x=480.0|y=195.0|size=18|nimg=public/gm/btnm3.png|color=251|text=学习单个技能|link=@@inputstring1012_0(输入格式：技能名称)>
        <Button|x=480.0|y=240.0|size=18|nimg=public/gm/btnm3.png|color=251|text=地图清怪|link=@clean_map_mon> 
        <Button|x=480.0|y=285.0|size=18|nimg=public/gm/btnm3.png|color=251|text=BUFF信息|link=@buff_info> 
        <Button|x=480.0|y=330.0|size=18|nimg=public/gm/btnm3.png|color=251|text=删除BUFF|link=@@inputstring1019_0(输入格式：buffId[输入0删除所有buff])> 
        <Button|x=480.0|y=375.0|size=18|nimg=public/gm/btnm3.png|color=251|text=加BUFF|link=@@inputstring1020_0(输入格式：buffId)> 
        <Button|x=480.0|y=420.0|size=18|nimg=public/gm/btnm3.png|color=251|text=完成某个任务|link=@@inputstring1021_0(输入格式：任务ID)> 
        

        <Button|x=630.0|y=60.0|size=18|nimg=public/gm/btnm3.png|color=250|text=地图传送|link=@@inputstring1015_0(输入格式：地图id,x坐标,y坐标)>
        <Button|x=630.0|y=105.0|size=18|nimg=public/gm/btnm3.png|color=250|text=添加称号|link=@@inputstring1016_0(输入格式：称号名称)>
        <Button|x=630.0|y=150.0|size=18|nimg=public/gm/btnm3.png|color=250|text=删除称号|link=@@inputstring1022_0(输入格式：称号名称)>
        <Button|x=630.0|y=195.0|size=18|nimg=public/gm/btnm3.png|color=250|text=查询字符串属性|link=@@inputstring1017_0(输入格式：字符串名称)>
        <Button|x=630.0|y=240.0|size=18|nimg=public/gm/btnm3.png|color=250|text=改字符串属性|link=@@inputstring1018_0(输入格式：字符串名称=3#1#300竖线3#2#300)>
        <Button|x=630.0|y=285.0|size=18|nimg=public/gm/btnm3.png|color=250|text=代币+100|link=@give_recharge>
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
        <Text|x=190.0|y=430.0|size=18|color=94|text=在线人数><Text|x=310.0|y=430.0|size=18|color=250|text=: %s>

        <Button|x=600.0|y=60.0|size=16|nimg=public/gm/btnm3.png|color=250|text=设置为直播区服|link=@op_active_system> 
    ]],
    -- 活动中心
    [5] = [[
        <Button|x=180.0|y=60.0|size=16|nimg=public/gm/btnm3.png|color=251|text=开启天降财宝|link=@op_active_state,1> 
        <Button|x=180.0|y=105.0|size=16|nimg=public/gm/btnm3.png|color=251|text=开启激情派对|link=@op_active_state,3>
        <Button|x=180|y=150|size=16|nimg=public/gm/btnm3.png|color=251|text=开启武林至尊|link=@op_active_state,5>
        <Button|x=180|y=195|size=16|nimg=public/gm/btnm3.png|color=251|text=开启夺宝奇兵|link=@op_active_state,6>
        <Button|x=180|y=240|size=16|nimg=public/gm/btnm3.png|color=251|text=开启世界boss|link=@op_active_state,7>
        <Button|x=180|y=285|size=16|nimg=public/gm/btnm3.png|color=251|text=开启行会战场|link=@op_active_state,8>
        <Button|x=180|y=330|size=16|nimg=public/gm/btnm3.png|color=251|text=开启乱斗之王|link=@op_active_state,9>
        <Button|x=180|y=375|size=16|nimg=public/gm/btnm3.png|color=251|text=开启狂暴霸主|link=@op_active_state,10>
        <Button|x=180|y=420|size=16|nimg=public/gm/btnm3.png|color=251|text=开启跨服沙城|link=@op_active_state,11>

    ]],
    --一键重置
    [6] = [[
        <Button|x=180.0|y=60.0|size=16|nimg=public/gm/btnm3.png|color=251|text=诡异空间|link=@reset_live_data,1> 
        <Button|x=180.0|y=105.0|size=16|nimg=public/gm/btnm3.png|color=251|text=地下矿洞|link=@reset_live_data,2>
        <Button|x=180.0|y=150.0|size=16|nimg=public/gm/btnm3.png|color=251|text=幸运老板娘|link=@@inputstring6001_0(输入格式：清理的gs玩家名称)>
        <Button|x=180.0|y=195.0|size=16|nimg=public/gm/btnm3.png|color=251|text=重置全服首爆|link=@reset_live_data,3> 
        <Button|x=180.0|y=240|size=16|nimg=public/gm/btnm3.png|color=251|text=重置塔防|link=@reset_live_data,5>
        <Button|x=180.0|y=285|size=16|nimg=public/gm/btnm3.png|color=251|text=重置王的遗迹|link=@reset_live_data,4>
        <Button|x=180.0|y=330|size=16|nimg=public/gm/btnm3.png|color=251|text=重置塔防2|link=@reset_live_data,6>
        <Button|x=180.0|y=375|size=16|nimg=public/gm/btnm3.png|color=251|text=重置木之幻境|link=@reset_live_data,7>
        <Button|x=180.0|y=420|size=16|nimg=public/gm/btnm3.png|color=251|text=重置传奇之路|link=@reset_live_data,8>

        <Button|x=330.0|y=60.0|size=16|nimg=public/gm/btnm3.png|color=251|text=1号点挖矿几率|link=@@inputstring2001_0(输入格式：1-100,数字越大几率越高)>
        <Button|x=330.0|y=105.0|size=16|nimg=public/gm/btnm3.png|color=251|text=2号点挖矿几率|link=@@inputstring2002_0(输入格式：1-100,数字越大几率越高)>
        <Button|x=330.0|y=150.0|size=16|nimg=public/gm/btnm3.png|color=251|text=3号点挖矿几率|link=@@inputstring2003_0(输入格式：1-100,数字越大几率越高)>
        <Button|x=330.0|y=195.0|size=16|nimg=public/gm/btnm3.png|color=251|text=4号点挖矿几率|link=@@inputstring2004_0(输入格式：1-100,数字越大几率越高)>
        <Button|x=330.0|y=240.0|size=16|nimg=public/gm/btnm3.png|color=251|text=全局变异几率|link=@@inputstring2005_0(输入格式：1-100,数字越大几率越高)>

        <Button|x=480.0|y=60.0|size=18|nimg=public/gm/btnm3.png|color=250|text=清理后台日志|link=@clean_backend_log>
    ]]
}
GmBackSystem.op_player = nil                -- 当前查询的玩家   <$USERCOUNT>
GmBackSystem.cur_page = 1                   -- 当前UI页签
-- 显示GM后台
function GmBackSystem.showSystem(actor)
    if check_gmlevel(actor) then return end
    local wday_str = CHWeekDay(GetWday())
    gm_back_sys_ui = parsetext(gm_back_sys_ui, actor)
    gm_back_sys_ui = string.format(gm_back_sys_ui, "星期"..wday_str)
    GmBackSystem.op_player = nil
    GmBackSystem.cur_page = 1
    local tab = {0,0,0,0,0,0,0,0,0,0,0,0,"0,0",0,0,0,0,0}
    local name = getbaseinfo(actor, 1)
    local ui_str = string.format(gm_back_sys_ui..page_ui[1], name, unpack(tab))
    say(actor, ui_str)
end

-- =========================================================== gm后台页签 ====================================================================
-- 显示查询角色信息
function GmBackSystem.showRoleInfo(actor)
    if check_gmlevel(actor) then return end
    local obj = GmBackSystem.op_player
    if nil == obj then
        GmBackSystem.showSystem(actor)
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
    local db = getbagitemcount(obj, "代币", 0)
    tmp_tab = {gm_name,obj_name,total_recharge,today_recharge,level,re_level,jin_bi,yuan_bao,ling_fu,zhi_gou_point,cz_point,account,map_name,pos,login_day,bind_jb,bind_yb,bind_lf,db}
    local ui_str = string.format(gm_back_sys_ui..page_ui[1], unpack(tmp_tab))
    say(actor, ui_str)
end

-- 密码验证
function GmBackSystem.password(actor)
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
        <Button|x=513.0|y=341.0|nimg=public/1900000660.png|submitInput=1|pimg=public/1900000661.png|size=18|color=2533|text=密码登录|link=@on_yz_password>
        <Text|x=25|y=20|color=255|size=22|text=Ver 1.0.0>
        <Layout|width=2000|height=2000>
    ]]
    say(actor,ui_str)
end
function on_yz_password(actor)
    if check_gmlevel(actor) then return end
    local password = getconst(actor, "<$NPCINPUT(1)>")
    if isInTable({"3699"}, password) then
        close(actor)
        GmBackSystem.showSystem(actor)
        Sendmsg9(actor, "00ff00", "登录成功!", 9)
    else
        Sendmsg9(actor, "ff0000", "密码错误", 9)
    end
end

-- 角色信息
function role_info(actor)
    if check_gmlevel(actor) then return end
    if GmBackSystem.cur_page == 1 then
        return
    end
    GmBackSystem.cur_page = 1
    GmBackSystem.showRoleInfo(actor)
end
-- 系统补发
function system_give(actor)
    if check_gmlevel(actor) then return end    
    if GmBackSystem.cur_page == 2 then
        return
    end
    GmBackSystem.cur_page = 2
    local name = getbaseinfo(GmBackSystem.op_player or "", 1)
    if nil == name or "" == name then
        name = "无"
    end
    name = "[ " .. name .. " ]"
    local str = string.format(gm_back_sys_ui..page_ui[2], name)
    say(actor, str)
end
-- 常用功能
function chang_yong(actor)
    if check_gmlevel(actor) then return end
    if GmBackSystem.cur_page == 3 then
        return
    end
    GmBackSystem.cur_page = 3
    say(actor, gm_back_sys_ui..page_ui[3])
end
-- 区服信息
function game_info(actor)
    if check_gmlevel(actor) then return end  
    if GmBackSystem.cur_page == 4 then
        return
    end
    GmBackSystem.cur_page = 4
    local info = {
        [0] = "(正常区服)",
        [1] = "(直播区服)",
    }
    local _type = GetSysInt("G200")
    local str = info[_type] or "(未知区服)"
    local server_name = GetServerName() .. str
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
    local str = string.format(page_ui[4], unpack(tmp_tab))
    say(actor, gm_back_sys_ui..str)
end
--
function activity_center(actor)
    if check_gmlevel(actor) then return end    
    if GmBackSystem.cur_page == 5 then
        return
    end
    GmBackSystem.cur_page = 5
    say(actor, gm_back_sys_ui..page_ui[5])
end
function resert_live(actor)
    if check_gmlevel(actor) then return end    
    if GmBackSystem.cur_page == 6 then
        return
    end
    GmBackSystem.cur_page = 6
    say(actor, gm_back_sys_ui..page_ui[6])
end
-- 装备信息
function all_equip_info(actor)
    if check_gmlevel(actor) then return end    
    if GmBackSystem.cur_page == 6 then
        return
    end
    GmBackSystem.cur_page = 6
    local item_id_list = {}
    for i = 50000, 50770, 1 do
        local name = getstditeminfo(i, 1)
        if type(name) == "string" and string.find(name, "//") == nil then
            item_id_list[#item_id_list + 1] = i
        end
    end
    local list_str = ""
    local layout = "<Layout|id=%s|children=%s|x=0|y=0|width=610|height=60>"
    local item_show = "<ItemShow|id=%s|x=%s|y=-3|width=60|height=60|itemid=%d|showtips=1|bgtype=1>"
    local layout_str = ""
    local item_str = ""
    local len = item_id_list[#item_id_list]
    for i = 1, math.ceil(#item_id_list / 10) do
        local tmp_str = ""
        local x = 0
        for j = 1, 10 do
            local index = (i - 1) * 10 + j
            local id = item_id_list[index] or len + j
            tmp_str = tmp_str .. "," .. id
            x = (j - 1) * 60
            item_str = item_str .. string.format(item_show, id, x, id)
        end
        tmp_str = "{" .. tmp_str .. "}"
        layout_str = layout_str .. string.format(layout, i, tmp_str)
        list_str = list_str .. "," .. i
    end
    list_str = "{" .. list_str .. "}"
    local str = string.format(page_ui[5], list_str)
    str = str .. layout_str .. item_str
    say(actor, gm_back_sys_ui..str)
end

-- 显示后台操作日志
function show_backend_log(actor)
    if check_gmlevel(actor) then return end
    if GmBackSystem.cur_page == 10 then
        return
    end
    GmBackSystem.cur_page = 10
    local account_id = getconst(actor, "<$USERACCOUNT>")
    local tmp_list = {"2", "1354735642"}
    if not isInTable(tmp_list, account_id) then
        -- Sendmsg9(actor, "ff0000", "暂未开放!", 1)
        -- return
    end
    local op_log_tab = GetBackendOperationLog()
    local list = [[
        <Layout|x=140|y=54|width=655|height=444>
        <ListView|children={%s}|x=140|y=54|width=655|height=444|direction=1|bounce=1|margin=10|reload=1>
    ]]
    local format = "<Text|id=%s|x=0|y=0|size=14|color=150|text=%s>"
    local show_str = ""
    local id = ""
    for i = 1, #op_log_tab do
        show_str = show_str .. string.format(format, i, op_log_tab[i])
        id = i .. "," ..id
    end
    local say_str = string.format(list, id)
    say_str = gm_back_sys_ui .. say_str .. show_str
    say(actor, say_str)
end

-- =========================================================== 角色信息 ====================================================================
-- 查询玩家
function check_player(actor)
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
    GmBackSystem.op_player = obj
    GmBackSystem.showRoleInfo(actor)
end
-- 变量修改
function inputstring104(actor)
    if check_gmlevel(actor) then return end
    local var_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    local obj = GmBackSystem.op_player
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "缺少要修改的玩家!", 1)
        return
    end
    local tmp_tab = strsplit(var_str, "#")
    local var_name = tmp_tab[1]
    local value = tmp_tab[2]
    if "" == var_name or nil == var_name then
        Sendmsg9(actor, "ffffff", "请正确输入变量名!", 1)
        return
    end
    local name = getbaseinfo(obj, 1)
    local cur_value = nil
    if string.find(var_name, "U_") or string.find(var_name, "U") then
        VarApi.setPlayerUIntVar(obj, var_name, tonumber(value) or 0, true)

        cur_value = VarApi.getPlayerUIntVar(obj, var_name)
    elseif string.find(var_name, "T_") then
        VarApi.setPlayerTStrVar(obj, var_name, value or "", true)

        cur_value = VarApi.getPlayerTStrVar(obj, var_name)
    elseif string.find(var_name, "J_") then
        VarApi.setPlayerJIntVar(obj, var_name, tonumber(value) or 0)

        cur_value = VarApi.getPlayerJIntVar(obj, var_name)
    elseif string.find(var_name, "Z_") then
        VarApi.setPlayerZStrVar(obj, var_name, value or "")

        cur_value = VarApi.getPlayerZStrVar(obj, var_name)
    else
        Sendmsg9(actor, "ffffff", "非法变量名: ".. var_name, 1)
        return
    end

    local str = string.format("玩家: [%s] 个人变量 (%s) 修改后的值为: %s", name, var_name, cur_value)
    messagebox(actor, str, "@______", "@______")
    RecordBackendOperationLog(actor, obj, "修改个人变量", var_name, cur_value)
    GmBackSystem.showRoleInfo(actor)
end
-- 变量查询
function inputstring103(actor)
    if check_gmlevel(actor) then return end
    local var_name = getconst(actor,"<$NPCPARAMS(1,S22)>")
    local obj = GmBackSystem.op_player
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "缺少补发玩家!", 1)
        return
    end
    if "" == var_name or nil == var_name then
        Sendmsg9(actor, "ffffff", "请正确输入变量名!", 1)
        return
    end
    local name = getbaseinfo(obj, 1)
    local value = nil
    if string.find(var_name, "U_") or string.find(var_name, "U") then
        value = GetInt(0, obj, var_name)
    elseif string.find(var_name, "T_") then
        value = GetStr(0, obj, var_name)
    elseif string.find(var_name, "J_") then
        value = GetTLInt(0, obj, var_name)
    elseif string.find(var_name, "Z_") then
        value = GetTLStr(0, actor, var_name)
    else
        Sendmsg9(actor, "ffffff", "非法变量名: "..var_name, 1)
        return
    end

    local str = string.format("玩家: [%s] 个人变量 (%s) 值为: %s", name, var_name, value)
    messagebox(actor, str, "@______", "@______")
end
-- 货币查询
function inputstring105(actor)
    if check_gmlevel(actor) then return end
    local obj = GmBackSystem.op_player
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "缺少查询玩家!", 1)
        return
    end
    local money_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    local name = getbaseinfo(obj, 1)
    local money_id = tonumber(money_str)
    if nil == money_id then
        money_id = getstditeminfo(money_str, 0)
    else
        money_str = getstditeminfo(money_id, 1)
    end
    local value = querymoney(obj, money_id)
    messagebox(actor, "玩家 [" ..name.. "] " ..money_str .. "数量为: " .. value, "@______", "@______")
end
-- 补发充值
function inputstring102(actor)
    if check_gmlevel(actor) then return end
    local value = getconst(actor,"<$NPCPARAMS(1,S22)>")
    value = tonumber(value)
    local obj = GmBackSystem.op_player
    if nil == obj or "" == obj or nil == value then
        Sendmsg9(actor, "ffffff", "缺少补发玩家!", 1)
        return
    end
    local name = getbaseinfo(obj, 1)
    messagebox(actor, "是否给玩家:\\<font color='#00ff00'>   [" .. name .. "]</font> \\补发 "..value.." 代币?", "@_on_ok_send,"..value, "@_on_no_send")
end
function _on_ok_send(actor, value)
    if check_gmlevel(actor) then return end
    value = tonumber(value)
    local obj = GmBackSystem.op_player
    if nil == obj or "" == obj or nil == value then
        Sendmsg9(actor, "ffffff", "缺少补发玩家!", 1)
        return
    end
    Sendmsg9(actor, "ffffff", "补发成功, 补发金额: "..value, 1)
    Gives(obj, "代币#"..value, "管理后台补发代币")
    RecordBackendOperationLog(actor, obj, "补发代币", "代币", value)
end
-- 封禁角色
function inputstring101(actor)
    if check_gmlevel(actor) then return end
    local obj = GmBackSystem.op_player
    local ban_type = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if nil == obj or "" == obj or nil == tonumber(ban_type) then
        return
    end
    local banned_name = getbaseinfo(obj, 1)
    gmexecute(actor,"DenyCharNameLogon", banned_name, tonumber(ban_type))
    Sendmsg9(actor, "ffffff", "已经封禁玩家："..banned_name, 1)
    RecordBackendOperationLog(actor, obj, "封禁角色", "封禁类型", ban_type)
end
-- 跟踪玩家
function follow_obj(actor)
    if check_gmlevel(actor) then return end
    local obj = GmBackSystem.op_player
    if nil == obj or "" == obj then
        return
    end
    local map_id = getbaseinfo(obj, 3)
    local pos_x = getbaseinfo(obj, 4)
    local pos_y = getbaseinfo(obj, 5)
    mapmove(actor, map_id, pos_x, pos_y)
end
-- 权限设置
function inputstring100(actor)
    if check_gmlevel(actor) then return end
    local obj = GmBackSystem.op_player
    if nil == obj or "" == obj then
        return
    end
    local gm_level = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if "" == gm_level or nil == tonumber(gm_level) then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return
    end
    setgmlevel(GmBackSystem.op_player, tonumber(gm_level))
    Sendmsg9(actor, "ffffff", "设置成功!", 1)
    RecordBackendOperationLog(actor, obj, "设置权限", "权限等级", gm_level)
end
-- 踢下线
function kick_offline(actor)
    if check_gmlevel(actor) then return end
    local obj = GmBackSystem.op_player
    if nil == obj or "" == obj then
        return
    end
    lualib:CallFuncByClient(obj, "GmBackSystem")

    RecordBackendOperationLog(actor, obj, "踢他下线", "", "")
end
-- 清理信息
function clean_player(actor)
    GmBackSystem.showSystem(actor)
end

-- =========================================================== 系统补发 ====================================================================
-- 游戏礼包  暂时不需要这个
-- function game_gift_bag(actor, value)
--     value = tonumber(value)
--     local obj = GmBackSystem.op_player
--     if nil == obj or "" == obj then
--         Sendmsg9(actor, "ffffff", "无补发角色信息!", 1)
--         return
--     end
--     local name = getbaseinfo(obj, 1)
--     messagebox(actor, "给玩家 ["..name.."] 补发 ["..value .."元礼包]", '@_on_give_gift,'..value, '@___')
-- end
-- function _on_give_gift(actor, value)
--     Sendmsg9(actor, "ffffff", value.."元礼包补发成功!", 1)
--     RecordBackendOperationLog(actor, GmBackSystem.op_player, "补发充值礼包", "礼包", value)
-- end
-- 修改货币
function inputstring10000(actor)
    if check_gmlevel(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    local obj = GmBackSystem.op_player
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "无补发角色信息!", 1)
        return
    end    
    local item_tab = strsplit(input_str, "#") 
    local item_id = getstditeminfo(item_tab[1], 0)
    ChangeMoney(obj, item_id,"=", tonumber(item_tab[2]), "gm后台发送"..item_tab[1], true)
    Sendmsg9(actor, "ffffff", "修改成功!", 1)
    RecordBackendOperationLog(actor, obj, "修改货币", item_tab[1], item_tab[2])
end
-- 系统补发
function send_mail(actor, send_type)
    if check_gmlevel(actor) then return end
    send_type = tonumber(send_type)
    local obj = GmBackSystem.op_player
    if nil == obj or "" == obj then
        Sendmsg9(actor, "ffffff", "无补发角色信息!", 1)
        return
    end
    local obj_id = getbaseinfo(obj or "", 2)
    local mail_title = getconst(actor, "<$NPCINPUT(8)>")
    local mail_center = getconst(actor, "<$NPCINPUT(9)>")
    local rewards = ""
    local const = "<$NPCINPUT(%d)>"
    for i = 0, 7, 2 do
        local name = getconst(actor, string.format(const, i))
        local value = getconst(actor, string.format(const, i + 1))
        if send_type == 0 then          -- 绑定发送
            rewards = rewards .. "&" .. name .. "#" .. value .. "#370"
        else
            rewards = rewards .. "&" .. name .. "#" .. value
        end
    end
    SendMail(obj_id, 1, mail_title, mail_center, rewards)
    local op_str = send_type == 0 and "系统绑定补发" or "系统非绑补发"
    RecordBackendOperationLog(actor, obj, op_str, rewards, "")
end

-- =========================================================== 常用功能 ====================================================================
-- 开启/关闭攻城
function shacheng_state(actor, op_type)
    if check_gmlevel(actor) then return end
    op_type = tonumber(op_type)
    local state = castleinfo(5)
    release_print(op_type, tostring(state))
    if op_type == 1 and not state then
        CastleWarTrigger.opCastleWar(actor, "open")
    end
    if op_type == 2 and state then
        CastleWarTrigger.opCastleWar(actor, "close")
    end
end
--道具操作
function inputstring1000(actor)
    if check_gmlevel(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    if string.find(input_str,"#") then
       local item_tab = strsplit(input_str,"#") 
       if #item_tab == 2 and tonumber(item_tab[2]) ~= nil then
            if tonumber(item_tab[2]) == 0 then --清空道具
                local item_id = getstditeminfo(item_tab[1],0)
                if nil == item_id then
                    Sendmsg9(actor, "ff0000", input_str .. "道具id为空, 检查输入是否正确!", 1)
                    return
                end
                if item_id <= 100 then
                    ChangeMoney(actor,item_id,"=",0,"gm清空",true)
                else
                    local count = getbagitemcount(actor,item_tab[1])
                    takeitemex(actor,item_tab[1],count)
                end
            else  --增加
                gives(actor,input_str,"[gives]刷物品")
            end
       end
       RecordBackendOperationLog(actor, actor, "发送道具", item_tab[1], item_tab[2])
    else
        local op_str = "清空货币"
        local item_id = getstditeminfo(input_str, 0)
        if nil == item_id then
            Sendmsg9(actor, "ff0000", input_str .. "道具id为空, 检查输入是否正确!", 1)
            return
        end
        local value = 0
        if item_id <= 100 then
            ChangeMoney(actor, item_id, "=", 0, "gm清空", true)
        else
            gives(actor,input_str.."#1","[gives]刷物品")
            op_str = "发送道具"
            value = 1
        end
        RecordBackendOperationLog(actor, actor, op_str, input_str, value)
    end
end
-- 修改个人变量
function inputstring1001(actor)
    if check_gmlevel(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local tmp_tab = strsplit(input_str, "#")
    local value = tmp_tab[2]
    local time = tmp_tab[3]
    local show_tips = nil
    if string.find(tmp_tab[1], "U_") or string.find(tmp_tab[1], "U") then
        VarApi.setPlayerUIntVar(actor, tmp_tab[1], tonumber(value) or 0, true)
        show_tips = "成功!"
    elseif string.find(tmp_tab[1], "T_") then
        VarApi.setPlayerTStrVar(actor, tmp_tab[1], value or "", true)
        show_tips = "成功!"
    elseif string.find(tmp_tab[1], "J_") then
        VarApi.setPlayerJIntVar(actor, tmp_tab[1], tonumber(value) or 0, tonumber(time))
        show_tips = "成功!"
    elseif string.find(tmp_tab[1], "Z_") then
        VarApi.setPlayerZStrVar(actor, tmp_tab[1], value or "", tonumber(time))
        show_tips = "成功!"
    end    
    if nil ~= show_tips then
        Sendmsg9(actor, "ffffff", show_tips, 1)
    end
    RecordBackendOperationLog(actor, actor, "修改个人变量", tmp_tab[1], tmp_tab[2] or "")
end
-- 修改系统int变量
function inputstring1002(actor)
    if check_gmlevel(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end    
    local tmp_tab = strsplit(input_str, "#")
    local value = tonumber(tmp_tab[2])
    if string.find(tmp_tab[1], "GT_") then

    else
        SetSysInt(tmp_tab[1], value)
    end
    Sendmsg9(actor, "ffffff", "成功!", 1)

    RecordBackendOperationLog(actor, actor, "修改系统int变量", tmp_tab[1], tmp_tab[2])
end
-- 修改系统str变量
function inputstring1003(actor)
    if check_gmlevel(actor) then return end
    local input_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if input_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local tmp_tab = strsplit(input_str, "#")
    SetSysStr(tmp_tab[1], tmp_tab[2])
    Sendmsg9(actor, "ffffff", "成功!", 1)

    RecordBackendOperationLog(actor, actor, "修改系统str变量", tmp_tab[1], tmp_tab[2])
end
-- 查询个人变量
function inputstring1004(actor)
    if check_gmlevel(actor) then return end
    local var_str = getconst(actor,"<$NPCPARAMS(1,S22)>") or ""
    if var_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入变量名!", 1)
        return 
    end
    local var = nil
    if string.find(var_str,"U_") or string.find(var_str,"U") then
        var = VarApi.getPlayerUIntVar(actor, var_str)
    elseif string.find(var_str,"T_") then
        var = VarApi.getPlayerTStrVar(actor, var_str)
    elseif string.find(var_str,"J_") then
        var = VarApi.getPlayerJIntVar(actor, var_str)
    elseif string.find(var_str,"Z_") then
        var = VarApi.getPlayerZStrVar(actor, var_str)
    else
        Sendmsg9(actor, "ffffff", "非法变量名: "..var_str, 1)
    end
    if nil ~= var then
        local str = string.format("个人变量 (%s) 值为: %s", var_str, var)
        messagebox(actor, str, "@______", "@______")
    end
end
-- 查询系统int变量
function inputstring1005(actor)
    if check_gmlevel(actor) then return end
    local var_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if var_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local var = GetSysInt(var_str)
    if nil ~= var then
        local str = string.format("系统int变量 (%s) 值为: %s", var_str, var)
        messagebox(actor, str, "@______", "@______")
    end
end
-- 查询系统str变量
function inputstring1006(actor)
    if check_gmlevel(actor) then return end
    local var_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if var_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local var = GetSysStr(var_str)
    if nil ~= var then
        local str = string.format("系统str变量 (%s) 值为: %s", var_str, var)
        messagebox(actor, str, "@______", "@______")
    end
end
-- 调整等级
function inputstring1007(actor)
    if check_gmlevel(actor) then return end
    local var_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if var_str == "" or nil == tonumber(var_str) then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    changelevel(actor, "=", tonumber(var_str))
    Sendmsg9(actor, "ffffff", "成功!", 1)
    reset_hpmp(actor)
    RecordBackendOperationLog(actor, actor, "调整等级", "等级", var_str)
end
-- 调整转生等级
function inputstring1008(actor)
    if check_gmlevel(actor) then return end
    local var_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if var_str == "" then
        Sendmsg9(actor, "ffffff", "请正确输入", 1)
        return 
    end
    local tmp_tab = strsplit(var_str, "#")
    renewlevel(actor, tonumber(tmp_tab[1]) or 0, tonumber(tmp_tab[2]) or 0, tonumber(tmp_tab[3]) or 0)
    Sendmsg9(actor, "ffffff", "成功!", 1)
    RecordBackendOperationLog(actor, actor, "调整转生等级", "转生等级", tonumber(tmp_tab[1]) or 0)
    VarApi.setPlayerUIntVar(actor, "U101", tonumber(tmp_tab[1]) or 0)
end
-- 清理背包
function clean_my_bag(actor)
    if check_gmlevel(actor) then return end
    gmexecute(actor, "clearbag")
    Sendmsg9(actor, "ffffff", "操作成功", 1)
end
-- 改变人物模式
-- 1=无敌 2=隐身 3=HP 4=MP 5=攻击力 6=魔法力 7=道术力 8=攻击速度 9=禁止攻击 10=锁定
function change_mode(actor, mode)
    if check_gmlevel(actor) then return end
    mode = tonumber(mode)
    changemode(actor, mode, 65535)
end
-- 修改开区天数
function inputstring1010(actor)
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
function inputstring1011(actor)
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
-- 地图清怪
function clean_map_mon(actor)
    if check_gmlevel(actor) then return end
    killmonsters(getbaseinfo(actor,3), "*", 0, true, false)
    RecordBackendOperationLog(actor, actor, "地图清怪", "清怪", "")
end
-- buff信息
function buff_info(actor)
    if check_gmlevel(actor) then return end
    local list_buff = getallbuffid(actor)
    local buff_info = ""
    for i, buffid in ipairs(list_buff) do
        buff_info = buff_info.."buffID: "..buffid.. "，name："..getstdbuffinfo(buffid,1):gsub("[<>/]", "")
        .. "，层数："..getbuffinfo(actor,buffid,1).."，time："..getbuffinfo(actor,buffid,2)
        .."，att："..getbuffinfo(actor,buffid,4).."\\"
    end
    messagebox(actor, buff_info, "", "")
end
-- 一键满血
function reset_hpmp(actor)
    if check_gmlevel(actor) then return end
    addhpper(actor, "=", 100)
    addmpper(actor, "=", 100)
    Sendmsg9(actor, "ffffff", "状态已恢复!", 1)
end
-- 开启秒怪
function open_kill_mon(actor)
    if check_gmlevel(actor) then return end
    local str_attr = "3#28#100|3#74#999999999|3#75#100000"
    addattlist(actor, "open_kill", "+", str_attr, 0)
end
-- 学习技能
function get_skill(actor)
    if check_gmlevel(actor) then return end
    LoginTrigger.loginAddSkills(actor)
    RecordBackendOperationLog(actor, actor, "学习技能", "技能", "")
end
-- 清除技能
function clean_skill(actor)
    if check_gmlevel(actor) then return end
    local skill_list = getallskills(actor)
    local num = 0
    for _, skillID in ipairs(skill_list or {}) do
        delskill(actor,skillID)
        num = num + 1
    end
    RecordBackendOperationLog(actor, actor, "删除所有技能", "删除数量", num)
end
-- 学习单个技能
function inputstring1012(actor)
    if check_gmlevel(actor) then return end
    local skill_name = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if "" == skill_name then
        return
    end
    local skill_id = getskillindex(skill_name)
    addskill(actor, skill_id, 3)
    RecordBackendOperationLog(actor, actor, "学习单个技能", "技能", skill_name)
end
-- 修改开服时间
function inputstring1014(actor)
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
-- 地图传送
function inputstring1015(actor)
    if check_gmlevel(actor) then return end
    local move_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if "" == move_str then
        Sendmsg9(actor, "ffffff", "请正确输入要传送的地图id及坐标!", 1)
        return
    end
    local tab = strsplit(move_str, ",")
    if tab[2] and tab[3] then
        mapmove(actor, tab[1], tab[2], tab[3], 1)
    else
        map(actor, tab[1])
    end
end

-- 添加称号
function inputstring1016(actor)
    if check_gmlevel(actor) then return end
    local title_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if "" == title_str then
        Sendmsg9(actor, "ffffff", "请正确输入称号名称!", 1)
        return
    end
    confertitle(actor, title_str, 1)
end
-- 删除称号
function inputstring1022(actor)
    if check_gmlevel(actor) then return end
    local title_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if "" == title_str then
        Sendmsg9(actor, "ffffff", "请正确输入称号名称!", 1)
        return
    end
    deprivetitle(actor, title_str)
end
--#region 查询字符串属性
function inputstring1017(actor)
    if check_gmlevel(actor) then return end
    local add_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    messagebox(actor,add_str.."属性为"..getattlist(actor,add_str),"","")
end
--#region 改字符串属性
function inputstring1018(actor)
    if check_gmlevel(actor) then return end
    local add_str = getconst(actor,"<$NPCPARAMS(1,S22)>")
    local strName = strsplit(add_str, "=")[1]
    local strValue1 = getattlist(actor,strName)
    local strValue2 = strsplit(add_str, "=")[2]
    delattlist(actor,strName)
    addattlist(actor,strName,"=",strValue2,1)
    messagebox(actor,strName.."属性为"..strValue1.."改为"..getattlist(actor,strName),"","")
    RecordBackendOperationLog(actor, actor, "修改字符串属性", "属性", add_str)
end
--#region 删除BUFF
function inputstring1019(actor)
    if check_gmlevel(actor) then return end
    local buffId = getconst(actor,"<$NPCPARAMS(1,S22)>")
    buffId = tonumber(buffId)
    if buffId == 0 then
        local list_buff = getallbuffid(actor)
        for i, buffid in ipairs(list_buff or {}) do
            delbuff(actor, buffid)
        end
    else
        delbuff(actor,buffId)
    end
    RecordBackendOperationLog(actor, actor, "删BUFF", "BUFFID", buffId)
end
--#region 加BUFF
function inputstring1020(actor)
    if check_gmlevel(actor) then return end
    local buffId = getconst(actor,"<$NPCPARAMS(1,S22)>")
    if addbuff(actor,buffId) then
        Sendmsg9(actor, "ffffff", buffId.."buff添加成功!", 1)
    else
        Sendmsg9(actor, "ffffff", buffId.."buff添加失败!", 1)
    end
    RecordBackendOperationLog(actor, actor, "加BUFF", "BUFFID", buffId)
end
-- 完成某个任务
function inputstring1021(actor)
    if check_gmlevel(actor) then return end
    local task_id = getconst(actor,"<$NPCPARAMS(1,S22)>")
    task_id = tonumber(task_id)
    if task_id then
        TaskTrigger.CompleteTask(actor, task_id)
    end
end
-- 真充+100
function give_recharge(actor)
    if check_gmlevel(actor) then return end
    -- local total_value = VarApi.getPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE)
    -- total_value = total_value + 100
    -- VarApi.setPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE, total_value, true)
    -- local today_recharge = VarApi.getPlayerJIntVar(actor, VarUIntDef.DAY_RECHARGE)
    -- today_recharge = today_recharge + 100
    -- VarApi.setPlayerJIntVar(actor, VarUIntDef.DAY_RECHARGE, today_recharge, nil)
    -- ChangeMoney(actor, 7, "+", 10000, "后台加100充值", true)
    -- ChangeMoney(actor, 18, "+", 100, "后台加100直购币", true)
    Gives(actor, "代币#100", "后台+100代币")
    RecordBackendOperationLog(actor, actor, "加代币", "代币", 100)
end
-- 活动中心
function op_active_state(actor, index)
    index = tonumber(index)
    if check_gmlevel(actor) then return end
    RecordBackendOperationLog(actor, actor, "活动中心", "操作活动", index)
    ActivityMgr.GmOpenActivity(actor,index)
end
-- 直播需求开启另一套配置
function op_active_system(actor)
    if check_gmlevel(actor) then return end
    local sever_info = {
        [0] = "正常区服",
        [1] = "直播区服"
    }
    local value = GetSysInt("G200")
    local center_str = "当前服务器为: <font color='#ffff00'> [".. sever_info[value].."] </font>"
    local set_type = 0
    if value == 0 then
        set_type = 1
    end
    local str = "是否更新换为<font color='#00ff00'> [正常区服] </font>"
    if set_type == 1 then
        str = "是否更新换为<font color='#00ff00'> [直播区服] </font>"
    end
    messagebox(actor, center_str .. str, "@on_click_set,"..set_type, "@______")
end
function on_click_set(actor, value)
    if check_gmlevel(actor) then return end
    value = tonumber(value)
    SetSysInt("G200", value)
    local sever_info = {
        [0] = "正常区服",
        [1] = "直播区服"
    }
    Sendmsg9(actor, "ffffff", "修改成功, 当前区服已改为: <font color='#00ff00'>["..sever_info[value] .. "]</font>", 1)
    GmBackSystem.cur_page = 0
    game_info(actor)
    RecordBackendOperationLog(actor, actor, "修改区服类型", "修改后", sever_info[value])
end
function reset_live_data(actor,index)
    if check_gmlevel(actor) then return end
    index = tonumber(index)
    if index == 1 then
        local class = IncludeNpcClass("AnswerNpc")
        if class then
            class:OpenAnswer() 
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
    elseif index == 4 then
        local npc_class = IncludeNpcClass("KingRemainNpc")
        if npc_class then
            npc_class:onResetKing(actor)
        end
        SetSysInt("G_king_open_state", 1)
        Sendmsg9(actor, "ffffff", "王的遗迹重置成功, 可以重新召唤了!", 1)
    elseif index == 5 then      -- 塔防1
        local npc_class = IncludeNpcClass("TowerDefence")
        if npc_class then
            npc_class:onOpen(actor)
        end
        Sendmsg9(actor, "ffffff", "重置塔防!", 1)
    elseif index == 6 then      -- 塔防2
        local state = GetSysInt("G_mll_defence_state")
        local npc_class = IncludeNpcClass("TowerDefence2")
        if npc_class then
            if state <= 0 then
                npc_class:OpenMllDefence()
                Sendmsg9(actor, "ffffff", "魔龙岭塔防已开启，需手动关闭活动!", 1)
            else
                npc_class:CloseMllDefence()
                Sendmsg9(actor, "ffffff", "魔龙岭塔防已关闭!", 1)
            end
        end
        
    elseif index == 7 then      -- 木之幻境
        local state = GetSysInt("G_tree_state")
        local npc_class = IncludeNpcClass("TreeDreamland")
        if npc_class then
            if state == 0 then
                npc_class:onTreeOpen()
            else
                npc_class:onTreeClose()
            end
        end
        Sendmsg9(actor, "ffffff", "重置木之幻境!", 1)
    elseif index==8 and GetSysInt("G200")>0 then --#region 传奇之路 (堵桥战)
        IncludeNpcClass("BridgeBattle"):clearMon(actor)
    end
end
function inputstring6001(actor)
    if check_gmlevel(actor) then return end
    local name = (getconst(actor,"<$NPCPARAMS(1,S22)>"))
    if name=="" then
        return
    end
    local player=getplayerbyname(name)
    if player=="" then
        return
    end
    killmonsters("老板娘的闺房","*",0,true,true)
    VarApi.setPlayerJIntVar(player,"J_luckBossToday",0,nil)
    VarApi.setPlayerUIntVar(player,"U_luckBossDiceTime",0,false)
    Sendmsg9(actor, "ffffff", "重置玩家"..name.."幸运老板娘!", 1)
end

-- 挖矿几率 1号点位
function inputstring2001(actor)
    local value = (getconst(actor,"<$NPCPARAMS(1,S22)>"))
    value = tonumber(value)
    if nil == value then
        Sendmsg9(actor, "ff0000", "输入错误!", 1)
        return
    end
    SetSysInt("G401", value)
    Sendmsg9(actor, "ffffff", "修改成功!", 1)
end
-- 挖矿几率 2号点位
function inputstring2002(actor)
    local value = (getconst(actor,"<$NPCPARAMS(1,S22)>"))
    value = tonumber(value)
    if nil == value then
        Sendmsg9(actor, "ff0000", "输入错误!", 1)
        return
    end
    SetSysInt("G402", value)
    Sendmsg9(actor, "ffffff", "修改成功!", 1)
end
-- 挖矿几率 3号点位
function inputstring2003(actor)
    local value = (getconst(actor,"<$NPCPARAMS(1,S22)>"))
    value = tonumber(value)
    if nil == value then
        Sendmsg9(actor, "ff0000", "输入错误!", 1)
        return
    end
    SetSysInt("G403", value)
    Sendmsg9(actor, "ffffff", "修改成功!", 1)
end
-- 挖矿几率 4号点位
function inputstring2004(actor)
    local value = (getconst(actor,"<$NPCPARAMS(1,S22)>"))
    value = tonumber(value)
    if nil == value then
        Sendmsg9(actor, "ff0000", "输入错误!", 1)
        return
    end
    SetSysInt("G400", value)
    Sendmsg9(actor, "ffffff", "修改成功!", 1)
end
-- 全局变异几率
function inputstring2005(actor)
    local value = (getconst(actor,"<$NPCPARAMS(1,S22)>"))
    value = tonumber(value)
    if nil == value then
        Sendmsg9(actor, "ff0000", "输入错误!", 1)
        return
    end
    SetSysInt("G_variationOdd", value)
    Sendmsg9(actor, "ffffff", "修改成功!", 1)
end
--============================================================= 后台操作日志 ===================================================================
-- 记录gm后台操作日志
function RecordBackendOperationLog(op_actor, target_obj, op_type, param1, param2)
    local gm_name = getbaseinfo(op_actor, 1)
    local name = getbaseinfo(target_obj, 1)
    local time = GetMonth().. "/" .. GetDay() .. " " .. GetHour() .. ":" .. GetMin()
    local op_log = GetSysStr(VarEngine.SysOpLog)
    if "" == op_log then
        op_log = {}
    else
        op_log = json2tbl(op_log)
    end
    local str = string.format("【%s】: [%s] - [GM后台] -给【%s】%s【%s : %s】", gm_name, time, name, op_type, param1, param2)
    op_log[#op_log + 1] = str
    SetSysStr(VarEngine.SysOpLog, tbl2json(op_log))
end
-- 获取gm后台操作日志
function GetBackendOperationLog()
    local list = {}
    local op_log = GetSysStr(VarEngine.SysOpLog)
    if "" == op_log then
        op_log = {}
    else
        -- op_log = json2tbl(op_log)
        for i,v in ipairs(json2tbl(op_log)) do
            table.insert(list,v)
        end
    end

    op_log = GetSysStr("A_chang_server_log")
    if "" == op_log then
        op_log = {}
    else
        -- op_log = json2tbl(op_log)
        for i,v in ipairs(json2tbl(op_log)) do
            table.insert(list,v)
        end
    end

    op_log = GetSysStr("A_get_change_server_log")
    if "" == op_log then
        op_log = {}
    else
        -- op_log = json2tbl(op_log)
        for i,v in ipairs(json2tbl(op_log)) do
            table.insert(list,v)
        end
    end
    
    return list
end

-- 清理后台日志
function clean_backend_log(actor)
    if check_gmlevel(actor) then return end
    SetSysStr(VarEngine.SysOpLog, "")
    Sendmsg9(actor, "00ff00", "清理成功", 9)
end

--#region gm工具
function usercmd9001(actor)
    if check_gmlevel(actor) then return end
    local server_id = GetServerIDX()
    if server_id < 10000 or GetSysInt("G200") > 0 then
        GmBackSystem.showSystem(actor)
    else
        GmBackSystem.password(actor)
    end
end