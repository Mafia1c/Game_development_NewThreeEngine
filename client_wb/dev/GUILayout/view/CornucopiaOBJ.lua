local CornucopiaOBJ = {}
CornucopiaOBJ.Name = "CornucopiaOBJ"
CornucopiaOBJ.cfg = GetConfig("CornucopiaCfg")
function CornucopiaOBJ:main(progress_list,mzl_state)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/CornucopiaUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.progress_list = SL:JsonDecode(progress_list) or {}
    -- self.limit_list = SL:JsonDecode(limit_list) or {}
    self.mzl_state = tonumber(mzl_state) or 0

    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("CornucopiaOBJ")
    end)
    GUI:addOnClickEvent(self.ui.get_equip_btn,function ()
        SendMsgCallFunByNpc(0,"Cornucopia","GetEquip")
    end)
    for i,v in ipairs(self.cfg) do
        GUI:addOnClickEvent(self.ui["get_reward_"..i],function ()
            SendMsgCallFunByNpc(0,"Cornucopia","GetAward",i)
        end)
    end
    self:FlushViewInfo()
end

function CornucopiaOBJ:FlushViewInfo()
    for i,v in ipairs(self.cfg) do
        GUI:Text_setString(self.ui["title_text"..i],v.tips)
        local num = self.progress_list[i] or 0
        if i == 1 then
            if 600 - num > 0 then
              GUI:Text_setTextColor(self.ui.coundown_time,"#ff0000")
                GUI:Text_COUNTDOWN(self.ui.coundown_time, 600 - num, function ()
                    GUI:Text_setString(self.ui.coundown_time,"可领取")
                    GUI:Text_setTextColor(self.ui.coundown_time,"#00ff00")
                end, 1)
            else
                GUI:Text_setTextColor(self.ui.coundown_time,"#00ff00")
                GUI:Text_setString(self.ui.coundown_time,"可领取")
            end
            num = math.floor(num / 60) 
        end
        GUI:Text_setString(self.ui["schedule_text"..i],num .."/"..v.progress.. (i==1 and "分" or "只"))
        GUI:Text_setTextColor(self.ui["schedule_text"..i],num >= v.progress and "#00FF00" or "#ff0000")
    end

    GUI:setVisible(self.ui.get_equip_tag,SL:Get_EQUIPBYPOS(106) ~= "")
    GUI:setVisible(self.ui.get_equip_btn,SL:Get_EQUIPBYPOS(106) == "")
end

function CornucopiaOBJ:flushView(progress_list,mzl_state)
    self.progress_list = SL:JsonDecode(progress_list) or {}
    -- self.limit_list = SL:JsonDecode(limit_list) or {}
    self.mzl_state = tonumber(mzl_state) or 0
    self:FlushViewInfo()
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "CornucopiaOBJ",["node"] = self,["is_all"] = true})
end

function CornucopiaOBJ:GetBtnRed()
    local mzl_state = GameData.GetData("U_allianceOrder") or 0 
    for i,v in ipairs(self.cfg) do
        if self:GetSigleBtnRed(i) then
            return true
        end
    end
    return false
end

function CornucopiaOBJ:GetSigleBtnRed(index)
    index = tonumber(index) 
    local mzl_state = GameData.GetData("U_allianceOrder") or 0 
    local progress = GameData.GetData("U_jubaopen_award_"..index) or 0
    local cfg = self.cfg[index]
    if progress >= (index == 1 and cfg.progress * 60 or cfg.progress) then
        if mzl_state <= 0 then
            local limit = GameData.GetData("J_jubaopen_limit_award_"..index) or 0 
            if limit < cfg.time then
                return true
            end
        else
            return true
        end
    end
    return false
end
return CornucopiaOBJ