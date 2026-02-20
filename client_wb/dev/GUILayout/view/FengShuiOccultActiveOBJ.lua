local FengShuiOccultActiveOBJ = {}
FengShuiOccultActiveOBJ.Name = "FengShuiOccultActiveOBJ"
FengShuiOccultActiveOBJ.cfg =GetConfig("FengShuiOccultCfg")
FengShuiOccultActiveOBJ.suit_cfg =GetConfig("FengShuiOccultSuitCfg")

function FengShuiOccultActiveOBJ:main(data)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/FengShuiOccultActiveUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close("FengShuiOccultActiveOBJ")
    end)

    self.data = SL:JsonDecode(data) or {}
    self.reward_name = ""
    GUI:addOnClickEvent(self.ui.unlock_btn,function ()
    	if self:GetActiveNum() >= 16 then
    		SL:ShowSystemTips("已全部解封")
    		return
    	end
    	if SL:Get_ITEM_COUNT("罗盘") < 1 then
    		SL:ShowSystemTips("罗盘不足！")
    		return
    	end
    	self:PlayUnlockAni()
    	SendMsgCallFunByNpc(0,"FengShuiOccult","LotteryClick")
    end)

     GUI:addOnClickEvent(self.ui.look_btn,function ()
    	SendMsgClickNpc("0#FengShuiOccult")
    end)

    GUI:addOnClickEvent(self.ui.continue_btn,function ()
    	if self:GetActiveNum() >= 16 then
    		SL:ShowSystemTips("已全部解封")
    		return
    	end
    	if SL:Get_ITEM_COUNT("罗盘") < 1 then
    		SL:ShowSystemTips("罗盘不足！")
    		return
    	end
	   	self:PlayUnlockAni()
    	SendMsgCallFunByNpc(0,"FengShuiOccult","LotteryClick")
    end)
    GUI:addOnClickEvent(self.ui.item_text,function ()
    	local pos = GUI:getWorldPosition(self.ui.item_text)
		UIOperator:OpenItemTips({itemData = SL:GetMetaValue("ITEM_DATA", SL:Get_ITEM_INDEX_BY_NAME("罗盘")),pos = pos})
    end)

    GUI:setVisible(self.ui.play_ani_node,false) 
    self:UpdaViewInfo()

end

function FengShuiOccultActiveOBJ:UpdaViewInfo()
	GUI:setVisible(self.ui.unlock_node,true) 
	GUI:setVisible(self.ui.unlock_btn,self.reward_name == "")
	GUI:setVisible(self.ui.look_btn,self.reward_name ~= "") 
	GUI:setVisible(self.ui.continue_btn,self.reward_name ~= "") 
	GUI:setVisible(self.ui.item_cell,self.reward_name ~= "") 
	if self.reward_name ~= "" then
		ItemShow_updateItem(self.ui.item_cell,{index = SL:Get_ITEM_INDEX_BY_NAME(self.reward_name),count = 1,bgVisible=true,look = true})
	end
end

function FengShuiOccultActiveOBJ:PlayUnlockAni()
	if self.ui.unlock_ani then
	 	removeOBJ(self.ui.unlock_ani,self)
	end
	GUI:setVisible(self.ui.unlock_node,false)
	GUI:setVisible(self.ui.play_ani_node,true) 
    local ext = {
		count = 30,
		speed = 100,
		loop = 1,
		finishhide = 1,
	}
	local fram = GUI:Frames_Create(self.ui["unlock_ani_node"], "unlock_ani", -363,-207, "res/custom/npc/00juqing/ef/efc", ".png", 1, 30,ext)
end

function FengShuiOccultActiveOBJ:flushView( ... )
	local tab = {...}
	if tab[1] == "reward_flush" then
		self.data = SL:JsonDecode(tab[2]) or {}
		self.reward_name = tab[3]
		SL:Print(self.reward_name)
		self:UpdaViewInfo()
	end

	GUI:setVisible(self.ui.play_ani_node,false)
end
function FengShuiOccultActiveOBJ:GetActiveNum()
    local num = 0
    for i,v in ipairs(self.data or {}) do
        if v > 0 then
            num = num + 1
        end
    end
    return num
end

return FengShuiOccultActiveOBJ