local EquipSignet = {}
EquipSignet.cfg=include("QuestDiary/config/EquipSignetCfg.lua") --#region 印记表
EquipSignet.cfg1={{78,"黑金古刃"},{79,"天蚕の甲"},{80,"痛苦の盔"},{81,"双鱼の佩"},{82,"转世の手"},{83,"轮回の爪"},{84,"神の戒"}
,{85,"魔の戒"},{86,"紫金の带"},{87,"幻影の靴"}} --#region 专属附魔
EquipSignet.cfg2={["need_config"]={{"仙石",20,0},{"元宝",50000,2}},} --#region 专属附魔
EquipSignet.cfg3={["need_config"]={{"元宝",2000,2}},} --#region 极品术士
EquipSignet.cfg4 = include("QuestDiary/config/EquipSpecialCfg.lua") --#region 上古以上装备

function EquipSignet:click(actor) --#region 炼金术士打开
    if CheckOpenState(actor, 1) then return end
    lualib:ShowNpcUi(actor, "EquipSignet1OBJ", "")
end
--#region 设置属性(对象，唯一id，装备std，词条数量,类型[94,95]附魔，极品)
function EquipSignet:setEquipInfo(actor,makeindex,stdmode,num,_index)
    if makeindex=="0" or not makeindex or not isInTable({1,2,3,4,5},num) then
        return
    end

    local validRunes = {} --#region 候选列表
    local totalWeight = 0 --#region 权重
    for index, value in ipairs(self.cfg) do
        local isMatch = false
        for _, std in ipairs(value.std_arr) do
            if std==9999 then
                break
            elseif stdmode==std then
                isMatch=true
                break
            end
        end

        if isMatch then
            totalWeight=totalWeight+value.weight
            table.insert(validRunes,index)
        end
    end
    if #validRunes==0 or totalWeight<=0 then
        return
    end

    local signetTab = {} --#region 抽到的符文
    for i = 1, num do --#region 抽取符文
        local random=math.random(totalWeight)
        local accumulated = 0
        for index, value in ipairs(validRunes) do
            accumulated=accumulated+self.cfg[value].weight
            if random<=accumulated then
                table.insert(signetTab,value)
                table.remove(validRunes,index)
                totalWeight=totalWeight-self.cfg[value].weight
                break
            end
        end
    end

    local numberTab = {} --#region 符文数值
    local msg = "500:"..(44*num) --#region 符文显示
    local infoTab={} --#region 符文属性表
    local tempTab={} --#region 属性变量表
    for i, value in ipairs(signetTab) do
        local random = math.random(self.cfg[value].minnum,self.cfg[value].maxnum)
        if self.cfg[value].minnum>=100 then
            random = math.floor(random / 10) * 10  -- 保证第三位一定是0
        end
        table.insert(numberTab,random)

        local tempText=numberTab[i]
        if self.cfg[value].minnum>=100 then
            tempText=tempText/100
        end
        if self.cfg[value].percent>0 then
            tempText=tempText.."%"
        end
        msg=msg.."|IIMG:"..self.cfg[value].icon..":0:"..(44*num-44*i)..":1"
        .."|RTEXT:<"..self.cfg[value].type.."：/FCOLOR="..self.cfg[value].color..">"
        .."<"..self.cfg[value].signet.."/FCOLOR=250><+"..tempText.."/FCOLOR=251>"
        .."\\<"..self.cfg[value].text.."/FCOLOR=159>:44:"..(44*num-44*i)..":1"

        infoTab[self.cfg[value].attid]=numberTab[i]

        local number = numberTab[i]
        if self.cfg[value].minnum>=100 then
            number=number/100
        end
        if self.cfg[value].percent>0 then
            number=number.."%"
        end
        tempTab[#tempTab+1] = {value,numberTab[i]}
    end

    local effectnumbag = 12800 + num
    local effectnumbody = 12800 + num
    if stdmode == 10 or stdmode == 11 or stdmode == 5 or stdmode == 6 then
        effectnumbody = 0
    end
    setitemeffect(actor,-2,effectnumbag,effectnumbody,0,0,makeindex)
    delitemattr(actor,makeindex,_index,0)
    additemattrEX(actor,makeindex,_index,3,infoTab)
    SetStr(3, makeindex, VarEngine.ItemDescVar, msg)
    -- SetStr(3,makeindex,"EquipSignet_"..getposbystdmode(stdmode),tbl2json(tempTab))
    SetStr(3,makeindex,"EquipSignet_",tbl2json(tempTab))
    SendItemVarToc(actor, makeindex)
    refreshitem(actor, makeindex)
    if _index==94 then --#region 专属附魔
        sendmsgnew(actor,255,0,"专属附魔：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功为"
        .."<『"..getiteminfo(actor,makeindex,7).."』附魔/FCOLOR=251>,获得属性提升！",1,2)
        local str=GetStr(3,makeindex,"EquipSignet_")
        lualib:FlushNpcUi(actor, "EquipSignet2OBJ", "up#"..str)
    elseif _index==95 then --#region 极品术士
        sendmsgnew(actor,255,0,"极品术士：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功为"
        .."<『"..getiteminfo(actor,makeindex,7).."』附魔/FCOLOR=251>,获得属性提升！",1,2)
        local str=GetStr(3,makeindex,"EquipSignet_")
        lualib:FlushNpcUi(actor, "EquipSignet1OBJ", "up#"..str)
    end
end
function EquipSignet:infoEvent1(actor,position) --#region 炼金术士拿属性
    position=tonumber(position)
    local itemmakeid = GetItemByPos(actor,position)
    local str=GetStr(3,itemmakeid,"EquipSignet_")
    lualib:FlushNpcUi(actor,"EquipSignet1OBJ","info#"..str)
end
function EquipSignet:upEvent1(actor,...) --#regoin 炼金术士
    if CheckOpenState(actor, 1) then return end
    local tab={...}
    local position=tonumber(tab[1])
    local itemmakeid = GetItemByPos(actor,position)
    local equipName = getiteminfo(actor,itemmakeid,7)
    if not equipName or (not self.cfg4[equipName]) then
        return Sendmsg9(actor, "ff0000", "当前装备不为上古以上装备！", 1)
    end
    local makeIndexTab={} --#region 消耗装备唯一id
    for i = 1, 3 do
        if tab[i+1] and tab[i+1]~="" then
            table.insert(makeIndexTab,tab[i+1])
            if getiteminfo(actor,tab[i+1],7)~=equipName then
                return Sendmsg9(actor, "ff0000", "当前选取装备异常！", 1)
            end
        end
    end
    local positionTab={1,0,4,3,5,6,7,8,10,11}
    if not isInTable(positionTab,position) then
        return Sendmsg9(actor, "ff0000", "当前鉴定装备异常！", 1)
    elseif #makeIndexTab==0 then
        return Sendmsg9(actor, "ff0000", "最少选取一件需要消耗的相同副装！", 1)
    elseif itemmakeid=="0" then
        return Sendmsg9(actor, "ff0000", "当前并未选取穿戴装备！", 1)
    end

    local infoTab=json2tbl(GetStr(3,itemmakeid,"EquipSignet_"..position))
    if type(infoTab)=="table" and #infoTab>=5 then
        messagebox(actor,"您当前装备已有5条极品属性，是否仍继续重新附魔？",
        "@equip_signet11,"..position..","..tbl2json(makeIndexTab),"@equip_signet12")
    else
        equip_signet11(actor,position,tbl2json(makeIndexTab))
    end
end
function equip_signet11(actor,position,makeIndexTab) --#regoin 极品附魔
    EquipSignet:equipSignet11(actor,position,makeIndexTab)
end
function EquipSignet:equipSignet11(actor,position,makeIndexTab) --#regoin 极品附魔
    local oddTab={{1,3,10,30,100},{5,10,20,50,100},{10,20,30,75,100}}
    position=tonumber(position)
    local itemmakeid = GetItemByPos(actor,position)
    local equipName = getiteminfo(actor,itemmakeid,7)
    makeIndexTab=json2tbl(makeIndexTab)

    for i, v in ipairs(EquipSignet.cfg3["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if getbagitemcount(actor,itemName,"0") < itemCount then
                lualib:FlushNpcUi(actor, "EquipSignet1OBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 1 then
            if querymoney(actor,itemIndex) < itemCount then
                lualib:FlushNpcUi(actor, "EquipSignet1OBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 2 then
            if getbindmoney(actor,itemName) < itemCount then
                lualib:FlushNpcUi(actor, "EquipSignet1OBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        end
    end
    for i, v in ipairs(EquipSignet.cfg3["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if not takeitem(actor,itemName,itemCount,0,itemName.."炼金术士扣物品") then
                return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 1 then
            if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."炼金术扣非通用货币",true) then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 2 then
            if not consumebindmoney(actor,itemName,itemCount,itemName.."炼金术扣通用货币") then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        end
    end
    for index, value in ipairs(makeIndexTab) do
        if not delitembymakeindex(actor,value,0,"炼金术士扣装备"..equipName..index) then
            return Sendmsg9(actor, "ff0000", "装备".. equipName..index.."扣除失败！", 1)
        end
    end

    local num = math.random(100)
    local countTab={5,4,3,2,1}
    local count=0
    for index, value in ipairs(oddTab[#makeIndexTab]) do
        if num<=value then
            count=countTab[index]
            break
        end
    end
    EquipSignet:setEquipInfo(actor,itemmakeid,getstditeminfo(equipName,2),count,95)
end

function EquipSignet:upEvent2(actor,leftIndex) --#regoin 专属附魔
    if CheckOpenState(actor, 2) then return end
    leftIndex=tonumber(leftIndex)
    local position = self.cfg1[leftIndex][1]
    local itemmakeid = GetItemByPos(actor,position)
    local equipName = getiteminfo(actor,itemmakeid,7)
    if not self.cfg1[leftIndex] or equipName~=self.cfg1[leftIndex][2] then
        return
    end

    local infoTab=json2tbl(GetStr(3,itemmakeid,"EquipSignet_"..position))
    if type(infoTab)=="table" and #infoTab>=5 then
        messagebox(actor,"您当前装备已有5条附魔属性，是否仍继续重新附魔？","@equip_signet21,"..leftIndex,"@equip_signet22")
    else
        equip_signet21(actor,leftIndex)
    end
end
function equip_signet21(actor,leftIndex) --#regoin 专属附魔
    EquipSignet:equipSignet21(actor,leftIndex)
end
function EquipSignet:equipSignet21(actor,leftIndex) --#regoin 专属附魔
    leftIndex=tonumber(leftIndex)
    local position = EquipSignet.cfg1[leftIndex][1]
    local itemmakeid = GetItemByPos(actor,position)
    local equipName = getiteminfo(actor,itemmakeid,7)

    for i, v in ipairs(EquipSignet.cfg2["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if getbagitemcount(actor,itemName,"0") < itemCount then
                lualib:FlushNpcUi(actor, "EquipSignet2OBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 1 then
            if querymoney(actor,itemIndex) < itemCount then
                lualib:FlushNpcUi(actor, "EquipSignet2OBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 2 then
            if getbindmoney(actor,itemName) < itemCount then
                lualib:FlushNpcUi(actor, "EquipSignet2OBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        end
    end
    for i, v in ipairs(EquipSignet.cfg2["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if not takeitem(actor,itemName,itemCount,0,itemName.."专属附魔身上扣物品") then
                return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 1 then
            if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."专属附魔身上扣非通用货币",true) then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 2 then
            if not consumebindmoney(actor,itemName,itemCount,itemName.."专属附魔身上扣通用货币") then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        end
    end

    local num = math.random(100)
    if num<=1 then
        num=5
    elseif num<=3 then
        num=4
    elseif num<=10 then
        num=3
    elseif num<=30 then
        num=2
    elseif num<=100 then
        num=1
    end
    EquipSignet:setEquipInfo(actor,itemmakeid,getstditeminfo(equipName,2),num,94)
end

function EquipSignet:infoEvent2(actor,leftIndex) --#region 专属附魔拿属性
    leftIndex=tonumber(leftIndex)
    local position = self.cfg1[leftIndex][1]
    local itemmakeid = GetItemByPos(actor,position)
    local equipName = getiteminfo(actor,itemmakeid,7)
    if not self.cfg1[leftIndex] or equipName~=self.cfg1[leftIndex][2] then
        return
    end
    local str=GetStr(3,itemmakeid,"EquipSignet_")
    lualib:FlushNpcUi(actor,"EquipSignet2OBJ","info#"..str)
end

return EquipSignet