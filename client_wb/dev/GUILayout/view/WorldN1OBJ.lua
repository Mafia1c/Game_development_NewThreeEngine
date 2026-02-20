local WorldN1OBJ = {}
WorldN1OBJ.Name = "WorldN1OBJ"
WorldN1OBJ.RunAction = true
WorldN1OBJ.rank_text = {
    "上榜玩家: %s",
    "上榜等级: %s级",
    "上榜战力: %s"
}

function WorldN1OBJ:main(npc_id, sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/WorldN1UI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.npc_id = tonumber(npc_id)
    self.rank_info = SL:Split(sMsg, "|")


    self:initClickEvents()
    self:updateUiInfo()
end

function WorldN1OBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("WorldN1OBJ")
    end)
    GUI:addOnClickEvent(self.ui.applyBtn, function()
        SendMsgCallFunByNpc(self.npc_id , "WorldN1Npc", "onApplyUp", self.npc_id)
    end)
end

function WorldN1OBJ:updateUiInfo()
    local id = self.npc_id - 74
    GUI:Image_loadTexture(self.ui.title_icon, string.format("res/custom/npc/36tx/t%s.png", id))
    GUI:Image_loadTexture(self.ui.title_mini, string.format("res/custom/npc/36tx/z%s.png", id))
    GUI:Image_loadTexture(self.ui.roleImg, string.format("res/custom/npc/36tx/r%s.png", id))

    for i = 1, 3 do
        local format = self.rank_text[i]
        local value = self.rank_info[i]
        if i == 2 and nil == value then
            format = "上榜等级: %s"
        end
        local str = string.format(format, value or "无")
        GUI:Text_setString(self.ui["title_"..i], str)
    end
end

function WorldN1OBJ:flushView(sMsg)
    self.rank_info = SL:Split(sMsg, "|")
    self:updateUiInfo()
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable({75,76,77}, npc_info.index) then
        SendMsgClickNpc(npc_info.index.."#WorldN1Npc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "WorldN1OBJ", onClickNpc)

return WorldN1OBJ