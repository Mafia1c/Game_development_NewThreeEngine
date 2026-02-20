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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/57mrcj/bg1.png")
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

	-- Create item_bg_1
	local item_bg_1 = GUI:Image_Create(FrameLayout, "item_bg_1", 319, 410, "res/private/item_tips/1900025001.png")
	GUI:setContentSize(item_bg_1, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_1, false)
	GUI:setAnchorPoint(item_bg_1, 0.50, 0.50)
	GUI:setTouchEnabled(item_bg_1, false)
	GUI:setTag(item_bg_1, 0)

	-- Create item_bg_2
	local item_bg_2 = GUI:Image_Create(FrameLayout, "item_bg_2", 389, 393, "res/private/item_tips/1900025001.png")
	GUI:setContentSize(item_bg_2, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_2, false)
	GUI:setAnchorPoint(item_bg_2, 0.50, 0.50)
	GUI:setTouchEnabled(item_bg_2, false)
	GUI:setTag(item_bg_2, 0)

	-- Create item_bg_3
	local item_bg_3 = GUI:Image_Create(FrameLayout, "item_bg_3", 435, 331, "res/private/item_tips/1900025001.png")
	GUI:setContentSize(item_bg_3, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_3, false)
	GUI:setAnchorPoint(item_bg_3, 0.50, 0.50)
	GUI:setTouchEnabled(item_bg_3, false)
	GUI:setTag(item_bg_3, 0)

	-- Create item_bg_4
	local item_bg_4 = GUI:Image_Create(FrameLayout, "item_bg_4", 431, 264, "res/private/item_tips/1900025001.png")
	GUI:setContentSize(item_bg_4, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_4, false)
	GUI:setAnchorPoint(item_bg_4, 0.50, 0.50)
	GUI:setTouchEnabled(item_bg_4, false)
	GUI:setTag(item_bg_4, 0)

	-- Create item_bg_5
	local item_bg_5 = GUI:Image_Create(FrameLayout, "item_bg_5", 383, 205, "res/private/item_tips/1900025001.png")
	GUI:setContentSize(item_bg_5, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_5, false)
	GUI:setAnchorPoint(item_bg_5, 0.50, 0.50)
	GUI:setTouchEnabled(item_bg_5, false)
	GUI:setTag(item_bg_5, 0)

	-- Create item_bg_6
	local item_bg_6 = GUI:Image_Create(FrameLayout, "item_bg_6", 316, 181, "res/private/item_tips/1900025001.png")
	GUI:setContentSize(item_bg_6, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_6, false)
	GUI:setAnchorPoint(item_bg_6, 0.50, 0.50)
	GUI:setTouchEnabled(item_bg_6, false)
	GUI:setTag(item_bg_6, 0)

	-- Create item_bg_7
	local item_bg_7 = GUI:Image_Create(FrameLayout, "item_bg_7", 248, 201, "res/private/item_tips/1900025001.png")
	GUI:setContentSize(item_bg_7, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_7, false)
	GUI:setAnchorPoint(item_bg_7, 0.50, 0.50)
	GUI:setTouchEnabled(item_bg_7, false)
	GUI:setTag(item_bg_7, 0)

	-- Create item_bg_8
	local item_bg_8 = GUI:Image_Create(FrameLayout, "item_bg_8", 202, 266, "res/private/item_tips/1900025001.png")
	GUI:setContentSize(item_bg_8, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_8, false)
	GUI:setAnchorPoint(item_bg_8, 0.50, 0.50)
	GUI:setTouchEnabled(item_bg_8, false)
	GUI:setTag(item_bg_8, 0)

	-- Create item_bg_9
	local item_bg_9 = GUI:Image_Create(FrameLayout, "item_bg_9", 204, 334, "res/private/item_tips/1900025001.png")
	GUI:setContentSize(item_bg_9, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_9, false)
	GUI:setAnchorPoint(item_bg_9, 0.50, 0.50)
	GUI:setTouchEnabled(item_bg_9, false)
	GUI:setTag(item_bg_9, 0)

	-- Create item_bg_10
	local item_bg_10 = GUI:Image_Create(FrameLayout, "item_bg_10", 250, 395, "res/private/item_tips/1900025001.png")
	GUI:setContentSize(item_bg_10, 50, 50)
	GUI:setIgnoreContentAdaptWithSize(item_bg_10, false)
	GUI:setAnchorPoint(item_bg_10, 0.50, 0.50)
	GUI:setTouchEnabled(item_bg_10, false)
	GUI:setTag(item_bg_10, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 319, 410, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setScale(ItemShow_1, 0.80)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 389, 393, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setScale(ItemShow_2, 0.80)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(FrameLayout, "ItemShow_3", 435, 331, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setScale(ItemShow_3, 0.80)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(FrameLayout, "ItemShow_4", 431, 264, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setScale(ItemShow_4, 0.80)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(FrameLayout, "ItemShow_5", 383, 205, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setScale(ItemShow_5, 0.80)
	GUI:setTag(ItemShow_5, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(FrameLayout, "ItemShow_6", 316, 181, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setScale(ItemShow_6, 0.80)
	GUI:setTag(ItemShow_6, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(FrameLayout, "ItemShow_7", 248, 201, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setScale(ItemShow_7, 0.80)
	GUI:setTag(ItemShow_7, 0)

	-- Create ItemShow_8
	local ItemShow_8 = GUI:ItemShow_Create(FrameLayout, "ItemShow_8", 202, 266, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_8, 0.50, 0.50)
	GUI:setScale(ItemShow_8, 0.80)
	GUI:setTag(ItemShow_8, 0)

	-- Create ItemShow_9
	local ItemShow_9 = GUI:ItemShow_Create(FrameLayout, "ItemShow_9", 204, 334, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_9, 0.50, 0.50)
	GUI:setScale(ItemShow_9, 0.80)
	GUI:setTag(ItemShow_9, 0)

	-- Create ItemShow_10
	local ItemShow_10 = GUI:ItemShow_Create(FrameLayout, "ItemShow_10", 250, 395, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_10, 0.50, 0.50)
	GUI:setScale(ItemShow_10, 0.80)
	GUI:setTag(ItemShow_10, 0)

	-- Create arrow
	local arrow = GUI:Image_Create(FrameLayout, "arrow", 318, 299, "res/custom/npc/57mrcj/an1.png")
	GUI:setAnchorPoint(arrow, 0.50, 0.40)
	GUI:setTouchEnabled(arrow, false)
	GUI:setTag(arrow, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(arrow, "Image_1", 52, 51, "res/custom/npc/57mrcj/ks.png")
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 617, 41, "res/custom/btn1.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/btn2.png")
	GUI:setContentSize(Button_1, 120, 46)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[抽 奖]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create TableView_1
	local TableView_1 = GUI:TableView_Create(FrameLayout, "TableView_1", 559, 99, 240, 348, 1, 240, 50, 7)
	GUI:setAnchorPoint(TableView_1, 0.00, 0.00)
	GUI:setTouchEnabled(TableView_1, true)
	GUI:setTag(TableView_1, 0)
	GUI:setVisible(TableView_1, false)

	-- Create ruleBtn
	local ruleBtn = GUI:Button_Create(FrameLayout, "ruleBtn", 501, 438, "res/public/1900001024.png")
	GUI:setContentSize(ruleBtn, 34, 34)
	GUI:setIgnoreContentAdaptWithSize(ruleBtn, false)
	GUI:Button_setTitleText(ruleBtn, [[]])
	GUI:Button_setTitleColor(ruleBtn, "#ffffff")
	GUI:Button_setTitleFontSize(ruleBtn, 16)
	GUI:Button_titleEnableOutline(ruleBtn, "#000000", 1)
	GUI:setAnchorPoint(ruleBtn, 0.00, 0.00)
	GUI:setTouchEnabled(ruleBtn, true)
	GUI:setTag(ruleBtn, 0)
	GUI:setVisible(ruleBtn, false)

	-- Create BaoDianItem
	local BaoDianItem = GUI:ItemShow_Create(FrameLayout, "BaoDianItem", 398, 72, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(BaoDianItem, 0.50, 0.50)
	GUI:setTag(BaoDianItem, 0)

	-- Create itemCount
	local itemCount = GUI:Text_Create(FrameLayout, "itemCount", 431, 62, 16, "#00ff00", [[当前剩余: 10个]])
	GUI:Text_enableOutline(itemCount, "#000000", 1)
	GUI:setAnchorPoint(itemCount, 0.00, 0.00)
	GUI:setTouchEnabled(itemCount, false)
	GUI:setTag(itemCount, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 81, 77, 16, "#ff9b00", [[【规则说明】:]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 89, 48, 16, "#00ffe8", [[每次开启抽奖需要消耗【玛法宝典*1】]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 560, 441, 240, 342, 1)
	GUI:ListView_setBackGroundImageScale9Slice(ListView_1, 6, 6, 33, 33)
	GUI:ListView_setGravity(ListView_1, 2)
	GUI:ListView_setItemsMargin(ListView_1, 10)
	GUI:setAnchorPoint(ListView_1, 0.00, 1.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create cell_2
	local cell_2 = GUI:Layout_Create(ListView_1, "cell_2", 5, 322, 230, 20, false)
	GUI:setAnchorPoint(cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(cell_2, false)
	GUI:setTag(cell_2, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(cell_2, "Text_1", 0, 10, 16, "#ffff00", [[5倍高爆地图卷:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rate_1
	local rate_1 = GUI:Text_Create(cell_2, "rate_1", 180, 10, 16, "#00ff00", [[24.6%]])
	GUI:Text_enableOutline(rate_1, "#000000", 1)
	GUI:setAnchorPoint(rate_1, 0.00, 0.50)
	GUI:setTouchEnabled(rate_1, false)
	GUI:setTag(rate_1, 0)

	-- Create cell_3
	local cell_3 = GUI:Layout_Create(ListView_1, "cell_3", 5, 292, 230, 20, false)
	GUI:setAnchorPoint(cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(cell_3, false)
	GUI:setTag(cell_3, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(cell_3, "Text_1", 0, 10, 16, "#ffff00", [[10倍高爆地图卷:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rate_2
	local rate_2 = GUI:Text_Create(cell_3, "rate_2", 180, 10, 16, "#00ff00", [[24.6%]])
	GUI:Text_enableOutline(rate_2, "#000000", 1)
	GUI:setAnchorPoint(rate_2, 0.00, 0.50)
	GUI:setTouchEnabled(rate_2, false)
	GUI:setTag(rate_2, 0)

	-- Create cell_4
	local cell_4 = GUI:Layout_Create(ListView_1, "cell_4", 5, 262, 230, 20, false)
	GUI:setAnchorPoint(cell_4, 0.00, 0.00)
	GUI:setTouchEnabled(cell_4, false)
	GUI:setTag(cell_4, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(cell_4, "Text_1", 0, 10, 16, "#ffff00", [[20倍高爆地图卷:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rate_3
	local rate_3 = GUI:Text_Create(cell_4, "rate_3", 180, 10, 16, "#00ff00", [[24.6%]])
	GUI:Text_enableOutline(rate_3, "#000000", 1)
	GUI:setAnchorPoint(rate_3, 0.00, 0.50)
	GUI:setTouchEnabled(rate_3, false)
	GUI:setTag(rate_3, 0)

	-- Create cell_5
	local cell_5 = GUI:Layout_Create(ListView_1, "cell_5", 5, 232, 230, 20, false)
	GUI:setAnchorPoint(cell_5, 0.00, 0.00)
	GUI:setTouchEnabled(cell_5, false)
	GUI:setTag(cell_5, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(cell_5, "Text_1", 0, 10, 16, "#ffff00", [[30倍高爆地图卷:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rate_4
	local rate_4 = GUI:Text_Create(cell_5, "rate_4", 180, 10, 16, "#00ff00", [[24.6%]])
	GUI:Text_enableOutline(rate_4, "#000000", 1)
	GUI:setAnchorPoint(rate_4, 0.00, 0.50)
	GUI:setTouchEnabled(rate_4, false)
	GUI:setTag(rate_4, 0)

	-- Create cell_6
	local cell_6 = GUI:Layout_Create(ListView_1, "cell_6", 5, 202, 230, 20, false)
	GUI:setAnchorPoint(cell_6, 0.00, 0.00)
	GUI:setTouchEnabled(cell_6, false)
	GUI:setTag(cell_6, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(cell_6, "Text_1", 0, 10, 16, "#ffff00", [[50倍高爆地图卷:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rate_5
	local rate_5 = GUI:Text_Create(cell_6, "rate_5", 180, 10, 16, "#00ff00", [[24.6%]])
	GUI:Text_enableOutline(rate_5, "#000000", 1)
	GUI:setAnchorPoint(rate_5, 0.00, 0.50)
	GUI:setTouchEnabled(rate_5, false)
	GUI:setTag(rate_5, 0)

	-- Create cell_7
	local cell_7 = GUI:Layout_Create(ListView_1, "cell_7", 5, 172, 230, 20, false)
	GUI:setAnchorPoint(cell_7, 0.00, 0.00)
	GUI:setTouchEnabled(cell_7, false)
	GUI:setTag(cell_7, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(cell_7, "Text_1", 0, 10, 16, "#ffff00", [[100倍高爆地图卷:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rate_6
	local rate_6 = GUI:Text_Create(cell_7, "rate_6", 180, 10, 16, "#00ff00", [[24.6%]])
	GUI:Text_enableOutline(rate_6, "#000000", 1)
	GUI:setAnchorPoint(rate_6, 0.00, 0.50)
	GUI:setTouchEnabled(rate_6, false)
	GUI:setTag(rate_6, 0)

	-- Create cell_8
	local cell_8 = GUI:Layout_Create(ListView_1, "cell_8", 5, 142, 230, 20, false)
	GUI:setAnchorPoint(cell_8, 0.00, 0.00)
	GUI:setTouchEnabled(cell_8, false)
	GUI:setTag(cell_8, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(cell_8, "Text_1", 0, 10, 16, "#ffff00", [[初级装扮宝箱:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rate_7
	local rate_7 = GUI:Text_Create(cell_8, "rate_7", 180, 10, 16, "#00ff00", [[24.6%]])
	GUI:Text_enableOutline(rate_7, "#000000", 1)
	GUI:setAnchorPoint(rate_7, 0.00, 0.50)
	GUI:setTouchEnabled(rate_7, false)
	GUI:setTag(rate_7, 0)

	-- Create cell_9
	local cell_9 = GUI:Layout_Create(ListView_1, "cell_9", 5, 112, 230, 20, false)
	GUI:setAnchorPoint(cell_9, 0.00, 0.00)
	GUI:setTouchEnabled(cell_9, false)
	GUI:setTag(cell_9, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(cell_9, "Text_1", 0, 10, 16, "#ffff00", [[高级装扮宝箱:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rate_8
	local rate_8 = GUI:Text_Create(cell_9, "rate_8", 180, 10, 16, "#00ff00", [[24.6%]])
	GUI:Text_enableOutline(rate_8, "#000000", 1)
	GUI:setAnchorPoint(rate_8, 0.00, 0.50)
	GUI:setTouchEnabled(rate_8, false)
	GUI:setTag(rate_8, 0)

	-- Create cell_10
	local cell_10 = GUI:Layout_Create(ListView_1, "cell_10", 5, 82, 230, 20, false)
	GUI:setAnchorPoint(cell_10, 0.00, 0.00)
	GUI:setTouchEnabled(cell_10, false)
	GUI:setTag(cell_10, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(cell_10, "Text_1", 0, 10, 16, "#ffff00", [[史诗装扮宝箱:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rate_9
	local rate_9 = GUI:Text_Create(cell_10, "rate_9", 180, 10, 16, "#00ff00", [[24.6%]])
	GUI:Text_enableOutline(rate_9, "#000000", 1)
	GUI:setAnchorPoint(rate_9, 0.00, 0.50)
	GUI:setTouchEnabled(rate_9, false)
	GUI:setTag(rate_9, 0)

	-- Create cell_11
	local cell_11 = GUI:Layout_Create(ListView_1, "cell_11", 5, 52, 230, 20, false)
	GUI:setAnchorPoint(cell_11, 0.00, 0.00)
	GUI:setTouchEnabled(cell_11, false)
	GUI:setTag(cell_11, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(cell_11, "Text_1", 0, 10, 16, "#ffff00", [[传说装扮宝箱:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create rate_10
	local rate_10 = GUI:Text_Create(cell_11, "rate_10", 180, 10, 16, "#00ff00", [[24.6%]])
	GUI:Text_enableOutline(rate_10, "#000000", 1)
	GUI:setAnchorPoint(rate_10, 0.00, 0.50)
	GUI:setTouchEnabled(rate_10, false)
	GUI:setTag(rate_10, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
