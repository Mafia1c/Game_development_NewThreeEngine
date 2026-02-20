local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create EquipUI
	local EquipUI = GUI:Layout_Create(parent, "EquipUI", 0, 0, 272, 349, false)
	GUI:setChineseName(EquipUI, "玩家时装_组合")
	GUI:setAnchorPoint(EquipUI, 0.00, 0.00)
	GUI:setTouchEnabled(EquipUI, false)
	GUI:setTag(EquipUI, 137)
	TAGOBJ["137"] = EquipUI

	-- Create BG
	local BG = GUI:Image_Create(EquipUI, "BG", 136, 174, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015001_1.jpg")
	GUI:setChineseName(BG, "玩家时装_背景图")
	GUI:setAnchorPoint(BG, 0.50, 0.50)
	GUI:setTouchEnabled(BG, false)
	GUI:setTag(BG, 62)
	TAGOBJ["62"] = BG

	-- Create Node_playerModel
	local Node_playerModel = GUI:Node_Create(EquipUI, "Node_playerModel", 139, 138)
	GUI:setChineseName(Node_playerModel, "玩家时装_裸模位置")
	GUI:setTag(Node_playerModel, 139)
	TAGOBJ["139"] = Node_playerModel

	-- Create Panel_posEx17
	local Panel_posEx17 = GUI:Layout_Create(EquipUI, "Panel_posEx17", 136, 120, 103, 144, false)
	GUI:setChineseName(Panel_posEx17, "玩家时装_衣服位置")
	GUI:setAnchorPoint(Panel_posEx17, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_posEx17, true)
	GUI:setTag(Panel_posEx17, 140)
	TAGOBJ["140"] = Panel_posEx17

	-- Create Panel_posEx18
	local Panel_posEx18 = GUI:Layout_Create(EquipUI, "Panel_posEx18", 65, 190, 80, 120, false)
	GUI:setChineseName(Panel_posEx18, "玩家时装_武器位置")
	GUI:setAnchorPoint(Panel_posEx18, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_posEx18, true)
	GUI:setTag(Panel_posEx18, 141)
	TAGOBJ["141"] = Panel_posEx18

	-- Create Panel_pos45
	local Panel_pos45 = GUI:Layout_Create(EquipUI, "Panel_pos45", 134, 185, 139, 177, false)
	GUI:setChineseName(Panel_pos45, "玩家时装_盾牌位置")
	GUI:setAnchorPoint(Panel_pos45, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos45, true)
	GUI:setTag(Panel_pos45, 142)
	TAGOBJ["142"] = Panel_pos45

	-- Create Panel_pos19
	local Panel_pos19 = GUI:Layout_Create(EquipUI, "Panel_pos19", 138, 207, 33, 30, false)
	GUI:setChineseName(Panel_pos19, "玩家时装_斗笠位置")
	GUI:setAnchorPoint(Panel_pos19, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos19, true)
	GUI:setTag(Panel_pos19, 143)
	TAGOBJ["143"] = Panel_pos19

	-- Create PanelBg
	local PanelBg = GUI:Image_Create(Panel_pos19, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_斗笠_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 145)
	GUI:setVisible(PanelBg, false)
	TAGOBJ["145"] = PanelBg

	-- Create DefaultIcon
	local DefaultIcon = GUI:Image_Create(Panel_pos19, "DefaultIcon", 21, 21, "res/private/gui_edit/ImageFile.png")
	GUI:setContentSize(DefaultIcon, 35, 36)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_斗笠_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 146)
	GUI:setVisible(DefaultIcon, false)
	TAGOBJ["146"] = DefaultIcon

	-- Create Panel_pos21
	local Panel_pos21 = GUI:Layout_Create(EquipUI, "Panel_pos21", 138, 207, 33, 30, false)
	GUI:setChineseName(Panel_pos21, "玩家时装_头盔位置")
	GUI:setAnchorPoint(Panel_pos21, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos21, true)
	GUI:setTag(Panel_pos21, 143)
	TAGOBJ["143"] = Panel_pos21

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos21, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_头盔_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 145)
	GUI:setVisible(PanelBg, false)
	TAGOBJ["145"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos21, "DefaultIcon", 21, 21, "res/private/gui_edit/ImageFile.png")
	GUI:setContentSize(DefaultIcon, 35, 36)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_头盔_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 146)
	GUI:setVisible(DefaultIcon, false)
	TAGOBJ["146"] = DefaultIcon

	-- Create Panel_pos23
	local Panel_pos23 = GUI:Layout_Create(EquipUI, "Panel_pos23", 24, 128, 42, 42, false)
	GUI:setChineseName(Panel_pos23, "玩家时装_右手镯组合")
	GUI:setAnchorPoint(Panel_pos23, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos23, true)
	GUI:setTag(Panel_pos23, 144)
	TAGOBJ["144"] = Panel_pos23

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos23, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_右手镯_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 145)
	TAGOBJ["145"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos23, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015034.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_右手镯_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 146)
	TAGOBJ["146"] = DefaultIcon

	-- Create Panel_pos25
	local Panel_pos25 = GUI:Layout_Create(EquipUI, "Panel_pos25", 24, 76, 42, 42, false)
	GUI:setChineseName(Panel_pos25, "玩家时装_右戒指组合")
	GUI:setAnchorPoint(Panel_pos25, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos25, true)
	GUI:setTag(Panel_pos25, 148)
	TAGOBJ["148"] = Panel_pos25

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos25, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_右戒指_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 149)
	TAGOBJ["149"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos25, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015035.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_右戒指_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 150)
	TAGOBJ["150"] = DefaultIcon

	-- Create Panel_pos24
	local Panel_pos24 = GUI:Layout_Create(EquipUI, "Panel_pos24", 248, 76, 42, 42, false)
	GUI:setChineseName(Panel_pos24, "玩家时装_左戒指_组合")
	GUI:setAnchorPoint(Panel_pos24, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos24, true)
	GUI:setTag(Panel_pos24, 152)
	TAGOBJ["152"] = Panel_pos24

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos24, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_左戒指_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 153)
	TAGOBJ["153"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos24, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015035.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_左戒指_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 154)
	TAGOBJ["154"] = DefaultIcon

	-- Create Panel_pos22
	local Panel_pos22 = GUI:Layout_Create(EquipUI, "Panel_pos22", 248, 128, 42, 42, false)
	GUI:setChineseName(Panel_pos22, "玩家时装_左手镯_组合")
	GUI:setAnchorPoint(Panel_pos22, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos22, true)
	GUI:setTag(Panel_pos22, 156)
	TAGOBJ["156"] = Panel_pos22

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos22, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_左手镯_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 157)
	TAGOBJ["157"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos22, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015034.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_左手镯_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 158)
	TAGOBJ["158"] = DefaultIcon

	-- Create Panel_pos26
	local Panel_pos26 = GUI:Layout_Create(EquipUI, "Panel_pos26", 248, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos26, "玩家时装_勋章_组合")
	GUI:setAnchorPoint(Panel_pos26, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos26, true)
	GUI:setTag(Panel_pos26, 160)
	TAGOBJ["160"] = Panel_pos26

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos26, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_勋章_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 161)
	TAGOBJ["161"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos26, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015033.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_勋章_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 162)
	TAGOBJ["162"] = DefaultIcon

	-- Create Panel_pos20
	local Panel_pos20 = GUI:Layout_Create(EquipUI, "Panel_pos20", 248, 181, 42, 42, false)
	GUI:setChineseName(Panel_pos20, "玩家时装_项链_组合")
	GUI:setAnchorPoint(Panel_pos20, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos20, true)
	GUI:setTag(Panel_pos20, 164)
	TAGOBJ["164"] = Panel_pos20

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos20, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_项链_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 165)
	TAGOBJ["165"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos20, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015032.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_项链_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 71)
	TAGOBJ["71"] = DefaultIcon

	-- Create Panel_pos44
	local Panel_pos44 = GUI:Layout_Create(EquipUI, "Panel_pos44", 24, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos44, "玩家时装_战鼓_组合")
	GUI:setAnchorPoint(Panel_pos44, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos44, true)
	GUI:setTag(Panel_pos44, 201)
	TAGOBJ["201"] = Panel_pos44

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos44, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_战鼓_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 202)
	TAGOBJ["202"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos44, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015040.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_战鼓_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 203)
	TAGOBJ["203"] = DefaultIcon

	-- Create Panel_pos42
	local Panel_pos42 = GUI:Layout_Create(EquipUI, "Panel_pos42", 248, 233, 42, 42, false)
	GUI:setChineseName(Panel_pos42, "玩家时装_坐骑_组合")
	GUI:setAnchorPoint(Panel_pos42, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos42, true)
	GUI:setTag(Panel_pos42, 205)
	TAGOBJ["205"] = Panel_pos42

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos42, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_坐骑_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 206)
	TAGOBJ["206"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos42, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015041.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_坐骑_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 207)
	TAGOBJ["207"] = DefaultIcon

	-- Create Panel_pos29
	local Panel_pos29 = GUI:Layout_Create(EquipUI, "Panel_pos29", 192, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos29, "玩家时装_魔血石_组合")
	GUI:setAnchorPoint(Panel_pos29, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos29, true)
	GUI:setTag(Panel_pos29, 168)
	TAGOBJ["168"] = Panel_pos29

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos29, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_魔血石_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 169)
	TAGOBJ["169"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos29, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015039.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_魔血石_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 170)
	TAGOBJ["170"] = DefaultIcon

	-- Create Panel_pos28
	local Panel_pos28 = GUI:Layout_Create(EquipUI, "Panel_pos28", 136, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos28, "玩家时装_靴子_组合")
	GUI:setAnchorPoint(Panel_pos28, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos28, true)
	GUI:setTag(Panel_pos28, 172)
	TAGOBJ["172"] = Panel_pos28

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos28, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_靴子_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 173)
	TAGOBJ["173"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos28, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015037.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_靴子_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 174)
	TAGOBJ["174"] = DefaultIcon

	-- Create Panel_pos27
	local Panel_pos27 = GUI:Layout_Create(EquipUI, "Panel_pos27", 80, 24, 42, 42, false)
	GUI:setChineseName(Panel_pos27, "玩家时装_腰带_组合")
	GUI:setAnchorPoint(Panel_pos27, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos27, true)
	GUI:setTag(Panel_pos27, 176)
	TAGOBJ["176"] = Panel_pos27

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos27, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_腰带_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 177)
	TAGOBJ["177"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos27, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015038.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_腰带_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 178)
	TAGOBJ["178"] = DefaultIcon

	-- Create Panel_pos43
	local Panel_pos43 = GUI:Layout_Create(EquipUI, "Panel_pos43", 24, 180, 42, 42, false)
	GUI:setChineseName(Panel_pos43, "玩家时装_护身符_组合")
	GUI:setAnchorPoint(Panel_pos43, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos43, true)
	GUI:setTag(Panel_pos43, 180)
	TAGOBJ["180"] = Panel_pos43

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos43, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家时装_护身符_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 181)
	TAGOBJ["181"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos43, "DefaultIcon", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/1900015036.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_护身符_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 182)
	TAGOBJ["182"] = DefaultIcon

	-- Create Node_19
	local Node_19 = GUI:Node_Create(EquipUI, "Node_19", 138, 208)
	GUI:setTag(Node_19, 147)
	TAGOBJ["147"] = Node_19

	-- Create Node_21
	local Node_21 = GUI:Node_Create(EquipUI, "Node_21", 138, 208)
	GUI:setTag(Node_21, 147)
	TAGOBJ["147"] = Node_21

	-- Create Node_23
	local Node_23 = GUI:Node_Create(EquipUI, "Node_23", 24, 128)
	GUI:setChineseName(Node_23, "玩家时装_右手镯_位置")
	GUI:setTag(Node_23, 147)
	TAGOBJ["147"] = Node_23

	-- Create Node_25
	local Node_25 = GUI:Node_Create(EquipUI, "Node_25", 24, 76)
	GUI:setChineseName(Node_25, "玩家时装_右戒指_位置")
	GUI:setTag(Node_25, 151)
	TAGOBJ["151"] = Node_25

	-- Create Node_24
	local Node_24 = GUI:Node_Create(EquipUI, "Node_24", 248, 76)
	GUI:setChineseName(Node_24, "玩家时装_左戒指_位置")
	GUI:setTag(Node_24, 155)
	TAGOBJ["155"] = Node_24

	-- Create Node_22
	local Node_22 = GUI:Node_Create(EquipUI, "Node_22", 248, 128)
	GUI:setChineseName(Node_22, "玩家时装_左手镯_位置")
	GUI:setTag(Node_22, 159)
	TAGOBJ["159"] = Node_22

	-- Create Node_26
	local Node_26 = GUI:Node_Create(EquipUI, "Node_26", 248, 24)
	GUI:setChineseName(Node_26, "玩家时装_勋章_位置")
	GUI:setTag(Node_26, 163)
	TAGOBJ["163"] = Node_26

	-- Create Node_20
	local Node_20 = GUI:Node_Create(EquipUI, "Node_20", 248, 181)
	GUI:setChineseName(Node_20, "玩家时装_项链_位置")
	GUI:setTag(Node_20, 167)
	TAGOBJ["167"] = Node_20

	-- Create Node_44
	local Node_44 = GUI:Node_Create(EquipUI, "Node_44", 24, 24)
	GUI:setChineseName(Node_44, "玩家时装_战鼓_位置")
	GUI:setTag(Node_44, 204)
	TAGOBJ["204"] = Node_44

	-- Create Node_42
	local Node_42 = GUI:Node_Create(EquipUI, "Node_42", 248, 233)
	GUI:setChineseName(Node_42, "玩家时装_坐骑_位置")
	GUI:setTag(Node_42, 208)
	TAGOBJ["208"] = Node_42

	-- Create Node_29
	local Node_29 = GUI:Node_Create(EquipUI, "Node_29", 192, 24)
	GUI:setChineseName(Node_29, "玩家时装_魔血石_位置")
	GUI:setTag(Node_29, 171)
	TAGOBJ["171"] = Node_29

	-- Create Node_28
	local Node_28 = GUI:Node_Create(EquipUI, "Node_28", 136, 24)
	GUI:setChineseName(Node_28, "玩家时装_靴子_位置")
	GUI:setTag(Node_28, 175)
	TAGOBJ["175"] = Node_28

	-- Create Node_27
	local Node_27 = GUI:Node_Create(EquipUI, "Node_27", 80, 24)
	GUI:setChineseName(Node_27, "玩家时装_腰带_位置")
	GUI:setTag(Node_27, 179)
	TAGOBJ["179"] = Node_27

	-- Create Node_43
	local Node_43 = GUI:Node_Create(EquipUI, "Node_43", 24, 180)
	GUI:setChineseName(Node_43, "玩家时装_护身符_位置")
	GUI:setTag(Node_43, 183)
	TAGOBJ["183"] = Node_43

	-- Create Panel_pos18
	local Panel_pos18 = GUI:Layout_Create(EquipUI, "Panel_pos18", 24, 205, 42, 42, false)
	GUI:setChineseName(Panel_pos18, "玩家装备_武器_组合")
	GUI:setAnchorPoint(Panel_pos18, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos18, true)
	GUI:setTag(Panel_pos18, 69)
	GUI:setVisible(Panel_pos18, false)
	TAGOBJ["69"] = Panel_pos18

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos18, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_武器_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 70)
	TAGOBJ["70"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos18, "DefaultIcon", 21, 21, "res/public/0.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_武器_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 81)
	TAGOBJ["81"] = DefaultIcon

	-- Create Node_18
	local Node_18 = GUI:Node_Create(EquipUI, "Node_18", 24, 205)
	GUI:setChineseName(Node_18, "玩家装备_武器_位置")
	GUI:setTag(Node_18, 71)
	GUI:setVisible(Node_18, false)
	TAGOBJ["71"] = Node_18

	-- Create Panel_pos17
	local Panel_pos17 = GUI:Layout_Create(EquipUI, "Panel_pos17", 24, 160, 42, 42, false)
	GUI:setChineseName(Panel_pos17, "玩家装备_衣服_组合")
	GUI:setAnchorPoint(Panel_pos17, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos17, true)
	GUI:setTag(Panel_pos17, 69)
	GUI:setVisible(Panel_pos17, false)
	TAGOBJ["69"] = Panel_pos17

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos17, "PanelBg", 21, 21, "res/private/player_main_layer_ui/player_main_layer_ui_win32/icon_chenghd_03.png")
	GUI:setChineseName(PanelBg, "玩家装备_衣服_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 70)
	TAGOBJ["70"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos17, "DefaultIcon", 21, 21, "res/public/0.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_衣服_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 81)
	TAGOBJ["81"] = DefaultIcon

	-- Create Node_17
	local Node_17 = GUI:Node_Create(EquipUI, "Node_17", 24, 160)
	GUI:setChineseName(Node_17, "玩家装备_衣服_位置")
	GUI:setTag(Node_17, 71)
	GUI:setVisible(Node_17, false)
	TAGOBJ["71"] = Node_17

	ui.update(__data__)
	return EquipUI
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
