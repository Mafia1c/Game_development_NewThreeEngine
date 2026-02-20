local ChangeServer = {}
function ChangeServer:click(actor)
    local str = "[提醒]：自助转区成功以后角色立即封禁，请慎重操作\n[提醒]：不想转区的玩家请勿操作，立即退出当前NPC\n[提醒]：角色转区只能转当前账号！\n[提醒]：本功能仅限当前已开新区使用！" 
    messagebox(actor,str,"@change_server_ok")
    local path = '..\\QuestDiary\\'.. GetUserAccount(actor)..'.txt'
    local tab = getliststringex(path, 0)
    local data = {}
    if type(tab) == "table" then
        data.all_recharge = tonumber(getliststringex(path, 0)[1])  or 0
        data.yilingqu = tonumber(getliststringex(path, 1)[1]) or 0
        data.dailingqu = tonumber(getliststringex(path, 2)[1]) or 0
        data.chang_server_id = tonumber(getliststringex(path, 3)[1])  or 0
        data.get_serverid = tonumber(getliststringex(path, 4)[1]) or 0
    else
        data.all_recharge = 0
        data.yilingqu =0
        data.dailingqu =0
        data.chang_server_id = 0
        data.get_serverid = 0
    end
    local zhuanqu_data =  json2tbl(VarApi.getPlayerTStrVar(actor,"T_cache_chang_server_data")) 
    if zhuanqu_data == "" then
        zhuanqu_data = data
    end

    local recharge_value = VarApi.getPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE)
    lualib:ShowNpcUi(actor,"ChangeServerOBJ",recharge_value.."#".. tbl2json(zhuanqu_data))
end
----------------------------------------转区---------------------------------------
function ChangeServer:OnClickChangeServer(actor)
    local change_server_data =  json2tbl(VarApi.getPlayerTStrVar(actor,"T_ChangeServer_data")) 
    if change_server_data ~= "" then
        messagebox(actor,"你当前有转区额度尚未领取，是否继续进行转区操作!","@check_change_1","@not_change")
        return
    end
    self:CheckRecharge(actor)
end

function ChangeServer:CheckRecharge(actor)
    local recharge = VarApi.getPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE)
    if recharge < 500 then
        return Sendmsg9(actor, "ffffff", "您当前充值低于500元，转区失败！", 1) 
    end
    messagebox(actor,string.format("确认转区后当前角色数据立即删除！\n当前账号可转区额度：%s元\n是否确认转区，该操作不可逆!",recharge) ,"@check_change_2","@not_change")
end

function ChangeServer:OnChangeServer(actor)
    local recharge = VarApi.getPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE)
    if recharge < 500 then
        return  Sendmsg9(actor, "ffffff", "您当前充值低于500元，转区失败！", 1) 
    end
    local change_data = {}
    change_data.all_recharge = recharge
    change_data.yilingqu = 0
    change_data.dailingqu = recharge
    change_data.chang_server_id = GetServerIDX()
    change_data.get_serverid = 0
    local path = '..\\QuestDiary\\'.. GetUserAccount(actor)..'.txt'
    addtextlist(path, recharge, 0)
    addtextlist(path, 0, 1)
    addtextlist(path, recharge, 2)
    addtextlist(path, GetServerIDX(), 3)
    addtextlist(path, 0, 4)

    tongupload(100, GetUserAccount(actor)..'.txt', GetUserAccount(actor)..'.txt')
    local role_name = getbaseinfo(actor,1)

    local chang_server_log = GetSysStr("A_chang_server_log")
    if "" == chang_server_log then
        chang_server_log = {}
    else
        chang_server_log = json2tbl(chang_server_log)
    end
    chang_server_log[#chang_server_log+1] = string.format("[%s]已转区,角色id[%s],账号id[%s],转区id[%s]",role_name,getbaseinfo(actor,2),GetUserAccount(actor),GetServerIDX())
    SetSysStr("A_chang_server_log",tbl2json(chang_server_log))
    gmexecute("0","DenyCharNameLogon",role_name,1)
    delaygoto(actor,2000,"change_server_quit",0)
end
function change_server_quit(actor)
    openhyperlink(actor,34)
end
function check_change_1(actor)
    local class = IncludeNpcClass("ChangeServer")
    if class then
        class:CheckRecharge(actor)
    end
end

function check_change_2(actor)
    local class = IncludeNpcClass("ChangeServer")
    if class then
        class:OnChangeServer(actor)
    end
end 

--------------------领取----------------
function ChangeServer:OnClickGet(actor)
    local recharge = VarApi.getPlayerUIntVar(actor, VarUIntDef.TRUE_RECHARGE)
    if recharge <= 0 then
        return Sendmsg9(actor, "ffffff", "没有可领取的转区金额", 1)
    end
    local data = {}
    data.all_recharge = 0
    data.yilingqu = 0
    data.dailingqu = 0
    data.chang_server_id = 0
    data.get_serverid = 0

    local zhuanqu_data =  json2tbl(VarApi.getPlayerTStrVar(actor,"T_cache_chang_server_data")) 
    local path = '..\\QuestDiary\\'.. GetUserAccount(actor)..'.txt'
    local is_clearn = false
    if zhuanqu_data ~= "" then
        data = zhuanqu_data
        is_clearn = true
    else
        local tab = getliststringex(path, 0)
        if type(tab) == "table" and tonumber(tab[1]) then
            data.all_recharge = tonumber(getliststringex(path, 0)[1])  or 0
            data.yilingqu = tonumber(getliststringex(path, 1)[1]) or 0
            data.dailingqu = tonumber(getliststringex(path, 2)[1]) or 0
            data.chang_server_id = tonumber(getliststringex(path, 3)[1])  or 0
            data.get_serverid = tonumber(getliststringex(path, 4)[1]) or 0
            is_clearn = true
        end
    end

    if data == nil or data == "" or  data.dailingqu <=0 then
        return Sendmsg9(actor, "ffffff", "没有可领取的转区金额", 1)
    end
    if recharge < 100 then
        return Sendmsg9(actor, "ffffff", "最低充值100可领！", 1)
    end

    if data.get_serverid ~= 0 and data.get_serverid ~= GetServerIDX() then
        return Sendmsg9(actor, "ffffff", "你已在其他区服领取过！", 1)
    end

    if data.chang_server_id ~= 0 and data.chang_server_id == GetServerIDX() then
        return Sendmsg9(actor, "ffffff", "相同区无法领取，请前往新区！", 1)
    end
    local merge_count = GetSysInt(VarEngine.HeFuCount)              -- 合服次数
    if merge_count > 0 then
        return Sendmsg9(actor, "ffffff", "该区服已经合区，无法领取转区金额！", 1)
    end
    local get_value = recharge - data.yilingqu
    if get_value > data.dailingqu then
        get_value = data.dailingqu
    end
    SendMail(actor, 1, "自助转区", "恭喜你成功领取转区充值，请查收！\\领取元宝"..get_value *500, "元宝#"..get_value*500)
    local change_data = {}
    change_data.all_recharge = data.all_recharge
    change_data.yilingqu = data.yilingqu + get_value
    change_data.chang_server_id = data.chang_server_id
    change_data.dailingqu = data.dailingqu - get_value
    change_data.get_serverid = GetServerIDX()
    VarApi.setPlayerTStrVar(actor,"T_cache_chang_server_data",tbl2json(change_data))
    if is_clearn then
        clearnamelist(path)
        tongupload(100, GetUserAccount(actor)..'.txt', GetUserAccount(actor)..'.txt')
    end
    local get_chang_server_log = GetSysStr("A_get_change_server_log")
    if "" == get_chang_server_log then
        get_chang_server_log = {}
    else
        get_chang_server_log = json2tbl(get_chang_server_log)
    end
    get_chang_server_log[#get_chang_server_log+1] =string.format("[%s]领取[%s],角色id[%s],账号id[%s],区服id[%s]",getbaseinfo(actor,1),get_value,getbaseinfo(actor,2),GetUserAccount(actor),GetServerIDX()) 
    SetSysStr("A_get_change_server_log",tbl2json(get_chang_server_log))

    lualib:FlushNpcUi(actor,"ChangeServerOBJ",tbl2json(change_data))
end
return ChangeServer