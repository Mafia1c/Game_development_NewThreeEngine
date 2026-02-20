local GodMagic_LookOBJ = {}
GodMagic_LookOBJ.Name = "GodMagic_LookOBJ"
GodMagic_LookOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
GodMagic_LookOBJ.cfg = GetConfig("GodMagicCfg")
local equipTab1={"圣辉·初曦","神谕·净世","天罚·裁罪","穹苍·织星"}
local equipTab2={"魔骸·蚀骨","渊狱·泣血","寂灭·吞灵","永夜·无妄"}
local tipsTab = {
    "<神之真元/FCOLOR=254> → <Lv10/FCOLOR=250> 激活 <圣辉·初曦/FCOLOR=254>\\<神之真元/FCOLOR=254> → <Lv20/FCOLOR=250> 激活 <神谕·净世/FCOLOR=254>"
    .."\\<神之真元/FCOLOR=254> → <Lv30/FCOLOR=250> 激活 <天罚·裁罪/FCOLOR=254>\\<神之真元/FCOLOR=254> → <Lv40/FCOLOR=250> 激活 <穹苍·织星/FCOLOR=254>",
    "<魔之真元/FCOLOR=251> → <Lv10/FCOLOR=250> 激活 <魔骸·蚀骨/FCOLOR=251>\\<魔之真元/FCOLOR=251> → <Lv20/FCOLOR=250> 激活 <渊狱·泣血/FCOLOR=251>"
    .."\\<魔之真元/FCOLOR=251> → <Lv30/FCOLOR=250> 激活 <寂灭·吞灵/FCOLOR=251>\\<魔之真元/FCOLOR=251> → <Lv40/FCOLOR=250> 激活 <永夜·无妄/FCOLOR=251>"
}

function GodMagic_LookOBJ:main(layer1,layer2)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GodMagicUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    SL:Print(layer1,layer2)
    self.layer1 = tonumber(layer1) --#region 神境界
    self.layer2 = tonumber(layer2) --#region 魔境界
    self:refreshMidNode()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("GodMagic_LookOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("GodMagic_LookOBJ")
    end)
    for i = 1, 2 do
        GUI:addOnClickEvent(self.ui["tipsBtn"..i],function ()
            local worldPos = GUI:getTouchEndPosition(self.ui["tipsBtn"..i])
            GUI:ShowWorldTips(tipsTab[i], worldPos, GUI:p(1, 1))
        end)
        GUI:setVisible(self.ui["upNode"..i],false)
        GUI:setVisible(self.ui["maxImg"..i],false)
    end
end

function GodMagic_LookOBJ:refreshMidNode()
    local layerTab={10,20,30,40}
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
        if self["layer"..i]==0 then
            GUI:Effect_Create(self.ui["effectNode"..i],"effect"..i,160,398,0,self.cfg[self["layer"..i]+1]["effect"..i],0,0,0,1)
        elseif self["layer"..i]==#self.cfg then
            GUI:Effect_Create(self.ui["effectNode"..i],"effect"..i,160,398,0,self.cfg[self["layer"..i]]["effect"..i],0,0,0,1)
            GUI:setVisible(self.ui["maxImg"..i],true)
        else
            GUI:Effect_Create(self.ui["effectNode"..i],"effect"..i,160,398,0,self.cfg[self["layer"..i]]["effect"..i],0,0,0,1)
        end
    end
end

--#region 后端消息刷新ui
function GodMagic_LookOBJ:flushView(...)
    local tab = {...}
    local functionTab = {

    }
    functionTab[tab[1]]()
end

return GodMagic_LookOBJ