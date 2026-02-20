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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/53dyd/sq1/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 801, 511, "res/custom/npc/close1.png")
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

	-- Create leftBtnList
	local leftBtnList = GUI:ListView_Create(FrameLayout, "leftBtnList", 73, 482, 120, 440, 1)
	GUI:ListView_setItemsMargin(leftBtnList, 2)
	GUI:setAnchorPoint(leftBtnList, 0.00, 1.00)
	GUI:setTouchEnabled(leftBtnList, true)
	GUI:setTag(leftBtnList, 0)

	-- Create leftBtn1
	local leftBtn1 = GUI:Button_Create(leftBtnList, "leftBtn1", 0, 396, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(leftBtn1, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn1, false)
	GUI:Button_setTitleText(leftBtn1, [[打野刀]])
	GUI:Button_setTitleColor(leftBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn1, 16)
	GUI:Button_titleEnableOutline(leftBtn1, "#000000", 1)
	GUI:setAnchorPoint(leftBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn1, true)
	GUI:setTag(leftBtn1, 0)

	-- Create leftBtn2
	local leftBtn2 = GUI:Button_Create(leftBtnList, "leftBtn2", 0, 350, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(leftBtn2, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn2, false)
	GUI:Button_setTitleText(leftBtn2, [[神器激活]])
	GUI:Button_setTitleColor(leftBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn2, 16)
	GUI:Button_titleEnableOutline(leftBtn2, "#000000", 1)
	GUI:setAnchorPoint(leftBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn2, true)
	GUI:setTag(leftBtn2, 0)

	-- Create leftBtn3
	local leftBtn3 = GUI:Button_Create(leftBtnList, "leftBtn3", 0, 304, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(leftBtn3, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn3, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn3, false)
	GUI:Button_setTitleText(leftBtn3, [[神器融合]])
	GUI:Button_setTitleColor(leftBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn3, 16)
	GUI:Button_titleEnableOutline(leftBtn3, "#000000", 1)
	GUI:setAnchorPoint(leftBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn3, true)
	GUI:setTag(leftBtn3, 0)

	-- Create leftBtn4
	local leftBtn4 = GUI:Button_Create(leftBtnList, "leftBtn4", 0, 258, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(leftBtn4, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn4, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn4, false)
	GUI:Button_setTitleText(leftBtn4, [[神器图鉴]])
	GUI:Button_setTitleColor(leftBtn4, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn4, 16)
	GUI:Button_titleEnableOutline(leftBtn4, "#000000", 1)
	GUI:setAnchorPoint(leftBtn4, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn4, true)
	GUI:setTag(leftBtn4, 0)

	-- Create leftBtn5
	local leftBtn5 = GUI:Button_Create(leftBtnList, "leftBtn5", 0, 212, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(leftBtn5, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn5, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn5, false)
	GUI:Button_setTitleText(leftBtn5, [[神器配置]])
	GUI:Button_setTitleColor(leftBtn5, "#ffffff")
	GUI:Button_setTitleFontSize(leftBtn5, 16)
	GUI:Button_titleEnableOutline(leftBtn5, "#000000", 1)
	GUI:setAnchorPoint(leftBtn5, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn5, true)
	GUI:setTag(leftBtn5, 0)

	-- Create midNode1
	local midNode1 = GUI:Node_Create(FrameLayout, "midNode1", 0, 0)
	GUI:setTag(midNode1, 0)
	GUI:setVisible(midNode1, false)

	-- Create equipNode1
	local equipNode1 = GUI:Node_Create(midNode1, "equipNode1", 0, 0)
	GUI:setTag(equipNode1, 0)

	-- Create nowEquip1
	local nowEquip1 = GUI:EquipShow_Create(equipNode1, "nowEquip1", 390, 373, 89, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = true, lookPlayer = false, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(nowEquip1)
	GUI:setAnchorPoint(nowEquip1, 0.50, 0.50)
	GUI:setTouchEnabled(nowEquip1, true)
	GUI:setMouseEnabled(nowEquip1, true)
	GUI:setTag(nowEquip1, 0)

	-- Create equipLevel1
	local equipLevel1 = GUI:Text_Create(equipNode1, "equipLevel1", 434, 299, 16, "#00ff00", [[0]])
	GUI:Text_enableOutline(equipLevel1, "#000000", 1)
	GUI:setAnchorPoint(equipLevel1, 0.00, 0.00)
	GUI:setTouchEnabled(equipLevel1, false)
	GUI:setTag(equipLevel1, 0)

	-- Create loadingBg1
	local loadingBg1 = GUI:Image_Create(equipNode1, "loadingBg1", 322, 256, "res/custom/npc/53dyd/sj/jd1.png")
	GUI:setContentSize(loadingBg1, 196, 22)
	GUI:setIgnoreContentAdaptWithSize(loadingBg1, false)
	GUI:setAnchorPoint(loadingBg1, 0.00, 0.00)
	GUI:setTouchEnabled(loadingBg1, false)
	GUI:setTag(loadingBg1, 0)

	-- Create LoadingBar1
	local LoadingBar1 = GUI:LoadingBar_Create(loadingBg1, "LoadingBar1", 0, 0, "res/custom/npc/53dyd/sj/jd2.png", 0)
	GUI:LoadingBar_setPercent(LoadingBar1, 0)
	GUI:setAnchorPoint(LoadingBar1, 0.00, 0.00)
	GUI:setTouchEnabled(LoadingBar1, false)
	GUI:setTag(LoadingBar1, 0)

	-- Create LoadingText1
	local LoadingText1 = GUI:Text_Create(loadingBg1, "LoadingText1", 96, 30, 15, "#ff9b00", [[]])
	GUI:Text_enableOutline(LoadingText1, "#000000", 1)
	GUI:setAnchorPoint(LoadingText1, 0.50, 0.50)
	GUI:setTouchEnabled(LoadingText1, false)
	GUI:setTag(LoadingText1, 0)

	-- Create RText11
	local RText11 = GUI:RichText_Create(equipNode1, "RText11", 242, 200, [[<font color='#ffffff' size='16' >打野刀经验值累计满可</font><font color='#00ff00' size='16' >升级</font><font color='#ffffff' size='16' >获得</font><font color='#00ff00' size='16' >成长属性</font><br><font color='#ffffff' size='16' >打野刀达成指定等级可</font><font color='#9b00ff' size='16' >晋升</font><font color='#ffffff' size='16' >激活</font><font color='#9b00ff' size='16' >专属神器</font>]], 300, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RText11, 0.00, 0.00)
	GUI:setTag(RText11, 0)

	-- Create infoBg1
	local infoBg1 = GUI:Image_Create(midNode1, "infoBg1", 580, 190, "res/custom/npc/53dyd/sj/czsx.png")
	GUI:setContentSize(infoBg1, 211, 279)
	GUI:setIgnoreContentAdaptWithSize(infoBg1, false)
	GUI:setAnchorPoint(infoBg1, 0.00, 0.00)
	GUI:setTouchEnabled(infoBg1, false)
	GUI:setTag(infoBg1, 0)

	-- Create textNode1
	local textNode1 = GUI:Node_Create(infoBg1, "textNode1", 108, 138)
	GUI:setTag(textNode1, 0)

	-- Create RText12
	local RText12 = GUI:RichText_Create(midNode1, "RText12", 236, 98, [[<font color='#ffffff' size='16' >每次</font><font color='#ff0000' size='16' >击杀怪物</font><font color='#ffffff' size='16' >可获得对应的打野刀</font><font color='#00ffe8' size='16' >经验进度</font><br><font color='#ffffff' size='16' > 每提交</font><font color='#00ff00' size='16' >1张书页</font><font color='#ffffff' size='16' >可获得</font><font color='#00ff00' size='16' >100点</font><font color='#ffffff' size='16' >打野刀</font><font color='#00ffe8' size='16' >经验值</font>]], 340, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RText12, 0.00, 0.00)
	GUI:setTag(RText12, 0)

	-- Create commitBtn11
	local commitBtn11 = GUI:Button_Create(midNode1, "commitBtn11", 316, 70, "res/custom/npc/53dyd/sj/a1.png")
	GUI:Button_loadTexturePressed(commitBtn11, "res/custom/npc/53dyd/sj/a2.png")
	GUI:Button_setScale9Slice(commitBtn11, 10, 10, 12, 12)
	GUI:Button_setTitleText(commitBtn11, [[]])
	GUI:Button_setTitleColor(commitBtn11, "#E8DCBD")
	GUI:Button_setTitleFontSize(commitBtn11, 18)
	GUI:Button_titleEnableOutline(commitBtn11, "#000000", 1)
	GUI:setAnchorPoint(commitBtn11, 0.50, 0.50)
	GUI:setTouchEnabled(commitBtn11, true)
	GUI:setTag(commitBtn11, 0)

	-- Create commitBtn12
	local commitBtn12 = GUI:Button_Create(midNode1, "commitBtn12", 458, 70, "res/custom/npc/53dyd/sj/an10.png")
	GUI:Button_loadTexturePressed(commitBtn12, "res/custom/npc/53dyd/sj/an11.png")
	GUI:Button_setScale9Slice(commitBtn12, 10, 10, 12, 12)
	GUI:Button_setTitleText(commitBtn12, [[]])
	GUI:Button_setTitleColor(commitBtn12, "#E8DCBD")
	GUI:Button_setTitleFontSize(commitBtn12, 18)
	GUI:Button_titleEnableOutline(commitBtn12, "#000000", 1)
	GUI:setAnchorPoint(commitBtn12, 0.50, 0.50)
	GUI:setTouchEnabled(commitBtn12, true)
	GUI:setTag(commitBtn12, 0)

	-- Create needItemNode1
	local needItemNode1 = GUI:Node_Create(midNode1, "needItemNode1", 686, 122)
	GUI:setTag(needItemNode1, 0)

	-- Create upBtn1
	local upBtn1 = GUI:Button_Create(midNode1, "upBtn1", 688, 64, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn1, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn1, 0, 0, 0, 0)
	GUI:setContentSize(upBtn1, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(upBtn1, false)
	GUI:Button_setTitleText(upBtn1, [[开始升级]])
	GUI:Button_setTitleColor(upBtn1, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn1, 18)
	GUI:Button_titleEnableOutline(upBtn1, "#000000", 1)
	GUI:setAnchorPoint(upBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn1, true)
	GUI:setTag(upBtn1, 0)

	-- Create maxImg1
	local maxImg1 = GUI:Image_Create(midNode1, "maxImg1", 690, 100, "res/custom/tag/c_103.png")
	GUI:setContentSize(maxImg1, 114, 66)
	GUI:setIgnoreContentAdaptWithSize(maxImg1, false)
	GUI:setAnchorPoint(maxImg1, 0.50, 0.50)
	GUI:setTouchEnabled(maxImg1, false)
	GUI:setTag(maxImg1, 0)
	GUI:setVisible(maxImg1, false)

	-- Create tipsBtn1
	local tipsBtn1 = GUI:Button_Create(midNode1, "tipsBtn1", 538, 440, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tipsBtn1, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn1, false)
	GUI:Button_setTitleText(tipsBtn1, [[]])
	GUI:Button_setTitleColor(tipsBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn1, 16)
	GUI:Button_titleEnableOutline(tipsBtn1, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn1, true)
	GUI:setTag(tipsBtn1, 0)

	-- Create midNode2
	local midNode2 = GUI:Node_Create(FrameLayout, "midNode2", 0, 0)
	GUI:setTag(midNode2, 0)

	-- Create tipsBtn2
	local tipsBtn2 = GUI:Button_Create(midNode2, "tipsBtn2", 748, 430, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tipsBtn2, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn2, false)
	GUI:Button_setTitleText(tipsBtn2, [[]])
	GUI:Button_setTitleColor(tipsBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn2, 16)
	GUI:Button_titleEnableOutline(tipsBtn2, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn2, true)
	GUI:setTag(tipsBtn2, 0)

	-- Create effect2
	local effect2 = GUI:Effect_Create(midNode2, "effect2", 472, 359, 0, 5056, 0, 0, 0, 1)
	GUI:setTag(effect2, 0)

	-- Create activeBtn21
	local activeBtn21 = GUI:Button_Create(midNode2, "activeBtn21", 408, 188, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(activeBtn21, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(activeBtn21, 0, 0, 0, 0)
	GUI:setContentSize(activeBtn21, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(activeBtn21, false)
	GUI:Button_setTitleText(activeBtn21, [[激活1次]])
	GUI:Button_setTitleColor(activeBtn21, "#E8DCBD")
	GUI:Button_setTitleFontSize(activeBtn21, 18)
	GUI:Button_titleEnableOutline(activeBtn21, "#000000", 1)
	GUI:setAnchorPoint(activeBtn21, 0.50, 0.50)
	GUI:setTouchEnabled(activeBtn21, true)
	GUI:setTag(activeBtn21, 0)

	-- Create activeBtn22
	local activeBtn22 = GUI:Button_Create(midNode2, "activeBtn22", 588, 188, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(activeBtn22, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(activeBtn22, 0, 0, 0, 0)
	GUI:setContentSize(activeBtn22, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(activeBtn22, false)
	GUI:Button_setTitleText(activeBtn22, [[激活10次]])
	GUI:Button_setTitleColor(activeBtn22, "#E8DCBD")
	GUI:Button_setTitleFontSize(activeBtn22, 18)
	GUI:Button_titleEnableOutline(activeBtn22, "#000000", 1)
	GUI:setAnchorPoint(activeBtn22, 0.50, 0.50)
	GUI:setTouchEnabled(activeBtn22, true)
	GUI:setTag(activeBtn22, 0)

	-- Create downBg2
	local downBg2 = GUI:Image_Create(midNode2, "downBg2", 496, 110, "res/custom/npc/53dyd/sq1/downBg.png")
	GUI:setContentSize(downBg2, 383, 29)
	GUI:setIgnoreContentAdaptWithSize(downBg2, false)
	GUI:setAnchorPoint(downBg2, 0.50, 0.50)
	GUI:setTouchEnabled(downBg2, false)
	GUI:setTag(downBg2, 0)

	-- Create hasText21
	local hasText21 = GUI:Text_Create(downBg2, "hasText21", 130, 2, 16, "#ffffff", [[拥有：]])
	GUI:Text_enableOutline(hasText21, "#000000", 1)
	GUI:setAnchorPoint(hasText21, 0.00, 0.00)
	GUI:setTouchEnabled(hasText21, false)
	GUI:setTag(hasText21, 0)

	-- Create hasText22
	local hasText22 = GUI:Text_Create(hasText21, "hasText22", 48, 0, 16, "#00ff00", [[神器魔盒*0]])
	GUI:Text_enableOutline(hasText22, "#000000", 1)
	GUI:setAnchorPoint(hasText22, 0.00, 0.00)
	GUI:setTouchEnabled(hasText22, false)
	GUI:setTag(hasText22, 0)

	-- Create RText2
	local RText2 = GUI:RichText_Create(midNode2, "RText2", 507, 54, [[<font color='#efe5dc' size='16' >每次激活，需要：</font><font color='#ffff00' size='16' >神器魔盒*1</font><font color='#ffffff' size='16' >，</font><font color='#eee4db' size='16' >随机获得：</font><font color='#fe00f5' size='16' >1件神器</font>]], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RText2, 0.50, 0.50)
	GUI:setTag(RText2, 0)

	-- Create boxAnimNode2
	local boxAnimNode2 = GUI:Node_Create(midNode2, "boxAnimNode2", 0, 0)
	GUI:setTag(boxAnimNode2, 0)
	GUI:setVisible(boxAnimNode2, false)

	-- Create bgLayout2
	local bgLayout2 = GUI:Layout_Create(boxAnimNode2, "bgLayout2", 466, 246, 60, 200, true)
	GUI:setAnchorPoint(bgLayout2, 0.00, 0.00)
	GUI:setTouchEnabled(bgLayout2, false)
	GUI:setTag(bgLayout2, 0)

	-- Create itemList21
	local itemList21 = GUI:ListView_Create(bgLayout2, "itemList21", 0, 73, 300, 60, 2)
	GUI:ListView_setGravity(itemList21, 3)
	GUI:setAnchorPoint(itemList21, 0.00, 0.00)
	GUI:setTouchEnabled(itemList21, true)
	GUI:setTag(itemList21, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(itemList21, "ItemShow_1", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(itemList21, "ItemShow_2", 90, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(itemList21, "ItemShow_3", 150, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(itemList21, "ItemShow_4", 210, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(itemList21, "ItemShow_5", 270, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create itemList22
	local itemList22 = GUI:ListView_Create(bgLayout2, "itemList22", 300, 73, 300, 60, 2)
	GUI:ListView_setGravity(itemList22, 3)
	GUI:setAnchorPoint(itemList22, 0.00, 0.00)
	GUI:setTouchEnabled(itemList22, true)
	GUI:setTag(itemList22, 0)

	-- Create ItemShow_1
	ItemShow_1 = GUI:ItemShow_Create(itemList22, "ItemShow_1", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create ItemShow_2
	ItemShow_2 = GUI:ItemShow_Create(itemList22, "ItemShow_2", 90, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create ItemShow_3
	ItemShow_3 = GUI:ItemShow_Create(itemList22, "ItemShow_3", 150, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create ItemShow_4
	ItemShow_4 = GUI:ItemShow_Create(itemList22, "ItemShow_4", 210, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create ItemShow_5
	ItemShow_5 = GUI:ItemShow_Create(itemList22, "ItemShow_5", 270, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create colorLayout21
	local colorLayout21 = GUI:Layout_Create(bgLayout2, "colorLayout21", 0, 0, 113, 200, false)
	GUI:Layout_setBackGroundColorType(colorLayout21, 1)
	GUI:Layout_setBackGroundColor(colorLayout21, "#2c292a")
	GUI:Layout_setBackGroundColorOpacity(colorLayout21, 76)
	GUI:setAnchorPoint(colorLayout21, 0.00, 0.00)
	GUI:setTouchEnabled(colorLayout21, false)
	GUI:setTag(colorLayout21, 0)
	GUI:setVisible(colorLayout21, false)

	-- Create colorLayout22
	local colorLayout22 = GUI:Layout_Create(bgLayout2, "colorLayout22", 183, 0, 112, 200, false)
	GUI:Layout_setBackGroundColorType(colorLayout22, 1)
	GUI:Layout_setBackGroundColor(colorLayout22, "#2c292a")
	GUI:Layout_setBackGroundColorOpacity(colorLayout22, 76)
	GUI:setAnchorPoint(colorLayout22, 0.00, 0.00)
	GUI:setTouchEnabled(colorLayout22, false)
	GUI:setTag(colorLayout22, 0)
	GUI:setVisible(colorLayout22, false)

	-- Create midNode3
	local midNode3 = GUI:Node_Create(FrameLayout, "midNode3", 0, 0)
	GUI:setTag(midNode3, 0)
	GUI:setVisible(midNode3, false)

	-- Create effect3
	local effect3 = GUI:Effect_Create(midNode3, "effect3", 378, 360, 0, 5056, 0, 0, 0, 1)
	GUI:setTag(effect3, 0)

	-- Create downBoxList3
	local downBoxList3 = GUI:ListView_Create(midNode3, "downBoxList3", 214, 154, 382, 60, 2)
	GUI:ListView_setGravity(downBoxList3, 3)
	GUI:ListView_setItemsMargin(downBoxList3, 22)
	GUI:setAnchorPoint(downBoxList3, 0.00, 0.00)
	GUI:setTouchEnabled(downBoxList3, false)
	GUI:setTag(downBoxList3, 0)

	-- Create downBg31
	local downBg31 = GUI:Image_Create(downBoxList3, "downBg31", 0, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(downBg31, 0.00, 0.00)
	GUI:setTouchEnabled(downBg31, false)
	GUI:setTag(downBg31, 0)

	-- Create downBg32
	local downBg32 = GUI:Image_Create(downBoxList3, "downBg32", 80, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(downBg32, 0.00, 0.00)
	GUI:setTouchEnabled(downBg32, false)
	GUI:setTag(downBg32, 0)

	-- Create downBg33
	local downBg33 = GUI:Image_Create(downBoxList3, "downBg33", 160, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(downBg33, 0.00, 0.00)
	GUI:setTouchEnabled(downBg33, false)
	GUI:setTag(downBg33, 0)

	-- Create downBg34
	local downBg34 = GUI:Image_Create(downBoxList3, "downBg34", 240, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(downBg34, 0.00, 0.00)
	GUI:setTouchEnabled(downBg34, false)
	GUI:setTag(downBg34, 0)

	-- Create downBg35
	local downBg35 = GUI:Image_Create(downBoxList3, "downBg35", 320, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(downBg35, 0.00, 0.00)
	GUI:setTouchEnabled(downBg35, false)
	GUI:setTag(downBg35, 0)

	-- Create rightList3
	local rightList3 = GUI:ListView_Create(midNode3, "rightList3", 615, 36, 190, 414, 1)
	GUI:ListView_setItemsMargin(rightList3, 4)
	GUI:setAnchorPoint(rightList3, 0.00, 0.00)
	GUI:setTouchEnabled(rightList3, true)
	GUI:setTag(rightList3, 0)

	-- Create rightSmallList31
	local rightSmallList31 = GUI:ListView_Create(rightList3, "rightSmallList31", 0, 356, 186, 58, 2)
	GUI:ListView_setGravity(rightSmallList31, 3)
	GUI:ListView_setItemsMargin(rightSmallList31, 4)
	GUI:setAnchorPoint(rightSmallList31, 0.00, 0.00)
	GUI:setTouchEnabled(rightSmallList31, true)
	GUI:setTag(rightSmallList31, 0)

	-- Create rightBox311
	local rightBox311 = GUI:Image_Create(rightSmallList31, "rightBox311", 0, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox311, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox311, false)
	GUI:setTag(rightBox311, 0)

	-- Create rightBox312
	local rightBox312 = GUI:Image_Create(rightSmallList31, "rightBox312", 62, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox312, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox312, false)
	GUI:setTag(rightBox312, 0)

	-- Create rightBox313
	local rightBox313 = GUI:Image_Create(rightSmallList31, "rightBox313", 124, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox313, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox313, false)
	GUI:setTag(rightBox313, 0)

	-- Create rightSmallList32
	local rightSmallList32 = GUI:ListView_Create(rightList3, "rightSmallList32", 0, 294, 186, 58, 2)
	GUI:ListView_setGravity(rightSmallList32, 3)
	GUI:ListView_setItemsMargin(rightSmallList32, 4)
	GUI:setAnchorPoint(rightSmallList32, 0.00, 0.00)
	GUI:setTouchEnabled(rightSmallList32, true)
	GUI:setTag(rightSmallList32, 0)

	-- Create rightBox311
	rightBox311 = GUI:Image_Create(rightSmallList32, "rightBox311", 0, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox311, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox311, false)
	GUI:setTag(rightBox311, 0)

	-- Create rightBox312
	rightBox312 = GUI:Image_Create(rightSmallList32, "rightBox312", 62, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox312, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox312, false)
	GUI:setTag(rightBox312, 0)

	-- Create rightBox313
	rightBox313 = GUI:Image_Create(rightSmallList32, "rightBox313", 124, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox313, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox313, false)
	GUI:setTag(rightBox313, 0)

	-- Create rightSmallList31_2
	local rightSmallList31_2 = GUI:ListView_Create(rightList3, "rightSmallList31_2", 0, 232, 186, 58, 2)
	GUI:ListView_setGravity(rightSmallList31_2, 3)
	GUI:ListView_setItemsMargin(rightSmallList31_2, 4)
	GUI:setAnchorPoint(rightSmallList31_2, 0.00, 0.00)
	GUI:setTouchEnabled(rightSmallList31_2, true)
	GUI:setTag(rightSmallList31_2, 0)

	-- Create rightBox311
	rightBox311 = GUI:Image_Create(rightSmallList31_2, "rightBox311", 0, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox311, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox311, false)
	GUI:setTag(rightBox311, 0)

	-- Create rightBox312
	rightBox312 = GUI:Image_Create(rightSmallList31_2, "rightBox312", 62, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox312, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox312, false)
	GUI:setTag(rightBox312, 0)

	-- Create rightBox313
	rightBox313 = GUI:Image_Create(rightSmallList31_2, "rightBox313", 124, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox313, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox313, false)
	GUI:setTag(rightBox313, 0)

	-- Create rightSmallList31_3
	local rightSmallList31_3 = GUI:ListView_Create(rightList3, "rightSmallList31_3", 0, 170, 186, 58, 2)
	GUI:ListView_setGravity(rightSmallList31_3, 3)
	GUI:ListView_setItemsMargin(rightSmallList31_3, 4)
	GUI:setAnchorPoint(rightSmallList31_3, 0.00, 0.00)
	GUI:setTouchEnabled(rightSmallList31_3, true)
	GUI:setTag(rightSmallList31_3, 0)

	-- Create rightBox311
	rightBox311 = GUI:Image_Create(rightSmallList31_3, "rightBox311", 0, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox311, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox311, false)
	GUI:setTag(rightBox311, 0)

	-- Create rightBox312
	rightBox312 = GUI:Image_Create(rightSmallList31_3, "rightBox312", 62, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox312, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox312, false)
	GUI:setTag(rightBox312, 0)

	-- Create rightBox313
	rightBox313 = GUI:Image_Create(rightSmallList31_3, "rightBox313", 124, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox313, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox313, false)
	GUI:setTag(rightBox313, 0)

	-- Create rightSmallList31_4
	local rightSmallList31_4 = GUI:ListView_Create(rightList3, "rightSmallList31_4", 0, 108, 186, 58, 2)
	GUI:ListView_setGravity(rightSmallList31_4, 3)
	GUI:ListView_setItemsMargin(rightSmallList31_4, 4)
	GUI:setAnchorPoint(rightSmallList31_4, 0.00, 0.00)
	GUI:setTouchEnabled(rightSmallList31_4, true)
	GUI:setTag(rightSmallList31_4, 0)

	-- Create rightBox311
	rightBox311 = GUI:Image_Create(rightSmallList31_4, "rightBox311", 0, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox311, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox311, false)
	GUI:setTag(rightBox311, 0)

	-- Create rightBox312
	rightBox312 = GUI:Image_Create(rightSmallList31_4, "rightBox312", 62, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox312, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox312, false)
	GUI:setTag(rightBox312, 0)

	-- Create rightBox313
	rightBox313 = GUI:Image_Create(rightSmallList31_4, "rightBox313", 124, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox313, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox313, false)
	GUI:setTag(rightBox313, 0)

	-- Create rightSmallList31_5
	local rightSmallList31_5 = GUI:ListView_Create(rightList3, "rightSmallList31_5", 0, 46, 186, 58, 2)
	GUI:ListView_setGravity(rightSmallList31_5, 3)
	GUI:ListView_setItemsMargin(rightSmallList31_5, 4)
	GUI:setAnchorPoint(rightSmallList31_5, 0.00, 0.00)
	GUI:setTouchEnabled(rightSmallList31_5, true)
	GUI:setTag(rightSmallList31_5, 0)

	-- Create rightBox311
	rightBox311 = GUI:Image_Create(rightSmallList31_5, "rightBox311", 0, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox311, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox311, false)
	GUI:setTag(rightBox311, 0)

	-- Create rightBox312
	rightBox312 = GUI:Image_Create(rightSmallList31_5, "rightBox312", 62, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox312, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox312, false)
	GUI:setTag(rightBox312, 0)

	-- Create rightBox313
	rightBox313 = GUI:Image_Create(rightSmallList31_5, "rightBox313", 124, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox313, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox313, false)
	GUI:setTag(rightBox313, 0)

	-- Create rightSmallList31_6
	local rightSmallList31_6 = GUI:ListView_Create(rightList3, "rightSmallList31_6", 0, -16, 186, 58, 2)
	GUI:ListView_setGravity(rightSmallList31_6, 3)
	GUI:ListView_setItemsMargin(rightSmallList31_6, 4)
	GUI:setAnchorPoint(rightSmallList31_6, 0.00, 0.00)
	GUI:setTouchEnabled(rightSmallList31_6, true)
	GUI:setTag(rightSmallList31_6, 0)

	-- Create rightBox311
	rightBox311 = GUI:Image_Create(rightSmallList31_6, "rightBox311", 0, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox311, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox311, false)
	GUI:setTag(rightBox311, 0)

	-- Create rightBox312
	rightBox312 = GUI:Image_Create(rightSmallList31_6, "rightBox312", 62, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox312, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox312, false)
	GUI:setTag(rightBox312, 0)

	-- Create rightBox313
	rightBox313 = GUI:Image_Create(rightSmallList31_6, "rightBox313", 124, 0, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(rightBox313, 0.00, 0.00)
	GUI:setTouchEnabled(rightBox313, false)
	GUI:setTag(rightBox313, 0)

	-- Create upBtn3
	local upBtn3 = GUI:Button_Create(midNode3, "upBtn3", 404, 114, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn3, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn3, 0, 0, 0, 0)
	GUI:setContentSize(upBtn3, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(upBtn3, false)
	GUI:Button_setTitleText(upBtn3, [[开始融合]])
	GUI:Button_setTitleColor(upBtn3, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn3, 18)
	GUI:Button_titleEnableOutline(upBtn3, "#000000", 1)
	GUI:setAnchorPoint(upBtn3, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn3, true)
	GUI:setTag(upBtn3, 0)

	-- Create RText3
	local RText3 = GUI:RichText_Create(midNode3, "RText3", 208, 38, [[<font color='#ffffff' size='16' >       放入</font><font color='#00ff00' size='16' >3-5个</font><font color='#ffffff' size='16' >同品质神器，可随机合出</font><font color='#ffff00' size='16' >更高级</font><font color='#ffffff' size='16' >的神器</font><br><font color='#ffffff' size='16' >如若放入</font><font color='#00ff00' size='16' >5个相同</font><font color='#ffffff' size='16' >的神器，必定合成</font><font color='#ffff00' size='16' >对应系列</font><font color='#ffffff' size='16' >下一阶神器</font>]], 420, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RText3, 0.00, 0.00)
	GUI:setTag(RText3, 0)

	-- Create tipsBtn3
	local tipsBtn3 = GUI:Button_Create(midNode3, "tipsBtn3", 558, 440, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tipsBtn3, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn3, false)
	GUI:Button_setTitleText(tipsBtn3, [[]])
	GUI:Button_setTitleColor(tipsBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn3, 16)
	GUI:Button_titleEnableOutline(tipsBtn3, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn3, true)
	GUI:setTag(tipsBtn3, 0)
	GUI:setVisible(tipsBtn3, false)

	-- Create midNode4
	local midNode4 = GUI:Node_Create(FrameLayout, "midNode4", 0, 0)
	GUI:setTag(midNode4, 0)
	GUI:setVisible(midNode4, false)

	-- Create upList4
	local upList4 = GUI:ListView_Create(midNode4, "upList4", 252, 393, 506, 72, 2)
	GUI:ListView_setClippingEnabled(upList4, false)
	GUI:ListView_setGravity(upList4, 3)
	GUI:ListView_setItemsMargin(upList4, 36)
	GUI:setAnchorPoint(upList4, 0.00, 0.00)
	GUI:setTouchEnabled(upList4, true)
	GUI:setTag(upList4, 0)

	-- Create typeBox41
	local typeBox41 = GUI:Image_Create(upList4, "typeBox41", 0, 1, "res/custom/npc/53dyd/sq3/typeBg.png")
	GUI:setAnchorPoint(typeBox41, 0.00, 0.00)
	GUI:setTouchEnabled(typeBox41, false)
	GUI:setTag(typeBox41, 0)

	-- Create typeBtn41
	local typeBtn41 = GUI:Button_Create(typeBox41, "typeBtn41", 36, 34, "res/custom/npc/53dyd/sq3/icon1.png")
	GUI:setContentSize(typeBtn41, 62, 58)
	GUI:setIgnoreContentAdaptWithSize(typeBtn41, false)
	GUI:Button_setTitleText(typeBtn41, [[]])
	GUI:Button_setTitleColor(typeBtn41, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn41, 16)
	GUI:Button_titleEnableOutline(typeBtn41, "#000000", 1)
	GUI:setAnchorPoint(typeBtn41, 0.50, 0.50)
	GUI:setTouchEnabled(typeBtn41, true)
	GUI:setTag(typeBtn41, 0)

	-- Create selectBox4
	local selectBox4 = GUI:Image_Create(typeBox41, "selectBox4", 2, 2, "res/custom/npc/53dyd/sq3/select.png")
	GUI:setAnchorPoint(selectBox4, 0.00, 0.00)
	GUI:setTouchEnabled(selectBox4, false)
	GUI:setTag(selectBox4, 0)

	-- Create selectArrow4
	local selectArrow4 = GUI:Image_Create(typeBox41, "selectArrow4", 22, -28, "res/custom/npc/53dyd/sq3/arrow.png")
	GUI:setAnchorPoint(selectArrow4, 0.00, 0.00)
	GUI:setTouchEnabled(selectArrow4, false)
	GUI:setTag(selectArrow4, 0)

	-- Create typeBox42
	local typeBox42 = GUI:Image_Create(upList4, "typeBox42", 107, 1, "res/custom/npc/53dyd/sq3/typeBg.png")
	GUI:setAnchorPoint(typeBox42, 0.00, 0.00)
	GUI:setTouchEnabled(typeBox42, false)
	GUI:setTag(typeBox42, 0)

	-- Create typeBtn42
	local typeBtn42 = GUI:Button_Create(typeBox42, "typeBtn42", 36, 34, "res/custom/npc/53dyd/sq3/icon2.png")
	GUI:setContentSize(typeBtn42, 62, 58)
	GUI:setIgnoreContentAdaptWithSize(typeBtn42, false)
	GUI:Button_setTitleText(typeBtn42, [[]])
	GUI:Button_setTitleColor(typeBtn42, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn42, 16)
	GUI:Button_titleEnableOutline(typeBtn42, "#000000", 1)
	GUI:setAnchorPoint(typeBtn42, 0.50, 0.50)
	GUI:setTouchEnabled(typeBtn42, true)
	GUI:setTag(typeBtn42, 0)

	-- Create typeBox43
	local typeBox43 = GUI:Image_Create(upList4, "typeBox43", 214, 1, "res/custom/npc/53dyd/sq3/typeBg.png")
	GUI:setAnchorPoint(typeBox43, 0.00, 0.00)
	GUI:setTouchEnabled(typeBox43, false)
	GUI:setTag(typeBox43, 0)

	-- Create typeBtn43
	local typeBtn43 = GUI:Button_Create(typeBox43, "typeBtn43", 35, 34, "res/custom/npc/53dyd/sq3/icon3.png")
	GUI:setContentSize(typeBtn43, 62, 58)
	GUI:setIgnoreContentAdaptWithSize(typeBtn43, false)
	GUI:Button_setTitleText(typeBtn43, [[]])
	GUI:Button_setTitleColor(typeBtn43, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn43, 16)
	GUI:Button_titleEnableOutline(typeBtn43, "#000000", 1)
	GUI:setAnchorPoint(typeBtn43, 0.50, 0.50)
	GUI:setTouchEnabled(typeBtn43, true)
	GUI:setTag(typeBtn43, 0)

	-- Create typeBox44
	local typeBox44 = GUI:Image_Create(upList4, "typeBox44", 321, 1, "res/custom/npc/53dyd/sq3/typeBg.png")
	GUI:setAnchorPoint(typeBox44, 0.00, 0.00)
	GUI:setTouchEnabled(typeBox44, false)
	GUI:setTag(typeBox44, 0)

	-- Create typeBtn44
	local typeBtn44 = GUI:Button_Create(typeBox44, "typeBtn44", 36, 34, "res/custom/npc/53dyd/sq3/icon4.png")
	GUI:setContentSize(typeBtn44, 62, 58)
	GUI:setIgnoreContentAdaptWithSize(typeBtn44, false)
	GUI:Button_setTitleText(typeBtn44, [[]])
	GUI:Button_setTitleColor(typeBtn44, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn44, 16)
	GUI:Button_titleEnableOutline(typeBtn44, "#000000", 1)
	GUI:setAnchorPoint(typeBtn44, 0.50, 0.50)
	GUI:setTouchEnabled(typeBtn44, true)
	GUI:setTag(typeBtn44, 0)

	-- Create typeBox45
	local typeBox45 = GUI:Image_Create(upList4, "typeBox45", 428, 1, "res/custom/npc/53dyd/sq3/typeBg.png")
	GUI:setAnchorPoint(typeBox45, 0.00, 0.00)
	GUI:setTouchEnabled(typeBox45, false)
	GUI:setTag(typeBox45, 0)

	-- Create typeBtn45
	local typeBtn45 = GUI:Button_Create(typeBox45, "typeBtn45", 39, 33, "res/custom/npc/53dyd/sq3/icon5.png")
	GUI:setContentSize(typeBtn45, 62, 58)
	GUI:setIgnoreContentAdaptWithSize(typeBtn45, false)
	GUI:Button_setTitleText(typeBtn45, [[]])
	GUI:Button_setTitleColor(typeBtn45, "#ffffff")
	GUI:Button_setTitleFontSize(typeBtn45, 16)
	GUI:Button_titleEnableOutline(typeBtn45, "#000000", 1)
	GUI:setAnchorPoint(typeBtn45, 0.50, 0.50)
	GUI:setTouchEnabled(typeBtn45, true)
	GUI:setTag(typeBtn45, 0)

	-- Create textNode4
	local textNode4 = GUI:Node_Create(midNode4, "textNode4", 0, 0)
	GUI:setTag(textNode4, 0)

	-- Create Rtext41
	local Rtext41 = GUI:RichText_Create(textNode4, "Rtext41", 502, 290, [[<font color='#ffffff' size='16' >                                          图鉴类型：</font><font color='#00ff00' size='16' >普通</font><br><font color='#ffffff' size='16' >                                单个图鉴属性：</font><font color='#ffff00' size='16' >生命值+2%</font><br><font color='#ffffff' size='16' >全套拥有属性：</font><font color='#ff00f6' size='16' >受战减伤+2%，受法减伤+2%，受道士减伤+2%</font>]], 500, 16, "#ffffff", 4)
	GUI:setAnchorPoint(Rtext41, 0.50, 0.50)
	GUI:setTag(Rtext41, 0)
	GUI:setVisible(Rtext41, false)

	-- Create Rtext42
	local Rtext42 = GUI:RichText_Create(textNode4, "Rtext42", 502, 290, [[<font color='#ffffff' size='16' >                                          图鉴类型：</font><font color='#00ff00' size='16' >稀有</font><br><font color='#ffffff' size='16' >                          单个图鉴属性：</font><font color='#ffff00' size='16' >防御+1%，魔防+1%</font><br><font color='#ffffff' size='16' >全套拥有属性：</font><font color='#ff00f6' size='16' >受战减伤+3%，受法减伤+3%，受道士减伤+3%</font>]], 500, 16, "#ffffff", 4)
	GUI:setAnchorPoint(Rtext42, 0.50, 0.50)
	GUI:setTag(Rtext42, 0)
	GUI:setVisible(Rtext42, false)

	-- Create Rtext43
	local Rtext43 = GUI:RichText_Create(textNode4, "Rtext43", 502, 290, [[<font color='#ffffff' size='16' >                                          图鉴类型：</font><font color='#00ff00' size='16' >史诗</font><br><font color='#ffffff' size='16' >                      单个图鉴属性：</font><font color='#ffff00' size='16' >生命值+1%，攻魔道+1%</font><br><font color='#ffffff' size='16' >全套拥有属性：</font><font color='#ff00f6' size='16' >受战减伤+4%，受法减伤+4%，受道士减伤+4%</font>]], 500, 16, "#ffffff", 4)
	GUI:setAnchorPoint(Rtext43, 0.50, 0.50)
	GUI:setTag(Rtext43, 0)
	GUI:setVisible(Rtext43, false)

	-- Create Rtext44
	local Rtext44 = GUI:RichText_Create(textNode4, "Rtext44", 502, 290, [[<font color='#ffffff' size='16' >                                          图鉴类型：</font><font color='#00ff00' size='16' >传说</font><br><font color='#ffffff' size='16' >                      单个图鉴属性：</font><font color='#ffff00' size='16' >生命值+2%，PK减伤+1%</font><br><font color='#ffffff' size='16' >全套拥有属性：</font><font color='#ff00f6' size='16' >受战减伤+5%，受法减伤+5%，受道士减伤+5%</font>]], 500, 16, "#ffffff", 4)
	GUI:setAnchorPoint(Rtext44, 0.50, 0.50)
	GUI:setTag(Rtext44, 0)
	GUI:setVisible(Rtext44, false)

	-- Create Rtext45
	local Rtext45 = GUI:RichText_Create(textNode4, "Rtext45", 502, 290, [[<font color='#ffffff' size='16' >                                          图鉴类型：</font><font color='#00ff00' size='16' >上古</font><br><font color='#ffffff' size='16' >                      单个图鉴属性：</font><font color='#ffff00' size='16' >生命值+3%，PK增伤+1%</font><br><font color='#ffffff' size='16' >全套拥有属性：</font><font color='#ff00f6' size='16' >受战减伤+6%，受法减伤+6%，受道士减伤+6%</font>]], 500, 16, "#ffffff", 4)
	GUI:setAnchorPoint(Rtext45, 0.50, 0.50)
	GUI:setTag(Rtext45, 0)

	-- Create tipsBtn4
	local tipsBtn4 = GUI:Button_Create(midNode4, "tipsBtn4", 756, 332, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tipsBtn4, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn4, false)
	GUI:Button_setTitleText(tipsBtn4, [[]])
	GUI:Button_setTitleColor(tipsBtn4, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn4, 16)
	GUI:Button_titleEnableOutline(tipsBtn4, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn4, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn4, true)
	GUI:setTag(tipsBtn4, 0)
	GUI:setVisible(tipsBtn4, false)

	-- Create equipBoxList4
	local equipBoxList4 = GUI:ListView_Create(midNode4, "equipBoxList4", 241, 98, 524, 60, 2)
	GUI:ListView_setClippingEnabled(equipBoxList4, false)
	GUI:ListView_setGravity(equipBoxList4, 3)
	GUI:ListView_setItemsMargin(equipBoxList4, 34)
	GUI:setAnchorPoint(equipBoxList4, 0.00, 0.00)
	GUI:setTouchEnabled(equipBoxList4, true)
	GUI:setTag(equipBoxList4, 0)

	-- Create equipBox41
	local equipBox41 = GUI:Image_Create(equipBoxList4, "equipBox41", 0, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(equipBox41, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox41, false)
	GUI:setTag(equipBox41, 0)

	-- Create statuBtn41
	local statuBtn41 = GUI:Button_Create(equipBox41, "statuBtn41", -4, -38, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(statuBtn41, "res/custom/npc/anb1.png")
	GUI:Button_setScale9Slice(statuBtn41, 0, 0, 0, 0)
	GUI:setContentSize(statuBtn41, 67, 30)
	GUI:setIgnoreContentAdaptWithSize(statuBtn41, false)
	GUI:Button_setTitleText(statuBtn41, [[已拥有]])
	GUI:Button_setTitleColor(statuBtn41, "#00ff00")
	GUI:Button_setTitleFontSize(statuBtn41, 15)
	GUI:Button_titleEnableOutline(statuBtn41, "#000000", 1)
	GUI:setAnchorPoint(statuBtn41, 0.00, 0.00)
	GUI:setTouchEnabled(statuBtn41, true)
	GUI:setTag(statuBtn41, 0)

	-- Create equipShow41
	local equipShow41 = GUI:ItemShow_Create(equipBox41, "equipShow41", -1, -1, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(equipShow41, 0.00, 0.00)
	GUI:setTag(equipShow41, 0)

	-- Create equipBox42
	local equipBox42 = GUI:Image_Create(equipBoxList4, "equipBox42", 92, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(equipBox42, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox42, false)
	GUI:setTag(equipBox42, 0)

	-- Create statuBtn42
	local statuBtn42 = GUI:Button_Create(equipBox42, "statuBtn42", -4, -38, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(statuBtn42, "res/custom/npc/anb1.png")
	GUI:Button_setScale9Slice(statuBtn42, 0, 0, 0, 0)
	GUI:setContentSize(statuBtn42, 67, 30)
	GUI:setIgnoreContentAdaptWithSize(statuBtn42, false)
	GUI:Button_setTitleText(statuBtn42, [[已拥有]])
	GUI:Button_setTitleColor(statuBtn42, "#ff0000")
	GUI:Button_setTitleFontSize(statuBtn42, 15)
	GUI:Button_titleEnableOutline(statuBtn42, "#000000", 1)
	GUI:setAnchorPoint(statuBtn42, 0.00, 0.00)
	GUI:setTouchEnabled(statuBtn42, true)
	GUI:setTag(statuBtn42, 0)

	-- Create equipBox43
	local equipBox43 = GUI:Image_Create(equipBoxList4, "equipBox43", 184, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(equipBox43, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox43, false)
	GUI:setTag(equipBox43, 0)

	-- Create statuBtn43
	local statuBtn43 = GUI:Button_Create(equipBox43, "statuBtn43", -4, -38, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(statuBtn43, "res/custom/npc/anb1.png")
	GUI:Button_setScale9Slice(statuBtn43, 0, 0, 0, 0)
	GUI:setContentSize(statuBtn43, 67, 30)
	GUI:setIgnoreContentAdaptWithSize(statuBtn43, false)
	GUI:Button_setTitleText(statuBtn43, [[已拥有]])
	GUI:Button_setTitleColor(statuBtn43, "#E8DCBD")
	GUI:Button_setTitleFontSize(statuBtn43, 15)
	GUI:Button_titleEnableOutline(statuBtn43, "#000000", 1)
	GUI:setAnchorPoint(statuBtn43, 0.00, 0.00)
	GUI:setTouchEnabled(statuBtn43, true)
	GUI:setTag(statuBtn43, 0)

	-- Create equipBox44
	local equipBox44 = GUI:Image_Create(equipBoxList4, "equipBox44", 276, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(equipBox44, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox44, false)
	GUI:setTag(equipBox44, 0)

	-- Create statuBtn44
	local statuBtn44 = GUI:Button_Create(equipBox44, "statuBtn44", -4, -38, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(statuBtn44, "res/custom/npc/anb1.png")
	GUI:Button_setScale9Slice(statuBtn44, 0, 0, 0, 0)
	GUI:setContentSize(statuBtn44, 67, 30)
	GUI:setIgnoreContentAdaptWithSize(statuBtn44, false)
	GUI:Button_setTitleText(statuBtn44, [[已拥有]])
	GUI:Button_setTitleColor(statuBtn44, "#E8DCBD")
	GUI:Button_setTitleFontSize(statuBtn44, 15)
	GUI:Button_titleEnableOutline(statuBtn44, "#000000", 1)
	GUI:setAnchorPoint(statuBtn44, 0.00, 0.00)
	GUI:setTouchEnabled(statuBtn44, true)
	GUI:setTag(statuBtn44, 0)

	-- Create equipBox45
	local equipBox45 = GUI:Image_Create(equipBoxList4, "equipBox45", 368, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(equipBox45, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox45, false)
	GUI:setTag(equipBox45, 0)

	-- Create statuBtn45
	local statuBtn45 = GUI:Button_Create(equipBox45, "statuBtn45", -4, -38, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(statuBtn45, "res/custom/npc/anb1.png")
	GUI:Button_setScale9Slice(statuBtn45, 0, 0, 0, 0)
	GUI:setContentSize(statuBtn45, 67, 30)
	GUI:setIgnoreContentAdaptWithSize(statuBtn45, false)
	GUI:Button_setTitleText(statuBtn45, [[已拥有]])
	GUI:Button_setTitleColor(statuBtn45, "#E8DCBD")
	GUI:Button_setTitleFontSize(statuBtn45, 15)
	GUI:Button_titleEnableOutline(statuBtn45, "#000000", 1)
	GUI:setAnchorPoint(statuBtn45, 0.00, 0.00)
	GUI:setTouchEnabled(statuBtn45, true)
	GUI:setTag(statuBtn45, 0)

	-- Create equipBox46
	local equipBox46 = GUI:Image_Create(equipBoxList4, "equipBox46", 460, 2, "res/custom/npc/k1.png")
	GUI:setAnchorPoint(equipBox46, 0.00, 0.00)
	GUI:setTouchEnabled(equipBox46, false)
	GUI:setTag(equipBox46, 0)

	-- Create statuBtn46
	local statuBtn46 = GUI:Button_Create(equipBox46, "statuBtn46", -4, -38, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(statuBtn46, "res/custom/npc/anb1.png")
	GUI:Button_setScale9Slice(statuBtn46, 0, 0, 0, 0)
	GUI:setContentSize(statuBtn46, 67, 30)
	GUI:setIgnoreContentAdaptWithSize(statuBtn46, false)
	GUI:Button_setTitleText(statuBtn46, [[已拥有]])
	GUI:Button_setTitleColor(statuBtn46, "#E8DCBD")
	GUI:Button_setTitleFontSize(statuBtn46, 15)
	GUI:Button_titleEnableOutline(statuBtn46, "#000000", 1)
	GUI:setAnchorPoint(statuBtn46, 0.00, 0.00)
	GUI:setTouchEnabled(statuBtn46, true)
	GUI:setTag(statuBtn46, 0)

	-- Create midNode5
	local midNode5 = GUI:Node_Create(FrameLayout, "midNode5", 0, 0)
	GUI:setTag(midNode5, 0)
	GUI:setVisible(midNode5, false)

	-- Create rightList5
	local rightList5 = GUI:ListView_Create(midNode5, "rightList5", 194, 486, 610, 336, 1)
	GUI:ListView_setBounceEnabled(rightList5, true)
	GUI:setAnchorPoint(rightList5, 0.00, 1.00)
	GUI:setTouchEnabled(rightList5, true)
	GUI:setTag(rightList5, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(rightList5, "Image_1", 0, 256, "res/custom/npc/53dyd/pz/pt.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create select1
	local select1 = GUI:Image_Create(Image_1, "select1", 78, 22, "res/custom/npc/53dyd/pz/an2.png")
	GUI:setContentSize(select1, 33, 42)
	GUI:setIgnoreContentAdaptWithSize(select1, false)
	GUI:setAnchorPoint(select1, 0.00, 0.00)
	GUI:setTouchEnabled(select1, false)
	GUI:setTag(select1, 0)

	-- Create select2
	local select2 = GUI:Image_Create(Image_1, "select2", 564, 22, "res/custom/npc/53dyd/pz/an1.png")
	GUI:setContentSize(select2, 33, 42)
	GUI:setIgnoreContentAdaptWithSize(select2, false)
	GUI:setAnchorPoint(select2, 0.00, 0.00)
	GUI:setTouchEnabled(select2, false)
	GUI:setTag(select2, 0)

	-- Create iconList51
	local iconList51 = GUI:ListView_Create(Image_1, "iconList51", 120, 10, 434, 64, 2)
	GUI:ListView_setGravity(iconList51, 3)
	GUI:ListView_setItemsMargin(iconList51, 10)
	GUI:setAnchorPoint(iconList51, 0.00, 0.00)
	GUI:setTouchEnabled(iconList51, true)
	GUI:setTag(iconList51, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(iconList51, "Image_6", 0, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(Image_6, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(Image_6, false)
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create Image_12
	local Image_12 = GUI:Image_Create(Image_6, "Image_12", 6, 5, "res/custom/npc/53dyd/js/icon/bs_1.png")
	GUI:setAnchorPoint(Image_12, 0.00, 0.00)
	GUI:setTouchEnabled(Image_12, false)
	GUI:setTag(Image_12, 0)
	GUI:setVisible(Image_12, false)

	-- Create Image_13
	local Image_13 = GUI:Image_Create(Image_6, "Image_13", -3, -3, "res/custom/npc/53dyd/pz/xz.png")
	GUI:setAnchorPoint(Image_13, 0.00, 0.00)
	GUI:setTouchEnabled(Image_13, false)
	GUI:setTag(Image_13, 0)

	-- Create Image_7
	local Image_7 = GUI:Image_Create(iconList51, "Image_7", 74, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(Image_7, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(Image_7, false)
	GUI:setAnchorPoint(Image_7, 0.00, 0.00)
	GUI:setTouchEnabled(Image_7, false)
	GUI:setTag(Image_7, 0)

	-- Create Image_8
	local Image_8 = GUI:Image_Create(iconList51, "Image_8", 148, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(Image_8, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(Image_8, false)
	GUI:setAnchorPoint(Image_8, 0.00, 0.00)
	GUI:setTouchEnabled(Image_8, false)
	GUI:setTag(Image_8, 0)

	-- Create Image_9
	local Image_9 = GUI:Image_Create(iconList51, "Image_9", 222, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(Image_9, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(Image_9, false)
	GUI:setAnchorPoint(Image_9, 0.00, 0.00)
	GUI:setTouchEnabled(Image_9, false)
	GUI:setTag(Image_9, 0)

	-- Create Image_10
	local Image_10 = GUI:Image_Create(iconList51, "Image_10", 296, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(Image_10, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(Image_10, false)
	GUI:setAnchorPoint(Image_10, 0.00, 0.00)
	GUI:setTouchEnabled(Image_10, false)
	GUI:setTag(Image_10, 0)

	-- Create Image_11
	local Image_11 = GUI:Image_Create(iconList51, "Image_11", 370, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(Image_11, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(Image_11, false)
	GUI:setAnchorPoint(Image_11, 0.00, 0.00)
	GUI:setTouchEnabled(Image_11, false)
	GUI:setTag(Image_11, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(rightList5, "Image_2", 0, 176, "res/custom/npc/53dyd/pz/pt.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(rightList5, "Image_3", 0, 96, "res/custom/npc/53dyd/pz/pt.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(rightList5, "Image_4", 0, 16, "res/custom/npc/53dyd/pz/pt.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(rightList5, "Image_5", 0, -64, "res/custom/npc/53dyd/pz/pt.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create downList5
	local downList5 = GUI:ListView_Create(midNode5, "downList5", 208, 76, 442, 64, 2)
	GUI:ListView_setClippingEnabled(downList5, false)
	GUI:ListView_setGravity(downList5, 3)
	GUI:ListView_setItemsMargin(downList5, 30)
	GUI:setAnchorPoint(downList5, 0.00, 0.00)
	GUI:setTouchEnabled(downList5, true)
	GUI:setTag(downList5, 0)

	-- Create downBg51
	local downBg51 = GUI:Image_Create(downList5, "downBg51", 0, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(downBg51, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(downBg51, false)
	GUI:setAnchorPoint(downBg51, 0.00, 0.00)
	GUI:setTouchEnabled(downBg51, false)
	GUI:setTag(downBg51, 0)

	-- Create Image_12
	Image_12 = GUI:Image_Create(downBg51, "Image_12", 6, 5, "res/custom/npc/53dyd/js/icon/bs_1.png")
	GUI:setAnchorPoint(Image_12, 0.00, 0.00)
	GUI:setTouchEnabled(Image_12, false)
	GUI:setTag(Image_12, 0)

	-- Create Image_14
	local Image_14 = GUI:Image_Create(downBg51, "Image_14", 2, -40, "res/custom/npc/53dyd/pz/pdz.png")
	GUI:setAnchorPoint(Image_14, 0.00, 0.00)
	GUI:setTouchEnabled(Image_14, false)
	GUI:setTag(Image_14, 0)

	-- Create downBg52
	local downBg52 = GUI:Image_Create(downList5, "downBg52", 94, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(downBg52, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(downBg52, false)
	GUI:setAnchorPoint(downBg52, 0.00, 0.00)
	GUI:setTouchEnabled(downBg52, false)
	GUI:setTag(downBg52, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(downBg52, "Button_1", 2, -36, "res/custom/npc/anb1.png")
	GUI:Button_setScale9Slice(Button_1, 12, 12, 14, 14)
	GUI:setContentSize(Button_1, 60, 30)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[移除]])
	GUI:Button_setTitleColor(Button_1, "#e8dcbd")
	GUI:Button_setTitleFontSize(Button_1, 16)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create downBg53
	local downBg53 = GUI:Image_Create(downList5, "downBg53", 188, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(downBg53, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(downBg53, false)
	GUI:setAnchorPoint(downBg53, 0.00, 0.00)
	GUI:setTouchEnabled(downBg53, false)
	GUI:setTag(downBg53, 0)

	-- Create downBg54
	local downBg54 = GUI:Image_Create(downList5, "downBg54", 282, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(downBg54, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(downBg54, false)
	GUI:setAnchorPoint(downBg54, 0.00, 0.00)
	GUI:setTouchEnabled(downBg54, false)
	GUI:setTag(downBg54, 0)

	-- Create downBg55
	local downBg55 = GUI:Image_Create(downList5, "downBg55", 376, 0, "res/custom/npc/53dyd/pz/kuang.png")
	GUI:setContentSize(downBg55, 64, 64)
	GUI:setIgnoreContentAdaptWithSize(downBg55, false)
	GUI:setAnchorPoint(downBg55, 0.00, 0.00)
	GUI:setTouchEnabled(downBg55, false)
	GUI:setTag(downBg55, 0)

	-- Create tipsBtn5
	local tipsBtn5 = GUI:Button_Create(midNode5, "tipsBtn5", 720, 66, "res/custom/npc/53dyd/pz/tips.png")
	GUI:setContentSize(tipsBtn5, 64, 57)
	GUI:setIgnoreContentAdaptWithSize(tipsBtn5, false)
	GUI:Button_setTitleText(tipsBtn5, [[]])
	GUI:Button_setTitleColor(tipsBtn5, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn5, 16)
	GUI:Button_titleEnableOutline(tipsBtn5, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn5, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn5, true)
	GUI:setTag(tipsBtn5, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
