local DemonContractOBJ = {}
DemonContractOBJ.Name = "DemonContractOBJ"
DemonContractOBJ.NpcId = 74
DemonContractOBJ.cfg = GetConfig("DemonContractCfg")
DemonContractOBJ.talent_cfg = GetConfig("DemonContractTalentCfg")
DemonContractOBJ.total_attr_name_list = {"生命值:","魔法值:","防御:","魔防:","攻击"}
DemonContractOBJ.RunAction = true
DemonContractOBJ.cfg_map = {}
function DemonContractOBJ:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/DemonContractUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cfg_map = {}
    for i,v in ipairs(self.cfg) do
    	if v.map_type <= 1 or (GameData.GetData("U_bigMap",false) or 0) >= v.map_type then
			self.cfg_map[v.map_type] = self.cfg_map[v.map_type] or {}
			self.cfg_map[v.map_type][v.tujian_type] = self.cfg_map[v.map_type][v.tujian_type] or {}
			table.insert(self.cfg_map[v.map_type][v.tujian_type],v) 
    	end
	end

    local tab = {...}
    self.leftIndex = 1
	self.slect_common_key = 1
	self.slect_common_key_index = 1

    self.select_btn_index = tonumber(tab[1])
    self.select_tujian_index = 1
    self.pre_talent_tab = {}
    if self.select_btn_index == 1 then
    	self.leftIndex = tonumber(tab[4]) or 1
	    self.two_index = tonumber(tab[3]) or 1
    	self.star_data = SL:JsonDecode(tab[2]) or {}
    else
    	self.cur_talent_value = tonumber(tab[2]) or 0 
    	self.pre_talent_value = self.cur_talent_value
    	self.cur_talent_tab = SL:JsonDecode(tab[3]) or {}
    end
    GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.CloseLayout,function ()
    	GUI:setVisible(self.ui.tip_panel,false)
    end)

    GUI:addOnClickEvent(self.ui.tip_btn,function ()
    	removeOBJ(self.ui.tipbtn_rich,self)
		GUI:setVisible(self.ui.tip_panel,true)
		local big_map = (GameData.GetData("U_bigMap",false) or 0)
    	local str = "<font color='#FFFF00'>恶魔图鉴说明：</font><br><font color='#FF9B00'>每次提交图鉴可获得对应天赋点，最高3级</font><br><font color='#00FF00'>每次提交图鉴可获得对应声望，不限次数</font><br><font color='#FF00FF'>提交所需的图鉴在对应BOSS身上爆出</font><br><font color='#00FFE8'>万能恶魔图鉴可选中任意图鉴进行激活</font><br><font color='#009BFF'>盟重省万能恶魔图鉴消耗分别为：1/2/3/4/5张</font>"
    	local str2 = big_map >= 2 and "<br><font color='#FFFF00'>白日门万能恶魔图鉴消耗分别为：2/4/6/8/10张</font>" or ""
    	local str3 = big_map >= 3 and "<br><font color='#00FF00'>封魔谷万能恶魔图鉴消耗分别为：3/6/9/12/15张</font>" or ""
    	local rich = GUI:RichText_Create(self.ui.tip_bg, "tipbtn_rich", 215, 130, str..str2..str3, 390, 18, "#FFFFFF")
		GUI:setAnchorPoint(rich,0.5,0.5) 
    end)

    GUI:addOnClickEvent(self.ui.tip_panel,function ()
    	GUI:setVisible(self.ui.tip_panel,false)
    end)

    GUI:addOnClickEvent(self.ui.submit_btn,function ()
    	SendMsgCallFunByNpc(DemonContractOBJ.NpcId,"DemonContract","SubmitBtnClick",self.leftIndex.."#"..self.two_index)
    end)

    GUI:addOnClickEvent(self.ui.comm_submit_btn,function ()
    	if SL:Get_ITEM_COUNT("万能恶魔图鉴") > 0 and self.select_name then
    		local cfg = DemonContractOBJ.cfg_map[self.leftIndex][self.two_index][self.select_tujian_index]
	    	local data = {}
			data.str = "你确定使用【万能恶魔图鉴】 X ".. cfg.need_common_count .. " 激活【"..self.select_name .."】吗？"
			data.btnType = 2
			data.callback = function(atype, param)
			    if atype == 1 then
			        SendMsgCallFunByNpc(DemonContractOBJ.NpcId,"DemonContract","CommonSubmitBtnClick",self.leftIndex.."#"..self.two_index.."#"..self.select_tujian_index)
			    end
			end
			UIOperator:OpenCommonTipsUI(data)
    	else
    		SL:ShowSystemTips("万能恶魔图鉴不足！")
    	end
    end)

    for i=1,2 do
    	GUI:addOnClickEvent(self.ui["Button_"..i],function ()
    		SendMsgCallFunByNpc(0,"DemonContract","PageClick",i)
    	end)	
    end

    GUI:addOnClickEvent(self.ui.ok_talent_btn,function ()
    	SendMsgCallFunByNpc(0,"DemonContract","SetTalentAttr")
    end)

    for i=1,8 do
    	GUI:addOnClickEvent(self.ui["add_attr_btn"..i],function ( ... )
    		-- self:FlushPreTalent(i,true)
    		SendMsgCallFunByNpc(0,"DemonContract","SetPreTalentAttr",i .."#"..1)
    	end)  
    end

    for i=1,8 do
    	GUI:addOnClickEvent(self.ui["minus_attr_btn"..i],function ( ... )
    		-- self:FlushPreTalent(i,false)
    		SendMsgCallFunByNpc(0,"DemonContract","SetPreTalentAttr",i .."#"..0)
    	end)  
    end

    GUI:addOnClickEvent(self.ui.talent_tip,function ()
	  	local worldPos = GUI:getTouchEndPosition(self.ui.talent_tip)
	  	local str ="" 
	  	local job_str = "攻击"
	  	local job = SL:Get_JOB()
		if job == 1 then
			job_str = "魔法"
		elseif job == 2 then
			job_str = "道术"
		end
	  	for i=1,8 do
	  		local cfg = self.talent_cfg[i]
	  		if i < 7 then
	  			str = str.. string.format("<%s每点消耗：/FCOLOR=251><%s天赋点/FCOLOR=250>\\",cfg.attr_name,cfg.need_talent) 
	  		elseif i ==7 then
	  			str = str.. string.format("<%s下限每点消耗：/FCOLOR=251><%s天赋点/FCOLOR=250>\\",job_str,cfg.need_talent)
	  		elseif i == 8 then
				str = str.. string.format("<%s上限每点消耗：/FCOLOR=251><%s天赋点/FCOLOR=250>\\",job_str,cfg.need_talent)
	  		end
	  	end
        GUI:ShowWorldTips(str, worldPos, GUI:p(1, 0))
    end)

    for i=1,8 do
    	GUI:addOnClickEvent(self.ui["allot_btn"..i],function ()
			local data = {}
			data.str = "请输入要分配属性点数"
			data.btnType = 2
			data.showEdit = true
			data.editParams= {inputMode=2}
			data.callback = function(atype, param)
			    if atype == 1 then
			        if param and param.editStr and string.len(param.editStr) > 0 then
			        	SendMsgCallFunByNpc(0,"DemonContract","SetPreTalentAttr",i .."#3#"..param.editStr)
			        end
			    end
			end
			UIOperator:OpenCommonTipsUI(data)

    	end)
    end

	self:InInViewinfo()
    self:UpdateBtnNode()

end

function DemonContractOBJ:UpdateBtnNode()
	GUI:setVisible(self.ui.tujian_node,self.select_btn_index == 1 )
	GUI:setVisible(self.ui.attr_node,self.select_btn_index ~= 1 ) 
	for i=1,2 do
		GUI:setVisible(self.ui["btn_select"..i],self.select_btn_index == i) 
	end
	GUI:Image_loadTexture(self.ui.FrameBG,self.select_btn_index == 1 and "res/custom/npc/13emqy/bg11.png" or "res/custom/npc/13emqy/bg.png") 
	if self.select_btn_index == 1 then
		self:InInViewinfo()
	else
		self:flushPreAttr()
		self:UpdataAttrView()
	end

end

function DemonContractOBJ:InInViewinfo()
	GUI:removeAllChildren(self.ui.ScrollView)
	self.ui = GUI:ui_delegate(self._parent)
    for index, value in ipairs(self.cfg_map) do
        local btn = GUI:Button_Create(self.ui.ScrollView,"map_btn"..index,0,0,"res/custom/npc/ta1.png")
        GUI:Button_loadTexturePressed(btn,"res/custom/npc/ta0.png")
        GUI:Button_setTitleText(btn, value[1][1].map_name)
        GUI:Button_setTitleColor(btn, "#BDBDB5")
        GUI:Button_setTitleFontSize(btn, 18)
        GUI:addOnClickEvent(btn,function ()
        	self.leftIndex = index
        	self:FlushTwoList(1)
        end)
    end
    self:FlushTwoList(self.two_index or 1)
end

function DemonContractOBJ:FlushTwoList(index)
	self.two_index = index
    removeOBJ(self.ui.nowLeftTag,self)
    GUI:Image_Create(self.ui["map_btn"..self.leftIndex],"nowLeftTag",10,12,"res/custom/ar2.png")
    removeOBJ(self.ui.nowLeftList,self)
    local infoTab = self.cfg_map[self.leftIndex]
    local _height = 44 * #infoTab
    GUI:ScrollView_setInnerContainerSize(self.ui.ScrollView,124,44*#self.cfg_map+_height)
    for index, value in ipairs(self.cfg_map) do
        GUI:Button_loadTextureNormal(self.ui["map_btn"..index],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["map_btn"..index], "#BDBDB5")
        GUI:setPositionY(self.ui["map_btn"..index],450-index*44)
    end

    for i = self.leftIndex+1, #self.cfg_map do
        GUI:setPositionY(self.ui["map_btn"..i],GUI:getPositionY(self.ui["map_btn"..i]) - _height)
    end

    GUI:Button_loadTextureNormal(self.ui["map_btn"..self.leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["map_btn"..self.leftIndex], "#FFFFFF")


    local list = GUI:ListView_Create(self.ui["map_btn"..self.leftIndex],"nowLeftList",3,0,114,_height,1)
    GUI:setTouchEnabled(list,false)
    GUI:setAnchorPoint(list,0,1)
    local check_btn_list = {}
    for i,v in ipairs(infoTab) do
    	check_btn_list["leftBox"..i] = RedPointMgr.GetRedDataByBtnName("DemonContractOBJ","leftBox"..i)
    	local img = GUI:Image_Create(list,"leftBox"..i,0,0,"res/custom/hecheng/bt1.png")
        local name = GUI:Text_Create(img,"leftBoxName"..i,60,22,16,"#FFFFFF",v[1].tujian_type_name.."BOSS")
        GUI:setAnchorPoint(name,0.5,0.5)
        GUI:setLocalZOrder(name,20)
        GUI:setTouchEnabled(name,true)
        GUI:addOnClickEvent(name,function ()
        	self.two_index = i
        	self:FlushRight(true)
        end)
    end
    check_btn_list.view_name = "DemonContractOBJ"
    check_btn_list.node = self
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,check_btn_list)
    self:FlushRight(true)
end

function DemonContractOBJ:FlushRight(is_common)
	removeOBJ(self.ui.nowLeftBoxTag,self)
    GUI:Image_Create(self.ui["leftBox"..self.two_index],"nowLeftBoxTag",0,0,"res/custom/hecheng/bt3.png")
    for i,v in ipairs(self.cfg_map[self.leftIndex]) do
    	GUI:Text_setTextColor(self.ui["leftBoxName"..i],self.two_index == i and "#00FF00" or "#FFFFFF")
    end
	GUI:removeAllChildren(self.ui.tujian_listview)
	self.ui = GUI:ui_delegate(self._parent)
	local cfg = self.cfg_map[self.leftIndex][self.two_index]
	local list_num = math.ceil(#cfg /4) 
	for i=1,list_num do
		local list_view = GUI:ListView_Create(self.ui.tujian_listview,"tujian_list"..i,0,0,488,162,2)
		GUI:ListView_setItemsMargin(list_view, 3)
		GUI:setTouchEnabled(list_view,false)
	end

	local index = 1
	for i,v in ipairs(cfg) do
		local star = self.star_data[v.key_name] or 0
		local img = GUI:Image_Create(self.ui["tujian_list"..index],"tujian"..i,0,0,"res/custom/npc/13emqy/ka1.png")
		GUI:setTouchEnabled(img,true)
		GUI:addOnClickEvent(img,function ()
			self.select_name = v.tujian_name
			self:FlushSelectTuJian(cfg,i)
			self.slect_common_key = v.key_name
			self.slect_common_key_index = i
		end)
		GUI:Image_Create(img,"tujian_icon"..i,8,7,string.format("res/custom/npc/13emqy/ka/%s.png",v.tujian_id))
		GUI:Image_Create(img,"tujian_star"..i,19,18,string.format("res/custom/npc/13emqy/xx%s.png",star))
		local name_text = GUI:Text_Create(img,"tujian_name"..i,60,147,16,"#FF0000",v.tujian_name)
		GUI:setAnchorPoint(name_text,0.5,0.5)
		local select_img = GUI:Image_Create(img,"select_tujian"..i,-3,-3,"res/public/1900000678_1.png")
		GUI:Image_setScale9Slice(select_img, 8, 8, 28, 28)
		GUI:setContentSize(select_img, 126, 170)
		GUI:setVisible(select_img,false)
		if i %4 == 0 then
			index = index + 1
		end
	end
	if is_common then
		for i,v in ipairs(cfg) do
			local star =  self.star_data[v.key_name] or 0
			if star < 3 then
				self.slect_common_key = v.key_name
				self.slect_common_key_index = i 
				break
			end
		end
	end
	local select_index = is_common and self.slect_common_key_index or 1
	GUI:Text_setString(self.ui.star_text,string.format("%s星级：%s ★",cfg[select_index].tujian_type_name,self:GetCurTypeStar()))
	GUI:Text_setString(self.ui.submit_rewrad_text,string.format("声望×%s",cfg[select_index].prestige_value))
	GUI:Text_setString(self.ui.attr_text,"天赋点"..cfg[select_index].talent_value)
	GUI:Text_setString(self.ui.prestige_text,string.format("声望：%s",SL:Get_MONEY(15)))
	-- GUI:Button_setTitleText(self.ui.submit_btn,SL:Get_ITEM_COUNT("万能恶魔图鉴") >= cfg[1].need_common_count and "万能激活" or "一键提交") 
	self.select_name = cfg[select_index].tujian_name
	self:FlushSelectTuJian(cfg,select_index)
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "DemonContractOBJ",["node"] = self,["submit_btn"]=RedPointMgr.GetRedDataByBtnName("DemonContractOBJ","submit_btn")})
end

function DemonContractOBJ:flushSigleItem(leftIndex,two_index,select_index)
	local cfg = self.cfg_map[leftIndex][two_index][select_index]
	local star = self.star_data[cfg.key_name] or 0
	GUI:Image_loadTexture(self.ui["tujian_star"..select_index],string.format("res/custom/npc/13emqy/xx%s.png",star))
	GUI:Text_setString(self.ui.prestige_text,string.format("声望：%s",SL:Get_MONEY(15)))
	if star >= 3 then
		self:FlushRight(true)
	end
end


function DemonContractOBJ:flushPreAttr()
	GUI:Text_setString(self.ui.cur_talent,self.pre_talent_value)
	for i=1,8 do
		local pre_value= self.pre_talent_tab[i] or 0
		GUI:Text_setString(self.ui["allot_talent_value"..i],pre_value) 
	end
end

function DemonContractOBJ:UpdataAttrView()
	local job = SL:Get_JOB()
	local str = "攻击"
	if job == 1 then
		str = "魔法"
	elseif job == 2 then
		str = "道术"
	end
	for i=1,5 do
		if i~= 5 then
	  		GUI:Text_setString(self.ui["total_attr_name"..i],self.total_attr_name_list[i])	
		else
			GUI:Text_setString(self.ui["total_attr_name"..i],str..":")	
		end
		if i <= 2 then
			GUI:Text_setString(self.ui["total_attr_value"..i],self.cur_talent_tab[i])
		elseif i == 3 then
			GUI:Text_setString(self.ui["total_attr_value"..i],self.cur_talent_tab[3].. "-" .. self.cur_talent_tab[4])
		elseif i == 4 then
			GUI:Text_setString(self.ui["total_attr_value"..i],self.cur_talent_tab[5].. "-" ..self.cur_talent_tab[6])
		elseif i == 5 then
			GUI:Text_setString(self.ui["total_attr_value"..i],self.cur_talent_tab[7].. "-" ..self.cur_talent_tab[8])
		end
	end
	for i=1,5 do
		GUI:Text_setString(self.ui["random_attr_value"..i],self.cur_talent_tab[i+8].."%") 
	end
	GUI:Text_setString(self.ui.allot_attr_name7,str.."下限:")
	GUI:Text_setString(self.ui.allot_attr_name8,str.."上限:")
end

function DemonContractOBJ:FlushSelectTuJian(cfg,index)
	self.select_tujian_index = index
	for i,v in ipairs(cfg) do
		local node = self.ui["select_tujian"..i]
		if GUI:Win_IsNotNull(node) then
			GUI:setVisible(node,i == index)
		end
	end
end

function DemonContractOBJ:GetCurTypeStar()
	local cfg = DemonContractOBJ.cfg_map[self.leftIndex][self.two_index]
	local star = 0
	for i,v in ipairs(cfg) do
		local sigle_star = self.star_data[v.key_name] or 0
		star = star + sigle_star
	end
	return star
end

function DemonContractOBJ:flushView(...)
	local tab = {...}
	if tab[1] == "change_page" then
		self.select_btn_index = tonumber(tab[2])
		if self.select_btn_index == 1 then
	    	self.star_data = SL:JsonDecode(tab[3]) or {}
	    else
	    	self.cur_talent_value = tonumber(tab[3]) or 0 
	    	self.pre_talent_value = self.cur_talent_value
	    	self.cur_talent_tab = SL:JsonDecode(tab[4]) or {}
	    	self.pre_talent_tab = {}
	    end
		self:UpdateBtnNode()
	elseif tab[1] == "submit" then
		self.star_data = SL:JsonDecode(tab[2]) or {}
		self:FlushRight()
		SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "DemonContractOBJ",["node"] = self,["is_all"] = true})
	elseif tab[1] == "common_submit" then
		self.star_data = SL:JsonDecode(tab[2]) or {}
		-- self:FlushRight(true)
		local one_index = tonumber(tab[3])
		local two_index = tonumber(tab[4])
		local select_index = tonumber(tab[5])
		self:flushSigleItem(one_index,two_index,select_index)
		SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "DemonContractOBJ",["node"] = self,["is_all"] = true})
	elseif tab[1] == "pre_change" then
 		self.pre_talent_tab = SL:JsonDecode(tab[2]) or {}
 		self.pre_talent_value =tonumber(tab[3]) or 0
 		self:flushPreAttr()
	elseif tab[1] == "attr_change" then
		self.cur_talent_tab = SL:JsonDecode(tab[2]) or {}
		self.cur_talent_value = tonumber(tab[3]) or 0 
		self.pre_talent_value = self.cur_talent_value
 		self.pre_talent_tab = {}
 		self:UpdataAttrView()
 		self:flushPreAttr()
 		SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "DemonContractOBJ",["node"] = self,["is_all"] = true})
	end 
end

function DemonContractOBJ:GetsubmitBtnShow()
	if not DemonContractOBJ.leftIndex or not DemonContractOBJ.two_index then
		return false
	end
	local cfg =  DemonContractOBJ.cfg_map[DemonContractOBJ.leftIndex][DemonContractOBJ.two_index]
	for i,v in ipairs(cfg) do
		if SL:Get_ITEM_COUNT(v.need_item) > 0 then
			return true
		end
	end
	return false
end

-- 点击npc触发
local function onClickNpc(npc_info)
	if npc_info.index == DemonContractOBJ.NpcId then
		SendMsgClickNpc(DemonContractOBJ.NpcId.."#DemonContract")
	end 
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "DemonContractOBJ", onClickNpc)

return DemonContractOBJ