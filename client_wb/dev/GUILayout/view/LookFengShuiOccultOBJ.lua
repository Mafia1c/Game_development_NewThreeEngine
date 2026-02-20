local LookFengShuiOccultOBJ = {}
LookFengShuiOccultOBJ.Name = "LookFengShuiOccultOBJ"
LookFengShuiOccultOBJ.cfg =GetConfig("FengShuiOccultCfg")
LookFengShuiOccultOBJ.suit_cfg =GetConfig("FengShuiOccultSuitCfg")
function LookFengShuiOccultOBJ:main(data,name)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LookFengShuiOccultUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close("LookFengShuiOccultOBJ")
    end)
    self.data = SL:JsonDecode(data) or {}
    self:UpdaViewInfo()
    GUI:Text_setString(self.ui.look_name,"["..name.."·风水秘术]")
    GUI:addOnClickEvent(self.ui.need_text,function ()
    	local pos = GUI:getWorldPosition(self.ui.need_text)
		UIOperator:OpenItemTips({itemData = SL:GetMetaValue("ITEM_DATA", SL:Get_ITEM_INDEX_BY_NAME("罗盘")),pos = pos})
    end)
end

function LookFengShuiOccultOBJ:UpdaViewInfo()
	for i,v in ipairs(self.cfg) do
		if self.ui["occult_fram"..i] then
			removeOBJ(self.ui["occult_fram"..i],self)
		end
		local format_str = (self.data[i] or 0) > 0  and "res/custom/npc/31mishu/ef1/%s/ef" or "res/custom/npc/31mishu/ef/%s/ef"
		local fram = GUI:Frames_Create(self.ui["occult_node_"..i], "occult_fram"..i, -19,-20, string.format(format_str,i), ".png", 1, 15)
		GUI:setTouchEnabled(fram,true)
		GUI:addOnClickEvent(fram,function ()
			local pos = GUI:getWorldPosition(self.ui["occult_node_"..i])
    		UIOperator:OpenItemTips({itemData = SL:GetMetaValue("ITEM_DATA", SL:Get_ITEM_INDEX_BY_NAME(v.name)),pos = pos})
		end)
	end
	GUI:removeAllChildren(self.ui.suit_list_view)
	self.ui = GUI:ui_delegate(self._parent)
	for i,v in ipairs(self.suit_cfg) do
		local is_active = self:GetActiveNum() >= v.active_num  
		local img = GUI:Image_Create(self.ui.suit_list_view,"suit_bg"..i,0,0,"res/custom/npc/31mishu/list.png")
		GUI:Image_Create(img,"title_bg"..i,13,8,string.format("res/custom/npc/31mishu/at%s.png",v.active_num))
		local icon_img = GUI:Image_Create(img,"icon"..i,61,26,string.format("res/custom/npc/31mishu/ai%s.png",v.active_num))
		GUI:Image_setGrey(icon_img, not is_active)
		if not is_active then
			GUI:Image_Create(img,"icon_lock"..i,61,27,"res/custom/npc/31mishu/lock.png")
		end
		GUI:Text_Create(img,"active_state"..i,68,6,16,is_active and "#00ff00" or "#ff0000",is_active and "已激活" or "未激活")
		local righ = GUI:RichTextFCOLOR_Create(img,"rich"..i,139,53,v.suit_desc,160,16,"#FFFFFF")
		GUI:setAnchorPoint(righ,0,0.5)
	end
end

function LookFengShuiOccultOBJ:GetActiveNum()
    local num = 0
    for i,v in ipairs(self.data) do
        if v > 0 then
            num = num + 1
        end
    end
    return num
end
return LookFengShuiOccultOBJ