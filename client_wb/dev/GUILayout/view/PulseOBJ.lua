local PulseOBJ = {}
PulseOBJ.Name = "PulseOBJ"
PulseOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
PulseOBJ.NpcId = 71
PulseOBJ.cfg = GetConfig("PulseCfg")
local positionTab = {
    [1]={{176,346},{178,284},{150,312},{140,266},{102,258},{214,308},{242,270},{176,232},{124,146},{244,146}},
    [2]={{176,316},{152,268},{108,274},{80,214},{190,218},{236,164},{134,190},{52,164},{188,142},{284,108}},
    [3]={{244,314},{248,268},{298,358},{208,262},{286,208},{226,170},{166,124},{86,92},{306,162},{316,92}},
    [4]={{94,332},{88,284},{100,246},{130,286},{164,320},{232,338},{172,272},{168,186},{164,102},{260,330}},
    [5]={{228,362},{248,308},{288,358},{210,290},{170,316},{172,262},{96,318},{72,256},{136,186},{118,96}},
    [6]={{198,366},{178,318},{138,352},{244,320},{294,346},{158,250},{90,244},{100,162},{164,162},{166,86}},
    [7]={{196,350},{192,308},{140,290},{68,282},{238,262},{188,210},{90,158},{64,90},{304,150},{316,78}},
    [8]={{188,360},{170,312},{124,346},{214,314},{254,260},{154,236},{200,284},{200,216},{144,150},{152,66}},
    [9]={{114,328},{124,276},{90,286},{68,238},{184,262},{262,278},{124,206},{56,162},{182,142},{276,102}},
    [10]={{248,364},{186,344},{108,276},{248,292},{274,266},{260,202},{192,304},{174,222},{188,146},{206,84}},
    [11]={{232,338},{202,304},{178,346},{248,306},{290,376},{160,264},{100,290},{110,204},{160,174},{170,94}},
}


function PulseOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/PulseUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.layer = GameData.GetData("U_pulseLayer",false)or 0 --#region 当前层次在表中index
    self.lineIndex = self.cfg[self.layer]["layer"] --#region 当前经脉index
    GUI:Timeline_Window4(self.ui.FrameLayout)
    GUI:runAction(self.ui.leftBg,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.4,36,320)))
    self:refreshLeftBox()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("PulseOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("PulseOBJ")
    end)
    GUI:addOnClickEvent(self.ui.tipsBtn,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn)
        GUI:ShowWorldTips(self.cfg[self.layer]["RText"], worldPos, GUI:p(1, 1))
    end)
    GUI:addOnClickEvent(self.ui.upBtn, function()
        SendMsgCallFunByNpc(self.NpcId, "Pulse", "upEvent", "")
    end)
end

function PulseOBJ:refreshLeftBox()
    GUI:Image_loadTexture(self.ui.lineImg,"res/custom/npc/09qjbm/z"..self.lineIndex..".png")
    GUI:Image_loadTexture(self.ui.acupointImg, "res/custom/npc/09qjbm/icon/"..self.layer..".png")
    GUI:Image_loadTexture(self.ui.personImg,"res/custom/npc/09qjbm/r"..self.lineIndex..".png")
    GUI:Text_setString(self.ui.acupointText,self.cfg[self.layer]["acupoint"])
    GUI:Timeline_FadeIn(self.ui.personImg, 0.5,nil)
    GUI:Timeline_FadeIn(self.ui.acupointText, 0.5,nil)
    local ball = (self.layer+1)%11
    if ball==0 then
        ball=10
    elseif self.layer==#self.cfg then
        ball=10
    else
        ball=ball-1
    end
    if ball==0 then
        GUI:removeAllChildren(self.ui.personImg)
        self.ui = GUI:ui_delegate(self._parent)
    end
    for i = 1, ball do
        if not self.ui["ballEffect"..i] then
            local effect = GUI:Effect_Create(self.ui.personImg, "ballEffect"..i, positionTab[self.lineIndex][i][1], positionTab[self.lineIndex][i][2]
            , 0, 14869, 0,0, 0, 1)
            GUI:setScale(effect,0.7)
        end
    end
    self:refreshRightNode()
    self:refreshNeedItem()
end

function PulseOBJ:refreshRightNode()
    if self.layer==#self.cfg then
        for i = 1, 3 do
            GUI:Text_setString(self.ui["text1"..i.."2"],self.cfg[self.layer]["text"..i])
            GUI:Text_setString(self.ui["text2"..i.."2"],self.cfg[self.layer]["text"..i])
        end
    else
        for i = 1, 3 do
            GUI:Text_setString(self.ui["text1"..i.."2"],self.cfg[self.layer]["text"..i])
            GUI:Text_setString(self.ui["text2"..i.."2"],self.cfg[self.layer+1]["text"..i])
        end
    end
    for i = 1, 2 do
        GUI:Text_setString(self.ui["text"..i.."22"],GUI:Text_getString(self.ui["text"..i.."22"]).."%")
        GUI:UserUILayout(self.ui["textNode"..i], {dir=1,addDir=2,interval=0.5,gap = {y=6},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
end

function PulseOBJ:refreshNeedItem()
    GUI:removeAllChildren(self.ui.needItemNode)
    self.ui = GUI:ui_delegate(self._parent)
    for i, v in ipairs(self.cfg[self.layer]["need_config"] or {}) do
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
function PulseOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["不足"] = function()
            Animation.bounceEffect(self.ui["need_item"..tab[2]], 5,20)
        end,
        ["提升"] = function()
            self.layer = GameData.GetData("U_pulseLayer",false)or 0 --#region 当前层次在表中index
            self.lineIndex = self.cfg[self.layer]["layer"] --#region 当前经脉index
            self:refreshLeftBox()
        end,
    }
    functionTab[tab[1]]()
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "FirstRechargeGiftOBJ",["node"] = self,["is_all"] = true})
end
function PulseOBJ:GetActiveBtnShow()
    local is_red = true
    local layer = GameData.GetData("U_pulseLayer",false)or 0
    if layer >= #PulseOBJ.cfg then return false end
    for i, v in ipairs(PulseOBJ.cfg[layer]["need_config"] or {}) do
        local itemIndex = SL:GetMetaValue("ITEM_INDEX_BY_NAME",v[1])
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if tonumber(SL:GetMetaValue("ITEM_COUNT", itemIndex)) < itemCount then
                is_red = false
            end
        elseif type == 1 then
            if tonumber(SL:GetMetaValue("MONEY", itemIndex)) < itemCount then
                is_red = false
            end
        elseif type == 2 then
            if tonumber(SL:GetMetaValue("MONEY_ASSOCIATED", itemIndex)) < itemCount then
                is_red = false
            end
        end
    end
    return is_red
end
-- 点击npc触发
local function onClickNpc(npc_info)
    if PulseOBJ.NpcId == npc_info.index then
        SendMsgClickNpc(npc_info.index.."#Pulse")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "PulseOBJ", onClickNpc)

return PulseOBJ