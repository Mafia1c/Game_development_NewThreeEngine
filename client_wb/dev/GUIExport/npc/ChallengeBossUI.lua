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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 89)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 170, 45, 832, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/33tzboss/bg.png")
	GUI:Image_setScale9Slice(bg_Image, 83, 83, 188, 188)
	GUI:setContentSize(bg_Image, 832, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 773, 490, "res/public/01.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/02.png")
	GUI:setContentSize(closeBtn, 30, 30)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create gotoBtn
	local gotoBtn = GUI:Button_Create(FrameLayout, "gotoBtn", 599, 36, "res/custom/btn1.png")
	GUI:Button_loadTexturePressed(gotoBtn, "res/custom/btn2.png")
	GUI:setContentSize(gotoBtn, 120, 46)
	GUI:setIgnoreContentAdaptWithSize(gotoBtn, false)
	GUI:Button_setTitleText(gotoBtn, [[前往挑战]])
	GUI:Button_setTitleColor(gotoBtn, "#ffffff")
	GUI:Button_setTitleFontSize(gotoBtn, 18)
	GUI:Button_titleEnableOutline(gotoBtn, "#000000", 1)
	GUI:setAnchorPoint(gotoBtn, 0.00, 0.00)
	GUI:setTouchEnabled(gotoBtn, true)
	GUI:setTag(gotoBtn, 0)

	-- Create eff_node
	local eff_node = GUI:Node_Create(FrameLayout, "eff_node", 0, 0)
	GUI:setTag(eff_node, 0)

	-- Create rewardNode
	local rewardNode = GUI:Node_Create(FrameLayout, "rewardNode", 661, 61)
	GUI:setTag(rewardNode, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(rewardNode, "ItemShow_1", -101, 181, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(rewardNode, "ItemShow_2", -36, 181, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(rewardNode, "ItemShow_3", 29, 181, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(rewardNode, "ItemShow_4", 95, 181, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create reward_item
	local reward_item = GUI:ItemShow_Create(rewardNode, "reward_item", -86, 69, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(reward_item, 0.50, 0.50)
	GUI:setTag(reward_item, 0)

	-- Create name_txt
	local name_txt = GUI:Text_Create(rewardNode, "name_txt", 22, 70, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(name_txt, "#000000", 1)
	GUI:setAnchorPoint(name_txt, 0.50, 0.00)
	GUI:setTouchEnabled(name_txt, false)
	GUI:setTag(name_txt, 0)

	-- Create time_txt
	local time_txt = GUI:Text_Create(rewardNode, "time_txt", 22, 41, 16, "#ffffff", [[文本]])
	GUI:Text_enableOutline(time_txt, "#000000", 1)
	GUI:setAnchorPoint(time_txt, 0.50, 0.00)
	GUI:setTouchEnabled(time_txt, false)
	GUI:setTag(time_txt, 0)

	-- Create bossListView
	local bossListView = GUI:ListView_Create(FrameLayout, "bossListView", 64, 89, 456, 357, 1)
	GUI:ListView_setItemsMargin(bossListView, 3)
	GUI:setAnchorPoint(bossListView, 0.00, 0.00)
	GUI:setTouchEnabled(bossListView, true)
	GUI:setTag(bossListView, 0)

	-- Create lastBtn
	local lastBtn = GUI:Button_Create(FrameLayout, "lastBtn", 220, 47, "res/custom/npc/33tzboss/an1_1.png")
	GUI:setContentSize(lastBtn, 26, 37)
	GUI:setIgnoreContentAdaptWithSize(lastBtn, false)
	GUI:Button_setTitleText(lastBtn, [[]])
	GUI:Button_setTitleColor(lastBtn, "#ffffff")
	GUI:Button_setTitleFontSize(lastBtn, 16)
	GUI:Button_titleEnableOutline(lastBtn, "#000000", 1)
	GUI:setAnchorPoint(lastBtn, 0.00, 0.00)
	GUI:setTouchEnabled(lastBtn, true)
	GUI:setTag(lastBtn, 0)

	-- Create nextBtn
	local nextBtn = GUI:Button_Create(FrameLayout, "nextBtn", 344, 47, "res/custom/npc/33tzboss/an1_2.png")
	GUI:setContentSize(nextBtn, 26, 37)
	GUI:setIgnoreContentAdaptWithSize(nextBtn, false)
	GUI:Button_setTitleText(nextBtn, [[]])
	GUI:Button_setTitleColor(nextBtn, "#ffffff")
	GUI:Button_setTitleFontSize(nextBtn, 16)
	GUI:Button_titleEnableOutline(nextBtn, "#000000", 1)
	GUI:setAnchorPoint(nextBtn, 0.00, 0.00)
	GUI:setTouchEnabled(nextBtn, true)
	GUI:setTag(nextBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
