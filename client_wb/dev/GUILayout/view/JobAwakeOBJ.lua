local JobAwakeOBJ = {}
JobAwakeOBJ.Name = "JobAwakeOBJ"
JobAwakeOBJ.NpcId = 73
JobAwakeOBJ.cfg = GetConfig("JobAwakeCfg")
JobAwakeOBJ.cfg_map = {}
for i,v in ipairs(JobAwakeOBJ.cfg) do
	JobAwakeOBJ.cfg_map[v.job_index] = JobAwakeOBJ.cfg_map[v.job_index] or {}
	table.insert(JobAwakeOBJ.cfg_map[v.job_index],v)
end
local k__={
	["0_1"]={{},{},{},{},{}},
	["0_2"]={{},{},{},{},{}},
	["0_3"]={{},{},{},{},{}},
	["1_1"]={{},{},{},{},{}},
}

function JobAwakeOBJ:main(key_name)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/JobAwakeUI", function () end)
    self.ui = GUI:ui_delegate(parent)
   	self.awake_key_name = tonumber(key_name) or 0
	self.typeIndex=nil --#region 职业(1-3)
	self.job_index=nil --#region 小职业(1-3)
	self.skillIndex=nil --#region 技能(1-5)

	if self.awake_key_name > 0 then
		local str_tab = string.split(self.cfg[self.awake_key_name].job_index,"_")
		self.select_job_index = tonumber(str_tab[2])
	else
		self.select_job_index = 1
	end

    GUI:addOnClickEvent(self.ui.close_btn, function()
        ViewMgr.close("JobAwakeOBJ")
    end)
    
    for i=1,3 do
    	GUI:addOnClickEvent(self.ui["leftBtn"..i],function (  )
			if self.typeIndex==i then
				return
			end
    		self:selectType(i)
    	end)
		for j = 1, 3 do
			GUI:Button_loadTextures(self.ui["typeBtn"..i..j],"res/custom/npc/111zhibo/zyjx/job_"..(i-1).."_"..j.."_0.png","res/custom/npc/111zhibo/zyjx/job_"..(i-1).."_"..j.."_1.png","",0)
			GUI:addOnClickEvent(self.ui["typeBtn"..i..j],function ()
				if self.job_index==j then
					return
				end
				self:OnClickJobBtn(j)
			end)
		end
    end

    for i=1,5 do
    	GUI:addOnClickEvent(self.ui["awake_skill_btn"..i],function ()
			if self.skillIndex==i then
				return
			end
    		self:refreshSkillInfo(i)
    	end)
		GUI:addOnClickEvent(self.ui["awake_btn"..i],function ()
			local cfg = self.cfg_map[self.job.."_"..self.job_index]
			local _key_name = cfg[i].key_name
			SendMsgCallFunByNpc(JobAwakeOBJ.NpcId,"JobAwake","OnClickAwake",_key_name)	
		end)
    end

	self:selectType(SL:Get_JOB()+1)
end
function JobAwakeOBJ:selectType(typeIndex) --#region 选职业
	self.typeIndex=typeIndex
	self.job=typeIndex-1
	removeOBJ(self.ui.leftTag,self)
	for j = 1, 3 do
		GUI:setContentSize(self.ui["leftList"..j],153,typeIndex==j and 150 or 0)
		GUI:setVisible(self.ui["leftList"..j],typeIndex==j)
		if self.awake_key_name>0 then
			local star_key_name=self.cfg_map[self.job.."_"..j][1].key_name
			local end_key_name=self.cfg_map[self.job.."_"..j][5].key_name
			if self.awake_key_name>=star_key_name and self.awake_key_name<=end_key_name then
				GUI:Image_Create(self.ui["typeBtn"..typeIndex..j],"leftTag",0,0,"res/custom/tag/jihuo02.png")
			end
		end
	end
	GUI:ListView_setDirection(self.ui.leftBigList, 1)
	self:OnClickJobBtn(typeIndex==SL:Get_JOB()+1 and self.select_job_index or 1)
end
function JobAwakeOBJ:OnClickJobBtn(job_index) --#region 选小职业
	self.job_index=job_index
	local _cfg = self.cfg_map[self.job.."_"..job_index]

	for i=1,3 do
		GUI:Button_loadTextureNormal(self.ui["typeBtn"..(self.job+1)..i],"res/custom/npc/111zhibo/zyjx/job_"..self.job.."_"..i.."_0.png")
	end
	GUI:Button_loadTextureNormal(self.ui["typeBtn"..(self.job+1)..job_index],"res/custom/npc/111zhibo/zyjx/job_"..self.job.."_"..job_index.."_1.png")

	local star_key_name=self.cfg_map[self.job.."_"..self.select_job_index][1].key_name
	local end_key_name=self.cfg_map[self.job.."_"..self.select_job_index][5].key_name
	for i,v in ipairs(_cfg) do
		GUI:Button_loadTextureNormal(self.ui["awake_skill_btn"..i],string.format("res/custom/npc/111zhibo/job_info/icon_%s_%s%s.png",self.job,job_index,i))
		GUI:Button_setGrey(self.ui["awake_skill_btn"..i],true)
		local needCfg=_cfg[i]
		GUI:Text_setString(self.ui["needText"..i],needCfg.need_item.."："..needCfg.need_item_num)
		local color = SL:Get_ITEM_COUNT(needCfg.need_item) >= needCfg.need_item_num and "#00ff00" or "#ff0000"
		GUI:Text_setTextColor(self.ui["needText"..i],color)
		if self.awake_key_name==0 or job_index~=self.select_job_index then
			GUI:setVisible(self.ui["awake_btn"..i],true)
			GUI:setVisible(self.ui["has_awake"..i],false)
			GUI:setVisible(self.ui["skill_active_flag"..i],false)
		elseif self.awake_key_name>=star_key_name and self.awake_key_name<=end_key_name then
			if needCfg.key_name<=self.awake_key_name then
				GUI:setVisible(self.ui["awake_btn"..i],false)
				GUI:setVisible(self.ui["has_awake"..i],true)
				GUI:setVisible(self.ui["skill_active_flag"..i],true)
			else
				GUI:setVisible(self.ui["awake_btn"..i],true)
				GUI:setVisible(self.ui["has_awake"..i],false)
				GUI:setVisible(self.ui["skill_active_flag"..i],false)
			end
		else
			GUI:setVisible(self.ui["awake_btn"..i],true)
			GUI:setVisible(self.ui["has_awake"..i],false)
			GUI:setVisible(self.ui["skill_active_flag"..i],false)
		end
	end
	self:refreshSkillInfo(1)
end
function JobAwakeOBJ:refreshSkillInfo(skillIndex) --#region 选技能
	self.skillIndex=skillIndex
	local _cfg = self.cfg_map[self.job.."_"..self.job_index]

	GUI:Image_loadTexture(self.ui.job_name_img,string.format("res/custom/npc/11zzjx/%s/%s/z%s.png",self.job,self.job_index,self.skillIndex))
	GUI:Image_loadTexture(self.ui["infoImg"],"res/custom/npc/111zhibo/job_info/img_"..self.job.."_"..self.job_index..self.skillIndex..".png")
	for i,v in ipairs(_cfg) do
		GUI:Button_setGrey(self.ui["awake_skill_btn"..i],i ~= skillIndex)
	end
	removeOBJ(self.ui.skill_effect,self)
 	GUI:Effect_Create(self.ui.effect_root, "skill_effect",_cfg[skillIndex].eff_x,_cfg[skillIndex].eff_y, 0, _cfg[skillIndex].effect_id)
end

function JobAwakeOBJ:flushView(key_name)
	self.awake_key_name = tonumber(key_name) or 0
	if self.awake_key_name > 0 then
		local str_tab = string.split(self.cfg[self.awake_key_name].job_index,"_")
		self.select_job_index = tonumber(str_tab[2])
	else
		self.select_job_index = 1
	end
	local lastSkillIndex = self.skillIndex
	self:selectType(self.typeIndex)
	self:OnClickJobBtn(self.job_index)
	self:refreshSkillInfo(lastSkillIndex)
end

function JobAwakeOBJ:CheckBubble()
	local key = GameData.GetData("U_job_awake_key") or 0
	if key <= 0 then
		return true
	else
		local cfg = self.cfg[key]
		for i,v in ipairs(self.cfg_map[cfg.job_index] or {}) do
		 	if	v.key_name > key and SL:Get_ITEM_COUNT("书页") > v.need_item_num then
		 		return true
		 	end
		end 
	end
	return false
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if JobAwakeOBJ.NpcId == npc_info.index then
        SendMsgClickNpc(JobAwakeOBJ.NpcId.."#JobAwake") 
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "JobAwakeOBJ", onClickNpc)

return JobAwakeOBJ