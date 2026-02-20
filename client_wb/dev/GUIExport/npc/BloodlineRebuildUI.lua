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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 738, 500, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/12tmfw/2/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 73, 73, 166, 166)
	GUI:setContentSize(FrameBG, 738, 500)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(FrameLayout, "Image_4", 250, 449, "res/custom/npc/12tmfw/2/z2.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 146, 76, 18, "#deded6", [[使用：天命石*1，可刷新当前天命符文]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create count_text
	local count_text = GUI:Text_Create(FrameLayout, "count_text", 476, 81, 18, "#f0b42a", [[拥有天命石：0]])
	GUI:Text_enableOutline(count_text, "#000000", 1)
	GUI:setAnchorPoint(count_text, 0.00, 0.00)
	GUI:setTouchEnabled(count_text, false)
	GUI:setTag(count_text, 0)

	-- Create rebuild_node
	local rebuild_node = GUI:Node_Create(FrameLayout, "rebuild_node", 377, 288)
	GUI:setTag(rebuild_node, 0)

	-- Create kapai_1
	local kapai_1 = GUI:Image_Create(rebuild_node, "kapai_1", -119, -141, "res/custom/npc/12tmfw/2/k111.png")
	GUI:setAnchorPoint(kapai_1, 0.00, 0.00)
	GUI:setTouchEnabled(kapai_1, false)
	GUI:setTag(kapai_1, 0)

	-- Create icon_1
	local icon_1 = GUI:Image_Create(kapai_1, "icon_1", 81, 173, "res/custom/npc/12tmfw/icon/100.png")
	GUI:setAnchorPoint(icon_1, 0.00, 0.00)
	GUI:setTouchEnabled(icon_1, false)
	GUI:setTag(icon_1, 0)

	-- Create quality_1
	local quality_1 = GUI:Image_Create(kapai_1, "quality_1", 18, 164, "res/custom/npc/12tmfw/2/t444.png")
	GUI:setAnchorPoint(quality_1, 0.00, 0.00)
	GUI:setTouchEnabled(quality_1, false)
	GUI:setTag(quality_1, 0)

	-- Create name_1
	local name_1 = GUI:Text_Create(kapai_1, "name_1", 107, 249, 18, "#ffffff", [[回春]])
	GUI:Text_enableOutline(name_1, "#000000", 1)
	GUI:setAnchorPoint(name_1, 0.50, 0.50)
	GUI:setTouchEnabled(name_1, false)
	GUI:setTag(name_1, 0)

	-- Create select_1
	local select_1 = GUI:Button_Create(kapai_1, "select_1", 54, -33, "res/custom/npc/12tmfw/2/an.png")
	GUI:setContentSize(select_1, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(select_1, false)
	GUI:Button_setTitleText(select_1, [[]])
	GUI:Button_setTitleColor(select_1, "#ffffff")
	GUI:Button_setTitleFontSize(select_1, 16)
	GUI:Button_titleDisableOutLine(select_1)
	GUI:setAnchorPoint(select_1, 0.00, 0.00)
	GUI:setTouchEnabled(select_1, true)
	GUI:setTag(select_1, 0)

	-- Create kapai_2
	local kapai_2 = GUI:Image_Create(rebuild_node, "kapai_2", -336, -141, "res/custom/npc/12tmfw/2/k444.png")
	GUI:setAnchorPoint(kapai_2, 0.00, 0.00)
	GUI:setTouchEnabled(kapai_2, false)
	GUI:setTag(kapai_2, 0)

	-- Create icon_2
	local icon_2 = GUI:Image_Create(kapai_2, "icon_2", 81, 173, "res/custom/npc/12tmfw/icon/100.png")
	GUI:setAnchorPoint(icon_2, 0.00, 0.00)
	GUI:setTouchEnabled(icon_2, false)
	GUI:setTag(icon_2, 0)

	-- Create quality_2
	local quality_2 = GUI:Image_Create(kapai_2, "quality_2", 18, 164, "res/custom/npc/12tmfw/2/t444.png")
	GUI:setAnchorPoint(quality_2, 0.00, 0.00)
	GUI:setTouchEnabled(quality_2, false)
	GUI:setTag(quality_2, 0)

	-- Create name_2
	local name_2 = GUI:Text_Create(kapai_2, "name_2", 107, 249, 18, "#ffffff", [[回春]])
	GUI:Text_enableOutline(name_2, "#000000", 1)
	GUI:setAnchorPoint(name_2, 0.50, 0.50)
	GUI:setTouchEnabled(name_2, false)
	GUI:setTag(name_2, 0)

	-- Create select_2
	local select_2 = GUI:Button_Create(kapai_2, "select_2", 54, -33, "res/custom/npc/12tmfw/2/an.png")
	GUI:setContentSize(select_2, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(select_2, false)
	GUI:Button_setTitleText(select_2, [[]])
	GUI:Button_setTitleColor(select_2, "#ffffff")
	GUI:Button_setTitleFontSize(select_2, 16)
	GUI:Button_titleDisableOutLine(select_2)
	GUI:setAnchorPoint(select_2, 0.00, 0.00)
	GUI:setTouchEnabled(select_2, true)
	GUI:setTag(select_2, 0)

	-- Create kapai_3
	local kapai_3 = GUI:Image_Create(rebuild_node, "kapai_3", 99, -141, "res/custom/npc/12tmfw/2/k444.png")
	GUI:setAnchorPoint(kapai_3, 0.00, 0.00)
	GUI:setTouchEnabled(kapai_3, false)
	GUI:setTag(kapai_3, 0)

	-- Create icon_3
	local icon_3 = GUI:Image_Create(kapai_3, "icon_3", 81, 173, "res/custom/npc/12tmfw/icon/100.png")
	GUI:setAnchorPoint(icon_3, 0.00, 0.00)
	GUI:setTouchEnabled(icon_3, false)
	GUI:setTag(icon_3, 0)

	-- Create quality_3
	local quality_3 = GUI:Image_Create(kapai_3, "quality_3", 18, 164, "res/custom/npc/12tmfw/2/t444.png")
	GUI:setAnchorPoint(quality_3, 0.00, 0.00)
	GUI:setTouchEnabled(quality_3, false)
	GUI:setTag(quality_3, 0)

	-- Create name_3
	local name_3 = GUI:Text_Create(kapai_3, "name_3", 107, 249, 18, "#ffffff", [[回春]])
	GUI:Text_enableOutline(name_3, "#000000", 1)
	GUI:setAnchorPoint(name_3, 0.50, 0.50)
	GUI:setTouchEnabled(name_3, false)
	GUI:setTag(name_3, 0)

	-- Create select_3
	local select_3 = GUI:Button_Create(kapai_3, "select_3", 54, -33, "res/custom/npc/12tmfw/2/an.png")
	GUI:setContentSize(select_3, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(select_3, false)
	GUI:Button_setTitleText(select_3, [[]])
	GUI:Button_setTitleColor(select_3, "#ffffff")
	GUI:Button_setTitleFontSize(select_3, 16)
	GUI:Button_titleDisableOutLine(select_3)
	GUI:setAnchorPoint(select_3, 0.00, 0.00)
	GUI:setTouchEnabled(select_3, true)
	GUI:setTag(select_3, 0)

	-- Create reflush_btn
	local reflush_btn = GUI:Button_Create(rebuild_node, "reflush_btn", 110, -249, "res/custom/npc/an.png")
	GUI:setContentSize(reflush_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(reflush_btn, false)
	GUI:Button_setTitleText(reflush_btn, [[刷新]])
	GUI:Button_setTitleColor(reflush_btn, "#efd6ad")
	GUI:Button_setTitleFontSize(reflush_btn, 18)
	GUI:Button_titleEnableOutline(reflush_btn, "#000000", 1)
	GUI:setAnchorPoint(reflush_btn, 0.00, 0.00)
	GUI:setTouchEnabled(reflush_btn, true)
	GUI:setTag(reflush_btn, 0)

	-- Create show_select_node
	local show_select_node = GUI:Node_Create(FrameLayout, "show_select_node", 377, 288)
	GUI:setTag(show_select_node, 0)
	GUI:setVisible(show_select_node, false)

	-- Create start_rebuild_btn
	local start_rebuild_btn = GUI:Button_Create(show_select_node, "start_rebuild_btn", -64, -175, "res/custom/npc/an.png")
	GUI:setContentSize(start_rebuild_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(start_rebuild_btn, false)
	GUI:Button_setTitleText(start_rebuild_btn, [[开始重修]])
	GUI:Button_setTitleColor(start_rebuild_btn, "#efd6ad")
	GUI:Button_setTitleFontSize(start_rebuild_btn, 18)
	GUI:Button_titleEnableOutline(start_rebuild_btn, "#000000", 1)
	GUI:setAnchorPoint(start_rebuild_btn, 0.00, 0.00)
	GUI:setTouchEnabled(start_rebuild_btn, true)
	GUI:setTag(start_rebuild_btn, 0)

	-- Create select_kapai
	local select_kapai = GUI:Image_Create(show_select_node, "select_kapai", -119, -141, "res/custom/npc/12tmfw/2/k444.png")
	GUI:setAnchorPoint(select_kapai, 0.00, 0.00)
	GUI:setTouchEnabled(select_kapai, false)
	GUI:setTag(select_kapai, 0)

	-- Create select_icon
	local select_icon = GUI:Image_Create(select_kapai, "select_icon", 81, 173, "res/custom/npc/12tmfw/icon/100.png")
	GUI:setAnchorPoint(select_icon, 0.00, 0.00)
	GUI:setTouchEnabled(select_icon, false)
	GUI:setTag(select_icon, 0)

	-- Create select_quality
	local select_quality = GUI:Image_Create(select_kapai, "select_quality", 18, 164, "res/custom/npc/12tmfw/2/t444.png")
	GUI:setAnchorPoint(select_quality, 0.00, 0.00)
	GUI:setTouchEnabled(select_quality, false)
	GUI:setTag(select_quality, 0)

	-- Create select_name
	local select_name = GUI:Text_Create(select_kapai, "select_name", 107, 249, 18, "#ffffff", [[回春]])
	GUI:Text_enableOutline(select_name, "#000000", 1)
	GUI:setAnchorPoint(select_name, 0.50, 0.50)
	GUI:setTouchEnabled(select_name, false)
	GUI:setTag(select_name, 0)

	-- Create cancel_btn
	local cancel_btn = GUI:Button_Create(show_select_node, "cancel_btn", 100, -248, "res/custom/npc/an.png")
	GUI:setContentSize(cancel_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(cancel_btn, false)
	GUI:Button_setTitleText(cancel_btn, [[取消]])
	GUI:Button_setTitleColor(cancel_btn, "#efd6ad")
	GUI:Button_setTitleFontSize(cancel_btn, 18)
	GUI:Button_titleEnableOutline(cancel_btn, "#000000", 1)
	GUI:setAnchorPoint(cancel_btn, 0.00, 0.00)
	GUI:setTouchEnabled(cancel_btn, true)
	GUI:setTag(cancel_btn, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 198, 40, 18, "#00ff00", [[每刷新10次必出传说天命！]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
