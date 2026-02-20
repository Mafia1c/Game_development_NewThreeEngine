local AbyssCaveOBJ = {}
AbyssCaveOBJ.Name = "AbyssCaveOBJ"
AbyssCaveOBJ.RunAction = true
AbyssCaveOBJ.NpcId = {35}

function AbyssCaveOBJ:main(sMsg, sMsg2)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/AbyssCaveUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.show_reward = true

    self:initClickEvents()
    self:ShowUIData()
    self:updateUiState(sMsg, sMsg2)
end

function AbyssCaveOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("AbyssCaveOBJ")
    end)

    GUI:addOnClickEvent(self.ui.enterBtn, function()
        SendMsgCallFunByNpc(35, "AbyssCaveNpc", "onEnterMap", "")
    end)

    for i = 1, 3, 1 do
        GUI:addOnClickEvent(self.ui["getBtn_"..i], function()
            SendMsgCallFunByNpc(35, "AbyssCaveNpc", "onGetReward", i)
        end)
    end
end

function AbyssCaveOBJ:ShowUIData()
    local reward_items = {
        {"黄金钥匙", 1},
        {"黄金钥匙", 1},
        {"黄金钥匙", 1}
    }
    for index, v in ipairs(reward_items) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(v[1])
        ItemShow_updateItem(self.ui["ItemShow_"..index], {index = item_id, look = true, bgVisible = true, showCount = true, count = v[2], color = 250})
    end
end

function AbyssCaveOBJ:updateUiState(sMsg, sMsg2)
    local num_tab = SL:JsonDecode(sMsg, false)
    GUI:Text_setString(self.ui.remainTxt, num_tab[1])
    GUI:Text_setString(self.ui.levelTxt, num_tab[2] .. "次")
    self.count = num_tab[2]

    local get_state = SL:JsonDecode(sMsg2, false)
    self.get_state = get_state
    for index, v in ipairs(get_state) do
        GUI:setVisible(self.ui["getBtn_"..index], v == 0)
        GUI:setVisible(self.ui["getTag_"..index], v > 0)
    end
end

function AbyssCaveOBJ:flushView(sMsg, sMsg2)
    self:updateUiState(sMsg, sMsg2)
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "AbyssCaveOBJ",["node"] = self,["is_all"] = true})
end

function AbyssCaveOBJ:GetBtnRed(index)
    index = tonumber(index)
    local count_list  = {5,10,20}
    if (AbyssCaveOBJ.get_state[index] or 0) < 1 and AbyssCaveOBJ.count >= count_list[index] then
        return true
    end
    return false
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(AbyssCaveOBJ.NpcId, npc_info.index) then
        SendMsgClickNpc(npc_info.index .. "#AbyssCaveNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "AbyssCaveOBJ", onClickNpc)

return AbyssCaveOBJ