local ObeliskNpc = {}
ObeliskNpc.NpcId = {129,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030}
ObeliskNpc.cfg = GetConfig("ObeliskCfg")
-- 镇魂塔
function ObeliskNpc:onMoveObelisk(actor, npc_id)
    if CheckOpenState(actor, 1) then return end
    npc_id = tonumber(npc_id)
    local npc = getnpcbyindex(npc_id)
    local my_map = getbaseinfo(actor, 3)
    local npc_map = getbaseinfo(npc, 3)
    if my_map ~= npc_map then
        return
    end

    if not isInTable(self.NpcId, npc_id) then
        return
    end

    local index = indexOfTable(self.NpcId, npc_id)
    if -1 == index then
        return
    end

    if not kuafuconnected() then
        Sendmsg9(actor, "ff0000", "跨服服务器未连接!", 1)
        return
    end

    local _cfg = self.cfg[npc_id]
    local need_item = _cfg.needitem
    if need_item then
        local num = getbagitemcount(actor, need_item, 0)
        if num < 9 then
            Sendmsg9(actor, "ff0000", string.format("进入镇魂塔需要仙石*%s!", 9), 1)
            return
        end
    end

    local var = _cfg.needvar
    if var then
        local tab = strsplit(var, "#")
        local var_name = tab[2] or ""
        local need_value = tab[3] or ""
        local ret = nil
        if string.find(var_name, "U") == 1 then
            local value = VarApi.getPlayerUIntVar(actor, tab[2])
            ret = value .. ">=" .. need_value
        elseif string.find(var_name, "T") == 1 then
            local value = VarApi.getPlayerTStrVar(actor, tab[2])
            ret = value .. "==" .. need_value
        elseif string.find(var_name, "J") == 1 then
            local value = VarApi.getPlayerJIntVar(actor, tab[2])
            ret = value .. ">=" .. need_value
        elseif string.find(var_name, "Z") == 1 then
            local value = VarApi.getPlayerZStrVar(actor, tab[2])
            ret = value .. "==" .. need_value
        end
        if ret then
            if not eval(ret) then
                Sendmsg9(actor, "ff0000", tab[1], 1)
                return
            end
        else
            Sendmsg9(actor, "ff0000", "变量配置错误: " .. var, 1)
            return
        end
    end

    local need_level = _cfg.needlevel
    if need_level then
        local level = getbaseinfo(actor, 6)
        if level < need_level then
            Sendmsg9(actor, "ff0000", string.format("进入需要人物等级%s!", need_level), 1)
            return
        end
    end

    if need_item and not takeitem(actor, need_item, 9, 0, "进入镇魂塔扣除!") then
        Sendmsg9(actor, "ff0000", need_item .. "扣除失败!", 1)
        return
    end

    lualib:CloseNpcUi(actor, "ObeliskOBJ")

    local map_id = _cfg.mapid
    mapmove(actor, map_id, _cfg.posx, _cfg.posy, 1)
    local map_name = getmapname(map_id)

    local name = getbaseinfo(actor, 1)
    local str = string.format("玩家 「%s」 前往: 「%s」 挑战, 祝愿他满载而归!", "<font color = '#00ff00'>"..name .. "</font>", "<font color = '#ffff00'>"..map_name .. "</font>")
    local msg = string.format('{"Msg":"%s","FColor":255,"BColor":249,"Type":1}',str)
    sendmsg(actor, 2,msg)
end

function ObeliskNpc:UpdateObeliskBoss()
    for key, v in pairs(self.cfg) do
        killmonsters(v.mapid, v.mobmon, 1, true, true)
        genmon(v.mapid, v.monx, v.mony, v.mobmon, 1, 1, 249)
    end
    sendmovemsg("0", 0, 255, 0, 90, 1, "<【镇魂塔】∶/FCOLOR=250><【跨服·镇魂塔】/FCOLOR=251><〖BOSS〗/FCOLOR=253>已刷新，各位勇士速速前往击杀！")
    Sendmsg1("0", 255, 249, "【镇魂塔】∶【跨服·镇魂塔】〖BOSS〗已刷新，各位勇士速速前往击杀！", 2)

    local player_list = getplayerlst(1)
    for key, actor in pairs(player_list or {}) do
        if checkkuafu(actor) or getbaseinfo(actor, 3) == "hero001" then
        else
            local ui_str = [[
                <Img|x=92|y=191|children={atv1,atv2}|img=custom/npc/49zht/tc.png>
                <Button|id=atv1|x=154|y=19|a=4|nimg=public/01.png|pimg=public/02.png|link=@close_addbtn_ui>
                <Button|id=atv2|x=91|y=144|a=4|nimg=custom/npc/49zht/btn1.png|pimg=custom/npc/49zht/btn2.png|link=@goto_zhenhunta>
            ]]
            addbutton(actor, 101, 999, ui_str)
        end
    end
end

function goto_zhenhunta(actor)
    delbutton(actor, 101, 999)
    local temp = VarApi.getPlayerUIntVar(actor, "U_bigMap")
    if temp >= 2 then
        opennpcshowex(actor, 129, 2, 2)
    else
        opennpcshowex(actor, 84, 2, 2)
    end
end

return ObeliskNpc