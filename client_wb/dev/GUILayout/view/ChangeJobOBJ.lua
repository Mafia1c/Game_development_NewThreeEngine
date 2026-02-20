local ChangeJobOBJ = {}
ChangeJobOBJ.Name = "ChangeJobOBJ"
ChangeJobOBJ.NpcId = 68

function ChangeJobOBJ:main( ... )
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ChangeJobUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:addOnClickEvent(self.ui.close_btn, function()
        ViewMgr.close("ChangeJobOBJ")
    end)
	local job = SL:Get_JOB()

	for i=1,3 do
		GUI:setVisible(self.ui["Button_"..i],tonumber(job) ~= (i-1) )
		GUI:addOnClickEvent(self.ui["Button_"..i],function ()
			SendMsgCallFunByNpc(ChangeJobOBJ.NpcId,"ChangeJob","ClickJob",i-1)
		end)
	end


    self:InitViewInfo()
end
function ChangeJobOBJ:InitViewInfo()
	GUI:UserUILayout(self.ui.btn_box, {
        dir=2,
        gap = {x=80},
    })
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if ChangeJobOBJ.NpcId == npc_info.index then
        ViewMgr.open(ChangeJobOBJ.Name)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "ChangeJobOBJ", onClickNpc)

return ChangeJobOBJ