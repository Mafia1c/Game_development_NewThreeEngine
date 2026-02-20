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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 580, 322, 793, 486, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/116guanm/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 79, 79, 162, 162)
	GUI:setContentSize(FrameBG, 793, 486)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 754, 408, "res/custom/npc/close3.png")
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
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 148, 124, 0, 14083, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(FrameLayout, "upBtn", 532, 34, "res/custom/npc/116guanm/btn11.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/116guanm/btn12.png")
	GUI:Button_setTitleText(upBtn, [[]])
	GUI:Button_setTitleColor(upBtn, "#ffffff")
	GUI:Button_setTitleFontSize(upBtn, 16)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create activeImg
	local activeImg = GUI:Image_Create(FrameLayout, "activeImg", 472, 12, "res/custom/tag/y_104.png")
	GUI:setContentSize(activeImg, 117, 95)
	GUI:setIgnoreContentAdaptWithSize(activeImg, false)
	GUI:setAnchorPoint(activeImg, 0.00, 0.00)
	GUI:setTouchEnabled(activeImg, false)
	GUI:setTag(activeImg, 0)
	GUI:setVisible(activeImg, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
