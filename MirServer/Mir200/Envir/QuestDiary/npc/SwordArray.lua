local SwordArray = {}
local tab1={"仙石",10} --#region 进入诛仙剑阵
local tab2={"幻灵石",1} --#region 进入上古剑阵
local tab3={"诛仙碎片",1} --#region 投放诛仙碎片

function SwordArray:click(actor)
    if CheckOpenState(actor, 2) then return end
    local layer=GetSysInt("G_SwordArray") or 0
    lualib:ShowNpcUi(actor, "SwordArrayOBJ", layer)
end
function SwordArray:goEvent1(actor) --#region 进入诛仙剑阵
    if CheckOpenState(actor, 2) then return end
    if getbagitemcount(actor,tab1[1],"0") < tab1[2] then
        return Sendmsg9(actor, "ff0000", "当前背包物品"..tab1[1].."数量少于"..tab1[2].."！", 1)
    end
    if not takeitem(actor,tab1[1],tab1[2],0,"诛仙剑阵进入诛仙剑阵") then
        return Sendmsg9(actor, "ff0000", "物品" .. tab1[1] .. "扣除失败！", 1)
    end

    lualib:CloseNpcUi(actor, "SwordArrayOBJ")
    map(actor,"诛仙剑阵")
end
function SwordArray:goEvent2(actor) --#region 进入上古剑阵
    if CheckOpenState(actor, 2) then return end
    if not kuafuconnected() then
        return Sendmsg9(actor, "ff0000", "当前跨服服务器并未连接！", 1)
    end
    if getbagitemcount(actor,tab2[1],"0") < tab2[2] then
        return Sendmsg9(actor, "ff0000", "当前背包物品"..tab2[1].."数量少于"..tab2[2].."！", 1)
    end
    if not takeitem(actor,tab2[1],tab2[2],0,"诛仙剑阵进入上古剑阵") then
        return Sendmsg9(actor, "ff0000", "物品" .. tab2[1] .. "扣除失败！", 1)
    end

    lualib:CloseNpcUi(actor, "SwordArrayOBJ")
    map(actor,"上古剑阵")
end
function SwordArray:goEvent3(actor) --#region 投放诛仙碎片
    if CheckOpenState(actor, 2) then return end
    local layer=GetSysInt("G_SwordArray") or 0
    if getbagitemcount(actor,tab3[1],"0") < tab3[2] then
        return Sendmsg9(actor, "ff0000", "当前背包物品"..tab3[1].."数量少于"..tab3[2].."！", 1)
    end
    if not takeitem(actor,tab3[1],tab3[2],0,"诛仙剑阵扣诛仙碎片") then
        return Sendmsg9(actor, "ff0000", "物品" .. tab3[1] .. "扣除失败！", 1)
    end
    GiveItem(actor,"幻灵石",1,370,"诛仙剑阵送幻灵石")

    if layer+1>=99 then
        SetSysInt("G_SwordArray",0,6)
        if getmoncount("诛仙剑阵",2499,true)==0 then
            genmon("诛仙剑阵",28,33,"诛仙剑魔",3,1,249)
        end
        for i = 1, 3 do
            sendmovemsg("0", 0, 255, 0, 60 + (i - 1 ) * 30, 1, "<【诛仙剑魔】∶/FCOLOR=253> 降临 <【诛仙剑阵】/FCOLOR=254> 各位勇士速速前往击杀！")
        end
    else
        SetSysInt("G_SwordArray",layer+1,6)
    end

    Sendmsg9(actor, "00ff00", "成功投放诛仙碎片*1！", 1)
    lualib:FlushNpcUi(actor,"SwordArrayOBJ","refresh#"..GetSysInt("G_SwordArray"))
end
-- function SwordArray:exchange(actor,index) --#region 兑换诛仙碎片
--     index=tonumber(index)
--     if not isInTable({1,2},index) then
--         return Sendmsg9(actor, "ff0000", "当前兑换次序异常！", 1)
--     end
--     if index==2 then index=10 end
--     if getbagitemcount(actor,"黄金钥匙","0") < 2*index then
--         return Sendmsg9(actor, "ff0000", "当前背包物品".."黄金钥匙".."数量少于"..(2*index).."！", 1)
--     end
--     if not takeitem(actor,"黄金钥匙",2*index,0,"诛仙剑阵扣诛仙碎片") then
--         return Sendmsg9(actor, "ff0000", "物品" .. "黄金钥匙" .. "扣除失败！", 1)
--     end

--     Sendmsg9(actor, "00ff00", "成功兑换诛仙碎片*"..(2*index).."！", 1)
--     GiveItem(actor,"诛仙碎片",index,0,"诛仙剑阵兑换"..index)
--     lualib:FlushNpcUi(actor,"SwordArrayOBJ","refresh#"..GetSysInt("G_SwordArray"))
-- end
function SwordArray:buyEvent(actor,number) --#region 买诛仙碎片
    if CheckOpenState(actor, 2) then return end
    number=tonumber(number)
    if not isInTable({1,2},number) then
        return Sendmsg9(actor, "ff0000", "当前购买次序异常！", 1)
    end
    local tab={"元宝",10000}
    if number==2 then number=10 end
    if getbindmoney(actor,tab[1]) < tab[2]*number then
        return Sendmsg9(actor, "ff0000", "当前玩家货币"..tab[1].. "数量少于" .. tab[2] .. "！", 1)
    end
    if not consumebindmoney(actor,tab[1],tab[2]*number,tab[1].."诛仙剑阵买碎片") then
        return Sendmsg9(actor, "ff0000", "货币" .. tab[1] .. "扣除失败！", 1)
    end
    GiveItem(actor,"诛仙碎片",1*number,370,"诛仙剑阵买")
    Sendmsg9(actor, "00ff00", "成功购买诛仙碎片*"..(1*number).."！", 1)
end

return SwordArray