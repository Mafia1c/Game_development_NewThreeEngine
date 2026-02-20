local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(parent, "Panel_1", 0, 0, 272, 349, false)
	GUI:setChineseName(Panel_1, "玩家技能组合")
	GUI:setAnchorPoint(Panel_1, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 41)
	TAGOBJ["41"] = Panel_1

	-- Create Image_bg
	local Image_bg = GUI:Image_Create(Panel_1, "Image_bg", 0, 0, "res/private/player_skill-win32/1900015001.png")
	GUI:setContentSize(Image_bg, 272, 349)
	GUI:setIgnoreContentAdaptWithSize(Image_bg, false)
	GUI:setChineseName(Image_bg, "玩家技能_背景图")
	GUI:setAnchorPoint(Image_bg, 0.00, 0.00)
	GUI:setTouchEnabled(Image_bg, false)
	GUI:setTag(Image_bg, 42)
	GUI:setVisible(Image_bg, false)
	TAGOBJ["42"] = Image_bg

	-- Create ListView_cells
	local ListView_cells = GUI:ListView_Create(Panel_1, "ListView_cells", 5, 349, 272, 349, 1)
	GUI:setChineseName(ListView_cells, "玩家技能_技能列表")
	GUI:setAnchorPoint(ListView_cells, 0.00, 1.00)
	GUI:setTouchEnabled(ListView_cells, true)
	GUI:setTag(ListView_cells, 13)
	TAGOBJ["13"] = ListView_cells

	ui.update(__data__)
	return Panel_1
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
