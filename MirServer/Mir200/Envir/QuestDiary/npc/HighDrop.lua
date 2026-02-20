local HighDrop = {}
HighDrop.temp_cfg = GetConfig("HighDropCfg")
HighDrop.cfg = {}
for i,v in ipairs(HighDrop.temp_cfg) do
    local show_mapid = tostring(v.show_mapid)
    HighDrop.cfg[show_mapid] = HighDrop.cfg[show_mapid] or {}
    table.insert(HighDrop.cfg[show_mapid],v)
end
HighDrop.ItemIds = {11345,11346,11347,11348,11349,11350}

function HighDrop:click(actor, item_id)
    lualib:ShowNpcUi(actor,"HighDropOBJ",  item_id)
end
function HighDrop:EnterHigtDrop(actor, item_id)
    local use_item = GetTempInt(0, actor, "UTemp_use_item_id")
    item_id = tonumber(item_id)
    if not isInTable(self.ItemIds, item_id) or use_item ~=  item_id then
        Sendmsg9(actor, "ff0000", "非法传参!", 9)
        return
    end

    local map_id = getbaseinfo(actor,3)
    local rate_index = indexOfTable(self.ItemIds, item_id)
    local cfg = nil
    if map_id == "3" or map_id == "bairi" or map_id == "4" then
        cfg = self.cfg[map_id][rate_index]
    end

    if cfg == nil then
        return Sendmsg9(actor, "ff0000", "请先返回安全区！", 1)
    end
    
    if rate_index == nil  then
        return Sendmsg9(actor, "ff0000", "高爆地图数据异常！", 1)
    end

    if getbagitemcount(actor, cfg.needitem_arr[1],0) <  cfg.needitem_arr[2] then
       return  Sendmsg9(actor, "ff0000",string.format("需要%sX%s！",cfg.needitem_arr[1],cfg.needitem_arr[2])  , 1)    
    end
    if kuafuconnected() then
        if not takeitem(actor,cfg.needitem_arr[1],cfg.needitem_arr[2],0,"高爆地图进入扣除") then
            return  Sendmsg9(actor, "ff0000",cfg.needitem_arr[1].."扣除失败！" , 1)    
        end
        lualib:CloseNpcUi(actor,"HighDropOBJ")
        map(actor,cfg.kfmapid)
    else
        if map_id ~= "3" then
            return Sendmsg9(actor, "ff0000", "请前往盟重省使用！", 1)
        end

        if not takeitem(actor,cfg.needitem_arr[1],cfg.needitem_arr[2],0,"高爆地图进入扣除") then
            return  Sendmsg9(actor, "ff0000",cfg.needitem_arr[1].."扣除失败！" , 1)    
        end

        lualib:CloseNpcUi(actor,"HighDropOBJ")
        map(actor,cfg.mapid)
    end
    SetTempInt(0, actor, "UTemp_use_item_id", 0)
end
return HighDrop