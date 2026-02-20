local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Node
	local Node = GUI:Node_Create(parent, "Node", 0, 0)
	GUI:setChineseName(Node, "大地图_节点")
	GUI:setTag(Node, -1)

	-- Create Panel_1
	local Panel_1 = GUI:Layout_Create(Node, "Panel_1", 568, 320, 722, 485, false)
	GUI:setChineseName(Panel_1, "大地图_组合")
	GUI:setAnchorPoint(Panel_1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_1, true)
	GUI:setTag(Panel_1, 55)
	TAGOBJ["55"] = Panel_1

	-- Create Panel_map
	local Panel_map = GUI:Layout_Create(Panel_1, "Panel_map", 0, 0, 722, 485, false)
	GUI:setChineseName(Panel_map, "大地图_组合")
	GUI:setAnchorPoint(Panel_map, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_map, false)
	GUI:setTag(Panel_map, 56)
	TAGOBJ["56"] = Panel_map

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Panel_map, "Image_1", 0, 0, "res/private/minimap/minibg.png")
	GUI:setContentSize(Image_1, 722, 485)
	GUI:setIgnoreContentAdaptWithSize(Image_1, false)
	GUI:setAnchorPoint(Image_1, 0.00, 0.00)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 0)

	-- Create Panel_minimap
	local Panel_minimap = GUI:Layout_Create(Panel_map, "Panel_minimap", 268, 268, 506, 350, false)
	GUI:setChineseName(Panel_minimap, "大地图_组合")
	GUI:setAnchorPoint(Panel_minimap, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_minimap, false)
	GUI:setTag(Panel_minimap, 58)
	TAGOBJ["58"] = Panel_minimap

	-- Create Image_mini_map
	local Image_mini_map = GUI:Image_Create(Panel_minimap, "Image_mini_map", 253, 175, "Default/ImageFile.png")
	GUI:setChineseName(Image_mini_map, "大地图_大地图_图片")
	GUI:setAnchorPoint(Image_mini_map, 0.50, 0.50)
	GUI:setTouchEnabled(Image_mini_map, false)
	GUI:setTag(Image_mini_map, 59)
	TAGOBJ["59"] = Image_mini_map

	-- Create Panel_event
	local Panel_event = GUI:Layout_Create(Panel_minimap, "Panel_event", 253, 175, 200, 200, false)
	GUI:setChineseName(Panel_event, "大地图_事件")
	GUI:setAnchorPoint(Panel_event, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_event, true)
	GUI:setTag(Panel_event, 61)
	TAGOBJ["61"] = Panel_event

	-- Create Node_monster
	local Node_monster = GUI:Node_Create(Panel_minimap, "Node_monster", 0, 0)
	GUI:setChineseName(Node_monster, "大地图_怪物节点")
	GUI:setTag(Node_monster, 70)
	TAGOBJ["70"] = Node_monster

	-- Create Node_team
	local Node_team = GUI:Node_Create(Panel_minimap, "Node_team", 0, 0)
	GUI:setChineseName(Node_team, "大地图_队友节点")
	GUI:setTag(Node_team, 71)
	TAGOBJ["71"] = Node_team

	-- Create Node_portals
	local Node_portals = GUI:Node_Create(Panel_minimap, "Node_portals", 0, 0)
	GUI:setChineseName(Node_portals, "大地图_描述节点")
	GUI:setTag(Node_portals, 72)
	TAGOBJ["72"] = Node_portals

	-- Create Node_path
	local Node_path = GUI:Node_Create(Panel_minimap, "Node_path", 0, 0)
	GUI:setChineseName(Node_path, "大地图_路径")
	GUI:setTag(Node_path, 62)
	TAGOBJ["62"] = Node_path

	-- Create Image_point
	local Image_point = GUI:Layout_Create(Panel_minimap, "Image_point", 100, 80, 100, 20, false)
	GUI:Layout_setBackGroundImage(Image_point, "res/private/minimap/1900012108.png")
	GUI:Layout_setBackGroundColorType(Image_point, 1)
	GUI:Layout_setBackGroundColor(Image_point, "#ffffff")
	GUI:Layout_setBackGroundColorOpacity(Image_point, 0)
	GUI:Layout_setBackGroundImageScale9Slice(Image_point, 50, 50, 0, 0)
	GUI:setChineseName(Image_point, "大地图_坐标组合")
	GUI:setAnchorPoint(Image_point, 0.50, 0.50)
	GUI:setTouchEnabled(Image_point, false)
	GUI:setTag(Image_point, 63)
	TAGOBJ["63"] = Image_point

	-- Create Text_point
	local Text_point = GUI:Text_Create(Image_point, "Text_point", 50, 10, 12, "#00ff00", [[(123，123）]])
	GUI:Text_enableOutline(Text_point, "#000000", 1)
	GUI:setAnchorPoint(Text_point, 0.50, 0.50)
	GUI:setTouchEnabled(Text_point, false)
	GUI:setTag(Text_point, 64)
	TAGOBJ["64"] = Text_point

	-- Create Image_player
	local Image_player = GUI:Image_Create(Panel_minimap, "Image_player", 100, 50, "res/private/minimap/icon_xdtzy_02.png")
	GUI:setChineseName(Image_player, "大地图_玩家位置_图片")
	GUI:setAnchorPoint(Image_player, 0.50, 0.50)
	GUI:setTouchEnabled(Image_player, false)
	GUI:setTag(Image_player, 65)
	TAGOBJ["65"] = Image_player

	-- Create Text_mouse_pos
	local Text_mouse_pos = GUI:Text_Create(Panel_minimap, "Text_mouse_pos", 500, 0, 12, "#ffffff", [[99:99]])
	GUI:Text_enableOutline(Text_mouse_pos, "#000000", 1)
	GUI:setChineseName(Text_mouse_pos, "大地图_鼠标指针_坐标")
	GUI:setAnchorPoint(Text_mouse_pos, 1.00, 0.00)
	GUI:setTouchEnabled(Text_mouse_pos, false)
	GUI:setTag(Text_mouse_pos, 12)
	TAGOBJ["12"] = Text_mouse_pos

	-- Create CloseButton
	local CloseButton = GUI:Button_Create(Panel_1, "CloseButton", 684, 448, "res/public/01.png")
	GUI:Button_loadTexturePressed(CloseButton, "res/public/02.png")
	GUI:setContentSize(CloseButton, 30, 30)
	GUI:setIgnoreContentAdaptWithSize(CloseButton, false)
	GUI:Button_setTitleText(CloseButton, [[]])
	GUI:Button_setTitleColor(CloseButton, "#ffffff")
	GUI:Button_setTitleFontSize(CloseButton, 16)
	GUI:Button_titleEnableOutline(CloseButton, "#000000", 1)
	GUI:setAnchorPoint(CloseButton, 0.00, 0.00)
	GUI:setTouchEnabled(CloseButton, true)
	GUI:setTag(CloseButton, 0)

	ui.update(__data__)
	return Node
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
