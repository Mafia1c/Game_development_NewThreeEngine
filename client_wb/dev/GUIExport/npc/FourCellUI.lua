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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/02tshc/mb.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 801, 511, "res/custom/npc/close1.png")
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

	-- Create leftBtnList
	local leftBtnList = GUI:ListView_Create(FrameLayout, "leftBtnList", 73, 484, 120, 440, 1)
	GUI:ListView_setItemsMargin(leftBtnList, 1)
	GUI:setAnchorPoint(leftBtnList, 0.00, 1.00)
	GUI:setTouchEnabled(leftBtnList, true)
	GUI:setTag(leftBtnList, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(leftBtnList, "Image_4", 0, 396, "res/custom/npc/ta0.png")
	GUI:setContentSize(Image_4, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Image_4, false)
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(leftBtnList, "Image_5", 0, 351, "res/custom/npc/ta0.png")
	GUI:setContentSize(Image_5, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Image_5, false)
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create rightTag
	local rightTag = GUI:Image_Create(FrameLayout, "rightTag", 200, 445, "res/custom/npc/02tshc/yq_0.png")
	GUI:Image_setScale9Slice(rightTag, 11, 11, 14, 14)
	GUI:setContentSize(rightTag, 116, 40)
	GUI:setIgnoreContentAdaptWithSize(rightTag, false)
	GUI:setAnchorPoint(rightTag, 0.00, 0.00)
	GUI:setTouchEnabled(rightTag, false)
	GUI:setTag(rightTag, 0)

	-- Create rightTagName
	local rightTagName = GUI:Text_Create(rightTag, "rightTagName", 62, 20, 18, "#ffff00", [[斗笠]])
	GUI:Text_enableOutline(rightTagName, "#000000", 1)
	GUI:setAnchorPoint(rightTagName, 0.50, 0.50)
	GUI:setTouchEnabled(rightTagName, false)
	GUI:setTag(rightTagName, 0)

	-- Create rightTagRow
	local rightTagRow = GUI:Image_Create(rightTag, "rightTagRow", 10, 12, "res/custom/ar2.png")
	GUI:setContentSize(rightTagRow, 22, 15)
	GUI:setIgnoreContentAdaptWithSize(rightTagRow, false)
	GUI:setAnchorPoint(rightTagRow, 0.00, 0.00)
	GUI:setTouchEnabled(rightTagRow, false)
	GUI:setTag(rightTagRow, 0)

	-- Create rightList
	local rightList = GUI:ListView_Create(rightTag, "rightList", 1, 0, 114, 360, 1)
	GUI:ListView_setBounceEnabled(rightList, true)
	GUI:ListView_setItemsMargin(rightList, 4)
	GUI:setAnchorPoint(rightList, 0.00, 1.00)
	GUI:setTouchEnabled(rightList, true)
	GUI:setTag(rightList, 0)

	-- Create rightBox1
	local rightBox1 = GUI:Image_Create(rightList, "rightBox1", 0, 326, "res/custom/npc/z2.png")
	GUI:setContentSize(rightBox1, 114, 34)
	GUI:setIgnoreContentAdaptWithSize(rightBox1, false)
	GUI:setAnchorPoint(rightBox1, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox1, false)
	GUI:setTag(rightBox1, 0)

	-- Create rightBoxName1
	local rightBoxName1 = GUI:Text_Create(rightBox1, "rightBoxName1", 58, 16, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(rightBoxName1, "#000000", 1)
	GUI:setAnchorPoint(rightBoxName1, 0.50, 0.50)
	GUI:setTouchEnabled(rightBoxName1, false)
	GUI:setTag(rightBoxName1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(rightBox1, "Image_1", 0, 0, "res/custom/npc/z3.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)
	GUI:setVisible(Image_1, false)

	-- Create rightBox1_1
	local rightBox1_1 = GUI:Image_Create(rightList, "rightBox1_1", 0, 288, "res/custom/npc/z2.png")
	GUI:setContentSize(rightBox1_1, 114, 34)
	GUI:setIgnoreContentAdaptWithSize(rightBox1_1, false)
	GUI:setAnchorPoint(rightBox1_1, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox1_1, false)
	GUI:setTag(rightBox1_1, 0)

	-- Create rightBoxName1
	rightBoxName1 = GUI:Text_Create(rightBox1_1, "rightBoxName1", 58, 16, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(rightBoxName1, "#000000", 1)
	GUI:setAnchorPoint(rightBoxName1, 0.50, 0.50)
	GUI:setTouchEnabled(rightBoxName1, false)
	GUI:setTag(rightBoxName1, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(rightBox1_1, "Image_1", 0, 0, "res/custom/npc/z3.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create equipNode
	local equipNode = GUI:Node_Create(midNode, "equipNode", 561, 385)
	GUI:setTag(equipNode, 0)

	-- Create nowItem
	local nowItem = GUI:ItemShow_Create(equipNode, "nowItem", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(nowItem, 0.50, 0.50)
	GUI:setTag(nowItem, 0)

	-- Create equipName
	local equipName = GUI:Text_Create(midNode, "equipName", 562, 324, 16, "#ff0000", [[]])
	GUI:Text_enableOutline(equipName, "#000000", 1)
	GUI:setAnchorPoint(equipName, 0.50, 0.50)
	GUI:setTouchEnabled(equipName, false)
	GUI:setTag(equipName, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(midNode, "needItemNode", 562, 218)
	GUI:setTag(needItemNode, 0)

	-- Create upBtn1
	local upBtn1 = GUI:Button_Create(midNode, "upBtn1", 494, 122, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn1, "res/custom/npc/anb2.png")
	GUI:setContentSize(upBtn1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(upBtn1, false)
	GUI:Button_setTitleText(upBtn1, [[背包合成]])
	GUI:Button_setTitleColor(upBtn1, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn1, 18)
	GUI:Button_titleEnableOutline(upBtn1, "#000000", 1)
	GUI:setAnchorPoint(upBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn1, true)
	GUI:setTag(upBtn1, 0)

	-- Create upBtn2
	local upBtn2 = GUI:Button_Create(midNode, "upBtn2", 648, 122, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn2, "res/custom/npc/anb2.png")
	GUI:setContentSize(upBtn2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(upBtn2, false)
	GUI:Button_setTitleText(upBtn2, [[身上合成]])
	GUI:Button_setTitleColor(upBtn2, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn2, 18)
	GUI:Button_titleEnableOutline(upBtn2, "#000000", 1)
	GUI:setAnchorPoint(upBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn2, true)
	GUI:setTag(upBtn2, 0)

	-- Create RichText
	local RichText = GUI:RichText_Create(midNode, "RichText", 78, 44, [==========[<font color='#FFFFFF' size='16' >提示：特殊合成所需的</font><font color='#00ff00' size='16' >[材料与道具]</font><font color='#FFFFFF' size='16' >在</font><font color='#00ff00' size='16' >[任意地图怪物]</font><font color='#FFFFFF' size='16' >均有几率爆出！</font>]==========], 700, 16, "#00ff00", 4)
	GUI:setAnchorPoint(RichText, 0.00, 0.00)
	GUI:setTag(RichText, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
