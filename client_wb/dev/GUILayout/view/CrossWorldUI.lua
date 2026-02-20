local CrossWorldUI = {}
CrossWorldUI.Name = "CrossWorldUI"
CrossWorldUI.RunAction = true

function CrossWorldUI:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/CrossWorldUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:flushView(sMsg)
end

function CrossWorldUI:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    for i = 1, 4 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            ViewMgr.open("SelectCrossWorldOBJ", i)
        end)
    end
end

function CrossWorldUI:flushView(sMsg)
    local tmp = SL:JsonDecode(sMsg, false)
    local merge_count = GameData.GetData("HeFuCount", false) or 0
    for i = 1, 4, 1 do
        local state = tmp[i] or 0
        local icon = self.ui["Image_"..i]
        local icon_path = "res/custom/npc/0kf/0.png"
        if state == 1 then
            icon_path = "res/custom/npc/0kf/1.png"
        end
        if merge_count <= 0 then
            icon_path = "res/custom/npc/0kf/00.png"
        end
        GUI:Image_loadTexture(icon, icon_path)
    end

    GUI:Button_setGrey(self.ui.Button_5, true)
    GUI:Button_setBrightEx(self.ui.Button_5, false)
end

return CrossWorldUI