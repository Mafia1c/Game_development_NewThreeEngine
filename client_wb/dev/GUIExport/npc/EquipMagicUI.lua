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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/33teshu/bg.png")
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
	local leftBtnList = GUI:ListView_Create(FrameLayout, "leftBtnList", 73, 482, 120, 440, 1)
	GUI:ListView_setItemsMargin(leftBtnList, 2)
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
	local Image_5 = GUI:Image_Create(leftBtnList, "Image_5", 0, 350, "res/custom/npc/ta0.png")
	GUI:setContentSize(Image_5, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Image_5, false)
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create equipNode
	local equipNode = GUI:Node_Create(midNode, "equipNode", 0, 0)
	GUI:setTag(equipNode, 0)

	-- Create nowEquip
	local nowEquip = GUI:ItemShow_Create(equipNode, "nowEquip", 499, 396, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(nowEquip, 0.50, 0.50)
	GUI:setTag(nowEquip, 0)

	-- Create equipName
	local equipName = GUI:Text_Create(equipNode, "equipName", 500, 334, 16, "#ff0000", [[]])
	GUI:Text_enableOutline(equipName, "#000000", 1)
	GUI:setAnchorPoint(equipName, 0.50, 0.50)
	GUI:setTouchEnabled(equipName, false)
	GUI:setTag(equipName, 0)

	-- Create tipsBtn1
	local tipsBtn1 = GUI:Button_Create(equipNode, "tipsBtn1", 306, 227, "res/custom/npc/33teshu/0_1.png")
	GUI:setContentSize(tipsBtn1, 62, 62)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn1, false)
	GUI:Button_setTitleText(tipsBtn1, [[]])
	GUI:Button_setTitleColor(tipsBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn1, 16)
	GUI:Button_titleEnableOutline(tipsBtn1, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn1, true)
	GUI:setTag(tipsBtn1, 0)

	-- Create tipsBtn2
	local tipsBtn2 = GUI:Button_Create(equipNode, "tipsBtn2", 386, 227, "res/custom/npc/33teshu/0_1.png")
	GUI:setContentSize(tipsBtn2, 62, 62)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn2, false)
	GUI:Button_setTitleText(tipsBtn2, [[]])
	GUI:Button_setTitleColor(tipsBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn2, 16)
	GUI:Button_titleEnableOutline(tipsBtn2, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn2, true)
	GUI:setTag(tipsBtn2, 0)

	-- Create tipsBtn3
	local tipsBtn3 = GUI:Button_Create(equipNode, "tipsBtn3", 466, 227, "res/custom/npc/33teshu/0_1.png")
	GUI:setContentSize(tipsBtn3, 62, 62)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn3, false)
	GUI:Button_setTitleText(tipsBtn3, [[]])
	GUI:Button_setTitleColor(tipsBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn3, 16)
	GUI:Button_titleEnableOutline(tipsBtn3, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn3, true)
	GUI:setTag(tipsBtn3, 0)

	-- Create tipsBtn4
	local tipsBtn4 = GUI:Button_Create(equipNode, "tipsBtn4", 546, 227, "res/custom/npc/33teshu/0_1.png")
	GUI:setContentSize(tipsBtn4, 62, 62)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn4, false)
	GUI:Button_setTitleText(tipsBtn4, [[]])
	GUI:Button_setTitleColor(tipsBtn4, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn4, 16)
	GUI:Button_titleEnableOutline(tipsBtn4, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn4, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn4, true)
	GUI:setTag(tipsBtn4, 0)

	-- Create tipsBtn5
	local tipsBtn5 = GUI:Button_Create(equipNode, "tipsBtn5", 626, 227, "res/custom/npc/33teshu/0_1.png")
	GUI:setContentSize(tipsBtn5, 62, 62)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn5, false)
	GUI:Button_setTitleText(tipsBtn5, [[]])
	GUI:Button_setTitleColor(tipsBtn5, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn5, 16)
	GUI:Button_titleEnableOutline(tipsBtn5, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn5, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn5, true)
	GUI:setTag(tipsBtn5, 0)

	-- Create infoNode1
	local infoNode1 = GUI:Node_Create(midNode, "infoNode1", 304, 380)
	GUI:setTag(infoNode1, 0)

	-- Create text111
	local text111 = GUI:Text_Create(infoNode1, "text111", 0, 0, 16, "#00ff00", [[攻魔道：]])
	GUI:Text_enableOutline(text111, "#000000", 1)
	GUI:setAnchorPoint(text111, 0.00, 0.00)
	GUI:setTouchEnabled(text111, false)
	GUI:setTag(text111, 0)

	-- Create text112
	local text112 = GUI:Text_Create(text111, "text112", 64, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text112, "#000000", 1)
	GUI:setAnchorPoint(text112, 0.00, 0.00)
	GUI:setTouchEnabled(text112, false)
	GUI:setTag(text112, 0)

	-- Create text121
	local text121 = GUI:Text_Create(infoNode1, "text121", 0, 0, 16, "#00ff00", [[防魔御：]])
	GUI:Text_enableOutline(text121, "#000000", 1)
	GUI:setAnchorPoint(text121, 0.00, 0.00)
	GUI:setTouchEnabled(text121, false)
	GUI:setTag(text121, 0)

	-- Create text122
	local text122 = GUI:Text_Create(text121, "text122", 64, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text122, "#000000", 1)
	GUI:setAnchorPoint(text122, 0.00, 0.00)
	GUI:setTouchEnabled(text122, false)
	GUI:setTag(text122, 0)

	-- Create text131
	local text131 = GUI:Text_Create(infoNode1, "text131", 0, 0, 16, "#ff00ff", [[对道增伤：]])
	GUI:Text_enableOutline(text131, "#000000", 1)
	GUI:setAnchorPoint(text131, 0.00, 0.00)
	GUI:setTouchEnabled(text131, false)
	GUI:setTag(text131, 0)

	-- Create text132
	local text132 = GUI:Text_Create(text131, "text132", 80, 0, 16, "#ff00ff", [[2%]])
	GUI:Text_enableOutline(text132, "#000000", 1)
	GUI:setAnchorPoint(text132, 0.00, 0.00)
	GUI:setTouchEnabled(text132, false)
	GUI:setTag(text132, 0)

	-- Create infoNode2
	local infoNode2 = GUI:Node_Create(midNode, "infoNode2", 698, 380)
	GUI:setTag(infoNode2, 0)

	-- Create text211
	local text211 = GUI:Text_Create(infoNode2, "text211", 0, 0, 16, "#00ff00", [[攻魔道：]])
	GUI:Text_enableOutline(text211, "#000000", 1)
	GUI:setAnchorPoint(text211, 0.00, 0.00)
	GUI:setTouchEnabled(text211, false)
	GUI:setTag(text211, 0)

	-- Create text212
	local text212 = GUI:Text_Create(text211, "text212", 64, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text212, "#000000", 1)
	GUI:setAnchorPoint(text212, 0.00, 0.00)
	GUI:setTouchEnabled(text212, false)
	GUI:setTag(text212, 0)

	-- Create text221
	local text221 = GUI:Text_Create(infoNode2, "text221", 0, 0, 16, "#00ff00", [[防魔御：]])
	GUI:Text_enableOutline(text221, "#000000", 1)
	GUI:setAnchorPoint(text221, 0.00, 0.00)
	GUI:setTouchEnabled(text221, false)
	GUI:setTag(text221, 0)

	-- Create text222
	local text222 = GUI:Text_Create(text221, "text222", 64, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text222, "#000000", 1)
	GUI:setAnchorPoint(text222, 0.00, 0.00)
	GUI:setTouchEnabled(text222, false)
	GUI:setTag(text222, 0)

	-- Create text231
	local text231 = GUI:Text_Create(infoNode2, "text231", 0, 0, 16, "#ff00ff", [[对道增伤：]])
	GUI:Text_enableOutline(text231, "#000000", 1)
	GUI:setAnchorPoint(text231, 0.00, 0.00)
	GUI:setTouchEnabled(text231, false)
	GUI:setTag(text231, 0)

	-- Create text232
	local text232 = GUI:Text_Create(text231, "text232", 80, 0, 16, "#ff00ff", [[2%]])
	GUI:Text_enableOutline(text232, "#000000", 1)
	GUI:setAnchorPoint(text232, 0.00, 0.00)
	GUI:setTouchEnabled(text232, false)
	GUI:setTag(text232, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(midNode, "needItemNode", 496, 158)
	GUI:setTag(needItemNode, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midNode, "upBtn", 500, 60, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn, 0, 0, 0, 0)
	GUI:setContentSize(upBtn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[附魔]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create oddTag
	local oddTag = GUI:Text_Create(midNode, "oddTag", 294, 88, 16, "#ffffff", [[成功率：]])
	GUI:Text_enableOutline(oddTag, "#000000", 1)
	GUI:setAnchorPoint(oddTag, 0.00, 0.00)
	GUI:setTouchEnabled(oddTag, false)
	GUI:setTag(oddTag, 0)

	-- Create oddText
	local oddText = GUI:Text_Create(oddTag, "oddText", 92, 0, 16, "#00ff00", [[20%]])
	GUI:Text_enableOutline(oddText, "#000000", 1)
	GUI:setAnchorPoint(oddText, 1.00, 0.00)
	GUI:setTouchEnabled(oddText, false)
	GUI:setTag(oddText, 0)

	-- Create subOddText
	local subOddText = GUI:Text_Create(oddTag, "subOddText", 100, 0, 16, "#ffff00", [[(降级概率：0%，附魔10星后失败几率降级)]])
	GUI:Text_enableOutline(subOddText, "#000000", 1)
	GUI:setAnchorPoint(subOddText, 0.00, 0.00)
	GUI:setTouchEnabled(subOddText, false)
	GUI:setTag(subOddText, 0)

	-- Create maxImg
	local maxImg = GUI:Image_Create(midNode, "maxImg", 496, 160, "res/custom/tag/c_103.png")
	GUI:setContentSize(maxImg, 114, 66)
	GUI:setIgnoreContentAdaptWithSize(maxImg, false)
	GUI:setAnchorPoint(maxImg, 0.50, 0.50)
	GUI:setTouchEnabled(maxImg, false)
	GUI:setTag(maxImg, 0)
	GUI:setVisible(maxImg, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
