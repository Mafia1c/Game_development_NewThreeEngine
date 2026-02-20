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
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/45xq/bg1.png")
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

	-- Create tab_view_list
	local tab_view_list = GUI:ListView_Create(FrameLayout, "tab_view_list", 70, 39, 124, 445, 1)
	GUI:ListView_setGravity(tab_view_list, 2)
	GUI:setAnchorPoint(tab_view_list, 0.00, 0.00)
	GUI:setTouchEnabled(tab_view_list, true)
	GUI:setTag(tab_view_list, 0)

	-- Create one_btn1
	local one_btn1 = GUI:Button_Create(tab_view_list, "one_btn1", 2, 445, "res/custom/npc/ta0.png")
	GUI:setContentSize(one_btn1, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(one_btn1, false)
	GUI:Button_setTitleText(one_btn1, [[宝石镶嵌]])
	GUI:Button_setTitleColor(one_btn1, "#ffffff")
	GUI:Button_setTitleFontSize(one_btn1, 18)
	GUI:Button_titleEnableOutline(one_btn1, "#000000", 1)
	GUI:setAnchorPoint(one_btn1, 0.00, 1.00)
	GUI:setTouchEnabled(one_btn1, true)
	GUI:setTag(one_btn1, 0)

	-- Create select_img1
	local select_img1 = GUI:Image_Create(one_btn1, "select_img1", 4, 11, "res/custom/ad.png")
	GUI:setAnchorPoint(select_img1, 0.00, 0.00)
	GUI:setTouchEnabled(select_img1, false)
	GUI:setTag(select_img1, 0)
	GUI:setVisible(select_img1, false)

	-- Create ListView_1
	local ListView_1 = GUI:ListView_Create(tab_view_list, "ListView_1", 0, 101, 124, 300, 1)
	GUI:setAnchorPoint(ListView_1, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_1, false)
	GUI:setTag(ListView_1, 0)
	GUI:setVisible(ListView_1, false)

	-- Create one_btn2
	local one_btn2 = GUI:Button_Create(tab_view_list, "one_btn2", 2, 101, "res/custom/npc/ta1.png")
	GUI:setContentSize(one_btn2, 120, 44)
	GUI:setIgnoreContentAdaptWithSize(one_btn2, false)
	GUI:Button_setTitleText(one_btn2, [[宝石合成]])
	GUI:Button_setTitleColor(one_btn2, "#c6c6ce")
	GUI:Button_setTitleFontSize(one_btn2, 18)
	GUI:Button_titleEnableOutline(one_btn2, "#000000", 1)
	GUI:setAnchorPoint(one_btn2, 0.00, 1.00)
	GUI:setTouchEnabled(one_btn2, true)
	GUI:setTag(one_btn2, 0)

	-- Create select_img2
	local select_img2 = GUI:Image_Create(one_btn2, "select_img2", 4, 11, "res/custom/ad.png")
	GUI:setAnchorPoint(select_img2, 0.00, 0.00)
	GUI:setTouchEnabled(select_img2, false)
	GUI:setTag(select_img2, 0)
	GUI:setVisible(select_img2, false)

	-- Create ListView_2
	local ListView_2 = GUI:ListView_Create(tab_view_list, "ListView_2", 0, -143, 124, 200, 1)
	GUI:ListView_setGravity(ListView_2, 2)
	GUI:setAnchorPoint(ListView_2, 0.00, 0.00)
	GUI:setTouchEnabled(ListView_2, false)
	GUI:setTag(ListView_2, 0)

	-- Create item_node1
	local item_node1 = GUI:Layout_Create(FrameLayout, "item_node1", 195, 200, 80, 104, false)
	GUI:setAnchorPoint(item_node1, 0.00, 0.00)
	GUI:setTouchEnabled(item_node1, false)
	GUI:setTag(item_node1, 0)

	-- Create Image_2
	local Image_2 = GUI:Image_Create(item_node1, "Image_2", 0, 21, "res/custom/npc/45xq/kuang.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create ItemShow_1
	local ItemShow_1 = GUI:ItemShow_Create(item_node1, "ItemShow_1", 39, 62, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_1, 0.50, 0.50)
	GUI:setTag(ItemShow_1, 0)

	-- Create item_text_1
	local item_text_1 = GUI:Text_Create(item_node1, "item_text_1", 39, 10, 14, "#c6c6ce", [[未镶嵌]])
	GUI:Text_enableOutline(item_text_1, "#000000", 1)
	GUI:setAnchorPoint(item_text_1, 0.50, 0.50)
	GUI:setTouchEnabled(item_text_1, false)
	GUI:setTag(item_text_1, 0)

	-- Create item_node2
	local item_node2 = GUI:Layout_Create(FrameLayout, "item_node2", 277, 200, 80, 104, false)
	GUI:setAnchorPoint(item_node2, 0.00, 0.00)
	GUI:setTouchEnabled(item_node2, false)
	GUI:setTag(item_node2, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(item_node2, "Image_2", 0, 21, "res/custom/npc/45xq/kuang.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create ItemShow_2
	local ItemShow_2 = GUI:ItemShow_Create(item_node2, "ItemShow_2", 39, 62, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_2, 0.50, 0.50)
	GUI:setTag(ItemShow_2, 0)

	-- Create item_text_2
	local item_text_2 = GUI:Text_Create(item_node2, "item_text_2", 39, 10, 14, "#c6c6ce", [[未镶嵌]])
	GUI:Text_enableOutline(item_text_2, "#000000", 1)
	GUI:setAnchorPoint(item_text_2, 0.50, 0.50)
	GUI:setTouchEnabled(item_text_2, false)
	GUI:setTag(item_text_2, 0)

	-- Create item_node3
	local item_node3 = GUI:Layout_Create(FrameLayout, "item_node3", 359, 200, 80, 104, false)
	GUI:setAnchorPoint(item_node3, 0.00, 0.00)
	GUI:setTouchEnabled(item_node3, false)
	GUI:setTag(item_node3, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(item_node3, "Image_2", 0, 21, "res/custom/npc/45xq/kuang.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create ItemShow_3
	local ItemShow_3 = GUI:ItemShow_Create(item_node3, "ItemShow_3", 39, 62, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_3, 0.50, 0.50)
	GUI:setTag(ItemShow_3, 0)

	-- Create item_text_3
	local item_text_3 = GUI:Text_Create(item_node3, "item_text_3", 39, 10, 14, "#c6c6ce", [[未镶嵌]])
	GUI:Text_enableOutline(item_text_3, "#000000", 1)
	GUI:setAnchorPoint(item_text_3, 0.50, 0.50)
	GUI:setTouchEnabled(item_text_3, false)
	GUI:setTag(item_text_3, 0)

	-- Create item_node4
	local item_node4 = GUI:Layout_Create(FrameLayout, "item_node4", 443, 200, 80, 104, false)
	GUI:setAnchorPoint(item_node4, 0.00, 0.00)
	GUI:setTouchEnabled(item_node4, false)
	GUI:setTag(item_node4, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(item_node4, "Image_2", 0, 21, "res/custom/npc/45xq/kuang.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create ItemShow_4
	local ItemShow_4 = GUI:ItemShow_Create(item_node4, "ItemShow_4", 39, 62, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_4, 0.50, 0.50)
	GUI:setTag(ItemShow_4, 0)

	-- Create item_text_4
	local item_text_4 = GUI:Text_Create(item_node4, "item_text_4", 39, 10, 14, "#c6c6ce", [[未镶嵌]])
	GUI:Text_enableOutline(item_text_4, "#000000", 1)
	GUI:setAnchorPoint(item_text_4, 0.50, 0.50)
	GUI:setTouchEnabled(item_text_4, false)
	GUI:setTag(item_text_4, 0)

	-- Create item_node5
	local item_node5 = GUI:Layout_Create(FrameLayout, "item_node5", 525, 200, 80, 104, false)
	GUI:setAnchorPoint(item_node5, 0.00, 0.00)
	GUI:setTouchEnabled(item_node5, false)
	GUI:setTag(item_node5, 0)

	-- Create Image_2
	Image_2 = GUI:Image_Create(item_node5, "Image_2", 0, 21, "res/custom/npc/45xq/kuang.png")
	GUI:setAnchorPoint(Image_2, 0.00, 0.00)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 0)

	-- Create ItemShow_5
	local ItemShow_5 = GUI:ItemShow_Create(item_node5, "ItemShow_5", 39, 62, {index = 1, count = 1, look = true, bgVisible = false, color = 255})
	GUI:setAnchorPoint(ItemShow_5, 0.50, 0.50)
	GUI:setTag(ItemShow_5, 0)

	-- Create item_text_5
	local item_text_5 = GUI:Text_Create(item_node5, "item_text_5", 39, 10, 14, "#c6c6ce", [[未镶嵌]])
	GUI:Text_enableOutline(item_text_5, "#000000", 1)
	GUI:setAnchorPoint(item_text_5, 0.50, 0.50)
	GUI:setTouchEnabled(item_text_5, false)
	GUI:setTag(item_text_5, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(FrameLayout, "Image_1", 384, 310, "res/custom/npc/45xq/ar.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create bag_listview
	local bag_listview = GUI:ListView_Create(FrameLayout, "bag_listview", 607, 40, 192, 404, 1)
	GUI:ListView_setGravity(bag_listview, 2)
	GUI:ListView_setItemsMargin(bag_listview, 5)
	GUI:setAnchorPoint(bag_listview, 0.00, 0.00)
	GUI:setTouchEnabled(bag_listview, true)
	GUI:setTag(bag_listview, 0)

	-- Create target_equip
	local target_equip = GUI:ItemShow_Create(FrameLayout, "target_equip", 398, 392, {index = 1, count = 1, look = true, bgVisible = false, color = 255, noLockTips = true})
	GUI:setAnchorPoint(target_equip, 0.50, 0.50)
	GUI:setTag(target_equip, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 0, 0, 18, "#c6c6ce", [[文本]])
	GUI:Text_enableOutline(Text_1, "#000000", 1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create inlay_node
	local inlay_node = GUI:Node_Create(FrameLayout, "inlay_node", 398, 176)
	GUI:setTag(inlay_node, 0)

	-- Create inlay_btn1
	local inlay_btn1 = GUI:Button_Create(inlay_node, "inlay_btn1", -197, -16, "res/custom/npc/45xq/btn1.png")
	GUI:Button_loadTexturePressed(inlay_btn1, "res/custom/npc/45xq/btn2.png")
	GUI:setContentSize(inlay_btn1, 66, 38)
	GUI:setIgnoreContentAdaptWithSize(inlay_btn1, false)
	GUI:Button_setTitleText(inlay_btn1, [[]])
	GUI:Button_setTitleColor(inlay_btn1, "#ffffff")
	GUI:Button_setTitleFontSize(inlay_btn1, 16)
	GUI:Button_titleDisableOutLine(inlay_btn1)
	GUI:setAnchorPoint(inlay_btn1, 0.00, 0.00)
	GUI:setTouchEnabled(inlay_btn1, true)
	GUI:setTag(inlay_btn1, 0)

	-- Create inlay_btn2
	local inlay_btn2 = GUI:Button_Create(inlay_node, "inlay_btn2", -114, -16, "res/custom/npc/45xq/btn1.png")
	GUI:Button_loadTexturePressed(inlay_btn2, "res/custom/npc/45xq/btn2.png")
	GUI:setContentSize(inlay_btn2, 66, 38)
	GUI:setIgnoreContentAdaptWithSize(inlay_btn2, false)
	GUI:Button_setTitleText(inlay_btn2, [[]])
	GUI:Button_setTitleColor(inlay_btn2, "#ffffff")
	GUI:Button_setTitleFontSize(inlay_btn2, 16)
	GUI:Button_titleDisableOutLine(inlay_btn2)
	GUI:setAnchorPoint(inlay_btn2, 0.00, 0.00)
	GUI:setTouchEnabled(inlay_btn2, true)
	GUI:setTag(inlay_btn2, 0)

	-- Create inlay_btn3
	local inlay_btn3 = GUI:Button_Create(inlay_node, "inlay_btn3", -31, -16, "res/custom/npc/45xq/btn1.png")
	GUI:Button_loadTexturePressed(inlay_btn3, "res/custom/npc/45xq/btn2.png")
	GUI:setContentSize(inlay_btn3, 66, 38)
	GUI:setIgnoreContentAdaptWithSize(inlay_btn3, false)
	GUI:Button_setTitleText(inlay_btn3, [[]])
	GUI:Button_setTitleColor(inlay_btn3, "#ffffff")
	GUI:Button_setTitleFontSize(inlay_btn3, 16)
	GUI:Button_titleDisableOutLine(inlay_btn3)
	GUI:setAnchorPoint(inlay_btn3, 0.00, 0.00)
	GUI:setTouchEnabled(inlay_btn3, true)
	GUI:setTag(inlay_btn3, 0)

	-- Create inlay_btn4
	local inlay_btn4 = GUI:Button_Create(inlay_node, "inlay_btn4", 51, -16, "res/custom/npc/45xq/btn1.png")
	GUI:Button_loadTexturePressed(inlay_btn4, "res/custom/npc/45xq/btn2.png")
	GUI:setContentSize(inlay_btn4, 66, 38)
	GUI:setIgnoreContentAdaptWithSize(inlay_btn4, false)
	GUI:Button_setTitleText(inlay_btn4, [[]])
	GUI:Button_setTitleColor(inlay_btn4, "#ffffff")
	GUI:Button_setTitleFontSize(inlay_btn4, 16)
	GUI:Button_titleDisableOutLine(inlay_btn4)
	GUI:setAnchorPoint(inlay_btn4, 0.00, 0.00)
	GUI:setTouchEnabled(inlay_btn4, true)
	GUI:setTag(inlay_btn4, 0)

	-- Create inlay_btn5
	local inlay_btn5 = GUI:Button_Create(inlay_node, "inlay_btn5", 133, -16, "res/custom/npc/45xq/btn1.png")
	GUI:Button_loadTexturePressed(inlay_btn5, "res/custom/npc/45xq/btn2.png")
	GUI:setContentSize(inlay_btn5, 66, 38)
	GUI:setIgnoreContentAdaptWithSize(inlay_btn5, false)
	GUI:Button_setTitleText(inlay_btn5, [[]])
	GUI:Button_setTitleColor(inlay_btn5, "#ffffff")
	GUI:Button_setTitleFontSize(inlay_btn5, 16)
	GUI:Button_titleDisableOutLine(inlay_btn5)
	GUI:setAnchorPoint(inlay_btn5, 0.00, 0.00)
	GUI:setTouchEnabled(inlay_btn5, true)
	GUI:setTag(inlay_btn5, 0)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(inlay_node, "RichText_1", -199, -118, [[<font color='#ffffff' size='16' >1、每次镶嵌需要 </font><font color='#ffff00' size='16' >1000元宝</font><br><font color='#ffffff' size='16' >2、只有终极特殊装备才能镶嵌宝石，</font><font color='#ff0000' size='16' >盾牌最高镶嵌Lv9</font><br><font color='#ff0000' size='16' >斗笠、勋章、血石、护符、军鼓最高镶嵌Lv15</font>]], 400, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create equip_name
	local equip_name = GUI:Text_Create(inlay_node, "equip_name", -1, 281, 18, "#ff00ff", [[终极斗笠]])
	GUI:Text_enableOutline(equip_name, "#000000", 1)
	GUI:setAnchorPoint(equip_name, 0.50, 0.50)
	GUI:setTouchEnabled(equip_name, false)
	GUI:setTag(equip_name, 0)

	-- Create compound_node
	local compound_node = GUI:Node_Create(FrameLayout, "compound_node", 398, 176)
	GUI:setTag(compound_node, 0)
	GUI:setVisible(compound_node, false)

	-- Create compound_btn
	local compound_btn = GUI:Button_Create(compound_node, "compound_btn", -50, -28, "res/custom/btn11.png")
	GUI:Button_loadTexturePressed(compound_btn, "res/custom/btn12.png")
	GUI:setContentSize(compound_btn, 104, 40)
	GUI:setIgnoreContentAdaptWithSize(compound_btn, false)
	GUI:Button_setTitleText(compound_btn, [[合成宝石]])
	GUI:Button_setTitleColor(compound_btn, "#ffff00")
	GUI:Button_setTitleFontSize(compound_btn, 16)
	GUI:Button_titleEnableOutline(compound_btn, "#000000", 1)
	GUI:setAnchorPoint(compound_btn, 0.00, 0.00)
	GUI:setTouchEnabled(compound_btn, true)
	GUI:setTag(compound_btn, 0)

	-- Create need_money_text
	local need_money_text = GUI:Text_Create(compound_node, "need_money_text", 22, -45, 16, "#ff0000", [[50000金符]])
	GUI:Text_enableOutline(need_money_text, "#000000", 1)
	GUI:setAnchorPoint(need_money_text, 0.50, 0.50)
	GUI:setTouchEnabled(need_money_text, false)
	GUI:setTag(need_money_text, 0)

	-- Create Text_3
	local Text_3 = GUI:Text_Create(need_money_text, "Text_3", -44, 0, 16, "#c6c6ce", [[消耗：]])
	GUI:Text_enableOutline(Text_3, "#000000", 1)
	GUI:setAnchorPoint(Text_3, 0.00, 0.00)
	GUI:setTouchEnabled(Text_3, false)
	GUI:setTag(Text_3, 0)

	-- Create compound_lock
	local compound_lock = GUI:Image_Create(compound_node, "compound_lock", -12, 201, "res/custom/npc/lock.png")
	GUI:setAnchorPoint(compound_lock, 0.00, 0.00)
	GUI:setTouchEnabled(compound_lock, false)
	GUI:setTag(compound_lock, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
