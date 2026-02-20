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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 574, 334, 686, 462, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/117kryb/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 68, 68, 154, 154)
	GUI:setContentSize(FrameBG, 686, 462)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 626, 346, "res/custom/npc/close3.png")
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create itemList
	local itemList = GUI:ListView_Create(midNode, "itemList", 184, 194, 414, 60, 2)
	GUI:ListView_setGravity(itemList, 3)
	GUI:ListView_setItemsMargin(itemList, 12)
	GUI:setAnchorPoint(itemList, 0.00, 0.00)
	GUI:setTouchEnabled(itemList, true)
	GUI:setTag(itemList, 0)

	-- Create itemShow1
	local itemShow1 = GUI:ItemShow_Create(itemList, "itemShow1", 30, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(itemShow1, 0.50, 0.50)
	GUI:setTag(itemShow1, 0)

	-- Create itemShow2
	local itemShow2 = GUI:ItemShow_Create(itemList, "itemShow2", 102, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(itemShow2, 0.50, 0.50)
	GUI:setTag(itemShow2, 0)

	-- Create itemShow3
	local itemShow3 = GUI:ItemShow_Create(itemList, "itemShow3", 174, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(itemShow3, 0.50, 0.50)
	GUI:setTag(itemShow3, 0)

	-- Create itemShow4
	local itemShow4 = GUI:ItemShow_Create(itemList, "itemShow4", 246, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(itemShow4, 0.50, 0.50)
	GUI:setTag(itemShow4, 0)

	-- Create itemShow5
	local itemShow5 = GUI:ItemShow_Create(itemList, "itemShow5", 318, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(itemShow5, 0.50, 0.50)
	GUI:setTag(itemShow5, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(midNode, "RichText_1", 160, 130, [[<font color='#ffffff' size='16' >使用</font><font color='#00ff00' size='16' >绑定元宝</font><font color='#ffffff' size='16' >刷新，随机切至</font><font color='#00ff00' size='16' >2-3折</font><br><font color='#ffffff' size='16' >使用</font><font color='#00ff00' size='16' >元宝</font><font color='#ffffff' size='16' >刷新，</font><font color='#ff0000' size='16' >100%</font><font color='#ffffff' size='16' >切换至</font><font color='#00ff00' size='16' >1折 </font><font color='#ffff00' size='16' >每次刷新消耗100元宝</font>]], 500, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(midNode, "Button_1", 106, 26, "res/custom/npc/117kryb/bd.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/npc/117kryb/bd_1.png")
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(midNode, "Button_2", 280, 26, "res/custom/npc/117kryb/shuaxin.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/npc/117kryb/shuaxin_1.png")
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(midNode, "Button_3", 452, 26, "res/custom/npc/117kryb/yj.png")
	GUI:Button_loadTexturePressed(Button_3, "res/custom/npc/117kryb/yj_1.png")
	GUI:Button_setTitleText(Button_3, [[]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create timeText
	local timeText = GUI:Text_Create(midNode, "timeText", 509, 86, 16, "#00ff00", [[000000]])
	GUI:Text_enableOutline(timeText, "#000000", 1)
	GUI:setAnchorPoint(timeText, 0.00, 0.00)
	GUI:setTouchEnabled(timeText, false)
	GUI:setTag(timeText, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
