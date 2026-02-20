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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 0)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, false)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 558, 334, 350, 502, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/25bwqh/zf/zfbg.png")
	GUI:Image_setScale9Slice(FrameBG, 35, 35, 167, 167)
	GUI:setContentSize(FrameBG, 350, 502)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 344, 442, "res/custom/npc/25bwqh/zf/x1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/25bwqh/zf/x2.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create leftBoxList
	local leftBoxList = GUI:ListView_Create(FrameLayout, "leftBoxList", 30, 14, 290, 374, 1)
	GUI:ListView_setItemsMargin(leftBoxList, 7)
	GUI:setAnchorPoint(leftBoxList, 0.00, 0.00)
	GUI:setTouchEnabled(leftBoxList, true)
	GUI:setTag(leftBoxList, 0)

	-- Create icon1
	local icon1 = GUI:Image_Create(leftBoxList, "icon1", 0, 344, "res/custom/npc/25bwqh/zf/icon11.png")
	GUI:setAnchorPoint(icon1, 0.00, 0.00)
	GUI:setTouchEnabled(icon1, false)
	GUI:setTag(icon1, 0)

	-- Create leftBox1
	local leftBox1 = GUI:Image_Create(icon1, "leftBox1", 0, 0, "res/custom/npc/25bwqh/zf/list.png")
	GUI:setAnchorPoint(leftBox1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox1, false)
	GUI:setTag(leftBox1, 0)

	-- Create starText1
	local starText1 = GUI:Text_Create(leftBox1, "starText1", 36, 3, 16, "#00ff00", [[+15]])
	GUI:Text_enableOutline(starText1, "#000000", 1)
	GUI:setAnchorPoint(starText1, 0.00, 0.00)
	GUI:setTouchEnabled(starText1, false)
	GUI:setTag(starText1, 0)

	-- Create equipText1
	local equipText1 = GUI:Text_Create(leftBox1, "equipText1", 118, 15, 16, "#ff7700", [[龙骨加(男)]])
	GUI:Text_enableOutline(equipText1, "#000000", 1)
	GUI:setAnchorPoint(equipText1, 0.50, 0.50)
	GUI:setTouchEnabled(equipText1, false)
	GUI:setTag(equipText1, 0)

	-- Create effect1
	local effect1 = GUI:Effect_Create(leftBox1, "effect1", 198, -3, 0, 5004, 0, 0, 0, 1)
	GUI:setTag(effect1, 0)

	-- Create boxState1
	local boxState1 = GUI:Text_Create(leftBox1, "boxState1", 214, 3, 16, "#00ff00", [[增幅0%]])
	GUI:Text_enableOutline(boxState1, "#000000", 1)
	GUI:setAnchorPoint(boxState1, 0.00, 0.00)
	GUI:setTouchEnabled(boxState1, false)
	GUI:setTag(boxState1, 0)

	-- Create infoNode
	local infoNode = GUI:Node_Create(FrameLayout, "infoNode", 0, 0)
	GUI:setTag(infoNode, 0)

	-- Create allStarImg
	local allStarImg = GUI:Image_Create(infoNode, "allStarImg", 26, 431, "res/custom/npc/25bwqh/zf/allx.png")
	GUI:setAnchorPoint(allStarImg, 0.00, 0.00)
	GUI:setTouchEnabled(allStarImg, false)
	GUI:setTag(allStarImg, 0)

	-- Create allStarText
	local allStarText = GUI:Text_Create(allStarImg, "allStarText", 88, 11, 16, "#00ff00", [[12]])
	GUI:Text_enableOutline(allStarText, "#000000", 1)
	GUI:setAnchorPoint(allStarText, 0.50, 0.50)
	GUI:setTouchEnabled(allStarText, false)
	GUI:setTag(allStarText, 0)

	-- Create suitText
	local suitText = GUI:Text_Create(infoNode, "suitText", 162, 432, 16, "#ff0000", [[套装增幅属性未生效]])
	GUI:Text_enableOutline(suitText, "#000000", 1)
	GUI:setAnchorPoint(suitText, 0.00, 0.00)
	GUI:setTouchEnabled(suitText, false)
	GUI:setTag(suitText, 0)

	-- Create suitImg
	local suitImg = GUI:Image_Create(infoNode, "suitImg", 178, 431, "res/custom/npc/25bwqh/zf/qhtz.png")
	GUI:setAnchorPoint(suitImg, 0.00, 0.00)
	GUI:setTouchEnabled(suitImg, false)
	GUI:setTag(suitImg, 0)
	GUI:setVisible(suitImg, false)

	-- Create suitStarText
	local suitStarText = GUI:Text_Create(suitImg, "suitStarText", -1, 11, 16, "#fe00fe", [[80]])
	GUI:Text_enableOutline(suitStarText, "#000000", 1)
	GUI:setAnchorPoint(suitStarText, 1.00, 0.50)
	GUI:setTouchEnabled(suitStarText, false)
	GUI:setTag(suitStarText, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
