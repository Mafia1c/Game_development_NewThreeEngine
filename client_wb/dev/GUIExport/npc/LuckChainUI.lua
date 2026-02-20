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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/37xl/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

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

	-- Create leftBtnList
	local leftBtnList = GUI:ListView_Create(FrameLayout, "leftBtnList", 73, 484, 120, 440, 1)
	GUI:ListView_setItemsMargin(leftBtnList, 1)
	GUI:setAnchorPoint(leftBtnList, 0.00, 1.00)
	GUI:setTouchEnabled(leftBtnList, true)
	GUI:setTag(leftBtnList, 0)

	-- Create leftBtn1
	local leftBtn1 = GUI:Button_Create(leftBtnList, "leftBtn1", 0, 396, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(leftBtn1, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn1, false)
	GUI:Button_setTitleText(leftBtn1, [[幸运淬炼]])
	GUI:Button_setTitleColor(leftBtn1, "#BDBDB5")
	GUI:Button_setTitleFontSize(leftBtn1, 16)
	GUI:Button_titleEnableOutline(leftBtn1, "#000000", 1)
	GUI:setAnchorPoint(leftBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn1, true)
	GUI:setTag(leftBtn1, 0)

	-- Create leftBtn2
	local leftBtn2 = GUI:Button_Create(leftBtnList, "leftBtn2", 0, 351, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(leftBtn2, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn2, false)
	GUI:Button_setTitleText(leftBtn2, [[幸运转移]])
	GUI:Button_setTitleColor(leftBtn2, "#BDBDB5")
	GUI:Button_setTitleFontSize(leftBtn2, 16)
	GUI:Button_titleEnableOutline(leftBtn2, "#000000", 1)
	GUI:setAnchorPoint(leftBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn2, true)
	GUI:setTag(leftBtn2, 0)

	-- Create leftBtn3
	local leftBtn3 = GUI:Button_Create(leftBtnList, "leftBtn3", 0, 306, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(leftBtn3, "res/custom/npc/ta0.png")
	GUI:setContentSize(leftBtn3, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(leftBtn3, false)
	GUI:Button_setTitleText(leftBtn3, [[幸运觉醒]])
	GUI:Button_setTitleColor(leftBtn3, "#BDBDB5")
	GUI:Button_setTitleFontSize(leftBtn3, 16)
	GUI:Button_titleEnableOutline(leftBtn3, "#000000", 1)
	GUI:setAnchorPoint(leftBtn3, 0.00, 0.00)
	GUI:setTouchEnabled(leftBtn3, true)
	GUI:setTag(leftBtn3, 0)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create itemNode1
	local itemNode1 = GUI:Node_Create(midNode, "itemNode1", 280, 422)
	GUI:setTag(itemNode1, 0)

	-- Create itemNode2
	local itemNode2 = GUI:Node_Create(midNode, "itemNode2", 429, 422)
	GUI:setTag(itemNode2, 0)

	-- Create itemNode3
	local itemNode3 = GUI:Node_Create(midNode, "itemNode3", 354, 345)
	GUI:setTag(itemNode3, 0)

	-- Create infoNode1
	local infoNode1 = GUI:Node_Create(midNode, "infoNode1", 0, 0)
	GUI:setTag(infoNode1, 0)

	-- Create luckText11
	local luckText11 = GUI:Text_Create(infoNode1, "luckText11", 346, 256, 16, "#00ff00", [[？？]])
	GUI:Text_enableOutline(luckText11, "#000000", 1)
	GUI:setAnchorPoint(luckText11, 0.00, 0.00)
	GUI:setTouchEnabled(luckText11, false)
	GUI:setTag(luckText11, 0)

	-- Create oddText11
	local oddText11 = GUI:Text_Create(infoNode1, "oddText11", 384, 208, 16, "#ffff00", [[？？？]])
	GUI:Text_enableOutline(oddText11, "#000000", 1)
	GUI:setAnchorPoint(oddText11, 0.00, 0.00)
	GUI:setTouchEnabled(oddText11, false)
	GUI:setTag(oddText11, 0)

	-- Create nameText11
	local nameText11 = GUI:Text_Create(infoNode1, "nameText11", 384, 164, 16, "#00ffe8", [[？？？]])
	GUI:Text_enableOutline(nameText11, "#000000", 1)
	GUI:setAnchorPoint(nameText11, 0.00, 0.00)
	GUI:setTouchEnabled(nameText11, false)
	GUI:setTag(nameText11, 0)

	-- Create RichText11
	local RichText11 = GUI:RichText_Create(infoNode1, "RichText11", 528, 222, [==========[<font color='#ffffff' size='17' >仅限佩戴的项链进行幸运淬炼</font><br><font color='#ffffff' size='17' >项链幸运淬炼最高得</font><font color='#00ff00' size='17' >幸运+3</font><br><font color='#ffffff' size='17' >每次</font><font color='#00ff00' size='17' >淬炼幸运+3</font><font color='#ffffff' size='17' >即可随机获得</font><br><font color='#ffffff' size='17' >以下属性加成</font><br><br><br><br><br><font color='#ffffff' size='17' >暴击几率</font><font color='#f0b42a' size='17' >[1%-3%] </font><font color='#ffffff' size='17' >→ 当前：</font>]==========], 300, 16, "#00ff00", 4)
	GUI:setAnchorPoint(RichText11, 0.00, 0.00)
	GUI:setTag(RichText11, 0)

	-- Create numberText11
	local numberText11 = GUI:Text_Create(RichText11, "numberText11", 210, 0, 17, "#00ff00", [[0%]])
	GUI:Text_enableOutline(numberText11, "#000000", 1)
	GUI:setAnchorPoint(numberText11, 0.00, 0.00)
	GUI:setTouchEnabled(numberText11, false)
	GUI:setTag(numberText11, 0)

	-- Create RichText12
	local RichText12 = GUI:RichText_Create(infoNode1, "RichText12", 200, 37, [[<font color='#ffffff' size='17' >淬炼规则：</font><br><font color='#ffffff' size='17' >幸运淬炼成功，项链</font><font color='#00ff00' size='17' >获得幸运+1，最高+3</font><br><font color='#ffffff' size='17' >幸运淬炼失败，淬炼的材料系统</font><font color='#00ff00' size='17' >自动扣除</font><br><font color='#ffffff' size='17' >清除幸运则清除淬炼</font><font color='#00ff00' size='17' >属性与幸运值</font>]], 500, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText12, 0.00, 0.00)
	GUI:setTag(RichText12, 0)

	-- Create clearBtn
	local clearBtn = GUI:Button_Create(infoNode1, "clearBtn", 608, 79, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(clearBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(clearBtn, 0, 0, 0, 0)
	GUI:setContentSize(clearBtn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(clearBtn, false)
	GUI:Button_setTitleText(clearBtn, [[清除幸运]])
	GUI:Button_setTitleColor(clearBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(clearBtn, 16)
	GUI:Button_titleEnableOutline(clearBtn, "#000000", 1)
	GUI:setAnchorPoint(clearBtn, 0.50, 0.50)
	GUI:setTouchEnabled(clearBtn, true)
	GUI:setTag(clearBtn, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(infoNode1, "upBtn", 738, 79, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn, 0, 0, 0, 0)
	GUI:setContentSize(upBtn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开始淬炼]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 16)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create infoNode2
	local infoNode2 = GUI:Node_Create(midNode, "infoNode2", 0, 0)
	GUI:setTag(infoNode2, 0)
	GUI:setVisible(infoNode2, false)

	-- Create luckText21
	local luckText21 = GUI:Text_Create(infoNode2, "luckText21", 308, 238, 16, "#ffffff", [[项链幸运：]])
	GUI:Text_enableOutline(luckText21, "#000000", 1)
	GUI:setAnchorPoint(luckText21, 0.00, 0.00)
	GUI:setTouchEnabled(luckText21, false)
	GUI:setTag(luckText21, 0)

	-- Create luckText22
	local luckText22 = GUI:Text_Create(luckText21, "luckText22", 74, 0, 16, "#ffff00", [[？]])
	GUI:Text_enableOutline(luckText22, "#000000", 1)
	GUI:setAnchorPoint(luckText22, 0.00, 0.00)
	GUI:setTouchEnabled(luckText22, false)
	GUI:setTag(luckText22, 0)

	-- Create nameText21
	local nameText21 = GUI:Text_Create(infoNode2, "nameText21", 292, 208, 16, "#ffffff", [[项链名称：]])
	GUI:Text_enableOutline(nameText21, "#000000", 1)
	GUI:setAnchorPoint(nameText21, 0.00, 0.00)
	GUI:setTouchEnabled(nameText21, false)
	GUI:setTag(nameText21, 0)

	-- Create nameText22
	local nameText22 = GUI:Text_Create(nameText21, "nameText22", 78, 0, 16, "#ffff00", [[？？？]])
	GUI:Text_enableOutline(nameText22, "#000000", 1)
	GUI:setAnchorPoint(nameText22, 0.00, 0.00)
	GUI:setTouchEnabled(nameText22, false)
	GUI:setTag(nameText22, 0)

	-- Create oddText21
	local oddText21 = GUI:Text_Create(infoNode2, "oddText21", 282, 178, 16, "#ffffff", [[转移成功几率：]])
	GUI:Text_enableOutline(oddText21, "#000000", 1)
	GUI:setAnchorPoint(oddText21, 0.00, 0.00)
	GUI:setTouchEnabled(oddText21, false)
	GUI:setTag(oddText21, 0)

	-- Create oddText22
	local oddText22 = GUI:Text_Create(oddText21, "oddText22", 108, 0, 16, "#ffff00", [[100%]])
	GUI:Text_enableOutline(oddText22, "#000000", 1)
	GUI:setAnchorPoint(oddText22, 0.00, 0.00)
	GUI:setTouchEnabled(oddText22, false)
	GUI:setTag(oddText22, 0)

	-- Create rightNode2
	local rightNode2 = GUI:Node_Create(infoNode2, "rightNode2", 0, 0)
	GUI:setTag(rightNode2, 0)

	-- Create bigList2
	local bigList2 = GUI:ListView_Create(rightNode2, "bigList2", 532, 136, 252, 308, 1)
	GUI:ListView_setBounceEnabled(bigList2, true)
	GUI:ListView_setItemsMargin(bigList2, 2)
	GUI:setAnchorPoint(bigList2, 0.00, 0.00)
	GUI:setTouchEnabled(bigList2, true)
	GUI:setTag(bigList2, 0)

	-- Create list1
	local list1 = GUI:ListView_Create(bigList2, "list1", 0, 248, 252, 60, 2)
	GUI:ListView_setGravity(list1, 3)
	GUI:ListView_setItemsMargin(list1, 4)
	GUI:setAnchorPoint(list1, 0.00, 0.00)
	GUI:setTouchEnabled(list1, true)
	GUI:setTag(list1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(list1, "Image_1", 0, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(Image_1, "ItemShow_1", 30, 30, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(list1, "Image_2", 64, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(list1, "Image_3", 128, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_6
	local Image_6 = GUI:Image_Create(list1, "Image_6", 192, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_6, 0.00, 0.00)
	GUI:setTouchEnabled(Image_6, false)
	GUI:setTag(Image_6, 0)

	-- Create RichText21
	local RichText21 = GUI:RichText_Create(infoNode2, "RichText21", 200, 37, [[<font color='#ffffff' size='17' >转移规则：</font><br><font color='#ffffff' size='17' >将需要转移的</font><font color='#00ff00' size='17' >幸运+3</font><font color='#ffffff' size='17' >项链</font><font color='#00ff00' size='17' >佩戴在身上</font><font color='#ffffff' size='17' >选择右边背包项链</font><br><font color='#ffffff' size='17' >幸运转移成功可将幸运淬炼的属性覆盖到</font><font color='#00ff00' size='17' >所选择的项链</font><br><font color='#ffffff' size='17' >转移幸运项链仅支持非绑定货币，无法使用绑定货币</font>]], 500, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText21, 0.00, 0.00)
	GUI:setTag(RichText21, 0)

	-- Create moveBtn
	local moveBtn = GUI:Button_Create(infoNode2, "moveBtn", 710, 76, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(moveBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(moveBtn, 0, 0, 0, 0)
	GUI:setContentSize(moveBtn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(moveBtn, false)
	GUI:Button_setTitleText(moveBtn, [[开始转移]])
	GUI:Button_setTitleColor(moveBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(moveBtn, 16)
	GUI:Button_titleEnableOutline(moveBtn, "#000000", 1)
	GUI:setAnchorPoint(moveBtn, 0.50, 0.50)
	GUI:setTouchEnabled(moveBtn, true)
	GUI:setTag(moveBtn, 0)

	-- Create infoNode3
	local infoNode3 = GUI:Node_Create(midNode, "infoNode3", 0, 0)
	GUI:setTag(infoNode3, 0)
	GUI:setVisible(infoNode3, false)

	-- Create luckText31
	local luckText31 = GUI:Text_Create(infoNode3, "luckText31", 346, 256, 16, "#00ff00", [[？？]])
	GUI:Text_enableOutline(luckText31, "#000000", 1)
	GUI:setAnchorPoint(luckText31, 0.00, 0.00)
	GUI:setTouchEnabled(luckText31, false)
	GUI:setTag(luckText31, 0)

	-- Create oddText31
	local oddText31 = GUI:Text_Create(infoNode3, "oddText31", 384, 208, 16, "#ffff00", [[？？？]])
	GUI:Text_enableOutline(oddText31, "#000000", 1)
	GUI:setAnchorPoint(oddText31, 0.00, 0.00)
	GUI:setTouchEnabled(oddText31, false)
	GUI:setTag(oddText31, 0)

	-- Create nameText31
	local nameText31 = GUI:Text_Create(infoNode3, "nameText31", 384, 164, 16, "#00ffe8", [[？？？]])
	GUI:Text_enableOutline(nameText31, "#000000", 1)
	GUI:setAnchorPoint(nameText31, 0.00, 0.00)
	GUI:setTouchEnabled(nameText31, false)
	GUI:setTag(nameText31, 0)

	-- Create RichText31
	local RichText31 = GUI:RichText_Create(infoNode3, "RichText31", 528, 222, [==========[<font color='#ffffff' size='17' >仅限佩戴的项链进行</font><font color='#00ff00' size='17' >幸运觉醒</font><br><font color='#ffffff' size='17' >仅</font><font color='#00ff00' size='17' >幸运淬炼+3</font><font color='#ffffff' size='17' >的项链</font><font color='#00ff00' size='17' >才能觉醒</font><br><font color='#ffffff' size='17' >每次</font><font color='#00ff00' size='17' >觉醒后</font><font color='#ffffff' size='17' >即可随机获得</font><br><font color='#ffffff' size='17' >以下属性加成</font><br><br><br><br><br><font color='#ffffff' size='17' >神圣一击</font><font color='#f0b42a' size='17' >[1%-3%] </font><font color='#ffffff' size='17' >→ 当前：</font>]==========], 300, 16, "#00ff00", 4)
	GUI:setAnchorPoint(RichText31, 0.00, 0.00)
	GUI:setTag(RichText31, 0)

	-- Create numberText31
	local numberText31 = GUI:Text_Create(RichText31, "numberText31", 210, 0, 17, "#00ff00", [[0%]])
	GUI:Text_enableOutline(numberText31, "#000000", 1)
	GUI:setAnchorPoint(numberText31, 0.00, 0.00)
	GUI:setTouchEnabled(numberText31, false)
	GUI:setTag(numberText31, 0)

	-- Create RichText32
	local RichText32 = GUI:RichText_Create(infoNode3, "RichText32", 200, 37, [[<font color='#ffffff' size='17' >觉醒规则：</font><br><font color='#ffffff' size='17' >幸运淬炼至+3，觉醒项链</font><font color='#00ff00' size='17' >获得神圣一击属性</font><br><font color='#ffffff' size='17' >幸运觉醒失败，觉醒的材料系统</font><font color='#00ff00' size='17' >自动扣除</font><br><font color='#ffffff' size='17' >清除幸运则清除</font><font color='#00ff00' size='17' >觉醒属性与幸运值</font>]], 500, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText32, 0.00, 0.00)
	GUI:setTag(RichText32, 0)

	-- Create awakeBtn
	local awakeBtn = GUI:Button_Create(infoNode3, "awakeBtn", 669, 78, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(awakeBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(awakeBtn, 0, 0, 0, 0)
	GUI:setContentSize(awakeBtn, 110, 38)
	GUI:setIgnoreContentAdaptWithSize(awakeBtn, false)
	GUI:Button_setTitleText(awakeBtn, [[幸运觉醒]])
	GUI:Button_setTitleColor(awakeBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(awakeBtn, 16)
	GUI:Button_titleEnableOutline(awakeBtn, "#000000", 1)
	GUI:setAnchorPoint(awakeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(awakeBtn, true)
	GUI:setTag(awakeBtn, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
