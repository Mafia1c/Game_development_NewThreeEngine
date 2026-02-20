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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 346, 236, 450, 200, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/bossbg.png")
	GUI:Image_setScale9Slice(bg_Image, 45, 45, 66, 66)
	GUI:setContentSize(bg_Image, 450, 200)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, true)
	GUI:setMouseEnabled(bg_Image, true)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 415, 164, "res/public/01.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/02.png")
	GUI:setContentSize(closeBtn, 30, 30)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create titleTxt
	local titleTxt = GUI:Text_Create(FrameLayout, "titleTxt", 225, 166, 18, "#ff9b00", [[巡航提示]])
	GUI:Text_enableOutline(titleTxt, "#000000", 1)
	GUI:setAnchorPoint(titleTxt, 0.50, 0.00)
	GUI:setTouchEnabled(titleTxt, false)
	GUI:setTag(titleTxt, 0)

	-- Create center_txt_1
	local center_txt_1 = GUI:Text_Create(FrameLayout, "center_txt_1", 225, 111, 18, "#ffffff", [[开通 盟重令 可以享受无限巡航挂机特权!]])
	GUI:Text_enableOutline(center_txt_1, "#000000", 1)
	GUI:setAnchorPoint(center_txt_1, 0.50, 0.00)
	GUI:setTouchEnabled(center_txt_1, false)
	GUI:setTag(center_txt_1, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 225, 70, [[<font color='#ffffff' size='18' >是否前往开通 </font><font color='#9b00ff' size='18' >盟重令 </font><font color='#ffffff' size='18' >?</font>]], 190, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.50, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create noBtn
	local noBtn = GUI:Button_Create(FrameLayout, "noBtn", 78, 16, "res/public/1900000662.png")
	GUI:Button_loadTexturePressed(noBtn, "res/public/1900000663.png")
	GUI:setContentSize(noBtn, 116, 38)
	GUI:setIgnoreContentAdaptWithSize(noBtn, false)
	GUI:Button_setTitleText(noBtn, [[考虑一下]])
	GUI:Button_setTitleColor(noBtn, "#c6c6ce")
	GUI:Button_setTitleFontSize(noBtn, 16)
	GUI:Button_titleEnableOutline(noBtn, "#000000", 1)
	GUI:setAnchorPoint(noBtn, 0.00, 0.00)
	GUI:setTouchEnabled(noBtn, true)
	GUI:setTag(noBtn, 0)

	-- Create okBtn
	local okBtn = GUI:Button_Create(FrameLayout, "okBtn", 260, 16, "res/public/1900000662.png")
	GUI:Button_loadTexturePressed(okBtn, "res/public/1900000663.png")
	GUI:setContentSize(okBtn, 116, 38)
	GUI:setIgnoreContentAdaptWithSize(okBtn, false)
	GUI:Button_setTitleText(okBtn, [[前往开通]])
	GUI:Button_setTitleColor(okBtn, "#00ff00")
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
