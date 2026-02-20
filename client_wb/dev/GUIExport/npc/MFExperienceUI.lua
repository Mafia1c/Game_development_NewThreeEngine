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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 89)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 170, 34, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/109mfll/bg1.png")
	GUI:Image_setScale9Slice(bg_Image, 84, 84, 188, 188)
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 784, 493, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/close2.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(FrameLayout, "ListView_1", 75, 442, 480, 42, 2)
	GUI:ListView_setGravity(ListView_1, 5)
	GUI:ListView_setItemsMargin(ListView_1, 1)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create page_btn_1
	local page_btn_1 = GUI:Button_Create(ListView_1, "page_btn_1", 0, 2, "res/public/1900000662.png")
	GUI:Button_loadTexturePressed(page_btn_1, "res/public/1900000663.png")
	GUI:setContentSize(page_btn_1, 116, 38)
	GUI:setIgnoreContentAdaptWithSize(page_btn_1, false)
	GUI:Button_setTitleText(page_btn_1, [[【盟重土城】]])
	GUI:Button_setTitleColor(page_btn_1, "#00ff00")
	GUI:Button_setTitleFontSize(page_btn_1, 16)
	GUI:Button_titleEnableOutline(page_btn_1, "#000000", 1)
	GUI:setAnchorPoint(page_btn_1, 0.00, 0.00)
	GUI:setTouchEnabled(page_btn_1, true)
	GUI:setTag(page_btn_1, 0)

	-- Create page_btn_2
	local page_btn_2 = GUI:Button_Create(ListView_1, "page_btn_2", 117, 2, "res/public/1900000662.png")
	GUI:Button_loadTexturePressed(page_btn_2, "res/public/1900000663.png")
	GUI:setContentSize(page_btn_2, 116, 38)
	GUI:setIgnoreContentAdaptWithSize(page_btn_2, false)
	GUI:Button_setTitleText(page_btn_2, [[【白日门】]])
	GUI:Button_setTitleColor(page_btn_2, "#ffffff")
	GUI:Button_setTitleFontSize(page_btn_2, 16)
	GUI:Button_titleEnableOutline(page_btn_2, "#000000", 1)
	GUI:setAnchorPoint(page_btn_2, 0.00, 0.00)
	GUI:setTouchEnabled(page_btn_2, true)
	GUI:setTag(page_btn_2, 0)

	-- Create page_btn_3
	local page_btn_3 = GUI:Button_Create(ListView_1, "page_btn_3", 234, 2, "res/public/1900000662.png")
	GUI:Button_loadTexturePressed(page_btn_3, "res/public/1900000663.png")
	GUI:setContentSize(page_btn_3, 116, 38)
	GUI:setIgnoreContentAdaptWithSize(page_btn_3, false)
	GUI:Button_setTitleText(page_btn_3, [[【封魔谷】]])
	GUI:Button_setTitleColor(page_btn_3, "#ffffff")
	GUI:Button_setTitleFontSize(page_btn_3, 16)
	GUI:Button_titleEnableOutline(page_btn_3, "#000000", 1)
	GUI:setAnchorPoint(page_btn_3, 0.00, 0.00)
	GUI:setTouchEnabled(page_btn_3, true)
	GUI:setTag(page_btn_3, 0)

	-- Create taskList
	local taskList = GUI:ListView_Create(FrameLayout, "taskList", 72, 36, 484, 373, 1)
	GUI:setAnchorPoint(taskList, 0.00, 0.00)
	GUI:setTouchEnabled(taskList, true)
	GUI:setTag(taskList, 0)

	-- Create activeBtn
	local activeBtn = GUI:Button_Create(FrameLayout, "activeBtn", 623, 47, "res/public/1900000662.png")
	GUI:Button_loadTexturePressed(activeBtn, "res/public/1900000663.png")
	GUI:setContentSize(activeBtn, 116, 38)
	GUI:setIgnoreContentAdaptWithSize(activeBtn, false)
	GUI:Button_setTitleText(activeBtn, [[激活称号]])
	GUI:Button_setTitleColor(activeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(activeBtn, 16)
	GUI:Button_titleEnableOutline(activeBtn, "#000000", 1)
	GUI:setAnchorPoint(activeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(activeBtn, true)
	GUI:setTag(activeBtn, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 678, 125, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 677, 241, 20, "#00ff00", [[历练称号:江湖小虾米]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 677, 207, 20, "#ffff00", [[所需历练值:12456]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 677, 173, 20, "#00ff00", [[当前历练值:32165]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.50, 0.00)
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
