local LifeUpOBJ = {}
LifeUpOBJ.Name = "LifeUpOBJ"
LifeUpOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
LifeUpOBJ.NpcId = {69,93,119}
LifeUpOBJ.cfg = GetConfig("LifeUpCfg")
local ballPosition ={{228,268},{211,331},{238,388},{286,424},{354,438},{423,424},{477,388},{501,331},{480,268}}


function LifeUpOBJ:main(nowNpcId)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LifeUpUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.nowNpcId=tonumber(nowNpcId) --#regoin 当前打开npcId
    if nowNpcId==nil or nowNpcId=="" then self.nowNpcId=0 end
    self.layer = GameData.GetData("U_lifeUp",false)or 0 --#region 当前layer在表中index
    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshMidNode()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("LifeUpOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("LifeUpOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.nowNpcId, "LifeUp", "upEvent", self.nowNpcId)
    end)
end

function LifeUpOBJ:refreshMidNode()
    local zsLevel = SL:Get_RELEVEL()
    local job = SL:Get_JOB()
    local ball = (self.layer)%10
    if ball==0 then
        GUI:removeAllChildren(self.ui.ballNode2)
        self.ui = GUI:ui_delegate(self._parent)
        zsLevel=self.layer/10
    end
    GUI:Text_setString(self.ui.layerText,zsLevel.."转")
    for i = 1, ball do
        if not self.ui["ball"..i] then
            local effect = GUI:Effect_Create(self.ui.ballNode2, "ball"..i, ballPosition[i][1], ballPosition[i][2]
            , 0, 14869, 0,0, 0, 1)
        end
    end
    GUI:Text_setString(self.ui.ballText,"转生进度："..ball.." / 9")
    if ball==9 then GUI:Button_setTitleText(self.ui.upBtn, "轮回")
    else GUI:Button_setTitleText(self.ui.upBtn, "转生") end

    if self.layer==0 then
        GUI:Text_setString(self.ui["text112"],"0%")
        GUI:Text_setString(self.ui["text122"],"0%")
        GUI:Text_setString(self.ui["text212"],self.cfg[self.layer+1]["text"..job].."%")
        GUI:Text_setString(self.ui["text222"], self.cfg[self.layer+1]["text3"].."%")
    elseif self.layer==#self.cfg then
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text"..i.."12"],self.cfg[self.layer]["text"..job].."%")
            GUI:Text_setString(self.ui["text"..i.."22"], self.cfg[self.layer]["text3"].."%")
        end
    else
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text"..i.."12"],self.cfg[self.layer+i-1]["text"..job].."%")
            GUI:Text_setString(self.ui["text"..i.."22"], self.cfg[self.layer+i-1]["text3"].."%")
        end
    end
    for i = 1, 2 do
        GUI:setContentSize(self.ui["text1"..i.."1"],80+GUI:getContentSize(self.ui["text1"..i.."2"]).width
        ,GUI:getContentSize(self.ui["text1"..i.."1"]).height)
        GUI:setContentSize(self.ui["text2"..i.."1"],80+GUI:getContentSize(self.ui["text2"..i.."2"]).width
        ,GUI:getContentSize(self.ui["text2"..i.."1"]).height)
        GUI:UserUILayout(self.ui["infoNode"..i], {dir=1,addDir=2,interval=0.5,gap = {y=6},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
    self:refreshNeedItem()
    if zsLevel>=10 then
        GUI:setVisible(self.ui.getText, true)
        GUI:addOnClickEvent(self.ui.getText,function ()
            SendMsgCallFunByNpc(self.nowNpcId, "LifeUp", "getEvent","")
        end)
    else
        GUI:setVisible(self.ui.getText, false)
    end
end

function LifeUpOBJ:refreshNeedItem()
    GUI:removeAllChildren(self.ui.needItemNode)
    self.ui = GUI:ui_delegate(self._parent)
    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[self.layer+1] or (self.cfg[self.layer+1] and self.cfg[self.layer+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        local itemColor = 249
        for j = 1, self.cfg[self.layer+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[self.layer+1][keyName]
            itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",itemName)
            itemCount = self.cfg[self.layer+1][keyItemCount]
            itemColor = 249
            if i==1 then
                if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) >= itemCount then
                    itemColor = 250
                end
                number=number+1
                local item = GUI:ItemShow_Create(self.ui.needItemNode, "need_item"..number, 0, 0, {index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true})
                ItemShow_updateItem(item,{index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true,showCount=true})
            elseif i==2 then
                if tonumber(SL:GetMetaValue("MONEY", itemIndex)) >= itemCount then
                    itemColor = 250
                end
                number=number+1
                local item = GUI:ItemShow_Create(self.ui.needItemNode, "need_item"..number, 0, 0, {index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true})
                ItemShow_updateItem(item,{index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true,showCount=true})
            elseif i==3 then
                if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", itemIndex)) >= itemCount then
                    itemColor = 250
                end
                number=number+1
                local item = GUI:ItemShow_Create(self.ui.needItemNode, "need_item"..number, 0, 0, {index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true})
                ItemShow_updateItem(item,{index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true,showCount=true})
            end
        end
        ::continue::
    end
    GUI:UserUILayout(self.ui["needItemNode"], {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    if (self.nowNpcId==69 and self.layer>=100) or (self.nowNpcId==93 and self.layer>=150) or self.layer>=#self.cfg then
        GUI:Text_setString(self.ui.ballText,"转生进度：9 / 9")
        for i = 1, 9 do
            if not self.ui["ball"..i] then
                local effect = GUI:Effect_Create(self.ui.ballNode2, "ball"..i, ballPosition[i][1], ballPosition[i][2]
                , 0, 14869, 0,0, 0, 1)
            end
        end
        GUI:removeAllChildren(self.ui.needItemNode)
        self.ui = GUI:ui_delegate(self._parent)
        GUI:setVisible(self.ui.upBtn,false)
        GUI:setVisible(self.ui.maxImg,true)
    end
end

--#region 后端消息刷新ui
function LifeUpOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["提升"] = function ()
            self:refreshMidNode()
        end,
    }
    self.layer = GameData.GetData("U_lifeUp",false)or 0 --#region 当前layer在表中index
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "LifeUpOBJ",["node"] = self,["is_all"] = true})
end

function LifeUpOBJ:UpBtnRed()
    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local cfg = LifeUpOBJ.cfg[LifeUpOBJ.layer+1]
    if not cfg then return false end
    for i = 1, 3 do 
        local itemIndex = 0
        local itemCount = 0
        if (cfg and cfg["number_arr"][i]~=0) then
            for j = 1, cfg["number_arr"][i] do --#region 物品种类数量
                local keyName = typeName[i][1]..j
                local keyItemCount = typeName[i][2]..j
                local itemName = cfg[keyName]
                itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",itemName)
                itemCount = cfg[keyItemCount]
                if i==1 then
                    if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) < itemCount then
                        return false
                    end
                elseif i==2 then
                    if tonumber(SL:GetMetaValue("MONEY", itemIndex)) < itemCount then
                        return false
                    end
                elseif i==3 then
                    if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", itemIndex)) < itemCount then
                        return false
                    end
                end
            end
        end
    end
    return true
end
return LifeUpOBJ