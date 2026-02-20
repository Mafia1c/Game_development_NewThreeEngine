local EquipMagicOBJ = {}
EquipMagicOBJ.Name = "EquipMagicOBJ"
EquipMagicOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
EquipMagicOBJ.NpcId = 89
EquipMagicOBJ.cfg = GetConfig("EquipMagicCfg")
local position ={13,9,12,2,14}
local equipTab={"终极斗笠","终极护符","终极血石","终极勋章","终极军鼓"}
local starRtext ={ "<%s阶附加属性：/FCOLOR=251>\\<附魔%s星时激活附加属性/FCOLOR=250>\\<%s：%s/FCOLOR=253>" }

function EquipMagicOBJ:main(starStr)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/EquipMagicUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:refreshStarTab(starStr)
    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshLeftList()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("EquipMagicOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("EquipMagicOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        if SL:GetMetaValue("EQUIPBYPOS", position[self.leftIndex]) ~= equipTab[self.leftIndex] then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先穿戴"..equipTab[self.leftIndex].."装备再来附魔！</font>")
        end
        SendMsgCallFunByNpc(self.NpcId, "EquipMagic", "upEvent", self.leftIndex)
    end)
end
function EquipMagicOBJ:refreshStarTab(starStr)
    self.starTab = SL:JsonDecode(starStr, false) or {}
    if self.starTab=="" then self.starTab={} end
    for i = 1, 5 do
        self.starTab[i]=tonumber(self.starTab[i]) or 0
    end
end

function EquipMagicOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftBtnList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for i = 1, 5 do
        local btn = GUI:Button_Create(self.ui.leftBtnList,"leftBtn"..i,0,0,"res/custom/npc/ta1.png")
        GUI:Button_loadTexturePressed(btn,"res/custom/npc/ta0.png")
        GUI:Button_setTitleText(btn, self.cfg[i]["type"])
        GUI:Button_setTitleColor(btn, "#BDBDB5")
        GUI:Button_setTitleFontSize(btn, 18)
        GUI:addOnClickEvent(btn,function ()
            if self.leftIndex == i then
                return
            end
            self:refreshMidNode(i)
        end)
        GUI:setVisible(btn,false)
        time = time +0.05
        GUI:runAction(btn,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(btn,true)
            GUI:setPositionX(btn,-120)
            GUI:runAction(btn,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(btn))))
        end)))
    end
    self:refreshMidNode(1)
end

function EquipMagicOBJ:refreshMidNode(leftIndex)
    self.leftIndex = leftIndex
    for i = 1, 5 do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..i],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..i], "#BDBDB5")
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")
    local activeTab = {3,6,9,12,15}
    for i = 1, 5 do
        GUI:Button_loadTextureNormal(self.ui["tipsBtn"..i],"res/custom/npc/33teshu/"..(leftIndex-1).."_"..i..".png")
        if (self.starTab[leftIndex] or 0)<activeTab[i] then
            GUI:setGrey(self.ui["tipsBtn"..i], true)
        else
            GUI:setGrey(self.ui["tipsBtn"..i], false)
        end
        GUI:addOnClickEvent(self.ui["tipsBtn"..i],function ()
            local worldPos = GUI:getTouchEndPosition(self.ui["tipsBtn"..i])
            GUI:ShowWorldTips(string.format(starRtext[1],i,activeTab[i],self.cfg[leftIndex]["tag"],self.cfg[activeTab[i]]["text3"].."%"), worldPos, GUI:p(1, 1))
        end)
    end
    removeOBJ(self.ui.nowEquip,self)
    if SL:GetMetaValue("EQUIPBYPOS", position[leftIndex]) ~= "" then
        GUI:ItemShow_Create(self.ui.equipNode,"nowEquip",499,396
        ,{look=true,itemData=GUIFunction:GetEquipDataByPos(position[leftIndex],false, 0)})
        GUI:setAnchorPoint(self.ui.nowEquip,0.5,0.5)
    end
    GUI:Text_setString(self.ui.equipName, SL:Get_EQUIPBYPOS(position[leftIndex]))

    if self.starTab[leftIndex]==#self.cfg then
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text"..i.."12"],self.cfg[self.starTab[leftIndex]]["text1"])
            GUI:Text_setString(self.ui["text"..i.."22"], self.cfg[self.starTab[leftIndex]]["text2"])
            GUI:Text_setString(self.ui["text"..i.."32"], self.cfg[self.starTab[leftIndex]]["text3"].."%")
        end
        GUI:Text_setString(self.ui.oddText,self.cfg[self.starTab[leftIndex]]["odd_arr"][1].."%")
        GUI:Text_setString(self.ui.subOddText,"(降级概率："..(self.cfg[self.starTab[leftIndex]]["odd_arr"][2]-1).."%，附魔10星后失败几率降级)")
    else
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text"..i.."12"],self.cfg[self.starTab[leftIndex]+i-1]["text1"])
            GUI:Text_setString(self.ui["text"..i.."22"], self.cfg[self.starTab[leftIndex]+i-1]["text2"])
            GUI:Text_setString(self.ui["text"..i.."32"], self.cfg[self.starTab[leftIndex]+i-1]["text3"].."%")
        end
        GUI:Text_setString(self.ui.oddText,self.cfg[self.starTab[leftIndex]+1]["odd_arr"][1].."%")
        GUI:Text_setString(self.ui.subOddText,"(降级概率："..(self.cfg[self.starTab[leftIndex]+1]["odd_arr"][2]-1).."%，附魔10星后失败几率降级)")
    end
    local width={64,64,80}
    GUI:Text_setString(self.ui.text131,self.cfg[leftIndex]["tag"].."：")
    GUI:Text_setString(self.ui.text231,self.cfg[leftIndex]["tag"].."：")
    if leftIndex==4 or leftIndex==5 then
        width[3]=68
    end
    GUI:setPositionX(self.ui["text132"], width[3])

    for i = 1, 3 do
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

function EquipMagicOBJ:refreshNeedItem()
    GUI:removeAllChildren(self.ui.needItemNode)
    self.ui = GUI:ui_delegate(self._parent)
    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[self.starTab[self.leftIndex]+1] or (self.cfg[self.starTab[self.leftIndex]+1] and self.cfg[self.starTab[self.leftIndex]+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        local itemColor = 249
        for j = 1, self.cfg[self.starTab[self.leftIndex]+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[self.starTab[self.leftIndex]+1][keyName]
            itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",itemName)
            itemCount = self.cfg[self.starTab[self.leftIndex]+1][keyItemCount]
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
    GUI:UserUILayout(self.ui["needItemNode"], {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    if self.starTab[self.leftIndex]>=#self.cfg then
        GUI:removeAllChildren(self.ui.needItemNode)
        self.ui = GUI:ui_delegate(self._parent)
        GUI:setVisible(self.ui.upBtn,false)
        GUI:setVisible(self.ui.maxImg,true)
    else
        GUI:setVisible(self.ui.upBtn,true)
        GUI:setVisible(self.ui.maxImg,false)
    end
end

--#region 后端消息刷新ui
function EquipMagicOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["提升"] = function ()
            self:refreshStarTab(tab[2])
            self:refreshMidNode(self.leftIndex)
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode,"theEndEffect",478,300,0,14849,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
        end,
        ["失败"] = function ()
            self:refreshStarTab(tab[2])
            self:refreshMidNode(self.leftIndex)
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode,"theEndEffect",478,300,0,14859,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
        end,
    }
    functionTab[tab[1]]()
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if EquipMagicOBJ.NpcId == npc_info.index then
        -- ViewMgr.open("EquipMagicOBJ")
        SendMsgClickNpc(EquipMagicOBJ.NpcId.."#EquipMagic")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "EquipMagicOBJ", onClickNpc)

return EquipMagicOBJ