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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/50zh/bg3.png")
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
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 186, 448, {index = 0, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create needItem_1
	local needItem_1 = GUI:ItemShow_Create(FrameLayout, "needItem_1", 642, 139, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_1, 0.50, 0.50)
	GUI:setTag(needItem_1, 0)

	-- Create needItem_2
	local needItem_2 = GUI:ItemShow_Create(FrameLayout, "needItem_2", 723, 139, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
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

	-- Create attr1
	local attr1 = GUI:Text_Create(FrameLayout, "attr1", 596, 417, 18, "#ffffff", [[双	防：111-444]])
	GUI:setIgnoreContentAdaptWithSize(attr1, false)
	GUI:Text_setTextAreaSize(attr1, 174, 27)
	GUI:Text_setTextVerticalAlignment(attr1, 1)
	GUI:Text_enableOutline(attr1, "#000000", 1)
	GUI:setAnchorPoint(attr1, 0.00, 0.00)
	GUI:setTouchEnabled(attr1, false)
	GUI:setTag(attr1, 0)

	-- Create attr2
	local attr2 = GUI:Text_Create(FrameLayout, "attr2", 596, 380, 18, "#ffffff", [[双	防：111-444]])
	GUI:setIgnoreContentAdaptWithSize(attr2, false)
	GUI:Text_setTextAreaSize(attr2, 174, 27)
	GUI:Text_setTextVerticalAlignment(attr2, 1)
	GUI:Text_enableOutline(attr2, "#000000", 1)
	GUI:setAnchorPoint(attr2, 0.00, 0.00)
	GUI:setTouchEnabled(attr2, false)
	GUI:setTag(attr2, 0)

	-- Create attr3
	local attr3 = GUI:Text_Create(FrameLayout, "attr3", 596, 343, 18, "#ffffff", [[双	防：111-444]])
	GUI:setIgnoreContentAdaptWithSize(attr3, false)
	GUI:Text_setTextAreaSize(attr3, 174, 27)
	GUI:Text_setTextVerticalAlignment(attr3, 1)
	GUI:Text_enableOutline(attr3, "#000000", 1)
	GUI:setAnchorPoint(attr3, 0.00, 0.00)
	GUI:setTouchEnabled(attr3, false)
	GUI:setTag(attr3, 0)

	-- Create attr4
	local attr4 = GUI:Text_Create(FrameLayout, "attr4", 596, 306, 18, "#ffffff", [[双	防：111-444]])
	GUI:setIgnoreContentAdaptWithSize(attr4, false)
	GUI:Text_setTextAreaSize(attr4, 174, 27)
	GUI:Text_setTextVerticalAlignment(attr4, 1)
	GUI:Text_enableOutline(attr4, "#000000", 1)
	GUI:setAnchorPoint(attr4, 0.00, 0.00)
	GUI:setTouchEnabled(attr4, false)
	GUI:setTag(attr4, 0)

	-- Create attr5
	local attr5 = GUI:Text_Create(FrameLayout, "attr5", 596, 269, 18, "#00ff00", [[体力增加：300%]])
	GUI:setIgnoreContentAdaptWithSize(attr5, false)
	GUI:Text_setTextAreaSize(attr5, 174, 27)
	GUI:Text_setTextVerticalAlignment(attr5, 1)
	GUI:Text_enableOutline(attr5, "#000000", 1)
	GUI:setAnchorPoint(attr5, 0.00, 0.00)
	GUI:setTouchEnabled(attr5, false)
	GUI:setTag(attr5, 0)

	-- Create attr6
	local attr6 = GUI:Text_Create(FrameLayout, "attr6", 596, 232, 18, "#ff00ff", [[体力增加：300%]])
	GUI:setIgnoreContentAdaptWithSize(attr6, false)
	GUI:Text_setTextAreaSize(attr6, 174, 27)
	GUI:Text_setTextVerticalAlignment(attr6, 1)
	GUI:Text_enableOutline(attr6, "#000000", 1)
	GUI:setAnchorPoint(attr6, 0.00, 0.00)
	GUI:setTouchEnabled(attr6, false)
	GUI:setTag(attr6, 0)

	-- Create name
	local name = GUI:Text_Create(FrameLayout, "name", 324, 446, 18, "#ff00ff", [[元神之力·三魂]])
	GUI:Text_enableOutline(name, "#000000", 1)
	GUI:setAnchorPoint(name, 0.50, 0.50)
	GUI:setTouchEnabled(name, true)
	GUI:setTag(name, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
