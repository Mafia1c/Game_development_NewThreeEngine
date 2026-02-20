local AbyssGuardianOBJ = {}
AbyssGuardianOBJ.Name = "AbyssGuardianOBJ"
AbyssGuardianOBJ.RunAction = true
AbyssGuardianOBJ.cfg = GetConfig("AbyssCaveCfg")
AbyssGuardianOBJ.NpcId = {36}

function AbyssGuardianOBJ:main(sMsg, times, state)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/AbyssGuardianUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.title_txt = nil
    self.rank_model = nil

    self:initClickEvents()
    self:updateUiState(sMsg, times, state)
    self:CreateModel()
end

function AbyssGuardianOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("AbyssGuardianOBJ")
    end)

    GUI:addOnClickEvent(self.ui.getTitleBtn, function()
        SendMsgCallFunByNpc(35, "AbyssGuardianNpc", "onGetTitle", self.cur_times)
    end)
end

function AbyssGuardianOBJ:updateUiState(sMsg, times, state)
    times = tonumber(times)
    state = tonumber(state)
    self.cur_times = times

    local tab = SL:JsonDecode(sMsg, false)
    for i = 1, 5 do
        GUI:Text_setString(self.ui["timesTxt_"..i], tab[i] or 0)
    end
    local index = 9
    local reward_times = 10
    if state < 10 then
        reward_times = 10
    elseif state < 30 then
        reward_times = 30
        index = 10
    else
        reward_times = 90
        index = 11
    end

    GUI:setVisible(self.ui.tagIcon, times < reward_times)
    GUI:setVisible(self.ui.getTitleBtn, times >= reward_times)
    GUI:Text_setString(self.ui["timesTxt_6"], reward_times)
    if state >= 90 then
        GUI:Image_loadTexture(self.ui.tagIcon, "res/custom/npc/21fb/symj/ylq.png")
    end

    if self.title_txt then
        GUI:removeFromParent(self.title_txt)
        self.title_txt = nil
    end

    local _cfg = self.cfg[index]
    local item_id = SL:Get_ITEM_INDEX_BY_NAME(_cfg.giveitem1)
    local str = string.format("<a enableUnderline ='false' href='jump#item_tips#%s'> <u><font color ='#FFFF00'>%s</font></u></a>", item_id, _cfg.giveitem1)
    self.title_txt = GUI:RichText_Create(self.ui.FrameLayout, "title_txt", 547, 134, str, 100, 20, "#FFFF00")
end

function AbyssGuardianOBJ:CreateModel()
    local feature = GetModelInfo()
    local sex = SL:GetMetaValue("SEX")
    local job = SL:GetMetaValue("JOB")
    self.rank_model = GUI:UIModel_Create(self.ui.FrameLayout, "UIMODEL", 225, 195, sex, feature, nil, true, job)
end

function AbyssGuardianOBJ:flushView(sMsg, times, state)
    self:updateUiState(sMsg, times, state)
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(AbyssGuardianOBJ.NpcId, npc_info.index) then
        SendMsgClickNpc(npc_info.index .. "#AbyssGuardianNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "AbyssGuardianOBJ", onClickNpc)

return AbyssGuardianOBJ