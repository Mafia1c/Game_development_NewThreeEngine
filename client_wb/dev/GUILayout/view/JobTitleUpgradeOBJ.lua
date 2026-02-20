local JobTitleUpgradeOBJ = {}
JobTitleUpgradeOBJ.Name = "JobTitleUpgradeOBJ"
JobTitleUpgradeOBJ.cfg  = GetConfig("JobTitleUpgradeCfg")
JobTitleUpgradeOBJ.cfg_map = {}
for i,v in ipairs(JobTitleUpgradeOBJ.cfg) do
	JobTitleUpgradeOBJ.cfg_map[v.npc_id] = JobTitleUpgradeOBJ.cfg_map[v.npc_id] or {}
	table.insert(JobTitleUpgradeOBJ.cfg_map[v.npc_id],v)
end
function JobTitleUpgradeOBJ:main(juewei_index,npcid)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/JobTitleUpgradeUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.juewei_index = tonumber(juewei_index) or 0
    self.select_index = self.juewei_index + 1 
    self.npc_id = tonumber(npcid)
  	GUI:addOnClickEvent(self.ui.close_btn, function()
        ViewMgr.close("JobTitleUpgradeOBJ")
    end)

    GUI:addOnClickEvent(self.ui.upgrade_btn,function ()
    	SendMsgCallFunByNpc(0,"JobTitleUpgrade","UpgradeClick",self.npc_id)
    end)

    self:InitViewInfo()
end
function JobTitleUpgradeOBJ:InitViewInfo()
	-- local cur_map_id = SL:Get_MAP_ID()
	local cfg = self.cfg_map[self.npc_id]
	for i,v in ipairs(cfg) do
		local img_name = v.key_name == self.select_index and "res/custom/npc/ta0.png" or "res/custom/npc/ta1.png"
		local img = GUI:Image_Create(self.ui.juewei_listview,"juewei_img"..v.key_name,0,0,img_name)
		GUI:setTouchEnabled(img,true)
		GUI:addOnClickEvent(img,function ()
			self.select_index = v.key_name 
			if self.select_index - 1 > self.juewei_index then
				return SL:ShowSystemTips(string.format("请先完成%s爵位的晋升!",self.cfg[self.select_index-1].juewei_name))
			end
			self:UpdateRightInfo()
		end)
		local text = GUI:Text_Create(img, "juewei_text"..v.key_name, 39,10, 18, "#ffffff", v.juewei_name)
		GUI:Text_enableOutline(text,"#000000", 2)
	end
    local feature= {}
    feature.clothID =  SL:Get_EQUIP_DATA(0) and SL:Get_EQUIP_DATA(0).Looks or nil
    feature.weaponID = SL:Get_EQUIP_DATA(1) and SL:Get_EQUIP_DATA(1).Looks or nil-- 武器id
    feature.weaponEffectID =SL:Get_EQUIP_DATA(1) and SL:Get_EQUIP_DATA(1).sEffect or nil
    feature.clothEffectID = SL:Get_EQUIP_DATA(0) and SL:Get_EQUIP_DATA(0).sEffect or nil
    feature.showNodeModel = true  
    feature.showHair = false       
    local sex = SL:GetMetaValue("SEX")
    local job = SL:GetMetaValue("JOB")
    local UIModel = GUI:UIModel_Create(self.ui.model_box, "UIMODEL", 183, 140, sex, feature, nil, true, job)
	self:UpdateRightInfo()
end

function JobTitleUpgradeOBJ:UpdateRightInfo()
	-- local cur_map_id = SL:Get_MAP_ID()
	local cfg_map = self.cfg_map[self.npc_id]
	local attr_list = {}
	local juewei_index = self.select_index - 1
	local is_max = juewei_index >= cfg_map[#cfg_map].key_name
	GUI:setVisible(self.ui.max_img,is_max)
	GUI:setVisible(self.ui.need_item1,not is_max)
	GUI:setVisible(self.ui.need_item2,not is_max)
	GUI:setVisible(self.ui.upgrade_btn,not is_max and self.select_index  > self.juewei_index)

	for i,v in ipairs(cfg_map) do
		local img_name = v.key_name == self.select_index and "res/custom/npc/ta0.png" or "res/custom/npc/ta1.png"
		GUI:Image_loadTexture(self.ui["juewei_img"..v.key_name], img_name)
	end

	if is_max then
		juewei_index = cfg_map[#cfg_map].key_name
	end
	if juewei_index == 0 then
		attr_list[1] = "0%"
		attr_list[2] = "0%"
		attr_list[3] = "0%"
	else 
		for i=1,3 do
			table.insert(attr_list,self.cfg[juewei_index]["attr"..i])
		end
	end
	for i=1,3 do
		GUI:Text_setString(self.ui["cur_attr"..i],attr_list[i])
		GUI:Text_setString(self.ui["next_attr"..i],self.cfg[juewei_index+1]["attr"..i])
	end
	local upgrade_cfg = self.cfg[juewei_index+1]
	if self.ui.title_eff then
		removeOBJ(self.ui.title_eff,self)
	end

	GUI:Effect_Create(self.ui.FrameLayout, "title_eff", 370, 400, 0, upgrade_cfg.title_effect_id, 0, 0, 3, 1)
	if self.ui.rich_award then
		removeOBJ(self.ui.rich_award,self)
	end
	if self.ui.award_item then
		removeOBJ(self.ui.award_item,self)
	end
	if upgrade_cfg.give_item then
		local str =  "<font color='#ffffff'>晋升</font><font color='#ffff00'>[%s]</font><font color='#ffffff'> 奖励 →</font>"
		GUI:RichText_Create(self.ui.FrameLayout, "rich_award", 258, 69, string.format(str,upgrade_cfg.juewei_name), 200, 16, "#FFFFFF")
		GUI:ItemShow_Create(self.ui.FrameLayout, "award_item",407, 49, {index =  SL:GetMetaValue("ITEM_INDEX_BY_NAME",upgrade_cfg.give_item),count = 1,look=true,bgVisible=true,color =250})
	else
		local str =  "<font color='#ffffff'>晋升</font><font color='#ffff00'>[男爵]</font><font color='#ffffff'> 奖励 →</font>"
		GUI:RichText_Create(self.ui.FrameLayout, "rich_award", 258, 69, str, 200, 16, "#FFFFFF")
		GUI:ItemShow_Create(self.ui.FrameLayout, "award_item",407, 49, {index =  SL:GetMetaValue("ITEM_INDEX_BY_NAME","天运玫瑰·玉魄"),count = 1,look=true,bgVisible=true,color =250})
	end
	if not is_max then
		for i=1,2 do
			local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", upgrade_cfg["need_name"..i])
        	local count = SL:GetMetaValue("ITEM_COUNT", item_id)
			if i == 2 then
				count = tonumber(SL:Get_MONEY_ASSOCIATED(item_id)) 
			end
			local color =  count >= upgrade_cfg["need_num"..i] and 250 or 249
			ItemShow_updateItem(self.ui["need_item"..i],{showCount = true,index = item_id,count = upgrade_cfg["need_num"..i],look=true,bgVisible=true,color =color})
		end
	end
end

function JobTitleUpgradeOBJ:flushView(juewei_index)
	self.juewei_index = tonumber(juewei_index) or 0
	 self.select_index = self.juewei_index + 1 
	self:UpdateRightInfo()
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "JobTitleUpgradeOBJ",["node"] = self,["is_all"] = true})
end

return JobTitleUpgradeOBJ