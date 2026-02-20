local BloodlineRebuildOBJ = {}
BloodlineRebuildOBJ.Name = "BloodlineRebuildOBJ"
BloodlineRebuildOBJ.cfg = GetConfig("BloodlineAwakenCfg")
function BloodlineRebuildOBJ:main(...)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/BloodlineRebuildUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    local param_tab = {...}
	self.select_pos = tonumber(param_tab[2]) 
    if param_tab[1] == "show_select" then
    	self.select_pos_key = tonumber(param_tab[3]) 
    	self:ShowSelectInfo()
    end

    GUI:setVisible(self.ui.show_select_node,param_tab[1] == "show_select")
    GUI:setVisible(self.ui.rebuild_node,param_tab[1] == "show_rebuld") 

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("BloodlineRebuildOBJ")
    end)

    GUI:addOnClickEvent(self.ui.cancel_btn, function()
        ViewMgr.close("BloodlineRebuildOBJ")
    end)

    GUI:addOnClickEvent(self.ui.start_rebuild_btn, function()
    	local data = {}
	    data.str = "刷新后不选择将会失去刷新记录，是否确定开始重修？！"
	    data.btnType = 2
	    data.callback = function(atype, param)
	        if atype == 1 then
        		SendMsgCallFunByNpc(0,"BloodlineAwaken","OnClickRebuildBtn",self.select_pos)
	    	end
	    end
	    UIOperator:OpenCommonTipsUI(data)
    end)
   	
   	GUI:addOnClickEvent(self.ui.reflush_btn,function ()
   		local is_show_tip = false
   		for i,v in pairs(self.buff_list or {}) do
   		 	if self.cfg[v].xuemai_type == 333 then
   		 		is_show_tip = true
   		 		break
   		 	end
   		end 
   		if is_show_tip then
	   		local data = {}
		    data.str = "已刷新出传说血脉，确定继续刷新吗？！"
		    data.btnType = 2
		    data.callback = function(atype, param)
		        if atype == 1 then
	        		SendMsgCallFunByNpc(0,"BloodlineAwaken","OnClickRebuildBtn",self.select_pos)
		    	end
		    end
		    UIOperator:OpenCommonTipsUI(data)
		else
   			SendMsgCallFunByNpc(0,"BloodlineAwaken","RebuildFlushBloodLine",self.select_pos)
		end
   	end)

    for i=1,3 do
    	GUI:addOnClickEvent(self.ui["select_"..i],function ()
    		SendMsgCallFunByNpc(0,"BloodlineAwaken","SetRebuildXueMai",i.."#"..self.select_pos)
    	end)
    end
end

function BloodlineRebuildOBJ:ShowSelectInfo()
	local key_name = self.select_pos_key
	local cfg = self.cfg[key_name]
	GUI:Image_loadTexture(self.ui.select_kapai,string.format("res/custom/npc/12tmfw/2/k%s.png",cfg.xuemai_type)) 
	GUI:Image_loadTexture(self.ui.select_icon,string.format("res/custom/npc/12tmfw/icon/%s.png",(cfg.icon or 1) *100)) 
	GUI:Image_loadTexture(self.ui.select_quality,string.format("res/custom/npc/12tmfw/2/t%s.png",cfg.xuemai_type)) 
	GUI:Text_setString(self.ui.select_name,cfg.name) 
	GUI:Text_setTextColor(self.ui.select_name,SL:GetHexColorByStyleId(cfg.color))
	removeOBJ(self.ui["select_desc_list"],self)
	local list = GUI:ListView_Create(self.ui.select_kapai ,"select_desc_list", 35, 25, 144, 140, 1)
	GUI:ListView_setBounceEnabled(list, true)
	GUI:ListView_setClippingEnabled(list, true)
	GUI:RichTextFCOLOR_Create(list, "select_desc", 0, 0,"<符文属性：/FCOLOR=251>\\".. cfg.desc, 144, 16)
	GUI:Text_setString(self.ui.count_text,"拥有天命石："..SL:Get_ITEM_COUNT("天命石"))
end

function BloodlineRebuildOBJ:UpdaViewInfo()
	for i=1,3 do
		local key_name = self.buff_list[i]
		GUI:setVisible(self.ui["kapai_"..i],key_name ~= nil)
		if key_name ~= nil then
			local cfg = self.cfg[key_name]
			GUI:Image_loadTexture(self.ui["kapai_"..i],string.format("res/custom/npc/12tmfw/2/k%s.png",cfg.xuemai_type)) 
			GUI:Image_loadTexture(self.ui["icon_"..i],string.format("res/custom/npc/12tmfw/icon/%s.png",(cfg.icon or 1) *100)) 
			GUI:Image_loadTexture(self.ui["quality_"..i],string.format("res/custom/npc/12tmfw/2/t%s.png",cfg.xuemai_type)) 
			GUI:Text_setString(self.ui["name_"..i],cfg.name) 
			GUI:Text_setTextColor(self.ui["name_"..i],SL:GetHexColorByStyleId(cfg.color))
			removeOBJ(self.ui["desc_list"..i],self)
			local list = GUI:ListView_Create(self.ui["kapai_"..i] , "desc_list"..i, 35, 25, 144, 140, 1)
			GUI:ListView_setBounceEnabled(list, true)
			GUI:ListView_setClippingEnabled(list, true)
			GUI:RichTextFCOLOR_Create(list, "desc"..i, 0, 0,"<符文属性：/FCOLOR=251>\\".. cfg.desc, 144, 16)
		end
	end
	GUI:Text_setString(self.ui.count_text,"拥有天命石："..SL:Get_ITEM_COUNT("天命石"))
end

function BloodlineRebuildOBJ:flushView(...)
	local param_tab = {...}
	if param_tab[1] == "show_rebuld" then
		self.select_pos = tonumber(param_tab[2]) 
		self.buff_list = SL:JsonDecode(param_tab[3]) or {} 
		self:UpdaViewInfo()
	end
	GUI:setVisible(self.ui.show_select_node,param_tab[1] == "show_select")
    GUI:setVisible(self.ui.rebuild_node,param_tab[1] == "show_rebuld") 
end

return BloodlineRebuildOBJ