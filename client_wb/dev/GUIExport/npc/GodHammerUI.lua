local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create CloseLayout
	local CloseLayout = GUI:Layout_Create(parent, "CloseLayout", 0, 0, 1136, 640, false)
	GUI:Layout_setBackGroundColorType(CloseLayout, 1)
	GUI:Layout_setBackGroundColor(CloseLayout, "#f8e6c6")
	GUI:Layout_setBackGroundColorOpacity(CloseLayout, 0)
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", _V("SCREEN_WIDTH") * 0.5, _V("SCREEN_HEIGHT") * 0.5, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/48bao/bg1.png")
	GUI:Image_setScale9Slice(FrameBG, 84, 84, 188, 188)
	GUI:setContentSize(FrameBG, 846, 566)
	GUI:setIgnoreContentAdaptWithSize(FrameBG, false)
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 784, 493, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/close2.png")
	GUI:setContentSize(closeBtn, 36, 36)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleDisableOutLine(closeBtn)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create pageList_1
	local pageList_1 = GUI:ListView_Create(FrameLayout, "pageList_1", 72, 110, 120, 374, 1)
	GUI:setAnchorPoint(pageList_1, 0.00, 0.00)
	GUI:setTouchEnabled(pageList_1, true)
	GUI:setTag(pageList_1, 0)

	-- Create baolu_node
	local baolu_node = GUI:Node_Create(FrameLayout, "baolu_node", 434, 294)
	GUI:setTag(baolu_node, 0)
	GUI:setVisible(baolu_node, false)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(baolu_node, "Image_2", -80, 88, "res/custom/npc/48bao/lock.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create compound_target_item
	local compound_target_item = GUI:ItemShow_Create(baolu_node, "compound_target_item", -68, 107, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(compound_target_item, 0.50, 0.50)
	GUI:setTag(compound_target_item, 0)

	-- Create compound_need_item2
	local compound_need_item2 = GUI:ItemShow_Create(baolu_node, "compound_need_item2", -74, -147, {index = 0, count = 1, look = true, bgVisible = true, color = 255})
	GUI:setAnchorPoint(compound_need_item2, 0.50, 0.50)
	GUI:setTag(compound_need_item2, 0)

	-- Create forge_btn
	local forge_btn = GUI:Button_Create(baolu_node, "forge_btn", 184, -240, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(forge_btn, "res/custom/npc/an2.png")
	GUI:setContentSize(forge_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(forge_btn, false)
	GUI:Button_setTitleText(forge_btn, [[锻造]])
	GUI:Button_setTitleColor(forge_btn, "#ff00ff")
	GUI:Button_setTitleFontSize(forge_btn, 18)
	GUI:Button_titleEnableOutline(forge_btn, "#000000", 1)
	GUI:setAnchorPoint(forge_btn, 0.00, 0.00)
	GUI:setTouchEnabled(forge_btn, true)
	GUI:setTag(forge_btn, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(baolu_node, "RichText_1", -357, -241, [[<font color='#ffffff' size='16' >任意3个同样的首饰，可随机锻造一件高级装备，</font><font color='#00ff00' size='16' >100%</font><font color='#ffffff' size='16' >成功！</font><br><font color='#ffffff' size='16' >点击右边</font><font color='#ff00ff' size='16' >“首饰仓库”</font><font color='#ffffff' size='16' >即可添加装备至锻造框！</font>]], 450, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create compound_bag_listview
	local compound_bag_listview = GUI:ListView_Create(baolu_node, "compound_bag_listview", 107, -179, 257, 332, 1)
	GUI:ListView_setBounceEnabled(compound_bag_listview, true)
	GUI:ListView_setGravity(compound_bag_listview, 2)
	GUI:ListView_setItemsMargin(compound_bag_listview, 5)
	GUI:setAnchorPoint(compound_bag_listview, 0.00, 0.00)
	GUI:setTouchEnabled(compound_bag_listview, true)
	GUI:setTag(compound_bag_listview, 0)

	-- Create tip_btn
	local tip_btn = GUI:Button_Create(baolu_node, "tip_btn", 62, 154, "res/custom/npc/wenhao.png")
	GUI:setContentSize(tip_btn, 32, 32)
	GUI:setIgnoreContentAdaptWithSize(tip_btn, false)
	GUI:Button_setTitleText(tip_btn, [[]])
	GUI:Button_setTitleColor(tip_btn, "#ffffff")
	GUI:Button_setTitleFontSize(tip_btn, 16)
	GUI:Button_titleDisableOutLine(tip_btn)
	GUI:setAnchorPoint(tip_btn, 0.00, 0.00)
	GUI:setTouchEnabled(tip_btn, true)
	GUI:setTag(tip_btn, 0)

	-- Create compound_need_node1
	local compound_need_node1 = GUI:Node_Create(baolu_node, "compound_need_node1", -176, -11)
	GUI:setTag(compound_need_node1, 0)

	-- Create compound_need_node2
	local compound_need_node2 = GUI:Node_Create(baolu_node, "compound_need_node2", -69, -11)
	GUI:setTag(compound_need_node2, 0)

	-- Create compound_need_node3
	local compound_need_node3 = GUI:Node_Create(baolu_node, "compound_need_node3", 38, -12)
	GUI:setTag(compound_need_node3, 0)

	-- Create dazao_node
	local dazao_node = GUI:Node_Create(FrameLayout, "dazao_node", 434, 294)
	GUI:setTag(dazao_node, 0)
	GUI:setVisible(dazao_node, false)

	-- Create pageList_2
	local pageList_2 = GUI:ListView_Create(dazao_node, "pageList_2", -239, -259, 125, 450, 1)
	GUI:ListView_setGravity(pageList_2, 2)
	GUI:setAnchorPoint(pageList_2, 0.00, 0.00)
	GUI:setTouchEnabled(pageList_2, true)
	GUI:setTag(pageList_2, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(dazao_node, "Image_1", 113, -20, "res/custom/npc/47jx/ar.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Image_4
	local Image_4 = GUI:Image_Create(dazao_node, "Image_4", 28, -112, "res/custom/npc/47jx/itm.png")
	GUI:setAnchorPoint(Image_4, 0.00, 0.00)
	GUI:setTouchEnabled(Image_4, false)
	GUI:setTag(Image_4, 0)

	-- Create forge_item2
	local forge_item2 = GUI:ItemShow_Create(Image_4, "forge_item2", 41, 41, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(forge_item2, 0.50, 0.50)
	GUI:setTag(forge_item2, 0)

	-- Create Image_5
	local Image_5 = GUI:Image_Create(dazao_node, "Image_5", 150, -112, "res/custom/npc/47jx/itm.png")
	GUI:setAnchorPoint(Image_5, 0.00, 0.00)
	GUI:setTouchEnabled(Image_5, false)
	GUI:setTag(Image_5, 0)

	-- Create forge_item3
	local forge_item3 = GUI:ItemShow_Create(Image_5, "forge_item3", 41, 41, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(forge_item3, 0.50, 0.50)
	GUI:setTag(forge_item3, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(dazao_node, "Text_2", 183, -155, 18, "#00ff00", [[100%]])
	GUI:Text_enableOutline(Text_2, "#000000", 1)
	GUI:setAnchorPoint(Text_2, 0.50, 0.50)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(Text_2, "Text_1", -102, -1, 18, "#c6c6ce", [[锻造成功率：]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create dazao_btn
	local dazao_btn = GUI:Button_Create(dazao_node, "dazao_btn", 81, -230, "res/custom/npc/an.png")
	GUI:Button_loadTexturePressed(dazao_btn, "res/custom/npc/an2.png")
	GUI:setContentSize(dazao_btn, 104, 38)
	GUI:setIgnoreContentAdaptWithSize(dazao_btn, false)
	GUI:Button_setTitleText(dazao_btn, [[锻造]])
	GUI:Button_setTitleColor(dazao_btn, "#ffffff")
	GUI:Button_setTitleFontSize(dazao_btn, 18)
	GUI:Button_titleEnableOutline(dazao_btn, "#000000", 1)
	GUI:setAnchorPoint(dazao_btn, 0.00, 0.00)
	GUI:setTouchEnabled(dazao_btn, true)
	GUI:setTag(dazao_btn, 0)

	-- Create forge_name
	local forge_name = GUI:Text_Create(dazao_node, "forge_name", 126, 156, 18, "#ff00ff", [[圣山头盔]])
	GUI:Text_enableOutline(forge_name, "#000000", 1)
	GUI:setAnchorPoint(forge_name, 0.50, 0.50)
	GUI:setTouchEnabled(forge_name, false)
	GUI:setTag(forge_name, 0)

	-- Create forge_target_item
	local forge_target_item = GUI:ItemShow_Create(dazao_node, "forge_target_item", 128, 68, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(forge_target_item, 0.50, 0.50)
	GUI:setTag(forge_target_item, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
