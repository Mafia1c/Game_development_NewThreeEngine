local ChangeJob = {}
ChangeJob.job_name = {"战士","法师","道士"}
-- ChangeJob.extra_skills = {
--     [0] = {66},
--     [1] = {58},
--     [2] = {55}
-- }
function ChangeJob:ClickJob(actor,job)
    job = tonumber(job)

    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state < 1 then
        return  Sendmsg9(actor, "ffffff", "你未开通 [盟重令]!", 1)
    end
    if querymoney(actor, 2) < 50000 then
        return  Sendmsg9(actor, "FF0000", "非绑定元宝不足50000！", 1)
    end

    local self_job =  getbaseinfo(actor,7)
   
    if job == tonumber(self_job) then
        return Sendmsg9(actor, "ffffff", "当前已经是"..self.job_name[job +1], 1) 
    end
    messagebox(actor,"您确定要转为【"..self.job_name[job +1].."】吗？","@chang_job_ok,"..job,"@chang_job_no")
end
function chang_job_ok(actor,job)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state < 1 then
        return  Sendmsg9(actor, "ffffff", "你未开通 [盟重令]!", 1)
    end
    if querymoney(actor, 2) < 50000 then
        return  Sendmsg9(actor, "FF0000", "非绑定元宝不足50000！", 1)
    end
    if not ChangeMoney(actor,2,"-",50000,"转职扣除",true) then
        return Sendmsg9(actor, "FF0000", "非绑定元宝扣除失败！", 1)
    end
    local player_name = getbaseinfo(actor,1)
    local str =  "恭喜:<「%s」/FCOLOR=250>成功转职<「%s」/FCOLOR=251>！"
    sendmsgnew(actor,255,0,string.format(str,player_name,ChangeJob.job_name[job +1]),1,1)
    local npc_class = IncludeNpcClass("ChangeJob")
    if npc_class then
        npc_class:ResetJob(actor)
    else
        return
    end

    job = tonumber(job)
    setbaseinfo(actor,7,job)
    delnojobskill(actor)
    LoginTrigger.loginAddSkills(actor)
    delaygoto(actor,1000,"change_job_quitgame,",0)
end

function ChangeJob:ResetJob(actor)
    local emqy_class = IncludeNpcClass("DemonContract")
    if emqy_class then
        emqy_class:ChangeJobReset(actor)
    end
    --清除天下第一数据
    local wordn1_npc_class = IncludeNpcClass("WorldN1Npc")
    if wordn1_npc_class then
        wordn1_npc_class:ChangeJobDeleteRank(actor)
    end
    --清除技能强化数据
    local skill_reinforce_class = IncludeNpcClass("SkillReinforce")
    if skill_reinforce_class then
        skill_reinforce_class:ChangeJobRsetData(actor)
    end
    delbuff(actor, 100002) 
    --清除职业觉醒数据
    local job_awake_class = IncludeNpcClass("JobAwake")
    if job_awake_class then
        job_awake_class:ChangeJobRsetData(actor)
    end
    --删除狂暴
    VarApi.setPlayerUIntVar(actor, VarUIntDef.RAMPAGE_STATE,0,true)
    deprivetitle(actor, "狂暴之力")
end

function change_job_quitgame(actor)
    openhyperlink(actor,34,0)
end
return ChangeJob