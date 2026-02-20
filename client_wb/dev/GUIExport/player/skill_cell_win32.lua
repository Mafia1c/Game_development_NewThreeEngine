local ui = {}
local _V = function(...) return SL:GetMetaValue(...) end
local FUNCQUEUE = {}
local TAGOBJ = {}

function ui.init(parent, __data__, __update__)
	if __update__ then return ui.update(__data__) end
	-- Create Node
	local Node = GUI:Node_Create(parent, "Node", 0, 0)
	GUI:setChineseName(Node, "玩家技能节点")
	GUI:setTag(Node, -1)

	-- Create Panel_skill_cell
	local Panel_skill_cell = GUI:Layout_Create(Node, "Panel_skill_cell", 0, 0, 272, 50, false)
	GUI:setChineseName(Panel_skill_cell, "玩家技能_组合")
	GUI:setAnchorPoint(Panel_skill_cell, 0.00, 0.00)
	GUI:setTouchEnabled(Panel_skill_cell, true)
	GUI:setTag(Panel_skill_cell, 14)
	TAGOBJ["14"] = Panel_skill_cell

	-- Create Image_3
	local Image_3 = GUI:Image_Create(Panel_skill_cell, "Image_3", 56, 24, "res/private/player_skill-win32/1900015023.png")
	GUI:Image_setScale9Slice(Image_3, 19, 19, 9, 9)
	GUI:setContentSize(Image_3, 210, 44)
	GUI:setIgnoreContentAdaptWithSize(Image_3, false)
	GUI:setChineseName(Image_3, "玩家技能_背景图")
	GUI:setAnchorPoint(Image_3, 0.00, 0.50)
	GUI:setTouchEnabled(Image_3, false)
	GUI:setTag(Image_3, 16)
	TAGOBJ["16"] = Image_3

	-- Create Image_icon
	local Image_icon = GUI:Image_Create(Panel_skill_cell, "Image_icon", 26, 25, "res/private/player_skill-win32/1900015022.png")
	GUI:setChineseName(Image_icon, "玩家技能_技能图标")
	GUI:setAnchorPoint(Image_icon, 0.50, 0.50)
	GUI:setTouchEnabled(Image_icon, false)
	GUI:setTag(Image_icon, 14)
	TAGOBJ["14"] = Image_icon

	-- Create Image_1
	local Image_1 = GUI:Image_Create(Panel_skill_cell, "Image_1", 136, 35, "res/private/player_skill-win32/1900015021.png")
	GUI:setChineseName(Image_1, "玩家技能_Lv图片")
	GUI:setAnchorPoint(Image_1, 0.00, 0.50)
	GUI:setTouchEnabled(Image_1, false)
	GUI:setTag(Image_1, 16)
	TAGOBJ["16"] = Image_1

	-- Create Image_2
	local Image_2 = GUI:Image_Create(Panel_skill_cell, "Image_2", 61, 15, "res/private/player_skill-win32/1900015020.png")
	GUI:setChineseName(Image_2, "玩家技能_Exp图片")
	GUI:setAnchorPoint(Image_2, 0.00, 0.50)
	GUI:setTouchEnabled(Image_2, false)
	GUI:setTag(Image_2, 17)
	TAGOBJ["17"] = Image_2

	-- Create Text_skillName
	local Text_skillName = GUI:Text_Create(Panel_skill_cell, "Text_skillName", 61, 35, 12, "#ffffff", [[技能名称]])
	GUI:Text_enableOutline(Text_skillName, "#111111", 1)
	GUI:setChineseName(Text_skillName, "玩家技能_技能名称_文本")
	GUI:setAnchorPoint(Text_skillName, 0.00, 0.50)
	GUI:setTouchEnabled(Text_skillName, false)
	GUI:setTag(Text_skillName, 18)
	TAGOBJ["18"] = Text_skillName

	-- Create Text_skillLevel
	local Text_skillLevel = GUI:Text_Create(Panel_skill_cell, "Text_skillLevel", 161, 35, 12, "#ffff0f", [[-]])
	GUI:Text_enableOutline(Text_skillLevel, "#111111", 1)
	GUI:setChineseName(Text_skillLevel, "玩家技能_技能等级")
	GUI:setAnchorPoint(Text_skillLevel, 0.00, 0.50)
	GUI:setTouchEnabled(Text_skillLevel, false)
	GUI:setTag(Text_skillLevel, 19)
	TAGOBJ["19"] = Text_skillLevel

	-- Create Text_skillTrain
	local Text_skillTrain = GUI:Text_Create(Panel_skill_cell, "Text_skillTrain", 96, 15, 12, "#ffffff", [[-]])
	GUI:Text_enableOutline(Text_skillTrain, "#000000", 1)
	GUI:setChineseName(Text_skillTrain, "玩家技能_技能经验_文本")
	GUI:setAnchorPoint(Text_skillTrain, 0.00, 0.50)
	GUI:setTouchEnabled(Text_skillTrain, false)
	GUI:setTag(Text_skillTrain, 20)
	TAGOBJ["20"] = Text_skillTrain

	-- Create Text_levelup
	local Text_levelup = GUI:Text_Create(Panel_skill_cell, "Text_levelup", 61, 15, 12, "#ffffff", [[强化-重]])
	GUI:Text_enableOutline(Text_levelup, "#111111", 1)
	GUI:setChineseName(Text_levelup, "玩家技能_强化等级")
	GUI:setAnchorPoint(Text_levelup, 0.00, 0.50)
	GUI:setTouchEnabled(Text_levelup, false)
	GUI:setTag(Text_levelup, 15)
	TAGOBJ["15"] = Text_levelup

	-- Create Image_key
	local Image_key = GUI:Image_Create(Panel_skill_cell, "Image_key", 261, 40, "res/private/player_skill-win32/word_anzi_1.png")
	GUI:setChineseName(Image_key, "玩家技能_快捷键")
	GUI:setAnchorPoint(Image_key, 1.00, 1.00)
	GUI:setTouchEnabled(Image_key, false)
	GUI:setTag(Image_key, 34)
	TAGOBJ["34"] = Image_key

	-- Create levelup_Icon
	local levelup_Icon = GUI:Image_Create(Panel_skill_cell, "levelup_Icon", 172, 5, "Default/Sprite.png")
	GUI:setContentSize(levelup_Icon, 40, 40)
	GUI:setIgnoreContentAdaptWithSize(levelup_Icon, false)
	GUI:setAnchorPoint(levelup_Icon, 0.00, 0.00)
	GUI:setTouchEnabled(levelup_Icon, false)
	GUI:setTag(levelup_Icon, 0)

	-- Create Text_level
	local Text_level = GUI:Text_Create(Panel_skill_cell, "Text_level", 192, 6, 12, "#ffff00", [[LV.1]])
	GUI:Text_enableOutline(Text_level, "#000000", 1)
	GUI:setAnchorPoint(Text_level, 0.50, 0.00)
	GUI:setTouchEnabled(Text_level, false)
	GUI:setTag(Text_level, 0)

	ui.update(__data__)
	return Node
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
