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
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 89)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, 0)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 140, 45, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.00, 0.00)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, 0)

	-- Create bg_Image
	local bg_Image = GUI:Image_Create(FrameLayout, "bg_Image", 0, 0, "res/custom/npc/38jf/bg2.png")
	GUI:Image_setScale9Slice(bg_Image, 84, 84, 188, 188)
	GUI:setContentSize(bg_Image, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(bg_Image, false)
	GUI:setAnchorPoint(bg_Image, 0.00, 0.00)
	GUI:setTouchEnabled(bg_Image, true)
	GUI:setMouseEnabled(bg_Image, true)
	GUI:setTag(bg_Image, 0)

	-- Create Button_1
	local Button_1 = GUI:Button_Create(FrameLayout, "Button_1", 72, 439, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_1, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_1, false)
	GUI:Button_setTitleText(Button_1, [[金符送宝]])
	GUI:Button_setTitleColor(Button_1, "#ffffff")
	GUI:Button_setTitleFontSize(Button_1, 18)
	GUI:Button_titleEnableOutline(Button_1, "#000000", 1)
	GUI:setAnchorPoint(Button_1, 0.00, 0.00)
	GUI:setTouchEnabled(Button_1, true)
	GUI:setTag(Button_1, 0)

	-- Create Button_2
	local Button_2 = GUI:Button_Create(FrameLayout, "Button_2", 72, 394, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_2, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_2, false)
	GUI:Button_setTitleText(Button_2, [[图鉴助力]])
	GUI:Button_setTitleColor(Button_2, "#ffffff")
	GUI:Button_setTitleFontSize(Button_2, 18)
	GUI:Button_titleEnableOutline(Button_2, "#000000", 1)
	GUI:setAnchorPoint(Button_2, 0.00, 0.00)
	GUI:setTouchEnabled(Button_2, true)
	GUI:setTag(Button_2, 0)

	-- Create Button_3
	local Button_3 = GUI:Button_Create(FrameLayout, "Button_3", 72, 349, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_3, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_3, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_3, false)
	GUI:Button_setTitleText(Button_3, [[古纪助力]])
	GUI:Button_setTitleColor(Button_3, "#ffffff")
	GUI:Button_setTitleFontSize(Button_3, 18)
	GUI:Button_titleEnableOutline(Button_3, "#000000", 1)
	GUI:setAnchorPoint(Button_3, 0.00, 0.00)
	GUI:setTouchEnabled(Button_3, true)
	GUI:setTag(Button_3, 0)

	-- Create Button_4
	local Button_4 = GUI:Button_Create(FrameLayout, "Button_4", 72, 304, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_4, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_4, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_4, false)
	GUI:Button_setTitleText(Button_4, [[幸运助力]])
	GUI:Button_setTitleColor(Button_4, "#ffffff")
	GUI:Button_setTitleFontSize(Button_4, 18)
	GUI:Button_titleEnableOutline(Button_4, "#000000", 1)
	GUI:setAnchorPoint(Button_4, 0.00, 0.00)
	GUI:setTouchEnabled(Button_4, true)
	GUI:setTag(Button_4, 0)

	-- Create Button_5
	local Button_5 = GUI:Button_Create(FrameLayout, "Button_5", 72, 259, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_5, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_5, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_5, false)
	GUI:Button_setTitleText(Button_5, [[新服助力]])
	GUI:Button_setTitleColor(Button_5, "#ffffff")
	GUI:Button_setTitleFontSize(Button_5, 18)
	GUI:Button_titleEnableOutline(Button_5, "#000000", 1)
	GUI:setAnchorPoint(Button_5, 0.00, 0.00)
	GUI:setTouchEnabled(Button_5, true)
	GUI:setTag(Button_5, 0)

	-- Create Button_6
	local Button_6 = GUI:Button_Create(FrameLayout, "Button_6", 72, 214, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_6, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_6, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_6, false)
	GUI:Button_setTitleText(Button_6, [[金符仙子]])
	GUI:Button_setTitleColor(Button_6, "#ffffff")
	GUI:Button_setTitleFontSize(Button_6, 18)
	GUI:Button_titleEnableOutline(Button_6, "#000000", 1)
	GUI:setAnchorPoint(Button_6, 0.00, 0.00)
	GUI:setTouchEnabled(Button_6, true)
	GUI:setTag(Button_6, 0)

	-- Create Button_7
	local Button_7 = GUI:Button_Create(FrameLayout, "Button_7", 72, 169, "res/custom/npc/ta1.png")
	GUI:Button_loadTexturePressed(Button_7, "res/custom/npc/ta1.png")
	GUI:setContentSize(Button_7, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Button_7, false)
	GUI:Button_setTitleText(Button_7, [[金符童子]])
	GUI:Button_setTitleColor(Button_7, "#ffffff")
	GUI:Button_setTitleFontSize(Button_7, 18)
	GUI:Button_titleEnableOutline(Button_7, "#000000", 1)
	GUI:setAnchorPoint(Button_7, 0.00, 0.00)
	GUI:setTouchEnabled(Button_7, true)
	GUI:setTag(Button_7, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 784, 493, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/close2.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create Node_1
	local Node_1 = GUI:Node_Create(FrameLayout, "Node_1", 0, 0)
	GUI:setTag(Node_1, 0)
	GUI:setVisible(Node_1, false)

	-- Create GoldListView
	local GoldListView = GUI:ListView_Create(Node_1, "GoldListView", 197, 32, 601, 365, 1)
	GUI:ListView_setBounceEnabled(GoldListView, true)
	GUI:ListView_setGravity(GoldListView, 2)
	GUI:setAnchorPoint(GoldListView, 0.00, 0.00)
	GUI:setTouchEnabled(GoldListView, true)
	GUI:setTag(GoldListView, 0)

	-- Create Node_2
	local Node_2 = GUI:Node_Create(FrameLayout, "Node_2", 0, 0)
	GUI:setTag(Node_2, 0)
	GUI:setVisible(Node_2, false)

	-- Create TuJianListView
	local TuJianListView = GUI:ListView_Create(Node_2, "TuJianListView", 198, 32, 601, 365, 1)
	GUI:ListView_setBounceEnabled(TuJianListView, true)
	GUI:ListView_setGravity(TuJianListView, 2)
	GUI:setAnchorPoint(TuJianListView, 0.00, 0.00)
	GUI:setTouchEnabled(TuJianListView, true)
	GUI:setTag(TuJianListView, 0)

	-- Create Node_3
	local Node_3 = GUI:Node_Create(FrameLayout, "Node_3", 0, 0)
	GUI:setTag(Node_3, 0)
	GUI:setVisible(Node_3, false)

	-- Create goldTxt
	local goldTxt = GUI:Text_Create(Node_3, "goldTxt", 210, 410, 16, "#009bff", [[当前金符数量:   0]])
	GUI:Text_enableOutline(goldTxt, "#000000", 1)
	GUI:setAnchorPoint(goldTxt, 0.00, 0.00)
	GUI:setTouchEnabled(goldTxt, false)
	GUI:setTag(goldTxt, 0)

	-- Create BgCell_1
	local BgCell_1 = GUI:Image_Create(Node_3, "BgCell_1", 205, 42, "res/custom/npc/38jf/gjlist.png")
	GUI:setAnchorPoint(BgCell_1, 0.00, 0.00)
	GUI:setTouchEnabled(BgCell_1, false)
	GUI:setTag(BgCell_1, 0)

	-- Create titleImg
	local titleImg = GUI:Image_Create(BgCell_1, "titleImg", 143, 280, "res/custom/npc/38jf/gjtle1.png")
	GUI:setAnchorPoint(titleImg, 0.50, 0.00)
	GUI:setTouchEnabled(titleImg, false)
	GUI:setTag(titleImg, 0)

	-- Create gj_item_1
	local gj_item_1 = GUI:ItemShow_Create(BgCell_1, "gj_item_1", 66, 230, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(gj_item_1, 0.50, 0.50)
	GUI:setTag(gj_item_1, 0)

	-- Create gj_item_2
	local gj_item_2 = GUI:ItemShow_Create(BgCell_1, "gj_item_2", 143, 231, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(gj_item_2, 0.50, 0.50)
	GUI:setTag(gj_item_2, 0)

	-- Create gj_item_3
	local gj_item_3 = GUI:ItemShow_Create(BgCell_1, "gj_item_3", 220, 231, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(gj_item_3, 0.50, 0.50)
	GUI:setTag(gj_item_3, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(BgCell_1, "RichText_1", 142, 115, [[<font color='#bdbdb5' size='16' >价格:  </font><font color='#ffff00' size='16' >金符x50000</font>]], 140, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.50, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(BgCell_1, "Text_1", 142, 87, 16, "#00ff00", [[盟重令半价]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create buyBtn
	local buyBtn = GUI:Button_Create(BgCell_1, "buyBtn", 143, 38, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(buyBtn, "res/custom/btn12.png")
	GUI:setContentSize(buyBtn, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(buyBtn, false)
	GUI:Button_setTitleText(buyBtn, [[购      买]])
	GUI:Button_setTitleColor(buyBtn, "#ffff00")
	GUI:Button_setTitleFontSize(buyBtn, 18)
	GUI:Button_titleEnableOutline(buyBtn, "#000000", 1)
	GUI:setAnchorPoint(buyBtn, 0.50, 0.00)
	GUI:setTouchEnabled(buyBtn, true)
	GUI:setTag(buyBtn, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(BgCell_1, "Text_2", 90, 11, 16, "#bdbdb5", [[每日限购:]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create buyTimes_txt
	local buyTimes_txt = GUI:Text_Create(BgCell_1, "buyTimes_txt", 168, 11, 16, "#00ff00", [[0 / 3]])
	GUI:Text_enableOutline(buyTimes_txt, "#000000", 1)
	GUI:setAnchorPoint(buyTimes_txt, 0.00, 0.00)
	GUI:setTouchEnabled(buyTimes_txt, false)
	GUI:setTag(buyTimes_txt, 0)

	-- Create BgCell_2
	local BgCell_2 = GUI:Image_Create(Node_3, "BgCell_2", 503, 42, "res/custom/npc/38jf/gjlist.png")
	GUI:setAnchorPoint(BgCell_2, 0.00, 0.00)
	GUI:setTouchEnabled(BgCell_2, false)
	GUI:setTag(BgCell_2, 0)

	-- Create titleImg
	titleImg = GUI:Image_Create(BgCell_2, "titleImg", 143, 280, "res/custom/npc/38jf/gjtle2.png")
	GUI:setAnchorPoint(titleImg, 0.50, 0.00)
	GUI:setTouchEnabled(titleImg, false)
	GUI:setTag(titleImg, 0)

	-- Create free_item_1
	local free_item_1 = GUI:ItemShow_Create(BgCell_2, "free_item_1", 66, 230, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(free_item_1, 0.50, 0.50)
	GUI:setTag(free_item_1, 0)

	-- Create free_item_2
	local free_item_2 = GUI:ItemShow_Create(BgCell_2, "free_item_2", 143, 231, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(free_item_2, 0.50, 0.50)
	GUI:setTag(free_item_2, 0)

	-- Create free_item_3
	local free_item_3 = GUI:ItemShow_Create(BgCell_2, "free_item_3", 220, 231, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(free_item_3, 0.50, 0.50)
	GUI:setTag(free_item_3, 0)

	-- Create RichText_1
	RichText_1 = GUI:RichText_Create(BgCell_2, "RichText_1", 142, 115, [[<font color='#9b00ff' size='16' >今日充值任意金额</font>]], 140, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.50, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(BgCell_2, "Text_1", 142, 87, 16, "#00ff00", [[免费赠送]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.50, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create getBtn
	local getBtn = GUI:Button_Create(BgCell_2, "getBtn", 143, 38, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(getBtn, "res/custom/btn12.png")
	GUI:setContentSize(getBtn, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(getBtn, false)
	GUI:Button_setTitleText(getBtn, [[领     取]])
	GUI:Button_setTitleColor(getBtn, "#ffff00")
	GUI:Button_setTitleFontSize(getBtn, 18)
	GUI:Button_titleEnableOutline(getBtn, "#000000", 1)
	GUI:setAnchorPoint(getBtn, 0.50, 0.00)
	GUI:setTouchEnabled(getBtn, true)
	GUI:setTag(getBtn, 0)

	-- Create Text_2
	Text_2 = GUI:Text_Create(BgCell_2, "Text_2", 90, 11, 16, "#bdbdb5", [[每日限领:]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create getTimes_txt
	local getTimes_txt = GUI:Text_Create(BgCell_2, "getTimes_txt", 168, 11, 16, "#00ff00", [[0 / 1]])
	GUI:Text_enableOutline(getTimes_txt, "#000000", 1)
	GUI:setAnchorPoint(getTimes_txt, 0.00, 0.00)
	GUI:setTouchEnabled(getTimes_txt, false)
	GUI:setTag(getTimes_txt, 0)

	-- Create Node_4
	local Node_4 = GUI:Node_Create(FrameLayout, "Node_4", 0, 0)
	GUI:setTag(Node_4, 0)
	GUI:setVisible(Node_4, false)

	-- Create rateTxt
	local rateTxt = GUI:Text_Create(Node_4, "rateTxt", 210, 410, 16, "#009bff", [[金符助力比例:  1 比 100]])
	GUI:Text_enableOutline(rateTxt, "#000000", 1)
	GUI:setAnchorPoint(rateTxt, 0.00, 0.00)
	GUI:setTouchEnabled(rateTxt, false)
	GUI:setTag(rateTxt, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Node_4, "Image_1", 196, 30, "res/custom/npc/38jf/tp4.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(Node_4, "Text_3", 214, 272, 16, "#00ff00", [[保底10倍: 20*100*10倍 = 20000 金符]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create Text_4
	local Text_4 = GUI:Text_Create(Node_4, "Text_4", 214, 246, 16, "#9b00ff", [[暴击20倍: 20*100*20倍 = 40000 金符]])
	GUI:Text_enableOutline(Text_4, "#000000", 1)
	GUI:setAnchorPoint(Text_4, 0.00, 0.00)
	GUI:setTouchEnabled(Text_4, false)
	GUI:setTag(Text_4, 0)

	-- Create BgCell_3
	local BgCell_3 = GUI:Image_Create(Node_4, "BgCell_3", 503, 42, "res/custom/npc/38jf/gjlist.png")
	GUI:setAnchorPoint(BgCell_3, 0.00, 0.00)
	GUI:setTouchEnabled(BgCell_3, false)
	GUI:setTag(BgCell_3, 0)

	-- Create titleImg
	titleImg = GUI:Image_Create(BgCell_3, "titleImg", 143, 280, "res/custom/npc/38jf/z10.png")
	GUI:setAnchorPoint(titleImg, 0.50, 0.00)
	GUI:setTouchEnabled(titleImg, false)
	GUI:setTag(titleImg, 0)

	-- Create xy_item_1
	local xy_item_1 = GUI:ItemShow_Create(BgCell_3, "xy_item_1", 66, 248, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xy_item_1, 0.50, 0.50)
	GUI:setTag(xy_item_1, 0)

	-- Create xy_item_2
	local xy_item_2 = GUI:ItemShow_Create(BgCell_3, "xy_item_2", 143, 249, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xy_item_2, 0.50, 0.50)
	GUI:setTag(xy_item_2, 0)

	-- Create xy_item_3
	local xy_item_3 = GUI:ItemShow_Create(BgCell_3, "xy_item_3", 220, 249, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xy_item_3, 0.50, 0.50)
	GUI:setTag(xy_item_3, 0)

	-- Create xy_item_4
	local xy_item_4 = GUI:ItemShow_Create(BgCell_3, "xy_item_4", 66, 180, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xy_item_4, 0.50, 0.50)
	GUI:setTag(xy_item_4, 0)

	-- Create xy_item_5
	local xy_item_5 = GUI:ItemShow_Create(BgCell_3, "xy_item_5", 143, 181, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xy_item_5, 0.50, 0.50)
	GUI:setTag(xy_item_5, 0)

	-- Create xy_item_6
	local xy_item_6 = GUI:ItemShow_Create(BgCell_3, "xy_item_6", 220, 181, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xy_item_6, 0.50, 0.50)
	GUI:setTag(xy_item_6, 0)

	-- Create RichText_1
	RichText_1 = GUI:RichText_Create(BgCell_3, "RichText_1", 142, 114, [[<font color='#bdbdb5' size='16' >保底10倍:  </font><font color='#00ff00' size='16' >20000金符</font>]], 180, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.50, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(BgCell_3, "RichText_2", 142, 90, [[<font color='#bdbdb5' size='16' >保底20倍:  </font><font color='#9b00ff' size='16' >40000金符</font>]], 180, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.50, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create buyBtn2
	local buyBtn2 = GUI:Button_Create(BgCell_3, "buyBtn2", 143, 38, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(buyBtn2, "res/custom/btn12.png")
	GUI:setContentSize(buyBtn2, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(buyBtn2, false)
	GUI:Button_setTitleText(buyBtn2, [[购     买]])
	GUI:Button_setTitleColor(buyBtn2, "#ffff00")
	GUI:Button_setTitleFontSize(buyBtn2, 18)
	GUI:Button_titleEnableOutline(buyBtn2, "#000000", 1)
	GUI:setAnchorPoint(buyBtn2, 0.50, 0.00)
	GUI:setTouchEnabled(buyBtn2, true)
	GUI:setTag(buyBtn2, 0)

	-- Create buyEndImg
	local buyEndImg = GUI:Image_Create(BgCell_3, "buyEndImg", 92, 42, "res/custom/npc/38jf/ysq.png")
	GUI:setAnchorPoint(buyEndImg, 0.00, 0.00)
	GUI:setTouchEnabled(buyEndImg, false)
	GUI:setTag(buyEndImg, 0)
	GUI:setVisible(buyEndImg, false)

	-- Create Text_2
	Text_2 = GUI:Text_Create(BgCell_3, "Text_2", 85, 11, 16, "#bdbdb5", [[每日限购:]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create buy_txt
	local buy_txt = GUI:Text_Create(BgCell_3, "buy_txt", 163, 11, 16, "#00ff00", [[0 / 10]])
	GUI:Text_enableOutline(buy_txt, "#000000", 1)
	GUI:setAnchorPoint(buy_txt, 0.00, 0.00)
	GUI:setTouchEnabled(buy_txt, false)
	GUI:setTag(buy_txt, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(BgCell_3, "Image_2", 1, 263, "res/custom/npc/38jf/icon.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create mask
	local mask = GUI:Layout_Create(Node_4, "mask", 0, 0, 846, 566, false)
	GUI:setAnchorPoint(mask, 0.00, 0.00)
	GUI:setTouchEnabled(mask, true)
	GUI:setMouseEnabled(mask, true)
	GUI:setTag(mask, 0)
	GUI:setVisible(mask, false)

	-- Create maskBg
	local maskBg = GUI:Image_Create(mask, "maskBg", 226, 173, "res/custom/bossbg.png")
	GUI:setAnchorPoint(maskBg, 0.00, 0.00)
	GUI:setTouchEnabled(maskBg, true)
	GUI:setMouseEnabled(maskBg, true)
	GUI:setTag(maskBg, 0)

	-- Create maskTypeText
	local maskTypeText = GUI:Text_Create(maskBg, "maskTypeText", 224, 178, 16, "#ff0000", [[批量购买]])
	GUI:Text_enableOutline(maskTypeText, "#000000", 1)
	GUI:setAnchorPoint(maskTypeText, 0.50, 0.50)
	GUI:setTouchEnabled(maskTypeText, false)
	GUI:setTag(maskTypeText, 0)

	-- Create maskPrice1
	local maskPrice1 = GUI:Text_Create(maskBg, "maskPrice1", 72, 112, 16, "#ff00ff", [[￥20元]])
	GUI:Text_enableOutline(maskPrice1, "#000000", 1)
	GUI:setAnchorPoint(maskPrice1, 0.50, 0.50)
	GUI:setTouchEnabled(maskPrice1, false)
	GUI:setTag(maskPrice1, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(maskPrice1, "Text_1", 74, 0, 16, "#00ff00", [[随机 10 - 20倍 金符]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create maskPrice2
	local maskPrice2 = GUI:Text_Create(maskBg, "maskPrice2", 72, 50, 16, "#ff00ff", [[￥200元]])
	GUI:Text_enableOutline(maskPrice2, "#000000", 1)
	GUI:setAnchorPoint(maskPrice2, 0.50, 0.50)
	GUI:setTouchEnabled(maskPrice2, false)
	GUI:setTag(maskPrice2, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(maskPrice2, "Text_1", 86, 0, 16, "#00ff00", [[百分百 20倍 金符]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create maskBuyBtn1
	local maskBuyBtn1 = GUI:Button_Create(maskBg, "maskBuyBtn1", 280, 94, "res/custom/npc/39baoz/buy01.png")
	GUI:Button_loadTexturePressed(maskBuyBtn1, "res/custom/npc/39baoz/buy02.png")
	GUI:setContentSize(maskBuyBtn1, 150, 42)
	GUI:setIgnoreContentAdaptWithSize(maskBuyBtn1, false)
	GUI:Button_setTitleText(maskBuyBtn1, [[]])
	GUI:Button_setTitleColor(maskBuyBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(maskBuyBtn1, 16)
	GUI:Button_titleEnableOutline(maskBuyBtn1, "#000000", 1)
	GUI:setAnchorPoint(maskBuyBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(maskBuyBtn1, true)
	GUI:setTag(maskBuyBtn1, 0)

	-- Create maskBuyBtn2
	local maskBuyBtn2 = GUI:Button_Create(maskBg, "maskBuyBtn2", 280, 30, "res/custom/npc/39baoz/buy11.png")
	GUI:Button_loadTexturePressed(maskBuyBtn2, "res/custom/npc/39baoz/buy12.png")
	GUI:setContentSize(maskBuyBtn2, 150, 42)
	GUI:setIgnoreContentAdaptWithSize(maskBuyBtn2, false)
	GUI:Button_setTitleText(maskBuyBtn2, [[]])
	GUI:Button_setTitleColor(maskBuyBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(maskBuyBtn2, 16)
	GUI:Button_titleEnableOutline(maskBuyBtn2, "#000000", 1)
	GUI:setAnchorPoint(maskBuyBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(maskBuyBtn2, true)
	GUI:setTag(maskBuyBtn2, 0)

	-- Create maskCloseBtn
	local maskCloseBtn = GUI:Button_Create(maskBg, "maskCloseBtn", 414, 164, "res/public/01.png")
	GUI:Button_loadTexturePressed(maskCloseBtn, "res/public/02.png")
	GUI:setContentSize(maskCloseBtn, 30, 30)
	GUI:setIgnoreContentAdaptWithSize(maskCloseBtn, false)
	GUI:Button_setTitleText(maskCloseBtn, [[]])
	GUI:Button_setTitleColor(maskCloseBtn, "#ffffff")
	GUI:Button_setTitleFontSize(maskCloseBtn, 16)
	GUI:Button_titleEnableOutline(maskCloseBtn, "#000000", 1)
	GUI:setAnchorPoint(maskCloseBtn, 0.00, 0.00)
	GUI:setTouchEnabled(maskCloseBtn, true)
	GUI:setTag(maskCloseBtn, 0)

	-- Create Node_5
	local Node_5 = GUI:Node_Create(FrameLayout, "Node_5", 0, 0)
	GUI:setTag(Node_5, 0)

	-- Create BgCell_4
	local BgCell_4 = GUI:Image_Create(Node_5, "BgCell_4", 205, 42, "res/custom/npc/38jf/gjlist.png")
	GUI:setAnchorPoint(BgCell_4, 0.00, 0.00)
	GUI:setTouchEnabled(BgCell_4, false)
	GUI:setTag(BgCell_4, 0)

	-- Create titleImg
	titleImg = GUI:Image_Create(BgCell_4, "titleImg", 143, 280, "res/custom/npc/38jf/xftl1.png")
	GUI:setAnchorPoint(titleImg, 0.50, 0.00)
	GUI:setTouchEnabled(titleImg, false)
	GUI:setTag(titleImg, 0)

	-- Create xf_item_1
	local xf_item_1 = GUI:ItemShow_Create(BgCell_4, "xf_item_1", 66, 246, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_1, 0.50, 0.50)
	GUI:setTag(xf_item_1, 0)

	-- Create xf_item_2
	local xf_item_2 = GUI:ItemShow_Create(BgCell_4, "xf_item_2", 143, 247, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_2, 0.50, 0.50)
	GUI:setTag(xf_item_2, 0)

	-- Create xf_item_3
	local xf_item_3 = GUI:ItemShow_Create(BgCell_4, "xf_item_3", 220, 247, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_3, 0.50, 0.50)
	GUI:setTag(xf_item_3, 0)

	-- Create xf_item_4
	local xf_item_4 = GUI:ItemShow_Create(BgCell_4, "xf_item_4", 66, 180, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_4, 0.50, 0.50)
	GUI:setTag(xf_item_4, 0)

	-- Create xf_item_5
	local xf_item_5 = GUI:ItemShow_Create(BgCell_4, "xf_item_5", 143, 181, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_5, 0.50, 0.50)
	GUI:setTag(xf_item_5, 0)

	-- Create xf_item_6
	local xf_item_6 = GUI:ItemShow_Create(BgCell_4, "xf_item_6", 220, 181, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_6, 0.50, 0.50)
	GUI:setTag(xf_item_6, 0)

	-- Create RichText_1
	RichText_1 = GUI:RichText_Create(BgCell_4, "RichText_1", 142, 105, [[<font color='#bdbdb5' size='16' >价格:  </font><font color='#00ff00' size='16' >19800金符</font>]], 140, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.50, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create buyBtn3
	local buyBtn3 = GUI:Button_Create(BgCell_4, "buyBtn3", 143, 25, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(buyBtn3, "res/custom/btn12.png")
	GUI:setContentSize(buyBtn3, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(buyBtn3, false)
	GUI:Button_setTitleText(buyBtn3, [[购      买]])
	GUI:Button_setTitleColor(buyBtn3, "#ffff00")
	GUI:Button_setTitleFontSize(buyBtn3, 18)
	GUI:Button_titleEnableOutline(buyBtn3, "#000000", 1)
	GUI:setAnchorPoint(buyBtn3, 0.50, 0.00)
	GUI:setTouchEnabled(buyBtn3, true)
	GUI:setTag(buyBtn3, 0)

	-- Create BgCell_5
	local BgCell_5 = GUI:Image_Create(Node_5, "BgCell_5", 503, 42, "res/custom/npc/38jf/gjlist.png")
	GUI:setAnchorPoint(BgCell_5, 0.00, 0.00)
	GUI:setTouchEnabled(BgCell_5, false)
	GUI:setTag(BgCell_5, 0)

	-- Create titleImg
	titleImg = GUI:Image_Create(BgCell_5, "titleImg", 143, 280, "res/custom/npc/38jf/xftl2.png")
	GUI:setAnchorPoint(titleImg, 0.50, 0.00)
	GUI:setTouchEnabled(titleImg, false)
	GUI:setTag(titleImg, 0)

	-- Create xf_item_11
	local xf_item_11 = GUI:ItemShow_Create(BgCell_5, "xf_item_11", 66, 246, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_11, 0.50, 0.50)
	GUI:setTag(xf_item_11, 0)

	-- Create xf_item_22
	local xf_item_22 = GUI:ItemShow_Create(BgCell_5, "xf_item_22", 143, 247, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_22, 0.50, 0.50)
	GUI:setTag(xf_item_22, 0)

	-- Create xf_item_33
	local xf_item_33 = GUI:ItemShow_Create(BgCell_5, "xf_item_33", 220, 247, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_33, 0.50, 0.50)
	GUI:setTag(xf_item_33, 0)

	-- Create xf_item_44
	local xf_item_44 = GUI:ItemShow_Create(BgCell_5, "xf_item_44", 66, 180, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_44, 0.50, 0.50)
	GUI:setTag(xf_item_44, 0)

	-- Create xf_item_55
	local xf_item_55 = GUI:ItemShow_Create(BgCell_5, "xf_item_55", 143, 181, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_55, 0.50, 0.50)
	GUI:setTag(xf_item_55, 0)

	-- Create xf_item_66
	local xf_item_66 = GUI:ItemShow_Create(BgCell_5, "xf_item_66", 220, 181, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(xf_item_66, 0.50, 0.50)
	GUI:setTag(xf_item_66, 0)

	-- Create RichText_1
	RichText_1 = GUI:RichText_Create(BgCell_5, "RichText_1", 142, 105, [[<font color='#bdbdb5' size='16' >价格:  </font><font color='#00ff00' size='16' >88元</font>]], 80, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.50, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create buyBtn4
	local buyBtn4 = GUI:Button_Create(BgCell_5, "buyBtn4", 143, 25, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(buyBtn4, "res/custom/btn12.png")
	GUI:setContentSize(buyBtn4, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(buyBtn4, false)
	GUI:Button_setTitleText(buyBtn4, [[购      买]])
	GUI:Button_setTitleColor(buyBtn4, "#ffff00")
	GUI:Button_setTitleFontSize(buyBtn4, 18)
	GUI:Button_titleEnableOutline(buyBtn4, "#000000", 1)
	GUI:setAnchorPoint(buyBtn4, 0.50, 0.00)
	GUI:setTouchEnabled(buyBtn4, true)
	GUI:setTag(buyBtn4, 0)

	-- Create Frames_1
	local Frames_1 = GUI:Frames_Create(Node_5, "Frames_1", 494, 110, "res/custom/s/s", ".png", 1, 15, {count=15, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(Frames_1, 0.50, 0.50)
	GUI:setTouchEnabled(Frames_1, false)
	GUI:setTag(Frames_1, 0)

	-- Create Node_6
	local Node_6 = GUI:Node_Create(FrameLayout, "Node_6", 0, 0)
	GUI:setTag(Node_6, 0)
	GUI:setVisible(Node_6, false)

	-- Create Node_7
	local Node_7 = GUI:Node_Create(FrameLayout, "Node_7", 0, 0)
	GUI:setTag(Node_7, 0)
	GUI:setVisible(Node_7, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
