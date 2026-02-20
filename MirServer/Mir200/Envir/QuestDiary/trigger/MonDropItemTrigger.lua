MonDropItemTrigger = {}
local _tmp_cfg = {}
for index, v in ipairs(GetConfig("FirstDropCfg")) do
    _tmp_cfg[v.name] = v
end
MonDropItemTrigger.AllFirstDorpCfg = _tmp_cfg


--#regoin 怪物掉落物品触发(玩家对象，掉落装备物品唯一id，掉落怪物对象，掉落坐标x，掉落坐标y，物品序号)
function MonDropItemTrigger.mondropitemex(actor,makeIndex,mon,nX,nY,index)

    MonDropItemTrigger.AllServerDorp(actor,makeIndex,mon,nX,nY,index)
end

-- 全服首爆
function MonDropItemTrigger.AllServerDorp(actor,makeIndex,mon,nX,nY,index)
    local monName = getbaseinfo(mon, 1)
    local isBoss = getdbmonfieldvalue(monName, "type")
    local itemName = getiteminfo(actor, makeIndex, 7)
    local cfg = MonDropItemTrigger.AllFirstDorpCfg[itemName]
    if cfg and isBoss == 3 and not checkkuafu(actor) then
        local ret = GetSysStr("A_all_server_first_drop")
        if "" == ret then
            ret = {}
        else
            ret = json2tbl(ret)
        end
        if nil == ret[itemName] then
            ret[itemName] = itemName .. "|" .. getbaseinfo(actor, 1) .. "|" .. os.time()
            SetSysStr("A_all_server_first_drop", tbl2json(ret))

            local reward = cfg.givemoney .. "#" .. cfg.moneynum
            SendMail(actor, 1, "全服首爆奖励", "恭喜获得全服首爆 <["..itemName .. "]/FCOLOR=250> 奖励!,", reward)
            Sendmsg9(actor, "00ff00", "全服首爆 ["..itemName .. "] 奖励已发放至邮箱!", 1)
        end
    end
end
