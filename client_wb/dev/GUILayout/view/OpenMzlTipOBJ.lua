local OpenMzlTipOBJ = {}
OpenMzlTipOBJ.Name = "OpenMzlTipOBJ"

function OpenMzlTipOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/OpenMzlTipUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvents()
end

function OpenMzlTipOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("OpenMzlTipOBJ")
    end)

    GUI:addOnClickEvent(self.ui.noBtn, function()
        ViewMgr.close("OpenMzlTipOBJ")
    end)

    GUI:addOnClickEvent(self.ui.okBtn, function()
        ViewMgr.close("OpenMzlTipOBJ")
        ViewMgr.close("MapCruiseOBJ") 
        -- 打开盟重令UI
         SendMsgClickMainBtn("0#MainTopBtn#AllianceOrder")
    end)
end

return OpenMzlTipOBJ