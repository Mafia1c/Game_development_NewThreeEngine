TitleTrigger = {}
TitleTrigger.iconTab0 = {["星爵"]={14217,-5,0},["子爵"]={14218,-5,0},["男爵"]={14219,-5,0},["伯爵"]={14220,-5,0},["侯爵"]={14221,-5,0},
["公爵"]={14222,-5,0},["王爵"]={14223,-5,0},["皇爵"]={14224,-5,0},["亲王"]={14225,-5,0},["君主"]={14226,-5,0},["神皇"]={14227,-5,0},
["大帝"]={14228,-5,0},["超级大满贯·顶"] = {14149,0,0},["逍遥"] = {14095,0,0},["斜月三星"] = {14096,0,0},["来啊快活啊"] = {14153,0,0},
["拔刀斩苍穹"] = {14162,0,0},["血影弑魂夜"] = {14161,0,0},["舍我其谁"] = {14159,0,0},["大神豪"]={14148,0,0},["白银特权"]={14078, 0,0},
["黄金特权"]={14079, 0,0},["钻石特权"]={14081, 0,0},["冠名特权"]={14083, 0,0},
}

local _cfg = GetConfig("MaFaLiLianCfg")
for index, v in ipairs(_cfg) do
    if v.chreward then
        local title = v.chreward
        TitleTrigger.iconTab0[title] = {v.effectid, 0, 0}
    end
end

--#region 称号改变触发(玩家对象，称号道具id)添加,更改
function TitleTrigger.onTitlechangedex(actor,titleIdx)
    local titleName = getstditeminfo(titleIdx, 1) --#region 称号道具名
    local cfg = TitleTrigger.iconTab0[titleName]
    if cfg then --#region 0号位顶戴
        local infoTab = cfg
        seticon(actor, infoTab[4] or 0, 1, infoTab[1], infoTab[2], infoTab[3], 0, 0, 0)
    else
        seticon(actor, 0, -1)
    end
    -- 存名字就可以了  偏移值通过 TitleTrigger.iconTab0[name] 获取
    VarApi.setPlayerTStrVar(actor,VarTStrDef.ICON_0, titleName, true)
end

--#region 称号取消触发(玩家对象，称号道具id)取消穿戴,删除
function TitleTrigger.onUntitledex(actor,titleIdx)
    local titleName = getstditeminfo(titleIdx, 1) --#region 称号道具名
      --#region 取消顶戴
    local cfg = TitleTrigger.iconTab0[titleName]
    if cfg then --#region 0号位顶戴
        seticon(actor, cfg[4] or 0, -1)
    end
    VarApi.setPlayerTStrVar(actor, VarTStrDef.ICON_0, "", true)
end