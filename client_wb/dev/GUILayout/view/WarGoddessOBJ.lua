local WarGoddessOBJ = {}
WarGoddessOBJ.Name = "WarGoddessOBJ"
WarGoddessOBJ.cfg = GetConfig("WarGoddessCfg")
function WarGoddessOBJ:main(npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/WarGoddessUI", function () end)
    self.ui = GUI:ui_delegate(parent)	
    self.npc_id = tonumber(npc_id) or 0
    GUI:addOnClickEvent(self.ui.closeBtn,function ( ... )
    	ViewMgr.close("WarGoddessOBJ")
    end)

    GUI:addOnClickEvent(self.ui.upBtn,function ()
    	SendMsgCallFunByNpc(0,"WarGoddess","UpLevelClick",self.npc_id)
    end)
    self:UpdaViewInfo()
end

function WarGoddessOBJ:UpdaViewInfo()
	local cfg = self.cfg[self.npc_id]
	ItemShow_updateItem(self.ui.ItemShow_1,{index = SL:Get_ITEM_INDEX_BY_NAME(cfg.name),count=1,bgVisible=true,look=true})
	GUI:Text_setString(self.ui.name,cfg.name)
	if self.ui.rich then
		removeOBJ(self.ui.rich,self)
	end
	local str = string.format("<font color='#ffff00' >【%s】</font>击杀 <font color='#00ffe8' >%s</font> → <font color='#00ff00' >跨服BOSS</font> 必定掉落！",cfg.need_item,cfg.drop_map)
	GUI:RichText_Create(self.ui.FrameLayout, "rich",79, 45, str, 500, 18, "#c6c6ce")
	local color = SL:Get_ITEM_COUNT(cfg.need_item) >= cfg.need_item_count and 250 or 249
	ItemShow_updateItem(self.ui.needItem_1,{showCount =true,index=SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item),count=cfg.need_item_count,look=true,bgVisible=true,color = color})
	
	color = tonumber(SL:Get_MONEY_ASSOCIATED(SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item2))) >= cfg.need_item_count2 and 250 or 249 
	ItemShow_updateItem(self.ui.needItem_2,{showCount =true,index=SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item2),count=cfg.need_item_count2,look=true,bgVisible=true,color = color})
	GUI:removeAllChildren(self.ui.attr_listview)
	 self.ui = GUI:ui_delegate(self._parent)	
	for i,v in ipairs(cfg.attr_map) do
		GUI:Text_Create(self.ui.attr_listview, "attr_text"..v[1], 0,0, 18, "#"..v[2], v[1])
	end
end

function WarGoddessOBJ:flushView()
	self:UpdaViewInfo()
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "WarGoddessOBJ",["node"] = self,["is_all"] = true})
end

return WarGoddessOBJ