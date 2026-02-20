local SpiritPowerOBJ = {}
SpiritPowerOBJ.Name = "SpiritPowerOBJ"
SpiritPowerOBJ.cfg = GetConfig("SpiritPowerCfg")
function SpiritPowerOBJ:main(key)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/SpiritPowerUI", function () end)
    self.ui = GUI:ui_delegate(parent)	
    self.key = tonumber(key) or 1
    GUI:addOnClickEvent(self.ui.closeBtn,function ( ... )
    	ViewMgr.close("SpiritPowerOBJ")
    end)

    GUI:addOnClickEvent(self.ui.upBtn,function ()
    	SendMsgCallFunByNpc(0,"SpiritPower","UpLevelClick",self.key)
    end)
    self:UpdaViewInfo()
end

function SpiritPowerOBJ:UpdaViewInfo()
	local cfg = self.cfg[self.key]
	ItemShow_updateItem(self.ui.ItemShow_1,{index = SL:Get_ITEM_INDEX_BY_NAME(cfg.name),count=1,bgVisible=true,look=true})
	GUI:Text_setString(self.ui.name,cfg.name)
	if self.ui.effect then
		removeOBJ(self.ui.effect,self)
	end
	GUI:Effect_Create(self.ui.FrameLayout, "effect", 219, 318, 0, cfg.effect_id)
	if self.ui.rich then
		removeOBJ(self.ui.rich,self)
	end
	local str = string.format("<font color='#ffff00' >【%s】</font>击杀 <font color='#00ffe8' >%s</font> → <font color='#00ff00' >跨服BOSS</font> 必定掉落！",cfg.need_item1,cfg.drop_map)
	GUI:RichText_Create(self.ui.FrameLayout, "rich",79, 45, str, 500, 18, "#c6c6ce")

	local color = SL:Get_ITEM_COUNT(cfg.need_item1) >= cfg.need_item_count1 and 250 or 249
	ItemShow_updateItem(self.ui.needItem_1,{showCount =true,index=SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item1),count=cfg.need_item_count1,look=true,bgVisible=true,color = color})
	
	local item_index = SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item2)
	local count = 0
	if item_index > 10000 then
		count = SL:Get_ITEM_COUNT(cfg.need_item2)
	else
		count = tonumber(SL:Get_MONEY_ASSOCIATED(item_index)) 
	end
	color = count >= cfg.need_item_count2 and 250 or 249
	ItemShow_updateItem(self.ui.needItem_2,{showCount =true,index=SL:Get_ITEM_INDEX_BY_NAME(cfg.need_item2),count=cfg.need_item_count2,look=true,bgVisible=true,color = color})

	GUI:Text_setString(self.ui.attr1,"双	        防：".. cfg.defense1 .."-"..cfg.defense2)
	GUI:Text_setString(self.ui.attr2,"攻	        击：".. cfg.atk1 .."-"..cfg.atk2)
	GUI:Text_setString(self.ui.attr3,"魔	        法：".. cfg.atk1 .."-"..cfg.atk2)
	GUI:Text_setString(self.ui.attr4,"道	        术：".. cfg.atk1 .."-"..cfg.atk2)
	GUI:Text_setString(self.ui.attr5,"体力增加：".. cfg.hp .."%")
	GUI:Text_setString(self.ui.attr6,"攻击倍数：".. cfg.atk_per .."%")
end

function SpiritPowerOBJ:flushView()
	self:UpdaViewInfo()
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "SpiritPowerOBJ",["node"] = self,["is_all"] = true})
end

return SpiritPowerOBJ