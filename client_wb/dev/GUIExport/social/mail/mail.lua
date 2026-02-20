local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create mailLayer
	local mailLayer = GUI:Node_Create(parent, "mailLayer", 0, 0)
	GUI:setChineseName(mailLayer, "邮件场景")
	GUI:setTag(mailLayer, -1)

	-- Create bg
	local bg = GUI:Layout_Create(mailLayer, "bg", 0, 0, 732, 445, true)
	GUI:setChineseName(bg, "邮件组合")
	GUI:setAnchorPoint(bg, 0.00, 0.00)
	GUI:setTouchEnabled(bg, true)
	GUI:setTag(bg, 2)
	TAGOBJ["2"] = bg

	-- Create Image_7
	local Image_7 = GUI:Image_Create(bg, "Image_7", 366, 222, "res/private/mail/1900020061.png")
	GUI:setChineseName(Image_7, "邮件_装饰图")
	GUI:setAnchorPoint(Image_7, 0.50, 0.50)
	GUI:setTouchEnabled(Image_7, false)
	GUI:setTag(Image_7, 98)
	TAGOBJ["98"] = Image_7

	-- Create list
	local list = GUI:ListView_Create(bg, "list", 12, 60, 220, 376, 1)
	GUI:setChineseName(list, "邮件_列表")
	GUI:setAnchorPoint(list, 0.00, 0.00)
	GUI:setTouchEnabled(list, true)
	GUI:setTag(list, 37)
	TAGOBJ["37"] = list

	-- Create btn_takeOut_all
	local btn_takeOut_all = GUI:Button_Create(bg, "btn_takeOut_all", 67, 32, "res/public/1900000612.png")
	GUI:setContentSize(btn_takeOut_all, 104, 33)
	GUI:setIgnoreContentAdaptWithSize(btn_takeOut_all, false)
	GUI:Button_setTitleText(btn_takeOut_all, [[全部提取]])
	GUI:Button_setTitleColor(btn_takeOut_all, "#f8e6c6")
	GUI:Button_setTitleFontSize(btn_takeOut_all, 16)
	GUI:Button_titleEnableOutline(btn_takeOut_all, "#111111", 2)
	GUI:setChineseName(btn_takeOut_all, "邮件_全部提取_按钮")
	GUI:setAnchorPoint(btn_takeOut_all, 0.50, 0.50)
	GUI:setTouchEnabled(btn_takeOut_all, true)
	GUI:setTag(btn_takeOut_all, 4)
	TAGOBJ["4"] = btn_takeOut_all

	-- Create btn_delete_read
	local btn_delete_read = GUI:Button_Create(bg, "btn_delete_read", 177, 32, "res/public/1900000612.png")
	GUI:setContentSize(btn_delete_read, 104, 33)
	GUI:setIgnoreContentAdaptWithSize(btn_delete_read, false)
	GUI:Button_setTitleText(btn_delete_read, [[删除已读]])
	GUI:Button_setTitleColor(btn_delete_read, "#f8e6c6")
	GUI:Button_setTitleFontSize(btn_delete_read, 16)
	GUI:Button_titleEnableOutline(btn_delete_read, "#111111", 2)
	GUI:setChineseName(btn_delete_read, "邮件_删除已读_按钮")
	GUI:setAnchorPoint(btn_delete_read, 0.50, 0.50)
	GUI:setTouchEnabled(btn_delete_read, true)
	GUI:setTag(btn_delete_read, 5)
	TAGOBJ["5"] = btn_delete_read

	-- Create panel_main
	local panel_main = GUI:Layout_Create(bg, "panel_main", 240, 0, 490, 450, true)
	GUI:setChineseName(panel_main, "邮件详情")
	GUI:setAnchorPoint(panel_main, 0.00, 0.00)
	GUI:setTouchEnabled(panel_main, false)
	GUI:setTag(panel_main, 6)
	TAGOBJ["6"] = panel_main

	-- Create panel_title
	local panel_title = GUI:Layout_Create(panel_main, "panel_title", 15, 400, 460, 30, false)
	GUI:Layout_setBackGroundImage(panel_title, "res/private/mail/1900020064.png")
	GUI:Layout_setBackGroundImageScale9Slice(panel_title, 0, 35, 11, 71)
	GUI:setChineseName(panel_title, "邮件主题组合")
	GUI:setAnchorPoint(panel_title, 0.00, 0.00)
	GUI:setTouchEnabled(panel_title, false)
	GUI:setTag(panel_title, 7)
	TAGOBJ["7"] = panel_title

	-- Create mail_title
	local mail_title = GUI:Text_Create(panel_title, "mail_title", 10, 15, 18, "#a58e67", [[主题]])
	GUI:Text_enableOutline(mail_title, "#000000", 1)
	GUI:setChineseName(mail_title, "邮件_主题_文本")
	GUI:setAnchorPoint(mail_title, 0.00, 0.50)
	GUI:setTouchEnabled(mail_title, false)
	GUI:setTag(mail_title, 8)
	TAGOBJ["8"] = mail_title

	-- Create label_title
	local label_title = GUI:Text_Create(panel_title, "label_title", 60, 15, 16, "#f8e6c6", [[]])
	GUI:Text_enableOutline(label_title, "#111111", 2)
	GUI:setChineseName(label_title, "邮件_主题内容_文本")
	GUI:setAnchorPoint(label_title, 0.00, 0.50)
	GUI:setTouchEnabled(label_title, false)
	GUI:setTag(label_title, 9)
	TAGOBJ["9"] = label_title

	-- Create panel_sender
	local panel_sender = GUI:Layout_Create(panel_main, "panel_sender", 15, 364, 460, 30, false)
	GUI:Layout_setBackGroundImage(panel_sender, "res/private/mail/1900020064.png")
	GUI:Layout_setBackGroundImageScale9Slice(panel_sender, 0, 35, 11, 71)
	GUI:setChineseName(panel_sender, "邮件发送者组合")
	GUI:setAnchorPoint(panel_sender, 0.00, 0.00)
	GUI:setTouchEnabled(panel_sender, false)
	GUI:setTag(panel_sender, 10)
	TAGOBJ["10"] = panel_sender

	-- Create mail_sender
	local mail_sender = GUI:Text_Create(panel_sender, "mail_sender", 10, 15, 18, "#a58e67", [[发送者：]])
	GUI:Text_enableOutline(mail_sender, "#000000", 1)
	GUI:setChineseName(mail_sender, "邮件_发送者_文本")
	GUI:setAnchorPoint(mail_sender, 0.00, 0.50)
	GUI:setTouchEnabled(mail_sender, false)
	GUI:setTag(mail_sender, 11)
	TAGOBJ["11"] = mail_sender

	-- Create label_sender
	local label_sender = GUI:Text_Create(panel_sender, "label_sender", 80, 15, 16, "#f8e6c6", [[]])
	GUI:Text_enableOutline(label_sender, "#111111", 2)
	GUI:setChineseName(label_sender, "邮件_发送者内容_文本")
	GUI:setAnchorPoint(label_sender, 0.00, 0.50)
	GUI:setTouchEnabled(label_sender, false)
	GUI:setTag(label_sender, 12)
	TAGOBJ["12"] = label_sender

	-- Create panel_time
	local panel_time = GUI:Layout_Create(panel_main, "panel_time", 15, 327, 460, 30, false)
	GUI:Layout_setBackGroundImage(panel_time, "res/private/mail/1900020064.png")
	GUI:Layout_setBackGroundImageScale9Slice(panel_time, 0, 35, 11, 71)
	GUI:setChineseName(panel_time, "邮件时间组合")
	GUI:setAnchorPoint(panel_time, 0.00, 0.00)
	GUI:setTouchEnabled(panel_time, false)
	GUI:setTag(panel_time, 13)
	TAGOBJ["13"] = panel_time

	-- Create time
	local time = GUI:Text_Create(panel_time, "time", 10, 15, 18, "#a58e67", [[时间：]])
	GUI:Text_enableOutline(time, "#000000", 1)
	GUI:setChineseName(time, "邮件_时间_文本")
	GUI:setAnchorPoint(time, 0.00, 0.50)
	GUI:setTouchEnabled(time, false)
	GUI:setTag(time, 14)
	TAGOBJ["14"] = time

	-- Create label_time
	local label_time = GUI:Text_Create(panel_time, "label_time", 60, 15, 16, "#f8e6c6", [[]])
	GUI:Text_enableOutline(label_time, "#111111", 2)
	GUI:setChineseName(label_time, "邮件_时间内容_文本")
	GUI:setAnchorPoint(label_time, 0.00, 0.50)
	GUI:setTouchEnabled(label_time, false)
	GUI:setTag(label_time, 15)
	TAGOBJ["15"] = label_time

	-- Create panel_mailContent
	local panel_mailContent = GUI:Layout_Create(panel_main, "panel_mailContent", 17, 138, 455, 185, false)
	GUI:Layout_setBackGroundImage(panel_mailContent, "res/private/mail/1900020064.png")
	GUI:Layout_setBackGroundImageScale9Slice(panel_mailContent, 0, 35, 0, 35)
	GUI:setChineseName(panel_mailContent, "邮件_详细内容_文本")
	GUI:setAnchorPoint(panel_mailContent, 0.00, 0.00)
	GUI:setTouchEnabled(panel_mailContent, false)
	GUI:setTag(panel_mailContent, 16)
	TAGOBJ["16"] = panel_mailContent

	-- Create list_mailContent
	local list_mailContent = GUI:ListView_Create(panel_main, "list_mailContent", 22, 140, 450, 180, 1)
	GUI:setChineseName(list_mailContent, "邮件_详细内容_列表")
	GUI:setAnchorPoint(list_mailContent, 0.00, 0.00)
	GUI:setTouchEnabled(list_mailContent, true)
	GUI:setTag(list_mailContent, 36)
	TAGOBJ["36"] = list_mailContent

	-- Create Text_item
	local Text_item = GUI:Text_Create(panel_main, "Text_item", 39, 93, 18, "#ffffff", [[附
件]])
	GUI:Text_enableOutline(Text_item, "#000000", 1)
	GUI:setChineseName(Text_item, "邮件_附件_文本")
	GUI:setAnchorPoint(Text_item, 0.50, 0.50)
	GUI:setTouchEnabled(Text_item, false)
	GUI:setTag(Text_item, 42)
	TAGOBJ["42"] = Text_item

	-- Create list_items
	local list_items = GUI:ListView_Create(panel_main, "list_items", 54, 59, 420, 70, 2)
	GUI:ListView_setGravity(list_items, 5)
	GUI:ListView_setItemsMargin(list_items, 5)
	GUI:setChineseName(list_items, "邮件_附件物品_列表")
	GUI:setAnchorPoint(list_items, 0.00, 0.00)
	GUI:setTouchEnabled(list_items, true)
	GUI:setTag(list_items, 48)
	TAGOBJ["48"] = list_items

	-- Create rewardFlag_icon
	local rewardFlag_icon = GUI:Image_Create(panel_main, "rewardFlag_icon", 264, 92, "res/public/word_bqzy_01.png")
	GUI:setChineseName(rewardFlag_icon, "邮件_领取状态_图标")
	GUI:setAnchorPoint(rewardFlag_icon, 0.50, 0.50)
	GUI:setTouchEnabled(rewardFlag_icon, false)
	GUI:setTag(rewardFlag_icon, 48)
	GUI:setVisible(rewardFlag_icon, false)
	TAGOBJ["48"] = rewardFlag_icon

	-- Create btn_takeOut
	local btn_takeOut = GUI:Button_Create(panel_main, "btn_takeOut", 420, 31, "res/public/1900000611.png")
	GUI:setContentSize(btn_takeOut, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(btn_takeOut, false)
	GUI:Button_setTitleText(btn_takeOut, [[提  取]])
	GUI:Button_setTitleColor(btn_takeOut, "#f8e6c6")
	GUI:Button_setTitleFontSize(btn_takeOut, 16)
	GUI:Button_titleEnableOutline(btn_takeOut, "#111111", 2)
	GUI:setChineseName(btn_takeOut, "邮件_提取_按钮")
	GUI:setAnchorPoint(btn_takeOut, 0.50, 0.50)
	GUI:setTouchEnabled(btn_takeOut, true)
	GUI:setTag(btn_takeOut, 19)
	TAGOBJ["19"] = btn_takeOut

	-- Create TouchSize
	local TouchSize = GUI:Layout_Create(btn_takeOut, "TouchSize", 38, 16, 106, 46, false)
	GUI:Layout_setBackGroundColorType(TouchSize, 1)
	GUI:Layout_setBackGroundColor(TouchSize, "#96c8ff")
	GUI:Layout_setBackGroundColorOpacity(TouchSize, 102)
	GUI:setChineseName(TouchSize, "邮件_提取_图标")
	GUI:setAnchorPoint(TouchSize, 0.50, 0.50)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, 47)
	GUI:setVisible(TouchSize, false)
	TAGOBJ["47"] = TouchSize

	-- Create btn_delete
	local btn_delete = GUI:Button_Create(panel_main, "btn_delete", 420, 31, "res/public/1900000611.png")
	GUI:setContentSize(btn_delete, 76, 33)
	GUI:setIgnoreContentAdaptWithSize(btn_delete, false)
	GUI:Button_setTitleText(btn_delete, [[删  除]])
	GUI:Button_setTitleColor(btn_delete, "#f8e6c6")
	GUI:Button_setTitleFontSize(btn_delete, 16)
	GUI:Button_titleEnableOutline(btn_delete, "#111111", 2)
	GUI:setChineseName(btn_delete, "邮件_删除_按钮")
	GUI:setAnchorPoint(btn_delete, 0.50, 0.50)
	GUI:setTouchEnabled(btn_delete, true)
	GUI:setTag(btn_delete, 20)
	TAGOBJ["20"] = btn_delete

	-- Create TouchSize
	TouchSize = GUI:Layout_Create(btn_delete, "TouchSize", 38, 16, 106, 46, false)
	GUI:Layout_setBackGroundColorType(TouchSize, 1)
	GUI:Layout_setBackGroundColor(TouchSize, "#96c8ff")
	GUI:Layout_setBackGroundColorOpacity(TouchSize, 102)
	GUI:setChineseName(TouchSize, "邮件_删除_图标")
	GUI:setAnchorPoint(TouchSize, 0.50, 0.50)
	GUI:setTouchEnabled(TouchSize, true)
	GUI:setTag(TouchSize, 47)
	GUI:setVisible(TouchSize, false)
	TAGOBJ["47"] = TouchSize

	-- Create ImageView
	local ImageView = GUI:Image_Create(panel_main, "ImageView", 7, 6, "res/private/mail/mailtipsbg.png")
	GUI:setContentSize(ImageView, 300, 48)
	GUI:setIgnoreContentAdaptWithSize(ImageView, false)
	GUI:setAnchorPoint(ImageView, 0.00, 0.00)
	GUI:setTouchEnabled(ImageView, false)
	GUI:setTag(ImageView, 0)

	-- Create Text
	local Text = GUI:Text_Create(panel_main, "Text", 25, 20, 16, "#ff0000", [[邮件最多存储200封，请及时提取！]])
	GUI:Text_enableOutline(Text, "#000000", 1)
	GUI:setAnchorPoint(Text, 0.00, 0.00)
	GUI:setTouchEnabled(Text, false)
	GUI:setTag(Text, -1)

	ui.update(__data__)
	return mailLayer
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
