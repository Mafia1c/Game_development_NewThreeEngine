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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 0)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 738, 500, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/35xm/3/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 73, 73, 166, 166)
	GUI:setContentSize(FrameBG, 738, 500)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create kapai_1
	local kapai_1 = GUI:Image_Create(FrameLayout, "kapai_1", 62, 146, "res/custom/npc/35xm/3/k1.png")
	GUI:setAnchorPoint(kapai_1, 0.00, 0.00)
	GUI:setTouchEnabled(kapai_1, false)
	GUI:setTag(kapai_1, 0)

	-- Create icon_1
	local icon_1 = GUI:Image_Create(kapai_1, "icon_1", 80, 179, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon_1, 0.00, 0.00)
	GUI:setTouchEnabled(icon_1, false)
	GUI:setTag(icon_1, 0)

	-- Create name_1
	local name_1 = GUI:Text_Create(kapai_1, "name_1", 100, 248, 18, "#ffffff", [[回春]])
	GUI:Text_enableOutline(name_1, "#000000", 1)
	GUI:setAnchorPoint(name_1, 0.50, 0.50)
	GUI:setTouchEnabled(name_1, false)
	GUI:setTag(name_1, 0)

	-- Create select_1
	local select_1 = GUI:Button_Create(kapai_1, "select_1", 54, -33, "res/custom/npc/12tmfw/2/an.png")
	GUI:Button_setTitleText(select_1, [[]])
	GUI:Button_setTitleColor(select_1, "#ffffff")
	GUI:Button_setTitleFontSize(select_1, 16)
	GUI:Button_titleDisableOutLine(select_1)
	GUI:setAnchorPoint(select_1, 0.00, 0.00)
	GUI:setTouchEnabled(select_1, true)
	GUI:setTag(select_1, 0)

	-- Create yihuode_img1
	local yihuode_img1 = GUI:Image_Create(kapai_1, "yihuode_img1", 64, -46, "res/custom/tag/ylq_03.png")
	GUI:setContentSize(yihuode_img1, 96, 48)
	GUI:setIgnoreContentAdaptWithSize(yihuode_img1, false)
	GUI:setAnchorPoint(yihuode_img1, 0.00, 0.00)
	GUI:setTouchEnabled(yihuode_img1, false)
	GUI:setTag(yihuode_img1, 0)

	-- Create kapai_2
	local kapai_2 = GUI:Image_Create(FrameLayout, "kapai_2", 266, 146, "res/custom/npc/35xm/3/k2.png")
	GUI:setAnchorPoint(kapai_2, 0.00, 0.00)
	GUI:setTouchEnabled(kapai_2, false)
	GUI:setTag(kapai_2, 0)

	-- Create icon_2
	local icon_2 = GUI:Image_Create(kapai_2, "icon_2", 80, 179, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon_2, 0.00, 0.00)
	GUI:setTouchEnabled(icon_2, false)
	GUI:setTag(icon_2, 0)

	-- Create name_2
	local name_2 = GUI:Text_Create(kapai_2, "name_2", 100, 248, 18, "#ffffff", [[回春]])
	GUI:Text_enableOutline(name_2, "#000000", 1)
	GUI:setAnchorPoint(name_2, 0.50, 0.50)
	GUI:setTouchEnabled(name_2, false)
	GUI:setTag(name_2, 0)

	-- Create select_2
	local select_2 = GUI:Button_Create(kapai_2, "select_2", 54, -33, "res/custom/npc/12tmfw/2/an.png")
	GUI:Button_setTitleText(select_2, [[]])
	GUI:Button_setTitleColor(select_2, "#ffffff")
	GUI:Button_setTitleFontSize(select_2, 16)
	GUI:Button_titleDisableOutLine(select_2)
	GUI:setAnchorPoint(select_2, 0.00, 0.00)
	GUI:setTouchEnabled(select_2, true)
	GUI:setTag(select_2, 0)

	-- Create yihuode_img2
	local yihuode_img2 = GUI:Image_Create(kapai_2, "yihuode_img2", 63, -46, "res/custom/tag/ylq_03.png")
	GUI:setContentSize(yihuode_img2, 96, 48)
	GUI:setIgnoreContentAdaptWithSize(yihuode_img2, false)
	GUI:setAnchorPoint(yihuode_img2, 0.00, 0.00)
	GUI:setTouchEnabled(yihuode_img2, false)
	GUI:setTag(yihuode_img2, 0)

	-- Create kapai_3
	local kapai_3 = GUI:Image_Create(FrameLayout, "kapai_3", 470, 146, "res/custom/npc/35xm/3/k4.png")
	GUI:setAnchorPoint(kapai_3, 0.00, 0.00)
	GUI:setTouchEnabled(kapai_3, false)
	GUI:setTag(kapai_3, 0)

	-- Create icon_3
	local icon_3 = GUI:Image_Create(kapai_3, "icon_3", 80, 179, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon_3, 0.00, 0.00)
	GUI:setTouchEnabled(icon_3, false)
	GUI:setTag(icon_3, 0)

	-- Create name_3
	local name_3 = GUI:Text_Create(kapai_3, "name_3", 100, 248, 18, "#ffffff", [[回春]])
	GUI:Text_enableOutline(name_3, "#000000", 1)
	GUI:setAnchorPoint(name_3, 0.50, 0.50)
	GUI:setTouchEnabled(name_3, false)
	GUI:setTag(name_3, 0)

	-- Create select_3
	local select_3 = GUI:Button_Create(kapai_3, "select_3", 54, -33, "res/custom/npc/12tmfw/2/an.png")
	GUI:Button_setTitleText(select_3, [[]])
	GUI:Button_setTitleColor(select_3, "#ffffff")
	GUI:Button_setTitleFontSize(select_3, 16)
	GUI:Button_titleDisableOutLine(select_3)
	GUI:setAnchorPoint(select_3, 0.00, 0.00)
	GUI:setTouchEnabled(select_3, true)
	GUI:setTag(select_3, 0)

	-- Create yihuode_img3
	local yihuode_img3 = GUI:Image_Create(kapai_3, "yihuode_img3", 63, -46, "res/custom/tag/ylq_03.png")
	GUI:setContentSize(yihuode_img3, 96, 48)
	GUI:setIgnoreContentAdaptWithSize(yihuode_img3, false)
	GUI:setAnchorPoint(yihuode_img3, 0.00, 0.00)
	GUI:setTouchEnabled(yihuode_img3, false)
	GUI:setTag(yihuode_img3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(FrameLayout, "Image_4", 239, 447, "res/custom/npc/35xm/3/icon.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create reflush_btn
	local reflush_btn = GUI:Button_Create(FrameLayout, "reflush_btn", 320, 28, "res/custom/npc/an.png")
	GUI:setContentSize(reflush_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(reflush_btn, false)
	GUI:Button_setTitleText(reflush_btn, [[再次觉醒]])
	GUI:Button_setTitleColor(reflush_btn, "#efd6ad")
	GUI:Button_setTitleFontSize(reflush_btn, 18)
	GUI:Button_titleEnableOutline(reflush_btn, "#000000", 1)
	GUI:setAnchorPoint(reflush_btn, 0.00, 0.00)
	GUI:setTouchEnabled(reflush_btn, true)
	GUI:setTag(reflush_btn, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 199, 75, 18, "#deded6", [[使用：未选择时关闭窗口，本次血脉选择失效]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameLayout, "close_btn", 637, 456, "res/custom/npc/01dtcs/close.png")
	GUI:Button_loadTexturePressed(close_btn, "res/custom/npc/01dtcs/close2.png")
	GUI:setContentSize(close_btn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(close_btn, false)
	GUI:Button_setTitleText(close_btn, [[]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleDisableOutLine(close_btn)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
