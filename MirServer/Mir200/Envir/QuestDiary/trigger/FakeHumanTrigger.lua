FakeHumanTrigger = {} --#region 假人触发
FakeHumanTrigger.equipCfg=include("QuestDiary/config/FakerEquipCfg.lua")

function FakeHumanTrigger.clearAllFake()
    kickdummy()
end
function FakeHumanTrigger.fakeLogin(actor)
    local num=GetSysInt("G_fakeNumber")
    local job=getbaseinfo(actor,7)
    local sex=getbaseinfo(actor,8)
    local time=GlobalTimer.server_run_time
    if time<180 then
        changelevel(actor,"=",math.random(41,42))
    elseif time<300 then
        changelevel(actor,"=",math.random(42,45))
    else
        changelevel(actor,"=",math.random(55,56))
    end
    for position, value in pairs(FakeHumanTrigger.equipCfg) do
        local tag=value["equip_arr"..job..sex] or value["equip_arr"..job.."0"] or ""
        if tag~="" then
            local itemName=tag[math.random(#tag)]
            if num<10 then
                itemName=tag[1]
            end
            GiveOnItem(actor,position,itemName,1,0,"假人装备")
        end
    end
    mapmove(actor,"3",322,330,6)
    SetSysInt("G_fakeNumber",num+1,2)
end

