UseMagicTrigger = {}

--#region 玩家自身使用任意技能前触发(玩家对象，技能id，技能名字，受击对象，受击对象x坐标，受击对象y坐标，返回值(true/false，允许/组织施法))
function UseMagicTrigger.beginmagic(actor,magicId,magicName,target,x,y)
    local x,y = getbaseinfo(actor,4),getbaseinfo(actor,5)
    local mapID = getbaseinfo(actor,3)
    if magicId == 30 then  --召唤神兽
        local data=getobjectinmap(mapID,x,y,4,2)
        for key, mon in pairs(data or {}) do
            local _name=getbaseinfo(getbaseinfo(mon,59),1)
            if not getbaseinfo(mon,-1) and (string.find(getbaseinfo(mon,1),"白虎") or string.find(getbaseinfo(mon,1),"神兽"))
            and _name==getbaseinfo(actor,1) then
                killmonbyobj(actor,mon,false,false,false)
            end
        end
        local level = getskillinfo(actor, 30, 2) or 0
        local mon_name = "白虎"
        local mon_name2 = "神兽"
        if level >= 9 then
            mon_name = "疯狂白虎"
            mon_name2 = "暴走神兽"
        elseif level >= 6 then
            mon_name = "超级白虎"
            mon_name2 = "超级神兽"
        elseif level >= 3 then
            mon_name = "强化白虎"
            mon_name2 = "强化神兽"
        end
        local ncount=getbaseinfo(actor,38)
        local mon
        for i = 0 ,ncount-1 do
            mon = getslavebyindex(actor, i)
            local name = getbaseinfo(mon,1)
            if string.find(name,"白虎") and mon_name ~= "" then
                killmonbyobj(actor,mon,false,false,false)
            end 
            if string.find(name,"神兽") and mon_name2 ~= "" then
                killmonbyobj(actor,mon,false,false,false)
            end
        end
        local count = 1
        if hasbuff(actor,60082)  then
            count = count+1
        end
        if VarApi.getPlayerUIntVar(actor,"U_babyNumTag")>0 then
            count=count+1
        end
        local inherit_per = 0
        -- if hasbuff(actor,80036) then
        --     inherit_per = 15
        -- end
        recallmobex(actor,mon_name,x,y,7,count,3600,count > 1 and 253 or 255,0,0,0,inherit_per)
        recallmobex(actor,mon_name2,x,y,7,count,3600,count > 1 and 253 or 255,0,0,0,inherit_per)
    
    elseif magicId == 55 then  --召唤月灵
        local data=getobjectinmap(mapID,x,y,4,2)
        for key, mon in pairs(data or {}) do
            local _name=getbaseinfo(getbaseinfo(mon,59),1)
            if not getbaseinfo(mon,-1) and string.find(getbaseinfo(mon,1),"月灵")
            and _name==getbaseinfo(actor,1) then
                killmonbyobj(actor,mon,false,false,false)
            end
        end
        local level = getskillinfo(actor, 30, 2) or 0
        local mon_name = "月灵"
        if level >= 9 then
            mon_name = "神圣月灵"
        elseif level >= 6 then
            mon_name = "超级月灵"
        elseif level >= 3 then
            mon_name = "强化月灵"
        end
        local ncount=getbaseinfo(actor,38)
        local mon
        for i = 0 ,ncount-1 do
            mon = getslavebyindex(actor, i)
            if mon and isnotnull(mon) then
                local name = getbaseinfo(mon,1)
                if string.find(name,"月灵") then
                    killmonbyobj(actor,mon,false,false,false)
                end 
            end
        end
        local count = 1
        if hasbuff(actor,60082)  then
            count = count+1
        end
        if VarApi.getPlayerUIntVar(actor,"U_babyNumTag")>0 then
            count=count+1
        end
        local inherit_per = 0
        -- if hasbuff(actor,80036) then
        --     inherit_per = 15
        -- end
        recallmobex(actor,mon_name,x,y,7,count,3600,count > 1 and 253 or 255,0,0,0,inherit_per)
    
    elseif magicId == 74 then --法师 元素调和
        if hasbuff(actor,60069) then
            playeffect(actor,13445,0,0,1,0,0)
            delaygoto(actor,1000,"awake_fenshen")
        end
    elseif magicId == 6 and isplayer(target)  then --施毒术
        local level = getskillinfo(actor, magicId, 2)
        if level and level >= 3 and math.random(100) <= 1 then
            if not hasbuff(target,70034) then
                addbuff(target,70034,3) 
            end
            lualib:SendDataClient(target, "open_buff_dark")
            sendattackeff(actor,521,0,"*")
        end

    end
    --无双 化功大法
    local timestamp = VarApi.getPlayerUIntVar(actor,"U_80023_buff_cd_timestamp") 
    if hasbuff(actor,80023) and  isInTable({26,66,56,11,33,58,13,52},magicId) and math.random(100) <= 1 and os.time()-timestamp > 30 then
        addmpper(actor,"+",5)
        sendattackeff(actor,323,0,"*") 
        VarApi.setPlayerUIntVar(actor,"U_80023_buff_cd_timestamp",os.time()) 
    end
    --     --连击
    -- if hasbuff(actor,60019) and isInTable({26,66,56,11,33,58,13,52},magicId) then
    --     local odds = getbaseinfo(actor,51,219)
    --     if math.random(100) <= odds then
    --         local levle = getskillinfo(actor,magicId,1) or 1
    --         releasemagic(actor,magicId,1,levle,1,0)
    --         sendattackeff(actor,219,0,"*")
    --     end
    -- end
    return true
end
function awake_fenshen(actor)
    if #clonelist(actor) < 2 then
        recallself(actor,30,1,100)
    end
end
