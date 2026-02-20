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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/09qjbm/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 801, 511, "res/custom/npc/close1.png")
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

	-- Create leftBox
	local leftBox = GUI:Layout_Create(FrameLayout, "leftBox", 70, 77, 494, 410, true)
	GUI:setAnchorPoint(leftBox, 0.00, 0.00)
	GUI:setTouchEnabled(leftBox, false)
	GUI:setTag(leftBox, 0)

	-- Create leftBg
	local leftBg = GUI:Image_Create(leftBox, "leftBg", -64, 320, "res/custom/npc/09qjbm/icon.png")
	GUI:setAnchorPoint(leftBg, 0.50, 0.50)
	GUI:setTouchEnabled(leftBg, false)
	GUI:setTag(leftBg, 0)

	-- Create lineImg
	local lineImg = GUI:Image_Create(leftBg, "lineImg", 28, 58, "res/custom/npc/09qjbm/z1.png")
	GUI:setContentSize(lineImg, 21, 97)
	GUI:setIgnoreContentAdaptWithSize(lineImg, false)
	GUI:setAnchorPoint(lineImg, 0.50, 0.50)
	GUI:setTouchEnabled(lineImg, false)
	GUI:setTag(lineImg, 0)

	-- Create acupointImg
	local acupointImg = GUI:Image_Create(leftBg, "acupointImg", 66, 32, "res/custom/npc/09qjbm/icon/0.png")
	GUI:setAnchorPoint(acupointImg, 0.50, 0.50)
	GUI:setTouchEnabled(acupointImg, false)
	GUI:setTag(acupointImg, 0)

	-- Create personImg
	local personImg = GUI:Image_Create(leftBox, "personImg", 260, 218, "res/custom/npc/09qjbm/r11.png")
	GUI:setContentSize(personImg, 418, 427)
	GUI:setIgnoreContentAdaptWithSize(personImg, false)
	GUI:setAnchorPoint(personImg, 0.50, 0.50)
	GUI:setOpacity(personImg, 0)
	GUI:setTouchEnabled(personImg, false)
	GUI:setTag(personImg, 0)

	-- Create acupointText
	local acupointText = GUI:Text_Create(leftBox, "acupointText", 244, 27, 16, "#ff0000", [[]])
	GUI:Text_enableOutline(acupointText, "#000000", 1)
	GUI:setAnchorPoint(acupointText, 0.50, 0.50)
	GUI:setOpacity(acupointText, 0)
	GUI:setTouchEnabled(acupointText, false)
	GUI:setTag(acupointText, 0)

	-- Create rightNode
	local rightNode = GUI:Node_Create(FrameLayout, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create tipsBtn
	local tipsBtn = GUI:Button_Create(rightNode, "tipsBtn", 526, 446, "res/custom/npc/09qjbm/sx1.png")
	GUI:Button_loadTexturePressed(tipsBtn, "res/custom/npc/09qjbm/sx2.png")
	GUI:setContentSize(tipsBtn, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn, false)
	GUI:Button_setTitleText(tipsBtn, [[]])
	GUI:Button_setTitleColor(tipsBtn, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn, 16)
	GUI:Button_titleEnableOutline(tipsBtn, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn, 0.50, 0.50)
	GUI:setTouchEnabled(tipsBtn, true)
	GUI:setTag(tipsBtn, 0)

	-- Create textNode1
	local textNode1 = GUI:Node_Create(rightNode, "textNode1", 682, 402)
	GUI:setTag(textNode1, 0)

	-- Create text111
	local text111 = GUI:Text_Create(textNode1, "text111", 0, 0, 16, "#ffffff", [[攻魔道：   ]])
	GUI:Text_enableOutline(text111, "#000000", 1)
	GUI:setAnchorPoint(text111, 0.00, 0.00)
	GUI:setTouchEnabled(text111, false)
	GUI:setTag(text111, 0)

	-- Create text112
	local text112 = GUI:Text_Create(text111, "text112", 60, 0, 16, "#00ff00", [[1]])
	GUI:Text_enableOutline(text112, "#000000", 1)
	GUI:setAnchorPoint(text112, 0.00, 0.00)
	GUI:setTouchEnabled(text112, false)
	GUI:setTag(text112, 0)

	-- Create text121
	local text121 = GUI:Text_Create(textNode1, "text121", 0, 0, 16, "#ffffff", [[生命值：    ]])
	GUI:Text_enableOutline(text121, "#000000", 1)
	GUI:setAnchorPoint(text121, 0.00, 0.00)
	GUI:setTouchEnabled(text121, false)
	GUI:setTag(text121, 0)

	-- Create text122
	local text122 = GUI:Text_Create(text121, "text122", 60, 0, 16, "#00ff00", [[1%]])
	GUI:Text_enableOutline(text122, "#000000", 1)
	GUI:setAnchorPoint(text122, 0.00, 0.00)
	GUI:setTouchEnabled(text122, false)
	GUI:setTag(text122, 0)

	-- Create text132
	local text132 = GUI:Text_Create(textNode1, "text132", 0, 0, 16, "#9b00ff", [[神力：12%]])
	GUI:Text_enableOutline(text132, "#000000", 1)
	GUI:setAnchorPoint(text132, 0.00, 0.00)
	GUI:setTouchEnabled(text132, false)
	GUI:setTag(text132, 0)

	-- Create textNode2
	local textNode2 = GUI:Node_Create(rightNode, "textNode2", 682, 270)
	GUI:setTag(textNode2, 0)

	-- Create text211
	local text211 = GUI:Text_Create(textNode2, "text211", 0, 0, 16, "#ffffff", [[攻魔道：   ]])
	GUI:Text_enableOutline(text211, "#000000", 1)
	GUI:setAnchorPoint(text211, 0.00, 0.00)
	GUI:setTouchEnabled(text211, false)
	GUI:setTag(text211, 0)

	-- Create text212
	local text212 = GUI:Text_Create(text211, "text212", 60, 0, 16, "#00ff00", [[1]])
	GUI:Text_enableOutline(text212, "#000000", 1)
	GUI:setAnchorPoint(text212, 0.00, 0.00)
	GUI:setTouchEnabled(text212, false)
	GUI:setTag(text212, 0)

	-- Create text221
	local text221 = GUI:Text_Create(textNode2, "text221", 0, 0, 16, "#ffffff", [[生命值：    ]])
	GUI:Text_enableOutline(text221, "#000000", 1)
	GUI:setAnchorPoint(text221, 0.00, 0.00)
	GUI:setTouchEnabled(text221, false)
	GUI:setTag(text221, 0)

	-- Create text222
	local text222 = GUI:Text_Create(text221, "text222", 60, 0, 16, "#00ff00", [[1%]])
	GUI:Text_enableOutline(text222, "#000000", 1)
	GUI:setAnchorPoint(text222, 0.00, 0.00)
	GUI:setTouchEnabled(text222, false)
	GUI:setTag(text222, 0)

	-- Create text232
	local text232 = GUI:Text_Create(textNode2, "text232", 0, 0, 16, "#9b00ff", [[神力：12%]])
	GUI:Text_enableOutline(text232, "#000000", 1)
	GUI:setAnchorPoint(text232, 0.00, 0.00)
	GUI:setTouchEnabled(text232, false)
	GUI:setTag(text232, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(rightNode, "needItemNode", 680, 160)
	GUI:setTag(needItemNode, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(rightNode, "upBtn", 680, 102, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn, 0, 0, 0, 0)
	GUI:setContentSize(upBtn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[突破穴位]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 17)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create RichText
	local RichText = GUI:RichText_Create(rightNode, "RichText", 78, 44, [==========[<font color='#FFFFFF' size='16' >提示：修炼经脉所需的</font><font color='#00ff00' size='16' >[金针]</font><font color='#FFFFFF' size='16' >与</font><font color='#00ff00' size='16' >[洗髓丹]</font><font color='#FFFFFF' size='16' >在</font><font color='#00ff00' size='16' >[任意地图怪物]</font><font color='#FFFFFF' size='16' >均有几率爆出！</font>]==========], 700, 16, "#00ff00", 4)
	GUI:setAnchorPoint(RichText, 0.00, 0.00)
	GUI:setTag(RichText, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
