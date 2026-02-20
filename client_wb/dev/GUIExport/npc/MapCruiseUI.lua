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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 686, 440, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/0xun/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 68, 68, 146, 146)
	GUI:setContentSize(FrameBG, 686, 440)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 666, 418, "res/public/01.png")
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

	-- Create record_btn1
	local record_btn1 = GUI:Button_Create(FrameLayout, "record_btn1", 494, 335, "res/custom/0xun/btn01.png")
	GUI:Button_loadTexturePressed(record_btn1, "res/custom/0xun/btn02.png")
	GUI:setContentSize(record_btn1, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(record_btn1, false)
	GUI:Button_setTitleText(record_btn1, [[记录地图]])
	GUI:Button_setTitleColor(record_btn1, "#ffff00")
	GUI:Button_setTitleFontSize(record_btn1, 18)
	GUI:Button_titleEnableOutline(record_btn1, "#000000", 1)
	GUI:setAnchorPoint(record_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(record_btn1, true)
	GUI:setTag(record_btn1, 0)

	-- Create record_btn2
	local record_btn2 = GUI:Button_Create(FrameLayout, "record_btn2", 494, 284, "res/custom/0xun/btn01.png")
	GUI:Button_loadTexturePressed(record_btn2, "res/custom/0xun/btn02.png")
	GUI:setContentSize(record_btn2, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(record_btn2, false)
	GUI:Button_setTitleText(record_btn2, [[记录地图]])
	GUI:Button_setTitleColor(record_btn2, "#ffffff")
	GUI:Button_setTitleFontSize(record_btn2, 18)
	GUI:Button_titleEnableOutline(record_btn2, "#000000", 1)
	GUI:setAnchorPoint(record_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(record_btn2, true)
	GUI:setTag(record_btn2, 0)

	-- Create record_btn3
	local record_btn3 = GUI:Button_Create(FrameLayout, "record_btn3", 494, 232, "res/custom/0xun/btn01.png")
	GUI:Button_loadTexturePressed(record_btn3, "res/custom/0xun/btn02.png")
	GUI:setContentSize(record_btn3, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(record_btn3, false)
	GUI:Button_setTitleText(record_btn3, [[记录地图]])
	GUI:Button_setTitleColor(record_btn3, "#ffffff")
	GUI:Button_setTitleFontSize(record_btn3, 18)
	GUI:Button_titleEnableOutline(record_btn3, "#000000", 1)
	GUI:setAnchorPoint(record_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(record_btn3, true)
	GUI:setTag(record_btn3, 0)

	-- Create record_map1
	local record_map1 = GUI:Text_Create(FrameLayout, "record_map1", 335, 352, 18, "#00ff00", [[未记录地图]])
	GUI:Text_enableOutline(record_map1, "#000000", 1)
	GUI:setAnchorPoint(record_map1, 0.50, 0.50)
	GUI:setTouchEnabled(record_map1, false)
	GUI:setTag(record_map1, 0)

	-- Create record_map2
	local record_map2 = GUI:Text_Create(FrameLayout, "record_map2", 335, 302, 18, "#c6c6ce", [[未记录地图]])
	GUI:Text_enableOutline(record_map2, "#000000", 1)
	GUI:setAnchorPoint(record_map2, 0.50, 0.50)
	GUI:setTouchEnabled(record_map2, false)
	GUI:setTag(record_map2, 0)

	-- Create record_map3
	local record_map3 = GUI:Text_Create(FrameLayout, "record_map3", 335, 252, 18, "#c6c6ce", [[未记录地图]])
	GUI:Text_enableOutline(record_map3, "#000000", 1)
	GUI:setAnchorPoint(record_map3, 0.50, 0.50)
	GUI:setTouchEnabled(record_map3, false)
	GUI:setTag(record_map3, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 167, 187, "res/custom/0xun/sec11.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create checks_1
	local checks_1 = GUI:Image_Create(FrameLayout, "checks_1", 167, 151, "res/custom/0xun/sec01.png")
	GUI:setAnchorPoint(checks_1, 0.00, 0.00)
	GUI:setTouchEnabled(checks_1, true)
	GUI:setTag(checks_1, 0)

	-- Create checks_2
	local checks_2 = GUI:Image_Create(FrameLayout, "checks_2", 167, 117, "res/custom/0xun/sec01.png")
	GUI:setAnchorPoint(checks_2, 0.00, 0.00)
	GUI:setTouchEnabled(checks_2, true)
	GUI:setTag(checks_2, 0)

	-- Create checks_3
	local checks_3 = GUI:Image_Create(FrameLayout, "checks_3", 167, 84, "res/custom/0xun/sec01.png")
	GUI:setAnchorPoint(checks_3, 0.00, 0.00)
	GUI:setTouchEnabled(checks_3, true)
	GUI:setTag(checks_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(FrameLayout, "Text_4", 60, 37, 18, "#ffffff", [[注意：当不满足巡航地图进入条件时将停止巡航！]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create cruise_state_btn
	local cruise_state_btn = GUI:Button_Create(FrameLayout, "cruise_state_btn", 498, 34, "res/custom/0xun/btn01.png")
	GUI:Button_loadTexturePressed(cruise_state_btn, "res/custom/0xun/btn02.png")
	GUI:setContentSize(cruise_state_btn, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(cruise_state_btn, false)
	GUI:Button_setTitleText(cruise_state_btn, [[开始巡航]])
	GUI:Button_setTitleColor(cruise_state_btn, "#ff0000")
	GUI:Button_setTitleFontSize(cruise_state_btn, 18)
	GUI:Button_titleEnableOutline(cruise_state_btn, "#000000", 1)
	GUI:setAnchorPoint(cruise_state_btn, 0.00, 0.00)
	GUI:setTouchEnabled(cruise_state_btn, true)
	GUI:setTag(cruise_state_btn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
