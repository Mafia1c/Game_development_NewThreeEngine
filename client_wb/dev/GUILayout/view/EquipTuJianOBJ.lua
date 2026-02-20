local EquipTuJianOBJ = {}
EquipTuJianOBJ.Name = "EquipTuJianOBJ"
EquipTuJianOBJ.cfg = GetConfig("EquipTuJianCfg")


function EquipTuJianOBJ:main(data,index,jump_flag)
   	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/EquipTuJianUI", function () end)
    self.ui = GUI:ui_delegate(parent)	
    local jump_flag = tonumber(jump_flag) or 0
 
    self.tujian_data = SL:JsonDecode(data) or {} 

	local bigMap = GameData.GetData("U_bigMap",false) or 0 --#region 去过几大陆记录
	self.sort_cfg = {}
 	for i,v in ipairs(self.cfg) do
 		if bigMap >= v.show_mapid then
 			table.insert(self.sort_cfg,v)	
 		end
 	end

	table.sort(self.sort_cfg,function (a,b)
		local a_active = self:SuitIsActiveByKey(a.key_name) and 1 or 0
		local b_active = self:SuitIsActiveByKey(b.key_name) and 1 or 0
		if a_active ~= b_active then
			return a_active < b_active
		end
		return a.key_name < b.key_name
	end)

    self.select_type_index = (tonumber(index) and tonumber(index) > 0) and tonumber(index) or self.sort_cfg[1].key_name
    self.select_page_index = 1
	if jump_flag > 0 then
  		self.select_page_index = self:GetPageByKey(self.select_type_index)
    end

    GUI:addOnClickEvent(self.ui.closeBtn,function ()
    	ViewMgr.close("EquipTuJianOBJ")
    end)

    GUI:addOnClickEvent(self.ui.last_btn,function ()
    	if self.select_page_index <= 1 then
    		return SL:ShowSystemTips("已经是第一页!")
    	end
    	self.select_page_index = self.select_page_index - 1
		self:UpdaPageInfo()
    end)

    GUI:addOnClickEvent(self.ui.next_btn,function ()
    	if self.select_page_index >= math.ceil(#self.sort_cfg/12) then
    		return SL:ShowSystemTips("已经是最后一页!")
    	end
    	self.select_page_index = self.select_page_index + 1
		self:UpdaPageInfo()
    end)
    GUI:addOnClickEvent(self.ui.submit_btn,function ()
    	SendMsgCallFunByNpc(0,"EquipTuJian","SubmitOnClick",self.select_type_index)
    end)

  	GUI:addOnClickEvent(self.ui.tip_btn,function ()
  		local worldPos = GUI:getTouchEndPosition(self.ui.tip_btn)
  		local str = "<已激活套装属性:/FCOLOR=251>\\<体力：/FCOLOR=243><%s%%/FCOLOR=250>\\<攻魔道：/FCOLOR=243><%s%%/FCOLOR=250>\\<魔防加成：/FCOLOR=243><%s%%/FCOLOR=250>\\<防御加成：/FCOLOR=243><%s%%/FCOLOR=250>"
  		local attr1,attr2,attr3,attr4 = self:GetActiveSuitAttr()
        GUI:ShowWorldTips(string.format(str,attr1,attr2,attr2,attr3,attr4) , GUI:p(910, 240), GUI:p(1, 1))
  	end)
    
    self:UpdaPageInfo()
end

function EquipTuJianOBJ:UpdaPageInfo()
	GUI:removeAllChildren(self.ui.equip_type_box)
 	self.ui = GUI:ui_delegate(self._parent)	
 
	self.show_list = {}
	for i,v in ipairs(self.sort_cfg) do
		if i > (self.select_page_index-1) * 12 and i <= (self.select_page_index * 12) then
			table.insert(self.show_list,v) 
		end
	end
	local red_check_list = {}
	for i,v in ipairs(self.show_list) do
		local btn = GUI:Button_Create(self.ui.equip_type_box,"type_btn"..v.key_name,0,0,"res/custom/npc/ta1.png")
		GUI:Button_setTitleText(btn,v.equip_type_name)
		GUI:Button_setTitleFontSize(btn,18)
		if self:SuitIsActiveByKey(v.key_name) then
			GUI:Image_Create(btn,"suit_active_flag"..v.key_name,0,3,"res/custom/tag/000006.png")
		end
		GUI:addOnClickEvent(btn,function ()
			self.select_type_index = v.key_name
			self:UpdataRightInfo()		
		end)
		local red_data =  RedPointMgr.GetRedDataByBtnName("EquipTuJianOBJ","type_btn"..v.key_name)
		if red_data then
			red_check_list["type_btn"..v.key_name]  = red_data
		end
	end
	self:UpdataRightInfo()
	GUI:UserUILayout(self.ui.equip_type_box, {
        dir=3,
        addDir=1,
        colnum = 2,
        gap = {x=10,y=10,l=3},
    })
    GUI:Text_setString(self.ui.page_text,self.select_page_index)
    red_check_list.view_name = "EquipTuJianOBJ"
    red_check_list.node = self
    red_check_list["next_btn"]  =  RedPointMgr.GetRedDataByBtnName("EquipTuJianOBJ","next_btn")
    red_check_list["last_btn"]  =  RedPointMgr.GetRedDataByBtnName("EquipTuJianOBJ","last_btn")
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_check_list)
end

function EquipTuJianOBJ:UpdataRightInfo()
	for i,v in ipairs(self.show_list) do
		if GUI:Win_IsNotNull(self.ui["type_btn"..v.key_name]) then
			GUI:Button_loadTextureNormal(self.ui["type_btn"..v.key_name],self.select_type_index == v.key_name and "res/custom/npc/ta0.png" or "res/custom/npc/ta1.png")
			GUI:Button_setTitleColor(self.ui["type_btn"..v.key_name],self.select_type_index == v.key_name and "#00ff00" or "#ffffff")
		end
	end
	GUI:removeAllChildren(self.ui.equip_listview)
    self.ui = GUI:ui_delegate(self._parent)	
	for i,v in ipairs(self.cfg[self.select_type_index].equip_list) do
		local is_active = self:SigleIsActive(self.select_type_index,v)
		local img = GUI:Image_Create(self.ui.equip_listview,"equip"..i,0,0,"res/custom/npc/31zbtj/tips1.png")
		local item = GUI:ItemShow_Create(img,"equip_item"..i,61,43,{index =SL:GetMetaValue("ITEM_INDEX_BY_NAME",v),look=false,bgVisible=true,count =1})
		GUI:setAnchorPoint(item,0.5,0.5)
		GUI:Text_Create(img,"equip_flag"..i,137,33,16,is_active and "#00ff00" or "#ff0000" ,is_active and "1/1" or "0/1")
		local name =  GUI:Text_Create(img,"equip_name"..i,108,97,16,"#ff9b00",v)
		GUI:setAnchorPoint(name,0.5,0.5)
		if self.ui["active_flag"..i] then
			GUI:Image_loadTexture(self.ui["active_flag"..i],is_active and "res/custom/npc/14tujian/ss_0.png" or "res/custom/npc/14tujian/ss_1.png")
		else
			GUI:Image_Create(img,"active_flag"..i,195,18,is_active and "res/custom/npc/14tujian/ss_0.png" or "res/custom/npc/14tujian/ss_1.png")
		end
	end
	GUI:UserUILayout(self.ui.equip_listview, {
        dir=3,
        addDir=1,
        colnum = 2,
        gap = {x=10,y=10},
    })
    local str = "<font color='#f7ef8c'>体力</font><font color='#00ff00'>%s%%、</font><font color='#f7ef8c'>攻魔道</font><font color='#00ff00'>%s%%</font>"
	local cfg = self.cfg[self.select_type_index]
	if self.ui.attr_rich then
		removeOBJ(self.ui.attr_rich,self)
	end

	if cfg.attack_attr1 then
		str = string.format(str,cfg.hp_attr,cfg.attack_attr1)
	elseif cfg.attack_attr2 then
		str = "<font color='#f7ef8c'>体力</font><font color='#00ff00'>%s%%、</font><font color='#f7ef8c'>魔御加成</font><font color='#00ff00'>%s%%</font>"
		str = string.format(str,cfg.hp_attr,cfg.attack_attr2,cfg.attack_attr2)
	elseif cfg.attack_attr3 then
		str = "<font color='#f7ef8c'>体力</font><font color='#00ff00'>%s%%、</font><font color='#f7ef8c'>防御加成</font><font color='#00ff00'>%s%%</font>"
		str = string.format(str,cfg.hp_attr,cfg.attack_attr3,cfg.attack_attr3)
	end
    GUI:RichText_Create(self.ui.FrameLayout, "attr_rich",351, 59, str, 200, 18, "#ffffff")
    GUI:setVisible(self.ui.submit_btn,not self:SuitIsActiveByKey(self.select_type_index))
    GUI:setVisible(self.ui.yiwancheng_img, self:SuitIsActiveByKey(self.select_type_index))
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{view_name = EquipTuJianOBJ,node = self,["submit_btn"]=RedPointMgr.GetRedDataByBtnName("EquipTuJianOBJ","submit_btn")})
end

function EquipTuJianOBJ:flushView(data)
	self.tujian_data = SL:JsonDecode(data) or {} 
	self:UpdataRightInfo()
	local red_check_list = {}
	for i,v in ipairs(self.show_list) do
		local red_data =  RedPointMgr.GetRedDataByBtnName("EquipTuJianOBJ","type_btn"..v.key_name)
		if red_data then
			red_check_list["type_btn"..v.key_name]  = red_data
		end
		if self:SuitIsActiveByKey(v.key_name) then
			if self.ui["type_btn"..v.key_name] then
				GUI:Image_Create(self.ui["type_btn"..v.key_name],"suit_active_flag"..v.key_name,0,3,"res/custom/tag/000006.png")
			end
		end
	end
	red_check_list.view_name = "EquipTuJianOBJ"
	red_check_list.node = self
	red_check_list["next_btn"]  = RedPointMgr.GetRedDataByBtnName("EquipTuJianOBJ","next_btn")
	red_check_list["last_btn"]  = RedPointMgr.GetRedDataByBtnName("EquipTuJianOBJ","last_btn")
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_check_list)
end
function EquipTuJianOBJ:GetActiveSuitAttr()
	local attr1 =0 
	local attr2 =0 
	local attr3 =0 
	local attr4 =0 
	for i,v in ipairs(self.cfg) do
		if self:SuitIsActiveByKey(v.key_name) then
			attr1 = attr1 + v.hp_attr
			if v.attack_attr1 then
				attr2 = attr2 + v.attack_attr1
			end
			if v.attack_attr2 then
				attr3 = attr3 + v.attack_attr2
			end
			if v.attack_attr3 then
				attr4 = attr4 + v.attack_attr3
			end
		end
	end
	return attr1,attr2,attr3,attr4
end
function EquipTuJianOBJ:SuitIsActiveByKey(key_name)
	local cfg =  EquipTuJianOBJ.cfg[key_name]
	key_name =  tostring(key_name)
	if self.tujian_data[key_name] == nil or self.tujian_data[key_name] == "" then
		return false
	end
	return #self.tujian_data[key_name] >= #cfg.equip_list
end

function EquipTuJianOBJ:SigleIsActive(key_name,equip_name)
	local cfg = self.cfg[key_name]
	key_name = tostring(key_name)

	if self.tujian_data[key_name] == nil or self.tujian_data[key_name] == "" then
		return false
	end
	return isInTable(self.tujian_data[key_name],equip_name) 
end
function EquipTuJianOBJ:GetPageByKey(key)
	for i,v in ipairs(self.sort_cfg) do
		if v.key_name == key then
			return math.ceil(i/12) 
		end
	end
	return 1
end

function EquipTuJianOBJ:GetNextBtnShow()
	if EquipTuJianOBJ.select_page_index == nil then return false end
	for i,v in ipairs(EquipTuJianOBJ.sort_cfg) do
		if i > EquipTuJianOBJ.select_page_index * 12 then
			for _,name in ipairs(v.equip_list) do
				if SL:Get_ITEM_COUNT(name) > 0 and not EquipTuJianOBJ:SigleIsActive(v.key_name,name) then
					return true
				end
			end
		end
	end

	return false
end

function EquipTuJianOBJ:GetLastBtnShow()
	if EquipTuJianOBJ.select_page_index == nil then return false end
	for i,v in ipairs(EquipTuJianOBJ.sort_cfg) do
		if i < (EquipTuJianOBJ.select_page_index-1) * 12 then
			for _,name in ipairs(v.equip_list) do
				if SL:Get_ITEM_COUNT(name) > 0 and not EquipTuJianOBJ:SigleIsActive(v.key_name,name) then
					return true
				end
			end
		end
	end

	return false
end

function EquipTuJianOBJ:GetsubmitBtnShow()
	if not EquipTuJianOBJ.select_type_index then
		return false
	end
	local cfg = EquipTuJianOBJ.cfg[EquipTuJianOBJ.select_type_index]
	for i,v in ipairs(cfg.equip_list) do
		if SL:Get_ITEM_COUNT(v) > 0 and not EquipTuJianOBJ:SigleIsActive(cfg.key_name,v) then
			return true
		end
	end
	return false
end

return EquipTuJianOBJ