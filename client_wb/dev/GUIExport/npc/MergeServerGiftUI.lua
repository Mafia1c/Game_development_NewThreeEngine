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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/19fl/bg106.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 802, 511, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/close2.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 72, 440, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[合服豪礼]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 72, 395, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[合服返利]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Node_1
	local Node_1 = GUI:Node_Create(FrameLayout, "Node_1", 0, 0)
	GUI:setTag(Node_1, 0)
	GUI:setVisible(Node_1, false)

	-- Create cell_img_1
	local cell_img_1 = GUI:Image_Create(Node_1, "cell_img_1", 203, 76, "res/custom/npc/19fl/hflist1.png")
	GUI:setAnchorPoint(cell_img_1, 0.00, 0.00)
	GUI:setTouchEnabled(cell_img_1, false)
	GUI:setTag(cell_img_1, 0)

	-- Create jf_ItemShow_1
	local jf_ItemShow_1 = GUI:ItemShow_Create(cell_img_1, "jf_ItemShow_1", 66, 214, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(jf_ItemShow_1, 0.50, 0.50)
	GUI:setTag(jf_ItemShow_1, 0)

	-- Create jf_ItemShow_2
	local jf_ItemShow_2 = GUI:ItemShow_Create(cell_img_1, "jf_ItemShow_2", 146, 214, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(jf_ItemShow_2, 0.50, 0.50)
	GUI:setTag(jf_ItemShow_2, 0)

	-- Create jf_ItemShow_3
	local jf_ItemShow_3 = GUI:ItemShow_Create(cell_img_1, "jf_ItemShow_3", 226, 214, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(jf_ItemShow_3, 0.50, 0.50)
	GUI:setTag(jf_ItemShow_3, 0)

	-- Create jf_ItemShow_4
	local jf_ItemShow_4 = GUI:ItemShow_Create(cell_img_1, "jf_ItemShow_4", 66, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(jf_ItemShow_4, 0.50, 0.50)
	GUI:setTag(jf_ItemShow_4, 0)

	-- Create jf_ItemShow_5
	local jf_ItemShow_5 = GUI:ItemShow_Create(cell_img_1, "jf_ItemShow_5", 146, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(jf_ItemShow_5, 0.50, 0.50)
	GUI:setTag(jf_ItemShow_5, 0)

	-- Create jf_ItemShow_6
	local jf_ItemShow_6 = GUI:ItemShow_Create(cell_img_1, "jf_ItemShow_6", 226, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(jf_ItemShow_6, 0.50, 0.50)
	GUI:setTag(jf_ItemShow_6, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(cell_img_1, "Text_1", 146, 73, 16, "#00ff00", [[【盟重令用户半价】]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(cell_img_1, "Button_3", 146, 30, "res/custom/npc/19fl/zmbtn1.png")
	GUI:Button_loadTexturePressed(Button_3, "res/custom/npc/19fl/zmbtn2.png")
	GUI:setContentSize(Button_3, 150, 40)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[59800金符购买]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.50, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create cell_img_2
	local cell_img_2 = GUI:Image_Create(Node_1, "cell_img_2", 502, 76, "res/custom/npc/19fl/hflist2.png")
	GUI:setAnchorPoint(cell_img_2, 0.00, 0.00)
	GUI:setTouchEnabled(cell_img_2, false)
	GUI:setTag(cell_img_2, 0)

	-- Create hf_ItemShow_1
	local hf_ItemShow_1 = GUI:ItemShow_Create(cell_img_2, "hf_ItemShow_1", 66, 214, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(hf_ItemShow_1, 0.50, 0.50)
	GUI:setTag(hf_ItemShow_1, 0)

	-- Create hf_ItemShow_2
	local hf_ItemShow_2 = GUI:ItemShow_Create(cell_img_2, "hf_ItemShow_2", 146, 214, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(hf_ItemShow_2, 0.50, 0.50)
	GUI:setTag(hf_ItemShow_2, 0)

	-- Create hf_ItemShow_3
	local hf_ItemShow_3 = GUI:ItemShow_Create(cell_img_2, "hf_ItemShow_3", 226, 214, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(hf_ItemShow_3, 0.50, 0.50)
	GUI:setTag(hf_ItemShow_3, 0)

	-- Create hf_ItemShow_4
	local hf_ItemShow_4 = GUI:ItemShow_Create(cell_img_2, "hf_ItemShow_4", 66, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(hf_ItemShow_4, 0.50, 0.50)
	GUI:setTag(hf_ItemShow_4, 0)

	-- Create hf_ItemShow_5
	local hf_ItemShow_5 = GUI:ItemShow_Create(cell_img_2, "hf_ItemShow_5", 146, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(hf_ItemShow_5, 0.50, 0.50)
	GUI:setTag(hf_ItemShow_5, 0)

	-- Create hf_ItemShow_6
	local hf_ItemShow_6 = GUI:ItemShow_Create(cell_img_2, "hf_ItemShow_6", 226, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(hf_ItemShow_6, 0.50, 0.50)
	GUI:setTag(hf_ItemShow_6, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(cell_img_2, "Button_4", 146, 43, "res/custom/npc/19fl/zmbtn3.png")
	GUI:Button_loadTexturePressed(Button_4, "res/custom/npc/19fl/zmbtn4.png")
	GUI:setContentSize(Button_4, 130, 40)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[138 元 购 买]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 16)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.50, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(Node_1, "RichText_1", 205, 42, [[<font color='#bdbdb5' size='20' >购买</font><font color='#ffff00' size='20' >【合服豪礼】</font><font color='#bdbdb5' size='20' >系统自动赠送</font><font color='#9b00ff' size='20' >（ 金符豪礼*2 ）</font><font color='#00ff00' size='20' >（ 邮件发放 ）</font>]], 600, 20, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create Frames_1
	local Frames_1 = GUI:Frames_Create(Node_1, "Frames_1", 495, 161, "res/custom/s/s", ".png", 1, 15, {count=15, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(Frames_1, 0.50, 0.50)
	GUI:setTouchEnabled(Frames_1, false)
	GUI:setTag(Frames_1, 0)

	-- Create Node_2
	local Node_2 = GUI:Node_Create(FrameLayout, "Node_2", 0, 0)
	GUI:setTag(Node_2, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(Node_2, "Text_2", 210, 411, 16, "#00ffff", [[活动期间累计充值：]])
	GUI:Text_enableOutline(Text_2, "#000000", 2)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(Node_2, "ListView_1", 198, 36, 602, 361, 1)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
