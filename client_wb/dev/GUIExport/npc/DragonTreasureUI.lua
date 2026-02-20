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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 0)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 974, 584, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/39baoz/bg.png")
	GUI:Image_setScale9Slice(FrameBG, 97, 97, 194, 194)
	GUI:setContentSize(FrameBG, 974, 584)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create close_btn
	local close_btn = GUI:Button_Create(FrameLayout, "close_btn", 825, 444, "res/custom/npc/01dtcs/close.png")
	GUI:Button_loadTexturePressed(close_btn, "res/custom/npc/01dtcs/close2.png")
	GUI:setContentSize(close_btn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(close_btn, false)
	GUI:Button_setTitleText(close_btn, [[]])
	GUI:Button_setTitleColor(close_btn, "#ffffff")
	GUI:Button_setTitleFontSize(close_btn, 16)
	GUI:Button_titleDisableOutLine(close_btn)
	GUI:setAnchorPoint(close_btn, 0.00, 0.00)
	GUI:setTouchEnabled(close_btn, true)
	GUI:setTag(close_btn, 0)

	-- Create find_btn_text1
	local find_btn_text1 = GUI:Text_Create(FrameLayout, "find_btn_text1", 186, 140, 16, "#00ff00", [[黄金钥匙*1]])
	GUI:Text_enableOutline(find_btn_text1, "#000000", 1)
	GUI:setAnchorPoint(find_btn_text1, 0.50, 0.50)
	GUI:setTouchEnabled(find_btn_text1, false)
	GUI:setTag(find_btn_text1, 0)

	-- Create find_treasure_btn1
	local find_treasure_btn1 = GUI:Button_Create(FrameLayout, "find_treasure_btn1", 138, 155, "res/custom/npc/39baoz/xbtn11.png")
	GUI:Button_loadTexturePressed(find_treasure_btn1, "res/custom/npc/39baoz/xbtn12.png")
	GUI:setContentSize(find_treasure_btn1, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(find_treasure_btn1, false)
	GUI:Button_setTitleText(find_treasure_btn1, [[]])
	GUI:Button_setTitleColor(find_treasure_btn1, "#ffffff")
	GUI:Button_setTitleFontSize(find_treasure_btn1, 16)
	GUI:Button_titleDisableOutLine(find_treasure_btn1)
	GUI:setAnchorPoint(find_treasure_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(find_treasure_btn1, true)
	GUI:setTag(find_treasure_btn1, 0)

	-- Create find_btn_text2
	local find_btn_text2 = GUI:Text_Create(FrameLayout, "find_btn_text2", 482, 140, 16, "#00ff00", [[黄金钥匙*10]])
	GUI:Text_enableOutline(find_btn_text2, "#000000", 1)
	GUI:setAnchorPoint(find_btn_text2, 0.50, 0.50)
	GUI:setTouchEnabled(find_btn_text2, false)
	GUI:setTag(find_btn_text2, 0)

	-- Create find_treasure_btn2
	local find_treasure_btn2 = GUI:Button_Create(FrameLayout, "find_treasure_btn2", 433, 155, "res/custom/npc/39baoz/xbtn31.png")
	GUI:Button_loadTexturePressed(find_treasure_btn2, "res/custom/npc/39baoz/xbtn32.png")
	GUI:setContentSize(find_treasure_btn2, 100, 40)
	GUI:setIgnoreContentAdaptWithSize(find_treasure_btn2, false)
	GUI:Button_setTitleText(find_treasure_btn2, [[]])
	GUI:Button_setTitleColor(find_treasure_btn2, "#ffffff")
	GUI:Button_setTitleFontSize(find_treasure_btn2, 16)
	GUI:Button_titleDisableOutLine(find_treasure_btn2)
	GUI:setAnchorPoint(find_treasure_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(find_treasure_btn2, true)
	GUI:setTag(find_treasure_btn2, 0)

	-- Create reward_node_1
	local reward_node_1 = GUI:Image_Create(FrameLayout, "reward_node_1", 134, 360, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_1, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_1, false)
	GUI:setTag(reward_node_1, 0)

	-- Create reward_item_1
	local reward_item_1 = GUI:ItemShow_Create(reward_node_1, "reward_item_1", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_1, 0.50, 0.50)
	GUI:setTag(reward_item_1, 0)

	-- Create select_img1
	local select_img1 = GUI:Image_Create(reward_node_1, "select_img1", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img1, 0.00, 0.00)
	GUI:setTouchEnabled(select_img1, false)
	GUI:setTag(select_img1, 0)
	GUI:setVisible(select_img1, false)

	-- Create reward_node_2
	local reward_node_2 = GUI:Image_Create(FrameLayout, "reward_node_2", 219, 360, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_2, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_2, false)
	GUI:setTag(reward_node_2, 0)

	-- Create reward_item_2
	local reward_item_2 = GUI:ItemShow_Create(reward_node_2, "reward_item_2", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_2, 0.50, 0.50)
	GUI:setTag(reward_item_2, 0)

	-- Create select_img2
	local select_img2 = GUI:Image_Create(reward_node_2, "select_img2", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img2, 0.00, 0.00)
	GUI:setTouchEnabled(select_img2, false)
	GUI:setTag(select_img2, 0)
	GUI:setVisible(select_img2, false)

	-- Create reward_node_3
	local reward_node_3 = GUI:Image_Create(FrameLayout, "reward_node_3", 408, 360, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_3, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_3, false)
	GUI:setTag(reward_node_3, 0)

	-- Create reward_item_3
	local reward_item_3 = GUI:ItemShow_Create(reward_node_3, "reward_item_3", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_3, 0.50, 0.50)
	GUI:setTag(reward_item_3, 0)

	-- Create select_img3
	local select_img3 = GUI:Image_Create(reward_node_3, "select_img3", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img3, 0.00, 0.00)
	GUI:setTouchEnabled(select_img3, false)
	GUI:setTag(select_img3, 0)
	GUI:setVisible(select_img3, false)

	-- Create reward_node_4
	local reward_node_4 = GUI:Image_Create(FrameLayout, "reward_node_4", 493, 360, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_4, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_4, false)
	GUI:setTag(reward_node_4, 0)

	-- Create reward_item_4
	local reward_item_4 = GUI:ItemShow_Create(reward_node_4, "reward_item_4", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_4, 0.50, 0.50)
	GUI:setTag(reward_item_4, 0)

	-- Create select_img4
	local select_img4 = GUI:Image_Create(reward_node_4, "select_img4", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img4, 0.00, 0.00)
	GUI:setTouchEnabled(select_img4, false)
	GUI:setTag(select_img4, 0)
	GUI:setVisible(select_img4, false)

	-- Create reward_node_5
	local reward_node_5 = GUI:Image_Create(FrameLayout, "reward_node_5", 134, 288, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_5, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_5, false)
	GUI:setTag(reward_node_5, 0)

	-- Create reward_item_5
	local reward_item_5 = GUI:ItemShow_Create(reward_node_5, "reward_item_5", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_5, 0.50, 0.50)
	GUI:setTag(reward_item_5, 0)

	-- Create select_img5
	local select_img5 = GUI:Image_Create(reward_node_5, "select_img5", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img5, 0.00, 0.00)
	GUI:setTouchEnabled(select_img5, false)
	GUI:setTag(select_img5, 0)
	GUI:setVisible(select_img5, false)

	-- Create reward_node_6
	local reward_node_6 = GUI:Image_Create(FrameLayout, "reward_node_6", 219, 288, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_6, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_6, false)
	GUI:setTag(reward_node_6, 0)

	-- Create reward_item_6
	local reward_item_6 = GUI:ItemShow_Create(reward_node_6, "reward_item_6", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_6, 0.50, 0.50)
	GUI:setTag(reward_item_6, 0)

	-- Create select_img6
	local select_img6 = GUI:Image_Create(reward_node_6, "select_img6", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img6, 0.00, 0.00)
	GUI:setTouchEnabled(select_img6, false)
	GUI:setTag(select_img6, 0)
	GUI:setVisible(select_img6, false)

	-- Create reward_node_7
	local reward_node_7 = GUI:Image_Create(FrameLayout, "reward_node_7", 408, 288, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_7, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_7, false)
	GUI:setTag(reward_node_7, 0)

	-- Create reward_item_7
	local reward_item_7 = GUI:ItemShow_Create(reward_node_7, "reward_item_7", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_7, 0.50, 0.50)
	GUI:setTag(reward_item_7, 0)

	-- Create select_img7
	local select_img7 = GUI:Image_Create(reward_node_7, "select_img7", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img7, 0.00, 0.00)
	GUI:setTouchEnabled(select_img7, false)
	GUI:setTag(select_img7, 0)
	GUI:setVisible(select_img7, false)

	-- Create reward_node_8
	local reward_node_8 = GUI:Image_Create(FrameLayout, "reward_node_8", 493, 288, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_8, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_8, false)
	GUI:setTag(reward_node_8, 0)

	-- Create reward_item_8
	local reward_item_8 = GUI:ItemShow_Create(reward_node_8, "reward_item_8", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_8, 0.50, 0.50)
	GUI:setTag(reward_item_8, 0)

	-- Create select_img8
	local select_img8 = GUI:Image_Create(reward_node_8, "select_img8", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img8, 0.00, 0.00)
	GUI:setTouchEnabled(select_img8, false)
	GUI:setTag(select_img8, 0)
	GUI:setVisible(select_img8, false)

	-- Create reward_node_9
	local reward_node_9 = GUI:Image_Create(FrameLayout, "reward_node_9", 134, 218, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_9, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_9, false)
	GUI:setTag(reward_node_9, 0)

	-- Create reward_item_9
	local reward_item_9 = GUI:ItemShow_Create(reward_node_9, "reward_item_9", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_9, 0.50, 0.50)
	GUI:setTag(reward_item_9, 0)

	-- Create select_img9
	local select_img9 = GUI:Image_Create(reward_node_9, "select_img9", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img9, 0.00, 0.00)
	GUI:setTouchEnabled(select_img9, false)
	GUI:setTag(select_img9, 0)
	GUI:setVisible(select_img9, false)

	-- Create reward_node_10
	local reward_node_10 = GUI:Image_Create(FrameLayout, "reward_node_10", 219, 218, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_10, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_10, false)
	GUI:setTag(reward_node_10, 0)

	-- Create reward_item_10
	local reward_item_10 = GUI:ItemShow_Create(reward_node_10, "reward_item_10", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_10, 0.50, 0.50)
	GUI:setTag(reward_item_10, 0)

	-- Create select_img10
	local select_img10 = GUI:Image_Create(reward_node_10, "select_img10", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img10, 0.00, 0.00)
	GUI:setTouchEnabled(select_img10, false)
	GUI:setTag(select_img10, 0)
	GUI:setVisible(select_img10, false)

	-- Create reward_node_11
	local reward_node_11 = GUI:Image_Create(FrameLayout, "reward_node_11", 408, 218, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_11, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_11, false)
	GUI:setTag(reward_node_11, 0)

	-- Create reward_item_11
	local reward_item_11 = GUI:ItemShow_Create(reward_node_11, "reward_item_11", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_11, 0.50, 0.50)
	GUI:setTag(reward_item_11, 0)

	-- Create select_img11
	local select_img11 = GUI:Image_Create(reward_node_11, "select_img11", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img11, 0.00, 0.00)
	GUI:setTouchEnabled(select_img11, false)
	GUI:setTag(select_img11, 0)
	GUI:setVisible(select_img11, false)

	-- Create reward_node_12
	local reward_node_12 = GUI:Image_Create(FrameLayout, "reward_node_12", 493, 218, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(reward_node_12, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_12, false)
	GUI:setTag(reward_node_12, 0)

	-- Create reward_item_12
	local reward_item_12 = GUI:ItemShow_Create(reward_node_12, "reward_item_12", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_12, 0.50, 0.50)
	GUI:setTag(reward_item_12, 0)

	-- Create select_img12
	local select_img12 = GUI:Image_Create(reward_node_12, "select_img12", -20, -20, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img12, 0.00, 0.00)
	GUI:setTouchEnabled(select_img12, false)
	GUI:setTag(select_img12, 0)
	GUI:setVisible(select_img12, false)

	-- Create reward_node_13
	local reward_node_13 = GUI:Image_Create(FrameLayout, "reward_node_13", 302, 272, "res/custom/npc/39baoz/itbg0.png")
	GUI:setAnchorPoint(reward_node_13, 0.00, 0.00)
	GUI:setTouchEnabled(reward_node_13, false)
	GUI:setTag(reward_node_13, 0)

	-- Create reward_item_13
	local reward_item_13 = GUI:ItemShow_Create(reward_node_13, "reward_item_13", 40, 43, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(reward_item_13, 0.50, 0.50)
	GUI:setTag(reward_item_13, 0)

	-- Create select_img13
	local select_img13 = GUI:Image_Create(reward_node_13, "select_img13", -9, -8, "res/custom/npc/39baoz/s1.png")
	GUI:setAnchorPoint(select_img13, 0.00, 0.00)
	GUI:setTouchEnabled(select_img13, false)
	GUI:setTag(select_img13, 0)
	GUI:setVisible(select_img13, false)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(FrameLayout, "Image_5", 302, 136, "res/custom/npc/39baoz/itbg0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create fashion_item
	local fashion_item = GUI:ItemShow_Create(Image_5, "fashion_item", 40, 43, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(fashion_item, 0.50, 0.50)
	GUI:setTag(fashion_item, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 580, 287, [[<font color='#ffffff' size='16' >使用  </font><font color='#ffff00' size='16' >黄金钥匙</font><font color='#ffffff' size='16' >可开启寻龙宝藏</font><br><font color='#ffffff' size='16' >概率  </font><font color='#00ff00' size='16' >每个位置抽取均为十三分之一</font><br><font color='#fd00fd' size='16' >【时装大奖】抽中几率为：1‰</font><br><font color='#00ffe8' size='16' >每日累计次数达标可获得额外奖励!</font><br><font color='#ffff00' size='16' >每次开启额外获得：仙石*1</font>]], 260, 14, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create gold_key_text
	local gold_key_text = GUI:Text_Create(FrameLayout, "gold_key_text", 150, 430, 16, "#ffffff", [[黄金钥匙]])
	GUI:Text_enableOutline(gold_key_text, "#000000", 1)
	GUI:setAnchorPoint(gold_key_text, 0.00, 0.00)
	GUI:setTouchEnabled(gold_key_text, false)
	GUI:setTag(gold_key_text, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(FrameLayout, "ItemShow_1", 619, 112, {index = 10781, count = 10, look = true, bgVisible = true, color = 253})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 699, 142, "res/public/btn_szjm_01_1.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setRotation(Image_1, 180.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(FrameLayout, "Image_2", 713, 132, "res/public/btn_szjm_01_1.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setScale(Image_2, 0.70)
	GUI:setRotation(Image_2, 180.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create money_btn
	local money_btn = GUI:Button_Create(FrameLayout, "money_btn", 727, 84, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(money_btn, "res/custom/btn12.png")
	GUI:setContentSize(money_btn, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(money_btn, false)
	GUI:Button_setTitleText(money_btn, [[元宝购买]])
	GUI:Button_setTitleColor(money_btn, "#ffff00")
	GUI:Button_setTitleFontSize(money_btn, 16)
	GUI:Button_titleEnableOutline(money_btn, "#000000", 1)
	GUI:setAnchorPoint(money_btn, 0.00, 0.00)
	GUI:setTouchEnabled(money_btn, true)
	GUI:setTag(money_btn, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(FrameLayout, "ItemShow_2", 620, 199, {index = 10781, count = 10, look = true, bgVisible = true, color = 253})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(FrameLayout, "Image_3", 700, 229, "res/public/btn_szjm_01_1.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setRotation(Image_3, 180.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(FrameLayout, "Image_4", 714, 219, "res/public/btn_szjm_01_1.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setScale(Image_4, 0.70)
	GUI:setRotation(Image_4, 180.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create buy_btn
	local buy_btn = GUI:Button_Create(FrameLayout, "buy_btn", 726, 168, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(buy_btn, "res/custom/btn12.png")
	GUI:setContentSize(buy_btn, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(buy_btn, false)
	GUI:Button_setTitleText(buy_btn, [[19元购买]])
	GUI:Button_setTitleColor(buy_btn, "#ffff00")
	GUI:Button_setTitleFontSize(buy_btn, 16)
	GUI:Button_titleEnableOutline(buy_btn, "#000000", 1)
	GUI:setAnchorPoint(buy_btn, 0.00, 0.00)
	GUI:setTouchEnabled(buy_btn, true)
	GUI:setTag(buy_btn, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 733, 210, 16, "#ffffff", [[限购：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create limit_count_text
	local limit_count_text = GUI:Text_Create(FrameLayout, "limit_count_text", 781, 210, 16, "#00ff00", [[0/10]])
	GUI:Text_enableOutline(limit_count_text, "#000000", 1)
	GUI:setAnchorPoint(limit_count_text, 0.00, 0.00)
	GUI:setTouchEnabled(limit_count_text, false)
	GUI:setTag(limit_count_text, 0)

	-- Create jindu_node1
	local jindu_node1 = GUI:Image_Create(FrameLayout, "jindu_node1", 131, 54, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(jindu_node1, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_node1, false)
	GUI:setTag(jindu_node1, 0)

	-- Create jindu_item_1
	local jindu_item_1 = GUI:ItemShow_Create(jindu_node1, "jindu_item_1", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(jindu_item_1, 0.50, 0.50)
	GUI:setTag(jindu_item_1, 0)

	-- Create jindu_get_flag1
	local jindu_get_flag1 = GUI:Image_Create(jindu_node1, "jindu_get_flag1", 0, 16, "res/custom/npc/39baoz/y1.png")
	GUI:setAnchorPoint(jindu_get_flag1, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_get_flag1, false)
	GUI:setTag(jindu_get_flag1, 0)
	GUI:setVisible(jindu_get_flag1, false)

	-- Create Text_5
	local Text_5 = GUI:Text_Create(jindu_node1, "Text_5", -4, -30, 16, "#00ff00", [[寻宝20次]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create jindu_node1_1
	local jindu_node1_1 = GUI:Image_Create(FrameLayout, "jindu_node1_1", 225, 54, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(jindu_node1_1, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_node1_1, false)
	GUI:setTag(jindu_node1_1, 0)

	-- Create jindu_item_2
	local jindu_item_2 = GUI:ItemShow_Create(jindu_node1_1, "jindu_item_2", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(jindu_item_2, 0.50, 0.50)
	GUI:setTag(jindu_item_2, 0)

	-- Create jindu_get_flag2
	local jindu_get_flag2 = GUI:Image_Create(jindu_node1_1, "jindu_get_flag2", 0, 16, "res/custom/npc/39baoz/y1.png")
	GUI:setAnchorPoint(jindu_get_flag2, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_get_flag2, false)
	GUI:setTag(jindu_get_flag2, 0)
	GUI:setVisible(jindu_get_flag2, false)

	-- Create Text_5
	Text_5 = GUI:Text_Create(jindu_node1_1, "Text_5", -3, -30, 16, "#00ff00", [[寻宝50次]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create jindu_node1_2
	local jindu_node1_2 = GUI:Image_Create(FrameLayout, "jindu_node1_2", 315, 54, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(jindu_node1_2, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_node1_2, false)
	GUI:setTag(jindu_node1_2, 0)

	-- Create jindu_item_3
	local jindu_item_3 = GUI:ItemShow_Create(jindu_node1_2, "jindu_item_3", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(jindu_item_3, 0.50, 0.50)
	GUI:setTag(jindu_item_3, 0)

	-- Create jindu_get_flag3
	local jindu_get_flag3 = GUI:Image_Create(jindu_node1_2, "jindu_get_flag3", 0, 16, "res/custom/npc/39baoz/y1.png")
	GUI:setAnchorPoint(jindu_get_flag3, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_get_flag3, false)
	GUI:setTag(jindu_get_flag3, 0)
	GUI:setVisible(jindu_get_flag3, false)

	-- Create Text_5
	Text_5 = GUI:Text_Create(jindu_node1_2, "Text_5", -8, -30, 16, "#00ff00", [[寻宝100次]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create jindu_node1_3
	local jindu_node1_3 = GUI:Image_Create(FrameLayout, "jindu_node1_3", 403, 54, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(jindu_node1_3, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_node1_3, false)
	GUI:setTag(jindu_node1_3, 0)

	-- Create jindu_item_4
	local jindu_item_4 = GUI:ItemShow_Create(jindu_node1_3, "jindu_item_4", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(jindu_item_4, 0.50, 0.50)
	GUI:setTag(jindu_item_4, 0)

	-- Create jindu_get_flag4
	local jindu_get_flag4 = GUI:Image_Create(jindu_node1_3, "jindu_get_flag4", 0, 16, "res/custom/npc/39baoz/y1.png")
	GUI:setAnchorPoint(jindu_get_flag4, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_get_flag4, false)
	GUI:setTag(jindu_get_flag4, 0)
	GUI:setVisible(jindu_get_flag4, false)

	-- Create Text_5
	Text_5 = GUI:Text_Create(jindu_node1_3, "Text_5", -7, -30, 16, "#00ff00", [[寻宝300次]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create jindu_node1_4
	local jindu_node1_4 = GUI:Image_Create(FrameLayout, "jindu_node1_4", 495, 54, "res/custom/npc/39baoz/itbg1.png")
	GUI:setAnchorPoint(jindu_node1_4, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_node1_4, false)
	GUI:setTag(jindu_node1_4, 0)

	-- Create jindu_item_5
	local jindu_item_5 = GUI:ItemShow_Create(jindu_node1_4, "jindu_item_5", 30, 30, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(jindu_item_5, 0.50, 0.50)
	GUI:setTag(jindu_item_5, 0)

	-- Create jindu_get_flag5
	local jindu_get_flag5 = GUI:Image_Create(jindu_node1_4, "jindu_get_flag5", 0, 16, "res/custom/npc/39baoz/y1.png")
	GUI:setAnchorPoint(jindu_get_flag5, 0.00, 0.00)
	GUI:setTouchEnabled(jindu_get_flag5, false)
	GUI:setTag(jindu_get_flag5, 0)
	GUI:setVisible(jindu_get_flag5, false)

	-- Create Text_5
	Text_5 = GUI:Text_Create(jindu_node1_4, "Text_5", -5, -30, 16, "#00ff00", [[寻宝500次]])
	GUI:Text_enableOutline(Text_5, "#000000", 1)
	GUI:setAnchorPoint(Text_5, 0.00, 0.00)
	GUI:setTouchEnabled(Text_5, false)
	GUI:setTag(Text_5, 0)

	-- Create day_draw_count_text
	local day_draw_count_text = GUI:Text_Create(FrameLayout, "day_draw_count_text", 717, 35, 18, "#00ff00", [[你今日已寻宝：1149次]])
	GUI:Text_enableOutline(day_draw_count_text, "#000000", 1)
	GUI:setAnchorPoint(day_draw_count_text, 0.50, 0.50)
	GUI:setTouchEnabled(day_draw_count_text, false)
	GUI:setTag(day_draw_count_text, 0)

	-- Create buy_tip
	local buy_tip = GUI:Image_Create(FrameLayout, "buy_tip", 228, 134, "res/custom/bossbg.png")
	GUI:setAnchorPoint(buy_tip, 0.00, 0.00)
	GUI:setTouchEnabled(buy_tip, false)
	GUI:setTag(buy_tip, 0)
	GUI:setVisible(buy_tip, false)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(buy_tip, "Text_4", 188, 165, 18, "#ff0000", [[批量购买]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create buy_tip_close
	local buy_tip_close = GUI:Button_Create(buy_tip, "buy_tip_close", 413, 163, "res/public/01.png")
	GUI:Button_loadTexturePressed(buy_tip_close, "res/public/02.png")
	GUI:setContentSize(buy_tip_close, 30, 30)
	GUI:setIgnoreContentAdaptWithSize(buy_tip_close, false)
	GUI:Button_setTitleText(buy_tip_close, [[]])
	GUI:Button_setTitleColor(buy_tip_close, "#ffffff")
	GUI:Button_setTitleFontSize(buy_tip_close, 16)
	GUI:Button_titleDisableOutLine(buy_tip_close)
	GUI:setAnchorPoint(buy_tip_close, 0.00, 0.00)
	GUI:setTouchEnabled(buy_tip_close, true)
	GUI:setTag(buy_tip_close, 0)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(buy_tip, "RichText_3", 39, 109, [[<font color='#ff00ff' size='16' >￥19元 </font><font color='#ffffff' size='16' >  获得：</font><font color='#ffff00' size='16' >黄金钥匙*10</font>]], 250, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.00, 0.00)
	GUI:setTag(RichText_3, 0)
	GUI:setVisible(RichText_3, false)

	-- Create buy_one_btn
	local buy_one_btn = GUI:Button_Create(buy_tip, "buy_one_btn", 277, 96, "res/custom/npc/39baoz/buy01.png")
	GUI:setContentSize(buy_one_btn, 150, 42)
	GUI:setIgnoreContentAdaptWithSize(buy_one_btn, false)
	GUI:Button_setTitleText(buy_one_btn, [[]])
	GUI:Button_setTitleColor(buy_one_btn, "#ffffff")
	GUI:Button_setTitleFontSize(buy_one_btn, 16)
	GUI:Button_titleDisableOutLine(buy_one_btn)
	GUI:setAnchorPoint(buy_one_btn, 0.00, 0.00)
	GUI:setTouchEnabled(buy_one_btn, true)
	GUI:setTag(buy_one_btn, 0)

	-- Create RichText_4
	local RichText_4 = GUI:RichText_Create(buy_tip, "RichText_4", 26, 43, [[<font color='#ff00ff' size='16' >￥190元 </font><font color='#ffffff' size='16' >  获得：</font><font color='#ffff00' size='16' >黄金钥匙*100</font>]], 250, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_4, 0.00, 0.00)
	GUI:setTag(RichText_4, 0)
	GUI:setVisible(RichText_4, false)

	-- Create buy_ten_btn
	local buy_ten_btn = GUI:Button_Create(buy_tip, "buy_ten_btn", 277, 31, "res/custom/npc/39baoz/buy11.png")
	GUI:Button_loadTexturePressed(buy_ten_btn, "res/custom/npc/39baoz/buy12.png")
	GUI:setContentSize(buy_ten_btn, 150, 42)
	GUI:setIgnoreContentAdaptWithSize(buy_ten_btn, false)
	GUI:Button_setTitleText(buy_ten_btn, [[]])
	GUI:Button_setTitleColor(buy_ten_btn, "#ffffff")
	GUI:Button_setTitleFontSize(buy_ten_btn, 16)
	GUI:Button_titleDisableOutLine(buy_ten_btn)
	GUI:setAnchorPoint(buy_ten_btn, 0.00, 0.00)
	GUI:setTouchEnabled(buy_ten_btn, true)
	GUI:setTag(buy_ten_btn, 0)

	-- Create has_bug_flag
	local has_bug_flag = GUI:Image_Create(FrameLayout, "has_bug_flag", 729, 172, "res/custom/npc/39baoz/ysq.png")
	GUI:setAnchorPoint(has_bug_flag, 0.00, 0.00)
	GUI:setTouchEnabled(has_bug_flag, false)
	GUI:setTag(has_bug_flag, 0)
	GUI:setVisible(has_bug_flag, false)

	-- Create Text_22
	local Text_22 = GUI:Text_Create(FrameLayout, "Text_22", 726, 127, 16, "#ffffff", [[每枚:]])
	GUI:Text_enableOutline(Text_22, "#000000", 1)
	GUI:setAnchorPoint(Text_22, 0.00, 0.00)
	GUI:setTouchEnabled(Text_22, false)
	GUI:setTag(Text_22, 0)

	-- Create Text_33
	local Text_33 = GUI:Text_Create(FrameLayout, "Text_33", 764, 127, 16, "#00ff00", [[5000元宝]])
	GUI:Text_enableOutline(Text_33, "#000000", 1)
	GUI:setAnchorPoint(Text_33, 0.00, 0.00)
	GUI:setTouchEnabled(Text_33, false)
	GUI:setTag(Text_33, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
