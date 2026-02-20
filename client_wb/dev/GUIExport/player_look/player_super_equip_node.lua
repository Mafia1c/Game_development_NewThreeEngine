local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create EquipUI
	local EquipUI = GUI:Layout_Create(parent, "EquipUI", 0, 0, 348, 478, false)
	GUI:setChineseName(EquipUI, "玩家时装_组合")
	GUI:setAnchorPoint(EquipUI, 0.00, 0.00)
	GUI:setTouchEnabled(EquipUI, false)
	GUI:setTag(EquipUI, 31)
	TAGOBJ["31"] = EquipUI

	-- Create BG
	local BG = GUI:Image_Create(EquipUI, "BG", 174, 239, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/bg_juese_02.png")
	GUI:setChineseName(BG, "玩家时装_背景图")
	GUI:setAnchorPoint(BG, 0.50, 0.50)
	GUI:setTouchEnabled(BG, false)
	GUI:setTag(BG, 213)
	TAGOBJ["213"] = BG

	-- Create Panel_posEx17
	local Panel_posEx17 = GUI:Layout_Create(EquipUI, "Panel_posEx17", 174, 197, 180, 240, false)
	GUI:setChineseName(Panel_posEx17, "玩家时装_衣服位置")
	GUI:setAnchorPoint(Panel_posEx17, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_posEx17, true)
	GUI:setTag(Panel_posEx17, 32)
	TAGOBJ["32"] = Panel_posEx17

	-- Create Panel_pos45
	local Panel_pos45 = GUI:Layout_Create(EquipUI, "Panel_pos45", 175, 230, 187, 238, false)
	GUI:setChineseName(Panel_pos45, "玩家时装_盾牌位置")
	GUI:setAnchorPoint(Panel_pos45, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos45, true)
	GUI:setTag(Panel_pos45, 82)
	TAGOBJ["82"] = Panel_pos45

	-- Create Panel_posEx18
	local Panel_posEx18 = GUI:Layout_Create(EquipUI, "Panel_posEx18", 67, 306, 120, 206, false)
	GUI:setChineseName(Panel_posEx18, "玩家时装_武器位置")
	GUI:setAnchorPoint(Panel_posEx18, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_posEx18, true)
	GUI:setTag(Panel_posEx18, 31)
	TAGOBJ["31"] = Panel_posEx18

	-- Create Panel_pos19
	local Panel_pos19 = GUI:Layout_Create(EquipUI, "Panel_pos19", 174, 322, 50, 50, false)
	GUI:setChineseName(Panel_pos19, "玩家时装_斗笠位置")
	GUI:setAnchorPoint(Panel_pos19, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos19, true)
	GUI:setTag(Panel_pos19, 33)
	TAGOBJ["33"] = Panel_pos19

	-- Create PanelBg
	local PanelBg = GUI:Image_Create(Panel_pos19, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_斗笠_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 50)
	GUI:setVisible(PanelBg, false)
	TAGOBJ["50"] = PanelBg

	-- Create DefaultIcon
	local DefaultIcon = GUI:Image_Create(Panel_pos19, "DefaultIcon", 25, 25, "res/private/gui_edit/ImageFile.png")
	GUI:setContentSize(DefaultIcon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_斗笠_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 72)
	GUI:setVisible(DefaultIcon, false)
	TAGOBJ["72"] = DefaultIcon

	-- Create Panel_pos21
	local Panel_pos21 = GUI:Layout_Create(EquipUI, "Panel_pos21", 174, 322, 50, 50, false)
	GUI:setChineseName(Panel_pos21, "玩家时装_头盔位置")
	GUI:setAnchorPoint(Panel_pos21, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos21, true)
	GUI:setTag(Panel_pos21, 33)
	TAGOBJ["33"] = Panel_pos21

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos21, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_头盔_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 50)
	GUI:setVisible(PanelBg, false)
	TAGOBJ["50"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos21, "DefaultIcon", 25, 25, "res/private/gui_edit/ImageFile.png")
	GUI:setContentSize(DefaultIcon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_头盔_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 72)
	GUI:setVisible(DefaultIcon, false)
	TAGOBJ["72"] = DefaultIcon

	-- Create Node_playerModel
	local Node_playerModel = GUI:Node_Create(EquipUI, "Node_playerModel", 175, 222)
	GUI:setChineseName(Node_playerModel, "玩家时装_裸模位置")
	GUI:setTag(Node_playerModel, 48)
	TAGOBJ["48"] = Node_playerModel

	-- Create Panel_pos23
	local Panel_pos23 = GUI:Layout_Create(EquipUI, "Panel_pos23", 36, 156, 51, 51, false)
	GUI:setChineseName(Panel_pos23, "玩家时装_右手镯组合")
	GUI:setAnchorPoint(Panel_pos23, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos23, true)
	GUI:setTag(Panel_pos23, 34)
	TAGOBJ["34"] = Panel_pos23

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos23, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_右手镯_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 50)
	TAGOBJ["50"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos23, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015034.png")
	GUI:setContentSize(DefaultIcon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_右手镯_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 72)
	TAGOBJ["72"] = DefaultIcon

	-- Create Panel_pos25
	local Panel_pos25 = GUI:Layout_Create(EquipUI, "Panel_pos25", 36, 95, 51, 51, false)
	GUI:setChineseName(Panel_pos25, "玩家时装_右戒指组合")
	GUI:setAnchorPoint(Panel_pos25, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos25, true)
	GUI:setTag(Panel_pos25, 39)
	TAGOBJ["39"] = Panel_pos25

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos25, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_右戒指_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 49)
	TAGOBJ["49"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos25, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015035.png")
	GUI:setContentSize(DefaultIcon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_右戒指_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 73)
	TAGOBJ["73"] = DefaultIcon

	-- Create Panel_pos24
	local Panel_pos24 = GUI:Layout_Create(EquipUI, "Panel_pos24", 314, 95, 51, 51, false)
	GUI:setChineseName(Panel_pos24, "玩家时装_左戒指_组合")
	GUI:setAnchorPoint(Panel_pos24, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos24, true)
	GUI:setTag(Panel_pos24, 40)
	TAGOBJ["40"] = Panel_pos24

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos24, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_左戒指_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 48)
	TAGOBJ["48"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos24, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015035.png")
	GUI:setContentSize(DefaultIcon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_左戒指_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 74)
	TAGOBJ["74"] = DefaultIcon

	-- Create Panel_pos22
	local Panel_pos22 = GUI:Layout_Create(EquipUI, "Panel_pos22", 314, 156, 51, 51, false)
	GUI:setChineseName(Panel_pos22, "玩家时装_左手镯_组合")
	GUI:setAnchorPoint(Panel_pos22, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos22, true)
	GUI:setTag(Panel_pos22, 41)
	TAGOBJ["41"] = Panel_pos22

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos22, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_左手镯_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 46)
	TAGOBJ["46"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos22, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015034.png")
	GUI:setContentSize(DefaultIcon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_左手镯_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 75)
	TAGOBJ["75"] = DefaultIcon

	-- Create Panel_pos26
	local Panel_pos26 = GUI:Layout_Create(EquipUI, "Panel_pos26", 314, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos26, "玩家时装_勋章_组合")
	GUI:setAnchorPoint(Panel_pos26, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos26, true)
	GUI:setTag(Panel_pos26, 42)
	TAGOBJ["42"] = Panel_pos26

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos26, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_勋章_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 45)
	TAGOBJ["45"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos26, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015033.png")
	GUI:setContentSize(DefaultIcon, 47, 43)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_勋章_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 76)
	TAGOBJ["76"] = DefaultIcon

	-- Create Panel_pos20
	local Panel_pos20 = GUI:Layout_Create(EquipUI, "Panel_pos20", 314, 216, 51, 51, false)
	GUI:setChineseName(Panel_pos20, "玩家时装_项链_组合")
	GUI:setAnchorPoint(Panel_pos20, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos20, true)
	GUI:setTag(Panel_pos20, 43)
	TAGOBJ["43"] = Panel_pos20

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos20, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_项链_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 44)
	TAGOBJ["44"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos20, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015032.png")
	GUI:setContentSize(DefaultIcon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_项链_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 77)
	TAGOBJ["77"] = DefaultIcon

	-- Create Panel_pos44
	local Panel_pos44 = GUI:Layout_Create(EquipUI, "Panel_pos44", 36, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos44, "玩家时装_战鼓_组合")
	GUI:setAnchorPoint(Panel_pos44, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos44, true)
	GUI:setTag(Panel_pos44, 179)
	TAGOBJ["179"] = Panel_pos44

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos44, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_战鼓_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 180)
	TAGOBJ["180"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos44, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015040.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_战鼓_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 181)
	TAGOBJ["181"] = DefaultIcon

	-- Create Panel_pos42
	local Panel_pos42 = GUI:Layout_Create(EquipUI, "Panel_pos42", 314, 277, 51, 51, false)
	GUI:setChineseName(Panel_pos42, "玩家时装_坐骑_组合")
	GUI:setAnchorPoint(Panel_pos42, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos42, true)
	GUI:setTag(Panel_pos42, 175)
	TAGOBJ["175"] = Panel_pos42

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos42, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_坐骑_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 176)
	TAGOBJ["176"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos42, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015041.png")
	GUI:setChineseName(DefaultIcon, "玩家时装_坐骑_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 177)
	TAGOBJ["177"] = DefaultIcon

	-- Create Panel_pos29
	local Panel_pos29 = GUI:Layout_Create(EquipUI, "Panel_pos29", 242, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos29, "玩家时装_魔血石_组合")
	GUI:setAnchorPoint(Panel_pos29, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos29, true)
	GUI:setTag(Panel_pos29, 60)
	TAGOBJ["60"] = Panel_pos29

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos29, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_魔血石_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 61)
	TAGOBJ["61"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos29, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015039.png")
	GUI:setContentSize(DefaultIcon, 47, 43)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_魔血石_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 78)
	TAGOBJ["78"] = DefaultIcon

	-- Create Panel_pos28
	local Panel_pos28 = GUI:Layout_Create(EquipUI, "Panel_pos28", 172, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos28, "玩家时装_靴子_组合")
	GUI:setAnchorPoint(Panel_pos28, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos28, true)
	GUI:setTag(Panel_pos28, 63)
	TAGOBJ["63"] = Panel_pos28

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos28, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_靴子_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 64)
	TAGOBJ["64"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos28, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015037.png")
	GUI:setContentSize(DefaultIcon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_靴子_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 79)
	TAGOBJ["79"] = DefaultIcon

	-- Create Panel_pos27
	local Panel_pos27 = GUI:Layout_Create(EquipUI, "Panel_pos27", 103, 35, 51, 51, false)
	GUI:setChineseName(Panel_pos27, "玩家时装_腰带_组合")
	GUI:setAnchorPoint(Panel_pos27, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos27, true)
	GUI:setTag(Panel_pos27, 66)
	TAGOBJ["66"] = Panel_pos27

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos27, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_腰带_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 67)
	TAGOBJ["67"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos27, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015038.png")
	GUI:setContentSize(DefaultIcon, 47, 37)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_腰带_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 80)
	TAGOBJ["80"] = DefaultIcon

	-- Create Panel_pos43
	local Panel_pos43 = GUI:Layout_Create(EquipUI, "Panel_pos43", 36, 217, 51, 51, false)
	GUI:setChineseName(Panel_pos43, "玩家时装_护身符_组合")
	GUI:setAnchorPoint(Panel_pos43, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos43, true)
	GUI:setTag(Panel_pos43, 69)
	TAGOBJ["69"] = Panel_pos43

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos43, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家时装_护身符_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 70)
	TAGOBJ["70"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos43, "DefaultIcon", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/1900015036.png")
	GUI:setContentSize(DefaultIcon, 47, 43)
	GUI:setIgnoreContentAdaptWithSize(DefaultIcon, false)
	GUI:setChineseName(DefaultIcon, "玩家时装_护身符_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 81)
	TAGOBJ["81"] = DefaultIcon

	-- Create Node_19
	local Node_19 = GUI:Node_Create(EquipUI, "Node_19", 174, 324)
	GUI:setTag(Node_19, 51)
	TAGOBJ["51"] = Node_19

	-- Create Node_21
	local Node_21 = GUI:Node_Create(EquipUI, "Node_21", 174, 324)
	GUI:setTag(Node_21, 51)
	TAGOBJ["51"] = Node_21

	-- Create Node_23
	local Node_23 = GUI:Node_Create(EquipUI, "Node_23", 36, 156)
	GUI:setChineseName(Node_23, "玩家时装_右手镯_位置")
	GUI:setTag(Node_23, 51)
	TAGOBJ["51"] = Node_23

	-- Create Node_25
	local Node_25 = GUI:Node_Create(EquipUI, "Node_25", 36, 95)
	GUI:setChineseName(Node_25, "玩家时装_右戒指_位置")
	GUI:setTag(Node_25, 52)
	TAGOBJ["52"] = Node_25

	-- Create Node_24
	local Node_24 = GUI:Node_Create(EquipUI, "Node_24", 314, 95)
	GUI:setChineseName(Node_24, "玩家时装_左戒指_位置")
	GUI:setTag(Node_24, 53)
	TAGOBJ["53"] = Node_24

	-- Create Node_22
	local Node_22 = GUI:Node_Create(EquipUI, "Node_22", 314, 156)
	GUI:setChineseName(Node_22, "玩家时装_左手镯_位置")
	GUI:setTag(Node_22, 54)
	TAGOBJ["54"] = Node_22

	-- Create Node_26
	local Node_26 = GUI:Node_Create(EquipUI, "Node_26", 314, 35)
	GUI:setChineseName(Node_26, "玩家时装_勋章_位置")
	GUI:setTag(Node_26, 55)
	TAGOBJ["55"] = Node_26

	-- Create Node_20
	local Node_20 = GUI:Node_Create(EquipUI, "Node_20", 314, 216)
	GUI:setChineseName(Node_20, "玩家时装_项链_位置")
	GUI:setTag(Node_20, 56)
	TAGOBJ["56"] = Node_20

	-- Create Node_44
	local Node_44 = GUI:Node_Create(EquipUI, "Node_44", 36, 35)
	GUI:setChineseName(Node_44, "玩家时装_战鼓_位置")
	GUI:setTag(Node_44, 182)
	TAGOBJ["182"] = Node_44

	-- Create Node_42
	local Node_42 = GUI:Node_Create(EquipUI, "Node_42", 314, 277)
	GUI:setChineseName(Node_42, "玩家时装_坐骑_位置")
	GUI:setTag(Node_42, 178)
	TAGOBJ["178"] = Node_42

	-- Create Node_29
	local Node_29 = GUI:Node_Create(EquipUI, "Node_29", 242, 35)
	GUI:setChineseName(Node_29, "玩家时装_魔血石_位置")
	GUI:setTag(Node_29, 62)
	TAGOBJ["62"] = Node_29

	-- Create Node_28
	local Node_28 = GUI:Node_Create(EquipUI, "Node_28", 172, 35)
	GUI:setChineseName(Node_28, "玩家时装_靴子_位置")
	GUI:setTag(Node_28, 65)
	TAGOBJ["65"] = Node_28

	-- Create Node_27
	local Node_27 = GUI:Node_Create(EquipUI, "Node_27", 103, 35)
	GUI:setChineseName(Node_27, "玩家时装_腰带_位置")
	GUI:setTag(Node_27, 68)
	TAGOBJ["68"] = Node_27

	-- Create Node_43
	local Node_43 = GUI:Node_Create(EquipUI, "Node_43", 36, 217)
	GUI:setChineseName(Node_43, "玩家时装_护身符_位置")
	GUI:setTag(Node_43, 71)
	TAGOBJ["71"] = Node_43

	-- Create Panel_pos18
	local Panel_pos18 = GUI:Layout_Create(EquipUI, "Panel_pos18", 36, 277, 51, 51, false)
	GUI:setChineseName(Panel_pos18, "玩家装备_武器_组合")
	GUI:setAnchorPoint(Panel_pos18, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos18, true)
	GUI:setTag(Panel_pos18, 69)
	GUI:setVisible(Panel_pos18, false)
	TAGOBJ["69"] = Panel_pos18

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos18, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家装备_武器_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 70)
	TAGOBJ["70"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos18, "DefaultIcon", 25, 25, "res/public/0.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_武器_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 81)
	TAGOBJ["81"] = DefaultIcon

	-- Create Node_18
	local Node_18 = GUI:Node_Create(EquipUI, "Node_18", 36, 277)
	GUI:setChineseName(Node_18, "玩家装备_武器_位置")
	GUI:setTag(Node_18, 71)
	GUI:setVisible(Node_18, false)
	TAGOBJ["71"] = Node_18

	-- Create Panel_pos17
	local Panel_pos17 = GUI:Layout_Create(EquipUI, "Panel_pos17", 36, 216, 51, 51, false)
	GUI:setChineseName(Panel_pos17, "玩家装备_衣服_组合")
	GUI:setAnchorPoint(Panel_pos17, 0.50, 0.50)
	GUI:setTouchEnabled(Panel_pos17, true)
	GUI:setTag(Panel_pos17, 69)
	GUI:setVisible(Panel_pos17, false)
	TAGOBJ["69"] = Panel_pos17

	-- Create PanelBg
	PanelBg = GUI:Image_Create(Panel_pos17, "PanelBg", 25, 25, "res/private/player_main_layer_ui/player_main_layer_ui_mobile/icon_chenghd_03.png")
	GUI:Image_setScale9Slice(PanelBg, 17, 17, 16, 14)
	GUI:setContentSize(PanelBg, 52, 52)
	GUI:setIgnoreContentAdaptWithSize(PanelBg, false)
	GUI:setChineseName(PanelBg, "玩家装备_衣服_物品框")
	GUI:setAnchorPoint(PanelBg, 0.50, 0.50)
	GUI:setTouchEnabled(PanelBg, false)
	GUI:setTag(PanelBg, 70)
	TAGOBJ["70"] = PanelBg

	-- Create DefaultIcon
	DefaultIcon = GUI:Image_Create(Panel_pos17, "DefaultIcon", 25, 25, "res/public/0.png")
	GUI:setChineseName(DefaultIcon, "玩家装备_衣服_图标")
	GUI:setAnchorPoint(DefaultIcon, 0.50, 0.50)
	GUI:setTouchEnabled(DefaultIcon, false)
	GUI:setTag(DefaultIcon, 81)
	TAGOBJ["81"] = DefaultIcon

	-- Create Node_17
	local Node_17 = GUI:Node_Create(EquipUI, "Node_17", 36, 216)
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
