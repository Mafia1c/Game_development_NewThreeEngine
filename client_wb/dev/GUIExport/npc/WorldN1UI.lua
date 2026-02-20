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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 806, 506, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/36tx/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 80, 80, 168, 168)
	GUI:setContentSize(FrameBG, 806, 506)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 707, 441, "res/custom/npc/36tx/x.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create InfoNode
	local InfoNode = GUI:Node_Create(FrameLayout, "InfoNode", 444, 320)
	GUI:setTag(InfoNode, 0)

	-- Create title_1
	local title_1 = GUI:Text_Create(InfoNode, "title_1", 0, 30, 18, "#9b00ff", [[上榜玩家:]])
	GUI:Text_enableOutline(title_1, "#000000", 1)
	GUI:setAnchorPoint(title_1, 0.50, 0.50)
	GUI:setTouchEnabled(title_1, false)
	GUI:setTag(title_1, 0)

	-- Create title_2
	local title_2 = GUI:Text_Create(InfoNode, "title_2", 0, 0, 18, "#9b00ff", [[上榜等级:]])
	GUI:Text_enableOutline(title_2, "#000000", 1)
	GUI:setAnchorPoint(title_2, 0.50, 0.50)
	GUI:setTouchEnabled(title_2, false)
	GUI:setTag(title_2, 0)

	-- Create title_3
	local title_3 = GUI:Text_Create(InfoNode, "title_3", 0, -30, 18, "#9b00ff", [[上榜战力:]])
	GUI:Text_enableOutline(title_3, "#000000", 1)
	GUI:setAnchorPoint(title_3, 0.50, 0.50)
	GUI:setTouchEnabled(title_3, false)
	GUI:setTag(title_3, 0)

	-- Create title_icon
	local title_icon = GUI:Image_Create(FrameLayout, "title_icon", 444, 413, "res/custom/npc/36tx/t1.png")
	GUI:setContentSize(title_icon, 390, 102)
	GUI:setIgnoreContentAdaptWithSize(title_icon, false)
	GUI:setAnchorPoint(title_icon, 0.50, 0.00)
	GUI:setTouchEnabled(title_icon, false)
	GUI:setTag(title_icon, 0)

	-- Create title_mini
	local title_mini = GUI:Image_Create(FrameLayout, "title_mini", 425, 377, "res/custom/npc/36tx/z1.png")
	GUI:setContentSize(title_mini, 238, 28)
	GUI:setIgnoreContentAdaptWithSize(title_mini, false)
	GUI:setAnchorPoint(title_mini, 0.50, 0.00)
	GUI:setTouchEnabled(title_mini, false)
	GUI:setTag(title_mini, 0)

	-- Create applyBtn
	local applyBtn = GUI:Button_Create(FrameLayout, "applyBtn", 381, 95, "res/custom/npc/36tx/an1.png")
	GUI:setContentSize(applyBtn, 146, 44)
	GUI:setIgnoreContentAdaptWithSize(applyBtn, false)
	GUI:Button_setTitleText(applyBtn, [[]])
	GUI:Button_setTitleColor(applyBtn, "#ffffff")
	GUI:Button_setTitleFontSize(applyBtn, 16)
	GUI:Button_titleEnableOutline(applyBtn, "#000000", 1)
	GUI:setAnchorPoint(applyBtn, 0.00, 0.00)
	GUI:setTouchEnabled(applyBtn, true)
	GUI:setTag(applyBtn, 0)

	-- Create roleImg
	local roleImg = GUI:Image_Create(FrameLayout, "roleImg", 29, 62, "res/custom/npc/36tx/r1.png")
	GUI:setContentSize(roleImg, 232, 398)
	GUI:setIgnoreContentAdaptWithSize(roleImg, false)
	GUI:setAnchorPoint(roleImg, 0.00, 0.00)
	GUI:setTouchEnabled(roleImg, false)
	GUI:setTag(roleImg, 0)

	-- Create ruleTxt
	local ruleTxt = GUI:RichText_Create(FrameLayout, "ruleTxt", 291, 224, [[<font color='#ffffff' size='18' >天下第一玩家可获得专属称号: 【<a enableUnderline='false'href='jump#item_tips#11332'><u>&<ITEM_NAME_COLOR/11332>&</u></a>】申请优先对比角色等级, 若等级相同, 则对比战斗力</font><font color='#ffff00' size='18'> 注: 申请天下第一需要等级达到50级</font>]], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(ruleTxt, 0.00, 1.00)
	GUI:setTag(ruleTxt, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
