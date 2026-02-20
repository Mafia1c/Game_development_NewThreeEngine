local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:Layout_setBackGroundColorType(CloseLayout, 1)
	GUI:Layout_setBackGroundColor(CloseLayout, "#f8e6c6")
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 0)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/111zhibo/zyjx/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameLayout, "close_btn", 784, 493, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(close_btn, "res/custom/npc/close2.png")
	GUI:setContentSize(close_btn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(close_btn, false)
	GUI:Button_setTitleText(close_btn, [[]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleDisableOutLine(close_btn)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	-- Create leftBigList
	local leftBigList = GUI:ListView_Create(FrameLayout, "leftBigList", 71, 61, 153, 423, 1)
	GUI:ListView_setItemsMargin(leftBigList, 1)
	GUI:setAnchorPoint(leftBigList, 0.00, 0.00)
	GUI:setTouchEnabled(leftBigList, true)
	GUI:setTag(leftBigList, 0)

	-- Create leftBtn1
	local leftBtn1 = GUI:Button_Create(leftBigList, "leftBtn1", 0, 383, "res/custom/npc/111zhibo/zyjx/box.png")
	GUI:setContentSize(leftBtn1, 150, 40)
	GUI:setIgnoreContentAdaptWithSize(leftBtn1, false)
	GUI:Button_setTitleText(leftBtn1, [[战    士]])
	GUI:Button_setTitleColor(leftBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn1, 16)
	GUI:Button_titleEnableOutline(leftBtn1, "#000000", 1)
	GUI:setAnchorPoint(leftBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn1, true)
	GUI:setTag(leftBtn1, 0)

	-- Create leftList1
	local leftList1 = GUI:ListView_Create(leftBigList, "leftList1", 0, 82, 153, 150, 1)
	GUI:ListView_setItemsMargin(leftList1, 4)
	GUI:setAnchorPoint(leftList1, 0.00, 1.00)
	GUI:setTouchEnabled(leftList1, true)
	GUI:setTag(leftList1, 0)

	-- Create typeBtn11
	local typeBtn11 = GUI:Button_Create(leftList1, "typeBtn11", 0, 103, "res/custom/npc/111zhibo/zyjx/job_0_1_0.png")
	GUI:setContentSize(typeBtn11, 153, 47)
	GUI:setIgnoreContentAdaptWithSize(typeBtn11, false)
	GUI:Button_setTitleText(typeBtn11, [[]])
	GUI:Button_setTitleColor(typeBtn11, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn11, 16)
	GUI:Button_titleEnableOutline(typeBtn11, "#000000", 1)
	GUI:setAnchorPoint(typeBtn11, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn11, true)
	GUI:setTag(typeBtn11, 0)

	-- Create leftTag
	local leftTag = GUI:Image_Create(typeBtn11, "leftTag", 0, 0, "res/custom/tag/jihuo02.png")
	GUI:setAnchorPoint(leftTag, 0.00, 0.00)
	GUI:setTouchEnabled(leftTag, false)
	GUI:setTag(leftTag, 0)

	-- Create typeBtn12
	local typeBtn12 = GUI:Button_Create(leftList1, "typeBtn12", 0, 52, "res/custom/npc/111zhibo/zyjx/job_0_1_0.png")
	GUI:setContentSize(typeBtn12, 153, 47)
	GUI:setIgnoreContentAdaptWithSize(typeBtn12, false)
	GUI:Button_setTitleText(typeBtn12, [[]])
	GUI:Button_setTitleColor(typeBtn12, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn12, 16)
	GUI:Button_titleEnableOutline(typeBtn12, "#000000", 1)
	GUI:setAnchorPoint(typeBtn12, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn12, true)
	GUI:setTag(typeBtn12, 0)

	-- Create typeBtn13
	local typeBtn13 = GUI:Button_Create(leftList1, "typeBtn13", 0, 1, "res/custom/npc/111zhibo/zyjx/job_0_1_0.png")
	GUI:setContentSize(typeBtn13, 153, 47)
	GUI:setIgnoreContentAdaptWithSize(typeBtn13, false)
	GUI:Button_setTitleText(typeBtn13, [[]])
	GUI:Button_setTitleColor(typeBtn13, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn13, 16)
	GUI:Button_titleEnableOutline(typeBtn13, "#000000", 1)
	GUI:setAnchorPoint(typeBtn13, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn13, true)
	GUI:setTag(typeBtn13, 0)

	-- Create leftBtn2
	local leftBtn2 = GUI:Button_Create(leftBigList, "leftBtn2", 0, 191, "res/custom/npc/111zhibo/zyjx/box.png")
	GUI:setContentSize(leftBtn2, 150, 40)
	GUI:setIgnoreContentAdaptWithSize(leftBtn2, false)
	GUI:Button_setTitleText(leftBtn2, [[法    师]])
	GUI:Button_setTitleColor(leftBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn2, 16)
	GUI:Button_titleEnableOutline(leftBtn2, "#000000", 1)
	GUI:setAnchorPoint(leftBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn2, true)
	GUI:setTag(leftBtn2, 0)

	-- Create leftList2
	local leftList2 = GUI:ListView_Create(leftBigList, "leftList2", 0, 190, 153, 0, 1)
	GUI:ListView_setItemsMargin(leftList2, 4)
	GUI:setAnchorPoint(leftList2, 0.00, 1.00)
	GUI:setTouchEnabled(leftList2, true)
	GUI:setTag(leftList2, 0)

	-- Create typeBtn21
	local typeBtn21 = GUI:Button_Create(leftList2, "typeBtn21", 0, -47, "res/custom/npc/111zhibo/zyjx/job_0_1_0.png")
	GUI:setContentSize(typeBtn21, 153, 47)
	GUI:setIgnoreContentAdaptWithSize(typeBtn21, false)
	GUI:Button_setTitleText(typeBtn21, [[]])
	GUI:Button_setTitleColor(typeBtn21, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn21, 16)
	GUI:Button_titleEnableOutline(typeBtn21, "#000000", 1)
	GUI:setAnchorPoint(typeBtn21, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn21, true)
	GUI:setTag(typeBtn21, 0)

	-- Create typeBtn22
	local typeBtn22 = GUI:Button_Create(leftList2, "typeBtn22", 0, -98, "res/custom/npc/111zhibo/zyjx/job_0_1_0.png")
	GUI:setContentSize(typeBtn22, 153, 47)
	GUI:setIgnoreContentAdaptWithSize(typeBtn22, false)
	GUI:Button_setTitleText(typeBtn22, [[]])
	GUI:Button_setTitleColor(typeBtn22, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn22, 16)
	GUI:Button_titleEnableOutline(typeBtn22, "#000000", 1)
	GUI:setAnchorPoint(typeBtn22, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn22, true)
	GUI:setTag(typeBtn22, 0)

	-- Create typeBtn23
	local typeBtn23 = GUI:Button_Create(leftList2, "typeBtn23", 0, -149, "res/custom/npc/111zhibo/zyjx/job_0_1_0.png")
	GUI:setContentSize(typeBtn23, 153, 47)
	GUI:setIgnoreContentAdaptWithSize(typeBtn23, false)
	GUI:Button_setTitleText(typeBtn23, [[]])
	GUI:Button_setTitleColor(typeBtn23, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn23, 16)
	GUI:Button_titleEnableOutline(typeBtn23, "#000000", 1)
	GUI:setAnchorPoint(typeBtn23, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn23, true)
	GUI:setTag(typeBtn23, 0)

	-- Create leftBtn3
	local leftBtn3 = GUI:Button_Create(leftBigList, "leftBtn3", 0, 149, "res/custom/npc/111zhibo/zyjx/box.png")
	GUI:setContentSize(leftBtn3, 150, 40)
	GUI:setIgnoreContentAdaptWithSize(leftBtn3, false)
	GUI:Button_setTitleText(leftBtn3, [[道    士]])
	GUI:Button_setTitleColor(leftBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn3, 16)
	GUI:Button_titleEnableOutline(leftBtn3, "#000000", 1)
	GUI:setAnchorPoint(leftBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn3, true)
	GUI:setTag(leftBtn3, 0)

	-- Create leftList3
	local leftList3 = GUI:ListView_Create(leftBigList, "leftList3", 0, 148, 153, 0, 1)
	GUI:ListView_setItemsMargin(leftList3, 4)
	GUI:setAnchorPoint(leftList3, 0.00, 1.00)
	GUI:setTouchEnabled(leftList3, true)
	GUI:setTag(leftList3, 0)

	-- Create typeBtn31
	local typeBtn31 = GUI:Button_Create(leftList3, "typeBtn31", 0, -47, "res/custom/npc/111zhibo/zyjx/job_0_1_0.png")
	GUI:setContentSize(typeBtn31, 153, 47)
	GUI:setIgnoreContentAdaptWithSize(typeBtn31, false)
	GUI:Button_setTitleText(typeBtn31, [[]])
	GUI:Button_setTitleColor(typeBtn31, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn31, 16)
	GUI:Button_titleEnableOutline(typeBtn31, "#000000", 1)
	GUI:setAnchorPoint(typeBtn31, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn31, true)
	GUI:setTag(typeBtn31, 0)

	-- Create typeBtn32
	local typeBtn32 = GUI:Button_Create(leftList3, "typeBtn32", 0, -98, "res/custom/npc/111zhibo/zyjx/job_0_1_0.png")
	GUI:setContentSize(typeBtn32, 153, 47)
	GUI:setIgnoreContentAdaptWithSize(typeBtn32, false)
	GUI:Button_setTitleText(typeBtn32, [[]])
	GUI:Button_setTitleColor(typeBtn32, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn32, 16)
	GUI:Button_titleEnableOutline(typeBtn32, "#000000", 1)
	GUI:setAnchorPoint(typeBtn32, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn32, true)
	GUI:setTag(typeBtn32, 0)

	-- Create typeBtn33
	local typeBtn33 = GUI:Button_Create(leftList3, "typeBtn33", 0, -149, "res/custom/npc/111zhibo/zyjx/job_0_1_0.png")
	GUI:setContentSize(typeBtn33, 153, 47)
	GUI:setIgnoreContentAdaptWithSize(typeBtn33, false)
	GUI:Button_setTitleText(typeBtn33, [[]])
	GUI:Button_setTitleColor(typeBtn33, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn33, 16)
	GUI:Button_titleEnableOutline(typeBtn33, "#000000", 1)
	GUI:setAnchorPoint(typeBtn33, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn33, true)
	GUI:setTag(typeBtn33, 0)

	-- Create effect_root
	local effect_root = GUI:Layout_Create(FrameLayout, "effect_root", 226, 180, 360, 305, false)
	GUI:setAnchorPoint(effect_root, 0.00, 0.00)
	GUI:setTouchEnabled(effect_root, false)
	GUI:setTag(effect_root, 0)

	-- Create skillBg
	local skillBg = GUI:Image_Create(FrameLayout, "skillBg", 547, 336, "res/custom/npc/11zzjx/t.png")
	GUI:setAnchorPoint(skillBg, 0.00, 0.00)
	GUI:setTouchEnabled(skillBg, false)
	GUI:setTag(skillBg, 0)

	-- Create job_name_img
	local job_name_img = GUI:Image_Create(skillBg, "job_name_img", 19, 68, "res/custom/npc/11zzjx/0/1/z1.png")
	GUI:setAnchorPoint(job_name_img, 0.50, 0.50)
	GUI:setTouchEnabled(job_name_img, false)
	GUI:setTag(job_name_img, 0)

	-- Create infoImg
	local infoImg = GUI:Image_Create(FrameLayout, "infoImg", 408, 114, "res/custom/npc/111zhibo/job_info/img_0_11.png")
	GUI:setContentSize(infoImg, 352, 96)
	GUI:setIgnoreContentAdaptWithSize(infoImg, false)
	GUI:setAnchorPoint(infoImg, 0.50, 0.50)
	GUI:setTouchEnabled(infoImg, false)
	GUI:setTag(infoImg, 0)

	-- Create skillList
	local skillList = GUI:ListView_Create(FrameLayout, "skillList", 612, 55, 68, 414, 1)
	GUI:ListView_setClippingEnabled(skillList, false)
	GUI:ListView_setItemsMargin(skillList, 10)
	GUI:setAnchorPoint(skillList, 0.00, 0.00)
	GUI:setTouchEnabled(skillList, true)
	GUI:setTag(skillList, 0)

	-- Create awake_skill_btn1
	local awake_skill_btn1 = GUI:Button_Create(skillList, "awake_skill_btn1", 0, 342, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:setContentSize(awake_skill_btn1, 68, 72)
	GUI:setIgnoreContentAdaptWithSize(awake_skill_btn1, false)
	GUI:Button_setTitleText(awake_skill_btn1, [[]])
	GUI:Button_setTitleColor(awake_skill_btn1, "#ffffff")
	GUI:Button_setTitleFontSize(awake_skill_btn1, 16)
	GUI:Button_titleDisableOutLine(awake_skill_btn1)
	GUI:setAnchorPoint(awake_skill_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(awake_skill_btn1, true)
	GUI:setTag(awake_skill_btn1, 0)

	-- Create skill_active_flag1
	local skill_active_flag1 = GUI:Image_Create(awake_skill_btn1, "skill_active_flag1", 34, 42, "res/custom/npc/11zzjx/jk.png")
	GUI:setAnchorPoint(skill_active_flag1, 0.50, 0.50)
	GUI:setTouchEnabled(skill_active_flag1, false)
	GUI:setTag(skill_active_flag1, 0)
	GUI:setVisible(skill_active_flag1, false)

	-- Create needText1
	local needText1 = GUI:Text_Create(awake_skill_btn1, "needText1", 126, 56, 16, "#ffffff", [[书页：1000]])
	GUI:Text_enableOutline(needText1, "#000000", 1)
	GUI:setAnchorPoint(needText1, 0.50, 0.50)
	GUI:setTouchEnabled(needText1, false)
	GUI:setTag(needText1, 0)

	-- Create awake_btn1
	local awake_btn1 = GUI:Button_Create(awake_skill_btn1, "awake_btn1", 126, 27, "res/custom/npc/111zhibo/zyjx/upBtn2.png")
	GUI:Button_loadTexturePressed(awake_btn1, "res/custom/npc/111zhibo/zyjx/upBtn1.png")
	GUI:Button_setScale9Slice(awake_btn1, 6, 6, 10, 10)
	GUI:setContentSize(awake_btn1, 67, 32)
	GUI:setIgnoreContentAdaptWithSize(awake_btn1, false)
	GUI:Button_setTitleText(awake_btn1, [[]])
	GUI:Button_setTitleColor(awake_btn1, "#E8DCBD")
	GUI:Button_setTitleFontSize(awake_btn1, 18)
	GUI:Button_titleEnableOutline(awake_btn1, "#000000", 1)
	GUI:setAnchorPoint(awake_btn1, 0.50, 0.50)
	GUI:setTouchEnabled(awake_btn1, true)
	GUI:setTag(awake_btn1, 0)

	-- Create has_awake1
	local has_awake1 = GUI:Image_Create(awake_skill_btn1, "has_awake1", 86, 12, "res/custom/npc/11zzjx/yjx.png")
	GUI:Image_setScale9Slice(has_awake1, 0, 0, 0, 0)
	GUI:setContentSize(has_awake1, 80, 30)
	GUI:setIgnoreContentAdaptWithSize(has_awake1, false)
	GUI:setAnchorPoint(has_awake1, 0.00, 0.00)
	GUI:setTouchEnabled(has_awake1, false)
	GUI:setTag(has_awake1, 0)
	GUI:setVisible(has_awake1, false)

	-- Create awake_skill_btn2
	local awake_skill_btn2 = GUI:Button_Create(skillList, "awake_skill_btn2", 0, 260, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:setContentSize(awake_skill_btn2, 68, 72)
	GUI:setIgnoreContentAdaptWithSize(awake_skill_btn2, false)
	GUI:Button_setTitleText(awake_skill_btn2, [[]])
	GUI:Button_setTitleColor(awake_skill_btn2, "#ffffff")
	GUI:Button_setTitleFontSize(awake_skill_btn2, 16)
	GUI:Button_titleDisableOutLine(awake_skill_btn2)
	GUI:setAnchorPoint(awake_skill_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(awake_skill_btn2, true)
	GUI:setTag(awake_skill_btn2, 0)

	-- Create skill_active_flag2
	local skill_active_flag2 = GUI:Image_Create(awake_skill_btn2, "skill_active_flag2", 34, 42, "res/custom/npc/11zzjx/jk.png")
	GUI:setAnchorPoint(skill_active_flag2, 0.50, 0.50)
	GUI:setTouchEnabled(skill_active_flag2, false)
	GUI:setTag(skill_active_flag2, 0)
	GUI:setVisible(skill_active_flag2, false)

	-- Create needText2
	local needText2 = GUI:Text_Create(awake_skill_btn2, "needText2", 126, 56, 16, "#ffffff", [[书页：1000]])
	GUI:Text_enableOutline(needText2, "#000000", 1)
	GUI:setAnchorPoint(needText2, 0.50, 0.50)
	GUI:setTouchEnabled(needText2, false)
	GUI:setTag(needText2, 0)

	-- Create awake_btn2
	local awake_btn2 = GUI:Button_Create(awake_skill_btn2, "awake_btn2", 126, 27, "res/custom/npc/111zhibo/zyjx/upBtn2.png")
	GUI:Button_loadTexturePressed(awake_btn2, "res/custom/npc/111zhibo/zyjx/upBtn1.png")
	GUI:Button_setScale9Slice(awake_btn2, 6, 6, 10, 10)
	GUI:setContentSize(awake_btn2, 67, 32)
	GUI:setIgnoreContentAdaptWithSize(awake_btn2, false)
	GUI:Button_setTitleText(awake_btn2, [[]])
	GUI:Button_setTitleColor(awake_btn2, "#E8DCBD")
	GUI:Button_setTitleFontSize(awake_btn2, 18)
	GUI:Button_titleEnableOutline(awake_btn2, "#000000", 1)
	GUI:setAnchorPoint(awake_btn2, 0.50, 0.50)
	GUI:setTouchEnabled(awake_btn2, true)
	GUI:setTag(awake_btn2, 0)

	-- Create has_awake2
	local has_awake2 = GUI:Image_Create(awake_skill_btn2, "has_awake2", 86, 12, "res/custom/npc/11zzjx/yjx.png")
	GUI:Image_setScale9Slice(has_awake2, 0, 0, 0, 0)
	GUI:setContentSize(has_awake2, 80, 30)
	GUI:setIgnoreContentAdaptWithSize(has_awake2, false)
	GUI:setAnchorPoint(has_awake2, 0.00, 0.00)
	GUI:setTouchEnabled(has_awake2, false)
	GUI:setTag(has_awake2, 0)
	GUI:setVisible(has_awake2, false)

	-- Create awake_skill_btn3
	local awake_skill_btn3 = GUI:Button_Create(skillList, "awake_skill_btn3", 0, 178, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:setContentSize(awake_skill_btn3, 68, 72)
	GUI:setIgnoreContentAdaptWithSize(awake_skill_btn3, false)
	GUI:Button_setTitleText(awake_skill_btn3, [[]])
	GUI:Button_setTitleColor(awake_skill_btn3, "#ffffff")
	GUI:Button_setTitleFontSize(awake_skill_btn3, 16)
	GUI:Button_titleDisableOutLine(awake_skill_btn3)
	GUI:setAnchorPoint(awake_skill_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(awake_skill_btn3, true)
	GUI:setTag(awake_skill_btn3, 0)

	-- Create skill_active_flag3
	local skill_active_flag3 = GUI:Image_Create(awake_skill_btn3, "skill_active_flag3", 34, 42, "res/custom/npc/11zzjx/jk.png")
	GUI:setAnchorPoint(skill_active_flag3, 0.50, 0.50)
	GUI:setTouchEnabled(skill_active_flag3, false)
	GUI:setTag(skill_active_flag3, 0)
	GUI:setVisible(skill_active_flag3, false)

	-- Create needText3
	local needText3 = GUI:Text_Create(awake_skill_btn3, "needText3", 126, 56, 16, "#ffffff", [[书页：1000]])
	GUI:Text_enableOutline(needText3, "#000000", 1)
	GUI:setAnchorPoint(needText3, 0.50, 0.50)
	GUI:setTouchEnabled(needText3, false)
	GUI:setTag(needText3, 0)

	-- Create awake_btn3
	local awake_btn3 = GUI:Button_Create(awake_skill_btn3, "awake_btn3", 126, 27, "res/custom/npc/111zhibo/zyjx/upBtn2.png")
	GUI:Button_loadTexturePressed(awake_btn3, "res/custom/npc/111zhibo/zyjx/upBtn1.png")
	GUI:Button_setScale9Slice(awake_btn3, 6, 6, 10, 10)
	GUI:setContentSize(awake_btn3, 67, 32)
	GUI:setIgnoreContentAdaptWithSize(awake_btn3, false)
	GUI:Button_setTitleText(awake_btn3, [[]])
	GUI:Button_setTitleColor(awake_btn3, "#E8DCBD")
	GUI:Button_setTitleFontSize(awake_btn3, 18)
	GUI:Button_titleEnableOutline(awake_btn3, "#000000", 1)
	GUI:setAnchorPoint(awake_btn3, 0.50, 0.50)
	GUI:setTouchEnabled(awake_btn3, true)
	GUI:setTag(awake_btn3, 0)

	-- Create has_awake3
	local has_awake3 = GUI:Image_Create(awake_skill_btn3, "has_awake3", 86, 12, "res/custom/npc/11zzjx/yjx.png")
	GUI:Image_setScale9Slice(has_awake3, 0, 0, 0, 0)
	GUI:setContentSize(has_awake3, 80, 30)
	GUI:setIgnoreContentAdaptWithSize(has_awake3, false)
	GUI:setAnchorPoint(has_awake3, 0.00, 0.00)
	GUI:setTouchEnabled(has_awake3, false)
	GUI:setTag(has_awake3, 0)
	GUI:setVisible(has_awake3, false)

	-- Create awake_skill_btn4
	local awake_skill_btn4 = GUI:Button_Create(skillList, "awake_skill_btn4", 0, 96, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:setContentSize(awake_skill_btn4, 68, 72)
	GUI:setIgnoreContentAdaptWithSize(awake_skill_btn4, false)
	GUI:Button_setTitleText(awake_skill_btn4, [[]])
	GUI:Button_setTitleColor(awake_skill_btn4, "#ffffff")
	GUI:Button_setTitleFontSize(awake_skill_btn4, 16)
	GUI:Button_titleDisableOutLine(awake_skill_btn4)
	GUI:setAnchorPoint(awake_skill_btn4, 0.00, 0.00)
	GUI:setTouchEnabled(awake_skill_btn4, true)
	GUI:setTag(awake_skill_btn4, 0)

	-- Create skill_active_flag4
	local skill_active_flag4 = GUI:Image_Create(awake_skill_btn4, "skill_active_flag4", 34, 42, "res/custom/npc/11zzjx/jk.png")
	GUI:setAnchorPoint(skill_active_flag4, 0.50, 0.50)
	GUI:setTouchEnabled(skill_active_flag4, false)
	GUI:setTag(skill_active_flag4, 0)
	GUI:setVisible(skill_active_flag4, false)

	-- Create needText4
	local needText4 = GUI:Text_Create(awake_skill_btn4, "needText4", 126, 56, 16, "#00ff00", [[书页：1000]])
	GUI:Text_enableOutline(needText4, "#000000", 1)
	GUI:setAnchorPoint(needText4, 0.50, 0.50)
	GUI:setTouchEnabled(needText4, false)
	GUI:setTag(needText4, 0)

	-- Create awake_btn4
	local awake_btn4 = GUI:Button_Create(awake_skill_btn4, "awake_btn4", 126, 27, "res/custom/npc/111zhibo/zyjx/upBtn2.png")
	GUI:Button_loadTexturePressed(awake_btn4, "res/custom/npc/111zhibo/zyjx/upBtn1.png")
	GUI:Button_setScale9Slice(awake_btn4, 6, 6, 10, 10)
	GUI:setContentSize(awake_btn4, 67, 32)
	GUI:setIgnoreContentAdaptWithSize(awake_btn4, false)
	GUI:Button_setTitleText(awake_btn4, [[]])
	GUI:Button_setTitleColor(awake_btn4, "#E8DCBD")
	GUI:Button_setTitleFontSize(awake_btn4, 18)
	GUI:Button_titleEnableOutline(awake_btn4, "#000000", 1)
	GUI:setAnchorPoint(awake_btn4, 0.50, 0.50)
	GUI:setTouchEnabled(awake_btn4, true)
	GUI:setTag(awake_btn4, 0)

	-- Create has_awake4
	local has_awake4 = GUI:Image_Create(awake_skill_btn4, "has_awake4", 86, 12, "res/custom/npc/11zzjx/yjx.png")
	GUI:Image_setScale9Slice(has_awake4, 0, 0, 0, 0)
	GUI:setContentSize(has_awake4, 80, 30)
	GUI:setIgnoreContentAdaptWithSize(has_awake4, false)
	GUI:setAnchorPoint(has_awake4, 0.00, 0.00)
	GUI:setTouchEnabled(has_awake4, false)
	GUI:setTag(has_awake4, 0)
	GUI:setVisible(has_awake4, false)

	-- Create awake_skill_btn5
	local awake_skill_btn5 = GUI:Button_Create(skillList, "awake_skill_btn5", 0, 14, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:setContentSize(awake_skill_btn5, 68, 72)
	GUI:setIgnoreContentAdaptWithSize(awake_skill_btn5, false)
	GUI:Button_setTitleText(awake_skill_btn5, [[]])
	GUI:Button_setTitleColor(awake_skill_btn5, "#ffffff")
	GUI:Button_setTitleFontSize(awake_skill_btn5, 16)
	GUI:Button_titleDisableOutLine(awake_skill_btn5)
	GUI:setAnchorPoint(awake_skill_btn5, 0.00, 0.00)
	GUI:setTouchEnabled(awake_skill_btn5, true)
	GUI:setTag(awake_skill_btn5, 0)

	-- Create skill_active_flag5
	local skill_active_flag5 = GUI:Image_Create(awake_skill_btn5, "skill_active_flag5", 34, 42, "res/custom/npc/11zzjx/jk.png")
	GUI:setAnchorPoint(skill_active_flag5, 0.50, 0.50)
	GUI:setTouchEnabled(skill_active_flag5, false)
	GUI:setTag(skill_active_flag5, 0)
	GUI:setVisible(skill_active_flag5, false)

	-- Create needText5
	local needText5 = GUI:Text_Create(awake_skill_btn5, "needText5", 126, 56, 16, "#ffffff", [[书页：1000]])
	GUI:Text_enableOutline(needText5, "#000000", 1)
	GUI:setAnchorPoint(needText5, 0.50, 0.50)
	GUI:setTouchEnabled(needText5, false)
	GUI:setTag(needText5, 0)

	-- Create awake_btn5
	local awake_btn5 = GUI:Button_Create(awake_skill_btn5, "awake_btn5", 126, 27, "res/custom/npc/111zhibo/zyjx/upBtn2.png")
	GUI:Button_loadTexturePressed(awake_btn5, "res/custom/npc/111zhibo/zyjx/upBtn1.png")
	GUI:Button_setScale9Slice(awake_btn5, 6, 6, 10, 10)
	GUI:setContentSize(awake_btn5, 67, 32)
	GUI:setIgnoreContentAdaptWithSize(awake_btn5, false)
	GUI:Button_setTitleText(awake_btn5, [[]])
	GUI:Button_setTitleColor(awake_btn5, "#E8DCBD")
	GUI:Button_setTitleFontSize(awake_btn5, 18)
	GUI:Button_titleEnableOutline(awake_btn5, "#000000", 1)
	GUI:setAnchorPoint(awake_btn5, 0.50, 0.50)
	GUI:setTouchEnabled(awake_btn5, true)
	GUI:setTag(awake_btn5, 0)

	-- Create has_awake5
	local has_awake5 = GUI:Image_Create(awake_skill_btn5, "has_awake5", 86, 12, "res/custom/npc/11zzjx/yjx.png")
	GUI:Image_setScale9Slice(has_awake5, 0, 0, 0, 0)
	GUI:setContentSize(has_awake5, 80, 30)
	GUI:setIgnoreContentAdaptWithSize(has_awake5, false)
	GUI:setAnchorPoint(has_awake5, 0.00, 0.00)
	GUI:setTouchEnabled(has_awake5, false)
	GUI:setTag(has_awake5, 0)
	GUI:setVisible(has_awake5, false)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(FrameLayout, "RichText_2", 80, 37, [==========[<font color='#ffffff' size='16' >提示：完成转职所需的</font><font color='#00ff00' size='16' >[材料与道具]</font><font color='#ffffff' size='16' >在</font><font color='#00ff00' size='16' >[任意地图怪物]</font><font color='#ffffff' size='16' >均有几率爆出，觉醒属性依次递增！</font>]==========], 700, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
