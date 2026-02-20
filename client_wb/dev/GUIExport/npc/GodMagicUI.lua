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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/43wxzy/bg.png")
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

	-- Create midNode1
	local midNode1 = GUI:Node_Create(FrameLayout, "midNode1", 0, 0)
	GUI:setTag(midNode1, 0)

	-- Create effectNode1
	local effectNode1 = GUI:Node_Create(midNode1, "effectNode1", 0, 0)
	GUI:setTag(effectNode1, 0)

	-- Create effect1
	local effect1 = GUI:Effect_Create(effectNode1, "effect1", 160, 398, 0, 14311, 0, 0, 0, 1)
	GUI:setTag(effect1, 0)

	-- Create tipsBtn1
	local tipsBtn1 = GUI:Button_Create(midNode1, "tipsBtn1", 394, 444, "res/custom/npc/wenhao.png")
	GUI:Button_setTitleText(tipsBtn1, [[]])
	GUI:Button_setTitleColor(tipsBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn1, 16)
	GUI:Button_titleEnableOutline(tipsBtn1, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn1, true)
	GUI:setTag(tipsBtn1, 0)

	-- Create layerBg1
	local layerBg1 = GUI:Image_Create(midNode1, "layerBg1", 122, 194, "res/custom/npc/tip.png")
	GUI:setAnchorPoint(layerBg1, 0.00, 0.00)
	GUI:setTouchEnabled(layerBg1, false)
	GUI:setTag(layerBg1, 0)

	-- Create layerText1
	local layerText1 = GUI:Text_Create(layerBg1, "layerText1", 127, 17, 16, "#00ffff", [[神之真元·Lv40]])
	GUI:Text_enableOutline(layerText1, "#000000", 1)
	GUI:setAnchorPoint(layerText1, 0.50, 0.50)
	GUI:setTouchEnabled(layerText1, false)
	GUI:setTag(layerText1, 0)

	-- Create equipNode1
	local equipNode1 = GUI:Node_Create(midNode1, "equipNode1", 250, 161)
	GUI:setTag(equipNode1, 0)

	-- Create text11
	local text11 = GUI:Text_Create(midNode1, "text11", 98, 84, 16, "#df009f", [[人物体力：0%]])
	GUI:Text_enableOutline(text11, "#000000", 1)
	GUI:setAnchorPoint(text11, 0.00, 0.00)
	GUI:setTouchEnabled(text11, false)
	GUI:setTag(text11, 0)

	-- Create text12
	local text12 = GUI:Text_Create(midNode1, "text12", 98, 56, 16, "#ffff00", [[物伤减少：0%]])
	GUI:Text_enableOutline(text12, "#000000", 1)
	GUI:setAnchorPoint(text12, 0.00, 0.00)
	GUI:setTouchEnabled(text12, false)
	GUI:setTag(text12, 0)

	-- Create upNode1
	local upNode1 = GUI:Node_Create(midNode1, "upNode1", 0, 0)
	GUI:setTag(upNode1, 0)

	-- Create RText1
	local RText1 = GUI:RichText_Create(upNode1, "RText1", 336, 100, [[<font color='#ffffff' size='18' ><a enableUnderline ='false' href = 'jump#item_tips#10782'><u><font color ='#FFFF00'>神之泪*100</font></u></a></font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RText1, 0.50, 0.50)
	GUI:setTag(RText1, 0)

	-- Create upBtn1
	local upBtn1 = GUI:Button_Create(upNode1, "upBtn1", 336, 64, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn1, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn1, 0, 0, 0, 0)
	GUI:setContentSize(upBtn1, 94, 32)
	GUI:setIgnoreContentAdaptWithSize(upBtn1, false)
	GUI:Button_setTitleText(upBtn1, [[升 级]])
	GUI:Button_setTitleColor(upBtn1, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn1, 18)
	GUI:Button_titleEnableOutline(upBtn1, "#000000", 1)
	GUI:setAnchorPoint(upBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn1, true)
	GUI:setTag(upBtn1, 0)

	-- Create maxImg1
	local maxImg1 = GUI:Image_Create(midNode1, "maxImg1", 286, 38, "res/custom/npc/43wxzy/ywc.png")
	GUI:setAnchorPoint(maxImg1, 0.00, 0.00)
	GUI:setTouchEnabled(maxImg1, false)
	GUI:setTag(maxImg1, 0)
	GUI:setVisible(maxImg1, false)

	-- Create midNode2
	local midNode2 = GUI:Node_Create(FrameLayout, "midNode2", 370, 0)
	GUI:setTag(midNode2, 0)

	-- Create effectNode2
	local effectNode2 = GUI:Node_Create(midNode2, "effectNode2", 0, 0)
	GUI:setTag(effectNode2, 0)

	-- Create effect2
	local effect2 = GUI:Effect_Create(effectNode2, "effect2", 160, 398, 0, 14311, 0, 0, 0, 1)
	GUI:setTag(effect2, 0)

	-- Create tipsBtn2
	local tipsBtn2 = GUI:Button_Create(midNode2, "tipsBtn2", 394, 444, "res/custom/npc/wenhao.png")
	GUI:Button_setTitleText(tipsBtn2, [[]])
	GUI:Button_setTitleColor(tipsBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn2, 16)
	GUI:Button_titleEnableOutline(tipsBtn2, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn2, true)
	GUI:setTag(tipsBtn2, 0)

	-- Create layerBg2
	local layerBg2 = GUI:Image_Create(midNode2, "layerBg2", 122, 194, "res/custom/npc/tip.png")
	GUI:setAnchorPoint(layerBg2, 0.00, 0.00)
	GUI:setTouchEnabled(layerBg2, false)
	GUI:setTag(layerBg2, 0)

	-- Create layerText2
	local layerText2 = GUI:Text_Create(layerBg2, "layerText2", 127, 17, 16, "#ff0000", [[神之真元·Lv40]])
	GUI:Text_enableOutline(layerText2, "#000000", 1)
	GUI:setAnchorPoint(layerText2, 0.50, 0.50)
	GUI:setTouchEnabled(layerText2, false)
	GUI:setTag(layerText2, 0)

	-- Create equipNode2
	local equipNode2 = GUI:Node_Create(midNode2, "equipNode2", 250, 161)
	GUI:setTag(equipNode2, 0)

	-- Create text21
	local text21 = GUI:Text_Create(midNode2, "text21", 90, 84, 16, "#df009f", [[人物体力：0%]])
	GUI:Text_enableOutline(text21, "#000000", 1)
	GUI:setAnchorPoint(text21, 0.00, 0.00)
	GUI:setTouchEnabled(text21, false)
	GUI:setTag(text21, 0)

	-- Create text22
	local text22 = GUI:Text_Create(midNode2, "text22", 90, 56, 16, "#ffff00", [[物伤减少：0%]])
	GUI:Text_enableOutline(text22, "#000000", 1)
	GUI:setAnchorPoint(text22, 0.00, 0.00)
	GUI:setTouchEnabled(text22, false)
	GUI:setTag(text22, 0)

	-- Create upNode2
	local upNode2 = GUI:Node_Create(midNode2, "upNode2", 0, 0)
	GUI:setTag(upNode2, 0)

	-- Create RText2
	local RText2 = GUI:RichText_Create(upNode2, "RText2", 336, 100, [[<font color='#ffffff' size='18' ><a enableUnderline ='false' href = 'jump#item_tips#10783'><u><font color ='#FFFF00'>魔之魂*100</font></u></a></font>]], 100, 16, "#ff0000", 4)
	GUI:setAnchorPoint(RText2, 0.50, 0.50)
	GUI:setTag(RText2, 0)

	-- Create upBtn2
	local upBtn2 = GUI:Button_Create(upNode2, "upBtn2", 336, 64, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn2, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn2, 0, 0, 0, 0)
	GUI:setContentSize(upBtn2, 94, 32)
	GUI:setIgnoreContentAdaptWithSize(upBtn2, false)
	GUI:Button_setTitleText(upBtn2, [[升 级]])
	GUI:Button_setTitleColor(upBtn2, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn2, 18)
	GUI:Button_titleEnableOutline(upBtn2, "#000000", 1)
	GUI:setAnchorPoint(upBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn2, true)
	GUI:setTag(upBtn2, 0)

	-- Create maxImg2
	local maxImg2 = GUI:Image_Create(midNode2, "maxImg2", 286, 38, "res/custom/npc/43wxzy/ywc.png")
	GUI:setAnchorPoint(maxImg2, 0.00, 0.00)
	GUI:setTouchEnabled(maxImg2, false)
	GUI:setTag(maxImg2, 0)
	GUI:setVisible(maxImg2, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
