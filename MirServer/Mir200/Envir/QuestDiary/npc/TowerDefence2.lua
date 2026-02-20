local TowerDefence2 = {}
TowerDefence2.mon_cfg = GetConfig("Defence2Cfg")
TowerDefence2.cfg = {}
for i,v in ipairs(TowerDefence2.mon_cfg) do
    TowerDefence2.cfg[v.path_index] = TowerDefence2.cfg[v.path_index] or {}
    table.insert(TowerDefence2.cfg[v.path_index],v) 
end

TowerDefence2.g_run_time_value = TowerDefence2.g_run_time_value or 0
function TowerDefence2:OpenMllDefence()
    setenvirofftimer("魔龙岭", 1222222)
    if not HasNation(1) then
        createnation(1,"魔龙岭", 1000)
    end
    SetSysInt("G_mll_defence_state",1)
    self.g_run_time_value = 0
    setenvirontimer("魔龙岭", 1222222,1, "@mll_defence_genmon")
    SetSysStr("A_mll_mon_num","")
    local tips_str = "<【魔龙卫士】∶/FCOLOR=250><魔龙岭正在被妖族进攻，请各位勇士前去土城正上方NPC协助抵抗！！！/FCOLOR=253>"
    if tips_str then
        for i = 1, 3 do
            sendmovemsg("0", 0, 255, 0, 60 + (i - 1 ) * 30, 1, tips_str)
        end
    end
    Sendmsg1("0", 255, 249, "【魔龙卫士】∶魔龙岭正在被妖族进攻，请各位勇士前去土城正上方NPC协助抵抗！！！！", 2)
    globaldelaygoto((10 * 60) * 1000, "delay_closemll")
end
function delay_closemll()
    killmonsters("魔龙岭","*", 0, true,true)
    globalcleardelaygoto("delay_closemll", 1)
    SetSysInt("G_mll_defence_state",0)
    SetSysStr("A_mll_mon_num","")
    setenvirofftimer("魔龙岭", 1222222)
    Sendmsg1("0", 255, 249, "【魔龙卫士】∶魔龙岭已关闭！！！", 2)
end
function TowerDefence2:CloseMllDefence()
    globalcleardelaygoto("delay_closemll", 1)
    clearitemmap("魔龙岭",50,75,1000,"*")
    SetSysInt("G_mll_defence_state",0)
    SetSysStr("A_mll_mon_num","")
    setenvirofftimer("魔龙岭", 1222222)
    killmonsters("魔龙岭","*", 0, true,true)
    Sendmsg1("0", 255, 249, "【魔龙卫士】∶魔龙岭已关闭！！！", 2)
end

function mll_defence_genmon()
    TowerDefence2.g_run_time_value = TowerDefence2.g_run_time_value + 1
    if TowerDefence2.g_run_time_value % 6 == 0 then  
        --跑道1刷怪 
        TowerDefence2:PathGenMon(1,1)
        --跑道2刷怪
        TowerDefence2:PathGenMon(2,1)
    elseif TowerDefence2.g_run_time_value % 3 == 0 then  
        TowerDefence2:PathGenMon(1,2)
        TowerDefence2:PathGenMon(2,2)
    end
    --跑道1到点清怪
    for i,v in ipairs(getobjectinmap("魔龙岭", 51, 48, 0, 2)) do
        TowerDefence2:SetPathMonNum(v,getbaseinfo(v,1,1))
        killmonbyobj("0", v, false, false,false)
    end 

    for i,v in ipairs(getobjectinmap("魔龙岭", 50, 48, 0, 2)) do
        TowerDefence2:SetPathMonNum(v,getbaseinfo(v,1,1))
        killmonbyobj("0", v, false, false,false)
    end 
    --跑道2到点清怪
    for i,v in ipairs(getobjectinmap("魔龙岭", 90, 83, 0, 2)) do
       TowerDefence2:SetPathMonNum(v,getbaseinfo(v,1,1))
        killmonbyobj("0", v, false, false,false)
    end 

    for i,v in ipairs(getobjectinmap("魔龙岭", 89, 83, 0, 2)) do
        TowerDefence2:SetPathMonNum(v,getbaseinfo(v,1,1))
        killmonbyobj("0", v, false, false,false)
    end 
end
function TowerDefence2:Defence2Npc(actor)
    local str = [[<Img|bg=1|loadDelay=0|move=0|img=public/bg_npc_01.png|reset=1|show=4>
        <Layout|x=545|y=0|width=80|height=80|link=@exit>
        <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Layout|id=100|children={10001,10002,10003,10004}|x=10|y=23.0|width=108|height=29|color=X>
        <RText|id=10001|x=130|y=06|outline=1|color=255|size=17|text=魔龙岭正在遭受妖族的进攻>
        <RText|id=10002|x=130|y=36|outline=1|color=255|size=17|text=英雄是否愿意前往协助抵抗侵略？>
        <Text|id=10003|x=100|y=76|outline=1|color=251|size=18|text=我要前往|link=@move_defence2_map>
        <Text|id=10004|x=350|y=76|outline=1|color=251|size=18|text=关闭对话|link=@exit>
    ]]
    say(actor,str)
end
function move_defence2_map(actor)
    local state = GetSysInt("G_mll_defence_state")
    if state <= 0 then
        return Sendmsg9(actor, "ffffff", "当前活动未开启!", 1)  
    end
    if getbagitemcount(actor, "飞行符", 0) < 1 then
        return Sendmsg9(actor, "ff0000", "进入地图需要飞行符*1!", 1)  
    end
    if not takeitem(actor,"飞行符",1,0,"进魔龙岭扣除") then
        return Sendmsg9(actor, "ff0000", "飞行符扣除失败!", 1)  
    end
    mapmove(actor,"魔龙岭",36,46,5)
end
function TowerDefence2:PathGenMon(path,index)
    local cfg = TowerDefence2.cfg[path][index]
    local mon_info = cfg["gen_mon_arr"..math.random(1,4)] 
    if (path == 1 and index == 1) or (path == 2 and index == 2) then
        local random = ""
        for i = 1, 4 do
            local str =  cfg["gen_mon_arr"..i] 
            random = random.."|"..str[1].."#"..str[2]
        end
        mon_info = ransjstr(random, 1, 0)
        mon_info = strsplit(mon_info,"#")
    end
    if mon_info and mon_info[1]~="" then
        local mon_num = TowerDefence2:GetPathMonNum(path,index,mon_info[1])
        if mon_num < tonumber(mon_info[2]) then
            local mon_cfg = TowerDefence2.mon_cfg[mon_info[1]]
            if mon_cfg == nil then
                return 
            end
            local mons = genmonex("魔龙岭", cfg.create_point_arr[1], cfg.create_point_arr[2], mon_info[1], 0, 1, 0, mon_cfg.color, mon_info[1], 0, "魔龙岭", 0, 0, 0,0)
            monmission(mons[1], cfg.path_point1,cfg.path_point2, 0)
            SetInt(5, mons[1], "U_path_type", tonumber(path..index))
            TowerDefence2:SetPathMonNum(mons[1],mon_info[1],true)
        else
            TowerDefence2:PathGenMon(path,index)
        end
    end
end
function TowerDefence2:GetPathMonNum(path,index,mon_name)
    local list = json2tbl(GetSysStr("A_mll_mon_num"))
    if list == "" then
       return 0 
    end
    if list and list[path..index..mon_name] then
        return list[path..index..mon_name]
    end
    return 0
end

function TowerDefence2:SetPathMonNum(mon, mon_name,is_add)
    local list = json2tbl(GetSysStr("A_mll_mon_num"))
    if list == "" then
        list = {}
    end
    local path_type = GetInt(5,mon,"U_path_type")
    if is_add then
        list[path_type..mon_name] = (list[path_type..mon_name] or 0) + 1
    else
        if list[path_type..mon_name] and list[path_type..mon_name] > 0 then
            list[path_type..mon_name] = list[path_type..mon_name] - 1
        end
    end
    SetSysStr("A_mll_mon_num",tbl2json(list))
end

function TowerDefence2:SetMllMonDrop(actor, monObj,monName)
    local list = json2tbl(GetSysStr("A_mll_mon_num"))
    if list == "" then
        list = {}
    end
    if monName ~= "堕落骑士·必爆武器" then       
        local cfg_mon_name = getbaseinfo(monObj,1,1)
        local path_type = GetInt(5,monObj,"U_path_type")
        if list[path_type..cfg_mon_name] and list[path_type..cfg_mon_name] > 0 then
            list[path_type..cfg_mon_name] = list[path_type..cfg_mon_name] - 1
        end
        SetSysStr("A_mll_mon_num",tbl2json(list))
    end

    local equip_list = GetSysInt("G200") > 0 and self.mon_cfg[monName].drop_arr2 or self.mon_cfg[monName].drop_arr
    local value = math.random(1,#equip_list) 
    local x,y = getbaseinfo(actor,4),getbaseinfo(actor,5)
    throwitem("0", "魔龙岭", x,y, 1,equip_list[value], 1)
    if monName =="堕落骑士·必爆武器" and GetSysInt("G200") > 0 then
        throwitem("0", "魔龙岭", x,y, 1,"万倍地图爆率卷", 1)
    end
end

return TowerDefence2