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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/25bwqh/main.png")
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

	-- Create leftBigImg
	local leftBigImg = GUI:Image_Create(FrameLayout, "leftBigImg", 133, 462, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBigImg, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBigImg, false)
	GUI:setAnchorPoint(leftBigImg, 0.50, 0.50)
	GUI:setTouchEnabled(leftBigImg, false)
	GUI:setTag(leftBigImg, 0)

	-- Create leftBigName
	local leftBigName = GUI:Text_Create(leftBigImg, "leftBigName", 70, 20, 18, "#ffffff", [[部位强化]])
	GUI:Text_enableOutline(leftBigName, "#000000", 1)
	GUI:setAnchorPoint(leftBigName, 0.50, 0.50)
	GUI:setTouchEnabled(leftBigName, false)
	GUI:setTag(leftBigName, 0)

	-- Create leftBigRow
	local leftBigRow = GUI:Image_Create(leftBigImg, "leftBigRow", 10, 12, "res/custom/ad.png")
	GUI:setContentSize(leftBigRow, 18, 20)
	GUI:setIgnoreContentAdaptWithSize(leftBigRow, false)
	GUI:setAnchorPoint(leftBigRow, 0.00, 0.00)
	GUI:setTouchEnabled(leftBigRow, false)
	GUI:setTag(leftBigRow, 0)

	-- Create leftBtnList
	local leftBtnList = GUI:ListView_Create(leftBigImg, "leftBtnList", 4, 0, 114, 402, 1)
	GUI:ListView_setBounceEnabled(leftBtnList, true)
	GUI:ListView_setItemsMargin(leftBtnList, 4)
	GUI:setAnchorPoint(leftBtnList, 0.00, 1.00)
	GUI:setTouchEnabled(leftBtnList, true)
	GUI:setTag(leftBtnList, 0)

	-- Create leftBox1
	local leftBox1 = GUI:Image_Create(leftBtnList, "leftBox1", 0, 368, "res/custom/npc/z2.png")
	GUI:setContentSize(leftBox1, 114, 34)
	GUI:setIgnoreContentAdaptWithSize(leftBox1, false)
	GUI:setAnchorPoint(leftBox1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox1, false)
	GUI:setTag(leftBox1, 0)

	-- Create equipType1
	local equipType1 = GUI:Text_Create(leftBox1, "equipType1", 42, 16, 16, "#ffffff", [[衣服]])
	GUI:Text_enableOutline(equipType1, "#000000", 1)
	GUI:setAnchorPoint(equipType1, 0.50, 0.50)
	GUI:setTouchEnabled(equipType1, false)
	GUI:setTag(equipType1, 0)

	-- Create equipStar1
	local equipStar1 = GUI:Image_Create(equipType1, "equipStar1", 36, 5, "res/custom/npc/25bwqh/xx15.png")
	GUI:setContentSize(equipStar1, 32, 14)
	GUI:setIgnoreContentAdaptWithSize(equipStar1, false)
	GUI:setAnchorPoint(equipStar1, 0.00, 0.00)
	GUI:setTouchEnabled(equipStar1, false)
	GUI:setTag(equipStar1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(leftBox1, "Image_1", 0, 0, "res/custom/npc/z3.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)
	GUI:setVisible(Image_1, false)

	-- Create rightBox1_1
	local rightBox1_1 = GUI:Image_Create(leftBtnList, "rightBox1_1", 0, 330, "res/custom/npc/z2.png")
	GUI:setContentSize(rightBox1_1, 114, 34)
	GUI:setIgnoreContentAdaptWithSize(rightBox1_1, false)
	GUI:setAnchorPoint(rightBox1_1, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox1_1, false)
	GUI:setTag(rightBox1_1, 0)

	-- Create rightBoxName1
	local rightBoxName1 = GUI:Text_Create(rightBox1_1, "rightBoxName1", 58, 16, 16, "#ffffff", [[文本]])
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

	-- Create nowStarBg
	local nowStarBg = GUI:Image_Create(midNode, "nowStarBg", 420, 434, "res/custom/npc/25bwqh/bwx.png")
	GUI:setContentSize(nowStarBg, 162, 38)
	GUI:setIgnoreContentAdaptWithSize(nowStarBg, false)
	GUI:setAnchorPoint(nowStarBg, 0.00, 0.00)
	GUI:setTouchEnabled(nowStarBg, false)
	GUI:setTag(nowStarBg, 0)

	-- Create starText
	local starText = GUI:Text_Create(nowStarBg, "starText", 100, 18, 16, "#00fdfd", [[???]])
	GUI:Text_enableOutline(starText, "#000000", 1)
	GUI:setAnchorPoint(starText, 0.50, 0.50)
	GUI:setTouchEnabled(starText, false)
	GUI:setTag(starText, 0)

	-- Create nowEquipBg
	local nowEquipBg = GUI:Image_Create(nowStarBg, "nowEquipBg", 80, -46, "res/custom/npc/25bwqh/bwk.png")
	GUI:setContentSize(nowEquipBg, 78, 72)
	GUI:setIgnoreContentAdaptWithSize(nowEquipBg, false)
	GUI:setAnchorPoint(nowEquipBg, 0.50, 0.50)
	GUI:setTouchEnabled(nowEquipBg, false)
	GUI:setTag(nowEquipBg, 0)

	-- Create infoImg1
	local infoImg1 = GUI:Image_Create(midNode, "infoImg1", 286, 359, "res/custom/npc/25bwqh/sxbg.png")
	GUI:setContentSize(infoImg1, 138, 212)
	GUI:setIgnoreContentAdaptWithSize(infoImg1, false)
	GUI:setAnchorPoint(infoImg1, 0.50, 0.50)
	GUI:setTouchEnabled(infoImg1, false)
	GUI:setTag(infoImg1, 0)

	-- Create infoTitle1
	local infoTitle1 = GUI:Image_Create(infoImg1, "infoTitle1", 36, 180, "res/custom/npc/25bwqh/t1.png")
	GUI:setAnchorPoint(infoTitle1, 0.00, 0.00)
	GUI:setTouchEnabled(infoTitle1, false)
	GUI:setTag(infoTitle1, 0)

	-- Create infoTextNode1
	local infoTextNode1 = GUI:Node_Create(infoImg1, "infoTextNode1", 72, 120)
	GUI:setTag(infoTextNode1, 0)
	GUI:setVisible(infoTextNode1, false)

	-- Create text111
	local text111 = GUI:Text_Create(infoTextNode1, "text111", 0, 0, 16, "#ff7700", [[生命值：]])
	GUI:Text_enableOutline(text111, "#000000", 1)
	GUI:setAnchorPoint(text111, 0.00, 0.00)
	GUI:setTouchEnabled(text111, false)
	GUI:setTag(text111, 0)

	-- Create text112
	local text112 = GUI:Text_Create(text111, "text112", 60, 0, 16, "#00ff00", [[+1%]])
	GUI:Text_enableOutline(text112, "#000000", 1)
	GUI:setAnchorPoint(text112, 0.00, 0.00)
	GUI:setTouchEnabled(text112, false)
	GUI:setTag(text112, 0)

	-- Create text121
	local text121 = GUI:Text_Create(infoTextNode1, "text121", 0, 0, 16, "#ff7700", [[伤害减少：]])
	GUI:Text_enableOutline(text121, "#000000", 1)
	GUI:setAnchorPoint(text121, 0.00, 0.00)
	GUI:setTouchEnabled(text121, false)
	GUI:setTag(text121, 0)

	-- Create text122
	local text122 = GUI:Text_Create(text121, "text122", 74, 0, 16, "#00ff00", [[+1%]])
	GUI:Text_enableOutline(text122, "#000000", 1)
	GUI:setAnchorPoint(text122, 0.00, 0.00)
	GUI:setTouchEnabled(text122, false)
	GUI:setTag(text122, 0)

	-- Create infoText_11
	local infoText_11 = GUI:Text_Create(infoImg1, "infoText_11", 72, 154, 16, "#ff7700", [[装备威力提升]])
	GUI:Text_enableOutline(infoText_11, "#000000", 1)
	GUI:setAnchorPoint(infoText_11, 0.50, 0.50)
	GUI:setTouchEnabled(infoText_11, false)
	GUI:setTag(infoText_11, 0)

	-- Create infoText_12
	local infoText_12 = GUI:Text_Create(infoImg1, "infoText_12", 56, 110, 16, "#ff7700", [[加成：]])
	GUI:Text_enableOutline(infoText_12, "#000000", 1)
	GUI:setAnchorPoint(infoText_12, 0.50, 0.50)
	GUI:setTouchEnabled(infoText_12, false)
	GUI:setTag(infoText_12, 0)

	-- Create infoText_13
	local infoText_13 = GUI:Text_Create(infoText_12, "infoText_13", 46, 0, 16, "#00ff00", [[+0%]])
	GUI:Text_enableOutline(infoText_13, "#000000", 1)
	GUI:setAnchorPoint(infoText_13, 0.00, 0.00)
	GUI:setTouchEnabled(infoText_13, false)
	GUI:setTag(infoText_13, 0)

	-- Create infoImg2
	local infoImg2 = GUI:Image_Create(midNode, "infoImg2", 718, 359, "res/custom/npc/25bwqh/sxbg.png")
	GUI:setContentSize(infoImg2, 138, 212)
	GUI:setIgnoreContentAdaptWithSize(infoImg2, false)
	GUI:setAnchorPoint(infoImg2, 0.50, 0.50)
	GUI:setTouchEnabled(infoImg2, false)
	GUI:setTag(infoImg2, 0)

	-- Create infoTitle2
	local infoTitle2 = GUI:Image_Create(infoImg2, "infoTitle2", 36, 180, "res/custom/npc/25bwqh/t2.png")
	GUI:setAnchorPoint(infoTitle2, 0.00, 0.00)
	GUI:setTouchEnabled(infoTitle2, false)
	GUI:setTag(infoTitle2, 0)

	-- Create infoTextNode2
	local infoTextNode2 = GUI:Node_Create(infoImg2, "infoTextNode2", 72, 120)
	GUI:setTag(infoTextNode2, 0)
	GUI:setVisible(infoTextNode2, false)

	-- Create text211
	local text211 = GUI:Text_Create(infoTextNode2, "text211", 0, 0, 16, "#ff7700", [[生命值：]])
	GUI:Text_enableOutline(text211, "#000000", 1)
	GUI:setAnchorPoint(text211, 0.00, 0.00)
	GUI:setTouchEnabled(text211, false)
	GUI:setTag(text211, 0)

	-- Create text212
	local text212 = GUI:Text_Create(text211, "text212", 60, 0, 16, "#00ff00", [[+1%]])
	GUI:Text_enableOutline(text212, "#000000", 1)
	GUI:setAnchorPoint(text212, 0.00, 0.00)
	GUI:setTouchEnabled(text212, false)
	GUI:setTag(text212, 0)

	-- Create text221
	local text221 = GUI:Text_Create(infoTextNode2, "text221", 0, 0, 16, "#ff7700", [[伤害减少：]])
	GUI:Text_enableOutline(text221, "#000000", 1)
	GUI:setAnchorPoint(text221, 0.00, 0.00)
	GUI:setTouchEnabled(text221, false)
	GUI:setTag(text221, 0)

	-- Create text222
	local text222 = GUI:Text_Create(text221, "text222", 74, 0, 16, "#00ff00", [[+1%]])
	GUI:Text_enableOutline(text222, "#000000", 1)
	GUI:setAnchorPoint(text222, 0.00, 0.00)
	GUI:setTouchEnabled(text222, false)
	GUI:setTag(text222, 0)

	-- Create infoText_21
	local infoText_21 = GUI:Text_Create(infoImg2, "infoText_21", 72, 154, 16, "#ff7700", [[装备威力提升]])
	GUI:Text_enableOutline(infoText_21, "#000000", 1)
	GUI:setAnchorPoint(infoText_21, 0.50, 0.50)
	GUI:setTouchEnabled(infoText_21, false)
	GUI:setTag(infoText_21, 0)

	-- Create infoText_22
	local infoText_22 = GUI:Text_Create(infoImg2, "infoText_22", 56, 110, 16, "#ff7700", [[加成：]])
	GUI:Text_enableOutline(infoText_22, "#000000", 1)
	GUI:setAnchorPoint(infoText_22, 0.50, 0.50)
	GUI:setTouchEnabled(infoText_22, false)
	GUI:setTag(infoText_22, 0)

	-- Create infoText_23
	local infoText_23 = GUI:Text_Create(infoText_22, "infoText_23", 46, 0, 16, "#00ff00", [[+0%]])
	GUI:Text_enableOutline(infoText_23, "#000000", 1)
	GUI:setAnchorPoint(infoText_23, 0.00, 0.00)
	GUI:setTouchEnabled(infoText_23, false)
	GUI:setTag(infoText_23, 0)

	-- Create needItemBg
	local needItemBg = GUI:Image_Create(midNode, "needItemBg", 504, 252, "res/custom/npc/25bwqh/xbg.png")
	GUI:setAnchorPoint(needItemBg, 0.50, 0.50)
	GUI:setTouchEnabled(needItemBg, false)
	GUI:setTag(needItemBg, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(needItemBg, "needItemNode", 242, 36)
	GUI:setTag(needItemNode, 0)

	-- Create oddImg
	local oddImg = GUI:Image_Create(needItemBg, "oddImg", 162, 108, "res/custom/npc/25bwqh/dq.png")
	GUI:setContentSize(oddImg, 156, 30)
	GUI:setIgnoreContentAdaptWithSize(oddImg, false)
	GUI:setAnchorPoint(oddImg, 0.00, 0.00)
	GUI:setTouchEnabled(oddImg, false)
	GUI:setTag(oddImg, 0)

	-- Create oddText
	local oddText = GUI:Text_Create(oddImg, "oddText", 80, 14, 16, "#00ff00", [[强化成功率:???]])
	GUI:Text_enableOutline(oddText, "#000000", 1)
	GUI:setAnchorPoint(oddText, 0.50, 0.50)
	GUI:setTouchEnabled(oddText, false)
	GUI:setTag(oddText, 0)

	-- Create suitBtn
	local suitBtn = GUI:Button_Create(needItemBg, "suitBtn", -22, 32, "res/custom/npc/wenhao.png")
	GUI:setContentSize(suitBtn, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(suitBtn, false)
	GUI:Button_setTitleText(suitBtn, [[]])
	GUI:Button_setTitleColor(suitBtn, "#ffffff")
	GUI:Button_setTitleFontSize(suitBtn, 16)
	GUI:Button_titleEnableOutline(suitBtn, "#000000", 1)
	GUI:setAnchorPoint(suitBtn, 0.50, 0.50)
	GUI:setScale(suitBtn, 1.20)
	GUI:setTouchEnabled(suitBtn, true)
	GUI:setTag(suitBtn, 0)

	-- Create suitBtnText
	local suitBtnText = GUI:Text_Create(needItemBg, "suitBtnText", 4, 22, 16, "#ffff00", [[强化套装属性?]])
	GUI:Text_enableOutline(suitBtnText, "#000000", 1)
	GUI:Text_enableUnderline(suitBtnText)
	GUI:setAnchorPoint(suitBtnText, 0.00, 0.00)
	GUI:setTouchEnabled(suitBtnText, true)
	GUI:setTag(suitBtnText, 0)

	-- Create oddBtn
	local oddBtn = GUI:Button_Create(needItemBg, "oddBtn", 406, 32, "res/custom/npc/wenhao.png")
	GUI:setContentSize(oddBtn, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(oddBtn, false)
	GUI:Button_setTitleText(oddBtn, [[]])
	GUI:Button_setTitleColor(oddBtn, "#ffffff")
	GUI:Button_setTitleFontSize(oddBtn, 16)
	GUI:Button_titleEnableOutline(oddBtn, "#000000", 1)
	GUI:setAnchorPoint(oddBtn, 0.50, 0.50)
	GUI:setScale(oddBtn, 1.20)
	GUI:setTouchEnabled(oddBtn, true)
	GUI:setTag(oddBtn, 0)

	-- Create oddBtnText
	local oddBtnText = GUI:Text_Create(needItemBg, "oddBtnText", 432, 22, 16, "#ffff00", [[强化成功率?]])
	GUI:Text_enableOutline(oddBtnText, "#000000", 1)
	GUI:Text_enableUnderline(oddBtnText)
	GUI:setAnchorPoint(oddBtnText, 0.00, 0.00)
	GUI:setTouchEnabled(oddBtnText, true)
	GUI:setTag(oddBtnText, 0)

	-- Create tipsImg
	local tipsImg = GUI:Image_Create(midNode, "tipsImg", 206, 170, "res/custom/npc/25bwqh/gz.png")
	GUI:setContentSize(tipsImg, 94, 20)
	GUI:setIgnoreContentAdaptWithSize(tipsImg, false)
	GUI:setAnchorPoint(tipsImg, 0.00, 0.00)
	GUI:setTouchEnabled(tipsImg, false)
	GUI:setTag(tipsImg, 0)

	-- Create RichText1
	local RichText1 = GUI:RichText_Create(tipsImg, "RichText1", -2, -58, [[<font color='#ffffff' size='16' >1.强化获得的属性加成</font><font color='#00ff00' size='16' >绑定部位</font><font color='#ffffff' size='16' >，跟随人物。</font><br><font color='#ffffff' size='16' >2.每个部位最高强化</font><font color='#ddaaff' size='16' >+15星</font><font color='#ffffff' size='16' >，强化会</font><font color='#ff0000' size='16' >失败</font><font color='#ffffff' size='16' >或</font><font color='#ff0000' size='16' >降级</font><font color='#ffffff' size='16' >。</font>]], 450, 16, "#ff0000", 4)
	GUI:setAnchorPoint(RichText1, 0.00, 0.00)
	GUI:setTag(RichText1, 0)

	-- Create RichText2
	local RichText2 = GUI:RichText_Create(tipsImg, "RichText2", -6, -126, [==========[<font color='#ffffff' size='16' >提示：部位强化所需的</font><font color='#00ff00' size='16' >[材料与道具]</font><font color='#ffffff' size='16' >在</font><font color='#00ff00' size='16' >[任意地图怪物]</font><font color='#ffffff' size='16' >均有几率爆出！</font>]==========], 520, 16, "#ff0000", 4)
	GUI:setAnchorPoint(RichText2, 0.00, 0.00)
	GUI:setTag(RichText2, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(tipsImg, "upBtn", 512, -38, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:setContentSize(upBtn, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开始强化]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create luckBtn
	local luckBtn = GUI:Button_Create(tipsImg, "luckBtn", 456, -62, "res/custom/npc/g0.png")
	GUI:setContentSize(luckBtn, 24, 24)
	GUI:setIgnoreContentAdaptWithSize(luckBtn, false)
	GUI:Button_setTitleText(luckBtn, [[]])
	GUI:Button_setTitleColor(luckBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(luckBtn, 18)
	GUI:Button_titleEnableOutline(luckBtn, "#000000", 1)
	GUI:setAnchorPoint(luckBtn, 0.50, 0.50)
	GUI:setTouchEnabled(luckBtn, true)
	GUI:setTag(luckBtn, 0)
	GUI:setVisible(luckBtn, false)

	-- Create luckText
	local luckText = GUI:Text_Create(luckBtn, "luckText", 30, 0, 16, "#f0b42a", [==========[开启[强化增幅]]==========])
	GUI:Text_enableOutline(luckText, "#000000", 1)
	GUI:setAnchorPoint(luckText, 0.00, 0.00)
	GUI:setTouchEnabled(luckText, false)
	GUI:setTag(luckText, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
