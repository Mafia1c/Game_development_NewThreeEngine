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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/13emqy/bg11.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameLayout, "close_btn", 784, 493, "res/custom/npc/close1.png")
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

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 70, 382, "")
	GUI:setContentSize(Button_1, 114, 106)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleDisableOutLine(Button_1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create btn_select1
	local btn_select1 = GUI:Image_Create(Button_1, "btn_select1", 0, 1, "res/custom/npc/13emqy/xz.png")
	GUI:setAnchorPoint(btn_select1, 0.00, 0.00)
	GUI:setTouchEnabled(btn_select1, false)
	GUI:setTag(btn_select1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Button_1, "Image_1", 26, 13, "res/custom/npc/13emqy/an1.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 70, 282, "")
	GUI:setContentSize(Button_2, 114, 106)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleDisableOutLine(Button_2)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create btn_select2
	local btn_select2 = GUI:Image_Create(Button_2, "btn_select2", 0, 1, "res/custom/npc/13emqy/xz.png")
	GUI:setAnchorPoint(btn_select2, 0.00, 0.00)
	GUI:setTouchEnabled(btn_select2, false)
	GUI:setTag(btn_select2, 0)
	GUI:setVisible(btn_select2, false)

	-- Create Image_1
	Image_1 = GUI:Image_Create(Button_2, "Image_1", 27, 32, "res/custom/npc/13emqy/an11.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_9
	local Image_9 = GUI:Image_Create(Button_2, "Image_9", 32, 10, "res/custom/npc/13emqy/an12.png")
	GUI:setAnchorPoint(Image_9, 0.00, 0.00)
	GUI:setTouchEnabled(Image_9, false)
	GUI:setTag(Image_9, 0)

	-- Create tujian_node
	local tujian_node = GUI:Node_Create(FrameLayout, "tujian_node", 0, 0)
	GUI:setTag(tujian_node, 0)

	-- Create ScrollView
	local ScrollView = GUI:ScrollView_Create(tujian_node, "ScrollView", 186, 484, 124, 452, 1)
	GUI:ScrollView_setBounceEnabled(ScrollView, true)
	GUI:ScrollView_setInnerContainerSize(ScrollView, 124.00, 452.00)
	GUI:setAnchorPoint(ScrollView, 0.00, 1.00)
	GUI:setTouchEnabled(ScrollView, true)
	GUI:setTag(ScrollView, 0)

	-- Create tip_btn
	local tip_btn = GUI:Button_Create(tujian_node, "tip_btn", 753, 449, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tip_btn, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tip_btn, false)
	GUI:Button_setTitleText(tip_btn, [[]])
	GUI:Button_setTitleColor(tip_btn, "#ffffff")
	GUI:Button_setTitleFontSize(tip_btn, 16)
	GUI:Button_titleDisableOutLine(tip_btn)
	GUI:setAnchorPoint(tip_btn, 0.00, 0.00)
	GUI:setTouchEnabled(tip_btn, true)
	GUI:setTag(tip_btn, 0)

	-- Create type_listview
	local type_listview = GUI:ListView_Create(tujian_node, "type_listview", 188, 35, 116, 403, 1)
	GUI:ListView_setBounceEnabled(type_listview, true)
	GUI:setAnchorPoint(type_listview, 0.00, 0.00)
	GUI:setTouchEnabled(type_listview, true)
	GUI:setTag(type_listview, 0)
	GUI:setVisible(type_listview, false)

	-- Create tujian_listview
	local tujian_listview = GUI:ListView_Create(tujian_node, "tujian_listview", 311, 125, 488, 318, 1)
	GUI:ListView_setBounceEnabled(tujian_listview, true)
	GUI:ListView_setGravity(tujian_listview, 2)
	GUI:ListView_setItemsMargin(tujian_listview, 3)
	GUI:setAnchorPoint(tujian_listview, 0.00, 0.00)
	GUI:setTouchEnabled(tujian_listview, true)
	GUI:setTag(tujian_listview, 0)

	-- Create star_text
	local star_text = GUI:Text_Create(tujian_node, "star_text", 316, 88, 18, "#00ffe8", [[泰坦星级：10★]])
	GUI:Text_enableOutline(star_text, "#000000", 1)
	GUI:setAnchorPoint(star_text, 0.00, 0.00)
	GUI:setTouchEnabled(star_text, false)
	GUI:setTag(star_text, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(tujian_node, "Text_4", 316, 65, 18, "#c0c0c0", [[提交奖励：]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create submit_rewrad_text
	local submit_rewrad_text = GUI:Text_Create(Text_4, "submit_rewrad_text", 91, -1, 18, "#ffff00", [[声望X10]])
	GUI:Text_enableOutline(submit_rewrad_text, "#000000", 1)
	GUI:setAnchorPoint(submit_rewrad_text, 0.00, 0.00)
	GUI:setTouchEnabled(submit_rewrad_text, false)
	GUI:setTag(submit_rewrad_text, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(tujian_node, "Text_5", 316, 41, 18, "#c0c0c0", [[激活奖励：]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create attr_text
	local attr_text = GUI:Text_Create(Text_5, "attr_text", 91, -1, 18, "#39b5ef", [[攻魔道伤1-1]])
	GUI:Text_enableOutline(attr_text, "#000000", 1)
	GUI:setAnchorPoint(attr_text, 0.00, 0.00)
	GUI:setTouchEnabled(attr_text, false)
	GUI:setTag(attr_text, 0)

	-- Create submit_btn
	local submit_btn = GUI:Button_Create(tujian_node, "submit_btn", 691, 58, "res/custom/npc/an.png")
	GUI:setContentSize(submit_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(submit_btn, false)
	GUI:Button_setTitleText(submit_btn, [[一键提交]])
	GUI:Button_setTitleColor(submit_btn, "#ffffff")
	GUI:Button_setTitleFontSize(submit_btn, 18)
	GUI:Button_titleEnableOutline(submit_btn, "#000000", 1)
	GUI:setAnchorPoint(submit_btn, 0.00, 0.00)
	GUI:setTouchEnabled(submit_btn, true)
	GUI:setTag(submit_btn, 0)

	-- Create prestige_text
	local prestige_text = GUI:Text_Create(tujian_node, "prestige_text", 318, 453, 18, "#00ff00", [[声望：20]])
	GUI:Text_enableOutline(prestige_text, "#000000", 1)
	GUI:setAnchorPoint(prestige_text, 0.00, 0.00)
	GUI:setTouchEnabled(prestige_text, false)
	GUI:setTag(prestige_text, 0)

	-- Create comm_submit_btn
	local comm_submit_btn = GUI:Button_Create(tujian_node, "comm_submit_btn", 577, 58, "res/custom/npc/an.png")
	GUI:setContentSize(comm_submit_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(comm_submit_btn, false)
	GUI:Button_setTitleText(comm_submit_btn, [[万能激活]])
	GUI:Button_setTitleColor(comm_submit_btn, "#ffffff")
	GUI:Button_setTitleFontSize(comm_submit_btn, 18)
	GUI:Button_titleEnableOutline(comm_submit_btn, "#000000", 1)
	GUI:setAnchorPoint(comm_submit_btn, 0.00, 0.00)
	GUI:setTouchEnabled(comm_submit_btn, true)
	GUI:setTag(comm_submit_btn, 0)

	-- Create attr_node
	local attr_node = GUI:Node_Create(FrameLayout, "attr_node", 0, 0)
	GUI:setTag(attr_node, 0)
	GUI:setVisible(attr_node, false)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(attr_node, "ListView_1", 196, 262, 221, 183, 1)
	GUI:ListView_setGravity(ListView_1, 1)
	GUI:ListView_setItemsMargin(ListView_1, 8)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(ListView_1, "Image_2", 84, 153, "res/custom/npc/13emqy/att1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create total_attr_name1
	local total_attr_name1 = GUI:Text_Create(Image_2, "total_attr_name1", -10, 1, 18, "#ffffff", [[生命值:]])
	GUI:Text_enableOutline(total_attr_name1, "#000000", 1)
	GUI:setAnchorPoint(total_attr_name1, 1.00, 0.00)
	GUI:setTouchEnabled(total_attr_name1, false)
	GUI:setTag(total_attr_name1, 0)

	-- Create total_attr_value1
	local total_attr_value1 = GUI:Text_Create(Image_2, "total_attr_value1", 2, 2, 18, "#00ff00", [[1]])
	GUI:Text_enableOutline(total_attr_value1, "#000000", 1)
	GUI:setAnchorPoint(total_attr_value1, 0.00, 0.00)
	GUI:setTouchEnabled(total_attr_value1, false)
	GUI:setTag(total_attr_value1, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(ListView_1, "Image_3", 84, 115, "res/custom/npc/13emqy/att1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create total_attr_name2
	local total_attr_name2 = GUI:Text_Create(Image_3, "total_attr_name2", -10, 1, 18, "#ffffff", [[生命值:]])
	GUI:Text_enableOutline(total_attr_name2, "#000000", 1)
	GUI:setAnchorPoint(total_attr_name2, 1.00, 0.00)
	GUI:setTouchEnabled(total_attr_name2, false)
	GUI:setTag(total_attr_name2, 0)

	-- Create total_attr_value2
	local total_attr_value2 = GUI:Text_Create(Image_3, "total_attr_value2", 2, 2, 18, "#00ff00", [[1]])
	GUI:Text_enableOutline(total_attr_value2, "#000000", 1)
	GUI:setAnchorPoint(total_attr_value2, 0.00, 0.00)
	GUI:setTouchEnabled(total_attr_value2, false)
	GUI:setTag(total_attr_value2, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(ListView_1, "Image_4", 84, 77, "res/custom/npc/13emqy/att1.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create total_attr_name3
	local total_attr_name3 = GUI:Text_Create(Image_4, "total_attr_name3", -10, 1, 18, "#ffffff", [[生命值:]])
	GUI:Text_enableOutline(total_attr_name3, "#000000", 1)
	GUI:setAnchorPoint(total_attr_name3, 1.00, 0.00)
	GUI:setTouchEnabled(total_attr_name3, false)
	GUI:setTag(total_attr_name3, 0)

	-- Create total_attr_value3
	local total_attr_value3 = GUI:Text_Create(Image_4, "total_attr_value3", 2, 2, 18, "#00ff00", [[1]])
	GUI:Text_enableOutline(total_attr_value3, "#000000", 1)
	GUI:setAnchorPoint(total_attr_value3, 0.00, 0.00)
	GUI:setTouchEnabled(total_attr_value3, false)
	GUI:setTag(total_attr_value3, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(ListView_1, "Image_5", 84, 39, "res/custom/npc/13emqy/att1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create total_attr_name4
	local total_attr_name4 = GUI:Text_Create(Image_5, "total_attr_name4", -10, 1, 18, "#ffffff", [[生命值:]])
	GUI:Text_enableOutline(total_attr_name4, "#000000", 1)
	GUI:setAnchorPoint(total_attr_name4, 1.00, 0.00)
	GUI:setTouchEnabled(total_attr_name4, false)
	GUI:setTag(total_attr_name4, 0)

	-- Create total_attr_value4
	local total_attr_value4 = GUI:Text_Create(Image_5, "total_attr_value4", 2, 2, 18, "#00ff00", [[1]])
	GUI:Text_enableOutline(total_attr_value4, "#000000", 1)
	GUI:setAnchorPoint(total_attr_value4, 0.00, 0.00)
	GUI:setTouchEnabled(total_attr_value4, false)
	GUI:setTag(total_attr_value4, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(ListView_1, "Image_6", 84, 1, "res/custom/npc/13emqy/att1.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create total_attr_name5
	local total_attr_name5 = GUI:Text_Create(Image_6, "total_attr_name5", -10, 1, 18, "#ffffff", [[生命值:]])
	GUI:Text_enableOutline(total_attr_name5, "#000000", 1)
	GUI:setAnchorPoint(total_attr_name5, 1.00, 0.00)
	GUI:setTouchEnabled(total_attr_name5, false)
	GUI:setTag(total_attr_name5, 0)

	-- Create total_attr_value5
	local total_attr_value5 = GUI:Text_Create(Image_6, "total_attr_value5", 2, 2, 18, "#00ff00", [[1]])
	GUI:Text_enableOutline(total_attr_value5, "#000000", 1)
	GUI:setAnchorPoint(total_attr_value5, 0.00, 0.00)
	GUI:setTouchEnabled(total_attr_value5, false)
	GUI:setTag(total_attr_value5, 0)

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(attr_node, "ListView_2", 196, 46, 229, 176, 1)
	GUI:ListView_setGravity(ListView_2, 1)
	GUI:ListView_setItemsMargin(ListView_2, 6)
	GUI:setAnchorPoint(ListView_2, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_2, true)
	GUI:setTag(ListView_2, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_2, "Image_2", 92, 146, "res/custom/npc/13emqy/att1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create random_attr_name1
	local random_attr_name1 = GUI:Text_Create(Image_2, "random_attr_name1", -10, 1, 18, "#ffffff", [[生命加成:]])
	GUI:Text_enableOutline(random_attr_name1, "#000000", 1)
	GUI:setAnchorPoint(random_attr_name1, 1.00, 0.00)
	GUI:setTouchEnabled(random_attr_name1, false)
	GUI:setTag(random_attr_name1, 0)

	-- Create random_attr_value1
	local random_attr_value1 = GUI:Text_Create(Image_2, "random_attr_value1", 2, 1, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(random_attr_value1, "#000000", 1)
	GUI:setAnchorPoint(random_attr_value1, 0.00, 0.00)
	GUI:setTouchEnabled(random_attr_value1, false)
	GUI:setTag(random_attr_value1, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_2, "Image_3", 92, 110, "res/custom/npc/13emqy/att1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create random_attr_name2
	local random_attr_name2 = GUI:Text_Create(Image_3, "random_attr_name2", -10, 1, 18, "#ffffff", [[防御加成:]])
	GUI:Text_enableOutline(random_attr_name2, "#000000", 1)
	GUI:setAnchorPoint(random_attr_name2, 1.00, 0.00)
	GUI:setTouchEnabled(random_attr_name2, false)
	GUI:setTag(random_attr_name2, 0)

	-- Create random_attr_value2
	local random_attr_value2 = GUI:Text_Create(Image_3, "random_attr_value2", 2, 1, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(random_attr_value2, "#000000", 1)
	GUI:setAnchorPoint(random_attr_value2, 0.00, 0.00)
	GUI:setTouchEnabled(random_attr_value2, false)
	GUI:setTag(random_attr_value2, 0)

	-- Create Image_4
	Image_4 = GUI:Image_Create(ListView_2, "Image_4", 92, 74, "res/custom/npc/13emqy/att1.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create random_attr_name3
	local random_attr_name3 = GUI:Text_Create(Image_4, "random_attr_name3", -10, 1, 18, "#ffffff", [[魔防加成:]])
	GUI:Text_enableOutline(random_attr_name3, "#000000", 1)
	GUI:setAnchorPoint(random_attr_name3, 1.00, 0.00)
	GUI:setTouchEnabled(random_attr_name3, false)
	GUI:setTag(random_attr_name3, 0)

	-- Create random_attr_value3
	local random_attr_value3 = GUI:Text_Create(Image_4, "random_attr_value3", 2, 1, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(random_attr_value3, "#000000", 1)
	GUI:setAnchorPoint(random_attr_value3, 0.00, 0.00)
	GUI:setTouchEnabled(random_attr_value3, false)
	GUI:setTag(random_attr_value3, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_2, "Image_5", 92, 38, "res/custom/npc/13emqy/att1.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create random_attr_name4
	local random_attr_name4 = GUI:Text_Create(Image_5, "random_attr_name4", -10, 1, 18, "#ffffff", [[攻击加成:]])
	GUI:Text_enableOutline(random_attr_name4, "#000000", 1)
	GUI:setAnchorPoint(random_attr_name4, 1.00, 0.00)
	GUI:setTouchEnabled(random_attr_name4, false)
	GUI:setTag(random_attr_name4, 0)

	-- Create random_attr_value4
	local random_attr_value4 = GUI:Text_Create(Image_5, "random_attr_value4", 2, 1, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(random_attr_value4, "#000000", 1)
	GUI:setAnchorPoint(random_attr_value4, 0.00, 0.00)
	GUI:setTouchEnabled(random_attr_value4, false)
	GUI:setTag(random_attr_value4, 0)

	-- Create Image_8
	local Image_8 = GUI:Image_Create(ListView_2, "Image_8", 92, 2, "res/custom/npc/13emqy/att1.png")
	GUI:setAnchorPoint(Image_8, 0.00, 0.00)
	GUI:setTouchEnabled(Image_8, false)
	GUI:setTag(Image_8, 0)

	-- Create random_attr_name5
	local random_attr_name5 = GUI:Text_Create(Image_8, "random_attr_name5", -10, 1, 18, "#ffffff", [[暴击伤害:]])
	GUI:Text_enableOutline(random_attr_name5, "#000000", 1)
	GUI:setAnchorPoint(random_attr_name5, 1.00, 0.00)
	GUI:setTouchEnabled(random_attr_name5, false)
	GUI:setTag(random_attr_name5, 0)

	-- Create random_attr_value5
	local random_attr_value5 = GUI:Text_Create(Image_8, "random_attr_value5", 2, 1, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(random_attr_value5, "#000000", 1)
	GUI:setAnchorPoint(random_attr_value5, 0.00, 0.00)
	GUI:setTouchEnabled(random_attr_value5, false)
	GUI:setTag(random_attr_value5, 0)

	-- Create ListView_3
	local ListView_3 = GUI:ListView_Create(attr_node, "ListView_3", 443, 93, 357, 356, 1)
	GUI:ListView_setGravity(ListView_3, 1)
	GUI:ListView_setItemsMargin(ListView_3, 4)
	GUI:setAnchorPoint(ListView_3, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_3, true)
	GUI:setTag(ListView_3, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(ListView_3, "Panel_1", 1, 316, 356, 40, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 0)

	-- Create allot_btn1
	local allot_btn1 = GUI:Image_Create(Panel_1, "allot_btn1", 92, 2, "res/custom/npc/13emqy/att2.png")
	GUI:setAnchorPoint(allot_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(allot_btn1, true)
	GUI:setTag(allot_btn1, 0)

	-- Create minus_attr_btn1
	local minus_attr_btn1 = GUI:Button_Create(Panel_1, "minus_attr_btn1", 288, 7, "res/custom/npc/13emqy/-.png")
	GUI:setContentSize(minus_attr_btn1, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(minus_attr_btn1, false)
	GUI:Button_setTitleText(minus_attr_btn1, [[]])
	GUI:Button_setTitleColor(minus_attr_btn1, "#ffffff")
	GUI:Button_setTitleFontSize(minus_attr_btn1, 16)
	GUI:Button_titleDisableOutLine(minus_attr_btn1)
	GUI:setAnchorPoint(minus_attr_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(minus_attr_btn1, true)
	GUI:setTag(minus_attr_btn1, 0)

	-- Create add_attr_btn1
	local add_attr_btn1 = GUI:Button_Create(Panel_1, "add_attr_btn1", 321, 7, "res/custom/npc/13emqy/+.png")
	GUI:setContentSize(add_attr_btn1, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(add_attr_btn1, false)
	GUI:Button_setTitleText(add_attr_btn1, [[]])
	GUI:Button_setTitleColor(add_attr_btn1, "#ffffff")
	GUI:Button_setTitleFontSize(add_attr_btn1, 16)
	GUI:Button_titleDisableOutLine(add_attr_btn1)
	GUI:setAnchorPoint(add_attr_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(add_attr_btn1, true)
	GUI:setTag(add_attr_btn1, 0)

	-- Create allot_attr_name1
	local allot_attr_name1 = GUI:Text_Create(Panel_1, "allot_attr_name1", 85, 7, 18, "#ffffff", [[生命值:]])
	GUI:Text_enableOutline(allot_attr_name1, "#000000", 1)
	GUI:setAnchorPoint(allot_attr_name1, 1.00, 0.00)
	GUI:setTouchEnabled(allot_attr_name1, false)
	GUI:setTag(allot_attr_name1, 0)

	-- Create allot_talent_value1
	local allot_talent_value1 = GUI:Text_Create(Panel_1, "allot_talent_value1", 97, 7, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(allot_talent_value1, "#000000", 1)
	GUI:setAnchorPoint(allot_talent_value1, 0.00, 0.00)
	GUI:setTouchEnabled(allot_talent_value1, false)
	GUI:setTag(allot_talent_value1, 0)

	-- Create Panel_2
	local Panel_2 = GUI:Layout_Create(ListView_3, "Panel_2", 1, 272, 356, 40, false)
	GUI:setAnchorPoint(Panel_2, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_2, false)
	GUI:setTag(Panel_2, 0)

	-- Create allot_btn2
	local allot_btn2 = GUI:Image_Create(Panel_2, "allot_btn2", 92, 2, "res/custom/npc/13emqy/att2.png")
	GUI:setAnchorPoint(allot_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(allot_btn2, true)
	GUI:setTag(allot_btn2, 0)

	-- Create minus_attr_btn2
	local minus_attr_btn2 = GUI:Button_Create(Panel_2, "minus_attr_btn2", 288, 7, "res/custom/npc/13emqy/-.png")
	GUI:setContentSize(minus_attr_btn2, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(minus_attr_btn2, false)
	GUI:Button_setTitleText(minus_attr_btn2, [[]])
	GUI:Button_setTitleColor(minus_attr_btn2, "#ffffff")
	GUI:Button_setTitleFontSize(minus_attr_btn2, 16)
	GUI:Button_titleDisableOutLine(minus_attr_btn2)
	GUI:setAnchorPoint(minus_attr_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(minus_attr_btn2, true)
	GUI:setTag(minus_attr_btn2, 0)

	-- Create add_attr_btn2
	local add_attr_btn2 = GUI:Button_Create(Panel_2, "add_attr_btn2", 321, 7, "res/custom/npc/13emqy/+.png")
	GUI:setContentSize(add_attr_btn2, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(add_attr_btn2, false)
	GUI:Button_setTitleText(add_attr_btn2, [[]])
	GUI:Button_setTitleColor(add_attr_btn2, "#ffffff")
	GUI:Button_setTitleFontSize(add_attr_btn2, 16)
	GUI:Button_titleDisableOutLine(add_attr_btn2)
	GUI:setAnchorPoint(add_attr_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(add_attr_btn2, true)
	GUI:setTag(add_attr_btn2, 0)

	-- Create allot_attr_name2
	local allot_attr_name2 = GUI:Text_Create(Panel_2, "allot_attr_name2", 85, 7, 18, "#ffffff", [[魔法值:]])
	GUI:Text_enableOutline(allot_attr_name2, "#000000", 1)
	GUI:setAnchorPoint(allot_attr_name2, 1.00, 0.00)
	GUI:setTouchEnabled(allot_attr_name2, false)
	GUI:setTag(allot_attr_name2, 0)

	-- Create allot_talent_value2
	local allot_talent_value2 = GUI:Text_Create(Panel_2, "allot_talent_value2", 97, 7, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(allot_talent_value2, "#000000", 1)
	GUI:setAnchorPoint(allot_talent_value2, 0.00, 0.00)
	GUI:setTouchEnabled(allot_talent_value2, false)
	GUI:setTag(allot_talent_value2, 0)

	-- Create Panel_3
	local Panel_3 = GUI:Layout_Create(ListView_3, "Panel_3", 1, 228, 356, 40, false)
	GUI:setAnchorPoint(Panel_3, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_3, false)
	GUI:setTag(Panel_3, 0)

	-- Create allot_btn3
	local allot_btn3 = GUI:Image_Create(Panel_3, "allot_btn3", 92, 2, "res/custom/npc/13emqy/att2.png")
	GUI:setAnchorPoint(allot_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(allot_btn3, true)
	GUI:setTag(allot_btn3, 0)

	-- Create minus_attr_btn3
	local minus_attr_btn3 = GUI:Button_Create(Panel_3, "minus_attr_btn3", 288, 7, "res/custom/npc/13emqy/-.png")
	GUI:setContentSize(minus_attr_btn3, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(minus_attr_btn3, false)
	GUI:Button_setTitleText(minus_attr_btn3, [[]])
	GUI:Button_setTitleColor(minus_attr_btn3, "#ffffff")
	GUI:Button_setTitleFontSize(minus_attr_btn3, 16)
	GUI:Button_titleDisableOutLine(minus_attr_btn3)
	GUI:setAnchorPoint(minus_attr_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(minus_attr_btn3, true)
	GUI:setTag(minus_attr_btn3, 0)

	-- Create add_attr_btn3
	local add_attr_btn3 = GUI:Button_Create(Panel_3, "add_attr_btn3", 321, 7, "res/custom/npc/13emqy/+.png")
	GUI:setContentSize(add_attr_btn3, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(add_attr_btn3, false)
	GUI:Button_setTitleText(add_attr_btn3, [[]])
	GUI:Button_setTitleColor(add_attr_btn3, "#ffffff")
	GUI:Button_setTitleFontSize(add_attr_btn3, 16)
	GUI:Button_titleDisableOutLine(add_attr_btn3)
	GUI:setAnchorPoint(add_attr_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(add_attr_btn3, true)
	GUI:setTag(add_attr_btn3, 0)

	-- Create allot_attr_name3
	local allot_attr_name3 = GUI:Text_Create(Panel_3, "allot_attr_name3", 85, 7, 18, "#ffffff", [[防御下限:]])
	GUI:Text_enableOutline(allot_attr_name3, "#000000", 1)
	GUI:setAnchorPoint(allot_attr_name3, 1.00, 0.00)
	GUI:setTouchEnabled(allot_attr_name3, false)
	GUI:setTag(allot_attr_name3, 0)

	-- Create allot_talent_value3
	local allot_talent_value3 = GUI:Text_Create(Panel_3, "allot_talent_value3", 97, 7, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(allot_talent_value3, "#000000", 1)
	GUI:setAnchorPoint(allot_talent_value3, 0.00, 0.00)
	GUI:setTouchEnabled(allot_talent_value3, false)
	GUI:setTag(allot_talent_value3, 0)

	-- Create Panel_4
	local Panel_4 = GUI:Layout_Create(ListView_3, "Panel_4", 1, 184, 356, 40, false)
	GUI:setAnchorPoint(Panel_4, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_4, false)
	GUI:setTag(Panel_4, 0)

	-- Create allot_btn4
	local allot_btn4 = GUI:Image_Create(Panel_4, "allot_btn4", 92, 2, "res/custom/npc/13emqy/att2.png")
	GUI:setAnchorPoint(allot_btn4, 0.00, 0.00)
	GUI:setTouchEnabled(allot_btn4, true)
	GUI:setTag(allot_btn4, 0)

	-- Create minus_attr_btn4
	local minus_attr_btn4 = GUI:Button_Create(Panel_4, "minus_attr_btn4", 288, 7, "res/custom/npc/13emqy/-.png")
	GUI:setContentSize(minus_attr_btn4, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(minus_attr_btn4, false)
	GUI:Button_setTitleText(minus_attr_btn4, [[]])
	GUI:Button_setTitleColor(minus_attr_btn4, "#ffffff")
	GUI:Button_setTitleFontSize(minus_attr_btn4, 16)
	GUI:Button_titleDisableOutLine(minus_attr_btn4)
	GUI:setAnchorPoint(minus_attr_btn4, 0.00, 0.00)
	GUI:setTouchEnabled(minus_attr_btn4, true)
	GUI:setTag(minus_attr_btn4, 0)

	-- Create add_attr_btn4
	local add_attr_btn4 = GUI:Button_Create(Panel_4, "add_attr_btn4", 321, 7, "res/custom/npc/13emqy/+.png")
	GUI:setContentSize(add_attr_btn4, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(add_attr_btn4, false)
	GUI:Button_setTitleText(add_attr_btn4, [[]])
	GUI:Button_setTitleColor(add_attr_btn4, "#ffffff")
	GUI:Button_setTitleFontSize(add_attr_btn4, 16)
	GUI:Button_titleDisableOutLine(add_attr_btn4)
	GUI:setAnchorPoint(add_attr_btn4, 0.00, 0.00)
	GUI:setTouchEnabled(add_attr_btn4, true)
	GUI:setTag(add_attr_btn4, 0)

	-- Create allot_attr_name4
	local allot_attr_name4 = GUI:Text_Create(Panel_4, "allot_attr_name4", 85, 7, 18, "#ffffff", [[防御上限:]])
	GUI:Text_enableOutline(allot_attr_name4, "#000000", 1)
	GUI:setAnchorPoint(allot_attr_name4, 1.00, 0.00)
	GUI:setTouchEnabled(allot_attr_name4, false)
	GUI:setTag(allot_attr_name4, 0)

	-- Create allot_talent_value4
	local allot_talent_value4 = GUI:Text_Create(Panel_4, "allot_talent_value4", 97, 7, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(allot_talent_value4, "#000000", 1)
	GUI:setAnchorPoint(allot_talent_value4, 0.00, 0.00)
	GUI:setTouchEnabled(allot_talent_value4, false)
	GUI:setTag(allot_talent_value4, 0)

	-- Create Panel_5
	local Panel_5 = GUI:Layout_Create(ListView_3, "Panel_5", 1, 140, 356, 40, false)
	GUI:setAnchorPoint(Panel_5, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_5, false)
	GUI:setTag(Panel_5, 0)

	-- Create allot_btn5
	local allot_btn5 = GUI:Image_Create(Panel_5, "allot_btn5", 92, 2, "res/custom/npc/13emqy/att2.png")
	GUI:setAnchorPoint(allot_btn5, 0.00, 0.00)
	GUI:setTouchEnabled(allot_btn5, true)
	GUI:setTag(allot_btn5, 0)

	-- Create minus_attr_btn5
	local minus_attr_btn5 = GUI:Button_Create(Panel_5, "minus_attr_btn5", 288, 7, "res/custom/npc/13emqy/-.png")
	GUI:setContentSize(minus_attr_btn5, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(minus_attr_btn5, false)
	GUI:Button_setTitleText(minus_attr_btn5, [[]])
	GUI:Button_setTitleColor(minus_attr_btn5, "#ffffff")
	GUI:Button_setTitleFontSize(minus_attr_btn5, 16)
	GUI:Button_titleDisableOutLine(minus_attr_btn5)
	GUI:setAnchorPoint(minus_attr_btn5, 0.00, 0.00)
	GUI:setTouchEnabled(minus_attr_btn5, true)
	GUI:setTag(minus_attr_btn5, 0)

	-- Create add_attr_btn5
	local add_attr_btn5 = GUI:Button_Create(Panel_5, "add_attr_btn5", 321, 7, "res/custom/npc/13emqy/+.png")
	GUI:setContentSize(add_attr_btn5, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(add_attr_btn5, false)
	GUI:Button_setTitleText(add_attr_btn5, [[]])
	GUI:Button_setTitleColor(add_attr_btn5, "#ffffff")
	GUI:Button_setTitleFontSize(add_attr_btn5, 16)
	GUI:Button_titleDisableOutLine(add_attr_btn5)
	GUI:setAnchorPoint(add_attr_btn5, 0.00, 0.00)
	GUI:setTouchEnabled(add_attr_btn5, true)
	GUI:setTag(add_attr_btn5, 0)

	-- Create allot_attr_name5
	local allot_attr_name5 = GUI:Text_Create(Panel_5, "allot_attr_name5", 85, 7, 18, "#ffffff", [[魔防下限:]])
	GUI:Text_enableOutline(allot_attr_name5, "#000000", 1)
	GUI:setAnchorPoint(allot_attr_name5, 1.00, 0.00)
	GUI:setTouchEnabled(allot_attr_name5, false)
	GUI:setTag(allot_attr_name5, 0)

	-- Create allot_talent_value5
	local allot_talent_value5 = GUI:Text_Create(Panel_5, "allot_talent_value5", 97, 7, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(allot_talent_value5, "#000000", 1)
	GUI:setAnchorPoint(allot_talent_value5, 0.00, 0.00)
	GUI:setTouchEnabled(allot_talent_value5, false)
	GUI:setTag(allot_talent_value5, 0)

	-- Create Panel_6
	local Panel_6 = GUI:Layout_Create(ListView_3, "Panel_6", 1, 96, 356, 40, false)
	GUI:setAnchorPoint(Panel_6, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_6, false)
	GUI:setTag(Panel_6, 0)

	-- Create allot_btn6
	local allot_btn6 = GUI:Image_Create(Panel_6, "allot_btn6", 92, 2, "res/custom/npc/13emqy/att2.png")
	GUI:setAnchorPoint(allot_btn6, 0.00, 0.00)
	GUI:setTouchEnabled(allot_btn6, true)
	GUI:setTag(allot_btn6, 0)

	-- Create minus_attr_btn6
	local minus_attr_btn6 = GUI:Button_Create(Panel_6, "minus_attr_btn6", 288, 7, "res/custom/npc/13emqy/-.png")
	GUI:setContentSize(minus_attr_btn6, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(minus_attr_btn6, false)
	GUI:Button_setTitleText(minus_attr_btn6, [[]])
	GUI:Button_setTitleColor(minus_attr_btn6, "#ffffff")
	GUI:Button_setTitleFontSize(minus_attr_btn6, 16)
	GUI:Button_titleDisableOutLine(minus_attr_btn6)
	GUI:setAnchorPoint(minus_attr_btn6, 0.00, 0.00)
	GUI:setTouchEnabled(minus_attr_btn6, true)
	GUI:setTag(minus_attr_btn6, 0)

	-- Create add_attr_btn6
	local add_attr_btn6 = GUI:Button_Create(Panel_6, "add_attr_btn6", 321, 7, "res/custom/npc/13emqy/+.png")
	GUI:setContentSize(add_attr_btn6, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(add_attr_btn6, false)
	GUI:Button_setTitleText(add_attr_btn6, [[]])
	GUI:Button_setTitleColor(add_attr_btn6, "#ffffff")
	GUI:Button_setTitleFontSize(add_attr_btn6, 16)
	GUI:Button_titleDisableOutLine(add_attr_btn6)
	GUI:setAnchorPoint(add_attr_btn6, 0.00, 0.00)
	GUI:setTouchEnabled(add_attr_btn6, true)
	GUI:setTag(add_attr_btn6, 0)

	-- Create allot_attr_name6
	local allot_attr_name6 = GUI:Text_Create(Panel_6, "allot_attr_name6", 85, 7, 18, "#ffffff", [[魔防上限:]])
	GUI:Text_enableOutline(allot_attr_name6, "#000000", 1)
	GUI:setAnchorPoint(allot_attr_name6, 1.00, 0.00)
	GUI:setTouchEnabled(allot_attr_name6, false)
	GUI:setTag(allot_attr_name6, 0)

	-- Create allot_talent_value6
	local allot_talent_value6 = GUI:Text_Create(Panel_6, "allot_talent_value6", 97, 7, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(allot_talent_value6, "#000000", 1)
	GUI:setAnchorPoint(allot_talent_value6, 0.00, 0.00)
	GUI:setTouchEnabled(allot_talent_value6, false)
	GUI:setTag(allot_talent_value6, 0)

	-- Create Panel_7
	local Panel_7 = GUI:Layout_Create(ListView_3, "Panel_7", 1, 52, 356, 40, false)
	GUI:setAnchorPoint(Panel_7, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_7, false)
	GUI:setTag(Panel_7, 0)

	-- Create allot_btn7
	local allot_btn7 = GUI:Image_Create(Panel_7, "allot_btn7", 92, 2, "res/custom/npc/13emqy/att2.png")
	GUI:setAnchorPoint(allot_btn7, 0.00, 0.00)
	GUI:setTouchEnabled(allot_btn7, true)
	GUI:setTag(allot_btn7, 0)

	-- Create minus_attr_btn7
	local minus_attr_btn7 = GUI:Button_Create(Panel_7, "minus_attr_btn7", 288, 7, "res/custom/npc/13emqy/-.png")
	GUI:setContentSize(minus_attr_btn7, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(minus_attr_btn7, false)
	GUI:Button_setTitleText(minus_attr_btn7, [[]])
	GUI:Button_setTitleColor(minus_attr_btn7, "#ffffff")
	GUI:Button_setTitleFontSize(minus_attr_btn7, 16)
	GUI:Button_titleDisableOutLine(minus_attr_btn7)
	GUI:setAnchorPoint(minus_attr_btn7, 0.00, 0.00)
	GUI:setTouchEnabled(minus_attr_btn7, true)
	GUI:setTag(minus_attr_btn7, 0)

	-- Create add_attr_btn7
	local add_attr_btn7 = GUI:Button_Create(Panel_7, "add_attr_btn7", 321, 7, "res/custom/npc/13emqy/+.png")
	GUI:setContentSize(add_attr_btn7, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(add_attr_btn7, false)
	GUI:Button_setTitleText(add_attr_btn7, [[]])
	GUI:Button_setTitleColor(add_attr_btn7, "#ffffff")
	GUI:Button_setTitleFontSize(add_attr_btn7, 16)
	GUI:Button_titleDisableOutLine(add_attr_btn7)
	GUI:setAnchorPoint(add_attr_btn7, 0.00, 0.00)
	GUI:setTouchEnabled(add_attr_btn7, true)
	GUI:setTag(add_attr_btn7, 0)

	-- Create allot_attr_name7
	local allot_attr_name7 = GUI:Text_Create(Panel_7, "allot_attr_name7", 85, 7, 18, "#ffffff", [[攻击下限:]])
	GUI:Text_enableOutline(allot_attr_name7, "#000000", 1)
	GUI:setAnchorPoint(allot_attr_name7, 1.00, 0.00)
	GUI:setTouchEnabled(allot_attr_name7, false)
	GUI:setTag(allot_attr_name7, 0)

	-- Create allot_talent_value7
	local allot_talent_value7 = GUI:Text_Create(Panel_7, "allot_talent_value7", 97, 7, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(allot_talent_value7, "#000000", 1)
	GUI:setAnchorPoint(allot_talent_value7, 0.00, 0.00)
	GUI:setTouchEnabled(allot_talent_value7, false)
	GUI:setTag(allot_talent_value7, 0)

	-- Create Panel_8
	local Panel_8 = GUI:Layout_Create(ListView_3, "Panel_8", 1, 8, 356, 40, false)
	GUI:setAnchorPoint(Panel_8, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_8, false)
	GUI:setTag(Panel_8, 0)

	-- Create allot_btn8
	local allot_btn8 = GUI:Image_Create(Panel_8, "allot_btn8", 92, 2, "res/custom/npc/13emqy/att2.png")
	GUI:setAnchorPoint(allot_btn8, 0.00, 0.00)
	GUI:setTouchEnabled(allot_btn8, true)
	GUI:setTag(allot_btn8, 0)

	-- Create minus_attr_btn8
	local minus_attr_btn8 = GUI:Button_Create(Panel_8, "minus_attr_btn8", 288, 7, "res/custom/npc/13emqy/-.png")
	GUI:setContentSize(minus_attr_btn8, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(minus_attr_btn8, false)
	GUI:Button_setTitleText(minus_attr_btn8, [[]])
	GUI:Button_setTitleColor(minus_attr_btn8, "#ffffff")
	GUI:Button_setTitleFontSize(minus_attr_btn8, 16)
	GUI:Button_titleDisableOutLine(minus_attr_btn8)
	GUI:setAnchorPoint(minus_attr_btn8, 0.00, 0.00)
	GUI:setTouchEnabled(minus_attr_btn8, true)
	GUI:setTag(minus_attr_btn8, 0)

	-- Create add_attr_btn8
	local add_attr_btn8 = GUI:Button_Create(Panel_8, "add_attr_btn8", 321, 7, "res/custom/npc/13emqy/+.png")
	GUI:setContentSize(add_attr_btn8, 27, 27)
	GUI:setIgnoreContentAdaptWithSize(add_attr_btn8, false)
	GUI:Button_setTitleText(add_attr_btn8, [[]])
	GUI:Button_setTitleColor(add_attr_btn8, "#ffffff")
	GUI:Button_setTitleFontSize(add_attr_btn8, 16)
	GUI:Button_titleDisableOutLine(add_attr_btn8)
	GUI:setAnchorPoint(add_attr_btn8, 0.00, 0.00)
	GUI:setTouchEnabled(add_attr_btn8, true)
	GUI:setTag(add_attr_btn8, 0)

	-- Create allot_attr_name8
	local allot_attr_name8 = GUI:Text_Create(Panel_8, "allot_attr_name8", 85, 7, 18, "#ffffff", [[攻击上限:]])
	GUI:Text_enableOutline(allot_attr_name8, "#000000", 1)
	GUI:setAnchorPoint(allot_attr_name8, 1.00, 0.00)
	GUI:setTouchEnabled(allot_attr_name8, false)
	GUI:setTag(allot_attr_name8, 0)

	-- Create allot_talent_value8
	local allot_talent_value8 = GUI:Text_Create(Panel_8, "allot_talent_value8", 97, 7, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(allot_talent_value8, "#000000", 1)
	GUI:setAnchorPoint(allot_talent_value8, 0.00, 0.00)
	GUI:setTouchEnabled(allot_talent_value8, false)
	GUI:setTag(allot_talent_value8, 0)

	-- Create cur_talent
	local cur_talent = GUI:Text_Create(attr_node, "cur_talent", 575, 454, 18, "#ffffff", [[11]])
	GUI:Text_enableOutline(cur_talent, "#000000", 1)
	GUI:setAnchorPoint(cur_talent, 0.00, 0.00)
	GUI:setTouchEnabled(cur_talent, false)
	GUI:setTag(cur_talent, 0)

	-- Create ok_talent_btn
	local ok_talent_btn = GUI:Button_Create(attr_node, "ok_talent_btn", 567, 44, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(ok_talent_btn, "res/custom/npc/an2.png")
	GUI:setContentSize(ok_talent_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(ok_talent_btn, false)
	GUI:Button_setTitleText(ok_talent_btn, [[确定]])
	GUI:Button_setTitleColor(ok_talent_btn, "#ffffff")
	GUI:Button_setTitleFontSize(ok_talent_btn, 18)
	GUI:Button_titleEnableOutline(ok_talent_btn, "#000000", 1)
	GUI:setAnchorPoint(ok_talent_btn, 0.00, 0.00)
	GUI:setTouchEnabled(ok_talent_btn, true)
	GUI:setTag(ok_talent_btn, 0)

	-- Create talent_tip
	local talent_tip = GUI:Button_Create(attr_node, "talent_tip", 757, 48, "res/custom/npc/wenhao.png")
	GUI:setContentSize(talent_tip, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(talent_tip, false)
	GUI:Button_setTitleText(talent_tip, [[]])
	GUI:Button_setTitleColor(talent_tip, "#ffffff")
	GUI:Button_setTitleFontSize(talent_tip, 16)
	GUI:Button_titleDisableOutLine(talent_tip)
	GUI:setAnchorPoint(talent_tip, 0.00, 0.00)
	GUI:setTouchEnabled(talent_tip, true)
	GUI:setTag(talent_tip, 0)

	-- Create tip_panel
	local tip_panel = GUI:Layout_Create(FrameLayout, "tip_panel", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(tip_panel, 0.00, 0.00)
	GUI:setTouchEnabled(tip_panel, true)
	GUI:setTag(tip_panel, 0)
	GUI:setVisible(tip_panel, false)

	-- Create tip_bg
	local tip_bg = GUI:Image_Create(tip_panel, "tip_bg", 240, 123, "res/custom/npc/tips.png")
	GUI:Image_setScale9Slice(tip_bg, 69, 69, 137, 137)
	GUI:setContentSize(tip_bg, 431, 261)
	GUI:setIgnoreContentAdaptWithSize(tip_bg, false)
	GUI:setAnchorPoint(tip_bg, 0.00, 0.00)
	GUI:setTouchEnabled(tip_bg, false)
	GUI:setTag(tip_bg, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(tip_panel, "Text_1", 263, 312, 18, "#ff9b00", [[每次提交图鉴可获得对应天赋点，最高3级]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)
	GUI:setVisible(Text_1, false)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(tip_panel, "Text_3", 263, 286, 18, "#00ff00", [[每次提交图鉴可获得对应声望，不限次数]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)
	GUI:setVisible(Text_3, false)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(tip_panel, "Text_6", 263, 258, 18, "#ff00ff", [[提交所需的图鉴在对应BOSS身上爆出]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)
	GUI:setVisible(Text_6, false)

	-- Create Text_7
	local Text_7 = GUI:Text_Create(tip_panel, "Text_7", 263, 340, 18, "#ffff00", [[恶魔图鉴说明：]])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setAnchorPoint(Text_7, 0.00, 0.00)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 0)
	GUI:setVisible(Text_7, false)

	-- Create Text_8
	local Text_8 = GUI:Text_Create(tip_panel, "Text_8", 264, 230, 18, "#00ffe8", [[万能恶魔图鉴可选中任意图鉴进行激活]])
	GUI:Text_enableOutline(Text_8, "#000000", 1)
	GUI:setAnchorPoint(Text_8, 0.00, 0.00)
	GUI:setTouchEnabled(Text_8, false)
	GUI:setTag(Text_8, 0)
	GUI:setVisible(Text_8, false)

	-- Create Text_9
	local Text_9 = GUI:Text_Create(tip_panel, "Text_9", 265, 201, 18, "#009bff", [[盟重省万能恶魔图鉴消耗分别为：1/2/3/4/5张]])
	GUI:Text_enableOutline(Text_9, "#000000", 1)
	GUI:setAnchorPoint(Text_9, 0.00, 0.00)
	GUI:setTouchEnabled(Text_9, false)
	GUI:setTag(Text_9, 0)
	GUI:setVisible(Text_9, false)

	-- Create Text_10
	local Text_10 = GUI:Text_Create(tip_panel, "Text_10", 264, 172, 18, "#ff9b00", [[白日门万能恶魔图鉴消耗分别为：2/4/6/8/10张]])
	GUI:Text_enableOutline(Text_10, "#000000", 1)
	GUI:setAnchorPoint(Text_10, 0.00, 0.00)
	GUI:setTouchEnabled(Text_10, false)
	GUI:setTag(Text_10, 0)
	GUI:setVisible(Text_10, false)

	-- Create Text_11
	local Text_11 = GUI:Text_Create(tip_panel, "Text_11", 265, 142, 18, "#00ff00", [[封魔谷万能恶魔图鉴消耗分别为：3/6/9/12/15张]])
	GUI:Text_enableOutline(Text_11, "#000000", 1)
	GUI:setAnchorPoint(Text_11, 0.00, 0.00)
	GUI:setTouchEnabled(Text_11, false)
	GUI:setTag(Text_11, 0)
	GUI:setVisible(Text_11, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
