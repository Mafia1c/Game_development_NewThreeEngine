---item_count 道具数量；check_bind_money_count 多货币检测； money_count 单个货币检测； inside_list 是否在列表内；  inside_map 是否在map里面
--call_fun 调用前端界面函数； view_red_name 检测脚本所有红点；child_node_cache 检查红点配置 子节点缓存； var_int 后端发送到前端变量
--job 检查职业； map_id 检查地图； get_equipbypos 获取装备位；actor_level 玩家等级； skill_level 技能等级；open_view_var 前端界面 self变量； permanent 常驻显示
RedPointMgr = RedPointMgr or {}
SL:Require("GUILayout/common/RedPointParser", true)
SL:Require("GUILayout/common/CommonFunc", true)
RedPointMgr._GuideWidgetConfig = SL:RequireFile(GUIDefine.PATH_GUIDE_CONFIG)

RedPointMgr.red_cfg = GetConfig("RedPointCfg")  --主界面红点
RedPointMgr.red_data_cfg = GetConfig("RedViewPointDataCfg")  --界面红点配置
RedPointMgr.bubblecfg = GetConfig("BubbleCfg")  --气泡

RedPointMgr.red_btn_point_data_cache = {}       
RedPointMgr.open_view_list = {}                 -- 打开的界面 
RedPointMgr.redPoint_check_count = 10
RedPointMgr.start_index = 0
RedPointMgr.red_point_data_cache = {}       -- 缓存红点信息 删除的时候要用
RedPointMgr.redpoint_cfg = nil

RedPointMgr.bubble_cfg = nil
RedPointMgr.bubble_cache = {}
RedPointMgr.cur_show_bubble = {}

if RedPointMgr.red_view_point_data == nil then
	RedPointMgr.red_view_point_data = {}
    for k, v in pairs(RedPointMgr.red_data_cfg) do
    	RedPointMgr.red_view_point_data[v.view_name] = RedPointMgr.red_view_point_data[v.view_name] or {}
    	RedPointMgr.red_view_point_data[v.view_name][v.view_btn_id] = v 
    end
end

--界面调用 获取btn红点数据
function RedPointMgr.GetRedDataByBtnName(view_name,view_btn_id)
	if RedPointMgr.red_view_point_data[view_name] == nil then return end
	return RedPointMgr.red_view_point_data[view_name][view_btn_id]
end

local function Update()
	-- if not SL:Get_KFSTATE() then 
	RedPointMgr:CheckBubbleCfg()
	-- end
    RedPointMgr:CheckRedPointCfg()
end

--单独界面红点
function RedPointMgr:SetViewPointCache(data,is_show)
	if is_show then
		self.red_btn_point_data_cache[data.view_name] = self.red_btn_point_data_cache[data.view_name] or {}
		self.red_btn_point_data_cache[data.view_name][data.view_btn_id] = true
	else
		if self.red_btn_point_data_cache[data.view_name] and self.red_btn_point_data_cache[data.view_name][data.view_btn_id] then
			self.red_btn_point_data_cache[data.view_name][data.view_btn_id] = nil
			if next(self.red_btn_point_data_cache[data.view_name]) == nil then
				self.red_btn_point_data_cache[data.view_name] = nil
			end
		end
	end
	self:SetViewBtnRed(data,is_show)
end

function RedPointMgr:SetViewBtnRed(data,is_show)
	if RedPointMgr.open_view_list[data.view_name] then
		local node = RedPointMgr.open_view_list[data.view_name]
		if node == nil or node.ui == nil or node.ui[data.view_btn_id] == nil then return end
 		if is_show then
 			if node.ui[data.view_btn_id.."_Red"] == nil then
 				RedPointMgr:CreateViewRedPointData(data,node)
 			end
 		else
 			if node.ui[data.view_btn_id.."_Red"] then
 				RedPointMgr:DelViewRedPointData(data,node)
 			end
 		end
	end
end

function RedPointMgr.GetViewRedBtnCache(view_name,view_btn_id)
	if RedPointMgr.red_btn_point_data_cache[view_name] == nil or RedPointMgr.red_btn_point_data_cache[view_name][view_btn_id] == nil then
		return false
	end
	return true
end

function RedPointMgr.AddOpenView(view_name,node)
	RedPointMgr.open_view_list[view_name] = node
  	for k,v in pairs(RedPointMgr.red_view_point_data[view_name] or {}) do
  		local is_ok = false
  		if not RedPointMgr:GetViewRedBtnCache(view_name,v.view_btn_id) then
  	 		is_ok = RedPointParser.CheckRedPointVars(v.varCondition)
	  	 	RedPointMgr:SetViewPointCache(v,is_ok)
  		else
  			is_ok = true
  			RedPointMgr:SetViewBtnRed(v,is_ok)
  		end
  	end 
end

function RedPointMgr.RemoveOpenView(view_name)
	RedPointMgr.open_view_list[view_name] = nil
end


function RedPointMgr:CreateViewRedPointData(data,node)
	GUI:RedDot_Create(node.ui[data.view_btn_id], data.view_btn_id.."_Red", data.pos_x, data.pos_y, 0, "res/custom/red1.png")
	-- GUI:RedDot_Create(node.ui[data.view_btn_id], data.view_btn_id.."_Red", 80,80, 0, "res/custom/red1.png")
end

function RedPointMgr:DelViewRedPointData(data,node)
  	local reddot = node.ui[data.view_btn_id.."_Red"]
    if GUI:Win_IsNotNull(reddot) then
        removeOBJ(reddot,node)
    end
end

---主界面红点
function RedPointMgr:CheckRedPointCfg()
  	if self.redpoint_cfg == nil then
        self.redpoint_cfg = {}
        local cfg = RedPointMgr.red_cfg
        for k, v in ipairs(cfg) do
	        self.red_point_data_cache[v.key_name] = {}
            table.insert(self.redpoint_cfg,  SL:CopyData(v))
        end
        self.start_index = 0
        self.redPoint_total_count = #self.redpoint_cfg
    end
    for i = 1, self.redPoint_check_count do
        cur_index = i + self.start_index
        local v = self.redpoint_cfg[cur_index]
        if v  then
        	local is_ok = false
        	if v.view_name and next(self.bubble_cache[v.view_name] or {}) then
        		is_ok = true
        	else
        	 	is_ok = RedPointParser.CheckRedPointVars(v.varCondition)
        	end
            if true == v._is_check_ok  then
                if not is_ok then
                    v._is_check_ok = false
                    self:DelRedPointData(v)
                end
            else
                if is_ok then
                    v._is_check_ok = true                               -- 标记这一条已经检测通过了
                    self:CreateRedPointData(v)
                end
            end  
        end
    end


    self.start_index = self.start_index + self.redPoint_check_count
    if self.start_index > self.redPoint_total_count + 1 then
        self.start_index = 0
    end
end

function RedPointMgr.findNode(mainId,uiId)
    local idx = tonumber(mainId) 
    local getNodesFunc = RedPointMgr._GuideWidgetConfig[idx]
    if not getNodesFunc then
        return
    end
    local temp = { typeassist = uiId }
    local _widget ,_parent= getNodesFunc(temp)

    if (not _widget) or (not _parent) then
        return nil
    end
    return _widget
end

function RedPointMgr:CreateRedPointData(data)
	UIOperator:RefreshRedDot({add = 1,mainId=data.win_id,uiId = data.btn_id,x = data.pos_x,y = data.pos_y,mode = data.red_type,res = data.path})
	table.insert(self.red_point_data_cache[data.key_name],data) 
end

-- 删除红点
function RedPointMgr:DelRedPointData(data)
    local red_tabs = self.red_point_data_cache[data.key_name]
    for k, v in pairs(red_tabs) do
		UIOperator:RefreshRedDot({add = 0,mainId=data.win_id,uiId = data.btn_id,x = data.pos_x,y = data.pos_y,mode = data.red_type,res = data.path})
    end
    self.red_point_data_cache[data.key_name] = {}
end

function RedPointMgr:CheckBubbleCfg()
	 if self.bubble_cfg == nil then
        self.bubble_cfg = {}
        for k, v in pairs(self.bubblecfg) do
        	self.bubble_cache[v.view_name] = self.bubble_cache[v.view_name] or {}  
            table.insert(self.bubble_cfg, SL:CopyData(v))
        end
    end
    for k, v in pairs(self.bubble_cfg) do
        local is_ok = false
    	if self.red_point_data_cache and  self.red_point_data_cache[v.view_name] then
    		is_ok = true
    	else
    		is_ok = RedPointParser.CheckRedPointVars(v.varCondition)
    	end
        if true == v._is_check_ok then
            if not is_ok then
                v._is_check_ok = false
                self:DelBubbleData(v)
            end
        else
            if is_ok and self.cur_show_bubble[v.view_name] == nil then
                v._is_check_ok = true
                self:CreateBubbleData(v)
            end
        end
    end
end

function RedPointMgr:DelBubbleData(data)
	SL:RemoveUpgradeBtn(data.key_name)
  	self.bubble_cache[data.view_name][data.key_name] = nil
	self.cur_show_bubble[data.view_name] = nil
end

function RedPointMgr:CreateBubbleData(data)
	if self.cur_show_bubble[data.view_name] == nil then
		self.cur_show_bubble[data.view_name] = data.view_name
		SL:AddUpgradeBtn(data.key_name, data.bubble_name,function ()
			SendMsgClickSysBtn("0#OtherSysFunc#bubble_jump#"..data.key_name)
		end)
	end
	self.bubble_cache[data.view_name][data.key_name] = data
end

if RedPointMgr.sch then
    SL:UnSchedule(RedPointMgr.sch)
end 
RedPointMgr.sch = SL:Schedule(Update, 2)

-- 更新顶部按钮显示
local function update_callBack()
	for k,v in pairs(RedPointMgr.red_point_data_cache) do
		for i,data in ipairs(v) do
			UIOperator:RefreshRedDot({add = 1,mainId=data.win_id,uiId = data.btn_id,x = data.pos_x,y = data.pos_y,mode = data.red_type,res = data.path})
		end
	end
end

SL:UnRegisterLUAEvent(MAIN_TOP_BTN_CHANGE, "flush_top_btn_show")
SL:RegisterLUAEvent(MAIN_TOP_BTN_CHANGE, "flush_top_btn_show", update_callBack)

SL:UnRegisterLUAEvent(VIEW_BTN_RED_CHECK, "redupdata")
SL:RegisterLUAEvent(VIEW_BTN_RED_CHECK, "redupdata", function (list)
	RedPointMgr.open_view_list[list.view_name] = list.node

	if list.is_all then
		for k,v in pairs(RedPointMgr.red_view_point_data[list.view_name] or {}) do
			local is_ok = RedPointParser.CheckRedPointVars(v.varCondition)
	  	 	RedPointMgr:SetViewPointCache(v,is_ok)
		end
	else
		for k,v in pairs(list) do
			if v ~= nil and v.varCondition then
				local is_ok = RedPointParser.CheckRedPointVars(v.varCondition)
		  	 	RedPointMgr:SetViewPointCache(v,is_ok)
			end
		end
	end
end)
