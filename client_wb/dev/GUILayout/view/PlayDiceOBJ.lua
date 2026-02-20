local PlayDiceOBJ = {}
PlayDiceOBJ.Name = "PlayDiceOBJ"
PlayDiceOBJ.cfg = GetConfig("LoftPavilionCfg")
PlayDiceOBJ.RunAction = true

function PlayDiceOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/PlayDiceUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_select_index = nil

    self:initClickEvents()
    self:updateSelectInfo()
end

function PlayDiceOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("PlayDiceOBJ")
    end)
    for i = 1, 6, 1 do
        GUI:addOnClickEvent(self.ui["dice_"..i], function()
            self.cur_select_index = i
            self:updateSelectInfo()
        end)
    end

    GUI:addOnClickEvent(self.ui.playBtn, function()
        if nil == self.cur_select_index then
            return
        end
        SendMsgCallFunByNpc(40, "LoftPavilionNpc", "PlayDice", self.cur_select_index)
        ViewMgr.close("PlayDiceOBJ")
    end)
end

function PlayDiceOBJ:updateSelectInfo()
    local index = self.cur_select_index
    if index then
        local pos = GUI:getPosition(self.ui["dice_"..index])
        GUI:setPosition(self.ui.Effect_1, pos.x, pos.y)
    end
    GUI:setVisible(self.ui.Effect_1, nil ~= index)
end

return PlayDiceOBJ