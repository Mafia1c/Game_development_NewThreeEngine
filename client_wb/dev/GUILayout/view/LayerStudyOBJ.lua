local LayerStudyOBJ = {}
LayerStudyOBJ.Name = "LayerStudyOBJ"
LayerStudyOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
LayerStudyOBJ.NpcId = 87
LayerStudyOBJ.cfg = GetConfig("LayerStudyCfg")

function LayerStudyOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/LayerStudyUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.layer = GameData.GetData("U_LayerStudy",false)or 0 --#region 当前layer在表中index
    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshMidNode()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("LayerStudyOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("LayerStudyOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.NpcId, "LayerStudy", "upEvent", "")
    end)
end

function LayerStudyOBJ:refreshMidNode()
    GUI:Image_loadTexture(self.ui.layerImg,"res/custom/npc/30xiuwei/jingjie_"..self.layer..".png")
    if self.layer==#self.cfg then
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text"..i.."12"],self.cfg[self.layer]["text1"])
            GUI:Text_setString(self.ui["text"..i.."22"], self.cfg[self.layer]["text2"])
            GUI:Text_setString(self.ui["text"..i.."32"], self.cfg[self.layer]["text3"].."%")
            GUI:Text_setString(self.ui["text"..i.."42"], self.cfg[self.layer]["text4"].."%")
        end
    else
        for i = 1, 2 do
            GUI:Text_setString(self.ui["text"..i.."12"],self.cfg[self.layer+i-1]["text1"])
            GUI:Text_setString(self.ui["text"..i.."22"], self.cfg[self.layer+i-1]["text2"])
            GUI:Text_setString(self.ui["text"..i.."32"], self.cfg[self.layer+i-1]["text3"].."%")
            GUI:Text_setString(self.ui["text"..i.."42"], self.cfg[self.layer+i-1]["text4"].."%")
        end
    end
    local width={64,64,80,80}
    for i = 1, 4 do
        GUI:setContentSize(self.ui["text1"..i.."1"],width[i]+GUI:getContentSize(self.ui["text1"..i.."2"]).width
        ,GUI:getContentSize(self.ui["text1"..i.."1"]).height)
        GUI:setContentSize(self.ui["text2"..i.."1"],width[i]+GUI:getContentSize(self.ui["text2"..i.."2"]).width
        ,GUI:getContentSize(self.ui["text2"..i.."1"]).height)
    end
    for i = 1, 2 do
        GUI:UserUILayout(self.ui["infoNode"..i], {dir=1,addDir=2,interval=0.5,gap = {y=6},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -2,-2)) < tonumber(string.sub(GUI:getName(b), -2,-2))
            end)
        end})
    end
    self:refreshNeedItem()
end

function LayerStudyOBJ:refreshNeedItem()
    GUI:removeAllChildren(self.ui.needItemNode)
    self.ui = GUI:ui_delegate(self._parent)
    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg[self.layer+1] or (self.cfg[self.layer+1] and self.cfg[self.layer+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        local itemColor = 249
        for j = 1, self.cfg[self.layer+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg[self.layer+1][keyName]
            itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",itemName)
            itemCount = self.cfg[self.layer+1][keyItemCount]
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
    if self.layer>=#self.cfg then
        GUI:removeAllChildren(self.ui.needItemNode)
        self.ui = GUI:ui_delegate(self._parent)
        GUI:setVisible(self.ui.upBtn,false)
        GUI:setVisible(self.ui.maxImg,true)
    end
end

--#region 后端消息刷新ui
function LayerStudyOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["提升"] = function ()
            self:refreshMidNode()
        end,
    }
    self.layer = GameData.GetData("U_LayerStudy",false)or 0 --#region 当前layer在表中index
    functionTab[tab[1]]()
     SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "LayerStudyOBJ",["node"] = self,["is_all"] = true})
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if LayerStudyOBJ.NpcId == npc_info.index then
        ViewMgr.open("LayerStudyOBJ")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "LayerStudyOBJ", onClickNpc)

return LayerStudyOBJ