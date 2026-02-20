local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:Layout_setBackGroundColorType(CloseLayout, 1)
	GUI:Layout_setBackGroundColor(CloseLayout, "#000000")
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 76)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/50zh/bg4.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 802, 511, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/close2.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create nameBg
	local nameBg = GUI:Image_Create(FrameLayout, "nameBg", 192, 429, "res/custom/npc/tip.png")
	GUI:setContentSize(nameBg, 260, 36)
	GUI:setIgnoreContentAdaptWithSize(nameBg, false)
	GUI:setAnchorPoint(nameBg, 0.00, 0.00)
	GUI:setTouchEnabled(nameBg, false)
	GUI:setTag(nameBg, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 313, 311, {index = 0, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create needItem_1
	local needItem_1 = GUI:ItemShow_Create(FrameLayout, "needItem_1", 648, 139, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_1, 0.50, 0.50)
	GUI:setTag(needItem_1, 0)

	-- Create needItem_2
	local needItem_2 = GUI:ItemShow_Create(FrameLayout, "needItem_2", 721, 139, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_2, 0.50, 0.50)
	GUI:setTag(needItem_2, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(FrameLayout, "upBtn", 626, 52, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:setContentSize(upBtn, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开始打造]])
	GUI:Button_setTitleColor(upBtn, "#ffffff")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.00, 0.00)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create name
	local name = GUI:Text_Create(FrameLayout, "name", 311, 446, 18, "#ff00ff", [[元神之力·三魂]])
	GUI:Text_enableOutline(name, "#000000", 1)
	GUI:setAnchorPoint(name, 0.50, 0.50)
	GUI:setTouchEnabled(name, true)
	GUI:setTag(name, 0)

	-- Create attr_listview
	local attr_listview = GUI:ListView_Create(FrameLayout, "attr_listview", 594, 240, 183, 197, 1)
	GUI:ListView_setClippingEnabled(attr_listview, false)
	GUI:ListView_setItemsMargin(attr_listview, 10)
	GUI:setAnchorPoint(attr_listview, 0.00, 0.00)
	GUI:setTouchEnabled(attr_listview, false)
	GUI:setTag(attr_listview, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
