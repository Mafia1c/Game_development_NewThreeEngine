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
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 676, 480, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/22zbhs/bg.png")
	GUI:setContentSize(FrameBG, 676, 480)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 641, 445, "res/public/01.png")
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

	-- Create autoBtn
	local autoBtn = GUI:Button_Create(FrameLayout, "autoBtn", 411, 25, "res/custom/npc/22zbhs/an3_1.png")
	GUI:Button_loadTexturePressed(autoBtn, "res/custom/npc/22zbhs/an3_2.png")
	GUI:setContentSize(autoBtn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(autoBtn, false)
	GUI:Button_setTitleText(autoBtn, [[]])
	GUI:Button_setTitleColor(autoBtn, "#ffffff")
	GUI:Button_setTitleFontSize(autoBtn, 16)
	GUI:Button_titleEnableOutline(autoBtn, "#000000", 1)
	GUI:setAnchorPoint(autoBtn, 0.00, 0.00)
	GUI:setTouchEnabled(autoBtn, true)
	GUI:setTag(autoBtn, 0)

	-- Create allBtn
	local allBtn = GUI:Button_Create(FrameLayout, "allBtn", 533, 26, "res/custom/npc/22zbhs/an2_1.png")
	GUI:Button_loadTexturePressed(allBtn, "res/custom/npc/22zbhs/an2_2.png")
	GUI:setContentSize(allBtn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(allBtn, false)
	GUI:Button_setTitleText(allBtn, [[]])
	GUI:Button_setTitleColor(allBtn, "#ffffff")
	GUI:Button_setTitleFontSize(allBtn, 16)
	GUI:Button_titleEnableOutline(allBtn, "#000000", 1)
	GUI:setAnchorPoint(allBtn, 0.00, 0.00)
	GUI:setTouchEnabled(allBtn, true)
	GUI:setTag(allBtn, 0)

	-- Create tipIcon
	local tipIcon = GUI:Image_Create(FrameLayout, "tipIcon", 416, 31, "res/custom/npc/22zbhs/gou.png")
	GUI:setAnchorPoint(tipIcon, 0.00, 0.00)
	GUI:setTouchEnabled(tipIcon, false)
	GUI:setTag(tipIcon, 0)
	GUI:setVisible(tipIcon, false)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 14, 90, 380, 347, 1)
	GUI:ListView_setGravity(ListView_1, 2)
	GUI:ListView_setItemsMargin(ListView_1, 2)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(FrameLayout, "ListView_2", 399, 76, 264, 324, 1)
	GUI:setAnchorPoint(ListView_2, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_2, true)
	GUI:setTag(ListView_2, 0)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(FrameLayout, "Panel_1", 25, 23, 96, 26, false)
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 0)

	-- Create yb_icon
	local yb_icon = GUI:Image_Create(Panel_1, "yb_icon", 5, 13, "res/custom/npc/g0.png")
	GUI:setAnchorPoint(yb_icon, 0.00, 0.50)
	GUI:setTouchEnabled(yb_icon, false)
	GUI:setTag(yb_icon, 0)

	-- Create yb_txt
	local yb_txt = GUI:Text_Create(Panel_1, "yb_txt", 30, 13, 16, "#ffff00", [[自动元宝]])
	GUI:Text_enableOutline(yb_txt, "#000000", 1)
	GUI:setAnchorPoint(yb_txt, 0.00, 0.50)
	GUI:setTouchEnabled(yb_txt, false)
	GUI:setTag(yb_txt, 0)

	-- Create Panel_2
	local Panel_2 = GUI:Layout_Create(FrameLayout, "Panel_2", 139, 23, 96, 26, false)
	GUI:setAnchorPoint(Panel_2, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_2, true)
	GUI:setTag(Panel_2, 0)

	-- Create jy_icon
	local jy_icon = GUI:Image_Create(Panel_2, "jy_icon", 5, 13, "res/custom/npc/g1.png")
	GUI:setAnchorPoint(jy_icon, 0.00, 0.50)
	GUI:setTouchEnabled(jy_icon, false)
	GUI:setTag(jy_icon, 0)

	-- Create jy_txt
	local jy_txt = GUI:Text_Create(Panel_2, "jy_txt", 30, 13, 16, "#ffff00", [[自动经验]])
	GUI:Text_enableOutline(jy_txt, "#000000", 1)
	GUI:setAnchorPoint(jy_txt, 0.00, 0.50)
	GUI:setTouchEnabled(jy_txt, false)
	GUI:setTag(jy_txt, 0)

	-- Create allSelect
	local allSelect = GUI:Button_Create(FrameLayout, "allSelect", 268, 18, "res/public/1900000673.png")
	GUI:Button_loadTexturePressed(allSelect, "res/public/1900000674.png")
	GUI:setContentSize(allSelect, 92, 35)
	GUI:setIgnoreContentAdaptWithSize(allSelect, false)
	GUI:Button_setTitleText(allSelect, [[一键全选]])
	GUI:Button_setTitleColor(allSelect, "#ffff00")
	GUI:Button_setTitleFontSize(allSelect, 16)
	GUI:Button_titleEnableOutline(allSelect, "#000000", 1)
	GUI:setAnchorPoint(allSelect, 0.00, 0.00)
	GUI:setTouchEnabled(allSelect, true)
	GUI:setTag(allSelect, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", -2, 253, 0, 16051, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create rate_txt
	local rate_txt = GUI:Text_Create(FrameLayout, "rate_txt", 192, 56, 16, "#009bff", [[回收元宝比例：0%]])
	GUI:Text_enableOutline(rate_txt, "#000000", 1)
	GUI:setAnchorPoint(rate_txt, 0.50, 0.00)
	GUI:setTouchEnabled(rate_txt, false)
	GUI:setTag(rate_txt, 0)

	-- Create Scene
	local Scene = GUI:Layout_Create(parent, "Scene", 0, 0, 1136, 640, false)
	GUI:Layout_setBackGroundColorType(Scene, 1)
	GUI:Layout_setBackGroundColor(Scene, "#000000")
	GUI:Layout_setBackGroundColorOpacity(Scene, 38)
	GUI:setAnchorPoint(Scene, 0.00, 0.00)
	GUI:setTouchEnabled(Scene, true)
	GUI:setMouseEnabled(Scene, true)
	GUI:setTag(Scene, 0)
	GUI:setVisible(Scene, false)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Scene, "Image_1", 411, 320, "res/public/1900000677.png")
	GUI:Image_setScale9Slice(Image_1, 6, 6, 33, 33)
	GUI:setContentSize(Image_1, 186, 426)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ItemList
	local ItemList = GUI:ListView_Create(Image_1, "ItemList", 3, 3, 180, 420, 1)
	GUI:setAnchorPoint(ItemList, 0.00, 0.00)
	GUI:setTouchEnabled(ItemList, true)
	GUI:setTag(ItemList, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
