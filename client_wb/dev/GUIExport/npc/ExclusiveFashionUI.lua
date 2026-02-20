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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 1, -3, "res/custom/npc/50zh/bg7.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameLayout, "close_btn", 785, 490, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(close_btn, "res/custom/npc/close2.png")
	GUI:setContentSize(close_btn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(close_btn, false)
	GUI:Button_setTitleText(close_btn, [[]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleDisableOutLine(close_btn)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 195, 421, "res/custom/npc/tip.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create name_text
	local name_text = GUI:Text_Create(Image_1, "name_text", 128, 17, 18, "#ff00ff", [==========[[魔兽]麒麟兽]==========])
	GUI:Text_enableOutline(name_text, "#000000", 1)
	GUI:setAnchorPoint(name_text, 0.50, 0.50)
	GUI:setTouchEnabled(name_text, false)
	GUI:setTag(name_text, 0)

	-- Create ItemShow
	local ItemShow = GUI:ItemShow_Create(FrameLayout, "ItemShow", 680, 375, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow, 0.50, 0.50)
	GUI:setTag(ItemShow, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 613, 260, 18, "#c6c6ce", [[↑点击查看属性↑]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create item_name
	local item_name = GUI:Text_Create(FrameLayout, "item_name", 684, 318, 18, "#ffff00", [==========[[魔兽麒麟兽]]==========])
	GUI:Text_enableOutline(item_name, "#000000", 1)
	GUI:Text_enableUnderline(item_name)
	GUI:setAnchorPoint(item_name, 0.50, 0.50)
	GUI:setTouchEnabled(item_name, true)
	GUI:setTag(item_name, 0)

	-- Create need_item
	local need_item = GUI:ItemShow_Create(FrameLayout, "need_item", 648, 149, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(need_item, 0.50, 0.50)
	GUI:setTag(need_item, 0)

	-- Create need_item_2
	local need_item_2 = GUI:ItemShow_Create(FrameLayout, "need_item_2", 722, 149, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(need_item_2, 0.50, 0.50)
	GUI:setTag(need_item_2, 0)

	-- Create dazao_btn
	local dazao_btn = GUI:Button_Create(FrameLayout, "dazao_btn", 629, 57, "res/custom/npc/32mj/anb1.png")
	GUI:Button_loadTexturePressed(dazao_btn, "res/custom/npc/32mj/anb2.png")
	GUI:setContentSize(dazao_btn, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(dazao_btn, false)
	GUI:Button_setTitleText(dazao_btn, [[开始打造]])
	GUI:Button_setTitleColor(dazao_btn, "#d6c6ad")
	GUI:Button_setTitleFontSize(dazao_btn, 18)
	GUI:Button_titleEnableOutline(dazao_btn, "#000000", 1)
	GUI:setAnchorPoint(dazao_btn, 0.00, 0.00)
	GUI:setTouchEnabled(dazao_btn, true)
	GUI:setTag(dazao_btn, 0)

	-- Create effect_node
	local effect_node = GUI:Node_Create(FrameLayout, "effect_node", 322, 282)
	GUI:setTag(effect_node, 0)

	-- Create role_model
	local role_model = GUI:Effect_Create(FrameLayout, "role_model", 287, 201, 4, 1, 0, 0, 4, 1)
	GUI:setScale(role_model, 1.20)
	GUI:setTag(role_model, 0)
	GUI:setVisible(role_model, false)

	-- Create tip_btn
	local tip_btn = GUI:Layout_Create(FrameLayout, "tip_btn", 220, 152, 184, 120, false)
	GUI:setAnchorPoint(tip_btn, 0.00, 0.00)
	GUI:setTouchEnabled(tip_btn, true)
	GUI:setTag(tip_btn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
