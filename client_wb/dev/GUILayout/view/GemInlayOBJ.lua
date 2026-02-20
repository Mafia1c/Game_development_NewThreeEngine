local GemInlayOBJ = {}
GemInlayOBJ.Name = "GemInlayOBJ"
GemInlayOBJ.NpcId = 125
GemInlayOBJ.cfg = GetConfig("GemInlayCfg")
GemInlayOBJ.compoundcfg = {
	[1]={tab_name = "普通宝石",need_item = {"黑铁#888","仙石#188"},need_money = "元宝#2000"},
	[2]={tab_name = "传说宝石",need_item = {"红宝石Lv1#1","黄宝石Lv1#1","蓝宝石Lv1#1","绿宝石Lv1#1","紫水晶Lv1#1"},need_money = "元宝#20000"},
}
GemInlayOBJ.bag_show_list = {}
for _,v in ipairs(GemInlayOBJ.cfg) do
	for i=1,5 do
		if not isInTable(GemInlayOBJ.bag_show_list,v["inlay_pos"..i].."Lv1") then
			table.insert(GemInlayOBJ.bag_show_list,v["inlay_pos"..i].."Lv1")
		end
	end
end 
function GemInlayOBJ:main()
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GemInlayUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    GUI:addOnClickEvent(self.ui.closeBtn,function ()
    	ViewMgr.close("GemInlayOBJ")
    end)
    self.select_one_btn_index = 1
    self.select_type_index = 1
    self.select_compound_index = 1
    for i=1,2 do
    	GUI:addOnClickEvent(self.ui["one_btn"..i],function ( )
    		self.select_one_btn_index = i
    		self:FlusListView()
			self:FlushRight(i)
    	end)
    end
    for i=1,5 do
    	GUI:addOnClickEvent(self.ui["inlay_btn"..i],function ()
    		SendMsgCallFunByNpc(GemInlayOBJ.NpcId,"GemInlay","InlayClick",self.select_type_index .. "#".. i)
    	end )
    end

	GUI:addOnClickEvent(self.ui["compound_btn"],function ()
		SendMsgCallFunByNpc(GemInlayOBJ.NpcId,"GemInlay","CompoundClick",self.select_compound_index)
	end)

    self:InitViewinfo()
    self:FlusListView()
end

function GemInlayOBJ:InitViewinfo()
	for i,v in ipairs(self.cfg) do
		local img = GUI:Image_Create(self.ui.ListView_1,"inlay_tab"..i,0,0,"res/custom/hecheng/sbt1.png")
		GUI:setTouchEnabled(img, true)
		GUI:addOnClickEvent(img,function ()
			self.select_type_index = i
			self:FlushRight(1)
		end)

		local text = GUI:Text_Create(img,"inlay_tab_name"..i,58,18,16,"#f0b42a",v.tab_name)
		GUI:setAnchorPoint(text,0.5,0.5)
	end 

	for i,v in ipairs(self.compoundcfg) do
		local img = GUI:Image_Create(self.ui.ListView_2,"compound_tab"..i,0,0,"res/custom/hecheng/sbt1.png")
		GUI:setTouchEnabled(img, true)
		GUI:addOnClickEvent(img,function ()
			self.select_compound_index = i
			self:FlushRight(2)
		end)
		local text = GUI:Text_Create(img,"compound_tab_name"..i,58,18,16,"#f0b42a",v.tab_name)
		GUI:setAnchorPoint(text,0.5,0.5)
	end 
	self:FlushRight(1)
end

function GemInlayOBJ:FlusListView()
	self.select_type_index = 1
	self.select_compound_index = 1 
	for i=1,2 do
		GUI:Button_loadTextureNormal(self.ui["one_btn"..i],i == self.select_one_btn_index and "res/custom/npc/ta0.png" or "res/custom/npc/ta1.png") 
		GUI:setContentSize(self.ui["ListView_"..i], 124,i == self.select_one_btn_index and 309 or 0)
		GUI:setVisible(self.ui["select_img"..i], i == self.select_one_btn_index) 
		GUI:setVisible(self.ui["ListView_"..i],i == self.select_one_btn_index)
		GUI:Button_setTitleColor(self.ui["one_btn"..i],i == self.select_one_btn_index and "#ffffff" or "#c6c6ce")
	end
	GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/45xq/bg".. self.select_one_btn_index ..".png" ) 
	GUI:ListView_setDirection(self.ui.tab_view_list, 1)
	GUI:setVisible(self.ui.inlay_node,self.select_one_btn_index == 1) 
	GUI:setVisible(self.ui.compound_node,self.select_one_btn_index == 2) 


end
--1 镶嵌 2 合成
function GemInlayOBJ:FlushRight(tab_type)
	if tab_type == 1 then
		GUI:setPositionX(self.ui.item_node1,195) 
		GUI:setPositionX(self.ui.item_node2,277)
		for i,v in ipairs(self.cfg) do
			if GUI:Win_IsNotNull(self.ui["inlay_tab"..i]) then
				GUI:Image_loadTexture(self.ui["inlay_tab"..i], i == self.select_type_index and "res/custom/hecheng/sbt2.png" or "res/custom/hecheng/sbt1.png")
			end
		end
		local cfg = self.cfg[self.select_type_index]
		local equip_data =  SL:Get_EQUIP_DATA(cfg.equip_pos)
		GUI:setVisible(self.ui.target_equip,equip_data ~= nil)
		if equip_data ~= nil then
			ItemShow_updateItem(self.ui.target_equip,{index =SL:Get_ITEM_INDEX_BY_NAME(equip_data.Name),look=true,bgVisible = false,count = 1,itemData = equip_data})
			GUI:Text_setString(self.ui.equip_name,equip_data.Name) 
		else
			GUI:Text_setString(self.ui.equip_name,"") 
		end
		local gem_inlay_info = equip_data and  equip_data.TNCell or {}
		local item_list = {}
		for i=1,5 do
			GUI:setVisible(self.ui["item_node"..i],true)
			local name = cfg["inlay_pos"..i].."Lv1"
			local is_inlay = gem_inlay_info[i-1] and gem_inlay_info[i-1] > 0
			local text_str = nil
			if is_inlay then
				name = SL:Get_ITEM_NAME(gem_inlay_info[i-1])
				local gen_tab = string.split(name,"Lv") 
				text_str = "Lv"..gen_tab[2]
			end
			ItemShow_updateItem(self.ui["ItemShow_"..i],{index = SL:Get_ITEM_INDEX_BY_NAME(name),count=1,bgVisible=false,look=true}) 
			GUI:ItemShow_setIconGrey(self.ui["ItemShow_"..i], gem_inlay_info[i-1] == nil or  gem_inlay_info[i-1] <= 0)
			GUI:Text_setString(self.ui["item_text_"..i],text_str or  "未镶嵌")
			GUI:Text_setTextColor(self.ui["item_text_"..i],is_inlay and "#00ff00" or "#808080")
			table.insert(item_list, cfg["inlay_pos"..i].."Lv1")
		end
		self:FlushBagInfo(item_list)
	else
		for i,v in ipairs(self.compoundcfg) do
			if GUI:Win_IsNotNull(self.ui["compound_tab"..i]) then
				GUI:Image_loadTexture(self.ui["compound_tab"..i], i == self.select_compound_index and "res/custom/hecheng/sbt2.png" or "res/custom/hecheng/sbt1.png")
			end
		end
		if self.select_compound_index  == 1 then
			GUI:setPositionX(self.ui.item_node1,302) 
			GUI:setPositionX(self.ui.item_node2,416) 
		else
			GUI:setPositionX(self.ui.item_node1,195) 
			GUI:setPositionX(self.ui.item_node2,277)
		end
		local cfg = self.compoundcfg[self.select_compound_index]
		for i=1,5 do
			local cfg_data = cfg.need_item[i]
			GUI:setVisible(self.ui["item_node"..i],cfg_data ~= nil)
			if cfg_data then
				local item_data = string.split(cfg_data,"#")
				local name = item_data[1]
				local need_count = tonumber(item_data[2])  
				local color = SL:Get_ITEM_COUNT(name) >= need_count and 250 or 249
				ItemShow_updateItem(self.ui["ItemShow_"..i],{showCount =true,index = SL:Get_ITEM_INDEX_BY_NAME(name),count= need_count,bgVisible=false,look=true,color = color}) 
				GUI:Text_setString(self.ui["item_text_"..i],name)
				GUI:Text_setTextColor(self.ui["item_text_"..i],SL:Get_ITEM_COUNT(name) >= need_count and "#00ff00" or "#ff0000")
				GUI:ItemShow_setIconGrey(self.ui["ItemShow_"..i],false)
			end
		end
		local need_money_tab = string.split(cfg.need_money,"#") 
		local num = tonumber(need_money_tab[2])
		local color = tonumber(SL:Get_MONEY_ASSOCIATED(SL:Get_ITEM_INDEX_BY_NAME(need_money_tab[1]))) >=  num and "#00FF00" or "#ff0000"
		GUI:Text_setString(self.ui.need_money_text,num .. need_money_tab[1]) 
		GUI:Text_setTextColor(self.ui.need_money_text,color)
		GUI:setVisible(self.ui.target_equip,self.show_compound_name ~= nil)
		GUI:setVisible(self.ui.compound_lock,self.show_compound_name == nil)
		if self.show_compound_name ~= nil then
			ItemShow_updateItem(self.ui.target_equip,{index =SL:Get_ITEM_INDEX_BY_NAME(self.show_compound_name),look=true,bgVisible = false,count = 1})
		end
		self:FlushBagInfo(self.bag_show_list)
		if self.ui.compound_rich then
			removeOBJ(self.ui.compound_rich,self)
		end
		local format_str = self.select_compound_index == 1 and "黑铁*888+仙石*188" or "5种宝石各一个"
		local rich_str = "合成说明：使用上面<font color='#00FF00'> %s</font> + <font color='#ff9b00'>%s</font> 可随机合成出<font color='#ff0000'> %s</font>，不同宝石可镶嵌到不同装备上"
		local rich = GUI:RichText_Create(self.ui.compound_node, "compound_rich", 0, -70, string.format(rich_str,format_str,(num .. need_money_tab[1]),cfg.tab_name) , 400, 16, "#ffffff")
		GUI:setAnchorPoint(rich,0.5,1)
	end
end

function GemInlayOBJ:FlushBagInfo(item_list)
	GUI:removeAllChildren(self.ui.bag_listview)
	self.ui = GUI:ui_delegate(self._parent)
	local list_count = math.ceil(#item_list / 3)
	for i=1,list_count do
	 	local list = GUI:ListView_Create(self.ui.bag_listview,"bag_listview"..i,0,0,190,60,2)
	 	GUI:ListView_setItemsMargin(list, 5)
	 	GUI:setTouchEnabled(list,false)
	end
	local listview_index = 1
	for i,v in ipairs(item_list) do
		local node = GUI:Image_Create(self.ui["bag_listview"..listview_index],"bag_item_bg"..i,0,0,"res/custom/itm0.png")
		local item =  GUI:ItemShow_Create(node,"bag_item_cell"..i,30,30,{index = SL:Get_ITEM_INDEX_BY_NAME(v),count = SL:Get_ITEM_COUNT(v),look = true,bgVisible = false})
		GUI:setAnchorPoint(item,0.5,0.5)
		local color = SL:Get_ITEM_COUNT(v) > 0 and 250 or 230
		ItemShow_updateItem(item,{showCount = true,index = SL:Get_ITEM_INDEX_BY_NAME(v),count = SL:Get_ITEM_COUNT(v),look = true,bgVisible = false,color = color}) 
		if i % 3 == 0 then
			listview_index = listview_index + 1
		end
	end
end
function GemInlayOBJ:flushView( ... )
	local tab = {...}
	if tab[1] == "flush_inlay" then
		self:FlushRight(1)
	elseif tab[1] == "flush_compound" then
		self.show_compound_name = tab[2]
		self:FlushRight(2)
		self.show_compound_name = nil
	end
	
end
-- 点击npc触发
local function onClickNpc(npc_info)
    if GemInlayOBJ.NpcId ==  npc_info.index then
        SendMsgClickNpc(npc_info.index.."#GemInlay")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "GemInlayOBJ", onClickNpc)

return GemInlayOBJ