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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/hecheng/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 192, 192)
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
	local leftBtnList = GUI:ScrollView_Create(FrameLayout, "leftBtnList", 73, 484, 120, 440, 1)
	GUI:ScrollView_setInnerContainerSize(leftBtnList, 120.00, 440.00)
	GUI:setAnchorPoint(leftBtnList, 0.00, 1.00)
	GUI:setTouchEnabled(leftBtnList, true)
	GUI:setTag(leftBtnList, 0)

	-- Create leftBtn1
	local leftBtn1 = GUI:Image_Create(leftBtnList, "leftBtn1", 0, 396, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn1, false)
	GUI:setAnchorPoint(leftBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn1, false)
	GUI:setTag(leftBtn1, 0)

	-- Create nowLeftTag
	local nowLeftTag = GUI:Image_Create(leftBtn1, "nowLeftTag", 10, 12, "res/custom/ar2.png")
	GUI:setContentSize(nowLeftTag, 22, 15)
	GUI:setIgnoreContentAdaptWithSize(nowLeftTag, false)
	GUI:setAnchorPoint(nowLeftTag, 0.00, 0.00)
	GUI:setTouchEnabled(nowLeftTag, false)
	GUI:setTag(nowLeftTag, 0)

	-- Create nowLeftList
	local nowLeftList = GUI:ListView_Create(leftBtn1, "nowLeftList", 3, 0, 114, 88, 1)
	GUI:setAnchorPoint(nowLeftList, 0.00, 1.00)
	GUI:setTouchEnabled(nowLeftList, true)
	GUI:setTag(nowLeftList, 0)

	-- Create leftBox1
	local leftBox1 = GUI:Image_Create(nowLeftList, "leftBox1", 0, 44, "res/custom/hecheng/bt1.png")
	GUI:setContentSize(leftBox1, 114, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBox1, false)
	GUI:setAnchorPoint(leftBox1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox1, false)
	GUI:setTag(leftBox1, 0)

	-- Create leftBoxName1
	local leftBoxName1 = GUI:Text_Create(leftBox1, "leftBoxName1", 60, 22, 16, "#ffffff", [[转生材料]])
	GUI:Text_enableOutline(leftBoxName1, "#000000", 1)
	GUI:setAnchorPoint(leftBoxName1, 0.50, 0.50)
	GUI:setTouchEnabled(leftBoxName1, false)
	GUI:setTag(leftBoxName1, 0)

	-- Create leftBox2
	local leftBox2 = GUI:Image_Create(nowLeftList, "leftBox2", 0, 0, "res/custom/hecheng/bt1.png")
	GUI:setContentSize(leftBox2, 114, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBox2, false)
	GUI:setAnchorPoint(leftBox2, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox2, false)
	GUI:setTag(leftBox2, 0)

	-- Create leftBoxName1
	leftBoxName1 = GUI:Text_Create(leftBox2, "leftBoxName1", 60, 22, 16, "#ffffff", [[转生材料]])
	GUI:Text_enableOutline(leftBoxName1, "#000000", 1)
	GUI:setAnchorPoint(leftBoxName1, 0.50, 0.50)
	GUI:setTouchEnabled(leftBoxName1, false)
	GUI:setTag(leftBoxName1, 0)

	-- Create leftBox2_1
	local leftBox2_1 = GUI:Image_Create(leftBox2, "leftBox2_1", 0, 0, "res/custom/hecheng/bt3.png")
	GUI:setContentSize(leftBox2_1, 114, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBox2_1, false)
	GUI:setAnchorPoint(leftBox2_1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox2_1, false)
	GUI:setTag(leftBox2_1, 0)

	-- Create leftBtn2
	local leftBtn2 = GUI:Image_Create(leftBtnList, "leftBtn2", 0, 308, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn2, false)
	GUI:setAnchorPoint(leftBtn2, 0.00, 1.00)
	GUI:setTouchEnabled(leftBtn2, false)
	GUI:setTag(leftBtn2, 0)

	-- Create rightList
	local rightList = GUI:ListView_Create(FrameLayout, "rightList", 201, 484, 114, 444, 1)
	GUI:ListView_setBounceEnabled(rightList, true)
	GUI:ListView_setItemsMargin(rightList, 4)
	GUI:setAnchorPoint(rightList, 0.00, 1.00)
	GUI:setTouchEnabled(rightList, true)
	GUI:setTag(rightList, 0)

	-- Create rightBox1
	local rightBox1 = GUI:Image_Create(rightList, "rightBox1", 0, 410, "res/custom/npc/z2.png")
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
	local rightBox1_1 = GUI:Image_Create(rightList, "rightBox1_1", 0, 372, "res/custom/npc/z2.png")
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

	-- Create itemNode
	local itemNode = GUI:Node_Create(midNode, "itemNode", 561, 385)
	GUI:setTag(itemNode, 0)

	-- Create nowItem
	local nowItem = GUI:ItemShow_Create(itemNode, "nowItem", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(nowItem, 0.50, 0.50)
	GUI:setTag(nowItem, 0)

	-- Create nowItemName
	local nowItemName = GUI:Text_Create(midNode, "nowItemName", 564, 326, 16, "#ff0000", [[]])
	GUI:Text_enableOutline(nowItemName, "#000000", 1)
	GUI:setAnchorPoint(nowItemName, 0.50, 0.50)
	GUI:setTouchEnabled(nowItemName, false)
	GUI:setTag(nowItemName, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(midNode, "needItemNode", 562, 216)
	GUI:setTag(needItemNode, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midNode, "upBtn", 566, 98, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:setContentSize(upBtn, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开始合成]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
