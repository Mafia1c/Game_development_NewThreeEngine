local AllianceOrderOBJ = {}
AllianceOrderOBJ.Name = "AllianceOrderOBJ"
AllianceOrderOBJ.RunAction = true

function AllianceOrderOBJ:main(state1,reward, effect_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/AllianceOrderUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.reward = SL:JsonDecode(reward, false)
    self.effect_id = tonumber(effect_id) or 17046

    self:initClickEvent()
    self:refreshState(tonumber(state1))
    self:ShowRewardData()

    local sfx = GUI:Effect_Create(self.ui.FrameLayout, "sfx", 30, 297, 0, self.effect_id, 0, 0, 0, 1)

    ItemShow_updateItem(self.ui["equip_item"], {index = 51168, look = true, bgVisible = true})
end

function AllianceOrderOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    GUI:addOnClickEvent(self.ui.activateBtn, function()
        SendMsgClickMainBtn("0#AllianceOrder#onClickActivate")
    end)
end
function AllianceOrderOBJ:refreshState(state1,state2)
    GUI:setVisible(self.ui.icon, state1 >= 1)
    GUI:setVisible(self.ui.getTag, state1 >= 1)
    GUI:setVisible(self.ui.activateBtn, state1 < 1)
end

function AllianceOrderOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["recharge"] = function ()
            self:refreshState(tonumber(tab[2]),tonumber(tab[3]))
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "AllianceOrderOBJ",["node"] = self,["is_all"] = true})
end

function AllianceOrderOBJ:ShowRewardData()
    local reward = self.reward or {"元宝*68000","[时装激活卡]轮椅战神*1","天命石*9","书页*100","五行精华*88","转生凭证*28","秘境卷轴*18"}
    for i = 1, #reward, 1 do
        local info = reward[i]
        info = SL:Split(info, "*")
        local item = self.ui["ItemShow_"..i]
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(info[1]) or 0
        ItemShow_updateItem(item, {index = item_id, look = true, bgVisible = true, count = tonumber(info[2])})
    end
end

return AllianceOrderOBJ