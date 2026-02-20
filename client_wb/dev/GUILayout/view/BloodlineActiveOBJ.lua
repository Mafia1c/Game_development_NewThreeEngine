local BloodlineActiveOBJ = {}
BloodlineActiveOBJ.Name = "BloodlineActiveOBJ"
BloodlineActiveOBJ.cfg = GetConfig("BloodlineAwakenCfg")
function BloodlineActiveOBJ:main(buff_list)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/BloodlineActiveUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.buff_list = SL:JsonDecode(buff_list) or {} 

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("BloodlineActiveOBJ")
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
	        		SendMsgCallFunByNpc(0,"BloodlineAwaken","ReFlushBloodLine")
		    	end
		    end
		    UIOperator:OpenCommonTipsUI(data)
		else
   			SendMsgCallFunByNpc(0,"BloodlineAwaken","ReFlushBloodLine")
		end
   		
   	end)

    for i=1,3 do
    	GUI:addOnClickEvent(self.ui["select_"..i],function ()
    		SendMsgCallFunByNpc(0,"BloodlineAwaken","SetActiveXueMai",i)
    	end)
    end
    self:UpdaViewInfo()
end

function BloodlineActiveOBJ:UpdaViewInfo()
	for i=1,3 do
		local key_name = self.buff_list[i]
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

function BloodlineActiveOBJ:flushView(buff_list)
	self.buff_list = SL:JsonDecode(buff_list) or {} 
	self:UpdaViewInfo()
end

return BloodlineActiveOBJ