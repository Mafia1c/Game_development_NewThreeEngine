local GodEquipOBJ = {}
GodEquipOBJ.Name = "GodEquipOBJ"
GodEquipOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
GodEquipOBJ.NpcId = 1032
GodEquipOBJ.cfg1 = GetConfig("GodEquipCfg1") --#region 打野刀
GodEquipOBJ.cfg2 = GetConfig("GodEquipCfg2") --#region 神器
local equipKey={"[穿透]","[爆伤]","[吸血]","[防御]","[生命]","[攻速]"}
local tips1={"<打野刀经验说明：/FCOLOR=251>\\1. <击杀白名怪获得1点经验值/FCOLOR=250>\\2. <击杀绿名怪获得100点经验值/FCOLOR=250>\\3. <击杀粉名怪获得200点经验值/FCOLOR=250>\\4. <击杀金名怪获得500点经验值/FCOLOR=250>\\5. <击杀红名怪获得1000点经验值/FCOLOR=250>\\6. <击杀橙名怪获得2000点经验值/FCOLOR=250>"}
local tips2={"<神器激活说明：/FCOLOR=251>\\1. <抽中的神器即可激活图鉴对应的属性/FCOLOR=250>"}
local tips3 ={
    "<神器配置说明：/FCOLOR=254>"
    .."\\1. <专属分为普通、稀有、史诗、传说、上古5种6个神器/FCOLOR=251>"
    .."\\2. <只有已经激活的神器才可进行配置加强属性/FCOLOR=251>"
    .."\\3. <角色只能激活一种神器效果，配置后可在主界面按配置依次切换，切换CD15秒/FCOLOR=251>"
    .."\\4. <角色默认佩戴第一位置的神器/FCOLOR=251>"
}

function GodEquipOBJ:main(exp,leftIndex,lineIndex1,iconIndex1)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GodEquipUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self.exp = tonumber(exp)
    self.leftIndex = tonumber(leftIndex) or 1
    self.lineIndex1= tonumber(lineIndex1) or 1
    self.iconIndex1= tonumber(iconIndex1) or 1
    for i = 1, 5 do
        GUI:addOnClickEvent(self.ui["leftBtn"..i],function ()
            if self.leftIndex==i then return end
            if i==1 then
                self:refreshMidNode1(1)
            elseif i==2 then
                self:refreshMidNode2(2)
            elseif i==3 then
                self:refreshMidNode3(3)
            elseif i==4 then
                self:refreshMidNode4(4)
            elseif i==5 then
                self:refreshMidNode5(5)
            end
        end)
    end

    if self.leftIndex==1 then
        self:refreshMidNode1(1)
    elseif self.leftIndex==2 then
        self:refreshMidNode2(2)
    elseif self.leftIndex==3 then
        self:refreshMidNode3(3)
    elseif self.leftIndex==4 then
        self:refreshMidNode4(4)
    elseif self.leftIndex==5 then
        self:refreshMidNode5(5)
    end

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("GodEquipOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("GodEquipOBJ")
    end)
    self:initBtnEvent()
end
function GodEquipOBJ:initBtnEvent()
    --#retion 打野刀
    GUI:addOnClickEvent(self.ui.tipsBtn1,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn1)
        GUI:ShowWorldTips(tips1[1], worldPos, GUI:p(1, 1))
    end)
    for i = 1, 2 do
        GUI:addOnClickEvent(self.ui["commitBtn1"..i],function ()
            SendMsgCallFunByNpc(self.NpcId, "GodEquip", "expEvent",i)
        end)
    end
    GUI:addOnClickEvent(self.ui.upBtn1, function()
        SendMsgCallFunByNpc(self.NpcId, "GodEquip", "upEvent1","")
    end)
    --#region 神器激活
    GUI:addOnClickEvent(self.ui.tipsBtn2,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn2)
        GUI:ShowWorldTips(tips2[1], worldPos, GUI:p(1, 1))
    end)
    for i = 1, 2 do
        GUI:addOnClickEvent(self.ui["activeBtn2"..i],function ()
            SendMsgCallFunByNpc(self.NpcId, "GodEquip", "activeEvent2",i)
        end)
    end
    --#region 神器融合
    for i = 1, 5 do self["sonIndex3"..i]=nil end
    GUI:addOnClickEvent(self.ui.upBtn3,function ()
        local equipTypeTab={} --#region type Table
        local equipNameTab={}
        local cfg=self.has_data_list
        for i = 1, 5 do
            if i<=3 and (not self["sonIndex3"..i] or not self.ui["sonItem3"..i]) then
                return SL:ShowSystemTips("<font color=\'#ff0000\'>请先选取3个已拥有的神器！</font>")
            end
            if cfg[self["sonIndex3"..i]] then
                local equipName=SL:Get_ITEM_NAME(cfg[self["sonIndex3"..i]].index)
                local equipType= self.cfg2[string.match(equipName, "([^%[%]]+)")].type
                table.insert(equipNameTab,equipName)
                table.insert(equipTypeTab,equipType)
            end
        end
        for i = 2, #equipTypeTab do
            if equipTypeTab[i]~=equipTypeTab[1] then
                return SL:ShowSystemTips("<font color=\'#ff0000\'>请选取同级别的神器进行融合！</font>")
            end
        end
        if equipTypeTab[1]==5 then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>当前神器已是最高级别！</font>")
        end
        SendMsgCallFunByNpc(self.NpcId, "GodEquip", "merge3",equipNameTab)
    end)
    --#region 神器配置
    GUI:addOnClickEvent(self.ui.tipsBtn5,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn5)
        GUI:ShowWorldTips(tips3[1], worldPos, GUI:p(1, 1))
    end)
end

function GodEquipOBJ:remove_OBJ(index) --#region 针对pc移除触摸显示
    if index~=2 then
        GUI:removeAllChildren(self.ui.itemList21)
        GUI:removeAllChildren(self.ui.itemList22)
        self.ui = GUI:ui_delegate(self._parent)
        GUI:setPositionX(self.ui.itemList21,0)
        GUI:setPositionX(self.ui.itemList22,300)
        GUI:Timeline_StopAll(self.ui.itemList21)
        GUI:Timeline_StopAll(self.ui.itemList22)
    end
    if index~=3 then
        for i = 1, 3 do
            removeOBJ(self.ui["sonItem3"..i],self)
        end
        GUI:removeAllChildren(self.ui.rightList3)
        self.ui = GUI:ui_delegate(self._parent)
    end
    if index~=4 then
        for i = 1, 6 do
            removeOBJ(self.ui["equipShow4"..i],self)
        end
    end
    if index~=5 then
        GUI:removeAllChildren(self.ui.rightList5)
        self.ui = GUI:ui_delegate(self._parent)
        for i = 1, 5 do
            local parent=self.ui["downBg5"..i]
            GUI:removeAllChildren(parent)
        end
    end
end

function GodEquipOBJ:refreshMidNode1(leftIndex) --#region 打野刀
    GodEquipOBJ:remove_OBJ(leftIndex)
    GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/53dyd/sj/bg1.png")
    self.leftIndex = leftIndex
    for i = 1, 5 do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..i],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..i], "#BDBDB5")
        GUI:setVisible(self.ui["midNode"..i],i==leftIndex)
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")

    local jungleLv = tonumber(GameData.GetData("U_jungleLv",false)or 0)
    local exp = self.exp
    local exp_Bar=0
    GUI:Text_setString(self.ui.equipLevel1,jungleLv)
    if jungleLv>=#self.cfg1 then
        exp_Bar=100
    else
        exp_Bar=exp/self.cfg1[jungleLv+1].exp*100
        if exp_Bar>=100 then exp_Bar=100 end
    end
    GUI:LoadingBar_setPercent(self.ui.LoadingBar1,exp_Bar)
    GUI:Text_setString(self.ui.LoadingText1,exp.."/"..(self.cfg1[jungleLv+1] and self.cfg1[jungleLv+1].exp or self.cfg1[jungleLv].exp))

    local infoTab={{"3","攻魔道："},{"30","生命值：","%"},{"74","对怪伤害："},{"75","对怪增伤：","%",1},{"54","对战增伤：","%",1},{"56","对法增伤：","%",1},{"58","对道增伤：","%",1}}
    local infoStrTab=GameData.GetData("T_jungleText",true)or {}
    GUI:removeAllChildren(self.ui.textNode1)
    self.ui = GUI:ui_delegate(self._parent)
    for index, value in ipairs(infoTab) do
        if infoStrTab[value[1]] then
            local _type=GUI:Text_Create(self.ui.textNode1,"jugType1"..index,0,0,16,"#ffffff",value[2])
            local _number=tonumber(infoStrTab[value[1]])
            if value[4] then _number=_number/100 end --#region 万分比转换
            local _text=GUI:Text_Create(_type,"jugText1"..index,GUI:getContentSize(_type).width,0,16,"#00ff00",_number..(value[3]or ""))
            if index==1 then GUI:Text_setString(_text,_number.."-".._number) end
            GUI:setContentSize(_type,GUI:getContentSize(_type).width+GUI:getContentSize(_text).width,GUI:getContentSize(_type).height)
        end
    end
    if not next(infoStrTab) then
        GUI:Text_Create(self.ui.textNode1,"jugType11",0,0,16,"#ffffff","暂无")
    end
    GUI:UserUILayout(self.ui["textNode1"], {dir=1,addDir=2,interval=0.5,gap = {y=4},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})

    GUI:removeAllChildren(self.ui.needItemNode1)
    self.ui = GUI:ui_delegate(self._parent)
    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg1[jungleLv+1] or (self.cfg1[jungleLv+1] and self.cfg1[jungleLv+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        local itemColor = 249
        for j = 1, self.cfg1[jungleLv+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg1[jungleLv+1][keyName]
            itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",itemName)
            itemCount = self.cfg1[jungleLv+1][keyItemCount]
            itemColor = 249
            if i==1 then
                if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) >= itemCount then
                    itemColor = 250
                end
                number=number+1
                local item = GUI:ItemShow_Create(self.ui.needItemNode1, "need_item1"..number, 0, 0, {index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true})
                ItemShow_updateItem(item,{index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true,showCount=true})
            elseif i==2 then
                if tonumber(SL:GetMetaValue("MONEY", itemIndex)) >= itemCount then
                    itemColor = 250
                end
                number=number+1
                local item = GUI:ItemShow_Create(self.ui.needItemNode1, "need_item1"..number, 0, 0, {index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true})
                ItemShow_updateItem(item,{index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true,showCount=true})
            elseif i==3 then
                if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", itemIndex)) >= itemCount then
                    itemColor = 250
                end
                number=number+1
                local item = GUI:ItemShow_Create(self.ui.needItemNode1, "need_item1"..number, 0, 0, {index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true})
                ItemShow_updateItem(item,{index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true,showCount=true})
            end
        end
        ::continue::
    end
    GUI:UserUILayout(self.ui["needItemNode1"], {dir=2,addDir=2,interval=0.5,gap = {x=10},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    if jungleLv>=#self.cfg1 then
        GUI:setVisible(self.ui.upBtn1,false)
        GUI:setVisible(self.ui.maxImg1,true)
    end
    if jungleLv<5 then
        GUI:setPositionY(self.ui.upBtn1,94)
    else
        GUI:setPositionY(self.ui.upBtn1,64)
    end
end

function GodEquipOBJ:refreshMidNode2(leftIndex) --#region 神器激活
    GodEquipOBJ:remove_OBJ(leftIndex)
    GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/53dyd/sq1/bg1.png")
    GodEquipOBJ:resetStatus2()
    self.leftIndex = tonumber(leftIndex)
    for i = 1, 5 do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..i],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..i], "#BDBDB5")
        GUI:setVisible(self.ui["midNode"..i],i==leftIndex)
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")
    local number=SL:GetMetaValue("ITEM_COUNT", SL:GetMetaValue("ITEM_INDEX_BY_NAME","神器魔盒"))
    GUI:Text_setString(self.ui.hasText22,"神器魔盒*"..number)
end
function GodEquipOBJ:openBoxAnim2() --#region 神器激活动画
    GodEquipOBJ:resetStatus2()
    local equipTa={{},{}}
    for i = 1, 2 do
        for j = 1, 5 do
            local rand1=math.random(6)
            local rand2=math.random(5)
            local equipName=self.cfg2[rand1].name_arr[rand2]..equipKey[rand1]
            table.insert(equipTa[i],equipName)
            GUI:ItemShow_Create(self.ui["itemList2"..i],"rewardItem2_"..i..j,0,0
            ,{index=SL:Get_ITEM_INDEX_BY_NAME(equipName),bgVisible=false,look=true})
        end
        GUI:setVisible(self.ui["itemList2"..i],true)
    end
    GUI:setVisible(self.ui.boxAnimNode2,true)
    local function animaFun11()
        if ViewMgr.IsOpen("GodEquipOBJ") and self.leftIndex==2 and GUI:getVisible(self.ui.boxAnimNode2) then
            GUI:Timeline_MoveTo(self.ui.itemList21,{x=-300,y=73},4,function ()
                GUI:setPositionX(self.ui.itemList21,300)
                animaFun11()
            end)
        end
    end
    local function animaFun1()
        if ViewMgr.IsOpen("GodEquipOBJ") and self.leftIndex==2 and GUI:getVisible(self.ui.boxAnimNode2) then
            GUI:Timeline_MoveTo(self.ui.itemList21,{x=-300,y=73},2,function ()
                GUI:setPositionX(self.ui.itemList21,300)
                animaFun11()
            end)
        end
    end
    local function animaFun2()
        if ViewMgr.IsOpen("GodEquipOBJ") and self.leftIndex==2 and GUI:getVisible(self.ui.boxAnimNode2) then
            GUI:Timeline_MoveTo(self.ui.itemList22,{x=-300,y=73},4,function ()
                GUI:setPositionX(self.ui.itemList22,300)
                animaFun2()
            end)
        end
    end
    animaFun1()
    animaFun2()
end
function GodEquipOBJ:endBoxAnim2() --# 动画结束
    if ViewMgr.IsOpen("GodEquipOBJ") and self.leftIndex==2 and GUI:getVisible(self.ui.boxAnimNode2) then
        GodEquipOBJ:resetStatus2()
    end
end
function GodEquipOBJ:resetStatus2() --#region 神器激活动画重置状态
    GUI:setVisible(self.ui.boxAnimNode2,false)
    GUI:removeAllChildren(self.ui.itemList21)
    GUI:removeAllChildren(self.ui.itemList22)
    self.ui = GUI:ui_delegate(self._parent)
    GUI:Timeline_StopAll(self.ui.itemList21)
    GUI:Timeline_StopAll(self.ui.itemList22)
    GUI:setPositionX(self.ui.itemList21,0)
    GUI:setPositionX(self.ui.itemList22,300)
end

function GodEquipOBJ:refreshMidNode3(leftIndex) --#region 神器融合
    GodEquipOBJ:remove_OBJ(leftIndex)
    GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/53dyd/sq2/bg1.png")
    self.leftIndex = tonumber(leftIndex)
    for i = 1, 5 do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..i],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..i], "#BDBDB5")
        GUI:setVisible(self.ui["midNode"..i],i==leftIndex)
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")
    
    for i = 1, 5 do
        self["sonIndex3"..i]=nil
        removeOBJ(self.ui["sonItem3"..i],self)
    end
    removeOBJ(self.ui["mustAppear3"],self)
    GUI:setVisible(self.ui.effect3,true)
    local activeList=GameData.GetData("T_godEquipActive",true) or {} --#region 激活拥有的
    GUI:removeAllChildren(self.ui.rightList3)
    self.ui = GUI:ui_delegate(self._parent)
    local tmp_list = {}
    for k, v in pairs(activeList) do
        local num=tonumber(v)
        for i = 1, num do
            local data = {}
            data.index = SL:Get_ITEM_INDEX_BY_NAME(k)
            -- data.count = v.OverLap
            data.look = false
            data.bgVisible = false
            tmp_list[#tmp_list + 1] = data
        end

    end
    self.has_data_list = tmp_list --#region 背包物品列表

    if #self.has_data_list <= 21 then
        local time = 0
        for i = 1, 7 do
            local list = GUI:ListView_Create(self.ui.rightList3,"rightSmallList31"..i,0,0,186,58,2)
            GUI:ListView_setItemsMargin(list,2)
            GUI:ListView_setClippingEnabled(list,true)
            GUI:setTouchEnabled(list,false)
            for j = 1, 3 do
                GUI:Image_Create(list,"sonImg_3"..(i-1)*3+j,0,0,"res/custom/npc/k0.png")
            end
            GUI:setVisible(list,false)
            time = time + 0.05
            GUI:runAction(list, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
                GUI:setVisible(list, true)
                GUI:setPositionX(list, 186)
                GUI:runAction(list, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(list))))
            end)))
        end
    else
        local list_number = math.ceil(#self.has_data_list/3)
        local time = 0
        for i = 1, list_number, 1 do
            local list = GUI:ListView_Create(self.ui.rightList3,"rightSmallList31"..i,0,0,186,58,2)
            GUI:ListView_setItemsMargin(list,2)
            GUI:ListView_setClippingEnabled(list,true)
            GUI:setTouchEnabled(list,false)
            for j = 1, 3 do
                GUI:Image_Create(list,"sonImg_3"..(i-1)*3+j,0,0,"res/custom/npc/k0.png")
            end
            GUI:setVisible(list,false)
            time = time + 0.05
            GUI:runAction(list, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
                GUI:setVisible(list, true)
                GUI:setPositionX(list, 186)
                GUI:runAction(list, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(list))))
            end)))
        end
    end
    for index, value in ipairs(self.has_data_list or {}) do
        self:createSonItem(index)
    end
end
--#region 创建子列表
function GodEquipOBJ:createSonItem(sonIndex)
    local item = GUI:ItemShow_Create(self.ui["sonImg_3"..sonIndex],"sonItem_3"..sonIndex,29,29
    ,{index = self.has_data_list[sonIndex]["index"],look = true,bgVisible =false})
    GUI:setAnchorPoint(item,0.5,0.5)
    local layout = GUI:Layout_Create(item,"sonLayout_3"..sonIndex,30,30,60,60,true)
    GUI:setAnchorPoint(layout,0.5,0.5)
    GUI:setTouchEnabled(layout,true)
    GUI:setSwallowTouches(layout, false)
    GUI:addOnClickEvent(layout,function ()
        for i = 1, 5 do
            if self["sonIndex3"..i] and self["sonIndex3"..i]==sonIndex then
                GUI:ItemShow_setItemShowChooseState(self.ui["sonItem_3"..sonIndex], false)
                self["sonIndex3"..i] = nil
                removeOBJ(self.ui["sonItem3"..i],self)
                removeOBJ(self.ui["mustAppear3"],self)
                GUI:setVisible(self.ui.effect3,true)
                return
            end
        end
        for i = 1, 5 do
           if not self["sonIndex3"..i] then
                break
            elseif i==5 then
                return SL:ShowSystemTips("<font color=\'#ff0000\'>请先取消一个选取！</font>")
            end
        end
        for i = 1, 5 do
            if not self["sonIndex3"..i] then
                GUI:ItemShow_Create(self.ui["downBg3"..i],"sonItem3"..i,-1,-1
                ,{index=self.has_data_list[sonIndex]["index"],bgVisible=false,look=true})
                GUI:ItemShow_setItemShowChooseState(self.ui["sonItem_3"..sonIndex], true)
                self["sonIndex3"..i] = sonIndex
                for j = 1, 5 do --#region 判断必出显示
                    if i~=j and not self["sonIndex3"..j] then
                        break
                    elseif j==5 then
                        local cfgName=string.match(SL:Get_ITEM_NAME(self.has_data_list[self.sonIndex31].index),"([^%[%]]+)")
                        local lineType=self.cfg2[cfgName].lineType
                        local iconType=self.cfg2[cfgName].type
                        if iconType>=5 then
                            break
                        end
                        for k = 2, 5 do
                            if self.has_data_list[self.sonIndex31].index ~= self.has_data_list[self["sonIndex3"..k]].index then
                                break
                            elseif k==5 then
                                removeOBJ(self.ui["mustAppear3"],self)
                                GUI:setVisible(self.ui.effect3,false)
                                local nextIndex=SL:Get_ITEM_INDEX_BY_NAME(self.cfg2[lineType].name_arr[iconType+1]..equipKey[lineType])
                                GUI:ItemShow_Create(self.ui.midNode3,"mustAppear3",374,322
                                ,{index=nextIndex,bgVisible=false,look=true})
                                break
                            end
                        end
                    end
                end
                return
            end
        end
    end)
end


function GodEquipOBJ:refreshMidNode4(leftIndex) --#region 神器图鉴
    GodEquipOBJ:remove_OBJ(leftIndex)
    GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/53dyd/sq3/bg1.png")
    self.leftIndex = tonumber(leftIndex)
    for i = 1, 5 do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..i],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..i], "#BDBDB5")
        GUI:setVisible(self.ui["midNode"..i],i==leftIndex)
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")
    for i = 1, 5 do
        GUI:addOnClickEvent(self.ui["typeBtn4"..i],function ()
            GodEquipOBJ:refreshInfo4(i)
        end)
    end
    GodEquipOBJ:refreshInfo4(1)
end
function GodEquipOBJ:refreshInfo4(index) --#region 选图鉴刷新
    removeOBJ(self.ui.selectBox4,self)
    removeOBJ(self.ui.selectArrow4,self)
    GUI:Image_Create(self.ui["typeBox4"..index],"selectBox4",2,2,"res/custom/npc/53dyd/sq3/select.png")
    GUI:Image_Create(self.ui["typeBox4"..index],"selectArrow4",22,-28,"res/custom/npc/53dyd/sq3/arrow.png")
    -- Animation.breathingEffect(self.ui.selectBox4,0.4,0.4)
    Animation.breathingEffect(self.ui.selectArrow4,0.4,0.4)
    for i = 1, 5 do GUI:setVisible(self.ui["Rtext4"..i],index==i) end
    local activeList=GameData.GetData("T_godEquipActive",true) or {}
    for i = 1, 6 do
        removeOBJ(self.ui["equipShow4"..i],self)
        local equipName=self.cfg2[i].name_arr[index]..equipKey[i]
        local item=GUI:ItemShow_Create(self.ui["equipBox4"..i],"equipShow4"..i,-1,-1
        ,{index=SL:Get_ITEM_INDEX_BY_NAME(equipName),look=true,bgVisible=false})
        if activeList[equipName] and tonumber(activeList[equipName])>0 then
            GUI:ItemShow_setIconGrey(item, false)
            GUI:Button_setTitleColor(self.ui["statuBtn4"..i],"#00ff00")
            GUI:Button_setTitleText(self.ui["statuBtn4"..i],"已拥有")
        else
            GUI:ItemShow_setIconGrey(item, true)
            GUI:Button_setTitleColor(self.ui["statuBtn4"..i],"#ff0000")
            GUI:Button_setTitleText(self.ui["statuBtn4"..i],"未拥有")
        end
    end
end

function GodEquipOBJ:refreshMidNode5(leftIndex) --#region 神器配置
    GodEquipOBJ:remove_OBJ(leftIndex)
    GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/53dyd/pz/bg1.png")
    self.leftIndex = leftIndex
    for i = 1, 5 do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..i],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..i], "#BDBDB5")
        GUI:setVisible(self.ui["midNode"..i],i==leftIndex)
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")

    local activeList=GameData.GetData("T_godEquipActive",true) or {} --#region 激活拥有的
    local keyTab={"pt","xy","ss","cs","sg"}
    local nameTab={"普通系","稀有系","史诗系","传说系","上古系"}
    GUI:removeAllChildren(self.ui.rightList5)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for i = 1, 5 do --#region i代表iconIndex
        local box=GUI:Image_Create(self.ui.rightList5,"rightBox5"..i,0,0,"res/custom/npc/53dyd/pz/"..keyTab[i]..".png")
        GUI:Button_Create(box,"box5"..i.."1",78,22,"res/custom/npc/53dyd/pz/an2.png")
        GUI:Button_Create(box,"box5"..i.."2",564,22,"res/custom/npc/53dyd/pz/an1.png")
        local list=GUI:ListView_Create(box,"iconList5"..i,120,10,434,64,2)

        GUI:ListView_setItemsMargin(list,10)
        GUI:setTouchEnabled(list,false)
        local itemNameTab={} --#region 当前列神器
        for index, value in ipairs(self.cfg2) do
            table.insert(itemNameTab,value.name_arr[i])
        end
        for index, value in ipairs(itemNameTab) do --#region index代表lineIndex
            local equipName=self.cfg2[index]["name_arr"][i]..equipKey[index]
            if not activeList[equipName] or tonumber(activeList[equipName])<=0 then
                goto continue
            end
            local img=GUI:Image_Create(list,"iconBg5"..i..index,0,0,"res/custom/npc/53dyd/pz/kuang.png")
            local equip=GUI:ItemShow_Create(img,"iconEquip5"..i..index,2,2,
            {index=SL:Get_ITEM_INDEX_BY_NAME(equipName),look=true,bgVisible=false})
            local layout=GUI:Layout_Create(img,"iconLayout5"..i..index,0,0,64,64,true)
            GUI:setTouchEnabled(layout, true)
            GUI:setSwallowTouches(layout, false)
            local name=self.cfg2[index].name_arr[i]
            -- local btn=GUI:Button_Create(img,"icon3"..i..index,6,5,"res/custom/npc/53dyd/js/icon/"..iconKey[index]..i..".png")
            -- GUI:setGrey(btn,active==0)
            GUI:addOnClickEvent(layout,function ()
                removeOBJ(self.ui.selectIcon5,self)
                GUI:Image_Create(img,"selectIcon5",-3,-3,"res/custom/npc/53dyd/pz/xz.png")
                Animation.breathingEffect(self.ui.selectIcon5,0.4,0.4)
                for _ = 1, 5 do
                    if not self.ui["iconLayout5"..i] then
                        SendMsgCallFunByNpc(self.NpcId, "GodEquip", "setGodEquip",index.."#"..i)
                        break
                    end
                end
            end)
            ::continue::
        end

        GUI:setVisible(box,false)
        time = time +0.05
        GUI:runAction(box,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(box,true)
            GUI:setPositionX(box,-610)
            GUI:runAction(box,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(box))))
        end)))
    end

    self:refreshDownList5()
end
function GodEquipOBJ:refreshDownList5() --#region 神器配置刷新配置
    local hasList=GameData.GetData("T_godEquip_hasList",true)or {}
    for i = 1, 5 do
        local parent=self.ui["downBg5"..i]
        GUI:removeAllChildren(parent)
        self.ui = GUI:ui_delegate(self._parent)
        if hasList[i] then
            local lineIndex2,iconIndex2=tonumber(string.sub(hasList[i],1,1)),tonumber(string.sub(hasList[i],2,2))
            -- local img=GUI:Image_Create(parent,"downIcon3"..i,6,5
            -- ,"res/custom/npc/53dyd/js/icon/"..iconKey[lineIndex2]..iconIndex2..".png")
            local equipName=self.cfg2[lineIndex2].name_arr[iconIndex2]..equipKey[lineIndex2]
            local equip=GUI:ItemShow_Create(parent,"downEquip5"..i,2,2,
            {index=SL:Get_ITEM_INDEX_BY_NAME(equipName),look=true,bgVisible=false})
            if i>5 then
                GUI:Image_Create(parent,"downState"..i,2,-40,"res/custom/npc/53dyd/pz/pdz.png")
            else
                local btn=GUI:Button_Create(parent,"downState"..i,2,-36,"res/custom/npc/anb1.png")
                GUI:Button_setScale9Slice(btn, 12, 12, 14, 14)
                GUI:setContentSize(btn,60,30)
                GUI:Button_setTitleText(btn,"移除")
                GUI:Button_setTitleColor(btn,"#e8dcbd")
                GUI:Button_setTitleFontSize(btn,16)
                GUI:addOnClickEvent(btn,function ()
                    SendMsgCallFunByNpc(self.NpcId, "GodEquip", "removeGodEquip",i)
                end)
            end
        end
    end
end


--#region 后端消息刷新ui
function GodEquipOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["exp"] = function ()
            self.exp = tonumber(tab[2])
            self:refreshMidNode1(1)
            -- removeOBJ(self.ui.theEndEffect,self)
            -- GUI:Effect_Create(self.ui.midNode,"theEndEffect",478,300,0,14849,0,0,0,1)
            -- GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
        end,
        ["动画"] = function ()
            GodEquipOBJ:openBoxAnim2()
        end,
        ["激活"] = function ()
            if ViewMgr.IsOpen("GodEquipOBJ") then
                self:refreshMidNode2(2)
                GodEquipOBJ:endBoxAnim2()
            end
        end,
        ["融合"] = function ()
            GodEquipOBJ:refreshMidNode3(3)
        end,
        ["配置"] = function ()
            self:refreshDownList5()
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "GodEquipOBJ",["node"] = self,["is_all"] = true})
end

function GodEquipOBJ:UpBtnRed()
    local jungleLv = tonumber(GameData.GetData("U_jungleLv",false)or 0)
    if jungleLv>=#GodEquipOBJ.cfg1 then
        return false    
    end
    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    if not GodEquipOBJ.cfg1[jungleLv+1]  then
        return false
    end
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if GodEquipOBJ.cfg1[jungleLv+1] and GodEquipOBJ.cfg1[jungleLv+1]["number_arr"][i] > 0 then
            local itemIndex = 0
            local itemCount = 0
            for j = 1, GodEquipOBJ.cfg1[jungleLv+1]["number_arr"][i] do --#region 物品种类数量
                local keyName = typeName[i][1]..j
                local keyItemCount = typeName[i][2]..j
                local itemName = GodEquipOBJ.cfg1[jungleLv+1][keyName]
                itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",itemName)
                itemCount = GodEquipOBJ.cfg1[jungleLv+1][keyItemCount]
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
    local cur_exp = tonumber(GameData.GetData("U_jungleExp_now",false)or 0)
    return cur_exp >= GodEquipOBJ.cfg1[jungleLv+1].exp
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if GodEquipOBJ.NpcId == npc_info.index then
        -- ViewMgr.open("GodEquipOBJ")
        SendMsgClickNpc(GodEquipOBJ.NpcId.."#GodEquip")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "GodEquipOBJ", onClickNpc)

return GodEquipOBJ