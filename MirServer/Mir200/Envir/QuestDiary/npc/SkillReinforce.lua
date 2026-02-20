local SkillReinforce = {}
SkillReinforce.cfg = include("QuestDiary/config/SkillReinforceCfg.lua")
SkillReinforce.reiniforce_cfg ={
	[0] = {["need_cfg"] = {"书页#10","元宝#200"}},
	[1] = {["need_cfg"] ={"书页#50","元宝#500"},["attr_cfg"]={[30]=2,[36]=200,[37]=200},["skill_power"]=2},
	[2] = {["need_cfg"] ={"书页#100","元宝#800"},["attr_cfg"]={[30]=4,[36]=300,[37]=300},["skill_power"]=3},
	[3] = {["need_cfg"] ={"书页#200","元宝#1200"},["attr_cfg"]={[30]=6,[36]=400,[37]=400},["skill_power"]=4} ,
	[4] = {["need_cfg"] ={"书页#300","元宝#1600"},["attr_cfg"]={[30]=8,[36]=500,[37]=500},["skill_power"]=5} ,
	[5] = {["need_cfg"] ={"书页#400","元宝#2000"},["attr_cfg"]={[30]=10,[36]=600,[37]=600},["skill_power"]=6},
	[6] = {["need_cfg"] ={"书页#600","元宝#2500"},["attr_cfg"]={[30]=12,[36]=700,[37]=700},["skill_power"]=7},
	[7] = {["need_cfg"] ={"书页#800","元宝#3000"},["attr_cfg"]={[30]=14,[36]=800,[37]=800},["skill_power"]=8},
	[8] = {["need_cfg"] ={"书页#1000","元宝#5000"},["attr_cfg"]={[30]=16,[36]=900,[37]=900},["skill_power"]=9},
	[9] = {["need_cfg"] ={"书页#0","元宝#0"},["attr_cfg"]={[30]=20,[36]=1000,[37]=1000},["skill_power"]=10},
}
SkillReinforce.reset_cfg ={10,50,100,200,300,400,600,800,1000}
SkillReinforce.effect_cfg ={
	[12] = {"3#40010","6#40011","9#40012"},
    [26] = {"3#40020","6#40021","9#40022"},
    [66] = {"3#40030","6#40031","9#40032"},
    [56] = {"3#40040","6#40041","9#40042"},
    [22] = {"3#41100#41101","6#41110#41111","9#41120#41121"},
    [31] = {"3#41200#110","6#41210#111","9#41220#112"},
    [45] = {"3#41300","6#41310","9#41320"},
    [58] = {"3#41400","6#41410","9#41420"},
    [6] =  {"3#42100","6#42110","9#42120"},
    [13] =  {"3#42200","6#42210","9#42220"},
    [30] =  {"3#42300","6#42310","9#42320"},
    [52] =  {"3#42400","6#42410","9#42420"},
}
SkillReinforce.job_name = {[0] = "战士",[1]="法师",[2]="道士"}
function SkillReinforce:click(actor)
    local tmp_tab = {}
    for i = 1, 12 do
        local value = VarApi.getPlayerUIntVar(actor, "U_skill_reinforce_"..i)
        tmp_tab[i] = value
    end
    lualib:ShowNpcUi(actor,"SkillReinforceOBJ",tbl2json(tmp_tab))
    TaskTrigger.CompleteTask(actor, 15)
end
function SkillReinforce:ClickReinforce(actor,key_name)
    key_name = tonumber(key_name)
    local cfg = self.cfg[key_name]
    if cfg == nil then
        return Sendmsg9(actor, "ffffff", "请先选中技能！", 1)
    end
    local job = getbaseinfo(actor,7)
    
    if cfg.job_index ~= tonumber(job) then
        return  Sendmsg9(actor, "ffffff", string.format("您的职业为%s，只能强化%s技能！",self.job_name[tonumber(job)],self.job_name[tonumber(job)]), 1)
    end
    if getskillinfo(actor,cfg.skill_id,1) == nil then
        return Sendmsg9(actor, "ffffff", "你还没有学习"..getskillname(cfg.skill_id).."技能", 1)
    end
    local level =  VarApi.getPlayerUIntVar(actor, "U_skill_reinforce_"..key_name)
    if level >= 9 then
        return Sendmsg9(actor, "ffffff", cfg.skill_name.."强化已满级", 1)
    end
    local reiniforce_cfg = self.reiniforce_cfg[level]
    for i,v in ipairs(reiniforce_cfg.need_cfg) do
        local need_info = strsplit(v,"#")
        local stdmode =  getstditeminfo(need_info[1],2)
        local need_count = tonumber(need_info[2])
        local count = 0
        if stdmode == 41 then
            count = getbindmoney(actor,need_info[1])
        else
            count = getbagitemcount(actor,need_info[1] )
        end
        if count < need_count then
           return Sendmsg9(actor, "ffffff", need_info[1].."不足！", 1)
        end
    end

    for i,v in ipairs(reiniforce_cfg.need_cfg) do
        local need_info = strsplit(v,"#")
        local item_name = need_info[1]
        local stdmode =  getstditeminfo(item_name,2)
        local need_count = tonumber(need_info[2])
        if stdmode == 41 then
            if not consumebindmoney(actor,item_name,need_count,"技能强化扣除") then
                return Sendmsg9(actor, "ff0000", "货币" .. item_name .. "扣除失败！", 1)
            end
        else
            if not takeitem(actor,item_name,need_count,0,"技能强化扣除") then
                return Sendmsg9(actor, "ffffff", item_name.."扣除失败!", 1)
            end
        end
    end
    setskillinfo(actor, cfg.skill_id, 2, level+1)
    local skill_name = getskillname(cfg.skill_id)

    -- setmagicpower(actor, skill_name, reiniforce_cfg.skill_power, 1)
    VarApi.setPlayerUIntVar(actor, "U_skill_reinforce_"..key_name,level+1,true)
    local tmp_tab = {}
    for i = 1, 12 do
        local value = VarApi.getPlayerUIntVar(actor, "U_skill_reinforce_"..i)
        tmp_tab[i] = value
    end
    local effect_id = nil
    local effect2_id = nil
    for i, v in ipairs(SkillReinforce.effect_cfg[cfg.skill_id]) do
        local str_tab = strsplit(v,"#")
        if level+1 >= tonumber(str_tab[1]) then
            effect_id = tonumber(str_tab[2]) or nil 
            effect2_id = tonumber(str_tab[3])  or nil
        end
    end 
    if effect_id  or effect2_id  then
        
       setmagicskillefft(actor, skill_name,effect_id, effect2_id) 
    end
    Sendmsg9(actor, "ffffff", cfg.skill_name .."强化成功!", 1)
    lualib:FlushNpcUi(actor,"SkillReinforceOBJ",tbl2json(tmp_tab))
    delbuff(actor,100002)
    addbuff(actor,100002,0,1,actor,self:GetAllAttr(actor))
end
function SkillReinforce:FlushSkillEffect(actor)
    for k, v in pairs(self.effect_cfg) do
        local effect_id = nil
        local effect2_id = nil
        local level = getskillinfo(actor, k, 2)
        if level  and level > 0 then
            -- local reiniforce_cfg = self.reiniforce_cfg[level]
            -- local skill_name = getskillname(k)
            -- setmagicpower(actor, skill_name, reiniforce_cfg.skill_power, 1)
            for s,effect_info in ipairs(v) do
                local str_tab = strsplit(effect_info,"#")
                if level >= tonumber(str_tab[1]) then
                    effect_id = tonumber(str_tab[2]) or nil
                    effect2_id = tonumber(str_tab[3])  or nil
                end
            end
        end
        if effect_id  or effect2_id  then
           setmagicskillefft(actor, getskillname(k),effect_id, effect2_id) 
        end
    end
end
function SkillReinforce:GetAllAttr(actor)
    local list = {[30]=0,[36]=0,[37]=0}
    for i = 1, 12 do
        local value = VarApi.getPlayerUIntVar(actor, "U_skill_reinforce_"..i)
        if value > 0 then
            local cfg = self.reiniforce_cfg[value].attr_cfg
            for k, v in pairs(cfg) do
                list[k] = list[k] + v
            end
        end
    end
    return list
end
function SkillReinforce:ChangeJobRsetData(actor)
    local count = 0 
    for i = 1, 12 do
        local level = VarApi.getPlayerUIntVar(actor, "U_skill_reinforce_"..i) 
        if level > 0 then
            for index = 1, 9 do
                if index <= level then
                    count = count + SkillReinforce.reset_cfg[index]
                end
            end
        end
        VarApi.setPlayerUIntVar(actor, "U_skill_reinforce_"..i,0,true) 
    end
    VarApi.setPlayerUIntVar(actor,"U_change_job_flag2",count)
end
return SkillReinforce