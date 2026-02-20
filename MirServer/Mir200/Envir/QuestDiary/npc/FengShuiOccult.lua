local FengShuiOccult = {}
FengShuiOccult.cfg =GetConfig("FengShuiOccultCfg")
FengShuiOccult.suit_cfg =GetConfig("FengShuiOccultSuitCfg")
FengShuiOccult.cfg_map = {}
for i,v in ipairs(FengShuiOccult.cfg) do
	FengShuiOccult.cfg_map[v.npc_id] = v 
end
function FengShuiOccult:click(actor)
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_occult_level")) 
    if data == "" then
        data = {}
        for i = 1, 16 do
            data[i] = 0
        end
        VarApi.setPlayerTStrVar(actor,"T_occult_level",tbl2json(data),true)
    end
    lualib:ShowNpcUi(actor,"FengShuiOccultOBJ",tbl2json(data))
end
function FengShuiOccult:UnLockClick(actor)
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_occult_level")) 
    if data == "" then
        data = {}
        for i = 1, 16 do
            data[i] = 0
        end
        VarApi.setPlayerTStrVar(actor,"T_occult_level",tbl2json(data),true)
    end
    if self:GetActiveNum(actor) + 1 > #self.cfg then
        Sendmsg9(actor, "ff00ff","你已解封所有秘术，可喜可贺，强者自强，牛逼！", 1)  
        Sendmsg9(actor, "00ff00","你已解封所有秘术，可喜可贺，强者自强，牛逼！", 1)  
        Sendmsg9(actor, "ff0000","你已解封所有秘术，可喜可贺，强者自强，牛逼！", 1)  
        Sendmsg9(actor, "ffff00","你已解封所有秘术，可喜可贺，强者自强，牛逼！", 1)  
        return  
    end
    if getbagitemcount(actor,"罗盘",0) <= 0 then
        return Sendmsg9(actor, "ffffff","解封秘术需要：<font color=\'#ff0000\'>罗盘X1</font>！", 1)  
    end
    lualib:CloseNpcUi(actor,"FengShuiOccultOBJ")
    lualib:ShowNpcUi(actor,"FengShuiOccultActiveOBJ",tbl2json(data))
end
function FengShuiOccult:LotteryClick(actor)
    if self:GetActiveNum(actor) + 1 > #self.cfg then
        Sendmsg9(actor, "ff00ff","你已解封所有秘术，可喜可贺，强者自强，牛逼！", 1)  
        Sendmsg9(actor, "00ff00","你已解封所有秘术，可喜可贺，强者自强，牛逼！", 1)  
        Sendmsg9(actor, "ff0000","你已解封所有秘术，可喜可贺，强者自强，牛逼！", 1)  
        Sendmsg9(actor, "ffff00","你已解封所有秘术，可喜可贺，强者自强，牛逼！", 1)  
        return  
    end
 
    if getbagitemcount(actor,"罗盘",0) <= 0 then
        return Sendmsg9(actor, "ff0000","解封秘术需要：<font color=\'#ff0000\'>罗盘X1</font>！", 1)  
    end
    if not takeitem(actor,"罗盘",1,0,"风水秘术扣除") then
        return Sendmsg9(actor, "ff0000","罗盘扣除失败！", 1)  
    end
    delaygoto(actor,2900,"@startlottey_fun")

end
function startlottey_fun(actor)
    local sure_flag = 0
    local reward = ""
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_occult_level")) 
    if data == "" then
        data = {}
        for i = 1, 16 do
            data[i] = 0
        end
        VarApi.setPlayerTStrVar(actor,"T_occult_level",tbl2json(data),true)
    end
    local frist_flag = VarApi.getPlayerUIntVar(actor,"U_occult_first_flag")
    local index = 0
    for i,v in ipairs(data) do
        if v <= 0 then
            index = i
            break 
        end
    end 
    local cfg = FengShuiOccult.cfg[index]
        if frist_flag <= 0 then
        reward = cfg.name
        VarApi.setPlayerUIntVar(actor,"U_occult_first_flag",1)
    else
        reward = ransjstr(cfg.weight,0,2)
    end
    for i,v in ipairs(FengShuiOccult.cfg) do
        if reward == v.name then
            sure_flag = 1
            break
        end
    end
    if sure_flag == 0 then
        lualib:CallFuncByClient(actor, "screffects", 14843)
        local award_tab = strsplit(reward,"#")
        local std_mode = getstditeminfo(award_tab[1],2)
        if std_mode == 41 then
            ChangeMoney(actor,getstditeminfo(award_tab[1],0),"+",tonumber(award_tab[2]),"风水秘术解封失败补偿")
        else
            GiveItem(actor,award_tab[1],tonumber(award_tab[2]),0,"风水秘术解封失败补偿")
        end
        Sendmsg9(actor, "ff0000","解封失败，系统补偿："..reward, 1)  
        reward = ""
    else
        lualib:CallFuncByClient(actor, "screffects", 14842)
        data[cfg.key_name] = 1
        VarApi.setPlayerTStrVar(actor,"T_occult_level",tbl2json(data),true)
        FengShuiOccult:FlushOccultAttr(actor)
    end
    lualib:FlushNpcUi(actor,"FengShuiOccultActiveOBJ","reward_flush#".. tbl2json(data).."#"..reward) 

end
function FengShuiOccult:FlushOccultAttr(actor)
    local num =  self:GetActiveNum(actor)
    delbuff(actor,60116)
   
    local str = string.format("3#30#%s|3#3#%s|3#4#%s|3#5#%s|3#6#%s|3#7#%s|3#8#%s|3#9#%s|3#10#%s|3#11#%s|3#12#%s",num*1,num*1,num*1,num*1,num*1,num*1,num*1,num*1,num*1,num*1,num*1) 
    local attr_tab = ParserAttrStrToTable(str)
    addbuff(actor,60116,0,1,actor,attr_tab)
    delbuff(actor,60117)
    local suit_attr = ""
    for i,v in ipairs(self.suit_cfg) do
        if num >= v.active_num and i ~= 6 then
            suit_attr = suit_attr .. "|"..v.attr_str
        end
    end
    local attr_tab2 = ParserAttrStrToTable(suit_attr)
    addbuff(actor,60117,0,1,actor,attr_tab2)
end

function FengShuiOccult:GetActiveNum(actor)
    local data = json2tbl(VarApi.getPlayerTStrVar(actor,"T_occult_level")) 
    if data == "" then
        return 0
    end
    local num = 0
    for i,v in ipairs(data) do
        if v > 0 then
            num = num + 1
        end
    end
    return num
end
return FengShuiOccult