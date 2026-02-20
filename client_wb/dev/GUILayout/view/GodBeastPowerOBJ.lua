local GodBeastPowerOBJ = {}
GodBeastPowerOBJ.Name = "GodBeastPowerOBJ"
GodBeastPowerOBJ.cfg = GetConfig("GodBeastPowerCfg")
GodBeastPowerOBJ.list_cfg = {
	[1] ={name = "青龙之力",need_item = "青龙魂石",special_attr_name = "生命加成：",effect_id = 12385},
	[2] ={name = "白虎之力",need_item = "白虎魂石",special_attr_name = "攻魔道伤：",effect_id = 12386},
	[3] ={name = "朱雀之力",need_item = "朱雀魂石",special_attr_name = "防御加成：",effect_id = 12387},
	[4] ={name = "玄武之力",need_item = "玄武魂石",special_attr_name = "魔防加成：",effect_id = 12388},
}
function GodBeastPowerOBJ:main(data)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GodBeastPowerUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.level_info = SL:JsonDecode(data) or {} 
    self.select_btn_index = 1
   	GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close("GodBeastPowerOBJ")
    end)
    for i=1,4 do
    	GUI:addOnClickEvent(self.ui["Button_"..i],function ()
    		self.select_btn_index = i
    		self:UpdaViewInfo()
    	end)
    end

    GUI:addOnClickEvent(self.ui.up_level_btn,function ()
    	SendMsgCallFunByNpc(92,"GodBeastPower","UpLevelClick",self.select_btn_index)
    end)

    GUI:addOnClickEvent(self.ui.tip_btn,function ()
    	local str = "<兽魂融合BUFF：/FCOLOR=251>\\<神兽之力总等级达到30星/45星/60星/时激活对应BUFF/FCOLOR=243>\\<30星BUFF：攻击倍数+5%，攻击目标5%几率冰冻1秒！/FCOLOR=250>\\<45星BUFF：攻击倍数+10%，攻击目标10%几率冰冻2秒！/FCOLOR=250>\\<60星BUFF：攻击倍数+20%，攻击目标20%几率冰冻3秒！/FCOLOR=250>\\<冰冻BUFF冷却时间为30秒！/FCOLOR=250>"
    	GUI:ShowWorldTips(str, GUI:p(350, 280), GUI:p(0, 0))
    end)

    self:UpdaViewInfo()
end

function GodBeastPowerOBJ:UpdaViewInfo()
	for i=1,4 do
		GUI:Button_setGrey(self.ui["Button_"..i],self.select_btn_index ~= i )	
	end
	local cfg = self.list_cfg[self.select_btn_index]
	local level =  self.level_info[self.select_btn_index] or 0
	local level_cfg = self.cfg[level] 
	local next_level_cfg = self.cfg[level + 1]
	if next_level_cfg == nil then
		next_level_cfg = level_cfg
	end
	GUI:Text_setString(self.ui.name_text,cfg.name.."Lv"..level)
	if self.ui.sfx then
		removeOBJ(self.ui.sfx,self)
	end
	GUI:Effect_Create(self.ui.FrameLayout, "sfx", 370, 282, 0, cfg.effect_id)
	local color = SL:Get_ITEM_COUNT(cfg.need_item) >= level_cfg.need_item_count and 250 or 249
	ItemShow_updateItem(self.ui["need_item1"],{showCount =true,index = SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item),count = level_cfg.need_item_count,look = true,bgVisible = true,color = color}) 
	color = tonumber(SL:Get_MONEY_ASSOCIATED(SL:Get_ITEM_INDEX_BY_NAME(level_cfg.need_money))) >= level_cfg.need_money_count and 250 or 249
	ItemShow_updateItem(self.ui["need_item2"],{showCount =true,index = SL:Get_ITEM_INDEX_BY_NAME(level_cfg.need_money),count = level_cfg.need_money_count,look = true,bgVisible = true,color = color}) 
	for i=1,2 do
		GUI:Text_setString(self.ui["cur_attr_"..i],level_cfg["attr"..i]) 
		GUI:Text_setString(self.ui["next_attr_"..i],next_level_cfg["attr"..i]) 
	end

	GUI:Text_setString(self.ui["cur_attr_"..3],level_cfg.attr3.."%") 
	GUI:Text_setString(self.ui["next_attr_"..3],next_level_cfg.attr3.."%") 
	GUI:Text_setString(self.ui.special_attr_name,cfg.special_attr_name) 
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "GodBeastPowerOBJ",["node"] = self,["is_all"] = true})
end

function GodBeastPowerOBJ:UpBtnRed()
	if GodBeastPowerOBJ.select_btn_index == nil then return  false end
	local cfg = GodBeastPowerOBJ.list_cfg[GodBeastPowerOBJ.select_btn_index]
	local level =  GodBeastPowerOBJ.level_info[GodBeastPowerOBJ.select_btn_index] or 0
	local level_cfg = GodBeastPowerOBJ.cfg[level] 
	if level >= #GodBeastPowerOBJ.cfg then
		return false
	end
	if SL:Get_ITEM_COUNT(cfg.need_item) < level_cfg.need_item_count then return false  end
	if tonumber(SL:Get_MONEY_ASSOCIATED(SL:Get_ITEM_INDEX_BY_NAME(level_cfg.need_money))) < level_cfg.need_money_count then
		return false
	end
	return true
end

function GodBeastPowerOBJ:PageBtnRed(index)
	index = tonumber(index)
	if index == nil then return false end
	local cfg = GodBeastPowerOBJ.list_cfg[index]
	local level =  GodBeastPowerOBJ.level_info[index] or 0
	local level_cfg = GodBeastPowerOBJ.cfg[level] 
	if level >= #GodBeastPowerOBJ.cfg then
		return false
	end
	if SL:Get_ITEM_COUNT(cfg.need_item) < level_cfg.need_item_count then return false end
	if tonumber(SL:Get_MONEY_ASSOCIATED(SL:Get_ITEM_INDEX_BY_NAME(level_cfg.need_money))) < level_cfg.need_money_count then
		return false
	end
	return true
end

function GodBeastPowerOBJ:flushView( data )
	self.level_info = SL:JsonDecode(data) or {} 
	self:UpdaViewInfo()

end

return GodBeastPowerOBJ