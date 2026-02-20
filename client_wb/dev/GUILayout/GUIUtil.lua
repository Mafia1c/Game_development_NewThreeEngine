LF = {}
LF.W = SL:GetMetaValue("SCREEN_WIDTH")
LF.H = SL:GetMetaValue("SCREEN_HEIGHT")
LF.effect = nil

function SLMainError(errinfo)
    if errinfo then
        SL:Print("--------------------error-----------------------")
        SL:Print("--------------------error-----------------------")
        SL:Print("--------------------error-----------------------")
        SL:Print("--------------------error-----------------------")
        SL:Print(errinfo)
        SL:Print("--------------------error-------------------------")
        SL:Print("--------------------error-------------------------")
        SL:Print("--------------------error-------------------------")
        SL:Print("--------------------error-------------------------")
    end
end

local function init_app()
    SL:Require("GUILayout/LoadAllFile", true)
end

local game_id = SL:GetMetaValue("GAME_ID")
local server_id = tonumber(SL:GetMetaValue("SERVER_ID")) or 0
SL:release_print("GUIUtil: ", game_id, server_id)
if server_id <= 1000 then
    local function ReloadScript()
        ViewMgr.CloseAll()
        init_app()
    end
    GUI:addKeyboardEvent({"KEY_CTRL","KEY_TAB"}, ReloadScript)
end

init_app()

-- 小地图怪物数据刷新
SL:RegisterLUAEvent(LUA_EVENT_MINIMAP_MONSTER, "GUIUtil", function ()
    local parent = GUI:GetWindow(GUI:Attach_SceneB(), "bossInfo")
    if parent then
        GUI:removeAllChildren(parent)
    else
        parent = GUI:Node_Create(GUI:Attach_SceneB(), "bossInfo", 0, 0)
    end
    local monsters = SL:Get_MINIMAP_MONSTERS()
    -- SL:dump(monsters,"--------------monsters")
    for _, v in pairs(monsters) do
        local posMx,posMy = SL:ConvertMapPos2WorldPos(tonumber(v.x) or 1, tonumber(v.y) or 1)
        local node = GUI:Node_Create(parent, string.format("boss_text%s_%s%s", v.name..posMx, posMx, posMy), posMx, posMy)
        GUI:Effect_Create(node, "effect", 0,0, 1, 220, 0, 0, 0, 1)
        local text = GUI:Text_Create(node, "bossName",30,40, 16, "#ff0000", v.name)
        GUI:setAnchorPoint(text,0.5,0.5)
        text = GUI:Text_Create(node, "downTime",30,0, 16, "#ff0000", "")
        GUI:setAnchorPoint(text,0.5,0.5)
        GUI:Text_COUNTDOWN(text, v.time, function ()
            GUI:removeFromParent(node)
        end)
    end
end)

-- 切换地图(不同地图)
SL:RegisterLUAEvent(LUA_EVENT_MAP_INFO_CHANGE, "GUIUtil", function()
    SL:RequestMiniMapMonsters()

    local mapName = SL:GetMetaValue("MAP_NAME")
    local _Handle = GUI:Attach_UITop()
    if _Handle then
        local nameList = {}
        -- 处理地图名称
        if mapName then
            local stringMatch = "[%z\1-\127\194-\244][\128-\191]*"
            for i, _ in string.gmatch(mapName, stringMatch) do
                table.insert(nameList, i)
            end
        end

        -- 创建文字动画效果
        for i = 1, #nameList do
            -- 移除已存在的同名控件
            if GUI:GetWindow(_Handle, "mapName"..i) then
                GUI:removeFromParent(GUI:GetWindow(_Handle, "mapName"..i))
            end

            -- 创建文字控件
            local Text_1 = GUI:Text_Create(
                _Handle,
                "mapName"..i,
                LF.W/2,
                LF.H/2,
                40,
                "#ffffff",
                nameList[i]
            )
            -- 设置文字属性
            GUI:setAnchorPoint(Text_1, 0.5, 0.5)
            GUI:setTouchEnabled(Text_1, false)
            GUI:setTag(Text_1, 0)
            GUI:Text_enableOutline(Text_1, "#0000ff", 2)
            -- 运行动画序列
            GUI:runAction(Text_1,
                GUI:ActionSequence(
                    GUI:ActionFadeOut(0),
                    GUI:DelayTime(i * 0.1),
                    GUI:ActionEaseExponentialOut(
                        GUI:ActionSpawn(
                            GUI:ActionMoveBy(0.3, (i * 48) - (48 * #nameList)/2, 0),
                            GUI:ActionFadeIn(0.3)
                        )
                    ),
                    GUI:DelayTime(0.5 + (#nameList - i) * 0.1),
                    GUI:ActionFadeOut(0.5),
                    GUI:CallFunc(function()
                        GUI:removeChildByName(_Handle, "mapName"..i)
                    end)
                )
            )
        end
    end
end)

function PlayMapEffect()
    local cfg = GetConfig("MapEffectCfg")
    for key, v in pairs(cfg or {}) do
        SL:RmvMapSpecialEffect(v.id, v.mapid)
        SL:AddMapSpecialEffect(v.id, v.mapid, v.effectid, v.x, v.y, true, 0, 0)
    end
end
PlayMapEffect()


