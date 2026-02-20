local FourCellOBJ = {}
FourCellOBJ.Name = "FourCellOBJ"
FourCellOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
FourCellOBJ.NpcId = 64
FourCellOBJ.cfg = GetConfig("FourCellCfg")


function FourCellOBJ:main(leftIndex,rightIndex)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/FourCellUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self.leftIndex = tonumber(leftIndex) or 1
    self.rightIndex = tonumber(rightIndex) or 1 
    self:refreshLeftList()
    self:leftBtnEvent(self.leftIndex)

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("FourCellOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("FourCellOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn1, function()
        SendMsgCallFunByNpc(self.NpcId, "FourCell", "upEvent1", self.leftIndex.."#"..self.rightIndex)
    end)
    GUI:addOnClickEvent(self.ui.upBtn2, function()
        SendMsgCallFunByNpc(self.NpcId, "FourCell", "upEvent2", self.leftIndex.."#"..self.rightIndex)
    end)
end

function FourCellOBJ:refreshLeftList()
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

function FourCellOBJ:leftBtnEvent(leftIndex)
    self.leftIndex = leftIndex
    for index, value in ipairs(self.cfg) do
        GUI:Button_loadTextureNormal(self.ui["leftBtn"..index],"res/custom/npc/ta1.png")
        GUI:Button_setTitleColor(self.ui["leftBtn"..index], "#BDBDB5")
    end
    GUI:Button_loadTextureNormal(self.ui["leftBtn"..leftIndex],"res/custom/npc/ta0.png")
    GUI:Button_setTitleColor(self.ui["leftBtn"..leftIndex], "#FFFFFF")
    GUI:Text_setString(self.ui.rightTagName, string.sub(self.cfg[leftIndex]["type"], 1, 6))
    GUI:setVisible(self.ui.rightTag, true)

    GUI:removeAllChildren(self.ui.rightList)
    self.ui = GUI:ui_delegate(self._parent)
    local nowIndex = 1
    local time = 0
    local red_check_list = {}
    for index, value in ipairs(self.cfg[leftIndex]["equip_arr"]) do
        red_check_list["rightBox"..index] = RedPointMgr.GetRedDataByBtnName("FourCellOBJ","rightBox"..index)
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
    -- if leftIndex==1 then --#region 老显示
    --     GUI:setVisible(self.ui.upBtn1,true)
    --     GUI:Button_setTitleText(self.ui.upBtn2,"身上合成")
    --     GUI:setPositionX(self.ui.upBtn2,648)
    --     local time = 0
    --     for index, value in ipairs(self.cfg[leftIndex]["equip_arr"]) do
    --         local img = GUI:Image_Create(self.ui.rightList,"rightBox"..index,0,0,"res/custom/npc/z2.png")
    --         local text = GUI:Text_Create(img,"rightBoxName"..index,58,16,16,"#FFFFFF",value)
    --         GUI:setAnchorPoint(text,0.5,0.5)
    --         local layout = GUI:Layout_Create(img,"rightLayout"..index,0,0,114,34,true)
    --         GUI:setTouchEnabled(layout, true)
    --         GUI:addOnClickEvent(layout,function ()
    --             if self.rightIndex == index then
    --                 return
    --             end
    --             self:refreshMidNode(index)
    --         end)
    --         GUI:setVisible(img,false)
    --         time = time +0.05
    --         GUI:runAction(img,GUI:ActionSequence(GUI:DelayTime(time),GUI:CallFunc(function()
    --             GUI:setVisible(img,true)
    --             GUI:setPositionX(img,114)
    --             GUI:runAction(img,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.05,0,GUI:getPositionY(img))))
    --         end)))
    --     end
    -- else
    --     GUI:setVisible(self.ui.upBtn1,false)
    --     GUI:Button_setTitleText(self.ui.upBtn2,"开始合成")
    --     GUI:setPositionX(self.ui.upBtn2,566)
    --     local position = self.cfg[leftIndex]["position"]
    --     for index, value in ipairs(self.cfg[leftIndex]["equip_arr"]) do
    --         if SL:Get_EQUIPBYPOS(position)==value then
    --             nowIndex=index+1
    --             if nowIndex>#self.cfg[leftIndex]["equip_arr"] then
    --                 nowIndex=#self.cfg[leftIndex]["equip_arr"]
    --             end
    --             break
    --         end
    --     end
    --     local img = GUI:Image_Create(self.ui.rightList,"rightBox"..nowIndex,0,0,"res/custom/npc/z2.png")
    --     local text = GUI:Text_Create(img,"rightBoxName"..nowIndex,58,16,16,"#FFFFFF",self.cfg[leftIndex]["equip_arr"][nowIndex])
    --     GUI:setAnchorPoint(text,0.5,0.5)
    --     local layout = GUI:Layout_Create(img,"rightLayout"..nowIndex,0,0,114,34,true)
    --     GUI:setTouchEnabled(layout, true)
    --     GUI:addOnClickEvent(layout,function ()
    --         if self.rightIndex == nowIndex then
    --             return
    --         end
    --         self:refreshMidNode(nowIndex)
    --     end)
    -- end

    if leftIndex>1 then
        local position = self.cfg[leftIndex]["position"]
        for index, value in ipairs(self.cfg[leftIndex]["equip_arr"]) do
            if SL:Get_EQUIPBYPOS(position)==value then
                nowIndex=index+1
                if nowIndex>=#self.cfg[leftIndex]["equip_arr"] then
                    nowIndex=#self.cfg[leftIndex]["equip_arr"]
                end
                break
            end
        end
    end
    self:refreshMidNode((leftIndex==1 and (self.rightIndex or 1))or nowIndex)
   
    red_check_list.view_name = "FourCellOBJ"
    red_check_list.node = self
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_check_list)
end

function FourCellOBJ:refreshMidNode(rightIndex)
    self.rightIndex = rightIndex
    if self.leftIndex==1 then
        GUI:setVisible(self.ui.upBtn1,true)
        GUI:setVisible(self.ui.upBtn2,true)
        GUI:setPositionX(self.ui.upBtn1,494)
        GUI:setPositionX(self.ui.upBtn2,648)
        if rightIndex==1 then
            GUI:setVisible(self.ui.upBtn1,true)
            GUI:setVisible(self.ui.upBtn2,false)
            GUI:setPositionX(self.ui.upBtn1,566)
        end
    else
        GUI:setVisible(self.ui.upBtn1,false)
        GUI:setVisible(self.ui.upBtn2,true)
        GUI:setPositionX(self.ui.upBtn1,494)
        GUI:setPositionX(self.ui.upBtn2,566)
    end
    local equipName = self.cfg[self.leftIndex]["equip_arr"][rightIndex]
    local position=self.cfg[self.leftIndex].position
    removeOBJ(self.ui.rightMask,self)
    GUI:Image_Create(self.ui["rightBox"..rightIndex],"rightMask",0,0,"res/custom/npc/z3.png")
    GUI:setLocalZOrder(self.ui["rightBoxName"..rightIndex], 20)
    GUI:ItemShow_updateItem(self.ui.nowItem, 
    {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg[self.leftIndex]["equip_arr"][rightIndex]),look=true,bgVisible=false})
    GUI:Text_setString(self.ui.equipName,equipName)

    GUI:removeAllChildren(self.ui.needItemNode)
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
        if self.leftIndex>1 and i==1 and SL:Get_EQUIPBYPOS(position)==v[1] then
            itemColor = 250
        end
        local item = GUI:ItemShow_Create(self.ui.needItemNode, "need_item"..i, 0, 0, {index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true})
        ItemShow_updateItem(item,{index=itemIndex,count=itemCount,color=itemColor,look=true,bgVisible=true,showCount=true})
    end
    GUI:UserUILayout(self.ui["needItemNode"], {dir=2,addDir=2,interval=0.5,gap = {x=20},sortfunc = function (lists)
        table.sort(lists, function (a, b)
            return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
        end)
    end})
    local red_check_list = {}
    red_check_list.view_name = "FourCellOBJ"
    red_check_list.node = self
    red_check_list.upBtn1 = RedPointMgr.GetRedDataByBtnName("FourCellOBJ","upBtn1")
    red_check_list.upBtn2 = RedPointMgr.GetRedDataByBtnName("FourCellOBJ","upBtn2")
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_check_list)
end


--#region 后端消息刷新ui
function FourCellOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["refresh"] = function()
            self:leftBtnEvent(self.leftIndex)
        end,
    }
    functionTab[tab[1]]()
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "FourCellOBJ",["node"] = self,["is_all"] = true})
end

function FourCellOBJ:RightBoxRed(index,left_index)
    index = tonumber(index)
    local leftIndex = left_index or FourCellOBJ.leftIndex
    if index == nil or leftIndex == nil then return false end
    local equipName = FourCellOBJ.cfg[leftIndex]["equip_arr"][index]
    local position= FourCellOBJ.cfg[leftIndex].position
    for i, v in ipairs(FourCellOBJ.cfg[equipName]["need_config"]) do
        local itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",v[1])
        local itemCount = v[2]
        local itemColor = 249
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if leftIndex > 1  then  --没有背包合成
                if i == 1  then
                    if SL:Get_EQUIPBYPOS(position)~=v[1] then
                        return false
                    end
                else
                    if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) < itemCount  then
                        return false
                    end
                end

            else  --背包 + 身上
                if SL:Get_EQUIPBYPOS(position)== equipName then
                    return false
                end
                local count = tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex))
                if index == 1 then
                   if count < itemCount or SL:Get_EQUIPBYPOS(position) ~= ""  then
                        return false
                   end
                else
                    if i == 1 then 
                        count = count + (SL:Get_EQUIPBYPOS(position)~=v[1] and 0 or 1)
                    end
                end
                if count < itemCount then
                    return false
                end
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
    return true
end

function FourCellOBJ:LeftBtnBoxRed(index)
    index = tonumber(index)
    if index == nil then return false end
    local cfg = FourCellOBJ.cfg[index]
    for i,v in ipairs(cfg.equip_arr) do
        if FourCellOBJ:RightBoxRed(i,index) then
            return true
        end
    end
    return false
end

function FourCellOBJ:upBtnRed(index)
    index = tonumber(index)
    if index == nil or FourCellOBJ.leftIndex == nil or FourCellOBJ.rightIndex == nil  then return false end
    local equipName = FourCellOBJ.cfg[FourCellOBJ.leftIndex]["equip_arr"][FourCellOBJ.rightIndex]
    local position= FourCellOBJ.cfg[FourCellOBJ.leftIndex].position
    for i, v in ipairs(FourCellOBJ.cfg[equipName]["need_config"]) do
        local itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",v[1])
        local itemCount = v[2]
        local itemColor = 249
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if index == 1 then
                if FourCellOBJ.leftIndex > 1 then
                    return false
                end
                if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) < itemCount or SL:Get_EQUIPBYPOS(position) ~= "" then
                    return false
                end
            else
                local count = tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex))
                if i == 1 then
                    if SL:Get_EQUIPBYPOS(position)~=v[1] then
                        return false
                    end
                    count = count + 1
                end
                if count < itemCount then
                    return false
                end
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
    return true
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if FourCellOBJ.NpcId == npc_info.index then
        SendMsgCallFunByNpc(npc_info.index, "FourCell", "onClick")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "FourCellOBJ", onClickNpc)

return FourCellOBJ