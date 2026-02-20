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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 460, 220, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/tips.png")
	GUI:Image_setScale9Slice(FrameBG, 69, 69, 69, 69)
	GUI:setContentSize(FrameBG, 460, 220)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create numberText
	local numberText = GUI:Text_Create(FrameBG, "numberText", 232, 162, 18, "#00ff00", [[充值金额：元]])
	GUI:Text_enableOutline(numberText, "#000000", 1)
	GUI:setAnchorPoint(numberText, 0.50, 0.50)
	GUI:setTouchEnabled(numberText, false)
	GUI:setTag(numberText, 0)

	-- Create typeNode
	local typeNode = GUI:Node_Create(FrameBG, "typeNode", 236, 94)
	GUI:setTag(typeNode, 0)

	-- Create typeBtn1
	local typeBtn1 = GUI:Button_Create(typeNode, "typeBtn1", 0, 0, "res/custom/0pay/type21.png")
	GUI:setContentSize(typeBtn1, 88, 33)
	GUI:setIgnoreContentAdaptWithSize(typeBtn1, false)
	GUI:Button_setTitleText(typeBtn1, [[]])
	GUI:Button_setTitleColor(typeBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn1, 16)
	GUI:Button_titleEnableOutline(typeBtn1, "#000000", 1)
	GUI:setAnchorPoint(typeBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn1, true)
	GUI:setTag(typeBtn1, 0)

	-- Create typeBtn2
	local typeBtn2 = GUI:Button_Create(typeNode, "typeBtn2", 0, 0, "res/custom/0pay/type31.png")
	GUI:setContentSize(typeBtn2, 88, 33)
	GUI:setIgnoreContentAdaptWithSize(typeBtn2, false)
	GUI:Button_setTitleText(typeBtn2, [[]])
	GUI:Button_setTitleColor(typeBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn2, 16)
	GUI:Button_titleEnableOutline(typeBtn2, "#000000", 1)
	GUI:setAnchorPoint(typeBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn2, true)
	GUI:setTag(typeBtn2, 0)

	-- Create typeBtn3
	local typeBtn3 = GUI:Button_Create(typeNode, "typeBtn3", 0, 0, "res/custom/0pay/type11.png")
	GUI:setContentSize(typeBtn3, 88, 33)
	GUI:setIgnoreContentAdaptWithSize(typeBtn3, false)
	GUI:Button_setTitleText(typeBtn3, [[]])
	GUI:Button_setTitleColor(typeBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn3, 16)
	GUI:Button_titleEnableOutline(typeBtn3, "#000000", 1)
	GUI:setAnchorPoint(typeBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn3, true)
	GUI:setTag(typeBtn3, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 444, 204, "res/public/01.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/02.png")
	GUI:setContentSize(closeBtn, 30, 30)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
