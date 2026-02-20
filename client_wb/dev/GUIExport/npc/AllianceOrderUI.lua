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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 320, 908, 560, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/17mz/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 86, 86, 186, 186)
	GUI:setContentSize(FrameBG, 864, 560)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 799, 455, "res/custom/npc/01dtcs/close.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/01dtcs/close2.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 30, 297, 0, 12777, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)
	GUI:setVisible(Effect_1, false)

	-- Create icon
	local icon = GUI:Image_Create(FrameLayout, "icon", 116, 379, "res/custom/npc/17mz/yhd.png")
	GUI:setAnchorPoint(icon, 0.00, 0.00)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 70, 419, "res/custom/npc/17mz/t.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)
	GUI:setVisible(Image_1, false)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 335, 158, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 404, 158, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(FrameLayout, "ItemShow_3", 474, 158, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(FrameLayout, "ItemShow_4", 544, 158, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(FrameLayout, "ItemShow_5", 614, 158, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(FrameLayout, "ItemShow_6", 680, 158, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(FrameLayout, "ItemShow_7", 748, 158, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create activateBtn
	local activateBtn = GUI:Button_Create(FrameLayout, "activateBtn", 454, 49, "res/custom/npc/17mz/an.png")
	GUI:Button_loadTexturePressed(activateBtn, "res/custom/npc/17mz/an2.png")
	GUI:setContentSize(activateBtn, 176, 66)
	GUI:setIgnoreContentAdaptWithSize(activateBtn, false)
	GUI:Button_setTitleText(activateBtn, [[]])
	GUI:Button_setTitleColor(activateBtn, "#ffffff")
	GUI:Button_setTitleFontSize(activateBtn, 16)
	GUI:Button_titleEnableOutline(activateBtn, "#000000", 1)
	GUI:setAnchorPoint(activateBtn, 0.00, 0.00)
	GUI:setTouchEnabled(activateBtn, true)
	GUI:setTag(activateBtn, 0)

	-- Create getTag
	local getTag = GUI:Image_Create(FrameLayout, "getTag", 485, 38, "res/custom/npc/17mz/yhd.png")
	GUI:setAnchorPoint(getTag, 0.00, 0.00)
	GUI:setTouchEnabled(getTag, false)
	GUI:setTag(getTag, 0)

	-- Create equip_item
	local equip_item = GUI:ItemShow_Create(FrameLayout, "equip_item", 755, 384, {index = 51168, count = 1, look = true, bgVisible = true, color = 255, showModelEffect = true})
	GUI:setAnchorPoint(equip_item, 0.50, 0.50)
	GUI:setTag(equip_item, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
