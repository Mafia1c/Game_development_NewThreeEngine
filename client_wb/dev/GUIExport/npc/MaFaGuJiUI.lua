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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, _V("SCREEN_HEIGHT") * 0.5, 896, 610, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/27guji/main.png")
	GUI:Image_setScale9Slice(FrameBG, 89, 89, 203, 203)
	GUI:setContentSize(FrameBG, 896, 610)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 853, 556, "res/custom/npc/close1.png")
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

	-- Create L_Node
	local L_Node = GUI:Node_Create(FrameLayout, "L_Node", 0, 0)
	GUI:setTag(L_Node, 0)

	-- Create ModeNode
	local ModeNode = GUI:Node_Create(L_Node, "ModeNode", 0, 0)
	GUI:setTag(ModeNode, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(L_Node, "ItemShow_1", 128, 406, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create icon
	local icon = GUI:Image_Create(ItemShow_1, "icon", -9, 0, "res/custom/npc/27guji/jh0.png")
	GUI:setAnchorPoint(icon, 0.00, 0.00)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(L_Node, "ItemShow_2", 379, 406, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create icon
	icon = GUI:Image_Create(ItemShow_2, "icon", 46, 0, "res/custom/npc/27guji/jh1.png")
	GUI:setAnchorPoint(icon, 0.00, 0.00)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(L_Node, "ItemShow_3", 128, 326, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create icon
	icon = GUI:Image_Create(ItemShow_3, "icon", -9, 0, "res/custom/npc/27guji/jh0.png")
	GUI:setAnchorPoint(icon, 0.00, 0.00)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(L_Node, "ItemShow_4", 379, 326, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create icon
	icon = GUI:Image_Create(ItemShow_4, "icon", 46, 0, "res/custom/npc/27guji/jh0.png")
	GUI:setAnchorPoint(icon, 0.00, 0.00)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(L_Node, "ItemShow_5", 128, 247, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create icon
	icon = GUI:Image_Create(ItemShow_5, "icon", -9, 0, "res/custom/npc/27guji/jh0.png")
	GUI:setAnchorPoint(icon, 0.00, 0.00)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(L_Node, "ItemShow_6", 379, 247, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create icon
	icon = GUI:Image_Create(ItemShow_6, "icon", 46, 0, "res/custom/npc/27guji/jh0.png")
	GUI:setAnchorPoint(icon, 0.00, 0.00)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(L_Node, "ItemShow_7", 205, 174, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create icon
	icon = GUI:Image_Create(ItemShow_7, "icon", -9, 0, "res/custom/npc/27guji/jh0.png")
	GUI:setAnchorPoint(icon, 0.00, 0.00)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(L_Node, "ItemShow_8", 312, 174, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setTag(ItemShow_8, 0)

	-- Create icon
	icon = GUI:Image_Create(ItemShow_8, "icon", 46, 0, "res/custom/npc/27guji/jh0.png")
	GUI:setAnchorPoint(icon, 0.00, 0.00)
	GUI:setTouchEnabled(icon, false)
	GUI:setTag(icon, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(L_Node, "Text_1", 79, 102, 20, "#c6a529", [[奖励说明:]])
	GUI:Text_enableOutline(Text_1, "#000000", 2)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(L_Node, "RichText_1", 80, 60, [==========[<font color='#c6c6ce' size='18' > 完成 </font><font color='#00ff00' size='18' >玛法古纪 </font><font color='#c6c6ce' size='18' >任务可晋升获得 </font><font color='#9b00ff' size='18' >[高级副装]</font>]==========], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create R_Node
	local R_Node = GUI:Node_Create(FrameLayout, "R_Node", 0, 0)
	GUI:setTag(R_Node, 0)

	-- Create cell_img_1
	local cell_img_1 = GUI:Image_Create(R_Node, "cell_img_1", 438, 366, "res/custom/npc/27guji/list.png")
	GUI:setContentSize(cell_img_1, 413, 126)
	GUI:setIgnoreContentAdaptWithSize(cell_img_1, false)
	GUI:setAnchorPoint(cell_img_1, 0.00, 0.00)
	GUI:setTouchEnabled(cell_img_1, false)
	GUI:setTag(cell_img_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(cell_img_1, "Text_2", 15, 57, 18, "#f0b42a", [[任
务]])
	GUI:Text_enableOutline(Text_2, "#000000", 2)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create rank
	local rank = GUI:Image_Create(cell_img_1, "rank", 8, 18, "res/custom/npc/27guji/no1.png")
	GUI:setAnchorPoint(rank, 0.00, 0.00)
	GUI:setTouchEnabled(rank, false)
	GUI:setTag(rank, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(cell_img_1, "Button_1", 340, 16, "res/custom/tag/y_103.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/npc/27guji/btn2.png")
	GUI:setContentSize(Button_1, 107, 84)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.50, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(cell_img_1, "ItemShow_1", 85, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(cell_img_1, "ItemShow_2", 160, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(cell_img_1, "ItemShow_3", 235, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create cell_img_2
	local cell_img_2 = GUI:Image_Create(R_Node, "cell_img_2", 438, 240, "res/custom/npc/27guji/list.png")
	GUI:setContentSize(cell_img_2, 413, 126)
	GUI:setIgnoreContentAdaptWithSize(cell_img_2, false)
	GUI:setAnchorPoint(cell_img_2, 0.00, 0.00)
	GUI:setTouchEnabled(cell_img_2, false)
	GUI:setTag(cell_img_2, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(cell_img_2, "Text_2", 15, 57, 18, "#00ffe8", [[任
务]])
	GUI:Text_enableOutline(Text_2, "#000000", 2)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create rank
	rank = GUI:Image_Create(cell_img_2, "rank", 8, 18, "res/custom/npc/27guji/no2.png")
	GUI:setAnchorPoint(rank, 0.00, 0.00)
	GUI:setTouchEnabled(rank, false)
	GUI:setTag(rank, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(cell_img_2, "Button_2", 340, 16, "res/custom/npc/27guji/btn1.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/npc/27guji/btn2.png")
	GUI:setContentSize(Button_2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.50, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(cell_img_2, "ItemShow_1", 85, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(cell_img_2, "ItemShow_2", 160, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(cell_img_2, "ItemShow_3", 235, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create cell_img_3
	local cell_img_3 = GUI:Image_Create(R_Node, "cell_img_3", 438, 114, "res/custom/npc/27guji/list.png")
	GUI:setContentSize(cell_img_3, 413, 126)
	GUI:setIgnoreContentAdaptWithSize(cell_img_3, false)
	GUI:setAnchorPoint(cell_img_3, 0.00, 0.00)
	GUI:setTouchEnabled(cell_img_3, false)
	GUI:setTag(cell_img_3, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(cell_img_3, "Text_2", 15, 57, 18, "#94844a", [[任
务]])
	GUI:Text_enableOutline(Text_2, "#000000", 2)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create rank
	rank = GUI:Image_Create(cell_img_3, "rank", 8, 18, "res/custom/npc/27guji/no3.png")
	GUI:setAnchorPoint(rank, 0.00, 0.00)
	GUI:setTouchEnabled(rank, false)
	GUI:setTag(rank, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(cell_img_3, "Button_3", 340, 16, "res/custom/npc/27guji/btn1.png")
	GUI:Button_loadTexturePressed(Button_3, "res/custom/npc/27guji/btn2.png")
	GUI:setContentSize(Button_3, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.50, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(cell_img_3, "ItemShow_1", 85, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(cell_img_3, "ItemShow_2", 160, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(cell_img_3, "ItemShow_3", 235, 40, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create GetReward
	local GetReward = GUI:Button_Create(R_Node, "GetReward", 718, 48, "res/custom/npc/27guji/dbtn1.png")
	GUI:Button_loadTexturePressed(GetReward, "res/custom/npc/27guji/dbtn2.png")
	GUI:setContentSize(GetReward, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(GetReward, false)
	GUI:Button_setTitleText(GetReward, [[]])
	GUI:Button_setTitleColor(GetReward, "#ffffff")
	GUI:Button_setTitleFontSize(GetReward, 16)
	GUI:Button_titleEnableOutline(GetReward, "#000000", 1)
	GUI:setAnchorPoint(GetReward, 0.00, 0.00)
	GUI:setTouchEnabled(GetReward, true)
	GUI:setTag(GetReward, 0)

	-- Create btn_tag
	local btn_tag = GUI:Image_Create(R_Node, "btn_tag", 710, 50, "res/custom/npc/27guji/tiao.png")
	GUI:setAnchorPoint(btn_tag, 0.00, 0.00)
	GUI:setTouchEnabled(btn_tag, false)
	GUI:setTag(btn_tag, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(R_Node, "ListView_1", 503, 43, 200, 60, 2)
	GUI:ListView_setGravity(ListView_1, 5)
	GUI:ListView_setItemsMargin(ListView_1, 10)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create GetTag
	local GetTag = GUI:Image_Create(R_Node, "GetTag", 728, 40, "res/custom/tag/c_101.png")
	GUI:setAnchorPoint(GetTag, 0.00, 0.00)
	GUI:setTouchEnabled(GetTag, false)
	GUI:setTag(GetTag, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
