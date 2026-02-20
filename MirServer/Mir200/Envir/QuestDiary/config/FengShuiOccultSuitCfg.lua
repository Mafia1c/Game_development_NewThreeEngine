---alg工作台
---xls转lua table
---本工具免费 交流QQ群:436063587
local config = {
 
	[1] = {
 		["key_name"]=1,
		["active_num"]=3,
		["attr_str"]=[[3#26#3|3#27#3]],
		["suit_desc"]=[[<激活：三字成阵/FCOLOR=250>\\<物理伤害减少：3%/FCOLOR=254>\\<魔法伤害减少：3%/FCOLOR=254>]], 
	},
	[2] = {
 		["key_name"]=2,
		["active_num"]=6,
		["attr_str"]=[[3#35#600|3#36#600|3#37#600]],
		["suit_desc"]=[[<激活：六字通玄/FCOLOR=250>\\<攻魔道：6%/FCOLOR=254>\\<双防：6%/FCOLOR=254>]], 
	},
	[3] = {
 		["key_name"]=3,
		["active_num"]=9,
		["attr_str"]=[[3#21#3|3#23#3]],
		["suit_desc"]=[[<激活：九字归真/FCOLOR=250>\\<暴击几率增加：3%/FCOLOR=254>\\<韧性：3%/FCOLOR=254>]], 
	},
	[4] = {
 		["key_name"]=4,
		["active_num"]=12,
		["attr_str"]=[[3#30#10|3#29#3]],
		["suit_desc"]=[[<激活：十二字破虚/FCOLOR=250>\\<人物体力增加：10%/FCOLOR=254>\\<所有伤害反弹：3%/FCOLOR=254>]], 
	},
	[5] = {
 		["key_name"]=5,
		["active_num"]=15,
		["attr_str"]=[[3#22#6|3#25#6]],
		["suit_desc"]=[[<激活：十五字逆天/FCOLOR=250>\\<暴击伤害增加：6%/FCOLOR=254>\\<增加攻击伤害：6%/FCOLOR=254>]], 
	},
	[6] = {
 		["key_name"]=6,
		["active_num"]=16,
		["attr_str"]=[[20]],
		["suit_desc"]=[[<激活：十六字圆满/FCOLOR=250>\\<死亡时20%几率/FCOLOR=253>\\<满血复活/FCOLOR=253>]], 
	},  
}
 return config;