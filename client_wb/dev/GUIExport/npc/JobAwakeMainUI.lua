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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/115job/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 83, 83, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 822, 490, "res/custom/npc/115job/close.png")
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleDisableOutLine(closeBtn)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create tagText
	local tagText = GUI:Text_Create(FrameLayout, "tagText", 123, 460, 18, "#ffffff", [[流  派]])
	GUI:Text_enableOutline(tagText, "#000000", 1)
	GUI:setAnchorPoint(tagText, 0.50, 0.50)
	GUI:setTouchEnabled(tagText, false)
	GUI:setTag(tagText, 0)

	-- Create leftBigList
	local leftBigList = GUI:ListView_Create(FrameLayout, "leftBigList", 65, 34, 116, 405, 1)
	GUI:ListView_setItemsMargin(leftBigList, 2)
	GUI:setAnchorPoint(leftBigList, 0.00, 0.00)
	GUI:setTouchEnabled(leftBigList, true)
	GUI:setTag(leftBigList, 0)

	-- Create typeBtn33
	local typeBtn33 = GUI:Button_Create(leftBigList, "typeBtn33", 0, 362, "res/custom/npc/115job/btn231.png")
	GUI:Button_setTitleText(typeBtn33, [[]])
	GUI:Button_setTitleColor(typeBtn33, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn33, 16)
	GUI:Button_titleEnableOutline(typeBtn33, "#000000", 1)
	GUI:setAnchorPoint(typeBtn33, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn33, true)
	GUI:setTag(typeBtn33, 0)

	-- Create typeBtn33_1
	local typeBtn33_1 = GUI:Button_Create(leftBigList, "typeBtn33_1", 0, 317, "res/custom/npc/115job/btn231.png")
	GUI:Button_setTitleText(typeBtn33_1, [[]])
	GUI:Button_setTitleColor(typeBtn33_1, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn33_1, 16)
	GUI:Button_titleEnableOutline(typeBtn33_1, "#000000", 1)
	GUI:setAnchorPoint(typeBtn33_1, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn33_1, true)
	GUI:setTag(typeBtn33_1, 0)

	-- Create typeBtn33_2
	local typeBtn33_2 = GUI:Button_Create(leftBigList, "typeBtn33_2", 0, 272, "res/custom/npc/115job/btn231.png")
	GUI:Button_setTitleText(typeBtn33_2, [[]])
	GUI:Button_setTitleColor(typeBtn33_2, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn33_2, 16)
	GUI:Button_titleEnableOutline(typeBtn33_2, "#000000", 1)
	GUI:setAnchorPoint(typeBtn33_2, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn33_2, true)
	GUI:setTag(typeBtn33_2, 0)

	-- Create typeBtn33_3
	local typeBtn33_3 = GUI:Button_Create(leftBigList, "typeBtn33_3", 0, 227, "res/custom/npc/115job/btn231.png")
	GUI:Button_setTitleText(typeBtn33_3, [[]])
	GUI:Button_setTitleColor(typeBtn33_3, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn33_3, 16)
	GUI:Button_titleEnableOutline(typeBtn33_3, "#000000", 1)
	GUI:setAnchorPoint(typeBtn33_3, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn33_3, true)
	GUI:setTag(typeBtn33_3, 0)

	-- Create typeBtn33_4
	local typeBtn33_4 = GUI:Button_Create(leftBigList, "typeBtn33_4", 0, 182, "res/custom/npc/115job/btn231.png")
	GUI:Button_setTitleText(typeBtn33_4, [[]])
	GUI:Button_setTitleColor(typeBtn33_4, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn33_4, 16)
	GUI:Button_titleEnableOutline(typeBtn33_4, "#000000", 1)
	GUI:setAnchorPoint(typeBtn33_4, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn33_4, true)
	GUI:setTag(typeBtn33_4, 0)

	-- Create typeBtn33_5
	local typeBtn33_5 = GUI:Button_Create(leftBigList, "typeBtn33_5", 0, 137, "res/custom/npc/115job/btn231.png")
	GUI:Button_setTitleText(typeBtn33_5, [[]])
	GUI:Button_setTitleColor(typeBtn33_5, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn33_5, 16)
	GUI:Button_titleEnableOutline(typeBtn33_5, "#000000", 1)
	GUI:setAnchorPoint(typeBtn33_5, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn33_5, true)
	GUI:setTag(typeBtn33_5, 0)

	-- Create typeBtn33_6
	local typeBtn33_6 = GUI:Button_Create(leftBigList, "typeBtn33_6", 0, 92, "res/custom/npc/115job/btn231.png")
	GUI:Button_setTitleText(typeBtn33_6, [[]])
	GUI:Button_setTitleColor(typeBtn33_6, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn33_6, 16)
	GUI:Button_titleEnableOutline(typeBtn33_6, "#000000", 1)
	GUI:setAnchorPoint(typeBtn33_6, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn33_6, true)
	GUI:setTag(typeBtn33_6, 0)

	-- Create typeBtn33_7
	local typeBtn33_7 = GUI:Button_Create(leftBigList, "typeBtn33_7", 0, 47, "res/custom/npc/115job/btn231.png")
	GUI:Button_setTitleText(typeBtn33_7, [[]])
	GUI:Button_setTitleColor(typeBtn33_7, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn33_7, 16)
	GUI:Button_titleEnableOutline(typeBtn33_7, "#000000", 1)
	GUI:setAnchorPoint(typeBtn33_7, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn33_7, true)
	GUI:setTag(typeBtn33_7, 0)

	-- Create typeBtn33_8
	local typeBtn33_8 = GUI:Button_Create(leftBigList, "typeBtn33_8", 0, 2, "res/custom/npc/115job/btn231.png")
	GUI:Button_setTitleText(typeBtn33_8, [[]])
	GUI:Button_setTitleColor(typeBtn33_8, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn33_8, 16)
	GUI:Button_titleEnableOutline(typeBtn33_8, "#000000", 1)
	GUI:setAnchorPoint(typeBtn33_8, 0.00, 0.00)
	GUI:setTouchEnabled(typeBtn33_8, true)
	GUI:setTag(typeBtn33_8, 0)

	-- Create skillList
	local skillList = GUI:ListView_Create(FrameLayout, "skillList", 208, 40, 76, 432, 1)
	GUI:ListView_setItemsMargin(skillList, 12)
	GUI:setAnchorPoint(skillList, 0.00, 0.00)
	GUI:setTouchEnabled(skillList, true)
	GUI:setTag(skillList, 0)

	-- Create skillBg1
	local skillBg1 = GUI:Image_Create(skillList, "skillBg1", 0, 356, "res/custom/npc/115job/skillBg.png")
	GUI:setAnchorPoint(skillBg1, 0.00, 0.00)
	GUI:setTouchEnabled(skillBg1, false)
	GUI:setTag(skillBg1, 0)

	-- Create skillBtn1
	local skillBtn1 = GUI:Button_Create(skillBg1, "skillBtn1", 4, -2, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:Button_setTitleText(skillBtn1, [[]])
	GUI:Button_setTitleColor(skillBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(skillBtn1, 16)
	GUI:Button_titleEnableOutline(skillBtn1, "#000000", 1)
	GUI:setAnchorPoint(skillBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(skillBtn1, true)
	GUI:setTag(skillBtn1, 0)

	-- Create skillBg2
	local skillBg2 = GUI:Image_Create(skillList, "skillBg2", 0, 268, "res/custom/npc/115job/skillBg.png")
	GUI:setAnchorPoint(skillBg2, 0.00, 0.00)
	GUI:setTouchEnabled(skillBg2, false)
	GUI:setTag(skillBg2, 0)

	-- Create skillBtn2
	local skillBtn2 = GUI:Button_Create(skillBg2, "skillBtn2", 4, -2, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:Button_setTitleText(skillBtn2, [[]])
	GUI:Button_setTitleColor(skillBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(skillBtn2, 16)
	GUI:Button_titleEnableOutline(skillBtn2, "#000000", 1)
	GUI:setAnchorPoint(skillBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(skillBtn2, true)
	GUI:setTag(skillBtn2, 0)

	-- Create skillBg3
	local skillBg3 = GUI:Image_Create(skillList, "skillBg3", 0, 180, "res/custom/npc/115job/skillBg.png")
	GUI:setAnchorPoint(skillBg3, 0.00, 0.00)
	GUI:setTouchEnabled(skillBg3, false)
	GUI:setTag(skillBg3, 0)

	-- Create skillBtn3
	local skillBtn3 = GUI:Button_Create(skillBg3, "skillBtn3", 4, -2, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:Button_setTitleText(skillBtn3, [[]])
	GUI:Button_setTitleColor(skillBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(skillBtn3, 16)
	GUI:Button_titleEnableOutline(skillBtn3, "#000000", 1)
	GUI:setAnchorPoint(skillBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(skillBtn3, true)
	GUI:setTag(skillBtn3, 0)

	-- Create skillBg4
	local skillBg4 = GUI:Image_Create(skillList, "skillBg4", 0, 92, "res/custom/npc/115job/skillBg.png")
	GUI:setAnchorPoint(skillBg4, 0.00, 0.00)
	GUI:setTouchEnabled(skillBg4, false)
	GUI:setTag(skillBg4, 0)

	-- Create skillBtn4
	local skillBtn4 = GUI:Button_Create(skillBg4, "skillBtn4", 4, -2, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:Button_setTitleText(skillBtn4, [[]])
	GUI:Button_setTitleColor(skillBtn4, "#ffffff")
	GUI:Button_setTitleFontSize(skillBtn4, 16)
	GUI:Button_titleEnableOutline(skillBtn4, "#000000", 1)
	GUI:setAnchorPoint(skillBtn4, 0.00, 0.00)
	GUI:setTouchEnabled(skillBtn4, true)
	GUI:setTag(skillBtn4, 0)

	-- Create skillBg5
	local skillBg5 = GUI:Image_Create(skillList, "skillBg5", 0, 4, "res/custom/npc/115job/skillBg.png")
	GUI:setAnchorPoint(skillBg5, 0.00, 0.00)
	GUI:setTouchEnabled(skillBg5, false)
	GUI:setTag(skillBg5, 0)

	-- Create skillBtn5
	local skillBtn5 = GUI:Button_Create(skillBg5, "skillBtn5", 4, -2, "res/custom/npc/111zhibo/job_info/icon_0_11.png")
	GUI:Button_setTitleText(skillBtn5, [[]])
	GUI:Button_setTitleColor(skillBtn5, "#ffffff")
	GUI:Button_setTitleFontSize(skillBtn5, 16)
	GUI:Button_titleEnableOutline(skillBtn5, "#000000", 1)
	GUI:setAnchorPoint(skillBtn5, 0.00, 0.00)
	GUI:setTouchEnabled(skillBtn5, true)
	GUI:setTag(skillBtn5, 0)

	-- Create effect_root
	local effect_root = GUI:Layout_Create(FrameLayout, "effect_root", 368, 26, 360, 305, false)
	GUI:setAnchorPoint(effect_root, 0.00, 0.00)
	GUI:setTouchEnabled(effect_root, false)
	GUI:setTag(effect_root, 0)

	-- Create skillBg
	local skillBg = GUI:Image_Create(FrameLayout, "skillBg", 755, 167, "res/custom/npc/11zzjx/t.png")
	GUI:setAnchorPoint(skillBg, 0.00, 0.00)
	GUI:setTouchEnabled(skillBg, false)
	GUI:setTag(skillBg, 0)

	-- Create job_name_img
	local job_name_img = GUI:Image_Create(skillBg, "job_name_img", 19, 68, "res/custom/npc/11zzjx/0/1/z1.png")
	GUI:setAnchorPoint(job_name_img, 0.50, 0.50)
	GUI:setTouchEnabled(job_name_img, false)
	GUI:setTag(job_name_img, 0)

	-- Create infoImg
	local infoImg = GUI:Image_Create(FrameLayout, "infoImg", 568, 376, "res/custom/npc/111zhibo/job_info/img_0_11.png")
	GUI:setContentSize(infoImg, 352, 96)
	GUI:setIgnoreContentAdaptWithSize(infoImg, false)
	GUI:setAnchorPoint(infoImg, 0.50, 0.50)
	GUI:setTouchEnabled(infoImg, false)
	GUI:setTag(infoImg, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
