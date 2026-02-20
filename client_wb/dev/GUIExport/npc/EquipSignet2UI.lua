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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/05jpss/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
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

	-- Create leftBigImg
	local leftBigImg = GUI:Image_Create(FrameLayout, "leftBigImg", 133, 462, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBigImg, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBigImg, false)
	GUI:setAnchorPoint(leftBigImg, 0.50, 0.50)
	GUI:setTouchEnabled(leftBigImg, false)
	GUI:setTag(leftBigImg, 0)

	-- Create leftBigName
	local leftBigName = GUI:Text_Create(leftBigImg, "leftBigName", 70, 20, 18, "#ffffff", [[专属附魔]])
	GUI:Text_enableOutline(leftBigName, "#000000", 1)
	GUI:setAnchorPoint(leftBigName, 0.50, 0.50)
	GUI:setTouchEnabled(leftBigName, false)
	GUI:setTag(leftBigName, 0)

	-- Create leftBigRow
	local leftBigRow = GUI:Image_Create(leftBigImg, "leftBigRow", 10, 14, "res/custom/ar2.png")
	GUI:setContentSize(leftBigRow, 22, 15)
	GUI:setIgnoreContentAdaptWithSize(leftBigRow, false)
	GUI:setAnchorPoint(leftBigRow, 0.00, 0.00)
	GUI:setTouchEnabled(leftBigRow, false)
	GUI:setTag(leftBigRow, 0)

	-- Create leftBtnList
	local leftBtnList = GUI:ListView_Create(leftBigImg, "leftBtnList", 4, -1, 114, 357, 1)
	GUI:ListView_setBounceEnabled(leftBtnList, true)
	GUI:ListView_setItemsMargin(leftBtnList, 4)
	GUI:setAnchorPoint(leftBtnList, 0.00, 1.00)
	GUI:setTouchEnabled(leftBtnList, true)
	GUI:setTag(leftBtnList, 0)

	-- Create rightBox1_1
	local rightBox1_1 = GUI:Image_Create(leftBtnList, "rightBox1_1", 0, 323, "res/custom/npc/z2.png")
	GUI:setContentSize(rightBox1_1, 114, 34)
	GUI:setIgnoreContentAdaptWithSize(rightBox1_1, false)
	GUI:setAnchorPoint(rightBox1_1, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox1_1, false)
	GUI:setTag(rightBox1_1, 0)

	-- Create rightBoxName1
	local rightBoxName1 = GUI:Text_Create(rightBox1_1, "rightBoxName1", 59, 18, 16, "#ffffff", [[黑金古人]])
	GUI:Text_enableOutline(rightBoxName1, "#000000", 1)
	GUI:setAnchorPoint(rightBoxName1, 0.50, 0.50)
	GUI:setTouchEnabled(rightBoxName1, false)
	GUI:setTag(rightBoxName1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(rightBox1_1, "Image_1", 0, 0, "res/custom/npc/z3.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create nowEquipNode
	local nowEquipNode = GUI:Node_Create(midNode, "nowEquipNode", 500, 388)
	GUI:setTag(nowEquipNode, 0)

	-- Create nowEquipName
	local nowEquipName = GUI:Text_Create(nowEquipNode, "nowEquipName", 0, 68, 16, "#00ff00", [[]])
	GUI:Text_enableOutline(nowEquipName, "#000000", 1)
	GUI:setAnchorPoint(nowEquipName, 0.50, 0.50)
	GUI:setTouchEnabled(nowEquipName, false)
	GUI:setTag(nowEquipName, 0)

	-- Create nowFM
	local nowFM = GUI:Text_Create(nowEquipNode, "nowFM", -54, -64, 16, "#bdbdb5", [[当前附魔:]])
	GUI:Text_enableOutline(nowFM, "#000000", 1)
	GUI:setAnchorPoint(nowFM, 0.00, 0.00)
	GUI:setTouchEnabled(nowFM, false)
	GUI:setTag(nowFM, 0)

	-- Create numberText
	local numberText = GUI:Text_Create(nowFM, "numberText", 74, 0, 16, "#00ff00", [[0]])
	GUI:Text_enableOutline(numberText, "#000000", 1)
	GUI:setAnchorPoint(numberText, 0.00, 0.00)
	GUI:setTouchEnabled(numberText, false)
	GUI:setTag(numberText, 0)

	-- Create stingText
	local stingText = GUI:Text_Create(nowFM, "stingText", 86, 0, 16, "#ffffff", [[/]])
	GUI:Text_enableOutline(stingText, "#000000", 1)
	GUI:setAnchorPoint(stingText, 0.00, 0.00)
	GUI:setTouchEnabled(stingText, false)
	GUI:setTag(stingText, 0)

	-- Create stingText_1
	local stingText_1 = GUI:Text_Create(nowFM, "stingText_1", 96, 0, 16, "#fe00fe", [[5]])
	GUI:Text_enableOutline(stingText_1, "#000000", 1)
	GUI:setAnchorPoint(stingText_1, 0.00, 0.00)
	GUI:setTouchEnabled(stingText_1, false)
	GUI:setTag(stingText_1, 0)

	-- Create infoNode
	local infoNode = GUI:Node_Create(midNode, "infoNode", 498, 241)
	GUI:setTag(infoNode, 0)
	GUI:setVisible(infoNode, false)

	-- Create infoList
	local infoList = GUI:ListView_Create(midNode, "infoList", 244, 230, 512, 46, 2)
	GUI:ListView_setClippingEnabled(infoList, false)
	GUI:ListView_setGravity(infoList, 3)
	GUI:ListView_setItemsMargin(infoList, 70)
	GUI:setAnchorPoint(infoList, 0.00, 0.00)
	GUI:setTouchEnabled(infoList, true)
	GUI:setTag(infoList, 0)

	-- Create infoBox1
	local infoBox1 = GUI:Image_Create(infoList, "infoBox1", 0, 0, "res/custom/npc/k0.png")
	GUI:Image_setScale9Slice(infoBox1, 6, 6, 20, 20)
	GUI:setContentSize(infoBox1, 46, 46)
	GUI:setIgnoreContentAdaptWithSize(infoBox1, false)
	GUI:setAnchorPoint(infoBox1, 0.00, 0.00)
	GUI:setTouchEnabled(infoBox1, false)
	GUI:setTag(infoBox1, 0)

	-- Create lockImg1
	local lockImg1 = GUI:Image_Create(infoBox1, "lockImg1", 23, 23, "res/custom/jpicon/1.png")
	GUI:setAnchorPoint(lockImg1, 0.50, 0.50)
	GUI:setTouchEnabled(lockImg1, false)
	GUI:setTag(lockImg1, 0)

	-- Create showItem1
	local showItem1 = GUI:ItemShow_Create(infoBox1, "showItem1", -6, -6, {index = 10604, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(showItem1, 0.00, 0.00)
	GUI:setTag(showItem1, 0)
	GUI:setVisible(showItem1, false)

	-- Create infoText11
	local infoText11 = GUI:Text_Create(showItem1, "infoText11", -12, -14, 15, "#ffffff", [[敏捷之印:+]])
	GUI:Text_enableOutline(infoText11, "#000000", 1)
	GUI:setAnchorPoint(infoText11, 0.00, 0.00)
	GUI:setTouchEnabled(infoText11, false)
	GUI:setTag(infoText11, 0)

	-- Create infoText12
	local infoText12 = GUI:Text_Create(showItem1, "infoText12", 62, -14, 15, "#ffff00", [[4]])
	GUI:Text_enableOutline(infoText12, "#000000", 1)
	GUI:setAnchorPoint(infoText12, 0.00, 0.00)
	GUI:setTouchEnabled(infoText12, false)
	GUI:setTag(infoText12, 0)

	-- Create noText1
	local noText1 = GUI:Text_Create(infoBox1, "noText1", -1, -24, 16, "#bdbdb5", [[未附魔]])
	GUI:Text_enableOutline(noText1, "#000000", 1)
	GUI:setAnchorPoint(noText1, 0.00, 0.00)
	GUI:setTouchEnabled(noText1, false)
	GUI:setTag(noText1, 0)

	-- Create infoBox2
	local infoBox2 = GUI:Image_Create(infoList, "infoBox2", 116, 0, "res/custom/npc/k0.png")
	GUI:Image_setScale9Slice(infoBox2, 6, 6, 20, 20)
	GUI:setContentSize(infoBox2, 46, 46)
	GUI:setIgnoreContentAdaptWithSize(infoBox2, false)
	GUI:setAnchorPoint(infoBox2, 0.00, 0.00)
	GUI:setTouchEnabled(infoBox2, false)
	GUI:setTag(infoBox2, 0)

	-- Create lockImg2
	local lockImg2 = GUI:Image_Create(infoBox2, "lockImg2", 23, 23, "res/custom/jpicon/1.png")
	GUI:setAnchorPoint(lockImg2, 0.50, 0.50)
	GUI:setTouchEnabled(lockImg2, false)
	GUI:setTag(lockImg2, 0)

	-- Create showItem2
	local showItem2 = GUI:ItemShow_Create(infoBox2, "showItem2", -6, -6, {index = 10604, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(showItem2, 0.00, 0.00)
	GUI:setTag(showItem2, 0)
	GUI:setVisible(showItem2, false)

	-- Create infoText21
	local infoText21 = GUI:Text_Create(showItem2, "infoText21", -12, -14, 15, "#ffffff", [[敏捷之印:+]])
	GUI:Text_enableOutline(infoText21, "#000000", 1)
	GUI:setAnchorPoint(infoText21, 0.00, 0.00)
	GUI:setTouchEnabled(infoText21, false)
	GUI:setTag(infoText21, 0)

	-- Create infoText22
	local infoText22 = GUI:Text_Create(showItem2, "infoText22", 62, -14, 15, "#ffff00", [[4]])
	GUI:Text_enableOutline(infoText22, "#000000", 1)
	GUI:setAnchorPoint(infoText22, 0.00, 0.00)
	GUI:setTouchEnabled(infoText22, false)
	GUI:setTag(infoText22, 0)

	-- Create noText2
	local noText2 = GUI:Text_Create(infoBox2, "noText2", -1, -24, 16, "#bdbdb5", [[未附魔]])
	GUI:Text_enableOutline(noText2, "#000000", 1)
	GUI:setAnchorPoint(noText2, 0.00, 0.00)
	GUI:setTouchEnabled(noText2, false)
	GUI:setTag(noText2, 0)

	-- Create infoBox3
	local infoBox3 = GUI:Image_Create(infoList, "infoBox3", 232, 0, "res/custom/npc/k0.png")
	GUI:Image_setScale9Slice(infoBox3, 6, 6, 20, 20)
	GUI:setContentSize(infoBox3, 46, 46)
	GUI:setIgnoreContentAdaptWithSize(infoBox3, false)
	GUI:setAnchorPoint(infoBox3, 0.00, 0.00)
	GUI:setTouchEnabled(infoBox3, false)
	GUI:setTag(infoBox3, 0)

	-- Create lockImg3
	local lockImg3 = GUI:Image_Create(infoBox3, "lockImg3", 23, 23, "res/custom/jpicon/1.png")
	GUI:setAnchorPoint(lockImg3, 0.50, 0.50)
	GUI:setTouchEnabled(lockImg3, false)
	GUI:setTag(lockImg3, 0)

	-- Create showItem3
	local showItem3 = GUI:ItemShow_Create(infoBox3, "showItem3", -6, -6, {index = 10604, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(showItem3, 0.00, 0.00)
	GUI:setTag(showItem3, 0)
	GUI:setVisible(showItem3, false)

	-- Create infoText31
	local infoText31 = GUI:Text_Create(showItem3, "infoText31", -12, -14, 15, "#ffffff", [[敏捷之印:+]])
	GUI:Text_enableOutline(infoText31, "#000000", 1)
	GUI:setAnchorPoint(infoText31, 0.00, 0.00)
	GUI:setTouchEnabled(infoText31, false)
	GUI:setTag(infoText31, 0)

	-- Create infoText32
	local infoText32 = GUI:Text_Create(showItem3, "infoText32", 62, -14, 15, "#ffff00", [[4]])
	GUI:Text_enableOutline(infoText32, "#000000", 1)
	GUI:setAnchorPoint(infoText32, 0.00, 0.00)
	GUI:setTouchEnabled(infoText32, false)
	GUI:setTag(infoText32, 0)

	-- Create noText3
	local noText3 = GUI:Text_Create(infoBox3, "noText3", -1, -24, 16, "#bdbdb5", [[未附魔]])
	GUI:Text_enableOutline(noText3, "#000000", 1)
	GUI:setAnchorPoint(noText3, 0.00, 0.00)
	GUI:setTouchEnabled(noText3, false)
	GUI:setTag(noText3, 0)

	-- Create infoBox4
	local infoBox4 = GUI:Image_Create(infoList, "infoBox4", 348, 0, "res/custom/npc/k0.png")
	GUI:Image_setScale9Slice(infoBox4, 6, 6, 20, 20)
	GUI:setContentSize(infoBox4, 46, 46)
	GUI:setIgnoreContentAdaptWithSize(infoBox4, false)
	GUI:setAnchorPoint(infoBox4, 0.00, 0.00)
	GUI:setTouchEnabled(infoBox4, false)
	GUI:setTag(infoBox4, 0)

	-- Create lockImg4
	local lockImg4 = GUI:Image_Create(infoBox4, "lockImg4", 23, 23, "res/custom/jpicon/1.png")
	GUI:setAnchorPoint(lockImg4, 0.50, 0.50)
	GUI:setTouchEnabled(lockImg4, false)
	GUI:setTag(lockImg4, 0)

	-- Create showItem4
	local showItem4 = GUI:ItemShow_Create(infoBox4, "showItem4", -6, -6, {index = 10604, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(showItem4, 0.00, 0.00)
	GUI:setTag(showItem4, 0)
	GUI:setVisible(showItem4, false)

	-- Create infoText41
	local infoText41 = GUI:Text_Create(showItem4, "infoText41", -12, -14, 15, "#ffffff", [[敏捷之印:+]])
	GUI:Text_enableOutline(infoText41, "#000000", 1)
	GUI:setAnchorPoint(infoText41, 0.00, 0.00)
	GUI:setTouchEnabled(infoText41, false)
	GUI:setTag(infoText41, 0)

	-- Create infoText42
	local infoText42 = GUI:Text_Create(showItem4, "infoText42", 62, -14, 15, "#ffff00", [[4]])
	GUI:Text_enableOutline(infoText42, "#000000", 1)
	GUI:setAnchorPoint(infoText42, 0.00, 0.00)
	GUI:setTouchEnabled(infoText42, false)
	GUI:setTag(infoText42, 0)

	-- Create noText4
	local noText4 = GUI:Text_Create(infoBox4, "noText4", -1, -24, 16, "#bdbdb5", [[未附魔]])
	GUI:Text_enableOutline(noText4, "#000000", 1)
	GUI:setAnchorPoint(noText4, 0.00, 0.00)
	GUI:setTouchEnabled(noText4, false)
	GUI:setTag(noText4, 0)

	-- Create infoBox5
	local infoBox5 = GUI:Image_Create(infoList, "infoBox5", 464, 0, "res/custom/npc/k0.png")
	GUI:Image_setScale9Slice(infoBox5, 6, 6, 20, 20)
	GUI:setContentSize(infoBox5, 46, 46)
	GUI:setIgnoreContentAdaptWithSize(infoBox5, false)
	GUI:setAnchorPoint(infoBox5, 0.00, 0.00)
	GUI:setTouchEnabled(infoBox5, false)
	GUI:setTag(infoBox5, 0)

	-- Create lockImg5
	local lockImg5 = GUI:Image_Create(infoBox5, "lockImg5", 23, 23, "res/custom/jpicon/1.png")
	GUI:setAnchorPoint(lockImg5, 0.50, 0.50)
	GUI:setTouchEnabled(lockImg5, false)
	GUI:setTag(lockImg5, 0)

	-- Create showItem5
	local showItem5 = GUI:ItemShow_Create(infoBox5, "showItem5", -6, -6, {index = 10604, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(showItem5, 0.00, 0.00)
	GUI:setTag(showItem5, 0)
	GUI:setVisible(showItem5, false)

	-- Create infoText51
	local infoText51 = GUI:Text_Create(showItem5, "infoText51", -12, -14, 15, "#ffffff", [[敏捷之印:+]])
	GUI:Text_enableOutline(infoText51, "#000000", 1)
	GUI:setAnchorPoint(infoText51, 0.00, 0.00)
	GUI:setTouchEnabled(infoText51, false)
	GUI:setTag(infoText51, 0)

	-- Create infoText52
	local infoText52 = GUI:Text_Create(showItem5, "infoText52", 62, -14, 15, "#ffff00", [[4]])
	GUI:Text_enableOutline(infoText52, "#000000", 1)
	GUI:setAnchorPoint(infoText52, 0.00, 0.00)
	GUI:setTouchEnabled(infoText52, false)
	GUI:setTag(infoText52, 0)

	-- Create noText5
	local noText5 = GUI:Text_Create(infoBox5, "noText5", -1, -24, 16, "#bdbdb5", [[未附魔]])
	GUI:Text_enableOutline(noText5, "#000000", 1)
	GUI:setAnchorPoint(noText5, 0.00, 0.00)
	GUI:setTouchEnabled(noText5, false)
	GUI:setTag(noText5, 0)

	-- Create RichText1
	local RichText1 = GUI:RichText_Create(midNode, "RichText1", 200, 92, [[<font color='#ff0000' size='17' >专属附魔说明：</font><br><font color='#ffffff' size='17' >只有</font><font color='#ff9b00' size='17' >“白日门专属”</font><font color='#ffffff' size='17' >才可以进行附魔</font><br><font color='#ffffff' size='17' >如果你对当前专属装备附魔属性不满意</font><br><font color='#ffffff' size='17' >可在此重置此专属装备的附魔属性！</font>]], 400, 16, "#ff0000", 4)
	GUI:setAnchorPoint(RichText1, 0.00, 0.00)
	GUI:setTag(RichText1, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(midNode, "needItemNode", 592, 128)
	GUI:setTag(needItemNode, 0)

	-- Create RichText2
	local RichText2 = GUI:RichText_Create(midNode, "RichText2", 76, 45, [==========[<font color='#ffffff' size='16' >提示：专属附魔所需的</font><font color='#00ff00' size='16' >[材料与道具]</font><font color='#ffffff' size='16' >在</font><font color='#00ff00' size='16' >[任意地图怪物]</font><font color='#ffffff' size='16' >均有几率爆出！</font>]==========], 520, 16, "#ff0000", 4)
	GUI:setAnchorPoint(RichText2, 0.00, 0.00)
	GUI:setTag(RichText2, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midNode, "upBtn", 732, 124, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn, 0, 0, 0, 0)
	GUI:setContentSize(upBtn, 110, 40)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开始附魔]])
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
