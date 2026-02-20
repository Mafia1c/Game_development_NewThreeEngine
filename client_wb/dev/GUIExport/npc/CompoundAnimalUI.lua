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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/hecheng/bg4.png")
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

	-- Create leftImg1
	local leftImg1 = GUI:Image_Create(FrameLayout, "leftImg1", 133, 439, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftImg1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftImg1, false)
	GUI:setAnchorPoint(leftImg1, 0.50, 0.00)
	GUI:setTouchEnabled(leftImg1, false)
	GUI:setTag(leftImg1, 0)

	-- Create leftTagRow1
	local leftTagRow1 = GUI:Image_Create(leftImg1, "leftTagRow1", 6, 12, "res/custom/ad.png")
	GUI:setContentSize(leftTagRow1, 18, 20)
	GUI:setIgnoreContentAdaptWithSize(leftTagRow1, false)
	GUI:setAnchorPoint(leftTagRow1, 0.00, 0.00)
	GUI:setTouchEnabled(leftTagRow1, false)
	GUI:setTag(leftTagRow1, 0)

	-- Create leftImgName1
	local leftImgName1 = GUI:Text_Create(leftImg1, "leftImgName1", 64, 22, 18, "#ffffff", [[生肖合成]])
	GUI:Text_enableOutline(leftImgName1, "#000000", 1)
	GUI:setAnchorPoint(leftImgName1, 0.50, 0.50)
	GUI:setTouchEnabled(leftImgName1, false)
	GUI:setTag(leftImgName1, 0)

	-- Create leftBoxList1
	local leftBoxList1 = GUI:ListView_Create(leftImg1, "leftBoxList1", 4, 0, 114, 200, 1)
	GUI:ListView_setBounceEnabled(leftBoxList1, true)
	GUI:ListView_setItemsMargin(leftBoxList1, 1)
	GUI:setAnchorPoint(leftBoxList1, 0.00, 1.00)
	GUI:setTouchEnabled(leftBoxList1, true)
	GUI:setTag(leftBoxList1, 0)

	-- Create leftBox11
	local leftBox11 = GUI:Image_Create(leftBoxList1, "leftBox11", 0, 156, "res/custom/hecheng/bt1.png")
	GUI:setContentSize(leftBox11, 114, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBox11, false)
	GUI:setAnchorPoint(leftBox11, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox11, false)
	GUI:setTag(leftBox11, 0)

	-- Create leftBoxName11
	local leftBoxName11 = GUI:Text_Create(leftBox11, "leftBoxName11", 56, 22, 16, "#f0b42a", [[一阶生肖]])
	GUI:Text_enableOutline(leftBoxName11, "#000000", 1)
	GUI:setAnchorPoint(leftBoxName11, 0.50, 0.50)
	GUI:setTouchEnabled(leftBoxName11, false)
	GUI:setTag(leftBoxName11, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(leftBox11, "Image_1", 0, 0, "res/custom/hecheng/bt3.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create leftBox11_1
	local leftBox11_1 = GUI:Image_Create(leftBoxList1, "leftBox11_1", 0, 111, "res/custom/hecheng/bt1.png")
	GUI:setContentSize(leftBox11_1, 114, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBox11_1, false)
	GUI:setAnchorPoint(leftBox11_1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox11_1, false)
	GUI:setTag(leftBox11_1, 0)

	-- Create leftBoxName11
	leftBoxName11 = GUI:Text_Create(leftBox11_1, "leftBoxName11", 56, 22, 16, "#f0b42a", [[一阶生肖]])
	GUI:Text_enableOutline(leftBoxName11, "#000000", 1)
	GUI:setAnchorPoint(leftBoxName11, 0.50, 0.50)
	GUI:setTouchEnabled(leftBoxName11, false)
	GUI:setTag(leftBoxName11, 0)

	-- Create leftBox11_2
	local leftBox11_2 = GUI:Image_Create(leftBoxList1, "leftBox11_2", 0, 66, "res/custom/hecheng/bt1.png")
	GUI:setContentSize(leftBox11_2, 114, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBox11_2, false)
	GUI:setAnchorPoint(leftBox11_2, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox11_2, false)
	GUI:setTag(leftBox11_2, 0)

	-- Create leftBoxName11
	leftBoxName11 = GUI:Text_Create(leftBox11_2, "leftBoxName11", 56, 22, 16, "#f0b42a", [[一阶生肖]])
	GUI:Text_enableOutline(leftBoxName11, "#000000", 1)
	GUI:setAnchorPoint(leftBoxName11, 0.50, 0.50)
	GUI:setTouchEnabled(leftBoxName11, false)
	GUI:setTag(leftBoxName11, 0)

	-- Create leftBox11_3
	local leftBox11_3 = GUI:Image_Create(leftBoxList1, "leftBox11_3", 0, 21, "res/custom/hecheng/bt1.png")
	GUI:setContentSize(leftBox11_3, 114, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBox11_3, false)
	GUI:setAnchorPoint(leftBox11_3, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox11_3, false)
	GUI:setTag(leftBox11_3, 0)

	-- Create leftBoxName11
	leftBoxName11 = GUI:Text_Create(leftBox11_3, "leftBoxName11", 56, 22, 16, "#f0b42a", [[一阶生肖]])
	GUI:Text_enableOutline(leftBoxName11, "#000000", 1)
	GUI:setAnchorPoint(leftBoxName11, 0.50, 0.50)
	GUI:setTouchEnabled(leftBoxName11, false)
	GUI:setTag(leftBoxName11, 0)

	-- Create leftImg2
	local leftImg2 = GUI:Image_Create(FrameLayout, "leftImg2", 133, 178, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftImg2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftImg2, false)
	GUI:setAnchorPoint(leftImg2, 0.50, 0.00)
	GUI:setTouchEnabled(leftImg2, false)
	GUI:setTag(leftImg2, 0)
	GUI:setVisible(leftImg2, false)

	-- Create leftTagRow2
	local leftTagRow2 = GUI:Image_Create(leftImg2, "leftTagRow2", 6, 12, "res/custom/ad.png")
	GUI:setContentSize(leftTagRow2, 18, 20)
	GUI:setIgnoreContentAdaptWithSize(leftTagRow2, false)
	GUI:setAnchorPoint(leftTagRow2, 0.00, 0.00)
	GUI:setTouchEnabled(leftTagRow2, false)
	GUI:setTag(leftTagRow2, 0)

	-- Create leftImgName2
	local leftImgName2 = GUI:Text_Create(leftImg2, "leftImgName2", 64, 22, 18, "#ffffff", [[生肖注灵]])
	GUI:Text_enableOutline(leftImgName2, "#000000", 1)
	GUI:setAnchorPoint(leftImgName2, 0.50, 0.50)
	GUI:setTouchEnabled(leftImgName2, false)
	GUI:setTag(leftImgName2, 0)

	-- Create leftBoxList2
	local leftBoxList2 = GUI:ListView_Create(leftImg2, "leftBoxList2", 4, 0, 114, 100, 1)
	GUI:ListView_setBounceEnabled(leftBoxList2, true)
	GUI:ListView_setItemsMargin(leftBoxList2, 1)
	GUI:setAnchorPoint(leftBoxList2, 0.00, 1.00)
	GUI:setTouchEnabled(leftBoxList2, true)
	GUI:setTag(leftBoxList2, 0)

	-- Create leftBox21
	local leftBox21 = GUI:Image_Create(leftBoxList2, "leftBox21", 0, 56, "res/custom/hecheng/bt1.png")
	GUI:setContentSize(leftBox21, 114, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBox21, false)
	GUI:setAnchorPoint(leftBox21, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox21, false)
	GUI:setTag(leftBox21, 0)

	-- Create leftBoxName21
	local leftBoxName21 = GUI:Text_Create(leftBox21, "leftBoxName21", 56, 22, 16, "#df009f", [[生肖注灵]])
	GUI:Text_enableOutline(leftBoxName21, "#000000", 1)
	GUI:setAnchorPoint(leftBoxName21, 0.50, 0.50)
	GUI:setTouchEnabled(leftBoxName21, false)
	GUI:setTag(leftBoxName21, 0)
	GUI:setLocalZOrder(leftBoxName21, 20)

	-- Create leftLayout21
	local leftLayout21 = GUI:Layout_Create(leftBox21, "leftLayout21", 0, 0, 114, 44, false)
	GUI:setAnchorPoint(leftLayout21, 0.00, 0.00)
	GUI:setTouchEnabled(leftLayout21, true)
	GUI:setMouseEnabled(leftLayout21, true)
	GUI:setTag(leftLayout21, 0)

	-- Create rightList
	local rightList = GUI:ListView_Create(FrameLayout, "rightList", 202, 482, 114, 448, 1)
	GUI:ListView_setBounceEnabled(rightList, true)
	GUI:ListView_setItemsMargin(rightList, 4)
	GUI:setAnchorPoint(rightList, 0.00, 1.00)
	GUI:setTouchEnabled(rightList, true)
	GUI:setTag(rightList, 0)

	-- Create rightBox1
	local rightBox1 = GUI:Image_Create(rightList, "rightBox1", 0, 414, "res/custom/npc/z2.png")
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
	Image_1 = GUI:Image_Create(rightBox1, "Image_1", 0, 0, "res/custom/npc/z3.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)
	GUI:setVisible(Image_1, false)

	-- Create rightBox1_1
	local rightBox1_1 = GUI:Image_Create(rightList, "rightBox1_1", 0, 376, "res/custom/npc/z2.png")
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

	-- Create midNode1
	local midNode1 = GUI:Node_Create(FrameLayout, "midNode1", 0, 0)
	GUI:setTag(midNode1, 0)
	GUI:setVisible(midNode1, false)

	-- Create equipNode1
	local equipNode1 = GUI:Node_Create(midNode1, "equipNode1", 561, 385)
	GUI:setTag(equipNode1, 0)

	-- Create nowItem1
	local nowItem1 = GUI:ItemShow_Create(equipNode1, "nowItem1", 0, 0, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(nowItem1, 0.50, 0.50)
	GUI:setTag(nowItem1, 0)

	-- Create equipName1
	local equipName1 = GUI:Text_Create(midNode1, "equipName1", 562, 324, 16, "#ff0000", [[]])
	GUI:Text_enableOutline(equipName1, "#000000", 1)
	GUI:setAnchorPoint(equipName1, 0.50, 0.50)
	GUI:setTouchEnabled(equipName1, false)
	GUI:setTag(equipName1, 0)

	-- Create needItemNode1
	local needItemNode1 = GUI:Node_Create(midNode1, "needItemNode1", 562, 214)
	GUI:setTag(needItemNode1, 0)

	-- Create upBtn11
	local upBtn11 = GUI:Button_Create(midNode1, "upBtn11", 494, 100, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn11, "res/custom/npc/anb2.png")
	GUI:setContentSize(upBtn11, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(upBtn11, false)
	GUI:Button_setTitleText(upBtn11, [[背包合成]])
	GUI:Button_setTitleColor(upBtn11, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn11, 18)
	GUI:Button_titleEnableOutline(upBtn11, "#000000", 1)
	GUI:setAnchorPoint(upBtn11, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn11, true)
	GUI:setTag(upBtn11, 0)

	-- Create upBtn12
	local upBtn12 = GUI:Button_Create(midNode1, "upBtn12", 648, 100, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn12, "res/custom/npc/anb2.png")
	GUI:setContentSize(upBtn12, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(upBtn12, false)
	GUI:Button_setTitleText(upBtn12, [[身上合成]])
	GUI:Button_setTitleColor(upBtn12, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn12, 18)
	GUI:Button_titleEnableOutline(upBtn12, "#000000", 1)
	GUI:setAnchorPoint(upBtn12, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn12, true)
	GUI:setTag(upBtn12, 0)

	-- Create midNode2
	local midNode2 = GUI:Node_Create(FrameLayout, "midNode2", 0, 0)
	GUI:setTag(midNode2, 0)

	-- Create tipsBtn2
	local tipsBtn2 = GUI:Button_Create(midNode2, "tipsBtn2", 760, 448, "res/custom/hecheng/help.png")
	GUI:setContentSize(tipsBtn2, 66, 57)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn2, false)
	GUI:Button_setTitleText(tipsBtn2, [[]])
	GUI:Button_setTitleColor(tipsBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn2, 16)
	GUI:Button_titleEnableOutline(tipsBtn2, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(tipsBtn2, true)
	GUI:setTag(tipsBtn2, 0)

	-- Create equipNode2
	local equipNode2 = GUI:Node_Create(midNode2, "equipNode2", 559, 377)
	GUI:setTag(equipNode2, 0)

	-- Create nowItem2
	local nowItem2 = GUI:ItemShow_Create(equipNode2, "nowItem2", -30, -30, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(nowItem2, 0.00, 0.00)
	GUI:setTag(nowItem2, 0)

	-- Create wearImg2
	local wearImg2 = GUI:Image_Create(equipNode2, "wearImg2", 0, -48, "res/custom/hecheng/00.png")
	GUI:setAnchorPoint(wearImg2, 0.50, 0.50)
	GUI:setTouchEnabled(wearImg2, false)
	GUI:setTag(wearImg2, 0)

	-- Create equipName2
	local equipName2 = GUI:Text_Create(midNode2, "equipName2", 560, 460, 16, "#df009f", [[神话·鼠]])
	GUI:Text_enableOutline(equipName2, "#000000", 1)
	GUI:setAnchorPoint(equipName2, 0.50, 0.50)
	GUI:setTouchEnabled(equipName2, false)
	GUI:setTag(equipName2, 0)

	-- Create infoNode2
	local infoNode2 = GUI:Node_Create(midNode2, "infoNode2", 562, 238)
	GUI:setTag(infoNode2, 0)

	-- Create needItemNode2
	local needItemNode2 = GUI:Node_Create(midNode2, "needItemNode2", 506, 84)
	GUI:setTag(needItemNode2, 0)

	-- Create upBtn21
	local upBtn21 = GUI:Button_Create(midNode2, "upBtn21", 698, 94, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn21, "res/custom/npc/anb2.png")
	GUI:setContentSize(upBtn21, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(upBtn21, false)
	GUI:Button_setTitleText(upBtn21, [[生肖注灵]])
	GUI:Button_setTitleColor(upBtn21, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn21, 18)
	GUI:Button_titleEnableOutline(upBtn21, "#000000", 1)
	GUI:setAnchorPoint(upBtn21, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn21, true)
	GUI:setTag(upBtn21, 0)

	-- Create oddText21
	local oddText21 = GUI:Text_Create(upBtn21, "oddText21", 62, -18, 16, "#00ff00", [[成功率：10%]])
	GUI:Text_enableOutline(oddText21, "#000000", 1)
	GUI:setAnchorPoint(oddText21, 0.50, 0.50)
	GUI:setTouchEnabled(oddText21, false)
	GUI:setTag(oddText21, 0)

	-- Create RichText2
	local RichText2 = GUI:RichText_Create(midNode2, "RichText2", 374, 152, [[<font color='#FFFFFF' size='16' >只有</font><font color='#DF009F' size='16' > 神话生肖 </font><font color='#FFFFFF' size='16' >方可注灵，注灵成功随机获得</font><font color='#00FCFC' size='16' >1-3</font><font color='#FFFFFF' size='16' >条属性</font>]], 400, 16, "#00ff00", 4)
	GUI:setAnchorPoint(RichText2, 0.00, 0.00)
	GUI:setTag(RichText2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
