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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 1, -3, "res/custom/npc/31mishu/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameLayout, "close_btn", 785, 490, "res/custom/npc/close1.png")
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

	-- Create occult_box_node
	local occult_box_node = GUI:Node_Create(FrameLayout, "occult_box_node", 285, 305)
	GUI:setTag(occult_box_node, 0)

	-- Create occult_node_1
	local occult_node_1 = GUI:Node_Create(occult_box_node, "occult_node_1", -2, 103)
	GUI:setTag(occult_node_1, 0)

	-- Create occult_node_2
	local occult_node_2 = GUI:Node_Create(occult_box_node, "occult_node_2", -2, -105)
	GUI:setTag(occult_node_2, 0)

	-- Create occult_node_3
	local occult_node_3 = GUI:Node_Create(occult_box_node, "occult_node_3", 74, -73)
	GUI:setTag(occult_node_3, 0)

	-- Create occult_node_4
	local occult_node_4 = GUI:Node_Create(occult_box_node, "occult_node_4", 101, 0)
	GUI:setTag(occult_node_4, 0)

	-- Create occult_node_5
	local occult_node_5 = GUI:Node_Create(occult_box_node, "occult_node_5", 71, 75)
	GUI:setTag(occult_node_5, 0)

	-- Create occult_node_6
	local occult_node_6 = GUI:Node_Create(occult_box_node, "occult_node_6", -104, -1)
	GUI:setTag(occult_node_6, 0)

	-- Create occult_node_7
	local occult_node_7 = GUI:Node_Create(occult_box_node, "occult_node_7", -79, -69)
	GUI:setTag(occult_node_7, 0)

	-- Create occult_node_8
	local occult_node_8 = GUI:Node_Create(occult_box_node, "occult_node_8", -77, 77)
	GUI:setTag(occult_node_8, 0)

	-- Create occult_node_9
	local occult_node_9 = GUI:Node_Create(occult_box_node, "occult_node_9", 43, 44)
	GUI:setTag(occult_node_9, 0)

	-- Create occult_node_10
	local occult_node_10 = GUI:Node_Create(occult_box_node, "occult_node_10", -36, -34)
	GUI:setTag(occult_node_10, 0)

	-- Create occult_node_11
	local occult_node_11 = GUI:Node_Create(occult_box_node, "occult_node_11", 6, -46)
	GUI:setTag(occult_node_11, 0)

	-- Create occult_node_12
	local occult_node_12 = GUI:Node_Create(occult_box_node, "occult_node_12", 57, 3)
	GUI:setTag(occult_node_12, 0)

	-- Create occult_node_13
	local occult_node_13 = GUI:Node_Create(occult_box_node, "occult_node_13", -52, 6)
	GUI:setTag(occult_node_13, 0)

	-- Create occult_node_14
	local occult_node_14 = GUI:Node_Create(occult_box_node, "occult_node_14", 41, -32)
	GUI:setTag(occult_node_14, 0)

	-- Create occult_node_15
	local occult_node_15 = GUI:Node_Create(occult_box_node, "occult_node_15", -39, 42)
	GUI:setTag(occult_node_15, 0)

	-- Create occult_node_16
	local occult_node_16 = GUI:Node_Create(occult_box_node, "occult_node_16", 2, 62)
	GUI:setTag(occult_node_16, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(FrameLayout, "RichText_2", 78, 67, [[<font color='#ffffff' size='16' >天字引</font><font color='#00ffe8' size='16' >雷霆</font><font color='#ffffff' size='16' >，地字动</font><font color='#ff0000' size='16' >龙脉</font><font color='#ffffff' size='16' >，十六字齐出则</font><font color='#00ff00' size='16' >重定地水风火</font><br><font color='#ff0000' size='16' >集九字</font><font color='#ffffff' size='16' >可窥天机，满十六字者，当受</font><font color='#ffff00' size='16' >天道诛戮</font>]], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create suit_list_view
	local suit_list_view = GUI:ListView_Create(FrameLayout, "suit_list_view", 493, 135, 308, 317, 1)
	GUI:ListView_setBounceEnabled(suit_list_view, true)
	GUI:ListView_setGravity(suit_list_view, 2)
	GUI:setAnchorPoint(suit_list_view, 0.00, 0.00)
	GUI:setTouchEnabled(suit_list_view, true)
	GUI:setTag(suit_list_view, 0)

	-- Create look_name
	local look_name = GUI:Text_Create(FrameLayout, "look_name", 278, 459, 18, "#ffff00", [==========[[风水秘术]]==========])
	GUI:Text_enableOutline(look_name, "#000000", 1)
	GUI:setAnchorPoint(look_name, 0.50, 0.50)
	GUI:setTouchEnabled(look_name, false)
	GUI:setTag(look_name, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 649, 79, 18, "#df009f", [==========[提示：使用[          ]可解封秘术]==========])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create need_text
	local need_text = GUI:Text_Create(Text_1, "need_text", 117, 12, 18, "#ffff00", [[罗盘]])
	GUI:Text_enableOutline(need_text, "#000000", 1)
	GUI:Text_enableUnderline(need_text)
	GUI:setAnchorPoint(need_text, 0.50, 0.50)
	GUI:setTouchEnabled(need_text, true)
	GUI:setTag(need_text, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
