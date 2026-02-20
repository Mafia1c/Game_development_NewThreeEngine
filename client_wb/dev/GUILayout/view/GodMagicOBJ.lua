local GodMagicOBJ = {}
GodMagicOBJ.Name = "GodMagicOBJ"
GodMagicOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
GodMagicOBJ.NpcId = 124
GodMagicOBJ.cfg = GetConfig("GodMagicCfg")
local equipTab1={"圣辉·初曦","神谕·净世","天罚·裁罪","穹苍·织星"}
local equipTab2={"魔骸·蚀骨","渊狱·泣血","寂灭·吞灵","永夜·无妄"}
local tipsTab = {
    "<神之真元/FCOLOR=254> → <Lv10/FCOLOR=250> 激活 <圣辉·初曦/FCOLOR=254>\\<神之真元/FCOLOR=254> → <Lv20/FCOLOR=250> 激活 <神谕·净世/FCOLOR=254>"
    .."\\<神之真元/FCOLOR=254> → <Lv30/FCOLOR=250> 激活 <天罚·裁罪/FCOLOR=254>\\<神之真元/FCOLOR=254> → <Lv40/FCOLOR=250> 激活 <穹苍·织星/FCOLOR=254>",
    "<魔之真元/FCOLOR=251> → <Lv10/FCOLOR=250> 激活 <魔骸·蚀骨/FCOLOR=251>\\<魔之真元/FCOLOR=251> → <Lv20/FCOLOR=250> 激活 <渊狱·泣血/FCOLOR=251>"
    .."\\<魔之真元/FCOLOR=251> → <Lv30/FCOLOR=250> 激活 <寂灭·吞灵/FCOLOR=251>\\<魔之真元/FCOLOR=251> → <Lv40/FCOLOR=250> 激活 <永夜·无妄/FCOLOR=251>"
}

function GodMagicOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GodMagicUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self:refreshMidNode()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("GodMagicOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("GodMagicOBJ")
    end)
    for i = 1, 2 do
        GUI:addOnClickEvent(self.ui["upBtn"..i], function()
            self.nowIndex=i
            SendMsgCallFunByNpc(self.NpcId, "GodMagic", "upEvent",i)
        end)
        GUI:addOnClickEvent(self.ui["tipsBtn"..i],function ()
            local worldPos = GUI:getTouchEndPosition(self.ui["tipsBtn"..i])
            GUI:ShowWorldTips(tipsTab[i], worldPos, GUI:p(1, 1))
        end)
    end
end

function GodMagicOBJ:refreshMidNode()
    local layerTab={10,20,30,40}
    self.layer1 = GameData.GetData("U_GodMagic1",false)or 0 --#region 神境界
    self.layer2 = GameData.GetData("U_GodMagic2",false)or 0 --#region 魔境界
    GUI:Text_setString(self.ui.layerText1,"神之真元·Lv"..self.layer1)
    GUI:Text_setString(self.ui.layerText2,"魔之真元·Lv"..self.layer2)
    GUI:removeAllChildren(self.ui.equipNode1)
    GUI:removeAllChildren(self.ui.equipNode2)
    self.ui = GUI:ui_delegate(self._parent)
    for i, value in ipairs(equipTab1) do
        local item = GUI:ItemShow_Create(self.ui.equipNode1, "equip1"..i, 0, 0, {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",value),look=true,bgVisible=true})
        if self.layer1<layerTab[i] then GUI:ItemShow_setIconGrey(item, true) end
    end
    for i, value in ipairs(equipTab2) do
        local item = GUI:ItemShow_Create(self.ui.equipNode2, "equip2"..i, 0, 0, {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",value),look=true,bgVisible=true})
        if self.layer2<layerTab[i] then GUI:ItemShow_setIconGrey(item, true) end
    end
    for i = 1, 2 do
        GUI:UserUILayout(self.ui["equipNode"..i], {dir=2,addDir=2,interval=0.5,gap = {x=6},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end

    local textTab={"物伤减少：","魔伤减少："}
    for i = 1, 2 do
        GUI:Text_setString(self.ui["text"..i.."1"],"人物体力："..(self["layer"..i]*3).."%")
        GUI:Text_setString(self.ui["text"..i.."2"],textTab[i]..(self["layer"..i]*2).."%")
        removeOBJ(self.ui["RText"..i],self)
        removeOBJ(self.ui["effect"..i],self)
        local itemName=self.cfg[self["layer"..i]+1] and self.cfg[self["layer"..i]+1]["need"..i]
        local itemIndex=SL:GetMetaValue("ITEM_INDEX_BY_NAME",itemName)
        local number=self.cfg[self["layer"..i]+1] and self.cfg[self["layer"..i]+1]["number"..i]
        local color="#00ff00"
        if self["layer"..i]==0 then
            GUI:Effect_Create(self.ui["effectNode"..i],"effect"..i,160,398,0,self.cfg[self["layer"..i]+1]["effect"..i],0,0,0,1)
            if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) < number then color="#ff0000" end
            GUI:RichText_Create(self.ui["upNode"..i],"RText"..i,336,100,
            "<font color='#ffffff' size='18' ><a enableUnderline ='false' href = 'jump#item_tips#"..itemIndex.."'><u><font color ='"..color.."'>"..itemName.."*"..(number).."</font></u></a></font>",120,16,"#ffffff",1)
        elseif self["layer"..i]==#self.cfg then
            GUI:Effect_Create(self.ui["effectNode"..i],"effect"..i,160,398,0,self.cfg[self["layer"..i]]["effect"..i],0,0,0,1)
            GUI:setVisible(self.ui["upNode"..i],false)
            GUI:setVisible(self.ui["maxImg"..i],true)
        else
            GUI:Effect_Create(self.ui["effectNode"..i],"effect"..i,160,398,0,self.cfg[self["layer"..i]]["effect"..i],0,0,0,1)
            if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) < number then color="#ff0000" end
            GUI:RichText_Create(self.ui["upNode"..i],"RText"..i,336,100,
            "<font color='#ffffff' size='18' ><a enableUnderline ='false' href = 'jump#item_tips#"..itemIndex.."'><u><font color ='"..color.."'>"..itemName.."*"..(number).."</font></u></a></font>",120,16,"#ffffff",1)
        end
        if self.ui["RText"..i] then GUI:setAnchorPoint(self.ui["RText"..i], 0.5, 0.5) end
    end
end

--#region 后端消息刷新ui
function GodMagicOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["提升"] = function ()
            self:refreshMidNode()
            removeOBJ(self.ui.theEndEffect,self)
            GUI:Effect_Create(self.ui["midNode"..self.nowIndex],"theEndEffect",220,300,0,14811,0,0,0,1)
            GUI:Effect_setAutoRemoveOnFinish(self.ui.theEndEffect)
        end,
    }
    functionTab[tab[1]]()
     SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "GodMagicOBJ",["node"] = self,["is_all"] = true})
end
function GodMagicOBJ:UpBtnRed(index)
    index = tonumber(index)
    if index == nil then return false end
    local layer = GameData.GetData("U_GodMagic"..index,false)or 0 
    local cfg = GodMagicOBJ.cfg[layer + 1]
    if cfg == nil  then return false end
    local name = cfg["need"..index]
    if SL:Get_ITEM_COUNT(name) < cfg["number"..index] then
        return false 
    end
    return true
end
-- 点击npc触发
local function onClickNpc(npc_info)
    if GodMagicOBJ.NpcId==npc_info.index then
        -- ViewMgr.open("GodMagicOBJ")
        SendMsgClickNpc(GodMagicOBJ.NpcId.."#GodMagic")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "GodMagicOBJ", onClickNpc)

return GodMagicOBJ