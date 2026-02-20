local WsBloodLineAwakenOBJ = {}
WsBloodLineAwakenOBJ.Name = "WsBloodLineAwakenOBJ"
WsBloodLineAwakenOBJ.cfg = GetConfig("WsbloodLineCfg")
WsBloodLineAwakenOBJ.NpcId = 94
WsBloodLineAwakenOBJ.RunAction = true

function WsBloodLineAwakenOBJ:main(xuemai_info,cur_main_xuemai,ws_xuemai_list)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.ui = GUI:ui_delegate(parent)
    GUI:LoadExport(parent, "npc/WsBloodLineAwakenUI", function () end)

    self.select_pos = 1
    self.select_xuemai_info = SL:JsonDecode(xuemai_info) or {}
    self.cur_main_index = tonumber(cur_main_xuemai) or 0
    self.ws_xuemai_list = SL:JsonDecode(ws_xuemai_list) or {}

    self.select_main_index = self.cur_main_index > 0 and self.cur_main_index or 1
    GUI:addOnClickEvent(self.ui.closeBtn,function ()
    	ViewMgr.close("WsBloodLineAwakenOBJ")
    end)
    for i=1,12 do
    	GUI:addOnClickEvent(self.ui["item_pos"..i],function ()
    		local data =  self.select_xuemai_info[i]
    		if data and data < 0 then
    			return SL:ShowSystemTips("该血脉位置未激活！")
    		end
    		self.select_pos = i
    		self:SetSelectPos()
    	end)
    end

    for i=1,2 do
    	GUI:addOnClickEvent(self.ui["xuemai_btn"..i],function ()
    		SendMsgCallFunByNpc(WsBloodLineAwakenOBJ.NpcId,"WsBloodLineAwaken","OnClickChangeXueMaiBtn",i)
    	end)
    end

    GUI:addOnClickEvent(self.ui.reset_btn,function ()
    	SendMsgCallFunByNpc(WsBloodLineAwakenOBJ.NpcId,"WsBloodLineAwaken","OnClickReset",self.select_main_index)
    end)

    GUI:addOnClickEvent(self.ui.save_active_btn,function ()
    	SendMsgCallFunByNpc(WsBloodLineAwakenOBJ.NpcId,"WsBloodLineAwaken","ClickSaveActive",self.select_main_index)
    end)

    self:UpdaViewInfo()
    self:FlushXueMaiBtn()
end

function WsBloodLineAwakenOBJ:SetSelectPos()
	local pos = GUI:getPosition(self.ui["item_pos"..self.select_pos])
	GUI:setPosition(self.ui.select_img,pos.x-4,pos.y-4)
end

function WsBloodLineAwakenOBJ:FlushXueMaiBtn()
	for i=1,2 do
		local path = i == 1 and "res/custom/npc/35xm/2/an4" or "res/custom/npc/35xm/2/an5"
		GUI:Button_loadTextureNormal(self.ui["xuemai_btn"..i],i == self.select_main_index and path ..".png "or path.."_1.png") 
    end
end

function WsBloodLineAwakenOBJ:UpdaViewInfo()
	local active_level = 0
	for i=1,12 do
		local key_name = self.select_xuemai_info[i]
		if key_name and key_name >= 0 then
			active_level = active_level + 1
		end
		GUI:setVisible(self.ui["lock"..i],key_name and key_name < 0)
		GUI:setVisible(self.ui["icon"..i],key_name and key_name > 0)
		if key_name and key_name > 0 then
			GUI:Image_loadTexture(self.ui["icon"..i],string.format("res/custom/npc/35xm/icon/%s.png",self.cfg[key_name].xuemai_icon) )
			GUI:addOnClickEvent(self.ui["icon"..i],function ()
				local item_data  = SL:Get_ITEM_DATA(SL:Get_ITEM_INDEX_BY_NAME(self.cfg[key_name].xuemai_name))
				UIOperator:OpenItemTips({itemData =item_data })
	    		self.select_pos = i
	    		self:SetSelectPos()
			end)
		end
	end
	GUI:setVisible(self.ui.line_img,active_level > 1)
	GUI:Image_loadTexture(self.ui.line_img,string.format("res/custom/npc/35xm/2/jd%s.png",active_level - 1) )
	local str = "当前激活：血脉配置" ..self.cur_main_index
	GUI:Text_setString(self.ui.cur_active_text,self.cur_main_index > 0 and str or "当前激活：未激活") 
	GUI:removeAllChildren(self.ui.xuemai_listview)
    self.ui = GUI:ui_delegate(self._parent)
 	-- GUI:removeAllChildren(self.ui.xuemai_listview)
	-- --  -- xuemai_listview
 	local list_num = math.ceil(#self.ws_xuemai_list / 4)
 	for i=1,list_num do
 		local list = GUI:ListView_Create(self.ui.xuemai_listview,"xuemai_list"..i,0,0,252,88,2)
        GUI:setTouchEnabled(list, false)
 	end
 	local list_index = 1
    for i,v in ipairs(self.ws_xuemai_list) do
    	local cfg = self.cfg[v]
        local list_node = GUI:Layout_Create(self.ui["xuemai_list"..list_index], "list_node"..i, 0,0, 63, 86,false)
        local item = GUI:ItemShow_Create(list_node , "xuemai_list_item"..i, 31,56, {index = SL:GetMetaValue("ITEM_INDEX_BY_NAME",cfg.xuemai_name),look = true,bgVisible = true,count = 1})
        GUI:setAnchorPoint(item,0.5,0.5)
        local button =  GUI:Button_Create(list_node,"xuemai_list_btn"..i,4,1,"res/custom/npc/35xm/2/an3.png")
        GUI:addOnClickEvent(button,function ()
        	SendMsgCallFunByNpc(WsBloodLineAwakenOBJ.NpcId,"WsBloodLineAwaken","ConfigurationXueMai",i.."#".. self.select_main_index.."#"..self.select_pos)
        end)
        if i % 4 == 0 then
            list_index = list_index + 1
        end
    end
end

function WsBloodLineAwakenOBJ:flushView( ... )
	local tab = {...}
	if tab[1] == "xuemai_change_flush" then
		self.select_xuemai_info = SL:JsonDecode(tab[2]) or {}
		self.select_main_index = tonumber(tab[3])  or 1
		self:UpdaViewInfo()
		self:FlushXueMaiBtn()
	elseif tab[1] == "xuemai_reset_flush" then
		self.select_xuemai_info = SL:JsonDecode(tab[2]) or {}
		self.select_main_index = tonumber(tab[3])  or 1
		self.cur_main_index = tonumber(tab[4]) or 0
		self:UpdaViewInfo()
		self:FlushXueMaiBtn()
	elseif tab[1] =="save_active" then
	    self.cur_main_index = tonumber(tab[2]) or 0
		local str = "当前激活：血脉配置" ..self.cur_main_index
		GUI:Text_setString(self.ui.cur_active_text,self.cur_main_index > 0 and str or "当前激活：未激活") 
	end
end

-- -- 点击npc触发
-- local function onClickNpc(npc_info)
--     if WsBloodLineAwakenOBJ.NpcId == npc_info.index then
--         SendMsgClickNpc(npc_info.index.."#WsBloodLineAwaken") 
--     end
-- end
-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "WsBloodLineAwakenOBJ", onClickNpc)

return WsBloodLineAwakenOBJ