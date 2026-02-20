NpcClassCache = {}

function QFIncludes(tag)
    release_print("LoadAllFile ===", tag)

    -- mgr
    include("QuestDiary/util/VarApi.lua")
    include("QuestDiary/util/ActivityMgr.lua");
    include("QuestDiary/util/PlayerTimer.lua")
    include("QuestDiary/util/GlobalTimer.lua")
    include("QuestDiary/util/BitMgr.lua")

    -- util define
    local utilFileList = {
        -- define
        "QuestDiary/define/ServerProtocolDefine.lua",
        "QuestDiary/define/VarDefine.lua",

        "QuestDiary/util/CommonFunc.lua",
        "QuestDiary/util/json.lua",
        "QuestDiary/util/luaApi.lua",
        "QuestDiary/util/debug.lua",
        "QuestDiary/util/sendmsg.lua",
        "QuestDiary/util/ChuanQiPuBg.lua",
        "QuestDiary/util/GmBackSystem.lua",
        "QuestDiary/util/GsBackFunc.lua",
        "QuestDiary/util/ShowReward.lua",
    }
    for i = 1, #utilFileList do
        local _, err = pcall(include, utilFileList[i])
        if err then
            release_print(utilFileList[i], err)
        end
    end

    -- 触发相关的都写到这里面去
    local triggerList = {
        "LoginTrigger",                         -- 登录触发
        "BuffTrigger",                          -- buff表trigger
        "UseItemTrigger",                       -- 双击使用道具触发
        "BeforeAttackTrigger",                  -- 攻击前触发(人物/宝宝/怪物)
        "BeforeBeingAttackedTrigger",           -- 被攻击前触发(人物/宝宝/怪物)
        "RechargeTrigger",                      -- 充值触发
        "TakeEquipTrigger",                     -- 穿脱装扮触发
        "KillmonTrigger",                       -- 杀怪触发
        "OtherTrigger",                         -- 跳转地图触发
        "UseMagicTrigger",                      -- 技能使用触发
        "BaByTrigger",                          -- 召唤宝宝
        "TitleTrigger",                         -- 称号增删改触发
        "PickupItemexTrigger",                  -- 拾取触发
        "MonDropItemTrigger",                   -- 怪物掉落物品触发
        "TaskTrigger",                          -- 任务系统级触发
        "CastleWarTrigger",                     -- 沙巴克攻城触发
        "ClickNpcTrigger",                      -- npc点击触发
        "KuaFuTrigger",                         -- 跨服触发
        "HeFuTrigger",                          -- 合服触发
        "PlayerDieTrigger",                     -- 主角死亡触发
        "AbilityTrigger",                       -- 属性变化触发
        "LoginAddStrAttrTrigger",               -- 登录加字符串属性
        "FakeHumanTrigger",                     -- 假人触发
    }
    for k, v in pairs(triggerList) do
        IncludeTriggerClass(v)
    end

    local npc_class = {

    }
    for k, v in pairs(npc_class) do
        IncludeNpcClass(v)
    end

    local main_class = {

    }
    for k, v in pairs(main_class) do
        IncludeMainClass(v)
    end

    local sys_class = {

    }
    for k, v in pairs(sys_class) do
        IncludeSysClass(v)
    end
end

function IncludeNpcClass(name)
    if nil == name then
        return nil
    end
    local npc_class = NpcClassCache[name]
    if npc_class then
        return npc_class
    end
    npc_class = include("QuestDiary/npc/"..name..".lua")
    NpcClassCache[name] = npc_class
    return npc_class
end

function IncludeMainClass(name)
    if nil == name then
        return nil
    end
    local npc_class = NpcClassCache[name]
    if npc_class then
        return npc_class
    end
    npc_class = include("QuestDiary/main/"..name..".lua")
    NpcClassCache[name] = npc_class
    return npc_class
end

function IncludeSysClass(name)
    if nil == name then
        return nil
    end
    local npc_class = NpcClassCache[name]
    if npc_class then
        return npc_class
    end
    npc_class = include("QuestDiary/sys/"..name..".lua")
    NpcClassCache[name] = npc_class
    return npc_class
end

function IncludeTriggerClass(name)
    include("QuestDiary/trigger/"..name..".lua")
end