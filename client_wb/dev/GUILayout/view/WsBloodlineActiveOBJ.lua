local WsBloodlineActiveOBJ = {}
WsBloodlineActiveOBJ.Name = "WsBloodlineActiveOBJ"
WsBloodlineActiveOBJ.cfg = GetConfig("WsbloodLineCfg")

function WsBloodlineActiveOBJ:main(data)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.ui = GUI:ui_delegate(parent)
    GUI:LoadExport(parent, "npc/WsBloodlineActiveUI", function () end)
    local data = SL:JsonDecode(data)
    self.xuemai_list = data.list or {}
    self.select_index = tonumber(data.select_flag) or 0 
    GUI:addOnClickEvent(self.ui.close_btn,function ( ... )
    	ViewMgr.close("WsBloodlineActiveOBJ")
    end)

    GUI:addOnClickEvent(self.ui.reflush_btn,function ()
    	SendMsgCallFunByNpc(0,"WsBloodLineAwaken","ClickFlushBtn")	
    end)
    for i=1,3 do
    	GUI:addOnClickEvent(self.ui["select_"..i],function ()
	    	SendMsgCallFunByNpc(0,"WsBloodLineAwaken","SetXueMaiList",i)	
	    end)

    end
    self:UpdaViewInfo()
end

function WsBloodlineActiveOBJ:UpdaViewInfo()
	for i=1,3 do
		local tab = string.split(self.xuemai_list[i],"|") 
		local cfg = WsBloodlineActiveOBJ.cfg[tonumber(tab[1])]
		if cfg then
			GUI:Image_loadTexture(self.ui["kapai_"..i],string.format("res/custom/npc/35xm/3/k%s.png",cfg.bg) ) 
			GUI:Text_setString(self.ui["name_"..i],cfg.xuemai_name)
			GUI:Text_setTextColor(self.ui["name_"..i],SL:GetHexColorByStyleId(cfg.color))
			GUI:Image_loadTexture(self.ui["icon_"..i],string.format("res/custom/npc/35xm/icon/%s.png",cfg.xuemai_icon))
			removeOBJ(self.ui["desc_list"..i],self)
			local list = GUI:ListView_Create(self.ui["kapai_"..i] , "desc_list"..i, 35, 25, 144, 140, 1)
			GUI:ListView_setBounceEnabled(list, true)
			GUI:ListView_setClippingEnabled(list, true)
			GUI:RichTextFCOLOR_Create(list, "desc"..i, 0, 0,"<符文属性：/FCOLOR=251>\\".. cfg.desc, 144, 16)
			GUI:setVisible(self.ui["yihuode_img"..i],self.select_index == i)
			GUI:setVisible(self.ui["select_"..i],self.select_index ~= i)
			GUI:Button_setBrightEx(self.ui["select_"..i], not (self.select_index ~= i and self.select_index ~= 0))
			GUI:Button_setGrey(self.ui["select_"..i], self.select_index ~= i and self.select_index ~= 0)
		end
	end
end
function WsBloodlineActiveOBJ:flushView(data)
    local data = SL:JsonDecode(data)
    self.xuemai_list = data.list or {}
    self.select_index = tonumber(data.select_flag) or 0 
	self:UpdaViewInfo()
end

return WsBloodlineActiveOBJ