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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 89)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 140, 45, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/18hd/bg1.png")
	GUI:Image_setScale9Slice(bg_Image, 84, 84, 188, 188)
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, true)
	GUI:setMouseEnabled(bg_Image, true)
	GUI:setTag(bg_Image, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 72, 439, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[天降财宝]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 72, 394, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[激情派对]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(FrameLayout, "Button_3", 72, 349, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_3, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_3, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[武林至尊]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(FrameLayout, "Button_4", 72, 304, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_4, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_4, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[夺宝奇兵]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 18)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(FrameLayout, "Button_5", 72, 259, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_5, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_5, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[世界BOSS]])
	GUI:Button_setTitleColor(Button_5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_5, 18)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.00, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create Button_6
	local Button_6 = GUI:Button_Create(FrameLayout, "Button_6", 72, 214, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_6, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_6, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_6, false)
	GUI:Button_setTitleText(Button_6, [[行会战场]])
	GUI:Button_setTitleColor(Button_6, "#ffffff")
	GUI:Button_setTitleFontSize(Button_6, 18)
	GUI:Button_titleEnableOutline(Button_6, "#000000", 1)
	GUI:setAnchorPoint(Button_6, 0.00, 0.00)
	GUI:setTouchEnabled(Button_6, true)
	GUI:setTag(Button_6, 0)

	-- Create Button_7
	local Button_7 = GUI:Button_Create(FrameLayout, "Button_7", 72, 169, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_7, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_7, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_7, false)
	GUI:Button_setTitleText(Button_7, [[乱斗之王]])
	GUI:Button_setTitleColor(Button_7, "#ffffff")
	GUI:Button_setTitleFontSize(Button_7, 18)
	GUI:Button_titleEnableOutline(Button_7, "#000000", 1)
	GUI:setAnchorPoint(Button_7, 0.00, 0.00)
	GUI:setTouchEnabled(Button_7, true)
	GUI:setTag(Button_7, 0)

	-- Create Button_8
	local Button_8 = GUI:Button_Create(FrameLayout, "Button_8", 72, 124, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_8, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_8, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_8, false)
	GUI:Button_setTitleText(Button_8, [[狂暴霸主]])
	GUI:Button_setTitleColor(Button_8, "#ffffff")
	GUI:Button_setTitleFontSize(Button_8, 18)
	GUI:Button_titleEnableOutline(Button_8, "#000000", 1)
	GUI:setAnchorPoint(Button_8, 0.00, 0.00)
	GUI:setTouchEnabled(Button_8, true)
	GUI:setTag(Button_8, 0)

	-- Create Button_9
	local Button_9 = GUI:Button_Create(FrameLayout, "Button_9", 72, 79, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_9, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_9, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_9, false)
	GUI:Button_setTitleText(Button_9, [[跨服沙城]])
	GUI:Button_setTitleColor(Button_9, "#ffffff")
	GUI:Button_setTitleFontSize(Button_9, 18)
	GUI:Button_titleEnableOutline(Button_9, "#000000", 1)
	GUI:setAnchorPoint(Button_9, 0.00, 0.00)
	GUI:setTouchEnabled(Button_9, true)
	GUI:setTag(Button_9, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 784, 493, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/close2.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create mapImg
	local mapImg = GUI:Image_Create(FrameLayout, "mapImg", 361, 279, "scene/uiminimap/099997.png")
	GUI:setContentSize(mapImg, 331, 240)
	GUI:setIgnoreContentAdaptWithSize(mapImg, false)
	GUI:setAnchorPoint(mapImg, 0.50, 0.50)
	GUI:setTouchEnabled(mapImg, false)
	GUI:setTag(mapImg, 0)

	-- Create Node_1
	local Node_1 = GUI:Node_Create(FrameLayout, "Node_1", 0, 0)
	GUI:setTag(Node_1, 0)

	-- Create goto_btn
	local goto_btn = GUI:Button_Create(Node_1, "goto_btn", 609, 48, "res/custom/npc/18hd/an1.png")
	GUI:setContentSize(goto_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(goto_btn, false)
	GUI:Button_setTitleText(goto_btn, [[]])
	GUI:Button_setTitleColor(goto_btn, "#ffffff")
	GUI:Button_setTitleFontSize(goto_btn, 16)
	GUI:Button_titleDisableOutLine(goto_btn)
	GUI:setAnchorPoint(goto_btn, 0.00, 0.00)
	GUI:setTouchEnabled(goto_btn, true)
	GUI:setTag(goto_btn, 0)
	GUI:setVisible(goto_btn, false)

	-- Create no_open_state
	local no_open_state = GUI:Image_Create(Node_1, "no_open_state", 611, 51, "res/custom/npc/18hd/an0.png")
	GUI:setAnchorPoint(no_open_state, 0.00, 0.00)
	GUI:setTouchEnabled(no_open_state, false)
	GUI:setTag(no_open_state, 0)

	-- Create new_open_desc_text
	local new_open_desc_text = GUI:Text_Create(Node_1, "new_open_desc_text", 273, 94, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(new_open_desc_text, "#000000", 1)
	GUI:setAnchorPoint(new_open_desc_text, 0.00, 0.00)
	GUI:setTouchEnabled(new_open_desc_text, false)
	GUI:setTag(new_open_desc_text, 0)

	-- Create old_open_desc_text
	local old_open_desc_text = GUI:Text_Create(Node_1, "old_open_desc_text", 273, 63, 18, "#00ff00", [[]])
	GUI:Text_enableOutline(old_open_desc_text, "#000000", 1)
	GUI:setAnchorPoint(old_open_desc_text, 0.00, 0.00)
	GUI:setTouchEnabled(old_open_desc_text, false)
	GUI:setTag(old_open_desc_text, 0)

	-- Create kf_tip
	local kf_tip = GUI:Text_Create(Node_1, "kf_tip", 215, 37, 18, "#ff0000", [[此活动合区后属于跨服活动]])
	GUI:Text_enableOutline(kf_tip, "#000000", 1)
	GUI:setAnchorPoint(kf_tip, 0.00, 0.00)
	GUI:setTouchEnabled(kf_tip, false)
	GUI:setTag(kf_tip, 0)
	GUI:setVisible(kf_tip, false)

	-- Create Node_2
	local Node_2 = GUI:Node_Create(FrameLayout, "Node_2", 0, 0)
	GUI:setTag(Node_2, 0)
	GUI:setVisible(Node_2, false)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Node_2, "Image_1", 197, 399, "res/custom/npc/18hd/hdban9.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create RichText_11
	local RichText_11 = GUI:RichText_Create(Node_2, "RichText_11", 213, 77, [[<font color='#ffffff' size='16' >跨服攻沙：</font><font color='#00ffe8' size='16' >周三、周六</font><font color='#00ff00' size='16' >(20:00→21:00)</font><br><font color='#ff0000' size='16' >攻沙当天若合过区，则优先进行本服攻沙</font>]], 300, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_11, 0.00, 0.00)
	GUI:setTag(RichText_11, 0)

	-- Create pointbtn1
	local pointbtn1 = GUI:Button_Create(Node_2, "pointbtn1", 207, 40, "res/public/1900000652_1.png")
	GUI:Button_setScale9Slice(pointbtn1, 8, 8, 9, 9)
	GUI:setContentSize(pointbtn1, 70, 29)
	GUI:setIgnoreContentAdaptWithSize(pointbtn1, false)
	GUI:Button_setTitleText(pointbtn1, [[复活点]])
	GUI:Button_setTitleColor(pointbtn1, "#ffff00")
	GUI:Button_setTitleFontSize(pointbtn1, 16)
	GUI:Button_titleEnableOutline(pointbtn1, "#000000", 1)
	GUI:setAnchorPoint(pointbtn1, 0.00, 0.00)
	GUI:setTouchEnabled(pointbtn1, true)
	GUI:setTag(pointbtn1, 0)

	-- Create pointbtn2
	local pointbtn2 = GUI:Button_Create(Node_2, "pointbtn2", 289, 40, "res/public/1900000652_1.png")
	GUI:Button_setScale9Slice(pointbtn2, 8, 8, 9, 9)
	GUI:setContentSize(pointbtn2, 70, 29)
	GUI:setIgnoreContentAdaptWithSize(pointbtn2, false)
	GUI:Button_setTitleText(pointbtn2, [[沙大门]])
	GUI:Button_setTitleColor(pointbtn2, "#ffff00")
	GUI:Button_setTitleFontSize(pointbtn2, 16)
	GUI:Button_titleEnableOutline(pointbtn2, "#000000", 1)
	GUI:setAnchorPoint(pointbtn2, 0.00, 0.00)
	GUI:setTouchEnabled(pointbtn2, true)
	GUI:setTag(pointbtn2, 0)

	-- Create pointbtn3
	local pointbtn3 = GUI:Button_Create(Node_2, "pointbtn3", 369, 40, "res/public/1900000652_1.png")
	GUI:Button_setScale9Slice(pointbtn3, 8, 8, 9, 9)
	GUI:setContentSize(pointbtn3, 70, 29)
	GUI:setIgnoreContentAdaptWithSize(pointbtn3, false)
	GUI:Button_setTitleText(pointbtn3, [[武器店]])
	GUI:Button_setTitleColor(pointbtn3, "#ffff00")
	GUI:Button_setTitleFontSize(pointbtn3, 16)
	GUI:Button_titleEnableOutline(pointbtn3, "#000000", 1)
	GUI:setAnchorPoint(pointbtn3, 0.00, 0.00)
	GUI:setTouchEnabled(pointbtn3, true)
	GUI:setTag(pointbtn3, 0)

	-- Create pointbtn4
	local pointbtn4 = GUI:Button_Create(Node_2, "pointbtn4", 449, 40, "res/public/1900000652_1.png")
	GUI:Button_setScale9Slice(pointbtn4, 8, 8, 9, 9)
	GUI:setContentSize(pointbtn4, 70, 29)
	GUI:setIgnoreContentAdaptWithSize(pointbtn4, false)
	GUI:Button_setTitleText(pointbtn4, [[衣服店]])
	GUI:Button_setTitleColor(pointbtn4, "#ffff00")
	GUI:Button_setTitleFontSize(pointbtn4, 16)
	GUI:Button_titleEnableOutline(pointbtn4, "#000000", 1)
	GUI:setAnchorPoint(pointbtn4, 0.00, 0.00)
	GUI:setTouchEnabled(pointbtn4, true)
	GUI:setTag(pointbtn4, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Node_2, "Image_2", 196, 159, "res/custom/npc/18hd/cs0.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create map_point_btn1
	local map_point_btn1 = GUI:Button_Create(Node_2, "map_point_btn1", 276, 307, "res/custom/npc/18hd/cs1.png")
	GUI:setContentSize(map_point_btn1, 56, 42)
	GUI:setIgnoreContentAdaptWithSize(map_point_btn1, false)
	GUI:Button_setTitleText(map_point_btn1, [[]])
	GUI:Button_setTitleColor(map_point_btn1, "#ffff00")
	GUI:Button_setTitleFontSize(map_point_btn1, 16)
	GUI:Button_titleEnableOutline(map_point_btn1, "#000000", 1)
	GUI:setAnchorPoint(map_point_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(map_point_btn1, true)
	GUI:setTag(map_point_btn1, 0)

	-- Create map_point_btn4
	local map_point_btn4 = GUI:Button_Create(Node_2, "map_point_btn4", 400, 312, "res/custom/npc/18hd/cs4.png")
	GUI:setContentSize(map_point_btn4, 56, 42)
	GUI:setIgnoreContentAdaptWithSize(map_point_btn4, false)
	GUI:Button_setTitleText(map_point_btn4, [[]])
	GUI:Button_setTitleColor(map_point_btn4, "#ffff00")
	GUI:Button_setTitleFontSize(map_point_btn4, 16)
	GUI:Button_titleEnableOutline(map_point_btn4, "#000000", 1)
	GUI:setAnchorPoint(map_point_btn4, 0.00, 0.00)
	GUI:setTouchEnabled(map_point_btn4, true)
	GUI:setTag(map_point_btn4, 0)

	-- Create map_point_btn2
	local map_point_btn2 = GUI:Button_Create(Node_2, "map_point_btn2", 397, 219, "res/custom/npc/18hd/cs2.png")
	GUI:setContentSize(map_point_btn2, 56, 42)
	GUI:setIgnoreContentAdaptWithSize(map_point_btn2, false)
	GUI:Button_setTitleText(map_point_btn2, [[]])
	GUI:Button_setTitleColor(map_point_btn2, "#ffff00")
	GUI:Button_setTitleFontSize(map_point_btn2, 16)
	GUI:Button_titleEnableOutline(map_point_btn2, "#000000", 1)
	GUI:setAnchorPoint(map_point_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(map_point_btn2, true)
	GUI:setTag(map_point_btn2, 0)

	-- Create map_point_btn3
	local map_point_btn3 = GUI:Button_Create(Node_2, "map_point_btn3", 267, 214, "res/custom/npc/18hd/cs3.png")
	GUI:setContentSize(map_point_btn3, 56, 42)
	GUI:setIgnoreContentAdaptWithSize(map_point_btn3, false)
	GUI:Button_setTitleText(map_point_btn3, [[]])
	GUI:Button_setTitleColor(map_point_btn3, "#ffff00")
	GUI:Button_setTitleFontSize(map_point_btn3, 16)
	GUI:Button_titleEnableOutline(map_point_btn3, "#000000", 1)
	GUI:setAnchorPoint(map_point_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(map_point_btn3, true)
	GUI:setTag(map_point_btn3, 0)

	-- Create shop_btn
	local shop_btn = GUI:Button_Create(Node_2, "shop_btn", 465, 162, "res/custom/npc/18hd/rybtn2.png")
	GUI:Button_loadTexturePressed(shop_btn, "res/custom/npc/18hd/rybtn1.png")
	GUI:setContentSize(shop_btn, 60, 58)
	GUI:setIgnoreContentAdaptWithSize(shop_btn, false)
	GUI:Button_setTitleText(shop_btn, [[]])
	GUI:Button_setTitleColor(shop_btn, "#ffffff")
	GUI:Button_setTitleFontSize(shop_btn, 16)
	GUI:Button_titleDisableOutLine(shop_btn)
	GUI:setAnchorPoint(shop_btn, 0.00, 0.00)
	GUI:setTouchEnabled(shop_btn, true)
	GUI:setTag(shop_btn, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Node_2, "Text_1", 670, 66, 16, "#ff00ff", [[发放奖励时任务必须在跨服沙城
不在跨服沙城，奖励将无法到账]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create activity_state_img
	local activity_state_img = GUI:Image_Create(FrameLayout, "activity_state_img", 462, 336, "res/custom/npc/18hd/hd0.png")
	GUI:setAnchorPoint(activity_state_img, 0.00, 0.00)
	GUI:setTouchEnabled(activity_state_img, false)
	GUI:setTag(activity_state_img, 0)

	-- Create award_box
	local award_box = GUI:Layout_Create(FrameLayout, "award_box", 536, 97, 255, 60, false)
	GUI:setAnchorPoint(award_box, 0.00, 0.00)
	GUI:setTouchEnabled(award_box, false)
	GUI:setTag(award_box, 0)

	-- Create award_4
	local award_4 = GUI:ItemShow_Create(award_box, "award_4", 123, 29, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(award_4, 0.50, 0.50)
	GUI:setTag(award_4, 0)

	-- Create award_3
	local award_3 = GUI:ItemShow_Create(award_box, "award_3", 123, 29, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(award_3, 0.50, 0.50)
	GUI:setTag(award_3, 0)

	-- Create award_2
	local award_2 = GUI:ItemShow_Create(award_box, "award_2", 123, 29, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(award_2, 0.50, 0.50)
	GUI:setTag(award_2, 0)

	-- Create award_1
	local award_1 = GUI:ItemShow_Create(award_box, "award_1", 123, 29, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(award_1, 0.50, 0.50)
	GUI:setTag(award_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
