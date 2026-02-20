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
	GUI:setChineseName(CloseLayout, "拍卖行主窗体_范围点击关闭")
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 568, 384, 645, 460, false)
	GUI:setChineseName(FrameLayout, "拍卖行主窗体组合")
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/public_win32/1900000610.png")
	GUI:setChineseName(FrameBG, "拍卖行主窗体_背景图")
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, false)
	GUI:setTag(FrameBG, -1)

	-- Create DressIMG
	local DressIMG = GUI:Image_Create(FrameLayout, "DressIMG", 17, 443, "res/public_win32/1900000610_1.png")
	GUI:setChineseName(DressIMG, "拍卖行主窗体_装饰图")
	GUI:setAnchorPoint(DressIMG, 0.50, 0.50)
	GUI:setTouchEnabled(DressIMG, false)
	GUI:setTag(DressIMG, -1)

	-- Create TitleText
	local TitleText = GUI:Text_Create(FrameLayout, "TitleText", 23, 437, 14, "#d8c8ae", [[拍卖行]])
	GUI:Text_enableOutline(TitleText, "#000000", 2)
	GUI:setChineseName(TitleText, "拍卖行主窗体_标题")
	GUI:setAnchorPoint(TitleText, 0.00, 0.50)
	GUI:setTouchEnabled(TitleText, false)
	GUI:setTag(TitleText, -1)

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(FrameLayout, "CloseButton", 605, 437, "res/public/01.png")
	GUI:Button_loadTexturePressed(CloseButton, "res/public/02.png")
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 10)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setChineseName(CloseButton, "拍卖行主窗体_关闭_按钮")
	GUI:setAnchorPoint(CloseButton, 0.00, 0.50)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, -1)

	-- Create ListView_group
	local ListView_group = GUI:ListView_Create(FrameLayout, "ListView_group", 22, 417, 410, 30, 2)
	GUI:ListView_setGravity(ListView_group, 3)
	GUI:setChineseName(ListView_group, "拍卖行主窗体_拍卖分组")
	GUI:setAnchorPoint(ListView_group, 0.00, 1.00)
	GUI:setTouchEnabled(ListView_group, false)
	GUI:setTag(ListView_group, 59)
	TAGOBJ["59"] = ListView_group

	-- Create Panel_search
	local Panel_search = GUI:Layout_Create(FrameLayout, "Panel_search", 624, 385, 200, 35, false)
	GUI:setChineseName(Panel_search, "拍卖行主窗体_搜索组合")
	GUI:setAnchorPoint(Panel_search, 1.00, 0.00)
	GUI:setTouchEnabled(Panel_search, true)
	GUI:setTag(Panel_search, 28)
	TAGOBJ["28"] = Panel_search

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Panel_search, "Image_1", 20, 16, "res/public/btn_szjm_02.png")
	GUI:setChineseName(Image_1, "拍卖行主窗体_查询_装饰图")
	GUI:setAnchorPoint(Image_1, 0.50, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 29)
	TAGOBJ["29"] = Image_1

	-- Create ImageView
	local ImageView = GUI:Image_Create(Panel_search, "ImageView", 32, 17, "res/public/1900000668.png")
	GUI:Image_setScale9Slice(ImageView, 52, 52, 12, 8)
	GUI:setContentSize(ImageView, 104, 28)
	GUI:setIgnoreContentAdaptWithSize(ImageView, false)
	GUI:setChineseName(ImageView, "拍卖行主窗体_搜索_背景框")
	GUI:setAnchorPoint(ImageView, 0.00, 0.50)
	GUI:setTouchEnabled(ImageView, false)
	GUI:setTag(ImageView, -1)

	-- Create SearchInput
	local SearchInput = GUI:TextInput_Create(Panel_search, "SearchInput", 35, 17, 100, 20, 12)
	GUI:TextInput_setString(SearchInput, "")
	GUI:TextInput_setPlaceHolder(SearchInput, "请输入物品名")
	GUI:TextInput_setFontColor(SearchInput, "#ffffff")
	GUI:TextInput_setPlaceholderFontColor(SearchInput, "#a6a6a6")
	GUI:TextInput_setMaxLength(SearchInput, 10)
	GUI:setChineseName(SearchInput, "拍卖行主窗体_搜索内容")
	GUI:setAnchorPoint(SearchInput, 0.00, 0.50)
	GUI:setTouchEnabled(SearchInput, true)
	GUI:setTag(SearchInput, 30)
	TAGOBJ["30"] = SearchInput

	-- Create Button_confirm
	local Button_confirm = GUI:Button_Create(Panel_search, "Button_confirm", 170, 17, "res/public/btn_fanye_03.png")
	GUI:Button_loadTexturePressed(Button_confirm, "res/public/btn_fanye_03_1.png")
	GUI:Button_loadTextureDisabled(Button_confirm, "Default/Button_Disable.png")
	GUI:Button_setScale9Slice(Button_confirm, 15, 15, 12, 10)
	GUI:setContentSize(Button_confirm, 63, 29)
	GUI:setIgnoreContentAdaptWithSize(Button_confirm, false)
	GUI:Button_setTitleText(Button_confirm, [[]])
	GUI:Button_setTitleColor(Button_confirm, "#f8e6c6")
	GUI:Button_setTitleFontSize(Button_confirm, 12)
	GUI:Button_titleEnableOutline(Button_confirm, "#111111", 2)
	GUI:setChineseName(Button_confirm, "拍卖行主窗体_确认搜索_按钮")
	GUI:setAnchorPoint(Button_confirm, 0.50, 0.50)
	GUI:setTouchEnabled(Button_confirm, true)
	GUI:setTag(Button_confirm, 31)
	TAGOBJ["31"] = Button_confirm

	-- Create Text
	local Text = GUI:Text_Create(Button_confirm, "Text", 32, 13, 14, "#f8e6c6", [[确 认]])
	GUI:Text_enableOutline(Text, "#000000", 2)
	GUI:setChineseName(Text, "拍卖行主窗体_确认_文本")
	GUI:setAnchorPoint(Text, 0.50, 0.50)
	GUI:setTouchEnabled(Text, false)
	GUI:setTag(Text, -1)

	-- Create AttachLayout
	local AttachLayout = GUI:Layout_Create(FrameLayout, "AttachLayout", 18, 28, 608, 391, false)
	GUI:setChineseName(AttachLayout, "拍卖行主窗体_详细内容")
	GUI:setAnchorPoint(AttachLayout, 0.00, 0.00)
	GUI:setTouchEnabled(AttachLayout, false)
	GUI:setTag(AttachLayout, -1)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
