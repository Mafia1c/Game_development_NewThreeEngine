local GodBeastSoulOBJ = {}
GodBeastSoulOBJ.Name = "GodBeastSoulOBJ"
GodBeastSoulOBJ.cfg = GetConfig("GodBeastSoulCfg")

function GodBeastSoulOBJ:main(level)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/GodBeastSoulUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_level = tonumber(level) or 0 
    GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close("GodBeastSoulOBJ")
    end)
    GUI:addOnClickEvent(self.ui.up_level_btn,function ( )
    	SendMsgCallFunByNpc(120,"GodBeastSoul","UpLevelClick")
    end)
    self:UpdaViewInfo()
end

function GodBeastSoulOBJ:UpdaViewInfo()
	for i=1,9 do
		GUI:setGrey(self.ui["Effect_"..i],(self.cur_level %10) < i)
	end
	GUI:TextAtlas_setString(self.ui.TextAtlas,math.floor(self.cur_level / 10))
	local is_max = self.cur_level >= #self.cfg
	GUI:setVisible(self.ui.item_box,not is_max)
	
	GUI:setVisible(self.ui.up_level_btn,not is_max)
	GUI:setVisible(self.ui.max_img,is_max)
	GUI:Text_setString(self.ui.max_tip_text,is_max and "兽灵已满级" or "进度[	        ]")  
	GUI:Text_setTextColor(self.ui.max_tip_text,is_max and "#FF00FF" or "#C6C6CE") 
	GUI:Text_setString(self.ui.level_text,string.format(" %s/9",(self.cur_level % 10)))  
	GUI:setVisible(self.ui.level_text,not is_max)
	local cfg = self.cfg[self.cur_level]
	GUI:setVisible(self.ui.need_money_text,not is_max and cfg.need_money ~= nil)
	for i=1,4 do
		GUI:setVisible(self.ui["ItemShow_"..i],cfg["need_count"..i] > 0)
		local name = cfg["need_item"..i]
		local count = cfg["need_count"..i]
		if count >= 0 then
			local color = SL:Get_ITEM_COUNT(name) >= count and 250 or 249
			ItemShow_updateItem(self.ui["ItemShow_"..i],{showCount=true,index = SL:Get_ITEM_INDEX_BY_NAME(name),count = count,look =true,bgVisible=true,color = color})
		end
	end
	if cfg.need_money then
		local color = tonumber(SL:Get_MONEY_ASSOCIATED(SL:Get_ITEM_INDEX_BY_NAME(cfg.need_money))) >= cfg.need_money_count and "#00FF00" or "#ff0000"
		GUI:Text_setString(self.ui.need_money_text,cfg.need_money_count .. cfg.need_money)
		GUI:Text_setTextColor(self.ui.need_money_text,color)
	end
	GUI:UserUILayout(self.ui.item_box, {
        dir=2,
        addDir=2,
        interval=0.01,
        gap = {x=15},
    })
	local next_cfg = self.cfg[self.cur_level + 1] or self.cfg[self.cur_level]
   	for i=1,6 do
   		if i == 1 then
   			GUI:Text_setString(self.ui["cur_attr1"],cfg["attr1"].."-"..cfg["attr2"])
   			GUI:Text_setString(self.ui["next_attr1"],next_cfg["attr1"].."-"..next_cfg["attr2"])
   		else
   			GUI:Text_setString(self.ui["cur_attr"..i],cfg["attr"..i+1].."%")
   			GUI:Text_setString(self.ui["next_attr"..i],next_cfg["attr"..i+1].."%")
   		end
   	end
   	GUI:Button_setTitleText(self.ui.up_level_btn,self.cur_level %10 == 9 and "突破" or "开始升级")
end

function GodBeastSoulOBJ:flushView(level)
	self.cur_level = tonumber(level) or 0 
    self:UpdaViewInfo()
end
return GodBeastSoulOBJ