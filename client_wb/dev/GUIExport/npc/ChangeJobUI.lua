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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 590, 452, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/zzbg.png")
	GUI:Image_setScale9Slice(FrameBG, 59, 59, 150, 150)
	GUI:setContentSize(FrameBG, 590, 452)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameLayout, "close_btn", 533, 404, "res/custom/npc/close1.png")
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

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 48, 359, 18, "#ff9b00", [[转职说明：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 48, 318, 16, "#ff0000", [[转职后清空技能，只保留基础技能，其他技能需要玩家重新自学]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 49, 129, [[<font color='#ffffff' size='18' >开通：</font><font color='#ff0000' size='18' >盟重令    </font><font color='#ffffff' size='18' >+     </font><font color='#ffff00' size='18' >非绑定元宝*50000</font>]], 500, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(FrameLayout, "Text_3", 48, 278, 16, "#00ff00", [[转职后，玩家的天下第一数据也将清空，需要重新申请！]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(FrameLayout, "Text_4", 48, 154, 18, "#ff9b00", [[转职条件：]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(FrameLayout, "Text_5", 48, 237, 16, "#ff00ff", [[转职后，职业流派将全部清空，需要玩家重新觉醒！]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create Text_6
	local Text_6 = GUI:Text_Create(FrameLayout, "Text_6", 48, 197, 16, "#ffff00", [[转职后，职业流派消耗书页全返！]])
	GUI:Text_enableOutline(Text_6, "#000000", 1)
	GUI:setAnchorPoint(Text_6, 0.00, 0.00)
	GUI:setTouchEnabled(Text_6, false)
	GUI:setTag(Text_6, 0)

	-- Create btn_box
	local btn_box = GUI:Layout_Create(FrameLayout, "btn_box", 143, 39, 320, 70, false)
	GUI:setAnchorPoint(btn_box, 0.00, 0.00)
	GUI:setTouchEnabled(btn_box, false)
	GUI:setTag(btn_box, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(btn_box, "Button_1", 0, 13, "res/custom/btn1.png")
	GUI:setContentSize(Button_1, 120, 46)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[转为战士]])
	GUI:Button_setTitleColor(Button_1, "#efd6ad")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(btn_box, "Button_2", 200, 11, "res/custom/btn1.png")
	GUI:setContentSize(Button_2, 120, 46)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[转为法师]])
	GUI:Button_setTitleColor(Button_2, "#efd6ad")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(btn_box, "Button_3", 366, 10, "res/custom/btn1.png")
	GUI:setContentSize(Button_3, 120, 46)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[转为道士]])
	GUI:Button_setTitleColor(Button_3, "#efd6ad")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
