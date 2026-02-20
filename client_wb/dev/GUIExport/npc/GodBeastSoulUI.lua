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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 1, -3, "res/custom/npc/44sszl/bg.png")
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

	-- Create up_level_btn
	local up_level_btn = GUI:Button_Create(FrameLayout, "up_level_btn", 588, 52, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(up_level_btn, "res/custom/npc/anb2.png")
	GUI:Button_setTitleText(up_level_btn, [[开始升级]])
	GUI:Button_setTitleColor(up_level_btn, "#efd6ad")
	GUI:Button_setTitleFontSize(up_level_btn, 20)
	GUI:Button_titleEnableOutline(up_level_btn, "#000000", 1)
	GUI:setAnchorPoint(up_level_btn, 0.00, 0.00)
	GUI:setTouchEnabled(up_level_btn, true)
	GUI:setTag(up_level_btn, 0)

	-- Create Frames_1
	local Frames_1 = GUI:Frames_Create(FrameLayout, "Frames_1", 279, 307, "res/custom/npc/44sszl/tx", ".png", 1, 8, {count=8, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(Frames_1, 0.50, 0.50)
	GUI:setTouchEnabled(Frames_1, false)
	GUI:setTag(Frames_1, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 136, 211, 0, 14870, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create Effect_2
	local Effect_2 = GUI:Effect_Create(FrameLayout, "Effect_2", 177, 276, 0, 14870, 0, 0, 0, 1)
	GUI:setTag(Effect_2, 0)

	-- Create Effect_3
	local Effect_3 = GUI:Effect_Create(FrameLayout, "Effect_3", 230, 347, 0, 14870, 0, 0, 0, 1)
	GUI:setTag(Effect_3, 0)

	-- Create Effect_4
	local Effect_4 = GUI:Effect_Create(FrameLayout, "Effect_4", 299, 377, 0, 14870, 0, 0, 0, 1)
	GUI:setTag(Effect_4, 0)

	-- Create Effect_5
	local Effect_5 = GUI:Effect_Create(FrameLayout, "Effect_5", 368, 409, 0, 14870, 0, 0, 0, 1)
	GUI:setTag(Effect_5, 0)

	-- Create Effect_6
	local Effect_6 = GUI:Effect_Create(FrameLayout, "Effect_6", 369, 328, 0, 14870, 0, 0, 0, 1)
	GUI:setTag(Effect_6, 0)

	-- Create Effect_7
	local Effect_7 = GUI:Effect_Create(FrameLayout, "Effect_7", 306, 299, 0, 14870, 0, 0, 0, 1)
	GUI:setTag(Effect_7, 0)

	-- Create Effect_8
	local Effect_8 = GUI:Effect_Create(FrameLayout, "Effect_8", 268, 248, 0, 14870, 0, 0, 0, 1)
	GUI:setTag(Effect_8, 0)

	-- Create Effect_9
	local Effect_9 = GUI:Effect_Create(FrameLayout, "Effect_9", 331, 207, 0, 14870, 0, 0, 0, 1)
	GUI:setTag(Effect_9, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 141, 129, "res/custom/npc/26tumo/tip.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create need_money_text
	local need_money_text = GUI:Text_Create(FrameLayout, "need_money_text", 673, 117, 18, "#ff0000", [[0]])
	GUI:Text_enableOutline(need_money_text, "#000000", 1)
	GUI:setAnchorPoint(need_money_text, 0.50, 0.50)
	GUI:setTouchEnabled(need_money_text, false)
	GUI:setTag(need_money_text, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(need_money_text, "Text_2", -51, 1, 18, "#c6c6ce", [[消耗：]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 84, 48, [[<font color='#ff9b00' size='16' >升级说明：</font><br><font color='#ffffff' size='16' >1、需要满级 </font><font color='#00ff00' size='16' >神兽之力 </font><font color='#ffffff' size='16' >才能进化 </font><font color='#ffff00' size='16' >神兽之灵</font><br><font color='#ffffff' size='16' >2、升级神兽之灵可大幅提升</font><font color='#00ff00' size='16' >人物属性</font><font color='#ffffff' size='16' >，变得更强！</font>]], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create max_tip_text
	local max_tip_text = GUI:Text_Create(FrameLayout, "max_tip_text", 224, 133, 18, "#c6c6ce", [==========[进度[	 ]]==========])
	GUI:Text_enableOutline(max_tip_text, "#000000", 1)
	GUI:setAnchorPoint(max_tip_text, 0.00, 0.00)
	GUI:setTouchEnabled(max_tip_text, false)
	GUI:setTag(max_tip_text, 0)

	-- Create level_text
	local level_text = GUI:Text_Create(max_tip_text, "level_text", 59, 11, 18, "#ff00ff", [[2/9]])
	GUI:Text_enableOutline(level_text, "#000000", 1)
	GUI:setAnchorPoint(level_text, 0.50, 0.50)
	GUI:setTouchEnabled(level_text, false)
	GUI:setTag(level_text, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 81, 317, "res/custom/npc/44sszl/icon.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create TextAtlas
	local TextAtlas = GUI:TextAtlas_Create(Image_2, "TextAtlas", 22, 44, "123456789", "res/public/word_tywz_01.png", 18, 28, "0")
	GUI:setAnchorPoint(TextAtlas, 0.50, 0.50)
	GUI:setTouchEnabled(TextAtlas, false)
	GUI:setTag(TextAtlas, 0)

	-- Create item_box
	local item_box = GUI:Layout_Create(FrameLayout, "item_box", 489, 132, 313, 80, false)
	GUI:setAnchorPoint(item_box, 0.00, 0.00)
	GUI:setTouchEnabled(item_box, false)
	GUI:setTag(item_box, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(item_box, "ItemShow_1", 45, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(item_box, "ItemShow_2", 120, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(item_box, "ItemShow_3", 195, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(item_box, "ItemShow_4", 270, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(FrameLayout, "Panel_1", 495, 255, 301, 184, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Panel_1, "Text_1", 8, 153, 18, "#00ff00", [[防御魔防：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create cur_attr1
	local cur_attr1 = GUI:Text_Create(Text_1, "cur_attr1", 133, 13, 18, "#00ffe8", [[50-1080]])
	GUI:Text_enableOutline(cur_attr1, "#000000", 1)
	GUI:setAnchorPoint(cur_attr1, 0.50, 0.50)
	GUI:setTouchEnabled(cur_attr1, false)
	GUI:setTag(cur_attr1, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(Text_1, "Image_3", 177, 6, "res/custom/npc/26tumo/ar.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create next_attr1
	local next_attr1 = GUI:Text_Create(Text_1, "next_attr1", 247, 13, 18, "#00ff00", [[50-1080]])
	GUI:Text_enableOutline(next_attr1, "#000000", 1)
	GUI:setAnchorPoint(next_attr1, 0.50, 0.50)
	GUI:setTouchEnabled(next_attr1, false)
	GUI:setTag(next_attr1, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(Panel_1, "Text_3", 8, 123, 18, "#00ff00", [[体力增加：]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create cur_attr2
	local cur_attr2 = GUI:Text_Create(Text_3, "cur_attr2", 133, 13, 18, "#00ffe8", [[590%]])
	GUI:Text_enableOutline(cur_attr2, "#000000", 1)
	GUI:setAnchorPoint(cur_attr2, 0.50, 0.50)
	GUI:setTouchEnabled(cur_attr2, false)
	GUI:setTag(cur_attr2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(Text_3, "Image_3", 177, 6, "res/custom/npc/26tumo/ar.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create next_attr2
	local next_attr2 = GUI:Text_Create(Text_3, "next_attr2", 247, 13, 18, "#00ff00", [[600%]])
	GUI:Text_enableOutline(next_attr2, "#000000", 1)
	GUI:setAnchorPoint(next_attr2, 0.50, 0.50)
	GUI:setTouchEnabled(next_attr2, false)
	GUI:setTag(next_attr2, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(Panel_1, "Text_4", 8, 93, 18, "#e317b3", [[受战减伤：]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create cur_attr3
	local cur_attr3 = GUI:Text_Create(Text_4, "cur_attr3", 133, 13, 18, "#ffff00", [[18]])
	GUI:Text_enableOutline(cur_attr3, "#000000", 1)
	GUI:setAnchorPoint(cur_attr3, 0.50, 0.50)
	GUI:setTouchEnabled(cur_attr3, false)
	GUI:setTag(cur_attr3, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(Text_4, "Image_3", 177, 6, "res/custom/npc/26tumo/ar.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create next_attr3
	local next_attr3 = GUI:Text_Create(Text_4, "next_attr3", 247, 13, 18, "#e317b3", [[20%]])
	GUI:Text_enableOutline(next_attr3, "#000000", 1)
	GUI:setAnchorPoint(next_attr3, 0.50, 0.50)
	GUI:setTouchEnabled(next_attr3, false)
	GUI:setTag(next_attr3, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(Panel_1, "Text_5", 8, 63, 18, "#e317b3", [[受法减伤：]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create cur_attr4
	local cur_attr4 = GUI:Text_Create(Text_5, "cur_attr4", 133, 13, 18, "#ffff00", [[590%]])
	GUI:Text_enableOutline(cur_attr4, "#000000", 1)
	GUI:setAnchorPoint(cur_attr4, 0.50, 0.50)
	GUI:setTouchEnabled(cur_attr4, false)
	GUI:setTag(cur_attr4, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(Text_5, "Image_3", 177, 6, "res/custom/npc/26tumo/ar.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create next_attr4
	local next_attr4 = GUI:Text_Create(Text_5, "next_attr4", 247, 13, 18, "#e317b3", [[20%]])
	GUI:Text_enableOutline(next_attr4, "#000000", 1)
	GUI:setAnchorPoint(next_attr4, 0.50, 0.50)
	GUI:setTouchEnabled(next_attr4, false)
	GUI:setTag(next_attr4, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(Panel_1, "Text_6", 8, 33, 18, "#e317b3", [[受道减伤：]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	-- Create cur_attr5
	local cur_attr5 = GUI:Text_Create(Text_6, "cur_attr5", 133, 13, 18, "#ffff00", [[590%]])
	GUI:Text_enableOutline(cur_attr5, "#000000", 1)
	GUI:setAnchorPoint(cur_attr5, 0.50, 0.50)
	GUI:setTouchEnabled(cur_attr5, false)
	GUI:setTag(cur_attr5, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(Text_6, "Image_3", 177, 6, "res/custom/npc/26tumo/ar.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create next_attr5
	local next_attr5 = GUI:Text_Create(Text_6, "next_attr5", 247, 13, 18, "#e317b3", [[20%]])
	GUI:Text_enableOutline(next_attr5, "#000000", 1)
	GUI:setAnchorPoint(next_attr5, 0.50, 0.50)
	GUI:setTouchEnabled(next_attr5, false)
	GUI:setTag(next_attr5, 0)

	-- Create Text_7
	local Text_7 = GUI:Text_Create(Panel_1, "Text_7", 8, 3, 18, "#e317b3", [[增加攻伤：]])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setAnchorPoint(Text_7, 0.00, 0.00)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 0)

	-- Create cur_attr6
	local cur_attr6 = GUI:Text_Create(Text_7, "cur_attr6", 133, 13, 18, "#ffff00", [[590%]])
	GUI:Text_enableOutline(cur_attr6, "#000000", 1)
	GUI:setAnchorPoint(cur_attr6, 0.50, 0.50)
	GUI:setTouchEnabled(cur_attr6, false)
	GUI:setTag(cur_attr6, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(Text_7, "Image_3", 177, 6, "res/custom/npc/26tumo/ar.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create next_attr6
	local next_attr6 = GUI:Text_Create(Text_7, "next_attr6", 247, 13, 18, "#e317b3", [[20%]])
	GUI:Text_enableOutline(next_attr6, "#000000", 1)
	GUI:setAnchorPoint(next_attr6, 0.50, 0.50)
	GUI:setTouchEnabled(next_attr6, false)
	GUI:setTag(next_attr6, 0)

	-- Create max_img
	local max_img = GUI:Image_Create(FrameLayout, "max_img", 590, 77, "res/custom/npc/44sszl/ymj.png")
	GUI:setAnchorPoint(max_img, 0.00, 0.00)
	GUI:setTouchEnabled(max_img, false)
	GUI:setTag(max_img, 0)
	GUI:setVisible(max_img, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
