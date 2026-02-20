local AnswerNpc = {}
AnswerNpc.moncfg = GetConfig("AnswerMonCfg")
AnswerNpc.moncfg2 = GetConfig("AnswerMonCfg2")
AnswerNpc.cfg = GetConfig("AnswerCfg")

function AnswerNpc:click(actor)
    local key = math.random(1,#self.cfg) 
    local say_ui = [[
        <Img|bg=1|loadDelay=0|move=0|img=public/bg_npc_01.png|height=230|reset=1|show=4|scale9l=20|scale9r=20|scale9t=20|scale9b=20>
        <Layout|x=545|y=0|width=80|height=80|link=@exit>
        <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Layout|id=100|children={10001,10002,10003,10004,10005,10006}|x=10|y=23.0|width=108|height=29>
        <RText|id=10001|x=22|y=06|outline=1|color=255|size=17|text=<哟！小哥，想去下一层？先让我猜猜你是不是传奇老登！/FCOLOR=249>>
        <RText|id=10002|x=22|y=36|outline=1|color=255|size=17|text=<%s/FCOLOR=251>>
        <ItemShow|id=10003|x=225|y=66|width=70|height=70|itemid=%s|itemcount=1|showtips=0|bgtype=1>
        <Img|id=10004|x=185|y=150|width=150|height=27|img=public/1900015004.png>
        <Input|id=10005|x=185|y=150|width=150|height=27|inputid=1|color=255|errortips=1|isChatInput=0|mincount=6|maxcount=99|place=请输入答案|type=0|size=18>
        <Button|id=10006|x=350|y=148|nimg=public/1900000612.png|size=18|color=255|submitInput=1|text=提交答案|link=@submit_option,%s>
        ]]
    local cfg = self.cfg[key]
    local say_str = string.format(say_ui,cfg.show_str,getstditeminfo(cfg.show_item, 0),key)
    say(actor, say_str)
end
function submit_option(actor,key)
    local cfg = AnswerNpc.cfg[tonumber(key)]
    local str = getconst(actor, "<$NPCINPUT(1)>")
    if  str == cfg.correct then
        Sendmsg9(actor, "00ff00", "回答正确!", 1)
        mapmove(actor,"诡异空间二层",7,51,2)
        return
    end
    Sendmsg9(actor, "ff0000", "回答错误!", 1)
end
function AnswerNpc:AnswerGenMon()
    killmonsters("诡异空间一层", "*", 0, true, true)
    killmonsters("诡异空间二层", "*", 0, true, true)
    globaldelaygoto(200, "answer_delay_update_mon")
end
function answer_delay_update_mon()
    local npc_class = IncludeNpcClass("AnswerNpc")
    if npc_class then
        npc_class:delayUpdateMon()
    end
end

function AnswerNpc:delayUpdateMon()
    local cfg = GetSysInt("G200") > 0 and self.moncfg2 or self.moncfg
    for i,v in ipairs(cfg) do
        genmon(v.map_id, v.pos_x,v.pos_y, v.mon_name, v.range, v.num,v.color or 255)
    end
    for i = 1, 3 do
        sendmovemsg("0", 0, 250, 0, 60 + (i - 1 ) * 30, 1, "【答题】答题活动已开始, 各位少侠可从【盟重土城】282.309进入答题!")
    end
end

function AnswerNpc:OpenAnswer()
    SetSysTLInt("G_J_answer_state", 1,GetDayTick() + 86400)
    self:AnswerGenMon()
end
return AnswerNpc