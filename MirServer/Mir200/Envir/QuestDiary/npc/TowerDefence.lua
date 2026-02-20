local TowerDefence = {}
TowerDefence.cfg  = GetConfig("DefenceCfg")
TowerDefence.g_run_time_value = TowerDefence.g_run_time_value or 0

TowerDefence.baby_cfg = {
    ["弓箭守卫9"]=1000,
    ["牛魔法师9"]=2000,
    ["牛魔王9"]=10000,
}
TowerDefence.level_cfg = {
    ["弓箭守卫9"]=1,
    ["牛魔法师9"]=2,
    ["牛魔王9"]=3,
}
TowerDefence.pos_cfg = {{30,29},{27,33},{29,38},{25,43},{33,43},{29,47},{36,46},{41,49},{44,51},{48,48}}

function TowerDefence:DefenceNpc(actor)
    local str = [[<Img|bg=1|loadDelay=0|move=0|img=public/bg_npc_01.png|reset=1|show=4>
        <Layout|x=545|y=0|width=80|height=80|link=@exit>
        <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Layout|id=100|children={10001,10002,10003,10004}|x=10|y=23.0|width=108|height=29|color=X>
        <RText|id=10001|x=130|y=06|outline=1|color=255|size=17|text=魔龙城寨正在遭受妖族的进攻>
        <RText|id=10002|x=130|y=36|outline=1|color=255|size=17|text=英雄是否愿意前往协助抵抗侵略？>
        <Text|id=10003|x=100|y=76|outline=1|color=251|size=18|text=我要前往|link=@move_defence_map>
        <Text|id=10004|x=350|y=76|outline=1|color=251|size=18|text=关闭对话|link=@exit>
    ]]
    say(actor,str)
end
function move_defence_map(actor)
    local state = GetSysInt("G_Defence_state")
    if state == 0 and GetSysInt("G_Defence_mon_end") - os.time() <= 0 then
        return Sendmsg9(actor, "ffffff", "当前活动未开启!", 1)  
    end
    local open_day = GetSysInt(VarEngine.OpenDay) 
    if open_day <= 0 then  --开服第一天  
        
    else
        if getbagitemcount(actor, "飞行符", 0) < 10 then
           return Sendmsg9(actor, "ff0000", "进入地图需要飞行符*10!", 1)  
        end
        if not takeitem(actor,"飞行符",10,0,"进龙虎山扣除") then
            return Sendmsg9(actor, "ff0000", "飞行符扣除失败!", 1)  
        end
    end
    mapmove(actor,"龙虎山",38,38,3) 
end


function TowerDefence:clickNpc(actor)
    local str = [[
    <Img|width=620|height=400|img=public/bg_npc_01.png|bg=1|scale9r=10|scale9t=10|scale9b=10|reset=1|scale9l=10|move=0>
    <Layout|x=597|y=3|width=80|height=80|link=@exit>
    <Button|x=619|y=2.0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
    <Text|a=0|x=30|y=20|tipsx=10|tipsy=80|color=255|size=18|text=　　　    　　　　　  请选择放置弓箭手的位置 >
    <Text|x=52|y=40|nimg=public/1900000679.png|pimg=public/1900000679_1.png|text=◎1号|color=251|size=18>
    <Text|a=0|x=120|y=40|tipsx=10|tipsy=80|color=249|size=18|text=%s>
    <Text|a=0|x=220|y=40|tipsx=10|tipsy=80|color=250|size=18|text=召唤弓箭守卫|link=@summon_baby,弓箭守卫9,1>
    <Text|a=0|x=340|y=40|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔法师|link=@summon_baby,牛魔法师9,1>
    <Text|a=0|x=460|y=40|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔王|link=@summon_baby,牛魔王9,1>
    <Text|x=52|y=70|nimg=public/1900000679.png|pimg=public/1900000679_1.png|text=◎2号|color=251|size=18>
    <Text|a=0|x=120|y=70|tipsx=10|tipsy=80|color=249|size=18|text=%s>
    <Text|a=0|x=220|y=70|tipsx=10|tipsy=80|color=250|size=18|text=召唤弓箭守卫|link=@summon_baby,弓箭守卫9,2>
    <Text|a=0|x=340|y=70|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔法师|link=@summon_baby,牛魔法师9,2>
    <Text|a=0|x=460|y=70|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔王|link=@summon_baby,牛魔王9,2>
    <Text|x=52|y=100|nimg=public/1900000679.png|pimg=public/1900000679_1.png|text=◎3号|color=251|size=18>
    <Text|a=0|x=120|y=100|tipsx=10|tipsy=80|color=249|size=18|text=%s>
    <Text|a=0|x=220|y=100|tipsx=10|tipsy=80|color=250|size=18|text=召唤弓箭守卫|link=@summon_baby,弓箭守卫9,3>
    <Text|a=0|x=340|y=100|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔法师|link=@summon_baby,牛魔法师9,3>
    <Text|a=0|x=460|y=100|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔王|link=@summon_baby,牛魔王9,3>
    <Text|x=52|y=130|nimg=public/1900000679.png|pimg=public/1900000679_1.png|text=◎4号|color=251|size=18>
    <Text|a=0|x=120|y=130|tipsx=10|tipsy=80|color=249|size=18|text=%s>
    <Text|a=0|x=220|y=130|tipsx=10|tipsy=80|color=250|size=18|text=召唤弓箭守卫|link=@summon_baby,弓箭守卫9,4>
    <Text|a=0|x=340|y=130|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔法师|link=@summon_baby,牛魔法师9,4>
    <Text|a=0|x=460|y=130|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔王|link=@summon_baby,牛魔王9,4>
    <Text|x=52|y=160|nimg=public/1900000679.png|pimg=public/1900000679_1.png|text=◎5号|color=251|size=18>
    <Text|a=0|x=120|y=160|tipsx=10|tipsy=80|color=249|size=18|text=%s>
    <Text|a=0|x=220|y=160|tipsx=10|tipsy=80|color=250|size=18|text=召唤弓箭守卫|link=@summon_baby,弓箭守卫9,5>
    <Text|a=0|x=340|y=160|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔法师|link=@summon_baby,牛魔法师9,5>
    <Text|a=0|x=460|y=160|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔王|link=@summon_baby,牛魔王9,5>
    <Text|x=52|y=190|nimg=public/1900000679.png|pimg=public/1900000679_1.png|text=◎6号|color=251|size=18>
    <Text|a=0|x=120|y=190|tipsx=10|tipsy=80|color=249|size=18|text=%s>
    <Text|a=0|x=220|y=190|tipsx=10|tipsy=80|color=250|size=18|text=召唤弓箭守卫|link=@summon_baby,弓箭守卫9,6>
    <Text|a=0|x=340|y=190|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔法师|link=@summon_baby,牛魔法师9,6>
    <Text|a=0|x=460|y=190|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔王|link=@summon_baby,牛魔王9,6>
    <Text|x=52|y=220|nimg=public/1900000679.png|pimg=public/1900000679_1.png|text=◎7号|color=251|size=18>
    <Text|a=0|x=120|y=220|tipsx=10|tipsy=80|color=249|size=18|text=%s>
    <Text|a=0|x=220|y=220|tipsx=10|tipsy=80|color=250|size=18|text=召唤弓箭守卫|link=@summon_baby,弓箭守卫9,7>
    <Text|a=0|x=340|y=220|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔法师|link=@summon_baby,牛魔法师9,7>
    <Text|a=0|x=460|y=220|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔王|link=@summon_baby,牛魔王9,7>
    <Text|x=52|y=250|nimg=public/1900000679.png|pimg=public/1900000679_1.png|text=◎8号|color=251|size=18>
    <Text|a=0|x=120|y=250|tipsx=10|tipsy=80|color=249|size=18|text=%s>
    <Text|a=0|x=220|y=250|tipsx=10|tipsy=80|color=250|size=18|text=召唤弓箭守卫|link=@summon_baby,弓箭守卫9,8>
    <Text|a=0|x=340|y=250|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔法师|link=@summon_baby,牛魔法师9,8>
    <Text|a=0|x=460|y=250|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔王|link=@summon_baby,牛魔王9,8>
    <Text|x=52|y=280|nimg=public/1900000679.png|pimg=public/1900000679_1.png|text=◎9号|color=251|size=18>
    <Text|a=0|x=120|y=280|tipsx=10|tipsy=80|color=249|size=18|text=%s>
    <Text|a=0|x=220|y=280|tipsx=10|tipsy=80|color=250|size=18|text=召唤弓箭守卫|link=@summon_baby,弓箭守卫9,9>
    <Text|a=0|x=340|y=280|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔法师|link=@summon_baby,牛魔法师9,9>
    <Text|a=0|x=460|y=280|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔王|link=@summon_baby,牛魔王9,9>
    <Text|x=52|y=310|nimg=public/1900000679.png|pimg=public/1900000679_1.png|text=◎10号|color=251|size=18>
    <Text|a=0|x=120|y=310|tipsx=10|tipsy=80|color=249|size=18|text=%s>
    <Text|a=0|x=220|y=310|tipsx=10|tipsy=80|color=250|size=18|text=召唤弓箭守卫|link=@summon_baby,弓箭守卫9,10>
    <Text|a=0|x=340|y=310|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔法师|link=@summon_baby,牛魔法师9,10>
    <Text|a=0|x=460|y=310|tipsx=10|tipsy=80|color=250|size=18|text=召唤牛魔王|link=@summon_baby,牛魔王9,10>
    ]]

    local pos_data = json2tbl(GetSysStr("A_defence_pos_data")) 
    if pos_data == "" then
        pos_data = {}
        for i = 1, 10 do
            pos_data[i] = {baby_name = "",mon =nil}
        end
    end
    local name_list = {}
    for i,v in ipairs(pos_data) do
        if v.baby_name =="" then
            name_list[i]="无"
        else
            name_list[i]= string.gsub(v.baby_name, "%d", "")
        end
    end
    say(actor,string.format(str,unpack(name_list)) )
end
function TowerDefence:OpenDefenceActivity()
    setenvirofftimer("龙虎山", 111111)
    killmonsters("龙虎山","*", 0, true,true)
    self:ClearBaBy()
    SetSysInt("G_Defence_state",1)
    SetSysInt("G_Defence_mon_end",0)
    self.g_run_time_value = 0
    SetSysInt("G_Defence_mon_num",0)
    SetSysInt("G_Defence_level",1)
    globaldelaygoto(300,"open_add_baby")
end
function TowerDefence:onOpen()
    SetSysTLInt("G_J_gs_Defence_state", 1,GetDayTick() + 86400)
    self:OpenDefenceActivity()
end

function open_add_baby()
    local data = {}
    local mons = recallmobex("0", "弓箭守卫9", 30, 29, 0, 1, nil, 0, 1, 1, 1)
    mapmove(mons[1], "龙虎山", 30,29,0)
    data[1] = {baby_name = "弓箭守卫9",mon = mons[1]}
    for i = 2, 10 do
        data[i] = {baby_name = "",mon =nil}
    end
    SetSysStr("A_defence_pos_data",tbl2json(data))
    globalcleardelaygoto("open_add_baby", 1)
    if GetSysInt("G200") > 0 then
        genmon("龙虎山", 39, 34, "贞子王1", 1, 1)
    else
        genmon("龙虎山", 39, 34, "贞子王", 1, 1)
    end

    setenvirontimer("龙虎山", 111111,1, "@defence_genmon")
    local tips_str = "<【魔龙城主】∶/FCOLOR=250><魔龙城寨正在被妖族进攻，请各位勇士前去土城正上方NPC协助抵抗！！！/FCOLOR=253>"
    if tips_str then
        for i = 1, 3 do
            sendmovemsg("0", 0, 255, 0, 60 + (i - 1 ) * 30, 1, tips_str)
        end
    end
    Sendmsg1("0", 255, 249, "【魔龙城主】∶魔龙城寨正在被妖族进攻，请各位勇士前去土城正上方NPC协助抵抗！！！！", 2)
end
function TowerDefence:ClearBaBy()
    local pos_data = json2tbl(GetSysStr("A_defence_pos_data")) 
    if pos_data ~= "" then
        for k, v in pairs(pos_data) do
            killmonbyobj("0", v.mon, false, false,false)
        end
    end
end
function defence_genmon()
    TowerDefence.g_run_time_value = TowerDefence.g_run_time_value + 1 
    if GetSysInt("G_Defence_level") <= 9 then
        if GetSysInt("G_Defence_mon_num") >= 100 then
            if GetSysInt("G_Defence_level") >= 9 then
                SetSysInt("G_Defence_level",10)
                SetSysInt("G_Defence_state",0)
                SetSysInt("G_Defence_mon_end",os.time()+900)
                local players = getplaycount("龙虎山",1,1)
                for i, player  in ipairs(type(players) == "table" and players or {}) do
                    TowerDefence:FlushDefenceTaskUi(player)
                end   
            else
                local mon = genmon("龙虎山", 29, 23, TowerDefence.cfg[GetSysInt("G_Defence_level")].mon_name, 0, 1)
                monmission(mon[1], "26;24;24;27;40;46;57", "27;30;38;44;57;56;45", 0)
                setenvirofftimer("龙虎山", 111111)
                SetSysInt("G_Defence_next_time",os.time()+10)
                local players = getplaycount("龙虎山",1,1)
                for i, player  in ipairs(type(players) == "table" and players or {}) do
                    TowerDefence:FlushDefenceTaskUi(player)
                end
                globaldelaygoto(10000, "next_genmon")
            end
        else
            if TowerDefence.g_run_time_value % 2 == 0 then
                SetSysInt("G_Defence_mon_num",GetSysInt("G_Defence_mon_num") + 1)
                local mon = genmon("龙虎山", 28,24, "半兽人9", 1,1)
                monmission(mon[1], "26;24;24;27;40;46;57", "27;30;38;44;57;56;45", 0)
            end
        end

        local players = getplaycount("龙虎山",1,1)
        for i, player  in ipairs(type(players) == "table" and players or {}) do
            TowerDefence:FlushDefenceTaskUi(player)
        end
    end
    for i,v in ipairs(getobjectinmap("龙虎山", 57, 45, 1, 2)) do
        killmonbyobj("0", v, false, false,false)
    end 
   
end
function next_genmon()
    globalcleardelaygoto("next_genmon", 1)
    SetSysInt("G_Defence_next_time",os.time())
    SetSysInt("G_Defence_mon_num",0)
    SetSysInt("G_Defence_level",GetSysInt("G_Defence_level") + 1)
    setenvirontimer("龙虎山", 111111,1, "@defence_genmon")
end

function summon_baby(actor,baby_name,pos_index)
    if TowerDefence:CheckPosIsHasBaby(pos_index,baby_name) then
        return Sendmsg9(actor, "ffffff", "该位置已经存在同级别宝宝了，无需重复召唤！", 1)
    end
    messagebox(actor,"召唤"..baby_name.."需要消耗元宝*".. TowerDefence.baby_cfg[baby_name].."\\是否召唤？","@placebaby,"..pos_index..","..baby_name,"@not")
end
--放置宝宝
function placebaby(actor,pos_index,baby_name)
    local state = GetSysInt("G_Defence_state")
    if state == 0 then
       return Sendmsg9(actor, "ffffff", "活动未开启！", 1)
    end
   
    pos_index = tonumber(pos_index)
    local pos_data = json2tbl(GetSysStr("A_defence_pos_data")) 
    if TowerDefence:CheckPosIsHasBaby(pos_index,baby_name) then
        return Sendmsg9(actor, "ff0000", "该位置已经存在同级别宝宝了，无需重复召唤！", 1)
    end

    if pos_data[pos_index] and pos_data[pos_index].mon ~= nil then
        if TowerDefence.level_cfg[pos_data[pos_index].baby_name] > TowerDefence.level_cfg[baby_name] then
            Sendmsg9(actor, "ffffff", "该位置已存在高等级宝宝！", 1)
            return  
        end
    end

    if querymoney(actor, getstditeminfo("元宝", 0)) < TowerDefence.baby_cfg[baby_name] then
        return  Sendmsg9(actor, "ffffff", "元宝不足！", 1)
    end

    if not ChangeMoney(actor,getstditeminfo("元宝", 0),"-",TowerDefence.baby_cfg[baby_name],"塔防召唤宝宝消耗") then
        return  Sendmsg9(actor, "ffffff", "元宝扣除失败！", 1)
    end
    if pos_data[pos_index] and pos_data[pos_index].mon ~= nil then
        killmonbyobj("0", pos_data[pos_index].mon, false, false,false)
    end

    Sendmsg9(actor, "ffffff", "已在"..pos_index.."号位置放置宝宝", 1)
    delaymsggoto(actor, 100, "@flush_baby,"..pos_index..","..baby_name)
    
end
function flush_baby(actor,pos_index,baby_name)
    pos_index = tonumber(pos_index)
    local pos_cfg = TowerDefence.pos_cfg[tonumber(pos_index) ]
    local objList = getobjectinmap("龙虎山",pos_cfg[1], pos_cfg[2] , 1,1)
    for k, v in pairs(objList or {}) do
        mapmove(v,"龙虎山",38, 38,1)
    end
    local pos_data = json2tbl(GetSysStr("A_defence_pos_data")) 
    local mons = recallmobex("0", baby_name, pos_cfg[1], pos_cfg[2], 0, 1, nil, 0, 1, 1, 1)
    for i, mon in ipairs(mons or {}) do
        pos_data[pos_index] = {baby_name= baby_name,mon= mon}
    end
    SetSysStr("A_defence_pos_data",tbl2json(pos_data))
    TowerDefence:clickNpc(actor)
end
function TowerDefence:CheckPosIsHasBaby(pos_index,baby_name)
    pos_index = tonumber(pos_index) 
    local pos_data = json2tbl(GetSysStr("A_defence_pos_data")) 
    if pos_data ~= "" and pos_data[pos_index] ~= nil and pos_data[pos_index].baby_name == baby_name then
        return true
    end
    return false
end

function TowerDefence:FlushDefenceTaskUi(actor)
    delbutton(actor, 110, "_654321")
    if GetSysInt("G_Defence_mon_end") - os.time() > 0 then
        local btn_str = [[
            <RText|x=100|y=70|a=4|outline=2|color=255|size=18|text=活动已结束>
            <COUNTDOWN|x=55|y=100|a=4|outline=2|color=249|size=18|count=1|time=%s|showWay=1|link=defen_gohom>
            <RText|x=150|y=100|a=4|outline=2|color=255|size=18|text=后退出场景>
            ]]
        addbutton(actor, 110, "_654321", string.format(btn_str,GetSysInt("G_Defence_mon_end")-os.time()) )
    else
        local btn_str = [[
            <RText|x=100|y=30|a=4|outline=2|color=255|size=18|text=关卡当前层数：%s/9>
            <RText|x=100|y=80|a=4|outline=2|color=255|size=18|text=关卡剩余怪物：%s>
            <RText|x=100|y=130|a=4|outline=2|color=255|size=18|text=关卡怪物难度：初级>
        ]]
        local time =  GetSysInt("G_Defence_next_time")
        if time - os.time() > 0 then
            local count_down_str = [[
                <COUNTDOWN|x=40|y=160|a=4|outline=2|color=249|size=18|count=1|time=10>|showWay=0>
                <RText|x=120|y=160|a=4|outline=2|color=255|size=18|text=后进入下一轮>
            ]]
            btn_str = btn_str .. string.format(count_down_str,time - os.time()) 
        end
        local level = GetSysInt("G_Defence_level") 
        addbutton(actor, 110, "_654321", string.format(btn_str,level> 9 and 9 or level,100 - GetSysInt("G_Defence_mon_num")) )
    end
end
function defen_gohom(actor)
    mapmove(actor,"3",325,334,5)
end

function TowerDefence:SetMonDrop(actor,monObj,monName)
    local base_drop = "10元宝|1万经验珠|书页|五行精华|金针|转生凭证"
    local drop_str = "drop_name"
    if GetSysInt("G200") > 0 then
        base_drop = "10元宝|1万经验珠|书页|五行精华|金针|转生凭证"
        drop_str = "drop_name2"
    end
    local level = GetSysInt("G_Defence_level") > 9 and 9 or GetSysInt("G_Defence_level")
    if monName == "半兽人9" then
        base_drop = base_drop .. "|"..self.cfg[level][drop_str]
        local item_str = ransjstr(base_drop, 1, 0)
        item_str = strsplit(item_str,"#")
        if self.cfg[item_str[1]] then
            local equip_list = self.cfg[item_str[1]].drop_equip_arr
            local value = math.random(1,#equip_list) 
            throwitem("0", "龙虎山", 39, 40, 5,equip_list[value], 1)
        else
            throwitem("0", "龙虎山", 39, 40, 5, item_str[1], 1)
        end
    else
        local equip_list = GetSysInt("G200") > 0 and  self.cfg["上古1装备随机"].drop_equip_arr or self.cfg["上古1装备随机2"].drop_equip_arr
        local value = math.random(1,#equip_list) 
        throwitem("0", "龙虎山", 39, 40, 5,equip_list[value], 1)
    end

end
return TowerDefence