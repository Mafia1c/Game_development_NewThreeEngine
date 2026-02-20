local CourierNpc = {}
function CourierNpc:onClickCourier(actor, key)
    local map_names = {
        ["map_tjp"] = "0159",
        ["map_bld"] = "0149",
        ["map_ssd"] = "0158",
        ["map_kz"] = "0148",
        ["map_mf"] = "0160",
    }
    local cur_mapid = getbaseinfo(actor, 3)
    local map_id = map_names[key]
    if nil == map_id or cur_mapid ~= "3" then
        Sendmsg9(actor, "ff0000", "Êý¾ÝÒì³£!", 1)
        return
    end
    map(actor, map_id)
    lualib:CloseNpcUi(actor, "CourierOBJ")
end

return CourierNpc