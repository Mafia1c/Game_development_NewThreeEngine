local LookWsBloodlineActiveOBJ = {}
LookWsBloodlineActiveOBJ.Name = "LookWsBloodlineActiveOBJ"
LookWsBloodlineActiveOBJ.cfg = GetConfig("WsbloodLineCfg")

function LookWsBloodlineActiveOBJ:main(info1,info2,cur_main_index,name)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    self.ui = GUI:ui_delegate(parent)
    GUI:LoadExport(parent, "npc/LookWsBloodLineAwakenUI", function () end)

    self.select_index = 1
    self.cur_main_index = tonumber(cur_main_index) or 0

    self.xuemai_info1 = SL:JsonDecode(info1) or {}
    self.xuemai_info2 = SL:JsonDecode(info2) or {} 
    GUI:addOnClickEvent(self.ui.closeBtn,function ()
    	ViewMgr.close("LookWsBloodlineActiveOBJ")
    end)
    GUI:Text_setString(self.ui.player_name,string.format("[%s·无双血脉]",name))
    for i=1,2 do
    	GUI:addOnClickEvent(self.ui["xuemai_btn"..i],function ()
    		self.select_index = i  
    		self:FlushXueMaiBtn()
    		self:UpdaViewInfo() 
    	end)
    end
    self:UpdaViewInfo()
    self:FlushXueMaiBtn()
end


function LookWsBloodlineActiveOBJ:FlushXueMaiBtn()
	for i=1,2 do
		local path = i == 1 and "res/custom/npc/35xm/2/an4" or "res/custom/npc/35xm/2/an5"
		GUI:Button_loadTextureNormal(self.ui["xuemai_btn"..i],i == self.select_index and path ..".png "or path.."_1.png") 
    end
end

function LookWsBloodlineActiveOBJ:UpdaViewInfo()
	local active_level = 0
	for i=1,12 do
		local key_name = self["xuemai_info"..self.select_index][i]
		if key_name and key_name >= 0 then
			active_level = active_level + 1
		end
		GUI:setVisible(self.ui["lock"..i],key_name == nil or key_name < 0)
		GUI:setVisible(self.ui["icon"..i],key_name ~= nil and key_name > 0)
		if key_name and key_name > 0 then
			GUI:Image_loadTexture(self.ui["icon"..i],string.format("res/custom/npc/35xm/icon/%s.png",self.cfg[key_name].xuemai_icon) )
			GUI:addOnClickEvent(self.ui["icon"..i],function ()
				local item_data  = SL:Get_ITEM_DATA(SL:Get_ITEM_INDEX_BY_NAME(self.cfg[key_name].xuemai_name))
				UIOperator:OpenItemTips({itemData =item_data})
			end)
		end
	end
	GUI:setVisible(self.ui.line_img,active_level > 1)
	GUI:Image_loadTexture(self.ui.line_img,string.format("res/custom/npc/35xm/2/jd%s.png",active_level - 1) )
	local str = "当前激活：血脉配置" ..self.cur_main_index
	GUI:Text_setString(self.ui.cur_active_text,self.cur_main_index > 0 and str or "当前激活：未激活") 
end


return LookWsBloodlineActiveOBJ