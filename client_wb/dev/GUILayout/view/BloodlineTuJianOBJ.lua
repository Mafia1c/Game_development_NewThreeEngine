local BloodlineTuJianOBJ = {}
BloodlineTuJianOBJ.Name = "BloodlineTuJianOBJ"
BloodlineTuJianOBJ.cfg = GetConfig("BloodlineAwakenCfg")
BloodlineTuJianOBJ.cfg_map = {}
for i,v in ipairs(BloodlineTuJianOBJ.cfg) do
	BloodlineTuJianOBJ.cfg_map[v.xuemai_type] = BloodlineTuJianOBJ.cfg_map[v.xuemai_type] or {}
	table.insert(BloodlineTuJianOBJ.cfg_map[v.xuemai_type],v)
end

function BloodlineTuJianOBJ:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/BloodlineTuJianUI", function () end)
    self.ui = GUI:ui_delegate(parent)
   	GUI:addOnClickEvent(self.ui.close_btn, function()
        ViewMgr.close("BloodlineTuJianOBJ")
    end)
    self.select_index = 1
    -- GUI:setContentSize(self.ui.Panel_1,553,500)
    self:CreateList()
end

function BloodlineTuJianOBJ:CreateList()
	GUI:removeAllChildren(self.ui.tujian_list_view)
	local sort_list = {111,222,333,444}
	for i,v in ipairs(sort_list) do
		local data = self.cfg_map[v]
		local count = math.ceil(#data / 7)
		-- hight = hight + count*67
		local xuemai_type = data[1].xuemai_type
		local parent_list = GUI:ListView_Create(self.ui.tujian_list_view, "parent_list"..xuemai_type, 0, 0, 556, 37+count*67, 1)
		GUI:setTouchEnabled(parent_list,false)
		GUI:ListView_setItemsMargin(parent_list, -80)
		GUI:Image_Create(parent_list,"title"..xuemai_type,0,0,string.format("res/custom/npc/10tmfw/%s.png",xuemai_type))
		local tujian_list = GUI:ListView_Create(parent_list, "tujian_list"..xuemai_type, 0, 0, 552, 67, 1)
		GUI:setTouchEnabled(tujian_list,false)
		GUI:ListView_setGravity(tujian_list,2)
		for i=1,count do
			local item_list = GUI:ListView_Create(tujian_list, "item_list"..xuemai_type.."_"..i, 0, 0, 482, 67, 2)
			GUI:setTouchEnabled(item_list,false)
			GUI:ListView_setItemsMargin(item_list,10) 
		end
		local index = 1
		for i,item in ipairs(data) do
			local node = GUI:Layout_Create(self.ui["item_list"..xuemai_type.."_"..index], "item_btn"..item.key_name,0, 0, 58, 58, false)
			GUI:setTouchEnabled(node,true)
			GUI:addOnClickEvent(node,function ()
				if self.select_index == item.key_name then
					return
				end
				self.select_index = item.key_name
				self:flushSelect()
			end)
			GUI:ItemShow_Create(node,"item"..item.key_name,0,0,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", item.name),count=1,bgVisible=false,look =false})
			GUI:Effect_Create(node, "select"..item.key_name, 30, 30, 0, 14505)
			if i % 7 == 0 then
				index = index + 1
			end 
		end
		GUI:setContentSize(tujian_list,552,67*count)
	end
	self:flushSelect()
end

function BloodlineTuJianOBJ:flushSelect()
	for i,v in ipairs(self.cfg) do
	 	GUI:setVisible(self.ui["select"..v.key_name],self.select_index == v.key_name) 
	end 
	removeOBJ(self.ui.select_layer_rich,self)
	local cfg = self.cfg[self.select_index]
	ItemShow_updateItem(self.ui.select_item,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.name),count=1,bgVisible=false,look =false})
	GUI:Text_setString(self.ui.select_name,cfg.name)
	GUI:Text_setTextColor(self.ui.select_name,SL:GetHexColorByStyleId(cfg.color)) 
	local layer_str = string.format("%s/<font color='#ff0000'>%s层</font>",0,cfg.max_layer) 
	GUI:RichText_Create(self.ui.select_bg, "select_layer_rich", 115, 277, layer_str, 100, 18,"#FFFFFF")
	removeOBJ(self.ui["desc_list"],self)
	local list = GUI:ListView_Create(self.ui.select_bg , "desc_list", 24, 64, 178, 170, 1)
	GUI:ListView_setBounceEnabled(list, true)
	GUI:ListView_setClippingEnabled(list, true)
	GUI:RichTextFCOLOR_Create(list, "select_desc", 0, 0,cfg.desc, 178, 18)
end


return BloodlineTuJianOBJ