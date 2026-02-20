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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 318, 976, 618, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/0kf/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 97, 97, 206, 206)
	GUI:setContentSize(FrameBG, 976, 618)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 898, 506, "res/custom/npc/01dtcs/close.png")
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

	-- Create Frames_1
	local Frames_1 = GUI:Frames_Create(FrameLayout, "Frames_1", 139, 297, "res/custom/npc/0kf/tx/tx1_", ".png", 1, 30, {count=30, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(Frames_1, 0.50, 0.50)
	GUI:setTouchEnabled(Frames_1, false)
	GUI:setTag(Frames_1, 0)

	-- Create Frames_2
	local Frames_2 = GUI:Frames_Create(FrameLayout, "Frames_2", 319, 297, "res/custom/npc/0kf/tx/tx2_", ".png", 1, 30, {count=30, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(Frames_2, 0.50, 0.50)
	GUI:setTouchEnabled(Frames_2, false)
	GUI:setTag(Frames_2, 0)

	-- Create Frames_3
	local Frames_3 = GUI:Frames_Create(FrameLayout, "Frames_3", 504, 297, "res/custom/npc/0kf/tx/tx3_", ".png", 1, 30, {count=30, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(Frames_3, 0.50, 0.50)
	GUI:setTouchEnabled(Frames_3, false)
	GUI:setTag(Frames_3, 0)

	-- Create Frames_4
	local Frames_4 = GUI:Frames_Create(FrameLayout, "Frames_4", 694, 297, "res/custom/npc/0kf/tx/tx4_", ".png", 1, 30, {count=30, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(Frames_4, 0.50, 0.50)
	GUI:setTouchEnabled(Frames_4, false)
	GUI:setTag(Frames_4, 0)

	-- Create Frames_5
	local Frames_5 = GUI:Frames_Create(FrameLayout, "Frames_5", 852, 297, "res/custom/npc/0kf/tx/tx0_", ".png", 1, 30, {count=30, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(Frames_5, 0.50, 0.50)
	GUI:setTouchEnabled(Frames_5, false)
	GUI:setTag(Frames_5, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 137, 163, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/btn12.png")
	GUI:setContentSize(Button_1, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[选     择]])
	GUI:Button_setTitleColor(Button_1, "#ffff00")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.50, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 318, 163, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/btn12.png")
	GUI:setContentSize(Button_2, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[选     择]])
	GUI:Button_setTitleColor(Button_2, "#ffff00")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.50, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(FrameLayout, "Button_3", 503, 163, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(Button_3, "res/custom/btn12.png")
	GUI:setContentSize(Button_3, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[选     择]])
	GUI:Button_setTitleColor(Button_3, "#ffff00")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.50, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(FrameLayout, "Button_4", 693, 163, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(Button_4, "res/custom/btn12.png")
	GUI:setContentSize(Button_4, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[选     择]])
	GUI:Button_setTitleColor(Button_4, "#ffff00")
	GUI:Button_setTitleFontSize(Button_4, 18)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.50, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(FrameLayout, "Button_5", 851, 163, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(Button_5, "res/custom/btn12.png")
	GUI:setContentSize(Button_5, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[暂      无]])
	GUI:Button_setTitleColor(Button_5, "#a0a0a4")
	GUI:Button_setTitleFontSize(Button_5, 18)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.50, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 137, 116, "res/custom/npc/0kf/00.png")
	GUI:setAnchorPoint(Image_1, 0.50, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 318, 116, "res/custom/npc/0kf/0.png")
	GUI:setAnchorPoint(Image_2, 0.50, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(FrameLayout, "Image_3", 503, 116, "res/custom/npc/0kf/0.png")
	GUI:setAnchorPoint(Image_3, 0.50, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(FrameLayout, "Image_4", 693, 116, "res/custom/npc/0kf/0.png")
	GUI:setAnchorPoint(Image_4, 0.50, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
