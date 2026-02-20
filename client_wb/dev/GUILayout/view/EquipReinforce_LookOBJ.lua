local EquipReinforce_LookOBJ = {}
EquipReinforce_LookOBJ.Name = "EquipReinforce_LookOBJ"
EquipReinforce_LookOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
EquipReinforce_LookOBJ.NpcId = 0
EquipReinforce_LookOBJ.RunDrag = true
EquipReinforce_LookOBJ.cfg={0,1,3,4,5,6,7,8,10,11}

function EquipReinforce_LookOBJ:main(sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/EquipReinforceUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    -- GUI:addOnClickEvent(self.ui.CloseLayout, function()
    --     ViewMgr.close("EquipReinforce_LookOBJ")
    -- end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("EquipReinforce_LookOBJ")
    end)
    self.equip_id_tab = SL:JsonDecode(sMsg)
    self:refreshInfo()
end

function EquipReinforce_LookOBJ:refreshInfo()
    GUI:removeAllChildren(self.ui.leftBoxList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    local allStar = 0
    for index, position in ipairs(self.cfg) do
        local icon = GUI:Image_Create(self.ui.leftBoxList,"icon"..index,0,0,"res/custom/npc/25bwqh/zf/icon"..(10+index)..".png")
        local box = GUI:Image_Create(icon,"leftBox"..index,0,0,"res/custom/npc/25bwqh/zf/list.png")
        local nowStar = tonumber(self.equip_id_tab[index][1])
        allStar=allStar+nowStar
        GUI:Text_Create(box,"starText"..index,36,3,16,"#00FF00","+"..nowStar)
        GUI:Text_Create(box,"equipText"..index,116,15,16,"#FF7700",SL:Get_L_M_EQUIP_DATA(position) and SL:Get_ITEM_NAME(SL:Get_L_M_EQUIP_DATA(position).Index) or "")
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
    GUI:setVisible(self.ui.allStarImg,false)
    GUI:RichTextFCOLOR_Create(self.ui.infoNode,"rich",104,442, SL:Get_LOOK_TARGET_NAME().."<("..allStar.."星)/FCOLOR=250>",200,16, "#ffffff", 1)
    GUI:setAnchorPoint(self.ui.rich,0.5,0.5)
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
function EquipReinforce_LookOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        
    }
    functionTab[tab[1]]()
end

-- 点击npc触发
-- local function onClickNpc(npc_info)
--     if EquipReinforce_LookOBJ.NpcId == npc_info.index then
--         ViewMgr.open("EquipReinforce_LookOBJ")
--     end
-- end
-- SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "EquipReinforce_LookOBJ", onClickNpc)

return EquipReinforce_LookOBJ