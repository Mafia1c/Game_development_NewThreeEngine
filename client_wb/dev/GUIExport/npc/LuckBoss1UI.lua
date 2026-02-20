local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Layout_Create(parent, "Scene", 0, 0, _V("SCREEN_WIDTH"), _V("SCREEN_HEIGHT"), false)
	GUI:setAnchorPoint(Scene, 0.00, 0.00)
	GUI:setTouchEnabled(Scene, true)
	GUI:setTag(Scene, -1)

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Scene, "Image_bg", 0, _V("SCREEN_HEIGHT"), "res/public/bg_npc_01.png")
	GUI:Image_setScale9Slice(Image_bg, 0, 0, 0, 0)
	GUI:setContentSize(Image_bg, 546, 199)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setAnchorPoint(Image_bg, 0.00, 1.00)
	GUI:setTouchEnabled(Image_bg, true)
	GUI:setTag(Image_bg, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(Image_bg, "closeBtn", 545, 198, "res/public/11.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/12.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 1.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create point1
	local point1 = GUI:Image_Create(Image_bg, "point1", 34, 156, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(point1, 0.00, 0.00)
	GUI:setTouchEnabled(point1, false)
	GUI:setTag(point1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(point1, "Text_1", 24, -3, 16, "#ffffff", [[贾富贵：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(point1, "Text_2", 20, -84, 16, "#00ff00", [[老板好，你真的是太幸运了，给您准备了30个幸运骰子
听说美丽的老板娘是三朵金花，用运气战胜她们可获得神秘彩蛋。
小弟在这里祝您生意兴隆通四海，财源广进达三江。]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create point2
	local point2 = GUI:Image_Create(point1, "point2", 172, -126, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(point2, 0.00, 0.00)
	GUI:setTouchEnabled(point2, false)
	GUI:setTag(point2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(point2, "Text_3", 20, -4, 16, "#ffff00", [[【领取骰子】(每天每个角色仅可领取1次)]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:Text_enableUnderline(Text_3)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, true)
	GUI:setTag(Text_3, 0)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
