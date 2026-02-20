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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/20zb/bg.png")
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

	-- Create tagImg
	local tagImg = GUI:Image_Create(midNode, "tagImg", 500, 324, "res/custom/npc/20zb/ba1.png")
	GUI:setContentSize(tagImg, 51, 151)
	GUI:setIgnoreContentAdaptWithSize(tagImg, false)
	GUI:setAnchorPoint(tagImg, 0.00, 0.00)
	GUI:setTouchEnabled(tagImg, false)
	GUI:setTag(tagImg, 0)

	-- Create infoImg
	local infoImg = GUI:Image_Create(midNode, "infoImg", 330, 160, "res/custom/npc/20zb/ss1.png")
	GUI:setContentSize(infoImg, 92, 20)
	GUI:setIgnoreContentAdaptWithSize(infoImg, false)
	GUI:setAnchorPoint(infoImg, 0.00, 0.00)
	GUI:setTouchEnabled(infoImg, false)
	GUI:setTag(infoImg, 0)

	-- Create effectNode
	local effectNode = GUI:Node_Create(midNode, "effectNode", 0, 0)
	GUI:setTag(effectNode, 0)

	-- Create Effect_2
	local Effect_2 = GUI:Effect_Create(effectNode, "Effect_2", 350, 282, 4, 1, 0, 0, 4, 1)
	GUI:setTag(Effect_2, 0)

	-- Create Effect_3
	local Effect_3 = GUI:Effect_Create(effectNode, "Effect_3", 346, 286, 2, 20012, 0, 1, 5, 1)
	GUI:setTag(Effect_3, 0)

	-- Create textNode
	local textNode = GUI:Node_Create(midNode, "textNode", 0, 0)
	GUI:setTag(textNode, 0)

	-- Create typeText1
	local typeText1 = GUI:Text_Create(textNode, "typeText1", 306, 116, 16, "#ffffff", [[攻魔道：]])
	GUI:Text_enableOutline(typeText1, "#000000", 1)
	GUI:setAnchorPoint(typeText1, 1.00, 0.00)
	GUI:setTouchEnabled(typeText1, false)
	GUI:setTag(typeText1, 0)

	-- Create numberText1
	local numberText1 = GUI:Text_Create(typeText1, "numberText1", 64, 0, 16, "#00ff00", [[3 - 6]])
	GUI:Text_enableOutline(numberText1, "#000000", 1)
	GUI:setAnchorPoint(numberText1, 0.00, 0.00)
	GUI:setTouchEnabled(numberText1, false)
	GUI:setTag(numberText1, 0)

	-- Create typeText2
	local typeText2 = GUI:Text_Create(textNode, "typeText2", 306, 86, 16, "#ffffff", [[攻魔道：]])
	GUI:Text_enableOutline(typeText2, "#000000", 1)
	GUI:setAnchorPoint(typeText2, 1.00, 0.00)
	GUI:setTouchEnabled(typeText2, false)
	GUI:setTag(typeText2, 0)

	-- Create numberText2
	local numberText2 = GUI:Text_Create(typeText2, "numberText2", 64, 0, 16, "#00ff00", [[3 - 6]])
	GUI:Text_enableOutline(numberText2, "#000000", 1)
	GUI:setAnchorPoint(numberText2, 0.00, 0.00)
	GUI:setTouchEnabled(numberText2, false)
	GUI:setTag(numberText2, 0)

	-- Create typeText3
	local typeText3 = GUI:Text_Create(textNode, "typeText3", 306, 56, 16, "#ffffff", [[魔力增加：]])
	GUI:Text_enableOutline(typeText3, "#000000", 1)
	GUI:setAnchorPoint(typeText3, 1.00, 0.00)
	GUI:setTouchEnabled(typeText3, false)
	GUI:setTag(typeText3, 0)

	-- Create numberText3
	local numberText3 = GUI:Text_Create(typeText3, "numberText3", 80, 0, 16, "#00ff00", [[3 - 6]])
	GUI:Text_enableOutline(numberText3, "#000000", 1)
	GUI:setAnchorPoint(numberText3, 0.00, 0.00)
	GUI:setTouchEnabled(numberText3, false)
	GUI:setTag(numberText3, 0)

	-- Create typeText4
	local typeText4 = GUI:Text_Create(textNode, "typeText4", 482, 116, 16, "#ffffff", [[魔力增加：]])
	GUI:Text_enableOutline(typeText4, "#000000", 1)
	GUI:setAnchorPoint(typeText4, 1.00, 0.00)
	GUI:setTouchEnabled(typeText4, false)
	GUI:setTag(typeText4, 0)

	-- Create numberText4
	local numberText4 = GUI:Text_Create(typeText4, "numberText4", 80, 0, 16, "#00ff00", [[3%]])
	GUI:Text_enableOutline(numberText4, "#000000", 1)
	GUI:setAnchorPoint(numberText4, 0.00, 0.00)
	GUI:setTouchEnabled(numberText4, false)
	GUI:setTag(numberText4, 0)

	-- Create typeText5
	local typeText5 = GUI:Text_Create(textNode, "typeText5", 482, 86, 16, "#ffffff", [[攻魔道：]])
	GUI:Text_enableOutline(typeText5, "#000000", 1)
	GUI:setAnchorPoint(typeText5, 1.00, 0.00)
	GUI:setTouchEnabled(typeText5, false)
	GUI:setTag(typeText5, 0)

	-- Create numberText5
	local numberText5 = GUI:Text_Create(typeText5, "numberText5", 64, 0, 16, "#00ff00", [[3 - 6]])
	GUI:Text_enableOutline(numberText5, "#000000", 1)
	GUI:setAnchorPoint(numberText5, 0.00, 0.00)
	GUI:setTouchEnabled(numberText5, false)
	GUI:setTag(numberText5, 0)

	-- Create typeText6
	local typeText6 = GUI:Text_Create(textNode, "typeText6", 482, 56, 16, "#ffffff", [[魔力增加：]])
	GUI:Text_enableOutline(typeText6, "#000000", 1)
	GUI:setAnchorPoint(typeText6, 1.00, 0.00)
	GUI:setTouchEnabled(typeText6, false)
	GUI:setTag(typeText6, 0)

	-- Create numberText6
	local numberText6 = GUI:Text_Create(typeText6, "numberText6", 80, 0, 16, "#00ff00", [[3 - 6]])
	GUI:Text_enableOutline(numberText6, "#000000", 1)
	GUI:setAnchorPoint(numberText6, 0.00, 0.00)
	GUI:setTouchEnabled(numberText6, false)
	GUI:setTag(numberText6, 0)

	-- Create rightNode
	local rightNode = GUI:Node_Create(FrameLayout, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create rightList
	local rightList = GUI:ListView_Create(rightNode, "rightList", 559, 164, 240, 288, 1)
	GUI:ListView_setBounceEnabled(rightList, true)
	GUI:setAnchorPoint(rightList, 0.00, 0.00)
	GUI:setTouchEnabled(rightList, true)
	GUI:setTag(rightList, 0)

	-- Create sonList1
	local sonList1 = GUI:ListView_Create(rightList, "sonList1", 0, 192, 240, 96, 2)
	GUI:ListView_setGravity(sonList1, 3)
	GUI:setAnchorPoint(sonList1, 0.00, 0.00)
	GUI:setTouchEnabled(sonList1, true)
	GUI:setTag(sonList1, 0)

	-- Create itemBox1
	local itemBox1 = GUI:Image_Create(sonList1, "itemBox1", 0, 0, "res/custom/npc/20zb/list.png")
	GUI:setAnchorPoint(itemBox1, 0.00, 0.00)
	GUI:setTouchEnabled(itemBox1, false)
	GUI:setTag(itemBox1, 0)

	-- Create showItem1
	local showItem1 = GUI:ItemShow_Create(itemBox1, "showItem1", 10, 28, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(showItem1, 0.00, 0.00)
	GUI:setTag(showItem1, 0)

	-- Create nowTagImg
	local nowTagImg = GUI:Image_Create(showItem1, "nowTagImg", 1, 15, "res/custom/npc/20zb/wx1.png")
	GUI:setAnchorPoint(nowTagImg, 0.00, 0.00)
	GUI:setTouchEnabled(nowTagImg, false)
	GUI:setTag(nowTagImg, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(showItem1, "Effect_1", 32, 31, 0, 4004, 0, 0, 0, 1)
	GUI:setScale(Effect_1, 0.70)
	GUI:setTag(Effect_1, 0)

	-- Create itemName1
	local itemName1 = GUI:Text_Create(itemBox1, "itemName1", 41, 12, 16, "#ffffff", [[福气临门]])
	GUI:Text_enableOutline(itemName1, "#000000", 1)
	GUI:setAnchorPoint(itemName1, 0.50, 0.50)
	GUI:setTouchEnabled(itemName1, false)
	GUI:setTag(itemName1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(sonList1, "Image_2", 80, 0, "res/custom/npc/20zb/list.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(sonList1, "Image_3", 160, 0, "res/custom/npc/20zb/list.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create nowItem
	local nowItem = GUI:ItemShow_Create(rightNode, "nowItem", 600, 50, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(nowItem, 0.00, 0.00)
	GUI:setTag(nowItem, 0)

	-- Create showBtn
	local showBtn = GUI:Button_Create(rightNode, "showBtn", 742, 76, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(showBtn, "res/custom/npc/anb2.png")
	GUI:setContentSize(showBtn, 96, 36)
	GUI:setIgnoreContentAdaptWithSize(showBtn, false)
	GUI:Button_setTitleText(showBtn, [[外  显]])
	GUI:Button_setTitleColor(showBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(showBtn, 16)
	GUI:Button_titleEnableOutline(showBtn, "#000000", 1)
	GUI:setAnchorPoint(showBtn, 0.50, 0.50)
	GUI:setTouchEnabled(showBtn, true)
	GUI:setTag(showBtn, 0)

	-- Create hideBtn
	local hideBtn = GUI:Button_Create(rightNode, "hideBtn", 742, 76, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(hideBtn, "res/custom/npc/anb2.png")
	GUI:setContentSize(hideBtn, 96, 36)
	GUI:setIgnoreContentAdaptWithSize(hideBtn, false)
	GUI:Button_setTitleText(hideBtn, [[隐  藏]])
	GUI:Button_setTitleColor(hideBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(hideBtn, 16)
	GUI:Button_titleEnableOutline(hideBtn, "#000000", 1)
	GUI:setAnchorPoint(hideBtn, 0.50, 0.50)
	GUI:setTouchEnabled(hideBtn, true)
	GUI:setTag(hideBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
