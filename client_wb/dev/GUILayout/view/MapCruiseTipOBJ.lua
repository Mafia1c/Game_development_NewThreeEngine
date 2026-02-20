local MapCruiseTipOBJ = {}
MapCruiseTipOBJ.Name = "MapCruiseTipOBJ"

function MapCruiseTipOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/MapCruiseTipUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:addOnClickEvent(self.ui.CloseLayout,function ()
    	ViewMgr.close(MapCruiseTipOBJ.Name)
    	SendMsgCallFunByNpc(0,"MapCruise","StopMapCruise")
    	SendMsgClickNpc(0 .. "#MapCruise")
    end)

    GUI:addOnClickEvent(self.ui.stop_cruise_btn,function ()
    	ViewMgr.close(MapCruiseTipOBJ.Name)
    	SendMsgCallFunByNpc(0,"MapCruise","StopMapCruise")
    	SendMsgClickNpc(0 .. "#MapCruise")
    end)
    

    self:UpdaViewInfo()
end

function MapCruiseTipOBJ:UpdaViewInfo( ... )
    -- removeOBJ(self.ui.count_down_text,self)
    -- removeOBJ(self.ui.progress,self)
    local text = GUI:Text_Create(self.ui.FrameLayout,"count_down_text",124,193,25,"#00FF00","")
    GUI:Text_COUNTDOWN(text, 5, nil, 0)
    local progress = GUI:ProgressTimer_Create(self.ui.FrameLayout, "progress", 21, 21, "res/custom/0xun/xhjd.png")
    GUI:ProgressTimer_progressTo(progress, 5, 100, function()
        ViewMgr.close(MapCruiseTipOBJ.Name)
        SendMsgCallFunByNpc(0,"MapCruise","StartMapCruise")
    end,77)
end

return MapCruiseTipOBJ