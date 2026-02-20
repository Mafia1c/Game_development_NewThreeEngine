ClickNpcTrigger = {}
ClickNpcTrigger.map_cfg = GetConfig("MapMoveCfg")
ClickNpcTrigger.ExclusiveCfg = GetConfig("ExclusiveCfg")

--#region npc点击触发(玩家对象,npc索引id,npc文本路径)return true不允许
function ClickNpcTrigger.clicknpc(actor, npcId, sScript)
    local npc_obj = getnpcbyindex(npcId)
    local name = getbaseinfo(npc_obj, 1)
    local npcTab={
        [1]=function ()
            if VarApi.getPlayerUIntVar(actor, "U_task_step_info") < 1 then
                if not TaskTrigger.CheckTask(actor, 1) then
                    delay_pick_task(actor)
                end
                return true
            elseif VarApi.getPlayerUIntVar(actor, "U_login_give") == 0 then
                VarApi.setPlayerUIntVar(actor, "U_login_give", 1, false)
                CompleteTask(actor, 2)
                return false
            end
            return false
        end,
        [1059]=function ()-- gs后台
            -- GmBackSystem.password(actor)
            usercmd9001(actor)
            return false
        end,
        [1060]=function ()-- gs后台
            -- GmBackSystem.password(actor)
            usercmd9002(actor)
            return false
        end,
        [100001]=function ()-- gs后台
            -- GsBackFunc.password(actor)
            usercmd9002(actor)
            return false
        end,
        [100002]=function ()
            usercmd9001(actor)
            return false
        end,
        [66]=function ()--官职晋升
            IncludeNpcClass("JobTitleUpgrade"):click(actor,npcId)
            return false
        end,
        [88]=function ()--官职晋升
            IncludeNpcClass("JobTitleUpgrade"):click(actor,npcId)
            return false
        end,
        [126]=function ()--官职晋升
            IncludeNpcClass("JobTitleUpgrade"):click(actor,npcId)
            return false
        end,
        [79]=function ()-- 首爆奖励
            IncludeMainClass("WelfareHall"):onClickBtn(actor, 4)
            return false
        end,
        [82]=function ()
            IncludeNpcClass("ClickBloodFillingNpc"):onClickBloodFilling(actor)
            return false
        end,
        [62]=function ()-- 狂暴之力
            IncludeMainClass("BerserkerPower"):onClickBtn(actor)
            return false
        end,
        [127]=function ()
            IncludeNpcClass("DragonTreasure"):click(actor)
            return false
        end,
        [80]=function ()-- 活动大使
            IncludeMainClass("ActivityCenter"):onClickBtn(actor)
            return false
        end,
        [38]=function ()-- 行会禁地
            IncludeMainClass("ActivityCenter"):onClickBtn(actor, 6)
            return false
        end,
        [92]=function ()-- 神兽之力
            IncludeNpcClass("GodBeastPower"):click(actor)
            return false
        end,
        [120]=function ()-- 神兽之灵
            IncludeNpcClass("GodBeastSoul"):click(actor)
            return false
        end,
        [10002]=function ()--武林至尊裁判员
            IncludeMainClass("ActivityCenter"):WlzzCaiPan(actor)
            return false
        end,
        [1056]=function ()
            IncludeNpcClass("AnswerNpc"):click(actor)
            return false
        end,
        [1055]=function ()-- 地下矿洞
            IncludeNpcClass("MiningDemand"):clickNpc(actor)
            return false
        end,
        [1050]=function () --#region 老板娘的闺房
            if GlobalTimer.server_run_time>7200 and GetSysInt("G200")==0 then
                Sendmsg9(actor, "ff0000", "活动只有开服2小时内可进入！", 1)
                return true
            end
            mapmove(actor,"老板娘的闺房",12,24,1)
            return false
        end,
        [1058]=function ()--塔防
            IncludeNpcClass("TowerDefence"):DefenceNpc(actor)
            return false
        end,
        [1057]=function ()
            IncludeNpcClass("TowerDefence"):clickNpc(actor)
            return false
        end,
        [1061]=function ()
            IncludeNpcClass("TowerDefence2"):Defence2Npc(actor)
            return false
        end,
        [1049]=function ()
            if GetSysInt("G_king_open_state") ~= 1 then
                Sendmsg9(actor, "ff0000", "【王的遗迹】未开放或已结束!", 9)
                return true
            end
            local open_day = GetSysInt(VarEngine.OpenDay)
            if open_day < 1 then
                map(actor, "王的遗迹1")
            else
                local npc_class = IncludeNpcClass("MapMoveNpc")
                if npc_class then
                    npc_class:onMove(actor, npcId)
                end
            end
            return false
        end,
    }
    if npcTab[npcId] then
        return npcTab[npcId]() or false
    end

    -- 传送npc
    local _cfg = ClickNpcTrigger.map_cfg[npcId]
    if _cfg then
        if _cfg.reward_arr == nil then
            local npc_class = IncludeNpcClass("MapMoveNpc")
            if isInTable({1036,1037,1038,1039,1040,1041},npcId) then
                if npc_class then
                    npc_class:EnterHideMap(actor, npcId)
                end
            else
                if npc_class then
                    npc_class:onMove(actor, npcId)
                end
            end
        else
            lualib:ShowNpcUi(actor, "MapMoveOBJ", npcId)
        end
        return false
    end
    -- 专属装备
    _cfg = ClickNpcTrigger.ExclusiveCfg[npcId]
    if _cfg then
        local npc_class = IncludeNpcClass("ExclusiveEquipNpc")
        if npc_class then
            npc_class:click(actor, npcId)
        end
        return false
    end


    --专属时装
    if isInTable({214,213,215},npcId) then
        local npc_class = IncludeNpcClass("ExclusiveFashion")
        if npc_class then
            npc_class:click(actor,npcId)
        end
        return false
    end
     --元神之力
    if isInTable({164,175,190},npcId) then
        local npc_class = IncludeNpcClass("SpiritPower")
        if npc_class then
            npc_class:click(actor,npcId)
        end
        return false
    end
    --战争女神
    if isInTable({168,176,192},npcId) then
        local npc_class = IncludeNpcClass("WarGoddess")
        if npc_class then
            npc_class:click(actor,npcId)
        end
        return false
    end
    --上古裁缝
    if isInTable({167,179,189},npcId) then
        local npc_class = IncludeNpcClass("AncientDressmaker")
        if npc_class then
            npc_class:click(actor,npcId)
        end
        return false
    end  
    --天神之锤
    if isInTable({187},npcId) then
        local npc_class = IncludeNpcClass("GodHammer")
        if npc_class then
            npc_class:click(actor)
        end
        return false
    end
    --专属称号
    if isInTable({210,211,212},npcId) then
        local npc_class = IncludeNpcClass("ExclusiveTitle")
        if npc_class then
            npc_class:click(actor,npcId)
        end
        return false
    end

    if isInTable({69,93,119}, npcId) then
        local npc_class = IncludeNpcClass("LifeUp")
        if npc_class then
            npc_class:onClick(actor, npcId)
        end
        return false
    end

    -- 王的遗迹1-7 npc
    if isInTable({1042,1043,1044,1045,1046,1047,1048}, npcId) then
        local npc_class = IncludeNpcClass("KingRemainNpc")
        if npc_class then
            npc_class:click(actor, npcId)
        end
        return false
    end

    return false --#region 允许点击
end
