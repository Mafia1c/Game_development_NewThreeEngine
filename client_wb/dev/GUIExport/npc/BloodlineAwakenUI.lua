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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/12tmfw/bg2.png")
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
	GUI:setVisible(select_bg, false)

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

	-- Create active_btn
	local active_btn = GUI:Button_Create(FrameLayout, "active_btn", 745, 67, "res/custom/npc/12tmfw/an1.png")
	GUI:setContentSize(active_btn, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(active_btn, false)
	GUI:Button_setTitleText(active_btn, [[]])
	GUI:Button_setTitleColor(active_btn, "#ffffff")
	GUI:Button_setTitleFontSize(active_btn, 16)
	GUI:Button_titleDisableOutLine(active_btn)
	GUI:setAnchorPoint(active_btn, 0.00, 0.00)
	GUI:setTouchEnabled(active_btn, true)
	GUI:setTag(active_btn, 0)

	-- Create reset_btn
	local reset_btn = GUI:Button_Create(FrameLayout, "reset_btn", 648, 67, "res/custom/npc/12tmfw/an2.png")
	GUI:setContentSize(reset_btn, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(reset_btn, false)
	GUI:Button_setTitleText(reset_btn, [[]])
	GUI:Button_setTitleColor(reset_btn, "#ffffff")
	GUI:Button_setTitleFontSize(reset_btn, 16)
	GUI:Button_titleDisableOutLine(reset_btn)
	GUI:setAnchorPoint(reset_btn, 0.00, 0.00)
	GUI:setTouchEnabled(reset_btn, true)
	GUI:setTag(reset_btn, 0)

	-- Create can_active_text
	local can_active_text = GUI:Text_Create(FrameLayout, "can_active_text", 739, 54, 16, "#00ff00", [[剩余激活次数：2次]])
	GUI:setIgnoreContentAdaptWithSize(can_active_text, false)
	GUI:Text_setTextAreaSize(can_active_text, 154, 27)
	GUI:Text_enableOutline(can_active_text, "#000000", 1)
	GUI:setAnchorPoint(can_active_text, 0.50, 0.50)
	GUI:setTouchEnabled(can_active_text, false)
	GUI:setTag(can_active_text, 0)

	-- Create no_select_text
	local no_select_text = GUI:Text_Create(FrameLayout, "no_select_text", 697, 362, 18, "#ffff00", [[未选择符文]])
	GUI:Text_enableOutline(no_select_text, "#000000", 1)
	GUI:setAnchorPoint(no_select_text, 0.00, 0.00)
	GUI:setTouchEnabled(no_select_text, false)
	GUI:setTag(no_select_text, 0)
	GUI:setVisible(no_select_text, false)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 70, 43, 554, 461, 2)
	GUI:ListView_setGravity(ListView_1, 3)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create fuwen_box
	local fuwen_box = GUI:Layout_Create(ListView_1, "fuwen_box", 0, 5, 894, 456, false)
	GUI:setAnchorPoint(fuwen_box, 0.00, 0.00)
	GUI:setTouchEnabled(fuwen_box, false)
	GUI:setTag(fuwen_box, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(fuwen_box, "Image_5", -1, 7, "res/custom/npc/12tmfw/kuang.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(fuwen_box, "Image_6", 89, 7, "res/custom/npc/12tmfw/kuang.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create Image_16
	local Image_16 = GUI:Image_Create(fuwen_box, "Image_16", 180, 7, "res/custom/npc/12tmfw/kuang.png")
	GUI:setAnchorPoint(Image_16, 0.00, 0.00)
	GUI:setTouchEnabled(Image_16, false)
	GUI:setTag(Image_16, 0)

	-- Create Image_17
	local Image_17 = GUI:Image_Create(fuwen_box, "Image_17", 271, 7, "res/custom/npc/12tmfw/kuang.png")
	GUI:setAnchorPoint(Image_17, 0.00, 0.00)
	GUI:setTouchEnabled(Image_17, false)
	GUI:setTag(Image_17, 0)

	-- Create Image_18
	local Image_18 = GUI:Image_Create(fuwen_box, "Image_18", 356, 7, "res/custom/npc/12tmfw/kuang.png")
	GUI:setAnchorPoint(Image_18, 0.00, 0.00)
	GUI:setTouchEnabled(Image_18, false)
	GUI:setTag(Image_18, 0)

	-- Create Image_19
	local Image_19 = GUI:Image_Create(fuwen_box, "Image_19", 448, 7, "res/custom/npc/12tmfw/kuang.png")
	GUI:setAnchorPoint(Image_19, 0.00, 0.00)
	GUI:setTouchEnabled(Image_19, false)
	GUI:setTag(Image_19, 0)

	-- Create Image_20
	local Image_20 = GUI:Image_Create(fuwen_box, "Image_20", 534, 7, "res/custom/npc/12tmfw/kuang.png")
	GUI:setAnchorPoint(Image_20, 0.00, 0.00)
	GUI:setTouchEnabled(Image_20, false)
	GUI:setTag(Image_20, 0)

	-- Create Image_21
	local Image_21 = GUI:Image_Create(fuwen_box, "Image_21", 624, 7, "res/custom/npc/12tmfw/kuang.png")
	GUI:setAnchorPoint(Image_21, 0.00, 0.00)
	GUI:setTouchEnabled(Image_21, false)
	GUI:setTag(Image_21, 0)

	-- Create Image_22
	local Image_22 = GUI:Image_Create(fuwen_box, "Image_22", 714, 7, "res/custom/npc/12tmfw/kuang.png")
	GUI:setAnchorPoint(Image_22, 0.00, 0.00)
	GUI:setTouchEnabled(Image_22, false)
	GUI:setTag(Image_22, 0)

	-- Create Image_23
	local Image_23 = GUI:Image_Create(fuwen_box, "Image_23", 804, 7, "res/custom/npc/12tmfw/kuang.png")
	GUI:setAnchorPoint(Image_23, 0.00, 0.00)
	GUI:setTouchEnabled(Image_23, false)
	GUI:setTag(Image_23, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(fuwen_box, "Image_1", 35, 54, "res/custom/npc/12tmfw/x2.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_7
	local Image_7 = GUI:Image_Create(fuwen_box, "Image_7", 125, 54, "res/custom/npc/12tmfw/x2.png")
	GUI:setAnchorPoint(Image_7, 0.00, 0.00)
	GUI:setTouchEnabled(Image_7, false)
	GUI:setTag(Image_7, 0)

	-- Create Image_8
	local Image_8 = GUI:Image_Create(fuwen_box, "Image_8", 215, 54, "res/custom/npc/12tmfw/x2.png")
	GUI:setAnchorPoint(Image_8, 0.00, 0.00)
	GUI:setTouchEnabled(Image_8, false)
	GUI:setTag(Image_8, 0)

	-- Create Image_9
	local Image_9 = GUI:Image_Create(fuwen_box, "Image_9", 307, 54, "res/custom/npc/12tmfw/x2.png")
	GUI:setAnchorPoint(Image_9, 0.00, 0.00)
	GUI:setTouchEnabled(Image_9, false)
	GUI:setTag(Image_9, 0)

	-- Create Image_10
	local Image_10 = GUI:Image_Create(fuwen_box, "Image_10", 393, 54, "res/custom/npc/12tmfw/x2.png")
	GUI:setAnchorPoint(Image_10, 0.00, 0.00)
	GUI:setTouchEnabled(Image_10, false)
	GUI:setTag(Image_10, 0)

	-- Create Image_11
	local Image_11 = GUI:Image_Create(fuwen_box, "Image_11", 485, 54, "res/custom/npc/12tmfw/x2.png")
	GUI:setAnchorPoint(Image_11, 0.00, 0.00)
	GUI:setTouchEnabled(Image_11, false)
	GUI:setTag(Image_11, 0)

	-- Create Image_12
	local Image_12 = GUI:Image_Create(fuwen_box, "Image_12", 571, 54, "res/custom/npc/12tmfw/x2.png")
	GUI:setAnchorPoint(Image_12, 0.00, 0.00)
	GUI:setTouchEnabled(Image_12, false)
	GUI:setTag(Image_12, 0)

	-- Create Image_13
	local Image_13 = GUI:Image_Create(fuwen_box, "Image_13", 660, 54, "res/custom/npc/12tmfw/x2.png")
	GUI:setAnchorPoint(Image_13, 0.00, 0.00)
	GUI:setTouchEnabled(Image_13, false)
	GUI:setTag(Image_13, 0)

	-- Create Image_14
	local Image_14 = GUI:Image_Create(fuwen_box, "Image_14", 750, 54, "res/custom/npc/12tmfw/x2.png")
	GUI:setAnchorPoint(Image_14, 0.00, 0.00)
	GUI:setTouchEnabled(Image_14, false)
	GUI:setTag(Image_14, 0)

	-- Create Image_15
	local Image_15 = GUI:Image_Create(fuwen_box, "Image_15", 840, 54, "res/custom/npc/12tmfw/x2.png")
	GUI:setAnchorPoint(Image_15, 0.00, 0.00)
	GUI:setTouchEnabled(Image_15, false)
	GUI:setTag(Image_15, 0)

	-- Create xuemai_bg1
	local xuemai_bg1 = GUI:Image_Create(fuwen_box, "xuemai_bg1", 17, 397, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg1, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg1, true)
	GUI:setTag(xuemai_bg1, 0)

	-- Create xuemai_bg2
	local xuemai_bg2 = GUI:Image_Create(fuwen_box, "xuemai_bg2", 17, 327, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg2, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg2, true)
	GUI:setTag(xuemai_bg2, 0)

	-- Create xuemai_bg3
	local xuemai_bg3 = GUI:Image_Create(fuwen_box, "xuemai_bg3", 17, 252, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg3, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg3, true)
	GUI:setTag(xuemai_bg3, 0)

	-- Create xuemai_bg4
	local xuemai_bg4 = GUI:Image_Create(fuwen_box, "xuemai_bg4", 16, 182, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg4, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg4, true)
	GUI:setTag(xuemai_bg4, 0)

	-- Create xuemai_bg5
	local xuemai_bg5 = GUI:Image_Create(fuwen_box, "xuemai_bg5", 17, 111, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg5, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg5, true)
	GUI:setTag(xuemai_bg5, 0)

	-- Create xuemai_bg6
	local xuemai_bg6 = GUI:Image_Create(fuwen_box, "xuemai_bg6", 8, 16, "res/custom/npc/12tmfw/s2.png")
	GUI:setAnchorPoint(xuemai_bg6, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg6, true)
	GUI:setTag(xuemai_bg6, 0)

	-- Create xuemai_bg7
	local xuemai_bg7 = GUI:Image_Create(fuwen_box, "xuemai_bg7", 109, 397, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg7, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg7, true)
	GUI:setTag(xuemai_bg7, 0)

	-- Create xuemai_bg8
	local xuemai_bg8 = GUI:Image_Create(fuwen_box, "xuemai_bg8", 109, 327, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg8, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg8, true)
	GUI:setTag(xuemai_bg8, 0)

	-- Create xuemai_bg9
	local xuemai_bg9 = GUI:Image_Create(fuwen_box, "xuemai_bg9", 109, 252, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg9, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg9, true)
	GUI:setTag(xuemai_bg9, 0)

	-- Create xuemai_bg10
	local xuemai_bg10 = GUI:Image_Create(fuwen_box, "xuemai_bg10", 108, 182, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg10, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg10, true)
	GUI:setTag(xuemai_bg10, 0)

	-- Create xuemai_bg11
	local xuemai_bg11 = GUI:Image_Create(fuwen_box, "xuemai_bg11", 109, 111, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg11, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg11, true)
	GUI:setTag(xuemai_bg11, 0)

	-- Create xuemai_bg12
	local xuemai_bg12 = GUI:Image_Create(fuwen_box, "xuemai_bg12", 97, 16, "res/custom/npc/12tmfw/s2.png")
	GUI:setAnchorPoint(xuemai_bg12, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg12, true)
	GUI:setTag(xuemai_bg12, 0)

	-- Create xuemai_bg13
	local xuemai_bg13 = GUI:Image_Create(fuwen_box, "xuemai_bg13", 199, 397, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg13, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg13, true)
	GUI:setTag(xuemai_bg13, 0)

	-- Create xuemai_bg14
	local xuemai_bg14 = GUI:Image_Create(fuwen_box, "xuemai_bg14", 199, 327, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg14, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg14, true)
	GUI:setTag(xuemai_bg14, 0)

	-- Create xuemai_bg15
	local xuemai_bg15 = GUI:Image_Create(fuwen_box, "xuemai_bg15", 199, 252, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg15, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg15, true)
	GUI:setTag(xuemai_bg15, 0)

	-- Create xuemai_bg16
	local xuemai_bg16 = GUI:Image_Create(fuwen_box, "xuemai_bg16", 198, 182, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg16, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg16, true)
	GUI:setTag(xuemai_bg16, 0)

	-- Create xuemai_bg17
	local xuemai_bg17 = GUI:Image_Create(fuwen_box, "xuemai_bg17", 199, 111, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg17, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg17, true)
	GUI:setTag(xuemai_bg17, 0)

	-- Create xuemai_bg18
	local xuemai_bg18 = GUI:Image_Create(fuwen_box, "xuemai_bg18", 187, 16, "res/custom/npc/12tmfw/s2.png")
	GUI:setAnchorPoint(xuemai_bg18, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg18, true)
	GUI:setTag(xuemai_bg18, 0)

	-- Create xuemai_bg19
	local xuemai_bg19 = GUI:Image_Create(fuwen_box, "xuemai_bg19", 290, 397, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg19, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg19, true)
	GUI:setTag(xuemai_bg19, 0)

	-- Create xuemai_bg20
	local xuemai_bg20 = GUI:Image_Create(fuwen_box, "xuemai_bg20", 290, 327, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg20, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg20, true)
	GUI:setTag(xuemai_bg20, 0)

	-- Create xuemai_bg21
	local xuemai_bg21 = GUI:Image_Create(fuwen_box, "xuemai_bg21", 290, 252, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg21, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg21, true)
	GUI:setTag(xuemai_bg21, 0)

	-- Create xuemai_bg22
	local xuemai_bg22 = GUI:Image_Create(fuwen_box, "xuemai_bg22", 289, 182, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg22, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg22, true)
	GUI:setTag(xuemai_bg22, 0)

	-- Create xuemai_bg23
	local xuemai_bg23 = GUI:Image_Create(fuwen_box, "xuemai_bg23", 290, 111, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg23, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg23, true)
	GUI:setTag(xuemai_bg23, 0)

	-- Create xuemai_bg24
	local xuemai_bg24 = GUI:Image_Create(fuwen_box, "xuemai_bg24", 278, 16, "res/custom/npc/12tmfw/s2.png")
	GUI:setAnchorPoint(xuemai_bg24, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg24, true)
	GUI:setTag(xuemai_bg24, 0)

	-- Create xuemai_bg25
	local xuemai_bg25 = GUI:Image_Create(fuwen_box, "xuemai_bg25", 376, 397, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg25, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg25, true)
	GUI:setTag(xuemai_bg25, 0)

	-- Create xuemai_bg26
	local xuemai_bg26 = GUI:Image_Create(fuwen_box, "xuemai_bg26", 376, 327, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg26, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg26, true)
	GUI:setTag(xuemai_bg26, 0)

	-- Create xuemai_bg27
	local xuemai_bg27 = GUI:Image_Create(fuwen_box, "xuemai_bg27", 376, 252, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg27, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg27, true)
	GUI:setTag(xuemai_bg27, 0)

	-- Create xuemai_bg28
	local xuemai_bg28 = GUI:Image_Create(fuwen_box, "xuemai_bg28", 375, 182, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg28, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg28, true)
	GUI:setTag(xuemai_bg28, 0)

	-- Create xuemai_bg29
	local xuemai_bg29 = GUI:Image_Create(fuwen_box, "xuemai_bg29", 376, 111, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg29, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg29, true)
	GUI:setTag(xuemai_bg29, 0)

	-- Create xuemai_bg30
	local xuemai_bg30 = GUI:Image_Create(fuwen_box, "xuemai_bg30", 367, 16, "res/custom/npc/12tmfw/s2.png")
	GUI:setAnchorPoint(xuemai_bg30, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg30, true)
	GUI:setTag(xuemai_bg30, 0)

	-- Create xuemai_bg31
	local xuemai_bg31 = GUI:Image_Create(fuwen_box, "xuemai_bg31", 469, 397, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg31, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg31, true)
	GUI:setTag(xuemai_bg31, 0)

	-- Create xuemai_bg32
	local xuemai_bg32 = GUI:Image_Create(fuwen_box, "xuemai_bg32", 469, 327, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg32, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg32, true)
	GUI:setTag(xuemai_bg32, 0)

	-- Create xuemai_bg33
	local xuemai_bg33 = GUI:Image_Create(fuwen_box, "xuemai_bg33", 469, 252, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg33, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg33, true)
	GUI:setTag(xuemai_bg33, 0)

	-- Create xuemai_bg34
	local xuemai_bg34 = GUI:Image_Create(fuwen_box, "xuemai_bg34", 468, 182, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg34, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg34, true)
	GUI:setTag(xuemai_bg34, 0)

	-- Create xuemai_bg35
	local xuemai_bg35 = GUI:Image_Create(fuwen_box, "xuemai_bg35", 469, 111, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg35, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg35, true)
	GUI:setTag(xuemai_bg35, 0)

	-- Create xuemai_bg36
	local xuemai_bg36 = GUI:Image_Create(fuwen_box, "xuemai_bg36", 457, 16, "res/custom/npc/12tmfw/s2.png")
	GUI:setAnchorPoint(xuemai_bg36, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg36, true)
	GUI:setTag(xuemai_bg36, 0)

	-- Create xuemai_bg37
	local xuemai_bg37 = GUI:Image_Create(fuwen_box, "xuemai_bg37", 552, 397, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg37, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg37, true)
	GUI:setTag(xuemai_bg37, 0)

	-- Create xuemai_bg38
	local xuemai_bg38 = GUI:Image_Create(fuwen_box, "xuemai_bg38", 552, 327, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg38, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg38, true)
	GUI:setTag(xuemai_bg38, 0)

	-- Create xuemai_bg39
	local xuemai_bg39 = GUI:Image_Create(fuwen_box, "xuemai_bg39", 552, 252, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg39, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg39, true)
	GUI:setTag(xuemai_bg39, 0)

	-- Create xuemai_bg40
	local xuemai_bg40 = GUI:Image_Create(fuwen_box, "xuemai_bg40", 551, 182, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg40, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg40, true)
	GUI:setTag(xuemai_bg40, 0)

	-- Create xuemai_bg41
	local xuemai_bg41 = GUI:Image_Create(fuwen_box, "xuemai_bg41", 552, 111, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg41, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg41, true)
	GUI:setTag(xuemai_bg41, 0)

	-- Create xuemai_bg42
	local xuemai_bg42 = GUI:Image_Create(fuwen_box, "xuemai_bg42", 543, 16, "res/custom/npc/12tmfw/s2.png")
	GUI:setAnchorPoint(xuemai_bg42, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg42, true)
	GUI:setTag(xuemai_bg42, 0)

	-- Create xuemai_bg43
	local xuemai_bg43 = GUI:Image_Create(fuwen_box, "xuemai_bg43", 644, 397, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg43, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg43, true)
	GUI:setTag(xuemai_bg43, 0)

	-- Create xuemai_bg44
	local xuemai_bg44 = GUI:Image_Create(fuwen_box, "xuemai_bg44", 644, 327, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg44, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg44, true)
	GUI:setTag(xuemai_bg44, 0)

	-- Create xuemai_bg45
	local xuemai_bg45 = GUI:Image_Create(fuwen_box, "xuemai_bg45", 644, 252, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg45, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg45, true)
	GUI:setTag(xuemai_bg45, 0)

	-- Create xuemai_bg46
	local xuemai_bg46 = GUI:Image_Create(fuwen_box, "xuemai_bg46", 643, 182, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg46, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg46, true)
	GUI:setTag(xuemai_bg46, 0)

	-- Create xuemai_bg47
	local xuemai_bg47 = GUI:Image_Create(fuwen_box, "xuemai_bg47", 644, 111, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg47, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg47, true)
	GUI:setTag(xuemai_bg47, 0)

	-- Create xuemai_bg48
	local xuemai_bg48 = GUI:Image_Create(fuwen_box, "xuemai_bg48", 632, 16, "res/custom/npc/12tmfw/s2.png")
	GUI:setAnchorPoint(xuemai_bg48, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg48, true)
	GUI:setTag(xuemai_bg48, 0)

	-- Create xuemai_bg49
	local xuemai_bg49 = GUI:Image_Create(fuwen_box, "xuemai_bg49", 734, 397, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg49, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg49, true)
	GUI:setTag(xuemai_bg49, 0)

	-- Create xuemai_bg50
	local xuemai_bg50 = GUI:Image_Create(fuwen_box, "xuemai_bg50", 734, 327, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg50, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg50, true)
	GUI:setTag(xuemai_bg50, 0)

	-- Create xuemai_bg51
	local xuemai_bg51 = GUI:Image_Create(fuwen_box, "xuemai_bg51", 734, 252, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg51, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg51, true)
	GUI:setTag(xuemai_bg51, 0)

	-- Create xuemai_bg52
	local xuemai_bg52 = GUI:Image_Create(fuwen_box, "xuemai_bg52", 733, 182, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg52, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg52, true)
	GUI:setTag(xuemai_bg52, 0)

	-- Create xuemai_bg53
	local xuemai_bg53 = GUI:Image_Create(fuwen_box, "xuemai_bg53", 734, 111, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg53, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg53, true)
	GUI:setTag(xuemai_bg53, 0)

	-- Create xuemai_bg54
	local xuemai_bg54 = GUI:Image_Create(fuwen_box, "xuemai_bg54", 722, 16, "res/custom/npc/12tmfw/s2.png")
	GUI:setAnchorPoint(xuemai_bg54, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg54, true)
	GUI:setTag(xuemai_bg54, 0)

	-- Create xuemai_bg55
	local xuemai_bg55 = GUI:Image_Create(fuwen_box, "xuemai_bg55", 825, 397, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg55, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg55, true)
	GUI:setTag(xuemai_bg55, 0)

	-- Create xuemai_bg56
	local xuemai_bg56 = GUI:Image_Create(fuwen_box, "xuemai_bg56", 825, 327, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg56, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg56, true)
	GUI:setTag(xuemai_bg56, 0)

	-- Create xuemai_bg57
	local xuemai_bg57 = GUI:Image_Create(fuwen_box, "xuemai_bg57", 825, 252, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg57, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg57, true)
	GUI:setTag(xuemai_bg57, 0)

	-- Create xuemai_bg58
	local xuemai_bg58 = GUI:Image_Create(fuwen_box, "xuemai_bg58", 824, 182, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg58, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg58, true)
	GUI:setTag(xuemai_bg58, 0)

	-- Create xuemai_bg59
	local xuemai_bg59 = GUI:Image_Create(fuwen_box, "xuemai_bg59", 825, 111, "res/custom/npc/12tmfw/s1.png")
	GUI:setAnchorPoint(xuemai_bg59, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg59, true)
	GUI:setTag(xuemai_bg59, 0)

	-- Create xuemai_bg60
	local xuemai_bg60 = GUI:Image_Create(fuwen_box, "xuemai_bg60", 813, 16, "res/custom/npc/12tmfw/s2.png")
	GUI:setAnchorPoint(xuemai_bg60, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_bg60, true)
	GUI:setTag(xuemai_bg60, 0)

	-- Create tujian_btn
	local tujian_btn = GUI:Button_Create(FrameLayout, "tujian_btn", 813, 469, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tujian_btn, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tujian_btn, false)
	GUI:Button_setTitleText(tujian_btn, [[]])
	GUI:Button_setTitleColor(tujian_btn, "#ffffff")
	GUI:Button_setTitleFontSize(tujian_btn, 16)
	GUI:Button_titleDisableOutLine(tujian_btn)
	GUI:setAnchorPoint(tujian_btn, 0.00, 0.00)
	GUI:setTouchEnabled(tujian_btn, true)
	GUI:setTag(tujian_btn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
