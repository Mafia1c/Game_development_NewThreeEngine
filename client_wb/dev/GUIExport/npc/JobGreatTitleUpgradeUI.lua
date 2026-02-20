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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/29juewei/bg.png")
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

	-- Create juewei_img
	local juewei_img = GUI:Image_Create(FrameLayout, "juewei_img", 73, 437, "res/custom/npc/ta1.png")
	GUI:setAnchorPoint(juewei_img, 0.00, 0.00)
	GUI:setTouchEnabled(juewei_img, false)
	GUI:setTag(juewei_img, 0)

	-- Create Text_7
	local Text_7 = GUI:Text_Create(juewei_img, "Text_7", 41, 9, 18, "#ffffff", [[大帝]])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setAnchorPoint(Text_7, 0.00, 0.00)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 0)

	-- Create upgrade_btn
	local upgrade_btn = GUI:Button_Create(FrameLayout, "upgrade_btn", 628, 39, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(upgrade_btn, "res/custom/npc/an2.png")
	GUI:setContentSize(upgrade_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(upgrade_btn, false)
	GUI:Button_setTitleText(upgrade_btn, [[晋升]])
	GUI:Button_setTitleColor(upgrade_btn, "#ffffff")
	GUI:Button_setTitleFontSize(upgrade_btn, 18)
	GUI:Button_titleEnableOutline(upgrade_btn, "#000000", 2)
	GUI:setAnchorPoint(upgrade_btn, 0.00, 0.00)
	GUI:setTouchEnabled(upgrade_btn, true)
	GUI:setTag(upgrade_btn, 0)

	-- Create need_item1
	local need_item1 = GUI:ItemShow_Create(FrameLayout, "need_item1", 644, 117, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(need_item1, 0.50, 0.50)
	GUI:setTag(need_item1, 0)

	-- Create need_item2
	local need_item2 = GUI:ItemShow_Create(FrameLayout, "need_item2", 716, 117, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(need_item2, 0.50, 0.50)
	GUI:setTag(need_item2, 0)

	-- Create max_img
	local max_img = GUI:Image_Create(FrameLayout, "max_img", 628, 56, "res/custom/npc/29juewei/ymj.png")
	GUI:setAnchorPoint(max_img, 0.00, 0.00)
	GUI:setTouchEnabled(max_img, false)
	GUI:setTag(max_img, 0)
	GUI:setVisible(max_img, false)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 634, 414, 18, "#ffffff", [[生命值：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create cur_attr1
	local cur_attr1 = GUI:Text_Create(Text_1, "cur_attr1", 72, 0, 18, "#00ff00", [[0]])
	GUI:Text_enableOutline(cur_attr1, "#000000", 1)
	GUI:setAnchorPoint(cur_attr1, 0.00, 0.00)
	GUI:setTouchEnabled(cur_attr1, false)
	GUI:setTag(cur_attr1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 634, 382, 18, "#ffffff", [[魔法值：]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create cur_attr2
	local cur_attr2 = GUI:Text_Create(Text_2, "cur_attr2", 72, 0, 18, "#00ff00", [[0]])
	GUI:Text_enableOutline(cur_attr2, "#000000", 1)
	GUI:setAnchorPoint(cur_attr2, 0.00, 0.00)
	GUI:setTouchEnabled(cur_attr2, false)
	GUI:setTag(cur_attr2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 634, 348, 18, "#ffffff", [[防魔御：]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create cur_attr3
	local cur_attr3 = GUI:Text_Create(Text_3, "cur_attr3", 72, 0, 18, "#00ff00", [[0]])
	GUI:Text_enableOutline(cur_attr3, "#000000", 1)
	GUI:setAnchorPoint(cur_attr3, 0.00, 0.00)
	GUI:setTouchEnabled(cur_attr3, false)
	GUI:setTag(cur_attr3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(FrameLayout, "Text_4", 634, 259, 18, "#ffffff", [[生命值：]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create next_attr1
	local next_attr1 = GUI:Text_Create(Text_4, "next_attr1", 71, 0, 18, "#00ff00", [[0]])
	GUI:Text_enableOutline(next_attr1, "#000000", 1)
	GUI:setAnchorPoint(next_attr1, 0.00, 0.00)
	GUI:setTouchEnabled(next_attr1, false)
	GUI:setTag(next_attr1, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(FrameLayout, "Text_5", 634, 227, 18, "#ffffff", [[魔法值：]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create next_attr2
	local next_attr2 = GUI:Text_Create(Text_5, "next_attr2", 72, 0, 18, "#00ff00", [[0]])
	GUI:Text_enableOutline(next_attr2, "#000000", 1)
	GUI:setAnchorPoint(next_attr2, 0.00, 0.00)
	GUI:setTouchEnabled(next_attr2, false)
	GUI:setTag(next_attr2, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(FrameLayout, "Text_6", 634, 193, 18, "#ffffff", [[防魔御：]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	-- Create next_attr3
	local next_attr3 = GUI:Text_Create(Text_6, "next_attr3", 72, 0, 18, "#00ff00", [[0]])
	GUI:Text_enableOutline(next_attr3, "#000000", 1)
	GUI:setAnchorPoint(next_attr3, 0.00, 0.00)
	GUI:setTouchEnabled(next_attr3, false)
	GUI:setTag(next_attr3, 0)

	-- Create model_box
	local model_box = GUI:Layout_Create(FrameLayout, "model_box", 196, 131, 366, 349, false)
	GUI:setAnchorPoint(model_box, 0.00, 0.00)
	GUI:setTouchEnabled(model_box, false)
	GUI:setTag(model_box, 0)

	-- Create jinduimg_1
	local jinduimg_1 = GUI:Image_Create(FrameLayout, "jinduimg_1", 197, 129, "res/custom/npc/29juewei/sbg.png")
	GUI:setContentSize(jinduimg_1, 364, 32)
	GUI:setIgnoreContentAdaptWithSize(jinduimg_1, false)
	GUI:setAnchorPoint(jinduimg_1, 0.00, 0.00)
	GUI:setTouchEnabled(jinduimg_1, false)
	GUI:setTag(jinduimg_1, 0)

	-- Create jindu_img
	local jindu_img = GUI:Image_Create(FrameLayout, "jindu_img", 236, 134, "res/custom/npc/29juewei/s0.png")
	GUI:setAnchorPoint(jindu_img, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_img, false)
	GUI:setTag(jindu_img, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 265, 73, [==========[<font color='#ffffff' size='16' >晋升[</font><font color='#ffff00' size='16' >大帝</font><font color='#ffffff' size='16' >]奖励→</font>]==========], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 436, 83, {index = 50691, count = 1, look = true, bgVisible = true, color = 255, noLockTips = true})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
