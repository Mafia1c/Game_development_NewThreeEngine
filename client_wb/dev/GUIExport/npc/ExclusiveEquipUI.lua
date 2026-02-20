local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 320, 310, 448, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/mbtn/bgzs.png")
	GUI:Image_setScale9Slice(FrameBG, 31, 31, 149, 149)
	GUI:setContentSize(FrameBG, 310, 448)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create ModeNode
	local ModeNode = GUI:Node_Create(FrameLayout, "ModeNode", 0, 0)
	GUI:setTag(ModeNode, 0)

	-- Create wqLayout
	local wqLayout = GUI:Layout_Create(FrameLayout, "wqLayout", 19, 204, 91, 167, false)
	GUI:setAnchorPoint(wqLayout, 0.00, 0.00)
	GUI:setTouchEnabled(wqLayout, true)
	GUI:setTag(wqLayout, 0)

	-- Create yfLayout
	local yfLayout = GUI:Layout_Create(FrameLayout, "yfLayout", 112, 124, 91, 200, false)
	GUI:setAnchorPoint(yfLayout, 0.00, 0.00)
	GUI:setTouchEnabled(yfLayout, true)
	GUI:setTag(yfLayout, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 323, 425, "res/public/11.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/12.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 53, 190, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 53, 114, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(FrameLayout, "ItemShow_3", 111, 51, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(FrameLayout, "ItemShow_4", 195, 51, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(FrameLayout, "ItemShow_5", 256, 114, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(FrameLayout, "ItemShow_6", 256, 190, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(FrameLayout, "ItemShow_7", 256, 264, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(FrameLayout, "ItemShow_8", 256, 340, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	ui.update(__data__)
	return FrameLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
