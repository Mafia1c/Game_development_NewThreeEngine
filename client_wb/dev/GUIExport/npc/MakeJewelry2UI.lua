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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/48bao/bg.png")
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

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create tipsBtn
	local tipsBtn = GUI:Button_Create(midNode, "tipsBtn", 498, 443, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tipsBtn, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn, false)
	GUI:Button_setTitleText(tipsBtn, [[]])
	GUI:Button_setTitleColor(tipsBtn, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn, 16)
	GUI:Button_titleEnableOutline(tipsBtn, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn, true)
	GUI:setTag(tipsBtn, 0)

	-- Create lockImg
	local lockImg = GUI:Image_Create(midNode, "lockImg", 354, 382, "res/custom/npc/48bao/lock.png")
	GUI:setAnchorPoint(lockImg, 0.00, 0.00)
	GUI:setTouchEnabled(lockImg, false)
	GUI:setTag(lockImg, 0)

	-- Create equipNode1
	local equipNode1 = GUI:Node_Create(midNode, "equipNode1", 258, 283)
	GUI:setTag(equipNode1, 0)

	-- Create equipNode2
	local equipNode2 = GUI:Node_Create(midNode, "equipNode2", 365, 283)
	GUI:setTag(equipNode2, 0)

	-- Create equipNode3
	local equipNode3 = GUI:Node_Create(midNode, "equipNode3", 472, 283)
	GUI:setTag(equipNode3, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(midNode, "needItemNode", 364, 147)
	GUI:setTag(needItemNode, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midNode, "upBtn", 675, 72, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn, 0, 0, 0, 0)
	GUI:setContentSize(upBtn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开始锻造]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 16)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create RichText
	local RichText = GUI:RichText_Create(midNode, "RichText", 76, 50, [[<font color='#ffffff' size='16' >任意3个同类型的首饰，可随机锻造一件高级装备，</font><font color='#00ff00' size='16' >100%</font><font color='#ffffff' size='16' >成功！</font><br><font color='#ffffff' size='16' >点击右边</font><font color='#9b00ff' size='16' >“首饰仓库”</font><font color='#ffffff' size='16' >即可添加装备至锻造框！</font>]], 500, 16, "#00ff00", 4)
	GUI:setAnchorPoint(RichText, 0.00, 0.00)
	GUI:setTag(RichText, 0)

	-- Create rightNode
	local rightNode = GUI:Node_Create(FrameLayout, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create bigList
	local bigList = GUI:ListView_Create(rightNode, "bigList", 543, 114, 252, 333, 1)
	GUI:ListView_setBounceEnabled(bigList, true)
	GUI:ListView_setItemsMargin(bigList, 2)
	GUI:setAnchorPoint(bigList, 0.00, 0.00)
	GUI:setTouchEnabled(bigList, true)
	GUI:setTag(bigList, 0)

	-- Create list1
	local list1 = GUI:ListView_Create(bigList, "list1", 0, 273, 252, 60, 2)
	GUI:ListView_setGravity(list1, 3)
	GUI:ListView_setItemsMargin(list1, 4)
	GUI:setAnchorPoint(list1, 0.00, 0.00)
	GUI:setTouchEnabled(list1, true)
	GUI:setTag(list1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(list1, "Image_1", 0, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Image_1, "ItemShow_1", 30, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(list1, "Image_2", 64, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(list1, "Image_3", 128, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(list1, "Image_6", 192, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
