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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, _V("SCREEN_HEIGHT") * 0.5, 928, 619, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/113cjtq/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 92, 92, 206, 206)
	GUI:setContentSize(FrameBG, 928, 619)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 828, 523, "res/custom/npc/36tx/x.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 209, 144, 618, 334, 2)
	GUI:ListView_setGravity(ListView_1, 3)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create item_cell_1
	local item_cell_1 = GUI:Image_Create(ListView_1, "item_cell_1", 0, 0, "res/custom/npc/113cjtq/baiyin.png")
	GUI:setContentSize(item_cell_1, 206, 334)
	GUI:setIgnoreContentAdaptWithSize(item_cell_1, false)
	GUI:setAnchorPoint(item_cell_1, 0.00, 0.00)
	GUI:setTouchEnabled(item_cell_1, false)
	GUI:setTag(item_cell_1, 0)

	-- Create tips_icon_1
	local tips_icon_1 = GUI:Image_Create(item_cell_1, "tips_icon_1", 30, 201, "res/custom/npc/113cjtq/tips1.png")
	GUI:setContentSize(tips_icon_1, 138, 48)
	GUI:setIgnoreContentAdaptWithSize(tips_icon_1, false)
	GUI:setAnchorPoint(tips_icon_1, 0.00, 0.00)
	GUI:setTouchEnabled(tips_icon_1, false)
	GUI:setTag(tips_icon_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(item_cell_1, "ItemShow_1", 42, 130, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(item_cell_1, "ItemShow_2", 102, 130, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(item_cell_1, "ItemShow_3", 163, 130, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(item_cell_1, "Button_1", 50, 36, "res/custom/npc/113cjtq/an1.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/npc/113cjtq/an2.png")
	GUI:setContentSize(Button_1, 99, 39)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create activeImg1
	local activeImg1 = GUI:Image_Create(item_cell_1, "activeImg1", 64, 28, "res/custom/tag/0-3.png")
	GUI:setAnchorPoint(activeImg1, 0.00, 0.00)
	GUI:setTouchEnabled(activeImg1, false)
	GUI:setTag(activeImg1, 0)
	GUI:setVisible(activeImg1, false)

	-- Create item_cell_2
	local item_cell_2 = GUI:Image_Create(ListView_1, "item_cell_2", 206, 0, "res/custom/npc/113cjtq/huangjin.png")
	GUI:setContentSize(item_cell_2, 206, 334)
	GUI:setIgnoreContentAdaptWithSize(item_cell_2, false)
	GUI:setAnchorPoint(item_cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(item_cell_2, false)
	GUI:setTag(item_cell_2, 0)

	-- Create tips_icon_1
	tips_icon_1 = GUI:Image_Create(item_cell_2, "tips_icon_1", 30, 201, "res/custom/npc/113cjtq/tips2.png")
	GUI:setContentSize(tips_icon_1, 138, 48)
	GUI:setIgnoreContentAdaptWithSize(tips_icon_1, false)
	GUI:setAnchorPoint(tips_icon_1, 0.00, 0.00)
	GUI:setTouchEnabled(tips_icon_1, false)
	GUI:setTag(tips_icon_1, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(item_cell_2, "ItemShow_1", 42, 130, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(item_cell_2, "ItemShow_2", 102, 130, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(item_cell_2, "ItemShow_3", 163, 130, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(item_cell_2, "Button_2", 50, 36, "res/custom/npc/113cjtq/an1.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/npc/113cjtq/an2.png")
	GUI:setContentSize(Button_2, 99, 39)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create activeImg2
	local activeImg2 = GUI:Image_Create(item_cell_2, "activeImg2", 64, 28, "res/custom/tag/0-3.png")
	GUI:setAnchorPoint(activeImg2, 0.00, 0.00)
	GUI:setTouchEnabled(activeImg2, false)
	GUI:setTag(activeImg2, 0)
	GUI:setVisible(activeImg2, false)

	-- Create item_cell_3
	local item_cell_3 = GUI:Image_Create(ListView_1, "item_cell_3", 412, 0, "res/custom/npc/113cjtq/zuanshi.png")
	GUI:setContentSize(item_cell_3, 206, 334)
	GUI:setIgnoreContentAdaptWithSize(item_cell_3, false)
	GUI:setAnchorPoint(item_cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(item_cell_3, false)
	GUI:setTag(item_cell_3, 0)

	-- Create tips_icon_1
	tips_icon_1 = GUI:Image_Create(item_cell_3, "tips_icon_1", 36, 168, "res/custom/npc/113cjtq/tips3.png")
	GUI:setContentSize(tips_icon_1, 138, 98)
	GUI:setIgnoreContentAdaptWithSize(tips_icon_1, false)
	GUI:setAnchorPoint(tips_icon_1, 0.00, 0.00)
	GUI:setTouchEnabled(tips_icon_1, false)
	GUI:setTag(tips_icon_1, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(item_cell_3, "ItemShow_1", 42, 130, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(item_cell_3, "ItemShow_2", 102, 130, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(item_cell_3, "ItemShow_3", 163, 130, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(item_cell_3, "Button_3", 50, 36, "res/custom/npc/113cjtq/an1.png")
	GUI:Button_loadTexturePressed(Button_3, "res/custom/npc/113cjtq/an2.png")
	GUI:setContentSize(Button_3, 99, 39)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create activeImg3
	local activeImg3 = GUI:Image_Create(item_cell_3, "activeImg3", 64, 28, "res/custom/tag/0-3.png")
	GUI:setAnchorPoint(activeImg3, 0.00, 0.00)
	GUI:setTouchEnabled(activeImg3, false)
	GUI:setTag(activeImg3, 0)
	GUI:setVisible(activeImg3, false)

	-- Create tipsImg
	local tipsImg = GUI:Image_Create(FrameLayout, "tipsImg", 524, 132, "res/custom/npc/113cjtq/tips4.png")
	GUI:setContentSize(tipsImg, 484, 22)
	GUI:setIgnoreContentAdaptWithSize(tipsImg, false)
	GUI:setAnchorPoint(tipsImg, 0.50, 0.50)
	GUI:setTouchEnabled(tipsImg, false)
	GUI:setTag(tipsImg, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
