local AncientDressmakerOBJ = {}
AncientDressmakerOBJ.Name = "AncientDressmakerOBJ"
AncientDressmakerOBJ.cfg = GetConfig("AncientDressmakerCfg")
AncientDressmakerOBJ.cfg_map = {}
for i,v in ipairs(AncientDressmakerOBJ.cfg) do
    AncientDressmakerOBJ.cfg_map[v.npc_id] = AncientDressmakerOBJ.cfg_map[v.npc_id] or {}
    table.insert(AncientDressmakerOBJ.cfg_map[v.npc_id],v) 
end 
function AncientDressmakerOBJ:main(npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/AncientDressmakerUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    GUI:addOnClickEvent(self.ui.closeBtn,function ()
    	ViewMgr.close("AncientDressmakerOBJ")
    end)
    self.npc_id = tonumber(npc_id) or 0
    self.tag_btn_index = 1

    GUI:addOnClickEvent(self.ui.forge_btn,function ()
    	SendMsgCallFunByNpc(0,"AncientDressmaker","ForgeClick",self.npc_id.."#"..self.tag_btn_index)
    end)
    self:UpdaViewInfo()

end

function AncientDressmakerOBJ:UpdaViewInfo()
	local cfg = self.cfg_map[self.npc_id]
	GUI:Button_setTitleText(self.ui.Button_1,cfg[1].name) 
	for i,v in ipairs(cfg) do
		local img = GUI:Image_Create(self.ui.pageList_2,"tag"..i,0,0,"res/custom/npc/bt1.png")
		GUI:setTouchEnabled(img, true)
		GUI:addOnClickEvent(img,function ()
			self.tag_btn_index = i
			self:FlushRight()
		end)
		local text = GUI:Text_Create(img,"tag_name"..i,58,21,16,"#ffffff",v.tag_name)
		GUI:setAnchorPoint(text,0.5,0.5)

	end
	self:FlushRight()
end
function AncientDressmakerOBJ:FlushRight()
	for i,v in ipairs(self.cfg_map[self.npc_id]) do
		GUI:Image_loadTexture(self.ui["tag"..i], i == self.tag_btn_index and "res/custom/npc/bt2.png" or "res/custom/npc/bt1.png")
	end
	local cfg = self.cfg_map[self.npc_id][self.tag_btn_index]
	GUI:Text_setString(self.ui.equipName,cfg.tag_name) 
	ItemShow_updateItem(self.ui.EquipItem,{index=SL:Get_ITEM_INDEX_BY_NAME(cfg.tag_name),look=true,bgVisible=true})
	for i,v in ipairs(cfg.need_item_list_map) do
		local color = SL:Get_ITEM_COUNT(v[1]) >= v[2] and 250 or 249
		ItemShow_updateItem(self.ui["ItemShow_"..i],{index=SL:Get_ITEM_INDEX_BY_NAME(v[1]),look=true,bgVisible=true,count = v[2],color = color})
	end
	GUI:setVisible(self.ui["ItemShow_5"], #cfg.need_item_list_map >= 5)
	-- GUI:Text_setString(self.ui.money_text,cfg.need_money.."*"..cfg.need_money_count) 
	local red_list = {}
	red_list.view_name = "AncientDressmakerOBJ"
	red_list.node = self
	red_list.forge_btn =  RedPointMgr.GetRedDataByBtnName("AncientDressmakerOBJ","forge_btn")
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_list)
end

function AncientDressmakerOBJ:ForgeBtnRed()
	if AncientDressmakerOBJ.npc_id == nil or AncientDressmakerOBJ.tag_btn_index == nil then return false end
	local cfg = AncientDressmakerOBJ.cfg_map[AncientDressmakerOBJ.npc_id][AncientDressmakerOBJ.tag_btn_index]
	for i,v in ipairs(cfg.need_item_list_map) do
		if SL:Get_ITEM_COUNT(v[1]) < v[2] then
			return false
		end
	end
	return true
end

function AncientDressmakerOBJ:flushView()
	self:FlushRight()
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "AncientDressmakerOBJ",["node"] = self,["is_all"] = true})
end

return AncientDressmakerOBJ