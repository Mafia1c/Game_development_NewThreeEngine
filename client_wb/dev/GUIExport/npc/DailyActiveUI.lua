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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 170, 34, 832, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/55mrhy/bg1.png")
	GUI:Image_setScale9Slice(bg_Image, 84, 84, 188, 188)
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
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

	-- Create rule_node
	local rule_node = GUI:Node_Create(FrameLayout, "rule_node", 0, 0)
	GUI:setTag(rule_node, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(rule_node, "Image_1", 74, 374, "res/custom/npc/55mrhy/hyd.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(rule_node, "Text_1", 259, 453, 18, "#00ff00", [[规则说明:]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(rule_node, "Text_2", 259, 429, 18, "#ffffff", [[每日活跃目标达成即可获得对应奖励!]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(rule_node, "Text_3", 259, 403, 18, "#ffffff", [[达成指定活跃度可获取对应奖励]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(rule_node, "Text_4", 259, 376, 18, "#ffffff", [[活跃度也可用于兑换指定道具]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create rewardList
	local rewardList = GUI:ListView_Create(FrameLayout, "rewardList", 560, 168, 241, 286, 1)
	GUI:ListView_setItemsMargin(rewardList, 2)
	GUI:setAnchorPoint(rewardList, 0.00, 0.00)
	GUI:setTouchEnabled(rewardList, true)
	GUI:setTag(rewardList, 0)

	-- Create reward_cell_1
	local reward_cell_1 = GUI:Image_Create(rewardList, "reward_cell_1", 0, 209, "res/custom/npc/55mrhy/kuang.png")
	GUI:setAnchorPoint(reward_cell_1, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_1, false)
	GUI:setTag(reward_cell_1, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(reward_cell_1, "RichText_1", 56, 29, [[<font color='#00ff00' size='16' >30</font><font color='#ffffff' size='16' >活跃度</font>]], 90, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.50, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(reward_cell_1, "ItemShow_1", 124, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create get_reward_1
	local get_reward_1 = GUI:Button_Create(reward_cell_1, "get_reward_1", 165, 23, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(get_reward_1, "res/custom/npc/an2.png")
	GUI:Button_setScale9Slice(get_reward_1, 10, 10, 12, 12)
	GUI:setContentSize(get_reward_1, 127, 60)
	GUI:setIgnoreContentAdaptWithSize(get_reward_1, false)
	GUI:Button_setTitleText(get_reward_1, [[]])
	GUI:Button_setTitleColor(get_reward_1, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_1, 16)
	GUI:Button_titleEnableOutline(get_reward_1, "#000000", 1)
	GUI:setAnchorPoint(get_reward_1, 0.00, 0.00)
	GUI:setScale(get_reward_1, 0.50)
	GUI:setTouchEnabled(get_reward_1, true)
	GUI:setTag(get_reward_1, 0)

	-- Create btn_txt_1
	local btn_txt_1 = GUI:Text_Create(reward_cell_1, "btn_txt_1", 175, 26, 16, "#ffffff", [[领   取]])
	GUI:Text_enableOutline(btn_txt_1, "#000000", 1)
	GUI:setAnchorPoint(btn_txt_1, 0.00, 0.00)
	GUI:setTouchEnabled(btn_txt_1, false)
	GUI:setTag(btn_txt_1, 0)

	-- Create get_tag_1
	local get_tag_1 = GUI:Image_Create(reward_cell_1, "get_tag_1", 161, 24, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_1, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_1, false)
	GUI:setAnchorPoint(get_tag_1, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_1, false)
	GUI:setTag(get_tag_1, 0)

	-- Create reward_cell_2
	local reward_cell_2 = GUI:Image_Create(rewardList, "reward_cell_2", 0, 130, "res/custom/npc/55mrhy/kuang.png")
	GUI:setAnchorPoint(reward_cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_2, false)
	GUI:setTag(reward_cell_2, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(reward_cell_2, "RichText_2", 56, 29, [[<font color='#00ff00' size='16' >80</font><font color='#ffffff' size='16' >活跃度</font>]], 90, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.50, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(reward_cell_2, "ItemShow_2", 124, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create get_reward_2
	local get_reward_2 = GUI:Button_Create(reward_cell_2, "get_reward_2", 165, 23, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(get_reward_2, "res/custom/npc/an2.png")
	GUI:Button_setScale9Slice(get_reward_2, 10, 10, 12, 12)
	GUI:setContentSize(get_reward_2, 127, 60)
	GUI:setIgnoreContentAdaptWithSize(get_reward_2, false)
	GUI:Button_setTitleText(get_reward_2, [[]])
	GUI:Button_setTitleColor(get_reward_2, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_2, 16)
	GUI:Button_titleEnableOutline(get_reward_2, "#000000", 1)
	GUI:setAnchorPoint(get_reward_2, 0.00, 0.00)
	GUI:setScale(get_reward_2, 0.50)
	GUI:setTouchEnabled(get_reward_2, true)
	GUI:setTag(get_reward_2, 0)

	-- Create btn_txt_2
	local btn_txt_2 = GUI:Text_Create(reward_cell_2, "btn_txt_2", 175, 26, 16, "#ffffff", [[领   取]])
	GUI:Text_enableOutline(btn_txt_2, "#000000", 1)
	GUI:setAnchorPoint(btn_txt_2, 0.00, 0.00)
	GUI:setTouchEnabled(btn_txt_2, false)
	GUI:setTag(btn_txt_2, 0)

	-- Create get_tag_2
	local get_tag_2 = GUI:Image_Create(reward_cell_2, "get_tag_2", 161, 24, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_2, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_2, false)
	GUI:setAnchorPoint(get_tag_2, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_2, false)
	GUI:setTag(get_tag_2, 0)

	-- Create reward_cell_3
	local reward_cell_3 = GUI:Image_Create(rewardList, "reward_cell_3", 0, 51, "res/custom/npc/55mrhy/kuang.png")
	GUI:setAnchorPoint(reward_cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_3, false)
	GUI:setTag(reward_cell_3, 0)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(reward_cell_3, "RichText_3", 53, 29, [[<font color='#00ff00' size='16' >150</font><font color='#ffffff' size='16' >活跃度</font>]], 90, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.50, 0.00)
	GUI:setTag(RichText_3, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(reward_cell_3, "ItemShow_3", 124, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create get_reward_3
	local get_reward_3 = GUI:Button_Create(reward_cell_3, "get_reward_3", 165, 23, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(get_reward_3, "res/custom/npc/an2.png")
	GUI:Button_setScale9Slice(get_reward_3, 10, 10, 12, 12)
	GUI:setContentSize(get_reward_3, 127, 60)
	GUI:setIgnoreContentAdaptWithSize(get_reward_3, false)
	GUI:Button_setTitleText(get_reward_3, [[]])
	GUI:Button_setTitleColor(get_reward_3, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_3, 16)
	GUI:Button_titleEnableOutline(get_reward_3, "#000000", 1)
	GUI:setAnchorPoint(get_reward_3, 0.00, 0.00)
	GUI:setScale(get_reward_3, 0.50)
	GUI:setTouchEnabled(get_reward_3, true)
	GUI:setTag(get_reward_3, 0)

	-- Create btn_txt_3
	local btn_txt_3 = GUI:Text_Create(reward_cell_3, "btn_txt_3", 175, 26, 16, "#ffffff", [[领   取]])
	GUI:Text_enableOutline(btn_txt_3, "#000000", 1)
	GUI:setAnchorPoint(btn_txt_3, 0.00, 0.00)
	GUI:setTouchEnabled(btn_txt_3, false)
	GUI:setTag(btn_txt_3, 0)

	-- Create get_tag_3
	local get_tag_3 = GUI:Image_Create(reward_cell_3, "get_tag_3", 161, 24, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_3, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_3, false)
	GUI:setAnchorPoint(get_tag_3, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_3, false)
	GUI:setTag(get_tag_3, 0)

	-- Create reward_cell_4
	local reward_cell_4 = GUI:Image_Create(rewardList, "reward_cell_4", 0, -28, "res/custom/npc/55mrhy/kuang.png")
	GUI:setAnchorPoint(reward_cell_4, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_4, false)
	GUI:setTag(reward_cell_4, 0)

	-- Create RichText_4
	local RichText_4 = GUI:RichText_Create(reward_cell_4, "RichText_4", 53, 29, [[<font color='#00ff00' size='16' >240</font><font color='#ffffff' size='16' >活跃度</font>]], 90, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_4, 0.50, 0.00)
	GUI:setTag(RichText_4, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(reward_cell_4, "ItemShow_4", 124, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create get_reward_4
	local get_reward_4 = GUI:Button_Create(reward_cell_4, "get_reward_4", 165, 23, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(get_reward_4, "res/custom/npc/an2.png")
	GUI:Button_setScale9Slice(get_reward_4, 10, 10, 12, 12)
	GUI:setContentSize(get_reward_4, 127, 60)
	GUI:setIgnoreContentAdaptWithSize(get_reward_4, false)
	GUI:Button_setTitleText(get_reward_4, [[]])
	GUI:Button_setTitleColor(get_reward_4, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_4, 16)
	GUI:Button_titleEnableOutline(get_reward_4, "#000000", 1)
	GUI:setAnchorPoint(get_reward_4, 0.00, 0.00)
	GUI:setScale(get_reward_4, 0.50)
	GUI:setTouchEnabled(get_reward_4, true)
	GUI:setTag(get_reward_4, 0)

	-- Create btn_txt_4
	local btn_txt_4 = GUI:Text_Create(reward_cell_4, "btn_txt_4", 175, 26, 16, "#ffffff", [[领   取]])
	GUI:Text_enableOutline(btn_txt_4, "#000000", 1)
	GUI:setAnchorPoint(btn_txt_4, 0.00, 0.00)
	GUI:setTouchEnabled(btn_txt_4, false)
	GUI:setTag(btn_txt_4, 0)

	-- Create get_tag_4
	local get_tag_4 = GUI:Image_Create(reward_cell_4, "get_tag_4", 161, 24, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_4, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_4, false)
	GUI:setAnchorPoint(get_tag_4, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_4, false)
	GUI:setTag(get_tag_4, 0)

	-- Create reward_cell_5
	local reward_cell_5 = GUI:Image_Create(rewardList, "reward_cell_5", 0, -107, "res/custom/npc/55mrhy/kuang.png")
	GUI:setAnchorPoint(reward_cell_5, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_5, false)
	GUI:setTag(reward_cell_5, 0)

	-- Create RichText_5
	local RichText_5 = GUI:RichText_Create(reward_cell_5, "RichText_5", 53, 29, [[<font color='#00ff00' size='16' >360</font><font color='#ffffff' size='16' >活跃度</font>]], 90, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_5, 0.50, 0.00)
	GUI:setTag(RichText_5, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(reward_cell_5, "ItemShow_5", 124, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create get_reward_5
	local get_reward_5 = GUI:Button_Create(reward_cell_5, "get_reward_5", 165, 23, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(get_reward_5, "res/custom/npc/an2.png")
	GUI:Button_setScale9Slice(get_reward_5, 10, 10, 12, 12)
	GUI:setContentSize(get_reward_5, 127, 60)
	GUI:setIgnoreContentAdaptWithSize(get_reward_5, false)
	GUI:Button_setTitleText(get_reward_5, [[]])
	GUI:Button_setTitleColor(get_reward_5, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_5, 16)
	GUI:Button_titleEnableOutline(get_reward_5, "#000000", 1)
	GUI:setAnchorPoint(get_reward_5, 0.00, 0.00)
	GUI:setScale(get_reward_5, 0.50)
	GUI:setTouchEnabled(get_reward_5, true)
	GUI:setTag(get_reward_5, 0)

	-- Create btn_txt_5
	local btn_txt_5 = GUI:Text_Create(reward_cell_5, "btn_txt_5", 175, 26, 16, "#ffffff", [[领   取]])
	GUI:Text_enableOutline(btn_txt_5, "#000000", 1)
	GUI:setAnchorPoint(btn_txt_5, 0.00, 0.00)
	GUI:setTouchEnabled(btn_txt_5, false)
	GUI:setTag(btn_txt_5, 0)

	-- Create get_tag_5
	local get_tag_5 = GUI:Image_Create(reward_cell_5, "get_tag_5", 161, 24, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_5, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_5, false)
	GUI:setAnchorPoint(get_tag_5, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_5, false)
	GUI:setTag(get_tag_5, 0)

	-- Create reward_cell_6
	local reward_cell_6 = GUI:Image_Create(rewardList, "reward_cell_6", 0, -186, "res/custom/npc/55mrhy/kuang.png")
	GUI:setAnchorPoint(reward_cell_6, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_6, false)
	GUI:setTag(reward_cell_6, 0)

	-- Create RichText_6
	local RichText_6 = GUI:RichText_Create(reward_cell_6, "RichText_6", 53, 29, [[<font color='#00ff00' size='16' >420</font><font color='#ffffff' size='16' >活跃度</font>]], 90, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_6, 0.50, 0.00)
	GUI:setTag(RichText_6, 0)

	-- Create ItemShow_6
	local ItemShow_6 = GUI:ItemShow_Create(reward_cell_6, "ItemShow_6", 124, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_6, 0.50, 0.50)
	GUI:setTag(ItemShow_6, 0)

	-- Create get_reward_6
	local get_reward_6 = GUI:Button_Create(reward_cell_6, "get_reward_6", 165, 23, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(get_reward_6, "res/custom/npc/an2.png")
	GUI:Button_setScale9Slice(get_reward_6, 10, 10, 12, 12)
	GUI:setContentSize(get_reward_6, 127, 60)
	GUI:setIgnoreContentAdaptWithSize(get_reward_6, false)
	GUI:Button_setTitleText(get_reward_6, [[]])
	GUI:Button_setTitleColor(get_reward_6, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_6, 16)
	GUI:Button_titleEnableOutline(get_reward_6, "#000000", 1)
	GUI:setAnchorPoint(get_reward_6, 0.00, 0.00)
	GUI:setScale(get_reward_6, 0.50)
	GUI:setTouchEnabled(get_reward_6, true)
	GUI:setTag(get_reward_6, 0)

	-- Create btn_txt_6
	local btn_txt_6 = GUI:Text_Create(reward_cell_6, "btn_txt_6", 175, 26, 16, "#ffffff", [[领   取]])
	GUI:Text_enableOutline(btn_txt_6, "#000000", 1)
	GUI:setAnchorPoint(btn_txt_6, 0.00, 0.00)
	GUI:setTouchEnabled(btn_txt_6, false)
	GUI:setTag(btn_txt_6, 0)

	-- Create get_tag_6
	local get_tag_6 = GUI:Image_Create(reward_cell_6, "get_tag_6", 161, 24, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_6, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_6, false)
	GUI:setAnchorPoint(get_tag_6, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_6, false)
	GUI:setTag(get_tag_6, 0)

	-- Create reward_cell_7
	local reward_cell_7 = GUI:Image_Create(rewardList, "reward_cell_7", 0, -265, "res/custom/npc/55mrhy/kuang.png")
	GUI:setAnchorPoint(reward_cell_7, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_7, false)
	GUI:setTag(reward_cell_7, 0)

	-- Create RichText_7
	local RichText_7 = GUI:RichText_Create(reward_cell_7, "RichText_7", 53, 29, [[<font color='#00ff00' size='16' >500</font><font color='#ffffff' size='16' >活跃度</font>]], 90, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_7, 0.50, 0.00)
	GUI:setTag(RichText_7, 0)

	-- Create ItemShow_7
	local ItemShow_7 = GUI:ItemShow_Create(reward_cell_7, "ItemShow_7", 124, 38, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_7, 0.50, 0.50)
	GUI:setTag(ItemShow_7, 0)

	-- Create get_reward_7
	local get_reward_7 = GUI:Button_Create(reward_cell_7, "get_reward_7", 165, 23, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(get_reward_7, "res/custom/npc/an2.png")
	GUI:Button_setScale9Slice(get_reward_7, 10, 10, 12, 12)
	GUI:setContentSize(get_reward_7, 127, 60)
	GUI:setIgnoreContentAdaptWithSize(get_reward_7, false)
	GUI:Button_setTitleText(get_reward_7, [[]])
	GUI:Button_setTitleColor(get_reward_7, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_7, 16)
	GUI:Button_titleEnableOutline(get_reward_7, "#000000", 1)
	GUI:setAnchorPoint(get_reward_7, 0.00, 0.00)
	GUI:setScale(get_reward_7, 0.50)
	GUI:setTouchEnabled(get_reward_7, true)
	GUI:setTag(get_reward_7, 0)

	-- Create btn_txt_7
	local btn_txt_7 = GUI:Text_Create(reward_cell_7, "btn_txt_7", 175, 26, 16, "#ffffff", [[领   取]])
	GUI:Text_enableOutline(btn_txt_7, "#000000", 1)
	GUI:setAnchorPoint(btn_txt_7, 0.00, 0.00)
	GUI:setTouchEnabled(btn_txt_7, false)
	GUI:setTag(btn_txt_7, 0)

	-- Create get_tag_7
	local get_tag_7 = GUI:Image_Create(reward_cell_7, "get_tag_7", 161, 24, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_7, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_7, false)
	GUI:setAnchorPoint(get_tag_7, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_7, false)
	GUI:setTag(get_tag_7, 0)

	-- Create exchange_node
	local exchange_node = GUI:Node_Create(FrameLayout, "exchange_node", 0, 0)
	GUI:setTag(exchange_node, 0)

	-- Create exchange_item_1
	local exchange_item_1 = GUI:ItemShow_Create(exchange_node, "exchange_item_1", 604, 102, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(exchange_item_1, 0.50, 0.50)
	GUI:setTag(exchange_item_1, 0)

	-- Create exchange_item_2
	local exchange_item_2 = GUI:ItemShow_Create(exchange_node, "exchange_item_2", 684, 102, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(exchange_item_2, 0.50, 0.50)
	GUI:setTag(exchange_item_2, 0)

	-- Create exchange_item_3
	local exchange_item_3 = GUI:ItemShow_Create(exchange_node, "exchange_item_3", 763, 102, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(exchange_item_3, 0.50, 0.50)
	GUI:setTag(exchange_item_3, 0)

	-- Create ex_btn_1
	local ex_btn_1 = GUI:Button_Create(exchange_node, "ex_btn_1", 574, 36, "res/custom/btn21.png")
	GUI:setContentSize(ex_btn_1, 60, 32)
	GUI:setIgnoreContentAdaptWithSize(ex_btn_1, false)
	GUI:Button_setTitleText(ex_btn_1, [[兑  换]])
	GUI:Button_setTitleColor(ex_btn_1, "#ffffff")
	GUI:Button_setTitleFontSize(ex_btn_1, 16)
	GUI:Button_titleEnableOutline(ex_btn_1, "#000000", 1)
	GUI:setAnchorPoint(ex_btn_1, 0.00, 0.00)
	GUI:setTouchEnabled(ex_btn_1, true)
	GUI:setTag(ex_btn_1, 0)

	-- Create ex_btn_2
	local ex_btn_2 = GUI:Button_Create(exchange_node, "ex_btn_2", 655, 36, "res/custom/btn21.png")
	GUI:setContentSize(ex_btn_2, 60, 32)
	GUI:setIgnoreContentAdaptWithSize(ex_btn_2, false)
	GUI:Button_setTitleText(ex_btn_2, [[兑  换]])
	GUI:Button_setTitleColor(ex_btn_2, "#ffffff")
	GUI:Button_setTitleFontSize(ex_btn_2, 16)
	GUI:Button_titleEnableOutline(ex_btn_2, "#000000", 1)
	GUI:setAnchorPoint(ex_btn_2, 0.00, 0.00)
	GUI:setTouchEnabled(ex_btn_2, true)
	GUI:setTag(ex_btn_2, 0)

	-- Create ex_btn_3
	local ex_btn_3 = GUI:Button_Create(exchange_node, "ex_btn_3", 734, 36, "res/custom/btn21.png")
	GUI:setContentSize(ex_btn_3, 60, 32)
	GUI:setIgnoreContentAdaptWithSize(ex_btn_3, false)
	GUI:Button_setTitleText(ex_btn_3, [[兑  换]])
	GUI:Button_setTitleColor(ex_btn_3, "#ffffff")
	GUI:Button_setTitleFontSize(ex_btn_3, 16)
	GUI:Button_titleEnableOutline(ex_btn_3, "#000000", 1)
	GUI:setAnchorPoint(ex_btn_3, 0.00, 0.00)
	GUI:setTouchEnabled(ex_btn_3, true)
	GUI:setTag(ex_btn_3, 0)

	-- Create taskList
	local taskList = GUI:ListView_Create(FrameLayout, "taskList", 72, 36, 484, 300, 1)
	GUI:setAnchorPoint(taskList, 0.00, 0.00)
	GUI:setTouchEnabled(taskList, true)
	GUI:setTag(taskList, 0)

	-- Create my_active_txt
	local my_active_txt = GUI:Text_Create(FrameLayout, "my_active_txt", 161, 418, 18, "#00ffe8", [[今日活跃: 9999]])
	GUI:Text_enableOutline(my_active_txt, "#000000", 1)
	GUI:setAnchorPoint(my_active_txt, 0.50, 0.00)
	GUI:setTouchEnabled(my_active_txt, false)
	GUI:setTag(my_active_txt, 0)

	-- Create total_active_txt
	local total_active_txt = GUI:Text_Create(FrameLayout, "total_active_txt", 161, 390, 18, "#00ff00", [[累计活跃: 9999]])
	GUI:Text_enableOutline(total_active_txt, "#000000", 1)
	GUI:setAnchorPoint(total_active_txt, 0.50, 0.00)
	GUI:setTouchEnabled(total_active_txt, false)
	GUI:setTag(total_active_txt, 0)

	-- Create jackpotBtn
	local jackpotBtn = GUI:Button_Create(FrameLayout, "jackpotBtn", 823, 346, "res/custom/npc/55mrhy/an1.png")
	GUI:Button_loadTexturePressed(jackpotBtn, "res/custom/npc/55mrhy/an2.png")
	GUI:Button_setTitleText(jackpotBtn, [[]])
	GUI:Button_setTitleColor(jackpotBtn, "#ffffff")
	GUI:Button_setTitleFontSize(jackpotBtn, 16)
	GUI:Button_titleEnableOutline(jackpotBtn, "#000000", 1)
	GUI:setAnchorPoint(jackpotBtn, 0.00, 0.00)
	GUI:setTouchEnabled(jackpotBtn, true)
	GUI:setTag(jackpotBtn, 0)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(jackpotBtn, "Text_5", 8, 36, 16, "#ffffff", [[宝
典
抽
奖]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
