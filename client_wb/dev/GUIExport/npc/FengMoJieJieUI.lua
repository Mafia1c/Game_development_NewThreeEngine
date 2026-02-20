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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/21fb/fengmo/mb.png")
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

	-- Create Text_1
	local Text_1 = GUI:Text_Create(infoNode, "Text_1", 7, 123, 16, "#ffffff", [==========[每次投放 [                   ] 可获得]==========])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)
	GUI:setVisible(Text_1, false)

	-- Create itemTxt_1
	local itemTxt_1 = GUI:RichText_Create(infoNode, "itemTxt_1", 85, 122, [[<font color='#ffffff' size='18' ><a enableUnderline ='false' href = 'jump#item_tips#10068'><u><font color ='#FFFF00'>仙石*10</font></u></a></font>]], 80, 16, "#ffffff", 4)
	GUI:setAnchorPoint(itemTxt_1, 0.00, 0.00)
	GUI:setTag(itemTxt_1, 0)
	GUI:setVisible(itemTxt_1, false)

	-- Create itemTxt_2
	local itemTxt_2 = GUI:RichText_Create(infoNode, "itemTxt_2", 213, 122, [[<font color='#ffffff' size='18' ><a enableUnderline ='false' href = 'jump#item_tips#10066'><u><font color ='#FFFF00'>帝王印记X1</font></u></a></font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(itemTxt_2, 0.00, 0.00)
	GUI:setTag(itemTxt_2, 0)
	GUI:setVisible(itemTxt_2, false)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(infoNode, "RichText_1", 8, 72, [==========[<font color='#ffffff' size='16' >投放满</font><font color='#9b00ff' size='16' > 999次</font><font color='#ff9b00' size='16' >  [ 结界之地 ] </font><font color='#ffffff' size='16' > 复活 </font><font color='#ff0000' size='16' >[ 永夜帝王·米尔迦兰 ]</font>]==========], 320, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)
	GUI:setVisible(RichText_1, false)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(infoNode, "RichText_2", 8, 47, [==========[<font color='#ffffff' size='16' >使用 </font><font color='#00ff00' size='16' >[ 5种魔石 ] </font><font color='#ffffff' size='16' >可前往 </font><font color='#ff9b00' size='16' >[ 结界禁地 ] </font><font color='#ffffff' size='16' >直接</font>]==========], 320, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)
	GUI:setVisible(RichText_2, false)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(infoNode, "RichText_3", 8, 16, [==========[<font color='#ffffff' size='16' >召唤 </font><font color='#ff0000' size='16' >[ 永夜帝王·米尔迦兰 ]</font>]==========], 320, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.00, 0.00)
	GUI:setTag(RichText_3, 0)
	GUI:setVisible(RichText_3, false)

	-- Create RichText_4
	local RichText_4 = GUI:RichText_Create(infoNode, "RichText_4", 164, 75, [[<font color='#ffffff' size='16' >每次激活封魔结界需要</font><font color='#ffff00' size='16' >【仙石*10】</font><font color='#ffffff' size='16' >可获得</font><font color='#00ff00' size='16' >帝王印记*1</font><font color='#ffffff' size='16' >，投放</font><font color='#00ff00' size='16' >999</font><font color='#ffffff' size='16' >次，</font><font color='#ff9b00' size='16' >结界之地</font><font color='#ffffff' size='16' >(为本服，每次进入需要</font><font color='#00ff00' size='16' >帝王印记*1</font><font color='#ffffff' size='16' >)复活</font><font color='#ff0000' size='16' >【永夜帝王·米尔迦兰】，</font><font color='#ffffff' size='16' >进入</font><font color='#ff9b00' size='16' >【结界禁地】</font><font color='#ffffff' size='16' >需要</font><font color='#00ff00' size='16' >帝王印记*1</font><font color='#ffffff' size='16' >，</font><font color='#ff9b00' size='16' >结界禁地</font><font color='#ffffff' size='16' >为跨服地图，每3小时刷新一只</font><font color='#ff0000' size='16' >【永夜帝王·米尔迦兰】</font>]], 300, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_4, 0.50, 0.50)
	GUI:setTag(RichText_4, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 630, 100, "res/custom/npc/21fb/fengmo/tg.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(FrameLayout, "Image_3", 303, 279, "res/custom/npc/21fb/fengmo/bbg.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(FrameLayout, "Image_4", 317, 293, "res/custom/npc/21fb/fengmo/cs.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create totalLevelTxt
	local totalLevelTxt = GUI:Text_Create(FrameLayout, "totalLevelTxt", 484, 290, 18, "#ff0000", [[100]])
	GUI:Text_enableOutline(totalLevelTxt, "#000000", 1)
	GUI:setAnchorPoint(totalLevelTxt, 0.00, 0.00)
	GUI:setTouchEnabled(totalLevelTxt, false)
	GUI:setTag(totalLevelTxt, 0)

	-- Create myLevelTxt
	local myLevelTxt = GUI:Text_Create(FrameLayout, "myLevelTxt", 757, 96, 18, "#00ffe8", [[100次]])
	GUI:Text_enableOutline(myLevelTxt, "#000000", 1)
	GUI:setAnchorPoint(myLevelTxt, 0.00, 0.00)
	GUI:setTouchEnabled(myLevelTxt, false)
	GUI:setTag(myLevelTxt, 0)

	-- Create enterBtn_1
	local enterBtn_1 = GUI:Button_Create(FrameLayout, "enterBtn_1", 268, 82, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(enterBtn_1, "res/custom/npc/an2.png")
	GUI:setContentSize(enterBtn_1, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(enterBtn_1, false)
	GUI:Button_setTitleText(enterBtn_1, [[进入结界之地]])
	GUI:Button_setTitleColor(enterBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(enterBtn_1, 15)
	GUI:Button_titleEnableOutline(enterBtn_1, "#000000", 1)
	GUI:setAnchorPoint(enterBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(enterBtn_1, true)
	GUI:setTag(enterBtn_1, 0)

	-- Create enterBtn_2
	local enterBtn_2 = GUI:Button_Create(FrameLayout, "enterBtn_2", 382, 82, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(enterBtn_2, "res/custom/npc/an2.png")
	GUI:setContentSize(enterBtn_2, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(enterBtn_2, false)
	GUI:Button_setTitleText(enterBtn_2, [[进入结界禁地]])
	GUI:Button_setTitleColor(enterBtn_2, "#ffffff")
	GUI:Button_setTitleFontSize(enterBtn_2, 15)
	GUI:Button_titleEnableOutline(enterBtn_2, "#000000", 1)
	GUI:setAnchorPoint(enterBtn_2, 0.00, 0.00)
	GUI:setTouchEnabled(enterBtn_2, true)
	GUI:setTag(enterBtn_2, 0)

	-- Create enterBtn_3
	local enterBtn_3 = GUI:Button_Create(FrameLayout, "enterBtn_3", 494, 82, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(enterBtn_3, "res/custom/npc/an2.png")
	GUI:setContentSize(enterBtn_3, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(enterBtn_3, false)
	GUI:Button_setTitleText(enterBtn_3, [[投放仙石*10]])
	GUI:Button_setTitleColor(enterBtn_3, "#ffffff")
	GUI:Button_setTitleFontSize(enterBtn_3, 15)
	GUI:Button_titleEnableOutline(enterBtn_3, "#000000", 1)
	GUI:setAnchorPoint(enterBtn_3, 0.00, 0.00)
	GUI:setTouchEnabled(enterBtn_3, true)
	GUI:setTag(enterBtn_3, 0)

	-- Create rewardNode
	local rewardNode = GUI:Node_Create(FrameLayout, "rewardNode", 0, 0)
	GUI:setTag(rewardNode, 0)

	-- Create titleIcon
	local titleIcon = GUI:Image_Create(rewardNode, "titleIcon", 650, 410, "res/custom/npc/21fb/fengmo/title.png")
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
	local Text_2 = GUI:Text_Create(reward_cell_1, "Text_2", 16, 21, 16, "#00ff00", [[投放
10次]])
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
	Text_2 = GUI:Text_Create(reward_cell_2, "Text_2", 16, 21, 16, "#00ff00", [[投放
20次]])
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
	Text_2 = GUI:Text_Create(reward_cell_3, "Text_2", 16, 21, 16, "#00ff00", [[投放
30次]])
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

	-- Create exchangeNode
	local exchangeNode = GUI:Node_Create(FrameLayout, "exchangeNode", 0, 0)
	GUI:setTag(exchangeNode, 0)
	GUI:setVisible(exchangeNode, false)

	-- Create titleIcon
	titleIcon = GUI:Image_Create(exchangeNode, "titleIcon", 650, 410, "res/custom/npc/21fb/fengmo/title2.png")
	GUI:setAnchorPoint(titleIcon, 0.00, 0.00)
	GUI:setTouchEnabled(titleIcon, false)
	GUI:setTag(titleIcon, 0)

	-- Create bgImg
	bgImg = GUI:Image_Create(exchangeNode, "bgImg", 622, 130, "res/custom/npc/21fb/fengmo/phbg2.png")
	GUI:setAnchorPoint(bgImg, 0.00, 0.00)
	GUI:setTouchEnabled(bgImg, false)
	GUI:setTag(bgImg, 0)

	-- Create exchange_cell_1
	local exchange_cell_1 = GUI:Image_Create(bgImg, "exchange_cell_1", 0, 179, "res/custom/npc/21fb/symj/symjbg.png")
	GUI:setAnchorPoint(exchange_cell_1, 0.00, 0.00)
	GUI:setTouchEnabled(exchange_cell_1, false)
	GUI:setTag(exchange_cell_1, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(exchange_cell_1, "Text_2", 182, 55, 14, "#ff0000", [[帝王印记*588]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(exchange_cell_1, "Image_1", 83, 27, "res/custom/npc/19fl/t4.png")
	GUI:setContentSize(Image_1, 38, 36)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ExShow_1
	local ExShow_1 = GUI:ItemShow_Create(exchange_cell_1, "ExShow_1", 38, 43, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ExShow_1, 0.50, 0.50)
	GUI:setTag(ExShow_1, 0)

	-- Create exchangeBtn_1
	local exchangeBtn_1 = GUI:Button_Create(exchange_cell_1, "exchangeBtn_1", 142, 15, "res/custom/npc/21fb/fengmo/dh1.png")
	GUI:Button_loadTexturePressed(exchangeBtn_1, "res/custom/npc/21fb/fengmo/dh2.png")
	GUI:setContentSize(exchangeBtn_1, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(exchangeBtn_1, false)
	GUI:Button_setTitleText(exchangeBtn_1, [[]])
	GUI:Button_setTitleColor(exchangeBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(exchangeBtn_1, 16)
	GUI:Button_titleEnableOutline(exchangeBtn_1, "#000000", 1)
	GUI:setAnchorPoint(exchangeBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(exchangeBtn_1, true)
	GUI:setTag(exchangeBtn_1, 0)

	-- Create exchangeTag_1
	local exchangeTag_1 = GUI:Image_Create(exchange_cell_1, "exchangeTag_1", 145, 15, "res/custom/npc/21fb/fengmo/dh11.png")
	GUI:setContentSize(exchangeTag_1, 80, 32)
	GUI:setIgnoreContentAdaptWithSize(exchangeTag_1, false)
	GUI:setAnchorPoint(exchangeTag_1, 0.00, 0.00)
	GUI:setTouchEnabled(exchangeTag_1, false)
	GUI:setTag(exchangeTag_1, 0)

	-- Create exchange_cell_2
	local exchange_cell_2 = GUI:Image_Create(bgImg, "exchange_cell_2", 0, 89, "res/custom/npc/21fb/symj/symjbg.png")
	GUI:setAnchorPoint(exchange_cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(exchange_cell_2, false)
	GUI:setTag(exchange_cell_2, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(exchange_cell_2, "Text_2", 182, 55, 14, "#ff0000", [[帝王印记*588]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(exchange_cell_2, "Image_1", 83, 27, "res/custom/npc/19fl/t4.png")
	GUI:setContentSize(Image_1, 38, 36)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ExShow_2
	local ExShow_2 = GUI:ItemShow_Create(exchange_cell_2, "ExShow_2", 38, 43, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ExShow_2, 0.50, 0.50)
	GUI:setTag(ExShow_2, 0)

	-- Create exchangeBtn_2
	local exchangeBtn_2 = GUI:Button_Create(exchange_cell_2, "exchangeBtn_2", 142, 15, "res/custom/npc/21fb/fengmo/dh1.png")
	GUI:Button_loadTexturePressed(exchangeBtn_2, "res/custom/npc/21fb/fengmo/dh2.png")
	GUI:setContentSize(exchangeBtn_2, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(exchangeBtn_2, false)
	GUI:Button_setTitleText(exchangeBtn_2, [[]])
	GUI:Button_setTitleColor(exchangeBtn_2, "#ffffff")
	GUI:Button_setTitleFontSize(exchangeBtn_2, 16)
	GUI:Button_titleEnableOutline(exchangeBtn_2, "#000000", 1)
	GUI:setAnchorPoint(exchangeBtn_2, 0.00, 0.00)
	GUI:setTouchEnabled(exchangeBtn_2, true)
	GUI:setTag(exchangeBtn_2, 0)

	-- Create exchangeTag_2
	local exchangeTag_2 = GUI:Image_Create(exchange_cell_2, "exchangeTag_2", 145, 15, "res/custom/npc/21fb/fengmo/dh11.png")
	GUI:setContentSize(exchangeTag_2, 80, 32)
	GUI:setIgnoreContentAdaptWithSize(exchangeTag_2, false)
	GUI:setAnchorPoint(exchangeTag_2, 0.00, 0.00)
	GUI:setTouchEnabled(exchangeTag_2, false)
	GUI:setTag(exchangeTag_2, 0)

	-- Create exchange_cell_3
	local exchange_cell_3 = GUI:Image_Create(bgImg, "exchange_cell_3", 0, -1, "res/custom/npc/21fb/symj/symjbg.png")
	GUI:setAnchorPoint(exchange_cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(exchange_cell_3, false)
	GUI:setTag(exchange_cell_3, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(exchange_cell_3, "Text_2", 182, 55, 14, "#ff0000", [[帝王印记*588]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(exchange_cell_3, "Image_1", 83, 27, "res/custom/npc/19fl/t4.png")
	GUI:setContentSize(Image_1, 38, 36)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ExShow_3
	local ExShow_3 = GUI:ItemShow_Create(exchange_cell_3, "ExShow_3", 38, 43, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ExShow_3, 0.50, 0.50)
	GUI:setTag(ExShow_3, 0)

	-- Create exchangeBtn_3
	local exchangeBtn_3 = GUI:Button_Create(exchange_cell_3, "exchangeBtn_3", 142, 15, "res/custom/npc/21fb/fengmo/dh1.png")
	GUI:Button_loadTexturePressed(exchangeBtn_3, "res/custom/npc/21fb/fengmo/dh2.png")
	GUI:setContentSize(exchangeBtn_3, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(exchangeBtn_3, false)
	GUI:Button_setTitleText(exchangeBtn_3, [[]])
	GUI:Button_setTitleColor(exchangeBtn_3, "#ffffff")
	GUI:Button_setTitleFontSize(exchangeBtn_3, 16)
	GUI:Button_titleEnableOutline(exchangeBtn_3, "#000000", 1)
	GUI:setAnchorPoint(exchangeBtn_3, 0.00, 0.00)
	GUI:setTouchEnabled(exchangeBtn_3, true)
	GUI:setTag(exchangeBtn_3, 0)

	-- Create exchangeTag_3
	local exchangeTag_3 = GUI:Image_Create(exchange_cell_3, "exchangeTag_3", 145, 15, "res/custom/npc/21fb/fengmo/dh11.png")
	GUI:setContentSize(exchangeTag_3, 80, 32)
	GUI:setIgnoreContentAdaptWithSize(exchangeTag_3, false)
	GUI:setAnchorPoint(exchangeTag_3, 0.00, 0.00)
	GUI:setTouchEnabled(exchangeTag_3, false)
	GUI:setTag(exchangeTag_3, 0)

	-- Create exchangeBtn
	local exchangeBtn = GUI:Button_Create(FrameLayout, "exchangeBtn", 679, 34, "res/custom/btn1.png")
	GUI:Button_loadTexturePressed(exchangeBtn, "res/custom/btn2.png")
	GUI:setContentSize(exchangeBtn, 120, 46)
	GUI:setIgnoreContentAdaptWithSize(exchangeBtn, false)
	GUI:Button_setTitleText(exchangeBtn, [[帝王印记兑换]])
	GUI:Button_setTitleColor(exchangeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(exchangeBtn, 16)
	GUI:Button_titleEnableOutline(exchangeBtn, "#000000", 1)
	GUI:setAnchorPoint(exchangeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(exchangeBtn, true)
	GUI:setTag(exchangeBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
