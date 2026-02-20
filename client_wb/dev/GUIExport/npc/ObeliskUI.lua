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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 788, 550, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/49zht/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 78, 78, 183, 183)
	GUI:setContentSize(FrameBG, 788, 550)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 709, 448, "res/custom/npc/01dtcs/close.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/01dtcs/close2.png")
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create enterBtn
	local enterBtn = GUI:Button_Create(FrameLayout, "enterBtn", 349, 73, "res/custom/npc/49zht/btn1.png")
	GUI:Button_loadTexturePressed(enterBtn, "res/custom/npc/49zht/btn2.png")
	GUI:Button_setTitleText(enterBtn, [[]])
	GUI:Button_setTitleColor(enterBtn, "#ffffff")
	GUI:Button_setTitleFontSize(enterBtn, 18)
	GUI:Button_titleEnableOutline(enterBtn, "#000000", 1)
	GUI:setAnchorPoint(enterBtn, 0.00, 0.00)
	GUI:setTouchEnabled(enterBtn, true)
	GUI:setTag(enterBtn, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(FrameLayout, "Effect_1", 142, 338, 0, 16064, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create infoNode
	local infoNode = GUI:Node_Create(FrameLayout, "infoNode", 270, 243)
	GUI:setTag(infoNode, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(infoNode, "Text_1", 0, -17, 18, "#ffff00", [[BOSS刷新时间: ]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(infoNode, "Text_2", 0, -87, 18, "#ff0000", [[战斗地图, 死亡不掉装备, 不加PK值!]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Frames_1
	local Frames_1 = GUI:Frames_Create(infoNode, "Frames_1", 167, -6, "res/custom/help/help", ".png", 1, 12, {count=12, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(Frames_1, 0.50, 0.50)
	GUI:setTouchEnabled(Frames_1, true)
	GUI:setTag(Frames_1, 0)

	-- Create maskLayout
	local maskLayout = GUI:Layout_Create(FrameLayout, "maskLayout", 0, 0, 788, 550, false)
	GUI:setAnchorPoint(maskLayout, 0.00, 0.00)
	GUI:setTouchEnabled(maskLayout, true)
	GUI:setMouseEnabled(maskLayout, true)
	GUI:setTag(maskLayout, 0)
	GUI:setVisible(maskLayout, false)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(maskLayout, "Image_1", 168, 180, "res/public/1900000600.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(Image_1, "Text_3", 26, 137, 16, "#ffffff", [[怪物刷新时间:]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(Image_1, "Text_4", 26, 109, 16, "#ffffff", [[01:15    04:15    07:15    10:15]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(Image_1, "Text_5", 26, 83, 16, "#ffffff", [[13:15    16:15    19:15    22:15]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create okBtn
	local okBtn = GUI:Button_Create(Image_1, "okBtn", 347, 20, "res/public/1900000679.png")
	GUI:Button_loadTexturePressed(okBtn, "res/public/1900000679_1.png")
	GUI:Button_setTitleText(okBtn, [[确定]])
	GUI:Button_setTitleColor(okBtn, "#ffffff")
	GUI:Button_setTitleFontSize(okBtn, 18)
	GUI:Button_titleEnableOutline(okBtn, "#000000", 1)
	GUI:setAnchorPoint(okBtn, 0.00, 0.00)
	GUI:setTouchEnabled(okBtn, true)
	GUI:setTag(okBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
