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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 324, 908, 550, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/21fb/bosszj/mb.png")
	GUI:Image_setScale9Slice(FrameBG, 90, 90, 183, 183)
	GUI:setContentSize(FrameBG, 908, 550)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 819, 477, "res/custom/npc/01dtcs/close.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/01dtcs/close2.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create infoBg
	local infoBg = GUI:Image_Create(FrameLayout, "infoBg", 275, 132, "res/custom/npc/21fb/gzbg.png")
	GUI:setContentSize(infoBg, 334, 132)
	GUI:setIgnoreContentAdaptWithSize(infoBg, false)
	GUI:setAnchorPoint(infoBg, 0.00, 0.00)
	GUI:setTouchEnabled(infoBg, false)
	GUI:setTag(infoBg, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(infoBg, "RichText_1", 7, 106, [[<font color='#bdbdb5' size='16' >Boss之家内聚集</font><font color='#00ff00' size='16' >各种Boss</font><font color='#bdbdb5' size='16' >,  刷新时间短!</font>]], 300, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(infoBg, "RichText_2", 7, 81, [[<font color='#ff0000' size='16' >Boss之家1</font><font color='#bdbdb5' size='16' >每30分钟刷新一轮</font><font color='#ffff00' size='16' >【领主级Boss】</font>]], 350, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(infoBg, "RichText_3", 7, 57, [[<font color='#ff0000' size='16' >Boss之家2</font><font color='#bdbdb5' size='16' >每30分钟刷新一轮</font><font color='#9b00ff' size='16' >【霸主级Boss】</font>]], 350, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.00, 0.00)
	GUI:setTag(RichText_3, 0)

	-- Create RichText_4
	local RichText_4 = GUI:RichText_Create(infoBg, "RichText_4", 7, 33, [[<font color='#bdbdb5' size='16' >进入需要</font><font color='#ffff00' size='16' >加入行会</font><font color='#ffffff' size='16' >,  </font><font color='#ff0000' size='16' >每次限时2小时</font>]], 320, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_4, 0.00, 0.00)
	GUI:setTag(RichText_4, 0)

	-- Create RichText_5
	local RichText_5 = GUI:RichText_Create(infoBg, "RichText_5", 7, 9, [[<font color='#00ff00' size='16' >盟重令</font><font color='#bdbdb5' size='16' >用户</font><font color='#00ff00' size='16' >不受行会限制, 且进入不限时</font>]], 320, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_5, 0.00, 0.00)
	GUI:setTag(RichText_5, 0)

	-- Create listBg
	local listBg = GUI:Image_Create(FrameLayout, "listBg", 619, 132, "res/custom/npc/21fb/phbg.png")
	GUI:setContentSize(listBg, 236, 324)
	GUI:setIgnoreContentAdaptWithSize(listBg, false)
	GUI:setAnchorPoint(listBg, 0.00, 0.00)
	GUI:setTouchEnabled(listBg, false)
	GUI:setTag(listBg, 0)

	-- Create titleBg
	local titleBg = GUI:Image_Create(listBg, "titleBg", 33, 278, "res/custom/npc/21fb/titlebg.png")
	GUI:setAnchorPoint(titleBg, 0.00, 0.00)
	GUI:setTouchEnabled(titleBg, false)
	GUI:setTag(titleBg, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(titleBg, "Image_2", 89, 17, "res/custom/npc/21fb/bosszj/pm.png")
	GUI:setAnchorPoint(Image_2, 0.50, 0.50)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(listBg, "Image_1", 0, 243, "res/custom/npc/21fb/btitle2.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create BossList
	local BossList = GUI:ListView_Create(listBg, "BossList", 0, 1, 237, 243, 1)
	GUI:ListView_setBounceEnabled(BossList, true)
	GUI:setAnchorPoint(BossList, 0.00, 0.00)
	GUI:setTouchEnabled(BossList, true)
	GUI:setTag(BossList, 0)

	-- Create btnList
	local btnList = GUI:ListView_Create(FrameLayout, "btnList", 338, 64, 309, 50, 2)
	GUI:ListView_setGravity(btnList, 5)
	GUI:ListView_setItemsMargin(btnList, 70)
	GUI:setAnchorPoint(btnList, 0.00, 0.00)
	GUI:setTouchEnabled(btnList, true)
	GUI:setTag(btnList, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(btnList, "Button_1", 0, 6, "res/custom/npc/21fb/bosszj/btn11.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/npc/21fb/bosszj/btn12.png")
	GUI:setContentSize(Button_1, 120, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 15)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(btnList, "Button_2", 190, 6, "res/custom/npc/21fb/bosszj/btn21.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/npc/21fb/bosszj/btn22.png")
	GUI:setContentSize(Button_2, 120, 38)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 15)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
