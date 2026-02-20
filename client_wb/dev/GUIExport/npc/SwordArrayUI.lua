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
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 580, 322, 796, 550, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/50zh/bg5.png")
	GUI:Image_setScale9Slice(FrameBG, 79, 79, 183, 183)
	GUI:setContentSize(FrameBG, 796, 550)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 720, 454, "res/custom/npc/close3.png")
	GUI:setContentSize(closeBtn, 58, 50)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create layerText
	local layerText = GUI:Text_Create(midNode, "layerText", 394, 307, 18, "#ff0000", [[0]])
	GUI:Text_enableOutline(layerText, "#000000", 1)
	GUI:setAnchorPoint(layerText, 0.00, 0.00)
	GUI:setTouchEnabled(layerText, false)
	GUI:setTag(layerText, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(midNode, "RichText_1", 174, 256, [==========[<font color='#c0c0c0' size='17' >每次投放[                    ]可获得：</font>]==========], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create itemRText1
	local itemRText1 = GUI:RichText_Create(midNode, "itemRText1", 254, 256, [[<font color='#ffff00' size='17' ><a enableUnderline ='false' href = 'jump#item_tips#10790'><u><font color ='#FFFF00'>诛仙碎片</font></u></a></font>]], 100, 16, "#ffff00", 4)
	GUI:setAnchorPoint(itemRText1, 0.00, 0.00)
	GUI:setTag(itemRText1, 0)

	-- Create itemRText2
	local itemRText2 = GUI:RichText_Create(midNode, "itemRText2", 398, 256, [[<font color='#ffff00' size='17' ><a enableUnderline ='false' href = 'jump#item_tips#10789'><u><font color ='#FFFF00'>幻灵石×1</font></u></a></font>]], 100, 16, "#ffff00", 4)
	GUI:setAnchorPoint(itemRText2, 0.00, 0.00)
	GUI:setTag(itemRText2, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(midNode, "RichText_2", 174, 226, [[<font color='#c0c0c0' size='17' >每投放满</font><font color='#fe00fe' size='17' >99次</font><font color='#c0c0c0' size='17' >，诛仙剑阵地图复活：</font><font color='#ff0000' size='17' >诛仙剑魔</font>]], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create RichText_3
	local RichText_3 = GUI:RichText_Create(midNode, "RichText_3", 174, 198, [[<font color='#00ff00' size='17' >上古剑阵(跨服)</font><font color='#c0c0c0' size='17' >地图每6小时刷新：</font><font color='#ff9b00' size='17' >上古剑魔</font>]], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_3, 0.00, 0.00)
	GUI:setTag(RichText_3, 0)

	-- Create RichText_4
	local RichText_4 = GUI:RichText_Create(midNode, "RichText_4", 174, 170, [==========[<font color='#ff0000' size='17' >[诛仙、上古剑魔]</font><font color='#c0c0c0' size='17' > 几率爆出：</font><font color='#00ffe8' size='17' >绝世级武器</font>]==========], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_4, 0.00, 0.00)
	GUI:setTag(RichText_4, 0)

	-- Create goBtn1
	local goBtn1 = GUI:Button_Create(midNode, "goBtn1", 198, 126, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(goBtn1, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(goBtn1, 0, 0, 0, 0)
	GUI:setContentSize(goBtn1, 116, 38)
	GUI:setIgnoreContentAdaptWithSize(goBtn1, false)
	GUI:Button_setTitleText(goBtn1, [[进入诛仙剑阵]])
	GUI:Button_setTitleColor(goBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(goBtn1, 17)
	GUI:Button_titleEnableOutline(goBtn1, "#000000", 1)
	GUI:setAnchorPoint(goBtn1, 0.50, 0.50)
	GUI:setTouchEnabled(goBtn1, true)
	GUI:setTag(goBtn1, 0)

	-- Create text11
	local text11 = GUI:Text_Create(goBtn1, "text11", 6, -30, 16, "#c0c0c0", [[消耗：]])
	GUI:Text_enableOutline(text11, "#000000", 1)
	GUI:setAnchorPoint(text11, 0.00, 0.00)
	GUI:setTouchEnabled(text11, false)
	GUI:setTag(text11, 0)

	-- Create text12
	local text12 = GUI:Text_Create(goBtn1, "text12", 50, -30, 16, "#00ff00", [[仙石*10]])
	GUI:Text_enableOutline(text12, "#000000", 1)
	GUI:setAnchorPoint(text12, 0.00, 0.00)
	GUI:setTouchEnabled(text12, false)
	GUI:setTag(text12, 0)

	-- Create goBtn2
	local goBtn2 = GUI:Button_Create(midNode, "goBtn2", 350, 126, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(goBtn2, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(goBtn2, 0, 0, 0, 0)
	GUI:setContentSize(goBtn2, 116, 38)
	GUI:setIgnoreContentAdaptWithSize(goBtn2, false)
	GUI:Button_setTitleText(goBtn2, [[进入上古剑阵]])
	GUI:Button_setTitleColor(goBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(goBtn2, 17)
	GUI:Button_titleEnableOutline(goBtn2, "#000000", 1)
	GUI:setAnchorPoint(goBtn2, 0.50, 0.50)
	GUI:setTouchEnabled(goBtn2, true)
	GUI:setTag(goBtn2, 0)

	-- Create text21
	local text21 = GUI:Text_Create(goBtn2, "text21", 4, -30, 16, "#c0c0c0", [[消耗：]])
	GUI:Text_enableOutline(text21, "#000000", 1)
	GUI:setAnchorPoint(text21, 0.00, 0.00)
	GUI:setTouchEnabled(text21, false)
	GUI:setTag(text21, 0)

	-- Create text22
	local text22 = GUI:Text_Create(goBtn2, "text22", 48, -30, 16, "#00ff00", [[幻灵石*1]])
	GUI:Text_enableOutline(text22, "#000000", 1)
	GUI:setAnchorPoint(text22, 0.00, 0.00)
	GUI:setTouchEnabled(text22, false)
	GUI:setTag(text22, 0)

	-- Create goBtn3
	local goBtn3 = GUI:Button_Create(midNode, "goBtn3", 498, 126, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(goBtn3, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(goBtn3, 0, 0, 0, 0)
	GUI:setContentSize(goBtn3, 116, 38)
	GUI:setIgnoreContentAdaptWithSize(goBtn3, false)
	GUI:Button_setTitleText(goBtn3, [[投放诛仙碎片]])
	GUI:Button_setTitleColor(goBtn3, "#ffffff")
	GUI:Button_setTitleFontSize(goBtn3, 17)
	GUI:Button_titleEnableOutline(goBtn3, "#000000", 1)
	GUI:setAnchorPoint(goBtn3, 0.50, 0.50)
	GUI:setTouchEnabled(goBtn3, true)
	GUI:setTag(goBtn3, 0)

	-- Create text31
	local text31 = GUI:Text_Create(goBtn3, "text31", -2, -30, 16, "#c0c0c0", [[消耗：]])
	GUI:Text_enableOutline(text31, "#000000", 1)
	GUI:setAnchorPoint(text31, 0.00, 0.00)
	GUI:setTouchEnabled(text31, false)
	GUI:setTag(text31, 0)

	-- Create text32
	local text32 = GUI:Text_Create(goBtn3, "text32", 42, -30, 16, "#00ff00", [[诛仙碎片*1]])
	GUI:Text_enableOutline(text32, "#000000", 1)
	GUI:setAnchorPoint(text32, 0.00, 0.00)
	GUI:setTouchEnabled(text32, false)
	GUI:setTag(text32, 0)

	-- Create needBg
	local needBg = GUI:Image_Create(midNode, "needBg", 581, 88, "res/custom/npc/0gsha/tips.png")
	GUI:Image_setScale9Slice(needBg, 7, 7, 10, 10)
	GUI:setContentSize(needBg, 170, 200)
	GUI:setIgnoreContentAdaptWithSize(needBg, false)
	GUI:setAnchorPoint(needBg, 0.00, 0.00)
	GUI:setTouchEnabled(needBg, false)
	GUI:setTag(needBg, 0)

	-- Create item_1
	local item_1 = GUI:ItemShow_Create(needBg, "item_1", 87, 136, {index = 1, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(item_1, 0.50, 0.50)
	GUI:setTag(item_1, 0)

	-- Create buyBtn
	local buyBtn = GUI:Button_Create(needBg, "buyBtn", 90, 36, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(buyBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(buyBtn, 0, 0, 0, 0)
	GUI:setContentSize(buyBtn, 100, 38)
	GUI:setIgnoreContentAdaptWithSize(buyBtn, false)
	GUI:Button_setTitleText(buyBtn, [[购买碎片]])
	GUI:Button_setTitleColor(buyBtn, "#ffffff")
	GUI:Button_setTitleFontSize(buyBtn, 17)
	GUI:Button_titleEnableOutline(buyBtn, "#000000", 1)
	GUI:setAnchorPoint(buyBtn, 0.50, 0.50)
	GUI:setTouchEnabled(buyBtn, true)
	GUI:setTag(buyBtn, 0)

	-- Create text11
	text11 = GUI:Text_Create(buyBtn, "text11", -16, 50, 16, "#c0c0c0", [[消耗：]])
	GUI:Text_enableOutline(text11, "#000000", 1)
	GUI:setAnchorPoint(text11, 0.00, 0.00)
	GUI:setTouchEnabled(text11, false)
	GUI:setTag(text11, 0)

	-- Create text12
	text12 = GUI:Text_Create(buyBtn, "text12", 28, 50, 16, "#00ff00", [[元宝*10000]])
	GUI:Text_enableOutline(text12, "#000000", 1)
	GUI:setAnchorPoint(text12, 0.00, 0.00)
	GUI:setTouchEnabled(text12, false)
	GUI:setTag(text12, 0)

	-- Create downBg
	local downBg = GUI:Image_Create(midNode, "downBg", 132, 32, "res/custom/npc/0gsha/tips.png")
	GUI:Image_setScale9Slice(downBg, 7, 7, 10, 10)
	GUI:setContentSize(downBg, 440, 36)
	GUI:setIgnoreContentAdaptWithSize(downBg, false)
	GUI:setAnchorPoint(downBg, 0.00, 0.00)
	GUI:setTouchEnabled(downBg, false)
	GUI:setTag(downBg, 0)
	GUI:setVisible(downBg, false)

	-- Create RichText_5
	local RichText_5 = GUI:RichText_Create(downBg, "RichText_5", 10, 7, [[<font color='#c0c0c0' size='17' >使用 </font><font color='#fe00fe' size='17' >黄金钥匙*2 </font><font color='#c0c0c0' size='17' >兑换 </font><font color='#00ffe8' size='17' >诛仙碎片</font>]], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_5, 0.00, 0.00)
	GUI:setTag(RichText_5, 0)

	-- Create buyText1
	local buyText1 = GUI:Text_Create(downBg, "buyText1", 282, 7, 17, "#ffff00", [[兑换1次]])
	GUI:Text_enableOutline(buyText1, "#000000", 1)
	GUI:Text_enableUnderline(buyText1)
	GUI:setAnchorPoint(buyText1, 0.00, 0.00)
	GUI:setTouchEnabled(buyText1, true)
	GUI:setMouseEnabled(buyText1, true)
	GUI:setTag(buyText1, 0)

	-- Create buyText2
	local buyText2 = GUI:Text_Create(downBg, "buyText2", 360, 7, 17, "#ffff00", [[兑换10次]])
	GUI:Text_enableOutline(buyText2, "#000000", 1)
	GUI:Text_enableUnderline(buyText2)
	GUI:setAnchorPoint(buyText2, 0.00, 0.00)
	GUI:setTouchEnabled(buyText2, true)
	GUI:setMouseEnabled(buyText2, true)
	GUI:setTag(buyText2, 0)

	-- Create mask
	local mask = GUI:Layout_Create(FrameLayout, "mask", 0, 0, 796, 550, false)
	GUI:setAnchorPoint(mask, 0.00, 0.00)
	GUI:setTouchEnabled(mask, true)
	GUI:setMouseEnabled(mask, true)
	GUI:setTag(mask, 0)
	GUI:setVisible(mask, false)

	-- Create maskBg
	local maskBg = GUI:Image_Create(mask, "maskBg", 196, 133, "res/custom/bossbg.png")
	GUI:setAnchorPoint(maskBg, 0.00, 0.00)
	GUI:setTouchEnabled(maskBg, true)
	GUI:setMouseEnabled(maskBg, true)
	GUI:setTag(maskBg, 0)

	-- Create maskTypeText
	local maskTypeText = GUI:Text_Create(maskBg, "maskTypeText", 224, 178, 16, "#ff0000", [[诛仙碎片购买]])
	GUI:Text_enableOutline(maskTypeText, "#000000", 1)
	GUI:setAnchorPoint(maskTypeText, 0.50, 0.50)
	GUI:setTouchEnabled(maskTypeText, false)
	GUI:setTag(maskTypeText, 0)

	-- Create maskPrice1
	local maskPrice1 = GUI:Text_Create(maskBg, "maskPrice1", 72, 112, 16, "#ff00ff", [[10000元宝]])
	GUI:Text_enableOutline(maskPrice1, "#000000", 1)
	GUI:setAnchorPoint(maskPrice1, 0.50, 0.50)
	GUI:setTouchEnabled(maskPrice1, false)
	GUI:setTag(maskPrice1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(maskPrice1, "Text_1", 90, 0, 16, "#00ff00", [[单次购买慢慢来！]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create maskPrice2
	local maskPrice2 = GUI:Text_Create(maskBg, "maskPrice2", 72, 50, 16, "#ff00ff", [[100000元宝]])
	GUI:Text_enableOutline(maskPrice2, "#000000", 1)
	GUI:setAnchorPoint(maskPrice2, 0.50, 0.50)
	GUI:setTouchEnabled(maskPrice2, false)
	GUI:setTag(maskPrice2, 0)

	-- Create Text_1
	Text_1 = GUI:Text_Create(maskPrice2, "Text_1", 95, 0, 16, "#00ff00", [[一步到位爽爽爽！]])
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

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
