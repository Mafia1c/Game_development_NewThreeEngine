local Cornucopia = {}
Cornucopia.cfg=GetConfig("CornucopiaCfg")
Cornucopia.color_list = {[250]=1,[253]=2,[243]=3,[249]=4,[70]=5}
function Cornucopia:onClickBtn(actor)
    --进度
    local list = {}
    -- --限购
    -- local limit_list = {}
    for i,v in ipairs(self.cfg) do
        table.insert(list,VarApi.getPlayerUIntVar(actor,"U_jubaopen_award_"..i) )
        -- table.insert(limit_list,VarApi.getPlayerUIntVar(actor,"J_jubaopen_limit_award_"..i))
    end
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    lualib:ShowNpcUi(actor, "CornucopiaOBJ",tbl2json(list).."#"..mzl_state)
end
function Cornucopia:GetEquip(actor)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state <= 0 then
        messagebox(actor, "开通盟重令可领取\\是否现在立即前往开启盟重令", "@on_open_mzl_view", "@______")
        return  
    end
    return Sendmsg9(actor, "ff0000", "聚宝盆已领取过!", 1)
end

function Cornucopia:GetAward(actor,index)
    index = tonumber(index)
    local cfg =self.cfg[index]
    if cfg == nil then
       return Sendmsg9(actor, "ff0000", "聚宝盆数据异常!", 1)
    end
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state <= 0 then
        if  VarApi.getPlayerJIntVar(actor,"J_jubaopen_limit_award_"..index) >= cfg.time then
            messagebox(actor, "今日领取次数已满！\\开通盟重令不限次数\\是否现在立即前往开启盟重令", "@on_open_mzl_view", "@______")
            return 
        end
    end
    local progress = index == 1 and cfg.progress *60  or cfg.progress
    if  VarApi.getPlayerUIntVar(actor,"U_jubaopen_award_"..index) < progress  then
        return Sendmsg9(actor, "ff0000", cfg.tips, 1)
    end

    local weight_cfg = self.cfg[cfg.desc] 
    local result1 = ransjstr(weight_cfg.giveitem, 1, 1)
    local result_list = strsplit(result1,"#") 
    VarApi.setPlayerUIntVar(actor,"U_jubaopen_award_"..index,0,true)
    VarApi.setPlayerJIntVar(actor,"J_jubaopen_limit_award_"..index,VarApi.getPlayerJIntVar(actor,"J_jubaopen_limit_award_"..index) + 1,nil,true)
    local item_id = getstditeminfo(result_list[1], 0)
    if item_id < 10000 then
        ChangeMoney(actor,item_id,"+",tonumber(result_list[2]),"聚宝盆领取")
    else
        GiveItem(actor,result_list[1],tonumber(result_list[2]),370,"聚宝盆领取")
    end
    Sendmsg9(actor, "ff0000", string.format("恭喜获得%s*%s",result_list[1],result_list[2]),1)
    --进度
    local list = {}
    for i,v in ipairs(self.cfg) do
        table.insert(list,VarApi.getPlayerUIntVar(actor,"U_jubaopen_award_"..i) )
    end
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    lualib:FlushNpcUi(actor, "CornucopiaOBJ",tbl2json(list).."#"..mzl_state)
    if  index == 1 then
        lualib:CallFuncByClient(actor, "flush_main_top_jbp", 1)
    end
end
--设置聚宝盆任务进度
function Cornucopia:SetCornucopiaState(actor,index,color)
    index = tonumber(index)
    if index == nil then
        return
    end
    if index > 1 then
        local list = {[255]=2,[250]=3,[253]=4}
        index = list[color] 
    end
    local cfg =self.cfg[index]
    if cfg == nil then
        return 
    end
    if VarApi.getPlayerUIntVar(actor,"U_jubaopen_award_"..index) >= (index == 1 and cfg.progress * 60 or  cfg.progress) then
        return 
    end
    VarApi.setPlayerUIntVar(actor,"U_jubaopen_award_"..index,VarApi.getPlayerUIntVar(actor,"U_jubaopen_award_"..index) + 1,true)
end

function Cornucopia:CornucopiaEquipAddMonry(actor,color)
    local num = 0 
    local lc_num = 0
    local cur_day_money = VarApi.getPlayerJIntVar(actor,"J_jubaopen_money")
    local cur_day_lc = VarApi.getPlayerJIntVar(actor,"J_jubaopen_lc")
    if cur_day_money < 200000 then
        if color == 255 then
            num = math.random(1,5)
        elseif self.color_list[color]  then
            num = math.random(100,1000)
        end
        if cur_day_money + num > 200000 then
            num = 200000 - cur_day_money 
        end
        if num > 0 then
            Sendmsg9(actor, "00ff00", "击杀".. (color == 255 and "小怪" or"BOSS怪") .."获得"..num.."绑定元宝", 9)
            ChangeMoney(actor,4,"+",num,"聚宝盆装备杀怪")
            VarApi.setPlayerJIntVar(actor,"J_jubaopen_money",cur_day_money + num)
        end
    end
    if cur_day_lc < 200 then
        if self.color_list[color] then
            local add_num = self.color_list[color]
            lc_num = add_num
            if cur_day_lc + add_num > 200 then
                lc_num = 200 - cur_day_lc
            end
            Sendmsg9(actor, "00ff00", "击杀BOSS怪" .."获得"..lc_num.."累充点数", 9)
            VarApi.setPlayerJIntVar(actor,"J_jubaopen_lc",cur_day_lc + lc_num)
            VarApi.setPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE, VarApi.getPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE) + lc_num,true) -- 总充值
        end
    end
end
function on_open_mzl_view(actor)
    lualib:CloseNpcUi(actor,"CornucopiaOBJ")
    local npc_class = IncludeMainClass("MainTopBtn")
    if npc_class then
        npc_class:AllianceOrder(actor)
    end
end
function Cornucopia:CheckJbpIsGet(actor)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state <= 0 then
        return
    end
    if  GetItemByPos(actor, 106) ~= "0" then
        return 
    end
    GiveOnItem(actor,106,"聚宝盆[神器]",1,65536,"聚宝盆神器补发")
end

return Cornucopia