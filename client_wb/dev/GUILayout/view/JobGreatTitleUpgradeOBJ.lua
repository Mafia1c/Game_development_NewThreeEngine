local JobGreatTitleUpgradeOBJ = {}
JobGreatTitleUpgradeOBJ.Name = "JobGreatTitleUpgradeOBJ"
JobGreatTitleUpgradeOBJ.cfg  = GetConfig("JobGreatTitleUpgradeCfg")
function JobGreatTitleUpgradeOBJ:main(juewei_index,great_level)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/JobGreatTitleUpgradeUI", function () end)
    self.ui = GUI:ui_delegate(parent)
  	GUI:addOnClickEvent(self.ui.close_btn, function()
        ViewMgr.close("JobGreatTitleUpgradeOBJ")
    end)

    GUI:addOnClickEvent(self.ui.upgrade_btn,function ()
    	SendMsgCallFunByNpc(0,"JobTitleUpgrade","UpgradeGreatClick")
    end)

    self.juewei_index = tonumber(juewei_index) or 0
    self.great_level = tonumber(great_level) or 0
    self:InitViewInfo()
    self:UpdateRightInfo()
end

function JobGreatTitleUpgradeOBJ:InitViewInfo()
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
end

function JobGreatTitleUpgradeOBJ:UpdateRightInfo()
	local img_name = self.juewei_index >= 11 and "res/custom/npc/ta0.png" or "res/custom/npc/ta1.png"
	local is_max = self.juewei_index >= 12
	GUI:Image_loadTexture(self.ui.juewei_img, img_name)
	GUI:Image_loadTexture(self.ui.jindu_img,string.format("res/custom/npc/29juewei/s%s.png",self.great_level))
	GUI:Button_setTitleText(self.ui.upgrade_btn,self.great_level >= 9 and "突破" or "晋升")

	GUI:setVisible(self.ui.max_img,is_max)
	GUI:setVisible(self.ui.need_item1,not is_max)
	GUI:setVisible(self.ui.need_item2,not is_max)
	GUI:setVisible(self.ui.upgrade_btn,not is_max)

	if self.ui.title_eff then
		removeOBJ(self.ui.title_eff,self)
	end
	if not is_max then
		GUI:Effect_Create(self.ui.FrameLayout, "title_eff", 370, 400, 0, 14228, 0, 0, 3, 1)
	end
	local cfg = self.cfg[self.great_level]

	local cur_attr_list = {}
	cur_attr_list[1] = cfg.attr1.."%"
	cur_attr_list[2] = cfg.attr2 .. "%"
	cur_attr_list[3] = cfg.attr3 .. "%"

	local next_attr_list = {}
	if is_max then
		next_attr_list = cur_attr_list
	else
		local next_cfg = self.cfg[self.great_level + 1]
		next_attr_list[1] = next_cfg.attr1.."%"
		next_attr_list[2] = next_cfg.attr2 .. "%"
		next_attr_list[3] = next_cfg.attr3 .. "%"
	end
	for i=1,3 do
		GUI:Text_setString(self.ui["cur_attr"..i],cur_attr_list[i])
		GUI:Text_setString(self.ui["next_attr"..i],next_attr_list[i])
	end
	if not is_max then
		for i=1,2 do
			local item_id = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg["need_name"..i])
        	local count = SL:GetMetaValue("ITEM_COUNT", item_id)
			local color =  count >= cfg["need_num"..i] and 250 or 249
			ItemShow_updateItem(self.ui["need_item"..i],{showCount = true,index = item_id,count = cfg["need_num"..i],look=true,bgVisible=true,color =color})
		end
	end
end

function JobGreatTitleUpgradeOBJ:flushView(juewei_index,great_level)
	self.juewei_index = tonumber(juewei_index) or 0
    self.great_level = tonumber(great_level) or 0
    self:UpdateRightInfo()
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "JobGreatTitleUpgradeOBJ",["node"] = self,["is_all"] = true})
end

return JobGreatTitleUpgradeOBJ