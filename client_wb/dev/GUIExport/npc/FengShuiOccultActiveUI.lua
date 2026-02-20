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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 730, 516, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/31mishu/msbg.png")
	GUI:Image_setScale9Slice(FrameBG, 73, 73, 172, 172)
	GUI:setContentSize(FrameBG, 730, 516)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameLayout, "close_btn", 624, 327, "res/custom/npc/01dtcs/close.png")
	GUI:Button_loadTexturePressed(close_btn, "res/custom/npc/01dtcs/close2.png")
	GUI:setContentSize(close_btn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(close_btn, false)
	GUI:Button_setTitleText(close_btn, [[]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleDisableOutLine(close_btn)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 329, 169, "res/custom/npc/31mishu/8gua.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create unlock_node
	local unlock_node = GUI:Node_Create(FrameLayout, "unlock_node", 367, 206)
	GUI:setTag(unlock_node, 0)

	-- Create tip_text
	local tip_text = GUI:Text_Create(unlock_node, "tip_text", 6, -166, 18, "#00ff00", [==========[提示：使用[          ]可解封秘术]==========])
	GUI:Text_enableOutline(tip_text, "#000000", 1)
	GUI:setAnchorPoint(tip_text, 0.50, 0.50)
	GUI:setTouchEnabled(tip_text, false)
	GUI:setTag(tip_text, 0)

	-- Create item_text
	local item_text = GUI:Text_Create(tip_text, "item_text", 117, 12, 18, "#ffff00", [[罗盘]])
	GUI:Text_enableOutline(item_text, "#000000", 1)
	GUI:Text_enableUnderline(item_text)
	GUI:setAnchorPoint(item_text, 0.50, 0.50)
	GUI:setTouchEnabled(item_text, true)
	GUI:setTag(item_text, 0)

	-- Create unlock_btn
	local unlock_btn = GUI:Button_Create(unlock_node, "unlock_btn", -57, -149, "res/custom/npc/31mishu/lwms11.png")
	GUI:Button_loadTexturePressed(unlock_btn, "res/custom/npc/31mishu/lwms12.png")
	GUI:setContentSize(unlock_btn, 126, 46)
	GUI:setIgnoreContentAdaptWithSize(unlock_btn, false)
	GUI:Button_setTitleText(unlock_btn, [[]])
	GUI:Button_setTitleColor(unlock_btn, "#ffffff")
	GUI:Button_setTitleFontSize(unlock_btn, 16)
	GUI:Button_titleDisableOutLine(unlock_btn)
	GUI:setAnchorPoint(unlock_btn, 0.00, 0.00)
	GUI:setTouchEnabled(unlock_btn, true)
	GUI:setTag(unlock_btn, 0)

	-- Create item_cell
	local item_cell = GUI:ItemShow_Create(unlock_node, "item_cell", 0, 1, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_cell, 0.50, 0.50)
	GUI:setTag(item_cell, 0)
	GUI:setVisible(item_cell, false)

	-- Create look_btn
	local look_btn = GUI:Button_Create(unlock_node, "look_btn", 13, -145, "res/custom/npc/31mishu/msk1.png")
	GUI:Button_loadTexturePressed(look_btn, "res/custom/npc/31mishu/msk2.png")
	GUI:setContentSize(look_btn, 126, 46)
	GUI:setIgnoreContentAdaptWithSize(look_btn, false)
	GUI:Button_setTitleText(look_btn, [[]])
	GUI:Button_setTitleColor(look_btn, "#ffffff")
	GUI:Button_setTitleFontSize(look_btn, 16)
	GUI:Button_titleDisableOutLine(look_btn)
	GUI:setAnchorPoint(look_btn, 0.00, 0.00)
	GUI:setTouchEnabled(look_btn, true)
	GUI:setTag(look_btn, 0)
	GUI:setVisible(look_btn, false)

	-- Create continue_btn
	local continue_btn = GUI:Button_Create(unlock_node, "continue_btn", -137, -145, "res/custom/npc/31mishu/jxjf1.png")
	GUI:Button_loadTexturePressed(continue_btn, "res/custom/npc/31mishu/jxjf2.png")
	GUI:setContentSize(continue_btn, 126, 46)
	GUI:setIgnoreContentAdaptWithSize(continue_btn, false)
	GUI:Button_setTitleText(continue_btn, [[]])
	GUI:Button_setTitleColor(continue_btn, "#ffffff")
	GUI:Button_setTitleFontSize(continue_btn, 16)
	GUI:Button_titleDisableOutLine(continue_btn)
	GUI:setAnchorPoint(continue_btn, 0.00, 0.00)
	GUI:setTouchEnabled(continue_btn, true)
	GUI:setTag(continue_btn, 0)
	GUI:setVisible(continue_btn, false)

	-- Create play_ani_node
	local play_ani_node = GUI:Node_Create(FrameLayout, "play_ani_node", 365, 206)
	GUI:setTag(play_ani_node, 0)
	GUI:setVisible(play_ani_node, false)

	-- Create text22
	local text22 = GUI:Text_Create(play_ani_node, "text22", 4, -142, 18, "#ff0000", [[···正在解封秘术···]])
	GUI:Text_enableOutline(text22, "#000000", 1)
	GUI:setAnchorPoint(text22, 0.50, 0.50)
	GUI:setTouchEnabled(text22, false)
	GUI:setTag(text22, 0)

	-- Create unlock_ani_node
	local unlock_ani_node = GUI:Node_Create(play_ani_node, "unlock_ani_node", -2, 1)
	GUI:setTag(unlock_ani_node, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
