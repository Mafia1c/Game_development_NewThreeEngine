local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Scene
	local Scene = GUI:Layout_Create(parent, "Scene", 0, 0, _V("SCREEN_WIDTH"), _V("SCREEN_HEIGHT"), false)
	GUI:setAnchorPoint(Scene, 0.00, 0.00)
	GUI:setTouchEnabled(Scene, true)
	GUI:setTag(Scene, -1)

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Scene, "Image_bg", 0, _V("SCREEN_HEIGHT"), "res/public/bg_npc_01.png")
	GUI:setContentSize(Image_bg, 546, 179)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setAnchorPoint(Image_bg, 0.00, 1.00)
	GUI:setTouchEnabled(Image_bg, true)
	GUI:setTag(Image_bg, 0)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(Image_bg, "closeBtn", 545, 137, "res/public/11.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/public/12.png")
	GUI:setContentSize(closeBtn, 26, 42)
	GUI:setIgnoreContentAdaptWithSize(closeBtn, false)
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 16)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.00, 0.00)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, 0)

	-- Create map_tjp
	local map_tjp = GUI:Text_Create(Image_bg, "map_tjp", 73, 138, 18, "#ffff00", [[铁匠铺]])
	GUI:Text_enableOutline(map_tjp, "#000000", 1)
	GUI:Text_enableUnderline(map_tjp)
	GUI:setAnchorPoint(map_tjp, 0.00, 0.00)
	GUI:setTouchEnabled(map_tjp, true)
	GUI:setTag(map_tjp, 0)

	-- Create Image_1
	local Image_1 = GUI:Image_Create(map_tjp, "Image_1", -19, 5, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create map_bld
	local map_bld = GUI:Text_Create(Image_bg, "map_bld", 233, 138, 18, "#ffff00", [[布料店]])
	GUI:Text_enableOutline(map_bld, "#000000", 1)
	GUI:Text_enableUnderline(map_bld)
	GUI:setAnchorPoint(map_bld, 0.00, 0.00)
	GUI:setTouchEnabled(map_bld, true)
	GUI:setTag(map_bld, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(map_bld, "Image_1", -19, 5, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create map_ssd
	local map_ssd = GUI:Text_Create(Image_bg, "map_ssd", 390, 138, 18, "#ffff00", [[首饰店]])
	GUI:Text_enableOutline(map_ssd, "#000000", 1)
	GUI:Text_enableUnderline(map_ssd)
	GUI:setAnchorPoint(map_ssd, 0.00, 0.00)
	GUI:setTouchEnabled(map_ssd, true)
	GUI:setTag(map_ssd, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(map_ssd, "Image_1", -19, 5, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create map_kz
	local map_kz = GUI:Text_Create(Image_bg, "map_kz", 73, 99, 18, "#ffff00", [[客栈]])
	GUI:Text_enableOutline(map_kz, "#000000", 1)
	GUI:Text_enableUnderline(map_kz)
	GUI:setAnchorPoint(map_kz, 0.00, 0.00)
	GUI:setTouchEnabled(map_kz, true)
	GUI:setTag(map_kz, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(map_kz, "Image_1", -19, 5, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create map_mf
	local map_mf = GUI:Text_Create(Image_bg, "map_mf", 233, 99, 18, "#ffff00", [[磨房]])
	GUI:Text_enableOutline(map_mf, "#000000", 1)
	GUI:Text_enableUnderline(map_mf)
	GUI:setAnchorPoint(map_mf, 0.00, 0.00)
	GUI:setTouchEnabled(map_mf, true)
	GUI:setTag(map_mf, 0)

	-- Create Image_1
	Image_1 = GUI:Image_Create(map_mf, "Image_1", -19, 5, "res/public/btn_npcfh_03.png")
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	ui.update(__data__)
	return Scene
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
