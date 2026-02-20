local DisguiseOBJ = {}
DisguiseOBJ.Name = "DisguiseOBJ"
DisguiseOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
DisguiseOBJ.NpcId = 0
DisguiseOBJ.cfg = GetConfig("DisguiseCfg")

function DisguiseOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/DisguiseUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshLeftList()
    for index, value in ipairs(self.cfg) do
        if (GameData.GetData(value.varStr,false)or "") ~="" then
            self:leftBtnEvent(index)
            break
        end
    end

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("DisguiseOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("DisguiseOBJ")
    end)
    GUI:addOnClickEvent(self.ui.showBtn, function()
        SendMsgCallFunByNpc(self.NpcId, "Disguise", "showEvent", self.leftIndex.."#"..self.rightIndex)
    end)
    GUI:addOnClickEvent(self.ui.hideBtn, function()
        SendMsgCallFunByNpc(self.NpcId, "Disguise", "hideEvent", self.leftIndex.."#"..self.rightIndex)
    end)
end

function DisguiseOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftBtnList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg) do
        if (GameData.GetData(value.varStr,false)or "") =="" then
            goto continue
        end
        local btn = GUI:Button_Create(self.ui.leftBtnList,"leftBtn"..index,0,0,"res/custom/npc/ta1.png")
        GUI:Button_loadTexturePressed(btn,"res/custom/npc/ta0.png")
        GUI:Button_setTitleText(btn, value["type"])
        GUI:Button_setTitleColor(btn, "#BDBDB5")
        GUI:Button_setTitleFontSize(btn, 18)
        GUI:addOnClickEvent(btn,function ()
            if self.leftIndex == index then
                return
            end
            self:leftBtnEvent(index)
        end)
        GUI:setVisible(btn,false)
        time = time +0.05
        GUI:runAction(btn,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(btn,true)
            GUI:setPositionX(btn,-120)
            GUI:runAction(btn,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(btn))))
        end)))
        ::continue::
    end
end

function DisguiseOBJ:leftBtnEvent(leftIndex)
    self.leftIndex = leftIndex
    for index, value in ipairs(self.cfg) do
        if self.ui["leftBtn"..index] then
            GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/npc/ta1.png")
            GUI:Button_setTitleColor(self.ui["leftBtn"..index], "#BDBDB5")
        end
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")
    GUI:Image_loadTexture(self.ui.tagImg,"res/custom/npc/20zb/ba"..leftIndex..".png")
    GUI:Image_loadTexture(self.ui.infoImg,"res/custom/npc/20zb/ss"..leftIndex..".png")
    removeOBJ(self.ui.wingText,self)
    if leftIndex==5 then
        GUI:Text_Create(self.ui.infoImg,"wingText",-30,24,16,"#FE00FE","羽翼仅显示在时装面板")
    end

    GUI:removeAllChildren(self.ui.rightList)
    self.ui = GUI:ui_delegate(self._parent)
    local str = GameData.GetData(self.cfg[leftIndex].varStr,false)
    if not str then
        return
    end
    local hasTab=SL:Split(string.sub(str,1,-2), "|")
    local endTab ={}
    for index, value in ipairs(hasTab) do
        if self.cfg[value] then
            table.insert(endTab,value)
        end
    end
    hasTab=endTab
    self.hasTab=hasTab

    local number = math.ceil(#hasTab/3)
    local time = 0
    for i = 1, number do
        local list = GUI:ListView_Create(self.ui.rightList,"sonList"..i,0,0,240,96,2)
        GUI:setTouchEnabled(list,false)
        GUI:setVisible(list,false)
        for j = 1, 3 do
            local sonIndex = (i-1)*3+j
            local name = hasTab[sonIndex]
            if name and self.cfg[name] then
                local box = GUI:Image_Create(list,"itemBox"..sonIndex,0,0,"res/custom/npc/20zb/list.png")
                local item = GUI:ItemShow_Create(box,"showItem"..sonIndex,10,30,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",name),look=true})
                local _name = GUI:Text_Create(box,"itemName"..sonIndex,41,12,16,"#ffffff",self.cfg[name].showName)
                GUI:setAnchorPoint(_name,0.5,0.5)
                local layout = GUI:Layout_Create(item,"sonLayout"..sonIndex,0,0,60,60,false)
                GUI:setTouchEnabled(layout,true)
                GUI:setSwallowTouches(layout, false)
                if (GameData.GetData("T_disguiseName"..leftIndex)or"") == name then
                    removeOBJ(self.ui.nowTagImg,self)
                    GUI:Image_Create(item,"nowTagImg",1,15,"res/custom/npc/20zb/wx1.png")
                end
                GUI:addOnClickEvent(layout,function ()
                    self:sonClickEvent(sonIndex)
                end)
            end
        end
        time = time + 0.05
        GUI:runAction(list, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
            GUI:setVisible(list, true)
            GUI:setPositionX(list, 254)
            GUI:runAction(list, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(list))))
        end)))
    end
    local textTab={}
    for i = 1, #self.cfg[leftIndex]["text_arr"]+1 do
        table.insert(textTab,i,0)
    end
    for index, value in ipairs(hasTab or {}) do
        for i = 1, 7 do
            if textTab[i] and self.cfg[value] then
                textTab[i]=textTab[i]+(self.cfg[value]["text"..(i-1)] or 0)
            end
        end
    end
    for i = 1, 6 do
        GUI:setVisible(self.ui["typeText"..i],false)
        GUI:Text_setString(self.ui["typeText"..i],(self.cfg[leftIndex]["text_arr"][i] and self.cfg[leftIndex]["text_arr"][i].."：") or "")
        GUI:setPositionX(self.ui["numberText"..i],GUI:getContentSize(self.ui["typeText"..i]).width)
        if i==1 then
            GUI:Text_setString(self.ui["numberText1"],textTab[1].." - "..textTab[2])
            GUI:setVisible(self.ui["typeText1"],true)
        elseif textTab[i+1] and textTab[i+1]>0 then
            GUI:Text_setString(self.ui["numberText"..i],textTab[i+1].."%")
            GUI:setVisible(self.ui["typeText"..i],true)
        end
    end
   
    self:sonClickEvent(1)
end

function DisguiseOBJ:sonClickEvent(rightIndex)
    self.rightIndex = rightIndex
    removeOBJ(self.ui.nowTagEffect,self)
    GUI:Effect_Create(self.ui["showItem"..rightIndex],"nowTagEffect",31,26,0,4004,0,0,0,1)
    GUI:setScale(self.ui.nowTagEffect, 0.7)
    local name = self.hasTab[rightIndex]
    removeOBJ(self.ui.nowItem,self)
    GUI:ItemShow_Create(self.ui.rightNode,"nowItem",600,50,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",name),look=true,bgVisible=true})
    if (GameData.GetData("T_disguiseName"..self.leftIndex)or"") == name then
        GUI:setVisible(self.ui.showBtn,false)
        GUI:setVisible(self.ui.hideBtn,true)
    else
        GUI:setVisible(self.ui.showBtn,true)
        GUI:setVisible(self.ui.hideBtn,false)
    end

    GUI:removeAllChildren(self.ui.effectNode)
    self.ui = GUI:ui_delegate(self._parent)
    if self.leftIndex==1 then
        GUI:Effect_Create(self.ui.effectNode,"nowShowEffect",354,288,4,self.cfg[name].effectId,SL:Get_SEX(),1,5,1)
    elseif self.leftIndex==2 then
        GUI:Effect_Create(self.ui.effectNode,"nowShowEffect",354,288,4,self.cfg[name].effectId,SL:Get_SEX(),1,5,1)
    elseif self.leftIndex==3 then
        GUI:Effect_Create(self.ui.effectNode,"nowShowEffect1",354,282,4,1,SL:Get_SEX(),5,2,1)
        GUI:Effect_Create(self.ui.effectNode,"nowShowEffect2",300,290,0,self.cfg[name].effectId,0,0,0,1)
        GUI:Effect_Create(self.ui.effectNode,"nowShowEffect3",250,280,0,self.cfg[name].effectId,0,0,0,1)
        GUI:setScale(self.ui.nowShowEffect3,0.6)
    elseif self.leftIndex==4 then
        GUI:Effect_Create(self.ui.effectNode,"nowShowEffect1",352,284,0,self.cfg[name].effectId,0,0,0,1)
        GUI:Effect_Create(self.ui.effectNode,"nowShowEffect2",350,282,4,1,SL:Get_SEX(),0,4,1)
    elseif self.leftIndex==5 then
        GUI:Effect_Create(self.ui.effectNode,"nowShowEffect1",360,276,0,self.cfg[name].effectId,0,0,0,1)
        GUI:setScale(self.ui.nowShowEffect1,0.7)
    elseif self.leftIndex==6 then
        GUI:Effect_Create(self.ui.effectNode,"nowShowEffect1",346,286,2,self.cfg[name].effectId,0,1,5,1)
    elseif self.leftIndex==7 then
        GUI:Effect_Create(self.ui.effectNode,"nowShowEffect1",346,286,2,self.cfg[name].effectId,0,1,5,1)
    end
end


--#region 后端消息刷新ui
function DisguiseOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["info"] = function ()
            removeOBJ(self.ui.nowTagImg,self)
            GUI:Image_Create(self.ui["showItem"..self.rightIndex],"nowTagImg",1,15,"res/custom/npc/20zb/wx1.png")
            GUI:setVisible(self.ui.showBtn,false)
            GUI:setVisible(self.ui.hideBtn,true)
        end,
        ["hide"] = function ()
            removeOBJ(self.ui.nowTagImg,self)
            GUI:setVisible(self.ui.showBtn,true)
            GUI:setVisible(self.ui.hideBtn,false)
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

local function moveEvent(data)
    local actorID = data and data.id
    if actorID then
        local posX = SL:GetMetaValue("ACTOR_POSITION_X", actorID)
        local posY = SL:GetMetaValue("ACTOR_POSITION_Y", actorID)
        local dir = SL:GetMetaValue("ACTOR_DIR", actorID)
        local effectModel = SL:GetMetaValue("ACTOR_GM_DATA", actorID)[1]
        local effectID = SL:GetMetaValue("ACTOR_GM_DATA", actorID)[2]
        if effectID ~= 0 and posX and posY then
            local actBegin = data.act
            if actBegin == 1 or actBegin == 6 or actBegin == 17 then
                local eff = GUI:Effect_Create(GUI:Attach_SceneB(),
                    string.format("foot_effect%s_%s%s", actorID, posX, posY), posX, posY, effectModel, effectID, 0, 0,
                    dir, 0.8)
                GUI:setScale(eff, 0.3)
                if eff then
                    GUI:Effect_addOnCompleteEvent(eff, function()
                        GUI:removeFromParent(eff)
                    end)
                end
            end
        end
    end
end
SL:RegisterLUAEvent(LUA_EVENT_PLAYER_ACTION_BEGIN, "GUIUtil", moveEvent)
SL:RegisterLUAEvent(LUA_EVENT_NET_PLAYER_ACTION_BEGIN, "GUIUtil", moveEvent)

return DisguiseOBJ