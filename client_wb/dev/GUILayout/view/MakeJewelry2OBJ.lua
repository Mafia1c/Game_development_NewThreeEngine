local MakeJewelry2OBJ = {}
MakeJewelry2OBJ.Name = "MakeJewelry2OBJ"
MakeJewelry2OBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
MakeJewelry2OBJ.NpcId = 146
MakeJewelry2OBJ.cfg = GetConfig("MakeJewelry2Cfg")
local tips={
        "<传承  I  /FCOLOR=251>< [战]    /FCOLOR=7><任意：武圣首饰*3 → 英雄首饰/FCOLOR=251>\\<传承  I  /FCOLOR=251>< [法]    /FCOLOR=7><任意：雷神首饰*3 → 魔灵首饰/FCOLOR=251>\\<传承  I  /FCOLOR=251>< [道]    /FCOLOR=7><任意：泰坦首饰*3 → 阐释首饰/FCOLOR=251>"
    .."\\<传承  II /FCOLOR=254>< [战]    /FCOLOR=7><任意：英雄首饰*3 → 赤龙首饰/FCOLOR=254>\\<传承  II /FCOLOR=254>< [法]    /FCOLOR=7><任意：魔灵首饰*3 → 追魂首饰/FCOLOR=254>\\<传承  II /FCOLOR=254>< [道]    /FCOLOR=7><任意：阐释首饰*3 → 昆仑首饰/FCOLOR=254>"
    .."\\<传承 III /FCOLOR=253>< [战]    /FCOLOR=7><任意：赤龙首饰*3 → 阎罗首饰/FCOLOR=253>\\<传承 III /FCOLOR=253>< [法]    /FCOLOR=7><任意：追魂首饰*3 → 毁灭首饰/FCOLOR=253>\\<传承 III /FCOLOR=253>< [道]    /FCOLOR=7><任意：昆仑首饰*3 → 避邪首饰/FCOLOR=253>"
}

function MakeJewelry2OBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/MakeJewelry2UI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshLeftList()
    self:leftBtnEvent(1)

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("MakeJewelry2OBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("MakeJewelry2OBJ")
    end)
    GUI:addOnClickEvent(self.ui.tipsBtn,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn)
        GUI:ShowWorldTips(tips[1], worldPos, GUI:p(1, 1))
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        for i = 1, 3 do
            if not self.ui["showItem_"..i] then
                return SL:ShowSystemTips("<font color=\'#ff0000\'>请先选取3个所需材料再进行锻造！</font>")
            end
        end
        SendMsgCallFunByNpc(self.NpcId, "MakeJewelry2", "upEvent", self.leftIndex.."#"..self.select_makeIndex1.."#"..self.select_makeIndex2.."#"..self.select_makeIndex3)
    end)
end

function MakeJewelry2OBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftBtnList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for index, value in ipairs(self.cfg) do
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
    end
end

function MakeJewelry2OBJ:leftBtnEvent(leftIndex)
    self.leftIndex = leftIndex
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..index], "#BDBDB5")
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")
    for i = 1, 3 do
        GUI:removeAllChildren(self.ui["equipNode"..i])
        self["select_itemIndex"..i] = nil
        self["select_makeIndex"..i] = nil
    end
    self.ui = GUI:ui_delegate(self._parent)
    self:refreshNeedItem()

    GUI:removeAllChildren(self.ui.bigList)
    self.ui = GUI:ui_delegate(self._parent)
    local bag_items = SL:GetMetaValue("BAG_DATA")
    local tmp_list = {}
    for k, v in pairs(bag_items) do
        if isInTable(self.cfg[leftIndex]["need_arr0"],v.Name) or isInTable(self.cfg[leftIndex]["need_arr1"],v.Name)
        or isInTable(self.cfg[leftIndex]["need_arr2"],v.Name) then
            local data = {}
            data.index = v.Index
            -- data.count = v.OverLap
            data.look = false
            data.bgVisible = false
            data._MakeIndex = v.MakeIndex
            tmp_list[#tmp_list + 1] = data
        end
    end
    table.sort(tmp_list, function (a,b)
        return a.index < b.index
    end)
    self.has_data_list = tmp_list --#region 背包物品列表

    if #self.has_data_list <= 24 then
        local time = 0
        for i = 1, 6 do
            local list = GUI:ListView_Create(self.ui.bigList,"rightList"..i,0,0,252,60,2)
            GUI:ListView_setItemsMargin(list,4)
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
            local list = GUI:ListView_Create(self.ui.bigList,"rightList"..i,0,0,252,60,2)
            GUI:ListView_setItemsMargin(list,4)
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
function MakeJewelry2OBJ:createSonItem(sonIndex)
    local item = GUI:ItemShow_Create(self.ui["sonImg"..sonIndex],"sonItem"..sonIndex,30,30
    ,{index = self.has_data_list[sonIndex]["index"],look = false,bgVisible =false,itemData = SL:GetMetaValue("ITEM_DATA_BY_MAKEINDEX",  self.has_data_list[sonIndex]["_MakeIndex"], false)})
    GUI:setAnchorPoint(item,0.5,0.5)
    local layout = GUI:Layout_Create(item,"sonLayout"..sonIndex,30,30,60,60,true)
    GUI:setAnchorPoint(layout,0.5,0.5)
    GUI:setTouchEnabled(layout,true)
    GUI:setSwallowTouches(layout, false)
    GUI:addOnClickEvent(layout,function ()
        for i = 1, 3 do
            if self.ui["showItem_"..i] and self["select_makeIndex"..i] == self.has_data_list[sonIndex]["_MakeIndex"] then
                GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..sonIndex], false)
                removeOBJ(self.ui["showItem_"..i],self)
                self["select_itemIndex"..i] = nil
                self["select_makeIndex"..i] = nil
                return
            end
        end

        for i = 1, 3 do
            if not self.ui["showItem_"..i] then
                self["select_itemIndex"..i] = self.has_data_list[sonIndex]["index"]
                self["select_makeIndex"..i] = self.has_data_list[sonIndex]["_MakeIndex"]
                GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..sonIndex], true)
                GUI:ItemShow_Create(self.ui["equipNode"..i],"showItem_"..i,-30,-30
                ,{index = self.has_data_list[sonIndex]["index"],look = true,bgVisible =false,itemData = SL:GetMetaValue("ITEM_DATA_BY_MAKEINDEX",  self.has_data_list[sonIndex]["_MakeIndex"], false)})
                break
            elseif i == 3 then
                return SL:ShowSystemTips("<font color=\'#ff0000\'>请先取消一个材料再进行选取！</font>")
            end
        end

    end)
end

function MakeJewelry2OBJ:refreshNeedItem() --#region 需要物品
    GUI:removeAllChildren(self.ui.needItemNode)
    self.ui = GUI:ui_delegate(self._parent)
    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[self.leftIndex] or (self.cfg[self.leftIndex] and self.cfg[self.leftIndex]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        local itemColor = 249
        for j = 1, self.cfg[self.leftIndex]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[self.leftIndex][keyName]
            itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",itemName)
            itemCount = self.cfg[self.leftIndex][keyItemCount]
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


--#region 后端消息刷新ui
function MakeJewelry2OBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["成功"]=function ()
            self:leftBtnEvent(self.leftIndex)
        end
    }
    functionTab[tab[1]]()
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if MakeJewelry2OBJ.NpcId == npc_info.index then
        ViewMgr.open("MakeJewelry2OBJ")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MakeJewelry2OBJ", onClickNpc)

return MakeJewelry2OBJ