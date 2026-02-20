local FengMoJieJieOBJ = {}
FengMoJieJieOBJ.Name = "FengMoJieJieOBJ"
FengMoJieJieOBJ.RunAction = true
FengMoJieJieOBJ.NpcId = {34}

function FengMoJieJieOBJ:main(sMsg, sMsg2, sMsg3)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/FengMoJieJieUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.show_reward = true

    self:initClickEvents()
    self:updateNodeShow()
    self:ShowUIData()
    self:updateUiState(sMsg, sMsg2, sMsg3)
end

function FengMoJieJieOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("FengMoJieJieOBJ")
    end)

    GUI:addOnClickEvent(self.ui.exchangeBtn, function()
        self.show_reward = not self.show_reward
        self:updateNodeShow()
    end)

    GUI:addOnClickEvent(self.ui.enterBtn_1, function()
        SendMsgCallFunByNpc(34, "FengMoJieJieNpc", "onMapMove", 1)
    end)
    GUI:addOnClickEvent(self.ui.enterBtn_2, function()
        SendMsgCallFunByNpc(34, "FengMoJieJieNpc", "onMapMove", 2)
    end)
    GUI:addOnClickEvent(self.ui.enterBtn_3, function()
        SendMsgCallFunByNpc(34, "FengMoJieJieNpc", "onLaunchItem", 2)
    end)

    for i = 1, 3, 1 do
        GUI:addOnClickEvent(self.ui["getBtn_"..i], function()
            SendMsgCallFunByNpc(34, "FengMoJieJieNpc", "onGetReward", i)
        end)
        GUI:addOnClickEvent(self.ui["exchangeBtn_"..i], function()
            SendMsgCallFunByNpc(34, "FengMoJieJieNpc", "onExchangeItem", i)
        end)
    end
end

function FengMoJieJieOBJ:ShowUIData()
    local reward_items = {
        {"黄金钥匙", 1},
        {"黄金钥匙", 1},
        {"黄金钥匙", 1}
    }
    for index, v in ipairs(reward_items) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(v[1])
        ItemShow_updateItem(self.ui["ItemShow_"..index], {index = item_id, look = true, bgVisible = true, showCount = true, count = v[2], color = 250})
    end

    local exchange_items = {
        "永夜先驱者(称号)",
        "[坐骑激活卡]武圣将军",
        "[时装激活卡]魔王撒旦"
    }
    for index, v in ipairs(exchange_items) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(v)
        ItemShow_updateItem(self.ui["ExShow_"..index], {index = item_id, look = true, bgVisible = true, showCount = true, count = 1, color = 250})
    end
end

function FengMoJieJieOBJ:updateNodeShow()
    GUI:setVisible(self.ui.rewardNode, self.show_reward)
    GUI:setVisible(self.ui.exchangeNode, not self.show_reward)
end

function FengMoJieJieOBJ:updateUiState(sMsg, sMsg2, sMsg3)
    local num_tab = SL:JsonDecode(sMsg, false)
    GUI:Text_setString(self.ui.totalLevelTxt, num_tab[1])
    self.count = num_tab[2]
    GUI:Text_setString(self.ui.myLevelTxt, num_tab[2] .. "次")

    local get_state = SL:JsonDecode(sMsg2, false)
    self.get_state =get_state 
    for index, v in ipairs(get_state) do
        GUI:setVisible(self.ui["getBtn_"..index], v == 0)
        GUI:setVisible(self.ui["getTag_"..index], v > 0)
    end

    local exchange_state = SL:JsonDecode(sMsg3, false)
    for index, v in ipairs(exchange_state) do
        GUI:setVisible(self.ui["exchangeBtn_"..index], v == 0)
        GUI:setVisible(self.ui["exchangeTag_"..index], v > 0)
    end
end

function FengMoJieJieOBJ:flushView(sMsg, sMsg2, sMsg3)
    self:updateUiState(sMsg, sMsg2, sMsg3)
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "FengMoJieJieOBJ",["node"] = self,["is_all"] = true})
end
function FengMoJieJieOBJ:GetBtnRed( index )
    index = tonumber(index)
    local count_list  = {10,20,30}
    if (FengMoJieJieOBJ.get_state[index] or 0) < 1 and FengMoJieJieOBJ.count >= count_list[index] then
        return true
    end
    return false
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(FengMoJieJieOBJ.NpcId, npc_info.index) then
        SendMsgClickNpc(npc_info.index .. "#FengMoJieJieNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "FengMoJieJieOBJ", onClickNpc)

return FengMoJieJieOBJ