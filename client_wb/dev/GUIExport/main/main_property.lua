local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Main_Property
	local Main_Property = GUI:Node_Create(parent, "Main_Property", 0, 0)
	GUI:setTag(Main_Property, -1)

	-- Create Panel_bg
	local Panel_bg = GUI:Layout_Create(Main_Property, "Panel_bg", 0, 0, 1136, 150, false)
	GUI:setChineseName(Panel_bg, "主界面操作组合")
	GUI:setAnchorPoint(Panel_bg, 0.50, 0.00)
	GUI:setTouchEnabled(Panel_bg, false)
	GUI:setTag(Panel_bg, -1)

	-- Create bottomImg
	local bottomImg = GUI:Image_Create(Panel_bg, "bottomImg", 468, -3, "res/private/main/1900012003.png")
	GUI:setContentSize(bottomImg, 1336, 30)
	GUI:setIgnoreContentAdaptWithSize(bottomImg, false)
	GUI:setChineseName(bottomImg, "主界面操作_底部栏_背景图")
	GUI:setAnchorPoint(bottomImg, 0.50, 0.00)
	GUI:setTouchEnabled(bottomImg, true)
	GUI:setTag(bottomImg, -1)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(Panel_bg, "Image_4", 325, 23, "res/private/main/1900012000.png")
	GUI:setChineseName(Image_4, "主界面操作_Hp/Mp_背景图")
	GUI:setAnchorPoint(Image_4, 0.50, 0.00)
	GUI:setTouchEnabled(Image_4, true)
	GUI:setTag(Image_4, -1)

	-- Create ImageView
	local ImageView = GUI:Image_Create(Panel_bg, "ImageView", 780, 23, "res/private/main/1900012000_1.png")
	GUI:setChineseName(ImageView, "主界面操作_右下_背景图")
	GUI:setAnchorPoint(ImageView, 0.50, 0.00)
	GUI:setTouchEnabled(ImageView, true)
	GUI:setTag(ImageView, -1)

	-- Create Image_14
	local Image_14 = GUI:Image_Create(Panel_bg, "Image_14", 350, 11, "res/private/main/1900012006.png")
	GUI:setChineseName(Image_14, "主界面操作_Hp_背景图")
	GUI:setAnchorPoint(Image_14, 0.50, 0.50)
	GUI:setTouchEnabled(Image_14, false)
	GUI:setTag(Image_14, -1)

	-- Create Image_14_0
	local Image_14_0 = GUI:Image_Create(Panel_bg, "Image_14_0", 457, 11, "res/private/main/1900012006.png")
	GUI:setChineseName(Image_14_0, "主界面操作_Mp_背景图")
	GUI:setAnchorPoint(Image_14_0, 0.50, 0.50)
	GUI:setTouchEnabled(Image_14_0, false)
	GUI:setTag(Image_14_0, -1)

	-- Create Image_14_0_0
	local Image_14_0_0 = GUI:Image_Create(Panel_bg, "Image_14_0_0", 650, 11, "res/private/main/1900012006.png")
	GUI:setChineseName(Image_14_0_0, "主界面操作_等级_背景图")
	GUI:setAnchorPoint(Image_14_0_0, 0.50, 0.50)
	GUI:setTouchEnabled(Image_14_0_0, false)
	GUI:setTag(Image_14_0_0, -1)

	-- Create btn_rein_add
	local btn_rein_add = GUI:Button_Create(Panel_bg, "btn_rein_add", 535, 11, "res/private/main/00641.png")
	GUI:Button_loadTexturePressed(btn_rein_add, "res/private/main/00641.png")
	GUI:Button_loadTextureDisabled(btn_rein_add, "res/private/main/00643.png")
	GUI:setContentSize(btn_rein_add, 23, 23)
	GUI:setIgnoreContentAdaptWithSize(btn_rein_add, false)
	GUI:Button_setTitleText(btn_rein_add, [[]])
	GUI:Button_setTitleColor(btn_rein_add, "#ffffff")
	GUI:Button_setTitleFontSize(btn_rein_add, 10)
	GUI:Button_titleEnableOutline(btn_rein_add, "#000000", 1)
	GUI:setChineseName(btn_rein_add, "主界面操作_属性点_按钮")
	GUI:setAnchorPoint(btn_rein_add, 0.50, 0.50)
	GUI:setTouchEnabled(btn_rein_add, true)
	GUI:setTag(btn_rein_add, -1)

	-- Create Image_17
	local Image_17 = GUI:Image_Create(Panel_bg, "Image_17", 570, 11, "res/private/main/1900012015.png")
	GUI:setChineseName(Image_17, "主界面操作_等级文字_图片")
	GUI:setAnchorPoint(Image_17, 0.50, 0.50)
	GUI:setTouchEnabled(Image_17, false)
	GUI:setTag(Image_17, -1)

	-- Create Image_19
	local Image_19 = GUI:Image_Create(Panel_bg, "Image_19", 896, 11, "res/private/main/1900012009.png")
	GUI:setContentSize(Image_19, 258, 14)
	GUI:setIgnoreContentAdaptWithSize(Image_19, false)
	GUI:setChineseName(Image_19, "主界面操作_经验_背景框")
	GUI:setAnchorPoint(Image_19, 0.50, 0.50)
	GUI:setTouchEnabled(Image_19, false)
	GUI:setTag(Image_19, -1)

	-- Create LoadingBar_exp
	local LoadingBar_exp = GUI:LoadingBar_Create(Panel_bg, "LoadingBar_exp", 895, 11, "res/private/main/1900012010.png", 0)
	GUI:setChineseName(LoadingBar_exp, "主界面操作_经验条")
	GUI:setAnchorPoint(LoadingBar_exp, 0.50, 0.50)
	GUI:setTouchEnabled(LoadingBar_exp, false)
	GUI:setTag(LoadingBar_exp, -1)

	-- Create Image_net
	local Image_net = GUI:Image_Create(Panel_bg, "Image_net", 84, 11, "res/private/main/Other/1900012501.png")
	GUI:setChineseName(Image_net, "主界面操作_信号_图片")
	GUI:setAnchorPoint(Image_net, 0.50, 0.50)
	GUI:setTouchEnabled(Image_net, false)
	GUI:setTag(Image_net, -1)

	-- Create Image_battery
	local Image_battery = GUI:Image_Create(Panel_bg, "Image_battery", 147, 11, "res/private/main/Other/1900012502.png")
	GUI:setChineseName(Image_battery, "主界面操作_电量_背景框")
	GUI:setAnchorPoint(Image_battery, 0.50, 0.50)
	GUI:setTouchEnabled(Image_battery, false)
	GUI:setTag(Image_battery, -1)

	-- Create LoadingBar_battery
	local LoadingBar_battery = GUI:LoadingBar_Create(Panel_bg, "LoadingBar_battery", 146, 11, "res/private/main/Other/1900012503.png", 0)
	GUI:setChineseName(LoadingBar_battery, "主界面操作_电量")
	GUI:setAnchorPoint(LoadingBar_battery, 0.50, 0.50)
	GUI:setTouchEnabled(LoadingBar_battery, false)
	GUI:setTag(LoadingBar_battery, -1)

	-- Create Text_FPS
	local Text_FPS = GUI:Text_Create(Panel_bg, "Text_FPS", 230, 11, 16, "#ffffff", [[FPS:60]])
	GUI:Text_enableOutline(Text_FPS, "#000000", 1)
	GUI:setChineseName(Text_FPS, "主界面操作_帧数_文本")
	GUI:setAnchorPoint(Text_FPS, 0.50, 0.50)
	GUI:setTouchEnabled(Text_FPS, false)
	GUI:setTag(Text_FPS, -1)

	-- Create Panel_hp
	local Panel_hp = GUI:Layout_Create(Panel_bg, "Panel_hp", 347, 78, 104, 104, false)
	GUI:setChineseName(Panel_hp, "主界面操作_Hp/Mp_组合")
	GUI:setAnchorPoint(Panel_hp, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_hp, false)
	GUI:setTag(Panel_hp, -1)

	-- Create Image_divide
	local Image_divide = GUI:Image_Create(Panel_hp, "Image_divide", 47, 52, "res/private/main/1900012507.png")
	GUI:setChineseName(Image_divide, "主界面操作_醉酒值")
	GUI:setAnchorPoint(Image_divide, 0.50, 0.50)
	GUI:setTouchEnabled(Image_divide, false)
	GUI:setTag(Image_divide, -1)

	-- Create LoadingBar_hp
	local LoadingBar_hp = GUI:LoadingBar_Create(Panel_hp, "LoadingBar_hp", 29, 52, "res/private/main/1900012032.png", 0)
	GUI:setChineseName(LoadingBar_hp, "主界面操作_Hp值")
	GUI:setAnchorPoint(LoadingBar_hp, 0.50, 0.50)
	GUI:setRotation(LoadingBar_hp, 270.00)
	GUI:setTouchEnabled(LoadingBar_hp, false)
	GUI:setTag(LoadingBar_hp, -1)

	-- Create LoadingBar_mp
	local LoadingBar_mp = GUI:LoadingBar_Create(Panel_hp, "LoadingBar_mp", 71, 53, "res/private/main/1900012033.png", 0)
	GUI:setChineseName(LoadingBar_mp, "主界面操作_Mp值")
	GUI:setAnchorPoint(LoadingBar_mp, 0.50, 0.50)
	GUI:setRotation(LoadingBar_mp, 270.00)
	GUI:setTouchEnabled(LoadingBar_mp, false)
	GUI:setTag(LoadingBar_mp, -1)

	-- Create LoadingBar_fhp
	local LoadingBar_fhp = GUI:LoadingBar_Create(Panel_hp, "LoadingBar_fhp", 52, 52, "res/private/main/1900012504.png", 0)
	GUI:setChineseName(LoadingBar_fhp, "主界面操作_全Hp值")
	GUI:setAnchorPoint(LoadingBar_fhp, 0.50, 0.50)
	GUI:setRotation(LoadingBar_fhp, 270.00)
	GUI:setTouchEnabled(LoadingBar_fhp, false)
	GUI:setTag(LoadingBar_fhp, -1)

	-- Create Panel_hp_sfx
	local Panel_hp_sfx = GUI:Layout_Create(Panel_hp, "Panel_hp_sfx", -2, 0, 52, 104, true)
	GUI:setChineseName(Panel_hp_sfx, "主界面操作_Hp特效")
	GUI:setAnchorPoint(Panel_hp_sfx, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_hp_sfx, false)
	GUI:setTag(Panel_hp_sfx, -1)

	-- Create Panel_mp_sfx
	local Panel_mp_sfx = GUI:Layout_Create(Panel_hp, "Panel_mp_sfx", 54, 0, 52, 104, true)
	GUI:setChineseName(Panel_mp_sfx, "主界面操作_Mp特效")
	GUI:setAnchorPoint(Panel_mp_sfx, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_mp_sfx, false)
	GUI:setTag(Panel_mp_sfx, -1)

	-- Create Panel_fhp_sfx
	local Panel_fhp_sfx = GUI:Layout_Create(Panel_hp, "Panel_fhp_sfx", 0, 0, 104, 104, true)
	GUI:setChineseName(Panel_fhp_sfx, "主界面操作_全Hp特效")
	GUI:setAnchorPoint(Panel_fhp_sfx, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_fhp_sfx, false)
	GUI:setTag(Panel_fhp_sfx, -1)
	GUI:setVisible(Panel_fhp_sfx, false)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Panel_bg, "Image_1", 1080, 11, "res/private/main/m_time.png")
	GUI:setChineseName(Image_1, "主界面操作_时间_背景图")
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, -1)

	-- Create Text_hp
	local Text_hp = GUI:Text_Create(Panel_bg, "Text_hp", 350, 12, 16, "#ffffff", [[11/11]])
	GUI:Text_enableOutline(Text_hp, "#000000", 1)
	GUI:setChineseName(Text_hp, "主界面操作_Hp_文本")
	GUI:setAnchorPoint(Text_hp, 0.50, 0.50)
	GUI:setTouchEnabled(Text_hp, false)
	GUI:setTag(Text_hp, -1)

	-- Create Text_mp
	local Text_mp = GUI:Text_Create(Panel_bg, "Text_mp", 457, 12, 16, "#ffffff", [[11/11]])
	GUI:Text_enableOutline(Text_mp, "#000000", 1)
	GUI:setChineseName(Text_mp, "主界面操作_Mp_文本")
	GUI:setAnchorPoint(Text_mp, 0.50, 0.50)
	GUI:setTouchEnabled(Text_mp, false)
	GUI:setTag(Text_mp, -1)

	-- Create Text_level
	local Text_level = GUI:Text_Create(Panel_bg, "Text_level", 650, 12, 16, "#ffffff", [[1级]])
	GUI:Text_enableOutline(Text_level, "#000000", 1)
	GUI:setChineseName(Text_level, "主界面操作_等级_文本")
	GUI:setAnchorPoint(Text_level, 0.50, 0.50)
	GUI:setTouchEnabled(Text_level, false)
	GUI:setTag(Text_level, -1)

	-- Create Text_time
	local Text_time = GUI:Text_Create(Panel_bg, "Text_time", 1080, 12, 16, "#ffffff", [[-]])
	GUI:Text_enableOutline(Text_time, "#000000", 1)
	GUI:setChineseName(Text_time, "主界面操作_时间_文本")
	GUI:setAnchorPoint(Text_time, 0.50, 0.50)
	GUI:setTouchEnabled(Text_time, false)
	GUI:setTag(Text_time, -1)

	-- Create Text_exp
	local Text_exp = GUI:Text_Create(Panel_bg, "Text_exp", 895, 12, 16, "#ffffff", [[0%]])
	GUI:Text_enableOutline(Text_exp, "#000000", 1)
	GUI:setChineseName(Text_exp, "主界面操作_经验百分比_文本")
	GUI:setAnchorPoint(Text_exp, 0.50, 0.50)
	GUI:setTouchEnabled(Text_exp, false)
	GUI:setTag(Text_exp, -1)

	-- Create Image_17_0
	local Image_17_0 = GUI:Image_Create(Panel_bg, "Image_17_0", 740, 12, "res/private/main/1900012016.png")
	GUI:setChineseName(Image_17_0, "主界面操作_经验文字_图片")
	GUI:setAnchorPoint(Image_17_0, 0.50, 0.50)
	GUI:setTouchEnabled(Image_17_0, false)
	GUI:setTag(Image_17_0, -1)

	-- Create Panel_mini_chat
	local Panel_mini_chat = GUI:Layout_Create(Main_Property, "Panel_mini_chat", -164, 25, 316, 108, false)
	GUI:setChineseName(Panel_mini_chat, "主界面操作袖珍聊天组合")
	GUI:setAnchorPoint(Panel_mini_chat, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_mini_chat, false)
	GUI:setTag(Panel_mini_chat, -1)

	-- Create Image_minichat_bg
	local Image_minichat_bg = GUI:Image_Create(Panel_mini_chat, "Image_minichat_bg", 158, 0, "res/private/main/1900012019.png")
	GUI:Image_setScale9Slice(Image_minichat_bg, 69, 69, 22, 22)
	GUI:setContentSize(Image_minichat_bg, 316, 108)
	GUI:setIgnoreContentAdaptWithSize(Image_minichat_bg, false)
	GUI:setChineseName(Image_minichat_bg, "主界面操作_聊天_背景图")
	GUI:setAnchorPoint(Image_minichat_bg, 0.50, 0.00)
	GUI:setTouchEnabled(Image_minichat_bg, false)
	GUI:setTag(Image_minichat_bg, -1)

	-- Create ListView_minichat
	local ListView_minichat = GUI:ListView_Create(Panel_mini_chat, "ListView_minichat", 158, 0, 310, 105, 1)
	GUI:setChineseName(ListView_minichat, "主界面操作_聊天内容_列表")
	GUI:setAnchorPoint(ListView_minichat, 0.50, 0.00)
	GUI:setTouchEnabled(ListView_minichat, false)
	GUI:setTag(ListView_minichat, -1)

	-- Create ListView_chat_ex
	local ListView_chat_ex = GUI:ListView_Create(Panel_mini_chat, "ListView_chat_ex", 158, 105, 310, 25, 1)
	GUI:setChineseName(ListView_chat_ex, "主界面操作_聊天公告_列表")
	GUI:setAnchorPoint(ListView_chat_ex, 0.50, 1.00)
	GUI:setTouchEnabled(ListView_chat_ex, false)
	GUI:setTag(ListView_chat_ex, -1)

	-- Create Panel_mini_chat_touch
	local Panel_mini_chat_touch = GUI:Layout_Create(Panel_mini_chat, "Panel_mini_chat_touch", 0, -1, 316, 108, false)
	GUI:setChineseName(Panel_mini_chat_touch, "主界面操作_聊天_触摸")
	GUI:setAnchorPoint(Panel_mini_chat_touch, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_mini_chat_touch, true)
	GUI:setTag(Panel_mini_chat_touch, -1)

	-- Create Image_barbg
	local Image_barbg = GUI:Image_Create(Main_Property, "Image_barbg", -55, 25, "res/private/main/angerBg2.png")
	GUI:setChineseName(Image_barbg, "主界面操作_怒气组合")
	GUI:setAnchorPoint(Image_barbg, 0.50, 0.00)
	GUI:setTouchEnabled(Image_barbg, false)
	GUI:setTag(Image_barbg, -1)
	GUI:setVisible(Image_barbg, false)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Image_barbg, "Image_2", 6, 2, "res/private/main/angerBg.png")
	GUI:setChineseName(Image_2, "怒气_背景框")
	GUI:setAnchorPoint(Image_2, 0.50, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, -1)

	-- Create Panel_bar
	local Panel_bar = GUI:Layout_Create(Image_barbg, "Panel_bar", 6, 0, 13, 108, true)
	GUI:setChineseName(Panel_bar, "主界面操作_怒气组合")
	GUI:setAnchorPoint(Panel_bar, 0.50, 0.00)
	GUI:setTouchEnabled(Panel_bar, false)
	GUI:setTag(Panel_bar, -1)

	-- Create Image_bar
	local Image_bar = GUI:Image_Create(Panel_bar, "Image_bar", 7, 2, "res/private/main/angerBar.png")
	GUI:setChineseName(Image_bar, "怒气_怒气值")
	GUI:setAnchorPoint(Image_bar, 0.50, 0.00)
	GUI:setTouchEnabled(Image_bar, false)
	GUI:setTag(Image_bar, -1)

	-- Create Image_barbg_dz
	local Image_barbg_dz = GUI:Image_Create(Main_Property, "Image_barbg_dz", 274, 25, "res/private/main/douzhi_00.png")
	GUI:setChineseName(Image_barbg_dz, "主界面操作_斗转组合")
	GUI:setAnchorPoint(Image_barbg_dz, 0.50, 0.00)
	GUI:setTouchEnabled(Image_barbg_dz, false)
	GUI:setTag(Image_barbg_dz, -1)
	GUI:setVisible(Image_barbg_dz, false)

	-- Create Image_dz
	local Image_dz = GUI:Image_Create(Image_barbg_dz, "Image_dz", 6, 2, "res/private/main/douzhi_01.png")
	GUI:setChineseName(Image_dz, "主界面操作_斗转值_背景图")
	GUI:setAnchorPoint(Image_dz, 0.50, 0.00)
	GUI:setTouchEnabled(Image_dz, false)
	GUI:setTag(Image_dz, -1)

	-- Create Panel_bar_dz
	local Panel_bar_dz = GUI:Layout_Create(Image_barbg_dz, "Panel_bar_dz", 6, 2, 8, 103, true)
	GUI:setChineseName(Panel_bar_dz, "主界面操作_斗转组合")
	GUI:setAnchorPoint(Panel_bar_dz, 0.50, 0.00)
	GUI:setTouchEnabled(Panel_bar_dz, false)
	GUI:setTag(Panel_bar_dz, -1)

	-- Create bar_dz
	local bar_dz = GUI:Image_Create(Panel_bar_dz, "bar_dz", 4, 0, "res/private/main/douzhi_02.png")
	GUI:setChineseName(bar_dz, "主界面操作_斗转值")
	GUI:setAnchorPoint(bar_dz, 0.50, 0.00)
	GUI:setTouchEnabled(bar_dz, false)
	GUI:setTag(bar_dz, -1)

	-- Create Image_barbg_zj
	local Image_barbg_zj = GUI:Image_Create(Main_Property, "Image_barbg_zj", 291, 25, "res/private/main/douzhi_00.png")
	GUI:setChineseName(Image_barbg_zj, "主界面操作_醉酒组合")
	GUI:setAnchorPoint(Image_barbg_zj, 0.50, 0.00)
	GUI:setTouchEnabled(Image_barbg_zj, false)
	GUI:setTag(Image_barbg_zj, -1)
	GUI:setVisible(Image_barbg_zj, false)

	-- Create Image_zj
	local Image_zj = GUI:Image_Create(Image_barbg_zj, "Image_zj", 6, 2, "res/private/main/douzhi_01.png")
	GUI:setChineseName(Image_zj, "主界面操作_醉酒_背景图")
	GUI:setAnchorPoint(Image_zj, 0.50, 0.00)
	GUI:setTouchEnabled(Image_zj, false)
	GUI:setTag(Image_zj, -1)

	-- Create Panel_bar_zj
	local Panel_bar_zj = GUI:Layout_Create(Image_barbg_zj, "Panel_bar_zj", 6, 2, 8, 103, true)
	GUI:setChineseName(Panel_bar_zj, "主界面操作_醉酒组合")
	GUI:setAnchorPoint(Panel_bar_zj, 0.50, 0.00)
	GUI:setTouchEnabled(Panel_bar_zj, false)
	GUI:setTag(Panel_bar_zj, -1)

	-- Create bar_zj
	local bar_zj = GUI:Image_Create(Panel_bar_zj, "bar_zj", 4, 0, "res/private/main/douzhi_02.png")
	GUI:setChineseName(bar_zj, "主界面操作_醉酒值")
	GUI:setAnchorPoint(bar_zj, 0.50, 0.00)
	GUI:setTouchEnabled(bar_zj, false)
	GUI:setTag(bar_zj, -1)

	-- Create Panel_quick
	local Panel_quick = GUI:Layout_Create(Main_Property, "Panel_quick", -164, 137, 316, 50, false)
	GUI:setChineseName(Panel_quick, "主界面快捷操作栏组合")
	GUI:setAnchorPoint(Panel_quick, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_quick, false)
	GUI:setTag(Panel_quick, -1)

	-- Create Panel_quick_use_1
	local Panel_quick_use_1 = GUI:Layout_Create(Panel_quick, "Panel_quick_use_1", 0, 0, 50, 50, false)
	GUI:setChineseName(Panel_quick_use_1, "主界面_快捷操作栏1")
	GUI:setAnchorPoint(Panel_quick_use_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_quick_use_1, true)
	GUI:setTag(Panel_quick_use_1, -1)

	-- Create Panel_quick_use_2
	local Panel_quick_use_2 = GUI:Layout_Create(Panel_quick, "Panel_quick_use_2", 53, 0, 50, 50, false)
	GUI:setChineseName(Panel_quick_use_2, "主界面_快捷操作栏2")
	GUI:setAnchorPoint(Panel_quick_use_2, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_quick_use_2, true)
	GUI:setTag(Panel_quick_use_2, -1)

	-- Create Panel_quick_use_3
	local Panel_quick_use_3 = GUI:Layout_Create(Panel_quick, "Panel_quick_use_3", 106, 0, 50, 50, false)
	GUI:setChineseName(Panel_quick_use_3, "主界面_快捷操作栏3")
	GUI:setAnchorPoint(Panel_quick_use_3, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_quick_use_3, true)
	GUI:setTag(Panel_quick_use_3, -1)

	-- Create Panel_quick_use_4
	local Panel_quick_use_4 = GUI:Layout_Create(Panel_quick, "Panel_quick_use_4", 159, 0, 50, 50, false)
	GUI:setChineseName(Panel_quick_use_4, "主界面_快捷操作栏4")
	GUI:setAnchorPoint(Panel_quick_use_4, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_quick_use_4, true)
	GUI:setTag(Panel_quick_use_4, -1)

	-- Create Panel_quick_use_5
	local Panel_quick_use_5 = GUI:Layout_Create(Panel_quick, "Panel_quick_use_5", 212, 0, 50, 50, false)
	GUI:setChineseName(Panel_quick_use_5, "主界面_快捷操作栏5")
	GUI:setAnchorPoint(Panel_quick_use_5, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_quick_use_5, true)
	GUI:setTag(Panel_quick_use_5, -1)

	-- Create Panel_quick_use_6
	local Panel_quick_use_6 = GUI:Layout_Create(Panel_quick, "Panel_quick_use_6", 265, 0, 50, 50, false)
	GUI:setChineseName(Panel_quick_use_6, "主界面_快捷操作栏6")
	GUI:setAnchorPoint(Panel_quick_use_6, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_quick_use_6, true)
	GUI:setTag(Panel_quick_use_6, -1)

	-- Create Panel_bubble_tips
	local Panel_bubble_tips = GUI:Layout_Create(Main_Property, "Panel_bubble_tips", -286, 210, 150, 50, false)
	GUI:setChineseName(Panel_bubble_tips, "提示信息列表(邮件/交易等)")
	GUI:setAnchorPoint(Panel_bubble_tips, 0.50, 0.00)
	GUI:setTouchEnabled(Panel_bubble_tips, false)
	GUI:setTag(Panel_bubble_tips, -1)

	-- Create ListView_bubble_tips
	local ListView_bubble_tips = GUI:ListView_Create(Panel_bubble_tips, "ListView_bubble_tips", 0, 0, 150, 50, 2)
	GUI:ListView_setGravity(ListView_bubble_tips, 3)
	GUI:setChineseName(ListView_bubble_tips, "提示信息_列表")
	GUI:setAnchorPoint(ListView_bubble_tips, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_bubble_tips, false)
	GUI:setTag(ListView_bubble_tips, -1)

	-- Create Panel_auto_tips
	local Panel_auto_tips = GUI:Layout_Create(Main_Property, "Panel_auto_tips", -164, 190, 316, 60, false)
	GUI:setChineseName(Panel_auto_tips, "主界面_自动挂机_提示")
	GUI:setAnchorPoint(Panel_auto_tips, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_auto_tips, false)
	GUI:setTag(Panel_auto_tips, -1)

	-- Create Button_chat_hide
	local Button_chat_hide = GUI:Button_Create(Main_Property, "Button_chat_hide", -75, 120, "res/private/main/chat_hide.png")
	GUI:Button_loadTextureDisabled(Button_chat_hide, "res/private/main/chat_hide_1.png")
	GUI:setContentSize(Button_chat_hide, 22, 26)
	GUI:setIgnoreContentAdaptWithSize(Button_chat_hide, false)
	GUI:Button_setTitleText(Button_chat_hide, [[]])
	GUI:Button_setTitleColor(Button_chat_hide, "#ffffff")
	GUI:Button_setTitleFontSize(Button_chat_hide, 10)
	GUI:Button_titleEnableOutline(Button_chat_hide, "#000000", 1)
	GUI:setChineseName(Button_chat_hide, "主界面操作_聊天框隐藏_按钮")
	GUI:setAnchorPoint(Button_chat_hide, 0.00, 0.00)
	GUI:setTouchEnabled(Button_chat_hide, true)
	GUI:setTag(Button_chat_hide, -1)
	GUI:setVisible(Button_chat_hide, false)

	-- Create Node_quit_tip
	local Node_quit_tip = GUI:Node_Create(Main_Property, "Node_quit_tip", 0, 237)
	GUI:setChineseName(Node_quit_tip, "主界面_退出提示_节点")
	GUI:setTag(Node_quit_tip, -1)

	ui.update(__data__)
	return Main_Property
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
