local Disguise = {}
Disguise.cfg = include("QuestDiary/config/DisguiseCfg.lua")

function Disguise:showEvent(actor,leftIndex,rightIndex) --#region 显示
    leftIndex = tonumber(leftIndex)
    rightIndex = tonumber(rightIndex)
    if not self.cfg[leftIndex] then
        return Sendmsg9(actor, "ff0000", "序列异常！", 1)
    end
    local varStr = self.cfg[leftIndex].varStr
    local str = VarApi.getPlayerTStrVar(actor,varStr)
    if str=="" then
        return Sendmsg9(actor, "ff0000", "数据异常1！", 1)
    end
    str=string.sub(str,1,-2)
    local hasTab=strsplit(str,"|")
    local endTab ={}
    for index, value in ipairs(hasTab) do
        if self.cfg[value] then
            table.insert(endTab,value)
        end
    end
    hasTab=endTab
    local itemName = hasTab[rightIndex]
    if not itemName then
        return Sendmsg9(actor, "ff0000", "数据异常2！", 1)
    elseif itemName==VarApi.getPlayerTStrVar(actor,"T_disguiseName"..leftIndex) then
        return Sendmsg9(actor, "ff0000", "当前"..itemName.."装扮已是外显状态！", 1)
    end
    if leftIndex==1 or leftIndex==2 then
        local lastName1 = VarApi.getPlayerTStrVar(actor,"T_disguiseName1") --#region 上次外显1
        local lastName2 = VarApi.getPlayerTStrVar(actor,"T_disguiseName2") --#region 上次外显2
        if (self.cfg[lastName1] and self.cfg[lastName1].buffid) then
            delbuff(actor,self.cfg[lastName1].buffid)
        elseif (self.cfg[lastName2] and self.cfg[lastName2].buffid) then
            delbuff(actor,self.cfg[lastName2].buffid)
        end
        if leftIndex==1 then
            VarApi.setPlayerTStrVar(actor,"T_disguiseName2","",true)
        else
            VarApi.setPlayerTStrVar(actor,"T_disguiseName1","",true)
        end
        addbuff(actor,self.cfg[itemName]["buffid"])
    elseif leftIndex==3 then
        setmoveeff(actor, self.cfg[itemName].effectId, 1)
    elseif leftIndex==4 then
        seticon(actor,2,1,self.cfg[itemName].effectId,-20,66,1,0,1)
    elseif leftIndex==5 then
    elseif leftIndex==6 then
        releasesprite(actor)
        createsprite(actor, itemName)
    elseif leftIndex==7 then
        local ncount=getbaseinfo(actor,38)
        for i = 0 ,ncount-1 do
            local mon = getslavebyindex(actor, i)
            for _, value in ipairs(self.cfg[leftIndex]["item_arr"]) do
                if getbaseinfo(mon,1,1)==value then
                    killmonbyobj(actor,mon,false,false,false)
                end
            end
        end
        recallmob(actor,itemName,7,7200,0,0,0)
    end
    VarApi.setPlayerTStrVar(actor,"T_disguiseName"..leftIndex,itemName,true)

    Sendmsg9(actor,"00ff00","成功外显"..itemName.."！",1)
    lualib:FlushNpcUi(actor,"DisguiseOBJ","info")
end

function Disguise:hideEvent(actor,leftIndex,rightIndex) --#region 隐藏
    leftIndex = tonumber(leftIndex)
    rightIndex = tonumber(rightIndex)
    if not self.cfg[leftIndex] then
        return Sendmsg9(actor, "ff0000", "序列异常！", 1)
    end
    local varStr = self.cfg[leftIndex].varStr
    local str = VarApi.getPlayerTStrVar(actor,varStr)
    if str=="" then
        return Sendmsg9(actor, "ff0000", "数据异常1！", 1)
    end
    str=string.sub(str,1,-2)
    local hasTab=strsplit(str,"|")
    local endTab ={}
    for index, value in ipairs(hasTab) do
        if self.cfg[value] then
            table.insert(endTab,value)
        end
    end
    hasTab=endTab
    local itemName = hasTab[rightIndex]
    if not itemName then
        return Sendmsg9(actor, "ff0000", "数据异常2！", 1)
    end
    if leftIndex==1 or leftIndex==2 then
        local lastName = VarApi.getPlayerTStrVar(actor,"T_disguiseName"..leftIndex) --#region 上次外显
        if (self.cfg[lastName] and self.cfg[lastName].buffid) then
            delbuff(actor,self.cfg[lastName].buffid)
        end
    elseif leftIndex==3 then
        setmoveeff(actor, 0, 1)
    elseif leftIndex==4 then
        seticon(actor,2,-1)
    elseif leftIndex==5 then
    elseif leftIndex==6 then
        releasesprite(actor)
    elseif leftIndex==7 then
        local ncount=getbaseinfo(actor,38)
        for i = 0 ,ncount-1 do
            local mon = getslavebyindex(actor, i)
            for _, value in ipairs(self.cfg[leftIndex]["item_arr"]) do
                if getbaseinfo(mon,1,1)==value then
                    killmonbyobj(actor,mon,false,false,false)
                end
            end
        end
    end
    VarApi.setPlayerTStrVar(actor,"T_disguiseName"..leftIndex,"",true)

    Sendmsg9(actor,"00ff00","成功取消外显"..itemName.."！",1)
    lualib:FlushNpcUi(actor,"DisguiseOBJ","hide")
end

function Disguise:logEvent(actor) --#region 登陆重新赋予
    for i = 1, 7 do
        local itemName = VarApi.getPlayerTStrVar(actor,"T_disguiseName"..i)
        if itemName~="" and self.cfg[itemName] then
            if i==3 then
                setmoveeff(actor, self.cfg[itemName].effectId, 1)
            elseif i==4 then
                seticon(actor,2,1,self.cfg[itemName].effectId,-20,66,1,0,1)
            elseif i==6 then
                releasesprite(actor)
                createsprite(actor, itemName)
            elseif i==7 then
                local ncount=getbaseinfo(actor,38)
                for j = 0 ,ncount-1 do
                    local mon = getslavebyindex(actor, j)
                    for _, value in ipairs(self.cfg[7]["item_arr"]) do
                        if getbaseinfo(mon,1,1)==value then
                            killmonbyobj(actor,mon,false,false,false)
                        end
                    end
                end
                recallmob(actor,itemName,7,7200,0,0,0)
            end
        end
    end
end

return Disguise