local MainTopBtn = {}
-- 充值商城
function MainTopBtn:RechargeShopping(actor)
    if not self:CheckKFState(actor) then return end
    openhyperlink(actor, 26, 0)
    -- lualib:FlushNpcUi(actor,"StoreRechargePanelBtn","recharge#"..VarApi.getPlayerJIntVar(actor,"J_gift_zdy866"))
end
-- 福利大厅
function MainTopBtn:WelfareHall(actor)
    if not self:CheckKFState(actor) then return end
    local npc_class = IncludeMainClass("WelfareHall")
    if npc_class then
        npc_class:onClickBtn(actor)
    end
end
-- 活动中心
function MainTopBtn:ActivityCenter(actor)
    if not self:CheckKFState(actor) then return end
    local npc_class = IncludeMainClass("ActivityCenter")
    if npc_class then
        npc_class:onClickBtn(actor)
    end
end
-- 跨服世界
function MainTopBtn:CrossServerWorld(actor)
    if not self:CheckKFState(actor) then return end
    local npc_class = IncludeMainClass("CrossWorld")
    if npc_class then
        npc_class:onClickBtn(actor)
    end
end
-- 拍卖行
function MainTopBtn:AuctionHouse(actor)
    if not self:CheckKFState(actor) then return end
    openhyperlink(actor, 27, 0)
end
-- 狂暴之力
function MainTopBtn:Rampage(actor)
    if not self:CheckKFState(actor) then return end
    local npc_class = IncludeMainClass("BerserkerPower")
    if npc_class then
        npc_class:onClickBtn(actor)
    end
end
-- 盟重令
function MainTopBtn:AllianceOrder(actor)
    if not self:CheckKFState(actor) then return end
    local npc_class = IncludeMainClass("AllianceOrder")
    if npc_class then
        npc_class:onClickBtn(actor)
    end
end
-- 首充豪礼
function MainTopBtn:FirstRechargeGift(actor)
    if not self:CheckKFState(actor) then return end
    local npc_class = IncludeMainClass("FirstRechargeGift")
    if npc_class then
        npc_class:onClickBtn(actor)
    end
end
-- 挑战boss
function MainTopBtn:ChallengeBoss(actor)
    if not self:CheckKFState(actor) then return end
    local npc_class = IncludeMainClass("ChallengeBoss")
    if npc_class then
        npc_class:onClickBtn(actor)
    end
end
-- 每日活跃
function MainTopBtn:DailyActive(actor)
    if not self:CheckKFState(actor) then return end
    local npc_class = IncludeMainClass("DailyActive")
    if npc_class then
        npc_class:onClickBtn(actor)
    end
end
--#region 专享福利
function MainTopBtn:WelfareToday(actor)
    if not self:CheckKFState(actor) then return end
    local npc_class = IncludeMainClass("WelfareToday")
    if npc_class then
        npc_class:onClickBtn(actor)
    end
end

function MainTopBtn:SuperPrivileges(actor)
    lualib:ShowNpcUi(actor, "SuperPrivilegesOBJ", "")
end

-- 跨服
function MainTopBtn:CheckKFState(actor)
    if checkkuafu(actor) then
        Sendmsg9(actor, "ff0000", "跨服区域禁止使用!", 1)
        return false
    end
    return true
end

-- 聚宝盆
function MainTopBtn:Cornucopia(actor)
    local npc_class = IncludeMainClass("Cornucopia")
    if npc_class then
        npc_class:onClickBtn(actor)
    end
    return true
end

return MainTopBtn