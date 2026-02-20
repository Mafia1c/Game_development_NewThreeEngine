local EquipSignet2OBJ = {}
EquipSignet2OBJ.Name = "EquipSignet2OBJ"
EquipSignet2OBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
EquipSignet2OBJ.NpcId = 123
EquipSignet2OBJ.cfg=GetConfig("EquipSignetCfg")
EquipSignet2OBJ.cfg1={{78,"黑金古刃"},{79,"天蚕の甲"},{80,"痛苦の盔"},{81,"双鱼の佩"},{82,"转世の手"},{83,"轮回の爪"},{84,"神の戒"}
,{85,"魔の戒"},{86,"紫金の带"},{87,"幻影の靴"}}
EquipSignet2OBJ.cfg2={["need_config"]={{"仙石",20,0},{"元宝",50000,2}},} --#region 专属附魔

function EquipSignet2OBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/EquipSignet2UI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self.leftIndex=nil
    self:refreshLeftList()
    for index, value in ipairs(self.cfg1) do
        if SL:GetMetaValue("EQUIPBYPOS", value[1]) == value[2] then
            self:refreshMidNode(index)
            break
        end
    end

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("EquipSignet2OBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("EquipSignet2OBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        if self.leftIndex == nil or not self.ui.nowEquip then
            return SL:ShowSystemTips("<font color=\'#ff0000\'>请先穿戴一件白日门专属装备再来附魔！</font>")
        end
        SendMsgCallFunByNpc(self.NpcId, "EquipSignet", "upEvent2", self.leftIndex)
    end)
end

function EquipSignet2OBJ:refreshLeftList()
    GUI:removeAllChildren(self.ui.leftBtnList)
    self.ui = GUI:ui_delegate(self._parent)
    local time = 0
    for i = 1, 10, 1 do
        local position = self.cfg1[i][1]
        local equipName = self.cfg1[i][2]
        if SL:GetMetaValue("EQUIPBYPOS", position) ~= equipName then
            goto continue
        end
        local box = GUI:Image_Create(self.ui.leftBtnList,"leftBox"..i,0,0,"res/custom/npc/z2.png")
        local text = GUI:Text_Create(box,"equipName"..i,58,18,16,"#FF7700",equipName)
        GUI:setAnchorPoint(text,0.5,0.5)
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

function EquipSignet2OBJ:refreshMidNode(leftIndex,temp) --#region 刷新nodeBox
    self.leftIndex = leftIndex
    if not temp then
        SendMsgCallFunByNpc(self.NpcId, "EquipSignet", "infoEvent2", leftIndex)
    end

    removeOBJ(self.ui.leftMask,self)
    GUI:Image_Create(self.ui["leftBox"..leftIndex],"leftMask",0,0,"res/custom/npc/z3.png")
    local position = self.cfg1[leftIndex][1]
    local equipName = self.cfg1[leftIndex][2]
    GUI:Text_setString(self.ui.nowEquipName,equipName)
    removeOBJ(self.ui.nowEquip,self)
    GUI:ItemShow_Create(self.ui.nowEquipNode,"nowEquip",-30,-30,{look=true,itemData=GUIFunction:GetEquipDataByPos(position,false, 1)})

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
function EquipSignet2OBJ:refreshInfoNode() --#region 后端传来刷新属性
    local infoTab = self.str or""
    if infoTab=="" then
        infoTab={}
    else
        infoTab=SL:JsonDecode(infoTab, false)
    end
    GUI:Text_setString(self.ui.numberText,#infoTab)
    for index = 1, 5 do
        if infoTab[index] then
            local _index=tonumber(infoTab[index][1])
            local _number=tonumber(infoTab[index][2])
            GUI:setVisible(self.ui["noText"..index],false)
            GUI:Text_setString(self.ui["infoText"..index.."1"],self.cfg[_index]["signet"]..":+")
            if self.cfg[_index].minnum>=100 then
                _number=_number/100
            end
            if self.cfg[_index].percent>0 then
                _number=_number.."%"
            end
            GUI:Text_setString(self.ui["infoText"..index.."2"],_number)
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
            GUI:Text_setTextColor(self.ui["infoText"..index.."1"],color)
            ItemShow_updateItem(self.ui["showItem"..index],{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg[_index]["signet"]),look=true})
            GUI:setVisible(self.ui["showItem"..index],true)
        else
            GUI:setVisible(self.ui["noText"..index],true)
            GUI:setVisible(self.ui["showItem"..index],false)
        end
    end
end

--#region 后端消息刷新ui
function EquipSignet2OBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["up"] = function()
            self:refreshMidNode(self.leftIndex,1)
            self.str=tab[2]
            self:refreshInfoNode()
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
    if EquipSignet2OBJ.NpcId == npc_info.index then
        ViewMgr.open("EquipSignet2OBJ")
        -- SendMsgClickNpc(EquipSignet2OBJ.NpcId.."#EquipSignet2")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "EquipSignet2OBJ", onClickNpc)

return EquipSignet2OBJ