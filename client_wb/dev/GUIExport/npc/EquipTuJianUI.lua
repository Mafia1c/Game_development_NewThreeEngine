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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 832, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/31zbtj/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 83, 83, 188, 188)
	GUI:setContentSize(FrameBG, 832, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 791, 505, "res/public/01.png")
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

	-- Create quick_btn
	local quick_btn = GUI:Button_Create(FrameLayout, "quick_btn", 735, 179, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(quick_btn, "res/custom/npc/close2.png")
	GUI:setContentSize(quick_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(quick_btn, false)
	GUI:Button_setTitleText(quick_btn, [[快速完成]])
	GUI:Button_setTitleColor(quick_btn, "#efd6ad")
	GUI:Button_setTitleFontSize(quick_btn, 18)
	GUI:Button_titleEnableOutline(quick_btn, "#000000", 1)
	GUI:setAnchorPoint(quick_btn, 0.50, 0.50)
	GUI:setTouchEnabled(quick_btn, true)
	GUI:setTag(quick_btn, -1)
	GUI:setVisible(quick_btn, false)

	-- Create quick_need_text
	local quick_need_text = GUI:Text_Create(FrameLayout, "quick_need_text", 736, 149, 14, "#00ff00", [[幸运钥匙*5]])
	GUI:Text_enableOutline(quick_need_text, "#000000", 1)
	GUI:setAnchorPoint(quick_need_text, 0.50, 0.50)
	GUI:setTouchEnabled(quick_need_text, false)
	GUI:setTag(quick_need_text, 0)
	GUI:setVisible(quick_need_text, false)

	-- Create submit_btn
	local submit_btn = GUI:Button_Create(FrameLayout, "submit_btn", 660, 84, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(submit_btn, "res/custom/npc/anb2.png")
	GUI:setContentSize(submit_btn, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(submit_btn, false)
	GUI:Button_setTitleText(submit_btn, [[一键点亮]])
	GUI:Button_setTitleColor(submit_btn, "#efd6ad")
	GUI:Button_setTitleFontSize(submit_btn, 18)
	GUI:Button_titleEnableOutline(submit_btn, "#000000", 1)
	GUI:setAnchorPoint(submit_btn, 0.50, 0.50)
	GUI:setTouchEnabled(submit_btn, true)
	GUI:setTag(submit_btn, -1)

	-- Create page_text
	local page_text = GUI:Text_Create(FrameLayout, "page_text", 200, 62, 18, "#00ff00", [[1]])
	GUI:Text_enableOutline(page_text, "#000000", 1)
	GUI:setAnchorPoint(page_text, 0.50, 0.50)
	GUI:setTouchEnabled(page_text, false)
	GUI:setTag(page_text, 0)

	-- Create last_btn
	local last_btn = GUI:Button_Create(FrameLayout, "last_btn", 123, 47, "res/custom/npc/31zbtj/an1_1.png")
	GUI:setContentSize(last_btn, 26, 37)
	GUI:setIgnoreContentAdaptWithSize(last_btn, false)
	GUI:Button_setTitleText(last_btn, [[]])
	GUI:Button_setTitleColor(last_btn, "#ffffff")
	GUI:Button_setTitleFontSize(last_btn, 16)
	GUI:Button_titleDisableOutLine(last_btn)
	GUI:setAnchorPoint(last_btn, 0.00, 0.00)
	GUI:setTouchEnabled(last_btn, true)
	GUI:setTag(last_btn, 0)

	-- Create next_btn
	local next_btn = GUI:Button_Create(FrameLayout, "next_btn", 248, 47, "res/custom/npc/31zbtj/an1_2.png")
	GUI:setContentSize(next_btn, 26, 37)
	GUI:setIgnoreContentAdaptWithSize(next_btn, false)
	GUI:Button_setTitleText(next_btn, [[]])
	GUI:Button_setTitleColor(next_btn, "#ffffff")
	GUI:Button_setTitleFontSize(next_btn, 16)
	GUI:Button_titleDisableOutLine(next_btn)
	GUI:setAnchorPoint(next_btn, 0.00, 0.00)
	GUI:setTouchEnabled(next_btn, true)
	GUI:setTag(next_btn, 0)

	-- Create equip_type_box
	local equip_type_box = GUI:Layout_Create(FrameLayout, "equip_type_box", 64, 92, 256, 318, false)
	GUI:setAnchorPoint(equip_type_box, 0.00, 0.00)
	GUI:setTouchEnabled(equip_type_box, false)
	GUI:setTag(equip_type_box, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(FrameLayout, "Text_5", 166, 50, 18, "#ffffff", [[第]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(FrameLayout, "Text_6", 216, 50, 18, "#ffffff", [[页]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	-- Create equip_listview
	local equip_listview = GUI:ScrollView_Create(FrameLayout, "equip_listview", 326, 133, 463, 313, 1)
	GUI:ScrollView_setInnerContainerSize(equip_listview, 463.00, 313.00)
	GUI:setAnchorPoint(equip_listview, 0.00, 0.00)
	GUI:setTouchEnabled(equip_listview, true)
	GUI:setTag(equip_listview, 0)

	-- Create yiwancheng_img
	local yiwancheng_img = GUI:Image_Create(FrameLayout, "yiwancheng_img", 670, 52, "res/custom/tag/hdyl_106.png")
	GUI:setAnchorPoint(yiwancheng_img, 0.00, 0.00)
	GUI:setTouchEnabled(yiwancheng_img, false)
	GUI:setTag(yiwancheng_img, 0)
	GUI:setVisible(yiwancheng_img, false)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 84, 416, 18, "#ffffff", [[请选择你要查看的装备类型]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create tip_btn
	local tip_btn = GUI:Button_Create(FrameLayout, "tip_btn", 756, 96, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tip_btn, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tip_btn, false)
	GUI:Button_setTitleText(tip_btn, [[]])
	GUI:Button_setTitleColor(tip_btn, "#ffffff")
	GUI:Button_setTitleFontSize(tip_btn, 16)
	GUI:Button_titleDisableOutLine(tip_btn)
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
