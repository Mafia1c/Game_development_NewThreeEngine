local ActivityCenterOBJ = {}
ActivityCenterOBJ.Name = "ActivityCenterOBJ"
ActivityCenterOBJ.cfg = GetConfig("ActivityUICfg")
ActivityCenterOBJ.RunAction = true

function ActivityCenterOBJ:main(page, sMsg, sMsg2)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/ActivityCenterUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_page_index = tonumber(page) or 1

    self:initClickEvent()
    self:onChangePage()
    self:showPageInfo(self.cur_page_index, sMsg, sMsg2)
end

function ActivityCenterOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    for i = 1, 9 do
        GUI:addOnClickEvent(self.ui["Button_"..i], function()
            if i == self.cur_page_index then
                return
            end
            SendMsgClickMainBtn("0#ActivityCenter#onPageChange#"..i)
        end)
    end

    GUI:addOnClickEvent(self.ui.goto_btn,function ()
        SendMsgClickMainBtn("0#ActivityCenter#onSelectActivity#"..self.cur_page_index)
    end)
    for i=1,4 do
        GUI:addOnClickEvent(self.ui["pointbtn"..i],function ()
             SendMsgClickMainBtn("0#ActivityCenter#onSelectActivity#".. 9 .."#"..i)
        end)
        GUI:addOnClickEvent(self.ui["map_point_btn"..i],function ()
             SendMsgClickMainBtn("0#ActivityCenter#onSelectActivity#".. 9 .."#"..i)
        end)
    end
    GUI:addOnClickEvent(self.ui["shop_btn"],function ()
        SL:JumpTo(10)
    end)
end

function ActivityCenterOBJ:onChangePage(index)
    index = index or self.cur_page_index
    GUI:Button_loadTextureNormal(self.ui["Button_"..self.cur_page_index], "res/custom/npc/ta1.png")
    GUI:Button_loadTextureNormal(self.ui["Button_"..index], "res/custom/npc/ta0.png")

    local bg_path = {
        "res/custom/npc/18hd/bg1.png",
        "res/custom/npc/18hd/bg2.png",
        "res/custom/npc/18hd/bg3.png",
        "res/custom/npc/18hd/bg4.png",
        "res/custom/npc/18hd/bg5.png",
        "res/custom/npc/18hd/bg6.png",
        "res/custom/npc/18hd/bg7.png",
        "res/custom/npc/18hd/bg8.png",
        "res/custom/npc/18hd/bg.png",
    }
    GUI:Image_loadTexture(self.ui.bg_Image, bg_path[index])
    local cfg = self.cfg[index]
    local mini_map = cfg.mini_mapid
    local map_img_path = "scene/uiminimap/"..mini_map..".png"
    if SL:IsFileExist(map_img_path) then
        GUI:Image_loadTexture(self.ui["mapImg"], map_img_path)
    else
        local function downloadcallback(isOk, path)
            if isOk then
                GUI:Image_loadTexture(self.ui["mapImg"], path)
            end
            SL:release_print("down load mini img === ", isOk, path, mini_map)
        end
        SL:DownloadMiniMapRes(mini_map+1, downloadcallback)
    end
    GUI:setVisible(self.ui["Node_1"], index <= 8)
    GUI:setVisible(self.ui["Node_2"], index > 8)
    -- for i = 1, 9 do
    --     GUI:setVisible(self.ui["Node_"..i], index == i)
    -- end

    self.cur_page_index = index

    if self.ui.desc_rich then
        removeOBJ(self.ui.desc_rich,self)
    end

    local rich = GUI:RichText_Create(self.ui.FrameLayout, "desc_rich", 543,363, cfg.desc, 255, 16, "#ffffff",5)
    GUI:setAnchorPoint(rich,0,1)
    for i=1,4 do
        local data = cfg.show_award_list_map[i]
        GUI:setVisible(self.ui["award_"..i],data~= nil)
        if data then
            ItemShow_updateItem(self.ui["award_"..i],{index = SL:Get_ITEM_INDEX_BY_NAME(data[1]),count=data[2],look=true,bgVisible =true})
        end
    end
    GUI:UserUILayout(self.ui.award_box, {
        dir=2,
        addDir=2,
        interval=0.01,
        gap = {x=8},
    })
    GUI:Text_setString(self.ui.new_open_desc_text,cfg.new_open_desc or "")
    GUI:Text_setString(self.ui.old_open_desc_text,cfg.old_open_desc or "此活动只在新区开放")
    GUI:Text_setTextColor(self.ui.old_open_desc_text,cfg.old_open_desc~= nil and "#00ff00" or "#ff0000")
    GUI:setVisible(self.ui.kf_tip,cfg.is_hequ_activity > 0)
end

-- page:  1.天降财宝  2.激情派对  3.武林至尊  4.夺宝奇兵  5.世界BOSS  6.行会战场   7.乱斗之王   8.狂暴霸主    9.跨服沙城
function ActivityCenterOBJ:showPageInfo(page, sMsg, sMsg2)
    sMsg = sMsg or ""
    sMsg2 = sMsg2 or ""
    GUI:Image_loadTexture(self.ui.activity_state_img,sMsg == "1" and "res/custom/npc/18hd/hd1.png" or "res/custom/npc/18hd/hd0.png")
    GUI:setVisible(self.ui.no_open_state,sMsg ~= "1")
    GUI:setVisible(self.ui.goto_btn,sMsg == "1")
    if self.ui.kbjj_text then
        removeOBJ(self.ui.kbjj_text,self) 
    end
    if page == 1 then
        
    elseif page == 2 then

    elseif page == 3 then

    elseif page == 4 then

    elseif page == 5 then

    elseif page == 6 then
    elseif page == 7 then
    elseif page == 8 then

        GUI:Text_Create(self.ui.FrameLayout,"kbjj_text",543,210,18,"#00FFE8",string.format("当前狂暴结界：%s层",sMsg2) )
    elseif page == 9 then

    end
end

function ActivityCenterOBJ:flushView(page, sMsg, sMsg2)
    page = tonumber(page)
    self:onChangePage(page)
    self:showPageInfo(page, sMsg, sMsg2)
end

return ActivityCenterOBJ