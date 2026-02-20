BaByTrigger = {}
local DisguiseCfg = include("QuestDiary/config/DisguiseCfg.lua")
--角色获得宝宝触发
function BaByTrigger.slavebb(actor, mon)
    local bb_name = getbaseinfo(mon, 1) or ""
    if mon and isnotnull(mon) and (string.find(bb_name, "白虎") or string.find(bb_name, "神兽") or string.find(bb_name, "月灵")) then
        -- --道士 四象归一
        if actor and isnotnull(actor) and hasbuff(actor,60085) then
            playeffect(actor,13434,0,0,1,1,0)
        end
        
        delaymsggoto(actor, 1000, "@set_baby_attr,"..mon)
    end
end
function set_baby_attr(actor, mon)
    if not isnotnull(mon) then
        return
    end
    local bb_name = getbaseinfo(mon, 1) or ""
    local attr_fy1 = getbaseinfo(actor, 15) + getbaseinfo(mon, 15)
    local attr_fy2 = getbaseinfo(actor, 16) + getbaseinfo(mon, 16)
    local attr_fy3 = getbaseinfo(actor, 17) + getbaseinfo(mon, 17)
    local attr_fy4 = getbaseinfo(actor, 18) + getbaseinfo(mon, 18)
    -- local attr_fy5 = getbaseinfo(actor, 23) + getbaseinfo(mon, 19)
    -- local attr_fy6 = getbaseinfo(actor, 24) + getbaseinfo(mon, 20)

    setbaseinfo(mon, 15, attr_fy1)
    setbaseinfo(mon, 16, attr_fy2)
    setbaseinfo(mon, 17, attr_fy3)
    setbaseinfo(mon, 18, attr_fy4)
    -- setbaseinfo(mon, 19, attr_fy5)
    -- setbaseinfo(mon, 20, attr_fy6)

    local attr_fy7 = getbaseinfo(actor, 10)
    setbaseinfo(mon, 10, attr_fy7 + getbaseinfo(mon, 10))
    setbaseinfo(mon, 9, attr_fy7 + getbaseinfo(mon, 10))
    changeslaveattackhumpowerrate(actor, bb_name, 20)
end