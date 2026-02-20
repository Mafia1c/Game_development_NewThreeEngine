local JobTitleUpgrade = {}
JobTitleUpgrade.cfg = include("QuestDiary/config/JobTitleUpgradeCfg.lua")
JobTitleUpgrade.great_cfg = include("QuestDiary/config/JobGreatTitleUpgradeCfg.lua")
JobTitleUpgrade.cfg_map = {}
for i,v in ipairs(JobTitleUpgrade.cfg) do
	JobTitleUpgrade.cfg_map[v.npc_id] = JobTitleUpgrade.cfg_map[v.npc_id] or {}
	table.insert(JobTitleUpgrade.cfg_map[v.npc_id],v)
end
function JobTitleUpgrade:click(actor,npcid)
    local juewei = VarApi.getPlayerUIntVar(actor,"U_job_title")
    if juewei < 11 then
        lualib:ShowNpcUi(actor,"JobTitleUpgradeOBJ",juewei.."#"..npcid)
    else
        local grade_level = VarApi.getPlayerUIntVar(actor,"U_job_great_title_level")
        lualib:ShowNpcUi(actor,"JobGreatTitleUpgradeOBJ",juewei.."#"..grade_level)
    end
    TaskTrigger.CompleteTask(actor, 10)
end
function JobTitleUpgrade:UpgradeClick(actor,npc_id)
    npc_id = tonumber(npc_id) 
    if npc_id == nil then 
        Sendmsg9(actor, "ffffff", "官职晋升异常!", 1)
        return 
    end
    local cfg = JobTitleUpgrade.cfg_map[npc_id]
    if cfg == nil then 
        Sendmsg9(actor, "ffffff", "官职晋升异常,未知npc!"..npc_id, 1)
        return 
    end

    local map_indx = VarApi.getPlayerUIntVar(actor,"U_bigMap")
    if npc_id == 88 and  map_indx < 2 then
        return Sendmsg9(actor, "ffffff", "进入白日门后可晋升!", 1)
    end
    
    if npc_id == 126 and  map_indx < 3 then
        return Sendmsg9(actor, "ffffff", "今日封魔谷后可晋升!", 1)
    end

    local juewei = VarApi.getPlayerUIntVar(actor,"U_job_title")
    local map_id = getbaseinfo(actor,3)
    if juewei >= cfg[#cfg].key_name then
       return Sendmsg9(actor, "ffffff", "当前已满级!", 1)
    end
    if map_id == "bairi" and juewei < 10 then
        return Sendmsg9(actor, "ffffff", "请先完成上一大陆的晋升!", 1)
    elseif map_id == "4" and juewei < 11 then
        return Sendmsg9(actor, "ffffff", "请先完成上一大陆的晋升!", 1)
    end
    local upgrade_cfg = self.cfg[juewei + 1]
    for i = 1, 2 do
        local item_name =upgrade_cfg["need_name"..i]
        local count = querymoney(actor,getstditeminfo(item_name,0)) 
        if i == 2 then
            count = getbindmoney(actor,item_name)
        end
        if count < upgrade_cfg["need_num"..i] then
           return Sendmsg9(actor, "ffffff", upgrade_cfg["need_name"..i].."不足!", 1)
        end
    end
    for i = 1, 2 do
        local item_name =upgrade_cfg["need_name"..i]
        local count = upgrade_cfg["need_num"..i]
        if i == 1 then
            if not ChangeMoney(actor,getstditeminfo(item_name,0),"-",count,"官职晋升扣除") then
                return Sendmsg9(actor, "ff0000", "货币" .. item_name .. "扣除失败！", 1)
            end
        else
            if not consumebindmoney(actor,item_name,count,"官职晋升扣除") then
                return Sendmsg9(actor, "ff0000", "货币" .. item_name .. "扣除失败！", 1)
            end
        end
    end
    if upgrade_cfg.give_item then
        delbodyitem(actor,15,"官职晋升扣除")
        GiveOnItem(actor,15,upgrade_cfg.give_item,1,65536,"官职晋升")
    end
    if self.cfg[juewei] then
        deprivetitle(actor,self.cfg[juewei].juewei_name)
    end
    confertitle(actor,upgrade_cfg.juewei_name,1)
    VarApi.setPlayerUIntVar(actor,"U_job_title",juewei + 1,true)
    local player_name = getbaseinfo(actor,1)
    local str =  "官职晋升:<「%s」/FCOLOR=251>成功晋升<「%s」/FCOLOR=251>属性暴涨！"
    sendmsgnew(actor,255,0,string.format(str,player_name,upgrade_cfg.juewei_name),1,1)
    lualib:FlushNpcUi(actor,"JobTitleUpgradeOBJ",juewei + 1)
end
--大帝
function JobTitleUpgrade:UpgradeGreatClick(actor)
    if CheckOpenState(actor, 2) then return end
    local juewei = VarApi.getPlayerUIntVar(actor,"U_job_title")
    if juewei >= 12 then
        return Sendmsg9(actor, "ffffff", "当前已满级!", 1)  
    end
    if juewei < 11 then
        return Sendmsg9(actor, "ffffff", "请先完成上一大陆的晋升!", 1)
    end
    local great_level = VarApi.getPlayerUIntVar(actor,"U_job_great_title_level",true)
    if great_level >= 10 then
        return Sendmsg9(actor, "ffffff", "当前已满级!", 1)
    end
     
    local great_cfg = self.great_cfg[great_level] 
    for i = 1, 2 do
        local item_name =great_cfg["need_name"..i]
        local stdmode =  getstditeminfo(item_name,2)
        local count = 0
        if stdmode == 41 then
            count =  querymoney(actor,getstditeminfo(item_name,0))
        else
            count = getbagitemcount(actor,item_name )
        end
        if count < great_cfg["need_num"..i] then
           return Sendmsg9(actor, "ffffff", great_cfg["need_name"..i].."不足!", 1)
        end
    end
    for i = 1, 2 do
        local item_name =great_cfg["need_name"..i]
        local count = great_cfg["need_num"..i]
        local stdmode =  getstditeminfo(item_name,2)
        if stdmode == 41 then
            if not ChangeMoney(actor,getstditeminfo(item_name,0),"-",count,"官职晋升扣除") then
                return Sendmsg9(actor, "ff0000", "货币" .. item_name .. "扣除失败！", 1)
            end
        else
            if not takeitem(actor,item_name,count,0,"官职晋升大帝扣除") then
                return Sendmsg9(actor, "ffffff", item_name.."扣除失败!", 1)
            end
        end
    end
    if great_level == 9 then --突破
        deprivetitle(actor,"神皇9阶")
        confertitle(actor,"大帝",1)
        juewei = juewei + 1
        VarApi.setPlayerUIntVar(actor,"U_job_title",juewei,true)
        delbodyitem(actor,15,"官职晋升扣除")
        GiveOnItem(actor,15,"天运玫瑰·九转梵音",1,65536,"官职晋升")
        local player_name = getbaseinfo(actor,1)
        local str =  "官职晋升:<「%s」/FCOLOR=251>成功晋升<「大帝」/FCOLOR=251>属性暴涨！"
        sendmsgnew(actor,255,0,string.format(str,player_name),1,1)
    else
        if great_cfg then
            deprivetitle(actor,"神皇")
            deprivetitle(actor,great_cfg.givech)
        end
        local up_great_cfg = self.great_cfg[great_level+1] 
        confertitle(actor,up_great_cfg.givech,1)
    end
    VarApi.setPlayerUIntVar(actor,"U_job_great_title_level",great_level + 1,true)
    lualib:FlushNpcUi(actor,"JobGreatTitleUpgradeOBJ",juewei.."#"..great_level + 1)
end
return JobTitleUpgrade