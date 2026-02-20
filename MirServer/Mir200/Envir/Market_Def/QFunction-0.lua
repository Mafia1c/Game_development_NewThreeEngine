math.randomseed(tostring(os.time()):reverse():sub(1, 7))
include("QuestDiary/LoadAllFile.lua")
QFIncludes("QF")

handle_request_interval = {}
---接受协议消息触发
--- @param actor  string 玩家对象
--- @param msgid number  协议ID
--- @param npc_id integer npcID 
--- @param sMsg string  协议携带数据
function handlerequest(actor, msgid, npc_id, arg2, arg3, sMsg)
    local tab = strsplit(sMsg, "#")
    msgid = tonumber(msgid) or 0
    local _npc_id = tonumber(tab[1])
    local map_id = getbaseinfo(actor, 3)
    local cur_time = GetCurrentTime()
    local op_time = handle_request_interval[actor] or 0
    if _npc_id > 0 and cur_time - op_time <= 200 then
        -- release_print("请勿频繁操作!")
        -- Sendmsg9(actor, "ff0000", "请勿频繁操作!", 1)
        return
    end
    handle_request_interval[actor] = cur_time

    local _file_name = tab[2]
    local _func_name = tab[3]
    if msgid == CS_MSG_CALL_FUN_BY_NPC then                     -- 调用指定npc的指定函数 npcid#classname#funName#param
        local npc_class = IncludeNpcClass(_file_name)
        if nil == npc_class then
            npc_class = IncludeMainClass(_file_name)
        end
        if npc_class and npc_class[_func_name] then
            npc_class[_func_name](npc_class, actor, unpack(tab,4))
        end
    elseif msgid == CS_MSG_SEND_DATA then                       -- 客户端发送数据到服务器
    elseif msgid == CS_MSG_CLICK_NPC then                       -- 点击npc协议   sMsg = npcid#classname#param
        local npc_class = IncludeNpcClass(_file_name)
        if npc_class and npc_class.click then
            npc_class:click(actor, _npc_id, unpack(tab,3))
        end
    elseif msgid == CS_MSG_CLICK_MAIN_BTN then                  -- 主界面按钮协议    sMsg = npcid#classname#param
        local npc_class = IncludeMainClass(_file_name)
        if npc_class and npc_class[_func_name] then
            npc_class[_func_name](npc_class, actor, unpack(tab, 4))
        end
    elseif msgid == CS_MSG_CLICK_SYS_BTN then                   -- 点击系统面板上的一些按钮    
        local sys_class = IncludeSysClass(_file_name)
        if sys_class and sys_class[_func_name] then
            sys_class[_func_name](sys_class, actor, unpack(tab,4))
        end
    end
end

--BUFF操作触发
function buffchange(actor, buffId, groupId, opt)
    --opt 1=新增;2=更新;4=删除;
    if opt == 1 then
        if buffId == 70026 then
            playeffect(actor,13429,0,0,0,0,0)
        elseif buffId == 80001 and  getbaseinfo(actor,25) < 0 then  --无双 诅咒之王
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60105 .. "," .."add")
        elseif buffId == 80005  then  --无双 勇敢的心
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60107 .. "," .."add")
        elseif buffId == 80006 then  --单打独斗
            if getbaseinfo(actor,35) <= 0  then
                delaymsggoto(actor, 100, "@change_buff_callfun,"..60108 .. "," .."add")
            else
                delaymsggoto(actor, 100, "@change_buff_callfun,"..60108 .. "," .."del")
            end
        elseif buffId == 70011 then
            changemode(actor,2, 10000)
        elseif  buffId ==  80014 and  getbaseinfo(actor,25) > 0 then --无双 幸运之星
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60106 .. "," .."add")
        elseif buffId == 80015 then --无双 血气方刚
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60109 .. "," .."add")
        elseif buffId == 80029 then  --无双 排除异己
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60110 .. "," .."add")
        elseif buffId == 80043 and getpklevel(actor) == 2 then -- 无双 恶魔崛起
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60111 .. "," .."add")
        elseif buffId == 80045 then --无双 移花接木
            local max_mp = getbaseinfo(actor,12)
            local per_mp = math.floor(max_mp*0.2)
            changehumability(actor,12,-per_mp,64800)
            changehumability(actor,11,per_mp,64800)
            sendattackeff(actor,345,0,"*")
        elseif buffId == 80055 and getbaseinfo(actor,25) >= 9 then  --无双 运气爆棚
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60112 .. "," .."add")
        elseif buffId == 60086 then
            playeffect(actor,13435,0,0,0,0,0)
        end
    elseif opt == 4 then
        if buffId == 70026 then
            clearplayeffect(actor,13429)
        elseif buffId == 50000 then --脱离战斗
        
        elseif buffId == 80001 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60105 .. "," .."del")
        elseif buffId == 80005 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60107 .. "," .."del")
        elseif buffId == 80006 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60108 .. "," .."del")
        elseif buffId ==  70011 then
            changemode(actor,2, 0)
        elseif buffId == 80014 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60106 .. "," .."del")
        elseif buffId == 80015 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60109 .. "," .."del")
        elseif buffId == 80025 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60102 .. "," .."del")
        elseif buffId == 80029 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60110 .. "," .."del")
        elseif buffId == 80031 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..70031 .. "," .."del")
        elseif buffId == 80035 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60103 .. "," .."del")
        elseif buffId == 80043 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60111 .. "," .."del")
        elseif buffId == 80045 then
            changehumability(actor,12,0)
            changehumability(actor,11,0)
        elseif buffId == 80055 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..60112 .. "," .."del")
        elseif buffId == 60086 then
            clearplayeffect(actor,13435)
        elseif buffId == 50022 then
            delaymsggoto(actor, 100, "@change_buff_callfun,"..50022 .. "," .."del")
        end
    end
   
end
function change_buff_callfun(actor,buff_id,tag)
    buff_id = tonumber(buff_id)
    if buff_id == nil then return end
    if tag == "add" then
        if buff_id == 60105 then
            VarApi.setPlayerUIntVar(actor,"U_listening_attr_39",getbaseinfo(actor,25))
            local dc = getbaseinfo(actor,19)
            local mc = getbaseinfo(actor,21)
            local sc = getbaseinfo(actor,23) 
            local curse_value =  0 - getbaseinfo(actor,25)
            local random_value = math.random(5)
            local attr_str = "3#3#"..curse_value * math.ceil((random_value /100)* dc) .. "|3#5#"..curse_value * (math.ceil((random_value /100) * mc)).."|3#7#"..curse_value * (math.ceil((random_value /100) * sc))
            local tab = ParserAttrStrToTable(attr_str)
            delbuff(actor,60105)
            addbuff(actor,60105,0,1,actor,tab)
        elseif  buff_id == 60107 then
            local job = getbaseinfo(actor,7)
            local attr_str = ""
            if job == 0 then
                attr_str = "3#57#1000|3#59#1000"
            elseif job == 1 then
                attr_str = "3#55#1000|3#59#1000"
            else
                attr_str = "3#55#1000|3#57#1000"
            end
            local tab = ParserAttrStrToTable(attr_str)
            delbuff(actor,60107)
            addbuff(actor,60107,0,1,actor,tab)
            sendattackeff(actor,305,0,"*")
        elseif buff_id == 60108 then
            addbuff(actor,60108,0,1,actor,{[66]=5000,[75]=1000})
        elseif buff_id == 60106 then
            local curse_value = getbaseinfo(actor,25)
            local attr_str = "3#89#"..curse_value * 200
            local tab = ParserAttrStrToTable(attr_str)
            delbuff(actor,60106)
            addbuff(actor,60106,0,1,actor,tab)
            VarApi.setPlayerUIntVar(actor,"U_listening_attr_39",getbaseinfo(actor,25))
            sendattackeff(actor,314,0,"*")
        elseif buff_id == 60109 then
            VarApi.setPlayerUIntVar(actor,"U_listening_attr_2",getbaseinfo(actor,12))
            local value =  math.floor(getbaseinfo(actor,12)/100) 
            local attr_str = "3#10#"..value.."|3#12#"..value
            local tab = ParserAttrStrToTable(attr_str)
            delbuff(actor,60109)
            addbuff(actor,60109,0,1,actor,tab)
        elseif buff_id == 60110 then
            local job = tonumber( getbaseinfo(actor,7)) 
            local attr_str  = ""
            local value = math.random(10) * 100
            if job == 0 then
                attr_str = "3#56#"..value.."|3#58#"..value
            elseif job == 1 then
                attr_str = "3#54#"..value.."|3#58#"..value
            else
                attr_str = "3#54#"..value.."|3#56#"..value
            end
            local tab = ParserAttrStrToTable(attr_str)
            delbuff(actor,60110)
            addbuff(actor,60110,0,1,actor,tab)
            sendattackeff(actor,329,0,"*")
        elseif buff_id == 60111 then
            sendattackeff(actor,343,0,"*")
            delbuff(actor,60111)
            addbuff(actor,60111,0,1,actor,{[25]=10}) 
        elseif buff_id == 60112 then
            addbuff(actor,60112,0,1,actor,{[35]=1000})
            VarApi.setPlayerUIntVar(actor,"U_listening_attr_39",getbaseinfo(actor,25))
            sendattackeff(actor,355,0,"*") 
        end
    else
        if buff_id == 60108 then
           delbuff(actor, 60108) 
        elseif buff_id == 60105 then    
            delbuff(actor,60105)
        elseif buff_id == 60107 then    
            delbuff(actor,60107)
        elseif buff_id == 60106 then  
            delbuff(actor,60106)
        elseif buff_id == 60109 then  
            delbuff(actor,60109)
        elseif buff_id == 60102 then  
            delbuff(actor,60102)
        elseif buff_id == 60110 then
            delbuff(actor,60110)
        elseif buff_id == 70031 then
            delbuff(actor,70031)
        elseif buff_id == 60103 then   
            delbuff(actor,60103)  
        elseif buff_id == 60111 then 
            delbuff(actor,60111) 
        elseif buff_id == 60112 then 
            delbuff(actor,60112)
        elseif buff_id == 50022 then
            if not hasbuff(actor, 50008) then
                setmagicpower(actor, "施毒术", 0, 1)
            end
        end
    end
end
function bufftriggerhpchange(actor,buffID,buffGroup,HP,buffHost,mon,result)

end 

--商城购买后触发
function buyshopitem(actor, makeIndexList, itemName, itemNum, money_list)

end

--编辑行会公告前触发
function updateguildnotice(actor)
    return false
end

--聊天触发
function triggerchat(actor, msg, channel, msgType)
    local get_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.FirstRecharge)
    local level = getbaseinfo(actor, 6)
    if level < 70 and get_state == 0 then
        Sendmsg9(actor, "ffffff", "禁言中, 等级大于等于70或领取首充奖励即可解除禁言!", 9)
        return false
    end
    return true
end

--角色脱下装备前触发
function takeoffbeforeex(actor,makeIndex,where,idx)
    return TakeEquipTrigger.takeoffbeforeex(actor,makeIndex,where,idx)
end

--脱装备后触发
function takeoffex(actor,makeIndex,where,itemName)
    return TakeEquipTrigger.takeoffex(actor,makeIndex,where,itemName)
end

--#region buff表21列填时间加名称触发(列1000#@bufftrigger) 具体逻辑在BffTrigger编写
function bufftrigger(actor,buffId)
    BuffTrigger.onBuffTrigger(actor, buffId)
end

--#region 收到请求离线玩家变量时(系统id,玩家唯一id,玩家名称,变量名,变量值)
function on_offline_var(SysID,UserID,UserName,varName,varValue)
    
end

--穿装备前触发
function takeonbeforeex(actor,makeIndex,where)
    return TakeEquipTrigger.takeonbeforeex(actor,makeIndex,where)
end

--穿装备后触发
function takeonex(actor,makeIndex,where,itemName)
    TakeEquipTrigger.takeonex(actor,makeIndex,where,itemName)
end

--物品进背包
function addbag(actor, makeIndex, index)
    local name = getstditeminfo(index, 1)
    local auto = VarApi.getPlayerUIntVar(actor, "U_auto_recycle")
    local num = getbagblank(actor)
    if num < 10 and auto == 1 and not checkkuafu(actor) then
        local npc_class = IncludeNpcClass("RecycleNpc")
        if npc_class then
            npc_class:onAllRecycle(actor, true)
        end
    end
    local navigation = VarApi.getPlayerUIntVar(actor, "U_navigation_use_exp_item")
    if navigation == 0 and isInTable({"100万经验珠", "1000万经验珠", "1亿经验珠"}, name) then
        VarApi.setPlayerUIntVar(actor, "U_navigation_use_exp_item", 1, false)
        openhyperlink(actor, 7, 1)
        delaygoto(actor, 500, "delay_navigation_use_exp_item,"..makeIndex, 0)
    end
end
function delay_navigation_use_exp_item(actor, makeIndex)
    navigation(actor, 1, makeIndex, "点击使用!")
end

function addbagbefore(actor,itemMakeIndex,itemIndex)
    local itemName = getiteminfo(actor, itemMakeIndex, 7)
    if itemName == "终极宝箱" then
        seticon(actor,8,0,"baoxiang",0,0,1,0,0)
        if not hastimer(actor,PlayerTimer.dbqb_timer_id) then
            PlayerTimer.addPlayerTimer(actor, PlayerTimer.dbqb_timer_id, 1)
        end
    end
end
--任意地图杀死怪物
function killmon(actor,mon,itype,kill,monName,mapID)
    KillmonTrigger.onKillMon(actor,mon,itype,kill,monName,mapID)
end

--#region 称号改变触发(玩家对象，称号道具id)添加,更改
function titlechangedex(actor,titleIdx)
    TitleTrigger.onTitlechangedex(actor,titleIdx)
end
--#region 称号取消触发(玩家对象，称号道具id)取消穿戴,删除
function untitledex(actor,titleIdx)
    TitleTrigger.onUntitledex(actor,titleIdx)
end

--#region 玩家自身使用任意技能前触发(玩家对象，技能id，技能名字，受击对象，受击对象x坐标，受击对象y坐标，返回值(true/false，允许/组织施法))
function beginmagic(actor,magicId,magicName,target,x,y)
    return UseMagicTrigger.beginmagic(actor,magicId,magicName,target,x,y)
end

--在跨服中地图杀死怪物
function killkfmon(actor, mapkey, monName, monNameEx, monIdx)
end

--大退触发
function playoffline(actor)
    if IsDummy(actor) then
        return
    end
    --气泡数据  每次登陆清空 防止跨服交互气泡清不掉
    local cur_hp = getbaseinfo(actor, 9)
    local max_hp = getbaseinfo(actor, 10)
    local rate = math.ceil(cur_hp / max_hp * 100)
    VarApi.setPlayerUIntVar(actor, "U_exit_game_hp_rate", rate, false)
    PlayerTimer.removeAllTimer(actor)
    VarApi.setPlayerUIntVar(actor,"U_map_cruise_state",0)
    local map_id = getbaseinfo(actor,3)
    if  map_id == "夺宝奇兵" then
        if getbagitemcount(actor,"终极宝箱",0) > 0 then
            takeitem(actor,"终极宝箱",1,0)
            throwitem("0","夺宝奇兵",26,34,0,"终极宝箱",1,3,false,true,false)
            seticon(actor,8,-1)
            PlayerTimer.removePlayerTimer(actor, PlayerTimer.dbqb_timer_id)
            SetTempInt(0,actor,"dbqb_box_time",0)
        end
    end

    mapmove(actor, "3", 322, 330, 4)
    offlineplay(actor, 600)
end

--小退触发
function playreconnection(actor)
    --气泡数据  每次登陆清空 防止跨服交互气泡清不掉
    local cur_hp = getbaseinfo(actor, 9)
    local max_hp = getbaseinfo(actor, 10)
    local rate = math.ceil(cur_hp / max_hp * 100)
    VarApi.setPlayerUIntVar(actor, "U_exit_game_hp_rate", rate, false)
    PlayerTimer.removeAllTimer(actor)
    VarApi.setPlayerUIntVar(actor,"U_map_cruise_state",0)
    local map_id = getbaseinfo(actor,3)
    if  map_id == "夺宝奇兵" then
        if  hastimer(actor,PlayerTimer.dbqb_timer_id) then
            seticon(actor,8,-1)
            PlayerTimer.removePlayerTimer(actor, PlayerTimer.dbqb_timer_id)
            SetTempInt(0,actor,"dbqb_box_time",0)
        end
    end
end

function kflogin(actor) --#region 跨服成功跨服qf触发
    KuaFuTrigger.kflogin(actor)
end

function kfend(actor) --#region 跨服结束本服qf触发
    KuaFuTrigger.kfend(actor)
end

--跨服通知本服
function kfsyscall1(actor, parama, paramb)
    KuaFuTrigger.kfsyscall1(actor, parama, paramb)
end
--本服通知跨服
function bfsyscall99(actor, parama, paramb)
    KuaFuTrigger.bfsyscall99(actor, parama, paramb)
end

--跨服调用-爆装备提示--{mapname, x, y, equipid}
function dropuseitems_kf(player, str)

end

-- 人物死亡装备掉落前触发支持stop
function checkdropuseitems(actor, equipSite, itemId)
    local drop_item = VarApi.getPlayerTStrVar(actor, "T_drop_items")
    if drop_item == "" then
        drop_item = {}
    else
        drop_item = json2tbl(drop_item)
    end
    drop_item[#drop_item + 1] = getstditeminfo(itemId, 1)
    VarApi.setPlayerTStrVar(actor, "T_drop_items", tbl2json(drop_item))
    return true
end

-- 装备从背包掉落前触发
function itemdropfrombagbefore(actor, makeIndex)
    local drop_item = VarApi.getPlayerTStrVar(actor, "T_drop_items")
    if drop_item == "" then
        drop_item = {}
    else
        drop_item = json2tbl(drop_item)
    end
    drop_item[#drop_item + 1] = getiteminfo(actor, makeIndex, 7)
    VarApi.setPlayerTStrVar(actor, "T_drop_items", tbl2json(drop_item))
end

-- 玩家被杀触发 	actor: 被杀玩家(死者)     killed:凶手或凶手主人 
function playdie(actor, killer)
    local gong_sha = getbaseinfo(actor, 60)  -- 攻沙期间不掉
    PlayerDieTrigger.onPlayDie(actor, killer)
end

-- 玩家死亡触发  actor:凶手或凶手主人   killed: 被杀玩家(死者)
function killplay(actor,killed)
    PlayerDieTrigger.onKillPlay(actor, killed)
end

--#region npc点击触发(玩家对象,npc索引id,npc文本路径)return true不允许
function clicknpc(actor,npcId,sScript)
    return ClickNpcTrigger.clicknpc(actor,npcId,sScript)
end

--拾取触发
function pickupitemex(actor,itemMakeIndex,itemIndex)
    PickupItemexTrigger.pickupitemex(actor,itemMakeIndex,itemIndex)

    -- 第一个物品进背包来一次引导
    local nav = VarApi.getPlayerUIntVar(actor, "U_bag_navigation")
    if nav == 0 then
        VarApi.setPlayerUIntVar(actor, "U_bag_navigation", 10, false)
        openhyperlink(actor, 7, 1)
        delaygoto(actor, 1000, "on_delay_navigation", 0)
    end
end
function on_delay_navigation(actor)
    navigation(actor, 7, 10002, "点击回收")
end

-- 提前邮件触发
function getmailitem(actor, mainID, mailTitle, itemJson)
    if mailTitle == "新人豪礼" then
        delaygoto(actor, 0, "on_play_screffects,1000,恭喜获得<font color='#FF00FF'>【自动拾取】</font>特权！,自动拾取", 0)
        delaygoto(actor, 250, "on_play_screffects,1001,恭喜获得<font color='#FF00FF'>【自动回收】</font>特权！,自动回收", 0)
        delaygoto(actor, 500, "on_play_screffects,1002,恭喜获得<font color='#FF00FF'>【自动经验】</font>特权！,自动经验", 0)
        delaygoto(actor, 750, "on_play_screffects,1003,恭喜获得<font color='#FF00FF'>【自动货币】</font>特权！,自动货币", 0)
        delaygoto(actor, 1000, "on_play_screffects,1004,恭喜获得<font color='#FF00FF'>【仓库全开】</font>特权！,仓库全开", 0)
        delaygoto(actor, 1250, "on_play_screffects,1005,恭喜获得<font color='#FF00FF'>【远程仓库】</font>特权！,远程仓库", 0)
        delaygoto(actor, 1500, "on_play_screffects,1006,恭喜获得<font color='#FF00FF'>【二级背包】</font>特权！,二级背包", 0)
    end
end
function on_play_screffects(actor, id, desc, itemName)
    id = tonumber(id) or 1
    lualib:CallFuncByClient(actor, "screffects", 14804)
    Sendmsg9(actor, "ffffff", desc, 1)
    if id == 1006 then
        eatitem(actor, itemName, 1)
        refreshbag(actor)
    else
        takeitem(actor, itemName, getbagitemcount(actor, itemName, 0), 0, "提取邮件扣除展示道具!")
    end
end
--#region 拾取前触发(物品唯一ID)return false阻止拾取
function pickupitemfrontex(actor,makeIndex)
    return PickupItemexTrigger.pickupitemfrontex(actor, makeIndex)
end

--#region 角色扔掉任意物品前触发(玩家对象，物品唯一id，掉落物品名，行为id【0=扔掉触发】【1=人物掉落触发】，true允许掉落)
function dropitemfrontex(actor,makeIndex,itemName,model)
    OtherTrigger.dropitemfrontex(actor,makeIndex,itemName,model)
end

--扔任意物品后触发
function dropitemex(actor, item)
end
--切换地图
function entermap(actor, map_id, x, y, mapId2)
    OtherTrigger.onMapChange(actor, map_id, x, y, mapId2)
end

--在跨服切换地图
function entermapkf(actor, cur_mapid, former_mapid, stayTime, leaveMapName)
    -- release_print("跨服切换地图触发 *** ")
end

function delaystartautofight(actor)
end
--离开地图
function leavemap(actor,mapId,x,y,mapId2)
    OtherTrigger.onLeaveMapChange(actor,mapId,x,y,mapId2)
end

--#region 角色升级触发(玩家对象，升级后等级)
function playlevelup(actor,level)
    OtherTrigger.playlevelup(actor,level)
end


-- 开始挂机触发
function startautoplaygame(actor)
    SetTempInt(0, actor, "UTemp_auto_fight_state", 1)
end

-- 停止挂机触发
function stopautoplaygame(actor)
    SetTempInt(0, actor, "UTemp_auto_fight_state", 0)
end

--攻城开始时触发
function castlewarstart(sysobj)
    CastleWarTrigger.CastleWarStart(sysobj)
end

--攻城结束时触发
function castlewarend(sysobj)
    CastleWarTrigger.CastleWarEnd(sysobj)
end

-- 怪物掉落物品触发
function mondropitemex(actor,makeIndex,mon,nX,nY,index)
    local itemName = getiteminfo(actor, makeIndex,7) --#region 物品名称
    local map_id = getbaseinfo(mon, 3)
    local mon_name = getbaseinfo(mon, 1)
    local filter_map = {"狂暴霸主", "激情派对","狂暴霸主kf"}
    if mon_name == "上古稻草人" and itemName == "1亿经验珠" and not isInTable(filter_map, map_id) then
        local random = math.random(100)
        if random > 10 then
            return false
        end
    end

    MonDropItemTrigger.mondropitemex(actor,makeIndex,mon,nX,nY,index)
    return true
end

--退出行会前触发
function guilddelmemberbefore(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服服务器禁止操作!", 1)
        return false
    end
end

--解散行会前触发
function guildclosebefore(actor)

end

-- 加入行会前触发
function guildaddmember(actor, guild, name)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ffffff", "跨服服务器禁止操作!", 1)
        return false
    end
end

-- 加入行会后触发
function guildaddmemberafter(actor, guild, name)

end

local layerStudyPath = {"custom/npc/30xiuwei/jingjie_",".png"} --#region 境界修炼
local layerUpPath = {"custom/npc/31fs/fs",".png"} --#region 境界提升
--#region 查看别人装备触发(玩家对象，被查看的玩家名)
function lookhuminfo(actor, actorInsId, targetName)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    VarApi.setPlayerTStrVar(actor, VarTStrDef.LookPlayerId, actorInsId or targetName, false)
    VarApi.setPlayerTStrVar(actor, VarTStrDef.LookPlayer, targetName or actorInsId, false)

    local targetActor = getplayerbyname(targetName or actorInsId) --#region 查看玩家对象
    if not isnotnull(targetActor) then
        targetActor = getplayerbyid(actorInsId)
    end

    local btnTab={{301,200},{301,201},{3901,202},{3901,203}} --#region 重置按钮
    for _, value in ipairs(btnTab) do
        delbutton(actor,value[1],value[2])
    end

    if targetActor and targetActor~="" and isnotnull(targetActor) then --#region 查看玩家在线
        local layerStudy = VarApi.getPlayerUIntVar(targetActor,"U_LayerStudy") --#region 境界修炼
        local layerUp = VarApi.getPlayerUIntVar(targetActor,"U_LayerUp") --#region 境界提升
        local bigMap = VarApi.getPlayerUIntVar(targetActor,"U_bigMap") --#region 去过几大陆
        if layerStudy>0 then --#region 境界显示
            local xy_tab={14,-2} --#region xy坐标
            if is_pc then xy_tab={50,-16} end
            addbutton(actor, 301, 200, "<Img|x="..xy_tab[1].."|y="..xy_tab[2].."|img=custom/npc/31fs/xbg.png>")
            addbutton(actor, 301, 201, "<Img|x="..xy_tab[1].."|y="..xy_tab[2].."|img="..layerStudyPath[1]..layerStudy..layerStudyPath[2]..">")
            if layerUp>0 then
                addbutton(actor, 301, 200, "<Img|x="..xy_tab[1].."|y="..xy_tab[2].."|img=custom/npc/31fs/xbg.png>")
                addbutton(actor, 301, 201, "<Img|x="..xy_tab[1].."|y="..xy_tab[2].."|img="..layerUpPath[1]..layerUp..layerUpPath[2]..">")
            end
        end
        if bigMap>=3 then
            if is_pc then
                addbutton(actor, 3901, 202, "<Button|a=0|x=218|y=10|nimg=custom/mbtn/sm1.png|pimg=custom/mbtn/sm2.png|link=@look_sm_panel>")
                addbutton(actor, 3901, 203, "<Button|a=0|x=218|y=50|nimg=custom/mbtn/mj1.png|pimg=custom/mbtn/mj2.png|link=@look_mj_panel>")
            else
                addbutton(actor, 3901, 202, "<Button|a=0|x=286|y=10|nimg=custom/mbtn/sm1.png|pimg=custom/mbtn/sm2.png|link=@look_sm_panel>")
                addbutton(actor, 3901, 203, "<Button|a=0|x=286|y=50|nimg=custom/mbtn/mj1.png|pimg=custom/mbtn/mj2.png|link=@look_mj_panel>")
            end
        end
        
        local job_awake_class = IncludeNpcClass("JobAwake")
        if job_awake_class then
            job_awake_class:FlushPlayerBtn(actor,targetActor,true)
        end
    end
end
function look_sm_panel(actor) --#region 神魔界面
    local sys = include("QuestDiary/sys/OtherSysFunc.lua")
    if sys then
        sys:lookPlayerInfo(actor,7)
    end
end
function look_mj_panel(actor) --#region 魔戒界面
    local sys = include("QuestDiary/sys/OtherSysFunc.lua")
    if sys then
        sys:lookPlayerInfo(actor,8)
    end
end

--任命掌门触发
function setguildrank1(actor)

end

--创建行会前触发
function checkbuildguild(actor, guildName)

end

-- 走路触发
function walk(actor)
end

--#region QFunction-0重载前触发
function qfloadbegin(sysobj)
    
end

--#region 属性变化时触发
function sendability(actor)
    AbilityTrigger.sendability(actor)
end

-- 镖车进入自动寻路范围触发
function carfindmaster(actor)

end

-- 丢失镖车触发
function losercar(actor, car)

end

-- 镖车死亡触发
--- @param actor  string 攻击镖车对象
--- @param car string  镖车对象
function cardie(actor, car)

end

function carpathend(actor)

end

--拍卖行上架触发
function canpaimaiitem(actor,itemIdx,itemMakeIndex,moneyType,price1,price2)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state <= 0 then
        allowpaimai(actor,1)
        Sendmsg9(actor, "ff0000", "未开通盟重令,禁止上架道具!", 9)
    else
        allowpaimai(actor,0)
    end
end

--#region QFunction-0重载后触发
function qfloadend(sysobj)
    local player_list = getplayerlst(1)
    for i, player  in ipairs(player_list or {}) do
        VarApi.Init(player)
    end
end

-- 充值触发  self.玩家对象  gold.充值金额  productId.产品ID  MoneyId.货币ID  isReal.真实/扶持充值  orderTime.订单时间
function recharge(actor, Gold, ProductId, MoneyId, isReal, orderTime, rechargeAmount, giftAmount, refundAmount)
    RechargeTrigger.onRecharge(actor, Gold, ProductId, MoneyId, isReal, orderTime, rechargeAmount, giftAmount, refundAmount)
end

---双击使用道具前触发
---*  actor: 玩家对象
---@param actor string 玩家对象
---@param itemMakeIndex number 道具唯一id
---@param itemIndex number 道具idx
---@param itemNum number 道具数量
---@param stdMode number 物品表stdMode参数
---@return boolean 是否允许使用
function beforeeatitem(actor,itemMakeIndex,itemIndex,itemNum,stdMode)
    return UseItemTrigger.useItem(actor, itemMakeIndex, itemIndex, itemNum, stdMode)
end

--#region 人物攻击前触发(玩家对象，受击对象，攻击对象，技能id，伤害，当前攻击模式，return为修改后伤害)
function attackdamage(actor, Target, Hiter, MagicId, Damage, Model)
    return BeforeAttackTrigger.onPlayerAttack(actor, Target, Hiter, MagicId, Damage, Model)
end

--玩家魔法攻击后
function magicattack(actor,target,hitter,magicId)
    return BeforeAttackTrigger.onTypePlayerAttack(actor,target,hitter,magicId,true)
end

--玩家物理攻击后
function attack(actor,target,hitter,magicId)
     return BeforeAttackTrigger.onTypePlayerAttack(actor,target,hitter,magicId,false)
end
--- 套装 668 成功触发
function groupitemon668(actor)
end

function groupitemoffex(actor, suit_id)
end

-- 暴击触发
function crittrigger(actor, attack, damage, MagicId)
    if isInTable(BeforeAttackTrigger.filter_mons, getbaseinfo(attack, 1, 1)) then
        return 1
    end

    --无双 以暴制暴
    local timestamp = VarApi.getPlayerUIntVar(attack,"U_80013_buff_cd_timestamp") 
    if hasbuff(attack,80013) and os.time() - timestamp > 30 and isplayer(attack) then
        addbuff(attack,70014,10)
        VarApi.setPlayerUIntVar(attack,"U_80013_buff_cd_timestamp",os.time())
        sendattackeff(attack,313,0,"*") 
    end
end
--#region 玩家受击前
function struckdamage(actor,Hiter,Target,MagicId,Damage)
    return BeforeBeingAttackedTrigger.struckdamage(actor,Hiter,Target,MagicId,Damage)
end
--玩家物理受击后
function struck(actor,target,hitter,magicId)
    BeforeBeingAttackedTrigger.PlayerstruckdamageEnd(actor,target,hitter,magicId,false)
end
--玩家魔法受击后
function magicstruck(actor,target,hitter,magicId)
    BeforeBeingAttackedTrigger.PlayerstruckdamageEnd(actor,target,hitter,magicId,true)
end

--宠物攻击伤害前触发
function attackdamagepet(play,target,petObj,magicID,damage,isImportant)
     return BeforeAttackTrigger.attackdamagepet(play,target,petObj,magicID,damage,isImportant)
end
--=================================================================QM
--服务器启动
function startup(role)
    setontimerex(GlobalTimer.global_server_time_id, 1)           -- 服务器运行时间 每秒秒更新一次

    for k, v in pairs(VarEngine.MonUpdateVar) do
        SetSysInt(k, v)
    end
    for k, v in pairs(ActivityMgr.new_activity_cfg) do
        if v.SysIntVarName then
            SetSysInt(v.SysIntVarName.."gm", 0)
        end
    end

    HeFuTrigger.updateInfo()        -- 合服信息更新(内部判断是否第一次登陆)
    VarApi.InitSysVar()             -- 初始化直播需要的各种变量

    AddScheduled(9527, "update_run_day", 1, '00:00:00', '@_update_run_day', "1")        -- 每天0点执行
    AddScheduled(9528, "update_run_day", 1, '00:00:30', '@_update_send_var', "1")        -- 每天0点0分30秒执行
end

-- 更新服务器运行时间
function ontimerex9500()
    if GetSysInt("first_player_login_in") == 0 then return end
    local sever_run_time = GetSysInt(VarEngine.ServerRunTime)
    sever_run_time = sever_run_time + 1
    SetSysInt(VarEngine.ServerRunTime, sever_run_time)

    -- 全局机器人
    GlobalTimer.RunGlobalScheduled(sever_run_time)
    -- 新区活动
    ActivityMgr.initNewActivity(sever_run_time)
    -- 老区活动
    ActivityMgr.initOldActivity(sever_run_time)
end

function _update_run_day(sysobj, ...)
    if GetSysInt("first_player_login_in") == 0 then return end
    local open_day = GetSysInt(VarEngine.OpenDay)           -- 开区天数
    open_day = open_day + 1
    SetSysInt(VarEngine.OpenDay, open_day)

    CastleWarTrigger.winner_people = 0
    CastleWarTrigger.loser_people = 0

    local time = GetSysInt("G199")
    if open_day > 0 and time ~= 7200 then
        SetSysInt("G199", 7200)
    end
end

-- 每天0点手动调用一下
function _update_send_var(sysobj)
    gmexecute("0", "开始提问", "_reset_player_var")
end
function _reset_player_var(actor)
    VarApi.Init(actor)
end

--角色登陆触发
function login(actor)
    -- 第一个玩家登录
    if GetSysInt("first_player_login_in") == 0 then
        SetSysInt("first_player_login_in", 1)
    end
    LoginTrigger.login(actor)
end

-- 跨天触发
function resetday(actor)
    LoginTrigger.resetdayLogin(actor)
end

-- 每天登录触发  每天第一次登录
function setday(actor)
end

--初始化行会触发 actor是创建者
function loadguild(actor, ...)

end
--组队杀怪触发
function groupkillmon(actor, bossName)
    
end
--角色获得宝宝触发
function slavebb(actor, mon)
    return BaByTrigger.slavebb(actor, mon)
end
function equip_variation_send_msg(actor)
    IncludeNpcClass("EquipVariation"):sendAllMsg(actor)
end
--清理稻草人  刷新玩家的面板
function clearscare_send_msg(actor)
    if isnotnull(actor) then
        delbutton(actor, 101, 99999)
    end
end

-- 合成触发
function g_compounditem10000(actor, idx)

end
--=================================================================QMEnd
-- 关闭UI
function close_addbtn_ui(actor)
    delbutton(actor, 101, 999)
end

-- 刷怪触发   策划老白
function flush_cehualaobai()

end

-- 回收触发
function recycling(actor, ...)

end

-- 镜像地图销毁前触发
function mirrormapend(sysobj, mapId)
    killmonsters(mapId, "*", 0, true, false)
end

--- 改名卡
--- 1. 会先执行查询人物名称操作，并触发：queryinghumname;
-- 2. 会根据查询结果情况触发：humnamefilter（名称被过滤）、namelengthfail（长度不符合要求）、humnameexists（名称已经存在）;
-- 3. 执行改名操作前触发：changeinghumname，根据改名结果触发：changehumnameok(改名成功)、changehumnamefail(改名失败)。

--正在查询玩家名称
function queryinghumname(actor)
    -- sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>正在查询请稍后。。。</font>","Type":9}')
end

--名称被过滤
function humnamefilter(actor)
    sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>请不要包含敏感字或特殊字符！</font>","Type":9}')
    SendMail(actor, 1, "改名失败", "改名失败，道具已返还\\失败原因: 名称存在非法字符", "改名卡#1#370")
end

--长度不符合要求
function namelengthfail(actor)
    sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>输入名称长度不符合要求!</font>","Type":9}')
    SendMail(actor, 1, "改名失败", "改名失败，道具已返还\\失败原因: 名称长度不符合要求", "改名卡#1#370")
end

--名称已经存在
function humnameexists(actor)
    sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>名称已经存在</font>","Type":9}')
    SendMail(actor, 1, "改名失败", "改名失败，道具已返还\\失败原因: 该名字已经被其他玩家占用，请选择其他名字！", "改名卡#1#370")
end

--正在执行改名操作
function changeinghumname(actor)
    -- sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>正在修改请稍后。。。</font>","Type":9}')
end

--改名成功
function changehumnameok(actor)
    sendmsg(actor, 1, '{"Msg":"<font color=\'#ffff00\'>'..parsetext("你的名字修改成功，旧名称：<$USERNAME> 新名称：<$USERNEWNAME>！",actor)..'</font>","Type":9}')

    local old_name = getconst(actor, "<$USERNAME>")
    local new_name = getconst(actor, "<$USERNEWNAME>")

    local rank_list = GetSysStr("A_bless_rank_info")
    if "" == rank_list or nil == rank_list then
        rank_list = {}
    else
        rank_list = json2tbl(rank_list)
    end
    if rank_list[old_name] then
        rank_list[new_name] = rank_list[old_name]
        rank_list[old_name] = nil
    end
    SetSysStr("A_bless_rank_info", tbl2json(rank_list))
end

--改名失败
function changehumnamefail(actor)
    sendmsg(actor, 1, '{"Msg":"<font color=\'#ff0000\'>修改名称失败</font>","Type":9}')
    SendMail(actor, 1, "改名失败", "改名失败，道具已返还\\失败原因: 未知！", "改名卡#1#370")
end

-- 接取任务触发
function picktask(actor, task_id)
    TaskTrigger.onPickTask(actor, task_id)
end

-- 点击任务触发
function clicknewtask(actor, task_id)
    TaskTrigger.onClickTask(actor, task_id)
end

-- 刷新任务
function changetask(actor, task_id)
    TaskTrigger.onChangeTask(actor, task_id)
end

-- 完成任务
function completetask(actor, task_id)
    TaskTrigger.onCompleteTask(actor, task_id)
end

-- 删除任务
function deletetask(actor, task_id)
    TaskTrigger.onDeleteTask(actor, task_id)
end

-- 自定义排行榜刷新触发
function inisort(sysobj)

end

-- 寻路开启触发
function findpathbegin(actor)
    -- release_print("findpathstop",getbaseinfo(actor,1),getconst(actor, "<$ToPointX>"),getconst(actor, "<$ToPointY>"))
end
--玩家奔跑触发
function run(actor)
    --踏雪觉醒
    local timestamp = VarApi.getPlayerUIntVar(actor,"U_60062_buff_cd_timestamp") 
    if hasbuff(actor,60062) and os.time() - timestamp > 120 then
        local layer = getbuffinfo(actor,70028,1)
        if layer and  layer >= 10 then
            VarApi.setPlayerUIntVar(actor,"U_60062_buff_cd_timestamp",os.time()) 
        end
        addbuff(actor,70028,10)
        playeffect(actor,13411,0,0,1,0,0)
    end
end
--宝宝攻击前触发
function attackdamagebb(actor,target,hitter,magicId,damage)
    return BeforeAttackTrigger.onPetAttack(actor,target,hitter,magicId,damage)
end
--宝宝死亡触发
function selfkillslave(actor,mon)
    --道士 御灵
    if hasbuff(actor,60083) and getbaseinfo(actor,9) ~= getbaseinfo(actor,10)  then
        addhpper(actor,"+",20)
        playeffect(actor,13432,0,0,1,0,0)
    end
end
--人物复活时
function revival(actor)
    --周天
    local timestamp = VarApi.getPlayerUIntVar(actor,"U_60089_buff_cd_timestamp") 
    if hasbuff(actor,60089) and os.time() - timestamp > 60 then
        VarApi.setPlayerUIntVar(actor,"U_60089_buff_cd_timestamp",os.time()) 
        addbuff(actor,50004,1)
        playeffect(actor,13438,0,0,1,0,0)
    end
    if hasbuff(actor, 60086) then
        playeffect(actor,13435,0,0,0,0,0)
    end
end
--人物死亡之前
function nextdie(actor,hitter,isplayer)
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_occult_level")) 
    if data ~= "" then
        local num = 0
        for i,v in ipairs(data or {}) do
            if v > 0 then
                num = num + 1
            end
        end
        if num >= 16 and math.random(100) <= 10 then
            realive(actor) 
            addhpper(actor,"=",100)
            playeffect(actor,13471,0,0,1)
        end
    end
    -- local timestamp = VarApi.getPlayerUIntVar(actor,"U_60044_buff_cd_timestamp") 
    -- --不朽
    -- if hasbuff(actor,60044) and math.random(100)<=11 and os.time() - timestamp > 120 then
    --     VarApi.setPlayerUIntVar(actor,"U_60044_buff_cd_timestamp",os.time()) 
    --     realive(actor)
    --     addhpper(actor,"=",50)
    --     sendattackeff(actor,244,0,"*")
    --     playeffect(actor,13471,0,0,1)
    -- end
    -- --无双 亡灵序曲
    -- if hasbuff(actor,80056) and math.random(100) <= 10 then
    --     realive(actor) 
    --     addhpper(actor,"=",100)
    --     sendattackeff(actor,356,0,"*")
    --     playeffect(actor,13471,0,0,1)
    -- end
end

function tongreadkeytouser100(actor,key,id,value)
    Sendmsg9(actor, "ffffff", "测试通区返回数据"..key..id..value, 1) 
    local class = IncludeNpcClass("ChangeServer")
    if class  then
        class:RedReturnValue(actor,key,id,value)
    end
end
--离开队伍触发
function leavegroup(actor,leader)
    if hasbuff(actor,80006) then
        if getbaseinfo(actor,35) <= 0  then
            addbuff(actor,60108,0,1,actor,{[66]=5000,[75]=1000})
        else
            delbuff(actor,60108)
        end
    end
end
--组队人数改变触发
function groupchange(actor,type,groupnum,actorname)
    if hasbuff(actor,80006) then
        if getbaseinfo(actor,35) <= 0  then
            addbuff(actor,60108,0,1,actor,{[66]=5000,[75]=1000})
        else
            delbuff(actor,60108)
        end
    end
end

--角色pk值变化触发
function pkpointchanged(actor,pkpoint)
    --无双 恶魔崛起
    if hasbuff(actor,80043) then
        if getpklevel(actor) == 2 and getattlist(actor,"80043_attr") == "" then
            addbuff(actor,60111,0,1,actor,{[25]=10}) 
            sendattackeff(actor,343,0,"*")
        elseif getpklevel(actor) ~= 2 then
            delbuff(actor,60111)
        end
    end
end

-- 地图攻击怪物触发
function map_att_mon(actor)
end

-- 地图事件
function map_mining1(actor)
    local state = GetSysInt("G_mining_state")
    if state == 0 then
        return
    end
    local random = GetSysInt("G401")
    if random == 0 then
        random = 10
        SetSysInt("G401", random)
    end
    local value = math.random(100)
    if value > random then
        return
    end
    local npc_class = IncludeNpcClass("MiningDemand")
    if npc_class then
        npc_class:onMining(actor, 1)
    end
end
function map_mining2(actor)
    local state = GetSysInt("G_mining_state")
    if state == 0 then
        return
    end
    local random = GetSysInt("G402")
    if random == 0 then
        random = 10
        SetSysInt("G402", random)
    end
    local value = math.random(100)
    if value > random then
        return
    end
    local npc_class = IncludeNpcClass("MiningDemand")
    if npc_class then
        npc_class:onMining(actor, 2)
    end
end
function map_mining3(actor)
    local state = GetSysInt("G_mining_state")
    if state == 0 then
        return
    end
    local random = GetSysInt("G403")
    if random == 0 then
        random = 10
        SetSysInt("G403", random)
    end
    local value = math.random(100)
    if value > random then
        return
    end
    local npc_class = IncludeNpcClass("MiningDemand")
    if npc_class then
        npc_class:onMining(actor, 3)
    end
end
function map_mining4(actor)
    local state = GetSysInt("G_mining_state")
    if state == 0 then
        return
    end
    local random = GetSysInt("G400")
    if random == 0 then
        random = 10
        SetSysInt("G400", random)
    end
    local value = math.random(100)
    if value > random then
        return
    end
    local npc_class = IncludeNpcClass("MiningDemand")
    if npc_class then
        npc_class:onMining(actor, 4)
    end
end
