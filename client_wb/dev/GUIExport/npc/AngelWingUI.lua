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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/50zh/bg1.png")
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

	-- Create nameBg
	local nameBg = GUI:Image_Create(FrameLayout, "nameBg", 192, 429, "res/custom/npc/tip.png")
	GUI:setContentSize(nameBg, 260, 36)
	GUI:setIgnoreContentAdaptWithSize(nameBg, false)
	GUI:setAnchorPoint(nameBg, 0.00, 0.00)
	GUI:setTouchEnabled(nameBg, false)
	GUI:setTag(nameBg, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(nameBg, "Text_1", 130, 18, 18, "#9b00ff", [[烈焰之羽]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 186, 448, {index = 51018, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create needItem_1
	local needItem_1 = GUI:ItemShow_Create(FrameLayout, "needItem_1", 645, 139, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_1, 0.50, 0.50)
	GUI:setTag(needItem_1, 0)

	-- Create needItem_2
	local needItem_2 = GUI:ItemShow_Create(FrameLayout, "needItem_2", 720, 139, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(needItem_2, 0.50, 0.50)
	GUI:setTag(needItem_2, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 89, 45, [==========[<font color='#ffff00' size='18' >[洛克之羽] </font><font color='#ffffff' size='18' >白日门 </font><font color='#00ff00' size='18' >BOSS</font><font color='#ffffff' size='18' > 均可掉落!</font>]==========], 300, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(FrameLayout, "upBtn", 626, 52, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:setContentSize(upBtn, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开始打造]])
	GUI:Button_setTitleColor(upBtn, "#ffffff")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.00, 0.00)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create attrLayout
	local attrLayout = GUI:Layout_Create(FrameLayout, "attrLayout", 581, 244, 202, 186, false)
	GUI:setAnchorPoint(attrLayout, 0.00, 0.00)
	GUI:setTouchEnabled(attrLayout, false)
	GUI:setTag(attrLayout, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
