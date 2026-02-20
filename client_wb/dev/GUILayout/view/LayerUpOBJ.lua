local LayerUpOBJ = {}
LayerUpOBJ.Name = "LayerUpOBJ"
LayerUpOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
LayerUpOBJ.NpcId = 148
LayerUpOBJ.cfg = GetConfig("LayerUpCfg")

function LayerUpOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LayerUpUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshLeftList()
    self:selectLeft()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("LayerUpOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("LayerUpOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.NpcId, "LayerUp", "upEvent", "")
    end)
end

function LayerUpOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftBtnList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg) do
        local btn = GUI:Button_Create(self.ui.leftBtnList,"leftBtn"..index,0,0,"res/custom/npc/ta1.png")
        GUI:Button_loadTexturePressed(btn,"res/custom/npc/ta0.png")
        GUI:Button_setTitleText(btn, value["type"])
        GUI:Button_setTitleColor(btn, "#BDBDB5")
        GUI:Button_setTitleFontSize(btn, 18)
        -- GUI:addOnClickEvent(btn,function ()
        --     if self.leftIndex == index then
        --         return
        --     end
        --     self:leftBtnEvent(index)
        -- end)
        GUI:setVisible(btn,false)
        time = time +0.05
        GUI:runAction(btn,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(btn,true)
            GUI:setPositionX(btn,-120)
            GUI:runAction(btn,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(btn))))
        end)))
    end
end
function LayerUpOBJ:selectLeft()
    self.layer = GameData.GetData("U_LayerUp",false)or 0 --#region 当前layer在表中index
    for index, value in ipairs(self.cfg) do
        if self.layer == index-1 then
            self:refreshMidNode(index)
            break
        elseif self.layer==#self.cfg then
            self:refreshMidNode(#self.cfg)
            break
        end
    end
end

function LayerUpOBJ:refreshMidNode(leftIndex)
    self.leftIndex = leftIndex
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..index], "#BDBDB5")
        GUI:setVisible(self.ui["RText"..index],false)
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")
    GUI:Image_loadTexture(self.ui.layerImg, "res/custom/npc/31fs/fs"..leftIndex..".png")
    GUI:setVisible(self.ui["RText"..leftIndex],true)

    if self.layer==#self.cfg then
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text"..i.."12"],self.cfg[self.layer]["text1"].."%")
            GUI:Text_setString(self.ui["text"..i.."22"], self.cfg[self.layer]["text2"].."-"..self.cfg[self.layer]["text2"])
            GUI:Text_setString(self.ui["text"..i.."32"], self.cfg[self.layer]["text3"].."-"..self.cfg[self.layer]["text3"])
            GUI:Text_setString(self.ui["text"..i.."42"], self.cfg[self.layer]["text4"].."%")
        end
    else
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text"..i.."12"],self.cfg[self.layer+i-1]["text1"].."%")
            GUI:Text_setString(self.ui["text"..i.."22"], self.cfg[self.layer+i-1]["text2"].."-"..self.cfg[self.layer+i-1]["text2"])
            GUI:Text_setString(self.ui["text"..i.."32"], self.cfg[self.layer+i-1]["text3"].."-"..self.cfg[self.layer+i-1]["text3"])
            GUI:Text_setString(self.ui["text"..i.."42"], self.cfg[self.layer+i-1]["text4"].."%")
        end
    end
    local width={55,64,64,80}
    for i = 1, 4 do
        GUI:setContentSize(self.ui["text1"..i.."1"],width[i]+GUI:getContentSize(self.ui["text1"..i.."2"]).width
        ,GUI:getContentSize(self.ui["text1"..i.."1"]).height)
        GUI:setContentSize(self.ui["text2"..i.."1"],width[i]+GUI:getContentSize(self.ui["text2"..i.."2"]).width
        ,GUI:getContentSize(self.ui["text2"..i.."1"]).height)
    end
    for i = 1, 2 do
        GUI:UserUILayout(self.ui["infoNode"..i], {dir=1,addDir=2,interval=0.5,gap = {y=2},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -2,-2)) < tonumber(string.sub(GUI:getName(b), -2,-2))
            end)
        end})
    end
    self:refreshNeedItem()
end

function LayerUpOBJ:refreshNeedItem()
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
    GUI:UserUILayout(self.ui["needItemNode"], {dir=2,addDir=2,interval=0.5,gap = {x=4},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    if self.layer>=#self.cfg then
        GUI:removeAllChildren(self.ui.needItemNode)
        self.ui = GUI:ui_delegate(self._parent)
        GUI:setVisible(self.ui.upBtn,false)
        GUI:setVisible(self.ui.maxImg,true)
    end
end

--#region 后端消息刷新ui
function LayerUpOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["提升"] = function ()
            self:selectLeft()
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode,"theEndEffect",478,300,0,14860,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
        end,
    }
    functionTab[tab[1]]()
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if LayerUpOBJ.NpcId == npc_info.index then
        SendMsgClickNpc(LayerUpOBJ.NpcId.."#LayerUp")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "LayerUpOBJ", onClickNpc)

return LayerUpOBJ