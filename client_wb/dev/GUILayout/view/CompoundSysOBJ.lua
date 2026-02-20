local CompoundSysOBJ = {}
CompoundSysOBJ.Name = "CompoundSysOBJ"
CompoundSysOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
CompoundSysOBJ.NpcId = 0
CompoundSysOBJ.cfg = GetConfig("CompoundSysCfg")


function CompoundSysOBJ:main(page)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/CompoundSysUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    page = tonumber(page) or 1

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshLeftList()
    self:leftBtnEvent(page)

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("CompoundSysOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("CompoundSysOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.NpcId, "CompoundSys", "upEvent"
        ,self.leftIndex1.."#"..self.leftIndex2.."#"..self.rightIndex)
    end)
end

function CompoundSysOBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftBtnList)
    self.ui = GUI:ui_delegate(self._parent)
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
    end
end

function CompoundSysOBJ:leftBtnEvent(leftIndex1)
    self.leftIndex1 = leftIndex1
    removeOBJ(self.ui.nowLeftTag,self)
    GUI:Image_Create(self.ui["leftBtn"..leftIndex1],"nowLeftTag",10,12,"res/custom/ar2.png")
    removeOBJ(self.ui.nowLeftList,self)
    local infoTab = self.cfg[leftIndex1]
    local _height = 44*#infoTab["item_arr"]
    GUI:ScrollView_setInnerContainerSize(self.ui.leftBtnList,120,44*#self.cfg+_height)
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..index], "#BDBDB5")
        GUI:setPositionY(self.ui["leftBtn"..index],440-index*44)
    end
    for i = leftIndex1+1, #self.cfg do
        GUI:setPositionY(self.ui["leftBtn"..i],GUI:getPositionY(self.ui["leftBtn"..i]) - _height)
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex1],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex1], "#FFFFFF")

    local list = GUI:ListView_Create(self.ui["leftBtn"..leftIndex1],"nowLeftList",3,0,114,_height,1)
    GUI:setTouchEnabled(list,false)
    GUI:setAnchorPoint(list,0,1)
    for i = 1, #infoTab["item_arr"] do
        local img = GUI:Image_Create(list,"leftBox"..i,0,0,"res/custom/hecheng/bt1.png")
        local leftBoxName = infoTab["item_arr"][i]
        if leftBoxName:sub(-1)=="1" then
            leftBoxName=leftBoxName:sub(1,-2)
        end
        local name = GUI:Text_Create(img,"leftBoxName"..i,60,22,16,"#F0B42A",leftBoxName)
        GUI:setAnchorPoint(name,0.5,0.5)
        GUI:setLocalZOrder(name,20)
        GUI:setTouchEnabled(name,true)
        GUI:addOnClickEvent(name,function ()
            self:refreshRightList(i)
        end)
    end
    self:refreshRightList(1)
end

function CompoundSysOBJ:refreshRightList(leftIndex2)
    self.leftIndex2=leftIndex2
    removeOBJ(self.ui.nowLeftBoxTag,self)
    GUI:Image_Create(self.ui["leftBox"..leftIndex2],"nowLeftBoxTag",0,0,"res/custom/hecheng/bt3.png")
    GUI:removeAllChildren(self.ui.rightList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    local itemName = self.cfg[self.leftIndex1]["item_arr"][leftIndex2]
    for index, value in ipairs(self.cfg[itemName]["item_arr"]) do
        local img = GUI:Image_Create(self.ui.rightList,"rightBox"..index,0,0,"res/custom/npc/z2.png")
        local text = GUI:Text_Create(img,"rightBoxName"..index,58,16,16,"#FFFFFF",value)
        GUI:setAnchorPoint(text,0.5,0.5)
        local layout = GUI:Layout_Create(img,"rightLayout"..index,0,0,114,34,true)
        GUI:setTouchEnabled(layout, true)
        GUI:addOnClickEvent(layout,function ()
            if self.rightIndex == index then
                return
            end
            self:refreshMidNode(index)
        end)
        GUI:setVisible(img,false)
        time = time +0.05
        GUI:runAction(img,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
            GUI:setVisible(img,true)
            GUI:setPositionX(img,114)
            GUI:runAction(img,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(img))))
        end)))
    end

    self:refreshMidNode(1)
end
function CompoundSysOBJ:refreshMidNode(rightIndex)
    self.rightIndex = rightIndex
    local lastItemName = self.cfg[self.leftIndex1]["item_arr"][self.leftIndex2]
    local itemName = self.cfg[lastItemName]["item_arr"][rightIndex]
    removeOBJ(self.ui.rightMask,self)
    GUI:Image_Create(self.ui["rightBox"..rightIndex],"rightMask",0,0,"res/custom/npc/z3.png")
    GUI:setLocalZOrder(self.ui["rightBoxName"..rightIndex], 20)
    GUI:ItemShow_updateItem(self.ui.nowItem, 
    {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",itemName),look=true,bgVisible=false})
    GUI:Text_setString(self.ui.nowItemName,itemName)

    GUI:removeAllChildren(self.ui.needItemNode)
    self.ui = GUI:ui_delegate(self._parent)
    for i, v in ipairs(self.cfg[itemName]["need_config"]) do
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


--#region 后端消息刷新ui
function CompoundSysOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["add"] = function()
            self:refreshMidNode(self.rightIndex)
        end,
    }
    functionTab[tab[1]]()
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if CompoundSysOBJ.NpcId == npc_info.index then
        ViewMgr.open("CompoundSysOBJ")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "CompoundSysOBJ", onClickNpc)

return CompoundSysOBJ