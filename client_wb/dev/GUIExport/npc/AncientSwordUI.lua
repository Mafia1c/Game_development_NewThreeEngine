local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:Layout_setBackGroundColorType(CloseLayout, 1)
	GUI:Layout_setBackGroundColor(CloseLayout, "#f8e6c6")
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 0)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/47jx/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 784, 493, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/close2.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleDisableOutLine(closeBtn)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create equipName
	local equipName = GUI:Text_Create(FrameLayout, "equipName", 560, 449, 18, "#ff00ff", [[耀光]])
	GUI:Text_enableOutline(equipName, "#000000", 2)
	GUI:setAnchorPoint(equipName, 0.50, 0.50)
	GUI:setTouchEnabled(equipName, false)
	GUI:setTag(equipName, 0)

	-- Create ItemNode
	local ItemNode = GUI:Node_Create(FrameLayout, "ItemNode", 564, 234)
	GUI:setTag(ItemNode, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(ItemNode, "ItemShow_1", -170, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(ItemNode, "ItemShow_2", -85, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(ItemNode, "ItemShow_3", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(ItemNode, "ItemShow_4", 85, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(ItemNode, "ItemShow_5", 170, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 546, 273, "res/custom/npc/47jx/ar.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create EquipItem
	local EquipItem = GUI:ItemShow_Create(FrameLayout, "EquipItem", 562, 362, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(EquipItem, 0.50, 0.50)
	GUI:setTag(EquipItem, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 521, 57, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/npc/an2.png")
	GUI:Button_setTitleText(Button_1, [[锻造]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create pageList_1
	local pageList_1 = GUI:ListView_Create(FrameLayout, "pageList_1", 72, 35, 120, 450, 1)
	GUI:setAnchorPoint(pageList_1, 0.00, 0.00)
	GUI:setTouchEnabled(pageList_1, true)
	GUI:setTag(pageList_1, 0)

	-- Create pageList_2
	local pageList_2 = GUI:ListView_Create(FrameLayout, "pageList_2", 198, 35, 120, 450, 1)
	GUI:setAnchorPoint(pageList_2, 0.00, 0.00)
	GUI:setTouchEnabled(pageList_2, true)
	GUI:setTag(pageList_2, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 570, 120, [[<font color='#bdbdb5' size='18' >锻造成功率: </font><font color='#00ff00' size='18' >100%</font>]], 170, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.50, 0.00)
	GUI:setTag(RichText_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
