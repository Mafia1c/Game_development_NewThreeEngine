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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 890, 576, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/10tmfw/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 89, 89, 192, 192)
	GUI:setContentSize(FrameBG, 890, 576)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameLayout, "close_btn", 825, 511, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(close_btn, "res/custom/npc/close2.png")
	GUI:setContentSize(close_btn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(close_btn, false)
	GUI:Button_setTitleText(close_btn, [[]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleDisableOutLine(close_btn)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	-- Create select_bg
	local select_bg = GUI:Image_Create(FrameLayout, "select_bg", 627, 43, "res/custom/npc/12tmfw/t5.png")
	GUI:setAnchorPoint(select_bg, 0.00, 0.00)
	GUI:setTouchEnabled(select_bg, false)
	GUI:setTag(select_bg, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(select_bg, "Image_2", 7, 61, "res/custom/npc/12tmfw/t1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create select_item
	local select_item = GUI:ItemShow_Create(select_bg, "select_item", 110, 392, {index = 1, count = 1, look = false, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(select_item, 0.50, 0.50)
	GUI:setTag(select_item, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(select_bg, "Image_3", -4, 307, "res/custom/npc/12tmfw/t3.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create select_name
	local select_name = GUI:Text_Create(Image_3, "select_name", 116, 13, 18, "#ffffff", [[文本]])
	GUI:Text_enableOutline(select_name, "#000000", 1)
	GUI:setAnchorPoint(select_name, 0.50, 0.50)
	GUI:setTouchEnabled(select_name, false)
	GUI:setTag(select_name, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(select_bg, "Image_4", 25, 280, "res/custom/npc/12tmfw/t4.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create no_select_text
	local no_select_text = GUI:Text_Create(FrameLayout, "no_select_text", 697, 362, 18, "#ffff00", [[未选择符文]])
	GUI:Text_enableOutline(no_select_text, "#000000", 1)
	GUI:setAnchorPoint(no_select_text, 0.00, 0.00)
	GUI:setTouchEnabled(no_select_text, false)
	GUI:setTag(no_select_text, 0)
	GUI:setVisible(no_select_text, false)

	-- Create tujian_list_view
	local tujian_list_view = GUI:ListView_Create(FrameLayout, "tujian_list_view", 71, 44, 553, 458, 1)
	GUI:ListView_setItemsMargin(tujian_list_view, 5)
	GUI:setAnchorPoint(tujian_list_view, 0.00, 0.00)
	GUI:setTouchEnabled(tujian_list_view, true)
	GUI:setTag(tujian_list_view, 0)

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(tujian_list_view, "ListView_2", 0, 354, 556, 104, 1)
	GUI:ListView_setItemsMargin(ListView_2, -80)
	GUI:setAnchorPoint(ListView_2, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_2, true)
	GUI:setTag(ListView_2, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(ListView_2, "Image_1", 556, -132, "res/custom/npc/10tmfw/111.png")
	GUI:setAnchorPoint(Image_1, 1.00, 1.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ListView_4
	local ListView_4 = GUI:ListView_Create(ListView_2, "ListView_4", 0, -68, 556, 134, 1)
	GUI:ListView_setGravity(ListView_4, 2)
	GUI:setAnchorPoint(ListView_4, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_4, true)
	GUI:setTag(ListView_4, 0)

	-- Create ListView_3
	local ListView_3 = GUI:ListView_Create(ListView_4, "ListView_3", 37, 67, 482, 67, 1)
	GUI:ListView_setGravity(ListView_3, 2)
	GUI:setAnchorPoint(ListView_3, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_3, true)
	GUI:setTag(ListView_3, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(ListView_3, "Image_5", 211, 7, "res/custom/itm0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_5
	local ListView_5 = GUI:ListView_Create(ListView_4, "ListView_5", 37, 0, 482, 67, 1)
	GUI:ListView_setGravity(ListView_5, 2)
	GUI:setAnchorPoint(ListView_5, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_5, true)
	GUI:setTag(ListView_5, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_5, "Image_5", 211, 7, "res/custom/itm0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_6
	local ListView_6 = GUI:ListView_Create(tujian_list_view, "ListView_6", 0, 245, 556, 104, 1)
	GUI:ListView_setItemsMargin(ListView_6, -80)
	GUI:setAnchorPoint(ListView_6, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_6, true)
	GUI:setTag(ListView_6, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(ListView_6, "Image_1", 556, -132, "res/custom/npc/10tmfw/111.png")
	GUI:setAnchorPoint(Image_1, 1.00, 1.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ListView_4
	ListView_4 = GUI:ListView_Create(ListView_6, "ListView_4", 0, -68, 556, 134, 1)
	GUI:ListView_setGravity(ListView_4, 2)
	GUI:setAnchorPoint(ListView_4, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_4, true)
	GUI:setTag(ListView_4, 0)

	-- Create ListView_3
	ListView_3 = GUI:ListView_Create(ListView_4, "ListView_3", 37, 67, 482, 67, 1)
	GUI:ListView_setGravity(ListView_3, 2)
	GUI:setAnchorPoint(ListView_3, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_3, true)
	GUI:setTag(ListView_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_3, "Image_5", 211, 7, "res/custom/itm0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_5
	ListView_5 = GUI:ListView_Create(ListView_4, "ListView_5", 37, 0, 482, 67, 1)
	GUI:ListView_setGravity(ListView_5, 2)
	GUI:setAnchorPoint(ListView_5, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_5, true)
	GUI:setTag(ListView_5, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_5, "Image_5", 211, 7, "res/custom/itm0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_7
	local ListView_7 = GUI:ListView_Create(tujian_list_view, "ListView_7", 0, 136, 556, 104, 1)
	GUI:ListView_setItemsMargin(ListView_7, -80)
	GUI:setAnchorPoint(ListView_7, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_7, true)
	GUI:setTag(ListView_7, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(ListView_7, "Image_1", 556, -132, "res/custom/npc/10tmfw/111.png")
	GUI:setAnchorPoint(Image_1, 1.00, 1.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ListView_4
	ListView_4 = GUI:ListView_Create(ListView_7, "ListView_4", 0, -68, 556, 134, 1)
	GUI:ListView_setGravity(ListView_4, 2)
	GUI:setAnchorPoint(ListView_4, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_4, true)
	GUI:setTag(ListView_4, 0)

	-- Create ListView_3
	ListView_3 = GUI:ListView_Create(ListView_4, "ListView_3", 37, 67, 482, 67, 1)
	GUI:ListView_setGravity(ListView_3, 2)
	GUI:setAnchorPoint(ListView_3, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_3, true)
	GUI:setTag(ListView_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_3, "Image_5", 211, 7, "res/custom/itm0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_5
	ListView_5 = GUI:ListView_Create(ListView_4, "ListView_5", 37, 0, 482, 67, 1)
	GUI:ListView_setGravity(ListView_5, 2)
	GUI:setAnchorPoint(ListView_5, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_5, true)
	GUI:setTag(ListView_5, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_5, "Image_5", 211, 7, "res/custom/itm0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_8
	local ListView_8 = GUI:ListView_Create(tujian_list_view, "ListView_8", 0, -308, 556, 439, 1)
	GUI:ListView_setItemsMargin(ListView_8, -80)
	GUI:setAnchorPoint(ListView_8, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_8, true)
	GUI:setTag(ListView_8, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(ListView_8, "Image_1", 556, 203, "res/custom/npc/10tmfw/111.png")
	GUI:setAnchorPoint(Image_1, 1.00, 1.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ListView_4
	ListView_4 = GUI:ListView_Create(ListView_8, "ListView_4", 0, 267, 556, 134, 1)
	GUI:ListView_setGravity(ListView_4, 2)
	GUI:setAnchorPoint(ListView_4, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_4, true)
	GUI:setTag(ListView_4, 0)

	-- Create ListView_3
	ListView_3 = GUI:ListView_Create(ListView_4, "ListView_3", 37, 67, 482, 67, 1)
	GUI:ListView_setGravity(ListView_3, 2)
	GUI:setAnchorPoint(ListView_3, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_3, true)
	GUI:setTag(ListView_3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_3, "Image_5", 211, 7, "res/custom/itm0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_5
	ListView_5 = GUI:ListView_Create(ListView_4, "ListView_5", 37, 0, 482, 67, 1)
	GUI:ListView_setGravity(ListView_5, 2)
	GUI:setAnchorPoint(ListView_5, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_5, true)
	GUI:setTag(ListView_5, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_5, "Image_5", 211, 7, "res/custom/itm0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
