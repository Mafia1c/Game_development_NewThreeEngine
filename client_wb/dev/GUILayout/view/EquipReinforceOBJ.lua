local EquipReinforceOBJ = {}
EquipReinforceOBJ.Name = "EquipReinforceOBJ"
EquipReinforceOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
EquipReinforceOBJ.NpcId = 0
EquipReinforceOBJ.RunDrag = true
EquipReinforceOBJ.cfg={0,1,3,4,5,6,7,8,10,11}

function EquipReinforceOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/EquipReinforceUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    -- GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshInfo()

    -- GUI:addOnClickEvent(self.ui.CloseLayout, function()
    --     ViewMgr.close("EquipReinforceOBJ")
    -- end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("EquipReinforceOBJ")
    end)
end

function EquipReinforceOBJ:refreshInfo()
    GUI:removeAllChildren(self.ui.leftBoxList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    local allStar = 0
    for index, position in ipairs(self.cfg) do
        local icon = GUI:Image_Create(self.ui.leftBoxList,"icon"..index,0,0,"res/custom/npc/25bwqh/zf/icon"..(10+index)..".png")
        local box = GUI:Image_Create(icon,"leftBox"..index,0,0,"res/custom/npc/25bwqh/zf/list.png")
        local nowStar = GameData.GetData("U_equipStar"..position,false)or 0
        allStar=allStar+nowStar
        GUI:Text_Create(box,"starText"..index,36,3,16,"#00FF00","+"..nowStar)
        GUI:Text_Create(box,"equipText"..index,116,15,16,"#FF7700",SL:Get_EQUIPBYPOS(position))
        GUI:setAnchorPoint(self.ui["equipText"..index],0.5,0.5)
        GUI:Effect_Create(box,"effect"..index,198,-3,0,5004,0,0,0,1)
        local addInfoTab={"10","12","14","16","18","20","30","40","50","60","70","80","90","100","120"}
        GUI:Text_Create(box,"boxState"..index,214,3,16,"#00FF00","增幅"..(addInfoTab[nowStar] or "0").."%")
        GUI:setVisible(icon,false)
        time = time +0.05
        GUI:runAction(icon,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(icon,true)
            GUI:setPositionX(icon,-290)
            GUI:runAction(icon,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(icon))))
        end)))
    end
    GUI:Text_setString(self.ui.allStarText,allStar)
    if allStar<80 then
        GUI:setVisible(self.ui.suitText,true)
        GUI:setVisible(self.ui.suitImg,false)
    else
        GUI:setVisible(self.ui.suitText,false)
        GUI:setVisible(self.ui.suitImg,true)
        if allStar>=150 then
            GUI:Text_setString(self.ui.suitStarText,150)
        elseif allStar>=140 then
            GUI:Text_setString(self.ui.suitStarText,140)
        elseif allStar>=130 then
            GUI:Text_setString(self.ui.suitStarText,130)
        elseif allStar>=120 then
            GUI:Text_setString(self.ui.suitStarText,120)
        elseif allStar>=110 then
            GUI:Text_setString(self.ui.suitStarText,110)
        elseif allStar>=100 then
            GUI:Text_setString(self.ui.suitStarText,100)
        elseif allStar>=80 then
            GUI:Text_setString(self.ui.suitStarText,80)
        end
    end
end

--#region 后端消息刷新ui
function EquipReinforceOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        
    }
    functionTab[tab[1]]()
end

-- 点击npc触发
-- local function onClickNpc(npc_info)
--     if EquipReinforceOBJ.NpcId == npc_info.index then
--         ViewMgr.open("EquipReinforceOBJ")
--     end
-- end
-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "EquipReinforceOBJ", onClickNpc)

return EquipReinforceOBJ