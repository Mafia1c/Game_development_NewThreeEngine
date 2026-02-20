---alg工作台
---xls转lua table
---本工具免费 交流QQ群:436063587
---class lua类名
---func 全局函数名
---openTime 活动开启时间
---closeTime 活动关闭时间
---endTime 活动结束时间
---SysIntVarName 活动变量标记  同一个活动使用不同变量
---runType:
---0:指定时间
---1:每天执行
---2:每周执行
---3:每月执行
local config = {
	-- 新区活动
	["newServer"] = {
		[1] = {
			["key_name"]="天降财宝",
			["funcName"] = "WorldTreasure",
			["openDay"]=0,
			["openTime"] = 15 * 60,                      -- 开始时间
			["closeTime"] = nil,                         -- 关闭时间(入口关闭)
			["endTime"] = 25 * 60,                       -- 结束时间
			["SysIntVarName"] = "G_tjcb_activity_state1",
			["openDesc"]="<【活动提示】∶/FCOLOR=250><〖天降财宝〗/FCOLOR=253>已开启，活动地图掉落海量经验、元宝、材料，快快前往！",
			["closeDesc"] = nil,
			["endDesc"] = "【系统】：全服活动→天降财宝，活动已结束，请期待下次活动！"
		},
		[2] = {
			["key_name"]="天降财宝",
			["funcName"] = "WorldTreasure",
			["openDay"]=0,
			["openTime"] = 60 * 60,                      -- 开始时间
			["closeTime"] = nil,                    	 -- 关闭时间(入口关闭)
			["endTime"] = 70 * 60,                       -- 结束时间
			["SysIntVarName"] = "G_tjcb_activity_state2",
			["openDesc"]="<【活动提示】∶/FCOLOR=250><〖天降财宝〗/FCOLOR=253>已开启，活动地图掉落海量经验、元宝、材料，快快前往！",
			["closeDesc"] = nil,
			["endDesc"] = "【系统】：全服活动→天降财宝，活动已结束，请期待下次活动！"
		},
		[3] = {
			["key_name"]="激情派对",
			["funcName"] = "PassionParty",
			["openDay"]=0,
			["openTime"] = 30 * 60,                      -- 开始时间
			["closeTime"] = nil,                         -- 关闭时间(入口关闭)
			["endTime"] = 40 * 60,                       -- 结束时间
			["SysIntVarName"] = "G_jqpd_activity_state1",
			["openDesc"]="<【活动提示】∶/FCOLOR=250><〖激情派对〗/FCOLOR=253>已开启，活动地图每秒可获得大量经验、元宝，快快前往！",
			["closeDesc"] = nil,
			["endDesc"] = "【系统】：全服活动→激情派对，活动已结束，请期待下次活动！"
		},
		[4] = {
			["key_name"]="激情派对",
			["funcName"] = "PassionParty",
			["openDay"]=0,
			["openTime"] = 80 * 60,                      -- 开始时间
			["closeTime"] = nil,                    	 -- 关闭时间(入口关闭)
			["endTime"] = 90 * 60,                       -- 结束时间
			["SysIntVarName"] = "G_jqpd_activity_state2",
			["openDesc"]="<【活动提示】∶/FCOLOR=250><〖激情派对〗/FCOLOR=253>已开启，活动地图每秒可获得大量经验、元宝，快快前往！",
			["closeDesc"] = nil,
			["endDesc"] = "【系统】：全服活动→激情派对，活动已结束，请期待下次活动！"
		},
		[5] = {
			["key_name"]="武林至尊",
			["funcName"] = "WuLinMaster",
			["openDay"]=0,
			["openTime"] = 45 * 60,                      -- 开始时间
			["closeTime"] = 55*60,                    	 -- 关闭时间(入口关闭)
			["endTime"] = 60*60,                       -- 结束时间
			["SysIntVarName"] = "G_wlzz_activity_state",
			["openDesc"]="<【活动提示】∶/FCOLOR=250><〖武林至尊〗/FCOLOR=253>最终胜出者可以获得<〖武林盟主称号〗/FCOLOR=250>",
			["closeDesc"] = nil,
			["endDesc"] = nil,
		},
		[6] = {
			["key_name"]="夺宝奇兵",
			["funcName"] = "LootSoldier",
			["openDay"]=0,
			["openTime"] = 120 * 60,                      -- 开始时间
			["closeTime"] = nil,                    	 -- 关闭时间(入口关闭)
			["endTime"] = nil,                       -- 结束时间
			["SysIntVarName"] = "G_dbqb_activity_state",
			["openDesc"]="<【活动提示】∶/FCOLOR=250><〖夺宝奇兵〗/FCOLOR=253>已开启，持有宝箱120秒会获得<超级装备/FCOLOR=250>！",
			["closeDesc"] = nil,
			["endDesc"] = nil,
			["customCloseVar"] = "J_dbqb_close_flag"
		},
		[7] = {
			["key_name"]="世界boss",
			["funcName"] = "WordBoss",
			["openDay"]=0,
			["openTime"] = 150 * 60,                      -- 开始时间
			["closeTime"] = nil,                    	 -- 关闭时间(入口关闭)
			["endTime"] = nil,                       -- 结束时间
			["SysIntVarName"] = "G_sjbs_activity_state1",
			["openDesc"]="<【活动提示】∶/FCOLOR=250><终极大魔王/FCOLOR=251>已出现在<〖世界BOSS〗/FCOLOR=253>地图，击杀必爆超级装备！",
			["closeDesc"] = nil,
			["endDesc"] = nil,
			["customCloseVar"] = "J_sjbs_close_flag"
		},
		[8] = {
			["key_name"]="行会战场",
			["funcName"] = "GuildBattlefield",
			["openDay"]=0,
			["openTime"] = 180 * 60,                      -- 开始时间
			["closeTime"] = 190 * 60,                    	 -- 关闭时间(入口关闭)
			["endTime"] = nil,                       -- 结束时间
			["SysIntVarName"] = "G_hhzc_activity_state1",
			["openDesc"]="<【活动提示】∶/FCOLOR=250><行会大魔王/FCOLOR=251>已出现在<〖行会战场〗/FCOLOR=253>击杀必爆超级装备！",
			["closeDesc"] = "<【活动提示】∶/FCOLOR=250><行会战场/FCOLOR=251>入口<〖已经关闭〗/FCOLOR=253>各行会尽快清理敌人！",
			["endDesc"] = nil,
			["customCloseVar"] = "J_hhzc_close_flag"
		},
		[9] = {
			["key_name"]="乱斗之王",
			["funcName"] = "MeleeBattleKing",
			["openDay"]=0,
			["openTime"] = 240 * 60,                      -- 开始时间
			["closeTime"] = 250 * 60,                    	 -- 关闭时间(入口关闭)
			["endTime"] = nil,                       -- 结束时间
			["SysIntVarName"] = "G_ldzw_activity_state1",
			["openDesc"]= "<【活动提示】∶/FCOLOR=250><暗黑帝王/FCOLOR=251>已出现在<〖乱斗之王〗/FCOLOR=253>勇士们快去击杀！",
			["closeDesc"] = nil,
			["endDesc"] = nil,
			["customCloseVar"] = "J_ldzw_close_flag"
		},
		[10] = {
			["key_name"]="狂暴霸主",
			["funcName"] = "RageMaster",
			["openDay"]=0,
			["openTime"] = 300 * 60,                      -- 开始时间
			["closeTime"] = nil,                    	 -- 关闭时间(入口关闭)
			["endTime"] = nil,                       -- 结束时间
			["SysIntVarName"] = "G_kbbz_activity_state1",
			["openDesc"]= " <【活动提示】∶/FCOLOR=250><〖狂暴霸主〗/FCOLOR=253>已出现在活动地图，必爆高级装备！",
			["closeDesc"] = nil,
			["endDesc"] = nil,
			["customCloseVar"] = "J_kbbz_close_flag"
		},
	},
	-- 老区活动
	["oldServer"] = {
		[1] = {
			["key_name"]="世界boss",
			["activeName"]="世界boss",
			["funcName"] = "WordBoss",
			["class"]=nil,
			["openDay"]=1,
			["runType"]=1,
			["openTime"] = "18:30:00",
			["closeTime"] = nil,
			["endTime"] = nil,
			["openDesc"]="<【活动提示】∶/FCOLOR=250><终极大魔王/FCOLOR=251>已出现在<〖世界BOSS〗/FCOLOR=253>地图，击杀必爆超级装备！",
			["SysIntVarName"] = "G_sjbs_activity_state2",
			["customCloseVar"] = "J_sjbs_close_flag"
		},
		[2] = {
			["key_name"]="行会战场",
			["activeName"]="行会战场",
			["funcName"] = "GuildBattlefield",
			["class"]=nil,
			["openDay"]=1,
			["runType"]=1,
			["openTime"] = "23:01:00",
			["closeTime"] = "23:11:00",
			["endTime"] = nil,
			["openDesc"]="<【活动提示】∶/FCOLOR=250><行会大魔王/FCOLOR=251>已出现在<〖行会战场〗/FCOLOR=253>击杀必爆超级装备！",
			["closeDesc"] = "<【活动提示】∶/FCOLOR=250><行会战场/FCOLOR=251>入口<〖已经关闭〗/FCOLOR=253>各行会尽快清理敌人！",
			["SysIntVarName"] = "G_hhzc_activity_state2",
			["customCloseVar"] = "J_hhzc_close_flag"
		},
		[3] = {
			["key_name"]="乱斗之王",
			["activeName"]="乱斗之王",
			["funcName"] = "MeleeBattleKing",
			["class"]=nil,
			["openDay"]=1,
			["runType"]=1,
			["openTime"] = "19:10:00",
			["closeTime"] = "19:20:00",
			["endTime"] = nil,
			["openDesc"]="<【活动提示】∶/FCOLOR=250><暗黑帝王/FCOLOR=251>已出现在<〖乱斗之王〗/FCOLOR=253>勇士们快去击杀！",
			["closeDesc"] = "",
			["SysIntVarName"] = "G_ldzw_activity_state2",
			["customCloseVar"] = "J_ldzw_close_flag"
		},
	},
}
 return config;