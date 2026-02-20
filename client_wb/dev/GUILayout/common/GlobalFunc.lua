--- 全局函数    服务器下发协议到客户端主动调用
GlobalFunc = {}
GlobalFunc.pubg_eff = {}
GlobalFunc.schedule_id = nil

-- 显示吃鸡毒圈特效
GlobalFunc["ShowPubgEffect"] = function (map_x, map_y, radius)
    GlobalFunc["DelPubgEffect"]()
    map_x = tonumber(map_x)
    map_y = tonumber(map_y)
    radius = tonumber(radius)
    if nil == map_x or nil == map_y or nil == radius then
        return
    end
    radius = radius * 48 + 24

    local pos = SL:ConvertMapPos2WorldPos(map_x, map_y)
    local function getPoints(x0, y0, r)
        local points = {}
        local seen = {}
        local x = r
        local y = 0
        local err = 0
        while x >= y do
            -- 添加八个对称的点
            local tmp_points = {}
            table.insert(tmp_points, {x0 + x, y0 + y})
            table.insert(tmp_points, {x0 + y, y0 + x})
            table.insert(tmp_points, {x0 - y, y0 + x})
            table.insert(tmp_points, {x0 - x, y0 + y})
            table.insert(tmp_points, {x0 - x, y0 - y})
            table.insert(tmp_points, {x0 - y, y0 - x})
            table.insert(tmp_points, {x0 + y, y0 - x})
            table.insert(tmp_points, {x0 + x, y0 - y})

            for _, point in ipairs(tmp_points) do
                local key = {point[1], point[2]}
                if not seen[key] then
                    table.insert(points, point)
                    seen[key] = true
                end
            end

            if err <= 0 then
                y = y + 10
                err = err + 2*y + 10
            end
            
            if err > 0 then
                x = x - 10
                err = err - 2*x + 10
            end
        end
        return points
    end

    local map_points = getPoints(pos.x, pos.y, radius)
    local parent = GUI:Attach_SceneB()
    if nil == GlobalFunc.schedule_id then
        local function update_callback()
            local _index = #GlobalFunc.pubg_eff
            if _index == #map_points then
                return
            end
            for i = 1, 100 do
                local k = _index + i
                local v = map_points[k]
                if v then
                    local icon = GUI:Effect_Create(parent, k.."_icon", v[1], v[2], 0, 27)
                    GlobalFunc.pubg_eff[k] = icon
                end
            end
        end
        GlobalFunc.schedule_id = SL:Schedule(update_callback, 0.05)
    end
end

-- 删除吃鸡毒圈特效
GlobalFunc["DelPubgEffect"] = function ()
    if GlobalFunc.schedule_id then
        SL:UnSchedule(GlobalFunc.schedule_id)
    end
    GlobalFunc.schedule_id = nil
    for k, v in pairs(GlobalFunc.pubg_eff)do
        GUI:removeFromParent(v)
    end
    GlobalFunc.pubg_eff = {}
end

-- 显示主界面top按钮
GlobalFunc["ShowMainTopBtn"] = function()
    local layout_102 = GUI:Win_FindParent(102)
    local btn_parent = GUI:GetWindow(layout_102, "btn_parent")
    if btn_parent then
        GUI:setVisible(btn_parent, true)
    end
end

-- 隐藏主界面top按钮
GlobalFunc["HiedMainTopBtn"] = function()
    local layout_102 = GUI:Win_FindParent(102)
    local btn_parent = GUI:GetWindow(layout_102, "btn_parent")
    if btn_parent then
        GUI:setVisible(btn_parent, false)
    end
end

-- 显示主界面系统按钮
GlobalFunc["ShowMainSysBtn"] = function()
    for key, v in pairs(main_sys_ui or {}) do
        GUI:setVisible(v, true)
    end
end

-- 隐藏主界面系统按钮
GlobalFunc["HiedMainSysBtn"] = function()
    for key, v in pairs(main_sys_ui or {}) do
        GUI:setVisible(v, false)
    end
end

-- 开区天数
GlobalFunc["OpenCount"] = function(count)
    SL:Print("OpenCount = ", count)
    GameData.SetData("OpenCount#"..count)
    SL:onLUAEvent(LUA_EVENT_GAME_DATA, "OpenCount#"..count)
end

--#region 合服次数接取
GlobalFunc["HeFuCount"] = function(count)
    SL:Print("HeFuCount = ", count)
    GameData.SetData("HeFuCount#"..count)
    SL:onLUAEvent(LUA_EVENT_GAME_DATA, "HeFuCount#"..count)
end

--#region 刷新怪物墓碑
GlobalFunc["UpdateBossMuBei"] = function()
    SL:RequestMiniMapMonsters()
end

--gm踢他下线
GlobalFunc["GmBackSystem"] = function()
    local data = {}
    data.str = "当前登录账号正在其他位置登录，本机已被强制离线！若非本人操作，请更改密码！"
    data.btnType = 1
    data.btnDesc = {"返回登录"}
    data.callback = function(atype, param)
        if atype == 1 then
            SL:ExitGame()
        end
    end
    UIOperator:OpenCommonTipsUI(data)
end

--天下第一战数据
GlobalFunc["A_world_n175"] = function(str)
    GameData.SetData("A_world_n175#"..str)
    SL:onLUAEvent(LUA_EVENT_GAME_DATA, "A_world_n175#"..str)
end
--天下第一战数据
GlobalFunc["A_world_n176"] = function(str)
    GameData.SetData("A_world_n176#"..str)
    SL:onLUAEvent(LUA_EVENT_GAME_DATA, "A_world_n176#"..str)
end
--天下第一战数据
GlobalFunc["A_world_n177"] = function(str)
    GameData.SetData("A_world_n177#"..str)
    SL:onLUAEvent(LUA_EVENT_GAME_DATA, "A_world_n177#"..str)
end

--活动状态
GlobalFunc["activity_state"] = function(key,value)  
    GameData.SetData(key.."#"..value)
end
--跨服世界
GlobalFunc["kf_word_state"] = function(key,value)  
    GameData.SetData(key.."#"..value)
end

--主界面聚宝盆
GlobalFunc["flush_main_top_jbp"] = function(key,value)  
    SL:onLUAEvent(LUA_EVENT_GAME_DATA, "flush_main_top_jbp")
end

-- 服务器下发 引导
GlobalFunc["navigation"] = function(fileName, nodeName, text, func, ...)
    local _tab = {...}
    local call_func = function ()
        local npc_class = ViewMgr.GetOpenViewByName(fileName)
        if nil == npc_class then
            return
        end
        local function callback()
            if func == "onActivationGift" then
                SendMsgClickMainBtn("0#WelfareHall#onActivationGift")
            elseif func == "onActiveBtn" then
                SendMsgCallFunByNpc(72, "BloodlineAwaken", "OnClickOpenActiveView", nil)
            elseif func == "onGetLoginReward" then
                SendMsgClickMainBtn("0#WelfareHall#onGetLoginReward#1")
            elseif func == "onAllRecycle" then
                -- SendMsgCallFunByNpc(0, "RecycleNpc", "onAllRecycle", _tab[1])
            elseif func == "onGetReward" then
                SendMsgCallFunByNpc(0, "MaFaGuJiNpc", "onGoToComplete", _tab[1] .. "#" .. _tab[2])
            elseif func == "onUpGodEquip" then
                SendMsgCallFunByNpc(1032, "GodEquip", "upEvent1","")
            elseif func == "onUse100Exp" then
                SendMsgClickSysBtn("0#OtherSysFunc#onUseExpItem#1#100万经验珠")
            elseif func == "onGetNewGift" then
                SendMsgClickSysBtn("0#OtherSysFunc#onGetNewPlayerGift#110")
            end
        end
        local data = {}
        data.dir = 8 -- 方向（1~8）从左按瞬时针
        data.guideWidget = npc_class.ui[nodeName] -- 当前节点
        data.guideParent = npc_class._parent -- 父窗口
        data.guideDesc = text or "引导" -- 文本描述
        data.clickCB = callback -- 回调
        data.autoExcute = 86400 -- 自动执行秒数
        data.isForce = true -- 强制引导
        SL:StartGuide(data)
    end
    SL:ScheduleOnce(call_func, 0.5)
end

--屏幕特效
GlobalFunc["screffects"] = function(id, value)
    local effect_id = tonumber(id)
    local _Handle = GUI:Attach_UITop()
    if effect_id and _Handle then
        local effect = GUI:getChildByName(_Handle, effect_id)
        if effect then
            GUI:removeFromParent(effect)
            effect = nil
        end
        local w = SL:GetMetaValue("SCREEN_WIDTH")
        local h = SL:GetMetaValue("SCREEN_HEIGHT")
        effect = GUI:Effect_Create(_Handle, effect_id, 0, 0, 0, effect_id, 0, 0, 0, 1)
        GUI:Effect_addOnCompleteEvent(effect, function()
            GUI:removeFromParent(effect)
            effect = nil
        end)
        GUI:setPosition(effect, w * 0.5, h * 0.5)
        GUI:setLocalZOrder(effect, 10000)
    end
end