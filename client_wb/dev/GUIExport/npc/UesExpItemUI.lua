local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Layout_Create(parent, "Scene", 0, 0, _V("SCREEN_WIDTH"), _V("SCREEN_HEIGHT"), false)
	GUI:setAnchorPoint(Scene, 0.00, 0.00)
	GUI:setTouchEnabled(Scene, false)
	GUI:setTag(Scene, -1)

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Scene, "Image_bg", _V("SCREEN_WIDTH") * 0.1188, _V("SCREEN_HEIGHT") * 0.85, "res/custom/npc/54jyj/bg.png")
	GUI:setContentSize(Image_bg, 453, 391)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setAnchorPoint(Image_bg, 0.00, 1.00)
	GUI:setTouchEnabled(Image_bg, true)
	GUI:setMouseEnabled(Image_bg, true)
	GUI:setTag(Image_bg, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(Image_bg, "closeBtn", 412, 346, "res/public/01.png")
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

	-- Create tips_1
	local tips_1 = GUI:Text_Create(Image_bg, "tips_1", 92, 312, 16, "#00ff00", [[本服经验卷完全靠打,   等级好升,   免费]])
	GUI:Text_enableOutline(tips_1, "#000000", 1)
	GUI:setAnchorPoint(tips_1, 0.00, 0.00)
	GUI:setTouchEnabled(tips_1, false)
	GUI:setTag(tips_1, 0)

	-- Create tips_2
	local tips_2 = GUI:RichText_Create(Image_bg, "tips_2", 34, 52, [[<font color='#ffffff' size='16' >想快速升级可到</font><font color='#ffff00' size='16' >拍卖行</font><font color='#ffffff' size='16' >秒经验珠</font>]], 240, 16, "#ffffff", 4)
	GUI:setAnchorPoint(tips_2, 0.00, 0.00)
	GUI:setTag(tips_2, 0)

	-- Create tips_3
	local tips_3 = GUI:RichText_Create(Image_bg, "tips_3", 34, 26, [[<font color='#ffff00' size='16' >越高级</font><font color='#ffffff' size='16' >地图, BOSS爆经验珠越多</font>]], 240, 16, "#ffffff", 4)
	GUI:setAnchorPoint(tips_3, 0.00, 0.00)
	GUI:setTag(tips_3, 0)

	-- Create LoadingBar_bg
	local LoadingBar_bg = GUI:Image_Create(Image_bg, "LoadingBar_bg", 213, 354, "res/custom/npc/54jyj/jd1.png")
	GUI:setAnchorPoint(LoadingBar_bg, 0.50, 0.00)
	GUI:setTouchEnabled(LoadingBar_bg, false)
	GUI:setTag(LoadingBar_bg, 0)

	-- Create LoadingBar_1
	local LoadingBar_1 = GUI:LoadingBar_Create(Image_bg, "LoadingBar_1", 213, 354, "res/custom/npc/54jyj/jd.png", 0)
	GUI:LoadingBar_setPercent(LoadingBar_1, 61)
	GUI:setAnchorPoint(LoadingBar_1, 0.50, 0.00)
	GUI:setTouchEnabled(LoadingBar_1, false)
	GUI:setTag(LoadingBar_1, 0)

	-- Create LoadingBar_value
	local LoadingBar_value = GUI:Text_Create(Image_bg, "LoadingBar_value", 213, 352, 14, "#ffff00", [[50/100]])
	GUI:Text_enableOutline(LoadingBar_value, "#000000", 1)
	GUI:setAnchorPoint(LoadingBar_value, 0.50, 0.00)
	GUI:setTouchEnabled(LoadingBar_value, false)
	GUI:setTag(LoadingBar_value, 0)

	-- Create ItemCellList
	local ItemCellList = GUI:ListView_Create(Image_bg, "ItemCellList", 14, 86, 425, 218, 1)
	GUI:ListView_setGravity(ItemCellList, 2)
	GUI:ListView_setItemsMargin(ItemCellList, 1)
	GUI:setAnchorPoint(ItemCellList, 0.00, 0.00)
	GUI:setTouchEnabled(ItemCellList, true)
	GUI:setTag(ItemCellList, 0)

	-- Create layout_check
	local layout_check = GUI:Layout_Create(Image_bg, "layout_check", 285, 53, 130, 24, false)
	GUI:setAnchorPoint(layout_check, 0.00, 0.00)
	GUI:setTouchEnabled(layout_check, true)
	GUI:setTag(layout_check, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(layout_check, "Image_1", 0, 12, "res/public/000263.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(layout_check, "Text_1", 29, 12, 16, "#ffff00", [[屏蔽双倍提示]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create all_check
	local all_check = GUI:Layout_Create(Image_bg, "all_check", 285, 21, 130, 24, false)
	GUI:setAnchorPoint(all_check, 0.00, 0.00)
	GUI:setTouchEnabled(all_check, true)
	GUI:setTag(all_check, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(all_check, "Image_2", 0, 12, "res/public/000263.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.50)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(all_check, "Text_1", 29, 12, 16, "#ffff00", [[一键全部使用]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
