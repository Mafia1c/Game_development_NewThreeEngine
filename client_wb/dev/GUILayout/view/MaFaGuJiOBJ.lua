local MaFaGuJiOBJ = {}
MaFaGuJiOBJ.Name = "MaFaGuJiOBJ"
MaFaGuJiOBJ.RunAction = true
local _cfg = GetConfig("TaskInfoCfg")
local tmp_cfg = {}
for key, v in ipairs(_cfg) do
    tmp_cfg[v.taskid] = tmp_cfg[v.taskid] or {}
    tmp_cfg[v.taskid].equipid_arr = v.equipid_arr or tmp_cfg[v.taskid].equipid_arr
    tmp_cfg[v.taskid].reward_arr = v.reward_arr or tmp_cfg[v.taskid].reward_arr
    tmp_cfg[v.taskid].rewardnum_arr = v.rewardnum_arr or tmp_cfg[v.taskid].rewardnum_arr
    tmp_cfg[v.taskid].effectid = v.effectid or tmp_cfg[v.taskid].effectid
    tmp_cfg[v.taskid].needitem_map = v.needitem_map or tmp_cfg[v.taskid].needitem_map
    table.insert(tmp_cfg[v.taskid], v)
end
MaFaGuJiOBJ.TaskCfg = tmp_cfg
MaFaGuJiOBJ.EquipIndex = {42, 20, 22, 23, 24, 25, 27, 28}

function MaFaGuJiOBJ:main(task_id, sMsg, state, tag)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/MaFaGuJiUI", function() end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_task_id = tonumber(task_id)
    self.task_info = SL:JsonDecode(sMsg, false)
    self.task_state = SL:JsonDecode(state, false)
    self.node_list = {}
    self.get_tag = tonumber(tag) or 0
    self.actor_job = SL:Get_JOB() + 1
    self.title_eff = nil
    self:initClickEvents()
    self:CreateModel()
    self:updateUiInfo()
    self:updateBtnState()
end

function MaFaGuJiOBJ:initClickEvents()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("MaFaGuJiOBJ")
    end)

    for i = 1, 3, 1 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            if self.task_state[i] > 1 then
                return
            end
            SendMsgCallFunByNpc(0, "MaFaGuJiNpc", "onGoToComplete", self.cur_task_id .. "#" .. i)
        end)
    end

    GUI:addOnClickEvent(self.ui.GetReward, function()
        SendMsgCallFunByNpc(0, "MaFaGuJiNpc", "onGetReward", self.cur_task_id)
    end)
end

function MaFaGuJiOBJ:CreateModel()
    local wq = SL:Get_EQUIP_DATA(1)
    local yf = SL:Get_EQUIP_DATA(0)
    local wq_eff = nil
    local yf_eff = nil
    if wq then
        wq_eff = wq.sEffect
    end
    if yf then
        yf_eff = yf.sEffect
    end
    
    local feature= {}
    feature.weaponID = wq and wq.Looks or nil-- 武器id
    feature.clothID = yf and yf.Looks or nil
    feature.weaponEffectID = wq_eff
    feature.clothEffectID = yf_eff
    feature.showNodeModel = true
    feature.showHair = false
    local sex = SL:GetMetaValue("SEX")
    local job = SL:GetMetaValue("JOB")
    local UIModel = GUI:UIModel_Create(self.ui.ModeNode, "UIMODEL", 255, 320, sex, feature, nil, true, job)
end

function MaFaGuJiOBJ:ShowTitleEffect()
    if self.title_eff then
        GUI:removeFromParent(self.title_eff)
        self.title_eff = nil
    end
    local cfg = self.TaskCfg[self.cur_task_id] or {}
    -- local sex = SL:GetMetaValue("SEX")
    -- self.title_eff = GUI:Effect_Create(self.ui.L_Node, "title", 255, 450, 0, cfg.effectid or 1, sex, 0, 0, 1)

    if self.ui.btn_tag and GUI:Win_IsNotNull(self.ui.btn_tag) then
        GUI:setVisible(self.ui.btn_tag, false)
        for key, v in pairs(cfg.needitem_map or {}) do
            local num = SL:Get_ITEM_COUNT(key)
            GUI:setVisible(self.ui.btn_tag, num >= v)
            break
        end
    end
end

function MaFaGuJiOBJ:updateBtnState()
    local count = 0
    for i = 1, 3, 1 do
        local size = {w = 120, h = 44}
        local btn = self.ui["Button_"..i]
        local state = self.task_state[i]            -- 0.未完成   1.已完成   2.已领取
        local res1 = "res/custom/npc/27guji/btn1.png"
        local res2 = "res/custom/npc/27guji/btn2.png"
        if state == 1 then
            res1 = "res/custom/npc/27guji/btn11.png"
            res2 = "res/custom/npc/27guji/btn12.png"
            count = count + 1
        elseif state == 2 then
            res1 = "res/custom/tag/y_103.png"
            res2 = "res/custom/tag/y_103.png"
            size = {w = 107, h = 84}
            count = count + 1
        end
        GUI:Button_loadTextureNormal(btn, res1)         -- 正常图片
        GUI:Button_loadTexturePressed(btn, res2)        -- 按下图片
        GUI:setContentSize(btn, size.w, size.h)
        if state == 1 then
            local red = GUI:Image_Create(btn, "red_icon", 100, 25, "res/custom/red1.png")
        else
            GUI:removeAllChildren(btn)
        end
    end
    GUI:setVisible(self.ui.GetTag, self.get_tag >= self.cur_task_id)
    GUI:setVisible(self.ui.GetReward, self.get_tag < self.cur_task_id)

    if count >= 3 then
        local red = GUI:Image_Create(self.ui.GetReward, "red_icon", 100, 25, "res/custom/red1.png")
    else
        GUI:removeAllChildren(self.ui.GetReward)
    end
end

function MaFaGuJiOBJ:updateUiInfo()
    local cfg = self.TaskCfg[self.cur_task_id]
    if nil == cfg then
        return
    end
    GUI:ListView_removeAllItems(self.ui.ListView_1)

    for key, node in pairs(self.node_list) do
        GUI:removeFromParent(node)
    end
    self.node_list = {}

    for i = 1, 8, 1 do
        local item = self.ui["ItemShow_"..i]
        local item_id = cfg.equipid_arr[i]
        ItemShow_updateItem(item, {index = item_id, look = true, bgVisible = true})

        local index = self.EquipIndex[i]
        local eq = SL:Get_EQUIP_DATA(index)
        local active = false
        if eq and eq.Index == item_id then
            active = true
        end
        GUI:ItemShow_setIconGrey(item, not active)
        local icon_res = not active and "res/custom/npc/27guji/jh1.png" or "res/custom/npc/27guji/jh0.png"
        GUI:Image_loadTexture(GUI:getChildByName(item, "icon"), icon_res)
    end

    for index, v in ipairs(cfg) do
        local parent = self.ui["cell_img_"..index]

        local task_title = v.tasktitle
        local title = GUI:RichTextFCOLOR_Create(parent, "_title", 55, 95, task_title, 300, 16, "#ffffff")

        local par_str = string.format(v.progress, self.task_info[index] or 0)
        local pro = GUI:RichTextFCOLOR_Create(parent, "_pro", 55, 72, par_str, 300, 16, "#ffffff")

        for key, value in ipairs(v.taskitem_arr or {}) do
            local item = GUI:getChildByName(parent, "ItemShow_"..key)
            local item_id = SL:Get_ITEM_INDEX_BY_NAME(value)
            local count = v.itemnum_arr[key] or 1
            ItemShow_updateItem(item, {index = item_id, look = true, bgVisible = true, showCount = true, count = count, color = 250})
        end

        table.insert(self.node_list, title)
        table.insert(self.node_list, pro)
    end

    for index, name in ipairs(cfg.reward_arr or {}) do
        local item_id = SL:Get_ITEM_INDEX_BY_NAME(name)
        local count = cfg.rewardnum_arr[index] or 1
        local item = GUI:ItemShow_Create(self.ui.ListView_1, item_id, 0, 0, {index = item_id, look = true, bgVisible = true, count = count})
    end

    self:ShowTitleEffect()
end


function MaFaGuJiOBJ:flushView(task_id, sMsg, state, tag)
    self.cur_task_id = tonumber(task_id)
    self.task_info = SL:JsonDecode(sMsg, false)
    self.task_state = SL:JsonDecode(state, false)
    self.get_tag = tonumber(tag) or 0
    self:updateUiInfo()
    self:updateBtnState()
end

return MaFaGuJiOBJ