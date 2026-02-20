local GodShieldOBJ = {}
GodShieldOBJ.Name = "GodShieldOBJ"
GodShieldOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
GodShieldOBJ.NpcId = {90,122}
GodShieldOBJ.cfg = {
    [90]={["needEquip"]={"九霄雷音盾",1},["need_config"]={{"黑铁",1888,0},{"龙鳞",1888,0},{"仙石",888,0},{"元宝",180000,2}},["nextEquip"]="太初鸿蒙盾"},
    [122]={["needEquip"]={"太初鸿蒙盾",1},["need_config"]={{"黑铁",3888,0},{"龙鳞",3888,0},{"仙石",1888,0},{"元宝",880000,2}},["nextEquip"]="创世源初盾"},
}


function GodShieldOBJ:main(nowNpcId)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GodShieldUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.nowNpcId=tonumber(nowNpcId)
    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshMidNode()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("GodShieldOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("GodShieldOBJ")
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(0, "GodShield", "upEvent", self.nowNpcId)
    end)
end

function GodShieldOBJ:refreshMidNode()
    if self.nowNpcId==90 then
        GUI:Image_loadTexture(self.ui.equipImg,"res/custom/npc/32sd/icon0.png")
    elseif self.nowNpcId==122 then
        GUI:Image_loadTexture(self.ui.equipImg,"res/custom/npc/32sd/icon1.png")
    end
    local nowEquipName = self.cfg[self.nowNpcId]["needEquip"][1]
    local nextEquipName = self.cfg[self.nowNpcId]["nextEquip"]
    ItemShow_updateItem(self.ui.equip1,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",nowEquipName),look=true})
    ItemShow_updateItem(self.ui.equip2,{index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",nextEquipName),look=true})
    GUI:Text_setString(self.ui.equipName1,nowEquipName)
    GUI:Text_setString(self.ui.equipName2,nextEquipName)
    GUI:setVisible(self.ui.RichText1,self.nowNpcId==90)
    GUI:setVisible(self.ui.RichText2,self.nowNpcId==122)

    GUI:removeAllChildren(self.ui.needItemNode)
    self.ui = GUI:ui_delegate(self._parent)
    for i, v in ipairs(self.cfg[self.nowNpcId]["need_config"]) do
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
function GodShieldOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["打造"] = function()
            self:refreshMidNode()
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui.midNode,"theEndEffect",400,300,0,14801,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
        end,
    }
    functionTab[tab[1]]()
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "GodShieldOBJ",["node"] = self,["is_all"] = true})
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(GodShieldOBJ.NpcId,npc_info.index) then
        -- ViewMgr.open("GodShieldOBJ",npc_info.index)
        SendMsgClickNpc(npc_info.index.."#GodShield#"..npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "GodShieldOBJ", onClickNpc)

return GodShieldOBJ