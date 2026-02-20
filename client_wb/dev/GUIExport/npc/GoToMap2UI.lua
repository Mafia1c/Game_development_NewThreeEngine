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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 754, 474, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/01dtcs/mb.png")
	GUI:Image_setScale9Slice(FrameBG, 75, 75, 158, 158)
	GUI:setContentSize(FrameBG, 754, 474)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 711, 421, "res/custom/npc/01dtcs/close.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/01dtcs/close2.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create miniMapImg
	local miniMapImg = GUI:Image_Create(FrameLayout, "miniMapImg", 317, 278, "scene/uiminimap/100010.png")
	GUI:setContentSize(miniMapImg, 291, 237)
	GUI:setIgnoreContentAdaptWithSize(miniMapImg, false)
	GUI:setAnchorPoint(miniMapImg, 0.50, 0.50)
	GUI:setTouchEnabled(miniMapImg, false)
	GUI:setTag(miniMapImg, 0)

	-- Create mapInfo
	local mapInfo = GUI:Node_Create(FrameLayout, "mapInfo", 481, 238)
	GUI:setTag(mapInfo, 0)

	-- Create title_1
	local title_1 = GUI:Text_Create(mapInfo, "title_1", 2, 86, 18, "#00ff00", [[地图说明:]])
	GUI:Text_enableOutline(title_1, "#000000", 1)
	GUI:setAnchorPoint(title_1, 0.00, 0.00)
	GUI:setTouchEnabled(title_1, false)
	GUI:setTag(title_1, 0)

	-- Create title_2
	local title_2 = GUI:Text_Create(mapInfo, "title_2", 2, 60, 18, "#00ff00", [[B  O  S  S:]])
	GUI:Text_enableOutline(title_2, "#000000", 1)
	GUI:setAnchorPoint(title_2, 0.00, 0.00)
	GUI:setTouchEnabled(title_2, false)
	GUI:setTag(title_2, 0)

	-- Create title_3
	local title_3 = GUI:Text_Create(mapInfo, "title_3", 2, 33, 18, "#00ff00", [[刷新时间:]])
	GUI:Text_enableOutline(title_3, "#000000", 1)
	GUI:setAnchorPoint(title_3, 0.00, 0.00)
	GUI:setTouchEnabled(title_3, false)
	GUI:setTag(title_3, 0)

	-- Create title_4
	local title_4 = GUI:Text_Create(mapInfo, "title_4", 2, 6, 18, "#00ff00", [[地图难度:]])
	GUI:Text_enableOutline(title_4, "#000000", 1)
	GUI:setAnchorPoint(title_4, 0.00, 0.00)
	GUI:setTouchEnabled(title_4, false)
	GUI:setTag(title_4, 0)

	-- Create joinInfo
	local joinInfo = GUI:Node_Create(FrameLayout, "joinInfo", 589, 151)
	GUI:setTag(joinInfo, 0)

	-- Create title_icon
	local title_icon = GUI:Image_Create(FrameLayout, "title_icon", 365, 410, "res/custom/npc/01dtcs/dtm/dtmz01.png")
	GUI:setContentSize(title_icon, 210, 60)
	GUI:setIgnoreContentAdaptWithSize(title_icon, false)
	GUI:setAnchorPoint(title_icon, 0.50, 0.00)
	GUI:setTouchEnabled(title_icon, false)
	GUI:setTag(title_icon, 0)

	-- Create enterBtn
	local enterBtn = GUI:Button_Create(FrameLayout, "enterBtn", 524, 55, "res/custom/npc/01dtcs/an.png")
	GUI:Button_loadTexturePressed(enterBtn, "res/custom/npc/01dtcs/an2.png")
	GUI:setContentSize(enterBtn, 126, 46)
	GUI:setIgnoreContentAdaptWithSize(enterBtn, false)
	GUI:Button_setTitleText(enterBtn, [[]])
	GUI:Button_setTitleColor(enterBtn, "#ffffff")
	GUI:Button_setTitleFontSize(enterBtn, 16)
	GUI:Button_titleEnableOutline(enterBtn, "#000000", 1)
	GUI:setAnchorPoint(enterBtn, 0.00, 0.00)
	GUI:setTouchEnabled(enterBtn, true)
	GUI:setTag(enterBtn, 0)

	-- Create bossImg
	local bossImg = GUI:Image_Create(FrameLayout, "bossImg", -110, -1, "res/custom/npc/01dtcs/boss/boss01.png")
	GUI:setContentSize(bossImg, 278, 474)
	GUI:setIgnoreContentAdaptWithSize(bossImg, false)
	GUI:setAnchorPoint(bossImg, 0.00, 0.00)
	GUI:setTouchEnabled(bossImg, false)
	GUI:setTag(bossImg, 0)

	-- Create dropItems
	local dropItems = GUI:Node_Create(FrameLayout, "dropItems", 312, 77)
	GUI:setTag(dropItems, 0)

	-- Create kf_eff
	local kf_eff = GUI:Effect_Create(FrameLayout, "kf_eff", 59, 268, 0, 16064, 0, 0, 0, 1)
	GUI:setTag(kf_eff, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
