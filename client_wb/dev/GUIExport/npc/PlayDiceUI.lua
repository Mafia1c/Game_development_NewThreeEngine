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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 536, 240, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/21fb/mfbg/ddbg.png")
	GUI:Image_setScale9Slice(FrameBG, 53, 53, 80, 80)
	GUI:setContentSize(FrameBG, 536, 240)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 514, 219, "res/public/01.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/02.png")
	GUI:setContentSize(closeBtn, 30, 30)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create playBtn
	local playBtn = GUI:Button_Create(FrameLayout, "playBtn", 185, 32, "res/custom/npc/21fb/mfbg/ksy1.png")
	GUI:Button_loadTexturePressed(playBtn, "res/custom/npc/21fb/mfbg/ksy2.png")
	GUI:setContentSize(playBtn, 150, 42)
	GUI:setIgnoreContentAdaptWithSize(playBtn, false)
	GUI:Button_setTitleText(playBtn, [[]])
	GUI:Button_setTitleColor(playBtn, "#ff9b00")
	GUI:Button_setTitleFontSize(playBtn, 20)
	GUI:Button_titleEnableOutline(playBtn, "#000000", 1)
	GUI:setAnchorPoint(playBtn, 0.00, 0.00)
	GUI:setTouchEnabled(playBtn, true)
	GUI:setTag(playBtn, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 344, 40, 16, "#ffff00", [[消耗: 命运骰子*1]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create dice_1
	local dice_1 = GUI:Image_Create(FrameLayout, "dice_1", 64, 141, "res/custom/npc/21fb/mfbg/dice1.png")
	GUI:setAnchorPoint(dice_1, 0.50, 0.50)
	GUI:setTouchEnabled(dice_1, true)
	GUI:setTag(dice_1, 0)

	-- Create dice_2
	local dice_2 = GUI:Image_Create(FrameLayout, "dice_2", 145, 141, "res/custom/npc/21fb/mfbg/dice2.png")
	GUI:setAnchorPoint(dice_2, 0.50, 0.50)
	GUI:setTouchEnabled(dice_2, true)
	GUI:setTag(dice_2, 0)

	-- Create dice_3
	local dice_3 = GUI:Image_Create(FrameLayout, "dice_3", 227, 141, "res/custom/npc/21fb/mfbg/dice3.png")
	GUI:setAnchorPoint(dice_3, 0.50, 0.50)
	GUI:setTouchEnabled(dice_3, true)
	GUI:setTag(dice_3, 0)

	-- Create dice_4
	local dice_4 = GUI:Image_Create(FrameLayout, "dice_4", 309, 141, "res/custom/npc/21fb/mfbg/dice4.png")
	GUI:setAnchorPoint(dice_4, 0.50, 0.50)
	GUI:setTouchEnabled(dice_4, true)
	GUI:setTag(dice_4, 0)

	-- Create dice_5
	local dice_5 = GUI:Image_Create(FrameLayout, "dice_5", 393, 141, "res/custom/npc/21fb/mfbg/dice5.png")
	GUI:setAnchorPoint(dice_5, 0.50, 0.50)
	GUI:setTouchEnabled(dice_5, true)
	GUI:setTag(dice_5, 0)

	-- Create dice_6
	local dice_6 = GUI:Image_Create(FrameLayout, "dice_6", 475, 141, "res/custom/npc/21fb/mfbg/dice6.png")
	GUI:setAnchorPoint(dice_6, 0.50, 0.50)
	GUI:setTouchEnabled(dice_6, true)
	GUI:setTag(dice_6, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 62, 140, 0, 4004, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
