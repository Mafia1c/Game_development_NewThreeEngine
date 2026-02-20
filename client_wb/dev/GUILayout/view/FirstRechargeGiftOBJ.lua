local FirstRechargeGiftOBJ = {}
FirstRechargeGiftOBJ.Name = "FirstRechargeGiftOBJ"
FirstRechargeGiftOBJ.RunAction = true

function FirstRechargeGiftOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/FirstRechargeGiftUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    local job = SL:Get_JOB()
    self.cfg1 = {
        {"魅影之刃",1},
        {"龙魂盾",1},
        {"吸星大法",1},
        {"三级背包",1},
    }
    local skill_book = {"开天斩", 1}
    if job == 1 then
        skill_book = {"流星火雨", 1}
    elseif job == 2 then
        skill_book = {"召唤月灵", 1}
    end

    self.cfg1[5]=skill_book
    GUI:removeAllChildren(self.ui.ItemNode_1)
    
    self:initClickEvent()
    self:ShowUIInfo()
    self:flushView(sMsg)
end

function FirstRechargeGiftOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.getGiftBtn, function()
        SendMsgClickMainBtn("0#FirstRechargeGift#getFirstRechargeGift")
    end)
end

function FirstRechargeGiftOBJ:ShowUIInfo()
    local item_cell1 = {}
    for index, info in ipairs(self.cfg1) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(info[1]) or index
        local item = GUI:ItemShow_Create(self.ui.ItemNode_1, item_id, 0, 0, {index = item_id, look = true, bgVisible = true, count = info[2]})
        if item then
            GUI:setAnchorPoint(item, 0.5, 0.5)
            ItemShow_updateItem(item, {showCount = true, count = info[2], color = 255})
            item_cell1[#item_cell1 + 1] = item
        end
    end
    arrangeNodesFromCenter(item_cell1, 0, 0, 70, 60)
end

function FirstRechargeGiftOBJ:flushView(sMsg)
    sMsg = tonumber(sMsg) or 0
    GUI:setVisible(self.ui.getGiftBtn, sMsg == 0)
    GUI:setVisible(self.ui.Image_2, sMsg ~= 0)
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "FirstRechargeGiftOBJ",["node"] = self,["is_all"] = true})
end

function FirstRechargeGiftOBJ:onClose()

end

return FirstRechargeGiftOBJ