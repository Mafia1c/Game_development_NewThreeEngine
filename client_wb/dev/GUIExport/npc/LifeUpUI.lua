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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/07zslh/bg.png")
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

	-- Create leftBtnList
	local leftBtnList = GUI:ListView_Create(FrameLayout, "leftBtnList", 73, 483, 120, 142, 1)
	GUI:ListView_setItemsMargin(leftBtnList, 1)
	GUI:setAnchorPoint(leftBtnList, 0.00, 1.00)
	GUI:setTouchEnabled(leftBtnList, true)
	GUI:setTag(leftBtnList, 0)

	-- Create leftBtn1
	local leftBtn1 = GUI:Button_Create(leftBtnList, "leftBtn1", 0, 98, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn1, false)
	GUI:Button_setTitleText(leftBtn1, [[转生]])
	GUI:Button_setTitleColor(leftBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn1, 18)
	GUI:Button_titleEnableOutline(leftBtn1, "#000000", 1)
	GUI:setAnchorPoint(leftBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn1, true)
	GUI:setTag(leftBtn1, 0)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create layerName
	local layerName = GUI:Text_Create(midNode, "layerName", 362, 459, 16, "#f0b42a", [[当前转生：]])
	GUI:Text_enableOutline(layerName, "#000000", 1)
	GUI:setAnchorPoint(layerName, 0.50, 0.50)
	GUI:setTouchEnabled(layerName, false)
	GUI:setTag(layerName, 0)

	-- Create layerText
	local layerText = GUI:Text_Create(layerName, "layerText", 80, 0, 16, "#06e6e6", [[0转]])
	GUI:Text_enableOutline(layerText, "#000000", 1)
	GUI:setAnchorPoint(layerText, 0.00, 0.00)
	GUI:setTouchEnabled(layerText, false)
	GUI:setTag(layerText, 0)

	-- Create personEffect
	local personEffect = GUI:Effect_Create(midNode, "personEffect", 366, 298, 0, 16002, 0, 0, 0, 1)
	GUI:setScale(personEffect, 0.60)
	GUI:setTag(personEffect, 0)

	-- Create layerBg
	local layerBg = GUI:Image_Create(midNode, "layerBg", 384, 226, "res/custom/npc/07zslh/tbg.png")
	GUI:setContentSize(layerBg, 220, 28)
	GUI:setIgnoreContentAdaptWithSize(layerBg, false)
	GUI:setAnchorPoint(layerBg, 0.50, 0.50)
	GUI:setTouchEnabled(layerBg, false)
	GUI:setTag(layerBg, 0)

	-- Create ballText
	local ballText = GUI:Text_Create(layerBg, "ballText", 110, 14, 16, "#d7039c", [[转生进度：0 / 9]])
	GUI:Text_enableOutline(ballText, "#000000", 1)
	GUI:setAnchorPoint(ballText, 0.50, 0.50)
	GUI:setTouchEnabled(ballText, false)
	GUI:setTag(ballText, 0)

	-- Create ballNode1
	local ballNode1 = GUI:Node_Create(midNode, "ballNode1", 0, 0)
	GUI:setTag(ballNode1, 0)

	-- Create ballEffect1
	local ballEffect1 = GUI:Effect_Create(ballNode1, "ballEffect1", 228, 268, 0, 16074, 0, 0, 0, 1)
	GUI:setTag(ballEffect1, 0)

	-- Create ballEffect2
	local ballEffect2 = GUI:Effect_Create(ballNode1, "ballEffect2", 211, 331, 0, 16074, 0, 0, 0, 1)
	GUI:setTag(ballEffect2, 0)

	-- Create ballEffect3
	local ballEffect3 = GUI:Effect_Create(ballNode1, "ballEffect3", 238, 388, 0, 16074, 0, 0, 0, 1)
	GUI:setTag(ballEffect3, 0)

	-- Create ballEffect4
	local ballEffect4 = GUI:Effect_Create(ballNode1, "ballEffect4", 286, 424, 0, 16074, 0, 0, 0, 1)
	GUI:setTag(ballEffect4, 0)

	-- Create ballEffect5
	local ballEffect5 = GUI:Effect_Create(ballNode1, "ballEffect5", 354, 438, 0, 16074, 0, 0, 0, 1)
	GUI:setTag(ballEffect5, 0)

	-- Create ballEffect6
	local ballEffect6 = GUI:Effect_Create(ballNode1, "ballEffect6", 423, 424, 0, 16074, 0, 0, 0, 1)
	GUI:setTag(ballEffect6, 0)

	-- Create ballEffect7
	local ballEffect7 = GUI:Effect_Create(ballNode1, "ballEffect7", 477, 388, 0, 16074, 0, 0, 0, 1)
	GUI:setTag(ballEffect7, 0)

	-- Create ballEffect8
	local ballEffect8 = GUI:Effect_Create(ballNode1, "ballEffect8", 501, 331, 0, 16074, 0, 0, 0, 1)
	GUI:setTag(ballEffect8, 0)

	-- Create ballEffect9
	local ballEffect9 = GUI:Effect_Create(ballNode1, "ballEffect9", 480, 268, 0, 16074, 0, 0, 0, 1)
	GUI:setTag(ballEffect9, 0)

	-- Create ballNode2
	local ballNode2 = GUI:Node_Create(midNode, "ballNode2", 0, 0)
	GUI:setTag(ballNode2, 0)

	-- Create RichText1
	local RichText1 = GUI:RichText_Create(midNode, "RichText1", 202, 100, [[<font color='#ff0000' size='18' >转生规则：</font><br><font color='#F0B42A' size='18' >收集所需的物品，即可提升当前</font><font color='#00ff00' size='18' >转生进度</font><br><font color='#F0B42A' size='18' >每次提升进度，即可获得对应的</font><font color='#00ff00' size='18' >属性加成</font>]], 360, 18, "#ff0000", 4)
	GUI:setAnchorPoint(RichText1, 0.00, 0.00)
	GUI:setTag(RichText1, 0)

	-- Create RichText2
	local RichText2 = GUI:RichText_Create(midNode, "RichText2", 78, 44, [==========[<font color='#FFFFFF' size='16' >提示：转生轮回所需的</font><font color='#00ff00' size='16' >[材料与道具]</font><font color='#FFFFFF' size='16' >在</font><font color='#00ff00' size='16' >[任意地图怪物]</font><font color='#FFFFFF' size='16' >均有几率爆出！</font>]==========], 700, 16, "#00ff00", 4)
	GUI:setAnchorPoint(RichText2, 0.00, 0.00)
	GUI:setTag(RichText2, 0)

	-- Create infoNode1
	local infoNode1 = GUI:Node_Create(midNode, "infoNode1", 686, 402)
	GUI:setTag(infoNode1, 0)

	-- Create text111
	local text111 = GUI:Text_Create(infoNode1, "text111", 0, 0, 16, "#ffffff", [[生命加成：]])
	GUI:Text_enableOutline(text111, "#000000", 1)
	GUI:setAnchorPoint(text111, 0.00, 0.00)
	GUI:setTouchEnabled(text111, false)
	GUI:setTag(text111, 0)

	-- Create text112
	local text112 = GUI:Text_Create(text111, "text112", 74, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text112, "#000000", 1)
	GUI:setAnchorPoint(text112, 0.00, 0.00)
	GUI:setTouchEnabled(text112, false)
	GUI:setTag(text112, 0)

	-- Create text121
	local text121 = GUI:Text_Create(infoNode1, "text121", 0, 0, 16, "#ffffff", [[攻击倍数：]])
	GUI:Text_enableOutline(text121, "#000000", 1)
	GUI:setAnchorPoint(text121, 0.00, 0.00)
	GUI:setTouchEnabled(text121, false)
	GUI:setTag(text121, 0)

	-- Create text122
	local text122 = GUI:Text_Create(text121, "text122", 74, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text122, "#000000", 1)
	GUI:setAnchorPoint(text122, 0.00, 0.00)
	GUI:setTouchEnabled(text122, false)
	GUI:setTag(text122, 0)

	-- Create infoNode2
	local infoNode2 = GUI:Node_Create(midNode, "infoNode2", 686, 276)
	GUI:setTag(infoNode2, 0)

	-- Create text211
	local text211 = GUI:Text_Create(infoNode2, "text211", 0, 0, 16, "#ffffff", [[生命加成：]])
	GUI:Text_enableOutline(text211, "#000000", 1)
	GUI:setAnchorPoint(text211, 0.00, 0.00)
	GUI:setTouchEnabled(text211, false)
	GUI:setTag(text211, 0)

	-- Create text212
	local text212 = GUI:Text_Create(text211, "text212", 74, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text212, "#000000", 1)
	GUI:setAnchorPoint(text212, 0.00, 0.00)
	GUI:setTouchEnabled(text212, false)
	GUI:setTag(text212, 0)

	-- Create text221
	local text221 = GUI:Text_Create(infoNode2, "text221", 0, 0, 16, "#ffffff", [[攻击倍数：]])
	GUI:Text_enableOutline(text221, "#000000", 1)
	GUI:setAnchorPoint(text221, 0.00, 0.00)
	GUI:setTouchEnabled(text221, false)
	GUI:setTag(text221, 0)

	-- Create text222
	local text222 = GUI:Text_Create(text221, "text222", 74, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text222, "#000000", 1)
	GUI:setAnchorPoint(text222, 0.00, 0.00)
	GUI:setTouchEnabled(text222, false)
	GUI:setTag(text222, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(midNode, "needItemNode", 680, 166)
	GUI:setTag(needItemNode, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midNode, "upBtn", 684, 105, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn, 0, 0, 0, 0)
	GUI:setContentSize(upBtn, 114, 40)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[转生]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create maxImg
	local maxImg = GUI:Image_Create(midNode, "maxImg", 682, 142, "res/custom/npc/07zslh/ymj.png")
	GUI:setContentSize(maxImg, 107, 84)
	GUI:setIgnoreContentAdaptWithSize(maxImg, false)
	GUI:setAnchorPoint(maxImg, 0.50, 0.50)
	GUI:setTouchEnabled(maxImg, false)
	GUI:setTag(maxImg, 0)
	GUI:setVisible(maxImg, false)

	-- Create getText
	local getText = GUI:Text_Create(midNode, "getText", 694, 56, 16, "#00ff00", [==========[合成→[飞升凭证]]==========])
	GUI:Text_enableOutline(getText, "#000000", 1)
	GUI:Text_enableUnderline(getText)
	GUI:setAnchorPoint(getText, 0.50, 0.50)
	GUI:setTouchEnabled(getText, true)
	GUI:setTag(getText, 0)
	GUI:setVisible(getText, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
