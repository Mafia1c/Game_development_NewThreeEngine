local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Node_Create(parent, "Scene", 0, 0)
	GUI:setChineseName(Scene, "排行榜场景")
	GUI:setTag(Scene, -1)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(Scene, "Panel_1", 534, 329, 581, 444, false)
	GUI:setChineseName(Panel_1, "排行榜组合")
	GUI:setAnchorPoint(Panel_1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 30)
	TAGOBJ["30"] = Panel_1

	-- Create Panel_bg
	local Panel_bg = GUI:Layout_Create(Panel_1, "Panel_bg", 0, 226, 582, 402, false)
	GUI:setChineseName(Panel_bg, "排行榜_背景组合")
	GUI:setAnchorPoint(Panel_bg, 0.00, 0.50)
	GUI:setTouchEnabled(Panel_bg, false)
	GUI:setTag(Panel_bg, 31)
	TAGOBJ["31"] = Panel_bg

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_bg, "Image_bg", 291, 201, "res/private/rank_ui/rank_ui_win32/1900020020.png")
	GUI:Image_setScale9Slice(Image_bg, 58, 58, 134, 134)
	GUI:setContentSize(Image_bg, 582, 402)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "排行榜_背景图")
	GUI:setAnchorPoint(Image_bg, 0.50, 0.50)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 32)
	TAGOBJ["32"] = Image_bg

	-- Create Panel_type
	local Panel_type = GUI:Layout_Create(Panel_1, "Panel_type", 136, 392, 185, 45, false)
	GUI:setChineseName(Panel_type, "排行榜_玩家和英雄组合")
	GUI:setAnchorPoint(Panel_type, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_type, true)
	GUI:setTag(Panel_type, 107)
	TAGOBJ["107"] = Panel_type

	-- Create Panel_player
	local Panel_player = GUI:Layout_Create(Panel_type, "Panel_player", 47, 19, 88, 33, false)
	GUI:setChineseName(Panel_player, "排行榜_玩家组合")
	GUI:setAnchorPoint(Panel_player, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_player, false)
	GUI:setTag(Panel_player, 108)
	TAGOBJ["108"] = Panel_player

	-- Create Button_1
	local Button_1 = GUI:Button_Create(Panel_player, "Button_1", 44, 16, "res/private/rank_ui/rank_ui_win32/1900012110.png")
	GUI:Button_loadTexturePressed(Button_1, "res/private/rank_ui/rank_ui_win32/1900012111.png")
	GUI:Button_loadTextureDisabled(Button_1, "res/private/rank_ui/rank_ui_win32/1900012111.png")
	GUI:Button_setScale9Slice(Button_1, 11, 10, 25, 25)
	GUI:setContentSize(Button_1, 33, 88)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#414146")
	GUI:Button_setTitleFontSize(Button_1, 14)
	GUI:Button_titleDisableOutLine(Button_1)
	GUI:setChineseName(Button_1, "排行榜_玩家_按钮")
	GUI:setAnchorPoint(Button_1, 0.50, 0.50)
	GUI:setRotation(Button_1, 90.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 109)
	TAGOBJ["109"] = Button_1

	-- Create Text_title1
	local Text_title1 = GUI:Text_Create(Panel_player, "Text_title1", 41, 26, 18, "#6c6861", [[玩家]])
	GUI:Text_enableOutline(Text_title1, "#111111", 2)
	GUI:setChineseName(Text_title1, "排行榜_玩家_文本")
	GUI:setAnchorPoint(Text_title1, 0.50, 1.00)
	GUI:setTouchEnabled(Text_title1, false)
	GUI:setTag(Text_title1, 110)
	TAGOBJ["110"] = Text_title1

	-- Create Panel_hero
	local Panel_hero = GUI:Layout_Create(Panel_type, "Panel_hero", 137, 19, 88, 33, false)
	GUI:setChineseName(Panel_hero, "排行榜_英雄组合")
	GUI:setAnchorPoint(Panel_hero, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_hero, false)
	GUI:setTag(Panel_hero, 111)
	TAGOBJ["111"] = Panel_hero

	-- Create Button_2
	local Button_2 = GUI:Button_Create(Panel_hero, "Button_2", 44, 16, "res/private/rank_ui/rank_ui_win32/1900012110.png")
	GUI:Button_loadTexturePressed(Button_2, "res/private/rank_ui/rank_ui_win32/1900012111.png")
	GUI:Button_loadTextureDisabled(Button_2, "res/private/rank_ui/rank_ui_win32/1900012111.png")
	GUI:Button_setScale9Slice(Button_2, 11, 10, 25, 25)
	GUI:setContentSize(Button_2, 33, 88)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#414146")
	GUI:Button_setTitleFontSize(Button_2, 14)
	GUI:Button_titleDisableOutLine(Button_2)
	GUI:setChineseName(Button_2, "排行榜_英雄_按钮")
	GUI:setAnchorPoint(Button_2, 0.50, 0.50)
	GUI:setRotation(Button_2, 90.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 112)
	TAGOBJ["112"] = Button_2

	-- Create Text_title2
	local Text_title2 = GUI:Text_Create(Panel_hero, "Text_title2", 41, 26, 18, "#6c6861", [[英雄]])
	GUI:Text_enableOutline(Text_title2, "#111111", 2)
	GUI:setChineseName(Text_title2, "排行榜_英雄_文本")
	GUI:setAnchorPoint(Text_title2, 0.50, 1.00)
	GUI:setTouchEnabled(Text_title2, false)
	GUI:setTag(Text_title2, 113)
	TAGOBJ["113"] = Text_title2

	-- Create Panel_btnList
	local Panel_btnList = GUI:Layout_Create(Panel_1, "Panel_btnList", -106, 40, 110, 354, false)
	GUI:setChineseName(Panel_btnList, "排行榜_排行分类组合")
	GUI:setAnchorPoint(Panel_btnList, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_btnList, true)
	GUI:setTag(Panel_btnList, 33)
	GUI:setVisible(Panel_btnList, false)
	TAGOBJ["33"] = Panel_btnList

	-- Create ListView_btn
	local ListView_btn = GUI:ListView_Create(Panel_btnList, "ListView_btn", 0, 354, 112, 354, 1)
	GUI:ListView_setGravity(ListView_btn, 2)
	GUI:setChineseName(ListView_btn, "排行榜_排行分类_列表")
	GUI:setAnchorPoint(ListView_btn, 0.00, 1.00)
	GUI:setTouchEnabled(ListView_btn, true)
	GUI:setTag(ListView_btn, 34)
	TAGOBJ["34"] = ListView_btn

	-- Create Panel_content
	local Panel_content = GUI:Layout_Create(Panel_1, "Panel_content", 13, 40, 558, 354, false)
	GUI:setAnchorPoint(Panel_content, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_content, false)
	GUI:setTag(Panel_content, -1)

	-- Create ListView_list
	local ListView_list = GUI:ListView_Create(Panel_content, "ListView_list", 5, 41, 370, 307, 1)
	GUI:setChineseName(ListView_list, "排行榜_排行详细_列表")
	GUI:setAnchorPoint(ListView_list, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_list, true)
	GUI:setTag(ListView_list, 46)
	TAGOBJ["46"] = ListView_list

	-- Create Node_model
	local Node_model = GUI:Node_Create(Panel_content, "Node_model", 452, 158)
	GUI:setChineseName(Node_model, "排行榜_模型_节点")
	GUI:setTag(Node_model, 47)
	TAGOBJ["47"] = Node_model

	-- Create Button_looks
	local Button_looks = GUI:Button_Create(Panel_content, "Button_looks", 452, 36, "res/public_win32/1900000679.png")
	GUI:Button_loadTexturePressed(Button_looks, "res/public_win32/1900000679_1.png")
	GUI:Button_setScale9Slice(Button_looks, 15, 15, 11, 11)
	GUI:setContentSize(Button_looks, 72, 32)
	GUI:setIgnoreContentAdaptWithSize(Button_looks, false)
	GUI:Button_setTitleText(Button_looks, [[查看]])
	GUI:Button_setTitleColor(Button_looks, "#f8e6c6")
	GUI:Button_setTitleFontSize(Button_looks, 18)
	GUI:Button_titleEnableOutline(Button_looks, "#111111", 2)
	GUI:setChineseName(Button_looks, "排行榜_查看_按钮")
	GUI:setAnchorPoint(Button_looks, 0.50, 0.50)
	GUI:setTouchEnabled(Button_looks, true)
	GUI:setTag(Button_looks, 48)
	TAGOBJ["48"] = Button_looks

	-- Create Panel_myInfo
	local Panel_myInfo = GUI:Layout_Create(Panel_content, "Panel_myInfo", 5, 7, 370, 26, false)
	GUI:setChineseName(Panel_myInfo, "排行榜_我的信息组合")
	GUI:setAnchorPoint(Panel_myInfo, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_myInfo, true)
	GUI:setTag(Panel_myInfo, 57)
	TAGOBJ["57"] = Panel_myInfo

	-- Create Text_5
	local Text_5 = GUI:Text_Create(Panel_myInfo, "Text_5", 101, 12, 14, "#ffffff", [[我的排名：]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setChineseName(Text_5, "排行榜_我的排名_文本")
	GUI:setAnchorPoint(Text_5, 1.00, 0.50)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 58)
	TAGOBJ["58"] = Text_5

	-- Create Text_level
	local Text_level = GUI:Text_Create(Panel_myInfo, "Text_level", 106, 13, 14, "#ffffff", [[未上榜]])
	GUI:Text_enableOutline(Text_level, "#000000", 1)
	GUI:setChineseName(Text_level, "排行榜_名次_文本")
	GUI:setAnchorPoint(Text_level, 0.00, 0.50)
	GUI:setTouchEnabled(Text_level, false)
	GUI:setTag(Text_level, 59)
	TAGOBJ["59"] = Text_level

	-- Create Text_7
	local Text_7 = GUI:Text_Create(Panel_myInfo, "Text_7", 264, 12, 14, "#ffffff", [[所属行会：]])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setChineseName(Text_7, "排行榜_所属行会_文本")
	GUI:setAnchorPoint(Text_7, 1.00, 0.50)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 60)
	TAGOBJ["60"] = Text_7

	-- Create Text_guildName
	local Text_guildName = GUI:Text_Create(Panel_myInfo, "Text_guildName", 269, 13, 14, "#ffffff", [[无]])
	GUI:Text_enableOutline(Text_guildName, "#000000", 1)
	GUI:setChineseName(Text_guildName, "排行榜_行会名称_文本")
	GUI:setAnchorPoint(Text_guildName, 0.00, 0.50)
	GUI:setTouchEnabled(Text_guildName, false)
	GUI:setTag(Text_guildName, 61)
	TAGOBJ["61"] = Text_guildName

	-- Create Image_title
	local Image_title = GUI:Image_Create(Panel_1, "Image_title", 422, 405, "res/private/rank_ui/rank_ui_win32/1900020024.png")
	GUI:setChineseName(Image_title, "排行榜_标题_图片")
	GUI:setAnchorPoint(Image_title, 0.50, 0.50)
	GUI:setTouchEnabled(Image_title, false)
	GUI:setTag(Image_title, 35)
	GUI:setVisible(Image_title, false)
	TAGOBJ["35"] = Image_title

	-- Create Button_close
	local Button_close = GUI:Button_Create(Panel_1, "Button_close", 561, 410, "res/public_win32/01.png")
	GUI:Button_loadTexturePressed(Button_close, "res/public_win32/02.png")
	GUI:Button_setScale9Slice(Button_close, 3, 3, 10, 10)
	GUI:setContentSize(Button_close, 30, 30)
	GUI:setIgnoreContentAdaptWithSize(Button_close, false)
	GUI:Button_setTitleText(Button_close, [[]])
	GUI:Button_setTitleColor(Button_close, "#414146")
	GUI:Button_setTitleFontSize(Button_close, 14)
	GUI:Button_titleDisableOutLine(Button_close)
	GUI:setChineseName(Button_close, "排行榜_关闭_按钮")
	GUI:setAnchorPoint(Button_close, 0.50, 0.50)
	GUI:setTouchEnabled(Button_close, true)
	GUI:setTag(Button_close, 49)
	TAGOBJ["49"] = Button_close

	-- Create TouchSize
	local TouchSize = GUI:Layout_Create(Button_close, "TouchSize", -23, -17, 70, 70, false)
	GUI:setChineseName(TouchSize, "排行榜_关闭_触摸")
	GUI:setAnchorPoint(TouchSize, 0.00, 0.00)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, 50)
	GUI:setVisible(TouchSize, false)
	TAGOBJ["50"] = TouchSize

	-- Create rank_page_1
	local rank_page_1 = GUI:Button_Create(Panel_1, "rank_page_1", -31, 300, "res/private/rank_ui/rank_ui_win32/rbtn10.png")
	GUI:Button_loadTexturePressed(rank_page_1, "res/private/rank_ui/rank_ui_win32/rbtn10.png")
	GUI:Button_setTitleText(rank_page_1, [[]])
	GUI:Button_setTitleColor(rank_page_1, "#ffffff")
	GUI:Button_setTitleFontSize(rank_page_1, 16)
	GUI:Button_titleEnableOutline(rank_page_1, "#000000", 1)
	GUI:setAnchorPoint(rank_page_1, 0.00, 0.00)
	GUI:setTouchEnabled(rank_page_1, true)
	GUI:setTag(rank_page_1, 0)

	-- Create rank_page_2
	local rank_page_2 = GUI:Button_Create(Panel_1, "rank_page_2", -31, 205, "res/private/rank_ui/rank_ui_win32/rbtn20.png")
	GUI:Button_loadTexturePressed(rank_page_2, "res/private/rank_ui/rank_ui_win32/rbtn20.png")
	GUI:Button_setTitleText(rank_page_2, [[]])
	GUI:Button_setTitleColor(rank_page_2, "#ffffff")
	GUI:Button_setTitleFontSize(rank_page_2, 16)
	GUI:Button_titleEnableOutline(rank_page_2, "#000000", 1)
	GUI:setAnchorPoint(rank_page_2, 0.00, 0.00)
	GUI:setTouchEnabled(rank_page_2, true)
	GUI:setTag(rank_page_2, 0)

	-- Create rank_page_3
	local rank_page_3 = GUI:Button_Create(Panel_1, "rank_page_3", -31, 110, "res/private/rank_ui/rank_ui_win32/rbtn30.png")
	GUI:Button_loadTexturePressed(rank_page_3, "res/private/rank_ui/rank_ui_win32/rbtn30.png")
	GUI:Button_setTitleText(rank_page_3, [[]])
	GUI:Button_setTitleColor(rank_page_3, "#ffffff")
	GUI:Button_setTitleFontSize(rank_page_3, 16)
	GUI:Button_titleEnableOutline(rank_page_3, "#000000", 1)
	GUI:setAnchorPoint(rank_page_3, 0.00, 0.00)
	GUI:setTouchEnabled(rank_page_3, true)
	GUI:setTag(rank_page_3, 0)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
