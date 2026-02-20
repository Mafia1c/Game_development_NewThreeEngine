local GodShield = {}
GodShield.cfg = {
    [90]={["needEquip"]={"九霄雷音盾",1},["need_config"]={{"黑铁",1888,0},{"龙鳞",1888,0},{"仙石",888,0},{"元宝",180000,2}},["nextEquip"]="太初鸿蒙盾"},
    [122]={["needEquip"]={"太初鸿蒙盾",1},["need_config"]={{"黑铁",3888,0},{"龙鳞",3888,0},{"仙石",1888,0},{"元宝",880000,2}},["nextEquip"]="创世源初盾"},
}
function GodShield:click(actor,nowNpcId)
    nowNpcId = tonumber(nowNpcId)
    if not self.cfg[nowNpcId] then
        return
    end
    if nowNpcId==90 then
        if CheckOpenState(actor, 1) then return end
    elseif nowNpcId==122 then
        if CheckOpenState(actor, 2) then return end
    end
    lualib:ShowNpcUi(actor, "GodShieldOBJ", nowNpcId)
end
function GodShield:upEvent(actor,nowNpcId) --#region 背包合成
    nowNpcId = tonumber(nowNpcId)
    if not self.cfg[nowNpcId] then
        return Sendmsg9(actor, "ff0000", "神盾合成序列异常！", 1)
    elseif checkitemw(actor,self.cfg[nowNpcId]["nextEquip"],1) then
        return Sendmsg9(actor, "ff0000", "当前神盾"..self.cfg[nowNpcId]["nextEquip"].."已拥有！", 1)
    end
    if nowNpcId==90 then
        if CheckOpenState(actor, 1) then return end
    elseif nowNpcId==122 then
        if CheckOpenState(actor, 2) then return end
    end

    if getbagitemcount(actor,self.cfg[nowNpcId]["needEquip"][1],"0") < self.cfg[nowNpcId]["needEquip"][2] then
        return Sendmsg9(actor, "ff0000", "当前背包物品"..self.cfg[nowNpcId]["needEquip"][1].."数量少于"..self.cfg[nowNpcId]["needEquip"][2].."！", 1)
    end
    for i, v in ipairs(self.cfg[nowNpcId]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if getbagitemcount(actor,itemName,"0") < itemCount then
                lualib:FlushNpcUi(actor, "GodShieldOBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 1 then
            if querymoney(actor,itemIndex) < itemCount then
                lualib:FlushNpcUi(actor, "GodShieldOBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        elseif type == 2 then
            if getbindmoney(actor,itemName) < itemCount then
                lualib:FlushNpcUi(actor, "GodShieldOBJ", "不足#"..i)
                return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
            end
        end
    end
    if not takeitem(actor,self.cfg[nowNpcId]["needEquip"][1],self.cfg[nowNpcId]["needEquip"][2],0,self.cfg[nowNpcId]["needEquip"][1].."神盾背包扣物品") then
        return Sendmsg9(actor, "ff0000", "物品"..self.cfg[nowNpcId]["needEquip"][1].."扣除失败！", 1)
    end
    for i, v in ipairs(self.cfg[nowNpcId]["need_config"] or {}) do
        local itemName = v[1]
        local itemIndex = getstditeminfo(itemName,0)
        local itemCount = v[2]
        local type = v[3] --#region 0材料 1非通用货币 2通用货币
        if type == 0 then
            if not takeitem(actor,itemName,itemCount,0,itemName.."次元神盾背包扣物品") then
                return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 1 then
            if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."次元神盾背包扣非通用货币",true) then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        elseif type == 2 then
            if not consumebindmoney(actor,itemName,itemCount,itemName.."次元神盾背包扣通用货币") then
                return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
            end
        end
    end

    local equipName = self.cfg[nowNpcId]["nextEquip"]
    GiveItem(actor,equipName,1,378,"次元神盾给"..equipName)
    sendmsgnew(actor,255,0,"次元神盾：恭喜<『"..getbaseinfo(actor,1).."』/FCOLOR=249>成功打造"
    .."<『"..equipName.."』/FCOLOR=251>,获得属性提升！",1,2)
    Sendmsg9(actor,"00ff00","恭喜您成功合成获得"..equipName.."！",1)
    lualib:FlushNpcUi(actor,"GodShieldOBJ","打造")
end

return GodShield