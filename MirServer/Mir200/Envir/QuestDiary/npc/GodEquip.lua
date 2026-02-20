local GodEquip = {}
GodEquip.cfg1 = include("QuestDiary/config/GodEquipCfg1.lua") --#region 打野刀
GodEquip.cfg2 = include("QuestDiary/config/GodEquipCfg2.lua") --#region 神器
local needLv={5,10,15,20,25}
local attTab={{{3,4,5,6,7,8},{35}},{{3,4,5,6,7,8},{22}},{{3,4,5,6,7,8},{360}},{{9,10,11,12},{26,27}},{{9,10,11,12},{30}},{{3,4,5,6,7,8},{20,359}}}
local equipKey={"[穿透]","[爆伤]","[吸血]","[防御]","[生命]","[攻速]"}

function GodEquip:click(actor,_npc_id,leftIndex,lineIndex1,iconIndex1)
    leftIndex = tonumber(leftIndex)  or 1
    lineIndex1 = tonumber(lineIndex1)  or 1
    iconIndex1 = tonumber(iconIndex1)  or 1
    local exp=VarApi.getPlayerUIntVar(actor,"U_jungleExp_now") --#region 打野刀当前经验
    lualib:ShowNpcUi(actor, "GodEquipOBJ",exp.."#"..leftIndex.."#"..lineIndex1.."#"..iconIndex1)
    if TaskTrigger.CheckTask(actor,12) then
        lualib:CallFuncByClient(actor, "navigation", "GodEquipOBJ#upBtn1#点击升级#onUpGodEquip")
    end
    TaskTrigger.CompleteTask(actor, 12)
end
function GodEquip:changeExp(actor,nextLv,nowBar,maxBar) --#region 改经验条刀魂(对象,等级,当前进度,最大值)
    local makeindex=GetItemByPos(actor, 89) --#region 打野刀唯一id
    if makeindex=="0" then
        return
    end
    SetStr(3, makeindex, "刀魂名字", "Lv."..nextLv)
    SetInt(3, makeindex, "进度条变量", nowBar)
    SetInt(3, makeindex, "最大值", maxBar)
    SendItemVarToc(actor, makeindex)
    -- refreshitem(actor, makeindex)
end
function GodEquip:killMonExpEvent(actor,monObj,killerType) --#region 杀怪打野刀加经验
    if killerType~=2 then
        return
    end
    local color = getbaseinfo(monObj, 56)
    local color_tab = {[255]=1,[250]=100,[253]=200,[243]=500,[249]=1000,[70]=2000}
    if color_tab[color] then
        local nowLv=VarApi.getPlayerUIntVar(actor,"U_jungleLv")
        if nowLv>=#self.cfg1 then return end
        VarApi.setPlayerUIntVar(actor,"U_jungleExp_now",VarApi.getPlayerUIntVar(actor,"U_jungleExp_now")+(color_tab[color]),true)
        self:changeExp(actor,nowLv,VarApi.getPlayerUIntVar(actor,"U_jungleExp_now")+(color_tab[color]),self.cfg1[nowLv+1].exp)
    end
end
function GodEquip:expEvent(actor,number) --#region 扣书页得经验
    number=tonumber(number)
    local nowLv=VarApi.getPlayerUIntVar(actor,"U_jungleLv")
    if not isInTable({1,2},number) then
        return Sendmsg9(actor, "ff0000", "打野刀提交次数异常！", 1)
    elseif nowLv>=#self.cfg1 then
        return Sendmsg9(actor, "ff0000", "打野刀经验已满！", 1)
    end
    if number==2 then number=10 end
    if getbagitemcount(actor,"书页","0") < number then
        return Sendmsg9(actor, "ff0000", "当前背包物品书页数量少于" .. number .. "！", 1)
    end
    if not takeitem(actor,"书页",number,0,"打野刀经验升扣物品") then
        return Sendmsg9(actor, "ff0000", "物品书页扣除失败！", 1)
    end
    VarApi.setPlayerUIntVar(actor,"U_jungleExp_now",VarApi.getPlayerUIntVar(actor,"U_jungleExp_now")+(100*number),true)
    self:changeExp(actor,nowLv,VarApi.getPlayerUIntVar(actor,"U_jungleExp_now"),self.cfg1[nowLv+1].exp)
    Sendmsg9(actor, "00ff00", "当前打野刀获得经验"..(100*number).."！", 1)
    lualib:FlushNpcUi(actor,"GodEquipOBJ","exp#"..VarApi.getPlayerUIntVar(actor,"U_jungleExp_now"))
end
function GodEquip:upEvent1(actor) --#region 打野刀提升
    local jungleLv = VarApi.getPlayerUIntVar(actor,"U_jungleLv") --#region 当前刀等级
    local exp=VarApi.getPlayerUIntVar(actor,"U_jungleExp_now") --#region 打野刀当前经验
    local makeindex=GetItemByPos(actor, 89) --#region 唯一id
    if jungleLv>= #self.cfg1 then
        return Sendmsg9(actor, "ff0000", "当前打野刀已升至最高等级！", 1)
    elseif makeindex=="0" then
        return Sendmsg9(actor, "ff0000", "当前没有打野刀！", 1)
    end
    if exp<self.cfg1[jungleLv+1].exp then
        return Sendmsg9(actor, "ff0000", "当前打野刀升级所需经验不足！", 1)
    end

    local typeName = {{"itemName","itemCount"},{"moneyName","moneyCount"},{"moneyComName","moneyComCount"}} --#regoin key名称
    local number = 0 --#region 创建物品款index序列顺序
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg1[jungleLv+1] or (self.cfg1[jungleLv+1] and self.cfg1[jungleLv+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        for j = 1, self.cfg1[jungleLv+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg1[jungleLv+1][keyName]
            itemIndex = getstditeminfo(itemName,0)
            itemCount = self.cfg1[jungleLv+1][keyItemCount]
            if i==1 then
                number=number+1
                if getbagitemcount(actor,itemName,"0") < itemCount then
                    lualib:FlushNpcUi(actor, "GodEquipOBJ", "不足#1"..number)
                    return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==2 then
                number=number+1
                if querymoney(actor,itemIndex) < itemCount then
                    lualib:FlushNpcUi(actor, "GodEquipOBJ", "不足#1"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            elseif i==3 then
                number=number+1
                if getbindmoney(actor,itemName) < itemCount then
                    lualib:FlushNpcUi(actor, "GodEquipOBJ", "不足#1"..number)
                    return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
                end
            end
        end
        ::continue::
    end
    for i = 1, 3 do --#region 1道具数,2非通用货币数,3通用货币数
        if not self.cfg1[jungleLv+1] or (self.cfg1[jungleLv+1] and self.cfg1[jungleLv+1]["number_arr"][i]==0) then
            goto continue
        end
        local itemIndex = 0
        local itemCount = 0
        for j = 1, self.cfg1[jungleLv+1]["number_arr"][i] do --#region 物品种类数量
            local keyName = typeName[i][1]..j
            local keyItemCount = typeName[i][2]..j
            local itemName = self.cfg1[jungleLv+1][keyName]
            itemIndex = getstditeminfo(itemName,0)
            itemCount = self.cfg1[jungleLv+1][keyItemCount]
            if i==1 then
                if not takeitem(actor,itemName,itemCount,0,itemName.."打野刀升扣物品") then
                    return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
                end
            elseif i==2 then
                if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."打野刀升扣非通用货币",true) then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            elseif i==3 then
                if not consumebindmoney(actor,itemName,itemCount,itemName.."打野刀升扣通用货币") then
                    return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
                end
            end
        end
        ::continue::
    end

    local weightTab={1000,100,100,100} --#region 随机属性(增伤,对战,对法,对道)
    local allWeight=0
    for index, value in ipairs(weightTab) do
        allWeight=allWeight+value
    end
    local random=math.random(allWeight)
    local nowWeight=0
    local nowIndex=0 --#region 当前随机值
    for index, value in ipairs(weightTab) do
        nowWeight=nowWeight+value
        if random<=nowWeight then
            nowIndex=index+5
            break
        end
    end
    local addInfoMap={}
    -- local hasAddStr=getitemattr(actor, makeindex, 94)
    for i = 1, 5 do
        for key, value in pairs(self.cfg1[jungleLv+1]["add_map"..i]) do
            addInfoMap[key]=value
        end
    end
    for key, value in pairs(self.cfg1[jungleLv+1]["add_map"..nowIndex]) do
        addInfoMap[key]=value
    end
    additemattrEX(actor,makeindex,93,3,addInfoMap)

    local addStr=getitemattr(actor,makeindex,93)
    local result = {} --#region 属性显示变量表
    for _item in addStr:gmatch("([^|]+)") do
        -- item 现在是 "3#30#1000" 或 "3#50#20"
        local _, key, value = _item:match("(%d+)#(%d+)#(%d+)")
        if key and value then
            if key=="3"or key=="4"or key=="5"or key=="6"or key=="7"or key=="8" then key="3" end --#region 攻魔道读同一个
            result[tostring(key)] = tostring(value)
        end
    end
    VarApi.setPlayerTStrVar(actor,"T_jungleText",tbl2json(result),true)

    if jungleLv+1>=#self.cfg1 then
        self:changeExp(actor,jungleLv+1,self.cfg1[jungleLv+1].exp,self.cfg1[jungleLv+1].exp)
    else
        self:changeExp(actor,jungleLv+1,exp-self.cfg1[jungleLv+1].exp,self.cfg1[jungleLv+2].exp)
    end

    VarApi.setPlayerUIntVar(actor,"U_jungleLv",jungleLv+1,true)
    VarApi.setPlayerUIntVar(actor,"U_jungleExp_now",exp-self.cfg1[jungleLv+1].exp,true)
    Sendmsg9(actor,"00ff00","恭喜您成功将打野刀提升至·Lv"..(jungleLv+1).."！",1)
    -- sendmsgnew(actor,255,0,"境界飞升：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功修炼至"
    -- .."<『".."飞升·"..self.cfg1[layer+1]["type"].."境界』/FCOLOR=251>,获得属性提升！",1,2)
    lualib:FlushNpcUi(actor,"GodEquipOBJ","exp#"..(exp-self.cfg1[jungleLv+1].exp))
end

function GodEquip:changeAttribute(actor) --#region 神器仓库变动改属性
    local hasTab=json2tbl(VarApi.getPlayerTStrVar(actor,"T_godEquipActive")) --#region 已抽取到的
    if hasTab=="" then hasTab={} end
    if next(hasTab)==nil then
        for i = 1, 10 do
            delbuff(actor,40249+i)
        end
        return
    end
    local buffAttTab={{[30]=2},{[36]=100,[37]=100},{[30]=1,[35]=100},{[30]=2,[77]=100},{[30]=3,[76]=100}}
    for i = 1, 5 do --#region 5种类型
        local layer=0 --#region 单个层数
        local suitTag=true --#region 套装tag
        for icon = 1, 6 do --#region 6个icon
            local equipName=self.cfg2[icon].name_arr[i]..equipKey[icon]
            if hasTab[equipName] and tonumber(hasTab[equipName])>0 then
                layer=layer+1
            else
                suitTag=false
            end
        end
        if layer>0 then --#region 图鉴单个
            local tab={}
            for k, v in pairs(buffAttTab[i]) do
                tab[k]= v*layer
            end
            delbuff(actor,40249+i)
            addbuff(actor,40249+i,0,1,actor,tab)
        else
            delbuff(actor,40249+i)
        end
        if suitTag then --#region 图鉴套装
            delbuff(actor,40254+i)
            addbuff(actor,40254+i)
        else
            delbuff(actor,40254+i)
        end
    end
end
function GodEquip:activeEvent2(actor,number) --#region 神器激活
    number=tonumber(number)
    if not isInTable({1,2},number) then
        return Sendmsg9(actor, "ff0000", "当前激活序列异常！", 1)
    elseif os.time()-VarApi.getPlayerUIntVar(actor,"U_godEquip_inAnim")<4 then
        return Sendmsg9(actor, "ff0000", "当前还在抽奖中！", 1)
    end

    if number==2 then number=10 end
    if getbagitemcount(actor,"神器魔盒","0") < number then
        return Sendmsg9(actor, "ff0000", "当前背包物品神器魔盒数量少于" .. number .. "！", 1)
    end
    if not takeitem(actor,"神器魔盒",number,0,"神器激活扣") then
        return Sendmsg9(actor, "ff0000", "物品神器魔盒扣除失败！", 1)
    end

    local weightTab={10000,1000,100,10,1}
    local allWeight=11111
    local hasTab=json2tbl(VarApi.getPlayerTStrVar(actor,"T_godEquipActive")) --#region 已抽取到的
    if hasTab=="" then hasTab={} end
    local awardTab={} --#region 本次抽到
    for i = 1, number do
        local randWeight=math.random(allWeight)
        local nowWeight=0
        local rand1=0 --#region 类别
        for index, value in ipairs(weightTab) do
            nowWeight=nowWeight+value
            if randWeight<=nowWeight then
                rand1=index
                break
            end
        end
        local rand2=math.random(6) --# 第几个

        local resultEquip=self.cfg2[rand2]["name_arr"][rand1]..equipKey[rand2]
        table.insert(awardTab,{resultEquip,1})
        if hasTab[resultEquip] then
            hasTab[resultEquip]=tonumber(hasTab[resultEquip])+1
        else
            hasTab[resultEquip]=1
        end
    end

    VarApi.setPlayerUIntVar(actor,"U_godEquip_inAnim",os.time(),false)
    VarApi.setPlayerTStrVar(actor,"T_godEquipActive",tbl2json(hasTab),true)
    delaygoto(actor,3000,"obj_anim_wait21",0)
    VarApi.setPlayerTStrVar(actor,"T_equipVariation_awardTab",tbl2json(awardTab),false)
    lualib:FlushNpcUi(actor,"GodEquipOBJ","动画")
end
function obj_anim_wait21(actor)
    GodEquip:obj_anim_wait21(actor)
end
function GodEquip:obj_anim_wait21(actor)
    local awardTab=json2tbl(VarApi.getPlayerTStrVar(actor,"T_equipVariation_awardTab"))
    for index, value in ipairs(awardTab) do
        awardTab[index][2]=tonumber(awardTab[index][2])
    end
    ShowReward.showReward(actor,awardTab,0)
    -- sendmsgnew(actor,255,0,"境界飞升：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功修炼至"
    -- .."<『".."飞升·"..self.cfg1[layer+1]["type"].."境界』/FCOLOR=251>,获得属性提升！",1,2)
    GodEquip:changeAttribute(actor)
    VarApi.setPlayerUIntVar(actor,"U_godEquip_inAnim",0,false)
    lualib:FlushNpcUi(actor,"GodEquipOBJ","激活")
end

function GodEquip:merge3(actor,equipNameTab) --#region 神器融合
    equipNameTab=json2tbl(equipNameTab) or {}
    if #equipNameTab<3 then
        return Sendmsg9(actor, "ff0000", "请最少选取3件已拥有的神器！", 1)
    end
    local type1=self.cfg2[string.match(equipNameTab[1], "([^%[%]]+)")].type --#region 第1位装备type
    for i = 2, #equipNameTab do
        if self.cfg2[string.match(equipNameTab[i], "([^%[%]]+)")].type ~= type1 then
            return Sendmsg9(actor, "ff0000", "请选取同级别的神器进行融合！", 1)
        end
    end
    if type1==5 then
        return Sendmsg9(actor, "ff0000", "当前神器已是最高级别！", 1)
    end

    local hasTab=json2tbl(VarApi.getPlayerTStrVar(actor,"T_godEquipActive")) --#region 已抽取到的
    if hasTab=="" then hasTab={} end
    for index, value in ipairs(equipNameTab) do
        if not hasTab[value] or (hasTab[value] and hasTab[value]<=0) then
            return Sendmsg9(actor, "ff0000", "当前没有神器"..value.."！", 1)
        end
        hasTab[value]= (tonumber(hasTab[value])-1<=0 and nil) or tonumber(hasTab[value])-1
    end

    local nowType=type1+1
    local rand=math.random(6)
    local resultEquip=self.cfg2[rand].name_arr[nowType]..equipKey[rand]
    if #equipNameTab==5 then --#region 5个相同
        for i = 2, #equipNameTab do
            if equipNameTab[i]~=equipNameTab[i] then
                break
            elseif i==#equipNameTab then
                rand=self.cfg2[string.match(equipNameTab[1], "([^%[%]]+)")].lineType --#region 第1位装备lineType
                resultEquip=self.cfg2[rand].name_arr[nowType]..equipKey[rand]
            end
        end
    end

    hasTab[resultEquip]=(hasTab[resultEquip] and tonumber(hasTab[resultEquip])+1) or 1

    VarApi.setPlayerTStrVar(actor,"T_godEquipActive",tbl2json(hasTab),true)
    ShowReward.showReward(actor,resultEquip.."#1",0)
    -- sendmsgnew(actor,255,0,"境界飞升：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功修炼至"
    -- .."<『".."飞升·"..self.cfg1[layer+1]["type"].."境界』/FCOLOR=251>,获得属性提升！",1,2)
    lualib:FlushNpcUi(actor,"GodEquipOBJ","融合")
    GodEquip:changeAttribute(actor)
    GodEquip:changeGodEquipCfg(actor)
end

function GodEquip:changeGodEquipCfg(actor) --#region 删仓库检查神器配置
    local hasTab=json2tbl(VarApi.getPlayerTStrVar(actor,"T_godEquipActive")) --#region 已抽取到的
    if hasTab=="" then hasTab={} end
    local hasTab2=json2tbl(VarApi.getPlayerTStrVar(actor,"T_godEquip_hasList")) --#region 已经配置的
    if hasTab2=="" then hasTab2={} end
    if next(hasTab2)==nil then
        return
    end
    for i, v in ipairs(hasTab2) do
        local lineIndex,iconIndex=tonumber(string.sub(v,1,1)),tonumber(string.sub(v,2,2))
        local equipName=self.cfg2[lineIndex].name_arr[iconIndex]..equipKey[lineIndex]
        if not hasTab[equipName] or (hasTab[equipName] and tonumber(hasTab[equipName])<=0) then
            GodEquip:removeGodEquip(actor,i)
        end
    end
end
function GodEquip:setGodEquip(actor,lineIndex,iconIndex) --#region 神器配置
    lineIndex=tonumber(lineIndex)
    iconIndex=tonumber(iconIndex)
    local hasTab=json2tbl(VarApi.getPlayerTStrVar(actor,"T_godEquip_hasList")) --#region 已经配置的
    if hasTab=="" then hasTab={} end
    local hasTab2=json2tbl(VarApi.getPlayerTStrVar(actor,"T_godEquipActive")) --#region 已抽取到的
    if hasTab2=="" then hasTab2={} end
    local str=tostring(lineIndex..iconIndex)
    local equipName=self.cfg2[lineIndex]["name_arr"][iconIndex]..equipKey[lineIndex]
    if not isInTable({1,2,3,4,5,6},lineIndex) or not isInTable({1,2,3,4,5},iconIndex) then
        return Sendmsg9(actor, "ff0000", "当前序列异常！", 1)
    elseif not hasTab2[equipName] then
        return Sendmsg9(actor, "ff0000", "当前神器"..self.cfg2[lineIndex]["name_arr"][iconIndex].."还未激活！", 1)
    elseif isInTable(hasTab,str) then
        return
    elseif #hasTab>=5 then
        return
    end

    hasTab[#hasTab+1]=str
    VarApi.setPlayerTStrVar(actor,"T_godEquip_hasList",tbl2json(hasTab),true)

    Sendmsg9(actor,"00ff00","恭喜您配置神器"..(equipName).."！",1)
    if #hasTab==1 then self:changeActive(actor) end --#region 首次穿戴
    add_god_equip_btn(actor)
    -- sendmsgnew(actor,255,0,"境界飞升：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功修炼至"
    -- .."<『".."飞升·"..self.cfg1[layer+1]["type"].."境界』/FCOLOR=251>,获得属性提升！",1,2)
    lualib:FlushNpcUi(actor,"GodEquipOBJ","配置")
end
function GodEquip:removeGodEquip(actor,index) --#region 移除神器配置
    index=tonumber(index)
    local hasTab=json2tbl(VarApi.getPlayerTStrVar(actor,"T_godEquip_hasList")) --#region 已经配置的
    if hasTab=="" then hasTab={} end
    if not isInTable({1,2,3,4,5},index) then
        return Sendmsg9(actor, "ff0000", "移除序列异常！", 1)
    elseif not hasTab[index] then
        return
    end
    local lineIndex,iconIndex=tonumber(string.sub(hasTab[index],1,1)),tonumber(string.sub(hasTab[index],2,2))
    local equipName=self.cfg2[lineIndex]["name_arr"][iconIndex]
    table.remove(hasTab,index)
    VarApi.setPlayerTStrVar(actor,"T_godEquip_hasList",tbl2json(hasTab),true)
    Sendmsg9(actor,"00ff00","成功移除配置神器"..(equipName).."！",1)
    lualib:FlushNpcUi(actor,"GodEquipOBJ","配置")
    add_god_equip_btn(actor)
end

function GodEquip:changeActive(actor) --#region 切换激活的神器(属性)和按钮
    local hasTab=json2tbl(VarApi.getPlayerTStrVar(actor,"T_godEquip_hasList")) --#region 已经配置的
    if hasTab=="" then hasTab={} end
    if #hasTab==0 then
        return
    end
    local time=VarApi.getPlayerUIntVar(actor,"U_godEquip_change_cd")
    if os.time()-time<15 then
        return Sendmsg9(actor, "ff0000", "还在切换CD中！", 1)
    end
    VarApi.setPlayerUIntVar(actor,"U_godEquip_change_cd",os.time(),false)
    local first = hasTab[1] --#region 换位置
    for i = 1, #hasTab - 1 do
        hasTab[i] = hasTab[i + 1]
    end
    hasTab[#hasTab] = first
    VarApi.setPlayerTStrVar(actor,"T_godEquip_hasList",tbl2json(hasTab),true)

    local lineIndex,iconIndex=tonumber(string.sub(hasTab[1],1,1)),tonumber(string.sub(hasTab[1],2,2))
    local equipName=self.cfg2[lineIndex]["name_arr"][iconIndex]

    -- local addInfoStr=""
    -- for index, value in ipairs(attTab[lineIndex][1]) do
    --     addInfoStr=addInfoStr.."3#"..value.."#"..self.cfg2[equipName].addNumber1.."|"
    -- end
    -- for index, value in ipairs(attTab[lineIndex][2]) do
    --     addInfoStr=addInfoStr.."3#"..value.."#"..self.cfg2[equipName].addNumber2.."|"
    -- end
    -- if string.find(addInfoStr,"3#360#") then --#region 吸血
    --     VarApi.setPlayerUIntVar(actor,"U_godEquip_xx",self.cfg2[equipName].addNumber2,false)
    -- else
    --     VarApi.setPlayerUIntVar(actor,"U_godEquip_xx",0,false)
    -- end
    -- if string.find(addInfoStr,"3#359#") then --#region 速度
    --     changespeed(actor, 3, -self.cfg2[equipName].addNumber2)
    -- else
    --     changespeed(actor, 3, 0)
    -- end
    -- delattlist(actor,"godEquipAtt_str")
    -- VarApi.setPlayerTStrVar(actor,"T_godEquipAtt_str",addInfoStr,false)
    if lineIndex==3 then --#region 吸血
        VarApi.setPlayerUIntVar(actor,"U_godEquip_xx",self.cfg2[equipName].addNumber2,false)
    else
        VarApi.setPlayerUIntVar(actor,"U_godEquip_xx",0,false)
    end
    if lineIndex==6 then --#region 速度
        changespeed(actor, 3, -self.cfg2[equipName].addNumber2)
    else
        changespeed(actor, 3, 0)
    end
    if iconIndex>=3 then --#region buff效果key
        VarApi.setPlayerTStrVar(actor,"T_godEquip_buff_key",tostring(lineIndex..iconIndex),false)
    else
        VarApi.setPlayerTStrVar(actor,"T_godEquip_buff_key","",false)
    end

    delbodyitem(actor, 90, "切换神器扣")
    GiveOnItem(actor,90,equipName..equipKey[lineIndex],1,0,"切换神器直接穿装备")
    for i = 1, 6 do
        for index, value in ipairs(self.cfg2[i].name_arr) do
            local _name=value..equipKey[i]
            if getbagitemcount(actor,_name,"0")>0 then
                takeitem(actor,_name,getbagitemcount(actor,_name,"0"),0,"神器切换扣背包异常神器")
            end
        end
    end

    --#region 改图标
    add_god_equip_btn(actor)

    Sendmsg9(actor,"00ff00","恭喜您切换神器"..(equipName).."！",1)
end

return GodEquip