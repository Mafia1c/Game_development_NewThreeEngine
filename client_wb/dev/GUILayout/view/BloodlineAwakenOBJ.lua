local BloodlineAwakenOBJ = {}
BloodlineAwakenOBJ.Name = "BloodlineAwakenOBJ"
BloodlineAwakenOBJ.cfg = GetConfig("BloodlineAwakenCfg")
BloodlineAwakenOBJ.NpcId = 72
function BloodlineAwakenOBJ:main(xuemai_data,can_active_count)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/BloodlineAwakenUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.select_pos = -1
    GUI:addOnClickEvent(self.ui.close_btn, function()
        ViewMgr.close("BloodlineAwakenOBJ")
    end)

    GUI:addOnClickEvent(self.ui.active_btn,function ()
    	SendMsgCallFunByNpc(BloodlineAwakenOBJ.NpcId,"BloodlineAwaken","OnClickOpenActiveView") 
    end)

    GUI:addOnClickEvent(self.ui.reset_btn,function ()
    	SendMsgCallFunByNpc(BloodlineAwakenOBJ.NpcId,"BloodlineAwaken","OnClickOpenRebuildView",self.select_pos) 
    end)

    GUI:addOnClickEvent(self.ui.tujian_btn,function ()
    	ViewMgr.open("BloodlineTuJianOBJ")
    end)
    
    self.xuemai_data = SL:JsonDecode(xuemai_data) or {}
    self.can_active_count = tonumber(can_active_count) or 0 
    self:InItInfo()
    self:UpdaViewInfo()
end

function BloodlineAwakenOBJ:InItInfo()
	GUI:setVisible(self.ui.no_select_text,true) 
	for i=1,60 do
		GUI:addOnClickEvent(self.ui["xuemai_bg"..i],function ()
			self:FlushRightInfo(i)
		end)
	end
end

function BloodlineAwakenOBJ:FlushRightInfo(index)
	local key_name = self.xuemai_data[index]
	local is_big_item = index % 6 == 0
	local is_active = key_name~=nil and key_name > 0
	if not is_active then
		return 
	end
	removeOBJ(self.ui.select_effect,self)
	removeOBJ(self.ui.select_layer_rich,self)
	GUI:setVisible(self.ui.select_bg,true) 
	GUI:setVisible(self.ui.no_select_text,false) 
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
	local layer_str = string.format("%s/<font color='#ff0000'>%s层</font>",self:GetXueMaiLayer(key_name),cfg.max_layer) 
	GUI:RichText_Create(self.ui.select_bg, "select_layer_rich", 115, 277, layer_str, 100, 18,"#FFFFFF")

	local list = GUI:ListView_Create(self.ui.select_bg , "desc_list", 24, 64, 178, 174, 1)
	GUI:ListView_setBounceEnabled(list, true)
	GUI:ListView_setClippingEnabled(list, true)
	GUI:RichTextFCOLOR_Create(list, "select_desc", 0, 0,cfg.desc, 178, 18)
end

function BloodlineAwakenOBJ:UpdaViewInfo()
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

	GUI:Text_setString(self.ui.can_active_text,string.format("剩余激活次数：%s次",self.can_active_count)) 
end

function BloodlineAwakenOBJ:flushView(...)
	local tab ={...}
	if tab[1] == "active_flush" then
		self.xuemai_data = SL:JsonDecode(tab[2]) or {}
	    self.can_active_count = tonumber(tab[3]) or 0 
	    self:UpdaViewInfo()
	  	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "BloodlineAwakenOBJ",["node"] = self,["is_all"] = true})
	elseif tab[1] == "rebuild" then
		self.xuemai_data = SL:JsonDecode(tab[2]) or {}
	    self.select_pos = tonumber(tab[3])
	    self:UpdaViewInfo()
	    self:FlushRightInfo(self.select_pos)
	end
end

--获取当前多少层
function BloodlineAwakenOBJ:GetXueMaiLayer(key_name)
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

function BloodlineAwakenOBJ:GetActiveBtnShow()
	local level = SL:Get_LEVEL()
    if  level <= 40 then
        return 0
    end
    local bloodline_list = GameData.GetData("T_bloodline_state", true)
    if bloodline_list == nil or  bloodline_list == "" then
        bloodline_list = {}
    end
    if level > 100 then
        level = 100
    end
    return (level - 40 - #bloodline_list) > 0
end


-- 点击npc触发
local function onClickNpc(npc_info)
    if BloodlineAwakenOBJ.NpcId == npc_info.index then
        SendMsgClickNpc(BloodlineAwakenOBJ.NpcId.."#BloodlineAwaken") 
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "BloodlineAwakenOBJ", onClickNpc)

return BloodlineAwakenOBJ