local NewPlayerGifeOBJ = {}
NewPlayerGifeOBJ.Name = "NewPlayerGifeOBJ"
NewPlayerGifeOBJ.RunAction = true

function NewPlayerGifeOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/NewPlayerGiftUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvent()
    self:ShowRewardData()
end

function NewPlayerGifeOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
end

function NewPlayerGifeOBJ:ShowRewardData()
    local reward1 = {"自动拾取", "自动回收", "自动货币", "自动经验"}
    local reward2 = {"仓库全开", "远程仓库", "二级背包", "行会大礼包"}
    local pos = {-105, -35, 35, 105}
    for i = 1, 4, 1 do
        local item1_name = reward1[i]
        local item_id1 = SL:Get_ITEM_INDEX_BY_NAME(item1_name)
        local item1 = GUI:ItemShow_Create(self.ui.Node_1, item_id1, pos[i], 0, {index = item_id1, look = true, bgVisible = true})
        GUI:setAnchorPoint(item1, 0.5, 0.5)

        local item2_name = reward2[i]
        local item_id2 = SL:Get_ITEM_INDEX_BY_NAME(item2_name)
        local item2 = GUI:ItemShow_Create(self.ui.Node_2, item_id2, pos[i], 0, {index = item_id2, look = true, bgVisible = true})
        GUI:setAnchorPoint(item2, 0.5, 0.5)
    end
end

return NewPlayerGifeOBJ