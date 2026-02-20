local EquipMasterOBJ = {}
EquipMasterOBJ.Name = "EquipMasterOBJ"
EquipMasterOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
EquipMasterOBJ.NpcId = 10001
EquipMasterOBJ.cfg = GetConfig("EquipMasterCfg")
local suit ={
    "<部位强化套装说明：/FCOLOR=251>\\<全身部位强化达到以下星级别，获得套装属性加成/FCOLOR=253>\\<P S：人物等级满100级生效/FCOLOR=7>"
    .."\\<全身 8 0 星/FCOLOR=249><  →  /FCOLOR=7><全属性+8%/FCOLOR=250><  人物等级+1/FCOLOR=254>"
    .."\\<全身100星/FCOLOR=249><  →  /FCOLOR=7><全属性+10%/FCOLOR=250><  人物等级+2/FCOLOR=254>"
    .."\\<全身110星/FCOLOR=249><  →  /FCOLOR=7><全属性+12%/FCOLOR=250><  人物等级+3/FCOLOR=254>"
    .."\\<全身120星/FCOLOR=249><  →  /FCOLOR=7><全属性+14%/FCOLOR=250><  人物等级+4/FCOLOR=254>"
    .."\\<全身130星/FCOLOR=249><  →  /FCOLOR=7><全属性+16%/FCOLOR=250><  人物等级+5/FCOLOR=254>"
    .."\\<全身140星/FCOLOR=249><  →  /FCOLOR=7><全属性+18%/FCOLOR=250><  人物等级+6/FCOLOR=254>"
    .."\\<全身150星/FCOLOR=249><  →  /FCOLOR=7><全属性+20%/FCOLOR=250><  人物等级+7/FCOLOR=254>"
}
local oddTab ={
    "<部位强化成功率：/FCOLOR=251>\\<强化  1星/FCOLOR=249><  →  /FCOLOR=7><成功率：100%/FCOLOR=250>"
    .."\\<强化  2星/FCOLOR=249><  →  /FCOLOR=7><成功率：100%/FCOLOR=250>\\<强化  3星/FCOLOR=249><  →  /FCOLOR=7><成功率：100%/FCOLOR=250>"
    .."\\<强化  4星/FCOLOR=249><  →  /FCOLOR=7><成功率：75%/FCOLOR=250>\\<强化  5星/FCOLOR=249><  →  /FCOLOR=7><成功率：75%/FCOLOR=250>"
    .."\\<强化  6星/FCOLOR=249><  →  /FCOLOR=7><成功率：50%/FCOLOR=250>\\<强化  7星/FCOLOR=249><  →  /FCOLOR=7><成功率：50%/FCOLOR=250>"
    .."\\<强化  8星/FCOLOR=249><  →  /FCOLOR=7><成功率：25%/FCOLOR=250>\\<强化  9星/FCOLOR=249><  →  /FCOLOR=7><成功率：20%/FCOLOR=250>"
    .."\\<强化10星/FCOLOR=249><  →  /FCOLOR=7><成功率：15%/FCOLOR=250>\\<强化11星/FCOLOR=249><  →  /FCOLOR=7><成功率：10%/FCOLOR=250>"
    .."\\<强化12星/FCOLOR=249><  →  /FCOLOR=7><成功率：8%/FCOLOR=250>\\<强化13星/FCOLOR=249><  →  /FCOLOR=7><成功率：6%/FCOLOR=250>"
    .."\\<强化14星/FCOLOR=249><  →  /FCOLOR=7><成功率：4%/FCOLOR=250>\\<强化15星/FCOLOR=249><  →  /FCOLOR=7><成功率：2%/FCOLOR=250>"
}

function EquipMasterOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/EquipMasterUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self.leftIndex=nil
    self:refreshLeftList()
    for i = 1, 10, 1 do
        local position = self.cfg[i]["type_arr"][2]
        if SL:GetMetaValue("EQUIPBYPOS", position) ~= "" then
            self:refreshMidNode(i)
            break
        end
    end

    self:initBtn()
end

function EquipMasterOBJ:initBtn()
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("EquipMasterOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("EquipMasterOBJ")
    end)
    GUI:addOnClickEvent(self.ui.suitBtn,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.suitBtn)
        GUI:ShowWorldTips(suit[1], worldPos, GUI:p(1, 1))
    end)
    GUI:addOnClickEvent(self.ui.suitBtnText,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.suitBtnText)
        GUI:ShowWorldTips(suit[1], worldPos, GUI:p(1, 1))
    end)
    GUI:addOnClickEvent(self.ui.oddBtn,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.oddBtn)
        GUI:ShowWorldTips(oddTab[1], worldPos, GUI:p(1, 1))
    end)
    GUI:addOnClickEvent(self.ui.oddBtnText,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.oddBtnText)
        GUI:ShowWorldTips(oddTab[1], worldPos, GUI:p(1, 1))
    end)
    GUI:addOnClickEvent(self.ui.luckBtn,function ()
        if self.leftIndex == nil or not self.ui.nowEquip then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先穿戴一件装备再来强化！</font>")
        end
        SendMsgCallFunByNpc(self.NpcId, "EquipMaster", "luck", self.leftIndex)
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        if self.leftIndex == nil or not self.ui.nowEquip then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先穿戴一件装备再来强化！</font>")
        end
        SendMsgCallFunByNpc(self.NpcId, "EquipMaster", "upEvent", self.leftIndex)
    end)
end

function EquipMasterOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftBtnList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for i = 1, 10, 1 do
        local position = self.cfg[i]["type_arr"][2]
        if SL:GetMetaValue("EQUIPBYPOS", position) == "" then
            goto continue
        end
        local box = GUI:Image_Create(self.ui.leftBtnList,"leftBox"..i,0,0,"res/custom/npc/z2.png")
        local text = GUI:Text_Create(box,"equipType"..i,42,16,16,"#FFFFFF",self.cfg[i]["type_arr"][1])
        GUI:setAnchorPoint(text,0.5,0.5)
        local nowEquipStar = GameData.GetData("U_equipStar"..position,false)or 0 --#region 当前装备位星
        GUI:Image_Create(text,"equipStar"..i,36,3,"res/custom/npc/25bwqh/xx"..nowEquipStar..".png")
        GUI:setLocalZOrder(text, 20)
        local layout = GUI:Layout_Create(box,"leftLayout"..i,0,0,114,34,true)
        GUI:setTouchEnabled(layout, true)
        GUI:addOnClickEvent(layout,function ()
            if self.leftIndex == i then
                return
            end
            self:refreshMidNode(i)
        end)
        GUI:setVisible(box,false)
        time = time +0.05
        GUI:runAction(box,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(box,true)
            GUI:setPositionX(box,-114)
            GUI:runAction(box,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(box))))
        end)))
        ::continue::
    end
end

function EquipMasterOBJ:refreshMidNode(leftIndex) --#region 刷新nodeBox
    self.leftIndex = leftIndex
    if (tonumber(GameData.GetData("U_equipLuck", false)) or 0)>0 then
        SendMsgCallFunByNpc(self.NpcId, "EquipMaster", "judgeEvent", leftIndex)
    end
    removeOBJ(self.ui.leftMask,self)
    GUI:Image_Create(self.ui["leftBox"..leftIndex],"leftMask",0,0,"res/custom/npc/z3.png")
    local position = self.cfg[leftIndex]["type_arr"][2]
    local equipStar = tonumber(GameData.GetData("U_equipStar"..position,false)or 0) --#region 当前装备位星
    GUI:Text_setString(self.ui.starText,"+"..equipStar.."星")
    removeOBJ(self.ui.nowEquip,self)
    GUI:ItemShow_Create(self.ui.nowEquipBg,"nowEquip",40,36,{look=true,itemData=GUIFunction:GetEquipDataByPos(position,false, 0)})
    GUI:setAnchorPoint(self.ui.nowEquip,0.5,0.5)
    local addInfoTab={"10","12","14","16","18","20","30","40","50","60","70","80","90","100","120"}
    GUI:Text_setString(self.ui.infoText_13, "+"..(addInfoTab[equipStar] or 0).."%")
    GUI:Text_setString(self.ui.infoText_23, "+"..(addInfoTab[equipStar+1] or addInfoTab[#equipStar]).."%")
    -- local typeIndex = self.cfg[leftIndex]["type_arr"][3]
    -- if equipStar>=#self.cfg then
    --     GUI:Text_setString(self.ui.oddText,"强化成功率:"..self.cfg[equipStar]["odd"].."%")
    --     for i = 1, 2 do
    --         GUI:Text_setString(self.ui["text"..i.."12"], "+"..self.cfg[equipStar]["text_arr1"][2].."%")
    --         GUI:Text_setString(self.ui["text"..i.."21"], self.cfg[leftIndex]["text_arr"..typeIndex][1].."：")
    --         GUI:Text_setString(self.ui["text"..i.."22"], "+"..self.cfg[equipStar]["text_arr"..typeIndex][2].."%")
    --     end
    -- elseif equipStar==0 then
    --     GUI:Text_setString(self.ui.oddText,"强化成功率:"..self.cfg[equipStar+1]["odd"].."%")
    --     GUI:Text_setString(self.ui["text112"], "+0%")
    --     GUI:Text_setString(self.ui["text212"], "+"..self.cfg[equipStar+1]["text_arr1"][2].."%")
    --     GUI:Text_setString(self.ui["text122"], "+0%")
    --     GUI:Text_setString(self.ui["text222"], "+"..self.cfg[equipStar+1]["text_arr"..typeIndex][2].."%")
    --     for i = 1, 2 do
    --         GUI:Text_setString(self.ui["text"..i.."21"], self.cfg[leftIndex]["text_arr"..typeIndex][1].."：")
    --     end
    -- else
    --     GUI:Text_setString(self.ui.oddText,"强化成功率:"..self.cfg[equipStar+1]["odd"].."%")
    --     for i = 1, 2 do
    --         GUI:Text_setString(self.ui["text"..i.."12"], "+"..self.cfg[equipStar+i-1]["text_arr1"][2].."%")
    --         GUI:Text_setString(self.ui["text"..i.."21"], self.cfg[leftIndex]["text_arr"..typeIndex][1].."：")
    --         GUI:Text_setString(self.ui["text"..i.."22"], "+"..self.cfg[equipStar+i-1]["text_arr"..typeIndex][2].."%")
    --     end
    -- end
    -- for i = 1, 2 do
    --     GUI:setVisible(self.ui["infoTextNode"..i],true)
    --     GUI:setContentSize(self.ui["text"..i.."11"],64+GUI:getContentSize(self.ui["text"..i.."12"]).width
    --     ,GUI:getContentSize(self.ui["text"..i.."11"]).height)
    --     GUI:setContentSize(self.ui["text"..i.."21"],80+GUI:getContentSize(self.ui["text"..i.."22"]).width
    --     ,GUI:getContentSize(self.ui["text"..i.."21"]).height)
    -- end

    for i = 1, 2 do
        GUI:UserUILayout(self.ui["infoTextNode"..i], {dir=1,addDir=2,interval=0.5,gap = {y=4},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
    self:refreshLuckBtn()
    self:refreshNeedItem(equipStar)
end

function EquipMasterOBJ:refreshNeedItem(equipStar) --#region 刷新物品
    GUI:removeAllChildren(self.ui.needItemNode)
    self.ui = GUI:ui_delegate(self._parent)
    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[equipStar+1] or (self.cfg[equipStar+1] and self.cfg[equipStar+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        local itemColor = 249
        for j = 1, self.cfg[equipStar+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[equipStar+1][keyName]
            itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",itemName)
            itemCount = self.cfg[equipStar+1][keyItemCount]
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
end

function EquipMasterOBJ:refreshLuckBtn() --#region 刷新幸运按钮和几率
    local position = self.cfg[self.leftIndex]["type_arr"][2]
    local equipStar = tonumber(GameData.GetData("U_equipStar"..position,false)) or 0
    local tag = tonumber(GameData.GetData("U_equipLuck", false)) or 0
    local odd = (self.cfg[equipStar+1] and self.cfg[equipStar+1]["odd"]) or 2
    if tag == 0 then
        GUI:Button_loadTextureNormal(self.ui.luckBtn, "res/custom/npc/g0.png")
    else
        odd = odd +10
        GUI:Button_loadTextureNormal(self.ui.luckBtn, "res/custom/npc/g1.png")
    end
    GUI:Text_setString(self.ui.oddText,"强化成功率:"..odd.."%")
end

--#region 后端消息刷新ui
function EquipMasterOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["成功"] = function()
            local position = self.cfg[self.leftIndex]["type_arr"][2]
            local equipStar = GameData.GetData("U_equipStar"..position,false)or 0 --#region 当前装备位星
            GUI:Image_loadTexture(self.ui["equipStar"..self.leftIndex],"res/custom/npc/25bwqh/xx"..equipStar..".png")
            self:refreshMidNode(self.leftIndex)
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode,"theEndEffect",478,300,0,14808,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
        end,
        ["失败"] = function()
            local position = self.cfg[self.leftIndex]["type_arr"][2]
            local equipStar = GameData.GetData("U_equipStar"..position,false)or 0 --#region 当前装备位星
            GUI:Image_loadTexture(self.ui["equipStar"..self.leftIndex],"res/custom/npc/25bwqh/xx"..equipStar..".png")
            self:refreshMidNode(self.leftIndex)
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode,"theEndEffect",478,300,0,14809,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
        end,
        ["luck"] = function()
            self:refreshLuckBtn()
        end,
    }
    functionTab[tab[1]]()
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if EquipMasterOBJ.NpcId == npc_info.index then
        SendMsgClickNpc(EquipMasterOBJ.NpcId.."#EquipMaster")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "EquipMasterOBJ", onClickNpc)

return EquipMasterOBJ