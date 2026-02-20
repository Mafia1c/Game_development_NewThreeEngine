local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create EquipUI
	local EquipUI = GUI:Layout_Create(parent, "EquipUI", 0, 0, 272, 349, false)
	GUI:setChineseName(EquipUI, "玩家装备_组合")
	GUI:setAnchorPoint(EquipUI, 0.00, 0.00)
	GUI:setTouchEnabled(EquipUI, false)
	GUI:setTag(EquipUI, 137)
	TAGOBJ["137"] = EquipUI

	-- Create BG
	local BG = GUI:Image_Create(EquipUI, "BG", 144, 185, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015042_1.png")
	GUI:setContentSize(BG, 294, 370)
	GUI:setIgnoreContentAdaptWithSize(BG, false)
	GUI:setChineseName(BG, "玩家装备_背景图")
	GUI:setAnchorPoint(BG, 0.50, 0.50)
	GUI:setTouchEnabled(BG, false)
	GUI:setTag(BG, 62)
	TAGOBJ["62"] = BG

	-- Create Node_playerModel
	local Node_playerModel = GUI:Node_Create(EquipUI, "Node_playerModel", 151, 149)
	GUI:setChineseName(Node_playerModel, "玩家装备_裸模")
	GUI:setTag(Node_playerModel, 139)
	TAGOBJ["139"] = Node_playerModel

	-- Create Panel_posEx0
	local Panel_posEx0 = GUI:Layout_Create(EquipUI, "Panel_posEx0", 147, 131, 80, 144, false)
	GUI:setChineseName(Panel_posEx0, "玩家装备_裸模位置")
	GUI:setAnchorPoint(Panel_posEx0, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_posEx0, true)
	GUI:setTag(Panel_posEx0, 140)
	TAGOBJ["140"] = Panel_posEx0

	-- Create Panel_posEx1
	local Panel_posEx1 = GUI:Layout_Create(EquipUI, "Panel_posEx1", 91, 201, 60, 120, false)
	GUI:setChineseName(Panel_posEx1, "玩家装备_武器位置")
	GUI:setAnchorPoint(Panel_posEx1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_posEx1, true)
	GUI:setTag(Panel_posEx1, 141)
	TAGOBJ["141"] = Panel_posEx1

	-- Create Panel_pos16
	local Panel_pos16 = GUI:Layout_Create(EquipUI, "Panel_pos16", 194, 143, 43, 71, false)
	GUI:setChineseName(Panel_pos16, "玩家装备_盾牌")
	GUI:setAnchorPoint(Panel_pos16, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos16, true)
	GUI:setTag(Panel_pos16, 142)
	TAGOBJ["142"] = Panel_pos16

	-- Create Panel_pos4
	local Panel_pos4 = GUI:Layout_Create(EquipUI, "Panel_pos4", 262, 297, 42, 42, false)
	GUI:setChineseName(Panel_pos4, "玩家装备_头盔_组合")
	GUI:setAnchorPoint(Panel_pos4, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos4, true)
	GUI:setTag(Panel_pos4, 143)
	TAGOBJ["143"] = Panel_pos4

	-- Create PanelBg
	local PanelBg = GUI:Image_Create(Panel_pos4, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_头盔_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 205)
	TAGOBJ["205"] = PanelBg

	-- Create DefaultIcon
	local DefaultIcon = GUI:Image_Create(Panel_pos4, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015034.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_头盔_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 206)
	TAGOBJ["206"] = DefaultIcon

	-- Create Panel_pos13
	local Panel_pos13 = GUI:Layout_Create(EquipUI, "Panel_pos13", 27, 243, 42, 42, false)
	GUI:setChineseName(Panel_pos13, "玩家装备_斗笠_组合")
	GUI:setAnchorPoint(Panel_pos13, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos13, true)
	GUI:setTag(Panel_pos13, 207)
	TAGOBJ["207"] = Panel_pos13

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos13, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_斗笠_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 208)
	TAGOBJ["208"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos13, "DefaultIcon", 21, 21, "Default/ImageFile.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_斗笠_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 209)
	GUI:setVisible(DefaultIcon, false)
	TAGOBJ["209"] = DefaultIcon

	-- Create Panel_pos55
	local Panel_pos55 = GUI:Layout_Create(EquipUI, "Panel_pos55", 138, 207, 42, 42, false)
	GUI:setChineseName(Panel_pos55, "玩家装备_面巾_触摸位")
	GUI:setAnchorPoint(Panel_pos55, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos55, true)
	GUI:setTag(Panel_pos55, 145)
	TAGOBJ["145"] = Panel_pos55

	-- Create Panel_pos6
	local Panel_pos6 = GUI:Layout_Create(EquipUI, "Panel_pos6", 27, 135, 42, 42, false)
	GUI:setChineseName(Panel_pos6, "玩家装备_左手镯_组合")
	GUI:setAnchorPoint(Panel_pos6, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos6, true)
	GUI:setTag(Panel_pos6, 144)
	TAGOBJ["144"] = Panel_pos6

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos6, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_左手镯_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 145)
	TAGOBJ["145"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos6, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015034.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_左手镯_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 146)
	TAGOBJ["146"] = DefaultIcon

	-- Create Panel_pos8
	local Panel_pos8 = GUI:Layout_Create(EquipUI, "Panel_pos8", 27, 81, 42, 42, false)
	GUI:setChineseName(Panel_pos8, "玩家装备_左戒指_组合")
	GUI:setAnchorPoint(Panel_pos8, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos8, true)
	GUI:setTag(Panel_pos8, 148)
	TAGOBJ["148"] = Panel_pos8

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos8, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_左戒指_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 149)
	TAGOBJ["149"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos8, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015035.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_左戒指_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 150)
	TAGOBJ["150"] = DefaultIcon

	-- Create Panel_pos7
	local Panel_pos7 = GUI:Layout_Create(EquipUI, "Panel_pos7", 263, 81, 42, 42, false)
	GUI:setChineseName(Panel_pos7, "玩家装备_右戒指_组合")
	GUI:setAnchorPoint(Panel_pos7, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos7, true)
	GUI:setTag(Panel_pos7, 152)
	TAGOBJ["152"] = Panel_pos7

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos7, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_右戒指_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 153)
	TAGOBJ["153"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos7, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015035.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_右戒指_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 154)
	TAGOBJ["154"] = DefaultIcon

	-- Create Panel_pos5
	local Panel_pos5 = GUI:Layout_Create(EquipUI, "Panel_pos5", 263, 135, 42, 42, false)
	GUI:setChineseName(Panel_pos5, "玩家装备_右手镯_组合")
	GUI:setAnchorPoint(Panel_pos5, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos5, true)
	GUI:setTag(Panel_pos5, 156)
	TAGOBJ["156"] = Panel_pos5

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos5, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_右手镯_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 157)
	TAGOBJ["157"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos5, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015034.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_右手镯_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 158)
	TAGOBJ["158"] = DefaultIcon

	-- Create Panel_pos2
	local Panel_pos2 = GUI:Layout_Create(EquipUI, "Panel_pos2", 263, 188, 42, 42, false)
	GUI:setChineseName(Panel_pos2, "玩家装备_勋章_组合")
	GUI:setAnchorPoint(Panel_pos2, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos2, true)
	GUI:setTag(Panel_pos2, 160)
	TAGOBJ["160"] = Panel_pos2

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos2, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_勋章_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 161)
	TAGOBJ["161"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos2, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015033.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_勋章_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 162)
	TAGOBJ["162"] = DefaultIcon

	-- Create Panel_pos3
	local Panel_pos3 = GUI:Layout_Create(EquipUI, "Panel_pos3", 263, 242, 42, 42, false)
	GUI:setChineseName(Panel_pos3, "玩家装备_项链_组合")
	GUI:setAnchorPoint(Panel_pos3, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos3, true)
	GUI:setTag(Panel_pos3, 164)
	TAGOBJ["164"] = Panel_pos3

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos3, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_项链_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 165)
	TAGOBJ["165"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos3, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015032.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_项链_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 166)
	TAGOBJ["166"] = DefaultIcon

	-- Create Panel_pos14
	local Panel_pos14 = GUI:Layout_Create(EquipUI, "Panel_pos14", 27, 27, 42, 42, false)
	GUI:setChineseName(Panel_pos14, "玩家装备_战鼓_组合")
	GUI:setAnchorPoint(Panel_pos14, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos14, true)
	GUI:setTag(Panel_pos14, 201)
	TAGOBJ["201"] = Panel_pos14

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos14, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_战鼓_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 202)
	TAGOBJ["202"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos14, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015040.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_战鼓_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 203)
	TAGOBJ["203"] = DefaultIcon

	-- Create Panel_pos15
	local Panel_pos15 = GUI:Layout_Create(EquipUI, "Panel_pos15", 263, 27, 42, 42, false)
	GUI:setChineseName(Panel_pos15, "玩家装备_坐骑_组合")
	GUI:setAnchorPoint(Panel_pos15, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos15, true)
	GUI:setTag(Panel_pos15, 205)
	TAGOBJ["205"] = Panel_pos15

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos15, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_坐骑_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 206)
	TAGOBJ["206"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos15, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015041.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_坐骑_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 207)
	TAGOBJ["207"] = DefaultIcon

	-- Create Panel_pos12
	local Panel_pos12 = GUI:Layout_Create(EquipUI, "Panel_pos12", 204, 27, 42, 42, false)
	GUI:setChineseName(Panel_pos12, "玩家装备_魔血石_组合")
	GUI:setAnchorPoint(Panel_pos12, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos12, true)
	GUI:setTag(Panel_pos12, 168)
	TAGOBJ["168"] = Panel_pos12

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos12, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_魔血石_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 169)
	TAGOBJ["169"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos12, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015039.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_魔血石_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 170)
	TAGOBJ["170"] = DefaultIcon

	-- Create Panel_pos11
	local Panel_pos11 = GUI:Layout_Create(EquipUI, "Panel_pos11", 145, 27, 42, 42, false)
	GUI:setChineseName(Panel_pos11, "玩家装备_靴子_组合")
	GUI:setAnchorPoint(Panel_pos11, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos11, true)
	GUI:setTag(Panel_pos11, 172)
	TAGOBJ["172"] = Panel_pos11

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos11, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_靴子_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 173)
	TAGOBJ["173"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos11, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015037.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_靴子_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 174)
	TAGOBJ["174"] = DefaultIcon

	-- Create Panel_pos10
	local Panel_pos10 = GUI:Layout_Create(EquipUI, "Panel_pos10", 86, 27, 42, 42, false)
	GUI:setChineseName(Panel_pos10, "玩家装备_腰带_组合")
	GUI:setAnchorPoint(Panel_pos10, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos10, true)
	GUI:setTag(Panel_pos10, 176)
	TAGOBJ["176"] = Panel_pos10

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos10, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_腰带_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 177)
	TAGOBJ["177"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos10, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015038.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_腰带_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 178)
	TAGOBJ["178"] = DefaultIcon

	-- Create Panel_pos9
	local Panel_pos9 = GUI:Layout_Create(EquipUI, "Panel_pos9", 27, 188, 42, 42, false)
	GUI:setChineseName(Panel_pos9, "玩家装备_护身符_组合")
	GUI:setAnchorPoint(Panel_pos9, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos9, true)
	GUI:setTag(Panel_pos9, 180)
	TAGOBJ["180"] = Panel_pos9

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos9, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_护身符_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 181)
	TAGOBJ["181"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos9, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015036.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_护身符_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 182)
	TAGOBJ["182"] = DefaultIcon

	-- Create Node_6
	local Node_6 = GUI:Node_Create(EquipUI, "Node_6", 27, 135)
	GUI:setChineseName(Node_6, "玩家装备_左手镯_位置")
	GUI:setTag(Node_6, 147)
	TAGOBJ["147"] = Node_6

	-- Create Node_8
	local Node_8 = GUI:Node_Create(EquipUI, "Node_8", 27, 81)
	GUI:setChineseName(Node_8, "玩家装备_左戒指_位置")
	GUI:setTag(Node_8, 151)
	TAGOBJ["151"] = Node_8

	-- Create Node_7
	local Node_7 = GUI:Node_Create(EquipUI, "Node_7", 263, 81)
	GUI:setChineseName(Node_7, "玩家装备_右戒指_位置")
	GUI:setTag(Node_7, 155)
	TAGOBJ["155"] = Node_7

	-- Create Node_5
	local Node_5 = GUI:Node_Create(EquipUI, "Node_5", 263, 135)
	GUI:setChineseName(Node_5, "玩家装备_右手镯_位置")
	GUI:setTag(Node_5, 159)
	TAGOBJ["159"] = Node_5

	-- Create Node_2
	local Node_2 = GUI:Node_Create(EquipUI, "Node_2", 263, 188)
	GUI:setChineseName(Node_2, "玩家装备_勋章_位置")
	GUI:setTag(Node_2, 163)
	TAGOBJ["163"] = Node_2

	-- Create Node_3
	local Node_3 = GUI:Node_Create(EquipUI, "Node_3", 263, 242)
	GUI:setChineseName(Node_3, "玩家装备_项链_位置")
	GUI:setTag(Node_3, 167)
	TAGOBJ["167"] = Node_3

	-- Create Node_4
	local Node_4 = GUI:Node_Create(EquipUI, "Node_4", 262, 297)
	GUI:setChineseName(Node_4, "玩家装备_头盔_位置")
	GUI:setTag(Node_4, 210)
	TAGOBJ["210"] = Node_4

	-- Create Node_13
	local Node_13 = GUI:Node_Create(EquipUI, "Node_13", 27, 243)
	GUI:setChineseName(Node_13, "玩家装备_斗笠_位置")
	GUI:setTag(Node_13, 211)
	TAGOBJ["211"] = Node_13

	-- Create Node_55
	local Node_55 = GUI:Node_Create(EquipUI, "Node_55", 138, 207)
	GUI:setChineseName(Node_55, "玩家装备_面巾_位置(只能放头上)")
	GUI:setTag(Node_55, 146)
	TAGOBJ["146"] = Node_55

	-- Create Node_14
	local Node_14 = GUI:Node_Create(EquipUI, "Node_14", 27, 27)
	GUI:setChineseName(Node_14, "玩家装备_战鼓_位置")
	GUI:setTag(Node_14, 204)
	TAGOBJ["204"] = Node_14

	-- Create Node_15
	local Node_15 = GUI:Node_Create(EquipUI, "Node_15", 263, 27)
	GUI:setChineseName(Node_15, "玩家装备_坐骑_位置")
	GUI:setTag(Node_15, 208)
	TAGOBJ["208"] = Node_15

	-- Create Node_12
	local Node_12 = GUI:Node_Create(EquipUI, "Node_12", 204, 27)
	GUI:setChineseName(Node_12, "玩家装备_魔血石_位置")
	GUI:setTag(Node_12, 171)
	TAGOBJ["171"] = Node_12

	-- Create Node_11
	local Node_11 = GUI:Node_Create(EquipUI, "Node_11", 145, 27)
	GUI:setChineseName(Node_11, "玩家装备_靴子_位置")
	GUI:setTag(Node_11, 175)
	TAGOBJ["175"] = Node_11

	-- Create Node_10
	local Node_10 = GUI:Node_Create(EquipUI, "Node_10", 86, 27)
	GUI:setChineseName(Node_10, "玩家装备_腰带_位置")
	GUI:setTag(Node_10, 179)
	TAGOBJ["179"] = Node_10

	-- Create Node_9
	local Node_9 = GUI:Node_Create(EquipUI, "Node_9", 27, 188)
	GUI:setChineseName(Node_9, "玩家装备_护身符_位置")
	GUI:setTag(Node_9, 183)
	TAGOBJ["183"] = Node_9

	-- Create Text_guildinfo
	local Text_guildinfo = GUI:Text_Create(EquipUI, "Text_guildinfo", 64, 344, 18, "#00ffe8", [[]])
	GUI:Text_enableOutline(Text_guildinfo, "#0e0e0e", 1)
	GUI:setChineseName(Text_guildinfo, "玩家装备_行会信息")
	GUI:setAnchorPoint(Text_guildinfo, 0.00, 0.50)
	GUI:setTouchEnabled(Text_guildinfo, false)
	GUI:setTag(Text_guildinfo, 138)
	TAGOBJ["138"] = Text_guildinfo

	-- Create Best_ringBox
	local Best_ringBox = GUI:Layout_Create(EquipUI, "Best_ringBox", 239, 320, 46, 36, false)
	GUI:setChineseName(Best_ringBox, "玩家装备_首饰盒组合")
	GUI:setAnchorPoint(Best_ringBox, 0.00, 0.00)
	GUI:setTouchEnabled(Best_ringBox, true)
	GUI:setTag(Best_ringBox, 184)
	TAGOBJ["184"] = Best_ringBox

	-- Create Image_box
	local Image_box = GUI:Image_Create(Best_ringBox, "Image_box", 22, 16, "res/private/player_best_rings_ui/player_best_rings_ui_win32/btn_jewelry_1_0.png")
	GUI:setChineseName(Image_box, "玩家装备_首饰盒")
	GUI:setAnchorPoint(Image_box, 0.50, 0.50)
	GUI:setTouchEnabled(Image_box, false)
	GUI:setTag(Image_box, 185)
	TAGOBJ["185"] = Image_box

	-- Create Panel_pos1
	local Panel_pos1 = GUI:Layout_Create(EquipUI, "Panel_pos1", 24, 205, 42, 42, false)
	GUI:setChineseName(Panel_pos1, "玩家装备_武器_组合")
	GUI:setAnchorPoint(Panel_pos1, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos1, true)
	GUI:setTag(Panel_pos1, 69)
	GUI:setVisible(Panel_pos1, false)
	TAGOBJ["69"] = Panel_pos1

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos1, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_武器_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 70)
	TAGOBJ["70"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos1, "DefaultIcon", 21, 21, "res/public/0.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_武器_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 81)
	TAGOBJ["81"] = DefaultIcon

	-- Create Node_1
	local Node_1 = GUI:Node_Create(EquipUI, "Node_1", 24, 205)
	GUI:setChineseName(Node_1, "玩家装备_武器_位置")
	GUI:setTag(Node_1, 71)
	GUI:setVisible(Node_1, false)
	TAGOBJ["71"] = Node_1

	-- Create Panel_pos0
	local Panel_pos0 = GUI:Layout_Create(EquipUI, "Panel_pos0", 24, 160, 42, 42, false)
	GUI:setChineseName(Panel_pos0, "玩家装备_衣服_组合")
	GUI:setAnchorPoint(Panel_pos0, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos0, true)
	GUI:setTag(Panel_pos0, 69)
	GUI:setVisible(Panel_pos0, false)
	TAGOBJ["69"] = Panel_pos0

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos0, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_衣服_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 70)
	TAGOBJ["70"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos0, "DefaultIcon", 21, 21, "res/public/0.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_衣服_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 81)
	TAGOBJ["81"] = DefaultIcon

	-- Create Node_0
	local Node_0 = GUI:Node_Create(EquipUI, "Node_0", 24, 160)
	GUI:setChineseName(Node_0, "玩家装备_衣服_位置")
	GUI:setTag(Node_0, 71)
	GUI:setVisible(Node_0, false)
	TAGOBJ["71"] = Node_0

	-- Create zfBtn
	local zfBtn = GUI:Button_Create(EquipUI, "zfBtn", 238, 352, "res/custom/mbtn/zf1.png")
	GUI:Button_loadTexturePressed(zfBtn, "res/custom/mbtn/zf2.png")
	GUI:Button_setScale9Slice(zfBtn, 0, 0, 0, 0)
	GUI:setContentSize(zfBtn, 46, 26)
	GUI:setIgnoreContentAdaptWithSize(zfBtn, false)
	GUI:Button_setTitleText(zfBtn, [[]])
	GUI:Button_setTitleColor(zfBtn, "#ffffff")
	GUI:Button_setTitleFontSize(zfBtn, 14)
	GUI:Button_titleEnableOutline(zfBtn, "#000000", 1)
	GUI:setAnchorPoint(zfBtn, 0.00, 0.00)
	GUI:setTouchEnabled(zfBtn, true)
	GUI:setTag(zfBtn, -1)

	-- Create Panel_pos89
	local Panel_pos89 = GUI:Layout_Create(EquipUI, "Panel_pos89", 27, 298, 42, 42, false)
	GUI:setAnchorPoint(Panel_pos89, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos89, true)
	GUI:setTag(Panel_pos89, 207)
	TAGOBJ["207"] = Panel_pos89

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos89, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 208)
	TAGOBJ["208"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos89, "DefaultIcon", 21, 21, "Default/ImageFile.png")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 209)
	GUI:setVisible(DefaultIcon, false)
	TAGOBJ["209"] = DefaultIcon

	-- Create EquipShow_89
	local EquipShow_89 = GUI:EquipShow_Create(Panel_pos89, "EquipShow_89", 22, 22, 89, false, {bgVisible = false, doubleTakeOff = false, look = true, movable = false, starLv = true, lookPlayer = false, showModelEffect = false})
	GUI:EquipShow_setAutoUpdate(EquipShow_89)
	GUI:setAnchorPoint(EquipShow_89, 0.50, 0.50)
	GUI:setTouchEnabled(EquipShow_89, false)
	GUI:setTag(EquipShow_89, 0)

	ui.update(__data__)
	return EquipUI
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
