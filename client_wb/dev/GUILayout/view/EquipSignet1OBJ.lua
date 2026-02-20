local EquipSignet1OBJ = {}
EquipSignet1OBJ.Name = "EquipSignet1OBJ"
EquipSignet1OBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
EquipSignet1OBJ.NpcId = 67
EquipSignet1OBJ.cfg=GetConfig("EquipSignetCfg")
EquipSignet1OBJ.cfg1={{1,"武器"},{0,"衣服"},{4,"头盔"},{3,"项链"},{5,"右镯"},{6,"左镯"},{7,"右戒"},{8,"左戒"},{10,"腰带"},{11,"靴子"}}
EquipSignet1OBJ.cfg2={["need_config"]={{"元宝",2000,2}},}
EquipSignet1OBJ.cfg3=GetConfig("EquipSpecialCfg") --#region 上古以上装备
local tips ={
    "<极品术士 随机获得 1-5 条属性：/FCOLOR=251>"
    .."\\<只有上古以上的装备才可进行鉴定加强属性/FCOLOR=249>"
    .."\\<印记符文分为：/FCOLOR=255><普通符文  /FCOLOR=161>"
    .."<高级符文  /FCOLOR=254><稀有符文  /FCOLOR=70><史诗符文  /FCOLOR=253>"
    .."\\<消耗1件副装 词条数量概率依次为：1%/3%/10%/30%/100% /FCOLOR=250>"
    .."\\<消耗2件副装 词条数量概率依次为：5%/10%/20%/50%/100% /FCOLOR=250>"
    .."\\<消耗3件副装 词条数量概率依次为：10%/20%/30%/75%/100% /FCOLOR=250>"
}

function EquipSignet1OBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/EquipSignet1UI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self.rightIndex=nil --#region 当前页签
    self.nowPosition=nil --#region 当前鉴定装备位
    self.sonIndex=nil --#region 当前鉴定装备序列
    self.nowEquipName=nil --#regio 当前鉴定装备名
    for i = 1, 3 do
        self["sonIndex"..i]=nil --#region 当前选取复装序列
    end
    GUI:UserUILayout(self.ui.needEquipNode, {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    self:refreshRightList1()
    self:refreshNeedItem()

    GUI:addOnClickEvent(self.ui.changeBtn1,function ()
        if self.rightIndex==1 then
            return
        end
        self:refreshRightList1()
    end)
    GUI:addOnClickEvent(self.ui.changeBtn2,function ()
        if not self.ui.nowEquip then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先选取身上需要鉴定的装备！</font>")
        elseif self.rightIndex==2 then
            return
        end
        self:refreshRightList2()
    end)
    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("EquipSignet1OBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("EquipSignet1OBJ")
    end)
    GUI:addOnClickEvent(self.ui.tipsBtn,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn)
        GUI:ShowWorldTips(tips[1], worldPos, GUI:p(1, 1))
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        if not self.ui.nowEquip then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先选取身上需要鉴定的装备！</font>")
        end
        for i = 1, 3 do
            if self["sonIndex"..i] then
                break
            elseif i==3 then
                return SL:ShowSystemTips("<font color=\'#ff0000\'>请最少选取一件背包需要消耗的相同副装！</font>")
            end
        end
        local tab={}
        for i = 1, 3 do
            if self["sonIndex"..i] then
                table.insert(tab,self.has_data_list[self["sonIndex"..i]]["_MakeIndex"])
            else
                table.insert(tab,"")
            end
        end
        SendMsgCallFunByNpc(self.NpcId, "EquipSignet", "upEvent1",self.nowPosition.."#"..tab[1].."#"..tab[2].."#"..tab[3])
    end)
end

function EquipSignet1OBJ:refreshNeedItem()
    GUI:removeAllChildren(self.ui.needItemNode)
    self.ui = GUI:ui_delegate(self._parent)
    for i, v in ipairs(self.cfg2["need_config"]) do
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
        local item = GUI:ItemShow_Create(self.ui.needItemNode, "need_item"..i, 0, 0, {index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true})
        ItemShow_updateItem(item,{index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true,showCount=true})
    end
    GUI:UserUILayout(self.ui["needItemNode"], {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
end
function EquipSignet1OBJ:refreshRightList1()
    self.rightIndex=1
    GUI:Button_loadTextures(self.ui.changeBtn1,"res/custom/npc/05jpss/bag2.png","res/custom/npc/05jpss/an11.png","",0)
    GUI:Button_loadTextures(self.ui.changeBtn2,"res/custom/npc/05jpss/an1.png","res/custom/npc/05jpss/bag1.png","",0)
    GUI:removeAllChildren(self.ui.bigList)
    self.ui = GUI:ui_delegate(self._parent)
    GUI:ScrollView_setBounceEnabled(self.ui.bigList, false)

    local time=0
    for i = 1, 5 do
        local list = GUI:ListView_Create(self.ui.bigList,"rightList"..i,0,0,250,60,2)
        GUI:ListView_setItemsMargin(list,3)
        GUI:ListView_setClippingEnabled(list,true)
        GUI:setTouchEnabled(list,false)
        for j = 1, 4 do
            local sonIndex=(i-1)*4+j
            GUI:Image_Create(list,"sonImg"..(i-1)*4+j,0,0,"res/custom/npc/k0.png")
        end
        GUI:setVisible(list,false)
        time = time + 0.05
        GUI:runAction(list, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
            GUI:setVisible(list, true)
            GUI:setPositionX(list, 254)
            GUI:runAction(list, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(list))))
        end)))
    end

    local hasIndex=0
    for index, value in ipairs(self.cfg1) do
        if SL:GetMetaValue("EQUIPBYPOS", value[1]) ~= "" and self.cfg3[SL:GetMetaValue("EQUIPBYPOS", value[1])] then
            hasIndex=hasIndex+1
            local position = value[1]
            local item=GUI:ItemShow_Create(self.ui["sonImg"..hasIndex],"sonItem"..hasIndex,0,0,{look=true,bgVisible=false,
            index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",SL:Get_EQUIPBYPOS(position)),itemData=SL:Get_EQUIP_DATA(position,false)})
            local layout = GUI:Layout_Create(item,"sonLayout"..hasIndex,30,30,60,60,true)
            GUI:setAnchorPoint(layout,0.5,0.5)
            GUI:setTouchEnabled(layout,true)
            GUI:setSwallowTouches(layout, false)
            local selectIndex= tonumber(string.match(GUI:getName(layout),"sonLayout(.*)"))
            if self.sonIndex and self.sonIndex == selectIndex then
                GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..selectIndex], true)
            end
            GUI:addOnClickEvent(layout,function ()
                if self.sonIndex and self.sonIndex == selectIndex then
                    GUI:removeAllChildren(self.ui.infoNode)
                    self.ui = GUI:ui_delegate(self._parent)
                    for i = 1, 3 do
                        removeOBJ(self.ui["needEquip"..i],self)
                        self["sonIndex"..i]=nil
                    end
                    GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..selectIndex], false)
                    self.nowPosition=nil
                    self.sonIndex = nil
                    self.nowEquipName=nil
                    GUI:Text_setString(self.ui.nowEquipName,"")
                    removeOBJ(self.ui.nowEquip,self)
                elseif self.sonIndex then
                    SendMsgCallFunByNpc(self.NpcId, "EquipSignet", "infoEvent1", position)
                    for i = 1, 3 do 
                        removeOBJ(self.ui["needEquip"..i],self)
                        self["sonIndex"..i]=nil
                    end
                    GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..self.sonIndex], false)
                    GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..selectIndex], true)
                    self.nowPosition=position
                    self.sonIndex=selectIndex
                    self.nowEquipName=SL:Get_EQUIP_DATA(position,false).Name
                    GUI:Text_setString(self.ui.nowEquipName,self.nowEquipName)
                    removeOBJ(self.ui.nowEquip,self)
                    GUI:ItemShow_Create(self.ui.nowEquipNode,"nowEquip",-30,-30,{look=true,bgVisible=false,
                    index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",SL:Get_EQUIPBYPOS(position)),itemData=SL:Get_EQUIP_DATA(position,false)})
                    -- self:refreshRightList2()
                else
                    SendMsgCallFunByNpc(self.NpcId, "EquipSignet", "infoEvent1", position)
                    GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..selectIndex], true)
                    self.nowPosition=position
                    self.sonIndex=selectIndex
                    self.nowEquipName=SL:Get_EQUIP_DATA(position,false).Name
                    GUI:Text_setString(self.ui.nowEquipName,self.nowEquipName)
                    removeOBJ(self.ui.nowEquip,self)
                    GUI:ItemShow_Create(self.ui.nowEquipNode,"nowEquip",-30,-30,{look=true,bgVisible=false,
                    index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",SL:Get_EQUIPBYPOS(position)),itemData=SL:Get_EQUIP_DATA(position,false)})
                    -- self:refreshRightList2()
                end
            end)
        end
    end

end
function EquipSignet1OBJ:refreshRightList2()
    self.rightIndex=2
    GUI:Button_loadTextures(self.ui.changeBtn1,"res/custom/npc/05jpss/an11.png","res/custom/npc/05jpss/bag2.png","",0)
    GUI:Button_loadTextures(self.ui.changeBtn2,"res/custom/npc/05jpss/bag1.png","res/custom/npc/05jpss/an1.png","",0)
    GUI:removeAllChildren(self.ui.bigList)
    self.ui = GUI:ui_delegate(self._parent)
    GUI:ScrollView_setBounceEnabled(self.ui.bigList, true)

    local bag_items = SL:GetMetaValue("BAG_DATA")
    local tmp_list = {}
    for k, v in pairs(bag_items) do
        if v.Index==SL:Get_ITEM_INDEX_BY_NAME(self.nowEquipName) then
            local data = {}
            data.index = v.Index
            -- data.count = v.OverLap
            data.look = false
            data.bgVisible = false
            data._MakeIndex = v.MakeIndex
            tmp_list[#tmp_list + 1] = data
        end
    end
    self.has_data_list = tmp_list --#region 背包物品列表

    if #self.has_data_list <= 20 then
        local time = 0
        for i = 1, 5 do
            local list = GUI:ListView_Create(self.ui.bigList,"rightList"..i,0,0,250,60,2)
            GUI:ListView_setItemsMargin(list,3)
            GUI:ListView_setClippingEnabled(list,true)
            GUI:setTouchEnabled(list,false)
            for j = 1, 4 do
                GUI:Image_Create(list,"sonImg"..(i-1)*4+j,0,0,"res/custom/npc/k0.png")
            end
            GUI:setVisible(list,false)
            time = time + 0.05
            GUI:runAction(list, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
                GUI:setVisible(list, true)
                GUI:setPositionX(list, 254)
                GUI:runAction(list, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(list))))
            end)))
        end
    else
        local list_number = math.ceil(#self.has_data_list/4)
        local time = 0
        for i = 1, list_number, 1 do
            local list = GUI:ListView_Create(self.ui.bigList,"rightList"..i,0,0,250,60,2)
            GUI:ListView_setItemsMargin(list,3)
            GUI:ListView_setClippingEnabled(list,true)
            GUI:setTouchEnabled(list,false)
            for j = 1, 4 do
                GUI:Image_Create(list,"sonImg"..(i-1)*4+j,0,0,"res/custom/npc/k0.png")
            end
            GUI:setVisible(list,false)
            time = time + 0.05
            GUI:runAction(list, GUI:ActionSequence(GUI:DelayTime(time), GUI:CallFunc(function()
                GUI:setVisible(list, true)
                GUI:setPositionX(list, 254)
                GUI:runAction(list, GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05, 0, GUI:getPositionY(list))))
            end)))
        end
    end
    for index, value in ipairs(self.has_data_list or {}) do
        self:createSonItem(index)
    end
end
--#region 创建子列表
function EquipSignet1OBJ:createSonItem(sonIndex)
    local item = GUI:ItemShow_Create(self.ui["sonImg"..sonIndex],"sonItem"..sonIndex,29,29
    ,{index = self.has_data_list[sonIndex]["index"],look = false,bgVisible=false,itemData=SL:GetMetaValue("ITEM_DATA_BY_MAKEINDEX",self.has_data_list[sonIndex]["_MakeIndex"],false)})
    GUI:setAnchorPoint(item,0.5,0.5)
    local layout = GUI:Layout_Create(item,"sonLayout"..sonIndex,30,30,60,60,true)
    GUI:setAnchorPoint(layout,0.5,0.5)
    GUI:setTouchEnabled(layout,true)
    GUI:setSwallowTouches(layout, false)
    for i = 1, 3 do
        if self["sonIndex"..i] and self["sonIndex"..i]==sonIndex then
            GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..sonIndex],true)
        end
    end
    GUI:addOnClickEvent(layout,function ()
        for i = 1, 3 do
            if self["sonIndex"..i] and self["sonIndex"..i]==sonIndex then
                self["sonIndex"..i]=nil
                GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..sonIndex], false)
                removeOBJ(self.ui["needEquip"..i],self)
                return
            end
        end
        for i = 1, 3 do
            if not self["sonIndex"..i] then
                break
            elseif i==3 then
                return SL:ShowSystemTips("<font color=\'#ff0000\'>请先取消选取一件副装装备！</font>")
            end
        end
        for i = 1, 3 do
            if not self["sonIndex"..i] then
                self["sonIndex"..i]=sonIndex
                GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..sonIndex], true)
                removeOBJ(self.ui["needEquip"..i],self)
                GUI:ItemShow_Create(self.ui["needEquipBox"..i],"needEquip"..i,0,0,{index = self.has_data_list[sonIndex]["index"],look = true,bgVisible =false
                ,itemData = SL:GetMetaValue("ITEM_DATA_BY_MAKEINDEX",  self.has_data_list[sonIndex]["_MakeIndex"], false)})
                break
            end
        end
    end)
end

function EquipSignet1OBJ:refreshInfoNode() --#region 后端传来刷新属性
    local infoTab = self.str or""
    if infoTab=="" then
        infoTab={}
    else
        infoTab=SL:JsonDecode(infoTab, false)
    end
    -- GUI:Text_setString(self.ui.numberText,#infoTab)
    GUI:removeAllChildren(self.ui.infoNode)
    self.ui = GUI:ui_delegate(self._parent)
    for index = 1, 5 do
        if infoTab[index] then
            local _index=tonumber(infoTab[index][1])
            local _number=tonumber(infoTab[index][2])
            local color="#FFFFFF"
            if self.cfg[_index].type=="普通符文" then
                color="#F7F7DE"
            elseif self.cfg[_index].type=="高级符文" then
                color="#00FDFD"
            elseif self.cfg[_index].type=="稀有符文" then
                color="#FF7700"
            elseif self.cfg[_index].type=="史诗符文" then
                color="#FE00FE"
            end
            if self.cfg[_index].minnum>=100 then
                _number=_number/100
            end
            if self.cfg[_index].percent>0 then
                _number=_number.."%"
            end
            local str=self.cfg[_index].signet.."："..self.cfg[_index].text.."+".._number
            GUI:Text_Create(self.ui.infoNode,"signetText"..index,0,0,16,color, str)
            -- ItemShow_updateItem(self.ui["showItem"..index],{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg[_index]["signet"]),look=true})
            -- GUI:setVisible(self.ui["showItem"..index],true)
        end
    end
    GUI:UserUILayout(self.ui.infoNode, {dir=1,addDir=2,interval=0.5,gap = {y=6},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
end

--#region 后端消息刷新ui
function EquipSignet1OBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["up"] = function()
            for i = 1, 3 do
                self["sonIndex"..i]=nil --#region 当前选取复装序列
                removeOBJ(self.ui["needEquip"..i],self)
            end
            self:refreshRightList2()
            self.str=tab[2]
            self:refreshInfoNode()
            self:refreshNeedItem()
            removeOBJ(self.ui.nowEquip,self)
            GUI:ItemShow_Create(self.ui.nowEquipNode,"nowEquip",-30,-30,{look=true,bgVisible=false,
            index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",SL:Get_EQUIPBYPOS(self.nowPosition)),itemData=SL:Get_EQUIP_DATA(self.nowPosition,false)})
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode,"theEndEffect",478,300,0,14849,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
        end,
        ["info"] = function ()
            self.str=tab[2]
            self:refreshInfoNode()
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if EquipSignet1OBJ.NpcId == npc_info.index then
        -- ViewMgr.open("EquipSignet1OBJ")
        SendMsgClickNpc(EquipSignet1OBJ.NpcId.."#EquipSignet")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "EquipSignet1OBJ", onClickNpc)

return EquipSignet1OBJ