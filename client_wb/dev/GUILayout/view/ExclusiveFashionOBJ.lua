local ExclusiveFashionOBJ = {}
ExclusiveFashionOBJ.Name = "ExclusiveFashionOBJ"
ExclusiveFashionOBJ.cfg = GetConfig("ExclusiveFashionCfg")
ExclusiveFashionOBJ.cfg_map = {}
for i,v in ipairs(ExclusiveFashionOBJ.cfg) do
	ExclusiveFashionOBJ.cfg_map[v.fashion_type] = ExclusiveFashionOBJ.cfg_map[v.fashion_type] or {}
	ExclusiveFashionOBJ.cfg_map[v.fashion_type] = ExclusiveFashionOBJ.cfg_map[v.fashion_type] or {}
	table.insert(ExclusiveFashionOBJ.cfg_map[v.fashion_type],v)
end
function ExclusiveFashionOBJ:main(fashion_type,active_str)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ExclusiveFashionUI", function () end)
    self.ui = GUI:ui_delegate(parent)

	GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close("ExclusiveFashionOBJ")
    end)

	self.active_str = active_str or ""

	self.fashion_type = tonumber(fashion_type) or 1 

	self:UpdaViewInfo()

	GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close("ExclusiveFashionOBJ")
    end)

	GUI:addOnClickEvent(self.ui.item_name,function ()
		local pos = GUI:getWorldPosition(self.ui.item_name)
    	UIOperator:OpenItemTips({itemData = SL:GetMetaValue("ITEM_DATA", SL:Get_ITEM_INDEX_BY_NAME(self.data.name)),pos = pos})
    end)

    GUI:addOnClickEvent(self.ui.tip_btn,function ( ... )
		local pos = GUI:getWorldPosition(self.ui.tip_btn)
    	UIOperator:OpenItemTips({itemData = SL:GetMetaValue("ITEM_DATA", SL:Get_ITEM_INDEX_BY_NAME(self.data.name)),pos = pos})
	end)

  	GUI:addOnClickEvent(self.ui.dazao_btn,function ( ... )
		SendMsgCallFunByNpc(0,"ExclusiveFashion","DaZaoClick",self.data.key_name)
	end)

end

function ExclusiveFashionOBJ:UpdaViewInfo()
	local cfg = self.cfg_map[self.fashion_type]
	self.data = cfg[#cfg]
	for i,v in ipairs(cfg) do
		if not string.find(self.active_str,v.name,1,true) then
			self.data = v
			break
		end
	end
	GUI:Text_setString(self.ui.name_text,self.data.name)
	GUI:Text_setString(self.ui.item_name,self.data.name)
	if self.ui.effect then
		removeOBJ(self.ui.effect,self)
	end
	local effect = GUI:Effect_Create(self.ui.effect_node, "effect", -24, -87, self.data.effect_type, self.data.effect_id, 1, 1, 5, 1)
	local size = 1
	if self.fashion_type == 2 then
		size = 1.2
	end
	GUI:setScale(effect, size)
	
	ItemShow_updateItem(self.ui.ItemShow,{index = SL:Get_ITEM_INDEX_BY_NAME(self.data.name),count=1,look=true,bgVisible=true})
	local color = SL:Get_ITEM_COUNT(self.data.need_item) >= self.data.need_count and 250 or 249
	ItemShow_updateItem(self.ui.need_item,{index = SL:Get_ITEM_INDEX_BY_NAME(self.data.need_item),count=self.data.need_count,look=true,bgVisible=true,color =color})
	local item_index = SL:Get_ITEM_INDEX_BY_NAME(self.data.need_item2)
	if item_index > 10000 then
		color = SL:Get_ITEM_COUNT(self.data.need_item2) >= self.data.need_count2 and 250 or 249
	else
		color = tonumber(SL:Get_MONEY_ASSOCIATED(item_index)) >= self.data.need_count2 and 250 or 249
	end
	ItemShow_updateItem(self.ui.need_item_2,{index = SL:Get_ITEM_INDEX_BY_NAME(self.data.need_item2),count=self.data.need_count2,look=true,bgVisible=true,color =color})

    GUI:setVisible(self.ui.role_model,self.fashion_type == 3)
    if self.ui.desc_rich then
    	removeOBJ(self.ui.desc_rich,self)
    end
    local str = string.format("<font color='#ffff00'>【%s】</font>%s <font color='#00ff00'>BOSS</font> 均可掉落!",self.data.need_item,self.data.map_name) 
    GUI:RichText_Create(self.ui.FrameLayout,"desc_rich",81,39,str,450,18,"#C6C6CE")
end

function ExclusiveFashionOBJ:flushView(fashion_type,active_str)
	self.active_str = active_str or ""
	self.fashion_type = tonumber(fashion_type) or 1 
	self:UpdaViewInfo()
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "ExclusiveFashionOBJ",["node"] = self,["is_all"] = true})
end

function ExclusiveFashionOBJ:DazaoBtnRed()
	if ExclusiveFashionOBJ.fashion_type == nil then return false end
	local cfg = ExclusiveFashionOBJ.cfg_map[ExclusiveFashionOBJ.fashion_type]
	local data = cfg[#cfg]
	local active_str = GameData.GetData(var_str,false) or ""
	for i,v in ipairs(cfg) do
		if not string.find(active_str,v.name,1,true) then
			data = v
			break
		end
	end
	if SL:Get_ITEM_COUNT(data.need_item) < data.need_count then
		return false
	end

	local item_index = SL:Get_ITEM_INDEX_BY_NAME(self.data.need_item2)
	if item_index > 10000 then
		if SL:Get_ITEM_COUNT(self.data.need_item2) < self.data.need_count2 then
			return false
		end
	else
		if tonumber(SL:Get_MONEY_ASSOCIATED(item_index)) < self.data.need_count2 then
			return false
		end
	end
	if data.fashion_type == 1 then --魔兽
        var_str = "T_warcraft_info"
    elseif data.fashion_type == 2 then --时装
        var_str = "T_fashion_info"
    elseif data.fashion_type == 3 then --魂环
        var_str = "T_soul_ring_info"
    end
	
    if string.find(active_str,data.name,1,true)  then
        return false
    end
	return true
end

return ExclusiveFashionOBJ