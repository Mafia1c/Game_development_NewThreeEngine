local WelfareTodayOBJ = {}
WelfareTodayOBJ.Name = "WelfareTodayOBJ"
WelfareTodayOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
WelfareTodayOBJ.NpcId = 0
WelfareTodayOBJ.cfg1 = {{"5倍高爆地图卷",1},{"罗盘",1},{"神器魔盒",1},{"五行精华",58}}
WelfareTodayOBJ.cfg2 = {{"元宝",20000},{"万能恶魔图鉴",10},{"生肖精华",38},{"书页",99}}
WelfareTodayOBJ.cfg3 = {{"元宝",50000},{"玛法宝典",3},{"神器魔盒",3},{"龙鳞",168},{"黑铁",168}}
WelfareTodayOBJ.cfg4 = {{"5倍高爆地图卷",3},{"绑定元宝",30000},{"1亿经验珠",1},{"五行精华",18},{"生肖精华",18}}

function WelfareTodayOBJ:main(buyToday,showTime,getToday)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/WelfareTodayUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:Timeline_Window4(self.ui.FrameLayout)
    self.buyToday=tonumber(buyToday) --#region 今日礼包是否购买
    self.showTime=tonumber(showTime) --#region 专享礼包剩余时间
    self.getToday=tonumber(getToday) --#region 今日专享是否领取
    self:refreshInfo()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("WelfareTodayOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("WelfareTodayOBJ")
    end)
    for i = 1, 2 do
        GUI:addOnClickEvent(self.ui["buyBtn"..i], function()
            SendMsgClickMainBtn("0#WelfareToday#buyEvent"..i)
        end)
    end
    GUI:addOnClickEvent(self.ui["getBtn3"], function()
        SendMsgClickMainBtn("0#WelfareToday#getReward")
    end)
end

function WelfareTodayOBJ:refreshInfo()
    for i = 1, 4 do
        GUI:removeAllChildren(self.ui["itemNode"..i])
        self.ui = GUI:ui_delegate(self._parent)
        for index, value in ipairs(self["cfg"..i]) do
            GUI:ItemShow_Create(self.ui["itemNode"..i],"item"..i..index,0,0
            ,{index=SL:Get_ITEM_INDEX_BY_NAME(value[1]),bgVisible=true,look=true,count=value[2],color=250})
        end
        GUI:UserUILayout(self.ui["itemNode"..i], {dir=2,addDir=2,interval=0.5,gap = {x=8},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) > tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
    removeOBJ(self.ui.hasTime,self)
    GUI:Text_Create(self.ui.showTime,"hasTime",144,0,16,"#00ff00","")
    GUI:Text_COUNTDOWN(self.ui.hasTime, self.showTime, function () end, 1)
    GUI:setVisible(self.ui.buyBtn1,self.buyToday==0)
    GUI:setVisible(self.ui.hasImg1,self.buyToday>0)
    GUI:setVisible(self.ui.getBtn3,self.getToday==0)
    GUI:setVisible(self.ui.hasImg2,self.getToday>0)
end

--#region 后端消息刷新ui
function WelfareTodayOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["recharge"] = function ()
            self.buyToday=tonumber(tab[2]) --#region 今日礼包是否购买
            self.showTime=tonumber(tab[3]) --#region 专享礼包剩余时间
            self.getToday=tonumber(tab[4]) --#region 今日专享是否领取
            self:refreshInfo()
        end,
    }
    functionTab[tab[1]]()
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "WelfareTodayOBJ",["node"] = self,["is_all"] = true})
end

function WelfareTodayOBJ:GetBtnRed()
    if (GameData.GetData("J_WelfareToday_getToday") or 0) > 0 then
        return false
    end
    local hasTime = GameData.GetData("U_WelfareToday_hasTime") or 0
    local firsetTime= GameData.GetData("U_gift_zxlb_firstTime") or 0 
    if hasTime <= 0 or SL:Get_SERVER_TIME() - hasTime  > firsetTime then
        return false
    end
    return true
end

return WelfareTodayOBJ