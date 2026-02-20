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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 568, 320, 756, 474, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/21fb/symj/sybg1.png")
	GUI:Image_setScale9Slice(FrameBG, 75, 75, 158, 158)
	GUI:setContentSize(FrameBG, 756, 474)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 155, 202, "res/custom/npc/21fb/pnbg.png")
	GUI:setContentSize(Image_1, 216, 28)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create pointTxt
	local pointTxt = GUI:Text_Create(Image_1, "pointTxt", 108, 14, 16, "#00ff00", [[当前拥有疲劳值: 100 点]])
	GUI:Text_enableOutline(pointTxt, "#000000", 1)
	GUI:setAnchorPoint(pointTxt, 0.50, 0.50)
	GUI:setTouchEnabled(pointTxt, false)
	GUI:setTag(pointTxt, 0)

	-- Create itemNode
	local itemNode = GUI:Node_Create(FrameLayout, "itemNode", 274, 124)
	GUI:setTag(itemNode, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 136, 64, [[<font color='#bdbdb5' size='14' >挑战深渊需要 </font><font color='#00ff00' size='14' >10点疲劳值</font><font color='#ff0000' size='14' >(盟重令用户5点)</font>]], 280, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(FrameLayout, "RichText_2", 136, 46, [[<font color='#bdbdb5' size='14' >恶魔深渊: 额外消耗 <a enableUnderline ='false' href='jump#item_tips#10087'> <u><font color ='#FFFF00'>秘境卷轴*10</font></u></a></font>]], 270, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(FrameLayout, "RichText_3", 136, 25, [[<font color='#bdbdb5' size='14' >恶魔深渊 </font><font color='#00ff00' size='14' >10% </font><font color='#bdbdb5' size='14' >几率触发 </font><font color='#9b00ff' size='14' >地狱模式</font>]], 280, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.00, 0.00)
	GUI:setTag(RichText_3, 0)

	-- Create ChallengeBtn_1
	local ChallengeBtn_1 = GUI:Button_Create(FrameLayout, "ChallengeBtn_1", 476, 74, "res/custom/btn21.png")
	GUI:Button_loadTexturePressed(ChallengeBtn_1, "res/custom/btn22.png")
	GUI:setContentSize(ChallengeBtn_1, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(ChallengeBtn_1, false)
	GUI:Button_setTitleText(ChallengeBtn_1, [[挑战普通深渊]])
	GUI:Button_setTitleColor(ChallengeBtn_1, "#ffff00")
	GUI:Button_setTitleFontSize(ChallengeBtn_1, 14)
	GUI:Button_titleEnableOutline(ChallengeBtn_1, "#000000", 1)
	GUI:setAnchorPoint(ChallengeBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(ChallengeBtn_1, true)
	GUI:setTag(ChallengeBtn_1, 0)

	-- Create ChallengeBtn_2
	local ChallengeBtn_2 = GUI:Button_Create(FrameLayout, "ChallengeBtn_2", 585, 74, "res/custom/btn21.png")
	GUI:Button_loadTexturePressed(ChallengeBtn_2, "res/custom/btn22.png")
	GUI:setContentSize(ChallengeBtn_2, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(ChallengeBtn_2, false)
	GUI:Button_setTitleText(ChallengeBtn_2, [[挑战恶魔深渊]])
	GUI:Button_setTitleColor(ChallengeBtn_2, "#ffff00")
	GUI:Button_setTitleFontSize(ChallengeBtn_2, 14)
	GUI:Button_titleEnableOutline(ChallengeBtn_2, "#000000", 1)
	GUI:setAnchorPoint(ChallengeBtn_2, 0.00, 0.00)
	GUI:setTouchEnabled(ChallengeBtn_2, true)
	GUI:setTag(ChallengeBtn_2, 0)

	-- Create effNode
	local effNode = GUI:Node_Create(FrameLayout, "effNode", 0, 0)
	GUI:setTag(effNode, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 699, 406, "res/custom/npc/01dtcs/close.png")
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

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 497, 51, 14, "#ff9b00", [[深渊副本 挑战限时 30 分钟]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
