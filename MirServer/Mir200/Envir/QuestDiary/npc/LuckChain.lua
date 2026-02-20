local LuckChain = {}
LuckChain.cfg1 = {"元宝",2000}
LuckChain.cfg2 = {"元宝",20000}
LuckChain.cfg3 = {"元宝",5000}

function LuckChain:click(actor,npcId)
    if not isInTable({10003,1031},tonumber(npcId)) then
        return Sendmsg9(actor, "ff0000",  "打开npc异常!" , 1)
    end
    local makeIndex = GetItemByPos(actor, 3)
    local luck = GetItemLuck(actor,makeIndex) or 0
    local odd_BJ = GetInt(3,makeIndex,"luck_BJ")or 0 --#region 暴击值
    local odd_SS = GetInt(3,makeIndex,"luck_SS")or 0 --#region 神圣一击值
    -- if getitemattr(actor,makeIndex,1) then
    --     odd_BJ = string.sub(getitemattr(actor,makeIndex,1), 6, 6)
    -- end
    lualib:ShowNpcUi(actor, "LuckChainOBJ", npcId.."#"..luck.."#"..odd_BJ.."#"..odd_SS)
end

function LuckChain:upEvent(actor) --#region 淬炼项链
    local makeIndex = GetItemByPos(actor, 3)
    local luck = GetItemLuck(actor,makeIndex)
    if makeIndex == "0" then
        return Sendmsg9(actor, "ff0000",  "请先穿戴项链再来强化!" , 1)
    elseif luck >=3  then
        return Sendmsg9(actor, "ff0000",  "当前项链已强化至最高等级!" , 1)
    end

    local itemName = self.cfg1[1]
    local itemIndex = getstditeminfo(itemName,0)
    local itemCount = self.cfg1[2]
    if getbindmoney(actor,itemName) < itemCount then
        lualib:FlushNpcUi(actor, "LuckChainOBJ", "不足#1")
        return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
    end
    if not consumebindmoney(actor,itemName,itemCount,"幸运淬炼扣通用货币") then
        return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
    end

    local oddTab={100,50,25}
    if math.random(100) > oddTab[luck+1] then
        local odd_BJ = GetInt(3,makeIndex,"luck_BJ")or 0 --#region 暴击值
        local odd_SS = GetInt(3,makeIndex,"luck_SS")or 0 --#region 神圣一击值
        lualib:FlushNpcUi(actor, "LuckChainOBJ", "失败#"..luck.."#"..odd_BJ.."#"..odd_SS)
        return Sendmsg9(actor, "ff0000", "当前项链强化失败！", 1)
    end
    SetItemLuck(actor,makeIndex,luck+1)
    if luck+1 >=3  then
        local rand = math.random(3)
        additemattrEX(actor,makeIndex,1,3,{[21]=rand})
        SetInt(3,makeIndex,"luck_BJ",rand)
    end

    refreshitem(actor,makeIndex)
    local odd_BJ = GetInt(3,makeIndex,"luck_BJ")or 0 --#region 暴击值
    local odd_SS = GetInt(3,makeIndex,"luck_SS")or 0 --#region 神圣一击值
    Sendmsg9(actor,"00ff00","恭喜您成功淬炼当前项链幸运至"..(luck+1).."！",1)
    lualib:FlushNpcUi(actor,"LuckChainOBJ","淬炼#"..(luck+1).."#"..odd_BJ.."#"..odd_SS)
end

function LuckChain:clearEvent(actor) --#region 清洗属性
    local makeIndex = GetItemByPos(actor, 3)
    local luck = GetItemLuck(actor,makeIndex)
    if makeIndex == "0" then
        return Sendmsg9(actor, "ff0000",  "请先穿戴项链再来清洗属性!" , 1)
    elseif luck<3 then
        return Sendmsg9(actor, "ff0000",  "请先淬炼至幸运3再来清洗属性!" , 1)
    end
    messagebox(actor,"是否确定清除当前项链幸运\\以及淬炼附加属性？\\注：确定清除淬炼属性无法恢复！","@func_luck_claer1","@func_luck_claer2")
end
function func_luck_claer1(actor)
    local makeIndex = GetItemByPos(actor, 3)
    SetItemLuck(actor,makeIndex,0)
    delitemattr(actor,makeIndex,1,0)
    SetInt(3,makeIndex,"luck_BJ",0)
    SetInt(3,makeIndex,"luck_SS",0)
    refreshitem(actor,makeIndex)
    Sendmsg9(actor,"00ff00","恭喜您成功清洗当前项链属性值！",1)
    lualib:FlushNpcUi(actor,"LuckChainOBJ","clear#0#0#0")
end

function LuckChain:transfer(actor,makeIndex2) --#region 转移幸运
    local makeIndex1 = GetItemByPos(actor, 3) --#region 穿戴项链index
    local luck1 = GetItemLuck(actor,makeIndex1) --#region 穿戴项链幸运
    if makeIndex1 == "0" then
        return Sendmsg9(actor, "ff0000",  "请先穿戴项链再来转移属性!" , 1)
    elseif makeIndex2 == "0" or makeIndex2 == nil or makeIndex2 == "" then
        return Sendmsg9(actor, "ff0000",  "请先选取背包拥有的项链再来转移属性!" , 1)
    elseif luck1<3 then
        return Sendmsg9(actor, "ff0000",  "请先将穿戴项链淬炼至幸运3再来转移属性!" , 1)
    end

    local itemName = self.cfg2[1]
    local itemIndex = getstditeminfo(itemName,0)
    local itemCount = self.cfg2[2]
    if getbindmoney(actor,itemName) < itemCount then
        lualib:FlushNpcUi(actor, "LuckChainOBJ", "不足#2")
        return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
    end
    if not consumebindmoney(actor,itemName,itemCount,"幸运转移扣通用货币") then
        return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
    end

    local odd_BJ = GetInt(3,makeIndex1,"luck_BJ")or 0 --#region 暴击值
    local odd_SS = GetInt(3,makeIndex1,"luck_SS")or 0 --#region 神圣一击值
    SetItemLuck(actor,makeIndex1,0)
    delitemattr(actor,makeIndex1,1,0)
    SetInt(3,makeIndex1,"luck_BJ",0)
    SetInt(3,makeIndex1,"luck_SS",0)
    refreshitem(actor,makeIndex1)
    SetItemLuck(actor,makeIndex2,luck1)
    delitemattr(actor,makeIndex2,1,0)
    additemattrEX(actor,makeIndex2,1,3,{[21]=odd_BJ,[79]=odd_SS*100})
    SetInt(3,makeIndex2,"luck_BJ",odd_BJ)
    SetInt(3,makeIndex2,"luck_SS",odd_SS)
    refreshitem(actor,makeIndex2)

    Sendmsg9(actor, "00FF00", "成功转移幸运属性至选取装备！", 1)
    lualib:FlushNpcUi(actor,"LuckChainOBJ", "transfer#0#0#0")
end

function LuckChain:awakeEvent(actor) --#region 觉醒项链
    if CheckOpenState(actor, 1) then return end
    local makeIndex = GetItemByPos(actor, 3)
    local luck = GetItemLuck(actor,makeIndex)
    local odd_BJ = GetInt(3,makeIndex,"luck_BJ")or 0 --#region 暴击值
    if makeIndex == "0" then
        return Sendmsg9(actor, "ff0000",  "请先穿戴项链再来强化!" , 1)
    elseif luck <3  then
        return Sendmsg9(actor, "ff0000",  "请先将穿戴项链淬炼至幸运3再来觉醒属性!" , 1)
    elseif odd_BJ<3 then
        return Sendmsg9(actor, "ff0000",  "请先将穿戴项链淬炼至暴击+3%再来觉醒属性!" , 1)
    elseif (GetInt(3,makeIndex,"luck_SS")or 0) >0 then
        return Sendmsg9(actor, "ff0000",  "当前穿戴项链已觉醒属性!" , 1)
    end

    local itemName = self.cfg3[1]
    local itemIndex = getstditeminfo(itemName,0)
    local itemCount = self.cfg3[2]
    if getbindmoney(actor,itemName) < itemCount then
        lualib:FlushNpcUi(actor, "LuckChainOBJ", "不足#1")
        return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
    end
    if not consumebindmoney(actor,itemName,itemCount,"幸运觉醒扣通用货币") then
        return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
    end

    -- local oddTab={100,50,25}
    -- if math.random(100) > oddTab[luck+1] then
    --     local odd_BJ = GetInt(3,makeIndex,"luck_BJ")or 0 --#region 暴击值
    --     local odd_SS = GetInt(3,makeIndex,"luck_SS")or 0 --#region 神圣一击值
    --     lualib:FlushNpcUi(actor, "LuckChainOBJ", "失败#"..luck.."#"..odd_BJ.."#"..odd_SS)
    --     return Sendmsg9(actor, "ff0000", "当前项链强化失败！", 1)
    -- end
    local rand = math.random(3)
    additemattrEX(actor,makeIndex,1,3,{[79]=rand*100})
    SetInt(3,makeIndex,"luck_SS",rand)

    refreshitem(actor,makeIndex)
    local odd_BJ = GetInt(3,makeIndex,"luck_BJ")or 0 --#region 暴击值
    local odd_SS = GetInt(3,makeIndex,"luck_SS")or 0 --#region 神圣一击值
    Sendmsg9(actor,"00ff00","恭喜您成功觉醒当前项链神圣一击至"..(odd_SS).."%！",1)
    lualib:FlushNpcUi(actor,"LuckChainOBJ","awake#"..(luck).."#"..odd_BJ.."#"..odd_SS)
end

return LuckChain