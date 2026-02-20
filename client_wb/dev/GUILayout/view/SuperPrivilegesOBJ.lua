local SuperPrivilegesOBJ = {}
SuperPrivilegesOBJ.Name = "SuperPrivilegesOBJ"
SuperPrivilegesOBJ.RunAction = true
SuperPrivilegesOBJ.cfg = GetConfig("PrivilegesCfg")
SuperPrivilegesOBJ.titleTab={[10285]=1,[10286]=2,[10287]=3}

function SuperPrivilegesOBJ:main()
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/SuperPrivilegesUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self:initClickEvents()
    self:ShowUIData()
end

function SuperPrivilegesOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("SuperPrivilegesOBJ")
    end)

    for i = 1, 3, 1 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            self:onUse(i)
        end)
    end
    SuperPrivilegesOBJ:refreshBtn()
end

function SuperPrivilegesOBJ:onUse(index)
    local v = self.cfg[index]
    local data = {}
    data.str = string.format("确定消耗<font color='#ffff00'>%s</font>激活<font color='#00ff00'>%s</font>吗?", v.needitem, v.givech)
    data.btnType = 2
    data.callback = function(atype, param)
        if atype == 1 then
            SendMsgClickSysBtn("0#OtherSysFunc#onActivation#"..index)
        end
    end
    UIOperator:OpenCommonTipsUI(data)
end

function SuperPrivilegesOBJ:ShowUIData()
    for key, v in ipairs(self.cfg) do
        local cell = self.ui["item_cell_"..key]
        if cell then
            for index, name in ipairs(v.giveitem_arr) do
                local count = v.itemnum_arr[index]
                local item_id = SL:Get_ITEM_INDEX_BY_NAME(name)
                local item = GUI:getChildByName(cell, "ItemShow_"..index)
                ItemShow_updateItem(item, {index = item_id, look = true, bgVisible = true, count = count, showCount = true, color = 255})
            end
        end
    end
end

function SuperPrivilegesOBJ:refreshBtn()
    for i = 1, 3 do
        local tag=tonumber(GameData.GetData("U_superTitle"..i,false) or 0)
        GUI:setVisible(self.ui["Button_"..i],tag==0)
        GUI:setVisible(self.ui["activeImg"..i],tag==1)
    end
end

--#region 后端消息刷新ui
function SuperPrivilegesOBJ:flushView(...)
    local tab = {...}
    local functionTab = {
        ["refresh"]=function ()
            SuperPrivilegesOBJ:refreshBtn()
        end,
    }
    if functionTab[tab[1]] then
        functionTab[tab[1]]()
    end
end

return SuperPrivilegesOBJ