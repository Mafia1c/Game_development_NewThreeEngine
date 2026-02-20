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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 317, 796, 478, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/16kb/main.png")
	GUI:Image_setScale9Slice(FrameBG, 79, 79, 159, 159)
	GUI:setContentSize(FrameBG, 796, 478)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 754, 398, "res/custom/npc/36tx/x.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 435, 116, 20, "#ff0000", [[99]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)
	GUI:setVisible(Text_1, false)

	-- Create enterMapBtn
	local enterMapBtn = GUI:Button_Create(FrameLayout, "enterMapBtn", 296, 45, "res/custom/npc/16kb/an1.png")
	GUI:setContentSize(enterMapBtn, 138, 38)
	GUI:setIgnoreContentAdaptWithSize(enterMapBtn, false)
	GUI:Button_setTitleText(enterMapBtn, [[]])
	GUI:Button_setTitleColor(enterMapBtn, "#ffffff")
	GUI:Button_setTitleFontSize(enterMapBtn, 16)
	GUI:Button_titleEnableOutline(enterMapBtn, "#000000", 1)
	GUI:setAnchorPoint(enterMapBtn, 0.00, 0.00)
	GUI:setTouchEnabled(enterMapBtn, true)
	GUI:setTag(enterMapBtn, 0)

	-- Create openBtn_1
	local openBtn_1 = GUI:Button_Create(FrameLayout, "openBtn_1", 451, 45, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(openBtn_1, "res/custom/npc/an2.png")
	GUI:setContentSize(openBtn_1, 130, 38)
	GUI:setIgnoreContentAdaptWithSize(openBtn_1, false)
	GUI:Button_setTitleText(openBtn_1, [[元宝开启]])
	GUI:Button_setTitleColor(openBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(openBtn_1, 18)
	GUI:Button_titleEnableOutline(openBtn_1, "#000000", 2)
	GUI:setAnchorPoint(openBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(openBtn_1, true)
	GUI:setTag(openBtn_1, 0)

	-- Create openBtn_2
	local openBtn_2 = GUI:Button_Create(FrameLayout, "openBtn_2", 612, 45, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(openBtn_2, "res/custom/npc/an2.png")
	GUI:setContentSize(openBtn_2, 130, 38)
	GUI:setIgnoreContentAdaptWithSize(openBtn_2, false)
	GUI:Button_setTitleText(openBtn_2, [[绑定元宝开启]])
	GUI:Button_setTitleColor(openBtn_2, "#ffffff")
	GUI:Button_setTitleFontSize(openBtn_2, 18)
	GUI:Button_titleEnableOutline(openBtn_2, "#000000", 2)
	GUI:setAnchorPoint(openBtn_2, 0.00, 0.00)
	GUI:setTouchEnabled(openBtn_2, true)
	GUI:setTag(openBtn_2, 0)

	-- Create levelTxt
	local levelTxt = GUI:Text_Create(FrameLayout, "levelTxt", 528, 91, 18, "#00ffe8", [[0]])
	GUI:Text_enableOutline(levelTxt, "#000000", 1)
	GUI:setAnchorPoint(levelTxt, 0.50, 0.00)
	GUI:setTouchEnabled(levelTxt, false)
	GUI:setTag(levelTxt, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 141, 154, 0, 16052, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create CheckBox_1
	local CheckBox_1 = GUI:CheckBox_Create(FrameLayout, "CheckBox_1", 101, 52, "res/custom/npc/g0.png", "res/custom/npc/g1.png")
	GUI:setContentSize(CheckBox_1, 24, 24)
	GUI:setIgnoreContentAdaptWithSize(CheckBox_1, false)
	GUI:CheckBox_setSelected(CheckBox_1, false)
	GUI:setAnchorPoint(CheckBox_1, 0.00, 0.00)
	GUI:setTouchEnabled(CheckBox_1, true)
	GUI:setTag(CheckBox_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 134, 53, 16, "#ffff00", [[自动开启狂暴]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 106, 323, "res/custom/tag/y_102.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
