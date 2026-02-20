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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/31fs/bg.png")
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

	-- Create Image_4
	local Image_4 = GUI:Image_Create(leftBtnList, "Image_4", 0, 396, "res/custom/npc/ta0.png")
	GUI:setContentSize(Image_4, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Image_4, false)
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(leftBtnList, "Image_5", 0, 350, "res/custom/npc/ta0.png")
	GUI:setContentSize(Image_5, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(Image_5, false)
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create layerBg
	local layerBg = GUI:Image_Create(midNode, "layerBg", 206, 358, "res/custom/npc/31fs/xbg.png")
	GUI:setContentSize(layerBg, 42, 115)
	GUI:setIgnoreContentAdaptWithSize(layerBg, false)
	GUI:setAnchorPoint(layerBg, 0.00, 0.00)
	GUI:setTouchEnabled(layerBg, false)
	GUI:setTag(layerBg, 0)

	-- Create layerImg
	local layerImg = GUI:Image_Create(layerBg, "layerImg", 21, 62, "res/custom/npc/31fs/fs0.png")
	GUI:setAnchorPoint(layerImg, 0.50, 0.50)
	GUI:setTouchEnabled(layerImg, false)
	GUI:setTag(layerImg, 0)

	-- Create frameImg
	local frameImg = GUI:Frames_Create(layerBg, "frameImg", 172, -50, "res/custom/npc/31fs/fe", ".png", 1, 15, {count=15, speed=100, loop=-1, finishhide=0})
	GUI:setAnchorPoint(frameImg, 0.50, 0.50)
	GUI:setTouchEnabled(frameImg, false)
	GUI:setTag(frameImg, 0)

	-- Create infoNode1
	local infoNode1 = GUI:Node_Create(midNode, "infoNode1", 678, 394)
	GUI:setTag(infoNode1, 0)

	-- Create text111
	local text111 = GUI:Text_Create(infoNode1, "text111", 0, 0, 16, "#ffffff", [[体  力：]])
	GUI:Text_enableOutline(text111, "#000000", 1)
	GUI:setAnchorPoint(text111, 0.00, 0.00)
	GUI:setTouchEnabled(text111, false)
	GUI:setTag(text111, 0)

	-- Create text112
	local text112 = GUI:Text_Create(text111, "text112", 55, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text112, "#000000", 1)
	GUI:setAnchorPoint(text112, 0.00, 0.00)
	GUI:setTouchEnabled(text112, false)
	GUI:setTag(text112, 0)

	-- Create text121
	local text121 = GUI:Text_Create(infoNode1, "text121", 0, 0, 16, "#ffffff", [[防魔御：]])
	GUI:Text_enableOutline(text121, "#000000", 1)
	GUI:setAnchorPoint(text121, 0.00, 0.00)
	GUI:setTouchEnabled(text121, false)
	GUI:setTag(text121, 0)

	-- Create text122
	local text122 = GUI:Text_Create(text121, "text122", 64, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text122, "#000000", 1)
	GUI:setAnchorPoint(text122, 0.00, 0.00)
	GUI:setTouchEnabled(text122, false)
	GUI:setTag(text122, 0)

	-- Create text131
	local text131 = GUI:Text_Create(infoNode1, "text131", 0, 0, 16, "#ffffff", [[攻魔道：]])
	GUI:Text_enableOutline(text131, "#000000", 1)
	GUI:setAnchorPoint(text131, 0.00, 0.00)
	GUI:setTouchEnabled(text131, false)
	GUI:setTag(text131, 0)

	-- Create text132
	local text132 = GUI:Text_Create(text131, "text132", 64, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text132, "#000000", 1)
	GUI:setAnchorPoint(text132, 0.00, 0.00)
	GUI:setTouchEnabled(text132, false)
	GUI:setTag(text132, 0)

	-- Create text141
	local text141 = GUI:Text_Create(infoNode1, "text141", 0, 0, 16, "#ffff00", [[攻击伤害：]])
	GUI:Text_enableOutline(text141, "#000000", 1)
	GUI:setAnchorPoint(text141, 0.00, 0.00)
	GUI:setTouchEnabled(text141, false)
	GUI:setTag(text141, 0)

	-- Create text142
	local text142 = GUI:Text_Create(text141, "text142", 80, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text142, "#000000", 1)
	GUI:setAnchorPoint(text142, 0.00, 0.00)
	GUI:setTouchEnabled(text142, false)
	GUI:setTag(text142, 0)

	-- Create infoNode2
	local infoNode2 = GUI:Node_Create(midNode, "infoNode2", 678, 254)
	GUI:setTag(infoNode2, 0)

	-- Create text211
	local text211 = GUI:Text_Create(infoNode2, "text211", 0, 0, 16, "#ffffff", [[体  力：]])
	GUI:Text_enableOutline(text211, "#000000", 1)
	GUI:setAnchorPoint(text211, 0.00, 0.00)
	GUI:setTouchEnabled(text211, false)
	GUI:setTag(text211, 0)

	-- Create text212
	local text212 = GUI:Text_Create(text211, "text212", 55, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text212, "#000000", 1)
	GUI:setAnchorPoint(text212, 0.00, 0.00)
	GUI:setTouchEnabled(text212, false)
	GUI:setTag(text212, 0)

	-- Create text221
	local text221 = GUI:Text_Create(infoNode2, "text221", 0, 0, 16, "#ffffff", [[防魔御：]])
	GUI:Text_enableOutline(text221, "#000000", 1)
	GUI:setAnchorPoint(text221, 0.00, 0.00)
	GUI:setTouchEnabled(text221, false)
	GUI:setTag(text221, 0)

	-- Create text222
	local text222 = GUI:Text_Create(text221, "text222", 64, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text222, "#000000", 1)
	GUI:setAnchorPoint(text222, 0.00, 0.00)
	GUI:setTouchEnabled(text222, false)
	GUI:setTag(text222, 0)

	-- Create text231
	local text231 = GUI:Text_Create(infoNode2, "text231", 0, 0, 16, "#ffffff", [[攻魔道：]])
	GUI:Text_enableOutline(text231, "#000000", 1)
	GUI:setAnchorPoint(text231, 0.00, 0.00)
	GUI:setTouchEnabled(text231, false)
	GUI:setTag(text231, 0)

	-- Create text232
	local text232 = GUI:Text_Create(text231, "text232", 64, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text232, "#000000", 1)
	GUI:setAnchorPoint(text232, 0.00, 0.00)
	GUI:setTouchEnabled(text232, false)
	GUI:setTag(text232, 0)

	-- Create text241
	local text241 = GUI:Text_Create(infoNode2, "text241", 0, 0, 16, "#ffff00", [[攻击伤害：]])
	GUI:Text_enableOutline(text241, "#000000", 1)
	GUI:setAnchorPoint(text241, 0.00, 0.00)
	GUI:setTouchEnabled(text241, false)
	GUI:setTag(text241, 0)

	-- Create text242
	local text242 = GUI:Text_Create(text241, "text242", 80, 0, 16, "#00ff00", [[2%]])
	GUI:Text_enableOutline(text242, "#000000", 1)
	GUI:setAnchorPoint(text242, 0.00, 0.00)
	GUI:setTouchEnabled(text242, false)
	GUI:setTag(text242, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(midNode, "needItemNode", 674, 128)
	GUI:setTag(needItemNode, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midNode, "upBtn", 676, 64, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:setContentSize(upBtn, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[开始飞升]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create maxImg
	local maxImg = GUI:Image_Create(midNode, "maxImg", 678, 112, "res/custom/tag/c_103.png")
	GUI:setContentSize(maxImg, 114, 66)
	GUI:setIgnoreContentAdaptWithSize(maxImg, false)
	GUI:setAnchorPoint(maxImg, 0.50, 0.50)
	GUI:setTouchEnabled(maxImg, false)
	GUI:setTag(maxImg, 0)
	GUI:setVisible(maxImg, false)

	-- Create RText1
	local RText1 = GUI:RichText_Create(midNode, "RText1", 198, 60, [[<font color='#ff9b00' size='18' >飞升效果：</font><br><font color='#9b00ff' size='18' >压制: </font><font color='#ffffff' size='18' >对</font><font color='#ffff00' size='18' >20转及以下玩家</font><font color='#ffffff' size='18' >额外造成</font><font color='#ff0000' size='18' >5%</font><font color='#ffffff' size='18' >伤害</font><br><font color='#00ffe8' size='18' >Buff:</font><font color='#00ff00' size='18' > 10%</font><font color='#ffffff' size='18' >几率麻痹目标</font><font color='#ffff00' size='18' >2秒</font><font color='#ffffff' size='18' >，</font><font color='#ff0000' size='18' >CD60秒</font>]], 370, 20, "#00ff00", 4)
	GUI:setAnchorPoint(RText1, 0.00, 0.00)
	GUI:setTag(RText1, 0)
	GUI:setVisible(RText1, false)

	-- Create RText2
	local RText2 = GUI:RichText_Create(midNode, "RText2", 198, 60, [[<font color='#ff9b00' size='18' >飞升效果：</font><br><font color='#9b00ff' size='18' >压制:</font><font color='#ffffff' size='18' > 对</font><font color='#ffff00' size='18' >金刚境及以下玩家</font><font color='#ffffff' size='18' >额外造成</font><font color='#ff0000' size='18' >6%</font><font color='#ffffff' size='18' >伤害</font><br><font color='#00ffe8' size='18' >Buff:</font><font color='#00ff00' size='18' > 10%</font><font color='#ffffff' size='18' >几率麻痹目标</font><font color='#ffff00' size='18' >2秒</font><font color='#ffffff' size='18' >，</font><font color='#ff0000' size='18' >CD60秒</font>]], 370, 20, "#00ff00", 4)
	GUI:setAnchorPoint(RText2, 0.00, 0.00)
	GUI:setTag(RText2, 0)
	GUI:setVisible(RText2, false)

	-- Create RText3
	local RText3 = GUI:RichText_Create(midNode, "RText3", 198, 60, [[<font color='#ff9b00' size='18' >飞升效果：</font><br><font color='#9b00ff' size='18' >压制:</font><font color='#ffffff' size='18' > 对</font><font color='#ffff00' size='18' >指玄境及以下玩家</font><font color='#ffffff' size='18' >额外造成</font><font color='#ff0000' size='18' >8%</font><font color='#ffffff' size='18' >伤害</font><br><font color='#00ffe8' size='18' >Buff: </font><font color='#00ff00' size='18' >10%</font><font color='#ffffff' size='18' >几率麻痹目标</font><font color='#ffff00' size='18' >2秒</font><font color='#ffffff' size='18' >，</font><font color='#ff0000' size='18' >CD60秒</font>]], 370, 20, "#00ff00", 4)
	GUI:setAnchorPoint(RText3, 0.00, 0.00)
	GUI:setTag(RText3, 0)
	GUI:setVisible(RText3, false)

	-- Create RText4
	local RText4 = GUI:RichText_Create(midNode, "RText4", 198, 60, [[<font color='#ff9b00' size='18' >飞升效果：</font><br><font color='#9b00ff' size='18' >压制:</font><font color='#ffffff' size='18' >对</font><font color='#ffff00' size='18' >天象境及以下玩家</font><font color='#ffffff' size='18' >额外造成</font><font color='#ff0000' size='18' >10%</font><font color='#ffffff' size='18' >伤害</font><br><font color='#00ffe8' size='18' >Buff:</font><font color='#00ff00' size='18' >10%</font><font color='#ffffff' size='18' >几率麻痹目标</font><font color='#ffff00' size='18' >2秒</font><font color='#ffffff' size='18' >，</font><font color='#ff0000' size='18' >CD60秒</font>]], 370, 20, "#00ff00", 4)
	GUI:setAnchorPoint(RText4, 0.00, 0.00)
	GUI:setTag(RText4, 0)
	GUI:setVisible(RText4, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
