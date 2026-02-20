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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/0gsha/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 270, 166, "res/custom/npc/0gsha/cs.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create title_img
	local title_img = GUI:Image_Create(FrameLayout, "title_img", 284, 431, "res/custom/npc/0gsha/tips.png")
	GUI:Image_setScale9Slice(title_img, 7, 7, 10, 10)
	GUI:setContentSize(title_img, 496, 40)
	GUI:setIgnoreContentAdaptWithSize(title_img, false)
	GUI:setAnchorPoint(title_img, 0.00, 0.00)
	GUI:setTouchEnabled(title_img, false)
	GUI:setTag(title_img, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(title_img, "Text_1", 248, 20, 18, "#ff00ff", [[快捷传送仅限攻沙期间使用, 玩家需加入行会后方可使用!]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.50)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create tips_1
	local tips_1 = GUI:Text_Create(FrameLayout, "tips_1", 284, 143, 18, "#ff0000", [==========[请在攻沙结束后[21:30]之前来领奖, 过期作废!]==========])
	GUI:Text_enableOutline(tips_1, "#000000", 1)
	GUI:setAnchorPoint(tips_1, 0.00, 0.00)
	GUI:setTouchEnabled(tips_1, false)
	GUI:setTag(tips_1, 0)

	-- Create tips_2
	local tips_2 = GUI:Text_Create(FrameLayout, "tips_2", 282, 102, 16, "#ffffff", [[你参与攻城时长:]])
	GUI:Text_enableOutline(tips_2, "#000000", 1)
	GUI:setAnchorPoint(tips_2, 0.00, 0.00)
	GUI:setTouchEnabled(tips_2, false)
	GUI:setTag(tips_2, 0)

	-- Create tips_3
	local tips_3 = GUI:Text_Create(FrameLayout, "tips_3", 282, 76, 16, "#ffffff", [[胜利方达标人数:]])
	GUI:Text_enableOutline(tips_3, "#000000", 1)
	GUI:setAnchorPoint(tips_3, 0.00, 0.00)
	GUI:setTouchEnabled(tips_3, false)
	GUI:setTag(tips_3, 0)

	-- Create tips_4
	local tips_4 = GUI:Text_Create(FrameLayout, "tips_4", 282, 49, 16, "#ffffff", [[参与方达标人数:]])
	GUI:Text_enableOutline(tips_4, "#000000", 1)
	GUI:setAnchorPoint(tips_4, 0.00, 0.00)
	GUI:setTouchEnabled(tips_4, false)
	GUI:setTag(tips_4, 0)

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

	-- Create time_txt
	local time_txt = GUI:Text_Create(FrameLayout, "time_txt", 109, 379, 18, "#00ff00", [[20:00 -> 21:00]])
	GUI:Text_enableOutline(time_txt, "#000000", 1)
	GUI:setAnchorPoint(time_txt, 0.00, 0.00)
	GUI:setTouchEnabled(time_txt, false)
	GUI:setTag(time_txt, 0)

	-- Create jackpot_txt
	local jackpot_txt = GUI:Text_Create(FrameLayout, "jackpot_txt", 165, 289, 18, "#00ffe8", [[100000元宝]])
	GUI:Text_enableOutline(jackpot_txt, "#000000", 1)
	GUI:setAnchorPoint(jackpot_txt, 0.50, 0.00)
	GUI:setTouchEnabled(jackpot_txt, false)
	GUI:setTag(jackpot_txt, 0)

	-- Create guild_txt
	local guild_txt = GUI:Text_Create(FrameLayout, "guild_txt", 165, 198, 18, "#c0c0c0", [[暂无]])
	GUI:Text_enableOutline(guild_txt, "#000000", 1)
	GUI:setAnchorPoint(guild_txt, 0.50, 0.00)
	GUI:setTouchEnabled(guild_txt, false)
	GUI:setTag(guild_txt, 0)

	-- Create city_txt
	local city_txt = GUI:Text_Create(FrameLayout, "city_txt", 165, 108, 18, "#c0c0c0", [[暂无]])
	GUI:Text_enableOutline(city_txt, "#000000", 1)
	GUI:setAnchorPoint(city_txt, 0.50, 0.00)
	GUI:setTouchEnabled(city_txt, false)
	GUI:setTag(city_txt, 0)

	-- Create mapMove_btn_1
	local mapMove_btn_1 = GUI:Button_Create(FrameLayout, "mapMove_btn_1", 343, 290, "res/custom/npc/0gsha/bt001.png")
	GUI:Button_loadTexturePressed(mapMove_btn_1, "res/custom/npc/0gsha/bt002.png")
	GUI:setContentSize(mapMove_btn_1, 94, 36)
	GUI:setIgnoreContentAdaptWithSize(mapMove_btn_1, false)
	GUI:Button_setTitleText(mapMove_btn_1, [[皇宫后院]])
	GUI:Button_setTitleColor(mapMove_btn_1, "#ffffff")
	GUI:Button_setTitleFontSize(mapMove_btn_1, 16)
	GUI:Button_titleEnableOutline(mapMove_btn_1, "#000000", 1)
	GUI:setAnchorPoint(mapMove_btn_1, 0.00, 0.00)
	GUI:setTouchEnabled(mapMove_btn_1, true)
	GUI:setTag(mapMove_btn_1, 0)

	-- Create mapMove_btn_2
	local mapMove_btn_2 = GUI:Button_Create(FrameLayout, "mapMove_btn_2", 505, 358, "res/custom/npc/0gsha/bt001.png")
	GUI:Button_loadTexturePressed(mapMove_btn_2, "res/custom/npc/0gsha/bt002.png")
	GUI:setContentSize(mapMove_btn_2, 94, 36)
	GUI:setIgnoreContentAdaptWithSize(mapMove_btn_2, false)
	GUI:Button_setTitleText(mapMove_btn_2, [[复活点]])
	GUI:Button_setTitleColor(mapMove_btn_2, "#00ff00")
	GUI:Button_setTitleFontSize(mapMove_btn_2, 16)
	GUI:Button_titleEnableOutline(mapMove_btn_2, "#000000", 1)
	GUI:setAnchorPoint(mapMove_btn_2, 0.00, 0.00)
	GUI:setTouchEnabled(mapMove_btn_2, true)
	GUI:setTag(mapMove_btn_2, 0)

	-- Create mapMove_btn_3
	local mapMove_btn_3 = GUI:Button_Create(FrameLayout, "mapMove_btn_3", 421, 235, "res/custom/npc/0gsha/bt001.png")
	GUI:Button_loadTexturePressed(mapMove_btn_3, "res/custom/npc/0gsha/bt002.png")
	GUI:setContentSize(mapMove_btn_3, 94, 36)
	GUI:setIgnoreContentAdaptWithSize(mapMove_btn_3, false)
	GUI:Button_setTitleText(mapMove_btn_3, [[武器店]])
	GUI:Button_setTitleColor(mapMove_btn_3, "#00ff00")
	GUI:Button_setTitleFontSize(mapMove_btn_3, 16)
	GUI:Button_titleEnableOutline(mapMove_btn_3, "#000000", 1)
	GUI:setAnchorPoint(mapMove_btn_3, 0.00, 0.00)
	GUI:setTouchEnabled(mapMove_btn_3, true)
	GUI:setTag(mapMove_btn_3, 0)

	-- Create mapMove_btn_4
	local mapMove_btn_4 = GUI:Button_Create(FrameLayout, "mapMove_btn_4", 636, 290, "res/custom/npc/0gsha/bt001.png")
	GUI:Button_loadTexturePressed(mapMove_btn_4, "res/custom/npc/0gsha/bt002.png")
	GUI:setContentSize(mapMove_btn_4, 94, 36)
	GUI:setIgnoreContentAdaptWithSize(mapMove_btn_4, false)
	GUI:Button_setTitleText(mapMove_btn_4, [[衣服店]])
	GUI:Button_setTitleColor(mapMove_btn_4, "#00ff00")
	GUI:Button_setTitleFontSize(mapMove_btn_4, 16)
	GUI:Button_titleEnableOutline(mapMove_btn_4, "#000000", 1)
	GUI:setAnchorPoint(mapMove_btn_4, 0.00, 0.00)
	GUI:setTouchEnabled(mapMove_btn_4, true)
	GUI:setTag(mapMove_btn_4, 0)

	-- Create mapMove_btn_5
	local mapMove_btn_5 = GUI:Button_Create(FrameLayout, "mapMove_btn_5", 682, 190, "res/custom/npc/0gsha/bt001.png")
	GUI:Button_loadTexturePressed(mapMove_btn_5, "res/custom/npc/0gsha/bt002.png")
	GUI:setContentSize(mapMove_btn_5, 94, 36)
	GUI:setIgnoreContentAdaptWithSize(mapMove_btn_5, false)
	GUI:Button_setTitleText(mapMove_btn_5, [[沙大门]])
	GUI:Button_setTitleColor(mapMove_btn_5, "#ffff00")
	GUI:Button_setTitleFontSize(mapMove_btn_5, 16)
	GUI:Button_titleEnableOutline(mapMove_btn_5, "#000000", 1)
	GUI:setAnchorPoint(mapMove_btn_5, 0.00, 0.00)
	GUI:setTouchEnabled(mapMove_btn_5, true)
	GUI:setTag(mapMove_btn_5, 0)

	-- Create rule_img
	local rule_img = GUI:Image_Create(FrameLayout, "rule_img", 266, 136, "res/custom/npc/0gsha/gstips.png")
	GUI:setContentSize(rule_img, 535, 349)
	GUI:setIgnoreContentAdaptWithSize(rule_img, false)
	GUI:setAnchorPoint(rule_img, 0.00, 0.00)
	GUI:setTouchEnabled(rule_img, false)
	GUI:setTag(rule_img, 0)
	GUI:setVisible(rule_img, false)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(rule_img, "Text_2", 149, 212, 18, "#00ff00", [[50万]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create backBtn
	local backBtn = GUI:Button_Create(rule_img, "backBtn", 476, -1, "res/custom/npc/0gsha/fh1.png")
	GUI:Button_loadTexturePressed(backBtn, "res/custom/npc/0gsha/fh2.png")
	GUI:setContentSize(backBtn, 60, 60)
	GUI:setIgnoreContentAdaptWithSize(backBtn, false)
	GUI:Button_setTitleText(backBtn, [[]])
	GUI:Button_setTitleColor(backBtn, "#ffffff")
	GUI:Button_setTitleFontSize(backBtn, 16)
	GUI:Button_titleEnableOutline(backBtn, "#000000", 1)
	GUI:setAnchorPoint(backBtn, 0.00, 0.00)
	GUI:setTouchEnabled(backBtn, true)
	GUI:setTag(backBtn, 0)

	-- Create rule_btn
	local rule_btn = GUI:Button_Create(FrameLayout, "rule_btn", 532, 64, "res/custom/npc/0gsha/bt001.png")
	GUI:Button_loadTexturePressed(rule_btn, "res/custom/npc/0gsha/bt002.png")
	GUI:setContentSize(rule_btn, 94, 36)
	GUI:setIgnoreContentAdaptWithSize(rule_btn, false)
	GUI:Button_setTitleText(rule_btn, [[攻沙规则]])
	GUI:Button_setTitleColor(rule_btn, "#ffffff")
	GUI:Button_setTitleFontSize(rule_btn, 16)
	GUI:Button_titleEnableOutline(rule_btn, "#000000", 1)
	GUI:setAnchorPoint(rule_btn, 0.00, 0.00)
	GUI:setTouchEnabled(rule_btn, true)
	GUI:setTag(rule_btn, 0)

	-- Create getReward_btn
	local getReward_btn = GUI:Button_Create(FrameLayout, "getReward_btn", 672, 64, "res/custom/npc/0gsha/bt001.png")
	GUI:Button_loadTexturePressed(getReward_btn, "res/custom/npc/0gsha/bt002.png")
	GUI:setContentSize(getReward_btn, 94, 36)
	GUI:setIgnoreContentAdaptWithSize(getReward_btn, false)
	GUI:Button_setTitleText(getReward_btn, [[领取奖励]])
	GUI:Button_setTitleColor(getReward_btn, "#ffffff")
	GUI:Button_setTitleFontSize(getReward_btn, 16)
	GUI:Button_titleEnableOutline(getReward_btn, "#000000", 1)
	GUI:setAnchorPoint(getReward_btn, 0.00, 0.00)
	GUI:setTouchEnabled(getReward_btn, true)
	GUI:setTag(getReward_btn, 0)

	-- Create city_time
	local city_time = GUI:Text_Create(FrameLayout, "city_time", 410, 102, 16, "#00ff00", [[0分钟]])
	GUI:Text_enableOutline(city_time, "#000000", 1)
	GUI:setAnchorPoint(city_time, 0.00, 0.00)
	GUI:setTouchEnabled(city_time, false)
	GUI:setTag(city_time, 0)

	-- Create people_count_1
	local people_count_1 = GUI:Text_Create(FrameLayout, "people_count_1", 410, 76, 16, "#00ff00", [[0人]])
	GUI:Text_enableOutline(people_count_1, "#000000", 1)
	GUI:setAnchorPoint(people_count_1, 0.00, 0.00)
	GUI:setTouchEnabled(people_count_1, false)
	GUI:setTag(people_count_1, 0)

	-- Create people_count_2
	local people_count_2 = GUI:Text_Create(FrameLayout, "people_count_2", 410, 49, 16, "#00ff00", [[0人]])
	GUI:Text_enableOutline(people_count_2, "#000000", 1)
	GUI:setAnchorPoint(people_count_2, 0.00, 0.00)
	GUI:setTouchEnabled(people_count_2, false)
	GUI:setTag(people_count_2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
