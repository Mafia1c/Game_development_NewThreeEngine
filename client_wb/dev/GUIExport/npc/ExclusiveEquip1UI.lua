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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 320, 1136, 618, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/33cmzs/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 113, 113, 206, 206)
	GUI:setContentSize(FrameBG, 1136, 618)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 967, 514, "res/custom/npc/01dtcs/close.png")
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
	local Frames_1 = GUI:Frames_Create(FrameLayout, "Frames_1", 559, 344, "res/custom/npc/33cmzs/ef1/ef", ".png", 1, 10, {count=10, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(Frames_1, 0.50, 0.50)
	GUI:setTouchEnabled(Frames_1, false)
	GUI:setTag(Frames_1, 0)

	-- Create effectNode
	local effectNode = GUI:Node_Create(FrameLayout, "effectNode", 0, 0)
	GUI:setTag(effectNode, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 172, 185, "res/custom/npc/33cmzs/tbg.png")
	GUI:setContentSize(Image_1, 140, 34)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Image_1, "Text_1", 7, 6, 16, "#ff0000", [[打造:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 797, 185, "res/custom/npc/33cmzs/tbg.png")
	GUI:setContentSize(Image_2, 140, 34)
	GUI:setIgnoreContentAdaptWithSize(Image_2, false)
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(Image_2, "Text_1", 7, 6, 16, "#ff0000", [[打造:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 183, 100, "res/custom/btn1.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/btn2.png")
	GUI:setContentSize(Button_1, 120, 46)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[查看专属]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 808, 100, "res/custom/btn1.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/btn2.png")
	GUI:setContentSize(Button_2, 120, 46)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[复原专属]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create L_Item_4
	local L_Item_4 = GUI:ItemShow_Create(FrameLayout, "L_Item_4", 423, 215, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(L_Item_4, 0.50, 0.50)
	GUI:setTag(L_Item_4, 0)

	-- Create L_Item_3
	local L_Item_3 = GUI:ItemShow_Create(FrameLayout, "L_Item_3", 395, 304, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(L_Item_3, 0.50, 0.50)
	GUI:setTag(L_Item_3, 0)

	-- Create L_Item_2
	local L_Item_2 = GUI:ItemShow_Create(FrameLayout, "L_Item_2", 436, 397, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(L_Item_2, 0.50, 0.50)
	GUI:setTag(L_Item_2, 0)

	-- Create L_Item_1
	local L_Item_1 = GUI:ItemShow_Create(FrameLayout, "L_Item_1", 504, 453, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(L_Item_1, 0.50, 0.50)
	GUI:setTag(L_Item_1, 0)

	-- Create R_Item_4
	local R_Item_4 = GUI:ItemShow_Create(FrameLayout, "R_Item_4", 694, 215, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(R_Item_4, 0.50, 0.50)
	GUI:setTag(R_Item_4, 0)

	-- Create R_Item_3
	local R_Item_3 = GUI:ItemShow_Create(FrameLayout, "R_Item_3", 721, 303, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(R_Item_3, 0.50, 0.50)
	GUI:setTag(R_Item_3, 0)

	-- Create R_Item_2
	local R_Item_2 = GUI:ItemShow_Create(FrameLayout, "R_Item_2", 681, 397, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(R_Item_2, 0.50, 0.50)
	GUI:setTag(R_Item_2, 0)

	-- Create R_Item_1
	local R_Item_1 = GUI:ItemShow_Create(FrameLayout, "R_Item_1", 613, 454, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(R_Item_1, 0.50, 0.50)
	GUI:setTag(R_Item_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
