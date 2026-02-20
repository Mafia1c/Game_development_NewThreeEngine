local MapCruiseOBJ = {}
MapCruiseOBJ.Name = "MapCruiseOBJ"
MapCruiseOBJ.NpcId = 1001

function MapCruiseOBJ:main(cruise_info,cruise_state,mzl_state)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/MapCruiseUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    local cruise_info = SL:JsonDecode(cruise_info) or {} 
    self.map_info = cruise_info.map_info or {}
    self.setting_info = cruise_info.setting_info or {}
    self.cruise_state = tonumber(cruise_state) or 0
    self.mzl_state = tonumber(mzl_state) or 0
    self:initClickEvents()
    self:UpdaViewInfo()
end

function MapCruiseOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("MapCruiseOBJ")
    end)

    GUI:addOnClickEvent(self.ui.cruise_state_btn, function()
        if self.mzl_state <= 0 then
            ViewMgr.open("OpenMzlTipOBJ") 
            return 
        end
        if self.cruise_state <= 0 then --开始巡航
            local can_cruise = false
            for i,v in ipairs(self.map_info.map_name) do
                if v ~= "" then
                    can_cruise = true
                end
            end 
            if not can_cruise then 
                SL:ShowSystemTips("请先设置巡航地图！")
                return
            end 
            ViewMgr.close("MapCruiseOBJ")
            ViewMgr.open("MapCruiseTipOBJ")
        else    --停止巡航
            SendMsgCallFunByNpc(0,"MapCruise","SetCruiseState")
        end
    end)

    for i=1,3 do
        GUI:addOnClickEvent(self.ui["record_btn"..i],function ()
            SendMsgCallFunByNpc(0,"MapCruise","RecordClick",i)
        end)

        GUI:addOnClickEvent(self.ui["checks_"..i],function ()
            SendMsgCallFunByNpc(0,"MapCruise","SetSettingClick",i)
        end)
    end
end

function MapCruiseOBJ:UpdaViewInfo()
    GUI:Button_setTitleText(self.ui.cruise_state_btn,self.cruise_state > 0 and "停止巡航" or "开始巡航")
    GUI:Button_setTitleColor(self.ui.cruise_state_btn,self.cruise_state > 0 and "#ff0000" or "#ffffff") 
    for i=1,3 do
        if self.map_info.map_name and self.map_info.map_name[i] ~= "" then
            GUI:Text_setString(self.ui["record_map"..i],self.map_info.map_name[i])
            GUI:Text_setTextColor(self.ui["record_map"..i],"#00ff00") 
             
            GUI:Button_setTitleText(self.ui["record_btn"..i],"清空记录")
            GUI:Button_setTitleColor(self.ui["record_btn"..i],"#ffff00") 
        else
            GUI:Text_setString(self.ui["record_map"..i],"未记录地图")
            GUI:Text_setTextColor(self.ui["record_map"..i],"#C6C6CE") 
            GUI:Button_setTitleText(self.ui["record_btn"..i],"记录地图")
            GUI:Button_setTitleColor(self.ui["record_btn"..i],"#ffffff") 
        end
    end
    for i=1,3 do
        local cheks_state = self.setting_info[i] or 0 
        GUI:Image_loadTexture(self.ui["checks_"..i],cheks_state > 0 and "res/custom/0xun/sec11.png" or "res/custom/0xun/sec01.png" ) 
    end
end
function MapCruiseOBJ:flushView( ... )
    local tab = {...}
    if tab[1] == "record_flush" then
        local cruise_info = SL:JsonDecode(tab[2]) or {} 
        self.map_info = cruise_info.map_info or {}
        self.setting_info = cruise_info.setting_info or {}
        self:UpdaViewInfo()
    elseif tab[1] == "state_flush" then
        self.cruise_state = tonumber(tab[2]) or 0
        self:UpdaViewInfo()
    end
end

return MapCruiseOBJ