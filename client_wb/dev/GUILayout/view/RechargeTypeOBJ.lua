local RechargeTypeOBJ = {}
RechargeTypeOBJ.Name = "RechargeTypeOBJ"
RechargeTypeOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
RechargeTypeOBJ.npcId = 0

function RechargeTypeOBJ:main(money)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/RechargeTypeUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshInfo(money)

    --背景关闭
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        SendMsgClickMainBtn("0#Recharge#cancelType")
        ViewMgr.close("RechargeTypeOBJ")
    end)
    --关闭按钮
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        SendMsgClickMainBtn("0#Recharge#cancelType")
        ViewMgr.close("RechargeTypeOBJ")
    end)
end

function RechargeTypeOBJ:refreshInfo(money)
    GUI:Text_setString(self.ui.numberText,"充值金额："..(money or 0).."元")
    GUI:UserUILayout(self.ui.typeNode, {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["typeBtn"..i],function ()
            SendMsgClickMainBtn("0#Recharge#confirmType#"..i)
        end)
    end
end


return RechargeTypeOBJ