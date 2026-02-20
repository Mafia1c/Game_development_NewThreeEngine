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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/58zxfl/bg1.png")
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

	-- Create leftNode
	local leftNode = GUI:Node_Create(FrameLayout, "leftNode", 0, 0)
	GUI:setTag(leftNode, 0)

	-- Create itemNode1
	local itemNode1 = GUI:Node_Create(leftNode, "itemNode1", 252, 322)
	GUI:setTag(itemNode1, 0)

	-- Create itemNode2
	local itemNode2 = GUI:Node_Create(leftNode, "itemNode2", 252, 258)
	GUI:setTag(itemNode2, 0)

	-- Create buyBtn1
	local buyBtn1 = GUI:Button_Create(leftNode, "buyBtn1", 254, 102, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(buyBtn1, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(buyBtn1, 0, 0, 0, 0)
	GUI:setContentSize(buyBtn1, 114, 40)
	GUI:setIgnoreContentAdaptWithSize(buyBtn1, false)
	GUI:Button_setTitleText(buyBtn1, [[购买礼包]])
	GUI:Button_setTitleColor(buyBtn1, "#E8DCBD")
	GUI:Button_setTitleFontSize(buyBtn1, 18)
	GUI:Button_titleEnableOutline(buyBtn1, "#000000", 1)
	GUI:setAnchorPoint(buyBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn1, true)
	GUI:setTag(buyBtn1, 0)

	-- Create buyText1
	local buyText1 = GUI:Text_Create(leftNode, "buyText1", 254, 58, 16, "#00ff00", [[每日每个角色仅限购买1次]])
	GUI:Text_enableOutline(buyText1, "#000000", 1)
	GUI:setAnchorPoint(buyText1, 0.50, 0.50)
	GUI:setTouchEnabled(buyText1, false)
	GUI:setTag(buyText1, 0)

	-- Create hasImg1
	local hasImg1 = GUI:Image_Create(leftNode, "hasImg1", 218, 86, "res/custom/tag/ygm.png")
	GUI:setAnchorPoint(hasImg1, 0.00, 0.00)
	GUI:setTouchEnabled(hasImg1, false)
	GUI:setTag(hasImg1, 0)
	GUI:setVisible(hasImg1, false)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(leftNode, "Text_1", 256, 188, 17, "#00ff00", [[可激活首充]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rightNode
	local rightNode = GUI:Node_Create(FrameLayout, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create itemNode3
	local itemNode3 = GUI:Node_Create(rightNode, "itemNode3", 618, 285)
	GUI:setTag(itemNode3, 0)

	-- Create itemNode4
	local itemNode4 = GUI:Node_Create(rightNode, "itemNode4", 618, 180)
	GUI:setTag(itemNode4, 0)

	-- Create buyBtn2
	local buyBtn2 = GUI:Button_Create(rightNode, "buyBtn2", 540, 104, "res/custom/npc/58zxfl/an1.png")
	GUI:Button_loadTexturePressed(buyBtn2, "res/custom/npc/58zxfl/an2.png")
	GUI:Button_setScale9Slice(buyBtn2, 10, 10, 12, 12)
	GUI:setContentSize(buyBtn2, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(buyBtn2, false)
	GUI:Button_setTitleText(buyBtn2, [[]])
	GUI:Button_setTitleColor(buyBtn2, "#E8DCBD")
	GUI:Button_setTitleFontSize(buyBtn2, 18)
	GUI:Button_titleEnableOutline(buyBtn2, "#000000", 1)
	GUI:setAnchorPoint(buyBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn2, true)
	GUI:setTag(buyBtn2, 0)

	-- Create getBtn3
	local getBtn3 = GUI:Button_Create(rightNode, "getBtn3", 714, 104, "res/custom/npc/58zxfl/an5.png")
	GUI:Button_loadTexturePressed(getBtn3, "res/custom/npc/58zxfl/an6.png")
	GUI:Button_setScale9Slice(getBtn3, 10, 10, 12, 12)
	GUI:setContentSize(getBtn3, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(getBtn3, false)
	GUI:Button_setTitleText(getBtn3, [[]])
	GUI:Button_setTitleColor(getBtn3, "#E8DCBD")
	GUI:Button_setTitleFontSize(getBtn3, 18)
	GUI:Button_titleEnableOutline(getBtn3, "#000000", 1)
	GUI:setAnchorPoint(getBtn3, 0.50, 0.50)
	GUI:setTouchEnabled(getBtn3, true)
	GUI:setTag(getBtn3, 0)

	-- Create buyText2
	local buyText2 = GUI:Text_Create(rightNode, "buyText2", 624, 64, 16, "#00ff00", [[仅限本页面充值58元，即可获得专享福利]])
	GUI:Text_enableOutline(buyText2, "#000000", 1)
	GUI:setAnchorPoint(buyText2, 0.50, 0.50)
	GUI:setTouchEnabled(buyText2, false)
	GUI:setTag(buyText2, 0)

	-- Create hasImg2
	local hasImg2 = GUI:Image_Create(rightNode, "hasImg2", 680, 88, "res/custom/tag/ylq_00.png")
	GUI:setAnchorPoint(hasImg2, 0.00, 0.00)
	GUI:setTouchEnabled(hasImg2, false)
	GUI:setTag(hasImg2, 0)
	GUI:setVisible(hasImg2, false)

	-- Create showTime
	local showTime = GUI:Text_Create(rightNode, "showTime", 690, 416, 16, "#00ff00", [[七日专享剩余时间：]])
	GUI:Text_enableOutline(showTime, "#000000", 1)
	GUI:setAnchorPoint(showTime, 1.00, 0.00)
	GUI:setTouchEnabled(showTime, false)
	GUI:setTag(showTime, 0)

	-- Create hasTime
	local hasTime = GUI:Text_Create(showTime, "hasTime", 144, 0, 16, "#00ff00", [[99天99时99分]])
	GUI:Text_enableOutline(hasTime, "#000000", 1)
	GUI:setAnchorPoint(hasTime, 0.00, 0.00)
	GUI:setTouchEnabled(hasTime, false)
	GUI:setTag(hasTime, 0)

	-- Create ScrollText_1
	local ScrollText_1 = GUI:ScrollText_Create(parent, "ScrollText_1", 0, 0, 100, 16, "#ffffff", "滚动文本", 4)
	GUI:ScrollText_enableOutline(ScrollText_1, "#000000", 1)
	GUI:ScrollText_setHorizontalAlignment(ScrollText_1, 0)
	GUI:setAnchorPoint(ScrollText_1, 0.00, 0.00)
	GUI:setTouchEnabled(ScrollText_1, false)
	GUI:setTag(ScrollText_1, 0)

	-- Create ScrollText_2
	local ScrollText_2 = GUI:ScrollText_Create(parent, "ScrollText_2", 0, 0, 100, 16, "#ffffff", "滚动文本", 4)
	GUI:ScrollText_enableOutline(ScrollText_2, "#000000", 1)
	GUI:ScrollText_setHorizontalAlignment(ScrollText_2, 0)
	GUI:setAnchorPoint(ScrollText_2, 0.00, 0.00)
	GUI:setTouchEnabled(ScrollText_2, false)
	GUI:setTag(ScrollText_2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
