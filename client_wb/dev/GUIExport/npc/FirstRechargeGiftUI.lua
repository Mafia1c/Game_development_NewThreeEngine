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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 89)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 140, 45, 798, 506, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/15sc/main.png")
	GUI:Image_setScale9Slice(bg_Image, 79, 79, 168, 168)
	GUI:setContentSize(bg_Image, 798, 506)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, true)
	GUI:setMouseEnabled(bg_Image, true)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 677, 378, "res/custom/npc/01dtcs/close.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/01dtcs/close2.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 163, 176, "res/custom/npc/15sc/t.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 89, 285, 0, 11047, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create ItemNode_1
	local ItemNode_1 = GUI:Node_Create(FrameLayout, "ItemNode_1", 469, 246)
	GUI:setTag(ItemNode_1, 0)

	-- Create getGiftBtn
	local getGiftBtn = GUI:Button_Create(FrameLayout, "getGiftBtn", 397, 71, "res/custom/npc/15sc/an.png")
	GUI:Button_loadTexturePressed(getGiftBtn, "res/custom/npc/15sc/an2.png")
	GUI:setContentSize(getGiftBtn, 150, 46)
	GUI:setIgnoreContentAdaptWithSize(getGiftBtn, false)
	GUI:Button_setTitleText(getGiftBtn, [[]])
	GUI:Button_setTitleColor(getGiftBtn, "#ffffff")
	GUI:Button_setTitleFontSize(getGiftBtn, 16)
	GUI:Button_titleEnableOutline(getGiftBtn, "#000000", 1)
	GUI:setAnchorPoint(getGiftBtn, 0.00, 0.00)
	GUI:setTouchEnabled(getGiftBtn, true)
	GUI:setTag(getGiftBtn, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 432, 63, "res/custom/tag/ty-15.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
