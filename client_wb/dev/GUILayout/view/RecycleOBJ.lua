local RecycleOBJ = {}
RecycleOBJ.Name = "RecycleOBJ"
RecycleOBJ.RunAction = true
RecycleOBJ.NpcId = {63}
local _cfg = GetConfig("RecycleCfg")
RecycleOBJ.RecycleCfg = _cfg

local temp_cfg = {}
for index, v in ipairs(_cfg) do
    temp_cfg[index] = v.equipname_arr
end
RecycleOBJ.tmp_cfg = temp_cfg

RecycleOBJ.ImgPath = {
    [0] = "res/custom/npc/g0.png",
    [1] = "res/custom/npc/g1.png"
}

RecycleOBJ.BtnImg = {
    [1] = "res/public/1900000663_1.png",
    [2] = "res/public/1900000663_2.png"
}

function RecycleOBJ:main(sMsg, auto, rate)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/RecycleUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.item_cell_list = {}
    self.recycle_state = SL:JsonDecode(sMsg, false)
    self.auto_state = SL:JsonDecode(auto, false)
    self.recycle_items = self:getRecycleItems()
    self.recycle_icon_list = {}
    self.recycle_item_list = {}

    self:initClickEvent()
    self:showRecycleItem()
    self:ShowAutoInfo()
    self:CreateRecycleItemCell()

    GUI:setVisible(self.ui.Scene, false)
    GUI:Text_setString(self.ui.rate_txt, string.format("回收元宝增加：%s%%", rate))
end

function RecycleOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)

    -- 自动元宝
    GUI:addOnClickEvent(self.ui.Panel_1, function()
        SendMsgCallFunByNpc(0, "RecycleNpc", "onChangeAutoSate", 1)
        self.auto_state[1] = self.auto_state[1] == 0 and 1 or 0
        self:ShowAutoInfo()
    end)
    -- 自动经验
    GUI:addOnClickEvent(self.ui.Panel_2, function()
        SendMsgCallFunByNpc(0, "RecycleNpc", "onChangeAutoSate", 2)
        self.auto_state[2] = self.auto_state[2] == 0 and 1 or 0
        self:ShowAutoInfo()
    end)
    -- 自动回收
    GUI:addOnClickEvent(self.ui.autoBtn, function()
        SendMsgCallFunByNpc(0, "RecycleNpc", "onChangeAutoSate", 3)
        self.auto_state[3] = self.auto_state[3] == 0 and 1 or 0
        self:ShowAutoInfo()
    end)
    -- 一键全选
    GUI:addOnClickEvent(self.ui.allSelect, function()
        SendMsgCallFunByNpc(0, "RecycleNpc", "onAllSelect", "")
    end)
    -- 一键回收
    GUI:addOnClickEvent(self.ui.allBtn, function()
        SendMsgCallFunByNpc(0, "RecycleNpc", "onAllRecycle", "")
    end)

    GUI:addOnClickEvent(self.ui.Scene, function()
        self.recycle_item_list = {}
        GUI:setVisible(self.ui.Scene, false)
    end)
end

function RecycleOBJ:CreateRecycleItemCell()
    GUI:ListView_removeAllItems(self.ui.ListView_1)
    local cur_state = self.recycle_state
    local list = self.RecycleCfg
    for index, v in ipairs(list) do
        local ret_str = SL:Split(cur_state[index], "|")
        local value = tonumber(ret_str[1]) or 0
        local cell_layout = GUI:Layout_Create(self.ui.ListView_1, "recycle_cell"..index, 0, 0, 380, 36,  true)
        local bg_img = GUI:Image_Create(cell_layout, "bg_img"..index, 5, 3, "res/public/bg_hhzy_01_2.png")
        GUI:setContentSize(bg_img, 370, 30)
        GUI:setTouchEnabled(bg_img, true)
        local icon_img = GUI:Image_Create(bg_img, "icon_state"..index, 15, 3, self.ImgPath[value])
        self.recycle_icon_list[index] = icon_img

        local tab = SL:Split(v.equiptype, "/FCOLOR=")
        local str_type = string.gsub(tab[1], "<", "")
        local color_id = string.gsub(tab[2], ">", "")
        local color_hex = SL:GetHexColorByStyleId(tonumber(color_id) or 250)
        local text = GUI:Text_Create(bg_img, "type_txt", 50, 6, 15, color_hex, str_type)
        GUI:Text_enableUnderline(text)
        GUI:setTouchEnabled(text, true)
        GUI:addOnClickEvent(text, function()
            self:ShowRecycleInfo(index)
            GUI:setVisible(self.ui.Scene, true)
        end)

        local str = string.format("%s", v.tips)
        GUI:RichTextFCOLOR_Create(bg_img, "tips_txt", 100, 6, str, 300, 15, "#ffffff")

        GUI:addOnClickEvent(bg_img, function()
            SendMsgCallFunByNpc(0, "RecycleNpc", "onChangeRecycleState", index)
        end)
    end
end

function RecycleOBJ:ShowRecycleInfo(index)
    GUI:ListView_removeAllItems(self.ui.ItemList)
    local list = self.RecycleCfg
    local info = list[index]
    if nil == info then
        return
    end
    local index_state = self.recycle_state[index]
    local ret_str = SL:Split(index_state, "|")
    local pos = GUI:getPosition(self.ui.FrameLayout)
    GUI:setPositionY(self.ui.Image_1, pos.y)
    self.recycle_item_list = {}

    for key, value in ipairs(info.equipname_arr) do
        local ret = tonumber(ret_str[key + 1]) or 0
        local layout = GUI:Layout_Create(self.ui.ItemList, "item_cell"..key, 0, 0, 180, 36, true)
        local cell_img = GUI:Image_Create(layout, "cell_img"..key, 5, 3, "res/public/bg_hhzy_01_2.png")
        GUI:setContentSize(cell_img, 170, 30)
        GUI:setTouchEnabled(cell_img, true)
        local icon_img = GUI:Image_Create(cell_img, "icon_state"..key, 15, 3, self.ImgPath[ret])
        self.recycle_item_list[key] = icon_img

        local str = string.format("<%s/FCOLOR=253>", value)
        GUI:RichTextFCOLOR_Create(cell_img, "tips_txt", 60, 6, str, 200, 15, "#ffffff")

        GUI:addOnClickEvent(cell_img, function()
            SendMsgCallFunByNpc(0, "RecycleNpc", "onChangeItemRecycleState", index.. "#" .. key)
        end)
    end
end

function RecycleOBJ:showRecycleItem()
    self.recycle_items = self:getRecycleItems()
    local pos = {0, 68, 136, 204}
    for i = 1, 31 do
        local layout = GUI:Layout_Create(self.ui.ListView_2, "item_cell"..i, 0, 0, 264, 60,  true)
        for j = 1, 4 do
            local index = (i - 1) * 4 + j
            local data = self.recycle_items[index]
            local item = GUI:ItemShow_Create(layout, "item_"..index, pos[j], 0, data or {bgVisible = true})
            self.item_cell_list[index] = item
        end
    end
    self:UpdateSelectState()
end

function RecycleOBJ:ShowAutoInfo()
    local auto_yb = self.auto_state[1] or 0
    GUI:Image_loadTexture(self.ui.yb_icon, auto_yb == 1 and "res/custom/npc/g1.png" or "res/custom/npc/g0.png")

    local auto_jy = self.auto_state[2] or 0
    GUI:Image_loadTexture(self.ui.jy_icon, auto_jy == 1 and "res/custom/npc/g1.png" or "res/custom/npc/g0.png")

    GUI:setVisible(self.ui.tipIcon, self.auto_state[3] == 1)
end

function RecycleOBJ:flushView(tab, _type)
    _type = tonumber(_type)
    self.recycle_state = SL:JsonDecode(tab, false)
    local cur_state = self.recycle_state
    for index, icon in ipairs(self.recycle_icon_list) do
        local ret_info = SL:Split(cur_state[index], "|")
        local state = tonumber(ret_info[1]) or 0
        local res = self.ImgPath[state]
        GUI:Image_loadTexture(icon, res)
    end
    if _type then
        local ret_info = SL:Split(cur_state[_type], "|")
        for index, icon in ipairs(self.recycle_item_list) do
            local state = tonumber(ret_info[index + 1]) or 0
            local res = self.ImgPath[state]
            GUI:Image_loadTexture(icon, res)
        end
    end

    self:UpdateSelectState()
end

function RecycleOBJ:UpdateSelectState()
    self.recycle_items = self:getRecycleItems()
    local sel_tab = self:GetSelectEquips()
    for k, v in pairs(self.item_cell_list) do
        local data = self.recycle_items[k]
        GUI:ItemShow_updateItem(v, data or {bgVisible = true, look = true, index = 0})
        if data and isInTable(sel_tab, data.name) then
            GUI:ItemShow_setItemShowChooseState(v, true)
        else
            GUI:ItemShow_setItemShowChooseState(v, false)
        end
    end
end

function RecycleOBJ:GetSelectEquips()
    local tmp_tab = {}
    local cur_state = self.recycle_state
    for key, value in ipairs(cur_state) do
        local ret_tab = SL:Split(value, "|")
        local _type = tonumber(ret_tab[1]) or 0
        if _type == 1 then            
            for index, name in ipairs(self.tmp_cfg[key]) do
                local ret = tonumber(ret_tab[index + 1]) or 0
                if ret == 1 then
                    tmp_tab[#tmp_tab + 1] = name
                end
            end
        end
    end
    return tmp_tab
end

function RecycleOBJ:getRecycleItems()
    local items = SL:Get_BAG_DATA()     -- 背包道具
    local tmp_items = {}
    for k, v in pairs(items) do
        for index, names in ipairs(self.tmp_cfg) do
            if isInTable(names, v.Name) then
                local data = {}
                data.index = v.Index
                data.look = true
                data.bgVisible = true
                data.MakeIndex = v.MakeIndex
                data.name = v.Name
                tmp_items[#tmp_items + 1] = data
            end
        end
    end
    return tmp_items
end

-- 点击npc触发
local function onClickNpc(npc_info)
    if isInTable(RecycleOBJ.NpcId, npc_info.index) then
        SendMsgClickNpc(npc_info.index.."#RecycleNpc")
    end
end
SL:RegisterLUAEvent(LUA_EVENT_TALKTONPC, "RecycleOBJ", onClickNpc)

return RecycleOBJ