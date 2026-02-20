local LuckBoss = {}
LuckBoss.cfg={[1051]={21,19},[1052]={30,28},[1053]={41,37}} --#region 如意如花如玉
LuckBoss.cfg1={{"屠夫·十倍爆率"},{"酒徒·百倍爆率"},{"烂赌鬼·千倍爆率"}} --#region 单双点
LuckBoss.cfg2 = include("QuestDiary/config/LuckBossEquipCfg.lua") --#region 60-80装备 剑甲(gs)
LuckBoss.cfg3 = "鬼王#啸天战甲(男)#啸天战甲(女)#啸天战盔#啸天战链#啸天战镯#啸天战戒#啸天战带#啸天战靴#七彩魔刃#暗月魔衣(男)#暗月魔衣(女)#暗月魔盔#暗月魔链#暗月魔镯#暗月魔戒#暗月魔带#暗月魔靴#破魂剑#太玄道袍(男)#太玄道袍(女)#太玄道盔#太玄道链#太玄道镯#太玄道戒#太玄道带#太玄道靴" --#region gs用
LuckBoss.cfg5="战神项链#战神手镯#战神戒指#战神腰带#战神靴子#圣魔项链#圣魔手镯#圣魔戒指#圣魔腰带#圣魔靴子#真魂项链#真魂手镯#真魂戒指#真魂腰带#真魂靴子#奔雷项链#奔雷护腕#奔雷战戒#奔雷腰带#奔雷战靴#怒焰项链#怒焰护腕#怒焰魔戒#怒焰腰带#怒焰魔靴#极光项链#极光护腕#极光道戒#极光腰带#极光道靴#虎啸战盔#虎啸战链#虎啸战镯#虎啸战戒#虎啸战带#虎啸战靴#聚魔法冠#聚魔法链#聚魔法镯#聚魔法戒#聚魔法带#聚魔法靴#暗咒道盔#暗咒道链#暗咒道镯#暗咒道戒#暗咒道带#暗咒道靴##开天#镇天#玄天#祖玛裁决#祖玛骨玉#祖玛龙纹#神圣屠龙#神圣嗜魂#神圣逍遥扇" --#region 普通玩家

function LuckBoss:judgeTime()
    if GlobalTimer.server_run_time>7200 and GetSysInt("G200")==0  then
        return true
    end
    return false
end
function LuckBoss:getDice(actor) --#region 王富贵骰子
    if LuckBoss:judgeTime() then
        return Sendmsg9(actor, "ff0000", "活动只在开服前2小时开放！", 1)
    end
    local time=VarApi.getPlayerJIntVar(actor,"J_luckBossToday")
    if time>0 then
        return Sendmsg9(actor, "ff0000", "今日骰子已领取过！", 1)
    end
    VarApi.setPlayerJIntVar(actor,"J_luckBossToday",1,nil)
    VarApi.setPlayerUIntVar(actor,"U_luckBossDiceTime",0,nil)
    Sendmsg9(actor, "00ff00", "恭喜成功获得30次挑战次数！", 1)
end

function LuckBoss:onclick(actor,npcId) --#region 点击npc 如意如花如玉
    if LuckBoss:judgeTime() then
        return Sendmsg9(actor, "ff0000", "活动只在开服前2小时开放！", 1)
    end
    npcId=tonumber(npcId)
    if not LuckBoss.cfg[npcId] then
        return Sendmsg9(actor, "ff0000", "打开序列异常！", 1)
    end
    local openTime=GetSysInt("G_luckBoss"..npcId)
    local hasTime=0
    if openTime~=0 then
        hasTime=openTime+30-os.time()
    end
    lualib:ShowNpcUi(actor, "LuckBoss2OBJ", npcId.."#"..hasTime)
end
function LuckBoss:playDice(actor,npcId,index)
    if LuckBoss:judgeTime() then
        return Sendmsg9(actor, "ff0000", "活动只在开服前2小时开放！", 1)
    end
    npcId=tonumber(npcId)
    index=tonumber(index) --#region 选点数
    local time=VarApi.getPlayerUIntVar(actor,"U_luckBossDiceTime")
    if not self.cfg[npcId] then
        return Sendmsg9(actor, "ff0000", "数据异常1！", 1)
    elseif not isInTable({1,2,3,4,5,6},index) then
        return Sendmsg9(actor, "ff0000", "数据异常2！", 1)
    elseif VarApi.getPlayerJIntVar(actor,"J_luckBossToday")==0 and GetSysInt("G200")==0 then
        return Sendmsg9(actor, "ff0000", "今日骰子还未领取！", 1)
    elseif time>=30 and GetSysInt("G200")==0 then
        return Sendmsg9(actor, "ff0000", "今日暂无挑战次数！", 1)
    elseif os.time()-VarApi.getPlayerUIntVar(actor,"U_luckBoss_In")<6 then
        return Sendmsg9(actor, "ff0000", "当前正在游戏中！", 1)
    end

    VarApi.setPlayerUIntVar(actor,"U_luckBossDiceTime",time+1,false)
    local openTime=GetSysInt("G_luckBoss"..npcId)
    if openTime==0 then
        VarApi.setPlayerUIntVar(actor,"U_luckBoss_In",os.time()+36,false)
        SetSysInt("G_luckBoss_dice"..npcId,math.random(6))
        SetSysInt("G_luckBoss"..npcId,os.time())
        gotolabel(actor,3,"luck_boss_trigger,"..npcId,4)
        delaygoto(actor,30000,"luck_boss_jump1,"..npcId..","..index,0)
        luck_boss_trigger(actor,npcId)
    else
        VarApi.setPlayerUIntVar(actor,"U_luckBoss_In",(openTime+36),false)
        delaygoto(actor,openTime+30-os.time(),"luck_boss_jump1,"..npcId..","..index,0)
        luck_boss_trigger(actor,npcId)
    end
end

function luck_boss_trigger(player,npcId) --#region 开启附近同步时间
    lualib:FlushNpcUi(player,"LuckBoss2OBJ","time#"..(GetSysInt("G_luckBoss"..npcId)+30-os.time()))
end
function luck_boss_jump1(player,npcId,index) --#region 到时间跳转
    SetSysInt("G_luckBoss"..npcId,0)
    local dicePoint=GetSysInt("G_luckBoss_dice"..npcId)
    SetInt(0,player,"D0",dicePoint)
    SetSysInt("G_luckBoss_dice"..npcId,0)
    playdice(player,1,"@luck_boss_time_end,"..npcId..","..index..","..dicePoint)
end
function luck_boss_time_end(actor,npcId,index,dicePoint) --#region 到时间跳转
    LuckBoss:diceResult(actor,npcId,index,dicePoint)
    VarApi.setPlayerUIntVar(actor,"U_luckBoss_In",0,false)
end

function LuckBoss:diceResult(actor,npcId,index,dicePoint) --#region 出结果
    npcId=tonumber(npcId)
    index=tonumber(index)
    dicePoint=tonumber(dicePoint)
    local endPoint=dicePoint
    local equipTab= {}
    if GetSysInt("G200")>0 then
        equipTab=strsplit(LuckBoss.cfg3,"#")
    else
        equipTab=strsplit(LuckBoss.cfg5,"#")
    end

    local endTab={
        [1]=function ()
            local bossNmae="屠夫·十倍爆率"..((GetSysInt("G200")>0 and "1") or "")
            genmon("老板娘的闺房",self.cfg[npcId][1],self.cfg[npcId][2],bossNmae,2,1,249)
        end,
        [2]=function ()
            local itemName=((GetSysInt("G200")>0 and LuckBoss.cfg2[math.random(#LuckBoss.cfg2)].name) or equipTab[math.random(#equipTab)])
            throwitem(actor,"老板娘的闺房",self.cfg[npcId][1],self.cfg[npcId][2],3,itemName,1,0,true,false,false,true,1,false)
        end,
        [3]=function ()
            local bossNmae="酒徒·百倍爆率"..((GetSysInt("G200")>0 and "1") or "")
            genmon("老板娘的闺房",self.cfg[npcId][1],self.cfg[npcId][2],bossNmae,2,1,249)
        end,
        [4]=function ()
            local itemName=((GetSysInt("G200")>0 and LuckBoss.cfg2[math.random(#LuckBoss.cfg2)].name) or equipTab[math.random(#equipTab)])
            throwitem(actor,"老板娘的闺房",self.cfg[npcId][1],self.cfg[npcId][2],3,itemName,1,0,true,false,false,true,1,false)
        end,
        [5]=function ()
            local bossNmae="烂赌鬼·千倍爆率"..((GetSysInt("G200")>0 and "1") or "")
            genmon("老板娘的闺房",self.cfg[npcId][1],self.cfg[npcId][2],bossNmae,2,1,249)
        end,
        [6]=function ()
            local itemName=equipTab[math.random(#equipTab)]
            throwitem(actor,"老板娘的闺房",self.cfg[npcId][1],self.cfg[npcId][2],3,itemName,1,0,true,false,false,true,1,false)
        end,
    }
    if endTab[endPoint] then --#region 系统结算
        endTab[endPoint]()
    end

    VarApi.setPlayerUIntVar(actor,"U_luckBoss_In",0,false)
    --#region 玩家结算
    if getbaseinfo(actor,3)=="老板娘的闺房" then
        local itemName=((GetSysInt("G200")>0 and LuckBoss.cfg2[math.random(#LuckBoss.cfg2)].name) or equipTab[math.random(#equipTab)])
        throwitem(actor,"老板娘的闺房",getbaseinfo(actor,4),getbaseinfo(actor,5),1,itemName,1,0,true,false,false,true,1,false)
    end

    -- if isInTable({1,2,3,4,5,6},index) then
    --     if endPoint==index then
    --         genmon("老板娘的闺房",self.cfg[npcId][1],self.cfg[npcId][2],self.cfg1[3][1],2,1,249)
    --     else
    --         local equip=self.cfg2[math.random(#self.cfg2)].name
    --         GiveItem(actor,equip,1,370,"幸运老板娘得装备")
    --         Sendmsg9(actor, "00ff00", "猜错了哦，获得装备"..equip, 1)
    --     end
    -- elseif index==7 then
    --     if not (endPoint%2==0) then
    --         genmon("老板娘的闺房",self.cfg[npcId][1],self.cfg[npcId][2],self.cfg1[1][1],2,1,249)
    --     else
    --         local equip=self.cfg2[math.random(#self.cfg2)].name
    --         GiveItem(actor,equip,1,370,"幸运老板娘得装备")
    --         Sendmsg9(actor, "00ff00", "猜错了哦，获得装备"..equip, 1)
    --     end
    -- elseif index==8 then
    --     if (endPoint%2==0) then
    --         genmon("老板娘的闺房",self.cfg[npcId][1],self.cfg[npcId][2],self.cfg1[2][1],2,1,249)
    --     else
    --         local equip=self.cfg2[math.random(#self.cfg2)].name
    --         GiveItem(actor,equip,1,370,"幸运老板娘得装备")
    --         Sendmsg9(actor, "00ff00", "猜错了哦，获得装备"..equip, 1)
    --     end
    -- end
end

return LuckBoss