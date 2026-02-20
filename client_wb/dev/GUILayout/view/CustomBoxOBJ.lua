local CustomBoxOBJ = {}
CustomBoxOBJ.Name = "CustomBoxOBJ"
CustomBoxOBJ.RunAction = true
CustomBoxOBJ.cfg = GetConfig("CustomBoxCfg")

function CustomBoxOBJ:main(name)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/CustomBoxUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.box_name = name

    self:initClickEvents()
    self:CreateItemCell()
end

function CustomBoxOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("CustomBoxOBJ")
    end)
end

function CustomBoxOBJ:CreateItemCell()
    local cfg = self.cfg[self.box_name]
    if nil == cfg then
        return
    end

    local item_tab = SL:Split(cfg.item, "|")
    local row = math.ceil(#item_tab / 4)
    for i = 1, row, 1 do
        local layout = GUI:Layout_Create(self.ui.ListView_1, "cell_"..i, 0, 0, 655, 184, true)
        for j = 1, 4 do
            local index = (i - 1) * 4 + j
            local item = item_tab[index]
            if item then
                local info = SL:Split(item, "#")
                local bg_img = GUI:Image_Create(layout, "bg_cell"..j, (j - 1) * 160 + (j - 1) * 3, 0, "res/custom/std/list.png")
                local name = GUI:RichTextFCOLOR_Create(bg_img, "_name", 77, 158, string.format("<%s/FCOLOR=251>", info[1]), 500, 14, "#ffffff")
                GUI:setAnchorPoint(name, 0.5, 0)
                local item_id = SL:Get_ITEM_INDEX_BY_NAME(info[1])
                local show = GUI:ItemShow_Create(bg_img, item_id, 80, 100, {index = item_id, look = true, bgVisible = false, count = tonumber(info[2]) or 1})
                GUI:setAnchorPoint(show, 0.5, 0.5)
                ItemShow_updateItem(show, {showCount = true, count = tonumber(info[2]) or 1, color = 255})
                local btn = GUI:Button_Create(bg_img, "_btn"..j, 80, 26, "res/custom/std/btn1.png")
                GUI:setAnchorPoint(btn, 0.5, 0.5)
                GUI:addOnClickEvent(btn, function()
                    SendMsgCallFunByNpc(0, "CustomBoxNpc", "onSelectItem", self.box_name .. "#" .. item)
                end)
            end
        end
    end
end

return CustomBoxOBJ