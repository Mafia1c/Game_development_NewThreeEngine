local AncientSwordOBJ = {}
AncientSwordOBJ.Name = "AncientSwordOBJ"
local tmp_cfg = {}
for key, v in pairs(GetConfig("AncientSwordCfg")) do
    tmp_cfg[v.npcid] = tmp_cfg[v.npcid] or {}
    tmp_cfg[v.npcid][v.type] = tmp_cfg[v.npcid][v.type] or {}
    table.insert(tmp_cfg[v.npcid][v.type], v)
end
AncientSwordOBJ.cfg = tmp_cfg

function AncientSwordOBJ:main(npc_id)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/AncientSwordUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.npc_id = tonumber(npc_id)

    local tmp = {}
    local cfg = self.cfg[self.npc_id] or {}
    for key, v in pairs(cfg) do
        local data = v
        table.sort(data, function (a, b)
            return a.key_name < b.key_name
        end)
        data.Name = key
        data.Sort = v[1].key_name
        tmp[#tmp + 1] = data
    end
    table.sort(tmp, function (a, b)
        return a.Sort < b.Sort
    end)
    self.cur_cfg = tmp

    self.one_page_index = 1
    self.tow_page_index = 1
    self.page_btn_1 = {}
    self.page_btn_2 = {}
    self.need_txt = nil
    self.cur_select_data = nil

    self:initClickEvents()
    self:CreatePageBtn()
    self:onOnePageChange()

    for i = 1, 5, 1 do
        local x = GUI:getPositionX(self.ui["ItemShow_"..i])
        GUI:setPositionX(self.ui["ItemShow_"..i], x + 50)
    end
end

function AncientSwordOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("AncientSwordOBJ")
    end)
    GUI:addOnClickEvent(self.ui.Button_1, function()
        if nil == self.cur_select_data then
            return
        end
        SendMsgCallFunByNpc(self.npc_id, "AncientSwordNpc", "onForgeEquip", self.cur_select_data.key_name)
    end)
end

function AncientSwordOBJ:CreatePageBtn()
    for key, v in pairs(self.cur_cfg) do
        local btn1 = GUI:Button_Create(self.ui.pageList_1, "page_1_"..key, 0, 0, "res/custom/npc/ta1.png")
        GUI:Button_setTitleFontSize(btn1, 18)
        GUI:Button_setTitleText(btn1, v.Name)
        GUI:addOnClickEvent(btn1, function()
            if key == self.one_page_index then
                return
            end
            self:onOnePageChange(key)
        end)
        table.insert(self.page_btn_1, btn1)
    end

    local list = self.cur_cfg[1]
    for key, v in ipairs(list) do
        local btn2 = GUI:Button_Create(self.ui.pageList_2, "page_2_"..key, 0, 0, "res/custom/npc/ta11.png")
        GUI:Button_setTitleFontSize(btn2, 18)
        GUI:Button_setTitleText(btn2, v.name)
        GUI:addOnClickEvent(btn2, function()
            if key == self.tow_page_index then
                return
            end
            self:onTowPageChange(key)
        end)
        table.insert(self.page_btn_2, btn2)
    end
end

function AncientSwordOBJ:onOnePageChange(index)
    index = index or self.one_page_index
    GUI:Button_loadTextureNormal(self.page_btn_1[self.one_page_index], "res/custom/npc/ta1.png")
    GUI:Button_loadTextureNormal(self.page_btn_1[index], "res/custom/npc/ta0.png")
    local two_data = self.cur_cfg[index]
    for key, btn in ipairs(self.page_btn_2) do
        GUI:Button_setTitleText(btn, two_data[key].name)
    end
    self.one_page_index = index
    self:onTowPageChange(1)
end

function AncientSwordOBJ:onTowPageChange(index)
    index = index or self.tow_page_index
    GUI:Button_loadTextureNormal(self.page_btn_2[self.tow_page_index], "res/custom/npc/ta11.png")
    GUI:Button_loadTextureNormal(self.page_btn_2[index], "res/custom/npc/ta10.png")
    self.tow_page_index = index
    self:ShowUIData()
    local red_check_list  = {}
    red_check_list.view_name = "AncientSwordOBJ"
    red_check_list.node = self
    red_check_list["page_2_1"]  =  RedPointMgr.GetRedDataByBtnName("AncientSwordOBJ","page_2_1")
    red_check_list["page_2_2"]  =  RedPointMgr.GetRedDataByBtnName("AncientSwordOBJ","page_2_2")
    red_check_list["page_2_3"]  =  RedPointMgr.GetRedDataByBtnName("AncientSwordOBJ","page_2_3")
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_check_list)
end

function AncientSwordOBJ:ShowUIData()
    local data = self.cur_cfg[self.one_page_index][self.tow_page_index]

    local need_items = {data.needequip, data.needitem, data.needitem1, data.needitem2, data.needitem3}
    local need_num = {data.equipnum, data.itemnum, data.itemnum1, data.itemnum2, data.itemnum3}
    for i = 1, 5, 1 do
        if need_items[i] then
            local item_id = SL:Get_ITEM_INDEX_BY_NAME(need_items[i])
            local count = need_num[i]
            local color = 250
            if SL:Get_ITEM_COUNT(need_items[i]) < count then
                color = 249
            end
            ItemShow_updateItem(self.ui["ItemShow_"..i], {index = item_id, look = true, bgVisible = true, count = count, color = color, showCount = true})
        end

        GUI:setVisible(self.ui["ItemShow_"..i], nil ~= need_items[i])
    end

    local equip_id = SL:Get_ITEM_INDEX_BY_NAME(data.name)
    ItemShow_updateItem(self.ui["EquipItem"], {index = equip_id, look = true, bgVisible = true, count = 1, color = 250})

    GUI:Text_setString(self.ui.equipName, data.name)
    self.cur_select_data = data
    local red_check_list  = {}
    red_check_list.view_name = "AncientSwordOBJ"
    red_check_list.node = self
    red_check_list["Button_1"]  =  RedPointMgr.GetRedDataByBtnName("AncientSwordOBJ","Button_1")
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,red_check_list)
end

function AncientSwordOBJ:flushView()
    self:ShowUIData()
    SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "AncientSwordOBJ",["node"] = self,["is_all"] = true})
end

function AncientSwordOBJ:GetBtnRed()
    if AncientSwordOBJ.one_page_index == nil or AncientSwordOBJ.tow_page_index == nil then return false end
    local data = AncientSwordOBJ.cur_cfg[AncientSwordOBJ.one_page_index][AncientSwordOBJ.tow_page_index]
    local need_items = {data.needequip, data.needitem, data.needitem1, data.needitem2, data.needitem3}
    local need_num = {data.equipnum, data.itemnum, data.itemnum1, data.itemnum2, data.itemnum3}
    for i = 1, 5, 1 do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(need_items[i])
        local count = need_num[i]
        local color = 250
        if SL:Get_ITEM_COUNT(need_items[i]) < count then
            return false
        end
    end
    return true
end
function AncientSwordOBJ:PageTwoRed(index)
    index = tonumber(index)
    if index == nil then return false end
    if AncientSwordOBJ.one_page_index == nil then return false end
    local data = AncientSwordOBJ.cur_cfg[AncientSwordOBJ.one_page_index][index]
    local need_items = {data.needequip, data.needitem, data.needitem1, data.needitem2, data.needitem3}
    local need_num = {data.equipnum, data.itemnum, data.itemnum1, data.itemnum2, data.itemnum3}
    for i = 1, 5, 1 do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(need_items[i])
        local count = need_num[i]
        local color = 250
        if SL:Get_ITEM_COUNT(need_items[i]) < count then
            return false
        end
    end
    return true
end

function AncientSwordOBJ:PageOneRed(index)
    index = tonumber(index)
    if index == nil then return false end
    if AncientSwordOBJ.cur_cfg[index] == nil then return false end
    for i,v in ipairs(AncientSwordOBJ.cur_cfg[index]) do
        local is_show = true
        local need_items = {v.needequip, v.needitem, v.needitem1, v.needitem2, v.needitem3}
        local need_num = {v.equipnum, v.itemnum, v.itemnum1, v.itemnum2, v.itemnum3}
        for i = 1, 5, 1 do
            local item_id = SL:Get_ITEM_INDEX_BY_NAME(need_items[i])
            local count = need_num[i]
            if SL:Get_ITEM_COUNT(need_items[i]) < count then
                is_show = false
                break
            end
        end
        if is_show then
            return true
        end
    end
    return false
end
-- 点击npc触发
local function onClickNpc(npc_info)
    if nil ~= AncientSwordOBJ.cfg[npc_info.index] then
        ViewMgr.open("AncientSwordOBJ", npc_info.index)
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "AncientSwordOBJ", onClickNpc)

return AncientSwordOBJ