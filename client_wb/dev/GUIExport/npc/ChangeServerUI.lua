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
	GUI:setAnchorPoint(CloseLayout, 0.00, 0.00)
	GUI:setTouchEnabled(CloseLayout, true)
	GUI:setTag(CloseLayout, -1)

	-- Create FrameLayout
	local FrameLayout = GUI:Layout_Create(parent, "FrameLayout", 570, 334, 846, 566, false)
	GUI:setAnchorPoint(FrameLayout, 0.50, 0.50)
	GUI:setTouchEnabled(FrameLayout, true)
	GUI:setMouseEnabled(FrameLayout, true)
	GUI:setTag(FrameLayout, -1)

	-- Create FrameBG
	local FrameBG = GUI:Image_Create(FrameLayout, "FrameBG", 0, 0, "res/custom/npc/0zhuanqu/bg.png")
	GUI:setAnchorPoint(FrameBG, 0.00, 0.00)
	GUI:setTouchEnabled(FrameBG, true)
	GUI:setMouseEnabled(FrameBG, true)
	GUI:setTag(FrameBG, -1)

	-- Create closeBtn
	local closeBtn = GUI:Button_Create(FrameLayout, "closeBtn", 802, 511, "res/custom/npc/close1.png")
	GUI:Button_loadTexturePressed(closeBtn, "res/custom/npc/close2.png")
	GUI:Button_setTitleText(closeBtn, [[]])
	GUI:Button_setTitleColor(closeBtn, "#ffffff")
	GUI:Button_setTitleFontSize(closeBtn, 10)
	GUI:Button_titleEnableOutline(closeBtn, "#000000", 1)
	GUI:setAnchorPoint(closeBtn, 0.50, 0.50)
	GUI:setTouchEnabled(closeBtn, true)
	GUI:setTag(closeBtn, -1)

	-- Create RichText_1
	local RichText_1 = GUI:RichText_Create(FrameLayout, "RichText_1", 170, 404, [[<font color='#00ff00' size='16' >真实充值达到500元，即可自主转入任意新区，可分批领取，最低100起领！</font><br><font color='#00ff00' size='16' >转区后当前角色将</font><font color='#ff0000' size='16' >【永久封禁】</font><font color='#00ff00' size='16' >玩家可以前往新区充值，并领取对应的转</font><br><font color='#00ff00' size='16' >区额度！</font><font color='#ffff00' size='16' >领取转区金额后，如想继续转区需补齐500可转金额！</font>]], 620, 18, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_1, 0.00, 0.00)
	GUI:setTag(RichText_1, 0)

	-- Create Text_1
	local Text_1 = GUI:Text_Create(FrameLayout, "Text_1", 87, 449, 16, "#ff9b00", [[转区规则：]])
	GUI:Text_disableOutLine(Text_1)
	GUI:setAnchorPoint(Text_1, 0.00, 0.00)
	GUI:setTouchEnabled(Text_1, false)
	GUI:setTag(Text_1, 0)

	-- Create Text_2
	local Text_2 = GUI:Text_Create(FrameLayout, "Text_2", 87, 350, 16, "#ff9b00", [[转区说明：]])
	GUI:Text_disableOutLine(Text_2)
	GUI:setAnchorPoint(Text_2, 0.00, 0.00)
	GUI:setTouchEnabled(Text_2, false)
	GUI:setTag(Text_2, 0)

	-- Create RichText_2
	local RichText_2 = GUI:RichText_Create(FrameLayout, "RichText_2", 170, 230, [[<font color='#ffffff' size='16' >转区成功后，请前往</font><font color='#ff0000' size='16' >【当前已正式开放】</font><font color='#ffffff' size='16' >的新区，使用相同账号注册角色进行领取</font><br><font color='#ffffff' size='16' >转区额度只能在一个角色数据上领取，不可分多个角色领取转区金额！</font><br><font color='#ffffff' size='16' >新区充值多少金额，可分批次领取多少转区额度</font><font color='#ff0000' size='16' >（领取额度不能超过转区金额）</font><br><font color='#ffffff' size='16' >转区成功后，前往新区可领取转区金额的充值货币</font><font color='#ff0000' size='16' >（转区金额不计算真实充值总数）</font><br><font color='#ffff00' size='16' >请注意：转区金额必须合区之前领取完，合区后将无法领取转区额度！</font><br><font color='#f300f3' size='16' >如实在看不懂上面的转区规则，请联系游戏客服进行详细了解</font>]], 620, 16, "#ffffff", 4)
	GUI:setAnchorPoint(RichText_2, 0.00, 0.00)
	GUI:setTag(RichText_2, 0)

	-- Create chang_server_btn
	local chang_server_btn = GUI:Button_Create(FrameLayout, "chang_server_btn", 596, 131, "res/custom/npc/0zhuanqu/btn11.png")
	GUI:Button_loadTexturePressed(chang_server_btn, "res/custom/npc/0zhuanqu/btn12.png")
	GUI:Button_setTitleText(chang_server_btn, [[]])
	GUI:Button_setTitleColor(chang_server_btn, "#ffffff")
	GUI:Button_setTitleFontSize(chang_server_btn, 16)
	GUI:Button_titleDisableOutLine(chang_server_btn)
	GUI:setAnchorPoint(chang_server_btn, 0.00, 0.00)
	GUI:setTouchEnabled(chang_server_btn, true)
	GUI:setTag(chang_server_btn, 0)

	-- Create get_btn
	local get_btn = GUI:Button_Create(FrameLayout, "get_btn", 597, 73, "res/custom/npc/0zhuanqu/btn21.png")
	GUI:Button_loadTexturePressed(get_btn, "res/custom/npc/0zhuanqu/btn22.png")
	GUI:Button_setTitleText(get_btn, [[]])
	GUI:Button_setTitleColor(get_btn, "#ffffff")
	GUI:Button_setTitleFontSize(get_btn, 16)
	GUI:Button_titleDisableOutLine(get_btn)
	GUI:setAnchorPoint(get_btn, 0.00, 0.00)
	GUI:setTouchEnabled(get_btn, true)
	GUI:setTag(get_btn, 0)

	-- Create change_server_money
	local change_server_money = GUI:Text_Create(FrameLayout, "change_server_money", 290, 152, 18, "#ff0000", [[100000000元]])
	GUI:Text_enableOutline(change_server_money, "#000000", 1)
	GUI:setAnchorPoint(change_server_money, 0.00, 0.00)
	GUI:setTouchEnabled(change_server_money, false)
	GUI:setTag(change_server_money, 0)

	-- Create can_get_money
	local can_get_money = GUI:Text_Create(FrameLayout, "can_get_money", 290, 111, 18, "#ff00ff", [[0元]])
	GUI:Text_enableOutline(can_get_money, "#000000", 1)
	GUI:setAnchorPoint(can_get_money, 0.00, 0.00)
	GUI:setTouchEnabled(can_get_money, false)
	GUI:setTag(can_get_money, 0)

	-- Create residue_money
	local residue_money = GUI:Text_Create(FrameLayout, "residue_money", 290, 70, 18, "#00ff00", [[0元]])
	GUI:Text_enableOutline(residue_money, "#000000", 1)
	GUI:setAnchorPoint(residue_money, 0.00, 0.00)
	GUI:setTouchEnabled(residue_money, false)
	GUI:setTag(residue_money, 0)

	ui.update(__data__)
	return CloseLayout
end

function ui.update(data)
	for _, func in pairs(FUNCQUEUE) do
		if func then func(data) end
	end
end

return ui
