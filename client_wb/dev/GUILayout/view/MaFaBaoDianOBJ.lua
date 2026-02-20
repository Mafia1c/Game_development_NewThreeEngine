local MaFaBaoDianOBJ = {}
MaFaBaoDianOBJ.Name = "MaFaBaoDianOBJ"
MaFaBaoDianOBJ.RunAction = true
MaFaBaoDianOBJ.jackpot_cfg = {"5倍高爆地图卷","10万元宝","1亿经验珠","神器魔盒","万能恶魔图鉴","书页","初级装扮宝箱","高级装扮宝箱","史诗装扮宝箱","传说装扮宝箱"}
MaFaBaoDianOBJ.jackpot_num = {1,1,1,3,20,999,1,1,1,1}
MaFaBaoDianOBJ.probability = {500,400,300,200,100,50,40,30,20,10}

function MaFaBaoDianOBJ:main(item, sMsg)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/MaFaBaoDianUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.schedule_id = nil
    self.isSpinning = false
    self.currentAngle = 0
    self.targetAngle = 0
    self.spinSpeed = 0
    self.cur_time = 0
    self.ret_index = 0
    self.jackpot_data = SL:JsonDecode(sMsg, false)
    self.total_probability = 0
    for index, value in ipairs(self.probability) do
        self.total_probability = self.total_probability + value
    end

    self:initClickEvents()
    self:UpdateJackpotInfo()
    self:InitInfo()
end

function MaFaBaoDianOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("MaFaBaoDianOBJ")
    end)

    GUI:addOnClickEvent(self.ui.Button_1, function()
        if self.isSpinning then
            SL:ShowSystemTips("抽奖进行中...")
            return
        end
        GUI:setRotation(self.ui.arrow, 0)
        SendMsgClickSysBtn("0#OtherSysFunc#onUseMFBDItem")
    end)
end

function MaFaBaoDianOBJ:InitInfo()
    for index, value in ipairs(self.jackpot_cfg) do
        local num = self.jackpot_num[index]
        local cell = self.ui["cell_"..(index+1)]
        local text = GUI:getChildByName(cell, "Text_1")
        GUI:Text_setString(text, value .. "*" .. num)
    end

    for index, v in ipairs(self.probability) do
        local rate = v / self.total_probability * 100
        rate = string.format("%.2f", rate)
        GUI:Text_setString(self.ui["rate_"..index], rate .. "%")
        GUI:setPositionX(self.ui["rate_"..index], 175)
    end
end

function MaFaBaoDianOBJ:UpdateJackpotInfo()
    for index, name in ipairs(self.jackpot_cfg) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(name)
        local count = self.jackpot_num[index] or 1
        ItemShow_updateItem(self.ui["ItemShow_"..index], {index = item_id, look = true, bgVisible = false, count = count, showCount = true, color = 250})
    end

    local item_id = SL:Get_ITEM_INDEX_BY_NAME("玛法宝典")
    ItemShow_updateItem(self.ui["BaoDianItem"], {index = item_id, look = true, bgVisible = true})

    if type(self.jackpot_data) ~= "table" then
        self.jackpot_data = {}
    end

    -- GUI:TableView_setTableViewCellsNumHandler(self.ui.TableView_1, #self.jackpot_data)
    -- GUI:TableView_setCellCreateEvent(self.ui.TableView_1, function(parent, idx, ID)
    --     if ID == "TableView_1" then
    --         local value = self.jackpot_data[idx]
    --         local tab = SL:Split(value, "|")
    --         self:CreateCell(parent, tab[1], tab[2], idx)
    --     end
    -- end)
    -- GUI:TableView_reloadData(self.ui.TableView_1)

    local count = SL:Get_ITEM_COUNT("玛法宝典")
    GUI:Text_setString(self.ui.itemCount, string.format("当前剩余: %s个", count))
end

function MaFaBaoDianOBJ:CreateCell(parent, name, ret, index)
    local layout = GUI:Layout_Create(parent, "cell_" .. index, 0, 0, 240, 50, true)
    GUI:Text_Create(layout, "title_txt", 0, 28, 16, "#ff0000", "恭喜:")
    local str = string.format("<%s/FCOLOR=251>获得<%s*1/FCOLOR=250>", name, ret)
    local txt = GUI:RichTextFCOLOR_Create(layout, "info_txt", 5, 5, str, 300, 16, "#ffffff")
    local size = GUI:getContentSize(txt)
    if size.width > 240 then
        local move_by = GUI:ActionMoveBy(5, -size.width, 0)
        local action = GUI:ActionSequence(GUI:DelayTime(0.5),move_by,GUI:CallFunc(function ()
            GUI:setPosition(txt, 5, 5)
        end))
        GUI:runAction(txt, GUI:ActionRepeatForever(action))
    end
end

function MaFaBaoDianOBJ:onStart(index)
    index = tonumber(index)
    if self.isSpinning then
        return
    end
    GUI:setEnabled(self.ui.Button_1,false)
    self.ret_index = index
    self.isSpinning = true
    self.spinSpeed = 0
    self.currentAngle = 0
    self.cur_time = 0

    local prizeIndex = index
    local anglePerPrize = 36
    local targetPrizeAngle = (prizeIndex - 1) * anglePerPrize
    self.targetAngle = targetPrizeAngle + 360 * 5

    if self.schedule_id then
        return
    end
    local function onUpdate(dt)
        self:update(dt)
    end
    self.schedule_id = SL:Schedule(onUpdate, 1 / 45)
end

function MaFaBaoDianOBJ:update(dt)
    if self.isSpinning then
        self.cur_time = self.cur_time + dt
        -- 加速阶段
        if self.spinSpeed < 10 then
            self.spinSpeed = self.spinSpeed + self.cur_time * 20
        end
        -- 旋转
        self.currentAngle = self.currentAngle + self.spinSpeed * self.cur_time

        -- 减速停止
        local angleDiff = math.abs(self.currentAngle - self.targetAngle)
        if angleDiff < 36 then
            self.spinSpeed = self.spinSpeed - self.cur_time * 5
            if self.spinSpeed < 0.1 then
                self.isSpinning = false
                self.currentAngle = self.targetAngle
                GUI:setEnabled(self.ui.Button_1, true)
            end
        end

        GUI:setRotation(self.ui.arrow, self.currentAngle)
    end

    local count = SL:Get_ITEM_COUNT("玛法宝典")
    GUI:Text_setString(self.ui.itemCount, string.format("当前剩余: %s个", count))
end

function MaFaBaoDianOBJ:flushView(sMsg)
    self:onStart(sMsg)
end

function MaFaBaoDianOBJ:onClose()
    SL:UnSchedule(self.schedule_id)
    self.schedule_id = nil
end

return MaFaBaoDianOBJ