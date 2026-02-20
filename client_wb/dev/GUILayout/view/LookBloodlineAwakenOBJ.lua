local LookBloodlineAwakenOBJ = {}
LookBloodlineAwakenOBJ.Name = "LookBloodlineAwakenOBJ"
LookBloodlineAwakenOBJ.cfg = GetConfig("BloodlineAwakenCfg")
LookBloodlineAwakenOBJ.NpcId = 72
function LookBloodlineAwakenOBJ:main(xuemai_data,name)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LookBloodlineAwakenUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.select_pos = -1
    GUI:addOnClickEvent(self.ui.close_btn, function()
        ViewMgr.close("LookBloodlineAwakenOBJ")
    end)
    self.xuemai_data = SL:JsonDecode(xuemai_data) or {}
    self.name = name
    self:InItInfo()
    self:UpdaViewInfo()
end

function LookBloodlineAwakenOBJ:InItInfo()
	GUI:setVisible(self.ui.no_select_text,true) 
	GUI:setVisible(self.ui.select_name,false) 
	GUI:setVisible(self.ui.select_node,false) 
	for i=1,60 do
		GUI:addOnClickEvent(self.ui["xuemai_bg"..i],function ()
			self:FlushRightInfo(i)
		end)
	end
	GUI:Text_setString(self.ui.player_name,string.format("[%s·天命]",self.name) ) 
end

function LookBloodlineAwakenOBJ:FlushRightInfo(index)
	local key_name = self.xuemai_data[index]
	local is_big_item = index % 6 == 0
	local is_active = key_name~=nil and key_name > 0
	if not is_active then
		return 
	end
	removeOBJ(self.ui.select_effect,self)
	removeOBJ(self.ui.select_layer_rich,self)
	GUI:setVisible(self.ui.select_node,true) 
	GUI:setVisible(self.ui.no_select_text,false) 
	GUI:setVisible(self.ui.select_name,true) 
	removeOBJ(self.ui["desc_list"],self)
	if is_big_item then
		GUI:Effect_Create(self.ui["xuemai_bg"..index], "select_effect", 6, 49, 0, 16012)
	else
		GUI:Effect_Create(self.ui["xuemai_bg"..index], "select_effect", 5, 34, 0, 16013)
	end
	local cfg = self.cfg[key_name]
	self.select_pos = index
	ItemShow_updateItem(self.ui.select_item,{index = SL:GetMetaValue("ITEM_INDEX_BY_NAME", cfg.name),count=1,bgVisible=false,look =false})
	GUI:Text_setString(self.ui.select_name,cfg.name)
	GUI:Text_setTextColor(self.ui.select_name,SL:GetHexColorByStyleId(cfg.color)) 
	-- local layer_str = string.format("%s/<font color='#ff0000'>%s层</font>",self:GetXueMaiLayer(key_name),cfg.max_layer) 
	-- GUI:RichText_Create(self.ui.select_bg, "select_layer_rich", 115, 277, layer_str, 100, 18,"#FFFFFF")

	local list = GUI:ListView_Create(self.ui.select_node , "desc_list", 24, 64, 178, 174, 1)
	GUI:ListView_setBounceEnabled(list, true)
	GUI:ListView_setClippingEnabled(list, true)
	GUI:RichTextFCOLOR_Create(list, "select_desc", 0, 0,cfg.desc, 178, 18)
end

function LookBloodlineAwakenOBJ:UpdaViewInfo()
	for i=1,60 do
		local key_name = self.xuemai_data[i]
		local is_big_item = i % 6 == 0
		local icon_bg_path = ""
		local is_active = key_name ~= nil and key_name > 0
		removeOBJ(self.ui["xuemai_icon_"..i],self )
		if is_active then
			local cfg = self.cfg[key_name]
			icon_bg_path = is_big_item and "res/custom/npc/12tmfw/k2.png"  or "res/custom/npc/12tmfw/k1.png" 
			local pos = cfg.xuemai_type==444 and 6 or 3
			GUI:Image_Create(self.ui["xuemai_bg"..i],"xuemai_icon_"..i,pos,pos,string.format("res/custom/npc/12tmfw/icon/%s.png",cfg.xuemai_type==444 and cfg.icon *100 or cfg.icon))
		else
			icon_bg_path = is_big_item and "res/custom/npc/12tmfw/s2.png"  or "res/custom/npc/12tmfw/s1.png" 
		end
		GUI:Image_loadTexture(self.ui["xuemai_bg"..i],icon_bg_path)
	end
end

--获取当前多少层
function LookBloodlineAwakenOBJ:GetXueMaiLayer(key_name)
    if self.xuemai_data == "" then return 0 end
    local max_layer = self.cfg[key_name].max_layer
    local count = 0
    for i,v in ipairs(self.xuemai_data) do
        if v == key_name then
            count = count + 1
        end
    end  
    return count
end

-- -- 点击npc触发
-- local function onClickNpc(npc_info)
--     if BloodlineAwakenOBJ.NpcId == npc_info.index then
--         SendMsgClickNpc(BloodlineAwakenOBJ.NpcId.."#BloodlineAwaken") 
--     end
-- end
-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "BloodlineAwakenOBJ", onClickNpc)

return LookBloodlineAwakenOBJ