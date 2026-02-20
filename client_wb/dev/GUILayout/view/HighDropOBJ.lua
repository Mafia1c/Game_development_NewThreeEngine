local HighDropOBJ = {}
HighDropOBJ.Name = "HighDropOBJ"
HighDropOBJ.RunAction = true
HighDropOBJ.cfg = GetConfig("HighDropCfg")

function HighDropOBJ:main(item_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/HighDropUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.item_id = item_id

    GUI:addOnClickEvent(self.ui.closeBtn,function ()
        ViewMgr.close("HighDropOBJ")
    end)

    GUI:addOnClickEvent(self.ui["Button_1"],function ()
        SendMsgCallFunByNpc(0,"HighDrop","EnterHigtDrop", self.item_id)
    end)
    self:UpdateUIShow()
end

function HighDropOBJ:UpdateUIShow()
    local name = SL:Get_ITEM_NAME(tonumber(self.item_id))
    name = string.gsub(name, "卷", "")
    GUI:Button_setTitleText(self.ui["Button_1"], name)
end

return HighDropOBJ