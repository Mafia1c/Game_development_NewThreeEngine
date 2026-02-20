local ShaBaKeOBJ = {}
ShaBaKeOBJ.Name = "ShaBaKeOBJ"
ShaBaKeOBJ.RunAction = true
ShaBaKeOBJ.NpcId = 81

function ShaBaKeOBJ:main(jackpot, sMsg, sMsg2)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ShaBaKeUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.jackpot_value = tonumber(jackpot) or 0
    self.sbk_info = SL:Split(sMsg, "|")
    self.guild_info = SL:Split(sMsg2, "|")

    self:initClickEvents()
    self:updateUiInfo()
end

function ShaBaKeOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("ShaBaKeOBJ")
    end)

    GUI:addOnClickEvent(self.ui.rule_btn, function()
        local visible = GUI:getVisible(self.ui.rule_img)
        GUI:setVisible(self.ui.rule_img, not visible)
    end)

    GUI:addOnClickEvent(self.ui.backBtn, function()
        GUI:setVisible(self.ui.rule_img, false)
    end)

    GUI:addOnClickEvent(self.ui.getReward_btn, function()
        SendMsgCallFunByNpc(self.NpcId, "ShaBaKeNpc", "onGetGongShaReward", i)
    end)

    for i = 1, 5 do
        GUI:addOnClickEvent(self.ui["mapMove_btn_" .. i], function()
            SendMsgCallFunByNpc(self.NpcId, "ShaBaKeNpc", "onMapMove", i)
        end)
    end
end

function ShaBaKeOBJ:updateUiInfo()
    if "" == self.guild_info[1] then
        self.guild_info[1] = "无"
    end
    if "" == self.guild_info[2] or "管理员" == self.guild_info[2] then
        self.guild_info[2] = "无"
    end
    local jackpot = SL:GetSimpleNumber(self.jackpot_value, 0)
    GUI:Text_setString(self.ui.jackpot_txt, jackpot .. "元宝")
    GUI:Text_setString(self.ui.guild_txt, self.guild_info[1] or "暂无")
    GUI:Text_setString(self.ui.city_txt, self.guild_info[2] or "暂无")

    GUI:Text_setString(self.ui.city_time, (self.sbk_info[1] or 0) .. "分钟")
    GUI:Text_setString(self.ui.people_count_1, (self.sbk_info[2] or 0) .. "人")
    GUI:Text_setString(self.ui.people_count_2, (self.sbk_info[3] or 0) .. "人")
end

function ShaBaKeOBJ:flushView(sMsg)

end

-- 点击npc触发
local function onClickNpc(npc_info)
    if npc_info.index == ShaBaKeOBJ.NpcId then
        SendMsgClickNpc(npc_info.index.."#ShaBaKeNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "ShaBaKeOBJ", onClickNpc)

return ShaBaKeOBJ