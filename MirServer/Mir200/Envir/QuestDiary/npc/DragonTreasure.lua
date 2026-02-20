local DragonTreasure = {}
DragonTreasure.cfg = GetConfig("DragonTreasureCfg")
DragonTreasure.money_buy_num = 50000
DragonTreasure.count_award = {20,50,100,300,500}
function DragonTreasure:click(actor)
    if CheckOpenState(actor, 1) then return end
    local merge_count = GetSysInt(VarEngine.HeFuCount)
    local day_count = VarApi.getPlayerJIntVar(actor,"J_dragon_day_count")
    local day_limit_count = VarApi.getPlayerJIntVar(actor,"J_dragon_day_limit_count")
    lualib:ShowNpcUi(actor,"DragonTreasureOBJ",merge_count.."#"..day_count.."#"..day_limit_count)
end
function DragonTreasure:FindTreasureClick(actor,index)
    if CheckOpenState(actor, 1) then return end
    index = tonumber(index)
    local num = index == 1 and 1 or 10
    if getbagitemcount(actor, "黄金钥匙",0) < num then
       return Sendmsg9(actor, "ffffff", "寻宝需要 【黄金钥匙x"..num.."】", 1) 
    end
    if not takeitem(actor,"黄金钥匙",num,0,"寻龙宝藏扣除") then
        return Sendmsg9(actor, "ffffff", "黄金钥匙 扣除失败", 1) 
    end
    local reward_str = "" 
    --时装奖励
    local common_award_count = VarApi.getPlayerUIntVar(actor,"U_dragon_treasure_all_count")
    local day_count = VarApi.getPlayerJIntVar(actor,"J_dragon_day_count")
    local first_fashion_flag = VarApi.getPlayerUIntVar(actor,"U_dragon_fashion_first_flag")
    if common_award_count >= 1000 then
        local is_give_fashion = false
        if first_fashion_flag >= 1 and math.random(1000) <= 1 then
            is_give_fashion = true
        elseif first_fashion_flag <= 0 and math.random(100) <= 30 then
            is_give_fashion = true
            VarApi.setPlayerUIntVar(actor,"U_dragon_fashion_first_flag",1)
        end
        if is_give_fashion then
            reward_str = "[时装激活卡]独孤求败#1#370&"
        end
    end

    local merge_count = GetSysInt(VarEngine.HeFuCount)
    local cfg = self.cfg[(merge_count >9 and 9 or merge_count)]
    local weight_cfg = getWeightedCfg(cfg.weight)
    local list = {}
    local reward_cfg = strsplit(cfg.reward_list,"|")
  
    for i = 1, num do
        local value = weightedRandom(weight_cfg).value
        table.insert(list,value)
        local data  = strsplit(reward_cfg[value],"#")
        reward_str = reward_str .. data[1] .. "#" .. data[2] .. "#370&"
    end
    reward_str = reward_str .."仙石#"..num.."#370"
   
    Gives(actor,reward_str,"寻龙宝藏获得")
    local show_award_str = string.gsub(reward_str,"&","|")
    ShowReward.showReward(actor, show_award_str, 0)

    common_award_count = common_award_count + num
    day_count = day_count + num

    
    --进度奖励
    local jindu_data = VarApi.getPlayerZStrVar(actor,"Z_dragon_jindu_flag")
    if jindu_data == "" then
        jindu_data = {}
    else
        jindu_data = json2tbl(jindu_data)
    end
    for i,v in ipairs(strsplit(cfg.jindu_reward_list,"|")) do
        local data = strsplit(v,"#")
        if day_count >= self.count_award[i] and not self:GetJinduIsGet(actor,i) then
            SendMail(actor,20,string.format("寻宝%s次奖励",self.count_award[i]),string.format("你今日开启寻龙宝藏达到<【%s次】/FCOLOR=251>,以下是奖励详情！",self.count_award[i]),data[1].."#"..data[2].."#370"  )
            table.insert(jindu_data,i)
        end
    end
    if num <= 1 then
        local data  = strsplit(reward_cfg[list[1]],"#")
        sendmsgnew(actor,255,0,"<寻龙宝藏：/FCOLOR=251>恭喜: <『"..getbaseinfo(actor,1).."』/FCOLOR=254>寻宝获得：<"..data[1].."x"..data[2].."/FCOLOR=250>!", 1, 1)
    else
        sendmsgnew(actor,255,0,"<寻龙宝藏：/FCOLOR=251>恭喜: <『"..getbaseinfo(actor,1).."』/FCOLOR=254>寻宝获得：<大量宝藏/FCOLOR=250>!", 1, 1)
    end
    VarApi.setPlayerJIntVar(actor,"J_dragon_day_count",day_count)
    VarApi.setPlayerZStrVar(actor,"Z_dragon_jindu_flag",tbl2json(jindu_data))
    VarApi.setPlayerUIntVar(actor,"U_dragon_treasure_count",common_award_count)
    lualib:FlushNpcUi(actor,"DragonTreasureOBJ","lottery_flush#"..tbl2json(list).."#"..day_count)
end

function DragonTreasure:BuyClick(actor,num,is_recharge_flag)
    if CheckOpenState(actor, 1) then return end
    num = tonumber(num) 
    if 10 ~= num and 1 ~= num then
       return  Sendmsg9(actor, "ffffff", "购买次数异常", 1) 
    end
    is_recharge_flag = tonumber(is_recharge_flag)
    if is_recharge_flag > 0 then
        local day_limit_count = VarApi.getPlayerJIntVar(actor,"J_dragon_day_limit_count")
        if day_limit_count >= 10 then
           return Sendmsg9(actor, "ffffff", "今天无购买次数！", 1) 
        end
        if IncludeMainClass("Recharge") then
            IncludeMainClass("Recharge"):showType(actor,"gift_xlbz",num,"DragonTreasureOBJ") --#region 礼包名,次数,前端obj
        end
    else
        local cur_count =  querymoney(actor, 2)
        if cur_count < (num * self.money_buy_num) then
            return  Sendmsg9(actor, "FF0000", "非绑定元宝不足！", 1) 
        end
        
        if not ChangeMoney(actor,2,"-",num * self.money_buy_num,"寻龙宝藏 购买钥匙扣除") then
            return  Sendmsg9(actor, "FF0000", "非绑定元宝扣除失败！", 1) 
        end
        GiveItem(actor,"黄金钥匙",num*10,370,"寻龙宝藏 元宝购买",true)
        GiveItem(actor,"洛克之羽",num,370,"寻龙宝藏 元宝购买")
        lualib:FlushNpcUi(actor,"DragonTreasureOBJ","buy_flush")
    end
end

function DragonTreasure:GetJinduIsGet(actor,index)
    local data = VarApi.getPlayerZStrVar(actor,"Z_dragon_jindu_flag")
    if data == "" then
       return false 
    else
        data = json2tbl(data)
    end
    return data[index] ~= nil
end
return DragonTreasure