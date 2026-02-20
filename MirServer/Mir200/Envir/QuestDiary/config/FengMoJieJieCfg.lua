---alg工作台
---xls转lua table
---本工具免费 交流QQ群:436063587
local config = {
 
	[1] = {
 		["key_name"]=1,
		["name"]=[[进入结界之地]],
		["mapid"]=[[封魔结界1]],
		["needvar_arr"]={"帝王印记",1,}, 
	},
	[2] = {
 		["key_name"]=2,
		["name"]=[[进入结界禁地]],
		["mapid"]=[[封魔结界2]],
		["needvar_arr"]={"帝王印记",1,}, 
	},
	[3] = {
 		["key_name"]=3,
		["name"]=[[投放结界魔石]],
		["needitem"]=[[仙石]],
		["itemnum"]=10,
		["giveitem"]=[[帝王印记]],
		["num"]=1, 
	},
	[4] = {
 		["key_name"]=4,
		["name"]=[[投放10次]],
		["giveitem"]=[[黄金钥匙]],
		["num"]=1, 
	},
	[5] = {
 		["key_name"]=5,
		["name"]=[[投放20次]],
		["giveitem"]=[[黄金钥匙]],
		["num"]=1, 
	},
	[6] = {
 		["key_name"]=6,
		["name"]=[[投放30次]],
		["giveitem"]=[[黄金钥匙]],
		["num"]=1, 
	},
	[7] = {
 		["key_name"]=7,
		["name"]=[[投放999次]],
		["mapid"]=[[封魔结界1]],
		["mobmon"]=[[永夜帝王·米尔迦兰]], 
	},
	[8] = {
 		["key_name"]=8,
		["name"]=[[兑换]],
		["needitem"]=[[帝王印记]],
		["itemnum"]=588,
		["giveitem"]=[[永夜先驱者(称号)]],
		["num"]=1, 
	},
	[9] = {
 		["key_name"]=9,
		["name"]=[[兑换]],
		["needitem"]=[[帝王印记]],
		["itemnum"]=1688,
		["giveitem"]="[坐骑激活卡]武圣将军",
		["num"]=1, 
	},
	[10] = {
 		["key_name"]=10,
		["name"]=[[兑换]],
		["needitem"]=[[帝王印记]],
		["itemnum"]=2988,
		["giveitem"]="[时装激活卡]魔王撒旦",
		["num"]=1, 
	},
	[11] = {
 		["key_name"]=11,
		["name"]=[[召唤]],
		["mapid"]=[[封魔结界2]],
		["needitems_map"]={["力量魔石"]=1,["智慧魔石"]=1,["权利魔石"]=1,["信仰魔石"]=1,["精神魔石"]=1,},
		["mobmon"]=[[永夜帝王·米尔迦兰]], 
	},  
}
 return config;