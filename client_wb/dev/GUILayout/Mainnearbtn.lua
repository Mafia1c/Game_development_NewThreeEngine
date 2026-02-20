MainNearBtn = {}
local screenW = SL:GetMetaValue("SCREEN_WIDTH")
local screenH = SL:GetMetaValue("SCREEN_HEIGHT")
local iswin32 = SL:Get_IS_PC_OPER_MODE()
function MainNearBtn:main()
    local attachPoint = GUI:Attach_RightBottom()
    local panel = GUI:getChildByName(attachPoint, "___main_panel")
    local btn = GUI:getChildByName(attachPoint, "___main_btn")
    
    if panel then
        GUI:removeFromParent(panel)
    end
    if btn  then
        GUI:removeFromParent(btn)
    end
    local x = -500
    if SL:Get_IS_PC_OPER_MODE() then
        x = -330
    end
    self.Main_Panel = GUI:Layout_Create(attachPoint, "___main_panel", x, 200, 62.00, 62.00, false)
    if not self.Main_Panel then
        return
    end
    GUI:setTouchEnabled(self.Main_Panel, true)
	self.targetBtn = GUI:Button_Create(self.Main_Panel, "___main_btn", 0, 0, "res/private/main/target_1.png")
    GUI:setSwallowTouches(self.targetBtn, false)
    local basePosX, basePosy = 0, 0
    GUI:addOnTouchEvent(self.Main_Panel, function (sender, eventType)
			-- 触摸开始
        if eventType == 0 then
            local pos_t = GUI:getPosition(sender)
            basePosX, basePosy = pos_t.x, pos_t.y
			-- 触摸移动
        elseif eventType == 1 then
            local sPos = GUI:getTouchBeganPosition(sender)
            local ePos = GUI:getTouchMovePosition(sender)
            local x = basePosX + ePos.x - sPos.x
            local y = basePosy  + ePos.y - sPos.y
			GUI:setPosition(self.Main_Panel, x, y)
            -- if MainNear and MainNear._ui["Panel_1"] and not GUI:Win_IsNull(MainNear._ui["Panel_1"]) then
            --     local Panel_1 = MainNear._ui["Panel_1"]
            --     local pSize = GUI:getContentSize(Panel_1)
            --     local anchor = GUI:getAnchorPoint(Panel_1)
            --     GUI:setPosition(Panel_1, x - pSize.width * anchor.x, y + pSize.height)
            -- end
			-- 触摸结束 or 触摸取消
        elseif eventType == 2 then
			-- 执行点击事件
            SL:JumpTo(116)
		end
	end)
end
MainNearBtn:main()
