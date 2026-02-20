local CommonTipsObj = {}
CommonTipsObj.Name = "CommonTipsObj"

function CommonTipsObj:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/CommonTipsUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvents()
end

function CommonTipsObj:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("CommonTipsObj")
    end)

    GUI:addOnClickEvent(self.ui.noBtn, function()
        ViewMgr.close("CommonTipsObj")
    end)

    GUI:addOnClickEvent(self.ui.okBtn, function()
        ViewMgr.close("CommonTipsObj")
        -- 打开盟重令UI
    end)
end

return CommonTipsObj