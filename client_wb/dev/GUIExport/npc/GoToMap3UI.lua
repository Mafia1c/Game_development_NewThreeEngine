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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 756, 474, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/32mj/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 75, 75, 158, 158)
	GUI:setContentSize(FrameBG, 756, 474)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 711, 421, "res/custom/npc/01dtcs/close.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/01dtcs/close2.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create dropItems
	local dropItems = GUI:Node_Create(FrameLayout, "dropItems", 245, 124)
	GUI:setTag(dropItems, 0)

	-- Create enterBtn
	local enterBtn = GUI:Button_Create(FrameLayout, "enterBtn", 524, 55, "res/custom/npc/32mj/anb1.png")
	GUI:Button_loadTexturePressed(enterBtn, "res/custom/npc/32mj/anb2.png")
	GUI:setContentSize(enterBtn, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(enterBtn, false)
	GUI:Button_setTitleText(enterBtn, [[挑战秘境]])
	GUI:Button_setTitleColor(enterBtn, "#ff9b00")
	GUI:Button_setTitleFontSize(enterBtn, 20)
	GUI:Button_titleEnableOutline(enterBtn, "#000000", 1)
	GUI:setAnchorPoint(enterBtn, 0.00, 0.00)
	GUI:setTouchEnabled(enterBtn, true)
	GUI:setTag(enterBtn, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 159, 48, 18, "#ff0000", [[进入秘境需要:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 290, 48, [[<font color='#ffffff' size='18' ><a enableUnderline ='false' href = 'jump#item_tips#10087'><u><font color ='#FFFF00'>秘境卷轴X1</font></u></a></font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
