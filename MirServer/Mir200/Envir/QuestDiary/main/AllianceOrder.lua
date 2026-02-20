local AllianceOrder = {}

function AllianceOrder:onClickBtn(actor)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    local gift_info = tbl2json({"元宝*68000", "[时装激活卡]齐天大圣*1", "天命石*9","书页*100","五行精华*88","转生凭证*28","秘境卷轴*18"})
    local eff_id = 17046
    if GetSysInt("G200") > 0 then
        gift_info = tbl2json({"元宝*68000","[时装激活卡]轮椅战神*1","天命石*9","书页*100","五行精华*88","转生凭证*28","秘境卷轴*18"})
        eff_id = 12777
    end
    lualib:ShowNpcUi(actor, "AllianceOrderOBJ",mzl_state .. "#" .. gift_info .. "#"..eff_id)
    TaskTrigger.CompleteTask(actor, 21)
end

-- 激活盟重令
function AllianceOrder:onClickActivate(actor)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state ~= 0 then
        Sendmsg9(actor, "ffffff", "你已激活盟重令特权!", 1)
        return
    end
    if IncludeMainClass("Recharge") then
        IncludeMainClass("Recharge"):showType(actor,"gift_mzl",1,"AllianceOrderOBJ") --#region 礼包名,次数,前端obj
    end
end

function AllianceOrder:UpdateAllianceOrderUI(actor)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    lualib:FlushNpcUi(actor, "AllianceOrderOBJ", "recharge#"..mzl_state)
end

return AllianceOrder