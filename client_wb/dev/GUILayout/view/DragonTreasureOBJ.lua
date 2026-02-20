local DragonTreasureOBJ = {}
DragonTreasureOBJ.Name = "DragonTreasureOBJ"
DragonTreasureOBJ.cfg = GetConfig("DragonTreasureCfg")
DragonTreasureOBJ.count_award = {20,50,100,300,500}

function DragonTreasureOBJ:main(merge_count,day_drwa_count,limit_count)
	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/DragonTreasureUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.merge_count = tonumber(merge_count) or 0 
    self.day_drwa_count = tonumber(day_drwa_count) or 0
    self.limit_count = tonumber(limit_count) or 0
    self.is_recharge = false
    GUI:addOnClickEvent(self.ui.close_btn,function ()
    	ViewMgr.close("DragonTreasureOBJ")
    end)
    for i=1,2 do
    	GUI:addOnClickEvent(self.ui["find_treasure_btn"..i],function ( ... )
    		SendMsgCallFunByNpc(0,"DragonTreasure","FindTreasureClick",i)
    	end)
    end

    GUI:addOnClickEvent(self.ui.money_btn,function ()
    	self.is_recharge = false
    	self:ShowBuyTip(false)
    end)

    GUI:addOnClickEvent(self.ui.buy_btn,function ()
    	if self.limit_count >= 1 then
    		SendMsgCallFunByNpc(0,"DragonTreasure","BuyClick",1 .. "#"..1)
    	else
    		self.is_recharge = true
    		self:ShowBuyTip(true)
    	end
    end)
    GUI:addOnClickEvent(self.ui.buy_tip_close,function ( ... )
    	GUI:setVisible(self.ui.buy_tip,false)
    end)

    GUI:addOnClickEvent(self.ui.buy_one_btn,function ()
    	SendMsgCallFunByNpc(0,"DragonTreasure","BuyClick",1 .."#".. (self.is_recharge and 1 or 0))
    end)

    GUI:addOnClickEvent(self.ui.buy_ten_btn,function ()
    	SendMsgCallFunByNpc(0,"DragonTreasure","BuyClick",10 .."#".. (self.is_recharge and 1 or 0))
    end)

    self.select_list = {}
    self:InitViewinfo()
    self:UpdaViewInfo()
end

function DragonTreasureOBJ:ShowBuyTip(is_recharge)
	GUI:setVisible(self.ui.buy_tip,true)
	local str = is_recharge and "<font color='#ff00ff'>￥19元 </font>获得：<font color='#ffff00'>黄金钥匙*10</font>" or "<font color='#ff00ff'>元宝 </font>购买：<font color='#ffff00'>黄金钥匙*10</font>"
	local str2 = is_recharge and "<font color='#ff00ff'>￥190元 </font>获得：<font color='#ffff00'>黄金钥匙*100</font>" or "<font color='#ff00ff'>元宝 </font>购买：<font color='#ffff00'>黄金钥匙*100</font>"
	if self.ui.ten_rich then
		removeOBJ(self.ui.ten_rich,self)
	end
	if self.ui.one_hundred_rich then
		removeOBJ(self.ui.one_hundred_rich,self)
	end
	GUI:RichText_Create(self.ui.buy_tip,"ten_rich",39,109,str,250,16,"#FFFFFF")
	GUI:RichText_Create(self.ui.buy_tip,"one_hundred_rich",39,43,str2,250,16,"#FFFFFF")
end

function DragonTreasureOBJ:InitViewinfo()
	local cfg = self.cfg[(self.merge_count >= 9 and 9 or self.merge_count)]
	local list = {}
	local str_tab = string.split(cfg.reward_list,"|") 
	for i,v in ipairs(str_tab) do
		local item_tab = string.split(v,"#")
		ItemShow_updateItem(self.ui["reward_item_"..i],{index = SL:Get_ITEM_INDEX_BY_NAME(item_tab[1]),count = tonumber(item_tab[2]),look =true,bgVisible = true,color = 251})
	end
	ItemShow_updateItem(self.ui["fashion_item"],{index = SL:Get_ITEM_INDEX_BY_NAME("[时装激活卡]独孤求败"),count = 1,look =true,bgVisible = true})
	local jindu_tab = string.split(cfg.jindu_reward_list,"|")
	for i,v in ipairs(jindu_tab) do
		local item_tab = string.split(v,"#")
		ItemShow_updateItem(self.ui["jindu_item_"..i],{index = SL:Get_ITEM_INDEX_BY_NAME(item_tab[1]),count = tonumber(item_tab[2]),look =true,bgVisible = true,color = 251})
	end
end

function DragonTreasureOBJ:UpdaViewInfo()
	GUI:Text_setString(self.ui.gold_key_text,"黄金钥匙：".. SL:Get_ITEM_COUNT("黄金钥匙"))
	GUI:Text_setString(self.ui.day_draw_count_text,string.format("你今日已寻宝：%s次",self.day_drwa_count) )
	GUI:Text_setString(self.ui.limit_count_text,string.format("%s/10",self.limit_count))
	GUI:setVisible(self.ui.buy_btn,self.limit_count < 10)
	GUI:setVisible(self.ui.has_bug_flag,self.limit_count >= 10)
	for i=1,2 do
		local is_enough = i == 1 and SL:Get_ITEM_COUNT("黄金钥匙") >= 1 or  SL:Get_ITEM_COUNT("黄金钥匙") >= 10
		GUI:Text_setTextColor(self.ui["find_btn_text"..i], is_enough and "#00FF00" or "#ff0000")
	end
	for i=1,13 do
		GUI:setVisible(self.ui["select_img"..i],isInTable(self.select_list,i)) 
	end 
	for i=1,5 do
		GUI:setVisible(self.ui["jindu_get_flag"..i],self.day_drwa_count >=  self.count_award[i])
	end
end

function DragonTreasureOBJ:flushView( ... )
	local tab = {...}
	if tab[1] == "lottery_flush" then
		self.select_list = SL:JsonDecode(tab[2]) or {}
		self.day_drwa_count = tonumber(tab[3]) or 0
		self:UpdaViewInfo()
	elseif tab[1] == "buy_flush" then
		GUI:setVisible(self.ui.buy_tip,false)
		self:UpdaViewInfo()
	elseif tab[1] == "recharge" then
		GUI:setVisible(self.ui.buy_tip,false)
		self.limit_count = tonumber(tab[2]) or 0
		self:UpdaViewInfo()
	end
	SL:onLUAEvent(VIEW_BTN_RED_CHECK,{["view_name"] = "DragonTreasureOBJ",["node"] = self,["is_all"] = true})
end

return DragonTreasureOBJ