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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/34ss/bg.png")
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

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 307, 424, "res/custom/npc/34ss/t2.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 66, 400, "res/custom/npc/34ss/icon1.png")
	GUI:setContentSize(Button_1, 176, 68)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleDisableOutLine(Button_1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 66, 310, "res/custom/npc/34ss/icon2.png")
	GUI:setContentSize(Button_2, 176, 68)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleDisableOutLine(Button_2)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(FrameLayout, "Button_3", 66, 220, "res/custom/npc/34ss/icon3.png")
	GUI:setContentSize(Button_3, 176, 68)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleDisableOutLine(Button_3)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(FrameLayout, "Button_4", 66, 130, "res/custom/npc/34ss/icon4.png")
	GUI:setContentSize(Button_4, 176, 68)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 16)
	GUI:Button_titleDisableOutLine(Button_4)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create tip_btn
	local tip_btn = GUI:Button_Create(FrameLayout, "tip_btn", 495, 430, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tip_btn, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tip_btn, false)
	GUI:Button_setTitleText(tip_btn, [[]])
	GUI:Button_setTitleColor(tip_btn, "#ffffff")
	GUI:Button_setTitleFontSize(tip_btn, 16)
	GUI:Button_titleDisableOutLine(tip_btn)
	GUI:setAnchorPoint(tip_btn, 0.00, 0.00)
	GUI:setTouchEnabled(tip_btn, true)
	GUI:setTag(tip_btn, 0)

	-- Create name_text
	local name_text = GUI:Text_Create(FrameLayout, "name_text", 389, 444, 18, "#ff0000", [[青龙之力Lv2]])
	GUI:Text_enableOutline(name_text, "#000000", 1)
	GUI:setAnchorPoint(name_text, 0.50, 0.50)
	GUI:setTouchEnabled(name_text, false)
	GUI:setTag(name_text, 0)

	-- Create need_item1
	local need_item1 = GUI:ItemShow_Create(FrameLayout, "need_item1", 637, 144, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(need_item1, 0.50, 0.50)
	GUI:setTag(need_item1, 0)

	-- Create need_item2
	local need_item2 = GUI:ItemShow_Create(FrameLayout, "need_item2", 710, 144, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(need_item2, 0.50, 0.50)
	GUI:setTag(need_item2, 0)

	-- Create up_level_btn
	local up_level_btn = GUI:Button_Create(FrameLayout, "up_level_btn", 623, 53, "res/custom/npc/34ss/an.png")
	GUI:Button_setTitleText(up_level_btn, [[]])
	GUI:Button_setTitleColor(up_level_btn, "#ffffff")
	GUI:Button_setTitleFontSize(up_level_btn, 16)
	GUI:Button_titleDisableOutLine(up_level_btn)
	GUI:setAnchorPoint(up_level_btn, 0.00, 0.00)
	GUI:setTouchEnabled(up_level_btn, true)
	GUI:setTag(up_level_btn, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 699, 398, "res/custom/npc/34ss/t1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(FrameLayout, "Image_3", 699, 362, "res/custom/npc/34ss/t1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(FrameLayout, "Image_4", 699, 324, "res/custom/npc/34ss/t1.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create cur_attr_1
	local cur_attr_1 = GUI:Text_Create(FrameLayout, "cur_attr_1", 670, 405, 18, "#00ff00", [[5]])
	GUI:Text_enableOutline(cur_attr_1, "#000000", 1)
	GUI:setAnchorPoint(cur_attr_1, 1.00, 0.50)
	GUI:setTouchEnabled(cur_attr_1, false)
	GUI:setTag(cur_attr_1, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(cur_attr_1, "Text_3", -70, 1, 18, "#ffffff", [[攻魔道：]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create next_attr_1
	local next_attr_1 = GUI:Text_Create(FrameLayout, "next_attr_1", 741, 393, 18, "#00ff00", [[2]])
	GUI:Text_enableOutline(next_attr_1, "#000000", 1)
	GUI:setAnchorPoint(next_attr_1, 0.00, 0.00)
	GUI:setTouchEnabled(next_attr_1, false)
	GUI:setTag(next_attr_1, 0)

	-- Create cur_attr_2
	local cur_attr_2 = GUI:Text_Create(FrameLayout, "cur_attr_2", 670, 369, 18, "#00ff00", [[5]])
	GUI:Text_enableOutline(cur_attr_2, "#000000", 1)
	GUI:setAnchorPoint(cur_attr_2, 1.00, 0.50)
	GUI:setTouchEnabled(cur_attr_2, false)
	GUI:setTag(cur_attr_2, 0)

	-- Create Text_3
	Text_3 = GUI:Text_Create(cur_attr_2, "Text_3", -70, 1, 18, "#ffffff", [[防魔御：]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create next_attr_2
	local next_attr_2 = GUI:Text_Create(FrameLayout, "next_attr_2", 741, 357, 18, "#00ff00", [[2]])
	GUI:Text_enableOutline(next_attr_2, "#000000", 1)
	GUI:setAnchorPoint(next_attr_2, 0.00, 0.00)
	GUI:setTouchEnabled(next_attr_2, false)
	GUI:setTag(next_attr_2, 0)

	-- Create cur_attr_3
	local cur_attr_3 = GUI:Text_Create(FrameLayout, "cur_attr_3", 688, 332, 18, "#00ff00", [[0%]])
	GUI:Text_enableOutline(cur_attr_3, "#000000", 1)
	GUI:setAnchorPoint(cur_attr_3, 1.00, 0.50)
	GUI:setTouchEnabled(cur_attr_3, false)
	GUI:setTag(cur_attr_3, 0)

	-- Create special_attr_name
	local special_attr_name = GUI:Text_Create(cur_attr_3, "special_attr_name", 1, 13, 18, "#ffffff", [[攻魔道伤：]])
	GUI:Text_setTextHorizontalAlignment(special_attr_name, 2)
	GUI:Text_enableOutline(special_attr_name, "#000000", 1)
	GUI:setAnchorPoint(special_attr_name, 1.00, 0.50)
	GUI:setTouchEnabled(special_attr_name, false)
	GUI:setTag(special_attr_name, 0)

	-- Create next_attr_3
	local next_attr_3 = GUI:Text_Create(FrameLayout, "next_attr_3", 742, 320, 18, "#00ff00", [[2]])
	GUI:Text_enableOutline(next_attr_3, "#000000", 1)
	GUI:setAnchorPoint(next_attr_3, 0.00, 0.00)
	GUI:setTouchEnabled(next_attr_3, false)
	GUI:setTag(next_attr_3, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 231, 51, [[<font color='#ff0000' size='16' >兽魂晋升说明</font><font color='#ffffff' size='16' >：</font><br><font color='#ff9b00' size='16' >收集所需的物品，即可提升当前</font><font color='#00ff00' size='16' >神兽之力</font><br><font color='#ff9b00' size='16' >兽魂总等级达到时，可激活</font><font color='#00ff00' size='16' >【融合BUFF】</font>]], 310, 16, "#ffffff", 5)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
