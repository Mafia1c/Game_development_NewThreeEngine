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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/05jpss/bg2.png")
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

	-- Create midNode
	local midNode = GUI:Node_Create(FrameLayout, "midNode", 0, 0)
	GUI:setTag(midNode, 0)

	-- Create nowEquipNode
	local nowEquipNode = GUI:Node_Create(midNode, "nowEquipNode", 310, 399)
	GUI:setTag(nowEquipNode, 0)

	-- Create nowEquipName
	local nowEquipName = GUI:Text_Create(nowEquipNode, "nowEquipName", 0, 66, 16, "#00ff00", [[]])
	GUI:Text_enableOutline(nowEquipName, "#000000", 1)
	GUI:setAnchorPoint(nowEquipName, 0.50, 0.50)
	GUI:setTouchEnabled(nowEquipName, false)
	GUI:setTag(nowEquipName, 0)

	-- Create needEquipNode
	local needEquipNode = GUI:Node_Create(midNode, "needEquipNode", 312, 318)
	GUI:setTag(needEquipNode, 0)

	-- Create needEquipBox1
	local needEquipBox1 = GUI:Image_Create(needEquipNode, "needEquipBox1", 0, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(needEquipBox1, 0.00, 0.00)
	GUI:setTouchEnabled(needEquipBox1, false)
	GUI:setTag(needEquipBox1, 0)

	-- Create needEquipBox2
	local needEquipBox2 = GUI:Image_Create(needEquipNode, "needEquipBox2", 0, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(needEquipBox2, 0.00, 0.00)
	GUI:setTouchEnabled(needEquipBox2, false)
	GUI:setTag(needEquipBox2, 0)

	-- Create needEquipBox3
	local needEquipBox3 = GUI:Image_Create(needEquipNode, "needEquipBox3", 0, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(needEquipBox3, 0.00, 0.00)
	GUI:setTouchEnabled(needEquipBox3, false)
	GUI:setTag(needEquipBox3, 0)

	-- Create infoNode
	local infoNode = GUI:Node_Create(midNode, "infoNode", 314, 204)
	GUI:setTag(infoNode, 0)

	-- Create RichText1
	local RichText1 = GUI:RichText_Create(midNode, "RichText1", 76, 38, [[<font color='#ffffff' size='15' >使用</font><font color='#00ff00' size='15' >相同的装备</font><font color='#ffffff' size='15' >可以进行</font><font color='#00ff00' size='15' >极品鉴定</font><font color='#ffffff' size='15' >！</font><br><font color='#ffffff' size='15' >附属装备放入的</font><font color='#00ff00' size='15' >数量</font><font color='#ffffff' size='15' >决定</font><font color='#ffff00' size='15' >极品鉴定的几率</font><font color='#ffffff' size='15' >与词条属性！</font><br><font color='#ffffff' size='15' >鉴定会</font><font color='#ff0000' size='15' >消耗附属装备</font><font color='#ffffff' size='15' >，且主装备随机</font><font color='#ffff00' size='15' >获得对应的极品属性！</font>]], 400, 16, "#ff0000", 4)
	GUI:setAnchorPoint(RichText1, 0.00, 0.00)
	GUI:setTag(RichText1, 0)

	-- Create needItemNode
	local needItemNode = GUI:Node_Create(midNode, "needItemNode", 614, 76)
	GUI:setTag(needItemNode, 0)

	-- Create upBtn
	local upBtn = GUI:Button_Create(midNode, "upBtn", 738, 74, "res/custom/npc/anb1.png")
	GUI:Button_loadTexturePressed(upBtn, "res/custom/npc/anb2.png")
	GUI:Button_setScale9Slice(upBtn, 0, 0, 0, 0)
	GUI:setContentSize(upBtn, 92, 36)
	GUI:setIgnoreContentAdaptWithSize(upBtn, false)
	GUI:Button_setTitleText(upBtn, [[鉴定]])
	GUI:Button_setTitleColor(upBtn, "#E8DCBD")
	GUI:Button_setTitleFontSize(upBtn, 18)
	GUI:Button_titleEnableOutline(upBtn, "#000000", 1)
	GUI:setAnchorPoint(upBtn, 0.50, 0.50)
	GUI:setTouchEnabled(upBtn, true)
	GUI:setTag(upBtn, 0)

	-- Create tipsBtn
	local tipsBtn = GUI:Button_Create(midNode, "tipsBtn", 504, 444, "res/custom/npc/wenhao.png")
	GUI:Button_setTitleText(tipsBtn, [[]])
	GUI:Button_setTitleColor(tipsBtn, "#ffffff")
	GUI:Button_setTitleFontSize(tipsBtn, 16)
	GUI:Button_titleEnableOutline(tipsBtn, "#000000", 1)
	GUI:setAnchorPoint(tipsBtn, 0.00, 0.00)
	GUI:setTouchEnabled(tipsBtn, true)
	GUI:setTag(tipsBtn, 0)

	-- Create rightNode
	local rightNode = GUI:Node_Create(FrameLayout, "rightNode", 0, 0)
	GUI:setTag(rightNode, 0)

	-- Create changeBtn1
	local changeBtn1 = GUI:Button_Create(rightNode, "changeBtn1", 547, 438, "res/custom/npc/05jpss/bag2.png")
	GUI:Button_loadTexturePressed(changeBtn1, "res/custom/npc/05jpss/an11.png")
	GUI:Button_setTitleText(changeBtn1, [[]])
	GUI:Button_setTitleColor(changeBtn1, "#ffffff")
	GUI:Button_setTitleFontSize(changeBtn1, 16)
	GUI:Button_titleEnableOutline(changeBtn1, "#000000", 1)
	GUI:setAnchorPoint(changeBtn1, 0.00, 0.00)
	GUI:setTouchEnabled(changeBtn1, true)
	GUI:setTag(changeBtn1, 0)

	-- Create changeBtn2
	local changeBtn2 = GUI:Button_Create(rightNode, "changeBtn2", 673, 438, "res/custom/npc/05jpss/bag1.png")
	GUI:Button_loadTexturePressed(changeBtn2, "res/custom/npc/05jpss/an1.png")
	GUI:Button_setTitleText(changeBtn2, [[]])
	GUI:Button_setTitleColor(changeBtn2, "#ffffff")
	GUI:Button_setTitleFontSize(changeBtn2, 16)
	GUI:Button_titleEnableOutline(changeBtn2, "#000000", 1)
	GUI:setAnchorPoint(changeBtn2, 0.00, 0.00)
	GUI:setTouchEnabled(changeBtn2, true)
	GUI:setTag(changeBtn2, 0)

	-- Create bigList
	local bigList = GUI:ListView_Create(rightNode, "bigList", 549, 126, 250, 310, 1)
	GUI:ListView_setBounceEnabled(bigList, true)
	GUI:ListView_setItemsMargin(bigList, 2)
	GUI:setAnchorPoint(bigList, 0.00, 0.00)
	GUI:setTouchEnabled(bigList, true)
	GUI:setTag(bigList, 0)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(bigList, "ListView_1", 0, 250, 250, 60, 2)
	GUI:ListView_setGravity(ListView_1, 3)
	GUI:ListView_setItemsMargin(ListView_1, 3)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, true)
	GUI:setTag(ListView_1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(ListView_1, "Image_2", 0, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	local Image_3 = GUI:Image_Create(ListView_1, "Image_3", 63, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(ListView_1, "Image_4", 126, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(ListView_1, "Image_5", 189, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(bigList, "ListView_2", 0, 188, 250, 60, 2)
	GUI:ListView_setGravity(ListView_2, 3)
	GUI:ListView_setItemsMargin(ListView_2, 3)
	GUI:setAnchorPoint(ListView_2, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_2, true)
	GUI:setTag(ListView_2, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_2, "Image_2", 0, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_2, "Image_3", 63, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	Image_4 = GUI:Image_Create(ListView_2, "Image_4", 126, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_2, "Image_5", 189, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_3
	local ListView_3 = GUI:ListView_Create(bigList, "ListView_3", 0, 126, 250, 60, 2)
	GUI:ListView_setGravity(ListView_3, 3)
	GUI:ListView_setItemsMargin(ListView_3, 3)
	GUI:setAnchorPoint(ListView_3, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_3, true)
	GUI:setTag(ListView_3, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_3, "Image_2", 0, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_3, "Image_3", 63, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	Image_4 = GUI:Image_Create(ListView_3, "Image_4", 126, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_3, "Image_5", 189, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_4
	local ListView_4 = GUI:ListView_Create(bigList, "ListView_4", 0, 64, 250, 60, 2)
	GUI:ListView_setGravity(ListView_4, 3)
	GUI:ListView_setItemsMargin(ListView_4, 3)
	GUI:setAnchorPoint(ListView_4, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_4, true)
	GUI:setTag(ListView_4, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_4, "Image_2", 0, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_4, "Image_3", 63, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	Image_4 = GUI:Image_Create(ListView_4, "Image_4", 126, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_4, "Image_5", 189, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create ListView_5
	local ListView_5 = GUI:ListView_Create(bigList, "ListView_5", 0, 2, 250, 60, 2)
	GUI:ListView_setGravity(ListView_5, 3)
	GUI:ListView_setItemsMargin(ListView_5, 3)
	GUI:setAnchorPoint(ListView_5, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_5, true)
	GUI:setTag(ListView_5, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(ListView_5, "Image_2", 0, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create Image_3
	Image_3 = GUI:Image_Create(ListView_5, "Image_3", 63, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_3, 0.00, 0.00)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 0)

	-- Create Image_4
	Image_4 = GUI:Image_Create(ListView_5, "Image_4", 126, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create Image_5
	Image_5 = GUI:Image_Create(ListView_5, "Image_5", 189, 0, "res/custom/npc/k0.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
