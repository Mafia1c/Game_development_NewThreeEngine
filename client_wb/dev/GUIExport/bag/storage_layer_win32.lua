local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Node_Create(parent, "Scene", 0, 0)
	GUI:setChineseName(Scene, "仓库场景")
	GUI:setTag(Scene, -1)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(Scene, "Panel_1", 35, 380, 365, 305, false)
	GUI:setChineseName(Panel_1, "仓库组合框")
	GUI:setAnchorPoint(Panel_1, 0.00, 0.50)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 49)
	TAGOBJ["49"] = Panel_1

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_1, "Image_bg", 182, 152, "res/public_win32/bg_npc_06_win32.png")
	GUI:setChineseName(Image_bg, "仓库_背景图片")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 50)
	TAGOBJ["50"] = Image_bg

	-- Create Node_page
	local Node_page = GUI:Node_Create(Panel_1, "Node_page", 360, 273)
	GUI:setChineseName(Node_page, "仓库_描点页")
	GUI:setTag(Node_page, 51)
	TAGOBJ["51"] = Node_page

	-- Create Button_page1
	local Button_page1 = GUI:Button_Create(Panel_1, "Button_page1", 360, 253, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_page1, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTextureDisabled(Button_page1, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_page1, 26, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_page1, false)
	GUI:Button_setTitleText(Button_page1, [[]])
	GUI:Button_setTitleColor(Button_page1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page1, 14)
	GUI:Button_titleEnableOutline(Button_page1, "#000000", 1)
	GUI:setChineseName(Button_page1, "仓库_第一页_组合框")
	GUI:setAnchorPoint(Button_page1, 0.00, 0.50)
	GUI:setTouchEnabled(Button_page1, false)
	GUI:setTag(Button_page1, -1)
	GUI:setVisible(Button_page1, false)

	-- Create PageText
	local PageText = GUI:Text_Create(Button_page1, "PageText", 10, 45, 13, "#ffffff", [[一]])
	GUI:Text_enableOutline(PageText, "#000000", 2)
	GUI:setChineseName(PageText, "仓库_第一页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	local TouchSize = GUI:Layout_Create(Button_page1, "TouchSize", 0, 67, 24, 67, false)
	GUI:setChineseName(TouchSize, "仓库_第一页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page2
	local Button_page2 = GUI:Button_Create(Panel_1, "Button_page2", 360, 194, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_page2, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTextureDisabled(Button_page2, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_page2, 26, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_page2, false)
	GUI:Button_setTitleText(Button_page2, [[]])
	GUI:Button_setTitleColor(Button_page2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page2, 14)
	GUI:Button_titleEnableOutline(Button_page2, "#000000", 1)
	GUI:setChineseName(Button_page2, "仓库_第二页_组合框")
	GUI:setAnchorPoint(Button_page2, 0.00, 0.50)
	GUI:setTouchEnabled(Button_page2, false)
	GUI:setTag(Button_page2, -1)
	GUI:setVisible(Button_page2, false)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page2, "PageText", 10, 45, 13, "#ffffff", [[二]])
	GUI:Text_enableOutline(PageText, "#000000", 2)
	GUI:setChineseName(PageText, "仓库_第二页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page2, "TouchSize", 0, 67, 24, 67, false)
	GUI:setChineseName(TouchSize, "仓库_第二页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page3
	local Button_page3 = GUI:Button_Create(Panel_1, "Button_page3", 360, 135, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_page3, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTextureDisabled(Button_page3, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_page3, 26, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_page3, false)
	GUI:Button_setTitleText(Button_page3, [[]])
	GUI:Button_setTitleColor(Button_page3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page3, 14)
	GUI:Button_titleEnableOutline(Button_page3, "#000000", 1)
	GUI:setChineseName(Button_page3, "仓库_第三页_组合框")
	GUI:setAnchorPoint(Button_page3, 0.00, 0.50)
	GUI:setTouchEnabled(Button_page3, false)
	GUI:setTag(Button_page3, -1)
	GUI:setVisible(Button_page3, false)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page3, "PageText", 10, 45, 13, "#ffffff", [[三]])
	GUI:Text_enableOutline(PageText, "#000000", 2)
	GUI:setChineseName(PageText, "仓库_第三页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page3, "TouchSize", 0, 67, 24, 67, false)
	GUI:setChineseName(TouchSize, "仓库_第三页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page4
	local Button_page4 = GUI:Button_Create(Panel_1, "Button_page4", 360, 76, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_page4, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTextureDisabled(Button_page4, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_page4, 26, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_page4, false)
	GUI:Button_setTitleText(Button_page4, [[]])
	GUI:Button_setTitleColor(Button_page4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page4, 14)
	GUI:Button_titleEnableOutline(Button_page4, "#000000", 1)
	GUI:setChineseName(Button_page4, "仓库_第四页_组合框")
	GUI:setAnchorPoint(Button_page4, 0.00, 0.50)
	GUI:setTouchEnabled(Button_page4, false)
	GUI:setTag(Button_page4, -1)
	GUI:setVisible(Button_page4, false)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page4, "PageText", 10, 45, 13, "#ffffff", [[四]])
	GUI:Text_enableOutline(PageText, "#000000", 2)
	GUI:setChineseName(PageText, "仓库_第四页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page4, "TouchSize", 0, 67, 24, 67, false)
	GUI:setChineseName(TouchSize, "仓库_第四页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_page5
	local Button_page5 = GUI:Button_Create(Panel_1, "Button_page5", 360, 17, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_page5, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTextureDisabled(Button_page5, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_page5, 26, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_page5, false)
	GUI:Button_setTitleText(Button_page5, [[]])
	GUI:Button_setTitleColor(Button_page5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_page5, 14)
	GUI:Button_titleEnableOutline(Button_page5, "#000000", 1)
	GUI:setChineseName(Button_page5, "仓库_第五页_组合框")
	GUI:setAnchorPoint(Button_page5, 0.00, 0.50)
	GUI:setTouchEnabled(Button_page5, false)
	GUI:setTag(Button_page5, -1)
	GUI:setVisible(Button_page5, false)

	-- Create PageText
	PageText = GUI:Text_Create(Button_page5, "PageText", 10, 45, 13, "#ffffff", [[五]])
	GUI:Text_enableOutline(PageText, "#000000", 2)
	GUI:setChineseName(PageText, "仓库_第五页_文本")
	GUI:setAnchorPoint(PageText, 0.50, 0.50)
	GUI:setTouchEnabled(PageText, false)
	GUI:setTag(PageText, -1)

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_page5, "TouchSize", 0, 67, 24, 67, false)
	GUI:setChineseName(TouchSize, "仓库_第五页_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, -1)

	-- Create Button_quick
	local Button_quick = GUI:Button_Create(Panel_1, "Button_quick", 77, 16, "res/private/bag_ui/bag_ui_win32/1900015210.png")
	GUI:Button_loadTexturePressed(Button_quick, "res/private/bag_ui/bag_ui_win32/1900015211.png")
	GUI:Button_setScale9Slice(Button_quick, 15, 15, 4, 4)
	GUI:setContentSize(Button_quick, 59, 21)
	GUI:setIgnoreContentAdaptWithSize(Button_quick, false)
	GUI:Button_setTitleText(Button_quick, [[快速存取]])
	GUI:Button_setTitleColor(Button_quick, "#ffe400")
	GUI:Button_setTitleFontSize(Button_quick, 12)
	GUI:Button_titleEnableOutline(Button_quick, "#111111", 2)
	GUI:setChineseName(Button_quick, "仓库_快速存取按钮")
	GUI:setAnchorPoint(Button_quick, 0.50, 0.50)
	GUI:setTouchEnabled(Button_quick, true)
	GUI:setTag(Button_quick, 52)
	TAGOBJ["52"] = Button_quick

	-- Create Button_reset
	local Button_reset = GUI:Button_Create(Panel_1, "Button_reset", 265, 16, "res/private/bag_ui/bag_ui_win32/1900015210.png")
	GUI:Button_loadTexturePressed(Button_reset, "res/private/bag_ui/bag_ui_win32/1900015211.png")
	GUI:Button_setScale9Slice(Button_reset, 15, 15, 4, 4)
	GUI:setContentSize(Button_reset, 59, 21)
	GUI:setIgnoreContentAdaptWithSize(Button_reset, false)
	GUI:Button_setTitleText(Button_reset, [[仓库整理]])
	GUI:Button_setTitleColor(Button_reset, "#ffe400")
	GUI:Button_setTitleFontSize(Button_reset, 12)
	GUI:Button_titleEnableOutline(Button_reset, "#111111", 2)
	GUI:setChineseName(Button_reset, "仓库_仓库整理按钮")
	GUI:setAnchorPoint(Button_reset, 0.50, 0.50)
	GUI:setTouchEnabled(Button_reset, true)
	GUI:setTag(Button_reset, 53)
	TAGOBJ["53"] = Button_reset

	-- Create Button_close
	local Button_close = GUI:Button_Create(Panel_1, "Button_close", 347, 314, "res/public_win32/01.png")
	GUI:Button_loadTexturePressed(Button_close, "res/public_win32/02.png")
	GUI:setContentSize(Button_close, 30, 30)
	GUI:setIgnoreContentAdaptWithSize(Button_close, false)
	GUI:Button_setTitleText(Button_close, [[]])
	GUI:Button_setTitleColor(Button_close, "#414146")
	GUI:Button_setTitleFontSize(Button_close, 14)
	GUI:Button_titleDisableOutLine(Button_close)
	GUI:setChineseName(Button_close, "仓库_关闭按钮")
	GUI:setAnchorPoint(Button_close, 0.50, 0.50)
	GUI:setTouchEnabled(Button_close, true)
	GUI:setTag(Button_close, 54)
	TAGOBJ["54"] = Button_close

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(Button_close, "TouchSize", 0, 40, 40, 51, false)
	GUI:setChineseName(TouchSize, "仓库_关闭_触摸区域")
	GUI:setAnchorPoint(TouchSize, 0.00, 1.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, 55)
	GUI:setVisible(TouchSize, false)
	TAGOBJ["55"] = TouchSize

	-- Create Panel_items
	local Panel_items = GUI:Layout_Create(Panel_1, "Panel_items", 14, 291, 336, 254, false)
	GUI:setChineseName(Panel_items, "仓库_物品")
	GUI:setAnchorPoint(Panel_items, 0.00, 1.00)
	GUI:setTouchEnabled(Panel_items, true)
	GUI:setTag(Panel_items, 56)
	TAGOBJ["56"] = Panel_items

	-- Create Panel_itemstouch
	local Panel_itemstouch = GUI:Layout_Create(Panel_1, "Panel_itemstouch", 14, 291, 336, 254, false)
	GUI:setChineseName(Panel_itemstouch, "仓库_物品触摸区域")
	GUI:setAnchorPoint(Panel_itemstouch, 0.00, 1.00)
	GUI:setTouchEnabled(Panel_itemstouch, false)
	GUI:setTag(Panel_itemstouch, 57)
	TAGOBJ["57"] = Panel_itemstouch

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
