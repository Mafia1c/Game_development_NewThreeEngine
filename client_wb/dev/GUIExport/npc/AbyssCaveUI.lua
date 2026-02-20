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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 908, 550, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/21fb/symj/mb.png")
	GUI:Image_setScale9Slice(FrameBG, 90, 90, 183, 183)
	GUI:setContentSize(FrameBG, 908, 550)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 847, 478, "res/custom/npc/01dtcs/close.png")
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

	-- Create infoNode
	local infoNode = GUI:Image_Create(FrameLayout, "infoNode", 268, 129, "res/custom/npc/21fb/fengmo/phbg2.png")
	GUI:Image_setScale9Slice(infoNode, 23, 23, 89, 89)
	GUI:setContentSize(infoNode, 329, 150)
	GUI:setIgnoreContentAdaptWithSize(infoNode, false)
	GUI:setAnchorPoint(infoNode, 0.00, 0.00)
	GUI:setTouchEnabled(infoNode, false)
	GUI:setTag(infoNode, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(infoNode, "RichText_1", 8, 120, [[<font color='#bdbdb5' size='16' >每日初始疲劳值</font><font color='#00ff00' size='16' >100点</font><font color='#ffffff' size='16' >,</font><font color='#9b00ff' size='16' >0点重置,盟重令+100点</font>]], 330, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(infoNode, "RichText_2", 8, 84, [[<font color='#bdbdb5' size='16' >挑战深渊需要疲劳值</font><font color='#00ff00' size='16' >10点</font><font color='#84009b' size='16' >(盟重令仅消耗5点)</font>]], 320, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(infoNode, "RichText_3", 8, 47, [[<font color='#ff0000' size='16' >噩梦深渊</font><font color='#bdbdb5' size='16' >额外消耗</font><font color='#00ff00' size='16' >10张</font><font color='#ffff00' size='16' >秘境卷轴</font>]], 320, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.00, 0.00)
	GUI:setTag(RichText_3, 0)

	-- Create RichText_4
	local RichText_4 = GUI:RichText_Create(infoNode, "RichText_4", 8, 15, [==========[<font color='#bdbdb5' size='16' >挑战[</font><font color='#00ff00' size='16' >噩梦深渊</font><font color='#bdbdb5' size='16' >]</font><font color='#9b00ff' size='16' >10%</font><font color='#bdbdb5' size='16' >几率触发</font><font color='#ff0000' size='16' >地狱模式</font>]==========], 320, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_4, 0.00, 0.00)
	GUI:setTag(RichText_4, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(FrameLayout, "Image_3", 303, 279, "res/custom/npc/21fb/symj/bbg.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(FrameLayout, "Image_4", 317, 293, "res/custom/npc/21fb/symj/cs.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create remainTxt
	local remainTxt = GUI:Text_Create(FrameLayout, "remainTxt", 470, 290, 18, "#00ff00", [[100]])
	GUI:Text_enableOutline(remainTxt, "#000000", 1)
	GUI:setAnchorPoint(remainTxt, 0.00, 0.00)
	GUI:setTouchEnabled(remainTxt, false)
	GUI:setTag(remainTxt, 0)

	-- Create levelTxt_1
	local levelTxt_1 = GUI:Text_Create(FrameLayout, "levelTxt_1", 649, 96, 18, "#bdbdb5", [[你今日累计通关:]])
	GUI:Text_enableOutline(levelTxt_1, "#000000", 1)
	GUI:setAnchorPoint(levelTxt_1, 0.00, 0.00)
	GUI:setTouchEnabled(levelTxt_1, false)
	GUI:setTag(levelTxt_1, 0)

	-- Create levelTxt
	local levelTxt = GUI:Text_Create(FrameLayout, "levelTxt", 787, 96, 18, "#00ffe8", [[0次]])
	GUI:Text_enableOutline(levelTxt, "#000000", 1)
	GUI:setAnchorPoint(levelTxt, 0.00, 0.00)
	GUI:setTouchEnabled(levelTxt, false)
	GUI:setTag(levelTxt, 0)

	-- Create enterBtn
	local enterBtn = GUI:Button_Create(FrameLayout, "enterBtn", 382, 82, "res/custom/npc/21fb/symj/btn1.png")
	GUI:Button_loadTexturePressed(enterBtn, "res/custom/npc/21fb/symj/btn2.png")
	GUI:setContentSize(enterBtn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(enterBtn, false)
	GUI:Button_setTitleText(enterBtn, [[前往挑战]])
	GUI:Button_setTitleColor(enterBtn, "#ffffff")
	GUI:Button_setTitleFontSize(enterBtn, 18)
	GUI:Button_titleEnableOutline(enterBtn, "#000000", 1)
	GUI:setAnchorPoint(enterBtn, 0.00, 0.00)
	GUI:setTouchEnabled(enterBtn, true)
	GUI:setTag(enterBtn, 0)

	-- Create rewardNode
	local rewardNode = GUI:Node_Create(FrameLayout, "rewardNode", 0, 0)
	GUI:setTag(rewardNode, 0)

	-- Create titleIcon
	local titleIcon = GUI:Image_Create(rewardNode, "titleIcon", 650, 410, "res/custom/npc/21fb/symj/title.png")
	GUI:setAnchorPoint(titleIcon, 0.00, 0.00)
	GUI:setTouchEnabled(titleIcon, false)
	GUI:setTag(titleIcon, 0)

	-- Create bgImg
	local bgImg = GUI:Image_Create(rewardNode, "bgImg", 622, 130, "res/custom/npc/21fb/fengmo/phbg2.png")
	GUI:setAnchorPoint(bgImg, 0.00, 0.00)
	GUI:setTouchEnabled(bgImg, false)
	GUI:setTag(bgImg, 0)

	-- Create reward_cell_1
	local reward_cell_1 = GUI:Image_Create(bgImg, "reward_cell_1", 0, 179, "res/custom/npc/21fb/symj/symjbg.png")
	GUI:setAnchorPoint(reward_cell_1, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_1, false)
	GUI:setTag(reward_cell_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(reward_cell_1, "Text_2", 16, 21, 16, "#00ff00", [[通关
 5次]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(reward_cell_1, "ItemShow_1", 93, 43, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create getBtn_1
	local getBtn_1 = GUI:Button_Create(reward_cell_1, "getBtn_1", 142, 28, "res/custom/npc/21fb/symj/lq1.png")
	GUI:Button_loadTexturePressed(getBtn_1, "res/custom/npc/21fb/symj/lq2.png")
	GUI:setContentSize(getBtn_1, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(getBtn_1, false)
	GUI:Button_setTitleText(getBtn_1, [[]])
	GUI:Button_setTitleColor(getBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(getBtn_1, 16)
	GUI:Button_titleEnableOutline(getBtn_1, "#000000", 1)
	GUI:setAnchorPoint(getBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(getBtn_1, true)
	GUI:setTag(getBtn_1, 0)

	-- Create getTag_1
	local getTag_1 = GUI:Image_Create(reward_cell_1, "getTag_1", 141, 29, "res/custom/npc/21fb/symj/lq11.png")
	GUI:setContentSize(getTag_1, 80, 32)
	GUI:setIgnoreContentAdaptWithSize(getTag_1, false)
	GUI:setAnchorPoint(getTag_1, 0.00, 0.00)
	GUI:setTouchEnabled(getTag_1, false)
	GUI:setTag(getTag_1, 0)

	-- Create reward_cell_2
	local reward_cell_2 = GUI:Image_Create(bgImg, "reward_cell_2", 0, 89, "res/custom/npc/21fb/symj/symjbg.png")
	GUI:setAnchorPoint(reward_cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_2, false)
	GUI:setTag(reward_cell_2, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(reward_cell_2, "Text_2", 16, 21, 16, "#00ff00", [[通关
10次]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(reward_cell_2, "ItemShow_2", 93, 43, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create getBtn_2
	local getBtn_2 = GUI:Button_Create(reward_cell_2, "getBtn_2", 142, 28, "res/custom/npc/21fb/symj/lq1.png")
	GUI:Button_loadTexturePressed(getBtn_2, "res/custom/npc/21fb/symj/lq2.png")
	GUI:setContentSize(getBtn_2, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(getBtn_2, false)
	GUI:Button_setTitleText(getBtn_2, [[]])
	GUI:Button_setTitleColor(getBtn_2, "#ffffff")
	GUI:Button_setTitleFontSize(getBtn_2, 16)
	GUI:Button_titleEnableOutline(getBtn_2, "#000000", 1)
	GUI:setAnchorPoint(getBtn_2, 0.00, 0.00)
	GUI:setTouchEnabled(getBtn_2, true)
	GUI:setTag(getBtn_2, 0)

	-- Create getTag_2
	local getTag_2 = GUI:Image_Create(reward_cell_2, "getTag_2", 141, 29, "res/custom/npc/21fb/symj/lq11.png")
	GUI:setContentSize(getTag_2, 80, 32)
	GUI:setIgnoreContentAdaptWithSize(getTag_2, false)
	GUI:setAnchorPoint(getTag_2, 0.00, 0.00)
	GUI:setTouchEnabled(getTag_2, false)
	GUI:setTag(getTag_2, 0)

	-- Create reward_cell_3
	local reward_cell_3 = GUI:Image_Create(bgImg, "reward_cell_3", 0, 0, "res/custom/npc/21fb/symj/symjbg.png")
	GUI:setAnchorPoint(reward_cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_3, false)
	GUI:setTag(reward_cell_3, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(reward_cell_3, "Text_2", 16, 21, 16, "#00ff00", [[通关
20次]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(reward_cell_3, "ItemShow_3", 93, 43, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create getBtn_3
	local getBtn_3 = GUI:Button_Create(reward_cell_3, "getBtn_3", 142, 28, "res/custom/npc/21fb/symj/lq1.png")
	GUI:Button_loadTexturePressed(getBtn_3, "res/custom/npc/21fb/symj/lq2.png")
	GUI:setContentSize(getBtn_3, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(getBtn_3, false)
	GUI:Button_setTitleText(getBtn_3, [[]])
	GUI:Button_setTitleColor(getBtn_3, "#ffffff")
	GUI:Button_setTitleFontSize(getBtn_3, 16)
	GUI:Button_titleEnableOutline(getBtn_3, "#000000", 1)
	GUI:setAnchorPoint(getBtn_3, 0.00, 0.00)
	GUI:setTouchEnabled(getBtn_3, true)
	GUI:setTag(getBtn_3, 0)

	-- Create getTag_3
	local getTag_3 = GUI:Image_Create(reward_cell_3, "getTag_3", 141, 29, "res/custom/npc/21fb/symj/lq11.png")
	GUI:setContentSize(getTag_3, 80, 32)
	GUI:setIgnoreContentAdaptWithSize(getTag_3, false)
	GUI:setAnchorPoint(getTag_3, 0.00, 0.00)
	GUI:setTouchEnabled(getTag_3, false)
	GUI:setTag(getTag_3, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
