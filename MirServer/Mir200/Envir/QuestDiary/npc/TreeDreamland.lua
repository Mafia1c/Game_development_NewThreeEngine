local TreeDreamland = {}
TreeDreamland.DirOffset = {
	[0] = {x = 0, y = -1},			-- 上
	[1] = {x = 1, y = -1},			-- 右上
	[2] = {x = 1, y = 0},			-- 右
	[3] = {x = 1, y = 1},			-- 右下
	[4] = {x = 0, y = 1},			-- 下
	[5] = {x = -1, y = 1},			-- 左下
	[6] = {x = -1, y = 0},			-- 左
	[7] = {x = -1, y = -1},			-- 左上
}
-- 怪物
TreeDreamland.tree_mon = {
    -- {"木之幻境", 137, 128, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 135, 128, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 133, 128, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 131, 128, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 129, 128, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 127, 128, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 125, 128, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 123, 128, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 121, 128, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 119, 128, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 117, 128, "爆不爆谁知道6", 0, 1, 0, 255},

    -- {"木之幻境", 137, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 135, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 133, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 131, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 129, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 127, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 125, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 123, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 121, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 119, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 117, 124, "爆不爆谁知道6", 0, 1, 0, 255},
    
    -- {"木之幻境", 137, 135, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 135, 135, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 133, 135, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 131, 135, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 129, 135, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 127, 135, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 125, 135, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 123, 135, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 121, 135, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 119, 135, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 117, 135, "爆不爆谁知道6", 0, 1, 0, 255},

    -- {"木之幻境", 137, 139, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 135, 139, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 133, 139, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 131, 139, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 129, 139, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 127, 139, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 125, 139, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 123, 139, "爆不爆谁知道6", 0, 1, 0, 255},
    {"木之幻境", 121, 139, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 119, 139, "爆不爆谁知道6", 0, 1, 0, 255},
    -- {"木之幻境", 117, 139, "爆不爆谁知道6", 0, 1, 0, 255},
}
-- 正常的
TreeDreamland.update_mon = {
    [1] = "僵尸王·十倍爆率",
    [2] = "僵尸王·百倍爆率",
    [3] = "僵尸王·千倍爆率",
    [4] = "僵尸王·万倍爆率",
    [5] = "僵尸王·十万倍爆率",
}
-- 直播的
TreeDreamland.update_mon2 = {
    [1] = "僵尸王·十倍爆率1",
    [2] = "僵尸王·百倍爆率1",
    [3] = "僵尸王·千倍爆率1",
    [4] = "僵尸王·万倍爆率1",
    [5] = "僵尸王·十万倍爆率1",
}

TreeDreamland.TreeCfg = GetConfig("MiningCfg")
TreeDreamland.TreeCfg2 = GetConfig("MiningCfg2")

function TreeDreamland:onKillTreeMapMon(actor, monName)
    local run_time = GetSysInt("G_tree_state_run_time")
    local cfg_index = 1
    local first_time = 5
    if GetSysInt("G200") > 0 then
        first_time = 8
    end
    if run_time <= 60 * first_time then
        cfg_index = 1
    elseif run_time <= 60 * (first_time + 5) then
        cfg_index = 2
    elseif run_time <= 60 * (first_time + 5 + 5) then
        cfg_index = 3
    else
        cfg_index = 4
    end
    self:MonDropInfo(actor, cfg_index)
end

function TreeDreamland:MonDropInfo(actor, index)
    local v = self.TreeCfg2[index]
    if GetSysInt("G200") >= 1 then
        v = self.TreeCfg[index]
    end
    if nil == v then
        release_print("参数异常: ", index)
        return
    end
    local x = getbaseinfo(actor, 4)
    local y = getbaseinfo(actor, 5)
    local probability = GetSysInt("G_tree_probability")         -- 数值越大 掉装备几率越大
    if probability == 0 then
        probability = 70
    end
    local _type = math.random(100)
    if _type > probability then
        local mon_name = self.update_mon[index]
        if GetSysInt("G200") >= 1 then
            mon_name = self.update_mon2[index]
        end
        if mon_name then
            genmon("木之幻境", x, y, mon_name, v.range, 1, 255)
        end
    else
        local drop_data = {}
        local random = math.random(100)
        if GetSysInt("G200") >= 1 then
            drop_data = v.ceshi_arr
            if random <= 10 then
                drop_data = v.ceshi2_arr
            end
        else
            drop_data = v.drop_arr
            if random <= 10 then
                drop_data = v.drop1_arr
            end
        end
        local tmp_tab = {}
        for key, value in pairs(drop_data) do
            tmp_tab[#tmp_tab + 1] = value
        end
        local reward = tmp_tab[math.random(#tmp_tab)]
        throwitem(actor, "木之幻境", x, y, v.range, reward, 1, 0, true, false, false, true, 1, false)
    end
end

-- 挖矿活动开始
function TreeDreamland:onTreeOpen(show_tips)
    SetSysInt("G_tree_state", 1)
    SetSysInt("G_tree_state_run_time", 0)
    setenvirofftimer("木之幻境", 222)
    setenvirontimer("木之幻境", 222, 1, "@tree_map_schedule")
    self:TreeMapUpdateMon()

    for i = 1, 3 do
        sendmovemsg("0", 0, 250, 0, 60 + (i - 1 ) * 30, 1, "【木之环境(福利)】活动已开始, 各位少侠可从【盟重土城】346.313进入参与!")
    end
end

-- 挖矿活动结束
function TreeDreamland:onTreeClose(show_tips)
    setenvirofftimer("木之幻境", 222)
    SetSysInt("G_tree_state", 0)
    SetSysInt("G_tree_state_run_time", 0)
    self:cleanTreeMapMon()

    if show_tips then
        return
    end
    for i = 1, 3 do
        sendmovemsg("0", 0, 249, 0, 60 + (i - 1 ) * 30, 1, "【木之幻境(福利)】活动已结束!")
    end
end

-- 木之幻境刷怪
function TreeDreamland:TreeMapUpdateMon()
    killmonsters("木之幻境", nil, 0, true, true)
    globaldelaygoto(500, "delay_update_tree_mon")
end
function delay_update_tree_mon()
    local id = ""
    if GetSysInt("G200") >= 1 then
        id = "1"
    end
    for index, info in ipairs(TreeDreamland.tree_mon) do
        local mon_name = info[4] .. id
        genmonex(info[1], info[2], info[3], mon_name, info[5], info[6], info[7], info[8], info[9])
    end
    globalcleardelaygoto("delay_update_tree_mon", 1)
end

-- 木之幻境清怪
function TreeDreamland:cleanTreeMapMon()
    local mon_tab = getobjectinmap("木之幻境", 0, 0, 800, 2)
    for key, mon in pairs(mon_tab or {}) do
        local name = getbaseinfo(mon, 1, 1) or ""
        if string.find(name, "僵尸王") or string.find(name, "爆不爆谁知道") then
            killmonbyobj("0", mon, false, false, false)
        end
    end
end

function tree_map_schedule()
    local run_time = GetSysInt("G_tree_state_run_time") + 1
    SetSysInt("G_tree_state_run_time", run_time)
end

return TreeDreamland