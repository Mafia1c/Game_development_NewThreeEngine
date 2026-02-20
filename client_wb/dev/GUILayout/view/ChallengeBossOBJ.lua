local ChallengeBossOBJ = {}
ChallengeBossOBJ.Name = "ChallengeBossOBJ"
ChallengeBossOBJ.RunAction = true
ChallengeBossOBJ.boss_info = GetConfig("ChallengeBossCfg")

function ChallengeBossOBJ:main(sMsg, sMsg2)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ChallengeBossUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.item_cell_list = {}
    self.page_node = {}
    self.format_str = "<第/FCOLOR=255><  %d  /FCOLOR=250><页/FCOLOR=255>"
    self.cur_page_value = 1
    self.cur_select_boss = 1
    self.boss_times = SL:JsonDecode(sMsg, false)
    self.kill_info = SL:JsonDecode(sMsg2, false)
    self.mon_name_txt = nil

    -- self.kill_text = GUI:ScrollText_Create(self.ui.rewardNode, "name_txt", 0, 43, 200, 18, "#ffffff", "虚位以待", 5)
    -- GUI:setAnchorPoint(self.kill_text, 0.5, 0.5)

    self:initClickEvent()
    self:createItemCell()

    self:updateBossInfo()
    self:showCurPage()
end

function ChallengeBossOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.gotoBtn, function()
        SendMsgClickMainBtn("0#ChallengeBoss#gotoChallenge#"..self.cur_page_value.."#"..self.cur_select_boss)
    end)
    GUI:addOnClickEvent(self.ui.lastBtn, function()
        self:onPageChange(-1)
    end)
    GUI:addOnClickEvent(self.ui.nextBtn, function()
        self:onPageChange(1)
    end)
end

function ChallengeBossOBJ:createItemCell()
    for i = 1, 6 do
        local img = GUI:Image_Create(self.ui.bossListView, i, 0, 0, "res/custom/npc/33tzboss/tips.png")
        local name = GUI:ScrollText_Create(img, "name", 67, 28, 120, 18, "#00ff00", "", 4)
        GUI:setAnchorPoint(name, 0.5, 0.5)
        local level = GUI:Text_Create(img, "level", 185, 28, 18, "#00ff00", "")
        GUI:setAnchorPoint(level, 0.5, 0.5)
        local map = GUI:Text_Create(img, "map", 282, 28, 18, "#00ff00", "")
        GUI:setAnchorPoint(map, 0.5, 0.5)
        local time = GUI:Text_Create(img, "time", 395, 28, 18, "#ff0000", "")
        GUI:setAnchorPoint(time, 0.5, 0.5)
        local tag = GUI:Image_Create(img, "tag", 351, 9, "res/custom/npc/33tzboss/tips1.png")
        local select = GUI:Image_Create(img, "select", 0, 0, "res/public/1900000678_3.png")
        GUI:setContentSize(select, 456, 56)
        GUI:Image_setScale9Slice(select, 10, 10, 10, 10)
        GUI:setVisible(select, false)

        local _ui = {
            img = img,
            name = name,
            level = level,
            map = map,
            time = time,
            tag = tag,
            select = select
        }
        self.item_cell_list[i] = _ui
        GUI:setTouchEnabled(img, true)
        GUI:addOnClickEvent(img, function()
            if i == self.cur_select_boss then
                return
            end
            self:showCurSelectCell(i)
            self.cur_select_boss = i
        end)
    end
end

function ChallengeBossOBJ:onPageChange(value)
    self.cur_page_value = self.cur_page_value + value
    if self.cur_page_value > math.ceil(#self.boss_info / 6) then
        self.cur_page_value = math.ceil(#self.boss_info / 6)
    end
    if self.cur_page_value < 1 then
        self.cur_page_value = 1
    end
    local ui1 = self.item_cell_list[self.cur_select_boss]
    GUI:setVisible(ui1.select, false)
    self.cur_select_boss = 1
    SendMsgClickMainBtn("0#ChallengeBoss#onPageChange#"..self.cur_page_value)
end

function ChallengeBossOBJ:showCurSelectCell(index)
    index = index or self.cur_select_boss
    local tmp_index = index
    local ui1 = self.item_cell_list[self.cur_select_boss]
    local ui2 = self.item_cell_list[index]
    GUI:setVisible(ui1.select, false)
    GUI:setVisible(ui2.select, true)

    if self.page_node[2] then
        GUI:removeFromParent(self.page_node[2])
        self.page_node[2] = nil
    end
    index = (self.cur_page_value - 1) * 6 + index
    local data = self.boss_info[index] or {}
    local dir = 4
    if isInTable({131, 140}, data.appr) then
        dir = 0
    end
    self.page_node[2] = GUI:Effect_Create(self.ui.eff_node, "mon_eff", 630, 350, 2, data.bossicon or 27, 0, 0, dir)
    GUI:setScale(self.page_node[2], data.scale or 1)

    if self.mon_name_txt then
        GUI:removeFromParent(self.mon_name_txt)
        self.mon_name_txt = nil
    end
    self.mon_name_txt = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "_mon_name", 660, 452, data.monname or "", 200, 18)
    GUI:setAnchorPoint(self.mon_name_txt, 0.5, 0)

    for key, name in ipairs(data.reward_arr or {}) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(name) or 0
        GUI:ItemShow_updateItem(self.ui["ItemShow_"..key], {bgVisible = true, look = true, index = item_id})
    end

    if data.firstkill_arr then
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(data.firstkill_arr[1]) or 0
        local count = data.firstkill_arr[2]
        ItemShow_updateItem(self.ui.reward_item, {index = item_id, look = true, bgVisible = true, count = count})
    end

    local name = "虚位以待"
    local time = "虚位以待"
    local color = "#ffffff"
    local v = self.kill_info[tmp_index]
    if 0 == v then
    else
        local tbl = SL:Split(v, "|")
        name = tbl[1]
        time = GetDate(tonumber(tbl[2]) or os.time())
        color = "#00ff00"
    end
    GUI:Text_setString(self.ui.name_txt, name)
    GUI:Text_setString(self.ui.time_txt, time)
    GUI:Text_setTextColor(self.ui.name_txt, color)
    GUI:Text_setTextColor(self.ui.time_txt, color)
end

function ChallengeBossOBJ:showCurPage()
    if self.page_node[1] then
        GUI:removeFromParent(self.page_node[1])
        self.page_node[1] = nil
    end
    self.page_node[1] = GUI:RichTextFCOLOR_Create(self.ui.FrameLayout, "_page_value", 295, 63, string.format(self.format_str, self.cur_page_value), 200, 18)
    GUI:setAnchorPoint(self.page_node[1], 0.5, 0.5)
end

function ChallengeBossOBJ:updateBossInfo()
    local start = (self.cur_page_value - 1) * 6
    local tmp_data = self.boss_info
    for i = 1, #self.item_cell_list, 1 do
        local ui = self.item_cell_list[i]
        local v = tmp_data[i + start]
        GUI:setVisible(ui.img, v ~= nil)
        if v then
            local tab = SL:Split(v.monname, "/FCOLOR=")
            local mon_name = string.gsub(tab[1], "<", "")
            local color_id = string.gsub(tab[2], ">", "")
            local color_hex = SL:GetHexColorByStyleId(tonumber(color_id) or 250)
            GUI:ScrollText_setString(ui.name, mon_name)
            GUI:ScrollText_setTextColor(ui.name, color_hex)
            GUI:Text_setString(ui.level, v.level)
            GUI:Text_setString(ui.map, v.mapname)
            local value = self.boss_times[i] or v.time
            GUI:Text_setString(ui.time, value .. "分钟")
            GUI:setVisible(ui.time, value ~= 0)
            GUI:setVisible(ui.tag, value == 0)
        end
    end

    self:showCurSelectCell()
end

function ChallengeBossOBJ:flushView(page, sMsg, sMsg2)
    self.boss_times = SL:JsonDecode(sMsg, false)
    self.kill_info = SL:JsonDecode(sMsg2, false)
    self:showCurPage()
    self:updateBossInfo()
end

return ChallengeBossOBJ