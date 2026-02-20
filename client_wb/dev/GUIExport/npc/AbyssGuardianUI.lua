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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 820, 510, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/21fb/symj/swbg.png")
	GUI:Image_setScale9Slice(FrameBG, 82, 82, 170, 170)
	GUI:setContentSize(FrameBG, 820, 510)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 718, 436, "res/custom/npc/01dtcs/close.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/01dtcs/close2.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create txtNode
	local txtNode = GUI:Node_Create(FrameLayout, "txtNode", 0, 0)
	GUI:setTag(txtNode, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(txtNode, "RichText_1", 443, 343, [[<font color='#bdbdb5' size='16' >副本 </font><font color='#009bff' size='16' >暗黑遗迹 </font><font color='#bdbdb5' size='16' >已通关         次</font>]], 220, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(txtNode, "RichText_2", 443, 315, [[<font color='#bdbdb5' size='16' >副本 </font><font color='#009bff' size='16' >幽冥废墟 </font><font color='#bdbdb5' size='16' >已通关         次</font>]], 220, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(txtNode, "RichText_3", 443, 288, [[<font color='#bdbdb5' size='16' >副本 </font><font color='#009bff' size='16' >窒息空间 </font><font color='#bdbdb5' size='16' >已通关         次</font>]], 220, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.00, 0.00)
	GUI:setTag(RichText_3, 0)

	-- Create RichText_4
	local RichText_4 = GUI:RichText_Create(txtNode, "RichText_4", 443, 262, [[<font color='#bdbdb5' size='16' >副本 </font><font color='#009bff' size='16' >混沌之源 </font><font color='#bdbdb5' size='16' >已通关         次</font>]], 220, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_4, 0.00, 0.00)
	GUI:setTag(RichText_4, 0)

	-- Create RichText_5
	local RichText_5 = GUI:RichText_Create(txtNode, "RichText_5", 443, 236, [[<font color='#bdbdb5' size='16' >副本 </font><font color='#009bff' size='16' >魔影裂痕 </font><font color='#bdbdb5' size='16' >已通关         次</font>]], 220, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_5, 0.00, 0.00)
	GUI:setTag(RichText_5, 0)

	-- Create RichText_6
	local RichText_6 = GUI:RichText_Create(txtNode, "RichText_6", 441, 186, [[<font color='#bdbdb5' size='16' >以上 </font><font color='#9b00ff' size='16' >5个 </font><font color='#bdbdb5' size='16' >副本通关均达到      次</font>]], 230, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_6, 0.00, 0.00)
	GUI:setTag(RichText_6, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(txtNode, "Text_1", 449, 133, 20, "#ffff00", [[称号奖励:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create tagIcon
	local tagIcon = GUI:Image_Create(FrameLayout, "tagIcon", 492, 67, "res/custom/npc/21fb/symj/wdc.png")
	GUI:setAnchorPoint(tagIcon, 0.00, 0.00)
	GUI:setTouchEnabled(tagIcon, false)
	GUI:setTag(tagIcon, 0)

	-- Create getTitleBtn
	local getTitleBtn = GUI:Button_Create(FrameLayout, "getTitleBtn", 467, 57, "res/custom/npc/21fb/symj/lqbtn1.png")
	GUI:Button_loadTexturePressed(getTitleBtn, "res/custom/npc/21fb/symj/lqbtn2.png")
	GUI:setContentSize(getTitleBtn, 146, 44)
	GUI:setIgnoreContentAdaptWithSize(getTitleBtn, false)
	GUI:Button_setTitleText(getTitleBtn, [[]])
	GUI:Button_setTitleColor(getTitleBtn, "#ffffff")
	GUI:Button_setTitleFontSize(getTitleBtn, 16)
	GUI:Button_titleEnableOutline(getTitleBtn, "#000000", 1)
	GUI:setAnchorPoint(getTitleBtn, 0.00, 0.00)
	GUI:setTouchEnabled(getTitleBtn, true)
	GUI:setTag(getTitleBtn, 0)

	-- Create timesTxt_1
	local timesTxt_1 = GUI:Text_Create(FrameLayout, "timesTxt_1", 613, 343, 16, "#00ff00", [[0]])
	GUI:Text_enableOutline(timesTxt_1, "#000000", 1)
	GUI:setAnchorPoint(timesTxt_1, 0.50, 0.00)
	GUI:setTouchEnabled(timesTxt_1, false)
	GUI:setTag(timesTxt_1, 0)

	-- Create timesTxt_2
	local timesTxt_2 = GUI:Text_Create(FrameLayout, "timesTxt_2", 613, 315, 16, "#00ff00", [[0]])
	GUI:Text_enableOutline(timesTxt_2, "#000000", 1)
	GUI:setAnchorPoint(timesTxt_2, 0.50, 0.00)
	GUI:setTouchEnabled(timesTxt_2, false)
	GUI:setTag(timesTxt_2, 0)

	-- Create timesTxt_3
	local timesTxt_3 = GUI:Text_Create(FrameLayout, "timesTxt_3", 613, 286, 16, "#00ff00", [[0]])
	GUI:Text_enableOutline(timesTxt_3, "#000000", 1)
	GUI:setAnchorPoint(timesTxt_3, 0.50, 0.00)
	GUI:setTouchEnabled(timesTxt_3, false)
	GUI:setTag(timesTxt_3, 0)

	-- Create timesTxt_4
	local timesTxt_4 = GUI:Text_Create(FrameLayout, "timesTxt_4", 613, 260, 16, "#00ff00", [[0]])
	GUI:Text_enableOutline(timesTxt_4, "#000000", 1)
	GUI:setAnchorPoint(timesTxt_4, 0.50, 0.00)
	GUI:setTouchEnabled(timesTxt_4, false)
	GUI:setTag(timesTxt_4, 0)

	-- Create timesTxt_5
	local timesTxt_5 = GUI:Text_Create(FrameLayout, "timesTxt_5", 613, 236, 16, "#00ff00", [[0]])
	GUI:Text_enableOutline(timesTxt_5, "#000000", 1)
	GUI:setAnchorPoint(timesTxt_5, 0.50, 0.00)
	GUI:setTouchEnabled(timesTxt_5, false)
	GUI:setTag(timesTxt_5, 0)

	-- Create timesTxt_6
	local timesTxt_6 = GUI:Text_Create(FrameLayout, "timesTxt_6", 631, 186, 16, "#00ff00", [[10]])
	GUI:Text_enableOutline(timesTxt_6, "#000000", 1)
	GUI:setAnchorPoint(timesTxt_6, 0.50, 0.00)
	GUI:setTouchEnabled(timesTxt_6, false)
	GUI:setTag(timesTxt_6, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
