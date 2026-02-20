HeFuTrigger = {}
HeFuTrigger.GenMonTimerId = 200

--#region 服务器启动触发
function HeFuTrigger.updateInfo()
    -- 初始化合服次数
    local hf_count = tonumber(getconst("0", "<$HFCOUNT>"))
    SetSysInt(VarEngine.HeFuCount, hf_count)
    if hf_count == 1 then
        globalcleardelaygoto("clearscarecrow_mon", 1)
        SetSysInt("G_scarecrow_gen",0)
        for i,v in ipairs({"钳虫巢穴","死亡神殿","地狱烈焰","深渊魔域","堕落坟场","困惑殿堂","狂暴霸主"}) do
            killmonsters(v, "上古稻草人", 0, true,true)
        end
    end

    -- 当天是否合区
    local reset_tag = GetSysTLInt("GTL_merge_reset_tag")        --加个标记  避免合区当天重启了m2导致多次执行
    local is_merge = tonumber(getconst("0", "<$HFDAYS>"))
    if is_merge == 1 and reset_tag == 0 then
        -- 每次合区重置首爆
        SetSysStr("A_all_server_first_drop", "")

        -- 合区重置天下第一
        for index, id in ipairs({75,76,77}) do
            SetSysStr("A_world_n1"..id, "")
        end

        SetSysTLInt("GTL_merge_reset_tag", 1, GetDayTick() + 86400 )
    end

    -- 恶魔秘境刷怪
    setontimerex(HeFuTrigger.GenMonTimerId, 20)
end

--#region 玩家登录触发
function HeFuTrigger.userLogin(actor)
    local identity = castleidentity(actor)
    if identity ~= 2 and checktitle(actor, "大城主") then
        deprivetitle(actor, "大城主")
    end
    
    if GetSysInt(VarEngine.HeFuCount) >= 1 then
        VarApi.setPlayerTStrVar(actor,"T_cache_chang_server_data","")
    end
end

function ontimerex200()
    setofftimerex(HeFuTrigger.GenMonTimerId)
    local is_kf_connect = kuafuconnected()
    if is_kf_connect then
        KuaFuTrigger.bfbackcall(nil, "恶魔秘境_genmon", "恶魔秘境")
    else
        local npc_class = IncludeNpcClass("SecretRealmMoveNpc")
        if npc_class then
            npc_class:UpdateMon(false)
        end
    end
end