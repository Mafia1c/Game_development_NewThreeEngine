local FastStepOBJ = {}
FastStepOBJ.Name = "FastStepOBJ"
FastStepOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
FastStepOBJ.NpcId = 0
FastStepOBJ.itemTab={{"1亿经验珠",8},{"书页",188},{"",1},{"天命石",5},{"元宝盒",10}}

function FastStepOBJ:main(time)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/FastStepUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.time=tonumber(time)
    GUI:Timeline_Window4(self.ui.FrameLayout)
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("FastStepOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("FastStepOBJ")
    end)

    removeOBJ(self.ui.timeText,self)
    if self.time>0 then
        local text=GUI:Text_Create(self.ui.midNode,"timeText",506,86,16,"#00ff00","")
        GUI:Text_COUNTDOWN(text,self.time,function ()
            SendMsgCallFunByNpc(self.NpcId, "FastStep", "delay_del_fast_step","")
        end,1)
    end
    FastStepOBJ:refreshInfo()

    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["Button_"..i],function ()
            SendMsgCallFunByNpc(self.NpcId, "FastStep", "btnEvent"..i,"")
        end)
    end
end
function FastStepOBJ:refreshInfo()
    local jobItem={[0]="战神变异宝箱",[1]="圣魔变异宝箱",[2]="真魂变异宝箱"}
    local job=SL:Get_JOB()
    for index, value in ipairs(self.itemTab) do
        local itemName=value[1]
        if index==3 then
            itemName=jobItem[job]
        end
        GUI:ItemShow_updateItem(self.ui["itemShow"..index],{index=SL:Get_ITEM_INDEX_BY_NAME(itemName),bgVisible=true,look=true,count=value[2],color=250})
    end
    local price=tonumber(GameData.GetData("U_fastStep_price",false)or 0)
    if price==0 then
        GUI:Button_loadTextures(self.ui.Button_3,"res/custom/npc/117kryb/yj.png","res/custom/npc/117kryb/yj_1.png",nil,0)
    else
        GUI:Button_loadTextures(self.ui.Button_3,"res/custom/npc/117kryb/"..price.."z.png","res/custom/npc/117kryb/"..price.."z_1.png",nil,0)
    end
end
--#region 后端消息刷新ui
function FastStepOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["refresh"] = function ()
            FastStepOBJ:refreshInfo()
        end,
        ["recharge"] = function ()
            ViewMgr.close("FastStepOBJ")
            SendMsgCallFunByNpc(self.NpcId, "FastStep", "delay_del_fast_step","")
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

-- 点击npc触发
-- local function onClickNpc(npc_info)
--     if FastStepOBJ.NpcId==npc_info.index then
--         -- ViewMgr.open("FastStepOBJ")
--         SendMsgClickNpc(FastStepOBJ.NpcId.."#FastStep")
--     end
-- end
-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "FastStepOBJ", onClickNpc)

return FastStepOBJ