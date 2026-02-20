local SkillReinforceOBJ = {}
SkillReinforceOBJ.Name = "SkillReinforceOBJ"
SkillReinforceOBJ.NpcId = 70
SkillReinforceOBJ.reiniforce_cfg ={
	[0] = {["need_cfg"] = {"书页#10","元宝#200"},["attr_cfg"]={"生命：0%","双防：0%","技能威力：0%"}},
	[1] = {["need_cfg"] ={"书页#50","元宝#500"},["attr_cfg"]={"生命：2%","双防：2%","技能威力：2%"}},
	[2] = {["need_cfg"] ={"书页#100","元宝#800"},["attr_cfg"]={"生命：4%","双防：3%","技能威力：3%"}},
	[3] = {["need_cfg"] ={"书页#200","元宝#1200"},["attr_cfg"]={"生命：6%","双防：4%","技能威力：4%"}},
	[4] = {["need_cfg"] ={"书页#300","元宝#1600"},["attr_cfg"]={"生命：8%","双防：5%","技能威力：5%"}},
	[5] = {["need_cfg"] ={"书页#400","元宝#2000"},["attr_cfg"]={"生命：10%","双防：6%","技能威力：6%"}},
	[6] = {["need_cfg"] ={"书页#600","元宝#2500"},["attr_cfg"]={"生命：12%","双防：7%","技能威力：7%"}},
	[7] = {["need_cfg"] ={"书页#800","元宝#3000"},["attr_cfg"]={"生命：14%","双防：8%","技能威力：8%"}},
	[8] = {["need_cfg"] ={"书页#1000","元宝#5000"},["attr_cfg"]={"生命：16%","双防：9%","技能威力：9%"}},
	[9] = {["need_cfg"] ={"书页#0","元宝#0"},["attr_cfg"]={"生命：20%","双防：10%","技能威力：10%"}},
}

local temp_cfg = GetConfig("SkillReinforceCfg")
SkillReinforceOBJ.cfg = {}
for i,v in ipairs(temp_cfg) do
	SkillReinforceOBJ.cfg[v.job_index] = SkillReinforceOBJ.cfg[v.job_index] or {}
	table.insert(SkillReinforceOBJ.cfg[v.job_index],v) 
end

function SkillReinforceOBJ:main(level_table)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/SkillReinforceUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.select_one_index = tonumber(SL:Get_JOB()) 
    self.select_two_index = 1
    self.select_key_name = 0
  	GUI:addOnClickEvent(self.ui.close_btn, function()
        ViewMgr.close("SkillReinforceOBJ")
    end)
    GUI:addOnClickEvent(self.ui.reinforce_btn, function()
        SendMsgCallFunByNpc(SkillReinforceOBJ.NpcId,"SkillReinforce","ClickReinforce",self.select_key_name)
    end)
    GUI:addOnClickEvent(self.ui.tip_btn, function()
    	GUI:setVisible(self.ui.tip_box,true) 
    end)
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
    	GUI:setVisible(self.ui.tip_box,false) 
    end)
    GUI:addOnClickEvent(self.ui.tip_box, function()
    	GUI:setVisible(self.ui.tip_box,false) 
    end)
  	self.level_table = SL:JsonDecode(level_table) or {}
    for i=1,3 do
    	GUI:addOnClickEvent(self.ui["skill_"..i],function (sender)
    		local cfg = self.cfg[self.select_one_index][self.select_two_index]
    		if cfg then
	    		local worldPos = GUI:getWorldPosition(sender)
	    		worldPos.y = worldPos.y + 80
	    		worldPos.x = worldPos.x - 100
	    		local odds = string.split(cfg.trigger_odds,"#")  
	    		local active_level = string.split(cfg.active_level,"#")  
	    		local str = string.format("<%s/FCOLOR=251>\\<Lv%s触发几率:%s%%/FCOLOR=250>\\<技能强化%s重时激活/FCOLOR=251>\\",cfg.sign_name,i,odds[i],active_level[i])
	    		str = str ..cfg.sign_desc
	    		GUI:ShowWorldTips(str, worldPos, GUI:p(0,0))
    		end
    	end)
    end

    self:InitViewInfo()
end

function SkillReinforceOBJ:InitViewInfo()
	for i=1,3 do
		GUI:addOnClickEvent(self.ui["job_btn"..i],function ()
			self.select_one_index = i-1
			self:ClickJobBtn()
		end)
	end
	self:ClickJobBtn(self.select_one_index)
end

function SkillReinforceOBJ:ClickJobBtn()
	self.select_two_index= 1
	for i=1,3 do
		GUI:Button_loadTextureNormal(self.ui["job_btn"..i],self.select_one_index == i-1 and "res/custom/npc/ta0.png" or "res/custom/npc/ta1.png") 
	end
	local cfg = self.cfg[self.select_one_index]
	GUI:removeAllChildren(self.ui.skill_listview)
	self.ui = GUI:ui_delegate(self._parent)
	local red_check_list = {}
	for i,v in ipairs(cfg) do
		red_check_list["skill_page_"..i] =  RedPointMgr.GetRedDataByBtnName("SkillReinforceOBJ","skill_page_"..i)
		local img = GUI:Image_Create(self.ui.skill_listview,"skill_page_"..i,0,0,"res/custom/npc/z2.png")
		GUI:setTouchEnabled(img, true)
		GUI:addOnClickEvent(img,function ()
			self.select_two_index = i
			self:FlushRight()
		end)
		local text = GUI:Text_Create(img,"skill_page_name"..i,58,17,18,"#FFFF00",v.skill_name)
		GUI:setAnchorPoint(text,0.5,0.5)
	end
 	red_check_list.view_name = "SkillReinforceOBJ"
    red_check_list.node = self
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_check_list)
	self:FlushRight()
end

function SkillReinforceOBJ:FlushRight()
	for i,v in ipairs(self.cfg[self.select_one_index]) do
		if GUI:Win_IsNotNull(self.ui["skill_page_"..i]) then
			GUI:Image_loadTexture(self.ui["skill_page_"..i], i == self.select_two_index and "res/custom/npc/z1.png" or "res/custom/npc/z2.png")
		end
	end
	local cfg = self.cfg[self.select_one_index][self.select_two_index]
	self.select_key_name = cfg.key_name
	GUI:Image_loadTexture(self.ui.select_icon,string.format("res/custom/npc/08jnqh/icon/%s.png",cfg.skill_icon))
	GUI:Text_setString(self.ui.skill_name,cfg.skill_name)
	local level = self.level_table[cfg.key_name] or 0
	for i=1,3 do
		GUI:Button_loadTextureNormal(self.ui["skill_"..i],string.format("res/custom/npc/08jnqh/icon/%s_%s_%s.png",self.select_one_index,self.select_two_index,i-1))
		local active_level = string.split(cfg.active_level,"#")  
		GUI:Button_setGrey(self.ui["skill_"..i],level < tonumber(active_level[i]))
		GUI:Image_setGrey(self.ui["skill_level_"..i],level < tonumber(active_level[i]))
	end
	local reiniforce_cfg = self.reiniforce_cfg[level]
	for i=1,2 do
		local need_info = string.split(reiniforce_cfg.need_cfg[i],"#")
		local count = SL:Get_ITEM_COUNT(need_info[1])
		if i == 2 then
			count = tonumber(SL:Get_MONEY_ASSOCIATED(SL:GetMetaValue("ITEM_INDEX_BY_NAME", need_info[1]))) 
		end
		local color = count >= tonumber(need_info[2]) and 250 or 249
		ItemShow_updateItem(self.ui["ItemShow_"..i],{showCount = true,index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", need_info[1]),count=tonumber(need_info[2]) , look = true,bgVisible = true,color = color})
	end
	GUI:Button_setTitleText(self.ui.reinforce_btn,string.format("强化%s重",SL:NumberToChinese(level+1 > 9 and 9 or level +1)) ) 
	local cur_attr_cfg = self.reiniforce_cfg[level].attr_cfg
	local next_attr_cfg = cur_attr_cfg
	if self.reiniforce_cfg[level+1] ~= nil then
		next_attr_cfg = self.reiniforce_cfg[level+1].attr_cfg
	end
	for i=1,3 do
		GUI:Text_setString(self.ui["cur_attr"..i],cur_attr_cfg[i])
		GUI:Text_setString(self.ui["next_attr"..i],next_attr_cfg[i])
	end
end

function SkillReinforceOBJ:flushView(level_table)
	self.level_table = SL:JsonDecode(level_table) or {}
	self:FlushRight()
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "SkillReinforceOBJ",["node"] = self,["is_all"] = true})
end

function SkillReinforceOBJ:PageRed(index)
	if SkillReinforceOBJ.select_one_index  == nil then return false end
	index = tonumber(index)
	if index  == nil then return false end
	local cfg = SkillReinforceOBJ.cfg[SkillReinforceOBJ.select_one_index][index]
	if SL:Get_JOB() == cfg.job_index then
		if SL:Get_SKILL_LEVEL(cfg.skill_id) < 0  then
			return false 
		end
		local level = SkillReinforceOBJ.level_table[cfg.key_name] or 0
		if level >= 9 then return false end
		for i=1,2 do
			local need_info = string.split(SkillReinforceOBJ.reiniforce_cfg[level].need_cfg[i],"#")
			local count = SL:Get_ITEM_COUNT(need_info[1])
			if i == 2 then
				count = tonumber(SL:Get_MONEY_ASSOCIATED(SL:GetMetaValue("ITEM_INDEX_BY_NAME", need_info[1]))) 
			end
			if count < tonumber(need_info[2])  then
				return false
			end
		end
		return true
	end
	return false
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if SkillReinforceOBJ.NpcId == npc_info.index then
        SendMsgClickNpc(SkillReinforceOBJ.NpcId.."#SkillReinforce") 
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "SkillReinforceOBJ", onClickNpc)

return SkillReinforceOBJ