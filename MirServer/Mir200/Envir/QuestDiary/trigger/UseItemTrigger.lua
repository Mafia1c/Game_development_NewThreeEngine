-- 使用道具触发
UseItemTrigger = {}
UseItemTrigger.BoxCfg = GetConfig("CustomBoxCfg")
UseItemTrigger.GiveItem = "玛法宝典#1#370"

---双击使用道具前触发
---*  actor: 玩家对象
---@param actor string 玩家对象
---@param itemObj obj 道具对象
---@param itemIdx number 道具idx
---@param itemMakeIndex number 道具唯一id
---@param itemNum number 道具数量
---@param stdMode number 物品表stdMode参数
---@return boolean 是否允许使用
function UseItemTrigger.useItem(actor, itemMakeIndex, itemIndex, itemNum, stdMode)
    local over_lap = getiteminfo(actor, itemMakeIndex, 5)        -- 叠加数量
    local itemName = getstditeminfo(itemIndex,1) --#region 道具名称
    local map_name = getbaseinfo(actor, 45)     -- 当前所在地图名称
    local map_id = getbaseinfo(actor, 3)        -- 当前所在地图id
    local job = getbaseinfo(actor, 7)           -- 职业
    local x = getbaseinfo(actor, 4)             -- 坐标x
    local y = getbaseinfo(actor, 5)             -- 坐标y
    local blank_num = getbagblank(actor)
    if blank_num < 6 then
        Sendmsg9(actor, "ffffff", "背包空间不足!", 1)
        return false
    end
    if hasbuff(actor,80028) and  isInTable({10568,10569,10570,10571,10572,12573},itemIndex) and math.random(100) <= 1  then
        addhpper(actor,"+",20)
        sendattackeff(actor,328,0,"*")
    end
    if isInTable({11345,11346,11347,11348,11349,11350}, itemIndex) then
        local npc_class = IncludeNpcClass("HighDrop")
        if npc_class then
            npc_class:click(actor, itemIndex)
        end
        SetTempInt(0, actor, "UTemp_use_item_id", itemIndex)
        return false
    end
    --#region 一定有返回是否允许使用     所有需要检查跨服是否可使用的道具都放到这里面实现
    local use_item_callback = {
        ["永久回城石"] = function ()
            if checkmirrormap(map_id)  then
                Sendmsg9(actor, "ffffff", "当前地图禁止使用!", 9)
                return false
            end
            if hasbuff(actor, 50000) then
                Sendmsg9(actor, "00ff00", "战斗中，请稍后操作", 9)
                return false
            end
            if checkkuafu(actor) then
                Sendmsg9(actor, "ffffff", "跨服地图禁止使用!", 1)
                return false
            end
            if VarApi.getPlayerUIntVar(actor,"U_map_cruise_state") > 0 then
                local class = IncludeNpcClass("MapCruise")
                if class then
                    Sendmsg9(actor, "ff0000", "手动回城，巡航取消!", 1)
                    class:StopMapCruise(actor)
                end
            end
            mapmove(actor, 3, 322, 333, 5)
            return false
        end,
        ["盟重传送石"] = function ()
            if checkmirrormap(map_id)  then
                Sendmsg9(actor, "ffffff", "当前地图禁止使用!", 9)
                return false
            end
            if checkkuafu(actor) then
                Sendmsg9(actor, "ffffff", "跨服地图禁止使用!", 1)
                return false
            end
            if VarApi.getPlayerUIntVar(actor,"U_map_cruise_state") > 0 then
                local class = IncludeNpcClass("MapCruise")
                if class then
                    Sendmsg9(actor, "ff0000", "手动回城，巡航取消!", 1)
                    class:StopMapCruise(actor)
                end
            end
            mapmove(actor, 3, 322, 333, 5)
            return false
        end,
        ["大陆传送石"] = function ()
            if checkmirrormap(map_id)  then
                Sendmsg9(actor, "ffffff", "当前地图禁止使用!", 9)
                return false
            end
            if checkkuafu(actor) then
                Sendmsg9(actor, "ffffff", "跨服地图禁止使用!", 1)
                return false
            end
            if VarApi.getPlayerUIntVar(actor,"U_map_cruise_state") > 0 then
                local class = IncludeNpcClass("MapCruise")
                if class then
                    Sendmsg9(actor, "ff0000", "手动回城，巡航取消!", 1)
                    class:StopMapCruise(actor)
                end
            end
            gohome(actor)
            return false
        end,
        ["随机传送石"] = function ()
            if checkkuafu(actor) then
                Sendmsg9(actor, "ffffff", "跨服地图禁止使用!", 1)
                return false
            end
            if string.find(map_id, "高爆") then
                Sendmsg9(actor, "ffffff", "禁止使用传送功能!", 1)
                return
            end
            map(actor, map_id)
            return false
        end,
        ["血脉石"] = function ()
            local npc_class = IncludeNpcClass("WsBloodLineAwaken")
            if npc_class then
                npc_class:OpenActiveView(actor)
            end
            return false
        end,
        ["永夜先驱者(称号)"] = function ()
            confertitle(actor, "永夜先驱者", 0)
            Sendmsg9(actor, "ffffff", "恭喜获得称号：<font color='#00ff00'>永夜先驱者</font>", 1)
            return true
        end,
        ["大神豪(称号)"] = function ()
            confertitle(actor, "大神豪", 0)
            Sendmsg9(actor, "ffffff", "恭喜获得称号：<font color='#00ff00'>大神豪</font>", 1)
            addbuff(actor, 50021)
            return true
        end,
        ["能量饮料"] = function ()
            addbuff(actor, 50005)
            local npc_class = IncludeMainClass("DailyActive")
            if npc_class then
                npc_class:UpdateActivePoint(actor, "能量饮料")
            end
            return true
        end,
        ["止疼药"] = function ()
            addbuff(actor,50006)
            return true
        end,
        ["医疗包"] = function ()
            addbuff(actor,50007)
            local npc_class = IncludeMainClass("DailyActive")
            if npc_class then
                npc_class:UpdateActivePoint(actor, "医疗包")
            end
            return true
        end,
        ["吸星大法"] = function ()
            addbuff(actor,50008)
            if tonumber(job) == 2 then
                setmagicpower(actor, "施毒术", 30, 1)
            end
            delbuff(actor, 50022)
            return true
        end,
        ["二级背包"] = function ()
            addbuff(actor,50009)
            setbagcount(actor, 86)
            return true
        end,
        ["三级背包"] = function ()
            delbuff(actor, 50009)
            addbuff(actor, 50010)
            setbagcount(actor, 126)
            Sendmsg9(actor, "ffffff", "背包全开!", 1)
            return true
        end,
        ["声望令"] = function ()
            if takeitem(actor, itemName, over_lap, 0, "双击使用声望令") then
                ChangeMoney(actor, 15, "+", 1 * over_lap, "消耗声望令道具获得声望", true)
            end
            return false
        end,
        ["玛法宝典"] = function ()
            lualib:ShowNpcUi(actor, "MaFaBaoDianOBJ", itemName .. "#" .. GetSysStr("A_jackpot_ret"))
            return false
        end,
        ["行会大礼包"] = function ()
            local guild_name = getbaseinfo(actor, 36)
            if guild_name ~= "" then
                Gives(actor, "玄铁盾#1#0&绑定元宝#10000", "使用行会大礼包赠送")
            else
                openhyperlink(actor, 31, 0)
                return false
            end
            return true
        end,
        ["冠名特权激活卡"] = function ()
            IncludeNpcClass("ChampionPrivilege"):click(actor)
            return false
        end,
        ["吸星大法体验卡"] = function ()
            if not hasbuff(actor, 50008) then
                addbuff(actor, 50022)
                if tonumber(job) == 2 then
                    setmagicpower(actor, "施毒术", 30, 1)
                end
            end
            return true
        end,
        ["变性卡"] = function ()
            messagebox(actor, "确定要消耗变性卡改变性别吗?", "@on_change_sex", "@______")
            return false
        end,
        ["神器魔盒"] = function ()
            IncludeNpcClass("GodEquip"):click(actor,nil,2)
            return false
        end,
        ["万倍地图爆率卷"] = function ()
            local time = os.time() + 3600
            VarApi.setPlayerJIntVar(actor, "J_wan_rate_map_time", time, time, true)
            OtherTrigger.showAddButton(actor)
            Sendmsg9(actor, "00ff00", "使用成功!", 1)
            return true
        end,
        ["元宝盒"] = function ()
            local weightTab={5000,4000,3000,2000,1000,500,300,200,100}
            local rewardTab={100,200,300,400,500,600,700,800,1000}
            local randWeight=math.random(16100)
            local nowWeight=0
            local endNum=0 --#region 结果数量
            for index, value in ipairs(weightTab) do
                nowWeight=nowWeight+value
                if randWeight<=nowWeight then
                    endNum=rewardTab[index]
                    break
                end
            end
            ChangeMoney(actor,4,"+",endNum,"元宝盒得元宝",true)
            Sendmsg9(actor,"00ff00","恭喜您成功获得"..endNum.."绑定元宝！",1)
            return true
        end,
        ["战神变异宝箱"] = function ()
            Gives(actor,"战神项链[变异]#1#370&战神手镯[变异]#1#370&战神手镯[变异]#1#370&战神戒指[变异]#1#370&战神戒指[变异]#1#370&战神腰带[变异]#1#370&战神靴子[变异]#1#370&","战神变异宝箱得")
            Sendmsg9(actor,"00ff00","恭喜您成功获得战神变异装备！",1)
            return true
        end,
        ["圣魔变异宝箱"] = function ()
            Gives(actor,"圣魔项链[变异]#1#370&圣魔手镯[变异]#1#370&圣魔手镯[变异]#1#370&圣魔戒指[变异]#1#370&圣魔戒指[变异]#1#370&圣魔腰带[变异]#1#370&圣魔靴子[变异]#1#370&","圣魔变异宝箱得")
            Sendmsg9(actor,"00ff00","恭喜您成功获得圣魔变异装备！",1)
            return true
        end,
        ["真魂变异宝箱"] = function ()
            Gives(actor,"真魂项链[变异]#1#370&真魂手镯[变异]#1#370&真魂手镯[变异]#1#370&真魂戒指[变异]#1#370&真魂戒指[变异]#1#370&真魂腰带[变异]#1#370&真魂靴子[变异]#1#370&","真魂变异宝箱得")
            Sendmsg9(actor,"00ff00","恭喜您成功获得真魂变异装备！",1)
            return true
        end,
    }
    if use_item_callback[itemName] then
        return use_item_callback[itemName]()
    end
    
    local car_list = {"白银特权激活卡","黄金特权激活卡","钻石特权激活卡"}
    if isInTable(car_list, itemName) then
        lualib:ShowNpcUi(actor, "SuperPrivilegesOBJ", "")
        return false
    end

    -- 技能书
    local skill_list = {
        ["开天斩"] = {0, 66, "你不是战士，无法学习", "修炼成功<font color='#00ff00'>【开天斩】</font>", 50000},
        ["擒龙手"] = {0, 71, "你不是战士，无法学习", "修炼成功<font color='#00ff00'>【擒龙手】</font>", 50000},
        ["逐日剑法"] = {0, 56, "你不是战士，无法学习", "修炼成功<font color='#00ff00'>【逐日剑法】</font>", 50000},
        ["十步一杀"] = {0, 82, "你不是战士，无法学习", "修炼成功<font color='#00ff00'>【十步一杀】</font>", 200000},
        ["流星火雨"] = {1, 58, "你不是法师，无法学习", "修炼成功<font color='#00ff00'>【流星火雨】</font>", 50000},
        ["分身术"] = {1, 74, "你不是法师，无法学习", "修炼成功<font color='#00ff00'>【分身术】</font>", 50000},
        ["灭天火"] = {1, 45, "你不是法师，无法学习", "修炼成功<font color='#00ff00'>【灭天火】</font>", 50000},
        ["群体雷电术"] = {1, 37, "你不是法师，无法学习", "修炼成功<font color='#00ff00'>【群体雷电术】</font>", 50000},
        ["冰霜群雨"] = {1, 84, "你不是法师，无法学习", "修炼成功<font color='#00ff00'>【冰霜群雨】</font>", 200000},
        ["飓风破"] = {2, 52, "你不是道士，无法学习", "修炼成功<font color='#00ff00'>【飓风破】</font>", 50000},
        ["噬血术"] = {2, 57, "你不是道士，无法学习", "修炼成功<font color='#00ff00'>【噬血术】</font>", 50000},
        ["无极真气"] = {2, 50, "你不是道士，无法学习", "修炼成功<font color='#00ff00'>【无极真气】</font>", 50000},
        ["气功波"] = {2, 48, "你不是道士，无法学习", "修炼成功<font color='#00ff00'>【气功波】</font>", 50000},
        ["死亡之眼"] = {2, 86, "你不是道士，无法学习", "修炼成功<font color='#00ff00'>【死亡之眼】</font>", 200000},
        ["召唤月灵"] = {2, 55, "你不是道士，无法学习", "修炼成功<font color='#00ff00'>【召唤月灵】</font>", 50000},
    }
    local v = skill_list[itemName]
    if v then
        if job ~= v[1] then
            Sendmsg9(actor, "ff0000", v[3], 1)
            return false
        elseif HasSkill(actor, v[2]) then
            local give_name = "书页"
            local give_num = math.ceil(v[5] / 1000)
            if give_num > 0 then
                Gives(actor, give_name .. "#" .. give_num .. "#370", "重复学习技能书获得奖励!")
                Sendmsg9(actor, "00ff00", string.format("重复学习获得%s*%s", give_name, give_num), 1)
            end
            if itemName == "召唤月灵" then
                takeitem(actor, itemName, 1, 0, "重复使用召唤月灵")
            end
            return true
        else
            addskill(actor, v[2], 3)
            Sendmsg9(actor, "ff0000", v[4], 1)
            if itemName == "召唤月灵" then
                takeitem(actor, itemName, 1, 0, "重复使用召唤月灵")
            end
            return true
        end
    end

    local AniCount = getdbitemfieldvalue(itemName, "Anicount")
    
    local _const1 = string.format("<$GetDBItemFieldValue(%s,ITEMPAEAM1)>", itemName)
    local ret1 = getconst(actor, _const1)
    local _const2 = string.format("<$GetDBItemFieldValue(%s,ITEMPAEAM2)>", itemName)
    local ret2 = getconst(actor, _const2)

    -- 元宝
    if isInTable({116,117,118,119,120,121,122,147}, AniCount) then
        local count = over_lap
        if over_lap <= 0 then
            count = itemNum
        end
        local source = getthrowitemly(actor, itemMakeIndex)
        local info = json2tbl(source)
        local tab = strsplit(ret1, "#")
        local value = tonumber(tab[2]) * count
        local name = tab[1]
        if type(info) == "table" and info.mon == "商铺购买" then
            name = "元宝"
        end
        gives(actor, name .. "#" .. value, "消耗道具"..itemName.."获得"..name)
        return true
    end
    -- 经验
    if isInTable({123,124,125,126,127,128}, AniCount) then
        UseItemTrigger.UseExpItem(actor, itemMakeIndex, itemIndex, itemNum, stdMode)
        return false
    end
    local buff_list = {
        ["[足迹激活卡]火麒麟"] = 50018,
        ["虚空魂环[激活卡]"] = 50019,
        ["[宠物激活卡]汪星人"] = 50020,
    }
    local buff_id = buff_list[itemName]
    if buff_id and not hasbuff(actor, buff_id) then
        addbuff(actor, buff_id)
    end

    -- 时装激活卡   -- 50011
    if AniCount >= 372 and AniCount <= 431 then
        local fashion_str = VarApi.getPlayerTStrVar(actor, "T_fashion_info")
        if not string.find(fashion_str, ret2, 1, true) then
            fashion_str = ret2 .. "|" .. fashion_str
            VarApi.setPlayerTStrVar(actor, "T_fashion_info", fashion_str, true)
            Sendmsg9(actor, "ffffff", "成功激活装扮，可前往<font color='#00ff00'> [ 装扮 → 时装 ] </font>查看！", 1)

            OtherTrigger.AttributeTransformation(actor, fashion_str, 50011)
        else
            if ret2=="[时装]独孤求败" then
                Gives(actor, "传说装扮宝箱#1#370", "消耗道具["..itemName.."]获得")
                Sendmsg9(actor, "ffffff", "你已激活过此时装装扮，系统补偿你：<font color='#00FF00'>传说装扮宝箱*1</font>", 1)
            else
                Gives(actor, UseItemTrigger.GiveItem, "消耗道具["..itemName.."]获得")
                Sendmsg9(actor, "ffffff", "你已激活过此时装装扮，系统补偿你：<font color='#00FF00'>玛法宝典*1</font>", 1)
            end
        end
    end
    -- 坐骑激活卡
    if AniCount >= 432 and AniCount <= 436 then
        local mount_equip = VarApi.getPlayerTStrVar(actor, "T_mount_equip")
        if not string.find(mount_equip, ret2, 1, true) then
            mount_equip = ret2 .. "|" .. mount_equip
            VarApi.setPlayerTStrVar(actor, "T_mount_equip", mount_equip, true)
            Sendmsg9(actor, "ffffff", "成功激活装扮，可前往<font color='#00ff00'> [ 装扮 → 坐骑 ] </font>查看！", 1)

            OtherTrigger.AttributeTransformation(actor, mount_equip, 50012)
        else
            Gives(actor, UseItemTrigger.GiveItem, "消耗道具["..itemName.."]获得")
            Sendmsg9(actor, "ffffff", "你已激活过此坐骑装扮，系统补偿你：<font color='#00FF00'>玛法宝典*1</font>", 1)
        end
        if itemName == "[坐骑激活卡]白衣剑仙" then
            VarApi.setPlayerUIntVar(actor, "U_mont_sword_state", 1, false)
        end
    end
    -- 足迹激活卡
    if AniCount >= 437 and AniCount <= 459 then
        local footprint = VarApi.getPlayerTStrVar(actor, "T_footprint_info")
        if not string.find(footprint, ret2, 1, true) then
            footprint = ret2 .. "|" .. footprint
            VarApi.setPlayerTStrVar(actor, "T_footprint_info", footprint, true)
            Sendmsg9(actor, "ffffff", "成功激活装扮，可前往<font color='#00ff00'> [ 装扮 → 足迹 ] </font>查看！", 1)

            OtherTrigger.AttributeTransformation(actor, footprint, 50013)
        else
            Gives(actor, UseItemTrigger.GiveItem, "消耗道具["..itemName.."]获得")
            Sendmsg9(actor, "ffffff", "你已激活过此足迹装扮，系统补偿你：<font color='#00FF00'>玛法宝典*1</font>", 1)
        end
    end
    -- 魂环激活卡
    if AniCount >= 460 and AniCount <= 471 then
        local soul_ring = VarApi.getPlayerTStrVar(actor, "T_soul_ring_info")
        if not string.find(soul_ring, ret2, 1, true) then
            soul_ring = ret2 .. "|" .. soul_ring
            VarApi.setPlayerTStrVar(actor, "T_soul_ring_info", soul_ring, true)
            Sendmsg9(actor, "ffffff", "成功激活装扮，可前往<font color='#00ff00'> [ 装扮 → 魂环 ] </font>查看！", 1)

            OtherTrigger.AttributeTransformation(actor, soul_ring, 50014)
        else
            Gives(actor, UseItemTrigger.GiveItem, "消耗道具["..itemName.."]获得")
            Sendmsg9(actor, "ffffff", "你已激活过此魂环装扮，系统补偿你：<font color='#00FF00'>玛法宝典*1</font>", 1)
        end
    end
    -- 翅膀激活卡
    if AniCount >= 486 and AniCount <= 494 then
        local _wing_str = VarApi.getPlayerTStrVar(actor, "T_angel_wing_info")
        if not string.find(_wing_str, ret2, 1, true) then
            _wing_str = ret2 .. "|" .. _wing_str
            VarApi.setPlayerTStrVar(actor, "T_angel_wing_info", _wing_str, true)
            Sendmsg9(actor, "ffffff", "成功激活装扮，可前往<font color='#00ff00'> [ 装扮 → 羽翼 ] </font>查看！", 1)
            -- VarApi.setPlayerTStrVar(actor, "T_cur_angel_wing", ret2, false)         -- 当前装扮的羽翼名称

            OtherTrigger.AttributeTransformation(actor, _wing_str, 50015)
        else
            Gives(actor, UseItemTrigger.GiveItem, "消耗道具["..itemName.."]获得")
            Sendmsg9(actor, "ffffff", "你已激活过此羽翼装扮，系统补偿你：<font color='#00FF00'>玛法宝典*1</font>", 1)
        end
    end
    -- 宠物激活卡
    if AniCount >= 476 and AniCount <= 485 then
        local pet_str = VarApi.getPlayerTStrVar(actor, "T_pet_str_info")
        if not string.find(pet_str, ret2, 1, true) then
            pet_str = ret2 .. "|" .. pet_str
            VarApi.setPlayerTStrVar(actor, "T_pet_str_info", pet_str, true)
            Sendmsg9(actor, "ffffff", "成功激活装扮，可前往<font color='#00ff00'> [ 装扮 → 宠物 ] </font>查看！", 1)
            if not checkspritelevel(actor) then
                createsprite(actor, ret2)
                VarApi.setPlayerTStrVar(actor, "T_disguiseName6", ret2, true)          -- 当前外显宠物
            end
            
            OtherTrigger.AttributeTransformation(actor, pet_str, 50016)
        else
            Gives(actor, UseItemTrigger.GiveItem, "消耗道具["..itemName.."]获得")
            Sendmsg9(actor, "ffffff", "你已激活过此宠物装扮，系统补偿你：<font color='#00FF00'>玛法宝典*1</font>", 1)
        end
    end
    -- 魔兽激活卡
    if AniCount >= 472 and AniCount <= 475 then
        local Warcraft_str = VarApi.getPlayerTStrVar(actor, "T_warcraft_info")
        if not string.find(Warcraft_str, ret2, 1, true) then
            Warcraft_str = ret2 .. "|" .. Warcraft_str
            VarApi.setPlayerTStrVar(actor, "T_warcraft_info", Warcraft_str, true)
            Sendmsg9(actor, "ffffff", "成功激活装扮，可前往<font color='#00ff00'> [ 装扮 → 魔兽 ] </font>查看！", 1)

            OtherTrigger.AttributeTransformation(actor, Warcraft_str, 50017)
        else
            Gives(actor, UseItemTrigger.GiveItem, "消耗道具["..itemName.."]获得")
            Sendmsg9(actor, "ffffff", "你已激活过此魔兽装扮，系统补偿你：<font color='#00FF00'>玛法宝典*1</font>", 1)
        end
    end

    if itemName == "pk清洗卡" then
        local pk_point = getbaseinfo(actor, 46)
        if nil == pk_point or 0 == pk_point then
            Sendmsg9(actor, "ff0000", "你没有罪孽，无需清洗！", 1)
            return false
        end
        setbaseinfo(actor, 46, 0)
        Sendmsg1(actor, 255, 249, "已为你消除一切罪孽，请耗子为止！", 1)
    end

    if itemName == "超级祝福油" then
        local wq = GetItemByPos(actor, 1)
        if "0" == wq then
            Sendmsg9(actor, "ff0000", "请佩戴好【武器】后再试！", 1)
            return false
        end
        local luck1 = getitemattidvalue(actor, 1, 39, 1, wq)
        local luck = GetItemLuck(actor, wq)
        if luck + luck1 >= 7 then
            Sendmsg9(actor, "00ff00", "你的武器已经是幸运+7", 1)
            return false
        end
        luck = luck + 1
        SetItemLuck(actor, wq, luck)
        Sendmsg9(actor, "00ff00", "恭喜：武器幸运+1点！", 1)
        Sendmsg1(actor, 255, 249, "恭喜：武器幸运+1点", 1)
    end

    -- 自选宝箱
    local _cfg = UseItemTrigger.BoxCfg[itemName]
    if _cfg then
        if _cfg.var == 1 then
            lualib:ShowNpcUi(actor, "CustomBoxOBJ", itemName)
        else
            local npc_class = IncludeNpcClass("CustomBoxNpc")
            if npc_class then
                npc_class:RandomItem(actor, itemName)
            end
        end
        return false
    end

    -- 千里传音
    if itemName == "千里传音" then
        if checkkuafu(actor) then
            Sendmsg9(actor, "FFFF00", "跨服区域禁止使用！", 1)
            return false
        end
        local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
        if mzl_state <= 0 then
            Sendmsg9(actor, "ffff00", "开通【盟重令】才可以使用！", 1)
            return false
        end
        UseItemTrigger.WorldSay(actor)
        return false
    end
    -- 改名卡
    if itemName == "改名卡" then
        if checkkuafu(actor) then
            Sendmsg9(actor, "FFFF00", "跨服区域禁止使用！", 1)
            return false
        end
        UseItemTrigger.ChangeName(actor)
        return false
    end
    -- 穿云箭
    if itemName == "穿云箭" then
        if checkkuafu(actor) then
            Sendmsg9(actor, "FFFF00", "跨服区域禁止使用！", 1)
            return false
        end
        local guild_obj = getmyguild(actor)
        if "0" == guild_obj then
            Sendmsg9(actor, "FFFF00", "你还没有行会！", 1)
            return false
        end
        local npc_class = IncludeNpcClass("MapMoveNpc")
        if npc_class then
            local id, cfg = npc_class:checkRecordNpcId(actor, map_id)
            if id == nil or (cfg.kuafu and cfg.kuafu >= 1) then
                Sendmsg9(actor, "FFFF00", "该地图禁止召唤！", 1)
                return false
            end
            messagebox(actor, "是否立即发起“穿云箭”\\可将行会成员召唤到身边\\需行会成员满足当前进图条件！", "@on_cyj_map_move,"..id, "@______")
        end
        return false
    end

    return true
end
-- 变性卡
function on_change_sex(actor)
    local num = getbagitemcount(actor, "变性卡", 0)
    if num <= 0 then
        Sendmsg9(actor, "ff0000", "改变性别需要道具[变性卡*1]", 1)
        return
    end
    if not takeitem(actor, "变性卡", 1, 0, "消耗变性卡改变性别!") then
        return
    end
    local sex = tonumber(getbaseinfo(actor, 8))
    if sex == 0 then
        sex = 1
    else
        sex = 0
    end
    setbaseinfo(actor, 8, sex)
    Sendmsg9(actor, "ffff00", "使用成功!", 1)
end

-- 千里传音
function UseItemTrigger.WorldSay(actor)
    local say_ui = [[
        <Img|img=public/1900000600.png|bg=1|show=4|esc=1|move=0|reset=1|scale9l=10|scale9r=10|scale9t=10|scale9b=10||height=286|width=546>
        <Layout|x=544|y=0|width=80|height=80|link=@exit>
        <Button|x=544|y=0|pimg=public/1900000511.png|nimg=public/1900000510.png|link=@exit>
        <RText|x=185|y=33|color=255|size=18|outline=1|text=<千里传音　全服喊话/FCOLOR=253>>
        <RText|x=49|y=84|color=255|size=18|outline=1|text=<信息将显示在世界频道，全服玩家屏幕中间滚动刷屏1次！/FCOLOR=254>>
        <Button|x=412|y=201|size=18|pimg=public/1900000680_1.png|color=251|submitInput=3|nimg=public/1900000680.png|text=发送喊话|link=@send_world_msg>
        <Img|x=75|y=200|width=320|img=public/1900015004.png>
        <Input|ax=0|ay=1|x=79|y=204|width=310|height=32|color=255|type=0|inputid=3|size=18|isChatInput=1>
        <RText|x=104|y=135|color=255|size=18|outline=1|text=<请输入发送的内容，发送垃圾信息会被封号！/FCOLOR=249>>
    ]]
    say(actor, say_ui)
end
function send_world_msg(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "FFFF00", "跨服区域禁止使用！", 1)
        return false
    end
    local num = getbagitemcount(actor, "千里传音", 0)
    if num < 1 then
        Sendmsg9(actor, "FFFF00", "需要千里传音*1！", 1)
        return
    end
    local say_str = getconst(actor, "<$NPCINPUT(3)>")
    if "" == say_str or nil == say_str then
        Sendmsg9(actor, "FFFF00", "请先输入内容！", 1)
        return
    end
    if not takeitem(actor, "千里传音", 1, 0, "发送世界消息扣除!") then
        return Sendmsg9(actor, "FFFF00", "千里传音扣除失败！", 1)
    end
    local str = "(世界传音) <%s/FCOLOR=251>:  <%s/FCOLOR=250>"
    sendmovemsg(actor, 1, 253, 0,180, 1, string.format(str, getbaseinfo(actor, 1), say_str))
    sendmovemsg(actor, 1, 253, 0,250, 1, string.format(str, getbaseinfo(actor, 1), say_str))
    sendmovemsg(actor, 1, 253, 0,320, 1, string.format(str, getbaseinfo(actor, 1), say_str))
    Sendmsg1(actor, 253, 255, "「(世界传音)」"..getbaseinfo(actor, 1)..": "..say_str, 2)
    close(actor)
end
-- 改名卡
function UseItemTrigger.ChangeName(actor)
    local say_ui = [[
        <Img|width=344|height=418|show=4|move=0|scale9t=10|bg=1|scale9b=10|scale9r=10|img=public/1900000600.png|reset=1|scale9l=10|esc=1>
        <Layout|x=343.0|y=0|width=80|height=80|link=@exit>
        <Button|x=343.0|y=0|nimg=public/1900000510.png|pimg=public/1900000511.png|link=@exit>
        <Text|x=119.0|y=23.0|size=18|color=250|outline=1|outlinecolor=0|text=角色改名功能>
        <Text|x=127.0|y=57.0|color=254|outline=1|size=18|text=改名说明：>
        <Text|x=46.0|y=90.0|size=18|color=254|outline=1|outlinecolor=0|text=不可以修改已经被使用的角色名>
        <Text|x=128.0|y=123|color=249|outline=1|size=18|text=必须遵守：>
        <Text|x=99.00|y=159|size=18|color=249|outline=1|outlinecolor=0|text=不可使用侮辱词汇、>
        <Text|x=70.00|y=195|color=249|outline=1|size=18|text=数字、英文、特殊字符、等>
        <Text|x=68.00|y=231|size=18|color=251|outline=1|outlinecolor=0|text=修改角色名之前请认真阅读，>
        <Text|x=71.00|y=267|color=251|outline=1|size=18|text=违犯以上规则官方有权封号>
        <Img|x=89.0|y=309.0|width=164|height=33|img=public/1900015004.png|esc=0>
        <Input|x=91.0|y=311.0|width=160|height=30|mincount=6|errortips=1|maxcount=12|inputid=4|size=18|place=输入要修改的名字|isChatInput=1|color=255|type=0>
        <Button|x=107.0|y=359.0|width=130|height=39|submitInput=4|size=18|color=103|nimg=public/1900000612.png|text=确认修改名字|link=@om_change_name>
    ]]
    say(actor, say_ui)
end
function om_change_name(actor)
    local say_str = getconst(actor, "<$NPCINPUT(4)>")
    if not takeitem(actor, "改名卡", 1) then
        Sendmsg9(actor, "ffffff", "需要改名卡！", 1)
        return
    end
    changehumname(actor, say_str)
    close(actor)
end
-- 发起穿云箭
function on_cyj_map_move(actor, npc_id)
    local map_id = getbaseinfo(actor, 3)
    local x, y = getconst(actor, "<$X>"), getconst(actor, "<$Y>")
    if not takeitem(actor, "穿云箭", 1) then
        return Sendmsg9(actor, "ffffff", "穿云箭扣除失败！", 1)
    end
    local my_name = getbaseinfo(actor, 1)
    local guild = getmyguild(actor)
    local member_list = getguildinfo(guild, 3)
    for k, name in pairs(member_list or {}) do
        local role = getplayerbyname(name)
        if name ~= my_name and role and isnotnull(role) then
            local str = string.format("玩家:%s使用穿云箭\n在 %s %s,%s求助，是否立即前往?",getbaseinfo(actor,1),getbaseinfo(actor,45),x, y)
            messagebox(role, str, "@_go_to_cyj_map,"..map_id..","..x ..","..y .. "," ..npc_id, "@______")
        end
    end
    Sendmsg9(actor, "00ff00", "使用成功！", 1)
end
-- 响应穿云箭
function _go_to_cyj_map(actor, map_id, x, y, npc_id)
    local npc_class = IncludeNpcClass("MapMoveNpc")
    if npc_class then
        npc_class:onMove(actor, tonumber(npc_id), map_id, tonumber(x), tonumber(y))
    end
end

-- 经验珠
function UseItemTrigger.UseExpItem(actor, itemMakeIndex, itemIndex, itemNum, stdMode)
    local sMsg = VarApi.getPlayerUIntVar(actor, "U_hide_double_tips")
    local sMsg2 = VarApi.getPlayerUIntVar(actor, "U_all_use_exp_state")
    lualib:ShowNpcUi(actor, "UseExpItemObj", sMsg .. "#" .. sMsg2)
    local navigation = VarApi.getPlayerUIntVar(actor, "U_navigation_use_exp_item")
    if navigation == 1 then
        VarApi.setPlayerUIntVar(actor, "U_navigation_use_exp_item", 100, true)
        lualib:CallFuncByClient(actor, "navigation", "UseExpItemObj#use_1_1#点击使用#onUse100Exp")
    end
end