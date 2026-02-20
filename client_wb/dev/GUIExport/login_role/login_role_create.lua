local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Panel_role
	local Panel_role = GUI:Layout_Create(parent, "Panel_role", 568, 320, 1136, 640, false)
	GUI:setChineseName(Panel_role, "创建角色面板")
	GUI:setAnchorPoint(Panel_role, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_role, false)
	GUI:setTag(Panel_role, -1)

	-- Create Panel_anim
	local Panel_anim = GUI:Layout_Create(Panel_role, "Panel_anim", 568, 595, 350, 400, false)
	GUI:setChineseName(Panel_anim, "创建角色_模型展示")
	GUI:setAnchorPoint(Panel_anim, 1.00, 1.00)
	GUI:setTouchEnabled(Panel_anim, false)
	GUI:setTag(Panel_anim, -1)

	-- Create Node_job15_panel
	local Node_job15_panel = GUI:Node_Create(Panel_anim, "Node_job15_panel", 0, 0)
	GUI:setTag(Node_job15_panel, 0)

	-- Create job15_panel
	local job15_panel = GUI:Image_Create(Node_job15_panel, "job15_panel", -54, -30, "res/custom/npc/111zhibo/infobg.png")
	GUI:setAnchorPoint(job15_panel, 0.00, 0.00)
	GUI:setTouchEnabled(job15_panel, true)
	GUI:setTag(job15_panel, 0)

	-- Create skillList
	local skillList = GUI:ListView_Create(job15_panel, "skillList", 15, 342, 380, 72, 2)
	GUI:ListView_setGravity(skillList, 3)
	GUI:ListView_setItemsMargin(skillList, 8)
	GUI:setAnchorPoint(skillList, 0.00, 0.00)
	GUI:setTouchEnabled(skillList, true)
	GUI:setTag(skillList, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(skillList, "Image_1", 0, 0, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(skillList, "Image_3", 76, 0, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(skillList, "Image_4", 152, 0, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(skillList, "Image_5", 228, 0, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(skillList, "Image_6", 304, 0, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create skillEffectNode
	local skillEffectNode = GUI:Node_Create(job15_panel, "skillEffectNode", 0, 0)
	GUI:setTag(skillEffectNode, 0)

	-- Create skillEffect
	local skillEffect = GUI:Effect_Create(skillEffectNode, "skillEffect", 180, 173, 0, 13444, 0, 0, 0, 1)
	GUI:setTag(skillEffect, 0)

	-- Create skillInfoImg
	local skillInfoImg = GUI:Image_Create(job15_panel, "skillInfoImg", 26, 28, "res/custom/npc/111zhibo/job_info/img_0_11.png")
	GUI:setAnchorPoint(skillInfoImg, 0.00, 0.00)
	GUI:setTouchEnabled(skillInfoImg, false)
	GUI:setTag(skillInfoImg, 0)

	-- Create Node_anim
	local Node_anim = GUI:Node_Create(Panel_anim, "Node_anim", 175, 0)
	GUI:setChineseName(Node_anim, "创建角色_模型节点")
	GUI:setTag(Node_anim, -1)

	-- Create Panel_info
	local Panel_info = GUI:Layout_Create(Panel_role, "Panel_info", 568, 606, 361, 443, false)
	GUI:setChineseName(Panel_info, "创建角色_详情组合")
	GUI:setAnchorPoint(Panel_info, 0.00, 1.00)
	GUI:setTouchEnabled(Panel_info, false)
	GUI:setTag(Panel_info, -1)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Panel_info, "Image_2", 180, 221, "res/custom/npc/111zhibo/bg.png")
	GUI:setChineseName(Image_2, "创建角色_背景图")
	GUI:setAnchorPoint(Image_2, 0.50, 0.50)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, -1)

	-- Create Button_close
	local Button_close = GUI:Button_Create(Panel_info, "Button_close", 344, 424, "res/public/btn_normal_2.png")
	GUI:Button_loadTexturePressed(Button_close, "res/public/btn_pressed_2.png")
	GUI:setContentSize(Button_close, 23, 30)
	GUI:setIgnoreContentAdaptWithSize(Button_close, false)
	GUI:Button_setTitleText(Button_close, [[]])
	GUI:Button_setTitleColor(Button_close, "#ffffff")
	GUI:Button_setTitleFontSize(Button_close, 10)
	GUI:Button_titleEnableOutline(Button_close, "#000000", 1)
	GUI:setChineseName(Button_close, "创建角色_关闭按钮")
	GUI:setAnchorPoint(Button_close, 0.50, 0.50)
	GUI:setTouchEnabled(Button_close, true)
	GUI:setTag(Button_close, -1)

	-- Create Image_7
	local Image_7 = GUI:Image_Create(Panel_info, "Image_7", 162, 427, "res/private/login/word_cjzy_01.png")
	GUI:setChineseName(Image_7, "创建角色_姓名文字_图片")
	GUI:setAnchorPoint(Image_7, 0.50, 0.50)
	GUI:setTouchEnabled(Image_7, false)
	GUI:setTag(Image_7, -1)
	GUI:setVisible(Image_7, false)

	-- Create Image_8
	local Image_8 = GUI:Image_Create(Panel_info, "Image_8", 180, 409, "res/private/login/bg_cjzy_00.png")
	GUI:setChineseName(Image_8, "创建角色_取名_背景框")
	GUI:setAnchorPoint(Image_8, 0.50, 0.50)
	GUI:setTouchEnabled(Image_8, false)
	GUI:setTag(Image_8, -1)

	-- Create TextInput_name
	local TextInput_name = GUI:TextInput_Create(Panel_info, "TextInput_name", 180, 409, 140, 28, 20)
	GUI:TextInput_setString(TextInput_name, "玩家名字")
	GUI:TextInput_setFontColor(TextInput_name, "#ffffff")
	GUI:TextInput_setPlaceholderFontColor(TextInput_name, "#a6a6a6")
	GUI:TextInput_setMaxLength(TextInput_name, 7)
	GUI:setChineseName(TextInput_name, "创建角色_昵称输入")
	GUI:setAnchorPoint(TextInput_name, 0.50, 0.50)
	GUI:setTouchEnabled(TextInput_name, true)
	GUI:setTag(TextInput_name, -1)

	-- Create Button_rand
	local Button_rand = GUI:Button_Create(Panel_info, "Button_rand", 279, 408, "res/private/login/btn_cjzy_03.png")
	GUI:Button_loadTexturePressed(Button_rand, "res/private/login/btn_cjzy_03_1.png")
	GUI:setContentSize(Button_rand, 39, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_rand, false)
	GUI:Button_setTitleText(Button_rand, [[]])
	GUI:Button_setTitleColor(Button_rand, "#ffffff")
	GUI:Button_setTitleFontSize(Button_rand, 10)
	GUI:Button_titleEnableOutline(Button_rand, "#000000", 1)
	GUI:setChineseName(Button_rand, "创建角色_筛子_按钮")
	GUI:setAnchorPoint(Button_rand, 0.50, 0.50)
	GUI:setTouchEnabled(Button_rand, true)
	GUI:setTag(Button_rand, -1)

	-- Create Image_7_0
	local Image_7_0 = GUI:Image_Create(Panel_info, "Image_7_0", 157, 255, "res/private/login/word_cjzy_02.png")
	GUI:setChineseName(Image_7_0, "创建角色_职业文字_图片")
	GUI:setAnchorPoint(Image_7_0, 0.50, 0.50)
	GUI:setTouchEnabled(Image_7_0, false)
	GUI:setTag(Image_7_0, -1)
	GUI:setVisible(Image_7_0, false)

	-- Create Button_job_1
	local Button_job_1 = GUI:Button_Create(Panel_info, "Button_job_1", 90, 245, "res/private/login/icon_cjzy_01.png")
	GUI:Button_loadTextureDisabled(Button_job_1, "res/private/login/icon_cjzy_01_1.png")
	GUI:setContentSize(Button_job_1, 56, 52)
	GUI:setIgnoreContentAdaptWithSize(Button_job_1, false)
	GUI:Button_setTitleText(Button_job_1, [[]])
	GUI:Button_setTitleColor(Button_job_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_1, 10)
	GUI:Button_titleEnableOutline(Button_job_1, "#000000", 1)
	GUI:setChineseName(Button_job_1, "创建角色_职业_战士_按钮")
	GUI:setAnchorPoint(Button_job_1, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_1, true)
	GUI:setTag(Button_job_1, -1)
	GUI:setVisible(Button_job_1, false)

	-- Create Button_job_2
	local Button_job_2 = GUI:Button_Create(Panel_info, "Button_job_2", 150, 245, "res/private/login/icon_cjzy_02.png")
	GUI:Button_loadTextureDisabled(Button_job_2, "res/private/login/icon_cjzy_02_1.png")
	GUI:setContentSize(Button_job_2, 56, 52)
	GUI:setIgnoreContentAdaptWithSize(Button_job_2, false)
	GUI:Button_setTitleText(Button_job_2, [[]])
	GUI:Button_setTitleColor(Button_job_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_2, 10)
	GUI:Button_titleEnableOutline(Button_job_2, "#000000", 1)
	GUI:setChineseName(Button_job_2, "创建角色_职业_法师_按钮")
	GUI:setAnchorPoint(Button_job_2, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_2, true)
	GUI:setTag(Button_job_2, -1)
	GUI:setVisible(Button_job_2, false)

	-- Create Button_job_3
	local Button_job_3 = GUI:Button_Create(Panel_info, "Button_job_3", 208, 245, "res/private/login/icon_cjzy_03.png")
	GUI:Button_loadTextureDisabled(Button_job_3, "res/private/login/icon_cjzy_03_1.png")
	GUI:setContentSize(Button_job_3, 56, 52)
	GUI:setIgnoreContentAdaptWithSize(Button_job_3, false)
	GUI:Button_setTitleText(Button_job_3, [[]])
	GUI:Button_setTitleColor(Button_job_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_3, 10)
	GUI:Button_titleEnableOutline(Button_job_3, "#000000", 1)
	GUI:setChineseName(Button_job_3, "创建角色_职业_道士_按钮")
	GUI:setAnchorPoint(Button_job_3, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_3, true)
	GUI:setTag(Button_job_3, -1)
	GUI:setVisible(Button_job_3, false)

	-- Create Button_job_r
	local Button_job_r = GUI:Button_Create(Panel_info, "Button_job_r", 264, 245, "res/private/login/icon_cjzy_04.png")
	GUI:Button_loadTexturePressed(Button_job_r, "res/private/login/icon_cjzy_04.png")
	GUI:setContentSize(Button_job_r, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_r, false)
	GUI:Button_setTitleText(Button_job_r, [[]])
	GUI:Button_setTitleColor(Button_job_r, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_r, 10)
	GUI:Button_titleEnableOutline(Button_job_r, "#000000", 1)
	GUI:setChineseName(Button_job_r, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_r, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_r, true)
	GUI:setTag(Button_job_r, -1)
	GUI:setVisible(Button_job_r, false)

	-- Create Button_job_4
	local Button_job_4 = GUI:Button_Create(Panel_info, "Button_job_4", 229, 210, "res/private/login/icon_cjzy_07.png")
	GUI:Button_loadTextureDisabled(Button_job_4, "res/private/login/icon_cjzy_07_1.png")
	GUI:setContentSize(Button_job_4, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_4, false)
	GUI:Button_setTitleText(Button_job_4, [[]])
	GUI:Button_setTitleColor(Button_job_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_4, 10)
	GUI:Button_titleEnableOutline(Button_job_4, "#000000", 1)
	GUI:setChineseName(Button_job_4, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_4, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_4, true)
	GUI:setTag(Button_job_4, -1)
	GUI:setVisible(Button_job_4, false)

	-- Create Button_job_5
	local Button_job_5 = GUI:Button_Create(Panel_info, "Button_job_5", 275, 210, "res/private/login/icon_zdyzy_05.png")
	GUI:Button_loadTextureDisabled(Button_job_5, "res/private/login/icon_cjzy_05_1.png")
	GUI:setContentSize(Button_job_5, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_5, false)
	GUI:Button_setTitleText(Button_job_5, [[]])
	GUI:Button_setTitleColor(Button_job_5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_5, 10)
	GUI:Button_titleEnableOutline(Button_job_5, "#000000", 1)
	GUI:setChineseName(Button_job_5, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_5, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_5, true)
	GUI:setTag(Button_job_5, -1)
	GUI:setVisible(Button_job_5, false)

	-- Create Button_job_6
	local Button_job_6 = GUI:Button_Create(Panel_info, "Button_job_6", 281, 210, "res/private/login/icon_zdyzy_06.png")
	GUI:Button_loadTextureDisabled(Button_job_6, "res/private/login/icon_zdyzy_06_1.png")
	GUI:setContentSize(Button_job_6, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_6, false)
	GUI:Button_setTitleText(Button_job_6, [[]])
	GUI:Button_setTitleColor(Button_job_6, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_6, 10)
	GUI:Button_titleEnableOutline(Button_job_6, "#000000", 1)
	GUI:setChineseName(Button_job_6, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_6, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_6, true)
	GUI:setTag(Button_job_6, -1)
	GUI:setVisible(Button_job_6, false)

	-- Create Button_job_7
	local Button_job_7 = GUI:Button_Create(Panel_info, "Button_job_7", 288, 210, "res/private/login/icon_zdyzy_07.png")
	GUI:Button_loadTextureDisabled(Button_job_7, "res/private/login/icon_zdyzy_07_1.png")
	GUI:setContentSize(Button_job_7, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_7, false)
	GUI:Button_setTitleText(Button_job_7, [[]])
	GUI:Button_setTitleColor(Button_job_7, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_7, 10)
	GUI:Button_titleEnableOutline(Button_job_7, "#000000", 1)
	GUI:setChineseName(Button_job_7, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_7, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_7, true)
	GUI:setTag(Button_job_7, -1)
	GUI:setVisible(Button_job_7, false)

	-- Create Button_job_8
	local Button_job_8 = GUI:Button_Create(Panel_info, "Button_job_8", 295, 210, "res/private/login/icon_zdyzy_08.png")
	GUI:Button_loadTextureDisabled(Button_job_8, "res/private/login/icon_zdyzy_08_1.png")
	GUI:setContentSize(Button_job_8, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_8, false)
	GUI:Button_setTitleText(Button_job_8, [[]])
	GUI:Button_setTitleColor(Button_job_8, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_8, 10)
	GUI:Button_titleEnableOutline(Button_job_8, "#000000", 1)
	GUI:setChineseName(Button_job_8, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_8, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_8, true)
	GUI:setTag(Button_job_8, -1)
	GUI:setVisible(Button_job_8, false)

	-- Create Button_job_9
	local Button_job_9 = GUI:Button_Create(Panel_info, "Button_job_9", 301, 210, "res/private/login/icon_zdyzy_09.png")
	GUI:Button_loadTextureDisabled(Button_job_9, "res/private/login/icon_zdyzy_09_1.png")
	GUI:setContentSize(Button_job_9, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_9, false)
	GUI:Button_setTitleText(Button_job_9, [[]])
	GUI:Button_setTitleColor(Button_job_9, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_9, 10)
	GUI:Button_titleEnableOutline(Button_job_9, "#000000", 1)
	GUI:setChineseName(Button_job_9, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_9, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_9, true)
	GUI:setTag(Button_job_9, -1)
	GUI:setVisible(Button_job_9, false)

	-- Create Button_job_10
	local Button_job_10 = GUI:Button_Create(Panel_info, "Button_job_10", 275, 170, "res/private/login/icon_zdyzy_10.png")
	GUI:Button_loadTextureDisabled(Button_job_10, "res/private/login/icon_zdyzy_10_1.png")
	GUI:setContentSize(Button_job_10, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_10, false)
	GUI:Button_setTitleText(Button_job_10, [[]])
	GUI:Button_setTitleColor(Button_job_10, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_10, 10)
	GUI:Button_titleEnableOutline(Button_job_10, "#000000", 1)
	GUI:setChineseName(Button_job_10, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_10, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_10, true)
	GUI:setTag(Button_job_10, -1)
	GUI:setVisible(Button_job_10, false)

	-- Create Button_job_11
	local Button_job_11 = GUI:Button_Create(Panel_info, "Button_job_11", 281, 170, "res/private/login/icon_zdyzy_11.png")
	GUI:Button_loadTextureDisabled(Button_job_11, "res/private/login/icon_zdyzy_11_1.png")
	GUI:setContentSize(Button_job_11, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_11, false)
	GUI:Button_setTitleText(Button_job_11, [[]])
	GUI:Button_setTitleColor(Button_job_11, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_11, 10)
	GUI:Button_titleEnableOutline(Button_job_11, "#000000", 1)
	GUI:setChineseName(Button_job_11, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_11, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_11, true)
	GUI:setTag(Button_job_11, -1)
	GUI:setVisible(Button_job_11, false)

	-- Create Button_job_12
	local Button_job_12 = GUI:Button_Create(Panel_info, "Button_job_12", 287, 170, "res/private/login/icon_zdyzy_12.png")
	GUI:Button_loadTextureDisabled(Button_job_12, "res/private/login/icon_zdyzy_12_1.png")
	GUI:setContentSize(Button_job_12, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_12, false)
	GUI:Button_setTitleText(Button_job_12, [[]])
	GUI:Button_setTitleColor(Button_job_12, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_12, 10)
	GUI:Button_titleEnableOutline(Button_job_12, "#000000", 1)
	GUI:setChineseName(Button_job_12, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_12, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_12, true)
	GUI:setTag(Button_job_12, -1)
	GUI:setVisible(Button_job_12, false)

	-- Create Button_job_13
	local Button_job_13 = GUI:Button_Create(Panel_info, "Button_job_13", 294, 170, "res/private/login/icon_zdyzy_13.png")
	GUI:Button_loadTextureDisabled(Button_job_13, "res/private/login/icon_zdyzy_13_1.png")
	GUI:setContentSize(Button_job_13, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_13, false)
	GUI:Button_setTitleText(Button_job_13, [[]])
	GUI:Button_setTitleColor(Button_job_13, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_13, 10)
	GUI:Button_titleEnableOutline(Button_job_13, "#000000", 1)
	GUI:setChineseName(Button_job_13, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_13, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_13, true)
	GUI:setTag(Button_job_13, -1)
	GUI:setVisible(Button_job_13, false)

	-- Create Button_job_14
	local Button_job_14 = GUI:Button_Create(Panel_info, "Button_job_14", 300, 170, "res/private/login/icon_zdyzy_14.png")
	GUI:Button_loadTextureDisabled(Button_job_14, "res/private/login/icon_zdyzy_14_1.png")
	GUI:setContentSize(Button_job_14, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_14, false)
	GUI:Button_setTitleText(Button_job_14, [[]])
	GUI:Button_setTitleColor(Button_job_14, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_14, 10)
	GUI:Button_titleEnableOutline(Button_job_14, "#000000", 1)
	GUI:setChineseName(Button_job_14, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_14, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_14, true)
	GUI:setTag(Button_job_14, -1)
	GUI:setVisible(Button_job_14, false)

	-- Create Button_job_15
	local Button_job_15 = GUI:Button_Create(Panel_info, "Button_job_15", 306, 170, "res/private/login/icon_zdyzy_15.png")
	GUI:Button_loadTextureDisabled(Button_job_15, "res/private/login/icon_zdyzy_15_1.png")
	GUI:setContentSize(Button_job_15, 64, 54)
	GUI:setIgnoreContentAdaptWithSize(Button_job_15, false)
	GUI:Button_setTitleText(Button_job_15, [[]])
	GUI:Button_setTitleColor(Button_job_15, "#ffffff")
	GUI:Button_setTitleFontSize(Button_job_15, 10)
	GUI:Button_titleEnableOutline(Button_job_15, "#000000", 1)
	GUI:setChineseName(Button_job_15, "创建角色_职业_待定_按钮")
	GUI:setAnchorPoint(Button_job_15, 0.50, 0.50)
	GUI:setTouchEnabled(Button_job_15, true)
	GUI:setTag(Button_job_15, -1)
	GUI:setVisible(Button_job_15, false)

	-- Create Image_7_0_0
	local Image_7_0_0 = GUI:Image_Create(Panel_info, "Image_7_0_0", 157, 150, "res/private/login/word_cjzy_03.png")
	GUI:setChineseName(Image_7_0_0, "创建角色_性别文字_图片")
	GUI:setAnchorPoint(Image_7_0_0, 0.50, 0.50)
	GUI:setTouchEnabled(Image_7_0_0, false)
	GUI:setTag(Image_7_0_0, -1)
	GUI:setVisible(Image_7_0_0, false)

	-- Create Button_sex_1
	local Button_sex_1 = GUI:Button_Create(Panel_info, "Button_sex_1", 78, 48, "res/private/login/icon_cjzy_06.png")
	GUI:Button_loadTextureDisabled(Button_sex_1, "res/private/login/icon_cjzy_06_1.png")
	GUI:setContentSize(Button_sex_1, 56, 52)
	GUI:setIgnoreContentAdaptWithSize(Button_sex_1, false)
	GUI:Button_setTitleText(Button_sex_1, [[]])
	GUI:Button_setTitleColor(Button_sex_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_sex_1, 10)
	GUI:Button_titleEnableOutline(Button_sex_1, "#000000", 1)
	GUI:setChineseName(Button_sex_1, "创建角色_性别_男_按钮")
	GUI:setAnchorPoint(Button_sex_1, 0.50, 0.50)
	GUI:setTouchEnabled(Button_sex_1, true)
	GUI:setTag(Button_sex_1, -1)

	-- Create Button_sex_2
	local Button_sex_2 = GUI:Button_Create(Panel_info, "Button_sex_2", 148, 48, "res/private/login/icon_cjzy_05.png")
	GUI:Button_loadTextureDisabled(Button_sex_2, "res/private/login/icon_cjzy_05_1.png")
	GUI:setContentSize(Button_sex_2, 56, 52)
	GUI:setIgnoreContentAdaptWithSize(Button_sex_2, false)
	GUI:Button_setTitleText(Button_sex_2, [[]])
	GUI:Button_setTitleColor(Button_sex_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_sex_2, 10)
	GUI:Button_titleEnableOutline(Button_sex_2, "#000000", 1)
	GUI:setChineseName(Button_sex_2, "创建角色_性别_女_按钮")
	GUI:setAnchorPoint(Button_sex_2, 0.50, 0.50)
	GUI:setTouchEnabled(Button_sex_2, true)
	GUI:setTag(Button_sex_2, -1)

	-- Create Button_submit
	local Button_submit = GUI:Button_Create(Panel_info, "Button_submit", 274, 48, "res/private/login/btn_fhyx_01.png")
	GUI:Button_loadTexturePressed(Button_submit, "res/private/login/btn_fhyx_01_1.png")
	GUI:setContentSize(Button_submit, 100, 43)
	GUI:setIgnoreContentAdaptWithSize(Button_submit, false)
	GUI:Button_setTitleText(Button_submit, [[提 交]])
	GUI:Button_setTitleColor(Button_submit, "#ffffff")
	GUI:Button_setTitleFontSize(Button_submit, 14)
	GUI:Button_titleEnableOutline(Button_submit, "#000000", 1)
	GUI:setChineseName(Button_submit, "创建角色_提交_按钮")
	GUI:setAnchorPoint(Button_submit, 0.50, 0.50)
	GUI:setTouchEnabled(Button_submit, true)
	GUI:setTag(Button_submit, -1)

	-- Create job_node
	local job_node = GUI:Node_Create(Panel_info, "job_node", 0, 0)
	GUI:setTag(job_node, 0)

	-- Create iconBtnList0
	local iconBtnList0 = GUI:ListView_Create(job_node, "iconBtnList0", 106, 298, 220, 58, 2)
	GUI:ListView_setClippingEnabled(iconBtnList0, false)
	GUI:ListView_setGravity(iconBtnList0, 3)
	GUI:ListView_setItemsMargin(iconBtnList0, 20)
	GUI:setAnchorPoint(iconBtnList0, 0.00, 0.00)
	GUI:setTouchEnabled(iconBtnList0, true)
	GUI:setTag(iconBtnList0, 0)

	-- Create jobBtn_0_1
	local jobBtn_0_1 = GUI:Button_Create(iconBtnList0, "jobBtn_0_1", 0, 0, "res/custom/npc/111zhibo/job_0_1_0.png")
	GUI:setContentSize(jobBtn_0_1, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(jobBtn_0_1, false)
	GUI:Button_setTitleText(jobBtn_0_1, [[]])
	GUI:Button_setTitleColor(jobBtn_0_1, "#ffffff")
	GUI:Button_setTitleFontSize(jobBtn_0_1, 16)
	GUI:Button_titleEnableOutline(jobBtn_0_1, "#000000", 1)
	GUI:setAnchorPoint(jobBtn_0_1, 0.00, 0.00)
	GUI:setTouchEnabled(jobBtn_0_1, true)
	GUI:setTag(jobBtn_0_1, 0)

	-- Create jobText_0_1
	local jobText_0_1 = GUI:Text_Create(jobBtn_0_1, "jobText_0_1", 30, -10, 16, "#00ff00", [[狂战]])
	GUI:Text_enableOutline(jobText_0_1, "#000000", 1)
	GUI:setAnchorPoint(jobText_0_1, 0.50, 0.50)
	GUI:setTouchEnabled(jobText_0_1, false)
	GUI:setTag(jobText_0_1, 0)

	-- Create jobBtn_0_2
	local jobBtn_0_2 = GUI:Button_Create(iconBtnList0, "jobBtn_0_2", 78, 0, "res/custom/npc/111zhibo/job_0_1_0.png")
	GUI:setContentSize(jobBtn_0_2, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(jobBtn_0_2, false)
	GUI:Button_setTitleText(jobBtn_0_2, [[]])
	GUI:Button_setTitleColor(jobBtn_0_2, "#ffffff")
	GUI:Button_setTitleFontSize(jobBtn_0_2, 16)
	GUI:Button_titleEnableOutline(jobBtn_0_2, "#000000", 1)
	GUI:setAnchorPoint(jobBtn_0_2, 0.00, 0.00)
	GUI:setTouchEnabled(jobBtn_0_2, true)
	GUI:setTag(jobBtn_0_2, 0)

	-- Create jobText_0_2
	local jobText_0_2 = GUI:Text_Create(jobBtn_0_2, "jobText_0_2", 30, -10, 16, "#ffffff", [[霸刀]])
	GUI:Text_enableOutline(jobText_0_2, "#000000", 1)
	GUI:setAnchorPoint(jobText_0_2, 0.50, 0.50)
	GUI:setTouchEnabled(jobText_0_2, false)
	GUI:setTag(jobText_0_2, 0)

	-- Create jobBtn_0_3
	local jobBtn_0_3 = GUI:Button_Create(iconBtnList0, "jobBtn_0_3", 156, 0, "res/custom/npc/111zhibo/job_0_1_0.png")
	GUI:setContentSize(jobBtn_0_3, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(jobBtn_0_3, false)
	GUI:Button_setTitleText(jobBtn_0_3, [[]])
	GUI:Button_setTitleColor(jobBtn_0_3, "#ffffff")
	GUI:Button_setTitleFontSize(jobBtn_0_3, 16)
	GUI:Button_titleEnableOutline(jobBtn_0_3, "#000000", 1)
	GUI:setAnchorPoint(jobBtn_0_3, 0.00, 0.00)
	GUI:setTouchEnabled(jobBtn_0_3, true)
	GUI:setTag(jobBtn_0_3, 0)

	-- Create jobText_0_3
	local jobText_0_3 = GUI:Text_Create(jobBtn_0_3, "jobText_0_3", 30, -10, 16, "#ffffff", [[剑宗]])
	GUI:Text_enableOutline(jobText_0_3, "#000000", 1)
	GUI:setAnchorPoint(jobText_0_3, 0.50, 0.50)
	GUI:setTouchEnabled(jobText_0_3, false)
	GUI:setTag(jobText_0_3, 0)

	-- Create iconBtnList1
	local iconBtnList1 = GUI:ListView_Create(job_node, "iconBtnList1", 106, 216, 220, 58, 2)
	GUI:ListView_setClippingEnabled(iconBtnList1, false)
	GUI:ListView_setGravity(iconBtnList1, 3)
	GUI:ListView_setItemsMargin(iconBtnList1, 20)
	GUI:setAnchorPoint(iconBtnList1, 0.00, 0.00)
	GUI:setTouchEnabled(iconBtnList1, true)
	GUI:setTag(iconBtnList1, 0)

	-- Create jobBtn_1_1
	local jobBtn_1_1 = GUI:Button_Create(iconBtnList1, "jobBtn_1_1", 0, 0, "res/custom/npc/111zhibo/job_0_1_0.png")
	GUI:setContentSize(jobBtn_1_1, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(jobBtn_1_1, false)
	GUI:Button_setTitleText(jobBtn_1_1, [[]])
	GUI:Button_setTitleColor(jobBtn_1_1, "#ffffff")
	GUI:Button_setTitleFontSize(jobBtn_1_1, 16)
	GUI:Button_titleEnableOutline(jobBtn_1_1, "#000000", 1)
	GUI:setAnchorPoint(jobBtn_1_1, 0.00, 0.00)
	GUI:setTouchEnabled(jobBtn_1_1, true)
	GUI:setTag(jobBtn_1_1, 0)

	-- Create jobText_1_1
	local jobText_1_1 = GUI:Text_Create(jobBtn_1_1, "jobText_1_1", 30, -10, 16, "#ffffff", [[法魂]])
	GUI:Text_enableOutline(jobText_1_1, "#000000", 1)
	GUI:setAnchorPoint(jobText_1_1, 0.50, 0.50)
	GUI:setTouchEnabled(jobText_1_1, false)
	GUI:setTag(jobText_1_1, 0)

	-- Create jobBtn_1_2
	local jobBtn_1_2 = GUI:Button_Create(iconBtnList1, "jobBtn_1_2", 78, 0, "res/custom/npc/111zhibo/job_0_1_0.png")
	GUI:setContentSize(jobBtn_1_2, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(jobBtn_1_2, false)
	GUI:Button_setTitleText(jobBtn_1_2, [[]])
	GUI:Button_setTitleColor(jobBtn_1_2, "#ffffff")
	GUI:Button_setTitleFontSize(jobBtn_1_2, 16)
	GUI:Button_titleEnableOutline(jobBtn_1_2, "#000000", 1)
	GUI:setAnchorPoint(jobBtn_1_2, 0.00, 0.00)
	GUI:setTouchEnabled(jobBtn_1_2, true)
	GUI:setTag(jobBtn_1_2, 0)

	-- Create jobText_1_2
	local jobText_1_2 = GUI:Text_Create(jobBtn_1_2, "jobText_1_2", 30, -10, 16, "#ffffff", [[巫师]])
	GUI:Text_enableOutline(jobText_1_2, "#000000", 1)
	GUI:setAnchorPoint(jobText_1_2, 0.50, 0.50)
	GUI:setTouchEnabled(jobText_1_2, false)
	GUI:setTag(jobText_1_2, 0)

	-- Create jobBtn_1_3
	local jobBtn_1_3 = GUI:Button_Create(iconBtnList1, "jobBtn_1_3", 156, 0, "res/custom/npc/111zhibo/job_0_1_0.png")
	GUI:setContentSize(jobBtn_1_3, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(jobBtn_1_3, false)
	GUI:Button_setTitleText(jobBtn_1_3, [[]])
	GUI:Button_setTitleColor(jobBtn_1_3, "#ffffff")
	GUI:Button_setTitleFontSize(jobBtn_1_3, 16)
	GUI:Button_titleEnableOutline(jobBtn_1_3, "#000000", 1)
	GUI:setAnchorPoint(jobBtn_1_3, 0.00, 0.00)
	GUI:setTouchEnabled(jobBtn_1_3, true)
	GUI:setTag(jobBtn_1_3, 0)

	-- Create jobText_1_3
	local jobText_1_3 = GUI:Text_Create(jobBtn_1_3, "jobText_1_3", 30, -10, 16, "#ffffff", [[祭司]])
	GUI:Text_enableOutline(jobText_1_3, "#000000", 1)
	GUI:setAnchorPoint(jobText_1_3, 0.50, 0.50)
	GUI:setTouchEnabled(jobText_1_3, false)
	GUI:setTag(jobText_1_3, 0)

	-- Create iconBtnList2
	local iconBtnList2 = GUI:ListView_Create(job_node, "iconBtnList2", 106, 136, 220, 58, 2)
	GUI:ListView_setClippingEnabled(iconBtnList2, false)
	GUI:ListView_setGravity(iconBtnList2, 3)
	GUI:ListView_setItemsMargin(iconBtnList2, 20)
	GUI:setAnchorPoint(iconBtnList2, 0.00, 0.00)
	GUI:setTouchEnabled(iconBtnList2, true)
	GUI:setTag(iconBtnList2, 0)

	-- Create jobBtn_2_1
	local jobBtn_2_1 = GUI:Button_Create(iconBtnList2, "jobBtn_2_1", 0, 0, "res/custom/npc/111zhibo/job_0_1_0.png")
	GUI:setContentSize(jobBtn_2_1, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(jobBtn_2_1, false)
	GUI:Button_setTitleText(jobBtn_2_1, [[]])
	GUI:Button_setTitleColor(jobBtn_2_1, "#ffffff")
	GUI:Button_setTitleFontSize(jobBtn_2_1, 16)
	GUI:Button_titleEnableOutline(jobBtn_2_1, "#000000", 1)
	GUI:setAnchorPoint(jobBtn_2_1, 0.00, 0.00)
	GUI:setTouchEnabled(jobBtn_2_1, true)
	GUI:setTag(jobBtn_2_1, 0)

	-- Create jobText_2_1
	local jobText_2_1 = GUI:Text_Create(jobBtn_2_1, "jobText_2_1", 30, -10, 16, "#ffffff", [[天师]])
	GUI:Text_enableOutline(jobText_2_1, "#000000", 1)
	GUI:setAnchorPoint(jobText_2_1, 0.50, 0.50)
	GUI:setTouchEnabled(jobText_2_1, false)
	GUI:setTag(jobText_2_1, 0)

	-- Create jobBtn_2_2
	local jobBtn_2_2 = GUI:Button_Create(iconBtnList2, "jobBtn_2_2", 78, 0, "res/custom/npc/111zhibo/job_0_1_0.png")
	GUI:setContentSize(jobBtn_2_2, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(jobBtn_2_2, false)
	GUI:Button_setTitleText(jobBtn_2_2, [[]])
	GUI:Button_setTitleColor(jobBtn_2_2, "#ffffff")
	GUI:Button_setTitleFontSize(jobBtn_2_2, 16)
	GUI:Button_titleEnableOutline(jobBtn_2_2, "#000000", 1)
	GUI:setAnchorPoint(jobBtn_2_2, 0.00, 0.00)
	GUI:setTouchEnabled(jobBtn_2_2, true)
	GUI:setTag(jobBtn_2_2, 0)

	-- Create jobText_2_2
	local jobText_2_2 = GUI:Text_Create(jobBtn_2_2, "jobText_2_2", 30, -10, 16, "#ffffff", [[尊者]])
	GUI:Text_enableOutline(jobText_2_2, "#000000", 1)
	GUI:setAnchorPoint(jobText_2_2, 0.50, 0.50)
	GUI:setTouchEnabled(jobText_2_2, false)
	GUI:setTag(jobText_2_2, 0)

	-- Create jobBtn_2_3
	local jobBtn_2_3 = GUI:Button_Create(iconBtnList2, "jobBtn_2_3", 156, 0, "res/custom/npc/111zhibo/job_0_1_0.png")
	GUI:setContentSize(jobBtn_2_3, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(jobBtn_2_3, false)
	GUI:Button_setTitleText(jobBtn_2_3, [[]])
	GUI:Button_setTitleColor(jobBtn_2_3, "#ffffff")
	GUI:Button_setTitleFontSize(jobBtn_2_3, 16)
	GUI:Button_titleEnableOutline(jobBtn_2_3, "#000000", 1)
	GUI:setAnchorPoint(jobBtn_2_3, 0.00, 0.00)
	GUI:setTouchEnabled(jobBtn_2_3, true)
	GUI:setTag(jobBtn_2_3, 0)

	-- Create jobText_2_3
	local jobText_2_3 = GUI:Text_Create(jobBtn_2_3, "jobText_2_3", 30, -10, 16, "#ffffff", [[修罗]])
	GUI:Text_enableOutline(jobText_2_3, "#000000", 1)
	GUI:setAnchorPoint(jobText_2_3, 0.50, 0.50)
	GUI:setTouchEnabled(jobText_2_3, false)
	GUI:setTag(jobText_2_3, 0)

	ui.update(__data__)
	return Panel_role
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
