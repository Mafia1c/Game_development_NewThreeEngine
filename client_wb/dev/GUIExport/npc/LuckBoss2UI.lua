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
	GUI:setContentSize(Image_bg, 546, 330)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setAnchorPoint(Image_bg, 0.00, 1.00)
	GUI:setTouchEnabled(Image_bg, true)
	GUI:setTag(Image_bg, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(Image_bg, "closeBtn", 545, 330, "res/public/11.png")
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

	-- Create npcPoint1
	local npcPoint1 = GUI:Image_Create(Image_bg, "npcPoint1", 34, 282, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(npcPoint1, 0.00, 0.00)
	GUI:setTouchEnabled(npcPoint1, false)
	GUI:setTag(npcPoint1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(npcPoint1, "Text_1", 24, -4, 16, "#ffffff", [[如花：(可使用骰子与老板娘猜点数)]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(npcPoint1, "Text_2", 24, -61, 16, "#00ff00", [[小伙子看你面如桃花，身强力壮，可否与老娘一战？
若猜中老娘骰子的点数，包你爽歪歪！]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create pointSingle
	local pointSingle = GUI:Image_Create(npcPoint1, "pointSingle", 42, -97, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(pointSingle, 0.00, 0.00)
	GUI:setTouchEnabled(pointSingle, false)
	GUI:setTag(pointSingle, 0)
	GUI:setVisible(pointSingle, false)

	-- Create dice7
	local dice7 = GUI:Text_Create(pointSingle, "dice7", 18, -4, 16, "#ffff00", [[【我猜单数】]])
	GUI:Text_enableOutline(dice7, "#000000", 1)
	GUI:Text_enableUnderline(dice7)
	GUI:setAnchorPoint(dice7, 0.00, 0.00)
	GUI:setTouchEnabled(dice7, true)
	GUI:setTag(dice7, 0)

	-- Create pointDouble
	local pointDouble = GUI:Image_Create(npcPoint1, "pointDouble", 352, -97, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(pointDouble, 0.00, 0.00)
	GUI:setTouchEnabled(pointDouble, false)
	GUI:setTag(pointDouble, 0)
	GUI:setVisible(pointDouble, false)

	-- Create dice8
	local dice8 = GUI:Text_Create(pointDouble, "dice8", 18, -4, 16, "#ffff00", [[【我猜双数】]])
	GUI:Text_enableOutline(dice8, "#000000", 1)
	GUI:Text_enableUnderline(dice8)
	GUI:setAnchorPoint(dice8, 0.00, 0.00)
	GUI:setTouchEnabled(dice8, true)
	GUI:setTag(dice8, 0)

	-- Create point1
	local point1 = GUI:Image_Create(npcPoint1, "point1", 42, -113, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(point1, 0.00, 0.00)
	GUI:setTouchEnabled(point1, false)
	GUI:setTag(point1, 0)

	-- Create dice1
	local dice1 = GUI:Text_Create(point1, "dice1", 18, -4, 16, "#ffff00", [[【我猜一点】]])
	GUI:Text_enableOutline(dice1, "#000000", 1)
	GUI:Text_enableUnderline(dice1)
	GUI:setAnchorPoint(dice1, 0.00, 0.00)
	GUI:setTouchEnabled(dice1, true)
	GUI:setTag(dice1, 0)

	-- Create point2
	local point2 = GUI:Image_Create(npcPoint1, "point2", 190, -113, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(point2, 0.00, 0.00)
	GUI:setTouchEnabled(point2, false)
	GUI:setTag(point2, 0)

	-- Create dice2
	local dice2 = GUI:Text_Create(point2, "dice2", 18, -4, 16, "#ffff00", [[【我猜二点】]])
	GUI:Text_enableOutline(dice2, "#000000", 1)
	GUI:Text_enableUnderline(dice2)
	GUI:setAnchorPoint(dice2, 0.00, 0.00)
	GUI:setTouchEnabled(dice2, true)
	GUI:setTag(dice2, 0)

	-- Create point3
	local point3 = GUI:Image_Create(npcPoint1, "point3", 352, -113, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(point3, 0.00, 0.00)
	GUI:setTouchEnabled(point3, false)
	GUI:setTag(point3, 0)

	-- Create dice3
	local dice3 = GUI:Text_Create(point3, "dice3", 18, -4, 16, "#ffff00", [[【我猜三点】]])
	GUI:Text_enableOutline(dice3, "#000000", 1)
	GUI:Text_enableUnderline(dice3)
	GUI:setAnchorPoint(dice3, 0.00, 0.00)
	GUI:setTouchEnabled(dice3, true)
	GUI:setTag(dice3, 0)

	-- Create point4
	local point4 = GUI:Image_Create(npcPoint1, "point4", 42, -148, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(point4, 0.00, 0.00)
	GUI:setTouchEnabled(point4, false)
	GUI:setTag(point4, 0)

	-- Create dice4
	local dice4 = GUI:Text_Create(point4, "dice4", 18, -4, 16, "#ffff00", [[【我猜四点】]])
	GUI:Text_enableOutline(dice4, "#000000", 1)
	GUI:Text_enableUnderline(dice4)
	GUI:setAnchorPoint(dice4, 0.00, 0.00)
	GUI:setTouchEnabled(dice4, true)
	GUI:setTag(dice4, 0)

	-- Create point5
	local point5 = GUI:Image_Create(npcPoint1, "point5", 190, -148, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(point5, 0.00, 0.00)
	GUI:setTouchEnabled(point5, false)
	GUI:setTag(point5, 0)

	-- Create dice5
	local dice5 = GUI:Text_Create(point5, "dice5", 18, -4, 16, "#ffff00", [[【我猜五点】]])
	GUI:Text_enableOutline(dice5, "#000000", 1)
	GUI:Text_enableUnderline(dice5)
	GUI:setAnchorPoint(dice5, 0.00, 0.00)
	GUI:setTouchEnabled(dice5, true)
	GUI:setTag(dice5, 0)

	-- Create point6
	local point6 = GUI:Image_Create(npcPoint1, "point6", 352, -148, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(point6, 0.00, 0.00)
	GUI:setTouchEnabled(point6, false)
	GUI:setTag(point6, 0)

	-- Create dice6
	local dice6 = GUI:Text_Create(point6, "dice6", 18, -4, 16, "#ffff00", [[【我猜六点】]])
	GUI:Text_enableOutline(dice6, "#000000", 1)
	GUI:Text_enableUnderline(dice6)
	GUI:setAnchorPoint(dice6, 0.00, 0.00)
	GUI:setTouchEnabled(dice6, true)
	GUI:setTag(dice6, 0)

	-- Create tipsText
	local tipsText = GUI:Text_Create(npcPoint1, "tipsText", 240, -202, 16, "#ff0000", [[每一轮游戏30s，30s后参与玩家统一出结果]])
	GUI:Text_enableOutline(tipsText, "#000000", 1)
	GUI:setAnchorPoint(tipsText, 0.50, 0.50)
	GUI:setTouchEnabled(tipsText, false)
	GUI:setTag(tipsText, 0)

	-- Create timeText
	local timeText = GUI:Text_Create(npcPoint1, "timeText", 220, -240, 16, "#ff9b00", [[结算倒计时：]])
	GUI:Text_enableOutline(timeText, "#000000", 1)
	GUI:setAnchorPoint(timeText, 0.50, 0.50)
	GUI:setTouchEnabled(timeText, false)
	GUI:setTag(timeText, 0)

	-- Create hasTime
	local hasTime = GUI:Text_Create(timeText, "hasTime", 100, 0, 16, "#00ff00", [[0]])
	GUI:Text_enableOutline(hasTime, "#000000", 1)
	GUI:setAnchorPoint(hasTime, 0.00, 0.00)
	GUI:setTouchEnabled(hasTime, false)
	GUI:setTag(hasTime, 0)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
