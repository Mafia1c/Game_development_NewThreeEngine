local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(parent, "Panel_1", 678, 322, 305, 428, false)
	GUI:setChineseName(Panel_1, "玩家面板_组合")
	GUI:setAnchorPoint(Panel_1, 1.00, 0.50)
	GUI:setTouchEnabled(Panel_1, false)
	GUI:setTag(Panel_1, 125)
	TAGOBJ["125"] = Panel_1

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_1, "Image_bg", 152, 214, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015000.png")
	GUI:setChineseName(Image_bg, "玩家面板_背景图")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 131)
	TAGOBJ["131"] = Image_bg

	-- Create Text_Name
	local Text_Name = GUI:Text_Create(Panel_1, "Text_Name", 189, 403, 18, "#ffe400", [[]])
	GUI:Text_enableOutline(Text_Name, "#0e0e0e", 1)
	GUI:setChineseName(Text_Name, "玩家面板_玩家昵称_文本")
	GUI:setAnchorPoint(Text_Name, 0.50, 0.50)
	GUI:setTouchEnabled(Text_Name, true)
	GUI:setTag(Text_Name, 132)
	TAGOBJ["132"] = Text_Name

	-- Create ButtonClose
	local ButtonClose = GUI:Button_Create(Panel_1, "ButtonClose", 321, 374, "res/public_win32/1900000510.png")
	GUI:Button_loadTextureDisabled(ButtonClose, "Default/Button_Disable.png")
	GUI:Button_setTitleText(ButtonClose, [[]])
	GUI:Button_setTitleColor(ButtonClose, "#414146")
	GUI:Button_setTitleFontSize(ButtonClose, 14)
	GUI:Button_titleDisableOutLine(ButtonClose)
	GUI:setChineseName(ButtonClose, "玩家面板_关闭按钮")
	GUI:setAnchorPoint(ButtonClose, 0.50, 0.50)
	GUI:setTouchEnabled(ButtonClose, true)
	GUI:setTag(ButtonClose, 133)
	TAGOBJ["133"] = ButtonClose

	-- Create Node_panel
	local Node_panel = GUI:Node_Create(Panel_1, "Node_panel", 16, 14)
	GUI:setChineseName(Node_panel, "玩家面板_节点")
	GUI:setTag(Node_panel, 134)
	TAGOBJ["134"] = Node_panel

	-- Create Panel_btnList
	local Panel_btnList = GUI:Layout_Create(Panel_1, "Panel_btnList", 304, 348, 24, 340, false)
	GUI:setChineseName(Panel_btnList, "玩家面板_侧边条组合")
	GUI:setAnchorPoint(Panel_btnList, 0.00, 1.00)
	GUI:setTouchEnabled(Panel_btnList, false)
	GUI:setTag(Panel_btnList, 130)
	TAGOBJ["130"] = Panel_btnList

	-- Create Button_101
	local Button_101 = GUI:Button_Create(Panel_btnList, "Button_101", 0, 340, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_101, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTextureDisabled(Button_101, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_101, 26, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_101, false)
	GUI:Button_setTitleText(Button_101, [[]])
	GUI:Button_setTitleColor(Button_101, "#414146")
	GUI:Button_setTitleFontSize(Button_101, 14)
	GUI:Button_titleDisableOutLine(Button_101)
	GUI:setChineseName(Button_101, "玩家面板_装备_按钮")
	GUI:setAnchorPoint(Button_101, 0.00, 1.00)
	GUI:setTouchEnabled(Button_101, true)
	GUI:setTag(Button_101, 127)
	TAGOBJ["127"] = Button_101

	-- Create Text_name
	local Text_name = GUI:Text_Create(Button_101, "Text_name", 11, 62, 13, "#807256", [[装
备]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_装备_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	-- Create Button_105
	local Button_105 = GUI:Button_Create(Panel_btnList, "Button_105", 0, 283, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_105, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:Button_loadTextureDisabled(Button_105, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_105, 26, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_105, false)
	GUI:Button_setTitleText(Button_105, [[]])
	GUI:Button_setTitleColor(Button_105, "#414146")
	GUI:Button_setTitleFontSize(Button_105, 14)
	GUI:Button_titleDisableOutLine(Button_105)
	GUI:setChineseName(Button_105, "玩家面板_称号_按钮")
	GUI:setAnchorPoint(Button_105, 0.00, 1.00)
	GUI:setTouchEnabled(Button_105, true)
	GUI:setTag(Button_105, 127)
	TAGOBJ["127"] = Button_105

	-- Create Text_name
	Text_name = GUI:Text_Create(Button_105, "Text_name", 11, 62, 13, "#807256", [[称
号]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_称号_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	-- Create Button_106
	local Button_106 = GUI:Button_Create(Panel_btnList, "Button_106", 0, 226, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_106, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:Button_loadTextureDisabled(Button_106, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_106, 26, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_106, false)
	GUI:Button_setTitleText(Button_106, [[]])
	GUI:Button_setTitleColor(Button_106, "#414146")
	GUI:Button_setTitleFontSize(Button_106, 14)
	GUI:Button_titleDisableOutLine(Button_106)
	GUI:setChineseName(Button_106, "玩家面板_时装_按钮")
	GUI:setAnchorPoint(Button_106, 0.00, 1.00)
	GUI:setTouchEnabled(Button_106, true)
	GUI:setTag(Button_106, 127)
	TAGOBJ["127"] = Button_106

	-- Create Text_name
	Text_name = GUI:Text_Create(Button_106, "Text_name", 11, 62, 13, "#807256", [[时
装]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_时装_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	-- Create Button_112
	local Button_112 = GUI:Button_Create(Panel_btnList, "Button_112", 0, 170, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015011.png")
	GUI:Button_loadTexturePressed(Button_112, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:Button_loadTextureDisabled(Button_112, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015010.png")
	GUI:setContentSize(Button_112, 26, 67)
	GUI:setIgnoreContentAdaptWithSize(Button_112, false)
	GUI:Button_setTitleText(Button_112, [[]])
	GUI:Button_setTitleColor(Button_112, "#414146")
	GUI:Button_setTitleFontSize(Button_112, 14)
	GUI:Button_titleEnableOutline(Button_112, "#000000", 1)
	GUI:setChineseName(Button_112, "玩家面板_buff_按钮")
	GUI:setAnchorPoint(Button_112, 0.00, 1.00)
	GUI:setTouchEnabled(Button_112, true)
	GUI:setTag(Button_112, 127)
	GUI:setVisible(Button_112, false)
	TAGOBJ["127"] = Button_112

	-- Create Text_name
	Text_name = GUI:Text_Create(Button_112, "Text_name", 11, 62, 13, "#807256", [[天
赋]])
	GUI:Text_enableOutline(Text_name, "#111111", 2)
	GUI:setChineseName(Text_name, "玩家面板_buff_文本")
	GUI:setAnchorPoint(Text_name, 0.50, 1.00)
	GUI:setTouchEnabled(Text_name, false)
	GUI:setTag(Text_name, 128)
	TAGOBJ["128"] = Text_name

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Panel_1, "Image_1", -46, 0, "res/custom/mbtn/mbg5.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(Image_1, "Button_1", 5, 287, "res/custom/mbtn/a11.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/mbtn/a12.png")
	GUI:setContentSize(Button_1, 30, 52)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(Image_1, "Button_2", 5, 227, "res/custom/mbtn/a21.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/mbtn/a22.png")
	GUI:setContentSize(Button_2, 30, 52)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(Image_1, "Button_3", 5, 165, "res/custom/mbtn/a31.png")
	GUI:Button_loadTexturePressed(Button_3, "res/custom/mbtn/a32.png")
	GUI:setContentSize(Button_3, 30, 52)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(Image_1, "Button_4", 5, 105, "res/custom/mbtn/a41.png")
	GUI:Button_loadTexturePressed(Button_4, "res/custom/mbtn/a42.png")
	GUI:setContentSize(Button_4, 30, 52)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 16)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(Image_1, "Button_5", 5, 46, "res/custom/mbtn/a51.png")
	GUI:Button_loadTexturePressed(Button_5, "res/custom/mbtn/a52.png")
	GUI:setContentSize(Button_5, 30, 52)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[]])
	GUI:Button_setTitleColor(Button_5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_5, 16)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.00, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	ui.update(__data__)
	return Panel_1
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
