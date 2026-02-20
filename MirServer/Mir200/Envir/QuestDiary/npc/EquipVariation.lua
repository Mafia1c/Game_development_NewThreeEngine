local EquipVariation = {}
EquipVariation.cfg=include("QuestDiary/config/EquipVariationCfg.lua") --#region 变异表
EquipVariation.cfg1={["黑金古刃"]=78,["天蚕の甲"]=79,["痛苦の盔"]=80,["双鱼の佩"]=81,["转世の手"]=82,["轮回の爪"]=83,["神の戒"]=84
,["魔の戒"]=85,["紫金の带"]=86,["幻影の靴"]=87} --#region 专属附魔(过滤)
EquipVariation.cfg2 = include("QuestDiary/config/EquipSpecialCfg2.lua") --#region 上古以上(衣服武器)
EquipVariation.upTab1 = { --#region 上面pc
    {106, 520,"<Img|ax=0.5|x=20|y=40|img=custom/npc/114by/bg1.png>"},
    {106, 521,"<RText|ax=0.5|x=20|y=144|size=18|text=%s>"},
    -- {106, 522,"<MKItemShow|ax=0.5|x=240|y=120|makeindex=%s|showtips=1|bgtype=1>"},
}
EquipVariation.upTab2 = { --#region 上面mob
    {106, 520,"<Img|ax=0.5|x=0|y=40|img=custom/npc/114by/bg1.png>"},
    {106, 521,"<RText|ax=0.5|x=0|y=144|size=18|text=%s>"},
    -- {106, 522,"<MKItemShow|ax=0.5|x=220|y=120|makeindex=%s|showtips=1|bgtype=1>"},
}
EquipVariation.sideTab1 = { --#region 侧面pc
    {103, 523,"<Img|ax=0.5|ay=0.5|x=200|y=-350|img=custom/npc/114by/bg2.png>"},
    {103, 524,"<ItemShow|ax=0.5|ay=0.5|x=200|y=-386|itemid=%s|showtips=1|bgtype=1>"},
    {103, 525,"<MKItemShow|ax=0.5|ay=0.5|x=200|y=-289|makeindex=%s|showtips=1|bgtype=1>"},
    {103, 526,"<Button|ax=0.5|ay=0.5|x=260|y=-236|nimg=custom/npc/g0.png|link=@check_equip_variation1>"},
    {103, 527,"<RText|ax=0.5|ay=0.5|x=186|y=-236|size=15|text=本局游戏不再提醒>"},
    {103, 528,"<Button|ax=0.5|ay=0.5|x=296|y=-424|nimg=public/11.png|link=@del_equip_variation_side1>"},
}
EquipVariation.sideTab2 = { --#region 侧面mob
    {103, 523,"<Img|ax=0.5|ay=0.5|x=280|y=-290|img=custom/npc/114by/bg2.png>"},
    {103, 524,"<ItemShow|ax=0.5|ay=0.5|x=280|y=-326|itemid=%s|showtips=1|bgtype=1>"},
    {103, 525,"<MKItemShow|ax=0.5|ay=0.5|x=280|y=-229|makeindex=%s|showtips=1|bgtype=1>"},
    {103, 526,"<Button|ax=0.5|ay=0.5|x=340|y=-176|nimg=custom/npc/g0.png|link=@check_equip_variation1>"},
    {103, 527,"<RText|ax=0.5|ay=0.5|x=266|y=-176|size=15|text=本局游戏不再提醒>"},
    {103, 528,"<Button|ax=0.5|ay=0.5|x=378|y=-362|nimg=public/11.png|link=@del_equip_variation_side1>"},
}


--#region 设置属性(对象，唯一id,必变tag)
function EquipVariation:setEquipVariation(actor,makeindex,specialEquip)
    local item_name=getiteminfo(actor,makeindex,7) --#region 掉落物品名
    local stdmode=getstditeminfo(item_name,2)
    if self.cfg[1].std_map[stdmode] or self.cfg[2].std_map[stdmode] or self.cfg[3].std_map[stdmode] then
    else
        return
    end
    local actorName=getbaseinfo(actor,1)
    local must_appear=false --#region 本次是否必出
    local gs_index=nil
    local must_key = "" --#region 本次必包印记
    for i = 1, 3 do  --#region gs本次是否必爆
        local label = GetSysStr("A_variation_label"..i)
        if (strsplit(label,"|")[1] or "")==actorName then
            must_key=strsplit(label,"|")[2] or ""
            must_appear=true
            gs_index=i
            break
        end
    end
    local variation_type = nil --#region 选中类型
    local has_info = GetStr(3,makeindex,"item_desc_info2")
    local tag= GetStr(3,makeindex,"isVariation")
    if has_info~="" then
        return
    elseif tag=="1" and not specialEquip then
        return
    end
    local odd=GetSysInt("G_variationOdd")
    if odd==0 then odd=2 end
    if GetSysInt("G200")==1 then
        odd=math.max(odd,20)
    end
    if self.cfg2[item_name] and self.cfg[3].std_map[stdmode] and (math.random(100)<=odd or must_appear or specialEquip) then
        variation_type=3
    elseif self.cfg[1].std_map[stdmode] and (math.random(100)<=odd or must_appear or specialEquip) then
        variation_type=1
    elseif self.cfg[2].std_map[stdmode] and (math.random(100)<=odd or must_appear or specialEquip) then
        variation_type=2
    else --#region 失败
        SetStr(3,makeindex,"isVariation","1")
        return
    end


    local validRunes = self.cfg[variation_type].signet_arr --#region 候选列表
    local totalWeight = 0 --#region 权重
    for index, value in ipairs(validRunes) do
        totalWeight=totalWeight+self.cfg[value].weight
    end

    local now_appear=nil --#region 本次出现
    local random=math.random(totalWeight)
    local accumulated = 0
    for index, value in ipairs(validRunes) do
        accumulated=accumulated+self.cfg[value].weight
        if random<=accumulated then
            now_appear=value
            break
        end
    end

    if must_appear and must_key~="" and self.cfg[variation_type].std_map[stdmode] then
        SetSysStr("A_variation_label"..gs_index,"",6)
        if self.cfg["["..must_key.."]"] then
            now_appear="["..must_key.."]"
        end
    end
    if must_appear then
        SetSysStr("A_variation_label"..gs_index,"",6)
    end

    local heightNumber=self.cfg[now_appear].height+1
    local msg = "500:"..(14+20*heightNumber) --#region 符文显示
    msg=msg.."|SFX:"..self.cfg[now_appear].effect..":0:"..(10+20*heightNumber)..":0.8|RTEXT:<"
    ..((variation_type~=3 and string.gsub(now_appear, "%[([^%[%]]+)%]", "[高级%1]")) or now_appear)
    .."：/FCOLOR=251>:56:"..(14+20*heightNumber-24)..":1"
    local textTab=strsplit(self.cfg[now_appear].text_arr,"#")
    for index, value in ipairs(textTab) do
        msg=msg.."\\|RTEXT:"..value..":56:"..(14+20*heightNumber-24-(index*22))..":1"
    end

    local effectnumbag = 13380
    local effectnumbody = 13380
    if stdmode == 10 or stdmode == 11 or stdmode == 5 or stdmode == 6 then
        effectnumbody = 0
    end
    setitemeffect(actor,-2,effectnumbag,effectnumbody,1,1,makeindex)

    delitemattr(actor,makeindex,88,0)
    additemattrEX(actor,makeindex,88,3,{[215]=1})
    SetStr(3, makeindex, "item_desc_info2", msg) --#region 前端用
    SetStr(3,makeindex,"equip_variation",now_appear)
    SendItemVarToc(actor, makeindex)
    refreshitem(actor, makeindex)
    Sendmsg9(actor, "DF009F", "恭喜装备"..item_name.."成功变异属性"..now_appear.."！", 1)
    SetSysStr("A_varitationSendAllMsg",getiteminfo(actor,makeindex,7)..","..now_appear..","..getbaseinfo(actor,1)..","..getbaseinfo(actor,3),6)
    gmexecute("0","开始提问","equip_variation_send_msg")
    -- EquipVariation:sendAllMsg(actor,makeindex,now_appear)

    delaygoto(actor, 100, "delay_show_variation_equip1,"..makeindex..","..getiteminfo(actor,makeindex,2), 0)
end

function delay_show_variation_equip1(actor, makeindex,equipIndex)
    local is_pc = getconst(actor,"<$CLIENTFLAG>")
    if VarApi.getPlayerUIntVar(actor,"U_equipVariation_isOpen")==0 then
        for index, v in ipairs(EquipVariation["sideTab"..is_pc] or EquipVariation["sideTab2"]) do
            delbutton(actor,v[1],v[2])
            local tmp_str = ""
            if index==2 then
                tmp_str=string.format(v[3], equipIndex)
            elseif index==3 then
                tmp_str=string.format(v[3], makeindex)
            else
                tmp_str=string.format(v[3], "")
            end
            addbutton(actor, v[1], v[2], tmp_str)
        end
    end
    cleardelaygoto(actor, "delay_show_variation_equip1")
    delaygoto(actor, 5000, "del_equip_variation_side1", 0)
end

function EquipVariation:sendAllMsg(actor) --#region 所有人发界面
    local tab=strsplit(GetSysStr("A_varitationSendAllMsg"), ",")
    local is_pc = getconst(actor,"<$CLIENTFLAG>")
    for index, v in ipairs(self["upTab"..is_pc] or self["upTab2"]) do
        delbutton(actor,v[1],v[2])
        local tmp_str = ""
        if index==2 then
            tmp_str=string.format(v[3],"恭喜玩家<"..tab[3].."/FCOLOR=149>在<"
            ..getmapname(tab[4]).."/FCOLOR=250>成功<变异装备/FCOLOR=249><"..tab[1].."/FCOLOR=245><"..tab[2].."/FCOLOR=251>")
        else
            tmp_str = string.format(v[3], "")
        end
        addbutton(actor, v[1], v[2], tmp_str)
        cleardelaygoto(actor,"del_equip_variation_up1")
        delaygoto(actor,3000,"del_equip_variation_up1",0)
    end
end
function del_equip_variation_up1(player) --#region del up
    EquipVariation:del_equip_variation_up1(player)
end
function EquipVariation:del_equip_variation_up1(player)
    local is_pc = getconst(player,"<$CLIENTFLAG>") or 2
    for index, v in ipairs(EquipVariation["upTab"..is_pc] or EquipVariation["upTab2"]) do
        delbutton(player,v[1],v[2])
    end
end
function check_equip_variation1(actor) --#region check按钮
    EquipVariation:check_equip_variation1(actor)
end
function EquipVariation:check_equip_variation1(actor)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") or 2
    local tab=EquipVariation["sideTab"..is_pc][4]
    if VarApi.getPlayerUIntVar(actor,"U_equipVariation_check")==0 then
        VarApi.setPlayerUIntVar(actor,"U_equipVariation_check",1,false)
        addbutton(actor,tab[1],tab[2],string.gsub(tab[3],"g0.png","g1.png"))
    else
        VarApi.setPlayerUIntVar(actor,"U_equipVariation_check",0,false)
        addbutton(actor,tab[1],tab[2],tab[3])
    end
end

function del_equip_variation_side1(actor) --#region del侧面
    EquipVariation:del_equip_variation_side1(actor)
end
function EquipVariation:del_equip_variation_side1(actor)
    local is_pc = getconst(actor,"<$CLIENTFLAG>") or 2
    if VarApi.getPlayerUIntVar(actor,"U_equipVariation_check")==1 then
        VarApi.setPlayerUIntVar(actor,"U_equipVariation_isOpen",1,false)
    end
    for index, v in ipairs(EquipVariation["sideTab"..is_pc] or EquipVariation["sideTab1"]) do
        delbutton(actor,v[1],v[2])
    end
end





function EquipVariation:addPlayerEquipVariationBuff(actor,makeIndex,where) --#region 穿戴变异属性
    local equipVariation=GetStr(3,makeIndex,"equip_variation")
    if not self.cfg[equipVariation] then
        return
    end
    -- local has_equipVariation=json2tbl(VarApi.getPlayerTStrVar(actor,"T_has_equipVariation"))--#region 拥有的变异名称
    -- if has_equipVariation=="" then has_equipVariation={} end
    local nowVariationTag=VarApi.getPlayerUIntVar(actor,"U_equipVariation_tag"..equipVariation) --#region 当前拥有几个tag
    if self.cfg[equipVariation].buffid then
        addbuff(actor,self.cfg[equipVariation].buffid)
    end
    if equipVariation=="[敏捷]" and nowVariationTag==0 then
        if GetSysInt("G200")==0 then
            changespeed(actor,1,-1)
            changespeed(actor,2,-1)
        end
    elseif equipVariation=="[须弥真言]" and nowVariationTag==0 then
        local job=getbaseinfo(actor,7)
        if job==0 then
            local cd1= getskillcscd("开天斩")--66
            local cd2= getskillcscd("逐日剑法")--56
            SetSkillMaxCD(actor,66,cd1-1000)
            SetSkillMaxCD(actor,56,cd2-1000)
            if GetSysInt("G200")==0 then
                changespeed(actor,2,-1)
            end
        elseif job==1 then
            setmagicpower(actor,"魔法盾",20,1)
            if GetSysInt("G200")==0 then
                changespeed(actor,3,-1)
            end
        elseif job==2 then
            VarApi.setPlayerUIntVar(actor,"U_babyNumTag",1,false)
            if GetSysInt("G200")==0 then
                changespeed(actor,3,-1)
            end
        end
    end
    -- table.insert(has_equipVariation,equipVariation)
    -- VarApi.setPlayerTStrVar(actor,"T_has_equipVariation",tbl2json(has_equipVariation),false)
    VarApi.setPlayerUIntVar(actor,"U_equipVariation_tag"..equipVariation,nowVariationTag+1,false)
end
function EquipVariation:delPlayerEquipVariationBuff(actor,makeIndex) --#region 脱变异属性
    local equipVariation=GetStr(3,makeIndex,"equip_variation")
    if not self.cfg[equipVariation] then
        return
    end
    -- local has_equipVariation=json2tbl(VarApi.getPlayerTStrVar(actor,"T_has_equipVariation"))--#region 拥有的变异名称
    -- if has_equipVariation=="" then has_equipVariation={} end
    -- if #has_equipVariation==0 then
    --     return
    -- end
    -- for index, value in ipairs(has_equipVariation) do
    --     if value==equipVariation then
    --         table.remove(has_equipVariation,index)
    --         break
    --     end
    -- end
    -- VarApi.setPlayerTStrVar(actor,"T_has_equipVariation",tbl2json(has_equipVariation),false)
    local nowVariationTag=VarApi.getPlayerUIntVar(actor,"U_equipVariation_tag"..equipVariation) --#region 当前拥有几个tag
    if self.cfg[equipVariation].buffid and nowVariationTag==1 then
        delbuff(actor,self.cfg[equipVariation].buffid)
    end
    if GetSysInt("G200")==0 and equipVariation=="[敏捷]" and nowVariationTag==1 then
        changespeed(actor,1,1)
        changespeed(actor,2,1)
    elseif equipVariation=="[永恒]" and nowVariationTag==1 then
        delbuff(actor,40208)
    elseif GetSysInt("G200")==0 and equipVariation=="[须弥真言]" and nowVariationTag==1 then
        local job=getbaseinfo(actor,7)
        if job==0 then
            changespeed(actor,2,1)
        elseif job==1 then
            changespeed(actor,3,1)
        elseif job==2 then
            changespeed(actor,3,1)
        end
        local cd1= getskillcscd("开天斩")--66
        local cd2= getskillcscd("逐日剑法")--56
        SetSkillMaxCD(actor,66,cd1)
        SetSkillMaxCD(actor,56,cd2)
        setmagicpower(actor,"魔法盾",0,1)
        VarApi.setPlayerUIntVar(actor,"U_babyNumTag",0,false)
    end
    VarApi.setPlayerUIntVar(actor,"U_equipVariation_tag"..equipVariation,((nowVariationTag-1)<0 and 0) or (nowVariationTag-1),false)
end

return EquipVariation