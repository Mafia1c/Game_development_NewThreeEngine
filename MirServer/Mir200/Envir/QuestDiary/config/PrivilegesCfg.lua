---alg工作台
---xls转lua table
---本工具免费 交流QQ群:436063587
local config = {
 
	[1] = {
 		["key_name"]=1,
		["type"]=[[白银]],
		["giveitem_arr"]={"书页","绑定元宝","五行精华",},
		["itemnum_arr"]={30,10000,10,},
		["givech"]=[[白银特权]],
		["needitem"]=[[白银特权激活卡]], 
	},
	[2] = {
 		["key_name"]=2,
		["type"]=[[黄金]],
		["giveitem_arr"]={"天命石","绑定元宝","五行精华",},
		["itemnum_arr"]={1,15000,20,},
		["givech"]=[[黄金特权]],
		["needitem"]=[[黄金特权激活卡]], 
	},
	[3] = {
 		["key_name"]=3,
		["type"]=[[钻石]],
		["giveitem_arr"]={"天命石","绑定元宝","吸星大法体验卡",},
		["itemnum_arr"]={2,20000,1,},
		["givech"]=[[钻石特权]],
		["needitem"]=[[钻石特权激活卡]], 
	},  
}
 return config;