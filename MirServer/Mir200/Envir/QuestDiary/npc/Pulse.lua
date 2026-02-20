local Pulse = {}
Pulse.cfg = include("QuestDiary/config/PulseCfg.lua")
function Pulse:click(actor)
    lualib:ShowNpcUi(actor, "PulseOBJ", "")
    TaskTrigger.CompleteTask(actor, 17)
end

function Pulse:upEvent(actor) --#region 提升
    local layer = VarApi.getPlayerUIntVar(actor,"U_pulseLayer")  --#region 当前层次在表中index
    local lineIndex = self.cfg[layer]["layer"] --#region 当前经脉index
    if not self.cfg[layer] then
        return Sendmsg9(actor, "ff0000", "当前提升序列异常！", 1)
    elseif layer>= #self.cfg then
        return Sendmsg9(actor, "ff0000", "当前所有穴位已激活！", 1)
    end

    for i, v in ipairs(self.cfg[layer]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if getbagitemcount(actor,itemName,"0") < itemCount then
                lualib:FlushNpcUi(actor, "PulseOBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 1 then
            if querymoney(actor,itemIndex) < itemCount then
                lualib:FlushNpcUi(actor, "PulseOBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 2 then
            if getbindmoney(actor,itemName) < itemCount then
                lualib:FlushNpcUi(actor, "PulseOBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        end
    end
    for i, v in ipairs(self.cfg[layer]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if not takeitem(actor,itemName,itemCount,0,itemName.."奇经八脉背包扣物品") then
                return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 1 then
            if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."奇经八脉背包扣非通用货币",true) then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 2 then
            if not consumebindmoney(actor,itemName,itemCount,itemName.."奇经八脉背包扣通用货币") then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        end
    end

    local addStr = self.cfg[layer+1]["addStr1"].."|"..self.cfg[layer+1]["addStr2"] --#region 基础属性+穴位属性
    delattlist(actor,"pluse_attr")
    -- VarApi.setPlayerTStrVar(actor,"T_pluse_attr",addStr,false)
    delbuff(actor,40104)
    addbuff(actor,40104,0,1,actor,ParserAttrStrToTable(addStr))
    VarApi.setPlayerUIntVar(actor,"U_pulseLayer",layer+1,true)
    if (layer+1)%11 == 0 then
        Sendmsg9(actor,"00ff00","恭喜您成功突破经脉达到"..self.cfg[layer+1]["lifeline"].."！",1)
    else
        Sendmsg9(actor,"00ff00","恭喜您成功突破穴位达到"..self.cfg[layer+1]["acupoint"].."！",1)
    end
    lualib:FlushNpcUi(actor,"PulseOBJ","提升")
end

function Pulse:addStrInfo(actor) --#region 登陆加属性
    -- local layer = VarApi.getPlayerUIntVar(actor,"U_pulseLayer")  --#region 当前层次在表中index
    -- if layer==0 then
    --     return
    -- end
    -- local addStr = self.cfg[layer]["addStr1"].."|"..self.cfg[layer]["addStr2"]
end


return Pulse