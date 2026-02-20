local CompoundSys = {}
CompoundSys.cfg = include("QuestDiary/config/CompoundSysCfg.lua")

function CompoundSys:upEvent(actor,leftIndex1,leftIndex2,rightIndex) --#region 合成
    -- leftIndex1 = tonumber(leftIndex1)
    -- leftIndex2 = tonumber(leftIndex2)
    -- rightIndex = tonumber(rightIndex)
    -- local item_name1 = self.cfg[leftIndex1]["item_arr"][leftIndex2]
    -- local item_name2 = self.cfg[item_name1]["item_arr"][rightIndex]
    -- if not self.cfg[leftIndex1] or not item_name1 or not self.cfg[item_name2] then
    --     return Sendmsg9(actor, "ff0000", "合成物品异常！", 1)
    -- end

    -- for i, v in ipairs(self.cfg[item_name2]["need_config"] or {}) do
    --     local itemName = v[1]
    --     local itemIndex = getstditeminfo(itemName,0)
    --     local itemCount = v[2]
    --     local type = v[3] --#region 0材料 1非通用货币 2通用货币
    --     if type == 0 then
    --         if getbagitemcount(actor,itemName,"0") < itemCount then
    --             lualib:FlushNpcUi(actor, "CompoundSysOBJ", "不足#"..i)
    --             return Sendmsg9(actor, "ff0000", "当前背包物品" .. itemName .. "数量少于" .. itemCount .. "！", 1)
    --         end
    --     elseif type == 1 then
    --         if querymoney(actor,itemIndex) < itemCount then
    --             lualib:FlushNpcUi(actor, "CompoundSysOBJ", "不足#"..i)
    --             return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
    --         end
    --     elseif type == 2 then
    --         if getbindmoney(actor,itemName) < itemCount then
    --             lualib:FlushNpcUi(actor, "CompoundSysOBJ", "不足#"..i)
    --             return Sendmsg9(actor, "ff0000", "当前玩家货币" .. itemName .. "数量少于" .. itemCount .. "！", 1)
    --         end
    --     end
    -- end
    -- for i, v in ipairs(self.cfg[item_name2]["need_config"] or {}) do
    --     local itemName = v[1]
    --     local itemIndex = getstditeminfo(itemName,0)
    --     local itemCount = v[2]
    --     local type = v[3] --#region 0材料 1非通用货币 2通用货币
    --     if type == 0 then
    --         if not takeitem(actor,itemName,itemCount,0,itemName.."特殊四格背包扣物品") then
    --             return Sendmsg9(actor, "ff0000", "物品" .. itemName .. "扣除失败！", 1)
    --         end
    --     elseif type == 1 then
    --         if not ChangeMoney(actor,itemIndex,"-",itemCount,itemName.."特殊四格背包扣非通用货币",true) then
    --             return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
    --         end
    --     elseif type == 2 then
    --         if not consumebindmoney(actor,itemName,itemCount,itemName.."特殊四格背包扣通用货币") then
    --             return Sendmsg9(actor, "ff0000", "货币" .. itemName .. "扣除失败！", 1)
    --         end
    --     end
    -- end

    -- GiveItem(actor,item_name2,1,0,"系统合成获得"..item_name2)
    -- Sendmsg9(actor,"00ff00","恭喜您成功合成获得"..item_name2.."！",1)
    -- lualib:FlushNpcUi(actor,"CompoundSysOBJ","add")
end

return CompoundSys