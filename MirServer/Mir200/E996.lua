---@meta E996

---
---@class E996lib
---
---标准输入。
---
E996 = {}

---@class object: string


---发送视野内广播消息
---* actor     	玩家对象
---* msgId     	消息ID
---* param1     	参数1
---* param2     	参数2
---* param3     	参数3
---* sMsg     	消息体
---@param actor     	object
---@param msgId     	number
---@param param1     	number
---@param param2     	number
---@param param3     	number
---@param sMsg     	string
function sendrefluamsg(actor, msgId, param1, param2, param3, sMsg) end;

---发送地图消息
---* mapId     	地图id
---* msg     	Json消息内容
---@param mapId     	number
---@param msg     	string
function sendmapmsg(mapId,msg) end;

---设置聊天前缀
---* actor     	玩家对象
---* prefix     	前缀信息，空则清除聊天前缀
---* color     	前缀颜色
---@param actor     	object
---@param prefix     	string
---@param color     	number
function setchatprefix(actor,prefix,color) end;

---打印消息到控制台
---* arr     	打印内容
---@param arr     	any
function release_print(...) end;

---发送自定义颜色的文字信息
---* actor     	玩家对象
---* FColor     	前景色
---* BColor     	背景色
---* Msg     	消息内容
---* flag     	发送对象：<br>0:自己；<br>1：所有人：<br>2：行会；<br>3：当前地图；<br>4：组队；
---@param actor     	object
---@param FColor     	number
---@param BColor     	number
---@param Msg     	string
---@param flag     	number
function guildnoticemsg(actor,FColor,BColor,Msg,flag) end;

---发送聊天框固顶信息
---* actor     	玩家对象
---* type     	<br>发送对象<br>0-所有人<br>1-自己
---* FColor     	字体景色
---* BColor     	背景色
---* time     	显示时间，自动替换内容中的%d
---* msg     	消息内容
---* shoeFlag     	是否显示人物名称<br>0-是<br>1-否
---@param actor     	object
---@param type     	number
---@param FColor     	number
---@param BColor     	number
---@param time     	number
---@param msg     	string
---@param shoeFlag     	number
function sendtopchatboardmsg(actor,type,FColor,BColor,time,msg,shoeFlag) end;

---发送屏幕中间大字体信息
---* actor     	玩家对象
---* FColor     	前景色
---* BColor     	背景色
---* Msg     	消息内容
---* flag     	<br>发送对象：<br>0=发送给自己；<br>1=发送所有人物；<br>2=发送行会；<br>3=发送国家（暂不支持）；<br>4=发送当前地图；<br>7=组队
---* time     	显示时间
---* func     	倒计时结束后跳转的脚本位置，对应脚本需要放QFunction脚本中，使用跳转时，消息文字提示中必须包含%d，用于显示倒计时时间
---@param actor     	object
---@param FColor     	number
---@param BColor     	number
---@param Msg     	string
---@param flag     	string
---@param time     	number
---@param func     	string
function sendcentermsg(actor,FColor,BColor,Msg,flag,time,func) end;

---发送屏幕滚动信息
---* actor     	玩家对象
---* type     	<br>模式，发送对象<br>0-所有人<br>1-自己
---* FColor     	字体景色
---* BColor     	背景色
---* Y     	Y坐标
---* scroll     	滚动次数
---* msg     	消息内容
---@param actor     	object
---@param type     	number
---@param FColor     	number
---@param BColor     	number
---@param Y     	number
---@param scroll     	number
---@param msg     	string
function sendmovemsg(actor,type,FColor,BColor,Y,scroll,msg) end;

---屏幕任意坐标发送公告信息
---* actor     	玩家对象
---* type     	<br>消息类型<br>0-全服<br>1-自己<br>2-组队<br>3-行会<br>4-当前地图
---* msg     	消息内容
---* FColor     	前景色
---* BColor     	背景色
---* X     	X坐标
---* Y     	Y坐标
---@param actor     	object
---@param type     	number
---@param msg     	string
---@param FColor     	number
---@param BColor     	number
---@param X     	number
---@param Y     	number
function sendcustommsg(actor,type,msg,FColor,BColor,X,Y) end;

---主屏幕弹出公告
---* actor     	玩家对象
---* FColor     	前景色
---* BColor     	背景色
---* msg     	公告内容
---* type     	<br>模式，发送对象<br>0-自己<br>1-所有人<br>2-行会<br>3-当前地图<br>4-组队
---* time     	显示时间
---@param actor     	object
---@param FColor     	number
---@param BColor     	number
---@param msg     	string
---@param type     	number
---@param time     	number
function sendmsgnew(actor,FColor,BColor,msg,type,time) end;

---显示倒计时信息提示
---* actor     	玩家对象
---* msg     	消息内容
---* time     	时间，秒
---* FColor     	字体景色
---* mapdelete     	换地图是否删除<br>0-不删除<br>1-删除
---* tag     	跳转的函数字段
---* X     	X坐标
---@param actor     	object
---@param msg     	string
---@param time     	number
---@param FColor     	number
---@param mapdelete     	number
---@param tag     	string
---@param X     	number
function senddelaymsg(actor,msg,time,FColor,mapdelete,tag,X) end;

---过滤全服提示信息
---* actor     	玩家对象
---* flag     	是否过滤<br>0-不过滤<br>1-过滤
---@param actor     	object
---@param flag     	number
function filterglobalmsg(actor,flag) end;

---弹出窗口消息
---* actor     	玩家对象
---* info     	弹出内容
---* flag1     	确定后跳转的接口
---* flag2     	取消后跳转的接口
---@param actor     	object
---@param info     	string
---@param flag1     	string
---@param flag2     	string
function messagebox(actor,info,flag1,flag2) end;

---调用触发
---* actor     	玩家对象
---* type     	<br>触发模式：<br>0小组成员触发<br>1行会成员触发<br>2当前地图的人物触发<br>3当前角色范围的人物触发<br>8当前国家的人物触发
---* label     	跳转后的接口
---* range     	触发模式=3时<br>指定的范围大小
---@param actor     	object
---@param type     	number
---@param label     	string
---@param range     	number
function gotolabel(actor,type,label,range) end;

---新手界面引导功能
---* actor     	玩家对象
---* NPCIndex     	界面ID
---* btnIndex     	按钮索引
---* sMsg     	显示的内容
---@param actor     	object
---@param NPCIndex     	number|string
---@param btnIndex     	number
---@param sMsg     	string
function navigation(actor,NPCIndex,btnIndex,sMsg) end;

---查看别人面板信息
---* actor     	玩家对象
---* useId     	其他玩家的UserID
---* winId     	面板ID：101-装备，106-称号，1011-时装
---@param actor     	object
---@param useId     	string
---@param winId     	number
function viewplayer(actor,useId,winId) end;

---查看自己面板
---* actor     	玩家对象
---* winId     	101=装备 102=状态 103=属性 104=技能 105=生肖 106=称号 1011=时装
---@param actor     	object
---@param winId     	number
function openwindows(actor,winId) end;

---调用TXT脚本命令
---* actor     	玩家对象
---* filename     	文件名
---* label     	标签
---@param actor     	object
---@param filename     	string
---@param label     	number
function callscript(actor,filename,label) end;

---调用传奇脚本命令
---* actor     	玩家对象
---* scriptname     	脚本接口
---* arr     	参数1~参数10
---@param actor     	object
---@param scriptname     	string
---@param arr     	any
function callscriptex(actor,scriptname,arr) end;

---调用传奇脚本命令2
---* actor     	玩家对象
---* scriptName     	脚本接口
---* arr     	参数1~参数10
---@param actor     	object
---@param scriptName     	string
---@param arr     	any
function callcheckscriptex(actor,scriptName,arr) end;

---获取全局信息
---* id     	0: 全局玩家信息<br>1: 部署时间开始 开发天数 开区天数建议获取常量<$KFDAY><br>2: 部署时间开始 开服时间 开服时间建议获取常量<$showtime><br>3: 合服次数<br>4: 合服时间<br>5: 服务器IP<br>6: 玩家数量<br>7: 背包最大数量<br>8: 引擎版本号（以线上版本为准,测试版、本地版可能存在差异）<br>9：游戏id<br>10：服务器名称获取异常,用常量<$SERVERNAME><br>11：服务器id<br>15：引擎标识，老三端为0，新三端为1
---@param id     	number
function globalinfo(id) end;

---获取Envir文件夹下文件列表
function getenvirfilelist() end;

---获取服务器上64位时间戳
function gettcount64() end;

---加载csv表格内容
---* fileName     	文件名
---@param fileName     	string
function newreadcsv(fileName) end;

---读取表里面的第几行第几列内容(0行0列开始)
---* fileName     	文件名
---* row     	行数
---* col     	列数
---@param fileName     	string
---@param row     	number
---@param col     	number
function newdqcsv(fileName,row,col) end;

---获取当前表格最大行数、和获取表格最大列数
---* fileName     	文件名
---* type     	读取目标：0-行数，1-列数
---@param fileName     	string
---@param type     	number
function gethlcsv(fileName,type) end;

---取字符串在csv表格中的行号
---* fileName     	文件名
---* str     	字符串
---* rowLimit     	行数限制，格式：开始行号-结束行号
---* col     	查找的列数
---* findType     	查找类型：<br>0-在开始哪行;<br>1-在最后哪行;
---@param fileName     	string
---@param str     	string
---@param rowLimit     	string
---@param col     	number
---@param findType     	number
function getgjcsv(fileName,str,rowLimit,col,findType) end;

---读取表格
---* path     	表格路径
---@param path     	string
function readexcel(path) end;

---微秒定时器初始化
function mmsreset() end;

---获取微秒定时器经过时间
---* type 	类型：<br>0继续记录<br>1停止记录
---@param type 	number
function mmspass(type) end;

---加载文件1
---* path     	文件路径
---@param path     	string
function include(path) end;

---加载文件2
---* path     	文件路径
---@param path     	string
function require(path) end;

---HTTP请求(post)
---* url     	链接地址
---* suffix     	请求信息
---* head     	请求头
---@param url     	string
---@param suffix     	string
---@param head     	string
function httppost(url,suffix,head) end;

---HTTP请求(get)
---* url     	链接地址
---@param url     	string
function httpget(url) end;

---是否满足指定条件显示（canshowshopitem触发中使用）
---* actor     	玩家对象
---* canShow     	1-不显示，0-显示
---@param actor     	object
---@param canShow     	number
function notallowshow(actor,canShow) end;

---是否满足指定条件购买（canbuyshopitem触发中使用）
---* actor     	玩家对象
---* canBuy     	1-不允许购买，0-允许购买
---@param actor     	object
---@param canBuy     	number
function notallowbuy(actor,canBuy) end;

---敏感词汇检测
---* str     	要检测的文本
---@param str     	string
function exisitssensitiveword(str) end;

---获取IP地址下所有的在线角色名称列表
---* IPAddress     	IP地址
---* getAllPlayers     	是否获取全部玩家列表0/1(默认限制返回200个)
---@param IPAddress     	string
---@param getAllPlayers     	number
function getplaylistbyip(IPAddress,getAllPlayers) end;

---发送登陆信息[反外挂]
---* userId     	玩家唯一ID
---@param userId     	string
function sendloginmsg(userId) end;

---检测登陆信息[反外挂]
---* userId     	玩家唯一ID
---@param userId     	string
function logincheckent(userId) end;

---发送聊天框消息
---* actor     	玩家对象
---* type     	1:自己<br>2:全服<br>3:行会<br>4:当前地图<br>5:组队
---* msg     	消息内容
---@param actor     	object
---@param type     	number
---@param msg     	string
function sendmsg(actor,type,msg) end;

---获取文件列表
---* path     	文件路径
---@param path     	string
function GetFileList(path) end;

---注册虚拟机index
---* idx     	虚拟机编号<br>QF:999999999,QM:999999996
---* scriptfile     	文件路径
---@param idx     	number
---@param scriptfile     	string
function SetSysIndex(idx,scriptfile) end;

---获取当前虚拟机编号
function GetSysIndex() end;

---gbk 转 utf-8
---* str     	gbk
---@param str     	string
function gbktoutf8(str) end;

---utf-8 转 gbk
---* str     	玩家对象
---@param str     	string
function utf8togbk(str) end;

---获取服务器名称
function GetServerName() end;

---获取区服部署时间常量
function GetCreateServerTime() end;

---获取区服测试区时间常量
function GetTestServerTime() end;

---获取区服正式区时间常量
function GetStartServerTime() end;

---获取客户端载体
---* actor     	玩家对象
---@param actor     	object
function GetClientFlag(actor) end;

---获取实时登录渠道ID
---* actor     	玩家对象
---@param actor     	object
function GetBoxVar(actor) end;

---获取服务器id
function GetServerIDX() end;

---获取GameID
function GetGameID() end;

---获取ip地址
---* actor     	玩家对象
---@param actor     	object
function GetIPAddr(actor) end;

---获取登录时间
---* actor     	玩家对象
---@param actor     	object
function GetLogInTime(actor) end;

---获取登录时长
---* actor     	玩家对象
---@param actor     	object
function GetLogInLong(actor) end;

---读取Ini文件中的字段值（带Cache）
---* fileName     	文件名
---* section     	配置项区
---* item	配置项
---@param fileName     	string
---@param section     	string
---@param item	string
function readinibycache(fileName,section,item) end;

---写入Ini文件中的字段值（带Cache）
---* fileName     	文件名
---* section     	配置项区
---* item	配置项
---* value	配置项值
---@param fileName     	string
---@param section     	string
---@param item	string
---@param value	string
function writeinibycache(fileName,section,item,value) end;

---删除Ini文件配置区（带Cache）
---* fileName     	文件名
---* section     	配置项区
---@param fileName     	string
---@param section     	string
function delinisectionbycache(fileName,section) end;

---删除Ini文件配置项（带Cache）
---* fileName     	文件名
---* section     	配置项区
---* item     	配置项
---@param fileName     	string
---@param section     	string
---@param item     	string
function deliniitembycache(fileName,section,item) end;

---脚本开启变量日志开关
---* type     	0：系统变量<br>1：玩家变量<br>2：行会变量<br>3：地图变量<br>4：NPC变量<br>5：物品变量<br>6：怪物变量<br>7：英雄变量<br>8：宠物变量<br>9：国家变量<br>
---* switch     	装备对象
---@param type     	number
---@param switch     	number
function setvarlog(type,switch) end;

---创建文本文件
---* path     	文件路径
---@param path     	string
function createfile(path) end;

---写入指定文本文件
---* path     	文件路径
---* str     	写入文本
---* line     	写入行数(0~65535)
---@param path     	string
---@param str     	string
---@param line     	number
function addtextlist(path,str,line) end;

---解析文本
---* text     	文本内容
---* actor     	玩家对象
---@param text     	string
---@param actor     	object
function parsetext(text,actor) end;

---获取人物/怪物 相关信息
---* object     	玩家/怪物 对象
---* nID     	类型(详见说明)
---* param3     	参数3<br>(仅ID=1时，可用)
---@param object     	object
---@param nID     	number
---@param param3     	number
function getbaseinfo(object,nID,param3) end;

---设置人物/怪物相关信息
---* object     	玩家对象
---* nID     	类型（详见说明）
---* value     	属性值
---@param object     	object
---@param nID     	number
---@param value     	number
function setbaseinfo(object,nID,value) end;

---对象是否存在
---* object     	玩家/怪物 对象
---@param object     	object
function isnotnull(object) end;

---判断对象是否为玩家
---* object     	判断对象
---@param object     	object
function isplayer(object) end;

---判断对象是否为人形怪
---* object     	判断对象
---@param object     	object
function isplaymon(object) end;

---判断对象是否为宝宝
---* object     	判断对象是否为宝宝
---@param object     	object
function ismob(object) end;

---判断对象是否为怪物
---* object     	判断对象
---@param object     	object
function ismon(object) end;

---改变 人/怪物 状态
---* object     	玩家/怪物 对象
---* id     	状态id(其他id无效)<br>0=绿毒;1=红毒<br>3=紫毒;5=麻痹<br>12=冰冻;13=蛛网
---* time     	时间(秒)
---* value     	威力，只针对绿毒有用
---* model     	0=不进行防护的判断<br>1=判断防全毒、防麻痹、防冰冻、防蛛网状态
---@param object     	object
---@param id     	number
---@param time     	number
---@param value     	number
---@param model     	number
function makeposion(object,id,time,value,model) end;

---检测 人/怪物 状态
---* object     	玩家/怪物 对象
---* type     	<br>类型:<br>1.魔法盾<br>2.护体神盾<br>3.无极真气<br>4.幽灵盾<br>5.神圣战甲术<br>6.隐身术<br>7.冰冻<br>8.麻痹<br>9.锁定<br>10.蛛网<br>11.中毒<br>12.禁止行为
---* forbid     	<br>禁止行为,参数2=12时有效<br>1=禁止走<br>2=禁止跑<br>3=禁止攻击<br>4=禁止施法<br>5=禁止使用物品<br>6=禁止说话<br>7=禁止飞<br>8=锁血
---@param object     	object
---@param type     	number
---@param forbid     	number
function checkhumanstate(object,type,forbid) end;

---使用脚本命令解毒（红绿毒）
---* object     	玩家/怪物 对象
---* opt     	-1，解所有毒;0,绿毒;1,红毒;3,紫毒;5,麻痹;6,冰冻;7,蛛网
---@param object     	object
---@param opt     	number
function detoxifcation(object,opt) end;

---回到最近经过的城市安全区
---* actor     	玩家对象
---@param actor     	object
function gohome(actor) end;

---在线泡点经验
---* actor     	玩家对象
---* eveTime     	间隔时间
---* experience     	经验
---* isSafe     	是否安全区<br>(0为任何地方)
---* mapId     	地图号（任何地图使用&quot;*&quot;）
---* opt     	聚灵珠是否能获取经验<br>(0=不可以 1= 可以)
---* allTime     	泡点获得经验的时间<br>时间：秒(上限100万秒)
---* level     	等级(多少级以下获得经验)
---@param actor     	object
---@param eveTime     	number
---@param experience     	number
---@param isSafe     	number
---@param mapId     	string
---@param opt     	number
---@param allTime     	number
---@param level     	number
function setautogetexp(actor,eveTime,experience,isSafe,mapId,opt,allTime,level) end;

---播放音乐声音
---* actor     	玩家对象
---* index     	播放文件的索引<br>对应声音配置表id(cfg_sound.xls)
---* times     	循环播放次数
---* flag     	播放模式:<br>0.播放给自己<br>1.播放给全服<br>2.播放给同一地图<br>4.播放给同屏人物
---@param actor     	object
---@param index     	number
---@param times     	number
---@param flag     	number
function playsound(actor,index,times,flag) end;

---表格转换成字符串
---* data     	表
---@param data     	table
function tbl2json(data) end;

---字符串转换成表格
---* str     	字符串
---@param str     	string
function json2tbl(str) end;

---拉取客户端充值接口
---* actor     	玩家对象
---* money     	金额
---* type     	充值方式：<br>1-支付宝，<br>2-花呗，<br>3-微信
---* falgId     	充值货币ID
---* productId     	产品ID
---@param actor     	object
---@param money     	number
---@param type     	number
---@param falgId     	number
---@param productId     	number
function pullpay(actor,money,type,falgId,productId) end;

---执行GM命令
---* actor     	玩家对象
---* GM     	GM命令
---* param1     	GM命令参数1
---* param2     	GM命令参数2
---* param3     	GM命令参数3
---* param4     	GM命令参数4
---* param5     	GM命令参数5
---* param6    	GM命令参数6
---* param7     	GM命令参数7
---* param8     	GM命令参数8
---* param9     	GM命令参数9
---* param10     	GM命令参数10
---@param actor     	object
---@param GM     	string
---@param param1     	string
---@param param2     	string
---@param param3     	string
---@param param4     	string
---@param param5     	string
---@param param6    	string
---@param param7     	string
---@param param8     	string
---@param param9     	string
---@param param10     	string
function gmexecute(actor,GM,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10) end;

---播放屏幕特效
---* actor     	玩家对象
---* id     	创建的特效编号
---* effectId     	特效ID
---* X     	在屏幕上的X坐标
---* Y     	在屏幕上的Y坐标
---* speed     	播放速度
---* times     	播放次数，0-持续播放
---* type     	播放模式<br>0-自己<br>1-所有人
---@param actor     	object
---@param id     	number
---@param effectId     	number
---@param X     	number
---@param Y     	number
---@param speed     	number
---@param times     	number
---@param type     	number
function screffects(actor,id,effectId,X,Y,speed,times,type) end;

---关闭屏幕特效
---* actor     	玩家对象
---* id     	创建的特效编号
---* type     	播放模式<br>0-自己<br>1-所有人
---@param actor     	object
---@param id     	number
---@param type     	number
function deleffects(actor,id,type) end;

---获取常量
---* actor     	玩家对象
---* varName     	常量名称，支持带尖括号和不带尖括号<$Name>或$Name
---@param actor     	object
---@param varName     	string
function getconst(actor,varName) end;

---屏幕震动
---* actor     	玩家对象
---* type     	模式(0~4)<br>0.仅自己;<br>1.在线所有人;<br>2屏幕范围内人物;<br>3.当前地图上所有人;<br>4.指定地图上所有人;
---* level     	震级(1~3)
---* num     	次数
---* mapId     	地图ID(模式等于4时，需要该参数)
---@param actor     	object
---@param type     	number
---@param level     	number
---@param num     	number
---@param mapId     	number
function scenevibration(actor,type,level,num,mapId) end;

---客户端复制
---* actor     	玩家对象
---* str     	文本内容
---@param actor     	object
---@param str     	string
function mircopy(actor,str) end;

---游戏中打开网站
---* actor     	玩家对象
---* web     	网站
---@param actor     	object
---@param web     	string
function openwebsite(actor,web) end;

---MD5加密
---* str     	需要加密的文本
---@param str     	string
function md5str(str) end;

---等概率或者按权限随机获取分割字符串
---* str     	需要获取随机的字符串
---* param1     	0=系统权重随机,有几个字符串就是几份之一<br>1=按#位权重随机总权重为各项位权重的总和
---* param2     	0=返回值都显示#权重数字<br>1=返回值都不显示#权重数字<br>2=返回值1显示,返回值2不显示<br>3=返回值2显示,返回值1不显示
---@param str     	string
---@param param1     	number
---@param param2     	number
function ransjstr(str,param1,param2) end;

---自定义日志
---* actor     	玩家对象
---* logAct     	日志ID<br>大于等于10000以上
---* logInfo     	日志内容<br>支持变量,常量等
---* param1     	整数型(可空)<br>最大支持21亿
---* param2     	整数型(可空)<br>最大支持21亿
---* param3     	整数型(可空)<br>最大支持21亿
---* param4     	整数型(可空)<br>最大支持21亿
---* param5     	整数型(可空)<br>最大支持21亿
---@param actor     	object
---@param logAct     	number
---@param logInfo     	number
---@param param1     	number
---@param param2     	number
---@param param3     	number
---@param param4     	number
---@param param5     	number
function logact(actor,logAct,logInfo,param1,param2,param3,param4,param5) end;

---日志上报接口
---* actor     	玩家对象
---* jsonStr     	日志json
---@param actor     	object
---@param jsonStr     	string
function senddiymsg(actor,jsonStr) end;

---打印脚本总耗时(微秒)
---* actor     	玩家对象
---* onoff     	1=开始计时<br>2=结束计时，并打印耗时信息
---@param actor     	object
---@param onoff     	number
function printusetime(actor,onoff) end;

---前端勾选面板控制命令
---* actor     	玩家对象
---* type     	0=允许添加<br>1=允许交易<br>2=允许挑战<br>3=允许组队<br>4=允许查看<br>5=允许添加为行会成员
---* time     	1=允许(勾选)<br>0=不允许(不勾选)(秒)
---@param actor     	object
---@param type     	number
---@param time     	number
function clientswitch(actor,type,time) end;

---拉起微信和qq等功能
---* actor     	玩家对象
---* model     	1=拉起QQ<br>2=QQ好友<br>3=QQ群<br>4=微信
---* param1     	参数2=2,填入QQ号<br>参数2=3,填入QQ群号
---* param2     	参数2=3,填入QQ群key
---@param actor     	object
---@param model     	number
---@param param1     	number
---@param param2     	string
function sendforqqwx(actor,model,param1,param2) end;

---发送邮件
---* userId     	玩家UserId，如果是玩家名，需要在前面加#，如:#张三
---* id     	自定义邮件ID
---* label     	邮件标题
---* memo     	邮件内容
---* rewards     	附件内容：物品1#数量#绑定标记&物品2#数量#绑定标记，&分组，#分隔绑定标记值参考物品帮助
---@param userId     	string
---@param id     	number
---@param label     	string
---@param memo     	string
---@param rewards     	string
function sendmail(userId,id,label,memo,rewards) end;

---获取对象类型
---* object     	对象
---@param object     	object
function GetObjType(object) end;

---表格转换成字符串
---* str     	表格
---@param str     	table
function tbl2jsonex(str) end;

---字符串转换成表格
---* str     	字符串
---@param str     	string
function json2tblex(str) end;

---通知客户端显示表单
---* actor 	玩家对象
---* FormName 	 文件名
---* Content	 Win_Create节点ID<br>(参数用#号拼接)
---@param actor 	object 
---@param FormName 	string 
---@param Content	string 
function ShowFormWithContent(actor,FormName,Content) end;

---设置表单的允许回调函数列表
---*  funname	函数名列表
---@param  funname	table 
function SetFormAllowFunc(funname) end;

---发送消息
---* actor     	玩家对象
---* msgId     	消息ID
---* param1     	参数1
---* param2     	参数2
---* param3     	参数3
---* sMsg     	消息体
---@param actor     	object
---@param msgId     	number
---@param param1     	number
---@param param2     	number
---@param param3     	number
---@param sMsg     	number
function sendluamsg(actor, msgId, param1, param2, param3, sMsg) end;

---修改人物名称
---* actor     	玩家对象
---* name     	要查询的名字
---@param actor     	object
---@param name     	string
function changehumname(actor,name) end;

---修改人物名字颜色
---* actor     	玩家对象
---* color     	颜色索引
---@param actor     	object
---@param color     	number
function changenamecolor(actor,color) end;

---刷新人物属性
---* actor     	玩家对象
---@param actor     	object
function recalcabilitys(actor) end;

---获取人物属性
---* actor     	玩家对象
---* id     	属性ID（1-20）
---@param actor     	object
---@param id     	number
function gethumability(actor,id) end;

---调整人物属性
---* actor     	玩家对象
---* id     	属性ID<br>1=防御下限<br>2=防御上限<br>3=魔御下限<br>4=魔御上限<br>5=攻击下限<br>6=攻击上限<br>7=魔法下限<br>8=魔法上限<br>9=道术下限<br>10=道术上限<br>11=MaxHP<br>12=MaxMP<br>13=HP恢复<br>14=MP恢复<br>15=毒恢复<br>16=毒躲避<br>17=魔法躲避<br>18=准确<br>19=敏捷<br>20= 幸运
---* value     	属性值
---* time     	时间(秒)
---@param actor     	object
---@param id     	number
---@param value     	number
---@param time     	number
function changehumability(actor,id,value,time) end;

---修改人物临时属性（带有效期）
---* actor     	玩家对象
---* nWhere     	位置 对应cfg_att_score 属性ID
---* nValue     	对应属性值
---* nTime     	有效时间，秒
---@param actor     	object
---@param nWhere     	number
---@param nValue     	number
---@param nTime     	number
function changehumnewvalue(actor,nWhere,nValue,nTime) end;

---获取人物临时属性
---* actor     	玩家对象
---* nWhere     	位置 对应cfg_att_score 属性ID
---@param actor     	object
---@param nWhere     	number
function gethumnewvalue(actor,nWhere) end;

---获取人物永久属性
---* actor     	玩家对象
---* nIndex     	索引
---@param actor     	object
---@param nIndex     	number
function getusebonuspoint(actor,nIndex) end;

---设置人物永久属性
---* actor     	玩家对象
---* nIndex     	索引<br>nIndex 取值<br>1:攻击下限(0~65535)<br>2:攻击上限(0~65535)<br>3:魔法下限(0~65535)<br>4:魔法上限(0~65535)<br>5:道术下限(0~65535)<br>6:道术上限(0~65535)<br>7:防御下限(0~65535)<br>8:防御上限(0~65535)<br>9:魔防下限(0~65535)<br>10:魔防上限(0~65535)<br>11:生命值(支持21亿)<br>12:魔法值(支持21亿)<br>13:准确(支持21亿)<br>14:躲避(支持21亿)<br>15:防御下限(支持21亿)<br>16:防御上限(支持21亿)<br>17:魔防下限(支持21亿)<br>18:魔防上限(支持21亿)
---* nValue     	属性值
---@param actor     	object
---@param nIndex     	number
---@param nValue     	number
function setusebonuspoint(actor,nIndex,nValue) end;

---通过字符串增加对应属性值(参照cfg_equip.xls属性字段)
---* actor     	玩家对象
---* attrIndex     	自定义属性组名称
---* opt     	操作符 +、-、=
---* attrStr     	属性字符串
---* type     	0或空=计算套装属性增加 1=增加固定值;不计算套装属性(属性加成类无效)
---@param actor     	object
---@param attrIndex     	string
---@param opt     	string
---@param attrStr     	string
---@param type     	number
function addattlist(actor,attrIndex,opt,attrStr,type) end;

---获取字符串属性
---* actor     	玩家对象
---* attrIndex     	自定义属性组名称
---@param actor     	object
---@param attrIndex     	string
function getattlist(actor,attrIndex) end;

---清除字符串属性
---* actor     	玩家对象
---* attrIndex     	自定义属性组名称
---@param actor     	object
---@param attrIndex     	string
function delattlist(actor,attrIndex) end;

---设置装备部位属性加成(万分比)
---* actor     	玩家对象
---* where     	装备部位
---* sFlag     	操作符(=,+,-)
---* pro     	倍数(万分比)
---@param actor     	object
---@param where     	string
---@param sFlag     	string
---@param pro     	number
function setequipaddvalue(actor,where,sFlag,pro) end;

---获取装备部位属性加成(万分比)
---* actor     	玩家对象
---* where     	装备部位
---@param actor     	object
---@param where     	string
function getequipaddvalue(actor,where) end;

---获取人物标记/标识值
---* actor     	玩家对象
---* nIndex     	索引（1-800）
---@param actor     	object
---@param nIndex     	number
function getflagstatus(actor,nIndex) end;

---设置人物标记/标识值
---* actor     	玩家对象
---* nIndex     	索引（1-800）
---* nValue     	对应属性值(flag标记只能支持0,1两个值，>0的值视为1)
---@param actor     	object
---@param nIndex     	number
---@param nValue     	number
function setflagstatus(actor,nIndex,nValue) end;

---设置人物经验值
---* actor     	玩家对象
---* opt     	操作符 + - =
---* count     	数量
---* addexp     	是否增加聚灵珠经验
---@param actor     	object
---@param opt     	string
---@param count     	number
---@param addexp     	 boolean
function changeexp(actor,opt,count,addexp) end;

---调整人物等级
---* actor     	玩家对象
---* opt     	操作符 + - =
---* count     	数量
---@param actor     	object
---@param opt     	string
---@param count     	number
function changelevel(actor,opt,count) end;

---设置等级锁
---* actor     	玩家对象
---* iType     	0:解除锁定<br>1锁定到达最大等级时并且不获取怪物经验<br>2:锁定到达最大等级时累积经验(int64)
---* level     	锁住最大等级
---@param actor     	object
---@param iType     	number
---@param level     	number
function setlocklevel(actor,iType,level) end;

---改变人物模式
---* actor     	玩家对象
---* mode     	模式1~24
---* time     	状态时间(秒,1-65535)
---* param1     	参数1,12,13,18,20,21代表几率其余代表属性值
---* param2     	参数2
---@param actor     	object
---@param mode     	number
---@param time     	number
---@param param1     	number
---@param param2     	number
function changemode(actor,mode,time,param1,param2) end;

---顶戴花翎
---* actor     	玩家对象
---* where     	位置 0-9
---* effType     	播放效果<br>0 = 图片名称<br>1 = 特效ID<br>-1 = 取消顶戴
---* resName     	图片名或者特效ID
---* x     	X坐标 (为空时默认X=0)
---* y     	Y坐标 (为空时默认Y=0)
---* autoDrop     	自动补全空白位置0,1(0=掉 1=不掉)
---* selfSee     	是否只有自己看见<br>0=所有人都可见;<br>1=仅仅自己可见;
---* posM     	播放位置(不填默认为0)<br>0=在角色之上;<br>1=在角色之下;
---@param actor     	object
---@param where     	number
---@param effType     	number
---@param resName     	string
---@param x     	number
---@param y     	number
---@param autoDrop     	number
---@param selfSee     	number
---@param posM     	number
function seticon(actor,where,effType,resName,x,y,autoDrop,selfSee,posM) end;

---在人物身上播放特效
---* actor     	玩家对象
---* effectId     	特效ID
---* offsetX     	相对于人物偏移的X坐标
---* offsetY     	相对于人物偏移的Y坐标
---* times     	播放次数<br>0-一直播放
---* behind     	播放模式<br>0-前面<br>1-后面
---* selfShow     	仅自己可见<br>0-否，视野内均可见，<br>1-是
---@param actor     	object
---@param effectId     	number
---@param offsetX     	number
---@param offsetY     	number
---@param times     	number
---@param behind     	number
---@param selfShow     	number
function playeffect(actor,effectId,offsetX,offsetY,times,behind,selfShow) end;

---清除人物身上播放的特效
---* actor     	玩家对象
---* effectId     	特效ID
---@param actor     	object
---@param effectId     	number
function clearplayeffect(actor,effectId) end;

---修改人物当前血量
---* actor     	玩家(怪物)对象
---* operate     	操作符号<br>“+” 增加<br>“-“ 减少<br>“=” 等于
---* nvalue     	HP点数
---* effId     	素材ID
---* delay     	延时时间(秒)
---* hitter     	伤害来源对象
---* isSend     	释放广播飘血<br>0/nil=不广播<br>1=广播
---* isRob     	是否强制修改归属<br>0/nil=强制修改归属;<br>1=已有归属的情况不抢归属
---@param actor     	object
---@param operate     	string
---@param nvalue     	number
---@param effId     	number
---@param delay     	number
---@param hitter     	object
---@param isSend     	number
---@param isRob     	number
function humanhp(actor,operate,nvalue,effId,delay,hitter,isSend,isRob) end;

---修改人物当前MP
---* actor     	玩家对象
---* operate     	操作符号<br>‘+’-增加<br>‘-‘-减少<br>‘=’-等于
---* nValue     	MP点数
---@param actor     	object
---@param operate     	string
---@param nValue     	number
function humanmp(actor,operate,nValue) end;

---调整HP(血量)的百分比
---* actor     	玩家(怪物)对象
---* opt     	控制符(=,+,-)
---* value     	数值
---@param actor     	object
---@param opt     	string
---@param value     	number
function addhpper(actor,opt,value) end;

---调整MP(蓝量)的百分比
---* actor     	玩家(怪物)对象
---* opt     	控制符(=,+,-)
---* value     	数值
---@param actor     	object
---@param opt     	string
---@param value     	number
function addmpper(actor,opt,value) end;

---设置人物伤害吸收
---* actor     	玩家对象
---* operate     	操作符号<br>‘+’-增加<br>‘-‘-减少<br>‘=’-等于
---* sum     	总吸收量
---* rate     	吸收比率，千分比<br>1=0.1%，100=10%
---* success     	吸收成功率
---@param actor     	object
---@param operate     	string
---@param sum     	number
---@param rate     	number
---@param success     	number
function setsuckdamage(actor,operate,sum,rate,success) end;

---获取人物伤害吸收
---* actor     	玩家对象
---@param actor     	object
function getsuckdamage(actor) end;

---人物变色
---* actor     	玩家对象
---* color     	颜色(0~255); 255时清除颜色; -1则为转生设置的颜色在人物身体上进行变色
---* time     	改变时长(秒)
---@param actor     	object
---@param color     	number
---@param time     	number
function setbodycolor(actor,color,time) end;

---播放光环效果
---* actor     	玩家对象
---* mapId     	地图id
---* x     	坐标x
---* y     	坐标y
---* type     	光环类型<br>1=僵尸钻的地洞<br>3=碎石块<br>4=困魔光<br>5=火墙
---* time     	时间（秒）
---* behind     	播放模式-0-前面-1-后面
---* selfShow     	仅自己可见0-否，视野内均可见，1-是
---@param actor     	object
---@param mapId     	number
---@param x     	number
---@param y     	number
---@param type     	number
---@param time     	number
---@param behind     	number
---@param selfShow     	number
function mobfireburn(actor,mapId,x,y,type,time,behind,selfShow) end;

---脚本设置防秒杀功能
---* actor     	玩家对象
---@param actor     	object
function killedprotect(actor) end;

---立即杀死角色
---* actor     	被杀的对象
---* killer     	凶手的对象
---@param actor     	object
---@param killer     	object
function kill(actor,killer) end;

---查询人物货币
---* actor     	玩家对象
---* id     	货币ID（1-100）
---@param actor     	object
---@param id     	number
function querymoney(actor,id) end;

---设置人物货币
---* actor     	玩家对象
---* id     	货币ID（1-100）
---* opt     	操作符 + - =
---* count     	数量
---* msg     	备注内容
---* send     	是否推送到客户端，true-更新
---@param actor     	object
---@param id     	number
---@param opt     	string
---@param count     	number
---@param msg     	string
---@param send     	 boolean
function changemoney(actor,id,opt,count,msg,send) end;

---获取人物通用货币数量(多货币计算)
---* actor     	玩家对象
---* moneyName     	货币名称
---@param actor     	object
---@param moneyName     	string
function getbindmoney(actor,moneyName) end;

---扣除人物通用货币数量(多货币依次计算)
---* actor     	玩家对象
---* moneyName     	货币名称
---* count     	对应货币值
---* msg     	备注内容
---@param actor     	object
---@param moneyName     	string
---@param count     	number
---@param msg     	string
function consumebindmoney(actor,moneyName,count,msg) end;

---设置人物背包格子数
---* actor     	玩家对象
---* count     	格子大小<br>（不小于46，不大于206）
---@param actor     	object
---@param count     	number
function setbagcount(actor,count) end;

---获取背包剩余空格数
---* actor     	玩家对象
---@param actor     	object
function getbagblank(actor) end;

---遍历背包勾选物品
---* actor     	玩家对象
---* makeIndex     	选中的物品唯一ID<br>多个物品用“,”分隔
---@param actor     	object
---@param makeIndex     	string
function selectbagitems(actor,makeIndex) end;

---穿戴装备
---* actor     	玩家对象
---* where     	位置
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param where     	number
---@param makeIndex     	number
function takeonitem(actor,where,makeIndex) end;

---脱下装备
---* actor     	玩家对象
---* where     	位置
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param where     	number
---@param makeIndex     	number
function takeoffitem(actor,where,makeIndex) end;

---开/关首饰盒
---* actor     	玩家对象
---* bState     	0：关闭，1：开启
---@param actor     	object
---@param bState     	number
function setsndaitembox(actor,bState) end;

---修改武器、衣服外观
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---* looks     	外观值
---@param actor     	object
---@param makeIndex     	object
---@param looks     	number
function changeitemshape(actor,makeIndex,looks) end;

---修改武器、衣服特效
---* actor     	玩家对象
---* where     	位置 0，1
---* effId     	特效ID
---* selfSee     	是否只有自己看见<br>(1=所有人都可见<br> 0=仅仅自己可见)
---@param actor     	object
---@param where     	number
---@param effId     	number
---@param selfSee     	number
function changedresseffect(actor,where,effId,selfSee) end;

---修改角色外观(武器、衣服、特效)
---* actor     	玩家对象
---* type     	0=衣服;1=武器;<br>2=衣服特效(翅膀);<br>3武器特效;<br>4=盾牌;5=盾牌特效<br>6=左手武器;7=左手武器特效
---* shape     	外观的shape(角色模型ID),-1表示清除
---* time     	时间 (秒)
---* param1     	仅在参数1位置为0时有效<br>0=覆盖时装外观<br>1=时装外观优先
---* param2     	仅在参数1位置为0时有效<br>0-斗笠、头发不变<br>1-隐藏斗笠<br>2-隐藏头发<br>3-隐藏斗笠和头发 4-隐藏盾牌和盾牌特效
---@param actor     	object
---@param type     	string
---@param shape     	number
---@param time     	number
---@param param1     	number
---@param param2     	number
function setfeature(actor,type,shape,time,param1,param2) end;

---给人物装备面板加特效
---* actor     	玩家对象
---* effectId     	特效ID， 0-删除特效
---* position     	显示位置：0-前面 1-后面
---@param actor     	object
---@param effectId     	number
---@param position     	number
function updateequipeffect(actor,effectId,position) end;

---获取技能信息
---* actor     	玩家对象
---* skillId     	技能ID
---* type     	获取类型:<br>1:等级;<br>2:强化等级;<br>3:熟练度(技能经验值);<br>4:熟练度上限(技能经验值上限);
---@param actor     	object
---@param skillId     	number
---@param type     	number
function getskillinfo(actor,skillId,type) end;

---添加技能
---* actor     	玩家对象
---* skillId     	技能ID
---* level     	等级
---@param actor     	object
---@param skillId     	number
---@param level     	number
function addskill(actor,skillId,level) end;

---删除技能
---* actor     	玩家对象
---* skillId     	技能ID
---@param actor     	object
---@param skillId     	number
function delskill(actor,skillId) end;

---删除非本职业技能
---* actor     	玩家对象
---@param actor     	object
function delnojobskill(actor) end;

---设置技能等级
---* actor     	玩家对象
---* skillId     	技能ID
---* flag     	类型：<br>1-技能等级<br>2-强化等级<br>3-熟练度(技能经验值)
---* point     	等级或点数
---@param actor     	object
---@param skillId     	number
---@param flag     	number
---@param point     	number
function setskillinfo(actor,skillId,flag,point) end;

---用脚本命令释放技能
---* actor     	玩家对象
---* skillId     	技能ID
---* type     	类型：<br>1-普通技能<br>2-强化技能
---* level     	技能等级
---* target     	技能对象：<br>1-攻击目标，<br>2-自身
---* flag     	是否显示施法动作：<br>0-不显示，1-显示
---@param actor     	object
---@param skillId     	number
---@param type     	number
---@param level     	number
---@param target     	number
---@param flag     	number
function releasemagic(actor,skillId,type,level,target,flag) end;

---对目标释放技能
---* actor     	玩家对象
---* skillId     	技能ID
---* sType     	类型<br>1-普通技能<br>2-强化技能
---* sLevel     	技能等级
---* target     	目标对象
---* data     	是否显示施法动作<br>0-不显示<br>1-显示
---@param actor     	object
---@param skillId     	number
---@param sType     	number
---@param sLevel     	number
---@param target     	object
---@param data     	number
function releasemagic_target(actor,skillId,sType,sLevel,target,data) end;

---对坐标释放技能
---* actor     	玩家对象
---* skillId     	技能ID
---* sType     	类型<br>1-普通技能<br>2-强化技能
---* sLevel     	技能等级
---* X     	目标点X坐标
---* Y     	目标点Y坐标
---* data     	是否显示施法动作<br>0-不显示<br>1-显示
---@param actor     	object
---@param skillId     	number
---@param sType     	number
---@param sLevel     	number
---@param X     	number
---@param Y     	number
---@param data     	number
function releasemagic_pos(actor,skillId,sType,sLevel,X,Y,data) end;

---设置人物攻击力倍数
---* actor     	玩家对象
---* rate     	攻击威力比率，100=100%
---* time     	有效时间，超过时间恢复正常
---@param actor     	object
---@param rate     	number
---@param time     	number
function powerrate(actor,rate,time) end;

---减少技能CD冷却时间
---* actor     	玩家对象
---* skillName     	技能名称
---* char     	操作符(+/-/=)<br>=0就是还原技能CD
---* time     	时间（秒)
---@param actor     	object
---@param skillName     	string
---@param char     	string
---@param time     	number
function setskilldeccd(actor,skillName,char,time) end;

---获取技能初始冷却时间
---* skillName     	技能名称
---@param skillName     	string
function getskillcscd(skillName) end;

---获取当前技能冷却时间
---* actor     	玩家对象
---* skillName     	技能名称
---@param actor     	object
---@param skillName     	string
function getskilldqcd(actor,skillName) end;

---重置技能冷却时间
---* actor     	玩家对象
---* skillInfo     	技能名称/技能ID
---* time     	减免的cd时间(秒)<br>传入0则重置技能CD
---@param actor     	object
---@param skillInfo     	number|string
---@param time     	number
function skillrestcd(actor,skillInfo,time) end;

---获取技能等级
---* actor     	玩家对象
---* skillId     	技能ID
---@param actor     	object
---@param skillId     	number
function getskilllevel(actor,skillId) end;

---获取技能强化等级
---* actor     	玩家对象
---* skillId     	技能ID
---@param actor     	object
---@param skillId     	number
function getskilllevelup(actor,skillId) end;

---获取技能熟练度
---* actor     	玩家对象
---* skillId     	技能ID
---@param actor     	object
---@param skillId     	number
function getskilltrain(actor,skillId) end;

---增加技能威力
---* actor     	玩家对象
---* skillName     	技能名称
---* value     	威力值
---* type     	计算方式(0按点数计算,1按百分比计算)
---@param actor     	object
---@param skillName     	string
---@param value     	number
---@param type     	number
function setmagicpower(actor,skillName,value,type) end;

---增加技能防御力
---* actor     	玩家对象
---* skillName     	技能名称
---* value     	抵消威力值
---* type     	计算方式(0按点数计算,1按百分比计算)
---@param actor     	object
---@param skillName     	string
---@param value     	number
---@param type     	number
function setmagicdefpower(actor,skillName,value,type) end;

---根据技能id获取技能名字
---* skillId     	技能id
---@param skillId     	number
function getskillname(skillId) end;

---根据技能名字获取技能id
---* skillName     	技能名称
---@param skillName     	string
function getskillindex(skillName) end;

---改变技能特效
---* actor     	玩家对象
---* skillName     	技能名称
---* effectId     	特效id,=0为关闭<br>(cfg_skill_present.xls表id)
---* effectId2     	持续性ID(魔法盾BUFF表id/火墙/群体雷电术/其他的技能无效)
---@param actor     	object
---@param skillName     	string
---@param effectId     	number
---@param effectId2     	number
function setmagicskillefft(actor,skillName,effectId,effectId2) end;

---根据玩家名获取玩家对象
---* actorName     	玩家名字
---@param actorName     	string
function getplayerbyname(actorName) end;

---根据玩家唯一ID获取玩家对象
---* id     	玩家唯一id
---@param id     	string
function getplayerbyid(id) end;

---添加称号
---* actor     	玩家对象
---* name	称号物品名称
---* use     	开启激活，1激活
---@param actor     	object
---@param name	string
---@param use     	number
function confertitle(actor,name,use) end;

---删除称号
---* actor     	玩家对象
---* name     	称号物品名称
---@param actor     	object
---@param name     	string
function deprivetitle(actor,name) end;

---检测人物称号
---* actor     	玩家对象
---* title     	称号
---@param actor     	object
---@param title     	string
function checktitle(actor,title) end;

---获取人物所有称号
---* actor     	玩家对象
---@param actor     	object
function newgettitlelist(actor) end;

---改变称号时间
---* actor     	玩家对象
---* titleName     	称号名称
---* operation     	操作符（+,-,=）
---* cour     	时间(+,-传入操作时间(秒), =传入时间戳)
---@param actor     	object
---@param titleName     	string
---@param operation     	string
---@param cour     	number
function changetitletime(actor,titleName,operation,cour) end;

---完美封号系统
---* actor     	玩家对象
---* levelName     	称号文本，和名字一起显示
---@param actor     	object
---@param levelName     	string
function setranklevelname(actor,levelName) end;

---修改攻击模式
---* actor     	玩家对象
---* attackMode     	攻击模式：<br>0-全体攻击<br>1-和平攻击<br>2-夫妻攻击<br>3-师徒攻击<br>4-编组攻击<br>5-行会攻击<br>6-红名攻击<br>7-国家攻击
---@param actor     	object
---@param attackMode     	number
function changeattackmode(actor,attackMode) end;

---强制修改攻击模式
---* actor     	玩家对象
---* attackMode     	攻击模式<br>-1-提前结束强制状态
---* time     	强制切换时间时间
---@param actor     	object
---@param attackMode     	number
---@param time     	number
function setattackmode(actor,attackMode,time) end;

---获取当前攻击模式
---* actor     	玩家对象
---@param actor     	object
function getattackmode(actor) end;

---打开仓库面板
---* actor     	玩家对象
---* isOpenUI     	0/nil=打开UI<br>1=只下发数据
---@param actor     	object
---@param isOpenUI     	number
function openstorage(actor,isOpenUI) end;

---新解锁仓库格子
---* actor     	玩家对象
---* nCount     	新解锁的格子数
---@param actor     	object
---@param nCount     	number
function changestorage(actor,nCount) end;

---获取仓库剩余格子数
---* actor     	玩家对象
---@param actor     	object
function getsblank(actor) end;

---获取玩家仓库最大格子数
---* actor     	玩家对象
---@param actor     	object
function getssize(actor) end;

---跳转地图（随机坐标）
---* actor     	玩家对象
---* mapId     	装备对地图ID象
---@param actor     	object
---@param mapId     	string
function map(actor,mapId) end;

---飞地图（指定坐标）
---* actor     	玩家对象
---* mapId     	地图ID
---* nX     	X坐标
---* nY     	Y坐标
---* nRange     	范围
---@param actor     	object
---@param mapId     	string
---@param nX     	number
---@param nY     	number
---@param nRange     	number
function mapmove(actor,mapId,nX,nY,nRange) end;

---导航玩家到指定位置
---* actor     	玩家对象
---* X     	X坐标
---* Y     	Y坐标
---@param actor     	object
---@param X     	number
---@param Y     	number
function gotonow(actor,X,Y) end;

---获取所有玩家对象列表(遍历玩家列表)
---* offline     	是否剔除离线挂机玩家<br>0/nil=不剔除<br>1=剔除
---@param offline     	number
function getplayerlst(offline) end;

---获取玩家GM权限值
---* actor     	玩家对象
---@param actor     	object
function getgmlevel(actor) end;

---设置玩家GM权限值
---* actor     	玩家对象
---* gmlevel     	GM权限值
---@param actor     	object
---@param gmlevel     	number
function setgmlevel(actor,gmlevel) end;

---复活
---* actor     	玩家对象
---@param actor     	object
function realive(actor) end;

---人物强制掉线(踢人下线)
---* actor     	玩家对象
---@param actor     	object
function kick(actor) end;

---延时跳转
---* actor     	玩家对象
---* time     	时间(毫秒)
---* func     	触发函数 函数名 使用 aa_cc 带底杠规则(消除部分隐患)
---* del     	换地图是否删除此延时(0或为空时=不删除 1=删除)
---@param actor     	object
---@param time     	number
---@param func     	string
---@param del     	number
function delaygoto(actor,time,func,del) end;

---删除延迟
---* actor     	玩家对象
---* func     	需要删除的延时函数<br>不填为清除全部
---@param actor     	object
---@param func     	string
function cleardelaygoto(actor,func) end;

---延时消息跳转
---* actor     	玩家对象
---* time     	时间(毫秒)
---* func     	触发函数
---@param actor     	object
---@param time     	number
---@param func     	string
function delaymsggoto(actor,time,func) end;

---增加附加伤害效果
---* actor     	玩家对象
---* targetX     	X坐标
---* targetY     	Y坐标
---* range     	影响范围
---* power     	攻击力
---* addType     	附加类型：<br>0.无,1.击退,2.冻结,<br>3.麻痹,4.吸血,5.吸蓝,<br>6.真实伤害数值,<br>7.蛛网效果,8.红毒,<br>9.绿毒,10.定身,<br>11.防禁锢,<br>12.最大hp百分比真实伤害,<br>13.当前hp百分比真实伤害
---* addValue     	附加属性值：<br>1.击退距离;2.冻结时间;<br>3.麻痹时间;4.吸血值;<br>5.吸蓝值;6.真实伤害值;<br>7.蛛网时间;8;红毒时间;<br>9.绿毒时间;<br>10.定身时间(定身时间单位是毫秒);<br>11.防禁锢时间(秒);<br>12.最大hp百分比真实伤害的值;<br>13.当前hp百分比真实伤害的值
---* checkState     	是否检查防冻结/麻痹/石化/冰冻/蛛网/红毒/绿毒属性<br>0=直接设置状态;1=检查后设置状态)
---* targetType     	目标类型(0或空=所有目标;1=仅人物;2=仅怪物)
---* sffectId     	目标身上播放的特效ID
---* harmNum     	群体伤害目标个数
---@param actor     	object
---@param targetX     	number
---@param targetY     	number
---@param range     	number
---@param power     	number
---@param addType     	number
---@param addValue     	number
---@param checkState     	number
---@param targetType     	number
---@param sffectId     	number
---@param harmNum     	number
function rangeharm(actor,targetX,targetY,range,power,addType,addValue,checkState,targetType,sffectId,harmNum) end;

---是否有该技能
---* actor     	玩家对象
---* skillId     	技能ID
---@param actor     	object
---@param skillId     	number
function HasSkill(actor,skillId) end;

---调整人物下次攻击倍率
---* actor     	玩家对象
---* num     	倍率
---* obj     	默认参数一，调整对象
---@param actor     	object
---@param num     	number
---@param obj     	object
function SetNextDamage(actor,num,obj) end;

---魔法盾减伤
---* actor     	玩家对象
---* per     	减伤万分比数值
---* type     	减伤类型（0-所有，1-仅物理伤害，2-仅魔法伤害）
---@param actor     	object
---@param per     	number
---@param type     	number
function SetSheildDec(actor,per,type) end;

---获取玩家登录账号id
---* actor     	玩家对象
---@param actor     	object
function GetUserAccount(actor) end;

---获取等级锁
---* actor     	玩家对象
---@param actor     	object
function getlocklevel(actor) end;

---全身所有装备星星数量总和
---* actor     	玩家对象
---@param actor     	object
function GetStarCountAll(actor) end;

---获取剩余复活时间
---* actor     	玩家对象
---* type     	0/nil=复活戒指时间,1=套装复活时间
---@param actor     	object
---@param type     	number
function GetRevivalTime(actor,type) end;

---开启一键拾取按钮
---* actor     	玩家对象
---* set     	0:关闭,1:开启
---@param actor     	object
---@param set     	number
function SetAutoPick(actor,set) end;

---获取人物背包最大格子数
---* actor     	玩家对象
---@param actor     	object
function GetBagMaxCount(actor) end;

---获取角色技能最大冷却时间
---* actor     	玩家对象
---* skillId     	技能id
---@param actor     	object
---@param skillId     	number
function GetSkillMaxCD(actor,skillId) end;

---设置角色技能最大冷却时间
---* actor     	玩家对象
---* skillId     	技能id
---* time     	冷却时间（毫秒）
---@param actor     	object
---@param skillId     	number
---@param time     	number
function SetSkillMaxCD(actor,skillId,time) end;

---获取角色技能剩余冷却时间
---* actor     	玩家对象
---* skillId     	技能id
---@param actor     	object
---@param skillId     	number
function GetSkillCD(actor,skillId) end;

---设置角色技能剩余冷却时间
---* actor     	玩家对象
---* skillId     	技能id
---* time     	冷却时间（毫秒）
---@param actor     	object
---@param skillId     	number
---@param time     	number
function SetSkillCD(actor,skillId,time) end;

---获取角色所有属性基准值
---* actor     	玩家对象
---@param actor     	object
function AttrTabPre(actor) end;

---设置杀怪掉落是否绑定
---* actor     	玩家对象
---* isbind     	 是否开启绑定
---@param actor     	object
---@param isbind     	boolean
function SetBind(actor,isbind) end;

---获取杀怪掉落是否绑定
---* actor     	玩家对象
---@param actor     	object
function GetBind(actor) end;

---获取角色所有技能
---* actor     	玩家对象
---@param actor     	object
function getallskills(actor) end;

---添加系统延时回调
---* time     	时间(毫秒)
---* funcName     	触发函数
---@param time     	number
---@param funcName     	string
function globaldelaygoto(time,funcName) end;

---删除系统延时回调
---* funcName     	需要删除的延时函数<br>不填为清除全部
---* value     	是否忽视标签参数<br>0=不忽视,要完整填写添加时的参数<>br1=忽视,只判断函数名
---@param funcName     	string
---@param value     	string
function globalcleardelaygoto(funcName,value) end;

---人物飘血飘字特效
---* target     	飘血飘字的主体，一般为受攻击者
---* type     	显示类型<br>1- 伤害，<br>2- 暴击伤害，<br>4- 加HP，<br>5- 格挡，<br>8- 扣减HP和MP，<br>9- 伤害，<br>10-扣减MP，<br>11- 致命一击<br>对应cfg_damage_number表里的ID
---* damage     	显示的点数
---* hitter     	可看到飘血飘字的主体，一般为攻击者
---@param target     	object
---@param type     	number
---@param damage     	number
---@param hitter     	object
function sendattackeff(target,type,damage,hitter) end;

---设定人物攻击飘血飘字类型
---* actor     	玩家对象
---* type     	显示类型<br>1- 伤害，<br>2- 暴击伤害，<br>4- 加HP，<br>5- 格挡，<br>8- 扣减HP和MP，<br>9- 伤害，<br>10-扣减MP，<br>11- 致命一击<br>对应cfg_damage_number表里的ID
---@param actor     	object
---@param type     	number
function setattackefftype(actor,type) end;

---停止自动挂机
---* actor     	玩家对象
---@param actor     	object
function stopautoattack(actor) end;

---采集挖矿等进度条操作
---* actor     	玩家对象
---* time     	进度条时间，秒
---* succ     	成功后跳转的函数
---* msg     	提示消息
---* canStop     	能否中断<br>0-不可中断<br>1-可以中断
---* fail     	中断触发的函数
---@param actor     	object
---@param time     	number
---@param succ     	string
---@param msg     	string
---@param canStop     	number
---@param fail     	string
function showprogressbardlg(actor,time,succ,msg,canStop,fail) end;

---改变玩家速度
---* actor     	玩家对象
---* type     	速度类型：<br>1-移动速度<br>2-攻击速度<br>3-施法速度
---* level     	速度等级 -10~10<br>0-原始速度，<br>-1时间间隔减少10%<br>+1时间间隔增加10%
---@param actor     	object
---@param type     	number
---@param level     	number
function changespeed(actor,type,level) end;

---百分比修改速度
---* actor     	玩家对象
---* model     	计算方式<br>1=移动速度<br>2=攻击速度<br>3=魔法速度
---* value     	速度值<br>0=原速度(大于0=加速 -=减速)
---* time     	有效时间秒<br>(为空=表示不限制时间,最大值65535)
---@param actor     	object
---@param model     	number
---@param value     	number
---@param time     	number
function changespeedex(actor,model,value,time) end;

---设置玩家穿人穿怪
---* actor     	玩家对象
---* type     	模式：0-恢复默认；1-穿人；2-穿怪；3-穿人穿怪
---* time     	时间(秒)
---* objType     	对象 ：0-玩家；1-宝宝
---@param actor     	object
---@param type     	number
---@param time     	number
---@param objType     	number
function throughhum(actor,type,time,objType) end;

---设置当前攻击目标
---* hitter     	攻击者(玩家/英雄/怪物)
---* target     	被攻击者(玩家/英雄/怪物)
---@param hitter     	object
---@param target     	object
function settargetcert(hitter,target) end;

---判断对象是否可被攻击
---* hitter     	攻击对象(玩家/英雄/怪物)
---* target     	被攻击对象(玩家/英雄/怪物)
---@param hitter     	object
---@param target     	object
function ispropertarget(hitter,target) end;

---增加气泡
---* actor     	玩家对象
---* id     	ID
---* name     	显示名称
---* func     	函数名(多参数用逗号分割)
---@param actor     	object
---@param id     	number
---@param name     	string
---@param func     	string
function addbutshow(actor,id,name,func) end;

---删除气泡
---* actor     	玩家对象
---* id     	气泡ID
---@param actor     	object
---@param id     	number
function delbutshow(actor,id) end;

---获取角色朝向前一格玩家对象
---* actor     	玩家对象
---@param actor     	object
function getoppositeobj(actor) end;

---调用游戏面板
---* actor     	玩家对象
---* nId     	面板ID
---* nState     	0=打开<br>1=打开面板重复点按钮不会关闭,除非主动点关闭按钮(一般做任务配合新手引导用到)<br>2=关闭当前面板ID
---* rankWnd     	面板ID(新排行榜用)
---* isHero     	0/nil=玩家<br>1=英雄(新排行榜用)
---@param actor     	object
---@param nId     	number
---@param nState     	number
---@param rankWnd     	number
---@param isHero     	 boolean
function openhyperlink(actor,nId,nState,rankWnd,isHero) end;

---开启自动挂机
---* actor     	玩家对象
---@param actor     	object
function startautoattack(actor) end;

---离线挂机
---* actor     	玩家对象
---* time     	离线时间（分）
---@param actor     	object
---@param time     	number
function offlineplay(actor,time) end;

---剔除离线挂机角色
---* mapId     	地图号,<br>“*”表示全部地图
---* level     	剔除等级<br>低于此等级均剔除<br>“*”表示所有
---* count     	最大剔除玩家数<br>“*”表示所有
---@param mapId     	string
---@param level     	string
---@param count     	string
function tdummy(mapId,level,count) end;

---获取玩家好友列表
---* actor     	玩家对象
---@param actor     	object
function getfriendnamelist(actor) end;

---人物转生控制
---* actor     	玩家对象
---* rLevel     	转生次数<br>一次转多少级(数值范围为1-255)
---* level     	转生后等级<br>代表转生后人物的等级，0为不改变人物当前等级
---* num     	分配点数<br>转生后可以得到的点数，此点数可能按比例换成人物属性点(数值范围 1 - 20000)
---@param actor     	object
---@param rLevel     	number
---@param level     	number
---@param num     	number
function renewlevel(actor,rLevel,level,num) end;

---调整人物转生属性点
---* actor     	玩家对象
---* sFlag     	操作符(=,+)
---* value     	点数(0-1000)
---@param actor     	object
---@param sFlag     	string
---@param value     	number
function bonuspoint(actor,sFlag,value) end;

---获取人物转生属性点
---* actor     	玩家对象
---@param actor     	object
function getbonuspoint(actor) end;

---复位属性点数
---* actor     	玩家对象
---@param actor     	object
function restbonuspoint(actor) end;

---获取玩家pk等级
---* actor     	玩家对象
---@param actor     	object
function getpklevel(actor) end;

---给按钮增加红点
---* actor     	玩家对象
---* win_id     	窗口ID
---* btn_id     	按钮ID/任务栏填任务ID
---* x     	X坐标
---* y     	Y坐标
---* type     	红点模式<br>0=图片<br>1=特效
---* mode     	红点模式=0(填图片路径)<br>红点模式=1(填特效编号)
---@param actor     	object
---@param win_id     	number
---@param btn_id     	number
---@param x     	number
---@param y     	number
---@param type     	number
---@param mode     	number
function reddot(actor,win_id,btn_id,x,y,type,mode) end;

---给按钮删除红点
---* actor     	玩家对象
---* win_id     	窗口ID
---* btn_ind     	按钮ID/任务栏填任务ID
---@param actor     	object
---@param win_id     	number
---@param btn_ind     	number
function reddel(actor,win_id,btn_ind) end;

---拾取道具飞入背包按钮动作
---* actor     	玩家对象
---* win_id     	窗口ID
---* btn_id     	按钮ID
---@param actor     	object
---@param win_id     	number
---@param btn_id     	number
function setpickitemtobag(actor,win_id,btn_id) end;

---吸怪功能
---* actor     	玩家对象
---* max     	最大范围
---* min     	最小范围
---* monLevel     	怪物等级<br>=0则嘲讽/吸引所以级别怪物
---* type     	0=不嘲讽玩家<br>1=嘲讽玩家
---* isMove     	0=怪物漂移到人物边<br>1=怪物瞬移到目前人物坐标<br>2=怪物瞬移到目前人物面前
---* unLimit     	0=无限制<br>1=怪物/人物攻击目标不归属自己的不可被吸
---@param actor     	object
---@param max     	number
---@param min     	number
---@param monLevel     	number
---@param type     	number
---@param isMove     	number
---@param unLimit     	number
function monmove(actor,max,min,monLevel,type,isMove,unLimit) end;

---人物显示一个放大的虚影
---* actor     	玩家对象
---* opacity     	透明度(0~255)
---* time     	显示时间(秒)
---@param actor     	object
---@param opacity     	number
---@param time     	number
function showphantom(actor,opacity,time) end;

---获取人物身上装备属性值命令
---* actor     	玩家对象
---* model     	类型(1，装备表里基础数据)
---* attrId     	属性ID
---* where     	装备位置(-2操作物品)
---* MakeIndex    	物品唯一ID
---@param actor     	object
---@param model     	number
---@param attrId     	number
---@param where     	string
---@param MakeIndex    	string
function getitemattidvalue(actor,model,attrId,where,MakeIndex) end;

---获取角色所有属性
---* actor     	玩家对象
---@param actor     	object
function attrtab(actor) end;

---是否在骑马
---* actor     	玩家对象
---@param actor     	object
function checkonhorse(actor) end;

---上马
---* actor     	玩家对象
---* horseAppr     	坐骑外观
---* horseEff     	坐骑特效外观
---* horseFature     	人物骑马外观
---* Type     	坐骑类型 0=单人 1=双人 2=连体
---@param actor     	object
---@param horseAppr     	number
---@param horseEff     	number
---@param horseFature     	number
---@param Type     	number
function ridehorse(actor,horseAppr,horseEff,horseFature,Type) end;

---下马
---* actor     	玩家对象
---@param actor     	object
function dismounthorse(actor) end;

---添加足迹特效
---* actor     	玩家对象
---* effectId     	特效id
---* modle     	播放模式<br>0/nil=两步播放<br>1=单步播放
---@param actor     	object
---@param effectId     	number
---@param modle     	number
function setmoveeff(actor,effectId,modle) end;

---给视野内玩家发送自定义广播消息
---* actor     	玩家对象
---* varIndex     	属性id(1~5)
---* varValue     	属性值
---@param actor     	object
---@param varIndex     	number
---@param varValue     	number
function setotherparams(actor,varIndex,varValue) end;

---收摊
---* actor     	玩家对象
---@param actor     	object
function stopmyshop(actor) end;

---骰子功能
---* actor     	玩家对象
---* num     	动画数量<br>比如3就是会出现3个骰子转动
---* funcName     	动画结束触发
---@param actor     	object
---@param num     	number
---@param funcName     	string
function playdice(actor,num,funcName) end;

---开启宝箱
---* actor     	玩家对象
---* boxIndex     	宝箱ID
---* num     	次数(不读数据表次数,只认这里的次数)
---@param actor     	object
---@param boxIndex     	string
---@param num     	number
function opendragonbox(actor,boxIndex,num) end;

---立即推送前端变量
---* actor     	玩家对象
---@param actor     	object
function sendredvartoclient(actor) end;

---设置人物照亮范围（光照）
---* actor     	玩家对象
---* value     	人物照亮范围值<br>-1=读装备的光照值
---@param actor     	object
---@param value     	number
function setcandlevalue(actor,value) end;

---获取自定义排行榜缓存数据
---* rankIndex     	自定义排行榜页签
---* isHero     	人物还是英雄<br>(0:人物,1:英雄)
---@param rankIndex     	object
---@param isHero     	number
function getsortdata(rankIndex,isHero) end;

---镖车自动寻路到指定坐标
---* actor     	玩家对象
---* aimX     	目标X坐标
---* aimY     	目标Y坐标
---* range     	人物离镖车距离内自动寻路<br>取值范围：0-12<br>0-不检测
---@param actor     	object
---@param aimX     	number
---@param aimY     	number
---@param range     	number
function dartmap(actor,aimX,aimY,range) end;

---人物下线，镖车存活设置
---* actor     	玩家对象
---* time     	镖车存活时间，秒
---* isDie     	下线是否消失<br>0-消失，1-时间到达消失
---@param actor     	object
---@param time     	number
---@param isDie     	number
function darttime(actor,time,isDie) end;

---给物品
---* actor     	玩家对象
---* itemName     	物品名称
---* qty     	数量
---* bind     	物品规则
---* desc     	描述
---@param actor     	object
---@param itemName     	string
---@param qty     	number
---@param bind     	number
---@param desc     	string
function giveitem(actor,itemName,qty,bind,desc) end;

---给物品直接装备
---* actor     	玩家对象
---* where     	装备位置
---* itemName     	物品名称
---* qty     	数量
---* bind     	物品规则
---* desc     	描述
---@param actor     	object
---@param where     	number
---@param itemName     	string
---@param qty     	number
---@param bind     	number
---@param desc     	string
function giveonitem(actor,where,itemName,qty,bind,desc) end;

---拿物品
---* actor     	玩家对象
---* itemName     	物品名称
---* itemNum     	数量
---* ignoreJP     	忽略极品<br>0：所有都扣除<br>1：极品不扣除
---* desc     	描述
---@param actor     	object
---@param itemName     	string
---@param itemNum     	number
---@param ignoreJP     	number
---@param desc     	string
function takeitem(actor,itemName,itemNum,ignoreJP,desc) end;

---拿物品(拓展)
---* actor     	玩家对象
---* itemName     	物品名称
---* itemNum     	数量
---* bind     	0=忽略<br>1=扣除非绑定物品<br>2=扣除绑定物品
---* desc     	描述
---@param actor     	object
---@param itemName     	string
---@param itemNum     	number
---@param bind     	number
---@param desc     	string
function takeitemex(actor,itemName,itemNum,bind,desc) end;

---根据唯一ID删除仓库物品
---* actor     	玩家对象
---* itemMakeId     	删除唯一ID物品
---@param actor     	object
---@param itemMakeId     	string
function delstorageitem(actor,itemMakeId) end;

---根据idx删除仓库物品
---* actor     	玩家对象
---* itemIndex     	删除所有Idx物品
---@param actor     	object
---@param itemIndex     	string
function delstorageitembyidx(actor,itemIndex) end;

---获取物品信息
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---* id     	~~1:唯一ID~~<br>2:物品ID<br>3:剩余持久<br>4:最大持久<br>5:叠加数量<br>6:绑定状态<br>7:物品名称<br>8:修改后物品名称
---@param actor     	object
---@param makeIndex     	string
---@param id     	number
function getiteminfo(actor,makeIndex,id) end;

---获取物品基础信息
---* iteminfo     	物品Id/物品名称
---* id     	0:idx<br>1:名称<br>2:StdMode<br>3:Shape<br>4:重量<br>5:AniCount<br>6:最大持久<br>7:叠加数量<br>8:价格（price）<br>9:使用条件<br>10:使用等级<br>11:自定义常量(29列)<br>12:自定义常量(30列)<br>13:道具颜色
---@param iteminfo     	string
---@param id     	number
function getstditeminfo(iteminfo,id) end;

---获取物品基础属性
---* itemId     	物品ID
---* id     	对应属性表的属性ID
---@param itemId     	number
---@param id     	number
function getstditematt(itemId,id) end;

---刷新物品信息到前端
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---@param actor     	object
---@param makeIndex     	string
function refreshitem(actor,makeIndex) end;

---根据物品唯一id替换模板数据
---* actor     	玩家对象
---* itemMakeId     	唯一ID
---* itemIndex     	新的模板数据的物品ID
---@param actor     	object
---@param itemMakeId     	string
---@param itemIndex     	number
function changeitemidx(actor,itemMakeId,itemIndex) end;

---增加限次使用物品的次数
---* actor     	玩家对象
---* itemMakeId     	唯一ID
---* num     	次数
---@param actor     	object
---@param itemMakeId     	string
---@param num     	number
function addfunitemdura(actor,itemMakeId,num) end;

---获取物品持久度
---* actor     	玩家对象
---* itemMakeId     	唯一ID
---@param actor     	object
---@param itemMakeId     	string
function getdura(actor,itemMakeId) end;

---修改物品持久度
---* actor     	玩家对象
---* itemMakeId     	唯一ID
---* char     	操作符(+ - =)
---* dura     	持久度
---@param actor     	object
---@param itemMakeId     	string
---@param char     	string
---@param dura     	number
function setdura(actor,itemMakeId,char,dura) end;

---修改装备内观Looks值
---* actor     	玩家对象
---* itemPos     	装备位置(-2操作物品唯一Id)
---* char     	操作符(+ - =)
---* picture     	内观图片
---* makeIndex     	物品唯一Id
---@param actor     	object
---@param itemPos     	number
---@param char     	string
---@param picture     	number
---@param makeIndex     	string
function setitemlooks(actor,itemPos,char,picture,makeIndex) end;

---通过物品唯一id拿走物品
---* actor     	玩家对象
---* ids     	物品唯一ID，逗号(,)串联
---* count     	叠加物品扣除数量，<br>不填此参数，默认全部扣除<br>不可叠加物品全部扣除
---* desc     	描述
---@param actor     	object
---@param ids     	string
---@param count     	number
---@param desc     	string
function delitembymakeindex(actor,ids,count,desc) end;

---使用物品（吃药、使用特殊物品等）
---* actor     	玩家对象
---* itemName     	物品名称
---* count     	数量
---@param actor     	object
---@param itemName     	string
---@param count     	number
function eatitem(actor,itemName,count) end;

---设置物品来源（使用物品唯一Id）
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---* source     	json字符串
---@param actor     	object
---@param makeIndex     	string
---@param source     	string
function setthrowitemly2(actor,makeIndex,source) end;

---设置物品来源
---* source     	json字符串
---@param source     	string
function setthrowitemly(source) end;

---获取物品来源（使用物品唯一Id）
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---@param actor     	object
---@param makeIndex     	string
function getthrowitemly(actor,makeIndex) end;

---设置物品特效
---* actor     	玩家对象
---* itemPos     	装备位置(-2操作物品唯一Id)
---* bagEffectId     	背包特效编号
---* inEffectId     	内观特效编号
---* order1     	背包特效层级<br>0=前;1=后
---* order2     	内观特效层级<br>0=前;1=后
---* makeIndex     	物品唯一Id
---@param actor     	object
---@param itemPos     	number
---@param bagEffectId     	number
---@param inEffectId     	number
---@param order1     	number
---@param order2     	number
---@param makeIndex     	string
function setitemeffect(actor,itemPos,bagEffectId,inEffectId,order1,order2,makeIndex) end;

---根据物品获取Json
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---@param actor     	object
---@param makeIndex     	string
function getitemjson(actor,makeIndex) end;

---根据json字符串给物品
---* actor     	玩家对象
---* json     	json字符串
---* desc     	描述
---@param actor     	object
---@param json     	string
---@param desc     	string
function giveitembyjson(actor,json,desc) end;

---根据物品获取前端显示的Json
---* actor	玩家对象
---* makeIndex	物品唯一Id
---@param actor	object
---@param makeIndex	string
function getitemjsonex(actor,makeIndex) end;

---关闭指定装备对比提示
---* actor     	玩家对象
---* order     	1=物品唯一ID 2=物品IDX 3=物品名称
---* str     	参数1的值
---@param actor     	object
---@param order     	number
---@param str     	string
function nothintitem(actor,order,str) end;

---设置物品绑定状态
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---* bind     	绑定类型
---* state     	绑定状态<br>0=不绑定<br>1=绑定
---@param actor     	object
---@param makeIndex     	string
---@param bind     	number
---@param state     	number
function setitemstate(actor,makeIndex,bind,state) end;

---判断绑定状态
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---* bind     	绑定类型
---@param actor     	object
---@param makeIndex     	string
---@param bind     	number
function checkitemstate(actor,makeIndex,bind) end;

---判断角色是否有该物品
---* actor     	玩家对象
---* itemMakeIndex     	物品唯一id
---@param actor     	object
---@param itemMakeIndex     	object
function hasitem(actor,itemMakeIndex) end;

---修复所有装备
---* actor     	玩家对象
---@param actor     	object
function repairall(actor) end;

---调整人物身上物品装备名字颜色
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---* color     	颜色(0-255)颜色=0时恢复默认颜色
---@param actor     	object
---@param makeIndex     	object
---@param color     	number
function changeitemnamecolor(actor,makeIndex,color) end;

---检测装备名字的颜色
---* makeIndex     	装备唯一Id
---@param makeIndex     	object
function getitemnamecolor(makeIndex) end;

---修改物品/装备名称
---* actor     	玩家对象
---* itemPos     	装备位置(-2操作物品唯一Id)
---* itemName     	装备名字
---* makeIndex     	物品唯一Id
---@param actor     	object
---@param itemPos     	number
---@param itemName     	string
---@param makeIndex     	string
function changeitemname(actor,itemPos,itemName,makeIndex) end;

---获取物品原始各项数据库字段值参数
---* itemData     	物品ID/物品名称
---* fieldName     	字段名
---@param itemData     	number|string
---@param fieldName     	string
function getdbitemfieldvalue(itemData,fieldName) end;

---获取背包物品数量
---* actor     	玩家对象
---* itemName     	物品名称
---* model     	物品绑定状态<br>0=忽略;<br>1=非绑定;<br>2=绑定;
---@param actor     	object
---@param itemName     	string
---@param model     	string
function getbagitemcount(actor,itemName,model) end;

---根据索引返回背包物品信息
---* actor     	玩家对象
---* index     	索引号,0开始
---@param actor     	object
---@param index     	number
function getiteminfobyindex(actor,index) end;

---整理背包里的物品
---* actor     	玩家对象
---@param actor     	object
function refreshbag(actor) end;

---获取仓库所有物品
---* actor     	玩家对象
---@param actor     	object
function getstorageitems(actor) end;

---获取背包物品列表
---* actor     	玩家对象
---* itemName     	道具名字
---* isBind     	是否绑定<br>0=忽略<br>1=非绑定<br>2=绑定
---@param actor     	object
---@param itemName     	string
---@param isBind     	number
function getbagitems(actor,itemName,isBind) end;

---从装备位扣除物品
---* actor     	玩家对象
---* where     	装备位
---* desc     	描述
---@param actor     	object
---@param where     	number
---@param desc     	string
function delbodyitem(actor,where,desc) end;

---根据StdMode获取装备位
---* stdMode     	道具StdMode
---@param stdMode     	number
function getposbystdmode(stdMode) end;

---批量检测背包物品
---* actor     	玩家对象
---* itemStr     	物品名称#物品数量&物品名称#物品数量 (&=和的意思)
---* isBind     	0=不检测;<br>1.非绑定<br>2.绑定
---* model     	参数1中的物品名称是ID还是道具名称<br>0=道具名称<br>1=道具ID）
---* desc     	描述
---@param actor     	object
---@param itemStr     	string
---@param isBind     	number
---@param model     	number
---@param desc     	string
function checkitems(actor,itemStr,isBind,model,desc) end;

---批量拿走背包物品
---* actor     	玩家对象
---* itemStr     	物品名称#物品数量&amp;物品名称#物品数量 (&amp;=和的意思)
---* isBind     	0=不检测;<br>1.非绑定<br>2.绑定
---* model     	参数1中的物品名称是ID还是道具名称<br>0=道具名称<br>1=道具ID）
---* isBindFirst     	0=按照默认顺序<br>1=优先绑定
---* desc     	描述，不填默认“NPC回收”
---@param actor     	object
---@param itemStr     	string
---@param isBind     	number
---@param model     	number
---@param isBindFirst     	number
---@param desc     	string
function takes(actor,itemStr,isBind,model,isBindFirst,desc) end;

---扣除角色穿戴的装备
---* actor     	玩家对象
---* itemName     	装备名称
---* num     	扣除物品数量
---* desc     	描述
---@param actor     	object
---@param itemName     	string
---@param num     	number
---@param desc     	string
function takew(actor,itemName,num,desc) end;

---批量给予物品
---* actor     	玩家对象
---* itemStr     	物品参数<br>物品名称#数量#绑定状态&物品名称#数量#绑定状态
---* desc     	描述
---@param actor     	object
---@param itemStr     	string
---@param desc     	string
function gives(actor,itemStr,desc) end;

---检测身上佩戴的装备
---* actor     	玩家对象
---* item_name     	装备名称
---* item_num     	检测数量
---@param actor     	object
---@param item_name     	string
---@param item_num     	number
function checkitemw(actor,item_name,item_num) end;

---返回前端面板消息[合成系统]
---* actor     	玩家对象
---* index     	合成表idx
---* json     	json信息
---@param actor     	object
---@param index     	string
---@param json     	string
function sendactionofjson(actor,index,json) end;

---增加回收组别
---* actor     	玩家对象
---* recyclingType     	回收组别，对应表中group字段(支持多类别配置用“;”分割)
---@param actor     	string
---@param recyclingType     	string
function addrecyclingtype(actor,recyclingType) end;

---删除回收组别
---* actor     	玩家对象
---* index     	回收组别索引，-1表示清空回收组别
---@param actor     	string
---@param index     	string
function delrecyclingtype(actor,index) end;

---执行回收
---* actor     	玩家对象
---@param actor     	object
function execrecycling(actor) end;

---执行自动回收
---* actor     	玩家对象
---* interval     	检测间隔时间（单位：秒）
---* maxBagSpace     	执行回收的背包空格
---@param actor     	string
---@param interval     	number
---@param maxBagSpace     	number
function autorecycling(actor,interval,maxBagSpace) end;

---装备加自定义属性
---* actor     	玩家对象
---* itemmakeid     	装备唯一id
---* type     	属性组
---* job     	职业
---* attId     	属性id
---* attVar     	属性值
---@param actor     	object
---@param itemmakeid     	string
---@param type     	number
---@param job     	number
---@param attId     	number
---@param attVar     	number
function additemattr(actor,itemmakeid,type,job,attId,attVar) end;

---物品加自定义属性表
---* actor     	玩家对象
---* itemmakeid     	物品唯一id
---* type     	属性组
---* job     	职业
---* attTab     	属性表{属性id = 属性值,属性id=属性值}
---@param actor     	object
---@param itemmakeid     	string
---@param type     	number
---@param job     	number
---@param attTab     	table
function additemattrEX(actor,itemmakeid,type,job,attTab) end;

---获取物品自定义属性
---* actor     	玩家对象
---* itemmakeid     	装备唯一id
---* type     	属性组
---@param actor     	object
---@param itemmakeid     	object
---@param type     	number
function getitemattr(actor,itemmakeid,type) end;

---获取物品自定义属性组
---* actor     	玩家对象
---* makeid     	物品唯一id
---@param actor     	object
---@param makeid     	object
function getitemattrtype(actor,makeid) end;

---删除物品自定义属性
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---* type     	属性组
---* attVar     	属性id(为0时清除该组所有属性)
---@param actor     	object
---@param makeIndex     	object
---@param type     	number
---@param attVar     	number
function delitemattr(actor,makeIndex,type,attVar) end;

---根据装备位置获取装备唯一id
---* actor     	玩家对象
---* type     	装备位
---@param actor     	object
---@param type     	number
function GetItemByPos(actor,type) end;

---物品设置标记
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---* index     	标记号
---* flag     	标记
---* str     	描述
---@param actor     	object
---@param makeIndex     	string
---@param index     	number
---@param flag     	number
---@param str     	string
function SetItemFlag(actor,makeIndex,index,flag,str) end;

---物品获取标记
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---* index     	标记号
---@param actor     	object
---@param makeIndex     	string
---@param index     	number
function GetItemFlag(actor,makeIndex,index) end;

---物品设置投保次数
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---* num     	投保次数
---@param actor     	object
---@param makeIndex     	string
---@param num     	number
function SetInsurance(actor,makeIndex,num) end;

---物品获取投保次数
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---@param actor     	object
---@param makeIndex     	string
function GetInsurance(actor,makeIndex) end;

---物品设置剩余时间
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---* time     	时间
---@param actor     	object
---@param makeIndex     	string
---@param time     	number
function SetItemLife(actor,makeIndex,time) end;

---物品获取剩余时间
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---@param actor     	object
---@param makeIndex     	string
function GetItemLife(actor,makeIndex) end;

---物品设置星级
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---* starNum     	星星数
---@param actor     	object
---@param makeIndex     	string
---@param starNum     	number
function SetItemStar(actor,makeIndex,starNum) end;

---物品获取星级
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---@param actor     	object
---@param makeIndex     	string
function GetItemStar(actor,makeIndex) end;

---获取玩家身上所有装备
---* actor     	玩家对象
---@param actor     	object
function GetAllEquip(actor) end;

---设置物品幸运值
---* actor     	玩家对象
---* makeIndex     	物品唯一id
---* value     	幸运值
---@param actor     	object
---@param makeIndex     	string
---@param value     	number
function SetItemLuck(actor,makeIndex,value) end;

---获取物品幸运值
---* actor     	玩家对象
---* makeIndex     	物品唯一id
---@param actor     	object
---@param makeIndex     	string
function GetItemLuck(actor,makeIndex) end;

---设置装备开孔状态
---* actor     	玩家对象
---* makeIndex     	唯一id
---* cellPos     	孔位置（0~19）
---* type     	0：闭孔，1：开孔
---@param actor     	object
---@param makeIndex     	string
---@param cellPos     	number
---@param type     	number
function SetInlayCell(actor,makeIndex,cellPos,type) end;

---获取开孔状态
---* actor     	玩家对象
---* makeIndex     	唯一id
---* cellPos     	孔位置
---@param actor     	object
---@param makeIndex     	string
---@param cellPos     	number
function GetInlayCell(actor,makeIndex,cellPos) end;

---镶嵌/拆卸宝石
---* actor     	玩家对象
---* makeIndex     	唯一id
---* cellPos     	孔位置（0~19）
---* type     	镶嵌宝石idx；0：拆卸宝石不返还；1：拆卸宝石返还
---@param actor     	object
---@param makeIndex     	string
---@param cellPos     	number
---@param type     	number
function SetInlayGem(actor,makeIndex,cellPos,type) end;

---获取宝石镶嵌
---* actor     	玩家对象
---* item     	装备对象
---@param actor     	object
---@param item     	object
function GetInlayGem(actor,item) end;

---获取装备镶嵌情况
---* actor     	玩家对象
---* makeIndex     	唯一id
---@param actor     	object
---@param makeIndex     	string
function GetInlayInfo(actor,makeIndex) end;

---获取物品最大持久度
---* actor     	玩家对象
---* makeIndex     	唯一id
---@param actor     	object
---@param makeIndex     	string
function GetMaxDura(actor,makeIndex) end;

---修改物品最大持久度
---* actor     	玩家对象
---* makeIndex	唯一id
---* type     	&quot;+&quot;&quot;-&quot;&quot;=&quot;
---* value     	持久度值
---@param actor     	object
---@param makeIndex	string
---@param type     	string
---@param value     	number
function SetMaxDura(actor,makeIndex,type,value) end;

---删除物品
---* actor     	玩家对象
---* itemtab     	物品table<br>{[物品id]=删除数量}
---* bind     	0=忽略 <br>1=扣除非绑定物品<br>2=扣除绑定物品
---* istype     	0=仅背包 <br>1=背包和身上 优先背包<br>2=背包和身上 优先身上
---* desc     	描述
---@param actor     	object
---@param itemtab     	table
---@param bind     	number
---@param istype     	number
---@param desc     	string
function DelItem(actor,itemtab,bind,istype,desc) end;

---附加随机极品属性
---* actor     	玩家对象
---* item     	装备唯一id
---* id     	极品属性id，例：ID1#ID2 (cfg_quality.xls表ID)
---* num     	最大极品属性条数
---* type     	1 覆盖 , 0 叠加
---@param actor     	object
---@param item     	string
---@param id     	string
---@param num     	number
---@param type     	number
function SetItemQuality(actor,item,id,num,type) end;

---附加固定极品属性
---* actor     	玩家对象
---* item     	装备唯一id
---* operate     	 运算符(+,-,=)
---* att     	属性ID#数值(cfg_quality.xls表ID)
---@param actor     	object
---@param item     	string
---@param operate     	string
---@param att     	string
function SetQuality(actor,item,operate,att) end;

---获取极品属性
---* actor     	玩家对象
---* makeIndex     	唯一id
---@param actor     	object
---@param makeIndex     	string
function GetQuality(actor,makeIndex) end;

---标记物品为极品
---* actor     	玩家对象
---* item     	装备对象
---* isJp     	0/1是否为极品
---@param actor     	object
---@param item     	object
---@param isJp     	number
function SetItemJP(actor,item,isJp) end;

---判定物品是否极品
---* actor     	玩家对象
---* item     	装备对象
---@param actor     	object
---@param item     	object
function stdmodefunc(actor,item) end;

---刷怪
---* mapId     	地图id
---* x     	坐标X
---* y     	坐标Y
---* monName     	怪物名称
---* range     	范围
---* count     	数量
---* color     	颜色(0~255)
---@param mapId     	object
---@param x     	number
---@param y     	number
---@param monName     	string
---@param range     	number
---@param count     	number
---@param color     	number
function genmon(mapId,x,y,monName,range,count,color) end;

---刷怪(拓展)
---* mapId     	地图id
---* x     	坐标X
---* y     	坐标Y
---* monName     	怪物名称
---* range     	范围
---* count     	数量
---* owner     	归属对象<br>填0则无指定归属
---* color     	颜色(0~255)
---* showName     	怪物自定义名称
---* isFilt     	是否过滤数字<br>0过滤，1不过滤
---* countryName     	国家名称
---* nAttack     	是否可攻击同国家的玩家<br>0=不可以<br>1=可以
---* nNatMonPK     	不同国家怪物是否可PK<br>0=不可以<br>1=可以
---* nPlayerPk     	人物是否可以攻击相同国家怪物<br>0=可以<br>1=不可以
---* nNg     	是否是内功怪<br>0=普通怪<brstring>1=内功怪
---@param mapId     	string
---@param x     	number
---@param y     	string
---@param monName     	string
---@param range     	number
---@param count     	number
---@param owner     	number|object
---@param color     	string
---@param showName     	string
---@param isFilt     	string
---@param countryName     	string
---@param nAttack     	number
---@param nNatMonPK     	number
---@param nPlayerPk     	number
---@param nNg     	number
function genmonex(mapId,x,y,monName,range,count,owner,color,showName,isFilt,countryName,nAttack,nNatMonPK,nPlayerPk,nNg) end;

---杀怪1
---* mapId     	地图id
---* monName     	怪物全名，空 或者 * 杀死全部
---* count     	数量，0所有
---* drop     	是否掉落物品，true不掉落
---* trigger     	是否不触发killmon,true不触发，默认为false触发
---@param mapId     	string
---@param monName     	string
---@param count     	number
---@param drop     	 boolean
---@param trigger     	 boolean
function killmonsters(mapId,monName,count,drop,trigger) end;

---杀怪2
---* actor     	玩家对象
---* mon     	怪物对象
---* drop     	是否掉落物品，true掉落
---* trigger     	是否触发killmon
---* showDie     	是否显示死亡动画<br>=false视为系统杀怪,将不会掉落物品与经验
---@param actor     	object
---@param mon     	object
---@param drop     	 boolean
---@param trigger     	 boolean
---@param showDie     	 boolean
function killmonbyobj(actor,mon,drop,trigger,showDie) end;

---清掉地图某范围的怪物
---* mapId     	地图id
---* X     	坐标X
---* Y     	坐标Y
---* range     	范围
---* monName     	怪物名 *表示所有怪物
---* isDrop     	是否爆物品<br>0=不爆;1=爆
---* isClear     	是否清尸体<br>0=不清;1=清
---@param mapId     	string
---@param X     	number
---@param Y     	number
---@param range     	number
---@param monName     	string
---@param isDrop     	number
---@param isClear     	number
function killmapmon(mapId,X,Y,range,monName,isDrop,isClear) end;

---杀怪物品再爆
---* actor     	玩家对象
---* count     	怪物物品掉落增加次数
---@param actor     	object
---@param count     	number
function monitems(actor,count) end;

---指定怪物的爆出
---* actor     	玩家对象
---* itemName     	怪物名称
---* value     	可爆出次数<br>最大多爆20次
---* delayTime     	延迟毫秒数
---@param actor     	object
---@param itemName     	string
---@param value     	number
---@param delayTime     	number
function monitemsex(actor,itemName,value,delayTime) end;

---召唤宝宝
---* actor     	玩家对象
---* monName     	怪物名称
---* level     	宝宝等级(最高为7)
---* time     	叛变时间(分钟)
---* param1     	预留(填0)
---* param2     	预留(填0)
---* param3     	设置大于0，检测时不计算该宝宝数量(仅M2控制的召唤数量)
---@param actor     	object
---@param monName     	string
---@param level     	number
---@param time     	number
---@param param1     	number
---@param param2     	number
---@param param3     	number
function recallmob(actor,monName,level,time,param1,param2,param3) end;

---召唤宝宝2
---* actor     	玩家对象
---* Name     	怪物名称
---* x     	怪物当前地图出生点X
---* y     	怪物当前地图出生点Y
---* lv     	怪物等级
---* num     	数量
---* time     	叛变时间(秒) 不填 则为10天
---* color     	是否自动变色
---* count     	检测时不计算该宝宝数量
---* upgard     	宝宝不升级
---* hide_name     	隐藏主人名
---* attr     	继承人物伤害百分比
---* hp_value     	宝宝血量数值
---* buff_id     	BUFF ID 多个BUFF ID用#号连接
---@param actor     	object
---@param Name     	string
---@param x     	number
---@param y     	number
---@param lv     	number
---@param num     	number
---@param time     	number
---@param color     	number
---@param count     	number
---@param upgard     	number
---@param hide_name     	number
---@param attr     	number
---@param hp_value     	number
---@param buff_id     	string
function recallmobex(actor,Name,x,y,lv,num,time,color,count,upgard,hide_name,attr,hp_value,buff_id) end;

---把怪物设置成宝宝
---* mon     	怪物对象
---* actor     	玩家对象
---* time     	叛变时间（秒）
---@param mon     	object
---@param actor     	object
---@param time     	number
function setmonmaster(mon,actor,time) end;

---遍历宠物(宝宝)列表
---* actor     	玩家对象
---* nIndex     	索引(0开始)
---@param actor     	object
---@param nIndex     	number
function getslavebyindex(actor,nIndex) end;

---修改宝宝名称
---* mon     	宝宝对象
---* name     	宝宝新名字
---@param mon     	object
---@param name     	string
function changemonname(mon,name) end;

---修改宝宝属性值
---* actor     	玩家对象
---* mon     	宝宝对象
---* attr     	属性位置
---* method     	操作符(+ - =)
---* value     	属性值
---* time     	有效时间
---@param actor     	object
---@param mon     	object
---@param attr     	number
---@param method     	string
---@param value     	number
---@param time     	number
function changemobability(actor,mon,attr,method,value,time) end;

---获取宝宝等级
---* mon     	宝宝对象
---@param mon     	object
function getslavelevel(mon) end;

---修改宝宝等级
---* actor     	玩家对象
---* mon     	宝宝对象
---* operate     	操作符号(+,-,=)
---* nLevel     	等级
---@param actor     	object
---@param mon     	object
---@param operate     	string
---@param nLevel     	number
function changeslavelevel(actor,mon,operate,nLevel) end;

---根据唯一id获取怪物对象
---* mapId     	地图id
---* monUserId     	怪物唯一id(UserID)
---@param mapId     	string
---@param monUserId     	string
function getmonbyuserid(mapId,monUserId) end;

---返回怪物基础信息
---* index     	怪物的IDX
---* id     	id<br>1-怪物名称；<br>2-怪物名字颜色；<br>3-杀死怪物获得的经验值；
---@param index     	number
---@param id     	number
function getmonbaseinfo(index,id) end;

---检测范围内怪物数量
---* mapId     	地图Id
---* monName     	怪物名，为空 or * 为检测所有怪
---* nX     	坐标X
---* nY     	坐标Y
---* nRange     	范围
---@param mapId     	string
---@param monName     	string
---@param nX     	number
---@param nY     	number
---@param nRange     	number
function checkrangemoncount(mapId,monName,nX,nY,nRange) end;

---召唤小精灵
---* actor     	玩家对象
---* monName     	精灵名称
---@param actor     	object
---@param monName     	string
function createsprite(actor,monName) end;

---检测小精灵
---* actor     	玩家对象
---* monName     	精灵名称,为空 则检测全部
---@param actor     	object
---@param monName     	object
function checkspritelevel(actor,monName) end;

---回收小精灵
---* actor     	玩家对象
---@param actor     	object
function releasesprite(actor) end;

---小精灵拾取模式
---* actor     	玩家对象
---* mode     	模式<br>0=以人物为中心捡取<br>1=以小精灵为中心捡取<br>3=以小精灵为中心小精灵一个个捡取 
---* range     	范围
---* interval     	间隔，最小500ms
---@param actor     	object
---@param mode     	number
---@param range     	number
---@param interval     	number
function pickupitems(actor,mode,range,interval) end;

---小精灵停止拾取
---* actor     	玩家对象
---@param actor     	object
function stoppickupitems(actor) end;

---在指定位置优先打指定的怪
---* actor     	玩家对象
---* map     	地图
---* X     	X坐标
---* Y     	Y坐标
---* monName     	优先攻击的怪物名称
---@param actor     	object
---@param map     	string
---@param X     	number
---@param Y     	number
---@param monName     	string
function killmobappoint(actor,map,X,Y,monName) end;

---临时增加怪物爆出物品
---* obj     	人物、怪物对象
---* mon     	怪物对象
---* itemName     	物品名称
---@param obj     	object
---@param mon     	object
---@param itemName     	string
function additemtodroplist(obj,mon,itemName) end;

---嘲讽怪物
---* actor     	玩家对象
---* distance     	距离人物格子数
---* grade     	受嘲讽影响的怪物等级上限（不大于指定等级均会被吸引）
---@param actor     	object
---@param distance     	number
---@param grade     	number
function dotaunt(actor,distance,grade) end;

---宝宝嘲讽
---* actor     	玩家对象
---* index     	第几个宝宝（第一个宝宝为0）
---* range     	距离格子数
---* levelMax     	受嘲讽影响的怪物等级上限（不大于指定等级均会被吸引）
---@param actor     	object
---@param index     	number
---@param range     	number
---@param levelMax     	number
function mobdotaunt(actor,index,range,levelMax) end;

---调整宝宝攻击人物的威力倍率
---* actor     	玩家对象
---* petName     	宝宝名称(带数字和不带数字都可以)
---* pro     	攻击人物威力倍率(威力倍数为0时不攻击人物, 110=攻击人物倍数1.1倍)
---@param actor     	object
---@param petName     	string
---@param pro     	number
function changeslaveattackhumpowerrate(actor,petName,pro) end;

---怪物寻路/巡逻
---* actor     	玩家对象
---* posX     	x坐标集<br>多坐标;分割<br>最多传入9个
---* posY     	y坐标集<br>多坐标;分割<br>最多传入9个
---* model     	0=寻路<br>1=巡逻
---@param actor     	object
---@param posX     	number
---@param posY     	number
---@param model     	number
function monmission(actor,posX,posY,model) end;

---怪物寻路
---* mapId     	地图id
---* x     	x坐标串联
---* y     	y坐标串联
---* monX     	刷怪坐标x
---* monY     	刷怪坐标y
---* count     	数量
---* range     	范围
---* monName     	怪物名字
---* target     	目标
---* country     	国家
---* attackSelfPlayer     	是否攻击本国玩家(0,1)
---* attackPVP     	不同国家怪物是否PK(0,1)
---* monNameColor     	怪物名字颜色
---* diableSelfPlayerAttack     	是否禁止本国玩家攻击(0,1)
---@param mapId     	string
---@param x     	string
---@param y     	string
---@param monX     	string
---@param monY     	string
---@param count     	number
---@param range     	number
---@param monName     	string
---@param target     	string
---@param country     	string
---@param attackSelfPlayer     	number
---@param attackPVP     	number
---@param monNameColor     	string
---@param diableSelfPlayerAttack     	number
function mission(mapId,x,y,monX,monY,count,range,monName,target,country,attackSelfPlayer,attackPVP,monNameColor,diableSelfPlayerAttack) end;

---命令移动怪物
---* monName     	怪物名字
---* mapId     	地图ID
---* posX1     	老坐标X
---* posY1     	老坐标Y
---* posX2     	新坐标X
---* posY2     	新坐标Y
---@param monName     	string
---@param mapId     	string
---@param posX1     	number
---@param posY1     	number
---@param posX2     	number
---@param posY2     	number
function movemontopos(monName,mapId,posX1,posY1,posX2,posY2) end;

---获取怪物原始各项数据库字段值参数
---* monInfo     	怪物ID/怪物名称
---* fieldName     	字段名(看下方示例)
---@param monInfo     	number|string
---@param fieldName     	string
function getdbmonfieldvalue(monInfo,fieldName) end;

---重置怪物生成计时器
---* mapId     	地图ID
---* monPosX     	怪物X坐标
---* monPosY     	怪物Y坐标
---* monName     	怪物名称
---@param mapId     	string
---@param monPosX     	number
---@param monPosY     	number
---@param monName     	string
function resetmongentick(mapId,monPosX,monPosY,monName) end;

---让怪物释放自定义技能
---* mon     	怪物对象
---* skillId     	自定义技能id
---* X     	目标点X坐标
---* Y     	目标点Y坐标
---* target     	目标对象
---@param mon     	object
---@param skillId     	number
---@param X     	number
---@param Y     	number
---@param target     	object
function mon_docustommagic(mon,skillId,X,Y,target) end;

---添加自定义怪物攻击表现
---* mon     	怪物对象
---* skillId     	攻击表现id对应cfg_monattack表
---@param mon     	object
---@param skillId     	number
function addmonattack(mon,skillId) end;

---设置宝宝叛变时间
---* mon     	宝宝对象
---* time     	时间（秒）
---@param mon     	object
---@param time     	number
function setmobtreachery(mon,time) end;

---获取宝宝叛变时间
---* mon     	宝宝对象
---@param mon     	object
function getmobtreachery(mon) end;

---创建行会
---* actor     	玩家对象
---* guildName     	行会名
---@param actor     	object
---@param guildName     	string
function buildguild(actor,guildName) end;

---获取人物所在行会成员数量
---* actor     	玩家对象
---@param actor     	object
function getguildmembercount(actor) end;

---设置行会成员人数上限
---* guild     	玩家对象
---* operate     	(操作符 + - = )
---* num     	数量
---@param guild     	object
---@param operate     	string
---@param num     	number
function changeguildmemberlimit(guild,operate,num) end;

---获取玩家所在的行会对象
---* actor     	玩家对象
---@param actor     	object
function getmyguild(actor) end;

---搜索行会
---* index     	搜索关键词：0-行会ID，1-行会名称
---* key     	搜索关键词
---@param index     	number
---@param key     	string
function findguild(index,key) end;

---获取行会信息
---* guild     	行会对象
---* index     	索引
---@param guild     	object
---@param index     	object
function getguildinfo(guild,index) end;

---设置行会信息
---* guild     	行会对象
---* index     	索引
---* value     	要设置的内容
---@param guild     	object
---@param index     	number
---@param value     	string
function setguildinfo(guild,index,value) end;

---获取所有行会对象
function getallguild() end;

---加入行会
---* actor     	玩家对象
---* guildName     	行会名
---@param actor     	object
---@param guildName     	string
function addguildmember(actor,guildName) end;

---退出行会
---* actorInfo     	玩家对象/玩家名/唯一ID
---* guildName     	行会名
---* type     	参数1类型:<br>0 = 参数1填玩家对象;<br>1 = 参数1填玩家名字;<br>2 = 参数1填玩家唯一ID;<br>唯一id可用于踢离线玩家,不填默认为0
---@param actorInfo     	object|string
---@param guildName     	string
---@param type     	number
function delguildmember(actorInfo,guildName,type) end;

---设置行会成员在行会中的职位
---* actor     	玩家对象
---* pos     	在行会中的职位<br>0：会长;<br>1：副会长;<br>2：行会成员1;<br>3：行会成员2;<br>4：行会成员3;
---@param actor     	object
---@param pos     	object
function setplayguildlevel(actor,pos) end;

---获取行会成员在行会中的职位
---* actor     	玩家对象
---@param actor     	object
function getplayguildlevel(actor) end;

---改变行会名称
---* actor     	玩家对象
---* guildName     	需要改名的行会名
---* newGuildName     	新的行会名字
---@param actor     	string
---@param guildName     	string
---@param newGuildName     	string
function changeguildname(actor,guildName,newGuildName) end;

---创建队伍
---* actor     	玩家对象
---@param actor     	object
function creategroup(actor) end;

---添加队员
---* actor     	玩家对象
---* memberId     	组员UserId
---@param actor     	object
---@param memberId     	object
function addgroupmember(actor,memberId) end;

---删除队员
---* actor     	玩家对象
---* memberId     	组员UserId
---@param actor     	object
---@param memberId     	string
function delgroupmember(actor,memberId) end;

---获取队员列表
---* actor     	玩家对象
---@param actor     	object
function getgroupmember(actor) end;

---发起行会战
---* guildName1     	宣战行会名字
---* guildName2     	敌对行会名字
---* time     	时间(分)
---@param guildName1     	string
---@param guildName2     	string
---@param time     	number
function setguildwar(guildName1,guildName2,time) end;

---判断行会之间是否宣战
---* guildName1     	行会名字/行会对象
---* guildName2     	行会名字/行会对象
---@param guildName1     	string
---@param guildName2     	string
function iswarguild(guildName1,guildName2) end;

---判断行会之间是否结盟
---* guildName1     	行会名字/行会对象
---* guildName2     	行会名字/行会对象
---@param guildName1     	string
---@param guildName2     	string
function isallyguild(guildName1,guildName2) end;

---删除Envir目录下的指定文件
---* path     	文件路径
---@param path     	string
function delfile(path) end;

---解散行会
---* guild     	行会对象
---@param guild     	object
function CloseGuild(guild) end;

---添加镜像地图
---* oldMap     	原地图ID
---* newMap     	新地图ID
---* newName     	新地图名
---* time     	有效时间(秒)最大值21亿/1000
---* backMap     	回城地图(有效时间结束后，传回去的地图)
---* miniMapId     	小地图编号
---* posMX     	返回地图的X坐标
---* posMY     	返回地图的Y坐标
---@param oldMap     	string
---@param newMap     	string
---@param newName     	string
---@param time     	number
---@param backMap     	string
---@param miniMapId     	number
---@param posMX     	number
---@param posMY     	number
function addmirrormap(oldMap,newMap,newName,time,backMap,miniMapId,posMX,posMY) end;

---删除镜像地图
---* mapId     	地图ID
---@param mapId     	string
function delmirrormap(mapId) end;

---获取/设置 镜像地图剩余时间
---* mapId     	地图ID
---* time     	设置地图有效时间
---@param mapId     	string
---@param time     	number
function mirrormaptime(mapId,time) end;

---检测镜像地图是否存在
---* mapId     	地图ID
---@param mapId     	string
function checkmirrormap(mapId) end;

---添加地图特效
---* id     	特效播放ID，用于区分多个地图特效
---* mapId     	地图ID
---* X     	坐标X
---* Y     	坐标Y
---* effId     	特效ID
---* time     	持续时间（秒）<br>0/-1不限时间
---* mode     	模式:(0~4，0所有人可见，1自己可见，2组队可见，3行会成员可见，4敌对可见)
---* actor     	玩家对象<br>模式1~4需填
---* effectModel     	特效播放模式<br>0=在人物/怪物后面<br>1=在人物/怪物前面
---@param id     	number
---@param mapId     	string
---@param X     	number
---@param Y     	number
---@param effId     	string
---@param time     	number
---@param mode     	number
---@param actor     	object
---@param effectModel     	number
function mapeffect(id,mapId,X,Y,effId,time,mode,actor,effectModel) end;

---删除地图特效
---* id     	特效播放ID
---@param id     	number
function delmapeffect(id) end;

---在地图上放置物品
---* actor     	玩家对象
---* mapId     	地图ID
---* X     	坐标X
---* Y     	坐标Y
---* range     	范围
---* itemName     	物品名
---* count     	数量
---* time     	时间（秒）
---* hint     	是否掉落提示
---* take     	是否立即拾取
---* onlySelf     	仅自己拾取
---* xyinOrder     	是-按位置顺序，<br>否-随机位置
---* overlap     	单个物品叠加数量，装备无效
---* isAuto     	true=可自动拾取<br>false=不可自动拾取<br>(onlyself=true时生效)
---@param actor     	object
---@param mapId     	string
---@param X     	number
---@param Y     	number
---@param range     	number
---@param itemName     	string
---@param count     	number
---@param time     	number
---@param hint     	 boolean
---@param take     	 boolean
---@param onlySelf     	 boolean
---@param xyinOrder     	 boolean
---@param overlap     	number
---@param isAuto     	 boolean
function throwitem(actor,mapId,X,Y,range,itemName,count,time,hint,take,onlySelf,xyinOrder,overlap,isAuto) end;

---在地图上生成掉落物品
---* mapId     	地图id
---* actor     	归属对象<br>填nil则无归属<br>且拾取cd时间会被设置为0
---* X     	x坐标
---* Y     	y坐标
---* json     	掉落json
---* data     	物品来源(参考设置物品来源)
---@param mapId     	number
---@param actor     	object
---@param X     	number
---@param Y     	number
---@param json     	string
---@param data     	table
function gendropitem(mapId,actor,X,Y,json,data) end;

---清理地图上指定名字的物品
---* mapId     	地图ID
---* X     	坐标X
---* Y     	坐标Y
---* range     	范围
---* itemName     	物品名
---@param mapId     	string
---@param X     	number
---@param Y     	number
---@param range     	number
---@param itemName     	string
function clearitemmap(mapId,X,Y,range,itemName) end;

---设定地图定时器
---* mapId     	地图ID
---* index     	计时器ID
---* second     	时长（秒）
---* func     	触发跳转的函数(多参数用逗号分割)
---@param mapId     	string
---@param index     	number
---@param second     	number
---@param func     	string
function setenvirontimer(mapId,index,second,func) end;

---关闭地图定时器
---* mapId     	地图ID
---* index     	计时器ID
---@param mapId     	string
---@param index     	number
function setenvirofftimer(mapId,index) end;

---判断地图定时器是否存在
---* mapId     	地图id
---* timerId     	计时器id
---@param mapId     	string
---@param timerId     	string
function hasenvirtimer(mapId,timerId) end;

---获取地图上指定范围内的对象
---* mapId     	地图ID
---* X     	坐标X
---* Y     	坐标Y
---* range     	范围
---* flag     	标记值，二进制位表示：<br>1-玩家，2-怪物<br>4-NPC，8-物品<br>~~16-地图事件(不可用)~~<br>32-人形怪<br>64-英雄<br>128-分身
---@param mapId     	string
---@param X     	number
---@param Y     	number
---@param range     	number
---@param flag     	number
function getobjectinmap(mapId,X,Y,range,flag) end;

---获取怪物位置及复活时间(仅支持小地图上提示的怪物)
---* mapId     	地图ID
---* model     	0=屏蔽数字<br>1=不屏蔽数字
---@param mapId     	string
---@param model     	number
function getmonrefresh(mapId,model) end;

---增加动态地图连接
---* name     	连接名称
---* mapFrom     	地图ID
---* X1     	X(小于0时随机坐标)
---* Y1     	Y(小于0时随机坐标)
---* range     	范围
---* mapTo     	到达地图号
---* X2     	到达地图X(小于0时随机坐标)
---* Y2     	到达地图Y(小于0时随机坐标)
---* time     	有效时间秒
---@param name     	object
---@param mapFrom     	string
---@param X1     	number
---@param Y1     	number
---@param range     	number
---@param mapTo     	string
---@param X2     	number
---@param Y2     	number
---@param time     	number
function addmapgate(name,mapFrom,X1,Y1,range,mapTo,X2,Y2,time) end;

---获取动态地图连接
---* name     	连接名称
---* mapFrom     	地图ID
---@param name     	string
---@param mapFrom     	string
function getmapgate(name,mapFrom) end;

---删除动态地图连接
---* name     	连接名称
---* mapId     	地图ID
---@param name     	string
---@param mapId     	string
function delmapgate(name,mapId) end;

---根据名称获取地图基础信息
---* mapId     	地图id
---* nIndex     	0：地图宽<br>1：地图高
---@param mapId     	string
---@param nIndex     	number
function getmapinfo(mapId,nIndex) end;

---判断地图坐标是否为空
---* mapid     	地图id
---* nX     	地图x坐标
---* nY     	地图y坐标
---@param mapid     	string
---@param nX     	number
---@param nY     	number
function isemptyinmap(mapid,nX,nY) end;

---获取地图指定范围内的怪物对象列表
---* mapId     	地图Id
---* monName     	怪物名，为空 or * 为检测所有怪
---* nX     	坐标X
---* nY     	坐标Y
---* nRange     	范围
---@param mapId     	string
---@param monName     	string
---@param nX     	number
---@param nY     	number
---@param nRange     	number
function getmapmon(mapId,monName,nX,nY,nRange) end;

---获取地图玩家对象列表
---* mapId     	地图ID
---* bIgnoreDied     	是否忽略死亡角色<br>1:忽略<br>0:不忽略
---* bIgnoreDummy     	是否忽略假人<br>1:忽略<br>0:不忽略
---@param mapId     	string
---@param bIgnoreDied     	number
---@param bIgnoreDummy     	number
function getplaycount(mapId,bIgnoreDied,bIgnoreDummy) end;

---获取指定地图玩家数量
---* actor     	玩家对象<br>可传入系统对象"0"
---* mapId     	地图ID
---* isAllGain     	是否全部获取<br>0=全部获取<br>1=排除已死亡的
---@param actor     	object
---@param mapId     	object
---@param isAllGain     	object
function getplaycountinmap(actor,mapId,isAllGain) end;

---获取指定地图怪物数量
---* mapId     	地图ID
---* monId     	怪物id<br>传入-1获取所有怪物
---* isAllMon     	是否忽略宝宝<br>true:忽略<br>false:不忽略
---@param mapId     	string
---@param monId     	number
---@param isAllMon     	 boolean
function getmoncount(mapId,monId,isAllMon) end;

---把某个地图中的玩家全部移动到另外一个地图
---* actor     	玩家对象
---* aMapId     	移动前地图Id
---* bMapId     	移动后地图Id
---* X     	x坐标
---* Y     	y坐标
---* range     	范围
---@param actor     	object
---@param aMapId     	string
---@param bMapId     	string
---@param X     	number
---@param Y     	number
---@param range     	number
function movemapplay(actor,aMapId,bMapId,X,Y,range) end;

---设置地图杀怪经验倍数
---* actor     	玩家对象
---* mapId     	地图id( * 号表示所有地图)
---* much     	倍率 为杀怪经验倍数，倍数除以100为真正的倍率(200 为 2 倍经验，150 为1.5倍,0表示关闭地图的杀怪经验倍数)
---@param actor     	object
---@param mapId     	string
---@param much     	number
function mapkillmonexprate(actor,mapId,much) end;

---随机杀死地图中的怪物
---* mapId     	地图Id
---* monsterName     	怪物名字
---* num     	数量(1-255)
---* isDrop     	掉落物品(0,1) 0=掉落 1=不掉落
---@param mapId     	string
---@param monsterName     	number
---@param num     	number
---@param isDrop     	number
function randomkillmon(mapId,monsterName,num,isDrop) end;

---编组地图传送
---* actor     	玩家对象
---* mapId     	地图ID
---* X     	x坐标
---* Y     	y坐标
---* level     	可以传送最低等级(可以为空，为空时不检测队员的等级直接传送)
---* value     	传送范围。（以队长为中心传送队友，0为不需要范围）
---* obj     	触发字段(可以为空)
---@param actor     	object
---@param mapId     	string
---@param X     	number
---@param Y     	number
---@param level     	number
---@param value     	number
---@param obj     	object
function groupmapmove(actor,mapId,X,Y,level,value,obj) end;

---根据地图id返回地图名
---* mapId     	地图Id
---@param mapId     	string
function getmapname(mapId) end;

---检测地图逻辑格
---* mapId     	地图Id
---* x     	x坐标
---* y     	y坐标
---* type     	逻辑格类型:<br>1.能否到达;<br>2.安全区;<br>3.攻城区;
---@param mapId     	string
---@param x     	number
---@param y     	number
---@param type     	number
function gridattr(mapId,x,y,type) end;

---获取当前地图行会成员数量
---* mapId     	地图编号
---* guildName     	行会名字或 * (等于未加入行会角色)
---@param mapId     	object
---@param guildName     	number
function maphanghcyguild(mapId,guildName) end;

---获取当前地图怪物状态
---* mapId     	地图编号
---* monName     	怪物名称，*表示所有怪物
---* model     	怪物名字格式<br>0=显示名称(不带数字)<br>1=表内名称(带数字)
---* param     	0=获取表格内刷的怪物状态<br>1=获取表格内和脚本刷的怪物状态
---@param mapId     	object
---@param monName     	string
---@param model     	number
---@param param     	number
function mapbossinfo(mapId,monName,model,param) end;

---开启/关闭地图参数
---* mapId     	地图编号
---* mapEvent     	地图参数,参考mapinfo.txt配置说明
---* model1     	不填表示关闭此地图参数，填地图参数里的需要的参数<br>不需要传参的地图事件也需要传入一个值
---* param2     	地图参数里的需要的参数
---@param mapId     	object
---@param mapEvent     	string
---@param model1     	string
---@param param2     	string
function setmapmode(mapId,mapEvent,model1,param2) end;

---增加天气
---* mapId     	地图ID
---* model     	天气效果<br>1=黄沙效果<br>2=花瓣效果<br>3=下雪效果
---* time     	有效时间(秒)
---@param mapId     	string
---@param model     	number
---@param time     	number
function setweathereffect(mapId,model,time) end;

---删除天气
---* mapId     	地图ID
---* model     	天气效果<br>0=关闭所有效果<br>1=黄沙效果<br>2=花瓣效果<br>3=下雪效果
---@param mapId     	string
---@param model     	number
function delweathereffect(mapId,model) end;

---获取当前地图随机xy坐标
---* actor     	玩家对象
---* mapid     	地图id
---@param actor     	object
---@param mapid     	string
function GetMapRandXY(actor,mapid) end;

---获取玩家沙巴克身份
---* actor     	玩家对象
---@param actor     	object
function castleidentity(actor) end;

---沙巴克基本信息
---* nID     	信息索引
---@param nID     	number
function castleinfo(nID) end;

---脚本命令设置沙巴克归属
---* guild     	行会名称
---* param     	是否忽略触发@beforgetcastle<br>0=不忽略<br>1=忽略
---@param guild     	object
---@param param     	number
function setcastleguild(guild,param) end;

---获取攻城列表
function getcastlewarlist() end;

---把行会添加到攻城列表
---* name     	行会名
---* day     	天数
---@param name     	string
---@param day     	number
function addtocastlewarlist(name,day) end;

---强制把行会添加到攻城列表
---* name     	行会名<br>传入"*"所有行会
---@param name     	string
function addtocastlewarlistex(name) end;

---所有行会在当晚同时攻城
function addattacksabukall() end;

---修复城门,城墙等
function repaircastle() end;

---雇佣沙巴克弓箭手/卫士
---* monId     	弓箭手/卫士ID
---* monType     	类型<br>0/nil=弓箭手<br>1=卫士
---@param monId     	number
---@param monType     	number
function castlearchergen(monId,monType) end;

---创建临时NPC
---* map     	地图编号
---* X     	X坐标
---* Y     	Y坐标
---* NPC     	NPC信息<br>json字符串
---@param map     	string
---@param X     	number
---@param Y     	number
---@param NPC     	string
function createnpc(map,X,Y,NPC) end;

---删除NPC
---* name     	NPC名称
---* map     	地图编号
---@param name     	string
---@param map     	string
function delnpc(name,map) end;

---根据ID获取NPC对象
---* NPCIndex     	NPC索引（NPC配置表中的ID）
---@param NPCIndex     	number
function getnpcbyindex(NPCIndex) end;

---打开指定NPC面板
---* actor     	玩家对象
---* NPCIndex     	NPC索引（NPC配置表中的ID）
---* nRange     	范围值，在此范围内允许打开
---@param actor     	object
---@param NPCIndex     	number
---@param nRange     	number
function opennpcshow(actor,NPCIndex,nRange) end;

---移动到指定NPC附近
---* actor     	玩家对象
---* NPCIndex     	NPC索引（NPC配置表中的ID）
---* nRange     	范围值，<br>不在此范围内则移动到NPC附近
---* nRange2     	范围值2，移动到NPC附近的范围内
---@param actor     	object
---@param NPCIndex     	number
---@param nRange     	number
---@param nRange2     	number
function opennpcshowex(actor,NPCIndex,nRange,nRange2) end;

---获取当前NPC对象
---* actor     	玩家对象
---@param actor     	object
function getcurrnpc(actor) end;

---设置NPC特效
---* actor     	玩家对象
---* NPCIndex     	NPC索引（NPC配置表中的ID）
---* Effect     	特效ID<br>5055-感叹号<br>5056-问号
---* X     	X坐标
---* Y     	Y坐标
---@param actor     	object
---@param NPCIndex     	number
---@param Effect     	number
---@param X     	number
---@param Y     	number
function setnpceffect(actor,NPCIndex,Effect,X,Y) end;

---删除NPC特效
---* actor     	玩家对象
---* NPCIndex     	NPC索引（NPC配置表中的ID）
---@param actor     	object
---@param NPCIndex     	number
function delnpceffect(actor,NPCIndex) end;

---关闭当前的NPC对话框
---* actor     	玩家对象
---@param actor     	object
function close(actor) end;

---给NPC注册Lua消息
---* msgId     	消息ID
---* NPCIndex     	NPC索引（NPC配置表中的ID）
---@param msgId     	number
---@param NPCIndex     	number
function regnpcmsg(msgId,NPCIndex) end;

---获取NPC对象的Idx
---* NPC     	NPC对象
---@param NPC     	object
function getnpcindex(NPC) end;

---调用其他NPC的lua函数
---* actor     	玩家对象
---* NPCIndex     	NPC索引（NPC配置表中的ID）<br>特殊:<br> npcid:QF=999999999<br>QM=999999996<br>LuaCond=999999995<br>LuaFunc=999999994
---* delayTime     	延迟时间ms,0立即执行
---* func     	函数名
---* sParam     	参数
---@param actor     	object
---@param NPCIndex     	number
---@param delayTime     	number
---@param func     	string
---@param sParam     	string
function callfunbynpc(actor,NPCIndex,delayTime,func,sParam) end;

---打开NPC大窗口
---* path     	玩家对象
---* pos     	显示位置
---* x     	X坐标
---* y     	Y坐标
---* height     	高度
---* width     	宽度
---* bool     	是否显示关闭按钮
---* closeX     	关闭按钮X坐标
---* closeY     	关闭按钮Y坐标
---* isMove     	是否可以移动(0不移动 1移动)
---@param path     	string
---@param pos     	number
---@param x     	number
---@param y     	number
---@param height     	number
---@param width     	number
---@param bool     	number
---@param closeX     	number
---@param closeY     	number
---@param isMove     	number
function openmerchantbigdlg(path,pos,x,y,height,width,bool,closeX,closeY,isMove) end;

---获取当前虚拟机id[npcid]
function getsysindex() end;

---NPC界面文本发送
---* actor     	玩家对象
---* msg     	界面文本内容
---@param actor     	object
---@param msg     	string
function say(actor,msg) end;

---增加自定义按钮
---* actor     	玩家对象
---* windowId     	主窗口ID
---* buttonId     	按钮ID
---* icon     	图标内容
---@param actor     	object
---@param windowId     	number
---@param buttonId     	number
---@param icon     	string
function addbutton(actor,windowId,buttonId,icon) end;

---删除自定义按钮
---* actor     	玩家对象
---* windowId     	主窗口ID
---* buttonId     	按钮ID
---@param actor     	object
---@param windowId     	number
---@param buttonId     	number
function delbutton(actor,windowId,buttonId) end;

---打开OK框
---* actor     	玩家对象
---* title     	OK框标题
---@param actor     	object
---@param title     	string
function openupgradedlg(actor,title) end;

---回收OK框物品
---* actor     	玩家对象
---* count     	数量(针对叠加物品有效)
---@param actor     	object
---@param count     	number
function takedlgitem(actor,count) end;

---返回OK框物品到背包
---* actor     	玩家对象
---@param actor     	object
function reclaimitem(actor) end;

---把包裹中的物品放入自定义OK框中
---* actor     	玩家对象
---* item     	物品名称<br>物品唯一id
---* index     	OK框编号(0~99)
---@param actor     	object
---@param item     	number|string
---@param index     	number
function bagitemintobox(actor,item,index) end;

---把自定义OK框物品返回到包裹
---* actor     	玩家对象
---* index     	OK框编号(0~99)
---@param actor     	object
---@param index     	number
function returnboxitem(actor,index) end;

---删除自定义OK框中的物品
---* actor     	玩家对象
---* index     	OK框编号(0~99)
---* num     	删除数量;参数只有是叠加物品时才会有效，为空则全部删除
---@param actor     	object
---@param index     	number
---@param num     	number
function delboxitem(actor,index,num) end;

---获取自定义OK框中的物品
---* actor     	玩家对象
---* index     	OK框编号(0~99)
---@param actor     	object
---@param index     	number
function getboxitem(actor,index) end;

---更新OK框物品
---* actor     	玩家对象
---* boxId     	OK框编号
---@param actor     	object
---@param boxId     	number
function updateboxitem(actor,boxId) end;

---NPC喊话
---* actor     	玩家对象：仅该玩家可见<br>-1：附近可见
---* npcid     	npcid
---* time     	显示时间(秒)
---* str     	喊话内容
---@param actor     	number|object
---@param npcid     	number
---@param time     	number
---@param str     	string
function NPCTalk(actor,npcid,time,str) end;

---添加全局定时器
---* id     	定时器ID
---* tick     	执行间隔，秒
---@param id     	number
---@param tick     	number
function setontimerex(id,tick) end;

---移除定时器
---* id     	定时器ID
---@param id     	number
function setofftimerex(id) end;

---判断全局定时器是否存在
---* timerId     	计时器id
---@param timerId     	string
function hastimerex(timerId) end;

---添加个人定时器
---* actor     	玩家对象
---* id     	定时器ID
---* runTick     	执行间隔，秒
---* runTime     	执行次数，&gt;0执行完成后，自动移除
---@param actor     	object
---@param id     	number
---@param runTick     	number
---@param runTime     	number
function setontimer(actor,id,runTick,runTime,kf) end;

---移除个人定时器
---* actor     	玩家对象
---* id     	定时器ID
---@param actor     	object
---@param id     	number
function setofftimer(actor,id) end;

---判断玩家定时器是否存在
---* actor     	玩家对象
---* timerId     	计时器id
---@param actor     	object
---@param timerId     	string
function hastimer(actor,timerId) end;

---新建任务
---* actor     	玩家对象
---* nId     	任务ID
---* param1     	参数1，用来替换任务内容里的%s
---* param2     	参数2，用来替换任务内容里的%s
---* param3     	参数3，用来替换任务内容里的%s
---* param4     	参数4，用来替换任务内容里的%s
---* param5     	参数5，用来替换任务内容里的%s
---* param6     	参数6，用来替换任务内容里的%s
---* param7     	参数7，用来替换任务内容里的%s
---* param8     	参数8，用来替换任务内容里的%s
---* param9     	参数9，用来替换任务内容里的%s
---* param10     	参数10，用来替换任务内容里的%s
---@param actor     	object
---@param nId     	number
---@param param1     	string
---@param param2     	string
---@param param3     	string
---@param param4     	string
---@param param5     	string
---@param param6     	string
---@param param7     	string
---@param param8     	string
---@param param9     	string
---@param param10     	string
function newpicktask(actor,nId,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10) end;

---刷新进行中任务状态
---* actor     	玩家对象
---* nId     	任务ID
---* param1     	参数1，用来替换任务内容里的%s
---* param2     	参数2，用来替换任务内容里的%s
---* param3     	参数3，用来替换任务内容里的%s
---* param4     	参数4，用来替换任务内容里的%s
---* param5     	参数5，用来替换任务内容里的%s
---* param6     	参数6，用来替换任务内容里的%s
---* param7     	参数7，用来替换任务内容里的%s
---* param8     	参数8，用来替换任务内容里的%s
---* param9     	参数9，用来替换任务内容里的%s
---* param10     	参数10，用来替换任务内容里的%s
---@param actor     	object
---@param nId     	number
---@param param1     	string
---@param param2     	string
---@param param3     	string
---@param param4     	string
---@param param5     	string
---@param param6     	string
---@param param7     	string
---@param param8     	string
---@param param9     	string
---@param param10     	string
function newchangetask(actor,nId,param1,param2,param3,param4,param5,param6,param7,param8,param9,param10) end;

---完成任务
---* actor     	玩家对象
---* nId     	任务ID
---@param actor     	object
---@param nId     	number
function newcompletetask(actor,nId) end;

---删除任务
---* actor     	玩家对象
---* nId     	任务ID
---@param actor     	object
---@param nId     	number
function newdeletetask(actor,nId) end;

---任务置顶显示
---* actor     	玩家对象
---* nId     	任务ID
---@param actor     	object
---@param nId     	number
function tasktopshow(actor,nId) end;

---增加系统任务计时
---* actor     	玩家对象
---* funcName     	回调函数名<br>需以dingshicf_开头
---* time     	倒计时时间(毫秒)
---* model     	0=上线需重新开启否则消失<br>1=上线直接执行
---* isClear     	0=开启新的<br>1=上线刷新当前时间
---@param actor     	object
---@param funcName     	string
---@param time     	number
---@param model     	number
---@param isClear     	number
function dsfuncall(actor,funcName,time,model,isClear) end;

---删除系统任务计时
---* actor     	玩家对象
---* funcName     	回调函数名
---@param actor     	object
---@param funcName     	string
function deldsfuncall(actor,funcName) end;

---改变系统任务计时
---* actor     	玩家对象
---* funcName     	回调函数名
---* model     	1=开启<br>0=停止
---@param actor     	object
---@param funcName     	string
---@param model     	string
function cngdsfuncallstate(actor,funcName,model) end;

---添加buff
---* base     	玩家、怪物对象
---* buffId     	buff id，10000以后
---* time     	时间,对应buff表里维护的单位
---* overLap     	叠加层数，默认1
---* objOwner     	施放者
---* abil     	属性表 {[1]=200, [4]=20}，属性id=值
---@param base     	object
---@param buffId     	number
---@param time     	number
---@param overLap     	number
---@param objOwner     	object
---@param abil     	table
function addbuff(base,buffId,time,overLap,objOwner,abil) end;

---删除buff
---* base     	玩家、怪物对象
---* buffId     	buff id
---@param base     	object
---@param buffId     	number
function delbuff(base,buffId) end;

---是否有buff
---* base     	玩家、怪物对象
---* buffId     	buff id
---@param base     	object
---@param buffId     	number
function hasbuff(base,buffId) end;

---获取buff信息
---* base     	玩家、怪物对象
---* buffId     	buff id
---* type     	1=叠加层数<br>2=剩余时间(单位跟配置一致)<br>3=获取施法者对象(对象离线返回nil)<br>4=获取额外属性
---@param base     	object
---@param buffId     	number
---@param type     	number
function getbuffinfo(base,buffId,type) end;

---获取buff模板信息
---* buffInfo     	buffID/buff名称
---* id     	0:idx<br>1:名称;<br>2.组别;<br>3.配置时间;<br>4.配置属性;
---@param buffInfo     	number|string
---@param id     	number
function getstdbuffinfo(buffInfo,id) end;

---获取角色所有buff
---* actor     	玩家对象
---@param actor     	object
function getallbuffid(actor) end;

---设置buff堆叠层数
---* actor     	玩家对象
---* buffId     	buffid
---* opt     	操作符 “+” “-“ “=”
---* stack     	buff层数 不可超出表中最大层数
---* iTimer     	是否重置buff 时间
---@param actor     	object
---@param buffId     	number
---@param opt     	string
---@param stack     	number
---@param iTimer     	 boolean
function buffstack(actor,buffId,opt,stack,iTimer) end;

---学习内功
---* actor     	玩家对象
---@param actor     	object
function readskillng(actor) end;

---获取内功等级
---* actor     	玩家对象
---@param actor     	object
function getnglevel(actor) end;

---调整人物内功等级
---* actor     	玩家对象
---* opt     	控制符(=,+,-)
---* value     	等级
---@param actor     	object
---@param opt     	string
---@param value     	number
function changenglevel(actor,opt,value) end;

---调整人物内功经验
---* actor     	玩家对象
---* opt     	控制符(=,+,-)
---* value     	经验
---@param actor     	object
---@param opt     	string
---@param value     	number
function changengexp(actor,opt,value) end;

---开启经络页签
---* actor     	玩家对象
---* pulse     	经络<br>0=冲脉<br>1=阴跷<br>2=阴维<br>3=任脉3<br>4=奇经
---* isOpen     	0=关闭<br>1=开启
---@param actor     	object
---@param pulse     	number
---@param isOpen     	number
function setpulsestate(actor,pulse,isOpen) end;

---开启经络穴位
---* actor     	玩家对象
---* pulse     	经络<br>0=冲脉<br>1=阴跷<br>2=阴维<br>3=任脉3<br>4=奇经
---* acupoint     	穴位（1~5,经络的五个穴位）
---@param actor     	object
---@param pulse     	number
---@param acupoint     	number
function openpulse(actor,pulse,acupoint) end;

---修改经络的修炼等级格式
---* actor     	玩家对象
---* pulse     	经络<br>0=冲脉<br>1=阴跷<br>2=阴维<br>3=任脉3<br>4=奇经
---* opt     	控制符(=,+,-)
---* level     	等级
---@param actor     	object
---@param pulse     	number
---@param opt     	string
---@param level     	number
function changepulselevel(actor,pulse,opt,level) end;

---学习内功/连击技能
---* actor     	玩家对象
---* skillName     	技能名称
---* skillLevel     	技能等级
---@param actor     	object
---@param skillName     	string
---@param skillLevel     	number
function addskillex(actor,skillName,skillLevel) end;

---设置杀怪内功经验倍数
---* actor     	玩家对象
---* pro     	倍率<br>倍数除以100为真正的倍率(200为2倍经验，150为1.5倍)
---* time     	有效时间(秒)
---@param actor     	object
---@param pro     	number
---@param time     	number
function killpulseexprate(actor,pro,time) end;

---设置地图杀怪内功经验倍数
---* actor     	玩家对象
---* mapId     	地图id("*"代表所有地图)
---* pro     	倍率<br>倍数除以100为真正的倍率<br>例如200为2倍经验
---@param actor     	object
---@param mapId     	number
---@param pro     	number
function plusemapkillmonexprate(actor,mapId,pro) end;

---调整人物的当前内力值
---* actor     	玩家对象
---* sFlag     	操作符(=,+,-)
---* value     	内力值
---* model     	计算方式<br>0=点数<br>1=万分比
---@param actor     	object
---@param sFlag     	string
---@param value     	number
---@param model     	number
function addinternalforce(actor,sFlag,value,model) end;

---获取英雄对象
---* actor     	玩家对象
---@param actor     	object
function gethero(actor) end;

---是否有英雄
---* actor     	玩家对象
---@param actor     	object
function hashero(actor) end;

---判断对象是否为英雄
---* object     	判断对象
---@param object     	object
function ishero(object) end;

---判断英雄是否为唤出状态
---* actor     	玩家对象
---@param actor     	object
function isherorecall(actor) end;

---设置英雄名称
---* actor     	玩家对象
---* name     	英雄名称
---@param actor     	object
---@param name     	string
function checkheroname(actor,name) end;

---创建英雄
---* actor     	玩家对象
---* name     	英雄名称
---* job     	职业(0-战 1-法 2-道)
---* sex     	性别(0-男 1-女)
---@param actor     	object
---@param name     	string
---@param job     	number
---@param sex     	number
function createhero(actor,name,job,sex) end;

---删除英雄
---* actor     	玩家对象
---@param actor     	object
function delhero(actor) end;

---召唤英雄
---* actor     	玩家对象
---@param actor     	object
function recallhero(actor) end;

---收回英雄
---* actor     	玩家对象
---@param actor     	object
function unrecallhero(actor) end;

---英雄改名接口
---* actor     	玩家对象
---* heroName     	英雄新名字
---@param actor     	object
---@param heroName     	string
function changeheroname(actor,heroName) end;

---获取英雄模式
---* actor     	玩家对象
---@param actor     	object
function getherosta(actor) end;

---设置英雄模式
---* actor     	玩家对象
---* model     	英雄模式<br>0=攻击<br>1=跟随<br>2= 休息
---@param actor     	object
---@param model     	number
function setherosta(actor,model) end;

---英雄传送到主体身边
---* actor     	玩家对象
---@param actor     	object
function herofollow(actor) end;

---召唤自身分身
---* actor     	玩家对象
---* time     	分身有效时间(秒)
---* num     	数量
---* attrPro     	继承人物属性百分比
---* color     	分身颜色<br>0-255;0不改变颜色
---* dressLook     	改变分身衣服外观(0或空为不改变)
---* weaponLook     	改变分身武器外观(0或空为不改变)
---* dressEffect     	改变分身衣服外观特效(0或空为不改变)
---* weaponEffect     	改变分身武器外观特效(0或空为不改变)
---* hpMax     	分身血量数值（填0表示按参数4的继承百分比）
---* buffId     	BUFFID<br>多个BUFF用#号连接
---@param actor     	object
---@param time     	string
---@param num     	number
---@param attrPro     	number
---@param color     	number
---@param dressLook     	number
---@param weaponLook     	number
---@param dressEffect     	number
---@param weaponEffect     	number
---@param hpMax     	number
---@param buffId     	string
function recallself(actor,time,num,attrPro,color,dressLook,weaponLook,dressEffect,weaponEffect,hpMax,buffId) end;

---获取角色所有分身
---* actor     	玩家对象
---@param actor     	object
function clonelist(actor) end;

---杀死角色所有分身
---* actor     	玩家对象
---@param actor     	object
function killcopyself(actor) end;

---跨服通知触发本服QF
---* id     	消息id（1-99）
---* userId     	玩家userid
---* paramA     	传递的字符串1(字符串)
---* paramB     	传递的字符串2(字符串)
---@param id     	number
---@param userId     	string
---@param paramA     	string
---@param paramB     	string
function kfbackcall(id,userId,paramA,paramB) end;

---本服通知触发跨服QF
---* id     	消息id（1-99）
---* userId     	玩家userid
---* paramA     	传递的字符串1(字符串)
---* paramB     	传递的字符串2(字符串)
---@param id     	number
---@param userId     	string
---@param paramA     	string
---@param paramB     	string
function bfbackcall(id,userId,paramA,paramB) end;

---检测当前服务器是否为跨服服务器
function iskuafuserver() end;

---检查跨服连接是否正常连接
function kuafuconnected() end;

---检测当前人物是否在跨服的地图
function checkkuafu(actor) end;

---所有跨服玩家回本服 根据执行区服自行处理
---* mapid     	地图id
---* x     	坐标X
---* y     	坐标Y
---* range     	范围
---@param mapid     	string
---@param x     	number
---@param y     	string
---@param range     	number
function kuafuusergohome(mapid,x,y,range) end;

---同步行会信息到跨服
function SynGuildToKuafu() end;

---创建宠物
---* actor     	玩家对象
---* monName     	自定义怪物名称
---* level     	怪物等级
---@param actor     	object
---@param monName     	string
---@param level     	number
function createpet(actor,monName,level) end;

---召唤宠物
---* actor     	玩家对象
---* index     	宠物序号
---@param actor     	object
---@param index     	number
function recallpet(actor,index) end;

---获取宠物
---* actor     	玩家对象
---* index     	宠物序号或’X’表示当前宠物
---@param actor     	object
---@param index     	number
function getpet(actor,index) end;

---收回宠物
---* actor     	玩家对象
---* index     	宠物序号
---@param actor     	object
---@param index     	number
function unrecallpet(actor,index) end;

---删除宠物
---* actor     	玩家对象
---* index     	宠物序号
---@param actor     	object
---@param index     	number
function delpet(actor,index) end;

---宠物穿装备
---* actor     	玩家对象
---* index     	宠物序号
---* item     	装备名称，多个装备用#分隔
---@param actor     	object
---@param index     	number
---@param item     	string
function pettakeon(actor,index,item) end;

---宠物脱装备
---* actor     	玩家对象
---* index     	宠物序号
---* item     	装备名称，多个装备用#分隔，-1表示脱下全部装备
---@param actor     	object
---@param index     	number
---@param item     	string
function pettakeoff(actor,index,item) end;

---获取宠物数量
---* actor     	玩家对象
---@param actor     	object
function getpetcount(actor) end;

---获取宠物身上装备列表
---* actor     	玩家对象
---* index     	宠物序号
---@param actor     	object
---@param index     	number
function getpetbodyitem(actor,index) end;

---设置宠物模式
---* actor     	玩家对象
---* mode     	宠物模式:<br>1-跟随;<br>2-攻击;<br>3-被动(被攻击时才设定目标);<br>4-休息
---@param actor     	object
---@param mode     	number
function setpetmode(actor,mode) end;

---获取宠物状态
---* actor     	玩家对象
---* index     	宠物序号
---@param actor     	object
---@param index     	number
function petstate(actor,index) end;

---增加宠物属性
---* actor     	玩家对象
---* index     	宠物序号
---* attrName     	自定义属性组名
---* opt     	操作符 + - =
---* attr     	属性字符串
---@param actor     	object
---@param index     	number
---@param attrName     	string
---@param opt     	string
---@param attr     	string
function addpetattlist(actor,index,attrName,opt,attr) end;

---清除宠物属性
---* actor     	玩家对象
---* index     	宠物序号
---* attrName     	装备清空对应属性组的属性;<br>nil清除所有属性组对象
---@param actor     	object
---@param index     	number
---@param attrName     	number
function delpetattlist(actor,index,attrName) end;

---置换宠物属性
---* actor     	玩家对象
---* index     	宠物序号
---* monIndex     	怪物IDX
---@param actor     	object
---@param index     	number
---@param monIndex     	number
function petmon(actor,index,monIndex) end;

---改变宠物外观
---* actor     	玩家对象
---* petIndex     	宠物序号,X表示当前宠物
---* appr     	怪物外观ID(怪物Appr)<br>0=还原
---@param actor     	object
---@param petIndex     	number|string
---@param appr     	number
function setpetappr(actor,petIndex,appr) end;

---增加宠物攻击表现
---* actor     	玩家对象
---* index     	宠物序号或’X’表示当前宠物
---* skillId     	增加的攻击表现ID，为cfg_monattack表中的ID
---@param actor     	object
---@param index     	number
---@param skillId     	number
function addpetskill(actor,index,skillId) end;

---获取宠物蛋信息
---* actor     	玩家对象
---* itemMakeIndex     	物品MakeIndex
---* type     	需要返回的数值<br>1-转生等级;<br>2-等级;<br>3-经验;<br>0-同时返回三个值
---@param actor     	object
---@param itemMakeIndex     	number
---@param type     	number
function getpetegglevel(actor,itemMakeIndex,type) end;

---设置宠物蛋等级
---* actor     	玩家对象
---* itemMakeIndex     	物品MakeIndex
---* level     	等级，-1表示不修改值
---* zLevel     	转生等级，-1表示不修改值
---* exp     	经验值，-1表示不修改值
---@param actor     	object
---@param itemMakeIndex     	object
---@param level     	object
---@param zLevel     	object
---@param exp     	object
function setpetegglevel(actor,itemMakeIndex,level,zLevel,exp) end;

---返回复活的宠物对象
---* actor     	玩家对象
---* index     	宠物序号
---* nHp     	复活后的HP量
---* type     	0-绝对值，1-百分比
---@param actor     	object
---@param index     	number
---@param nHp     	number
---@param type     	number
function realivepet(actor,index,nHp,type) end;

---收回宠物为物品
---* actor     	玩家对象
---* index     	宠物序号
---@param actor     	object
---@param index     	number
function retractpettoitem(actor,index) end;

---清除宠物所有技能
---* actor     	玩家对象
---* index     	宠物序号
---@param actor     	object
---@param index     	number
function ClearPetSkill(actor,index) end;

---创建国家
---* nIndex     	国家ID (1~100)
---* name     	国家名称
---* maxNum     	限制人数
---@param nIndex     	number
---@param name     	string
---@param maxNum     	number
function createnation(nIndex,name,maxNum) end;

---删除国家
---* nId     	国家ID
---@param nId     	number
function delnation(nId) end;

---设置当前人物在国家的职位
---* actor     	玩家对象
---* jobIndex     	职位编号
---@param actor     	object
---@param jobIndex     	number
function SetPlayNationRank(actor,jobIndex) end;

---修改国家职位名称
---* nIndex     	国家ID (1~100)
---* jobIndex     	职位编号
---* jobName     	职位名称
---@param nIndex     	number
---@param jobIndex     	number
---@param jobName     	string
function SetNationRank(nIndex,jobIndex,jobName) end;

---加入/退出国家
---* actor     	玩家对象
---* nIndex     	国家ID (1~100),填0退出国家
---* JobIndex     	职位编号（0-9 不填 默认为0）
---@param actor     	object
---@param nIndex     	number
---@param JobIndex     	number
function JoinNation(actor,nIndex,JobIndex) end;

---判断国家是否存在
---* nIdx     	国家id
---@param nIdx     	number
function HasNation(nIdx) end;

---获取角色国家ID
---* actor     	玩家对象
---@param actor     	object
function GetPlayNation(actor) end;

---获取角色在国家的职位
---* actor     	玩家对象
---@param actor     	object
function GetPlayNationRank(actor) end;

---获取国家职位名称
---* nIndex     	国家ID (1~100)
---* jobIndex     	职位编号
---@param nIndex     	number
---@param jobIndex     	number
function GetNationRank(nIndex,jobIndex) end;

---添加计划任务
---* id     	任务计划id，不可重复
---* name     	任务计划名称
---* itype     	0:指定时间<br>1:每天执行<br>2:每周执行<br>3:每月执行
---* strtime     	时间表 详细见示例<br>多时间#拼接
---* strfun     	回调函数
---* param     	自定义参数，多参数#拼接
---@param id     	number
---@param name     	string
---@param itype     	number
---@param strtime     	string
---@param strfun     	string
---@param param     	string
function AddScheduled(id,name,itype,strtime,strfun,param) end;

---删除计划任务
---* scheduledID     	计划任务id
---@param scheduledID     	number
function DelScheduled(scheduledID) end;

---判断计划任务是否存在
---* scheduledID     	计划任务id
---@param scheduledID     	string
function HasScheduled(scheduledID) end;

---建立关系
---* actor     	玩家对象
---* role     	接收者对象
---* netid     	关系id
---@param actor     	object
---@param role     	object
---@param netid     	number
function SetPlayNet(actor,role,netid) end;

---解散关系
---* netIndex     	关系唯一id
---@param netIndex     	string
function DisPlayNet(netIndex) end;

---获取关系成员
---* actor     	玩家对象
---* netid     	关系序号
---* online     	 0：全部成员 1：在线成员
---@param actor     	object
---@param netid     	number
---@param online     	number
function GetNetMem(actor,netid,online) end;

---获取关系成员允许召唤状态
---* actor     	玩家对象
---* netid     	关系id
---@param actor     	object
---@param netid     	number
function GetNetCallState(actor,netid) end;

---设置关系成员允许召唤状态
---* actor     	玩家对象
---* netid     	关系id
---* isSet     	是否允许召唤
---@param actor     	object
---@param netid     	number
---@param isSet     	 boolean
function SetNetCallState(actor,netid,isSet) end;

---获取人物关系ID
---* actor     	玩家对象
---* role     	接受者对象
---@param actor     	object
---@param role     	object
function GetPlayNet(actor,role) end;

---将玩家踢出关系
---* netIndex     	关系唯一id
---* userid     	玩家唯一id
---@param netIndex     	string
---@param userid     	string
function DelPlayNet(netIndex,userid) end;

---设置关系的等级
---* actor     	玩家对象
---* netIndex     	关系唯一id
---* level     	等级 0/1
---@param actor     	object
---@param netIndex     	string
---@param level     	number
function SetNetRank(actor,netIndex,level) end;

---获取关系的等级
---* actor     	玩家对象
---* netIndex     	关系唯一id
---@param actor     	object
---@param netIndex     	string
function GetNetRank(actor,netIndex) end;

---设置阵营ID
---* actor     	玩家/怪物 对象
---* campid     	阵营id
---@param actor     	object
---@param campid     	number
function setcamp(actor,campid) end;

---获取阵营ID
---* actor     	玩家/怪物 对象
---@param actor     	object
function getcamp(actor) end;

---获取服务器假人数量
function GetDummyPlayCount() end;

---获取地图假人数量
---* mapId     	地图id
---@param mapId     	string
function GetMapDummyPlayCount(mapId) end;

---检测是否是假人
---* actor     	假人对象
---@param actor     	object
function IsDummy(actor) end;

---假人自动寻路到当前地图坐标
---* actor     	假人对象
---* x     	地图坐标
---* y     	地图坐标
---@param actor     	object
---@param x     	number
---@param y     	number
function dummygoto(actor,x,y) end;

---假人是否锁定目标攻击
---* actor     	假人对象
---* type     	0=随机搜索，1=锁定
---@param actor     	object
---@param type     	number
function dummylocktarget(actor,type) end;

---踢出所有假人
function kickdummy() end;

---假人停止行动
---* actor     	假人对象
---@param actor     	object
function dummystop(actor) end;

---假人开始行动
---* actor     	假人对象
---@param actor     	object
function dummystart(actor) end;

---假人登录
---* actor     	玩家对象
---* mapId     	地图id
---* x     	地图坐标x
---* y     	地图坐标y
---* range     	范围
---* job     	职业(0=战士 1=法师 2=道士 3=随机)
---* num     	数量
---* interval     	间隔
---* mode     	登录模式(0=顺序 1=倒顺 2=随机)
---* sexy     	性别(0=男 1=女)
---@param actor     	object
---@param mapId     	string
---@param x     	number
---@param y     	number
---@param range     	number
---@param job     	number
---@param num     	number
---@param interval     	number
---@param mode     	number
---@param sexy     	number
function dummylogon(actor,mapId,x,y,range,job,num,interval,mode,sexy) end;

---通区写入内容
---* idx     	<font size=1> 0=系统;1=角色ID;2=账号ID
---* num     	触发编号例:</br>参数一=0时触发@G_TongReadKeyxxx,</br>参数一=1或2时触发TongReadKeyToUserxxx</br>注:必须为文本型数字
---* obj     	参数一=0本参数填0</br>参数一=1本参数填<$USERID></br>参数一=2本参数填<$USERACCOUNT>
---* key     	50字节(最大50个key)
---* value     	上限8000字节
---@param idx     	number
---@param num     	string
---@param obj     	string
---@param key     	string
---@param value     	string
function TongWriteKey(idx,num,obj,key,value) end;

---通区读取内容
---* type     	0=系统</br>1=角色</br>2=账号
---* num     	触发编号</br>(注:当参数一=2时,该区有几个角色在线都会同时触发) 
---* obj     	?参数一=0=系统</br>参数一=1=角色ID</br>参数一=2=账号ID
---* key     	50字节(最大50个key)
---@param type     	number
---@param num     	number
---@param obj     	string
---@param key     	string
function TongReadKey(type,num,obj,key) end;

---通区上传文件
---* num     	触发编号
---* file     	默认QD下</br>例:通区测试\996m2.txt</br>(文本大小上限1M)
---* name     	文件名</br>例:996m2.txt
---@param num     	number
---@param file     	string
---@param name     	string
function TongUpLoad(num,file,name) end;

---通区下载文件
---* num     	触发编号
---* name     	文件名</br>例:996m2.txt
---* path     	存储文件到本地路径,默认QD下</br>例:通区测试\996m2.txt
---@param num     	number
---@param name     	string
---@param path     	string
function TONGDOWNLOAD(num,name,path) end;

---批量操作
---* operate     	0=赋值<br>1=删除 
---* value     	参数1=0时有效
---@param operate     	number
---@param value     	string
function TongClearKey(operate,value) end;

---获取所有Key
function TongGetKeyList() end;

---监听消息
---* actor     	玩家对象
---* msgId     	消息ID
---* param1     	参数1
---* param2     	参数2
---* param3     	参数3
---* sMsg     	消息体
---@param actor     	object
---@param msgId     	number
---@param param1     	number
---@param param2     	number
---@param param3     	number
---@param sMsg     	string
function handlerequest(actor,msgId,param1,param2,param3,sMsg) end;

---服务端启动触发
function startup() end;

---聊天内容聊天触发
---* self     	玩家对象
---* sMsg     	说话内容
---* chat     	<br>聊天频道<br>1:系统<br>2:喊话<br>3:私聊<br>4:行会<br>5:组队<br>6:附近<br>7:世界<br>8:国家<br>9:联盟<br>40:行会通知
---* msgType     	<br>消息类型<br>0:普通消息<br>1:坐标<br>2:装备
---@param self     	object
---@param sMsg     	string
---@param chat     	number
---@param msgType     	string
function triggerchat(self, sMsg, chat,msgType) end;

---小退触发
---* actor     	玩家对象
---@param actor     	object
function playreconnection(actor) end;

---大退与关闭客户端触发
---* actor     	玩家对象
---@param actor     	object
function playoffline(actor) end;

---攻城开始时触发
function castlewarstart() end;

---攻城结束时触发
function castlewarend() end;

---占领沙巴克触发
function getcastle0() end;

---公众号获取KEY成功触发
---* actor     	玩家对象
---* key     	公众号key
---@param actor     	object
---@param key     	string
function bindwechat(actor,key) end;

---公众号成功验证触发
---* actor     	玩家对象
---* key     	输入的微信key
---* name     	微信名称
---* id     	微信id
---@param actor     	object
---@param key     	string
---@param name     	string
---@param id     	string
function bindrewechat(actor,key,name,id) end;

---收到请求离线玩家变量时
---* SysID     	系统id，忽略即可
---* UserID     	玩家唯一id
---* UserName     	玩家名称
---* varName     	变量名
---* varValue     	变量值
---@param SysID     	object
---@param UserID     	string
---@param UserName     	string
---@param varName     	string
---@param varValue     	integer|string
function on_offline_var(SysID,UserID,UserName,varName,varValue) end;

---QFunction-0重载前触发
function qfloadbegin() end;

---QFunction-0重载后触发
function qfloadend() end;

---玩家登录触发
---* actor     	actor
---@param actor     	object
function login(actor) end;

---收到私聊信息触发
---* actor     	玩家对象
---* sMsg     	说话内容
---* chat     	聊天频道
---@param actor     	object
---@param sMsg     	string
---@param chat     	number
function privatechat(actor,sMsg,chat) end;

---角色穿戴装备前触发
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---* where     	装备位置
---@param actor     	object
---@param makeIndex     	number
---@param where     	number
function takeonbeforeex(actor,makeIndex,where ) end;

---角色脱下装备前触发
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---* where     	装备位置
---@param actor     	object
---@param makeIndex     	number
---@param where     	number
function takeoffbeforeex(actor,makeIndex,where) end;

---角色穿戴X装备前触发
---* actor     	玩家对象
---* makeIndex     	物品唯一Id
---@param actor     	object
---@param makeIndex     	number
function takeonbeforeX(actor,makeIndex) end;

---角色脱下X装备前触发
---* actor     	玩家对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param makeIndex     	object
function takeoffbeforeX(actor,makeIndex) end;

---角色穿戴装备后触发
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---* where     	装备位置
---* itemName     	物品名
---@param actor     	object
---@param makeIndex     	number
---@param where     	number
---@param itemName     	string
function takeonex(actor,makeIndex,where,itemName ) end;

---角色脱下装备后触发
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---* where     	装备位置
---* itemName     	物品名
---@param actor     	object
---@param makeIndex     	number
---@param where     	number
---@param itemName     	string
function takeoffex(actor,makeIndex,where,itemName) end;

---角色穿戴X装备后触发
---* actor     	玩家对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param makeIndex     	number
function takeonX(actor,makeIndex) end;

---角色脱下X装备后触发
---* actor     	玩家对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param makeIndex     	number
function takeoffX(actor,makeIndex) end;

---人物死亡装备掉落前触发
---* actor     	玩家对象
---* where     	装备位
---* itemIndex     	装备Index
---@param actor     	object
---@param where     	number
---@param itemIndex     	number
function checkdropuseitems(actor,where,itemIndex) end;

---参照装备投保已投保装备掉落触发
---* actor     	玩家对象
---* makeIndex     	唯一Id
---@param actor     	object
---@param makeIndex     	object
function dropuseitemsX(actor,makeIndex) end;

---角色装备过期触发
---* actor     	玩家对象
---* makeIndex     	唯一Id<br>过期为称号时该参数为0
---* itemName     	物品名字
---* itemid     	物品ID
---@param actor     	object
---@param makeIndex     	object
---@param itemName     	string
---@param itemid     	string
function itemexpired(actor,makeIndex,itemName,itemid) end;

---角色脱下装备进入背包前触发
---* actor     	玩家对象
---* makeIndex     	装备唯一ID
---* where     	装位置
---@param actor     	object
---@param makeIndex     	number
---@param where     	number
function takeoffexchange(actor,makeIndex,where) end;

---装备持久消失触发
---* actor     	玩家对象
---* makeIndex     	唯一Id
---@param actor     	object
---@param makeIndex     	object
function itemdamageX(actor,makeIndex) end;

---武器加诅咒前触发
---* actor     	玩家对象
---* makeIndex     	唯一Id
---@param actor     	object
---@param makeIndex     	object
function makeweaponunluck(actor,makeIndex) end;

---双击类道具触发
---* actor     	玩家对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param makeIndex     	string
function stdmodefuncX(actor,makeIndex) end;

---双击使用道具前触发
---* actor     	玩家对象
---* itemMakeIndex     	道具唯一id
---* itemIndex     	道具index
---* itemNum     	道具数量
---* stdMode     	物品表stdMode参数
---@param actor     	object
---@param itemMakeIndex     	number
---@param itemIndex     	number
---@param itemNum     	number
---@param stdMode     	number
function beforeeatitem(actor,itemMakeIndex,itemIndex,itemNum,stdMode) end;

---货币改变触发
---* actor     	玩家对象
---@param actor     	object
function moneychangeX(actor) end;

---物品进包前触发
---* actor     	玩家对象
---* itemMakeIndex     	物品唯一index
---* itemIndex     	物品index
---@param actor     	object
---@param itemMakeIndex     	number
---@param itemIndex     	number
function addbagbefore(actor,itemMakeIndex,itemIndex) end;

---物品进包触发
---* actor     	玩家对象
---* makeIndex     	物品唯一ID
---* index     	物品ID
---@param actor     	object
---@param makeIndex     	string
---@param index     	string
function addbag(actor,makeIndex,index) end;

---角色扔掉任意物品前触发
---* actor     	玩家对象
---* makeIndex     	物品唯一ID
---* itemName     	掉落物品名
---* model     	行为id<br>0=扔掉触发<br>1=人物掉落触发
---@param actor     	object
---@param makeIndex     	string
---@param itemName     	string
---@param model     	number
function dropitemfrontex(actor,makeIndex,itemName,model) end;

---扔掉任意物品后触发
---* actor	玩家对象
---* makeIndex	物品唯一ID
---* itemName	物品名称
---@param actor	object
---@param makeIndex	string
---@param itemName	string
function dropitemex(actor,makeIndex,itemName) end;

---暴击触发
---* actor     	玩家对象
---* attack     	受击对象
---* damage     	暴击后伤害值
---* magicId     	技能id
---@param actor     	object
---@param attack     	object
---@param damage     	number
---@param magicId     	number
function crittrigger(actor,attack,damage,magicId) end;

---伤害反弹触发
---* actor     	玩家对象
---* hitter     	伤害来源对象
---* damage     	伤害值
---* magicId     	技能id
---@param actor     	object
---@param hitter     	object
---@param damage     	number
---@param magicId     	number
function reboundhurt(actor,hitter,damage,magicId) end;

---人物攻击前触发
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---* damage     	伤害
---* model     	<br>当前攻击模式<br>0=正常<br>1=暴击<br>2=格挡<br>3=切割
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
---@param damage     	number
---@param model     	number
function attackdamage(actor,target,hitter,magicId,damage,model) end;

---玩家物理攻击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function attack(actor,target,hitter,magicId) end;

---玩家魔法攻击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function magicattack(actor,target,hitter,magicId) end;

---玩家受击前
---* actor     	玩家对象
---* hitter     	攻击对象
---* target     	受击对象
---* magicId     	技能id
---* damage     	伤害
---@param actor     	object
---@param hitter     	object
---@param target     	object
---@param magicId     	number
---@param damage     	number
function struckdamage(actor,hitter,target,magicId,damage) end;

---玩家物理受击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function struck(actor,target,hitter,magicId) end;

---玩家魔法受击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function magicstruck(actor,target,hitter,magicId) end;

---自身使用技能触发
---* actor     	玩家对象
---@param actor     	object
function magselffuncX(actor) end;

---对目标人物使用技能时自身触发
---* actor     	玩家对象
---* roleObject     	受击玩家对象
---@param actor     	object
---@param roleObject     	object
function magtagfuncX(actor,roleObject) end;

---对目标怪物使用技能时自身触发
---* actor     	玩家对象
---* monObject     	受击玩家对象
---@param actor     	object
---@param monObject     	object
function magmonfuncX(actor,monObject) end;

---玩家自身使用任意技能前触发
---* actor     	玩家对象
---* magicId     	技能id
---* magicName     	技能名字
---* target     	受击对象
---* x     	受击对象x坐标
---* y     	受击对象y坐标
---@param actor     	object
---@param magicId     	number
---@param magicName     	string
---@param target     	object
---@param x     	number
---@param y     	number
function beginmagic(actor,magicId,magicName,target,x,y) end;

---玩家推动技能施法前触发
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function canpush(actor,target,hitter,magicId) end;

---自定义技能处理伤害前触发
---* hitter     	施法对象
---* target     	受击对象
---@param hitter     	object
---@param target     	object
function custommagicdamageX(hitter,target) end;

---玩家死亡触发
---* actor     	凶手或凶手主人
---* killed     	被杀玩家(死者)
---@param actor     	object
---@param killed     	object
function killplay(actor,killed) end;

---玩家被杀
---* actor     	被杀玩家
---* hitter     	攻击者
---@param actor     	object
---@param hitter     	object
function playdie(actor,hitter) end;

---杀死怪物或人物，爆物品触发
---* actor     	玩家对象
---* dropRole     	掉落者对象
---@param actor     	object
---@param dropRole     	object
function scatterbagitems(actor,dropRole) end;

---充值触发
---* actor     	玩家对象
---* gold     	充值金额
---* productId     	产品ID（保留,苹果商城用）
---* moneyId     	货币ID
---* isReal     	=1真实充值<br>=0扶持充值
---* orderTime     	订单时间(时间戳)
---* rechargeAmount     	实际到账货币金额
---* giftAmount     	额外赠送金额<br>运营后台配置
---* refundAmount     	开启积分金额<br>运营后台配置
---@param actor     	object
---@param gold     	number
---@param productId     	number
---@param moneyId     	number
---@param isReal     	number
---@param orderTime     	number
---@param rechargeAmount     	number
---@param giftAmount     	number
---@param refundAmount     	number
function recharge(actor,gold,productId,moneyId,isReal,orderTime,rechargeAmount,giftAmount,refundAmount) end;

---NPC点击触发
---* actor     	玩家对象
---* npcId     	NPC索引<br>NPC配置表中的ID
---@param actor     	object
---@param npcId     	object
function clicknpc(actor,npcId) end;

---玩家跳转地图触发
---* actor     	玩家对象
---* mapId     	进入的地图id
---* x     	进入地图x
---* y     	进入地图y
---* mapId2    	离开的地图id
---@param actor     	object
---@param mapId     	string
---@param x     	number
---@param y     	number
---@param mapId2    	string
function entermap(actor,mapId,x,y,mapId2) end;

---玩家离开地图触发
---* actor     	玩家对象
---* mapId     	离开地图id
---* x     	离开地图x
---* y     	离开地图y
---* mapId2     	进入的地图id
---@param actor     	object
---@param mapId     	string
---@param x     	number
---@param y     	number
---@param mapId2     	string
function leavemap(actor,mapId,x,y,mapId2) end;

---镜像地图销毁前触发
---* sysobj     	系统对象
---* mapId     	地图id
---@param sysobj     	object
---@param mapId     	string
function mirrormapend(sysobj,mapId) end;

---进入连接点(跳转点)前触发
---* actor     	玩家对象
---* mapid     	地图id
---* x     	地图x坐标
---* y     	地图y坐标
---@param actor     	object
---@param mapid     	string
---@param x     	number
---@param y     	number
function beforeroute(actor,mapid,x,y) end;

---捡取触发
---* actor     	玩家对象
---* itemMakeIndex     	物品唯一id
---* itemIndex     	物品id
---@param actor     	object
---@param itemMakeIndex     	number
---@param itemIndex     	number
function pickupitemex(actor,itemMakeIndex,itemIndex) end;

---奔跑触发
---* actor     	玩家对象
---@param actor     	object
function run(actor) end;

---走路触发
---* actor     	玩家对象
---@param actor     	object
function walk(actor) end;

---开始挂机触发
---* actor     	玩家对象
---@param actor     	object
function startautoplaygame(actor) end;

---停止挂机触发
---* actor     	玩家对象
---@param actor     	object
function stopautoplaygame(actor) end;

---属性变化时触发
---* actor     	玩家对象
---@param actor     	object
function sendability(actor) end;

---角色获取经验前触发
---* actor     	玩家对象
---* exp     	获取经验值
---@param actor     	object
---@param exp     	number
function getexp(actor,exp) end;

---拾取前触发
---* actor     	玩家对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param makeIndex     	number
function pickupitemfrontex(actor,makeIndex) end;

---点击背包锁头触发
---* actor     	玩家对象
---@param actor     	object
function closedbagitemclick(actor) end;

---套装激活触发
---* actor     	玩家对象
---* suitIndex     	套装id
---@param actor     	object
---@param suitIndex     	object
function groupitemonX(actor,suitIndex) end;

---穿套装触发
---* actor     	玩家对象
---* suiId     	套装id
---@param actor     	object
---@param suiId     	number
function groupitemonex(actor,suiId) end;

---脱套装触发
---* actor     	玩家对象
---* suiId     	套装id
---@param actor     	object
---@param suiId     	number
function groupitemoffex(actor,suiId) end;

---交易前触发
---* acceptActor     	接收交易请求对象
---* launchActor     	发起交易请求对象
---@param acceptActor     	object
---@param launchActor     	object
function dealbefore(acceptActor,launchActor) end;

---交易后触发
---* actor     	交易对象A
---* buyer     	交易对象B
---* itemjson    	交易物品json
---@param actor     	object
---@param buyer     	object
---@param itemjson    	string
function dealend(actor,buyer,itemjson) end;

---摆摊触发
---* actor     	玩家对象
---@param actor     	object
function startmyshop(actor) end;

---摆摊成功触发
---* actor     	玩家对象
---@param actor     	object
function startmyshopok(actor) end;

---商城购买后触发
---* actor     	玩家对象
---* MakeIndex     	物品唯一ID
---* itemName     	物品名称
---* itemNum     	物品数量
---* moneyId     	货币id
---* moneyNum     	货币数量
---@param actor     	object
---@param MakeIndex     	string
---@param itemName     	string
---@param itemNum     	number
---@param moneyId     	number
---@param moneyNum     	number
function buyshopitem(actor,MakeIndex,itemName,itemNum,moneyId,moneyNum) end;

---人物勾选外显时装生效触发
---* actor     	玩家对象
---@param actor     	object
function showfashion(actor) end;

---人物取消外显时装生效触发
---* actor     	玩家对象
---@param actor     	object
function notshowfashion(actor) end;

---加好友前触发
---* actor     	玩家对象
---@param actor     	object
function addfriendrequest(actor) end;

---角色pk值变化触发
---* actor     	玩家对象
---* pkpoint     	pk值
---@param actor     	object
---@param pkpoint     	number
function pkpointchanged(actor,pkpoint) end;

---人物死亡之前
---* actor     	玩家对象
---* hitter     	击杀者对象
---* isplayer     	0=击杀者非玩家<br>1=击杀者是玩家
---@param actor     	object
---@param hitter     	object
---@param isplayer     	number
function nextdie(actor,hitter,isplayer) end;

---查看别人装备触发
---* actor     	玩家对象
---* name     	被查看的玩家名
---@param actor     	object
---@param name     	string
function lookhuminfo(actor,name) end;

---阅读邮件触发
---* actor     	玩家对象
---* mailID     	邮件id
---* mailTitle     	邮件标题
---@param actor     	object
---@param mailID     	number
---@param mailTitle     	string
function readmail(actor,mailID,mailTitle) end;

---邮件提取触发
---* actor     	玩家对象
---* mainID     	邮件id
---* mailTitle     	邮件标题
---* itemJson     	提取物品的json
---@param actor     	object
---@param mainID     	number
---@param mailTitle     	string
---@param itemJson     	string
function getmailitem(actor,mainID,mailTitle,itemJson) end;

---传送戒指传送前触发
---* actor     	玩家对象
---* X     	X坐标
---* Y     	Y坐标
---@param actor     	object
---@param X     	number
---@param Y     	number
function beginteleport(actor,X,Y) end;

---绑定背包满触发
---* actor     	玩家对象
---* bindingType     	绑定类型(1：背包满通知)
---* isOpen     	是否开启(0：关闭，1：开启)
---* callbackFunc     	回调函数(QF)
---@param actor     	object
---@param bindingType     	object
---@param isOpen     	number
---@param callbackFunc     	string
function bindevent(actor,bindingType,isOpen,callbackFunc) end;

---回收触发
---* actor     	玩家对象
---@param actor     	object
function recycling(actor) end;

---寻路开启触发
---* actor     	玩家对象
---@param actor     	object
function findpathbegin(actor) end;

---寻路中断触发
---* actor     	玩家对象
---@param actor     	object
function findpathstop(actor) end;

---寻路结束触发
---* actor     	玩家对象
---@param actor     	object
function findpathend(actor) end;

---玩家捡取物品前触发(X=物品idx)
---* actor     	玩家对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param makeIndex     	number
function pickupitemfrontX(actor,makeIndex) end;

---装备从背包掉落前触发
---* actor     	actor
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param makeIndex     	string
function itemdropfrombagbefore(actor,makeIndex) end;

---称号改变触发
---* actor     	玩家对象
---* titleIndex     	称号索引
---@param actor     	object
---@param titleIndex     	number
function titlechangedex(actor,titleIndex) end;

---称号卸下触发
---* actor     	玩家对象
---* titleIndex     	称号索引
---@param actor     	object
---@param titleIndex     	number
function untitledex(actor,titleIndex) end;

---人物复活时
---* actor     	玩家对象
---@param actor     	object
function revival(actor) end;

---人物改变称号X时触发
---* actor     	玩家对象
---@param actor     	object
function titlechanged_X(actor) end;

---人物卸下称号X时触发
---* actor     	玩家对象
---@param actor     	object
function titlechanged_X(actor) end;

---摆摊出售物品触发
---* actor 	摊主
---* buyer 	买主
---* makeid	售出物品唯一id
---* ItemId	售出物品id
---* moneyid	货币id
---* moneynum	货币数量
---@param actor 	object 
---@param buyer 	object
---@param makeid	number
---@param ItemId	number
---@param moneyid	number
---@param moneynum	number
function on_stall_item(actor,buyer,makeid,ItemId,moneyid,moneynum) end;

---杀怪获取经验触发
---* actor     	玩家对象
---* killer     	击杀者对象
---* mon     	怪物对象
---* exp     	经验数
---@param actor     	object
---@param killer     	object
---@param mon     	object
---@param exp     	number
function getexpbykillmon(actor,killer,mon,exp) end;

---双击道具触发
---* actor     	玩家对象
---* aniCount     	负重值(外观)
---* makeIndex     	物品唯一ID
---* wIndex     	物品id
---* nOverLap     	数量
---@param actor     	object
---@param aniCount     	number
---@param makeIndex     	string
---@param wIndex     	string
---@param nOverLap     	number
function stdmodefunc(actor,aniCount,makeIndex,wIndex,nOverLap) end;

---玩家登录触发
---* actor     	actor
---@param actor     	object
function resetday(actor) end;

---英雄穿戴装备触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	装备唯一ID
---* where     	装备位置
---* itemName     	物品名
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
---@param where     	number
---@param itemName     	string
function herotakeonex(actor,hero,makeIndex,where,itemName) end;

---英雄脱下装备触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	装备唯一ID
---* where     	装备位置
---* itemName     	物品名
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
---@param where     	number
---@param itemName     	string
function herotakeoffex(actor,hero,makeIndex,where,itemName) end;

---英雄装备过期触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	唯一Id
---* itemName     	物品名字
---@param actor     	object
---@param hero     	object
---@param makeIndex     	object
---@param itemName     	string
function heroitemexpired(actor,hero,makeIndex,itemName) end;

---英雄脱下装备进入背包前触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
function herotakeoffexchange(actor,hero,makeIndex) end;

---添加英雄背包触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	物品唯一Id
---@param actor     	object
---@param hero     	object
---@param makeIndex     	string
function addherobag(actor,hero,makeIndex) end;

---英雄扔掉X物品前触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
function herodropitemfrontX(actor,hero,makeIndex) end;

---英雄扔掉X物品后触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param hero     	object
---@param makeIndex     	object
function herodropitemX(actor,hero,makeIndex) end;

---英雄扔掉物品前触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
function herodropitemfrontex(actor,hero,makeIndex) end;

---英雄扔掉物品后触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
function herodropitemex(actor,hero,makeIndex) end;

---宝宝攻击前触发
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id 负数
---* damage     	伤害
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
---@param damage     	number
function attackdamagebb(actor,target,hitter,magicId,damage) end;

---英雄攻击前触发
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---* damage     	伤害
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
---@param damage     	number
function heroattackdamage(actor,target,hitter,magicId,damage) end;

---英雄宝宝攻击前触发
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---* damage     	伤害
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
---@param damage     	number
function heroattackdamagebb(actor,target,hitter,magicId,damage) end;

---宝宝物理攻击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function attackpet(actor,target,hitter,magicId) end;

---宝宝魔法攻击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function magicattackpet(actor,target,hitter,magicId) end;

---英雄物理攻击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function heroattack(actor,target,hitter,magicId) end;

---英雄魔法攻击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function heromagicattack(actor,target,hitter,magicId) end;

---英雄宝宝物理攻击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function heroattackpet(actor,target,hitter,magicId) end;

---英雄宝宝魔法攻击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function heromagicattackpet(actor,target,hitter,magicId) end;

---宝宝受击前
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---* damage     	伤害
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
---@param damage     	number
function struckdamagebb(actor,target,hitter,magicId,damage) end;

---英雄受击前
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---* damage     	伤害
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
---@param damage     	number
function herostruckdamage(actor,target,hitter,magicId,damage) end;

---英雄宝宝受击前
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---* damage     	伤害
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
---@param damage     	number
function herostruckdamagebb(actor,target,hitter,magicId,damage) end;

---宝宝物理受击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function struckpet(actor,target,hitter,magicId) end;

---宝宝魔法受击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function magicstruckpet(actor,target,hitter,magicId) end;

---英雄物理受击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function herostruck(actor,target,hitter,magicId) end;

---英雄魔法受击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function heromagicstruck(actor,target,hitter,magicId) end;

---英雄宝宝魔法受击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function heromagicstruckpet(actor,target,hitter,magicId) end;

---英雄宝宝物理受击后
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function herostruckpet(actor,target,hitter,magicId) end;

---英雄自身使用任意技能前触发
---* actor     	玩家对象
---* hero     	英雄对象
---* magicId     	技能id
---* magicName     	技能名字
---* target     	受击对象
---* x     	受击对象x坐标
---* y     	受击对象y坐标
---@param actor     	object
---@param hero     	object
---@param magicId     	number
---@param magicName     	string
---@param target     	object
---@param x     	number
---@param y     	number
function herobeginmagic(actor,hero,magicId,magicName,target,x,y) end;

---英雄推动技能施法前触发
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function herocanpush(actor,target,hitter,magicId) end;

---宠物推动技能施法前触发
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function petcanpush(actor,target,hitter,magicId) end;

---宝宝推动技能施法前触发
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function bbcanpush(actor,target,hitter,magicId) end;

---英雄宝宝推动技能施法前触发
---* actor     	玩家对象
---* target     	受击对象
---* hitter     	攻击对象
---* magicId     	技能id
---@param actor     	object
---@param target     	object
---@param hitter     	object
---@param magicId     	number
function herobbcanpush(actor,target,hitter,magicId) end;

---宝宝死亡触发，触发对象 主人
---* actor     	玩家对象
---* mon     	宝宝/怪物对象
---@param actor     	object
---@param mon     	object
function selfkillslave(actor,mon) end;

---杀掉宝宝触发，触发对象 攻击者
---* actor     	玩家对象
---* mon     	宝宝/怪物对象
---@param actor     	object
---@param mon     	object
function killslave(actor,mon) end;

---杀怪触发
---* actor     	玩家对象
---* mon     	宝宝/怪物对象
---* itype     	击杀者类型<br>0=凶手是宝宝;<br>1=英雄;<br>2=人物;<br>4=全局触发(无归属)
---* kill     	击杀者对象(凶手)
---* monName     	怪物名称
---* mapID     	地图id
---@param actor     	object
---@param mon     	object
---@param itype     	number
---@param kill     	object
---@param monName     	string
---@param mapID     	string
function killmon(actor,mon,itype,kill,monName,mapID) end;

---杀怪触发(需要在mapinfo地图参数增加onkillmon)
---* actor     	玩家对象
---* mon     	宝宝/怪物对象
---@param actor     	object
---@param mon     	object
function onkillmob(actor,mon) end;

---英雄被杀触发
---* actor     	被杀英雄玩家
---* hero     	英雄对象
---@param actor     	object
---@param hero     	object
function herodie(actor,hero) end;

---怪物掉落物品触发
---* actor     	玩家对象
---* makeIndex     	掉落装备物品唯一ID
---* mon     	掉落怪物对象
---* nX     	掉落坐标x
---* nY     	掉落坐标y
---* index     	物品序号
---@param actor     	object
---@param makeIndex     	object
---@param mon     	object
---@param nX     	number
---@param nY     	number
---@param index     	number
function mondropitemex(actor,makeIndex,mon,nX,nY,index) end;

---宝宝升级触发
---* actor     	玩家对象
---* mon     	宝宝对象
---* level     	当前等级
---@param actor     	object
---@param mon     	object
---@param level     	number
function slaveupgrade(actor,mon,level) end;

---角色获得宝宝触发
---* actor     	玩家对象
---* mon     	宝宝对象
---@param actor     	object
---@param mon     	object
function slavebb(actor,mon) end;

---英雄获得宝宝触发
---* actor     	玩家对象
---* hero     	英雄对象
---* mon     	宝宝对象
---@param actor     	object
---@param hero     	object
---@param mon     	object
function heroslavebb(actor,hero,mon) end;

---角色宝宝叛变触发
---* actor     	玩家对象
---* mon     	宝宝对象
---@param actor     	object
---@param mon     	object
function mobtreachery(actor,mon) end;

---英雄宝宝叛变触发
---* actor     	玩家对象
---* hero     	英雄对象
---* mon     	宝宝对象
---@param actor     	object
---@param hero     	object
---@param mon     	object
function heromobtreachery(actor,hero,mon) end;

---英雄穿套装触发
---* actor     	玩家对象
---* hero     	英雄对象
---* suitId     	套装id
---@param actor     	object
---@param hero     	object
---@param suitId     	number
function herogroupitemonex(actor,hero,suitId) end;

---英雄脱套装触发
---* actor     	玩家对象
---* hero     	英雄对象
---* suitId     	套装id
---@param actor     	object
---@param hero     	object
---@param suitId     	number
function herogroupitemoffex(actor,hero,suitId) end;

---英雄套装激活触发
---* actor     	玩家对象
---* hero     	英雄对象
---@param actor     	object
---@param hero     	object
function herogroupitemonX(actor,hero) end;

---英雄开启首饰盒触发(神佑/生肖)
---* actor     	玩家对象
---* hero     	英雄对象
---@param actor     	object
---@param hero     	object
function heroopensndaitembox(actor,hero) end;

---英雄忠诚度改变触发
---* actor     	玩家对象
---* hero     	英雄对象
---* luckNum     	忠诚度
---@param actor     	object
---@param hero     	object
---@param luckNum     	number
function heroluck(actor,hero,luckNum) end;

---英雄勾选外显时装生效触发
---* actor     	玩家对象
---* hero     	英雄对象
---@param actor     	object
---@param hero     	object
function heroshowfashion(actor,hero) end;

---英雄取消外显时装生效触发
---* actor     	玩家对象
---* hero     	英雄对象
---@param actor     	object
---@param hero     	object
function heronotshowfashion(actor,hero) end;

---英雄登陆触发
---* actor     	玩家对象
---* hero     	英雄对象
---@param actor     	object
---@param hero     	object
function herologin(actor,hero) end;

---角色升级触发
---* actor     	玩家对象
---* level     	升级后等级
---@param actor     	object
---@param level     	number
function playlevelup(actor,level) end;

---英雄升级触发
---* actor     	玩家对象
---* hero     	英雄对象
---@param actor     	object
---@param hero     	object
function herolevelup(actor,hero) end;

---英雄创建触发
---* actor     	玩家对象
---@param actor     	object
function createherook(actor) end;

---英雄取名成功触发
---* actor     	玩家对象
---@param actor     	object
function checkusernameok(actor) end;

---英雄取名失败触发
---* actor     	玩家对象
---@param actor     	object
function checkusernameno(actor) end;

---宠物升级触发
---* actor     	玩家对象
---* petIndex     	宠物编号
---* level     	等级
---* zsLevel     	转生等级
---@param actor     	object
---@param petIndex     	number
---@param level     	number
---@param zsLevel     	number
function petlevelup(actor,petIndex,level,zsLevel) end;

---获得宠物触发[人物上线首次加载宠物时也会触发]
---* actor     	玩家对象
---* petIndex     	宠物编号
---@param actor     	object
---@param petIndex     	number
function getnewpet(actor,petIndex) end;

---使用宠物蛋触发
---* actor     	玩家对象
---* makeIndex     	物品唯一id
---* itemIndex     	物品id
---@param actor     	object
---@param makeIndex     	number
---@param itemIndex     	number
function usepetitem(actor,makeIndex,itemIndex) end;

---宠物死亡触发
---* actor     	玩家对象
---* petIndex     	宠物编号
---@param actor     	object
---@param petIndex     	number
function petdie(actor,petIndex) end;

---宠物变蛋触发
---* actor     	玩家对象
---* makeIndex     	物品唯一id
---@param actor     	object
---@param makeIndex     	number
function pettoitem(actor,makeIndex) end;

---宠物攻击触发
---* actor     	玩家对象
---* petIndex     	宠物编号
---* target     	目标对象
---* magicId     	技能id
---* isImportant     	是否主目标
---@param actor     	object
---@param petIndex     	number
---@param target     	object
---@param magicId     	number
---@param isImportant     	number
function attackbypet(actor,petIndex,target,magicId,isImportant) end;

---宠物攻击伤害前触发
---* actor     	玩家对象
---* target     	目标对象
---* petObj     	宠物对象
---* magicId     	技能id
---* damage     	伤害值
---* isImportant     	是否主目标
---@param actor     	object
---@param target     	object
---@param petObj     	object
---@param magicId     	number
---@param damage     	number
---@param isImportant     	number
function attackdamagepet(actor,target,petObj,magicId,damage,isImportant) end;

---宠物被攻击前触发
---* actor     	玩家对象
---* hitter     	攻击者对象
---* petIndex     	宠物编号
---* magicId     	技能id
---* damage     	伤害值
---@param actor     	object
---@param hitter     	object
---@param petIndex     	object
---@param magicId     	number
---@param damage     	number
function struckdamagepet(actor,hitter,petIndex,magicId,damage) end;

---宠物被物理攻击触发
---* actor     	玩家对象
---* petIndex     	宠物编号
---* hitter     	攻击者对象
---* magicId     	技能id
---@param actor     	object
---@param petIndex     	object
---@param hitter     	object
---@param magicId     	number
function struckofpet(actor,petIndex,hitter,magicId) end;

---宠物被魔法攻击触发
---* actor     	玩家对象
---* petIndex     	宠物编号
---* hitter     	攻击者对象
---* magicId     	技能id
---@param actor     	object
---@param petIndex     	object
---@param hitter     	object
---@param magicId     	number
function magicstruckofpet(actor,petIndex,hitter,magicId) end;

---英雄脱下装备前触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	装备唯一ID
---* where     	装备位置
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
---@param where     	number
function herotakeoffbeforeex(actor,hero,makeIndex,where) end;

---英雄穿戴装备前触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	物品唯一ID
---* where     	装备位置
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
---@param where     	number
function herotakeonbeforeex(actor,hero,makeIndex,where) end;

---英雄穿戴装备前触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
function herotakeonbeforeX(actor,hero,makeIndex) end;

---英雄脱下装备前触发(X=装备位置)
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	装备唯一ID
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
function herotakeoffbeforeX(actor,hero,makeIndex) end;

---英雄脱下装备触发(X=装备位置)
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
function herotakeoffX(actor,hero,makeIndex) end;

---英雄物品进包前触发
---* actor     	玩家对象
---* itemMakeIndex     	物品唯一index
---* itemIndex     	物品index
---@param actor     	object
---@param itemMakeIndex     	number
---@param itemIndex     	number
function addherobagbefore(actor,itemMakeIndex,itemIndex) end;

---英雄穿戴装备触发(X=装备位置)
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	装备唯一ID
---@param actor     	object
---@param hero     	object
---@param makeIndex     	number
function herotakeonX(actor,hero,makeIndex) end;

---英雄属性改变时触发
---* actor     	玩家对象
---* hero     	英雄对象
---@param actor     	object
---@param hero     	object
function herosendability(actor,hero) end;

---英雄死亡装备掉落前触发
---* actor     	玩家对象
---* hero     	英雄对象
---* where     	装备位
---* itemIndex     	装备Index
---@param actor     	object
---@param hero     	object
---@param where     	number
---@param itemIndex     	number
function herocheckdropuseitems(actor,hero,where,itemIndex) end;

---英雄死亡前触发
---* actor     	玩家对象
---* hero     	英雄对象
---* hitter     	击杀者对象
---* isplayer     	0=击杀者非玩家<br>1=击杀者是玩家
---@param actor     	object
---@param hero     	object
---@param hitter     	object
---@param isplayer     	number
function heronextdie(actor,hero,hitter,isplayer) end;

---英雄套装失效触发
---* actor     	玩家对象
---* hero     	英雄对象
---@param actor     	object
---@param hero     	object
function herogroupitemoffX(actor,hero) end;

---英雄复活时触发
---* actor     	玩家对象
---* hero     	英雄对象
---@param actor     	object
---@param hero     	object
function herorevival(actor,hero) end;

---英雄双击类道具触发
---* actor     	玩家对象
---* hero     	英雄对象
---* makeIndex     	物品唯一ID
---@param actor     	object
---@param hero     	object
---@param makeIndex     	string
function herostdmodefuncX(actor,hero,makeIndex) end;

---接取任务触发
---* actor     	玩家对象
---* taskId     	任务id
---@param actor     	object
---@param taskId     	number
function picktask(actor,taskId) end;

---点击任务触发
---* actor     	玩家对象
---* taskId     	任务id
---@param actor     	object
---@param taskId     	number
function clicknewtask(actor,taskId) end;

---刷新任务触发
---* actor     	玩家对象
---* taskId     	任务id
---@param actor     	object
---@param taskId     	number
function changetask(actor,taskId) end;

---完成任务触发
---* actor     	玩家对象
---* taskId     	任务id
---@param actor     	object
---@param taskId     	number
function completetask(actor,taskId) end;

---删除任务触发
---* actor     	玩家对象
---* taskId     	任务id
---@param actor     	object
---@param taskId     	number
function deletetask(actor,taskId) end;

---创建行会前触发
---* actor     	玩家对象
---* guildName     	行会名
---@param actor     	object
---@param guildName     	string
function checkbuildguild(actor,guildName) end;

---创建行会时触发
---* actor     	玩家对象
---* guild     	行会对象
---@param actor     	object
---@param guild     	object
function loadguild(actor,guild) end;

---加入行会前触发
---* actor     	玩家对象
---* guild     	行会对象
---@param actor     	object
---@param guild     	object
function guildaddmember(actor,guild) end;

---退出行会前触发
---* actor     	玩家对象
---@param actor     	object
function guilddelmemberbefore(actor) end;

---退出行会时触发
---* actor     	玩家对象
---@param actor     	object
function guilddelmember(actor) end;

---解散行会前
---* actor     	玩家对象
---@param actor     	object
function guildclosebefore(actor) end;

---请求行会联盟前触发
---* actor     	发起请求玩家对象
---* guildName     	行会名字
---* time     	结盟时长(小时)
---* moneyType     	货币类型
---* moneyNum     	货币数量
---@param actor     	object
---@param guildName     	string
---@param time     	number
---@param moneyType     	number
---@param moneyNum     	number
function guildapplybefore(actor,guildName,time,moneyType,moneyNum) end;

---掌门踢出行会成员前触发
---* actor     	玩家对象
---* userId     	被踢玩家userID
---@param actor     	object
---@param userId     	string
function guildchiefdelmember(actor,userId) end;

---创建组队前触发
---* actor     	玩家对象
---@param actor     	object
function startgroup(actor) end;

---创建组队后触发
---* actor     	玩家对象
---@param actor     	object
function groupcreate(actor) end;

---添加组队成员触发
---* actor     	玩家对象
---* leader     	队长对象
---@param actor     	object
---@param leader     	object
function groupaddmember(actor,leader) end;

---邀请组队前触发
---* actor1     	发起邀请对象
---* actor2     	被邀请对象
---@param actor1     	object
---@param actor2     	object
function invitegroup(actor1,actor2) end;

---离开队伍时触发(退组)
---* actor     	玩家对象
---* leader     	队长对象
---@param actor     	object
---@param leader     	object
function leavegroup(actor,leader) end;

---删除组队成员触发
---* actor     	队长对象
---@param actor     	object
function groupdelmember(actor) end;

---组队杀死怪物时触发
---* actor     	玩家对象
---* leader     	队长对象
---@param actor     	object
---@param leader     	object
function groupkillmon(actor,leader) end;

---组队人数改变触发
---* actor     	玩家对象
---@param actor     	object
function groupchange(actor) end;

---拍卖行上架触发
---* actor     	玩家对象
---* itemIndex     	物品id
---* itemMakeIndex     	物品唯一id
---* moneyType     	货币类型
---* price1     	竞拍价
---* price2     	一口价
---@param actor     	object
---@param itemIndex     	number
---@param itemMakeIndex     	number
---@param moneyType     	number
---@param price1     	number
---@param price2     	number
function canpaimaiitem(actor,itemIndex,itemMakeIndex,moneyType,price1,price2) end;

---拍卖行重新上架前触发
---* actor     	玩家对象
---* itemIndex     	物品id
---* itemMakeIndex     	物品唯一id
---* moneyType     	货币类型
---* price1     	竞拍价
---* price2     	一口价
---@param actor     	object
---@param itemIndex     	number
---@param itemMakeIndex     	number
---@param moneyType     	number
---@param price1     	number
---@param price2     	number
function canrepaimaiitem(actor,itemIndex,itemMakeIndex,moneyType,price1,price2) end;

---拍卖行下架触发
---* actor     	玩家对象
---@param actor     	object
function cangetbackpaimaiitem(actor) end;

---领取拍卖货币触发
---* actor     	玩家对象
---@param actor     	object
function getpaimaiitem(actor) end;

---拍卖购买物品触发
---* actor     	玩家对象
---* itemIndex     	物品id
---* itemMakeIndex     	物品唯一id
---* moneyType     	货币类型
---* price     	价格
---@param actor     	object
---@param itemIndex     	number
---@param itemMakeIndex     	number
---@param moneyType     	number
---@param price     	number
function buypaimaiitem(actor,itemIndex,itemMakeIndex,moneyType,price) end;

---拍卖行竞价触发
---* actor     	玩家对象
---* itemIndex     	物品id
---* itemMakeIndex     	物品唯一id
---* moneyType     	货币类型
---* price     	价格
---@param actor     	object
---@param itemIndex     	number
---@param itemMakeIndex     	number
---@param moneyType     	number
---@param price     	number
function buypaimaiitem(actor,itemIndex,itemMakeIndex,moneyType,price) end;

---采集前触发
---* actor     	玩家对象
---* monIndex     	怪物id
---* monName     	怪物名字
---* monMakeIndex     	怪物唯一id
---@param actor     	object
---@param monIndex     	number
---@param monName     	string
---@param monMakeIndex     	number
function collectmonex(actor,monIndex,monName,monMakeIndex) end;

---玩家点击采集怪物将会触发
---* actor     	玩家对象
---* mon     	怪物对象
---@param actor     	object
---@param mon     	number
function collectmonX(actor,mon) end;

---镖车到达指定位置触发
---* actor     	玩家对象
---@param actor     	object
function carpathend(actor) end;

---镖车切换地图触发
---* actor     	玩家对象
---@param actor     	object
function leavedart(actor) end;

---镖车进入自动寻路范围触发
---* actor     	镖车主人对象
---@param actor     	object
function carfindmaster(actor) end;

---丢失镖车触发
---* actor     	镖车主人对象
---* car     	镖车对象
---@param actor     	object
---@param car     	object
function losercar(actor,car) end;

---镖车死亡触发
---* actor     	攻击镖车对象
---* car     	镖车对象
---@param actor     	object
---@param car     	object
function cardie(actor,car) end;

---镖车被攻击触发
---* actor     	镖车主人对象
---* hitter     	攻击者对象
---* car     	镖车对象
---@param actor     	object
---@param hitter     	object
---@param car     	object
function slavedamage(actor,hitter,car) end;

---攻击别人镖车触发
---* actor     	攻击者对象
---* master     	镖车主人对象
---* car     	镖车对象
---@param actor     	object
---@param master     	object
---@param car     	object
function hitslave(actor,master,car) end;

---玩家buff操作触发
---* actor     	玩家对象
---* buffId     	buffID
---* groupId     	组id
---* model     	操作类型<br>1=新增;<br>2=更新;<br>4=删除;
---@param actor     	object
---@param buffId     	number
---@param groupId     	number
---@param model     	number
function buffchange(actor,buffId,groupId,model) end;

---英雄buff操作触发
---* actor     	玩家对象
---* hero     	英雄对象
---* buffId     	buffID
---* groupId     	组id
---* model     	操作类型<br>1=新增;<br>2=更新;<br>4=删除;
---@param actor     	object
---@param hero     	object
---@param buffId     	number
---@param groupId     	number
---@param model     	number
function herobuffchange(actor,hero,buffId,groupId,model) end;

---buff触发血量改变时(玩家)
---* actor     	玩家对象
---* buffId     	buffid
---* buffGroup     	buff组
---* HP     	hp
---* buffHost     	释放者对象
---@param actor     	object
---@param buffId     	number
---@param buffGroup     	number
---@param HP     	number
---@param buffHost     	object
function bufftriggerhpchange(actor,buffId,buffGroup,HP,buffHost,mon) end;

---buff触发血量改变时(怪物)
---* sysobj     	系统对象<br>
---* buffId     	buffid
---* buffGroup     	buff组
---* HP     	hp
---* buffHost     	释放者对象
---* mon     	怪物对象
---@param sysobj     	object
---@param buffId     	number
---@param buffGroup     	number
---@param HP     	number
---@param buffHost     	object
---@param mon     	object
function g_bufftriggerhpchange(sysobj,buffId,buffGroup,HP,buffHost,mon) end;

---玩家穴位点击触发
---* actor     	玩家对象
---@param actor     	object
function pulse(actor) end;

---英雄穴位点击触发
---* actor     	玩家对象
---@param actor     	object
function heropulse(actor) end;

---玩家修炼经络触发
---* actor     	玩家对象
---@param actor     	object
function pulselvupX(actor) end;

---英雄修炼经络触发
---* actor     	玩家对象
---@param actor     	object
function heropulselvupX(actor) end;

---自定义排行榜刷新触发
---* sysObj     	系统对象
---@param sysObj     	object
function inisort(sysObj) end;

---自定义排行榜切换玩家和英雄的页签触发
---* actor     	玩家对象
---* isHero     	0=打开玩家页签；<br>1=打开英雄页签
---@param actor     	string
---@param isHero     	number
function clicksortbutton(actor,isHero) end;

---自定义排行榜点击排名触发
---* actor     	玩家对象
---* ranking     	排行榜名次
---@param actor     	string
---@param ranking     	number
function clicksortno(actor,ranking) end;

---求购上架前触发
---* actor     	玩家对象
---* itemName     	求购物品名称
---* itemIndex     	求购物品idx
---* needNum     	求购的物品数量
---* price     	求购的货币金额(总值)
---@param actor     	object
---@param itemName     	string
---@param itemIndex     	number
---@param needNum     	number
---@param price     	number
function beforeaddqiugou(actor,itemName,itemIndex,needNum,price) end;

---求购上架成功触发
---* actor     	玩家对象
---* itemName     	求购物品名称
---* itemIndex     	求购物品idx
---* needNum     	求购的物品数量
---* price     	求购的货币金额(总值)
---@param actor     	object
---@param itemName     	string
---@param itemIndex     	number
---@param needNum     	number
---@param price     	number
function addqiugou(actor,itemName,itemIndex,needNum,price) end;

---出售前触发
---* actor     	玩家对象
---* itemName     	出售物品名称
---* itemIndex     	出售物品idx
---* needNum     	出售的物品数量
---* price     	出售的货币金额(总值)
---@param actor     	object
---@param itemName     	string
---@param itemIndex     	number
---@param needNum     	number
---@param price     	number
function beforesellqiugou(actor,itemName,itemIndex,needNum,price) end;

---卖出成功触发
---* actor     	玩家对象
---* itemName     	卖出物品名称
---* itemIndex     	卖出物品idx
---* needNum     	卖出的物品数量
---* price     	卖出的货币金额(总值)
---@param actor     	object
---@param itemName     	string
---@param itemIndex     	number
---@param needNum     	number
---@param price     	number
function sellqiugou(actor,itemName,itemIndex,needNum,price) end;

---客户端发起建立关系请求时触发
---* actor     	玩家对象
---* netid     	关系id
---* role     	接收者对象
---@param actor     	object
---@param netid     	number
---@param role     	object
function on_invite_united(actor,netid,role) end;

---客户端发起召集请求时触发
---* actor     	邀请者玩家对象
---* netIndex     	关系唯一id
---* level     	发起者职位等级
---* netId     	关系id
---@param actor     	object
---@param netIndex     	string
---@param level     	number
---@param netId     	number
function on_convene_united(actor,netIndex,level,netId) end;

---客户端发起踢除某成员关系请求时触发
---* actor     	玩家对象
---* netIndex     	关系唯一id
---* netid     	关系id
---* role     	被踢出对象
---@param actor     	object
---@param netIndex     	string
---@param netid     	number
---@param role     	object
function on_getout_united(actor,netIndex,netid,role) end;

---客户端发起解散关系请求时触发
---* actor     	玩家对象
---* netIndex     	关系唯一id
---* netid     	关系id
---@param actor     	object
---@param netIndex     	string
---@param netid     	number
function on_dissolve_united(actor,netIndex,netid) end;

---客户端发起退出请求时触发
---* actor     	玩家对象
---* userId     	用户id
---* netIndex     	关系唯一id
---* netId     	关系id
---@param actor     	object
---@param userId     	string
---@param netIndex     	string
---@param netId     	number
function on_exit_united(actor,userId,netIndex,netId) end;

---进入跨服触发
---* actor     	玩家对象
---@param actor     	object
function kflogin(actor) end;

---退出跨服触发
---* actor     	玩家对象
---@param actor     	object
function kfend(actor) end;

---读取全局触发
---* Param1     	写数据时的<font color=&quot;FF0000&quot;>&quot;key&quot;</font>
---* Param2     	写数据时的 <font color=&quot;FF0000&quot;>&quot;value&quot;</font>
---@param Param1     	string
---@param Param2     	string
function G_TongReadKey(Param1,Param2) end;

---读取玩家角色/账号触发
---* key     	写数据时的<font color=&quot;FF0000&quot;>&quot;key&quot;</font>
---* id     	玩家角色ID或玩家账号ID 
---* value     	写数据时的 <font color=&quot;FF0000&quot;>&quot;value&quot;</font>
---@param key     	string
---@param id     	string
---@param value     	string
function TongReadKeyTouSer(key,id,value) end;

---下载文件触发
---* type     	0=上传成功</br>1=上传失败</br>2=上传异常</br>3=下载成功</br>4=下载失败</br>5=下载异常</br>
---* path     	取回路径
---@param type     	string
---@param path     	string
function G_TongFileState(type,path) end;

---获取key列表触发
---* len     	`key`长度
---* content     	`key`内容
---@param len     	string
---@param content     	string
function G_TongGetKeyList(len,content) end;

---获取key数量触发
---* len     	`key`长度
---@param len     	string
function G_TongQueryKeyConut(len) end;

---批量操作触发
---* Param1     	初始化后的结果
---@param Param1     	string
function G_TongClearKey(Param1) end;

function GetInt(Type,actor,sVarName) end;
function SetInt(Type,actor,sVarName,nValue) end;
function GetStr(Type,actor,sVarName) end;
function SetStr(Type,actor,sVarName,nValue) end;
function SetSysInt(varName,value,itype) end;
function GetSysInt(varName) end;
function SetSysStr(varName,value,itype) end;
function GetSysStr(varName) end;
function SetTempInt(Type,actor,sVarName,nValue) end;
function GetTempInt(Type,actor,sVarName) end;
function SetTempStr(Type,actor,sVarName,nValue) end;
function GetTempStr(Type,actor,sVarName) end;
function SetSysTempInt(varName,value) end;
function GetSysTempInt(varName) end;
function SetSysTempStr(varName,value) end;
function GetSysTempStr(varName) end;
function GetKeyValue(Type,actor,sVarName,Key) end;
function SetKeyValue(Type,actor,sVarName,Key,Value) end;
function SetTLInt(Type,actor,sVarName,nValue,time) end;
function GetTLInt(Type,actor,sVarName) end;
function SetTLStr(Type,actor,sVarName,nValue,time) end;
function GetTLStr(Type,actor,sVarName) end;
function SetSysTLInt(sVarName,nValue,time) end;
function GetSysTLInt(sVarName) end;
function SetSysTLStr(sVarName,nValue,time) end;
function GetSysTLStr(sVarName) end;

return E996