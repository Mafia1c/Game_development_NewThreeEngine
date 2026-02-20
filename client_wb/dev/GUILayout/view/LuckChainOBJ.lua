local LuckChainOBJ = {}
LuckChainOBJ.Name = "LuckChainOBJ"
LuckChainOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
LuckChainOBJ.NpcId = {10003,1031}
LuckChainOBJ.cfg1 = {"元宝",2000}
LuckChainOBJ.cfg2 = {"元宝",20000}
LuckChainOBJ.cfg3 = {"元宝",5000}


function LuckChainOBJ:main(nowNpcId,luck,odd_BJ,odd_SS)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LuckChainUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.nowNpcId=tonumber(nowNpcId) --#regoin 当前打开npcId
    self.luck = tonumber(luck)
    self.odd_BJ = tonumber(odd_BJ)
    self.odd_SS = tonumber(odd_SS)
    GUI:Timeline_Window4(self.ui.FrameLayout)
    if self.nowNpcId==10003 then
        GUI:setVisible(self.ui.leftBtn3,false)
        self:refreshMidNode(1)
    elseif self.nowNpcId==1031 then
        GUI:setVisible(self.ui.leftBtn3,true)
        self:refreshMidNode(3)
    end
    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["leftBtn"..i],function ()
            if self.leftIndex==i then return end
            self:refreshMidNode(i)
        end)
    end

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("LuckChainOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("LuckChainOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        if SL:GetMetaValue("EQUIPBYPOS", 3) == "" then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先穿戴项链再来强化！</font>")
        end
        SendMsgCallFunByNpc(self.nowNpcId, "LuckChain", "upEvent", "")
    end)
    GUI:addOnClickEvent(self.ui.clearBtn, function()
        if SL:GetMetaValue("EQUIPBYPOS", 3) == "" then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先穿戴项链再来清洗属性！</font>")
        end
        SendMsgCallFunByNpc(self.nowNpcId, "LuckChain", "clearEvent", "")
    end)
    GUI:addOnClickEvent(self.ui.moveBtn,function () --#region 幸运转移
        if SL:GetMetaValue("EQUIPBYPOS", 3) == "" then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先穿戴项链再来转移属性！</font>")
        elseif not self.ui.item_3 then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先选取背包拥有的项链再来转移属性！</font>")
        end
        SendMsgCallFunByNpc(self.nowNpcId, "LuckChain", "transfer", self.has_data_list[self.sonIndex]["_MakeIndex"])
    end)
    GUI:addOnClickEvent(self.ui.awakeBtn, function()
        if SL:GetMetaValue("EQUIPBYPOS", 3) == "" then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先穿戴项链再来觉醒！</font>")
        end
        SendMsgCallFunByNpc(self.nowNpcId, "LuckChain", "awakeEvent", "")
    end)
end

function LuckChainOBJ:refreshMidNode(leftIndex)
    self.leftIndex=leftIndex
    for i = 1, 3 do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..i],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..i], "#BDBDB5")
        GUI:setVisible(self.ui["infoNode"..i],i==leftIndex)
        GUI:removeAllChildren(self.ui["itemNode"..i])
        self.ui = GUI:ui_delegate(self._parent)
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")
    if leftIndex==1 then --#region 幸运淬炼
        GUI:removeAllChildren(self.ui.bigList2)
        self.ui = GUI:ui_delegate(self._parent)
        GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/37xl/bg1.png")
        local oddTab={"100%","50%","25%"}
        local itemColor = 249
        if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED",SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg1[1]))) >= self.cfg1[2] then
            itemColor = 250
        end
        GUI:ItemShow_Create(self.ui.itemNode1,"need_item1",-30,-84,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg1[1]),count=self.cfg1[2],color=itemColor,look=true,bgVisible=false})
        if SL:GetMetaValue("EQUIPBYPOS", 3) ~= "" then
            GUI:Text_setString(self.ui.luckText11, "+"..self.luck)
            GUI:Text_setString(self.ui.oddText11,oddTab[self.luck+1] or "0%")
            GUI:Text_setString(self.ui.nameText11,SL:Get_EQUIPBYPOS(3))
            GUI:Text_setString(self.ui.numberText11,self.odd_BJ.."%")
            GUI:ItemShow_Create(self.ui.itemNode3,"item_3",46,-6,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",SL:Get_EQUIPBYPOS(3)),look=true,itemData=SL:Get_EQUIP_DATA(3,false),bgVisible=false})
        end
    elseif leftIndex==2 then --#region 幸运转移
        GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/37xl/bg2.png")
        self:refreshRightList()
    elseif leftIndex==3 then --#region 幸运觉醒
        GUI:removeAllChildren(self.ui.bigList2)
        self.ui = GUI:ui_delegate(self._parent)
        GUI:Image_loadTexture(self.ui.FrameBG,"res/custom/npc/37xl/bg1.png")
        local itemColor = 249
        if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED",SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg3[1]))) >= self.cfg3[2] then
            itemColor = 250
        end
        GUI:ItemShow_Create(self.ui.itemNode1,"need_item1",-30,-84,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg3[1]),count=self.cfg3[2],color=itemColor,look=true,bgVisible=false})
        if SL:GetMetaValue("EQUIPBYPOS", 3) ~= "" then
            GUI:Text_setString(self.ui.luckText31, "+"..self.luck)
            GUI:Text_setString(self.ui.oddText31,"100%")
            GUI:Text_setString(self.ui.nameText31,SL:Get_EQUIPBYPOS(3))
            GUI:Text_setString(self.ui.numberText31,self.odd_SS.."%")
            GUI:ItemShow_Create(self.ui.itemNode3,"item_3",46,-6,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",SL:Get_EQUIPBYPOS(3)),look=true,itemData=SL:Get_EQUIP_DATA(3,false),bgVisible=false})
        end
    end
end

function LuckChainOBJ:refreshRightList() --#region 幸运转移
    local itemColor = 249
    if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED",SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg2[1]))) >= self.cfg2[2] then
        itemColor = 250
    end
    GUI:ItemShow_Create(self.ui.itemNode2,"need_item2",-30,-30,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg2[1]),count=self.cfg2[2],color=itemColor,look=true,bgVisible=false})
    if SL:GetMetaValue("EQUIPBYPOS", 3) ~= "" then
        GUI:Text_setString(self.ui.luckText22, "+"..self.luck)
        GUI:Text_setString(self.ui.nameText22,SL:Get_EQUIPBYPOS(3))
        GUI:ItemShow_Create(self.ui.itemNode1,"item_1",-30,-30,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",SL:Get_EQUIPBYPOS(3)),look=true,itemData=SL:Get_EQUIP_DATA(3,false),bgVisible=false})
    end

    GUI:removeAllChildren(self.ui.bigList2)
    self.ui = GUI:ui_delegate(self._parent)
    local bag_items = SL:GetMetaValue("BAG_DATA")
    local tmp_list = {}
    for k, v in pairs(bag_items) do
        if isInTable({19,20,21},v.StdMode) then
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
            local list = GUI:ListView_Create(self.ui.bigList2,"rightList2"..i,0,0,252,60,2)
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
            local list = GUI:ListView_Create(self.ui.bigList2,"rightList2"..i,0,0,252,60,2)
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
function LuckChainOBJ:createSonItem(sonIndex)
    local item = GUI:ItemShow_Create(self.ui["sonImg"..sonIndex],"sonItem"..sonIndex,29,29
    ,{index = self.has_data_list[sonIndex]["index"],look = false,bgVisible =false,itemData = SL:GetMetaValue("ITEM_DATA_BY_MAKEINDEX",  self.has_data_list[sonIndex]["_MakeIndex"], false)})
    GUI:setAnchorPoint(item,0.5,0.5)
    local layout = GUI:Layout_Create(item,"sonLayout"..sonIndex,30,30,60,60,true)
    GUI:setAnchorPoint(layout,0.5,0.5)
    GUI:setTouchEnabled(layout,true)
    GUI:setSwallowTouches(layout, false)
    GUI:addOnClickEvent(layout,function ()
        if self.sonIndex == sonIndex then
            GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..sonIndex], false)
            self.sonIndex = nil
            removeOBJ(self.ui.item_3,self)
        else
            if self.sonIndex ~= nil then
                GUI:ItemShow_setItemShowChooseState(self.ui["sonItem"..self.sonIndex], false)
            end
            self.sonIndex = sonIndex
            GUI:ItemShow_setItemShowChooseState(self.ui["sonItem" .. sonIndex], true)
            removeOBJ(self.ui.item_3,self)
            GUI:ItemShow_Create(self.ui.itemNode3,"item_3",-30,-30
            ,{index = self.has_data_list[sonIndex]["index"],look = true,bgVisible =false,itemData = SL:GetMetaValue("ITEM_DATA_BY_MAKEINDEX",  self.has_data_list[sonIndex]["_MakeIndex"], false)})
        end
    end)
end

--#region 后端消息刷新ui
function LuckChainOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["淬炼"] = function()
            self.luck = tonumber(tab[2])
            self.odd_BJ = tonumber(tab[3])
            self.odd_SS = tonumber(tab[4])
            self:refreshMidNode(self.leftIndex)
        end,
        ["失败"] = function()
            self.luck = tonumber(tab[2])
            self.odd_BJ = tonumber(tab[3])
            self.odd_SS = tonumber(tab[4])
            self:refreshMidNode(self.leftIndex)
        end,
        ["clear"] = function ()
            self.luck = tonumber(tab[2])
            self.odd_BJ = tonumber(tab[3])
            self.odd_SS = tonumber(tab[4])
            self:refreshMidNode(self.leftIndex)
        end,
        ["transfer"] = function ()
            -- self.sonIndex = nil
            self.luck = tonumber(tab[2])
            self.odd_BJ = tonumber(tab[3])
            self.odd_SS = tonumber(tab[4])
            self:refreshMidNode(self.leftIndex)
        end,
        ["awake"] = function ()
            self.luck = tonumber(tab[2])
            self.odd_BJ = tonumber(tab[3])
            self.odd_SS = tonumber(tab[4])
            self:refreshMidNode(self.leftIndex)
        end,
    }
    functionTab[tab[1]]()
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(LuckChainOBJ.NpcId,npc_info.index) then
        -- ViewMgr.open("LuckChainOBJ",npc_info.index)
        SendMsgClickNpc(npc_info.index.."#LuckChain#"..npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "LuckChainOBJ", onClickNpc)

return LuckChainOBJ