local BerserkerPowerOBJ = {}
BerserkerPowerOBJ.Name = "BerserkerPowerOBJ"
BerserkerPowerOBJ.RunAction = true

function BerserkerPowerOBJ:main(killNum, auto, state)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/BerserkerPowerUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    auto = tonumber(auto)
    state = tonumber(state) or 0

    self:initClickEvents()

    GUI:Text_setString(self.ui.levelTxt,  killNum or 0)
    GUI:CheckBox_setSelected(self.ui.CheckBox_1, auto == 1)
    GUI:Image_loadTexture(self.ui.Image_1, state > 0 and "res/custom/tag/y_104.png" or "res/custom/tag/y_102.png")
end

function BerserkerPowerOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("BerserkerPowerOBJ")
    end)

    GUI:addOnClickEvent(self.ui.enterMapBtn, function()
        SendMsgClickMainBtn("0#BerserkerPower#onEnterRampageMap")
    end)

    GUI:addOnClickEvent(self.ui.openBtn_1, function()
        SendMsgClickMainBtn("0#BerserkerPower#onOpenRampage#1")
    end)

    GUI:addOnClickEvent(self.ui.openBtn_2, function()
        SendMsgClickMainBtn("0#BerserkerPower#onOpenRampage#2")
    end)

    GUI:CheckBox_addOnEvent(self.ui.CheckBox_1, function()
        local state = GUI:CheckBox_isSelected(self.ui.CheckBox_1)
        SendMsgClickMainBtn("0#BerserkerPower#onChangeAutoOpen#" .. (state and 1 or 0))
    end)
end

function BerserkerPowerOBJ:flushView()
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "BerserkerPowerOBJ",["node"] = self,["is_all"] = true})
end

return BerserkerPowerOBJ