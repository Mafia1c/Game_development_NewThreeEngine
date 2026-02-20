local MapCruise = {}
MapCruise.cfg = GetConfig("CanMapCruiseCfg")

function MapCruise:click(actor)
    if checkkuafu(actor) then
       return  Sendmsg9(actor, "ffffff", "跨服无法打开!", 1)  
    end
    local map_cruise_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_map_cruise_info"))
    local cruise_state = VarApi.getPlayerUIntVar(actor,"U_map_cruise_state")
    if map_cruise_info == "" then
        map_cruise_info = {}
        map_cruise_info.map_info = {map_ids ={-1,-1,-1},map_name = {"","",""}}
        map_cruise_info.setting_info = {0,0,0}
    end
     local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    lualib:ShowNpcUi(actor, "MapCruiseOBJ", tbl2json(map_cruise_info).."#"..cruise_state.."#"..mzl_state)
end
function MapCruise:SetCruiseState(actor)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state  <= 0  then
        Sendmsg9(actor, "ffffff", "开通盟重令可享受无限挂机特权!", 1)  
        return 
    end
    local cruise_state = VarApi.getPlayerUIntVar(actor,"U_map_cruise_state")
    if cruise_state > 0 then  --停止巡航
        self:StopMapCruise(actor,true)
    else  --开始巡航
        self:StartMapCruise(actor,true)
    end
    cleardelaygoto(actor,"map_cruise_jump")
end
--停止巡航
function MapCruise:StopMapCruise(actor,is_flush_view)
    VarApi.setPlayerUIntVar(actor,"U_map_cruise_state",0)
    if is_flush_view then
        lualib:FlushNpcUi(actor,"MapCruiseOBJ","state_flush#"..0)
    end
end
--开始巡航
function MapCruise:StartMapCruise(actor,is_flush_view)
    local mzl_state = VarApi.getPlayerUIntVar(actor, VarUIntDef.ZSTQ_LEVEL)
    if mzl_state  <= 0  then
        Sendmsg9(actor, "ffffff", "开通盟重令可享受无限挂机特权!", 1)  
        return 
    end
    
    if not self:MoveMapCruise(actor) then
        return 
    end
    VarApi.setPlayerUIntVar(actor,"U_map_cruise_state",1)
    if is_flush_view then
        lualib:FlushNpcUi(actor,"MapCruiseOBJ","state_flush#"..1)
    end
end

function MapCruise:MoveMapCruise(actor)
    local map_cruise_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_map_cruise_info"))
    if map_cruise_info == "" then
        Sendmsg9(actor, "ffffff", "请先记录巡航地图!", 1)  
        return false
    end
    local list = {}
    for i,v in ipairs(map_cruise_info.map_info.map_ids) do
        if v ~= "" then
            table.insert(list,v)
        end
    end
    if #list  == 0 then
        Sendmsg9(actor, "ffffff", "请先记录巡航地图!", 1)  
        return false
    end
    local map_id = list[math.random(1,#list)]
    if self.cfg[map_id] == nil then
        Sendmsg9(actor, "ffffff", "当前地图不允许巡航!", 1)  
        return  false
    end
    local checkmapid = self.cfg[map_id].checkmapid
    local class = IncludeNpcClass("MapMoveNpc")
    if class then
        local npc_id = class:checkRecordNpcId(actor, checkmapid)
        if npc_id == nil then
            Sendmsg9(actor, "ff0000", "不满足巡航条件，巡航终止!", 1)  
            return false
        end
        if class:onMove(actor, npc_id,nil,nil,nil,99999) then
            map(actor, map_id)
            startautoattack(actor)
            return true 
        end
    end
    Sendmsg9(actor, "ff0000", "不满足巡航条件，巡航终止!", 1)  
    return false
end
function MapCruise:RecordClick(actor,index)
    index = tonumber(index)
    local map_cruise_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_map_cruise_info"))
    if map_cruise_info == "" then
        map_cruise_info = {}
        map_cruise_info.map_info = {map_ids ={"","",""},map_name = {"","",""}}
        map_cruise_info.setting_info = {0,0,0}
    end
    if map_cruise_info.map_info.map_ids[index] ~= "" then  --清空记录
        if map_cruise_info.map_info.map_ids[index] == getbaseinfo(actor,3) then
            Sendmsg9(actor, "ffffff", "当前正在此地图巡航，不可清空!", 1)  
            return  
        end
        map_cruise_info.map_info.map_ids[index] = ""
        map_cruise_info.map_info.map_name[index] = ""
        VarApi.setPlayerTStrVar(actor,"T_map_cruise_info",tbl2json(map_cruise_info) )
    else  --记录
        local map_id = getbaseinfo(actor,3)
        if MapCruise.cfg[map_id] == nil then
            return Sendmsg9(actor, "ffffff", "当前地图不允许巡航!", 1)  
        end
        for i,v in ipairs(map_cruise_info.map_info.map_ids) do
            if map_id == v then
               return Sendmsg9(actor, "ffffff", "当前地图已在巡航记录中!", 1)  
            end
        end
        map_cruise_info.map_info.map_ids[index] = map_id
        map_cruise_info.map_info.map_name[index] = getbaseinfo(actor,45)
        VarApi.setPlayerTStrVar(actor,"T_map_cruise_info",tbl2json(map_cruise_info) )
    end
    lualib:FlushNpcUi(actor,"MapCruiseOBJ","record_flush#"..tbl2json(map_cruise_info))
end
---------------------------------设置项------------------------------------------------------

--继续巡航
function MapCruise:CheckContinueCruise(actor,map_id)
    if VarApi.getPlayerUIntVar(actor,"U_map_cruise_state") <= 0 then
        return 
    end
    if not isInTable({"3","bairi","cangyue","4","xueyuan","n6"},map_id) then
        return
    end
    -- if not getbaseinfo(actor,48)  then
    --     VarApi.setPlayerUIntVar(actor,"U_map_cruise_state",0) 
    --     Sendmsg9(actor, "ff0000", "退出巡航地图，巡航终止!", 1)
    --     return
    -- end
    delaygoto(actor,5000,"map_cruise_jump",0)
end
function map_cruise_jump(actor)
    if VarApi.getPlayerUIntVar(actor,"U_map_cruise_state") <= 0 then
        return 
    end
    lualib:ShowNpcUi(actor,"MapCruiseTipOBJ") 
end
function MapCruise:SetSettingClick(actor,index)
    index = tonumber(index)
    local map_cruise_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_map_cruise_info"))
    if map_cruise_info == "" then
        map_cruise_info = {}
        map_cruise_info.map_info = {map_ids ={-1,-1,-1},map_name = {"","",""}}
        map_cruise_info.setting_info = {0,0,0}
    end
    if map_cruise_info.setting_info[index] and map_cruise_info.setting_info[index] > 0 then  --取消勾选
        map_cruise_info.setting_info[index] = 0
    else
        map_cruise_info.setting_info[index] = 1
    end
    VarApi.setPlayerTStrVar(actor,"T_map_cruise_info",tbl2json(map_cruise_info))
    lualib:FlushNpcUi(actor,"MapCruiseOBJ","record_flush#"..tbl2json(map_cruise_info))
end
function MapCruise:CheckCanRandomMap(actor)
    if VarApi.getPlayerUIntVar(actor,"U_map_cruise_state") <= 0  then
        return
    end
    local map_cruise_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_map_cruise_info"))
    local setting_info = {}
    if map_cruise_info ~= "" and map_cruise_info.setting_info then
        setting_info = map_cruise_info.setting_info
    end
    local map_id = getbaseinfo(actor,3)
    local timestamp = VarApi.getPlayerUIntVar(actor,"U_map_cruise_not_mon_cd_timestamp") 
    if getmoncount(map_id,-1,true) <= 0 and setting_info[3] > 0 and os.time() - timestamp > 30 then
        self:RandomMoveMap(actor)
    end
end
function MapCruise:RandomMoveMap(actor)
    local map_cruise_info = json2tbl(VarApi.getPlayerTStrVar(actor,"T_map_cruise_info"))
    if map_cruise_info == "" then
        return
    end
    local list = {}
    for i,v in ipairs(map_cruise_info.map_info.map_ids) do
        if v ~= "" then
            table.insert(list,v)
        end
    end
    if #list <= 0 then
        VarApi.setPlayerUIntVar(actor,"U_map_cruise_state",0)
        Sendmsg9(actor, "ff0000", "没有可随机地图，巡航终止!", 1)
        return 
    end
    if not self:MoveMapCruise(actor) then
        VarApi.setPlayerUIntVar(actor,"U_map_cruise_state",0)
        return 
    end
    VarApi.setPlayerUIntVar(actor,"U_map_cruise_not_mon_cd_timestamp",os.time()) 
end
return MapCruise