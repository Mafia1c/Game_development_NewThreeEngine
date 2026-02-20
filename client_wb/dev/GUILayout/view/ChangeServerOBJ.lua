local ChangeServerOBJ = {}
ChangeServerOBJ.Name = "ChangeServerOBJ"
ChangeServerOBJ.NpcId = 78
function ChangeServerOBJ:main(recharge_value,chang_server_data)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ChangeServerUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.recharge_value = tonumber(recharge_value) or 0
    self.chang_server_data = SL:JsonDecode(chang_server_data) or {}
    GUI:addOnClickEvent(self.ui.closeBtn,function ()
    	ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.chang_server_btn,function ()
    	SendMsgCallFunByNpc(0,"ChangeServer","OnClickChangeServer")
    end)
    GUI:addOnClickEvent(self.ui.get_btn,function ()
    	SendMsgCallFunByNpc(0,"ChangeServer","OnClickGet")
    end)

    self:UpdaViewInfo()
end

function ChangeServerOBJ:UpdaViewInfo()
	local all_recharge = self.chang_server_data.all_recharge or 0
	local dailingqu = self.chang_server_data.dailingqu or 0
	local yilingqu = self.chang_server_data.yilingqu or 0
	local residue_money_value = 0
	local can_get_money_value = 0
	if all_recharge > 0 then
		local value = (self.recharge_value > all_recharge) and all_recharge or self.recharge_value
		can_get_money_value = value - yilingqu
	end
	GUI:Text_setString(self.ui.change_server_money,self.recharge_value.."元")	
	GUI:Text_setString(self.ui.can_get_money,can_get_money_value.."元")	
	GUI:Text_setString(self.ui.residue_money,dailingqu.."元")	
end

function ChangeServerOBJ:flushView(chang_server_data)
	self.chang_server_data = SL:JsonDecode(chang_server_data) or {}
	self:UpdaViewInfo()
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if ChangeServerOBJ.NpcId == npc_info.index then
        SendMsgClickNpc(npc_info.index .. "#ChangeServer")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "ChangeServerOBJ", onClickNpc)

return ChangeServerOBJ