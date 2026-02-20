local MakeJewelry1OBJ = {}
MakeJewelry1OBJ.Name = "MakeJewelry1OBJ"
MakeJewelry1OBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
MakeJewelry1OBJ.NpcId = 131
MakeJewelry1OBJ.cfg = GetConfig("MakeJewelry1Cfg")
local tips={
        "<上古  I  /FCOLOR=254><[战]    /FCOLOR=7><任意：龙吟首饰*3 → 啸天首饰/FCOLOR=254>\\<上古  I  /FCOLOR=254><[法]    /FCOLOR=7><任意：修罗首饰*3 → 暗月首饰/FCOLOR=254>\\<上古  I  /FCOLOR=254><[道]    /FCOLOR=7><任意：仙风首饰*3 → 太玄首饰/FCOLOR=254>"
    .."\\<上古  II /FCOLOR=251><[战]    /FCOLOR=7><任意：啸天首饰*3 → 追日首饰/FCOLOR=251>\\<上古  II /FCOLOR=251><[法]    /FCOLOR=7><任意：暗月首饰*3 → 揽月首饰/FCOLOR=251>\\<上古  II /FCOLOR=251><[道]    /FCOLOR=7><任意：太玄首饰*3 → 摘星首饰/FCOLOR=251>"
    .."\\<上古 III /FCOLOR=180><[战]    /FCOLOR=7><任意：追日首饰*3 → 金刚首饰/FCOLOR=180>\\<上古 III /FCOLOR=180><[法]    /FCOLOR=7><任意：揽月首饰*3 → 五行首饰/FCOLOR=180>\\<上古 III /FCOLOR=180><[道]    /FCOLOR=7><任意：摘星首饰*3 → 神谕首饰/FCOLOR=180>"
    .."\\<绝世  I  /FCOLOR=250><[战]    /FCOLOR=7><任意：金刚首饰*3 → 破坏首饰/FCOLOR=250>\\<绝世  I  /FCOLOR=250><[法]    /FCOLOR=7><任意：五行首饰*3 → 流星首饰/FCOLOR=250>\\<绝世  I  /FCOLOR=250><[道]    /FCOLOR=7><任意：神谕首饰*3 → 乾坤首饰/FCOLOR=250>"
    .."\\<绝世  II /FCOLOR=243><[战]    /FCOLOR=7><任意：破坏首饰*3 → 帝王首饰/FCOLOR=243>\\<绝世  II /FCOLOR=243><[法]    /FCOLOR=7><任意：流星首饰*3 → 七彩首饰/FCOLOR=243>\\<绝世  II /FCOLOR=243><[道]    /FCOLOR=7><任意：乾坤首饰*3 → 虚空首饰/FCOLOR=243>"
    .."\\<绝世 III /FCOLOR=245><[战]    /FCOLOR=7><任意：帝王首饰*3 → 武圣首饰/FCOLOR=245>\\<绝世 III /FCOLOR=245><[法]    /FCOLOR=7><任意：七彩首饰*3 → 雷神首饰/FCOLOR=245>\\<绝世 III /FCOLOR=245><[道]    /FCOLOR=7><任意：虚空首饰*3 → 泰坦首饰/FCOLOR=245>"
}

function MakeJewelry1OBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/MakeJewelry1UI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshLeftList()
    self:leftBtnEvent(1)

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("MakeJewelry1OBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("MakeJewelry1OBJ")
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
        SendMsgCallFunByNpc(self.NpcId, "MakeJewelry1", "upEvent", self.leftIndex.."#"..self.select_makeIndex1.."#"..self.select_makeIndex2.."#"..self.select_makeIndex3)
    end)
end

function MakeJewelry1OBJ:refreshLeftList()
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

function MakeJewelry1OBJ:leftBtnEvent(leftIndex)
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
    GUI:Text_setString(self.ui.needText2,self.cfg[leftIndex]["money2"]..self.cfg[leftIndex]["money1"])
    if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg[leftIndex]["money1"]))) >= self.cfg[leftIndex]["money2"] then
        GUI:Text_setTextColor(self.ui.needText2, "#00FF00")
    else
        GUI:Text_setTextColor(self.ui.needText2, "#ff0000")
    end

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
function MakeJewelry1OBJ:createSonItem(sonIndex)
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


--#region 后端消息刷新ui
function MakeJewelry1OBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["成功"]=function ()
            self:leftBtnEvent(self.leftIndex)
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.rightNode,"theEndEffect",478,300,0,14801,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
            GUI:setLocalZOrder(self.ui.theEndEffect, 20)
        end
    }
    functionTab[tab[1]]()
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if MakeJewelry1OBJ.NpcId == npc_info.index then
        ViewMgr.open("MakeJewelry1OBJ")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "MakeJewelry1OBJ", onClickNpc)

return MakeJewelry1OBJ