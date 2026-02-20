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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 110, 42, 888, 541, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, false)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/116jbp/bg.png")
	GUI:Image_setScale9Slice(bg_Image, 88, 88, 180, 180)
	GUI:setContentSize(bg_Image, 888, 541)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, false)
	GUI:setTag(bg_Image, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 812, 433, "res/custom/npc/close3.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create rewardList
	local rewardList = GUI:ListView_Create(FrameLayout, "rewardList", 488, 72, 343, 300, 1)
	GUI:ListView_setItemsMargin(rewardList, 2)
	GUI:setAnchorPoint(rewardList, 0.00, 0.00)
	GUI:setTouchEnabled(rewardList, true)
	GUI:setTag(rewardList, 0)

	-- Create reward_cell_1
	local reward_cell_1 = GUI:Image_Create(rewardList, "reward_cell_1", 0, 227, "res/custom/npc/116jbp/k.png")
	GUI:setContentSize(reward_cell_1, 342, 73)
	GUI:setIgnoreContentAdaptWithSize(reward_cell_1, false)
	GUI:setAnchorPoint(reward_cell_1, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_1, false)
	GUI:setTag(reward_cell_1, 0)

	-- Create title_text1
	local title_text1 = GUI:Text_Create(reward_cell_1, "title_text1", 17, 32, 16, "#ffffff", [[每10分钟领取1次:]])
	GUI:Text_enableOutline(title_text1, "#000000", 1)
	GUI:setAnchorPoint(title_text1, 0.00, 0.00)
	GUI:setTouchEnabled(title_text1, false)
	GUI:setTag(title_text1, 0)

	-- Create get_reward_1
	local get_reward_1 = GUI:Button_Create(reward_cell_1, "get_reward_1", 239, 18, "res/custom/npc/116jbp/an1.png")
	GUI:Button_loadTexturePressed(get_reward_1, "res/custom/npc/116jbp/an2.png")
	GUI:Button_setScale9Slice(get_reward_1, 8, 8, 11, 11)
	GUI:setContentSize(get_reward_1, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(get_reward_1, false)
	GUI:Button_setTitleText(get_reward_1, [[]])
	GUI:Button_setTitleColor(get_reward_1, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_1, 16)
	GUI:Button_titleEnableOutline(get_reward_1, "#000000", 1)
	GUI:setAnchorPoint(get_reward_1, 0.00, 0.00)
	GUI:setTouchEnabled(get_reward_1, true)
	GUI:setTag(get_reward_1, 0)

	-- Create get_tag_1
	local get_tag_1 = GUI:Image_Create(reward_cell_1, "get_tag_1", 244, 20, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_1, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_1, false)
	GUI:setAnchorPoint(get_tag_1, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_1, false)
	GUI:setTag(get_tag_1, 0)
	GUI:setVisible(get_tag_1, false)

	-- Create schedule_text1
	local schedule_text1 = GUI:Text_Create(reward_cell_1, "schedule_text1", 160, 31, 16, "#00ff00", [[00]])
	GUI:Text_enableOutline(schedule_text1, "#000000", 1)
	GUI:setAnchorPoint(schedule_text1, 0.00, 0.00)
	GUI:setTouchEnabled(schedule_text1, false)
	GUI:setTag(schedule_text1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(reward_cell_1, "Text_1", 17, 5, 16, "#ffff00", [[领取倒计时：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create coundown_time
	local coundown_time = GUI:Text_Create(reward_cell_1, "coundown_time", 107, 5, 16, "#ff0000", [[00:00:00]])
	GUI:Text_enableOutline(coundown_time, "#000000", 1)
	GUI:setAnchorPoint(coundown_time, 0.00, 0.00)
	GUI:setTouchEnabled(coundown_time, false)
	GUI:setTag(coundown_time, 0)

	-- Create reward_cell_2
	local reward_cell_2 = GUI:Image_Create(rewardList, "reward_cell_2", 0, 152, "res/custom/npc/116jbp/k.png")
	GUI:setContentSize(reward_cell_2, 342, 73)
	GUI:setIgnoreContentAdaptWithSize(reward_cell_2, false)
	GUI:setAnchorPoint(reward_cell_2, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_2, false)
	GUI:setTag(reward_cell_2, 0)

	-- Create title_text2
	local title_text2 = GUI:Text_Create(reward_cell_2, "title_text2", 17, 25, 16, "#ffffff", [[任意击杀小怪500只:]])
	GUI:Text_enableOutline(title_text2, "#000000", 1)
	GUI:setAnchorPoint(title_text2, 0.00, 0.00)
	GUI:setTouchEnabled(title_text2, false)
	GUI:setTag(title_text2, 0)

	-- Create get_reward_2
	local get_reward_2 = GUI:Button_Create(reward_cell_2, "get_reward_2", 239, 18, "res/custom/npc/116jbp/an1.png")
	GUI:Button_loadTexturePressed(get_reward_2, "res/custom/npc/116jbp/an2.png")
	GUI:Button_setScale9Slice(get_reward_2, 8, 8, 11, 11)
	GUI:setContentSize(get_reward_2, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(get_reward_2, false)
	GUI:Button_setTitleText(get_reward_2, [[]])
	GUI:Button_setTitleColor(get_reward_2, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_2, 16)
	GUI:Button_titleEnableOutline(get_reward_2, "#000000", 1)
	GUI:setAnchorPoint(get_reward_2, 0.00, 0.00)
	GUI:setTouchEnabled(get_reward_2, true)
	GUI:setTag(get_reward_2, 0)

	-- Create get_tag_2
	local get_tag_2 = GUI:Image_Create(reward_cell_2, "get_tag_2", 244, 20, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_2, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_2, false)
	GUI:setAnchorPoint(get_tag_2, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_2, false)
	GUI:setTag(get_tag_2, 0)
	GUI:setVisible(get_tag_2, false)

	-- Create schedule_text2
	local schedule_text2 = GUI:Text_Create(reward_cell_2, "schedule_text2", 160, 24, 16, "#00ff00", [[100/100只]])
	GUI:Text_enableOutline(schedule_text2, "#000000", 1)
	GUI:setAnchorPoint(schedule_text2, 0.00, 0.00)
	GUI:setTouchEnabled(schedule_text2, false)
	GUI:setTag(schedule_text2, 0)

	-- Create reward_cell_3
	local reward_cell_3 = GUI:Image_Create(rewardList, "reward_cell_3", 0, 77, "res/custom/npc/116jbp/k.png")
	GUI:setContentSize(reward_cell_3, 342, 73)
	GUI:setIgnoreContentAdaptWithSize(reward_cell_3, false)
	GUI:setAnchorPoint(reward_cell_3, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_3, false)
	GUI:setTag(reward_cell_3, 0)

	-- Create title_text3
	local title_text3 = GUI:Text_Create(reward_cell_3, "title_text3", 17, 25, 16, "#ffffff", [[任意击杀500只:]])
	GUI:Text_enableOutline(title_text3, "#000000", 1)
	GUI:setAnchorPoint(title_text3, 0.00, 0.00)
	GUI:setTouchEnabled(title_text3, false)
	GUI:setTag(title_text3, 0)

	-- Create get_reward_3
	local get_reward_3 = GUI:Button_Create(reward_cell_3, "get_reward_3", 239, 18, "res/custom/npc/116jbp/an1.png")
	GUI:Button_loadTexturePressed(get_reward_3, "res/custom/npc/116jbp/an2.png")
	GUI:Button_setScale9Slice(get_reward_3, 8, 8, 11, 11)
	GUI:setContentSize(get_reward_3, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(get_reward_3, false)
	GUI:Button_setTitleText(get_reward_3, [[]])
	GUI:Button_setTitleColor(get_reward_3, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_3, 16)
	GUI:Button_titleEnableOutline(get_reward_3, "#000000", 1)
	GUI:setAnchorPoint(get_reward_3, 0.00, 0.00)
	GUI:setTouchEnabled(get_reward_3, true)
	GUI:setTag(get_reward_3, 0)

	-- Create get_tag_3
	local get_tag_3 = GUI:Image_Create(reward_cell_3, "get_tag_3", 244, 20, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_3, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_3, false)
	GUI:setAnchorPoint(get_tag_3, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_3, false)
	GUI:setTag(get_tag_3, 0)
	GUI:setVisible(get_tag_3, false)

	-- Create schedule_text3
	local schedule_text3 = GUI:Text_Create(reward_cell_3, "schedule_text3", 160, 24, 16, "#00ff00", [[]])
	GUI:Text_enableOutline(schedule_text3, "#000000", 1)
	GUI:setAnchorPoint(schedule_text3, 0.00, 0.00)
	GUI:setTouchEnabled(schedule_text3, false)
	GUI:setTag(schedule_text3, 0)

	-- Create reward_cell_4
	local reward_cell_4 = GUI:Image_Create(rewardList, "reward_cell_4", 0, 2, "res/custom/npc/116jbp/k.png")
	GUI:setContentSize(reward_cell_4, 342, 73)
	GUI:setIgnoreContentAdaptWithSize(reward_cell_4, false)
	GUI:setAnchorPoint(reward_cell_4, 0.00, 0.00)
	GUI:setTouchEnabled(reward_cell_4, false)
	GUI:setTag(reward_cell_4, 0)

	-- Create title_text4
	local title_text4 = GUI:Text_Create(reward_cell_4, "title_text4", 17, 25, 16, "#ffffff", [[任意击杀500只:]])
	GUI:Text_enableOutline(title_text4, "#000000", 1)
	GUI:setAnchorPoint(title_text4, 0.00, 0.00)
	GUI:setTouchEnabled(title_text4, false)
	GUI:setTag(title_text4, 0)

	-- Create get_reward_4
	local get_reward_4 = GUI:Button_Create(reward_cell_4, "get_reward_4", 239, 18, "res/custom/npc/116jbp/an1.png")
	GUI:Button_loadTexturePressed(get_reward_4, "res/custom/npc/116jbp/an2.png")
	GUI:Button_setScale9Slice(get_reward_4, 8, 8, 11, 11)
	GUI:setContentSize(get_reward_4, 84, 34)
	GUI:setIgnoreContentAdaptWithSize(get_reward_4, false)
	GUI:Button_setTitleText(get_reward_4, [[]])
	GUI:Button_setTitleColor(get_reward_4, "#ffffff")
	GUI:Button_setTitleFontSize(get_reward_4, 16)
	GUI:Button_titleEnableOutline(get_reward_4, "#000000", 1)
	GUI:setAnchorPoint(get_reward_4, 0.00, 0.00)
	GUI:setTouchEnabled(get_reward_4, true)
	GUI:setTag(get_reward_4, 0)

	-- Create get_tag_4
	local get_tag_4 = GUI:Image_Create(reward_cell_4, "get_tag_4", 244, 20, "res/custom/tag/ok.png")
	GUI:setContentSize(get_tag_4, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_tag_4, false)
	GUI:setAnchorPoint(get_tag_4, 0.00, 0.00)
	GUI:setTouchEnabled(get_tag_4, false)
	GUI:setTag(get_tag_4, 0)
	GUI:setVisible(get_tag_4, false)

	-- Create schedule_text4
	local schedule_text4 = GUI:Text_Create(reward_cell_4, "schedule_text4", 160, 24, 16, "#00ff00", [[]])
	GUI:Text_enableOutline(schedule_text4, "#000000", 1)
	GUI:setAnchorPoint(schedule_text4, 0.00, 0.00)
	GUI:setTouchEnabled(schedule_text4, false)
	GUI:setTag(schedule_text4, 0)

	-- Create get_equip_btn
	local get_equip_btn = GUI:Button_Create(FrameLayout, "get_equip_btn", 375, 135, "res/custom/npc/116jbp/an11.png")
	GUI:Button_loadTexturePressed(get_equip_btn, "res/custom/npc/116jbp/an12.png")
	GUI:setContentSize(get_equip_btn, 99, 34)
	GUI:setIgnoreContentAdaptWithSize(get_equip_btn, false)
	GUI:Button_setTitleText(get_equip_btn, [[]])
	GUI:Button_setTitleColor(get_equip_btn, "#ffffff")
	GUI:Button_setTitleFontSize(get_equip_btn, 16)
	GUI:Button_titleDisableOutLine(get_equip_btn)
	GUI:setAnchorPoint(get_equip_btn, 0.00, 0.00)
	GUI:setTouchEnabled(get_equip_btn, true)
	GUI:setTag(get_equip_btn, 0)

	-- Create get_equip_tag
	local get_equip_tag = GUI:Image_Create(FrameLayout, "get_equip_tag", 388, 137, "res/custom/tag/ok.png")
	GUI:setContentSize(get_equip_tag, 73, 29)
	GUI:setIgnoreContentAdaptWithSize(get_equip_tag, false)
	GUI:setAnchorPoint(get_equip_tag, 0.00, 0.00)
	GUI:setTouchEnabled(get_equip_tag, false)
	GUI:setTag(get_equip_tag, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 426, 225, {index = 51168, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
