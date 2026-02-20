local GodHammerOBJ = {}
GodHammerOBJ.Name = "GodHammerOBJ"
GodHammerOBJ.cfg = GetConfig("GodHammerCfg")
GodHammerOBJ.cfg_map = {}
GodHammerOBJ.cfg_map[1] ={tag_name= "乾坤宝炉",put_in_equip1 = {"阎罗战盔","阎罗战链","阎罗战镯","阎罗战戒","阎罗战带","阎罗战靴"},target_equip1 = {"圣山战盔","圣山战链","圣山战镯","圣山战戒","圣山战带","圣山战靴"},
put_in_equip2 = {"毁灭魔盔","毁灭魔链","毁灭魔镯","毁灭魔戒","毁灭魔带","毁灭魔靴"},target_equip2 = {"冥王魔盔","冥王魔链","冥王魔镯","冥王魔戒","冥王魔带","冥王魔靴"},
put_in_equip3 = {"避邪道盔","避邪道链","避邪道镯","避邪道戒","避邪道带","避邪道靴"},target_equip3 = {"如来道盔","如来道链","如来道镯","如来道戒","如来道带","如来道靴"}}
for i,v in ipairs(GodHammerOBJ.cfg) do
	GodHammerOBJ.cfg_map[v.tag_type] = GodHammerOBJ.cfg_map[v.tag_type] or {}
	GodHammerOBJ.cfg_map[v.tag_type].tag_name = v.tag_name
	table.insert(GodHammerOBJ.cfg_map[v.tag_type],v)
end
function GodHammerOBJ:main( ... )
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GodHammerUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    GUI:addOnClickEvent(self.ui.closeBtn,function ()
    	ViewMgr.close("GodHammerOBJ")
    end)
    GUI:addOnClickEvent(self.ui.tip_btn,function ()
    	local str="<神话·I /FCOLOR=253>< [战] /FCOLOR=7><任意：阎罗首饰*3 → 圣山首饰/FCOLOR=250>\\<神话·I /FCOLOR=253>< [法] /FCOLOR=7><任意：毁灭首饰*3 → 冥王首饰/FCOLOR=250>\\<神话·I /FCOLOR=253>< [道] /FCOLOR=7><任意：避邪首饰*3 → 如来首饰/FCOLOR=250>"
    	local worldPos = GUI:getTouchEndPosition(self.ui.tip_btn)
        GUI:ShowWorldTips(str, worldPos, GUI:p(1, 1))
    end)
    self.one_page_index = 1

    self:InitViewInfo()
    GUI:addOnClickEvent(self.ui.forge_btn,function (  )
	 	for i = 1, 3 do
            if not self["compound_select"..i] then
                return SL:ShowSystemTips("<font color=\'#ff0000\'>请先选取3个所需材料再进行锻造！</font>")
            end
        end
 		SendMsgCallFunByNpc(0,"GodHammer","ForgeClick",self.compound_select1.."#"..self.compound_select2.."#"..self.compound_select3)
    end)

    GUI:addOnClickEvent(self.ui.dazao_btn,function ()
    	SendMsgCallFunByNpc(0,"GodHammer","DazaoClick",self.one_page_index.."#"..(self.tag_btn_index or 0))
    end)
end

function GodHammerOBJ:InitViewInfo()
	for k,v in pairs(self.cfg_map) do
		local btn = GUI:Button_Create(self.ui.pageList_1,"tag_btn"..k,0,0,"res/custom/npc/ta1.png")
		GUI:Button_setTitleText(btn,v.tag_name)
		GUI:Button_setTitleFontSize(btn,18)
		GUI:addOnClickEvent(btn,function ()
			self.one_page_index = k
			self:FlushTwoList()
		end)
	end	

	self:FlushTwoList()

end

function GodHammerOBJ:FlushTwoList()
	for k,v in pairs(self.cfg_map) do
		GUI:Button_loadTextureNormal(self.ui["tag_btn"..k],self.one_page_index == k and "res/custom/npc/ta0.png" or "res/custom/npc/ta1.png")
	end
	GUI:setVisible(self.ui.baolu_node,self.one_page_index == 1)
	GUI:setVisible(self.ui.dazao_node,self.one_page_index ~= 1)
	GUI:Image_loadTexture(self.ui.FrameBG,self.one_page_index == 1 and "res/custom/npc/48bao/bg1.png" or "res/custom/npc/47jx/bg2.png")
	if self.one_page_index == 1 then  --乾坤宝炉
		for i = 1, 3 do
	        GUI:removeAllChildren(self.ui["compound_need_node"..i])
	        self["compound_select"..i] = nil
	    end
	    self.ui = GUI:ui_delegate(self._parent)
		GUI:setVisible(self.ui.compound_target_item,self.baolu_equip_name ~= nil) 
	    if self.baolu_equip_name then
	    	ItemShow_updateItem(self.ui.compound_target_item,{index=SL:Get_ITEM_INDEX_BY_NAME(self.baolu_equip_name),look=true,bgVisible=false})
	    end
		-- local color = tonumber(SL:Get_MONEY_ASSOCIATED("元宝")) >= 500000 and 250 or 249 
		-- ItemShow_updateItem(self.ui.compound_need_item1,{index=SL:Get_ITEM_INDEX_BY_NAME("元宝"),look = true,bgVisible=true,count = 500000,color = color})
		local color = SL:Get_ITEM_COUNT("仙石") >= 199 and 250 or 249 
		ItemShow_updateItem(self.ui.compound_need_item2,{index=SL:Get_ITEM_INDEX_BY_NAME("仙石"),look = true,bgVisible=true,count = 199,color = color})
		self:FlushBagListInfo()
	else  --神话装备
		self.tag_btn_index = 1 
		GUI:removeAllChildren(self.ui.pageList_2)
		self.ui = GUI:ui_delegate(self._parent)
		local cfg = self.cfg_map[self.one_page_index]
		for i,v in ipairs(cfg) do
			local img = GUI:Image_Create(self.ui.pageList_2,"tag"..i,0,0,"res/custom/npc/bt1.png")
			GUI:setTouchEnabled(img, true)
			GUI:addOnClickEvent(img,function ()
				self.tag_btn_index = i
				self:FlushRight()
			end)
			local text = GUI:Text_Create(img,"tag_name"..i,58,21,16,"#ffffff",v.target_name)
			GUI:setAnchorPoint(text,0.5,0.5)
		end
		self:FlushRight()
	end
end

function GodHammerOBJ:FlushRight()
	for i,v in ipairs(self.cfg_map[self.one_page_index]) do
		GUI:Image_loadTexture(self.ui["tag"..i], i == self.tag_btn_index and "res/custom/npc/bt2.png" or "res/custom/npc/bt1.png")
	end
	local cfg = self.cfg_map[self.one_page_index][self.tag_btn_index]
	GUI:Text_setString(self.ui.forge_name,cfg.target_name) 
	ItemShow_updateItem(self.ui.forge_target_item,{index=SL:Get_ITEM_INDEX_BY_NAME(cfg.target_name),look=true,bgVisible=true}) 
	-- local color = tonumber(SL:Get_MONEY_ASSOCIATED(SL:Get_ITEM_INDEX_BY_NAME(cfg.need_money))) >=  cfg.need_money_count and 250 or 249
	-- ItemShow_updateItem(self.ui.forge_item1,{index=SL:Get_ITEM_INDEX_BY_NAME(cfg.need_money),look=true,bgVisible=true,count=cfg.need_money_count,color = color})
	for i,v in ipairs(cfg.need_item_list_map) do
		local color = SL:Get_ITEM_COUNT(v[1]) >= v[2] and 250 or 249
		ItemShow_updateItem(self.ui["forge_item"..i+1],{index=SL:Get_ITEM_INDEX_BY_NAME(v[1]),look=true,bgVisible=true,count=v[2],color = color})
	end
end

function GodHammerOBJ:FlushBagListInfo()
	GUI:removeAllChildren(self.ui.compound_bag_listview) 
	self.ui = GUI:ui_delegate(self._parent)
    local bag_items = SL:Get_BAG_DATA()
    local cfg = self.cfg_map[1]
    local bag_list = {}
    for k,v in pairs(bag_items) do
    	if isInTable(cfg.put_in_equip1,v.Name) or  isInTable(cfg.put_in_equip2,v.Name) or isInTable(cfg.put_in_equip3,v.Name) and  #bag_list < 99 then
 			local data = {}
            data.index = v.Index
            data.look = false
            data.bgVisible = false
            data._MakeIndex = v.MakeIndex
            table.insert(bag_list,data)
    	end
    end

    for i=1,15 do
    	local list_view = GUI:ListView_Create(self.ui.compound_bag_listview,"bag_item_list"..i,0,0,255,60,2)
    	GUI:ListView_setItemsMargin(list_view, 5)
    	GUI:setTouchEnabled(list_view,false) 
    end
    local list_index = 1
    for i=1,60 do
    	local img = GUI:Image_Create(self.ui["bag_item_list"..list_index],"bag_item_node"..i,0,0,"res/custom/itm0.png")
    	GUI:setTouchEnabled(img,true)
    	if bag_list[i]  then
    		local item = GUI:ItemShow_Create(img,"bag_item_cell"..i,0,0,bag_list[i])
    		GUI:addOnClickEvent(img,function ( )
    			for index=1,3 do
    				if self.ui["compound_item"..index] and self["compound_select"..index] == bag_list[i]._MakeIndex  then
    					removeOBJ(self.ui["compound_item"..index],self)
    					self["compound_select"..index] = nil
    					GUI:ItemShow_setItemShowChooseState(item, false)
    					return
    				end
    			end
    			for index=1,3 do
    				if self.ui["compound_item"..index] == nil then
						self["compound_select"..index] = bag_list[i]._MakeIndex
						GUI:ItemShow_Create(self.ui["compound_need_node"..index],"compound_item"..index,-30,-30,{index = bag_list[i].index,look = true,bgVisible =false,count=1})
						GUI:ItemShow_setItemShowChooseState(item, true)
						return
    				end
    			end
    		end)

    	end
    	if i % 4 == 0 then
    		list_index = list_index +1
    	end
    end
end

function GodHammerOBJ:flushView( ... )
	local tab = {...}
	if tab[1] == "flush_baolu" then
		self.baolu_equip_name = tab[2] 
		self:FlushTwoList()
		self.baolu_equip_name = nil
	-- elseif tab[1] == "" then
	end
end

return GodHammerOBJ