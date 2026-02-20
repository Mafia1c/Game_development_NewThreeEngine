local SwordArrayOBJ = {}
SwordArrayOBJ.Name = "SwordArrayOBJ"
SwordArrayOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
SwordArrayOBJ.NpcId = 209
SwordArrayOBJ.cfg = {{"仙石",10},{"幻灵石",1},{"诛仙碎片",1}}


function SwordArrayOBJ:main(layer)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/SwordArrayUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    if layer=="" then layer=0 end
    self.layer = tonumber(layer) or 0
    self:refreshMidNode()
    ItemShow_updateItem(self.ui.item_1,{index=10790,look=true,bgVisible=true,count=1,color=253})

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("SwordArrayOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("SwordArrayOBJ")
    end)
    for i = 1, 3 do
        GUI:addOnClickEvent(self.ui["goBtn"..i],function ()
            SendMsgCallFunByNpc(self.NpcId, "SwordArray", "goEvent"..i,"")
        end)
    end
    -- for i = 1, 2 do
    --     GUI:addOnClickEvent(self.ui["buyText"..i],function ()
    --         SendMsgCallFunByNpc(self.NpcId, "SwordArray", "exchange",i)
    --     end)
    -- end
    GUI:addOnClickEvent(self.ui.buyBtn,function ()
        GUI:setVisible(self.ui.mask,true)
    end)
end

function SwordArrayOBJ:refreshMidNode()
    GUI:Text_setString(self.ui.layerText,self.layer)
    for i = 1, 3 do
        GUI:Text_setString(self.ui["text"..i.."2"],self.cfg[i][1].."*"..self.cfg[i][2])
        if tonumber(SL:GetMetaValue("ITEM_COUNT", SL:GetMetaValue("ITEM_INDEX_BY_NAME",self.cfg[i][1]))) >= self.cfg[i][2] then
            GUI:Text_setTextColor(self.ui["text"..i.."2"],"#00FF00")
        else
            GUI:Text_setTextColor(self.ui["text"..i.."2"],"#ff0000")
        end
    end

    GUI:addOnClickEvent(self.ui.mask,function () GUI:setVisible(self.ui.mask, false) end)
    GUI:addOnClickEvent(self.ui.maskCloseBtn,function () GUI:setVisible(self.ui.mask, false) end)
    for i = 1, 2 do
        GUI:addOnClickEvent(self.ui["maskBuyBtn"..i], function ()
            SendMsgCallFunByNpc(self.NpcId,"SwordArray","buyEvent",i)
        end)
    end
end

--#region 后端消息刷新ui
function SwordArrayOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["refresh"] = function ()
            self.layer=tonumber(tab[2])
            self:refreshMidNode()
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if SwordArrayOBJ.NpcId==npc_info.index then
        -- ViewMgr.open("SwordArrayOBJ")
        SendMsgClickNpc(SwordArrayOBJ.NpcId.."#SwordArray")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "SwordArrayOBJ", onClickNpc)

return SwordArrayOBJ