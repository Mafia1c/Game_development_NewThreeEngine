local CompoundAnimalOBJ = {}
CompoundAnimalOBJ.Name = "CompoundAnimalOBJ"
CompoundAnimalOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
CompoundAnimalOBJ.NpcId = {65,91,121}
CompoundAnimalOBJ.cfg = GetConfig("CompoundAnimalCfg") --#region 合成
CompoundAnimalOBJ.cfg4 = GetConfig("CompoundAnimalCfg2") --#region 注灵
CompoundAnimalOBJ.cfg2={"神话·鼠","神话·牛","神话·虎","神话·兔","神话·龙","神话·蛇","神话·马","神话·羊","神话·猴","神话·鸡","神话·狗","神话·猪"}--注灵
CompoundAnimalOBJ.cfg3={["30"]={"体力增加",1},["26"]={"物伤减少",1},["27"]={"魔伤减少",1},["35"]={"攻魔道伤",100},["36"]={"防御加成",100}
,["37"]={"魔防加成",100},["76"]={"PK增伤",100},["77"]={"PK减伤",100},["85"]={"破防抵抗",100},["23"]={"暴击减少",1},["24"]={"暴击抵抗",1}
,["299"]={"人物等级",1,1}}
local tips ={
    "<生肖注灵 随机获得 1-3 条属性：/FCOLOR=254>\\1. <体力增加/FCOLOR=251> → 随机 <10-20/FCOLOR=250>\\2. <物伤减少/FCOLOR=251> → 随机 <10-20/FCOLOR=250>"
    .."\\3. <魔伤减少/FCOLOR=251> → 随机 <10-20/FCOLOR=250>\\4. <攻魔道伤/FCOLOR=251> → 随机 <5-10/FCOLOR=250>"
    .."\\5. <防御加成/FCOLOR=251> → 随机 <10-20/FCOLOR=250>\\6. <魔防加成/FCOLOR=251> → 随机 <10-20/FCOLOR=250>"
    .."\\7. <PK增伤/FCOLOR=251> → 随机 <5-10/FCOLOR=250>\\8. <PK减伤/FCOLOR=251> → 随机 <5-10/FCOLOR=250>"
    .."\\9. <破防抵抗/FCOLOR=251> → 随机 <10-20/FCOLOR=250>\\10. <暴击减少/FCOLOR=251> → 随机 <10-20/FCOLOR=250>"
    .."\\11. <暴击抵抗/FCOLOR=251> → 随机 <10-20/FCOLOR=250>\\12. <等级+1/FCOLOR=245> → <人物100级生效/FCOLOR=245>"
}

function CompoundAnimalOBJ:main(nowNpcId,leftIndex,rightIndex)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/CompoundAnimalUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.nowNpcId = tonumber(nowNpcId)
    self.leftIndex = tonumber(leftIndex) or 1 
    self.rightIndex = tonumber(rightIndex) or 1 
    if nowNpcId==nil or nowNpcId=="" then self.nowNpcId=0 end
    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshLeftList()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("CompoundAnimalOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("CompoundAnimalOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn11, function() --#region 背包合成
        SendMsgCallFunByNpc(0, "CompoundAnimal", "upEvent11", self.leftIndex.."#"..self.rightIndex)
    end)
    GUI:addOnClickEvent(self.ui.upBtn12, function() --#region 身上合成
        SendMsgCallFunByNpc(0, "CompoundAnimal", "upEvent12", self.leftIndex.."#"..self.rightIndex)
    end)
    GUI:addOnClickEvent(self.ui.tipsBtn2,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn2)
        GUI:ShowWorldTips(tips[1], worldPos, GUI:p(1, 1))
    end)
    GUI:addOnClickEvent(self.ui.leftLayout21, function()
        self:leftBtnEvent(1,2)
    end)
    GUI:addOnClickEvent(self.ui.upBtn21, function() --#region 灵符注灵
        SendMsgCallFunByNpc(0,"CompoundAnimal","upEvent3",self.rightIndex)
    end)
    SL:RegisterLUAEvent(LUA_EVENT_TAKE_ON_EQUIP, "CompoundAnimalOBJ", equipTake)
end

function CompoundAnimalOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftBoxList1)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg) do
        if self.nowNpcId==65 and index>1 then --#region 1大陆npc打开
            goto continue
        elseif self.nowNpcId==91 and (index<2 or index>3) then --#region 2大陆npc打开
            goto continue
        elseif self.nowNpcId==121 and index <4 then --#region 3大陆npc打开
            GUI:setVisible(self.ui.leftImg2,true)
            goto continue
        elseif self.nowNpcId=="" then --#region 气泡打开
            if index>1 and (GameData.GetData("U_bigMap",false)or 0) < index then
                goto continue
            end
            if (GameData.GetData("U_bigMap",false)or 0) >=3 then
                GUI:setVisible(self.ui.leftImg2,true)
            end
        end
        local box = GUI:Image_Create(self.ui.leftBoxList1,"leftBox1"..index,0,0,"res/custom/hecheng/bt1.png")
        local text = GUI:Text_Create(box,"leftBoxName1"..index,56,22,16,"#F0B42A",value["type"])
        GUI:setAnchorPoint(text,0.5,0.5)
        GUI:setLocalZOrder(text, 20)
        local layout = GUI:Layout_Create(box,"leftLayout1"..index,0,0,114,44,true)
        GUI:setTouchEnabled(layout, true)
        GUI:addOnClickEvent(layout,function ()
            self:leftBtnEvent(index,1)
        end)
        GUI:setVisible(box,false)
        time = time +0.05
        GUI:runAction(box,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(box,true)
            GUI:setPositionX(box,-120)
            GUI:runAction(box,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(box))))
        end)))
        ::continue::
    end
    if self.leftIndex == 1 then
        for index, value in ipairs(self.cfg) do
            if self.ui["leftLayout1"..index] then
                self:leftBtnEvent(index,1)
                break
            end
        end
    else
        self:leftBtnEvent(self.leftIndex,1)
    end
end

function CompoundAnimalOBJ:leftBtnEvent(leftIndex,tag) --#region tag=1为合成 =2为注灵
    self.leftIndex = leftIndex
    self.tag = tag
    removeOBJ(self.ui.leftMask,self)
    GUI:Image_Create(self.ui["leftBox"..tag..leftIndex],"leftMask",0,0,"res/custom/hecheng/bt3.png")

    GUI:removeAllChildren(self.ui.rightList)
    self.ui = GUI:ui_delegate(self._parent)
    local nowCfg = {} --#region 当前cfg表
    if tag==1 then
        if leftIndex==1 then
            GUI:setPositionX(self.ui.upBtn11,566)
            GUI:setVisible(self.ui.upBtn12, false)
        else
            GUI:setPositionX(self.ui.upBtn11,494)
            GUI:setVisible(self.ui.upBtn12, true)
        end
        GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/hecheng/bg2.png")
        GUI:setVisible(self.ui.midNode1,true)
        GUI:setVisible(self.ui.midNode2,false)
        nowCfg = self.cfg[leftIndex]["item_arr"]
    elseif tag==2 then
        GUI:Image_loadTexture(self.ui.FrameBG, "res/custom/hecheng/bg4.png")
        GUI:setVisible(self.ui.midNode1,false)
        GUI:setVisible(self.ui.midNode2,true)
        nowCfg = self.cfg2
    end

    local time = 0
    for index, value in ipairs(nowCfg) do
        local img = GUI:Image_Create(self.ui.rightList,"rightBox"..index,0,0,"res/custom/npc/z2.png")
        local text = GUI:Text_Create(img,"rightBoxName"..index,58,16,16,"#FFFFFF",value)
        GUI:setAnchorPoint(text,0.5,0.5)
        GUI:setLocalZOrder(text, 20)
        if tag==2 then
            if SL:Get_EQUIPBYPOS(29+index)==value then
                GUI:Text_setTextColor(text,"#00FF00")
            else
                GUI:Text_setTextColor(text,"#7B7373")
            end
        end
        local layout = GUI:Layout_Create(img,"rightLayout"..index,0,0,114,34,true)
        GUI:setTouchEnabled(layout, true)
        GUI:addOnClickEvent(layout,function ()
            if self.tag == tag and self.rightIndex == index then
                return
            end
            if tag==1 then
                self:refreshMidNode1(index)
            elseif tag==2 then
                self:refreshMidNode2(index)
            end
        end)
        GUI:setVisible(img,false)
        time = time +0.05
        GUI:runAction(img,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(img,true)
            GUI:setPositionX(img,114)
            GUI:runAction(img,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(img))))
        end)))
    end
    if tag==1 then
        self:refreshMidNode1(self.rightIndex)
    elseif tag==2 then
        self:refreshMidNode2(1)
    end
     SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "CompoundAnimalOBJ",["node"] = self,["is_all"] = true})
end

function CompoundAnimalOBJ:refreshMidNode1(rightIndex) --#region 生肖合成
    self.rightIndex = rightIndex
    local equipName = self.cfg[self.leftIndex]["item_arr"][rightIndex]
    removeOBJ(self.ui.rightMask,self)
    GUI:Image_Create(self.ui["rightBox"..rightIndex],"rightMask",0,0,"res/custom/npc/z3.png")
    removeOBJ(self.ui.nowItem2,self)
    GUI:ItemShow_updateItem(self.ui.nowItem1, 
    {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg[self.leftIndex]["item_arr"][rightIndex]),look=true,bgVisible=false})
    GUI:Text_setString(self.ui.equipName1,equipName)

    GUI:removeAllChildren(self.ui.needItemNode1)
    self.ui = GUI:ui_delegate(self._parent)
    for i, v in ipairs(self.cfg[equipName]["need_config"]) do
        local itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",v[1])
        local itemCount = v[2]
        local itemColor = 249
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) >= itemCount then
                itemColor = 250
            end
        elseif type == 1 then
            if tonumber(SL:GetMetaValue("MONEY", itemIndex)) >= itemCount then
                itemColor = 250
            end
        elseif type == 2 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", itemIndex)) >= itemCount then
                itemColor = 250
            end
        end
        local item = GUI:ItemShow_Create(self.ui.needItemNode1, "need_item1"..i, 0, 0, {index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true})
        ItemShow_updateItem(item,{index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true,showCount=true})
    end
    GUI:UserUILayout(self.ui["needItemNode1"], {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})

    local red_node_list = {}
    red_node_list.view_name = "CompoundAnimalOBJ"
    red_node_list.node = self
    red_node_list.upBtn11 = RedPointMgr.GetRedDataByBtnName("CompoundAnimalOBJ","upBtn11")
    red_node_list.upBtn12 = RedPointMgr.GetRedDataByBtnName("CompoundAnimalOBJ","upBtn12")
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_node_list)
end

function CompoundAnimalOBJ:refreshMidNode2(rightIndex) --#region 生肖注灵
    GUI:removeAllChildren(self.ui.infoNode2)
    self.ui = GUI:ui_delegate(self._parent)
    SendMsgCallFunByNpc(0, "CompoundAnimal", "getInfo",rightIndex)
    self.rightIndex = rightIndex
    local equipName = self.cfg2[rightIndex]
    removeOBJ(self.ui.rightMask,self)
    GUI:Image_Create(self.ui["rightBox"..rightIndex],"rightMask",0,0,"res/custom/npc/z3.png")

    GUI:removeAllChildren(self.ui.needItemNode2)
    self.ui = GUI:ui_delegate(self._parent)
    for i, v in ipairs(self.cfg4[rightIndex]["need_config"]) do
        local itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",v[1])
        local itemCount = v[2]
        local itemColor = 249
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) >= itemCount then
                itemColor = 250
            end
        elseif type == 1 then
            if tonumber(SL:GetMetaValue("MONEY", itemIndex)) >= itemCount then
                itemColor = 250
            end
        elseif type == 2 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", itemIndex)) >= itemCount then
                itemColor = 250
            end
        end
        local item = GUI:ItemShow_Create(self.ui.needItemNode2, "need_item2"..i, 0, 0, {index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true})
        ItemShow_updateItem(item,{index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true,showCount=true})
    end
    GUI:UserUILayout(self.ui["needItemNode2"], {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})

    local position = 29+rightIndex
    removeOBJ(self.ui.nowItem2,self)
    if SL:Get_EQUIPBYPOS(position)=="" then
        GUI:Image_loadTexture(self.ui.wearImg2,"res/custom/hecheng/00.png")
        GUI:ItemShow_Create(self.ui.equipNode2,"nowItem2",-30,-30
        ,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",equipName),look=true,bgVisible=false})
        -- GUI:ItemShow_updateItem(self.ui.nowItem2, 
        -- {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",equipName),look=true,bgVisible=false})
        GUI:Text_setString(self.ui.equipName2,equipName)
    else
        GUI:Image_loadTexture(self.ui.wearImg2,"res/custom/hecheng/01.png")
        GUI:ItemShow_Create(self.ui.equipNode2,"nowItem2",-30,-30,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME"
        ,SL:Get_EQUIPBYPOS(position)),look=true,bgVisible=false,itemData=SL:Get_EQUIP_DATA(position)})
        -- GUI:ItemShow_updateItem(self.ui.nowItem2, {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME"
        -- ,SL:Get_EQUIPBYPOS(position)),look=true,bgVisible=false,itemData=SL:Get_EQUIP_DATA(position)})
        GUI:Text_setString(self.ui.equipName2,SL:Get_EQUIPBYPOS(position))
    end
end

--#region 后端消息刷新ui
function CompoundAnimalOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["背包"] = function()
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode1,"theEndEffect",478,300,0,14851,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
            if self.rightIndex<12 then
                self:refreshMidNode1(self.rightIndex+1)
            else
                self:refreshMidNode1(self.rightIndex)
            end
            SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "CompoundAnimalOBJ",["node"] = self,["is_all"] = true})
        end,
        ["身上"] = function()
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode1,"theEndEffect",478,300,0,14851,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
            if self.rightIndex<12 then
                self:refreshMidNode1(self.rightIndex+1)
            else
                self:refreshMidNode1(self.rightIndex)
            end
            SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "CompoundAnimalOBJ",["node"] = self,["is_all"] = true})
        end,
        ["失败"] = function ()
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode2,"theEndEffect",478,300,0,14859,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
            self:refreshMidNode2(self.rightIndex)
            SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "CompoundAnimalOBJ",["node"] = self,["is_all"] = true})
        end,
        ["注灵"] = function()
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode2,"theEndEffect",478,300,0,14860,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
            self:refreshMidNode2(self.rightIndex)
        end,
        ["属性"] = function ()
            local infoTab = SL:JsonDecode(tab[2], false)
            GUI:removeAllChildren(self.ui.infoNode2)
            self.ui = GUI:ui_delegate(self._parent)
            for index, value in ipairs(infoTab) do
                local text = GUI:Text_Create(self.ui.infoNode2,"infoText2"..index,0,0,16,"#00FCFC"
                ,self.cfg3[value[1]][1].."："..(tonumber(value[2])/tonumber(self.cfg3[value[1]][2])).."%")
                if self.cfg3[value[1]][3] then
                    GUI:Text_setString(text,self.cfg3[value[1]][1].."："..(tonumber(value[2])/tonumber(self.cfg3[value[1]][2])))
                end
            end
            GUI:UserUILayout(self.ui["infoNode2"], {dir=1,addDir=2,interval=0.5,gap = {y=8},sortfunc = function (lists)
                table.sort(lists, function (a, b)
                    return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
                end)
            end})
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end
function CompoundAnimalOBJ:onClose()
    SL:UnRegisterLUAEvent(LUA_EVENT_TAKE_ON_EQUIP, "CompoundAnimalOBJ")
end
--1 背包合成   2 身上合成
function CompoundAnimalOBJ:GetUpBtnRed(flag)
    flag = tonumber(flag)
    if flag == nil or  CompoundAnimalOBJ.leftIndex == nil or CompoundAnimalOBJ.rightIndex == nil then return false end
    local equipName = CompoundAnimalOBJ.cfg[CompoundAnimalOBJ.leftIndex]["item_arr"][CompoundAnimalOBJ.rightIndex]
    if CompoundAnimalOBJ.leftIndex == 1  then
        if  SL:Get_EQUIPBYPOS(29+CompoundAnimalOBJ.leftIndex) ~= "" or SL:Get_ITEM_COUNT(equipName)>=1 then
            return false
        end 
    else
        if  SL:Get_EQUIPBYPOS(29+CompoundAnimalOBJ.leftIndex) == equipName or SL:Get_ITEM_COUNT(equipName)>=1 then
            return false
        end 
    end
    if flag == 2 then
        if CompoundAnimalOBJ.leftIndex == 1 then return false end
        local need_equip_name = CompoundAnimalOBJ.cfg[CompoundAnimalOBJ.leftIndex-1]["item_arr"][CompoundAnimalOBJ.rightIndex]
        if SL:Get_EQUIPBYPOS(29+CompoundAnimalOBJ.rightIndex) ~= need_equip_name then return false end
        for i, v in ipairs(CompoundAnimalOBJ.cfg[equipName]["need_config"]) do
            local itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",v[1])
            local itemCount = v[2]
            local itemColor = 249
            local type = v[3] --#region 0材料 1非通用货币 2通用货币
            if type == 0 then
                if i ~= 3 and tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) < itemCount then
                    return false
                end
            elseif type == 1 then
                if tonumber(SL:GetMetaValue("MONEY", itemIndex)) < itemCount then
                    return false
                end
            elseif type == 2 then
                if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", itemIndex)) < itemCount then
                    return false
                end
            end
        end
    else
        for i, v in ipairs(CompoundAnimalOBJ.cfg[equipName]["need_config"]) do
            local itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",v[1])
            local itemCount = v[2]
            local itemColor = 249
            local type = v[3] --#region 0材料 1非通用货币 2通用货币
            if type == 0 then
                if  tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) < itemCount then
                    return false
                end
            elseif type == 1 then
                if tonumber(SL:GetMetaValue("MONEY", itemIndex)) < itemCount then
                    return false
                end
            elseif type == 2 then
                if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", itemIndex)) < itemCount then
                    return false
                end
            end
        end
    end
    return true
end

function CompoundAnimalOBJ:leftBtnRed(leftIndex)
    leftIndex = tonumber(leftIndex)
    if leftIndex == nil then return false end
    for index, equipName in ipairs(CompoundAnimalOBJ.cfg[leftIndex]["item_arr"]) do
        if leftIndex == 1  then
            if SL:Get_EQUIPBYPOS(29+index) ~= "" or SL:Get_ITEM_COUNT(equipName)>=1 then
                break
            end 
        else
            if SL:Get_EQUIPBYPOS(29+index) == equipName or SL:Get_ITEM_COUNT(equipName)>=1 then
                break
            end 
        end
        local is_show = true
        for i, v in ipairs(CompoundAnimalOBJ.cfg[equipName]["need_config"]) do
            local itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",v[1])
            local itemCount = v[2]
            local itemColor = 249
            local type = v[3] --#region 0材料 1非通用货币 2通用货币
            if type == 0 then
                if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) < itemCount then
                    if i == 3 and leftIndex > 1 then
                        local need_equip_name = CompoundAnimalOBJ.cfg[leftIndex-1]["item_arr"][index]
                        if SL:Get_EQUIPBYPOS(29+index) ~= need_equip_name then 
                            is_show = false
                            break
                        end
                    else
                        is_show = false
                        break
                    end
                end
            elseif type == 1 then
                if tonumber(SL:GetMetaValue("MONEY", itemIndex)) < itemCount then
                    is_show = false
                    break
                end
            elseif type == 2 then
                if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", itemIndex)) < itemCount then
                    is_show =  false
                    break
                end
            end
        end
        if is_show then
            return true
        end
    end
    return false
end
-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(CompoundAnimalOBJ.NpcId,npc_info.index) then
        SendMsgCallFunByNpc(npc_info.index, "CompoundAnimal", "onClick", npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "CompoundAnimalOBJ", onClickNpc)

-- 装备变化
function equipTake(data)
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "CompoundAnimalOBJ",["node"] = CompoundAnimalOBJ,["is_all"] = true})
end


return CompoundAnimalOBJ