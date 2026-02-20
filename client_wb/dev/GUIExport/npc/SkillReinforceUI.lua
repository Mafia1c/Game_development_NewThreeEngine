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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/08jnqh/bg.png")
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

	-- Create select_icon
	local select_icon = GUI:Image_Create(FrameLayout, "select_icon", 533, 357, "res/custom/npc/08jnqh/icon/0_1.png")
	GUI:setAnchorPoint(select_icon, 0.00, 0.00)
	GUI:setTouchEnabled(select_icon, false)
	GUI:setTag(select_icon, 0)

	-- Create skill_name
	local skill_name = GUI:Text_Create(FrameLayout, "skill_name", 562, 311, 18, "#ffff00", [[《灵魂火符》]])
	GUI:Text_enableOutline(skill_name, "#000000", 1)
	GUI:setAnchorPoint(skill_name, 0.50, 0.50)
	GUI:setTouchEnabled(skill_name, false)
	GUI:setTag(skill_name, 0)

	-- Create skill_1
	local skill_1 = GUI:Button_Create(FrameLayout, "skill_1", 461, 191, "res/custom/npc/08jnqh/icon/0_1_0.png")
	GUI:setContentSize(skill_1, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(skill_1, false)
	GUI:Button_setTitleText(skill_1, [[]])
	GUI:Button_setTitleColor(skill_1, "#ffffff")
	GUI:Button_setTitleFontSize(skill_1, 16)
	GUI:Button_titleDisableOutLine(skill_1)
	GUI:setAnchorPoint(skill_1, 0.00, 0.00)
	GUI:setTouchEnabled(skill_1, true)
	GUI:setTag(skill_1, 0)

	-- Create skill_level_1
	local skill_level_1 = GUI:Image_Create(skill_1, "skill_level_1", 9, -7, "res/custom/npc/08jnqh/1.png")
	GUI:setAnchorPoint(skill_level_1, 0.00, 0.00)
	GUI:setTouchEnabled(skill_level_1, false)
	GUI:setTag(skill_level_1, 0)

	-- Create skill_2
	local skill_2 = GUI:Button_Create(FrameLayout, "skill_2", 534, 191, "res/custom/npc/08jnqh/icon/0_1_1.png")
	GUI:setContentSize(skill_2, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(skill_2, false)
	GUI:Button_setTitleText(skill_2, [[]])
	GUI:Button_setTitleColor(skill_2, "#ffffff")
	GUI:Button_setTitleFontSize(skill_2, 16)
	GUI:Button_titleDisableOutLine(skill_2)
	GUI:setAnchorPoint(skill_2, 0.00, 0.00)
	GUI:setTouchEnabled(skill_2, true)
	GUI:setTag(skill_2, 0)

	-- Create skill_level_2
	local skill_level_2 = GUI:Image_Create(skill_2, "skill_level_2", 9, -7, "res/custom/npc/08jnqh/2.png")
	GUI:setAnchorPoint(skill_level_2, 0.00, 0.00)
	GUI:setTouchEnabled(skill_level_2, false)
	GUI:setTag(skill_level_2, 0)

	-- Create skill_3
	local skill_3 = GUI:Button_Create(FrameLayout, "skill_3", 607, 191, "res/custom/npc/08jnqh/icon/0_1_2.png")
	GUI:setContentSize(skill_3, 58, 58)
	GUI:setIgnoreContentAdaptWithSize(skill_3, false)
	GUI:Button_setTitleText(skill_3, [[]])
	GUI:Button_setTitleColor(skill_3, "#ffffff")
	GUI:Button_setTitleFontSize(skill_3, 16)
	GUI:Button_titleDisableOutLine(skill_3)
	GUI:setAnchorPoint(skill_3, 0.00, 0.00)
	GUI:setTouchEnabled(skill_3, true)
	GUI:setTag(skill_3, 0)

	-- Create skill_level_3
	local skill_level_3 = GUI:Image_Create(skill_3, "skill_level_3", 9, -7, "res/custom/npc/08jnqh/3.png")
	GUI:setAnchorPoint(skill_level_3, 0.00, 0.00)
	GUI:setTouchEnabled(skill_level_3, false)
	GUI:setTag(skill_level_3, 0)

	-- Create tip_btn
	local tip_btn = GUI:Button_Create(FrameLayout, "tip_btn", 764, 39, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tip_btn, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tip_btn, false)
	GUI:Button_setTitleText(tip_btn, [[]])
	GUI:Button_setTitleColor(tip_btn, "#ffffff")
	GUI:Button_setTitleFontSize(tip_btn, 16)
	GUI:Button_titleDisableOutLine(tip_btn)
	GUI:setAnchorPoint(tip_btn, 0.00, 0.00)
	GUI:setTouchEnabled(tip_btn, true)
	GUI:setTag(tip_btn, 0)

	-- Create job_btn1
	local job_btn1 = GUI:Button_Create(FrameLayout, "job_btn1", 73, 439, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(job_btn1, "res/custom/npc/ta0.png")
	GUI:setContentSize(job_btn1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(job_btn1, false)
	GUI:Button_setTitleText(job_btn1, [[战士技能]])
	GUI:Button_setTitleColor(job_btn1, "#ffffff")
	GUI:Button_setTitleFontSize(job_btn1, 18)
	GUI:Button_titleEnableOutline(job_btn1, "#000000", 1)
	GUI:setAnchorPoint(job_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(job_btn1, true)
	GUI:setTag(job_btn1, 0)

	-- Create job_btn2
	local job_btn2 = GUI:Button_Create(FrameLayout, "job_btn2", 73, 394, "res/custom/npc/ta1.png")
	GUI:setContentSize(job_btn2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(job_btn2, false)
	GUI:Button_setTitleText(job_btn2, [[法师技能]])
	GUI:Button_setTitleColor(job_btn2, "#ffffff")
	GUI:Button_setTitleFontSize(job_btn2, 18)
	GUI:Button_titleEnableOutline(job_btn2, "#000000", 1)
	GUI:setAnchorPoint(job_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(job_btn2, true)
	GUI:setTag(job_btn2, 0)

	-- Create job_btn3
	local job_btn3 = GUI:Button_Create(FrameLayout, "job_btn3", 73, 349, "res/custom/npc/ta1.png")
	GUI:setContentSize(job_btn3, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(job_btn3, false)
	GUI:Button_setTitleText(job_btn3, [[道士技能]])
	GUI:Button_setTitleColor(job_btn3, "#ffffff")
	GUI:Button_setTitleFontSize(job_btn3, 18)
	GUI:Button_titleEnableOutline(job_btn3, "#000000", 1)
	GUI:setAnchorPoint(job_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(job_btn3, true)
	GUI:setTag(job_btn3, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 199, 440, "res/custom/npc/ta0.png")
	GUI:Button_setScale9Slice(Button_1, 12, 12, 14, 14)
	GUI:setContentSize(Button_1, 117, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleDisableOutLine(Button_1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, false)
	GUI:setTag(Button_1, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(Button_1, "Image_3", 9, 13, "res/custom/ar2.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Button_1, "Text_1", 47, 8, 18, "#ffffff", [[技能]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create skill_listview
	local skill_listview = GUI:ListView_Create(FrameLayout, "skill_listview", 201, 81, 114, 358, 1)
	GUI:ListView_setBounceEnabled(skill_listview, true)
	GUI:setAnchorPoint(skill_listview, 0.00, 0.00)
	GUI:setTouchEnabled(skill_listview, true)
	GUI:setTag(skill_listview, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(skill_listview, "Image_4", 0, 324, "res/custom/npc/z2.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(Image_4, "Text_2", 55, 17, 18, "#ffff00", [[刺杀剑术]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(skill_listview, "Image_5", 0, 290, "res/custom/npc/z2.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(Image_5, "Text_2", 55, 17, 18, "#ffff00", [[刺杀剑术]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(skill_listview, "Image_6", 0, 256, "res/custom/npc/z2.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(Image_6, "Text_2", 55, 17, 18, "#ffff00", [[刺杀剑术]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 457, 125, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 546, 125, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create reinforce_btn
	local reinforce_btn = GUI:Button_Create(FrameLayout, "reinforce_btn", 681, 106, "res/custom/npc/an.png")
	GUI:setContentSize(reinforce_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(reinforce_btn, false)
	GUI:Button_setTitleText(reinforce_btn, [[强化一重]])
	GUI:Button_setTitleColor(reinforce_btn, "#F8E6C6")
	GUI:Button_setTitleFontSize(reinforce_btn, 18)
	GUI:Button_titleEnableOutline(reinforce_btn, "#000000", 1)
	GUI:setAnchorPoint(reinforce_btn, 0.00, 0.00)
	GUI:setTouchEnabled(reinforce_btn, true)
	GUI:setTag(reinforce_btn, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 335, 264, "res/custom/npc/25bwqh/sxbg.png")
	GUI:Image_setScale9Slice(Image_1, 13, 13, 70, 70)
	GUI:setContentSize(Image_1, 138, 212)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Image_1, "Image_2", 36, 181, "res/custom/npc/25bwqh/t1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create cur_attr1
	local cur_attr1 = GUI:Text_Create(Image_1, "cur_attr1", 72, 154, 16, "#00ff00", [[生命：]])
	GUI:Text_enableOutline(cur_attr1, "#000000", 1)
	GUI:setAnchorPoint(cur_attr1, 0.50, 0.50)
	GUI:setTouchEnabled(cur_attr1, false)
	GUI:setTag(cur_attr1, 0)

	-- Create cur_attr2
	local cur_attr2 = GUI:Text_Create(Image_1, "cur_attr2", 72, 122, 16, "#00ff00", [[双防：]])
	GUI:Text_enableOutline(cur_attr2, "#000000", 1)
	GUI:setAnchorPoint(cur_attr2, 0.50, 0.50)
	GUI:setTouchEnabled(cur_attr2, false)
	GUI:setTag(cur_attr2, 0)

	-- Create cur_attr3
	local cur_attr3 = GUI:Text_Create(Image_1, "cur_attr3", 72, 89, 16, "#ff00ff", [[技能威力：]])
	GUI:Text_enableOutline(cur_attr3, "#000000", 1)
	GUI:setAnchorPoint(cur_attr3, 0.50, 0.50)
	GUI:setTouchEnabled(cur_attr3, false)
	GUI:setTag(cur_attr3, 0)

	-- Create Image_7
	local Image_7 = GUI:Image_Create(FrameLayout, "Image_7", 644, 264, "res/custom/npc/25bwqh/sxbg.png")
	GUI:Image_setScale9Slice(Image_7, 13, 13, 70, 70)
	GUI:setContentSize(Image_7, 138, 212)
	GUI:setIgnoreContentAdaptWithSize(Image_7, false)
	GUI:setAnchorPoint(Image_7, 0.00, 0.00)
	GUI:setTouchEnabled(Image_7, false)
	GUI:setTag(Image_7, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(Image_7, "Image_2", 32, 181, "res/custom/npc/25bwqh/t2.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create next_attr1
	local next_attr1 = GUI:Text_Create(Image_7, "next_attr1", 70, 151, 16, "#00ff00", [[生命：]])
	GUI:Text_enableOutline(next_attr1, "#000000", 1)
	GUI:setAnchorPoint(next_attr1, 0.50, 0.50)
	GUI:setTouchEnabled(next_attr1, false)
	GUI:setTag(next_attr1, 0)

	-- Create next_attr2
	local next_attr2 = GUI:Text_Create(Image_7, "next_attr2", 70, 119, 16, "#00ff00", [[双防：]])
	GUI:Text_enableOutline(next_attr2, "#000000", 1)
	GUI:setAnchorPoint(next_attr2, 0.50, 0.50)
	GUI:setTouchEnabled(next_attr2, false)
	GUI:setTag(next_attr2, 0)

	-- Create next_attr3
	local next_attr3 = GUI:Text_Create(Image_7, "next_attr3", 70, 86, 16, "#ff00ff", [[技能威力：]])
	GUI:Text_enableOutline(next_attr3, "#000000", 1)
	GUI:setAnchorPoint(next_attr3, 0.50, 0.50)
	GUI:setTouchEnabled(next_attr3, false)
	GUI:setTag(next_attr3, 0)

	-- Create tip_box
	local tip_box = GUI:Layout_Create(FrameLayout, "tip_box", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(tip_box, 0.00, 0.00)
	GUI:setTouchEnabled(tip_box, true)
	GUI:setTag(tip_box, 0)
	GUI:setVisible(tip_box, false)

	-- Create tip_img
	local tip_img = GUI:Image_Create(tip_box, "tip_img", 158, 102, "res/custom/npc/tips.png")
	GUI:Image_setScale9Slice(tip_img, 69, 69, 137, 137)
	GUI:setContentSize(tip_img, 537, 363)
	GUI:setIgnoreContentAdaptWithSize(tip_img, false)
	GUI:setAnchorPoint(tip_img, 0.00, 0.00)
	GUI:setTouchEnabled(tip_img, false)
	GUI:setTag(tip_img, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(tip_img, "RichText_1", 19, 28, [[<font color='#ffff00' size='16' >技能印记说明：</font><br><font color='#ff9b00' size='16' >职业技能可进行强化，来增强技能的威力与技能BUFF</font><br><font color='#00ff00' size='16' >强化技能达到（3/6/9）重时，可激活对应的技能BUFF效果</font><br><font color='#ffff00' size='16' >技能属性说明：</font><br><font color='#ff0000' size='16' >强化一重</font><font color='#ffffff' size='16' >：</font><font color='#ef00ef' size='16' >生命+2% 双防+2% 技能威力+2%</font><br><font color='#ff0000' size='16' >强化二重</font><font color='#ffffff' size='16' >：</font><font color='#ef00ef' size='16' >生命+4% 双防+3% 技能威力+3%</font><br><font color='#ff0000' size='16' >强化三重</font><font color='#ffffff' size='16' >：</font><font color='#ef00ef' size='16' >生命+6% 双防+4% 技能威力+4%</font><br><font color='#ff0000' size='16' >强化四重</font><font color='#ffffff' size='16' >：</font><font color='#ef00ef' size='16' >生命+8% 双防+5% 技能威力+5%</font><br><font color='#ff0000' size='16' >强化五重</font><font color='#ffffff' size='16' >：</font><font color='#ef00ef' size='16' >生命+10% 双防+6% 技能威力+6%</font><br><font color='#ff0000' size='16' >强化六重</font><font color='#ffffff' size='16' >：</font><font color='#ef00ef' size='16' >生命+12% 双防+7% 技能威力+7%</font><br><font color='#ff0000' size='16' >强化七重</font><font color='#ffffff' size='16' >：</font><font color='#ef00ef' size='16' >生命+14% 双防+8% 技能威力+8%</font><br><font color='#ff0000' size='16' >强化八重</font><font color='#ffffff' size='16' >：</font><font color='#ef00ef' size='16' >生命+16% 双防+9% 技能威力+9%</font><br><font color='#ff0000' size='16' >强化九重</font><font color='#ffffff' size='16' >：</font><font color='#ef00ef' size='16' >生命+20% 双防+10% 技能威力+10%</font>]], 500, 16, "#ffffff", 5)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
