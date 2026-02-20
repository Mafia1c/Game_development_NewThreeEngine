local ActivityCenter = {}
ActivityCenter.cfg = GetConfig("ActivityUICfg")
ActivityCenter.point_pos_list = {{190,200},{228,244},{191,222},{211,197}}
function ActivityCenter:onClickBtn(actor, page)
    page = tonumber(page) or 1
    local sMsg = self:getPageData(actor, page)
    lualib:ShowNpcUi(actor, "ActivityCenterOBJ", page .. "#" .. sMsg)
end

-- 切换页签
function ActivityCenter:onPageChange(actor, page)
    page = tonumber(page) or 1
    local sMsg = self:getPageData(actor, page)
 
    lualib:FlushNpcUi(actor, "ActivityCenterOBJ", page.."#"..sMsg)
end

-- 选择参与某个活动
function ActivityCenter:onSelectActivity(actor, index,point_index)
    index = tonumber(index)
    point_index = tonumber(point_index)
    local cfg =  ActivityCenter.cfg[index]
    if cfg == nil then
        return Sendmsg9(actor, "ff0000", "活动数据异常", 1)
    end
    if not self:GetActivityIsOpen(index) then
       return  Sendmsg9(actor, "ff0000", "活动未开启！", 1)
    end
    lualib:CloseNpcUi(actor,"ActivityCenterOBJ")
    local merge_count = GetSysInt(VarEngine.HeFuCount)              -- 合服次数
    local is_kf_connect = kuafuconnected()
    if index == 1 then
        delbutton(actor,101,999)
        map(actor,cfg.map_id)
       
    elseif index == 2 then
        delbutton(actor,101,999)
        map(actor,cfg.map_id) 
        guildnoticemsg(actor,255,249, string.format("玩家「{%s|250:0:1}」进入「{激情派对|250:0:1}」寻宝去了，祝愿他满载而归！",getbaseinfo(actor,1)))
    elseif index == 3 then
        map(actor,cfg.map_id) 
    elseif index == 4 then
        delbutton(actor,101,999)
        map(actor,cfg.map_id) 
        guildnoticemsg(actor,255,249, string.format("玩家「{%s|250:0:1}」进入「{夺宝奇兵|250:0:1}」夺宝去了！",getbaseinfo(actor,1)))
    elseif index == 5 then
        delbutton(actor,101,999)
        if merge_count > 0 and is_kf_connect then
            map(actor,"世界bosskf") 
        else
            map(actor,cfg.map_id) 
        end
        guildnoticemsg(actor,255,249, string.format("玩家「{%s|250:0:1}」进入「{世界boss|250:0:1}」夺宝去了！",getbaseinfo(actor,1)))
     elseif index == 6 then
        if getmyguild(actor) == "0" then
            return  Sendmsg9(actor, "ff0000", "你未加入行会！", 1)
        end
        delbutton(actor,101,999)
        setattackmode(actor, 5, 600)
        if merge_count > 0 and is_kf_connect then
            map(actor,"行会战场kf") 
        else
            map(actor,cfg.map_id) 
        end
        guildnoticemsg(actor,255,249, string.format("玩家「{%s|250:0:1}」杀向「{行会战场|250:0:1}」！",getbaseinfo(actor,1)))
    elseif index == 7 then
        delbutton(actor,101,999)
        if merge_count > 0 and is_kf_connect then
            map(actor,"乱斗之王1kf") 
        else
            map(actor,cfg.map_id) 
        end
        guildnoticemsg(actor,255,249, string.format("玩家「{%s|250:0:1}」杀向「{乱斗之王|250:0:1}」！",getbaseinfo(actor,1)))
    elseif index == 8 then  
        if VarApi.getPlayerUIntVar(actor, VarUIntDef.RAMPAGE_STATE) <= 0 then
            return  Sendmsg9(actor, "ff0000", "开启【狂暴之力】才能进入！", 1)
        end
        if merge_count > 0 and is_kf_connect then
            map(actor,"狂暴霸主kf") 
        else
            if getbaseinfo(actor,3) == cfg.map_id then
                return Sendmsg9(actor, "ff0000", "已在地图内", 1)
            end
            map(actor,cfg.map_id) 
        end
        guildnoticemsg(actor,255,249, string.format("玩家「{%s|250:0:1}」进入「{狂暴霸主|250:0:1}」寻宝去了，祝愿他满载而归！",getbaseinfo(actor,1)))
    elseif index == 9 then
        local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
        if mzl_state <= 0 then
            return Sendmsg9(actor, "ff0000", "请开通盟重令！", 9)
        end  
        delbutton(actor,101,999)
        local pos = ActivityCenter.point_pos_list[point_index]
        if tonumber(point_index) == nil then
            mapmove(actor,cfg.map_id,228,244,3)
        else
            mapmove(actor,cfg.map_id,pos[1],pos[2],3)
        end
    end
   
end

-- page:  1.天降财宝  2.激情派对  3.武林至尊  4.夺宝奇兵  5.世界BOSS  6.行会战场   7.乱斗之王   8.狂暴霸主    9.跨服沙城
function ActivityCenter:getPageData(actor, page)
    local sMsg = ""
    if page == 1 then
        sMsg = 0
        for key, v in pairs(ActivityMgr.new_activity_cfg or {}) do
            if v.key_name == "天降财宝" and  GetSysInt(v.SysIntVarName) == 1 then
               sMsg = 1  
               break
            end
        end
    elseif page == 2 then
        for key, v in pairs(ActivityMgr.new_activity_cfg or {}) do
            if v.key_name == "激情派对" and  GetSysInt(v.SysIntVarName) == 1 then
               sMsg = 1  
               break
            end
        end
    elseif page == 3 then
        if GetSysInt("G_wlzz_activity_state") == 1 then
            sMsg = 1  
        end
    elseif page == 4 then
        if GetSysInt("G_dbqb_activity_state") == 1 then
            sMsg = 1  
        end
    elseif page == 5 then
        for i = 1, 3 do
            if GetSysInt("G_sjbs_activity_state"..i) == 1 then
                sMsg = 1  
                break
            end
        end
    elseif page == 6 then
        for i = 1, 3 do
            if GetSysInt("G_hhzc_activity_state"..i) == 1 then
                sMsg = 1  
                break
            end
        end
    elseif page == 7 then
        for i = 1, 3 do
            if GetSysInt("G_ldzw_activity_state"..i) == 1 then
                sMsg = 1  
                break
            end
        end
    elseif page == 8 then
        for i = 1, 2 do
            if GetSysInt("G_kbbz_activity_state"..i) == 1 then
                sMsg = 1 
                break
            end
        end
        sMsg = sMsg.."#".. GetSysInt(VarEngine.KuangBaoDieCount)
    elseif page == 9 then
        if GetSysInt("G_kfsc_activity_state") == 1 then
            sMsg = 1  
        end
    end
    return sMsg
end
function ActivityCenter:GetActivityIsOpen(index)
    if index == 1 then
        if GetSysInt("G_tjcb_activity_state1") == 1 or GetSysInt("G_tjcb_activity_state2") == 1 then
           return true
        end
    elseif index == 2 then
        if GetSysInt("G_jqpd_activity_state1") == 1 or GetSysInt("G_jqpd_activity_state2") == 1 then
           return true
        end
    elseif index == 3 then
        if GetSysInt("G_wlzz_activity_state") == 1 then
           return true
        end
    elseif index == 4 then
        if GetSysInt("G_dbqb_activity_state") == 1 then
           return true
        end
    elseif index == 5 then
        for i = 1, 3 do
            if GetSysInt("G_sjbs_activity_state"..i) == 1 then
               return true  
            end
        end 
    elseif index == 6 then
        for i = 1, 3 do
            if GetSysInt("G_hhzc_activity_state"..i) == 1 then
                return true
            end
        end
    elseif index == 7 then
        for i = 1, 3 do
            if GetSysInt("G_ldzw_activity_state"..i) == 1 then
                return true
            end
        end 
    elseif index == 8 then
        for i = 1, 3 do
            if GetSysInt("G_kbbz_activity_state"..i) == 1 then
                return true
            end
        end
    elseif index == 9 then
        if GetSysInt("G_kfsc_activity_state") == 1 then
            return true
        end
    end
    return false
end

function ActivityCenter:JQPDTaskUi(actor)
    delbutton(actor, 110, "_654321")
    local btn_str = [[
        <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3}|img=custom/npc/18hd/pd1.png>
        <RText|id=bg1|x=100|y=082|a=4|outline=2|color=255|size=18|text=派对积分：{%s/FCOLOR=250}>
        <Button|id=bg2|x=60|y=150|a=4|nimg=custom/npc/18hd/exit.png|clickInterval=1000|link=@quit_jqpd>
        <Button|id=bg3|x=140|y=150|a=4|nimg=custom/npc/18hd/pd2.png|clickInterval=1000|link=@open_jqpa_rank>
    ]]
    addbutton(actor, 110, "_654321",  string.format(btn_str,ActivityCenter:GetActorJifen(actor)) )
end
function quit_jqpd(actor)
    mapmove(actor,3,322,333,5)
end
function open_jqpa_rank(actor)
    local str = [[
        <Img|x=270|y=6|bg=1|esc=1|show=0|move=0|children={ms0,ms1,ms2,ms3,ms4,ms5,ms6,ms7,ms8}|img=custom/npc/09qjbm/tips.png>
        <Button|id=ms0|x=255|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Img|id=ms1|x=16|y=020|children={ms11}|img=custom/npc/18hd/no1.png>
        <Img|id=ms2|x=16|y=070|children={ms21}|img=custom/npc/18hd/no2.png>
        <Img|id=ms3|x=16|y=120|children={ms31}|img=custom/npc/18hd/no3.png>
        <RText|id=ms4|x=20|y=180|ay=0.5|outline=1|color=255|size=17|text=第1名奖励：{100000元宝/FCOLOR=58}>
        <RText|id=ms5|x=20|y=220|ay=0.5|outline=1|color=255|size=17|text=第2名奖励：{50000元宝/FCOLOR=58}>
        <RText|id=ms6|x=20|y=260|ay=0.5|outline=1|color=255|size=17|text=第3名奖励：{20000元宝/FCOLOR=58}>
        <RText|id=ms7|x=128|y=300|a=4|outline=1|color=243|size=17|text=活动结束，邮件发放奖励>
        <RText|id=ms8|x=128|y=340|a=4|outline=1|color=253|size=17|text=你的排名：{%s/FCOLOR=159}>
    ]]
    local rank_str = "<RText|id=ms%s|x=48|y=17|ay=0.5|outline=1|color=251|size=17|text=神秘人　{%s积分/FCOLOR=250}>"

    local rank_list = ActivityCenter:GetJqpdRankList()
    local format_str = ""
    for i,v in ipairs(rank_list or {}) do
        format_str = format_str .. string.format(rank_str,i*10 + 1,v.value) 
    end
    str = str ..format_str
    local self_rank = 0
    for i,v in ipairs(rank_list) do
        if v.role_id == getbaseinfo(actor,2) then
            self_rank = i
            break
        end
    end
    say(actor,string.format(str, self_rank > 0 and self_rank or "暂无") )
end
function ActivityCenter:GetJqpdRankList()
    local rank_list =  json2tbl(GetSysStr("A_jfpd_rank")) 
    if rank_list == "" then
        return {}
    end

    local temp_list = {}
    for k, v in pairs(rank_list or {}) do
        table.insert(temp_list, {role_id = k,obj=v.obj,value = v.value})
    end

    table.sort(temp_list,function(a,b)
        return a.value > b.value
    end)

    local list = {}
    for i = 1, 3 do
        if temp_list[i] then
           table.insert(list,temp_list[i]) 
        end
    end
    return list
end
function ActivityCenter:GetActorJifen(actor)
    local rank_list =  json2tbl(GetSysStr("A_jfpd_rank")) 
    if rank_list == "" then
        return 0
    end
    if rank_list[getbaseinfo(actor,2)] then
        return rank_list[getbaseinfo(actor,2)].value
    end
    return 0
end
--武林至尊
function ActivityCenter:WlzzCaiPan(actor)
    local str = [[<Img|bg=1|loadDelay=0|move=0|img=public/bg_npc_01.png|reset=1|show=0>
        <Layout|x=545|y=0|width=80|height=80|link=@exit>
        <Button|x=546|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Layout|id=100|children={10001,10002,10003}|x=10|y=23.0|width=108|height=29|color=X>
        <RText|id=10001|x=22|y=06|outline=1|color=255|size=17|text=当地图内只剩下一个玩家的时候，就可以找我来领奖励了！>
        <RText|id=10002|x=22|y=36|outline=1|color=255|size=17|text=最终胜出的玩家可获得：{武林盟主/FCOLOR=250}{(1.2倍攻击)/FCOLOR=249} 称号！>
        <RText|id=10003|x=22|y=66|outline=1|color=255|size=17|text=活动开始10分钟后才可以领奖！>
        <Layout|id=103|children={10015,10016,10017}|x=20.0|y=120|width=108|height=29|color=X>
        <Img|id=10015|x=6.0|y=9.0|esc=0|img=public/btn_npcfh_03.png>
        <Text|id=10016|x=28.0|y=6.0|outline=1|color=251|size=18|text=领取奖励|link=@get_wlzz_award>
    ]]
    say(actor,str)
end
function get_wlzz_award(actor)
    local playerNum = getplaycountinmap("0","武林至尊",0)
    if playerNum > 1 then
       return  Sendmsg9(actor, "ff0000", "地图内还有其他玩家，无法领奖！", 1)
    end
    if GetSysInt("G_wlzz_activity_state") == 1 then
        return  Sendmsg9(actor, "ff0000", "活动开启时间不足10分钟，请稍后再来！", 1)
    end
    confertitle(actor,"武林盟主")
    sendmsgnew(actor,255,0,"恭喜: <『"..getbaseinfo(actor,1).."』/FCOLOR=254>成为<[武林盟主]/FCOLOR=250>，实力真的强悍的Yap！", 1, 2)
    mapmove(actor,3,322,333,5)
end
--活动开始弹窗
function ActivityCenter:ShowActitityStartTip(actor,index)
    local str = [[
        <Img|x=230|y=200|children={atv1,atv2}|img=custom/npc/18hd/icon%s.png>
        <Button|id=atv1|x=154|y=19|a=4|nimg=public/01.png|pimg=public/02.png|link=@close_active_tip,1>
    ]]
    str = string.format(str,index)
    str = str.."<Button|id=atv2|x=91|y=144|a=4|nimg=custom/npc/18hd/btn1.png|pimg=custom/npc/18hd/btn2.png|link=@close_active_tip,2,"..index..">"
    addbutton(actor,101,32159,str)
end
function close_active_tip(actor,flag,index)
    delbutton(actor,101,32159)
    if tonumber(flag) == 2 and tonumber(index) then
        ActivityCenter:onSelectActivity(actor, index)
    end
end

function ActivityCenter:KfscTaskUi(actor)
  
    delbutton(actor,110,901)
    local str = [[
       <Img|id=a3|x=1|y=1|children={bg1,bg2,bg3,bg4,bg5,bg6,bg7,bg8,bg9}|img=custom/npc/18hd/kfhd9.png>
       <RText|id=bg2|x=60|y=100|a=4|outline=2|color=255|size=18|text=攻沙结束：>
       <COUNTDOWN|id=bg3|ay=0.5|x=102|y=100|size=18|count=1|outline=2|time=%s|color=250>
       <Button|id=bg4|x=100|y=150|a=4|nimg=custom/npc/18hd//exit.png|link=@quit_kfsc>
    ]]
    str = string.format(str,GetSysInt("G_kfsc_start_time")-os.time())
    addbutton(actor,110,901,str)
    local guishu_str = [[<RText|ax=0.5|x=100|y=30|color=149|size=16|outline=1|text=<归属行会：/FCOLOR=149>\\<%s/FCOLOR=250>>]]
    local guild_name = GetSysStr("A_kfsc_guild_name") 
    addbutton(actor,110,902,string.format(guishu_str,guild_name == "" and "暂无行会占领" or guild_name) )
    openhyperlink(actor,110,2)
    openhyperlink(actor,110,1)
end
function quit_kfsc(actor)
    mapmove(actor,3,322,333,5)
end
function ActivityCenter:LoginByClient(actor)
    local list = {
        "G_tjcb_activity_state1",
        "G_tjcb_activity_state2",
        "G_jqpd_activity_state1",
        "G_jqpd_activity_state2",
        "G_wlzz_activity_state",
        "G_dbqb_activity_state",
        "G_sjbs_activity_state1",
        "G_sjbs_activity_state2",
        "G_sjbs_activity_state3",
        "G_hhzc_activity_state1",
        "G_hhzc_activity_state2",
        "G_hhzc_activity_state3",
        "G_ldzw_activity_state1",
        "G_ldzw_activity_state2",
        "G_ldzw_activity_state3",
        "G_kbbz_activity_state1",
        "G_kbbz_activity_state2",
        "G_kfsc_activity_state",
    }
    for i,v in ipairs(list) do
        lualib:CallFuncByClient(actor, "activity_state", v.."#".. GetSysInt(v))
    end
end
--上古稻草人
function ActivityCenter:RandomGenMon(is_kuafu)
    local tab = {}
    for i,v in ipairs({"钳虫巢穴","死亡神殿","地狱烈焰","深渊魔域","堕落坟场","困惑殿堂","狂暴霸主"}) do
        local map_name = is_kuafu and (v.."kf") or v
        if getmoncount(v, 2457, true) < 1 then
            killmonsters(v, "上古稻草人", 0, true, true)
        end
        local x,y = self:GetRandomXY(map_name)
        table.insert(tab,{map_name,x,y})
        genmon(map_name, x,y, "上古稻草人", 0, 1)
    end
    SetSysStr("A_scarecrow_gen_pos",tbl2json(tab))
end

function ActivityCenter:GetRandomXY(map_name)
    local x,y = GetMapRandXY("0", map_name)
    if not gridattr(map_name, x, y, 1) then
       return  self:GetRandomXY(map_name)
    end
    return x,y
end
return ActivityCenter