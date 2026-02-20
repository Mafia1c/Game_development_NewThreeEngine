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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 89)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 140, 45, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/19fl/bg15.png")
	GUI:Image_setScale9Slice(bg_Image, 84, 84, 188, 188)
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, true)
	GUI:setMouseEnabled(bg_Image, true)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 784, 493, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/close2.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 73, 440, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[登录奖励]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 73, 396, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[七日奖励]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(FrameLayout, "Button_3", 73, 352, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_3, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_3, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[升级奖励]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(FrameLayout, "Button_4", 73, 308, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_4, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_4, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[首爆奖励]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 18)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(FrameLayout, "Button_5", 73, 264, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_5, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_5, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[累充奖励]])
	GUI:Button_setTitleColor(Button_5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_5, 18)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.00, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create Button_7
	local Button_7 = GUI:Button_Create(FrameLayout, "Button_7", 73, 220, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_7, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_7, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_7, false)
	GUI:Button_setTitleText(Button_7, [[落地成神]])
	GUI:Button_setTitleColor(Button_7, "#ffffff")
	GUI:Button_setTitleFontSize(Button_7, 18)
	GUI:Button_titleEnableOutline(Button_7, "#000000", 1)
	GUI:setAnchorPoint(Button_7, 0.00, 0.00)
	GUI:setTouchEnabled(Button_7, true)
	GUI:setTag(Button_7, 0)

	-- Create node_7_effect
	local node_7_effect = GUI:Effect_Create(FrameLayout, "node_7_effect", 72, 260, 0, 16075, 0, 0, 0, 1)
	GUI:setScale(node_7_effect, 0.60)
	GUI:setTag(node_7_effect, 0)

	-- Create Button_6
	local Button_6 = GUI:Button_Create(FrameLayout, "Button_6", 73, 177, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_6, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_6, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_6, false)
	GUI:Button_setTitleText(Button_6, [[客服礼包]])
	GUI:Button_setTitleColor(Button_6, "#ffffff")
	GUI:Button_setTitleFontSize(Button_6, 18)
	GUI:Button_titleEnableOutline(Button_6, "#000000", 1)
	GUI:setAnchorPoint(Button_6, 0.00, 0.00)
	GUI:setTouchEnabled(Button_6, true)
	GUI:setTag(Button_6, 0)

	-- Create Node_1
	local Node_1 = GUI:Node_Create(FrameLayout, "Node_1", 0, 0)
	GUI:setTag(Node_1, 0)
	GUI:setVisible(Node_1, false)

	-- Create day_item_1
	local day_item_1 = GUI:ItemShow_Create(Node_1, "day_item_1", 242, 110, {index = 4, count = 1, look = true, bgVisible = true, color = 255, noLockTips = true})
	GUI:setAnchorPoint(day_item_1, 0.50, 0.50)
	GUI:setMouseEnabled(day_item_1, true)
	GUI:setTag(day_item_1, 0)

	-- Create day_item_2
	local day_item_2 = GUI:ItemShow_Create(Node_1, "day_item_2", 311, 110, {index = 10008, count = 1, look = true, bgVisible = true, color = 255, noLockTips = true})
	GUI:setAnchorPoint(day_item_2, 0.50, 0.50)
	GUI:setMouseEnabled(day_item_2, true)
	GUI:setTag(day_item_2, 0)

	-- Create day_item_3
	local day_item_3 = GUI:ItemShow_Create(Node_1, "day_item_3", 379, 110, {index = 10088, count = 1, look = true, bgVisible = true, color = 255, noLockTips = true})
	GUI:setAnchorPoint(day_item_3, 0.50, 0.50)
	GUI:setMouseEnabled(day_item_3, true)
	GUI:setTag(day_item_3, 0)

	-- Create day_item_4
	local day_item_4 = GUI:ItemShow_Create(Node_1, "day_item_4", 448, 110, {index = 10054, count = 1, look = true, bgVisible = true, color = 255, noLockTips = true})
	GUI:setAnchorPoint(day_item_4, 0.50, 0.50)
	GUI:setMouseEnabled(day_item_4, true)
	GUI:setTag(day_item_4, 0)

	-- Create loginListView
	local loginListView = GUI:ListView_Create(Node_1, "loginListView", 498, 36, 300, 360, 1)
	GUI:ListView_setBounceEnabled(loginListView, true)
	GUI:ListView_setGravity(loginListView, 2)
	GUI:setAnchorPoint(loginListView, 0.00, 0.00)
	GUI:setTouchEnabled(loginListView, true)
	GUI:setTag(loginListView, 0)

	-- Create DayGiftBtn
	local DayGiftBtn = GUI:Button_Create(Node_1, "DayGiftBtn", 301, 39, "res/custom/npc/19fl/ztn2_1.png")
	GUI:Button_loadTexturePressed(DayGiftBtn, "res/custom/npc/19fl/ztn2_2.png")
	GUI:setContentSize(DayGiftBtn, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(DayGiftBtn, false)
	GUI:Button_setTitleText(DayGiftBtn, [[]])
	GUI:Button_setTitleColor(DayGiftBtn, "#ffffff")
	GUI:Button_setTitleFontSize(DayGiftBtn, 16)
	GUI:Button_titleEnableOutline(DayGiftBtn, "#000000", 1)
	GUI:setAnchorPoint(DayGiftBtn, 0.00, 0.00)
	GUI:setTouchEnabled(DayGiftBtn, true)
	GUI:setTag(DayGiftBtn, 0)

	-- Create getTag
	local getTag = GUI:Image_Create(Node_1, "getTag", 306, 40, "res/custom/tag/ok.png")
	GUI:setContentSize(getTag, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(getTag, false)
	GUI:setAnchorPoint(getTag, 0.00, 0.00)
	GUI:setTouchEnabled(getTag, false)
	GUI:setTag(getTag, 0)

	-- Create Node_2
	local Node_2 = GUI:Node_Create(FrameLayout, "Node_2", 0, 0)
	GUI:setTag(Node_2, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(Node_2, "Text_2", 203, 432, 16, "#00ffe8", [[累计充值:  3天]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(Node_2, "Text_3", 257, 404, 18, "#ffff00", [[累计7天领取后重置累计充值天数归0, 当日可再次充值从1开始]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create DayRewardLayout
	local DayRewardLayout = GUI:ListView_Create(Node_2, "DayRewardLayout", 197, 35, 604, 330, 1)
	GUI:ListView_setGravity(DayRewardLayout, 2)
	GUI:ListView_setItemsMargin(DayRewardLayout, 5)
	GUI:setAnchorPoint(DayRewardLayout, 0.00, 0.00)
	GUI:setTouchEnabled(DayRewardLayout, true)
	GUI:setTag(DayRewardLayout, 0)

	-- Create dayReward_cell_8
	local dayReward_cell_8 = GUI:Image_Create(DayRewardLayout, "dayReward_cell_8", 3, 266, "res/custom/npc/19fl/k1.png")
	GUI:Image_setScale9Slice(dayReward_cell_8, 29, 29, 33, 33)
	GUI:setContentSize(dayReward_cell_8, 598, 64)
	GUI:setIgnoreContentAdaptWithSize(dayReward_cell_8, false)
	GUI:setAnchorPoint(dayReward_cell_8, 0.00, 0.00)
	GUI:setTouchEnabled(dayReward_cell_8, false)
	GUI:setTag(dayReward_cell_8, 0)

	-- Create title_txt
	local title_txt = GUI:RichText_Create(dayReward_cell_8, "title_txt", 17, 32, [[<font color='#00ffe8' size='18' >每日免费奖励</font>]], 120, 16, "#ffffff", 4)
	GUI:setAnchorPoint(title_txt, 0.00, 0.50)
	GUI:setTag(title_txt, 0)

	-- Create item_1
	local item_1 = GUI:ItemShow_Create(dayReward_cell_8, "item_1", 200, 32, {index = 4, count = 100000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_1, 0.50, 0.50)
	GUI:setTag(item_1, 0)

	-- Create item_2
	local item_2 = GUI:ItemShow_Create(dayReward_cell_8, "item_2", 269, 32, {index = 21, count = 1000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_2, 0.50, 0.50)
	GUI:setTag(item_2, 0)

	-- Create getRechareBtn_8
	local getRechareBtn_8 = GUI:Button_Create(dayReward_cell_8, "getRechareBtn_8", 481, 32, "res/custom/npc/19fl/ztn2_1.png")
	GUI:Button_loadTexturePressed(getRechareBtn_8, "res/custom/npc/19fl/ztn2_2.png")
	GUI:setContentSize(getRechareBtn_8, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(getRechareBtn_8, false)
	GUI:Button_setTitleText(getRechareBtn_8, [[]])
	GUI:Button_setTitleColor(getRechareBtn_8, "#ffffff")
	GUI:Button_setTitleFontSize(getRechareBtn_8, 16)
	GUI:Button_titleEnableOutline(getRechareBtn_8, "#000000", 1)
	GUI:setAnchorPoint(getRechareBtn_8, 0.00, 0.50)
	GUI:setTouchEnabled(getRechareBtn_8, true)
	GUI:setTag(getRechareBtn_8, 0)

	-- Create icon_tag
	local icon_tag = GUI:Image_Create(dayReward_cell_8, "icon_tag", 479, 32, "res/custom/tag/hdyl_009.png")
	GUI:setContentSize(icon_tag, 90, 51)
	GUI:setIgnoreContentAdaptWithSize(icon_tag, false)
	GUI:setAnchorPoint(icon_tag, 0.00, 0.50)
	GUI:setTouchEnabled(icon_tag, false)
	GUI:setTag(icon_tag, 0)
	GUI:setVisible(icon_tag, false)

	-- Create dayReward_cell_1
	local dayReward_cell_1 = GUI:Image_Create(DayRewardLayout, "dayReward_cell_1", 3, 197, "res/custom/npc/19fl/k1.png")
	GUI:Image_setScale9Slice(dayReward_cell_1, 29, 29, 33, 33)
	GUI:setContentSize(dayReward_cell_1, 598, 64)
	GUI:setIgnoreContentAdaptWithSize(dayReward_cell_1, false)
	GUI:setAnchorPoint(dayReward_cell_1, 0.00, 0.00)
	GUI:setTouchEnabled(dayReward_cell_1, false)
	GUI:setTag(dayReward_cell_1, 0)

	-- Create title_txt
	title_txt = GUI:RichText_Create(dayReward_cell_1, "title_txt", 17, 32, [[<font color='#ffffff' size='18' >累计充值 </font><font color='#00ff00' size='18' >1天</font>]], 120, 16, "#ffffff", 4)
	GUI:setAnchorPoint(title_txt, 0.00, 0.50)
	GUI:setTag(title_txt, 0)

	-- Create item_1
	item_1 = GUI:ItemShow_Create(dayReward_cell_1, "item_1", 200, 32, {index = 4, count = 100000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_1, 0.50, 0.50)
	GUI:setTag(item_1, 0)

	-- Create item_2
	item_2 = GUI:ItemShow_Create(dayReward_cell_1, "item_2", 269, 32, {index = 21, count = 1000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_2, 0.50, 0.50)
	GUI:setTag(item_2, 0)

	-- Create item_3
	local item_3 = GUI:ItemShow_Create(dayReward_cell_1, "item_3", 339, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_3, 0.50, 0.50)
	GUI:setTag(item_3, 0)

	-- Create item_4
	local item_4 = GUI:ItemShow_Create(dayReward_cell_1, "item_4", 406, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_4, 0.50, 0.50)
	GUI:setTag(item_4, 0)

	-- Create getRechareBtn_1
	local getRechareBtn_1 = GUI:Button_Create(dayReward_cell_1, "getRechareBtn_1", 481, 32, "res/custom/npc/19fl/ztn2_1.png")
	GUI:Button_loadTexturePressed(getRechareBtn_1, "res/custom/npc/19fl/ztn2_2.png")
	GUI:setContentSize(getRechareBtn_1, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(getRechareBtn_1, false)
	GUI:Button_setTitleText(getRechareBtn_1, [[]])
	GUI:Button_setTitleColor(getRechareBtn_1, "#ffffff")
	GUI:Button_setTitleFontSize(getRechareBtn_1, 16)
	GUI:Button_titleEnableOutline(getRechareBtn_1, "#000000", 1)
	GUI:setAnchorPoint(getRechareBtn_1, 0.00, 0.50)
	GUI:setTouchEnabled(getRechareBtn_1, true)
	GUI:setTag(getRechareBtn_1, 0)

	-- Create icon_tag
	icon_tag = GUI:Image_Create(dayReward_cell_1, "icon_tag", 479, 32, "res/custom/tag/hdyl_009.png")
	GUI:setContentSize(icon_tag, 90, 51)
	GUI:setIgnoreContentAdaptWithSize(icon_tag, false)
	GUI:setAnchorPoint(icon_tag, 0.00, 0.50)
	GUI:setTouchEnabled(icon_tag, false)
	GUI:setTag(icon_tag, 0)
	GUI:setVisible(icon_tag, false)

	-- Create dayReward_cell_2
	local dayReward_cell_2 = GUI:Image_Create(DayRewardLayout, "dayReward_cell_2", 3, 128, "res/custom/npc/19fl/k1.png")
	GUI:Image_setScale9Slice(dayReward_cell_2, 29, 29, 33, 33)
	GUI:setContentSize(dayReward_cell_2, 598, 64)
	GUI:setIgnoreContentAdaptWithSize(dayReward_cell_2, false)
	GUI:setAnchorPoint(dayReward_cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(dayReward_cell_2, false)
	GUI:setTag(dayReward_cell_2, 0)

	-- Create title_txt
	title_txt = GUI:RichText_Create(dayReward_cell_2, "title_txt", 17, 32, [[<font color='#ffffff' size='18' >累计充值 </font><font color='#00ff00' size='18' >2天</font>]], 120, 16, "#ffffff", 4)
	GUI:setAnchorPoint(title_txt, 0.00, 0.50)
	GUI:setTag(title_txt, 0)

	-- Create item_1
	item_1 = GUI:ItemShow_Create(dayReward_cell_2, "item_1", 200, 32, {index = 4, count = 100000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_1, 0.50, 0.50)
	GUI:setTag(item_1, 0)

	-- Create item_2
	item_2 = GUI:ItemShow_Create(dayReward_cell_2, "item_2", 269, 32, {index = 21, count = 1000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_2, 0.50, 0.50)
	GUI:setTag(item_2, 0)

	-- Create item_3
	item_3 = GUI:ItemShow_Create(dayReward_cell_2, "item_3", 339, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_3, 0.50, 0.50)
	GUI:setTag(item_3, 0)

	-- Create item_4
	item_4 = GUI:ItemShow_Create(dayReward_cell_2, "item_4", 406, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_4, 0.50, 0.50)
	GUI:setTag(item_4, 0)

	-- Create getRechareBtn_2
	local getRechareBtn_2 = GUI:Button_Create(dayReward_cell_2, "getRechareBtn_2", 481, 32, "res/custom/npc/19fl/ztn2_1.png")
	GUI:Button_loadTexturePressed(getRechareBtn_2, "res/custom/npc/19fl/ztn2_2.png")
	GUI:setContentSize(getRechareBtn_2, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(getRechareBtn_2, false)
	GUI:Button_setTitleText(getRechareBtn_2, [[]])
	GUI:Button_setTitleColor(getRechareBtn_2, "#ffffff")
	GUI:Button_setTitleFontSize(getRechareBtn_2, 16)
	GUI:Button_titleEnableOutline(getRechareBtn_2, "#000000", 1)
	GUI:setAnchorPoint(getRechareBtn_2, 0.00, 0.50)
	GUI:setTouchEnabled(getRechareBtn_2, true)
	GUI:setTag(getRechareBtn_2, 0)

	-- Create icon_tag
	icon_tag = GUI:Image_Create(dayReward_cell_2, "icon_tag", 479, 32, "res/custom/tag/hdyl_009.png")
	GUI:setContentSize(icon_tag, 90, 51)
	GUI:setIgnoreContentAdaptWithSize(icon_tag, false)
	GUI:setAnchorPoint(icon_tag, 0.00, 0.50)
	GUI:setTouchEnabled(icon_tag, false)
	GUI:setTag(icon_tag, 0)
	GUI:setVisible(icon_tag, false)

	-- Create dayReward_cell_3
	local dayReward_cell_3 = GUI:Image_Create(DayRewardLayout, "dayReward_cell_3", 3, 59, "res/custom/npc/19fl/k1.png")
	GUI:Image_setScale9Slice(dayReward_cell_3, 29, 29, 33, 33)
	GUI:setContentSize(dayReward_cell_3, 598, 64)
	GUI:setIgnoreContentAdaptWithSize(dayReward_cell_3, false)
	GUI:setAnchorPoint(dayReward_cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(dayReward_cell_3, false)
	GUI:setTag(dayReward_cell_3, 0)

	-- Create title_txt
	title_txt = GUI:RichText_Create(dayReward_cell_3, "title_txt", 17, 32, [[<font color='#ffffff' size='18' >累计充值 </font><font color='#00ff00' size='18' >3天</font>]], 120, 16, "#ffffff", 4)
	GUI:setAnchorPoint(title_txt, 0.00, 0.50)
	GUI:setTag(title_txt, 0)

	-- Create item_1
	item_1 = GUI:ItemShow_Create(dayReward_cell_3, "item_1", 200, 32, {index = 4, count = 100000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_1, 0.50, 0.50)
	GUI:setTag(item_1, 0)

	-- Create item_2
	item_2 = GUI:ItemShow_Create(dayReward_cell_3, "item_2", 269, 32, {index = 21, count = 1000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_2, 0.50, 0.50)
	GUI:setTag(item_2, 0)

	-- Create item_3
	item_3 = GUI:ItemShow_Create(dayReward_cell_3, "item_3", 339, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_3, 0.50, 0.50)
	GUI:setTag(item_3, 0)

	-- Create item_4
	item_4 = GUI:ItemShow_Create(dayReward_cell_3, "item_4", 406, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_4, 0.50, 0.50)
	GUI:setTag(item_4, 0)

	-- Create getRechareBtn_3
	local getRechareBtn_3 = GUI:Button_Create(dayReward_cell_3, "getRechareBtn_3", 481, 32, "res/custom/npc/19fl/ztn2_1.png")
	GUI:Button_loadTexturePressed(getRechareBtn_3, "res/custom/npc/19fl/ztn2_2.png")
	GUI:setContentSize(getRechareBtn_3, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(getRechareBtn_3, false)
	GUI:Button_setTitleText(getRechareBtn_3, [[]])
	GUI:Button_setTitleColor(getRechareBtn_3, "#ffffff")
	GUI:Button_setTitleFontSize(getRechareBtn_3, 16)
	GUI:Button_titleEnableOutline(getRechareBtn_3, "#000000", 1)
	GUI:setAnchorPoint(getRechareBtn_3, 0.00, 0.50)
	GUI:setTouchEnabled(getRechareBtn_3, true)
	GUI:setTag(getRechareBtn_3, 0)

	-- Create icon_tag
	icon_tag = GUI:Image_Create(dayReward_cell_3, "icon_tag", 479, 32, "res/custom/tag/hdyl_009.png")
	GUI:setContentSize(icon_tag, 90, 51)
	GUI:setIgnoreContentAdaptWithSize(icon_tag, false)
	GUI:setAnchorPoint(icon_tag, 0.00, 0.50)
	GUI:setTouchEnabled(icon_tag, false)
	GUI:setTag(icon_tag, 0)
	GUI:setVisible(icon_tag, false)

	-- Create dayReward_cell_4
	local dayReward_cell_4 = GUI:Image_Create(DayRewardLayout, "dayReward_cell_4", 3, -10, "res/custom/npc/19fl/k1.png")
	GUI:Image_setScale9Slice(dayReward_cell_4, 29, 29, 33, 33)
	GUI:setContentSize(dayReward_cell_4, 598, 64)
	GUI:setIgnoreContentAdaptWithSize(dayReward_cell_4, false)
	GUI:setAnchorPoint(dayReward_cell_4, 0.00, 0.00)
	GUI:setTouchEnabled(dayReward_cell_4, false)
	GUI:setTag(dayReward_cell_4, 0)

	-- Create title_txt
	title_txt = GUI:RichText_Create(dayReward_cell_4, "title_txt", 17, 32, [[<font color='#ffffff' size='18' >累计充值 </font><font color='#00ff00' size='18' >4天</font>]], 120, 16, "#ffffff", 4)
	GUI:setAnchorPoint(title_txt, 0.00, 0.50)
	GUI:setTag(title_txt, 0)

	-- Create item_1
	item_1 = GUI:ItemShow_Create(dayReward_cell_4, "item_1", 200, 32, {index = 4, count = 100000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_1, 0.50, 0.50)
	GUI:setTag(item_1, 0)

	-- Create item_2
	item_2 = GUI:ItemShow_Create(dayReward_cell_4, "item_2", 269, 32, {index = 21, count = 1000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_2, 0.50, 0.50)
	GUI:setTag(item_2, 0)

	-- Create item_3
	item_3 = GUI:ItemShow_Create(dayReward_cell_4, "item_3", 339, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_3, 0.50, 0.50)
	GUI:setTag(item_3, 0)

	-- Create item_4
	item_4 = GUI:ItemShow_Create(dayReward_cell_4, "item_4", 406, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_4, 0.50, 0.50)
	GUI:setTag(item_4, 0)

	-- Create getRechareBtn_4
	local getRechareBtn_4 = GUI:Button_Create(dayReward_cell_4, "getRechareBtn_4", 481, 32, "res/custom/npc/19fl/ztn2_1.png")
	GUI:Button_loadTexturePressed(getRechareBtn_4, "res/custom/npc/19fl/ztn2_2.png")
	GUI:setContentSize(getRechareBtn_4, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(getRechareBtn_4, false)
	GUI:Button_setTitleText(getRechareBtn_4, [[]])
	GUI:Button_setTitleColor(getRechareBtn_4, "#ffffff")
	GUI:Button_setTitleFontSize(getRechareBtn_4, 16)
	GUI:Button_titleEnableOutline(getRechareBtn_4, "#000000", 1)
	GUI:setAnchorPoint(getRechareBtn_4, 0.00, 0.50)
	GUI:setTouchEnabled(getRechareBtn_4, true)
	GUI:setTag(getRechareBtn_4, 0)

	-- Create icon_tag
	icon_tag = GUI:Image_Create(dayReward_cell_4, "icon_tag", 479, 32, "res/custom/tag/hdyl_009.png")
	GUI:setContentSize(icon_tag, 90, 51)
	GUI:setIgnoreContentAdaptWithSize(icon_tag, false)
	GUI:setAnchorPoint(icon_tag, 0.00, 0.50)
	GUI:setTouchEnabled(icon_tag, false)
	GUI:setTag(icon_tag, 0)
	GUI:setVisible(icon_tag, false)

	-- Create dayReward_cell_5
	local dayReward_cell_5 = GUI:Image_Create(DayRewardLayout, "dayReward_cell_5", 3, -79, "res/custom/npc/19fl/k1.png")
	GUI:Image_setScale9Slice(dayReward_cell_5, 29, 29, 33, 33)
	GUI:setContentSize(dayReward_cell_5, 598, 64)
	GUI:setIgnoreContentAdaptWithSize(dayReward_cell_5, false)
	GUI:setAnchorPoint(dayReward_cell_5, 0.00, 0.00)
	GUI:setTouchEnabled(dayReward_cell_5, false)
	GUI:setTag(dayReward_cell_5, 0)

	-- Create title_txt
	title_txt = GUI:RichText_Create(dayReward_cell_5, "title_txt", 17, 32, [[<font color='#ffffff' size='18' >累计充值 </font><font color='#00ff00' size='18' >5天</font>]], 120, 16, "#ffffff", 4)
	GUI:setAnchorPoint(title_txt, 0.00, 0.50)
	GUI:setTag(title_txt, 0)

	-- Create item_1
	item_1 = GUI:ItemShow_Create(dayReward_cell_5, "item_1", 200, 32, {index = 4, count = 100000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_1, 0.50, 0.50)
	GUI:setTag(item_1, 0)

	-- Create item_2
	item_2 = GUI:ItemShow_Create(dayReward_cell_5, "item_2", 269, 32, {index = 21, count = 1000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_2, 0.50, 0.50)
	GUI:setTag(item_2, 0)

	-- Create item_3
	item_3 = GUI:ItemShow_Create(dayReward_cell_5, "item_3", 339, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_3, 0.50, 0.50)
	GUI:setTag(item_3, 0)

	-- Create item_4
	item_4 = GUI:ItemShow_Create(dayReward_cell_5, "item_4", 406, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_4, 0.50, 0.50)
	GUI:setTag(item_4, 0)

	-- Create getRechareBtn_5
	local getRechareBtn_5 = GUI:Button_Create(dayReward_cell_5, "getRechareBtn_5", 481, 32, "res/custom/npc/19fl/ztn2_1.png")
	GUI:Button_loadTexturePressed(getRechareBtn_5, "res/custom/npc/19fl/ztn2_2.png")
	GUI:setContentSize(getRechareBtn_5, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(getRechareBtn_5, false)
	GUI:Button_setTitleText(getRechareBtn_5, [[]])
	GUI:Button_setTitleColor(getRechareBtn_5, "#ffffff")
	GUI:Button_setTitleFontSize(getRechareBtn_5, 16)
	GUI:Button_titleEnableOutline(getRechareBtn_5, "#000000", 1)
	GUI:setAnchorPoint(getRechareBtn_5, 0.00, 0.50)
	GUI:setTouchEnabled(getRechareBtn_5, true)
	GUI:setTag(getRechareBtn_5, 0)

	-- Create icon_tag
	icon_tag = GUI:Image_Create(dayReward_cell_5, "icon_tag", 479, 32, "res/custom/tag/hdyl_009.png")
	GUI:setContentSize(icon_tag, 90, 51)
	GUI:setIgnoreContentAdaptWithSize(icon_tag, false)
	GUI:setAnchorPoint(icon_tag, 0.00, 0.50)
	GUI:setTouchEnabled(icon_tag, false)
	GUI:setTag(icon_tag, 0)
	GUI:setVisible(icon_tag, false)

	-- Create dayReward_cell_6
	local dayReward_cell_6 = GUI:Image_Create(DayRewardLayout, "dayReward_cell_6", 3, -148, "res/custom/npc/19fl/k1.png")
	GUI:Image_setScale9Slice(dayReward_cell_6, 29, 29, 33, 33)
	GUI:setContentSize(dayReward_cell_6, 598, 64)
	GUI:setIgnoreContentAdaptWithSize(dayReward_cell_6, false)
	GUI:setAnchorPoint(dayReward_cell_6, 0.00, 0.00)
	GUI:setTouchEnabled(dayReward_cell_6, false)
	GUI:setTag(dayReward_cell_6, 0)

	-- Create title_txt
	title_txt = GUI:RichText_Create(dayReward_cell_6, "title_txt", 17, 32, [[<font color='#ffffff' size='18' >累计充值 </font><font color='#00ff00' size='18' >6天</font>]], 120, 16, "#ffffff", 4)
	GUI:setAnchorPoint(title_txt, 0.00, 0.50)
	GUI:setTag(title_txt, 0)

	-- Create item_1
	item_1 = GUI:ItemShow_Create(dayReward_cell_6, "item_1", 200, 32, {index = 4, count = 100000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_1, 0.50, 0.50)
	GUI:setTag(item_1, 0)

	-- Create item_2
	item_2 = GUI:ItemShow_Create(dayReward_cell_6, "item_2", 269, 32, {index = 21, count = 1000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_2, 0.50, 0.50)
	GUI:setTag(item_2, 0)

	-- Create item_3
	item_3 = GUI:ItemShow_Create(dayReward_cell_6, "item_3", 339, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_3, 0.50, 0.50)
	GUI:setTag(item_3, 0)

	-- Create item_4
	item_4 = GUI:ItemShow_Create(dayReward_cell_6, "item_4", 406, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_4, 0.50, 0.50)
	GUI:setTag(item_4, 0)

	-- Create getRechareBtn_6
	local getRechareBtn_6 = GUI:Button_Create(dayReward_cell_6, "getRechareBtn_6", 481, 32, "res/custom/npc/19fl/ztn2_1.png")
	GUI:Button_loadTexturePressed(getRechareBtn_6, "res/custom/npc/19fl/ztn2_2.png")
	GUI:setContentSize(getRechareBtn_6, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(getRechareBtn_6, false)
	GUI:Button_setTitleText(getRechareBtn_6, [[]])
	GUI:Button_setTitleColor(getRechareBtn_6, "#ffffff")
	GUI:Button_setTitleFontSize(getRechareBtn_6, 16)
	GUI:Button_titleEnableOutline(getRechareBtn_6, "#000000", 1)
	GUI:setAnchorPoint(getRechareBtn_6, 0.00, 0.50)
	GUI:setTouchEnabled(getRechareBtn_6, true)
	GUI:setTag(getRechareBtn_6, 0)

	-- Create icon_tag
	icon_tag = GUI:Image_Create(dayReward_cell_6, "icon_tag", 479, 32, "res/custom/tag/hdyl_009.png")
	GUI:setContentSize(icon_tag, 90, 51)
	GUI:setIgnoreContentAdaptWithSize(icon_tag, false)
	GUI:setAnchorPoint(icon_tag, 0.00, 0.50)
	GUI:setTouchEnabled(icon_tag, false)
	GUI:setTag(icon_tag, 0)
	GUI:setVisible(icon_tag, false)

	-- Create dayReward_cell_7
	local dayReward_cell_7 = GUI:Image_Create(DayRewardLayout, "dayReward_cell_7", 3, -217, "res/custom/npc/19fl/k1.png")
	GUI:Image_setScale9Slice(dayReward_cell_7, 29, 29, 33, 33)
	GUI:setContentSize(dayReward_cell_7, 598, 64)
	GUI:setIgnoreContentAdaptWithSize(dayReward_cell_7, false)
	GUI:setAnchorPoint(dayReward_cell_7, 0.00, 0.00)
	GUI:setTouchEnabled(dayReward_cell_7, false)
	GUI:setTag(dayReward_cell_7, 0)

	-- Create title_txt
	title_txt = GUI:RichText_Create(dayReward_cell_7, "title_txt", 17, 32, [[<font color='#ffffff' size='18' >累计充值 </font><font color='#00ff00' size='18' >7天</font>]], 120, 16, "#ffffff", 4)
	GUI:setAnchorPoint(title_txt, 0.00, 0.50)
	GUI:setTag(title_txt, 0)

	-- Create item_1
	item_1 = GUI:ItemShow_Create(dayReward_cell_7, "item_1", 200, 32, {index = 4, count = 100000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_1, 0.50, 0.50)
	GUI:setTag(item_1, 0)

	-- Create item_2
	item_2 = GUI:ItemShow_Create(dayReward_cell_7, "item_2", 269, 32, {index = 21, count = 1000, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_2, 0.50, 0.50)
	GUI:setTag(item_2, 0)

	-- Create item_3
	item_3 = GUI:ItemShow_Create(dayReward_cell_7, "item_3", 339, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_3, 0.50, 0.50)
	GUI:setTag(item_3, 0)

	-- Create item_4
	item_4 = GUI:ItemShow_Create(dayReward_cell_7, "item_4", 406, 32, {index = 10054, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_4, 0.50, 0.50)
	GUI:setTag(item_4, 0)

	-- Create getRechareBtn_7
	local getRechareBtn_7 = GUI:Button_Create(dayReward_cell_7, "getRechareBtn_7", 481, 32, "res/custom/npc/19fl/ztn2_1.png")
	GUI:Button_loadTexturePressed(getRechareBtn_7, "res/custom/npc/19fl/ztn2_2.png")
	GUI:setContentSize(getRechareBtn_7, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(getRechareBtn_7, false)
	GUI:Button_setTitleText(getRechareBtn_7, [[]])
	GUI:Button_setTitleColor(getRechareBtn_7, "#ffffff")
	GUI:Button_setTitleFontSize(getRechareBtn_7, 16)
	GUI:Button_titleEnableOutline(getRechareBtn_7, "#000000", 1)
	GUI:setAnchorPoint(getRechareBtn_7, 0.00, 0.50)
	GUI:setTouchEnabled(getRechareBtn_7, true)
	GUI:setTag(getRechareBtn_7, 0)

	-- Create icon_tag
	icon_tag = GUI:Image_Create(dayReward_cell_7, "icon_tag", 479, 32, "res/custom/tag/hdyl_009.png")
	GUI:setContentSize(icon_tag, 90, 51)
	GUI:setIgnoreContentAdaptWithSize(icon_tag, false)
	GUI:setAnchorPoint(icon_tag, 0.00, 0.50)
	GUI:setTouchEnabled(icon_tag, false)
	GUI:setTag(icon_tag, 0)
	GUI:setVisible(icon_tag, false)

	-- Create Node_3
	local Node_3 = GUI:Node_Create(FrameLayout, "Node_3", 0, 0)
	GUI:setTag(Node_3, 0)
	GUI:setVisible(Node_3, false)

	-- Create levelListView
	local levelListView = GUI:ListView_Create(Node_3, "levelListView", 196, 35, 606, 330, 1)
	GUI:ListView_setGravity(levelListView, 2)
	GUI:ListView_setItemsMargin(levelListView, 5)
	GUI:setAnchorPoint(levelListView, 0.00, 0.00)
	GUI:setTouchEnabled(levelListView, true)
	GUI:setTag(levelListView, 0)

	-- Create Node_4
	local Node_4 = GUI:Node_Create(FrameLayout, "Node_4", 0, 0)
	GUI:setTag(Node_4, 0)
	GUI:setVisible(Node_4, false)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Node_4, "Text_1", 272, 408, 16, "#00ff00", [[全服首曝打到即可获得奖励,每次合区重置刷新首爆(可再次进行全服首爆)。]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create title_img
	local title_img = GUI:Image_Create(Node_4, "title_img", 196, 364, "res/custom/npc/24sbss/1.png")
	GUI:setContentSize(title_img, 605, 36)
	GUI:setIgnoreContentAdaptWithSize(title_img, false)
	GUI:setAnchorPoint(title_img, 0.00, 0.00)
	GUI:setTouchEnabled(title_img, false)
	GUI:setTag(title_img, 0)

	-- Create firstDropList
	local firstDropList = GUI:ListView_Create(Node_4, "firstDropList", 199, 84, 600, 280, 1)
	GUI:ListView_setItemsMargin(firstDropList, 1)
	GUI:setAnchorPoint(firstDropList, 0.00, 0.00)
	GUI:setTouchEnabled(firstDropList, true)
	GUI:setTag(firstDropList, 0)

	-- Create L_btn
	local L_btn = GUI:Button_Create(Node_4, "L_btn", 407, 42, "res/custom/npc/24sbss/a1.png")
	GUI:Button_loadTexturePressed(L_btn, "res/custom/npc/24sbss/a1.png")
	GUI:setContentSize(L_btn, 40, 31)
	GUI:setIgnoreContentAdaptWithSize(L_btn, false)
	GUI:Button_setTitleText(L_btn, [[]])
	GUI:Button_setTitleColor(L_btn, "#ffffff")
	GUI:Button_setTitleFontSize(L_btn, 16)
	GUI:Button_titleEnableOutline(L_btn, "#000000", 1)
	GUI:setAnchorPoint(L_btn, 0.00, 0.00)
	GUI:setTouchEnabled(L_btn, true)
	GUI:setTag(L_btn, 0)

	-- Create pageBgImg
	local pageBgImg = GUI:Image_Create(Node_4, "pageBgImg", 451, 40, "res/custom/npc/24sbss/ye.png")
	GUI:setContentSize(pageBgImg, 106, 34)
	GUI:setIgnoreContentAdaptWithSize(pageBgImg, false)
	GUI:setAnchorPoint(pageBgImg, 0.00, 0.00)
	GUI:setTouchEnabled(pageBgImg, false)
	GUI:setTag(pageBgImg, 0)

	-- Create page_txt
	local page_txt = GUI:Text_Create(pageBgImg, "page_txt", 53, 5, 16, "#ff0000", [[1 / 10]])
	GUI:Text_enableOutline(page_txt, "#000000", 1)
	GUI:setAnchorPoint(page_txt, 0.50, 0.00)
	GUI:setTouchEnabled(page_txt, false)
	GUI:setTag(page_txt, 0)

	-- Create R_btn
	local R_btn = GUI:Button_Create(Node_4, "R_btn", 562, 42, "res/custom/npc/24sbss/b1.png")
	GUI:Button_loadTexturePressed(R_btn, "res/custom/npc/24sbss/b2.png")
	GUI:setContentSize(R_btn, 40, 31)
	GUI:setIgnoreContentAdaptWithSize(R_btn, false)
	GUI:Button_setTitleText(R_btn, [[]])
	GUI:Button_setTitleColor(R_btn, "#ffffff")
	GUI:Button_setTitleFontSize(R_btn, 16)
	GUI:Button_titleEnableOutline(R_btn, "#000000", 1)
	GUI:setAnchorPoint(R_btn, 0.00, 0.00)
	GUI:setTouchEnabled(R_btn, true)
	GUI:setTag(R_btn, 0)

	-- Create Node_5
	local Node_5 = GUI:Node_Create(FrameLayout, "Node_5", 0, 0)
	GUI:setTag(Node_5, 0)
	GUI:setVisible(Node_5, false)

	-- Create recharge
	local recharge = GUI:Text_Create(Node_5, "recharge", 244, 410, 18, "#00ffe8", [[文本]])
	GUI:Text_enableOutline(recharge, "#000000", 1)
	GUI:setAnchorPoint(recharge, 0.00, 0.00)
	GUI:setTouchEnabled(recharge, false)
	GUI:setTag(recharge, 0)

	-- Create rechargeListView
	local rechargeListView = GUI:ListView_Create(Node_5, "rechargeListView", 196, 35, 606, 330, 1)
	GUI:ListView_setGravity(rechargeListView, 2)
	GUI:ListView_setItemsMargin(rechargeListView, 5)
	GUI:setAnchorPoint(rechargeListView, 0.00, 0.00)
	GUI:setTouchEnabled(rechargeListView, true)
	GUI:setTag(rechargeListView, 0)

	-- Create allBuyBtn
	local allBuyBtn = GUI:Button_Create(Node_5, "allBuyBtn", 660, 405, "res/custom/npc/19fl/db_1.png")
	GUI:Button_loadTexturePressed(allBuyBtn, "res/custom/npc/19fl/db_2.png")
	GUI:setContentSize(allBuyBtn, 126, 38)
	GUI:setIgnoreContentAdaptWithSize(allBuyBtn, false)
	GUI:Button_setTitleText(allBuyBtn, [[]])
	GUI:Button_setTitleColor(allBuyBtn, "#ffffff")
	GUI:Button_setTitleFontSize(allBuyBtn, 16)
	GUI:Button_titleEnableOutline(allBuyBtn, "#000000", 1)
	GUI:setAnchorPoint(allBuyBtn, 0.00, 0.00)
	GUI:setTouchEnabled(allBuyBtn, true)
	GUI:setTag(allBuyBtn, 0)

	-- Create Node_6
	local Node_6 = GUI:Node_Create(FrameLayout, "Node_6", 0, 0)
	GUI:setTag(Node_6, 0)
	GUI:setVisible(Node_6, false)

	-- Create serviceLayout
	local serviceLayout = GUI:Layout_Create(Node_6, "serviceLayout", 539, 217, 248, 150, false)
	GUI:setAnchorPoint(serviceLayout, 0.00, 0.00)
	GUI:setTouchEnabled(serviceLayout, false)
	GUI:setTag(serviceLayout, 0)

	-- Create service_item_1
	local service_item_1 = GUI:ItemShow_Create(serviceLayout, "service_item_1", 47, 114, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(service_item_1, 0.50, 0.50)
	GUI:setTag(service_item_1, 0)

	-- Create service_item_2
	local service_item_2 = GUI:ItemShow_Create(serviceLayout, "service_item_2", 122, 114, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(service_item_2, 0.50, 0.50)
	GUI:setTag(service_item_2, 0)

	-- Create service_item_3
	local service_item_3 = GUI:ItemShow_Create(serviceLayout, "service_item_3", 201, 114, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(service_item_3, 0.50, 0.50)
	GUI:setTag(service_item_3, 0)

	-- Create service_item_4
	local service_item_4 = GUI:ItemShow_Create(serviceLayout, "service_item_4", 47, 36, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(service_item_4, 0.50, 0.50)
	GUI:setTag(service_item_4, 0)

	-- Create service_item_5
	local service_item_5 = GUI:ItemShow_Create(serviceLayout, "service_item_5", 122, 36, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(service_item_5, 0.50, 0.50)
	GUI:setTag(service_item_5, 0)

	-- Create service_item_6
	local service_item_6 = GUI:ItemShow_Create(serviceLayout, "service_item_6", 201, 36, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(service_item_6, 0.50, 0.50)
	GUI:setTag(service_item_6, 0)

	-- Create exchange_btn
	local exchange_btn = GUI:Button_Create(Node_6, "exchange_btn", 620, 185, "res/custom/npc/19fl/an1.png")
	GUI:setContentSize(exchange_btn, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(exchange_btn, false)
	GUI:Button_setTitleText(exchange_btn, [[]])
	GUI:Button_setTitleColor(exchange_btn, "#ffffff")
	GUI:Button_setTitleFontSize(exchange_btn, 16)
	GUI:Button_titleEnableOutline(exchange_btn, "#000000", 1)
	GUI:setAnchorPoint(exchange_btn, 0.00, 0.00)
	GUI:setTouchEnabled(exchange_btn, true)
	GUI:setTag(exchange_btn, 0)

	-- Create exchange_tag
	local exchange_tag = GUI:Image_Create(Node_6, "exchange_tag", 616, 186, "res/custom/tag/ylq_101.png")
	GUI:setContentSize(exchange_tag, 88, 30)
	GUI:setIgnoreContentAdaptWithSize(exchange_tag, false)
	GUI:setAnchorPoint(exchange_tag, 0.00, 0.00)
	GUI:setTouchEnabled(exchange_tag, false)
	GUI:setTag(exchange_tag, 0)

	-- Create TextInput_1
	local TextInput_1 = GUI:TextInput_Create(Node_6, "TextInput_1", 572, 91, 202, 28, 18)
	GUI:TextInput_setString(TextInput_1, "")
	GUI:TextInput_setPlaceHolder(TextInput_1, "点击输入SDK兑换码")
	GUI:TextInput_setFontColor(TextInput_1, "#ffffff")
	GUI:TextInput_setPlaceholderFontColor(TextInput_1, "#a6a6a6")
	GUI:setAnchorPoint(TextInput_1, 0.00, 0.00)
	GUI:setTouchEnabled(TextInput_1, true)
	GUI:setTag(TextInput_1, 0)

	-- Create exchange_btn_1
	local exchange_btn_1 = GUI:Button_Create(Node_6, "exchange_btn_1", 620, 47, "res/custom/npc/19fl/an1.png")
	GUI:setContentSize(exchange_btn_1, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(exchange_btn_1, false)
	GUI:Button_setTitleText(exchange_btn_1, [[]])
	GUI:Button_setTitleColor(exchange_btn_1, "#ffffff")
	GUI:Button_setTitleFontSize(exchange_btn_1, 16)
	GUI:Button_titleEnableOutline(exchange_btn_1, "#000000", 1)
	GUI:setAnchorPoint(exchange_btn_1, 0.00, 0.00)
	GUI:setTouchEnabled(exchange_btn_1, true)
	GUI:setTag(exchange_btn_1, 0)

	-- Create callBtn
	local callBtn = GUI:Button_Create(Node_6, "callBtn", 308, 98, "res/custom/npc/anc1.png")
	GUI:Button_loadTexturePressed(callBtn, "res/custom/npc/anc2.png")
	GUI:setContentSize(callBtn, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(callBtn, false)
	GUI:Button_setTitleText(callBtn, [[联系客服]])
	GUI:Button_setTitleColor(callBtn, "#ffff00")
	GUI:Button_setTitleFontSize(callBtn, 18)
	GUI:Button_titleEnableOutline(callBtn, "#000000", 1)
	GUI:setAnchorPoint(callBtn, 0.00, 0.00)
	GUI:setTouchEnabled(callBtn, true)
	GUI:setTag(callBtn, 0)

	-- Create er_wei_ma
	local er_wei_ma = GUI:Image_Create(Node_6, "er_wei_ma", 251, 90, "res/custom/npc/19fl/ma.jpg")
	GUI:setAnchorPoint(er_wei_ma, 0.00, 0.00)
	GUI:setScale(er_wei_ma, 0.60)
	GUI:setTouchEnabled(er_wei_ma, false)
	GUI:setTag(er_wei_ma, 0)
	GUI:setVisible(er_wei_ma, false)

	-- Create Node_7
	local Node_7 = GUI:Node_Create(FrameLayout, "Node_7", 0, 0)
	GUI:setTag(Node_7, 0)
	GUI:setVisible(Node_7, false)

	-- Create buy688gift
	local buy688gift = GUI:Button_Create(Node_7, "buy688gift", 641, 45, "res/custom/npc/19fl/a1.png")
	GUI:Button_loadTexturePressed(buy688gift, "res/custom/npc/19fl/a2.png")
	GUI:setContentSize(buy688gift, 116, 38)
	GUI:setIgnoreContentAdaptWithSize(buy688gift, false)
	GUI:Button_setTitleText(buy688gift, [[]])
	GUI:Button_setTitleColor(buy688gift, "#ffffff")
	GUI:Button_setTitleFontSize(buy688gift, 16)
	GUI:Button_titleEnableOutline(buy688gift, "#000000", 1)
	GUI:setAnchorPoint(buy688gift, 0.50, 0.00)
	GUI:setTouchEnabled(buy688gift, true)
	GUI:setTag(buy688gift, 0)

	-- Create buy688_tag
	local buy688_tag = GUI:Image_Create(Node_7, "buy688_tag", 600, 37, "res/custom/tag/hdyl_002.png")
	GUI:setContentSize(buy688_tag, 90, 51)
	GUI:setIgnoreContentAdaptWithSize(buy688_tag, false)
	GUI:setAnchorPoint(buy688_tag, 0.00, 0.00)
	GUI:setTouchEnabled(buy688_tag, false)
	GUI:setTag(buy688_tag, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
