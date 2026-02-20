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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/35xm/2/bg1.png")
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 802, 511, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/close2.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 82, 101, 16, "#00ff00", [[血脉觉醒说明：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 82, 78, 16, "#00ff00", [[提升境界修为即可解锁更多血脉觉醒位置]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 82, 57, [[<font color='#ff9b00' size='16' >使用boss掉落的</font><font color='#00ff00' size='16' >【血脉石】</font><font color='#ff9b00' size='16' >可进行血脉觉醒</font>]], 400, 16, "#ff9b00", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(FrameLayout, "RichText_2", 82, 36, [[<font color='#ff9b00' size='16' >点击</font><font color='#00ff00' size='16' >右侧【保存激活】</font><font color='#ff9b00' size='16' >才可生效血脉觉醒效果</font>]], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create cur_active_text
	local cur_active_text = GUI:Text_Create(FrameLayout, "cur_active_text", 666, 90, 18, "#ff0000", [[当前激活：未激活]])
	GUI:Text_enableOutline(cur_active_text, "#000000", 1)
	GUI:setAnchorPoint(cur_active_text, 0.50, 0.50)
	GUI:setTouchEnabled(cur_active_text, false)
	GUI:setTag(cur_active_text, 0)

	-- Create line_img
	local line_img = GUI:Image_Create(FrameLayout, "line_img", 131, 219, "res/custom/npc/35xm/2/jd1.png")
	GUI:setContentSize(line_img, 304, 228)
	GUI:setIgnoreContentAdaptWithSize(line_img, false)
	GUI:setAnchorPoint(line_img, 0.00, 0.00)
	GUI:setTouchEnabled(line_img, false)
	GUI:setTag(line_img, 0)

	-- Create xuemai_btn1
	local xuemai_btn1 = GUI:Button_Create(FrameLayout, "xuemai_btn1", 114, 139, "res/custom/npc/35xm/2/an4.png")
	GUI:setContentSize(xuemai_btn1, 92, 34)
	GUI:setIgnoreContentAdaptWithSize(xuemai_btn1, false)
	GUI:Button_setTitleText(xuemai_btn1, [[]])
	GUI:Button_setTitleColor(xuemai_btn1, "#efd6ad")
	GUI:Button_setTitleFontSize(xuemai_btn1, 18)
	GUI:Button_titleEnableOutline(xuemai_btn1, "#000000", 1)
	GUI:setAnchorPoint(xuemai_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_btn1, true)
	GUI:setTag(xuemai_btn1, 0)

	-- Create xuemai_btn2
	local xuemai_btn2 = GUI:Button_Create(FrameLayout, "xuemai_btn2", 403, 139, "res/custom/npc/35xm/2/an5.png")
	GUI:setContentSize(xuemai_btn2, 92, 34)
	GUI:setIgnoreContentAdaptWithSize(xuemai_btn2, false)
	GUI:Button_setTitleText(xuemai_btn2, [[]])
	GUI:Button_setTitleColor(xuemai_btn2, "#efd6ad")
	GUI:Button_setTitleFontSize(xuemai_btn2, 18)
	GUI:Button_titleEnableOutline(xuemai_btn2, "#000000", 1)
	GUI:setAnchorPoint(xuemai_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(xuemai_btn2, true)
	GUI:setTag(xuemai_btn2, 0)

	-- Create item_pos1
	local item_pos1 = GUI:Layout_Create(FrameLayout, "item_pos1", 275, 169, 49, 49, false)
	GUI:setAnchorPoint(item_pos1, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos1, true)
	GUI:setTag(item_pos1, 0)

	-- Create icon1
	local icon1 = GUI:Image_Create(item_pos1, "icon1", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon1, 0.00, 0.00)
	GUI:setTouchEnabled(icon1, true)
	GUI:setTag(icon1, 0)

	-- Create lock1
	local lock1 = GUI:Image_Create(item_pos1, "lock1", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock1, 0.00, 0.00)
	GUI:setTouchEnabled(lock1, false)
	GUI:setTag(lock1, 0)

	-- Create item_pos2
	local item_pos2 = GUI:Layout_Create(FrameLayout, "item_pos2", 202, 241, 49, 49, false)
	GUI:setAnchorPoint(item_pos2, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos2, true)
	GUI:setTag(item_pos2, 0)

	-- Create icon2
	local icon2 = GUI:Image_Create(item_pos2, "icon2", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon2, 0.00, 0.00)
	GUI:setTouchEnabled(icon2, true)
	GUI:setTag(icon2, 0)

	-- Create lock2
	local lock2 = GUI:Image_Create(item_pos2, "lock2", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock2, 0.00, 0.00)
	GUI:setTouchEnabled(lock2, false)
	GUI:setTag(lock2, 0)

	-- Create item_pos3
	local item_pos3 = GUI:Layout_Create(FrameLayout, "item_pos3", 94, 270, 49, 49, false)
	GUI:setAnchorPoint(item_pos3, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos3, true)
	GUI:setTag(item_pos3, 0)

	-- Create icon3
	local icon3 = GUI:Image_Create(item_pos3, "icon3", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon3, 0.00, 0.00)
	GUI:setTouchEnabled(icon3, true)
	GUI:setTag(icon3, 0)

	-- Create lock3
	local lock3 = GUI:Image_Create(item_pos3, "lock3", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock3, 0.00, 0.00)
	GUI:setTouchEnabled(lock3, false)
	GUI:setTag(lock3, 0)

	-- Create item_pos4
	local item_pos4 = GUI:Layout_Create(FrameLayout, "item_pos4", 163, 336, 49, 49, false)
	GUI:setAnchorPoint(item_pos4, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos4, true)
	GUI:setTag(item_pos4, 0)

	-- Create icon4
	local icon4 = GUI:Image_Create(item_pos4, "icon4", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon4, 0.00, 0.00)
	GUI:setTouchEnabled(icon4, true)
	GUI:setTag(icon4, 0)

	-- Create lock4
	local lock4 = GUI:Image_Create(item_pos4, "lock4", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock4, 0.00, 0.00)
	GUI:setTouchEnabled(lock4, false)
	GUI:setTag(lock4, 0)

	-- Create item_pos5
	local item_pos5 = GUI:Layout_Create(FrameLayout, "item_pos5", 255, 323, 49, 49, false)
	GUI:setAnchorPoint(item_pos5, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos5, true)
	GUI:setTag(item_pos5, 0)

	-- Create icon5
	local icon5 = GUI:Image_Create(item_pos5, "icon5", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon5, 0.00, 0.00)
	GUI:setTouchEnabled(icon5, true)
	GUI:setTag(icon5, 0)

	-- Create lock5
	local lock5 = GUI:Image_Create(item_pos5, "lock5", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock5, 0.00, 0.00)
	GUI:setTouchEnabled(lock5, false)
	GUI:setTag(lock5, 0)

	-- Create item_pos6
	local item_pos6 = GUI:Layout_Create(FrameLayout, "item_pos6", 331, 248, 49, 49, false)
	GUI:setAnchorPoint(item_pos6, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos6, true)
	GUI:setTag(item_pos6, 0)

	-- Create icon6
	local icon6 = GUI:Image_Create(item_pos6, "icon6", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon6, 0.00, 0.00)
	GUI:setTouchEnabled(icon6, true)
	GUI:setTag(icon6, 0)

	-- Create lock6
	local lock6 = GUI:Image_Create(item_pos6, "lock6", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock6, 0.00, 0.00)
	GUI:setTouchEnabled(lock6, false)
	GUI:setTag(lock6, 0)

	-- Create item_pos7
	local item_pos7 = GUI:Layout_Create(FrameLayout, "item_pos7", 424, 264, 49, 49, false)
	GUI:setAnchorPoint(item_pos7, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos7, true)
	GUI:setTag(item_pos7, 0)

	-- Create icon7
	local icon7 = GUI:Image_Create(item_pos7, "icon7", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon7, 0.00, 0.00)
	GUI:setTouchEnabled(icon7, true)
	GUI:setTag(icon7, 0)

	-- Create lock7
	local lock7 = GUI:Image_Create(item_pos7, "lock7", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock7, 0.00, 0.00)
	GUI:setTouchEnabled(lock7, false)
	GUI:setTag(lock7, 0)

	-- Create item_pos8
	local item_pos8 = GUI:Layout_Create(FrameLayout, "item_pos8", 341, 331, 49, 49, false)
	GUI:setAnchorPoint(item_pos8, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos8, true)
	GUI:setTag(item_pos8, 0)

	-- Create icon8
	local icon8 = GUI:Image_Create(item_pos8, "icon8", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon8, 0.00, 0.00)
	GUI:setTouchEnabled(icon8, true)
	GUI:setTag(icon8, 0)

	-- Create lock8
	local lock8 = GUI:Image_Create(item_pos8, "lock8", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock8, 0.00, 0.00)
	GUI:setTouchEnabled(lock8, false)
	GUI:setTag(lock8, 0)

	-- Create item_pos9
	local item_pos9 = GUI:Layout_Create(FrameLayout, "item_pos9", 430, 360, 49, 49, false)
	GUI:setAnchorPoint(item_pos9, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos9, true)
	GUI:setTag(item_pos9, 0)

	-- Create icon9
	local icon9 = GUI:Image_Create(item_pos9, "icon9", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon9, 0.00, 0.00)
	GUI:setTouchEnabled(icon9, true)
	GUI:setTag(icon9, 0)

	-- Create lock9
	local lock9 = GUI:Image_Create(item_pos9, "lock9", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock9, 0.00, 0.00)
	GUI:setTouchEnabled(lock9, false)
	GUI:setTag(lock9, 0)

	-- Create item_pos10
	local item_pos10 = GUI:Layout_Create(FrameLayout, "item_pos10", 353, 418, 49, 49, false)
	GUI:setAnchorPoint(item_pos10, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos10, true)
	GUI:setTag(item_pos10, 0)

	-- Create icon10
	local icon10 = GUI:Image_Create(item_pos10, "icon10", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon10, 0.00, 0.00)
	GUI:setTouchEnabled(icon10, true)
	GUI:setTag(icon10, 0)

	-- Create lock10
	local lock10 = GUI:Image_Create(item_pos10, "lock10", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock10, 0.00, 0.00)
	GUI:setTouchEnabled(lock10, false)
	GUI:setTag(lock10, 0)

	-- Create item_pos11
	local item_pos11 = GUI:Layout_Create(FrameLayout, "item_pos11", 265, 419, 49, 49, false)
	GUI:setAnchorPoint(item_pos11, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos11, true)
	GUI:setTag(item_pos11, 0)

	-- Create icon11
	local icon11 = GUI:Image_Create(item_pos11, "icon11", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon11, 0.00, 0.00)
	GUI:setTouchEnabled(icon11, true)
	GUI:setTag(icon11, 0)

	-- Create lock11
	local lock11 = GUI:Image_Create(item_pos11, "lock11", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock11, 0.00, 0.00)
	GUI:setTouchEnabled(lock11, false)
	GUI:setTag(lock11, 0)

	-- Create item_pos12
	local item_pos12 = GUI:Layout_Create(FrameLayout, "item_pos12", 162, 426, 49, 49, false)
	GUI:setAnchorPoint(item_pos12, 0.00, 0.00)
	GUI:setTouchEnabled(item_pos12, true)
	GUI:setTag(item_pos12, 0)

	-- Create icon12
	local icon12 = GUI:Image_Create(item_pos12, "icon12", 2, 2, "res/custom/npc/35xm/icon/1000.png")
	GUI:setAnchorPoint(icon12, 0.00, 0.00)
	GUI:setTouchEnabled(icon12, true)
	GUI:setTag(icon12, 0)

	-- Create lock12
	local lock12 = GUI:Image_Create(item_pos12, "lock12", 15, 9, "res/custom/npc/35xm/2/s.png")
	GUI:setAnchorPoint(lock12, 0.00, 0.00)
	GUI:setTouchEnabled(lock12, false)
	GUI:setTag(lock12, 0)

	-- Create player_name
	local player_name = GUI:Text_Create(FrameLayout, "player_name", 675, 418, 18, "#ffff00", [[]])
	GUI:Text_enableOutline(player_name, "#000000", 1)
	GUI:setAnchorPoint(player_name, 0.50, 0.50)
	GUI:setTouchEnabled(player_name, false)
	GUI:setTag(player_name, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
