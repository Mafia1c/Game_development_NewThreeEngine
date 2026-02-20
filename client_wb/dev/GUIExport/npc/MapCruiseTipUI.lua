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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 286, 286, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 0, 0, "res/custom/0xun/fhbg.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 84, 151, 18, "#ffffff", [[后进入巡航地图]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create stop_cruise_btn
	local stop_cruise_btn = GUI:Button_Create(FrameLayout, "stop_cruise_btn", 91, 74, "res/custom/0xun/btn01.png")
	GUI:Button_loadTexturePressed(stop_cruise_btn, "res/custom/0xun/btn02.png")
	GUI:setContentSize(stop_cruise_btn, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(stop_cruise_btn, false)
	GUI:Button_setTitleText(stop_cruise_btn, [[终止巡航]])
	GUI:Button_setTitleColor(stop_cruise_btn, "#ff0000")
	GUI:Button_setTitleFontSize(stop_cruise_btn, 18)
	GUI:Button_titleEnableOutline(stop_cruise_btn, "#000000", 1)
	GUI:setAnchorPoint(stop_cruise_btn, 0.00, 0.00)
	GUI:setTouchEnabled(stop_cruise_btn, true)
	GUI:setTag(stop_cruise_btn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
