local ExclusiveTitleOBJ = {}
ExclusiveTitleOBJ.Name = "ExclusiveTitleOBJ"
ExclusiveTitleOBJ.cfg=GetConfig("ExclusiveTitleCfg")
function ExclusiveTitleOBJ:main(npc_id,active_flag)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ExclusiveTitleUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close("ExclusiveTitleOBJ")
    end)
    self.npc_id = tonumber(npc_id) or 0
    self.active_flag = tonumber(active_flag) or 0 
    self:InitViewInfo()
    self:UpdaViewInfo()
  	GUI:addOnClickEvent(self.ui.dazao_btn,function ()
    	SendMsgCallFunByNpc(0,"ExclusiveTitle","DazaoClick",self.npc_id)
    end)

    GUI:addOnClickEvent(self.ui.item_name,function ()
		local pos = GUI:getWorldPosition(self.ui.item_name)
		local cfg = self.cfg[self.npc_id]
    	UIOperator:OpenItemTips({itemData = SL:GetMetaValue("ITEM_DATA", SL:Get_ITEM_INDEX_BY_NAME(cfg.name)),pos = pos})
    end)
end
function ExclusiveTitleOBJ:InitViewInfo()
	local cfg = self.cfg[self.npc_id]
	local str = string.format("<font color='#ffff00'>【%s】</font>%s <font color='#00ff00'>BOSS</font> 均可掉落!",cfg.need_item,cfg.map_name) 
    GUI:RichText_Create(self.ui.FrameLayout,"desc_rich",81,39,str,450,18,"#C6C6CE")
	GUI:Effect_Create(self.ui.effect_node, "effect", 0,0, 0, cfg.effect_id)
	 local feature= {}
    feature.clothID =  SL:Get_EQUIP_DATA(0) and SL:Get_EQUIP_DATA(0).Looks or nil
    feature.weaponID = SL:Get_EQUIP_DATA(1) and SL:Get_EQUIP_DATA(1).Looks or nil-- 武器id
    feature.weaponEffectID =SL:Get_EQUIP_DATA(1) and SL:Get_EQUIP_DATA(1).sEffect or nil
    feature.clothEffectID = SL:Get_EQUIP_DATA(0) and SL:Get_EQUIP_DATA(0).sEffect or nil
    feature.showNodeModel = true  
    feature.showHair = false       
    local sex = SL:GetMetaValue("SEX")
    local job = SL:GetMetaValue("JOB")
    local UIModel = GUI:UIModel_Create(self.ui.model_node, "UIMODEL", 0,0, sex, feature, nil, true, job)

end

function ExclusiveTitleOBJ:UpdaViewInfo()
	local cfg = self.cfg[self.npc_id]

	ItemShow_updateItem(self.ui.ItemShow,{index = SL:Get_ITEM_INDEX_BY_NAME(cfg.name),look=true,bgVisible=true,count=1})

	local color = SL:Get_ITEM_COUNT(cfg.need_item) >= cfg.need_item_count and 250 or 249 
	ItemShow_updateItem(self.ui.need_item,{index = SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item),look=true,bgVisible=true,count=cfg.need_item_count,color = color})

	color = tonumber(SL:Get_MONEY_ASSOCIATED(SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item2))) >= cfg.need_item_count2 and 250 or 249 
	ItemShow_updateItem(self.ui.need_item_2,{index = SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item2),look=true,bgVisible=true,count=cfg.need_item_count2,color = color})

	GUI:Text_setString(self.ui.item_name,"称号："..cfg.name) 
	GUI:setVisible(self.ui.need_item,self.active_flag <= 0)
	GUI:setVisible(self.ui.need_item_2,self.active_flag <= 0)
	GUI:setVisible(self.ui.dazao_btn,self.active_flag <= 0) 
	GUI:setVisible(self.ui.has_img,self.active_flag > 0) 
end

function ExclusiveTitleOBJ:DazaoBtnRed()
	if ExclusiveTitleOBJ.npc_id == nil then return false end
	local cfg = ExclusiveTitleOBJ.cfg[ExclusiveTitleOBJ.npc_id]
	if SL:Get_ITEM_COUNT(cfg.need_item) < cfg.need_item_count  then
		return false
	end
	if tonumber(SL:Get_MONEY_ASSOCIATED(SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item2))) < cfg.need_item_count2 then
		return false
	end
	local id = SL:Get_ITEM_INDEX_BY_NAME(cfg.name)
	local title_tab = SL:Get_TITLES() or {}
	for i,v in ipairs(title_tab) do
		if v.id == id then
			return false
		end
	end
	return true
end

function ExclusiveTitleOBJ:flushView(active_flag)
	self.active_flag = tonumber(active_flag) or 0 
	self:UpdaViewInfo()
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "ExclusiveTitleOBJ",["node"] = self,["is_all"] = true})
end
return ExclusiveTitleOBJ