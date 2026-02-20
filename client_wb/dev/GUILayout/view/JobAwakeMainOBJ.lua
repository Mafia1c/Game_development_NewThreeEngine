local JobAwakeMainOBJ = {}
JobAwakeMainOBJ.Name = "JobAwakeMainOBJ"
JobAwakeMainOBJ.NpcId = 0
JobAwakeMainOBJ.cfg = GetConfig("JobAwakeCfg")
JobAwakeMainOBJ.cfg_map = {}
for i,v in ipairs(JobAwakeMainOBJ.cfg) do
	JobAwakeMainOBJ.cfg_map[v.job_index] = JobAwakeMainOBJ.cfg_map[v.job_index] or {}
	table.insert(JobAwakeMainOBJ.cfg_map[v.job_index],v)
end
local k__={
	["0_1"]={{},{},{},{},{}},
	["0_2"]={{},{},{},{},{}},
	["0_3"]={{},{},{},{},{}},
	["1_1"]={{},{},{},{},{}},
}

function JobAwakeMainOBJ:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/JobAwakeMainUI", function () end)
    self.ui = GUI:ui_delegate(parent)
	self.leftIndex=nil --#region 小职业(1-9)
	self.typeIndex=nil --#region 职业(0-2)
	self.skillIndex=nil --#region 技能(1-5)

	JobAwakeMainOBJ:initBtn()
	JobAwakeMainOBJ:OnClickJobBtn(1)
end
function JobAwakeMainOBJ:initBtn()
	GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("JobAwakeMainOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("JobAwakeMainOBJ")
    end)
	GUI:removeAllChildren(self.ui.leftBigList)
	self.ui = GUI:ui_delegate(self._parent)
	local time=0
	for i = 1, 9 do
		local typeIndex=nil
		if i<=3 then
			typeIndex=0
		elseif i<=6 then
			typeIndex=1
		elseif i<=9 then
			typeIndex=2
		end
		local btn=GUI:Button_Create(self.ui.leftBigList,"leftBtn"..i,0,0,"res/custom/npc/115job/btn"..typeIndex..((i-1)%3+1).."1.png")
		GUI:Button_loadTextures(btn,"res/custom/npc/115job/btn"..typeIndex..((i-1)%3+1).."1.png","res/custom/npc/115job/btn"..typeIndex..((i-1)%3+1).."2.png","",0)
		GUI:addOnClickEvent(btn,function ()
			if self.leftIndex==i then
				return
			end
			self:OnClickJobBtn(i)
		end)

		GUI:setVisible(btn,false)
        time = time +0.05
        GUI:runAction(btn,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(btn,true)
            GUI:setPositionX(btn,-120)
            GUI:runAction(btn,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(btn))))
        end)))
	end
	for i=1,5 do
    	GUI:addOnClickEvent(self.ui["skillBtn"..i],function ()
			if self.skillIndex==i then
				return
			end
    		self:refreshSkillInfo(i)
    	end)
    end
end
function JobAwakeMainOBJ:OnClickJobBtn(leftIndex) --#region 选小职业
	self.leftIndex=leftIndex
	self.typeIndex=nil --#region 职业
	if leftIndex<=3 then
		self.typeIndex=0
	elseif leftIndex<=6 then
		self.typeIndex=1
	elseif leftIndex<=9 then
		self.typeIndex=2
	end

	for i = 1, 9 do
		local _typeIndex=nil --#region 职业
		if i<=3 then
			_typeIndex=0
		elseif i<=6 then
			_typeIndex=1
		elseif i<=9 then
			_typeIndex=2
		end
		if i~=leftIndex then
			GUI:Button_loadTextureNormal(self.ui["leftBtn"..i],"res/custom/npc/115job/btn".._typeIndex..((i-1)%3+1).."1.png")
		end
	end
	GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/115job/btn"..self.typeIndex..((leftIndex-1)%3+1).."2.png")
	for i = 1, 5 do
		GUI:Button_loadTextures(self.ui["skillBtn"..i],"res/custom/npc/115job//icon_"..self.typeIndex.."_"..((leftIndex-1)%3+1)..i..".png","","",0)
	end
	self:refreshSkillInfo(1)
end
function JobAwakeMainOBJ:refreshSkillInfo(skillIndex) --#region 选技能
	self.skillIndex=skillIndex
	local _cfg = self.cfg_map[self.typeIndex.."_"..((self.leftIndex-1)%3+1)]
	for i = 1, 5 do
		GUI:Button_setGrey(self.ui["skillBtn"..i],true)
	end
	GUI:Button_setGrey(self.ui["skillBtn"..skillIndex],false)
	GUI:Image_loadTexture(self.ui.job_name_img,"res/custom/npc/11zzjx/"..self.typeIndex.."/"..((self.leftIndex-1)%3+1).."/z"..skillIndex..".png")
	GUI:Image_loadTexture(self.ui["infoImg"],"res/custom/npc/111zhibo/job_info/img_"..self.typeIndex.."_"..((self.leftIndex-1)%3+1)..skillIndex..".png")
	local ani_index = 2
 	if self.typeIndex == 0 then
 		role_effect_id = 3
 	elseif self.typeIndex == 1 then
 		role_effect_id = 4
 		ani_index = 3
 	else
 		ani_index = 3
 		role_effect_id = 5
 	end
 	local skill_x,skill_y=250,100
 	if  _cfg[skillIndex].is_self_eff == 1 then
		skill_x,skill_y=50,100
 	end
 	
	removeOBJ(self.ui.skill_effect,self)
 	if _cfg[skillIndex].is_self_eff == 1 then
 		GUI:Effect_Create(self.ui.effect_root, "skill_effect",skill_x,skill_y, 0, _cfg[skillIndex].effect_id)
 	end

	removeOBJ(self.ui.role_effect,self)
 	GUI:Effect_Create(self.ui.effect_root, "role_effect",50,100, 4, role_effect_id,0,ani_index,2)

 	removeOBJ(self.ui.mon_effect,self)
 	GUI:Effect_Create(self.ui.effect_root, "mon_effect",250,100, 2, 10311,0,0,6)
 	if _cfg[skillIndex].is_self_eff ~= 1 then
 		GUI:Effect_Create(self.ui.effect_root, "skill_effect",skill_x,skill_y, 0, _cfg[skillIndex].effect_id)
 	end
end

function JobAwakeMainOBJ:flushView()

end

return JobAwakeMainOBJ