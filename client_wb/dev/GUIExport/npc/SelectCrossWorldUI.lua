local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:Layout_setBackGroundImage(CloseLayout, "res/custom/npc/0kf/bg0.png")
	GUI:Layout_setBackGroundColorType(CloseLayout, 1)
	GUI:Layout_setBackGroundColor(CloseLayout, "#000000")
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 76)
	GUI:Layout_setBackGroundImageScale9Slice(CloseLayout, 113, 113, 213, 213)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 318, 756, 476, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/0kf/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 75, 75, 158, 158)
	GUI:setContentSize(FrameBG, 756, 476)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 695, 402, "res/custom/npc/01dtcs/close.png")
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

	-- Create goBtn
	local goBtn = GUI:Button_Create(FrameLayout, "goBtn", 294, 66, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(goBtn, "res/custom/btn12.png")
	GUI:setContentSize(goBtn, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(goBtn, false)
	GUI:Button_setTitleText(goBtn, [[立即前往]])
	GUI:Button_setTitleColor(goBtn, "#ffff00")
	GUI:Button_setTitleFontSize(goBtn, 18)
	GUI:Button_titleEnableOutline(goBtn, "#000000", 1)
	GUI:setAnchorPoint(goBtn, 0.00, 0.00)
	GUI:setTouchEnabled(goBtn, true)
	GUI:setTag(goBtn, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 476, 156, "res/custom/npc/0gsha/tips.png")
	GUI:Image_setScale9Slice(Image_1, 7, 7, 10, 10)
	GUI:setContentSize(Image_1, 200, 180)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Image_1, "Text_1", 16, 153, 16, "#ff00ff", [[活动奖励:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(Image_1, "RichText_1", 19, 121, [[第１名：<a enableUnderline ='false' href='jump#item_tips#10140'> <u><font color ='#FFFF00'>觉醒嗜杀者</font></u></a>]], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(Image_1, "RichText_2", 19, 90, [[第２名：<a enableUnderline ='false' href='jump#item_tips#10141'> <u><font color ='#FFFF00'>混沌狂暴者</font></u></a>]], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(Image_1, "RichText_3", 19, 58, [[第３名：<a enableUnderline ='false' href='jump#item_tips#10142'> <u><font color ='#FFFF00'>乾坤审判者</font></u></a>]], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.00, 0.00)
	GUI:setTag(RichText_3, 0)

	-- Create RichText_4
	local RichText_4 = GUI:RichText_Create(Image_1, "RichText_4", 19, 26, [[参与奖：<a enableUnderline ='false' href='jump#item_tips#10148'> <u><font color ='#FFFF00'>开天大武神</font></u></a>]], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_4, 0.00, 0.00)
	GUI:setTag(RichText_4, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
