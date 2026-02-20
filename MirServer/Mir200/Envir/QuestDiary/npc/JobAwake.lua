local JobAwake = {}
JobAwake.cfg = include("QuestDiary/config/JobAwakeCfg.lua")
function JobAwake:click(actor)
    local key_name = VarApi.getPlayerUIntVar(actor,"U_job_awake_key")
    lualib:ShowNpcUi(actor,"JobAwakeOBJ",key_name)

    TaskTrigger.CompleteTask(actor, 3)
end
function JobAwake:OnClickAwake(actor,key_name)
    key_name = tonumber(key_name)
    local cfg = self.cfg[key_name]
    if cfg == nil then
        return Sendmsg9(actor, "ffffff", "请选择觉醒技能！", 1)
    end
    local job = getbaseinfo(actor,7)
    local job_tab = strsplit(cfg.job_index,"_") 
    if tonumber(job_tab[1])  ~= job then
       return Sendmsg9(actor, "ffffff", "非法操作，非本职业觉醒！", 1)
    end
    local has_key_name = VarApi.getPlayerUIntVar(actor,"U_job_awake_key")
    local has_awalke_cfg = self.cfg[has_key_name]
    if has_awalke_cfg then
        if cfg.job_index ~= has_awalke_cfg.job_index then
           return Sendmsg9(actor, "ffffff", "非法操作，不可学习其他转职技能！", 1)
        end
    end
    if has_key_name >= key_name then
       return  Sendmsg9(actor, "ffffff", "当前技能已觉醒过", 1)
    end
    if has_key_name > 0 and  key_name - has_key_name > 1 then
        return  Sendmsg9(actor, "ffffff", "请按顺序觉醒", 1)
    end
    if has_key_name == 0 and cfg.skill_index ~= 1 then
        return Sendmsg9(actor, "ffffff", "请按顺序觉醒", 1)
    end
    if getbagitemcount(actor, cfg.need_item) < cfg.need_item_num then
        return  Sendmsg9(actor, "ffffff", cfg.need_item.."不足！", 1)
    end
    -- local level = getbaseinfo(actor,6)
    -- if level < cfg.need_level then
    --     return  Sendmsg9(actor, "ffffff", "等级不足！", 1)
    -- end

    local level = getbaseinfo(actor,39)
    if cfg.need_zs and  cfg.need_zs > 0 and level < cfg.need_zs then
        return  Sendmsg9(actor, "ffffff", "转生等级不足！", 1)
    end
    if cfg.need_item_num > 0 and not takeitem(actor,cfg.need_item,cfg.need_item_num,0,"职业觉醒扣除") then
        return  Sendmsg9(actor, "ffffff", cfg.need_item.."扣除失败！", 1)
    end
    local player_name = getbaseinfo(actor,1)
    local str =  "职业觉醒:<「%s」/FCOLOR=251>成功觉醒<「%s」/FCOLOR=241>！"
    sendmsgnew(actor,255,0,string.format(str,player_name,cfg.awake_name),1,1)
    addbuff(actor,cfg.buff_id)
    VarApi.setPlayerUIntVar(actor,"U_job_awake_key",key_name,true)
    lualib:FlushNpcUi(actor,"JobAwakeOBJ",key_name)
    self:FlushPlayerBtn(actor)
end
function JobAwake:ChangeJobRsetData(actor)
    local key_name = VarApi.getPlayerUIntVar(actor,"U_job_awake_key")
    if key_name <= 0 then
        return
    end
    local cfg = self.cfg[key_name]
    local list = {}

    for i,v in ipairs(JobAwake.cfg ) do
        if hasbuff(actor,v.buff_id) then
           delbuff(actor,v.buff_id) 
        end
        if v.job_index == cfg.job_index and v.key_name <= key_name then
            table.insert(list,v)
        end
    end

    local count = 0
    for i,v in ipairs(list) do
        count = count + v.need_item_num
    end
    VarApi.setPlayerUIntVar(actor,"U_change_job_flag",count)
    VarApi.setPlayerUIntVar(actor,"U_job_awake_key",0,true)
end
function JobAwake:FlushPlayerBtn(actor,targetActor,is_look)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    local key_name = VarApi.getPlayerUIntVar(actor,"U_job_awake_key")
    if targetActor then
        key_name = VarApi.getPlayerUIntVar(targetActor,"U_job_awake_key")
    end
    local cfg = JobAwake.cfg[key_name]
    if cfg == nil then
        if is_look then
            delbutton(actor, 3002, 20018)
        else
            delbutton(actor, 3, 10018)
        end
        return 
    end
 
    local role_str = [[<Img|a=0|x=220|y=15|img=custom/npc/11zzjx/3/%s.png|link=@open_player_jobawake>]]
    if is_look then
        role_str = [[<Img|a=0|x=220|y=15|img=custom/npc/11zzjx/3/%s.png>]]
    end
    if is_pc then
        role_str = [[<Img|a=0|x=180|y=10|img=custom/npc/11zzjx/3/%s.png|link=@open_player_jobawake>]]
        if is_look then
            role_str = [[<Img|a=0|x=220|y=15|img=custom/npc/11zzjx/3/%s.png>]]
        end
    end
    addbutton(actor, is_look and 3002  or 3, is_look and 20018 or  10018, string.format(role_str,cfg.job_index) )
end
function open_player_jobawake(actor)
    JobAwake:click(actor)
end
return JobAwake