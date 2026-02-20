local ChampionPrivilege = {}

function ChampionPrivilege:click(actor)
    local tag="0"
    if checktitle(actor,"冠名特权") then
        tag="1"
    end
    lualib:ShowNpcUi(actor, "ChampionPrivilegeOBJ", tag)
end

function ChampionPrivilege:activeEvent(actor)
    if checktitle(actor,"冠名特权") then
        return Sendmsg9(actor, "ff0000", "冠名特权已激活过！", 1)
    elseif getbagitemcount(actor,"冠名特权激活卡","0") < 1 then
        Sendmsg9(actor, "ff0000", "请先前往客服礼包cdk兑换获得冠名特权激活卡！", 1)
        local sMsg = IncludeMainClass("WelfareHall"):getPageUiData(actor,6)
        lualib:ShowNpcUi(actor, "WelfareHallOBJ", sMsg .. "#6")
        return
    end

    if not takeitem(actor,"冠名特权激活卡",1,0,"激活冠名扣") then
        return Sendmsg9(actor, "ff0000", "物品冠名特权激活卡扣除失败！", 1)
    end
    confertitle(actor, "冠名特权", 1)
    local speed=getbaseinfo(actor,51,154)
    changehumnewvalue(actor,154,speed-50,186624000)

    Sendmsg9(actor,"00ff00","恭喜您成功激活冠名特权！",1)
    -- sendmsgnew(actor,255,0,"境界飞升：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功修炼至"
    -- .."<『".."飞升·"..self.cfg[layer+1]["type"].."境界』/FCOLOR=251>,获得属性提升！",1,2)
    lualib:FlushNpcUi(actor,"ChampionPrivilegeOBJ","refresh#1")
end


return ChampionPrivilege