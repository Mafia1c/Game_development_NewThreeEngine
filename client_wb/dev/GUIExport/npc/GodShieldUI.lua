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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/32sd/bg1.png")
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

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create equipNode1
	local equipNode1 = GUI:Node_Create(midNode, "equipNode1", 269, 370)
	GUI:setTag(equipNode1, 0)

	-- Create equip1
	local equip1 = GUI:ItemShow_Create(equipNode1, "equip1", 0, 0, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(equip1, 0.50, 0.50)
	GUI:setTag(equip1, 0)

	-- Create equipName1
	local equipName1 = GUI:Text_Create(equipNode1, "equipName1", 2, -56, 16, "#ff00ff", [[九霄雷音盾]])
	GUI:Text_enableOutline(equipName1, "#000000", 1)
	GUI:setAnchorPoint(equipName1, 0.50, 0.50)
	GUI:setTouchEnabled(equipName1, false)
	GUI:setTag(equipName1, 0)

	-- Create equipNode2
	local equipNode2 = GUI:Node_Create(midNode, "equipNode2", 606, 369)
	GUI:setTag(equipNode2, 0)

	-- Create equip2
	local equip2 = GUI:ItemShow_Create(equipNode2, "equip2", 0, 0, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(equip2, 0.50, 0.50)
	GUI:setTag(equip2, 0)

	-- Create equipName2
	local equipName2 = GUI:Text_Create(equipNode2, "equipName2", 2, -56, 16, "#ff00ff", [[九霄雷音盾]])
	GUI:Text_enableOutline(equipName2, "#000000", 1)
	GUI:setAnchorPoint(equipName2, 0.50, 0.50)
	GUI:setTouchEnabled(equipName2, false)
	GUI:setTag(equipName2, 0)

	-- Create equipImg
	local equipImg = GUI:Image_Create(midNode, "equipImg", 750, 328, "res/custom/npc/32sd/icon0.png")
	GUI:setAnchorPoint(equipImg, 0.00, 0.00)
	GUI:setTouchEnabled(equipImg, false)
	GUI:setTag(equipImg, 0)

	-- Create RichText1
	local RichText1 = GUI:RichText_Create(midNode, "RichText1", 80, 68, [[<font color='#ffffff' size='18' >说明：</font><font color='#00ff00' size='18' >神盾打造100%成功，神盾为绑定状态，死亡不会掉落！</font>]], 600, 18, "#ff0000", 4)
	GUI:setAnchorPoint(RichText1, 0.00, 0.00)
	GUI:setTag(RichText1, 0)

	-- Create RichText2
	local RichText2 = GUI:RichText_Create(midNode, "RichText2", 78, 54, [[<font color='#ffffff' size='18' >1、</font><font color='#00ff00' size='18' >神盾打造100%成功，神盾为绑定状态，死亡不会掉落</font><br><font color='#ffffff' size='18' >2、</font><font color='#ff0000' size='18' >创世源神盾，佩戴有压制效果，免疫非佩戴创世源初盾的玩家10%的最终伤害！</font>]], 700, 16, "#00ff00", 4)
	GUI:setAnchorPoint(RichText2, 0.00, 0.00)
	GUI:setTag(RichText2, 0)
	GUI:setVisible(RichText2, false)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(midNode, "needItemNode", 434, 240)
	GUI:setTag(needItemNode, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midNode, "upBtn", 440, 162, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn, 0, 0, 0, 0)
	GUI:setContentSize(upBtn, 114, 40)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[打造神盾]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create maxImg
	local maxImg = GUI:Image_Create(midNode, "maxImg", 682, 142, "res/custom/npc/07zslh/ymj.png")
	GUI:setContentSize(maxImg, 107, 84)
	GUI:setIgnoreContentAdaptWithSize(maxImg, false)
	GUI:setAnchorPoint(maxImg, 0.50, 0.50)
	GUI:setTouchEnabled(maxImg, false)
	GUI:setTag(maxImg, 0)
	GUI:setVisible(maxImg, false)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
