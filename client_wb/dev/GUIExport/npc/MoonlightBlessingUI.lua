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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 577, 319, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/51zq/bg2.png")
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
	GUI:Button_setTitleText(Button_1, [[爱吃月饼]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 72, 396, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[月之祈福]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 16)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(FrameLayout, "Button_3", 72, 352, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_3, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_3, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[连充奖励]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 16)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(FrameLayout, "Button_4", 72, 308, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_4, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_4, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[月饼兑换]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 16)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create pageNode_1
	local pageNode_1 = GUI:Node_Create(FrameLayout, "pageNode_1", 0, 0)
	GUI:setTag(pageNode_1, 0)
	GUI:setVisible(pageNode_1, false)

	-- Create jinniu_item
	local jinniu_item = GUI:ItemShow_Create(pageNode_1, "jinniu_item", 652, 304, {index = 11103, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(jinniu_item, 0.50, 0.50)
	GUI:setTag(jinniu_item, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(pageNode_1, "RichText_1", 516, 211, [[<font color='#00ff00' size='16' >20%几率</font><font color='#ffffff' size='16' >, 人物等级获得永久提升1级 人物等级满100级后才生效</font>]], 270, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(pageNode_1, "Text_1", 516, 183, 16, "#ffffff", [[最高可以提升                  级]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create upLevel_txt
	local upLevel_txt = GUI:Text_Create(pageNode_1, "upLevel_txt", 647, 183, 16, "#ff00ff", [[( 0 / 10 )]])
	GUI:Text_enableOutline(upLevel_txt, "#000000", 1)
	GUI:setAnchorPoint(upLevel_txt, 0.50, 0.00)
	GUI:setTouchEnabled(upLevel_txt, false)
	GUI:setTag(upLevel_txt, 0)

	-- Create useBtn
	local useBtn = GUI:Button_Create(pageNode_1, "useBtn", 603, 140, "res/custom/npc/51zq/sy21.png")
	GUI:Button_loadTexturePressed(useBtn, "res/custom/npc/51zq/sy22.png")
	GUI:setContentSize(useBtn, 104, 34)
	GUI:setIgnoreContentAdaptWithSize(useBtn, false)
	GUI:Button_setTitleText(useBtn, [[]])
	GUI:Button_setTitleColor(useBtn, "#ffffff")
	GUI:Button_setTitleFontSize(useBtn, 16)
	GUI:Button_titleEnableOutline(useBtn, "#000000", 1)
	GUI:setAnchorPoint(useBtn, 0.00, 0.00)
	GUI:setTouchEnabled(useBtn, true)
	GUI:setTag(useBtn, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(pageNode_1, "RichText_2", 515, 110, [==========[<font color='#ffffff' size='16' >合成 </font><font color='#00ffe8' size='16' >[金牛随喜]</font>]==========], 150, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(pageNode_1, "Text_2", 516, 78, 16, "#ff0000", [[五仁月饼*10  豆沙月饼*10]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(pageNode_1, "Text_3", 516, 51, 16, "#ff0000", [[莲蓉月饼*10  古纪卷轴*10]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create compoundBtn
	local compoundBtn = GUI:Button_Create(pageNode_1, "compoundBtn", 709, 61, "res/custom/npc/51zq/hc1.png")
	GUI:Button_loadTexturePressed(compoundBtn, "res/custom/npc/51zq/hc2.png")
	GUI:setContentSize(compoundBtn, 82, 34)
	GUI:setIgnoreContentAdaptWithSize(compoundBtn, false)
	GUI:Button_setTitleText(compoundBtn, [[]])
	GUI:Button_setTitleColor(compoundBtn, "#ffffff")
	GUI:Button_setTitleFontSize(compoundBtn, 16)
	GUI:Button_titleEnableOutline(compoundBtn, "#000000", 1)
	GUI:setAnchorPoint(compoundBtn, 0.00, 0.00)
	GUI:setTouchEnabled(compoundBtn, true)
	GUI:setTag(compoundBtn, 0)

	-- Create item_cell_1
	local item_cell_1 = GUI:Image_Create(pageNode_1, "item_cell_1", 199, 278, "res/custom/npc/51zq/list.png")
	GUI:setAnchorPoint(item_cell_1, 0.00, 0.00)
	GUI:setTouchEnabled(item_cell_1, false)
	GUI:setTag(item_cell_1, 0)

	-- Create yuebing_item
	local yuebing_item = GUI:ItemShow_Create(item_cell_1, "yuebing_item", 49, 75, {index = 11100, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(yuebing_item, 0.50, 0.50)
	GUI:setTag(yuebing_item, 0)

	-- Create item_name
	local item_name = GUI:Text_Create(item_cell_1, "item_name", 49, 15, 16, "#00ffe8", [[五仁月饼]])
	GUI:Text_enableOutline(item_name, "#000000", 1)
	GUI:setAnchorPoint(item_name, 0.50, 0.00)
	GUI:setTouchEnabled(item_name, false)
	GUI:setTag(item_name, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(item_cell_1, "Text_4", 100, 80, 16, "#a0a0a4", [[永久:]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(item_cell_1, "Text_5", 100, 52, 16, "#a0a0a4", [[累计:]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create useYBBtn_1
	local useYBBtn_1 = GUI:Button_Create(item_cell_1, "useYBBtn_1", 96, 9, "res/custom/npc/51zq/sy11.png")
	GUI:Button_loadTexturePressed(useYBBtn_1, "res/custom/npc/51zq/sy12.png")
	GUI:setContentSize(useYBBtn_1, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(useYBBtn_1, false)
	GUI:Button_setTitleText(useYBBtn_1, [[]])
	GUI:Button_setTitleColor(useYBBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(useYBBtn_1, 16)
	GUI:Button_titleEnableOutline(useYBBtn_1, "#000000", 1)
	GUI:setAnchorPoint(useYBBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(useYBBtn_1, true)
	GUI:setTag(useYBBtn_1, 0)

	-- Create allUseBtn_1
	local allUseBtn_1 = GUI:Button_Create(item_cell_1, "allUseBtn_1", 192, 9, "res/custom/npc/51zq/sy31.png")
	GUI:Button_loadTexturePressed(allUseBtn_1, "res/custom/npc/51zq/sy32.png")
	GUI:setContentSize(allUseBtn_1, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(allUseBtn_1, false)
	GUI:Button_setTitleText(allUseBtn_1, [[]])
	GUI:Button_setTitleColor(allUseBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(allUseBtn_1, 16)
	GUI:Button_titleEnableOutline(allUseBtn_1, "#000000", 1)
	GUI:setAnchorPoint(allUseBtn_1, 0.00, 0.00)
	GUI:setTouchEnabled(allUseBtn_1, true)
	GUI:setTag(allUseBtn_1, 0)

	-- Create hp_attr_txt
	local hp_attr_txt = GUI:Text_Create(item_cell_1, "hp_attr_txt", 146, 80, 16, "#00ff00", [[生命值 + 30]])
	GUI:Text_enableOutline(hp_attr_txt, "#000000", 1)
	GUI:setAnchorPoint(hp_attr_txt, 0.00, 0.00)
	GUI:setTouchEnabled(hp_attr_txt, false)
	GUI:setTag(hp_attr_txt, 0)

	-- Create use_txt
	local use_txt = GUI:Text_Create(item_cell_1, "use_txt", 146, 52, 16, "#ff00ff", [[0/2000 次]])
	GUI:Text_enableOutline(use_txt, "#000000", 1)
	GUI:setAnchorPoint(use_txt, 0.00, 0.00)
	GUI:setTouchEnabled(use_txt, false)
	GUI:setTag(use_txt, 0)

	-- Create item_cell_2
	local item_cell_2 = GUI:Image_Create(pageNode_1, "item_cell_2", 199, 155, "res/custom/npc/51zq/list.png")
	GUI:setAnchorPoint(item_cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(item_cell_2, false)
	GUI:setTag(item_cell_2, 0)

	-- Create yuebing_item
	yuebing_item = GUI:ItemShow_Create(item_cell_2, "yuebing_item", 49, 75, {index = 11101, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(yuebing_item, 0.50, 0.50)
	GUI:setTag(yuebing_item, 0)

	-- Create item_name
	item_name = GUI:Text_Create(item_cell_2, "item_name", 49, 15, 16, "#00ffe8", [[豆沙月饼]])
	GUI:Text_enableOutline(item_name, "#000000", 1)
	GUI:setAnchorPoint(item_name, 0.50, 0.00)
	GUI:setTouchEnabled(item_name, false)
	GUI:setTag(item_name, 0)

	-- Create Text_4
	Text_4 = GUI:Text_Create(item_cell_2, "Text_4", 100, 80, 16, "#a0a0a4", [[永久:]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	Text_5 = GUI:Text_Create(item_cell_2, "Text_5", 100, 52, 16, "#a0a0a4", [[累计:]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create useYBBtn_2
	local useYBBtn_2 = GUI:Button_Create(item_cell_2, "useYBBtn_2", 96, 9, "res/custom/npc/51zq/sy11.png")
	GUI:Button_loadTexturePressed(useYBBtn_2, "res/custom/npc/51zq/sy12.png")
	GUI:setContentSize(useYBBtn_2, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(useYBBtn_2, false)
	GUI:Button_setTitleText(useYBBtn_2, [[]])
	GUI:Button_setTitleColor(useYBBtn_2, "#ffffff")
	GUI:Button_setTitleFontSize(useYBBtn_2, 16)
	GUI:Button_titleEnableOutline(useYBBtn_2, "#000000", 1)
	GUI:setAnchorPoint(useYBBtn_2, 0.00, 0.00)
	GUI:setTouchEnabled(useYBBtn_2, true)
	GUI:setTag(useYBBtn_2, 0)

	-- Create allUseBtn_2
	local allUseBtn_2 = GUI:Button_Create(item_cell_2, "allUseBtn_2", 192, 9, "res/custom/npc/51zq/sy31.png")
	GUI:Button_loadTexturePressed(allUseBtn_2, "res/custom/npc/51zq/sy32.png")
	GUI:setContentSize(allUseBtn_2, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(allUseBtn_2, false)
	GUI:Button_setTitleText(allUseBtn_2, [[]])
	GUI:Button_setTitleColor(allUseBtn_2, "#ffffff")
	GUI:Button_setTitleFontSize(allUseBtn_2, 16)
	GUI:Button_titleEnableOutline(allUseBtn_2, "#000000", 1)
	GUI:setAnchorPoint(allUseBtn_2, 0.00, 0.00)
	GUI:setTouchEnabled(allUseBtn_2, true)
	GUI:setTag(allUseBtn_2, 0)

	-- Create attr_txt
	local attr_txt = GUI:Text_Create(item_cell_2, "attr_txt", 146, 80, 16, "#00ff00", [[攻魔道 + 1]])
	GUI:Text_enableOutline(attr_txt, "#000000", 1)
	GUI:setAnchorPoint(attr_txt, 0.00, 0.00)
	GUI:setTouchEnabled(attr_txt, false)
	GUI:setTag(attr_txt, 0)

	-- Create use_txt
	use_txt = GUI:Text_Create(item_cell_2, "use_txt", 146, 52, 16, "#ff00ff", [[0/1000 次]])
	GUI:Text_enableOutline(use_txt, "#000000", 1)
	GUI:setAnchorPoint(use_txt, 0.00, 0.00)
	GUI:setTouchEnabled(use_txt, false)
	GUI:setTag(use_txt, 0)

	-- Create item_cell_3
	local item_cell_3 = GUI:Image_Create(pageNode_1, "item_cell_3", 199, 32, "res/custom/npc/51zq/list.png")
	GUI:setAnchorPoint(item_cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(item_cell_3, false)
	GUI:setTag(item_cell_3, 0)

	-- Create yuebing_item
	yuebing_item = GUI:ItemShow_Create(item_cell_3, "yuebing_item", 49, 75, {index = 11102, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(yuebing_item, 0.50, 0.50)
	GUI:setTag(yuebing_item, 0)

	-- Create item_name
	item_name = GUI:Text_Create(item_cell_3, "item_name", 49, 15, 16, "#00ffe8", [[莲蓉月饼]])
	GUI:Text_enableOutline(item_name, "#000000", 1)
	GUI:setAnchorPoint(item_name, 0.50, 0.00)
	GUI:setTouchEnabled(item_name, false)
	GUI:setTag(item_name, 0)

	-- Create Text_4
	Text_4 = GUI:Text_Create(item_cell_3, "Text_4", 100, 80, 16, "#a0a0a4", [[永久:]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create Text_5
	Text_5 = GUI:Text_Create(item_cell_3, "Text_5", 100, 52, 16, "#a0a0a4", [[累计:]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create useYBBtn_3
	local useYBBtn_3 = GUI:Button_Create(item_cell_3, "useYBBtn_3", 96, 9, "res/custom/npc/51zq/sy11.png")
	GUI:Button_loadTexturePressed(useYBBtn_3, "res/custom/npc/51zq/sy12.png")
	GUI:setContentSize(useYBBtn_3, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(useYBBtn_3, false)
	GUI:Button_setTitleText(useYBBtn_3, [[]])
	GUI:Button_setTitleColor(useYBBtn_3, "#ffffff")
	GUI:Button_setTitleFontSize(useYBBtn_3, 16)
	GUI:Button_titleEnableOutline(useYBBtn_3, "#000000", 1)
	GUI:setAnchorPoint(useYBBtn_3, 0.00, 0.00)
	GUI:setTouchEnabled(useYBBtn_3, true)
	GUI:setTag(useYBBtn_3, 0)

	-- Create allUseBtn_3
	local allUseBtn_3 = GUI:Button_Create(item_cell_3, "allUseBtn_3", 192, 9, "res/custom/npc/51zq/sy31.png")
	GUI:Button_loadTexturePressed(allUseBtn_3, "res/custom/npc/51zq/sy32.png")
	GUI:setContentSize(allUseBtn_3, 80, 34)
	GUI:setIgnoreContentAdaptWithSize(allUseBtn_3, false)
	GUI:Button_setTitleText(allUseBtn_3, [[]])
	GUI:Button_setTitleColor(allUseBtn_3, "#ffffff")
	GUI:Button_setTitleFontSize(allUseBtn_3, 16)
	GUI:Button_titleEnableOutline(allUseBtn_3, "#000000", 1)
	GUI:setAnchorPoint(allUseBtn_3, 0.00, 0.00)
	GUI:setTouchEnabled(allUseBtn_3, true)
	GUI:setTag(allUseBtn_3, 0)

	-- Create attr_txt
	attr_txt = GUI:Text_Create(item_cell_3, "attr_txt", 146, 80, 16, "#00ff00", [[双防 + 1]])
	GUI:Text_enableOutline(attr_txt, "#000000", 1)
	GUI:setAnchorPoint(attr_txt, 0.00, 0.00)
	GUI:setTouchEnabled(attr_txt, false)
	GUI:setTag(attr_txt, 0)

	-- Create use_txt
	use_txt = GUI:Text_Create(item_cell_3, "use_txt", 146, 52, 16, "#ff00ff", [[0/1000 次]])
	GUI:Text_enableOutline(use_txt, "#000000", 1)
	GUI:setAnchorPoint(use_txt, 0.00, 0.00)
	GUI:setTouchEnabled(use_txt, false)
	GUI:setTag(use_txt, 0)

	-- Create pageNode_2
	local pageNode_2 = GUI:Node_Create(FrameLayout, "pageNode_2", 0, 0)
	GUI:setTag(pageNode_2, 0)

	-- Create ModelNode
	local ModelNode = GUI:Node_Create(pageNode_2, "ModelNode", 0, 0)
	GUI:setTag(ModelNode, 0)

	-- Create rank_bg_img
	local rank_bg_img = GUI:Image_Create(pageNode_2, "rank_bg_img", 222, 147, "res/custom/npc/tip.png")
	GUI:setAnchorPoint(rank_bg_img, 0.00, 0.00)
	GUI:setTouchEnabled(rank_bg_img, false)
	GUI:setTag(rank_bg_img, 0)

	-- Create Text_7
	local Text_7 = GUI:Text_Create(pageNode_2, "Text_7", 352, 126, 14, "#ffff00", [[每日0点系统自动统计排名并发放称号]])
	GUI:Text_enableOutline(Text_7, "#000000", 1)
	GUI:setAnchorPoint(Text_7, 0.50, 0.00)
	GUI:setTouchEnabled(Text_7, false)
	GUI:setTag(Text_7, 0)

	-- Create title_item
	local title_item = GUI:ItemShow_Create(pageNode_2, "title_item", 239, 64, {index = 10182, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(title_item, 0.50, 0.50)
	GUI:setTag(title_item, 0)

	-- Create Text_8
	local Text_8 = GUI:Text_Create(pageNode_2, "Text_8", 285, 65, 16, "#00ff00", [[积分满5000点]])
	GUI:Text_enableOutline(Text_8, "#000000", 1)
	GUI:setAnchorPoint(Text_8, 0.00, 0.00)
	GUI:setTouchEnabled(Text_8, false)
	GUI:setTag(Text_8, 0)

	-- Create Text_9
	local Text_9 = GUI:Text_Create(pageNode_2, "Text_9", 285, 40, 16, "#ffffff", [[即可参与排名]])
	GUI:Text_enableOutline(Text_9, "#000000", 1)
	GUI:setAnchorPoint(Text_9, 0.00, 0.00)
	GUI:setTouchEnabled(Text_9, false)
	GUI:setTag(Text_9, 0)

	-- Create rankBtn
	local rankBtn = GUI:Button_Create(pageNode_2, "rankBtn", 431, 37, "res/custom/npc/51zq/b1.png")
	GUI:Button_loadTexturePressed(rankBtn, "res/custom/npc/51zq/b2.png")
	GUI:setContentSize(rankBtn, 66, 58)
	GUI:setIgnoreContentAdaptWithSize(rankBtn, false)
	GUI:Button_setTitleText(rankBtn, [[]])
	GUI:Button_setTitleColor(rankBtn, "#ffffff")
	GUI:Button_setTitleFontSize(rankBtn, 16)
	GUI:Button_titleEnableOutline(rankBtn, "#000000", 1)
	GUI:setAnchorPoint(rankBtn, 0.00, 0.00)
	GUI:setTouchEnabled(rankBtn, true)
	GUI:setTag(rankBtn, 0)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(pageNode_2, "RichText_3", 523, 291, [==========[<font color='#ffffff' size='16' >每使用一个</font><font color='#00ff00' size='16' >五仁丶豆沙丶莲蓉月饼</font><font color='#ffffff' size='16' >,可获得</font><font color='#00ff00' size='16' >10祈福积分</font><font color='#ffffff' size='16' >, 使用 </font><font color='#ff9b00' size='16' >[金牛随喜] </font><font color='#ffffff' size='16' >可获得</font><font color='#ff9b00' size='16' >500祈福积分</font>]==========], 270, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.00, 0.00)
	GUI:setTag(RichText_3, 0)

	-- Create total_point
	local total_point = GUI:Text_Create(pageNode_2, "total_point", 654, 258, 16, "#00ffe8", [[当前祈福积分: 0]])
	GUI:Text_enableOutline(total_point, "#000000", 1)
	GUI:setAnchorPoint(total_point, 0.50, 0.00)
	GUI:setTouchEnabled(total_point, false)
	GUI:setTag(total_point, 0)

	-- Create Text_10
	local Text_10 = GUI:Text_Create(pageNode_2, "Text_10", 660, 30, 14, "#ff0000", [[积分达标时系统自动奖励]])
	GUI:Text_enableOutline(Text_10, "#000000", 1)
	GUI:setAnchorPoint(Text_10, 0.50, 0.00)
	GUI:setTouchEnabled(Text_10, false)
	GUI:setTag(Text_10, 0)

	-- Create RichText_4
	local RichText_4 = GUI:RichText_Create(pageNode_2, "RichText_4", 519, 199, [[<font color='#ffffff' size='14' >满</font><font color='#ff9b00' size='14' > 1000祈福积分 </font><font color='#ffffff' size='14' >获得称号: </font><font color='#9b00ff' size='14' > </font><font color='#ee00fd' size='14' >逍遥</font>]], 270, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_4, 0.00, 0.00)
	GUI:setTag(RichText_4, 0)

	-- Create RichText_5
	local RichText_5 = GUI:RichText_Create(pageNode_2, "RichText_5", 519, 174, [[<font color='#ffffff' size='14' >满</font><font color='#ff9b00' size='14' > 3000祈福积分 </font><font color='#ffffff' size='14' >获得称号: </font><font color='#ee00fd' size='14' > 斜月三星</font>]], 270, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_5, 0.00, 0.00)
	GUI:setTag(RichText_5, 0)

	-- Create RichText_6
	local RichText_6 = GUI:RichText_Create(pageNode_2, "RichText_6", 519, 149, [[<font color='#ffffff' size='14' >满</font><font color='#ff9b00' size='14' > 5000祈福积分 </font><font color='#ffffff' size='14' >获得称号: </font><font color='#ee00fd' size='14' > 来啊快活啊</font>]], 270, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_6, 0.00, 0.00)
	GUI:setTag(RichText_6, 0)

	-- Create RichText_7
	local RichText_7 = GUI:RichText_Create(pageNode_2, "RichText_7", 519, 124, [[<font color='#ffffff' size='14' >满</font><font color='#ff9b00' size='14' > 9999祈福积分 </font><font color='#ffffff' size='14' >获得足迹: </font><font color='#ee00fd' size='14' > </font><font color='#00ffe8' size='14' >紫气东来</font>]], 270, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_7, 0.00, 0.00)
	GUI:setTag(RichText_7, 0)

	-- Create Effect_1
	local Effect_1 = GUI:Effect_Create(pageNode_2, "Effect_1", 349, 325, 0, 14149, 0, 0, 0, 1)
	GUI:setTag(Effect_1, 0)

	-- Create rankBg
	local rankBg = GUI:Image_Create(pageNode_2, "rankBg", 199, 124, "res/public/1900000677.png")
	GUI:Image_setScale9Slice(rankBg, 6, 6, 33, 33)
	GUI:setContentSize(rankBg, 308, 149)
	GUI:setIgnoreContentAdaptWithSize(rankBg, false)
	GUI:setAnchorPoint(rankBg, 0.00, 0.00)
	GUI:setTouchEnabled(rankBg, false)
	GUI:setTag(rankBg, 0)
	GUI:setVisible(rankBg, false)

	-- Create icon_1
	local icon_1 = GUI:Image_Create(rankBg, "icon_1", 16, 100, "res/private/rank_ui/rank_ui_mobile/1900020025.png")
	GUI:setContentSize(icon_1, 34, 34)
	GUI:setIgnoreContentAdaptWithSize(icon_1, false)
	GUI:setAnchorPoint(icon_1, 0.00, 0.00)
	GUI:setTouchEnabled(icon_1, false)
	GUI:setTag(icon_1, 0)

	-- Create icon_2
	local icon_2 = GUI:Image_Create(rankBg, "icon_2", 16, 55, "res/private/rank_ui/rank_ui_mobile/1900020026.png")
	GUI:setContentSize(icon_2, 34, 34)
	GUI:setIgnoreContentAdaptWithSize(icon_2, false)
	GUI:setAnchorPoint(icon_2, 0.00, 0.00)
	GUI:setTouchEnabled(icon_2, false)
	GUI:setTag(icon_2, 0)

	-- Create icon_3
	local icon_3 = GUI:Image_Create(rankBg, "icon_3", 16, 10, "res/private/rank_ui/rank_ui_mobile/1900020027.png")
	GUI:setContentSize(icon_3, 34, 34)
	GUI:setIgnoreContentAdaptWithSize(icon_3, false)
	GUI:setAnchorPoint(icon_3, 0.00, 0.00)
	GUI:setTouchEnabled(icon_3, false)
	GUI:setTag(icon_3, 0)

	-- Create close
	local close = GUI:Button_Create(rankBg, "close", 280, 105, "res/public/11.png")
	GUI:Button_loadTexturePressed(close, "res/public/12.png")
	GUI:setContentSize(close, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(close, false)
	GUI:Button_setTitleText(close, [[]])
	GUI:Button_setTitleColor(close, "#ffffff")
	GUI:Button_setTitleFontSize(close, 16)
	GUI:Button_titleEnableOutline(close, "#000000", 1)
	GUI:setAnchorPoint(close, 0.00, 0.00)
	GUI:setTouchEnabled(close, true)
	GUI:setTag(close, 0)

	-- Create title_item_1
	local title_item_1 = GUI:ItemShow_Create(pageNode_2, "title_item_1", 552, 80, {index = 10255, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(title_item_1, 0.50, 0.50)
	GUI:setMouseEnabled(title_item_1, true)
	GUI:setTag(title_item_1, 0)

	-- Create title_item_2
	local title_item_2 = GUI:ItemShow_Create(pageNode_2, "title_item_2", 622, 80, {index = 10256, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(title_item_2, 0.50, 0.50)
	GUI:setMouseEnabled(title_item_2, true)
	GUI:setTag(title_item_2, 0)

	-- Create title_item_3
	local title_item_3 = GUI:ItemShow_Create(pageNode_2, "title_item_3", 692, 80, {index = 10184, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(title_item_3, 0.50, 0.50)
	GUI:setMouseEnabled(title_item_3, true)
	GUI:setTag(title_item_3, 0)

	-- Create title_item_4
	local title_item_4 = GUI:ItemShow_Create(pageNode_2, "title_item_4", 762, 80, {index = 11064, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(title_item_4, 0.50, 0.50)
	GUI:setMouseEnabled(title_item_4, true)
	GUI:setTag(title_item_4, 0)

	-- Create pageNode_3
	local pageNode_3 = GUI:Node_Create(FrameLayout, "pageNode_3", 0, 0)
	GUI:setTag(pageNode_3, 0)
	GUI:setVisible(pageNode_3, false)

	-- Create rechange_cell_1
	local rechange_cell_1 = GUI:Image_Create(pageNode_3, "rechange_cell_1", 198, 309, "res/custom/npc/51zq/list4.png")
	GUI:setContentSize(rechange_cell_1, 298, 84)
	GUI:setIgnoreContentAdaptWithSize(rechange_cell_1, false)
	GUI:setAnchorPoint(rechange_cell_1, 0.00, 0.00)
	GUI:setTouchEnabled(rechange_cell_1, false)
	GUI:setTag(rechange_cell_1, 0)

	-- Create RichText_8
	local RichText_8 = GUI:RichText_Create(rechange_cell_1, "RichText_8", 11, 34, [[<font color='#ffffff' size='16' >累充 </font><font color='#9b00ff' size='16' >1</font><font color='#ffffff' size='16' > 天</font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_8, 0.00, 0.00)
	GUI:setTag(RichText_8, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(rechange_cell_1, "ItemShow_1", 124, 42, {index = 11100, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(rechange_cell_1, "ItemShow_2", 188, 42, {index = 11101, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(rechange_cell_1, "ItemShow_3", 251, 42, {index = 11102, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create tag_icon
	local tag_icon = GUI:Image_Create(rechange_cell_1, "tag_icon", 1, 18, "res/custom/npc/51zq/y1.png")
	GUI:setContentSize(tag_icon, 68, 66)
	GUI:setIgnoreContentAdaptWithSize(tag_icon, false)
	GUI:setAnchorPoint(tag_icon, 0.00, 0.00)
	GUI:setTouchEnabled(tag_icon, false)
	GUI:setTag(tag_icon, 0)
	GUI:setVisible(tag_icon, false)

	-- Create rechange_cell_2
	local rechange_cell_2 = GUI:Image_Create(pageNode_3, "rechange_cell_2", 499, 309, "res/custom/npc/51zq/list4.png")
	GUI:setContentSize(rechange_cell_2, 298, 84)
	GUI:setIgnoreContentAdaptWithSize(rechange_cell_2, false)
	GUI:setAnchorPoint(rechange_cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(rechange_cell_2, false)
	GUI:setTag(rechange_cell_2, 0)

	-- Create RichText_8
	RichText_8 = GUI:RichText_Create(rechange_cell_2, "RichText_8", 11, 34, [[<font color='#ffffff' size='16' >累充 </font><font color='#9b00ff' size='16' >2</font><font color='#ffffff' size='16' > 天</font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_8, 0.00, 0.00)
	GUI:setTag(RichText_8, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(rechange_cell_2, "ItemShow_1", 124, 42, {index = 11100, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(rechange_cell_2, "ItemShow_2", 188, 42, {index = 11101, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(rechange_cell_2, "ItemShow_3", 251, 42, {index = 11102, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create tag_icon
	tag_icon = GUI:Image_Create(rechange_cell_2, "tag_icon", 1, 18, "res/custom/npc/51zq/y1.png")
	GUI:setContentSize(tag_icon, 68, 66)
	GUI:setIgnoreContentAdaptWithSize(tag_icon, false)
	GUI:setAnchorPoint(tag_icon, 0.00, 0.00)
	GUI:setTouchEnabled(tag_icon, false)
	GUI:setTag(tag_icon, 0)
	GUI:setVisible(tag_icon, false)

	-- Create rechange_cell_3
	local rechange_cell_3 = GUI:Image_Create(pageNode_3, "rechange_cell_3", 198, 218, "res/custom/npc/51zq/list4.png")
	GUI:setContentSize(rechange_cell_3, 298, 84)
	GUI:setIgnoreContentAdaptWithSize(rechange_cell_3, false)
	GUI:setAnchorPoint(rechange_cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(rechange_cell_3, false)
	GUI:setTag(rechange_cell_3, 0)

	-- Create RichText_8
	RichText_8 = GUI:RichText_Create(rechange_cell_3, "RichText_8", 11, 34, [[<font color='#ffffff' size='16' >累充 </font><font color='#9b00ff' size='16' >3</font><font color='#ffffff' size='16' > 天</font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_8, 0.00, 0.00)
	GUI:setTag(RichText_8, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(rechange_cell_3, "ItemShow_1", 124, 42, {index = 11100, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(rechange_cell_3, "ItemShow_2", 188, 42, {index = 11101, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(rechange_cell_3, "ItemShow_3", 251, 42, {index = 11102, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create tag_icon
	tag_icon = GUI:Image_Create(rechange_cell_3, "tag_icon", 1, 18, "res/custom/npc/51zq/y1.png")
	GUI:setContentSize(tag_icon, 68, 66)
	GUI:setIgnoreContentAdaptWithSize(tag_icon, false)
	GUI:setAnchorPoint(tag_icon, 0.00, 0.00)
	GUI:setTouchEnabled(tag_icon, false)
	GUI:setTag(tag_icon, 0)
	GUI:setVisible(tag_icon, false)

	-- Create rechange_cell_4
	local rechange_cell_4 = GUI:Image_Create(pageNode_3, "rechange_cell_4", 499, 218, "res/custom/npc/51zq/list4.png")
	GUI:setContentSize(rechange_cell_4, 298, 84)
	GUI:setIgnoreContentAdaptWithSize(rechange_cell_4, false)
	GUI:setAnchorPoint(rechange_cell_4, 0.00, 0.00)
	GUI:setTouchEnabled(rechange_cell_4, false)
	GUI:setTag(rechange_cell_4, 0)

	-- Create RichText_8
	RichText_8 = GUI:RichText_Create(rechange_cell_4, "RichText_8", 11, 34, [[<font color='#ffffff' size='16' >累充 </font><font color='#9b00ff' size='16' >4</font><font color='#ffffff' size='16' > 天</font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_8, 0.00, 0.00)
	GUI:setTag(RichText_8, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(rechange_cell_4, "ItemShow_1", 124, 42, {index = 11100, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(rechange_cell_4, "ItemShow_2", 188, 42, {index = 11101, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(rechange_cell_4, "ItemShow_3", 251, 42, {index = 11102, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create tag_icon
	tag_icon = GUI:Image_Create(rechange_cell_4, "tag_icon", 1, 18, "res/custom/npc/51zq/y1.png")
	GUI:setContentSize(tag_icon, 68, 66)
	GUI:setIgnoreContentAdaptWithSize(tag_icon, false)
	GUI:setAnchorPoint(tag_icon, 0.00, 0.00)
	GUI:setTouchEnabled(tag_icon, false)
	GUI:setTag(tag_icon, 0)
	GUI:setVisible(tag_icon, false)

	-- Create rechange_cell_5
	local rechange_cell_5 = GUI:Image_Create(pageNode_3, "rechange_cell_5", 198, 127, "res/custom/npc/51zq/list4.png")
	GUI:setContentSize(rechange_cell_5, 298, 84)
	GUI:setIgnoreContentAdaptWithSize(rechange_cell_5, false)
	GUI:setAnchorPoint(rechange_cell_5, 0.00, 0.00)
	GUI:setTouchEnabled(rechange_cell_5, false)
	GUI:setTag(rechange_cell_5, 0)

	-- Create RichText_8
	RichText_8 = GUI:RichText_Create(rechange_cell_5, "RichText_8", 11, 34, [[<font color='#ffffff' size='16' >累充 </font><font color='#9b00ff' size='16' >5</font><font color='#ffffff' size='16' > 天</font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_8, 0.00, 0.00)
	GUI:setTag(RichText_8, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(rechange_cell_5, "ItemShow_1", 124, 42, {index = 11100, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(rechange_cell_5, "ItemShow_2", 188, 42, {index = 11101, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(rechange_cell_5, "ItemShow_3", 251, 42, {index = 11102, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create tag_icon
	tag_icon = GUI:Image_Create(rechange_cell_5, "tag_icon", 1, 18, "res/custom/npc/51zq/y1.png")
	GUI:setContentSize(tag_icon, 68, 66)
	GUI:setIgnoreContentAdaptWithSize(tag_icon, false)
	GUI:setAnchorPoint(tag_icon, 0.00, 0.00)
	GUI:setTouchEnabled(tag_icon, false)
	GUI:setTag(tag_icon, 0)
	GUI:setVisible(tag_icon, false)

	-- Create rechange_cell_6
	local rechange_cell_6 = GUI:Image_Create(pageNode_3, "rechange_cell_6", 499, 127, "res/custom/npc/51zq/list4.png")
	GUI:setContentSize(rechange_cell_6, 298, 84)
	GUI:setIgnoreContentAdaptWithSize(rechange_cell_6, false)
	GUI:setAnchorPoint(rechange_cell_6, 0.00, 0.00)
	GUI:setTouchEnabled(rechange_cell_6, false)
	GUI:setTag(rechange_cell_6, 0)

	-- Create RichText_8
	RichText_8 = GUI:RichText_Create(rechange_cell_6, "RichText_8", 11, 34, [[<font color='#ffffff' size='16' >累充 </font><font color='#9b00ff' size='16' >6</font><font color='#ffffff' size='16' > 天</font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_8, 0.00, 0.00)
	GUI:setTag(RichText_8, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(rechange_cell_6, "ItemShow_1", 124, 42, {index = 11100, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(rechange_cell_6, "ItemShow_2", 188, 42, {index = 11101, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(rechange_cell_6, "ItemShow_3", 251, 42, {index = 11102, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create tag_icon
	tag_icon = GUI:Image_Create(rechange_cell_6, "tag_icon", 1, 18, "res/custom/npc/51zq/y1.png")
	GUI:setContentSize(tag_icon, 68, 66)
	GUI:setIgnoreContentAdaptWithSize(tag_icon, false)
	GUI:setAnchorPoint(tag_icon, 0.00, 0.00)
	GUI:setTouchEnabled(tag_icon, false)
	GUI:setTag(tag_icon, 0)
	GUI:setVisible(tag_icon, false)

	-- Create rechange_cell_7
	local rechange_cell_7 = GUI:Image_Create(pageNode_3, "rechange_cell_7", 198, 36, "res/custom/npc/51zq/list4.png")
	GUI:setContentSize(rechange_cell_7, 298, 84)
	GUI:setIgnoreContentAdaptWithSize(rechange_cell_7, false)
	GUI:setAnchorPoint(rechange_cell_7, 0.00, 0.00)
	GUI:setTouchEnabled(rechange_cell_7, false)
	GUI:setTag(rechange_cell_7, 0)

	-- Create RichText_8
	RichText_8 = GUI:RichText_Create(rechange_cell_7, "RichText_8", 11, 34, [[<font color='#ffffff' size='16' >累充 </font><font color='#9b00ff' size='16' >7</font><font color='#ffffff' size='16' > 天</font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_8, 0.00, 0.00)
	GUI:setTag(RichText_8, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(rechange_cell_7, "ItemShow_1", 124, 42, {index = 11100, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(rechange_cell_7, "ItemShow_2", 188, 42, {index = 11101, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(rechange_cell_7, "ItemShow_3", 251, 42, {index = 11102, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create tag_icon
	tag_icon = GUI:Image_Create(rechange_cell_7, "tag_icon", 1, 18, "res/custom/npc/51zq/y1.png")
	GUI:setContentSize(tag_icon, 68, 66)
	GUI:setIgnoreContentAdaptWithSize(tag_icon, false)
	GUI:setAnchorPoint(tag_icon, 0.00, 0.00)
	GUI:setTouchEnabled(tag_icon, false)
	GUI:setTag(tag_icon, 0)
	GUI:setVisible(tag_icon, false)

	-- Create rechange_cell_8
	local rechange_cell_8 = GUI:Image_Create(pageNode_3, "rechange_cell_8", 499, 36, "res/custom/npc/51zq/list4.png")
	GUI:setContentSize(rechange_cell_8, 298, 84)
	GUI:setIgnoreContentAdaptWithSize(rechange_cell_8, false)
	GUI:setAnchorPoint(rechange_cell_8, 0.00, 0.00)
	GUI:setTouchEnabled(rechange_cell_8, false)
	GUI:setTag(rechange_cell_8, 0)

	-- Create RichText_8
	RichText_8 = GUI:RichText_Create(rechange_cell_8, "RichText_8", 11, 34, [[<font color='#ffffff' size='16' > </font><font color='#9b00ff' size='16' >7</font><font color='#ffffff' size='16' > 天以上</font>]], 100, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_8, 0.00, 0.00)
	GUI:setTag(RichText_8, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(rechange_cell_8, "ItemShow_1", 124, 42, {index = 10781, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(rechange_cell_8, "ItemShow_2", 188, 42, {index = 10067, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(rechange_cell_8, "ItemShow_3", 251, 42, {index = 11103, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create tag_icon
	tag_icon = GUI:Image_Create(rechange_cell_8, "tag_icon", 1, 18, "res/custom/npc/51zq/y1.png")
	GUI:setContentSize(tag_icon, 68, 66)
	GUI:setIgnoreContentAdaptWithSize(tag_icon, false)
	GUI:setAnchorPoint(tag_icon, 0.00, 0.00)
	GUI:setTouchEnabled(tag_icon, false)
	GUI:setTag(tag_icon, 0)
	GUI:setVisible(tag_icon, false)

	-- Create recharge_txt
	local recharge_txt = GUI:Text_Create(pageNode_3, "recharge_txt", 217, 406, 16, "#00ffe8", [[你已连续充值: 0天]])
	GUI:Text_enableOutline(recharge_txt, "#000000", 1)
	GUI:setAnchorPoint(recharge_txt, 0.00, 0.00)
	GUI:setTouchEnabled(recharge_txt, false)
	GUI:setTag(recharge_txt, 0)

	-- Create getReward_btn
	local getReward_btn = GUI:Button_Create(pageNode_3, "getReward_btn", 637, 414, "res/custom/npc/51zq/hbtn1.png")
	GUI:Button_loadTexturePressed(getReward_btn, "res/custom/npc/51zq/hbtn2.png")
	GUI:setContentSize(getReward_btn, 150, 46)
	GUI:setIgnoreContentAdaptWithSize(getReward_btn, false)
	GUI:Button_setTitleText(getReward_btn, [[]])
	GUI:Button_setTitleColor(getReward_btn, "#ffffff")
	GUI:Button_setTitleFontSize(getReward_btn, 16)
	GUI:Button_titleEnableOutline(getReward_btn, "#000000", 1)
	GUI:setAnchorPoint(getReward_btn, 0.00, 0.00)
	GUI:setTouchEnabled(getReward_btn, true)
	GUI:setTag(getReward_btn, 0)

	-- Create get_tag
	local get_tag = GUI:Image_Create(pageNode_3, "get_tag", 649, 419, "res/custom/npc/51zq/yy2.png")
	GUI:setContentSize(get_tag, 128, 38)
	GUI:setIgnoreContentAdaptWithSize(get_tag, false)
	GUI:setAnchorPoint(get_tag, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag, false)
	GUI:setTag(get_tag, 0)
	GUI:setVisible(get_tag, false)

	-- Create pageNode_4
	local pageNode_4 = GUI:Node_Create(FrameLayout, "pageNode_4", 0, 0)
	GUI:setTag(pageNode_4, 0)
	GUI:setVisible(pageNode_4, false)

	-- Create y_zf_item_1
	local y_zf_item_1 = GUI:ItemShow_Create(pageNode_4, "y_zf_item_1", 348, 314, {index = 11100, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(y_zf_item_1, 0.50, 0.50)
	GUI:setTag(y_zf_item_1, 0)

	-- Create y_zf_item_2
	local y_zf_item_2 = GUI:ItemShow_Create(pageNode_4, "y_zf_item_2", 296, 241, {index = 11101, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(y_zf_item_2, 0.50, 0.50)
	GUI:setTag(y_zf_item_2, 0)

	-- Create y_zf_item_3
	local y_zf_item_3 = GUI:ItemShow_Create(pageNode_4, "y_zf_item_3", 402, 241, {index = 11102, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(y_zf_item_3, 0.50, 0.50)
	GUI:setTag(y_zf_item_3, 0)

	-- Create j_zf_item_1
	local j_zf_item_1 = GUI:ItemShow_Create(pageNode_4, "j_zf_item_1", 648, 314, {index = 11100, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(j_zf_item_1, 0.50, 0.50)
	GUI:setTag(j_zf_item_1, 0)

	-- Create j_zf_item_2
	local j_zf_item_2 = GUI:ItemShow_Create(pageNode_4, "j_zf_item_2", 596, 241, {index = 11101, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(j_zf_item_2, 0.50, 0.50)
	GUI:setTag(j_zf_item_2, 0)

	-- Create j_zf_item_3
	local j_zf_item_3 = GUI:ItemShow_Create(pageNode_4, "j_zf_item_3", 702, 241, {index = 11102, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(j_zf_item_3, 0.50, 0.50)
	GUI:setTag(j_zf_item_3, 0)

	-- Create RichText_9
	local RichText_9 = GUI:RichText_Create(pageNode_4, "RichText_9", 259, 178, [[<font color='#ffffff' size='14' >可以使用 </font><font color='#9b00ff' size='14' >挖矿免费金符 </font><font color='#ffffff' size='14' >购买</font>]], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_9, 0.00, 0.00)
	GUI:setTag(RichText_9, 0)

	-- Create RichText_10
	local RichText_10 = GUI:RichText_Create(pageNode_4, "RichText_10", 260, 152, [[<font color='#ffffff' size='14' >购买时</font><font color='#00ff00' size='14' >随机获得以上月饼*1</font>]], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_10, 0.00, 0.00)
	GUI:setTag(RichText_10, 0)

	-- Create RichText_11
	local RichText_11 = GUI:RichText_Create(pageNode_4, "RichText_11", 260, 126, [[<font color='#ffffff' size='14' >更有</font><font color='#00ff00' size='14' >10%几率</font><font color='#ffffff' size='14' >获得</font><font color='#00ff00' size='14' >金牛随喜*1</font>]], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_11, 0.00, 0.00)
	GUI:setTag(RichText_11, 0)

	-- Create RichText_12
	local RichText_12 = GUI:RichText_Create(pageNode_4, "RichText_12", 558, 178, [[<font color='#9b00ff' size='14' >充值金额每满99元 </font><font color='#ffffff' size='14' >可领取1次</font>]], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_12, 0.00, 0.00)
	GUI:setTag(RichText_12, 0)

	-- Create RichText_13
	local RichText_13 = GUI:RichText_Create(pageNode_4, "RichText_13", 558, 152, [[<font color='#ffffff' size='14' >领取时</font><font color='#00ff00' size='14' >随机获得以上月饼*3</font>]], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_13, 0.00, 0.00)
	GUI:setTag(RichText_13, 0)

	-- Create RichText_14
	local RichText_14 = GUI:RichText_Create(pageNode_4, "RichText_14", 558, 126, [[<font color='#ffffff' size='14' >领取时</font><font color='#00ff00' size='14' >必定</font><font color='#ffffff' size='14' >获得</font><font color='#00ff00' size='14' >金牛随喜*1</font>]], 200, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_14, 0.00, 0.00)
	GUI:setTag(RichText_14, 0)

	-- Create buyBtn
	local buyBtn = GUI:Button_Create(pageNode_4, "buyBtn", 295, 70, "res/custom/npc/51zq/by1.png")
	GUI:Button_loadTexturePressed(buyBtn, "res/custom/npc/51zq/by2.png")
	GUI:setContentSize(buyBtn, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(buyBtn, false)
	GUI:Button_setTitleText(buyBtn, [[]])
	GUI:Button_setTitleColor(buyBtn, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn, 16)
	GUI:Button_titleEnableOutline(buyBtn, "#000000", 1)
	GUI:setAnchorPoint(buyBtn, 0.00, 0.00)
	GUI:setTouchEnabled(buyBtn, true)
	GUI:setTag(buyBtn, 0)

	-- Create getBtn
	local getBtn = GUI:Button_Create(pageNode_4, "getBtn", 608, 70, "res/custom/npc/51zq/lq1.png")
	GUI:Button_loadTexturePressed(getBtn, "res/custom/npc/51zq/lq2.png")
	GUI:setContentSize(getBtn, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(getBtn, false)
	GUI:Button_setTitleText(getBtn, [[]])
	GUI:Button_setTitleColor(getBtn, "#ffffff")
	GUI:Button_setTitleFontSize(getBtn, 16)
	GUI:Button_titleEnableOutline(getBtn, "#000000", 1)
	GUI:setAnchorPoint(getBtn, 0.00, 0.00)
	GUI:setTouchEnabled(getBtn, true)
	GUI:setTag(getBtn, 0)

	-- Create Text_11
	local Text_11 = GUI:Text_Create(pageNode_4, "Text_11", 345, 39, 16, "#ffff00", [[20000金符,盟重令半价]])
	GUI:Text_enableOutline(Text_11, "#000000", 1)
	GUI:setAnchorPoint(Text_11, 0.50, 0.00)
	GUI:setTouchEnabled(Text_11, false)
	GUI:setTag(Text_11, 0)

	-- Create getNum_txt
	local getNum_txt = GUI:Text_Create(pageNode_4, "getNum_txt", 657, 41, 16, "#ffff00", [[当前可领: 0次]])
	GUI:Text_enableOutline(getNum_txt, "#000000", 1)
	GUI:setAnchorPoint(getNum_txt, 0.50, 0.00)
	GUI:setTouchEnabled(getNum_txt, false)
	GUI:setTag(getNum_txt, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
