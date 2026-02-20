---@meta _

GUI={}; SL={}; UIOperator={}; GUIFunction={};

---@class userdata

---创建窗口控件
---* ID   控件ID
---* X       控件位置的横坐标
---* Y       控件位置的纵坐标
---* W       控件的宽
---* H   控件的高
---* Main       是否隐藏主界面
---* Last   是否隐藏上一个界面
---* NV  是否点击时有音效
---* EscC   是否esc关闭
---* IsRev   是否pc鼠标经过吞噬，默认true
---* NpcID   绑定npcid
---* Rpos   是否不记录关闭位置，true为初始位置，false为上次关闭位置
---* Type		 创建层 0主界面层 1普通面板层 2通知层 默认1<br>仅普通面板时 Main、Last、EscC
---@param ID  number
---@param X      number
---@param Y      number
---@param W      number
---@param H  number
---@param Main      boolean
---@param Last  boolean
---@param NV boolean
---@param EscC  boolean
---@param IsRev  boolean
---@param NpcID  number
---@param Rpos  boolean
---@param Type		 number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:Win_Create(ID,X,Y,W,H,Main,Last,NV,EscC,IsRev,NpcID,Rpos,Type) end;

---创建图片控件
---* Parent   父控件对象
---* ID   控件ID
---* X     控件位置的横坐标
---* Y     控件位置的纵坐标
---* nimg     图片路径
---@param Parent  userdata
---@param ID  string
---@param X    number
---@param Y    number
---@param nimg    string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:Image_Create(Parent,ID,X,Y,nimg) end;

---创建按钮控件
---* Parent   父控件对象
---* ID   控件ID
---* X     控件位置的横坐标
---* Y     控件位置的纵坐标
---* nimg     图片路径
---@param Parent  userdata
---@param ID  string
---@param X    number
---@param Y    number
---@param nimg    string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:Button_Create(Parent, ID, X, Y, nimg) end;

---创建文本控件
---* Parent   父控件对象
---* ID   控件ID
---* X     控件位置的横坐标
---* Y     控件位置的纵坐标
---* fontSize     字体大小
---* fontColor     字体颜色
---* str     文本
---@param Parent  userdata
---@param ID  string
---@param X    number
---@param Y    number
---@param fontSize    number
---@param fontColor    string
---@param str    string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:Text_Create(Parent, ID, X, Y, fontSize, fontColor, str) end;

---创建Bmp文本
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* fontColor   字体颜色,支持传空
---* str         文本
---* fontPath    字体文件路径, 例：`&quot;fonts/stfont.fnt&quot;`
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param fontColor   string
---@param str         string
---@param fontPath    string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:BmpText_Create(parent, ID, x, y, fontColor, str, fontPath) end;

---创建艺术字文本
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* stringValue    文本内容
---* charMapFile    艺术字路径
---* itemWidth      单个字体宽度
---* itemHeight     单个字体高度
---* startCharMap   起始字符设置(&quot;/&quot;)
---* sheet		    字体内容(H5专属)<br>比如图片文字是“+-0123456789”,那这个sheet的值就是&quot;+-0123456789&quot;
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param stringValue    string
---@param charMapFile    string
---@param itemWidth      number
---@param itemHeight     number
---@param startCharMap   string
---@param sheet		    string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:TextAtlas_Create(parent, ID, x, y, stringValue, charMapFile, itemWidth, itemHeight, startCharMap, sheet) end;

---创建富文本
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* str         文本内容
---* width       富文本控件宽度
---* fontSize    字体大小
---* fontColor   字体颜色
---* vspace      富文本行间距
---* hyperlinkCB 超链回调函数
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param str         string
---@param width       number
---@param fontSize    number
---@param fontColor   string
---@param vspace      number
---@param hyperlinkCB function
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:RichText_Create(parent, ID, x, y, str, width, fontSize, fontColor, vspace, hyperlinkCB, defaultFontFace) end;

---创建原始富文本
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* str         文本内容
---* width       富文本控件宽度
---* fontSize    字体大小
---* color       字体颜色, 例: &quot;#FFFFFF&quot;
---* vspace      富文本行间距
---* hyperlinkCB 超链回调函数
---* fontPath    字体文件路径
---* outlineParam 描边参数 <br>outlineSize: 描边大小 <br>outlineColor: 描边颜色 C3B <br> (描边颜色 例 : <br>`SL:ConvertColorFromHexString(&quot;#FFFFFF&quot;)`)
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param str         string
---@param width       number
---@param fontSize    number
---@param color       string
---@param vspace      number
---@param hyperlinkCB function
---@param fontPath    string
---@param outlineParam table
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:RichTextFCOLOR_Create(parent, ID, x, y, str, width, fontSize, color, vspace, hyperlinkCB, fontPath, outlineParam) end;

---创建自定义组合富文本
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       富文本控件最大宽度
---* vspace      富文本行间距
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param vspace      number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:RichTextCombine_Create(parent, ID, x, y, width, vspace) end;

---创建自定义组合富文本cell
---* parent      父节点对象 [RichTextCombine]
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* type        cell类型 <br> 文本类型：1或TEXT<br>节点类型：2或NODE<br>换行类型：3 或 NEWLINE
---* param       额外参数
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param type        number
---@param param       table
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:RichTextCombineCell_Create(parent, ID, x, y, type, param) end;

---创建滚动文本
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       文本宽度
---* fontSize    字体大小
---* fontColor   字体颜色
---* str         文本内容
---* scrollTime  滚动时长 (秒)
---* fontPath	 字体文件路径
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param fontSize    number
---@param fontColor   number
---@param str         string
---@param scrollTime  number
---@param fontPath	 string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:ScrollText_Create(parent, ID, x, y, width, fontSize, fontColor, str, scrollTime, fontPath) end;

---创建节点
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:Node_Create(parent, ID, x, y) end;

---创建Widget
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       宽
---* height      高
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param height      number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:Widget_Create(parent, ID, x, y, width, height) end;

---创建物品框
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* setData     配置数据
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param setData     table
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:ItemShow_Create(parent, ID, x, y, setData) end;

---创建物品放入框
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* img         放置框底图资源路径
---* boxindex    放置框 唯一ID
---* stdmode     允许传入的StdMode (&quot;*&quot;: 所有 、单个用number 、多个用table)
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param img         string
---@param boxindex    number
---@param stdmode     string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:ItemBox_Create(parent, ID, x, y, img, boxindex, stdmode) end;

---创建复选框
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* nimg        正常图片路径
---* pimg        选中图片路径
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param nimg        string
---@param pimg        string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:CheckBox_Create(parent, ID, x, y, nimg, pimg) end;

---创建输入框
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       宽度
---* height      高度
---* fontSize    字体大小
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param height      number
---@param fontSize    number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:TextInput_Create(parent, ID, x, y, width, height, fontSize) end;

---创建滚动条
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* barimg      滚动条背景图片
---* pbarimg     滚动条图片
---* nimg        滚动条拖动块图片
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param barimg      string
---@param pbarimg     string
---@param nimg        string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:Slider_Create(parent, ID, x, y, barimg, pbarimg, nimg) end;

---创建圆形进度条
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* img         图片路径
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param img         string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:ProgressTimer_Create(parent, ID, x, y, img) end;

---创建进度条
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* nimg        图片路径
---* direction   方向：<br>0 从左到右<br>1 从右到左
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param nimg        string
---@param direction   number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:LoadingBar_Create(parent, ID, x, y, nimg, direction) end;

---创建特效
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* effecttype  0 特效<br>1 NPC<br>2 怪物<br>3 技能<br>4 人物<br>5 武器<br>6 翅膀<br>7 发型<br>8 盾牌
---* effectid   特效id
---* sex        性别(0 男 1 女)
---* act        0 待机<br>1 走<br>2 攻击<br>3 施法 <br>4 死亡<br>5 跑步
---* dir        方向
---* speed      播放速度
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param effecttype  number
---@param effectid   number
---@param sex        number
---@param act        number
---@param dir        number
---@param speed      number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:Effect_Create(parent, ID, x, y, effecttype, effectid, sex, act, dir, speed) end;

---创建人物模型
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* sex         0 男性 1 女性
---* feature     模型属性
---* scale       缩放比例(0-1)
---* useStaticScale 是否使用game_data配置staticSacle数据, 默认忽略
---* job         职业id 012 战法道等新增职业
---* ext_param   额外参数
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param sex         number
---@param feature     table
---@param scale       number
---@param useStaticScale boolean
---@param job         number
---@param ext_param   table
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:UIModel_Create(parent, ID, x, y, sex, feature, scale, useStaticScale, job, ext_param) end;

---创建层容器
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       宽度
---* height      长度
---* isClip      是否裁切
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param height      number
---@param isClip      boolean
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:Layout_Create(parent, ID, x, y, width, height, isClip) end;

---创建列表容器(TableView)
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       容器宽度
---* height      容器高度
---* direction   1：垂直; 2：水平
---* cellWid	 单个cell 宽
---* cellHei	 单个cell 高
---* num		 需创建cell个数
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param height      number
---@param direction   number
---@param cellWid	 number
---@param cellHei	 number
---@param num		 number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:TableView_Create(parent, ID, x, y, width, height, direction, cellWid, cellHei, num) end;

---创建滚动容器
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       宽度
---* height      高度
---* direction   1：垂直; 2：水平
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param height      number
---@param direction   number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:ScrollView_Create(parent, ID, x, y, width, height, direction) end;

---创建翻页容器
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       宽度
---* height      高度
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param height      number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:PageView_Create(parent, ID, x, y, width, height, direction) end;

---创建滚动容器子节点
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* w           宽度
---* h           高度
---* createCB    创建子节点内容回调 [函数返回 widget]
---* activeCB	 判断是否需要激活/创建 [函数返回 boolean值]
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param w           number
---@param h           number
---@param createCB    function
---@param activeCB	 function
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:QuickCell_Create(parent, ID, x, y, w, h, createCB, activeCB) end;

---创建序列帧动画
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* prefix      前缀
---* suffix      后缀
---* beginframe  起始帧, 默认1
---* finishframe 结束帧
---* ext         附加参数, {speed = 播放速度
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param prefix      string
---@param suffix      string
---@param beginframe  number
---@param finishframe number
---@param ext         table
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:Frames_Create(parent, ID, x, y, prefix, suffix, beginframe, finishframe, ext) end;

---创建粒子特效
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* res         粒子特效资源路径 plist文件
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param res         string
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:ParticleEffect_Create(parent, ID, x, y, res) end;

---创建骨骼动画
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* jsonPath    json文件路径
---* atlasPath   atlas文件路径
---* trackIndex  索引值
---* name        动画名
---* loop        动画是否循环
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param jsonPath    string
---@param atlasPath   string
---@param trackIndex  number
---@param name        string
---@param loop        boolean
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:SpineAnim_Create(parent, ID, x, y, jsonPath, atlasPath, trackIndex, name, loop) end;

---创建拖拽容器
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       宽
---* height      高
---* from     	 控件来自(界面位置)  官方默认的可参照GUIDefine.ItemFrom, <br>自定义类型的示例 : <br>`GUIDefine.ItemFrom.xxx` <br>[xxx: 自定义类型名]
---* ext		 额外参数
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param height      number
---@param from     	 number
---@param ext		 table
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:MoveWidget_Create(parent, ID, x, y, width, height, from, ext) end;

---创建刮图
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* showImg     展示图片资源
---* maskImg     遮罩图片资源
---* clearHei 	 刮除高度, 默认16
---* moveTime	 刮除时间, 单位: 秒
---* beginTime   开始点击到结束触发间隔, 单位: 秒
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param showImg     string
---@param maskImg     string
---@param clearHei 	 number
---@param moveTime	 number
---@param beginTime   number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:ScrapePic_Create(parent, ID, x, y, showImg, maskImg, clearHei, moveTime, beginTime, callback) end;

---创建旋转容器
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       宽度
---* height      高度
---* scrollGap   滑动间隙, 默认100
---* param       子节点参数, 参考
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param height      number
---@param scrollGap   number
---@param param       table
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:RotateView_Create(parent, ID, x, y, width, height, scrollGap, param) end;

---创建装备框
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* pos    	 装备装戴位置
---* isHero		 是否英雄装备
---* data		 额外参数
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param pos    	 number
---@param isHero		 boolean
---@param data		 table
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:EquipShow_Create(parent, ID, x, y, pos, isHero, data) end;

---创建渐变字文本
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* size    	 渐变字大小
---* txt		 渐变字文本内容
---* color1		 渐变颜色1
---* color2    	 渐变颜色2
---* param1		 渐变参数（param1，param2组合<br>1，0为横向渐变<br>0，1为纵向渐变）
---* param2		 渐变参数（param1，param2组合<br>1，0为横向渐变<br>0，1为纵向渐变）
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param size    	 number
---@param txt		 string
---@param color1		 string
---@param color2    	 string
---@param param1		 number
---@param param2		 number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:GradientColorText_Create(parent, ID, x, y, size, txt, color1,color2,param1,param2) end;

---创建列表容器(ListView)
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       容器宽度
---* height      容器高度
---* direction   1：垂直; 2：水平
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param height      number
---@param direction   number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:ListView_Create(parent, ID, x, y, width, height, direction) end;

---创建视频播放器
---* parent      父节点对象
---* ID          唯一ID
---* x           位置 横坐标
---* y           位置 纵坐标
---* width       容器宽度
---* height      容器高度
---@param parent      userdata
---@param ID          string
---@param x           number
---@param y           number
---@param width       number
---@param height      number
---@return userdata "返回:成功时返回控件对象，失败时返回空"
function GUI:VideoPlayer_Create(parent, ID, x, y, width, height) end;

---获取界面控件
---* parent   父控件对象
---* ID   控件ID
---@param parent  userdata
---@param ID  string
function GUI:GetWindow(parent, ID) end;

---获取控件自定义参数
---* widget   界面对象
---@param widget  userdata
function GUI:Win_GetParam(widget) end;

---获取按钮文字
---* widget      按钮对象
---@param widget      userdata
---@return string "返回:按钮文字"
function GUI:Button_getTitleText(widget) end;

---获取文本
---* widget    对象
---@param widget    userdata
---@return string "返回:文本内容"
function GUI:Text_getString(widget) end;

---获取艺术字文本
---* widget      艺术字对象
---@param widget      userdata
---@return string "返回:艺术字文本内容"
function GUI:TextAtlas_getString(widget) end;

---获取滚动文本内容
---* widget      滚动文本对象
---@param widget      userdata
---@return string "返回:滚动文本内容"
function GUI:ScrollText_getString(widget) end;

---获取对应ID放置框的物品数据
---* widget      物品放入框控件对象
---* boxindex    放置框 唯一ID
---@param widget      userdata
---@param boxindex    number
---@return table "返回:放置框的物品数据"
function GUI:ItemBox_GetItemData(widget, boxindex) end;

---获取复选框是否选中
---* widget      复选框对象
---@param widget      userdata
---@return boolean "返回:true(选中)/false(未选中)"
function GUI:CheckBox_isSelected(widget) end;

---获取输入框文本
---* widget      输入框对象
---@param widget      userdata
---@return string "返回:输入框文本"
function GUI:TextInput_getString(widget) end;

---获得滚动条进度
---* widget      滚动条对象
---@param widget      userdata
---@return number "返回:滚动条进度"
function GUI:Slider_getPercent(widget) end;

---获取圆形进度条百分比
---* widget      控件对象
---@param widget      userdata
---@return number "返回:圆形进度条百分比"
function GUI:ProgressTimer_getPercentage(widget) end;

---获取进度条进度
---* widget      进度条对象
---@param widget      userdata
---@return number "返回:进度条进度"
function GUI:LoadingBar_getPercent(widget) end;

---获取进度条颜色
---* widget      进度条对象
---@param widget      userdata
---@return string "返回:进度条颜色值"
function GUI:LoadingBar_getColor(widget) end;

---获取层背景图片文件路径
---* widget      层对象
---@param widget      userdata
---@return string "返回:背景图片路径"
function GUI:Layout_getBackGroundImageFile(widget) end;

---获取列表容器间隔
---* widget    容器对象
---@param widget    userdata
---@return number "返回:间隔距离(像素)"
function GUI:ListView_getItemsMargin(widget) end;

---获取列表容器最顶部可见范围子节点
---* widget    容器对象
---@param widget    userdata
---@return userdata "返回:顶部范围子节点对象"
function GUI:ListView_getTopmostItemInCurrentView(widget) end;

---获取列表容器最底部部可见范围子节点
---* widget    容器对象
---@param widget    userdata
---@return userdata "返回:底部范围子节点对象"
function GUI:ListView_getBottommostItemInCurrentView(widget) end;

---获取子节点序列号
---* widget    容器对象
---* value    子节点对象
---@param widget    userdata
---@param value    userdata
---@return number "返回:子节点序列号"
function GUI:ListView_getItemIndex(widget, value) end;

---通过子节点序列号获取子节点对象
---* widget    容器对象
---* value    子节点序列号
---@param widget    userdata
---@param value    number
---@return userdata "返回:子控件对象"
function GUI:ListView_getItemByIndex(widget, value) end;

---获取列表容器所有子节点对象
---* widget    容器对象
---@param widget    userdata
---@return table "返回:所有子节点对象"
function GUI:ListView_getItems(widget) end;

---获取列表容器所有子节点数量
---* widget    容器对象
---@param widget    userdata
---@return number "返回:子节点总数量"
function GUI:ListView_getItemCount(widget) end;

---获取列表容器滚动范围大小
---* widget    容器对象
---@param widget    userdata
---@return table "返回:列表容器滚动范围大小"
function GUI:ListView_getInnerContainerSize(widget) end;

---获取列表容器内部滚动区域坐标
---* widget    容器对象
---@param widget    userdata
---@return table "返回:列表容器内部滚动区域坐标"
function GUI:ListView_getInnerContainerPosition(widget) end;

---获取滚动容器滚动范围大小
---* widget      容器对象
---@param widget      userdata
---@return table "返回:滚动容器滚动范围大小"
function GUI:ScrollView_getInnerContainerSize(widget) end;

---获取容器内部滚动区域坐标
---* widget      容器对象
---@param widget      userdata
---@return table "返回:容器内部滚动区域坐标"
function GUI:ScrollView_getInnerContainerPosition(widget) end;

---获取当前子页面序列号
---* widget      容器对象
---@param widget      userdata
---@return number "返回:子页面序列号"
function GUI:PageView_getCurrentPageIndex(widget) end;

---获取翻页容器子页面
---* widget      容器对象
---@param widget      userdata
---@return table "返回:子页面对象"
function GUI:PageView_getItems(widget) end;

---获取翻页容器子页面数量
---* widget      容器对象
---@param widget      userdata
---@return number "返回:子页面数量"
function GUI:PageView_getItemCount(widget) end;

---获取列表容器内部区域偏移位置
---* widget      tableView对象
---@param widget      userdata
function GUI:TableView_getContentOffset(widget) end;

---获取容器cell的下标/序列号
---* cell      tableViewCell对象
---@param cell      userdata
---@return number "返回:cell下标"
function GUI:TableViewCell_getIdx(cell) end;

---获取对应下标item添加的子节点
---* widget      旋转容器对象
---* index       对应下标
---@param widget      userdata
---@param index       number
---@return userdata "返回:子节点"
function GUI:RotateView_getChildByIndex(widget, index) end;

---获取对应下标item
---* widget      旋转容器对象
---* index       对应下标
---@param widget      userdata
---@param index       number
---@return userdata "返回:对应下标item"
function GUI:RotateView_getItemByIndex(widget, index) end;

---获取父节点的快捷子控件组
---* parent      父节点
---@param parent      userdata
---@return table  [key 为控件名] "返回:父节点的快捷子控件组"
function GUI:ui_delegate(parent) end;

---获取主界面左上挂接点
---@return userdata "返回:主界面左上挂接点"
function GUI:Attach_LeftTop() end;

---获取主界面右上挂接点
---@return userdata "返回:主界面右上挂接点"
function GUI:Attach_RightTop() end;

---获取主界面左下挂接点
---@return userdata "返回:主界面左下挂接点"
function GUI:Attach_LeftBottom() end;

---获取主界面右下挂接点
---@return userdata "返回:主界面右下挂接点"
function GUI:Attach_RightBottom() end;

---获取最上层UI挂接点
---@return userdata "返回:最上层UI挂接点"
function GUI:Attach_UITop() end;

---获取上层场景挂接点
---@return userdata "返回:上层场景挂接点"
function GUI:Attach_SceneF() end;

---获取下层场景挂接点
---@return userdata "返回:下层场景挂接点"
function GUI:Attach_SceneB() end;

---获取主界面最底层左上挂接点
---@return userdata "返回:主界面最底层左上挂接点"
function GUI:Attach_LeftTop_B() end;

---获取主界面最底层右上挂接点
---@return userdata "返回:主界面最底层右上挂接点"
function GUI:Attach_RightTop_B() end;

---获取主界面最底层左下挂接点
---@return userdata "返回:主界面最底层左下挂接点"
function GUI:Attach_LeftBottom_B() end;

---获取主界面最底层右下挂接点
---@return userdata "返回:主界面最底层右下挂接点"
function GUI:Attach_RightBottom_B() end;

---获取主界面最顶层左上挂接点
---@return userdata "返回:主界面最顶层左上挂接点"
function GUI:Attach_LeftTop_T() end;

---获取主界面最顶层右上挂接点
---@return userdata "返回:主界面最顶层右上挂接点"
function GUI:Attach_RightTop_T() end;

---获取主界面最顶层左下挂接点
---@return userdata "返回:主界面最顶层左下挂接点"
function GUI:Attach_LeftBottom_T() end;

---获取主界面最顶层右下挂接点
---@return userdata "返回:主界面最顶层右下挂接点"
function GUI:Attach_RightBottom_T() end;

---获取自带父节点 [挂接点ID: 101-111]
---* ID      挂接点ID
---@param ID      number
---@return userdata "返回:自带父节点"
function GUI:Win_FindParent(ID) end;

---获取坐标
---* widget    控件对象
---@param widget    userdata
---@return table "返回:控件坐标"
function GUI:getPosition(widget) end;

---获取横坐标
---* widget    控件对象
---@param widget    userdata
---@return number "返回:横坐标"
function GUI:getPositionX(widget) end;

---获取纵坐标
---* widget    控件对象
---@param widget    userdata
---@return number "返回:纵坐标"
function GUI:getPositionY(widget) end;

---获取控件锚点
---* widget   控件对象
---@param widget   userdata
---@return table "返回:控件锚点"
function GUI:getAnchorPoint(widget) end;

---获取控件尺寸大小(纹理大小 不考虑缩放)
---* widget    控件对象
---@param widget    userdata
---@return table "返回:{height = height, width = width}"
function GUI:getContentSize(widget) end;

---获取控件尺寸大小(考虑缩放的真实大小)
---* widget    控件对象
---@param widget    userdata
---@return table "返回:{height = height, width = width}"
function GUI:getBoundingBox(widget) end;

---获取控件标签
---* widget      图片对象
---@param widget      userdata
---@return number "返回:标签"
function GUI:getTag(widget) end;

---获取控件旋转角度
---* widget    控件对象
---@param widget    userdata
---@return number "返回:控件旋转角度"
function GUI:getRotation(widget) end;

---获取控件是否显示状态
---* widget    控件对象
---@param widget    userdata
---@return boolean "返回:控件是否显示 true/false"
function GUI:getVisible(widget) end;

---获取控件Y轴方向缩放比例
---* widget    控件对象
---@param widget    userdata
---@return number "返回:控件Y轴方向缩放比例"
function GUI:getScaleY(widget) end;

---获取控件X轴方向缩放比例
---* widget    控件对象
---@param widget    userdata
---@return number "返回:控件X轴方向缩放比例"
function GUI:getScaleX(widget) end;

---获取是否水平翻转
---* widget    控件对象
---@param widget    userdata
---@return boolean "返回:是否水平翻转"
function GUI:getFlippedX(widget) end;

---获取是否垂直翻转
---* widget    控件对象
---@param widget    userdata
---@return boolean "返回:是否垂直翻转"
function GUI:getFlippedY(widget) end;

---获得控件世界坐标
---* widget    控件对象
---@param widget    userdata
---@return table "返回:控件世界坐标"
function GUI:getWorldPosition(widget) end;

---获取控件是否可以触摸
---* widget    控件对象
---@param widget    userdata
---@return boolean "返回:是否可触摸 true/false"
function GUI:getTouchEnabled(widget) end;

---获取父节点
---* widget    子控件对象
---@param widget    userdata
---@return userdata "返回:父节点"
function GUI:getParent(widget) end;

---获取控件所有子节点
---* widget    父控件对象
---@param widget    userdata
---@return table "返回:控件所有子节点"
function GUI:getChildren(widget) end;

---获取控件名字
---* widget    控件对象
---@param widget    userdata
---@return string "返回:控件名字"
function GUI:getName(widget) end;

---通过控件名字获取子节点
---* widget    父控件对象
---* name     控件名字
---@param widget    userdata
---@param name     string
---@return userdata "返回:子节点"
function GUI:getChildByName(widget, name) end;

---通过控件标记获取子节点
---* widget    父控件对象
---* tag     控件标记
---@param widget    userdata
---@param tag     number
---@return userdata "返回:子节点"
function GUI:getChildByTag(widget, tag) end;

---获取控件触摸开始时位置
---* widget    控件对象
---@param widget    userdata
---@return table "返回:触摸开始时位置{x = x, y = y}"
function GUI:getTouchBeganPosition(widget) end;

---获取控件触摸移动时位置
---* widget    控件对象
---@param widget    userdata
---@return table "返回:控件触摸移动时位置{x = x, y = y}"
function GUI:getTouchMovePosition(widget) end;

---获取控件触摸结束时位置
---* widget    控件对象
---@param widget    userdata
---@return table "返回:控件触摸结束时位置{x = x, y = y}"
function GUI:getTouchEndPosition(widget) end;

---获取控件是否触摸吞噬
---* widget    控件对象
---@param widget    userdata
---@return boolean "返回:是否触摸吞噬 true/false"
function GUI:getSwallowTouches(widget) end;

---检查触摸位置是否被父节点裁剪
---* widget    控件对象
---* position   世界坐标
---@param widget    userdata
---@param position   table
---@return boolean "返回:触摸位置是否被父节点裁剪 true/false"
function GUI:isClippingParentContainsPoint(widget, position) end;

---设置控件自定义参数
---* widget   界面对象
---* param 参数内容
---@param widget  userdata
---@param param number
function GUI:Win_SetParam(widget, param) end;

---设置界面拖拽
---* widget   界面对象
---* dragLayer 拖拽区域控件
---@param widget  userdata
---@param dragLayer userdata
function GUI:Win_SetDrag(widget, dragLayer) end;

---设置主界面隐藏
---* widget      界面对象
---* value       是否隐藏, 普通面板生效
---@param widget      userdata
---@param value       boolean
function GUI:Win_SetMainHide(widget, value) end;

---设置界面绑定NPC
---* widget      界面对象
---* npcID       NPCID
---@param widget      userdata
---@param npcID       number
function GUI:Win_BindNPC(widget, npcID) end;

---设置界面浮起
---* widget      界面对象
---* zPanel      控件对象
---@param widget      userdata
---@param zPanel      userdata
function GUI:Win_SetZPanel(widget, zPanel) end;

---设置界面绑定事件
---* widget      界面对象
---* eventID     事件ID
---* eventTag    事件描述
---@param widget      userdata
---@param eventID     string
---@param eventTag    string
function GUI:Win_BindLuaEvent(widget, eventID, eventTag) end;

---设置界面内鼠标右键吞噬
---* widget      界面对象
---* state       是否吞噬
---@param widget      userdata
---@param state       boolean
function GUI:Win_SetSwallowRightMouseTouch(widget, state) end;

---设置图片九宫格
---* widget      图片对象
---* scale9l     左边比例
---* scale9r     右边比例
---* scale9t     上边比例
---* scale9b     下边比例
---@param widget      userdata
---@param scale9l     number
---@param scale9r     number
---@param scale9t     number
---@param scale9b     number
function GUI:Image_setScale9Slice(widget, scale9l, scale9r, scale9t, scale9b) end;

---设置图片是否变灰
---* widget      图片对象
---* isGrey      是否置灰
---@param widget      userdata
---@param isGrey      boolean
function GUI:Image_setGrey(widget, isGrey) end;

---设置按钮状态图片
---* widget                     按钮对象
---* Normalfilepath             正常状态图片路径
---* Pressedfilepath            按压状态图片路径
---* Disabledfilepath           禁用状态图片路径
---* TextureType                加载类型：<br>0 图片<br>1 图片集 plist文件
---@param widget                     userdata
---@param Normalfilepath             string
---@param Pressedfilepath            string
---@param Disabledfilepath           string
---@param TextureType                number
function GUI:Button_loadTextures(widget, Normalfilepath, Pressedfilepath, Disabledfilepath, TextureType) end;

---设置正常状态图片
---* widget      按钮对象
---* filepath    图片路径
---@param widget      userdata
---@param filepath    string
function GUI:Button_loadTextureNormal(widget, filepath) end;

---设置按下状态图片
---* widget      按钮对象
---* filepath    图片路径
---@param widget      userdata
---@param filepath    string
function GUI:Button_loadTexturePressed(widget, filepath) end;

---设置禁用状态图片
---* widget      按钮对象
---* filepath    图片路径
---@param widget      userdata
---@param filepath    string
function GUI:Button_loadTextureDisabled(widget, filepath) end;

---设置按钮文字
---* widget      按钮对象
---* value       按钮显示文本
---@param widget      userdata
---@param value       string
function GUI:Button_setTitleText(widget, value) end;

---设置按钮文字颜色
---* widget      按钮对象
---* value       色值（#000000）
---@param widget      userdata
---@param value       string
function GUI:Button_setTitleColor(widget, value) end;

---设置按钮文字大小
---* widget      按钮对象
---* value       字体大小（字号16）
---@param widget      userdata
---@param value       number
function GUI:Button_setTitleFontSize(widget, value) end;

---设置按钮文字样式
---* widget      按钮对象
---* value       字体样式（font.ttf）
---@param widget      userdata
---@param value       string
function GUI:Button_setTitleFontName(widget, value) end;

---设置按钮文本最大宽度
---* widget      按钮对象
---* value       文本最大宽度
---@param widget      userdata
---@param value       number
function GUI:Button_setMaxLineWidth(widget, value) end;

---设置按钮文本加描边
---* widget      按钮对象
---* color       描边色值（#000000）
---* outline     描边大小
---@param widget      userdata
---@param color       string
---@param outline     number
function GUI:Button_titleEnableOutline(widget, color, outline) end;

---取消按钮文本描边
---* widget      按钮对象
---@param widget      userdata
function GUI:Button_titleDisableOutLine(widget) end;

---设置按钮是否禁用(可触摸)
---* widget      按钮对象
---* value       是否禁用（可触摸）
---@param widget      userdata
---@param value       boolean
function GUI:Button_setBright(widget, value) end;

---设置按钮是否禁用(不可触摸)
---* widget      按钮对象
---* value       是否禁用（不可触摸）
---@param widget      userdata
---@param value       boolean
function GUI:Button_setBrightEx(widget, value) end;

---设置按钮当前状态
---* widget      按钮对象
---* value       状态（0正常 1按下）
---@param widget      userdata
---@param value       number
function GUI:Button_setBrightStyle(widget, value) end;

---设置按钮是否灰态
---* widget      按钮对象
---* value       是否灰态
---@param widget      userdata
---@param value       boolean
function GUI:Button_setGrey(widget, value) end;

---设置按钮九宫格
---* widget      按钮对象
---* scale9l     左边比例
---* scale9r     右边比例
---* scale9t     上边比例
---* scale9b     下边比例
---@param widget      userdata
---@param scale9l     number
---@param scale9r     number
---@param scale9t     number
---@param scale9b     number
function GUI:Button_setScale9Slice(widget, scale9l, scale9r, scale9t, scale9b) end;

---设置文本
---* widget    对象
---* value    文本
---@param widget    userdata
---@param value    string
function GUI:Text_setString(widget, value) end;

---设置文本颜色
---* widget    对象
---* value    色值(&quot;#000000&quot;)
---@param widget    userdata
---@param value    string
function GUI:Text_setTextColor(widget, value) end;

---设置字体大小
---* widget    对象
---* value    字体大小
---@param widget    userdata
---@param value    number
function GUI:Text_setFontSize(widget, value) end;

---设置字体路径
---* widget    对象
---* value    字体文件路径<br>例: &quot;fonts/font.ttf&quot;
---@param widget    userdata
---@param value    string
function GUI:Text_setFontName(widget, value) end;

---设置字体描边
---* widget    对象
---* color    色值(&quot;#000000&quot;)
---* size     描边宽度
---@param widget    userdata
---@param color    string
---@param size     number
function GUI:Text_enableOutline(widget, color, size) end;

---设置是否启用下划线
---* widget    文本对象
---@param widget    userdata
function GUI:Text_enableUnderline(widget) end;

---设置文本最大行宽
---* widget    对象
---* value    宽度
---@param widget    userdata
---@param value    number
function GUI:Text_setMaxLineWidth(widget, value) end;

---设置文本垂直对齐
---* widget    对象
---* value    0：顶对齐<br> 1：垂直居中<br>2：底对齐
---@param widget    userdata
---@param value    number
function GUI:Text_setTextVerticalAlignment(widget, value) end;

---设置文本水平对齐
---* widget    对象
---* value    0：顶对齐<br> 1：垂直居中<br>2：底对齐
---@param widget    userdata
---@param value    number
function GUI:Text_setTextHorizontalAlignment(widget, value) end;

---设置文本尺寸
---* widget    对象
---* value    {width = 0, height = 0}
---@param widget    userdata
---@param value    table
function GUI:Text_setTextAreaSize(widget, value) end;

---设置倒计时文本
---* widget    对象
---* time     倒计时时间, 单位:秒
---* callback   倒计时结束触发
---* showType   倒计时时间显示方式 <br>0: xx时xx分xx秒 <br>1: 小于1天显示xx:xx:xx 大于显示xx天xx时xx分
---@param widget    userdata
---@param time     number
---@param callback   function
---@param showType   number
function GUI:Text_COUNTDOWN(widget, time, callback, showType) end;

---设置艺术字配置
---* widget      艺术字对象
---* stringValue    文本内容
---* charMapFile    艺术字路径
---* itemWidth      字体宽度
---* itemHeight     字体高度
---* startCharMap   起始字符设置(&quot;/&quot;)
---* sheet		    字体内容(H5专属)<br>比如图片文字是“+-0123456789”,那这个sheet的值就是&quot;+-0123456789&quot;
---@param widget      userdata
---@param stringValue    string
---@param charMapFile    string
---@param itemWidth      number
---@param itemHeight     number
---@param startCharMap   string
---@param sheet		    string
function GUI:TextAtlas_setProperty(widget, stringValue, charMapFile, itemWidth, itemHeight, startCharMap, sheet) end;

---设置艺术字文本
---* widget      艺术字对象
---* value       文本内容
---@param widget      userdata
---@param value       string
function GUI:TextAtlas_setString(widget, value) end;

---设置富文本背景颜色
---* widget      控件对象
---* color       颜色值, 例: &quot;#000000&quot;
---@param widget      userdata
---@param color       string
function GUI:RichText_setBackgroundColor(widget, color) end;

---设置滚动文本内容
---* widget      滚动文本对象
---* value       文本内容
---@param widget      userdata
---@param value       string
function GUI:ScrollText_setString(widget, value) end;

---设置滚动文本描边
---* widget      滚动文本对象
---* color       描边色值(&quot;#000000&quot;)
---* size        描边大小
---@param widget      userdata
---@param color       string
---@param size        number
function GUI:ScrollText_enableOutline(widget, color, size) end;

---设置滚动文本水平对齐
---* widget      滚动文本对象
---* value       对齐方式：<br>1 左对齐<br>2 水平居中<br>3 右对齐
---@param widget      userdata
---@param value       number
function GUI:ScrollText_setHorizontalAlignment(widget, value) end;

---设置滚动文本颜色
---* widget      滚动文本对象
---* value       色值(&quot;#000000&quot;)
---@param widget      userdata
---@param value       string
function GUI:ScrollText_setTextColor(widget, value) end;

---设置物品框单击事件
---* widget      物品框对象
---* eventCB      单击事件函数
---@param widget      userdata
---@param eventCB      function
function GUI:ItemShow_addReplaceClickEvent(widget, eventCB) end;

---设置物品框双击事件
---* widget      物品框对象
---* eventCB      双击事件函数
---@param widget      userdata
---@param eventCB      function
function GUI:ItemShow_addDoubleEvent(widget, eventCB) end;

---设置物品框长按事件
---* widget      物品框对象
---* eventCB      长按事件函数
---@param widget      userdata
---@param eventCB      function
function GUI:ItemShow_addPressEvent(widget, eventCB) end;

---设置物品框是否置灰
---* widget      物品框对象
---* value       是否置灰
---@param widget      userdata
---@param value       boolean
function GUI:ItemShow_setIconGrey(widget, value) end;

---设置物品框是否选中
---* widget      物品框对象
---* value       是否选中
---@param widget      userdata
---@param value       boolean
function GUI:ItemShow_setItemShowChooseState(widget, value) end;

---设置物品框是否拖动
---* widget      物品框对象
---* value       是否拖动
---@param widget      userdata
---@param value       boolean
function GUI:ItemShow_setMoveEable(widget, value) end;

---更新物品框内容
---* widget      物品框对象
---* itemData    配置数据
---@param widget      userdata
---@param itemData    table
function GUI:ItemShow_updateItem(widget, itemData) end;

---设置物品框是否触摸吞噬
---* widget      物品框对象
---* isSwallow       是否触摸吞噬
---@param widget      userdata
---@param isSwallow       boolean
function GUI:ItemShow_setItemTouchSwallow(widget, isSwallow) end;

---设置复选框默认状态背景图片
---* widget      复选框对象
---* value       默认状态图片路径
---@param widget      userdata
---@param value       string
function GUI:CheckBox_loadTextureBackGround(widget, value) end;

---设置复选框选中状态背景图片
---* widget      复选框对象
---* value       选中状态图片路径
---@param widget      userdata
---@param value       string
function GUI:CheckBox_loadTextureFrontCross(widget, value) end;

---设置复选框禁用状态背景图片
---* widget      复选框对象
---* value       禁用状态图片路径
---@param widget      userdata
---@param value       string
function GUI:CheckBox_loadTextureFrontCrossDisabled(widget, value) end;

---设置复选框选中或取消
---* widget      复选框对象
---* value       选中或取消
---@param widget      userdata
---@param value       boolean
function GUI:CheckBox_setSelected(widget, value) end;

---设置输入框字体颜色
---* widget      输入框对象
---* value       色值(&quot;#000000&quot;)
---@param widget      userdata
---@param value       string
function GUI:TextInput_setFontColor(widget, value) end;

---设置输入框字体
---* widget      输入框对象
---* value       字体路径
---* value2      字号
---@param widget      userdata
---@param value       string
---@param value2      number
function GUI:TextInput_setFont(widget, value, value2) end;

---设置输入框字体大小
---* widget      输入框对象
---* value       字号
---@param widget      userdata
---@param value       number
function GUI:TextInput_setFontSize(widget, value) end;

---设置输入框占位文本字体
---* widget      输入框对象
---* value       字体路径
---* value2      字体(&quot;font.ttf&quot;)
---@param widget      userdata
---@param value       string
---@param value2      string
function GUI:TextInput_setPlaceholderFont(widget, value, value2) end;

---设置输入框占位文本字体颜色
---* widget      输入框对象
---* value       色值(&quot;#000000&quot;)
---@param widget      userdata
---@param value       string
function GUI:TextInput_setPlaceholderFontColor(widget, value) end;

---设置输入框占位文本字体大小
---* widget      输入框对象
---* value       字号
---@param widget      userdata
---@param value       number
function GUI:TextInput_setPlaceholderFontSize(widget, value) end;

---设置输入框占位文本
---* widget      输入框对象
---* value       输入内容
---@param widget      userdata
---@param value       string
function GUI:TextInput_setPlaceHolder(widget, value) end;

---设置输入框文本
---* widget      输入框对象
---* value       输入内容
---@param widget      userdata
---@param value       string
function GUI:TextInput_setString(widget, value) end;

---设置输入框行宽
---* widget      输入框对象
---* value       输入框控件宽度
---@param widget      userdata
---@param value       number
function GUI:TextInput_setMaxLength(widget, value) end;

---设置输入框水平对齐
---* widget      输入框对象
---* value       对齐方式：<br>0 顶对齐<br> 1 底对齐<br>2 水平居中
---@param widget      userdata
---@param value       number
function GUI:TextInput_setTextHorizontalAlignment(widget, value) end;

---设置输入框文本类型
---* widget      输入框对象
---* value       类型
---@param widget      userdata
---@param value       number
function GUI:TextInput_setInputFlag(widget, value) end;

---设置输入框键盘编辑类型
---* widget      输入框对象
---* value       类型
---@param widget      userdata
---@param value       number
function GUI:TextInput_setInputMode(widget, value) end;

---设置输入框弹出式键盘返回类型
---* widget      输入框对象
---* value       类型
---@param widget      userdata
---@param value       number
function GUI:TextInput_setReturnType(widget, value) end;

---设置输入框监听事件
---* widget      输入框对象
---* eventCB     事件处理函数
---@param widget      userdata
---@param eventCB     function
function GUI:TextInput_addOnEvent(widget, eventCB) end;

---设置滚动条背景图
---* widget      滚动条对象
---* value       背景图路径
---@param widget      userdata
---@param value       string
function GUI:Slider_loadBarTexture(widget, value) end;

---设置滚动条图片
---* widget      滚动条对象
---* value       滚动条图片路径
---@param widget      userdata
---@param value       string
function GUI:Slider_loadProgressBarTexture(widget, value) end;

---设置滚动条拖动块普通图片
---* widget      滚动条对象
---* value       拖动块图片路径
---@param widget      userdata
---@param value       string
function GUI:Slider_loadSlidBallTextureNormal(widget, value) end;

---设置滚动条进度
---* widget      滚动条对象
---* value       滚动条进度(0-100)
---@param widget      userdata
---@param value       number
function GUI:Slider_setPercent(widget, value) end;

---设置滚动条最大进度值
---* widget      滚动条对象
---* value       滚动条最大进度值
---@param widget      userdata
---@param value       number
function GUI:Slider_setMaxPercent(widget, value) end;

---设置滚动条触摸事件
---* widget      滚动条对象
---* value       事件函数
---@param widget      userdata
---@param value       function
function GUI:Slider_addOnEvent(widget, value) end;

---设置圆形进度条百分比
---* widget      控件对象
---* value       进度(0-100)
---@param widget      userdata
---@param value       number
function GUI:ProgressTimer_setPercentage(widget, value) end;

---设置圆形进度条方向
---* widget      控件对象
---* value       true 顺时针<br>false 逆时针
---@param widget      userdata
---@param value       boolean
function GUI:ProgressTimer_setReverseDirection(widget, value) end;

---设置控件Y轴方向缩放
---* widget    控件对象
---* value    缩放比例, 默认1.0
---@param widget    userdata
---@param value    number
function GUI:setScaleY(widget, value) end;

---设置圆形进度条动作和回调函数
---* widget      控件对象
---* time        时间
---* to          结束进度(0-100)
---* completeCB  回调函数
---* tag         标记
---@param widget      userdata
---@param time        number
---@param to          number
---@param completeCB  function
---@param tag         number
function GUI:ProgressTimer_progressTo(widget, time, to, completeCB, tag) end;

---设置圆形进度条背景图
---* widget      控件对象
---* img         图片路径
---@param widget      userdata
---@param img         string
function GUI:ProgressTimer_ChangeImg(widget, img) end;

---设置进度条图片
---* widget      进度条对象
---* value       图片路径
---@param widget      userdata
---@param value       string
function GUI:LoadingBar_loadTexture(widget, value) end;

---设置进度条方向
---* widget      进度条对象
---* value       方向：<br>0 从左到右<br>1 从右到左
---@param widget      userdata
---@param value       number
function GUI:LoadingBar_setDirection(widget, value) end;

---设置进度条进度
---* widget      进度条对象
---* value       进度(0-100)
---@param widget      userdata
---@param value       number
function GUI:LoadingBar_setPercent(widget, value) end;

---设置进度条颜色
---* widget      进度条对象
---* value       色值(&quot;#000000&quot;)
---@param widget      userdata
---@param value       string
function GUI:LoadingBar_setColor(widget, value) end;

---设置特效播放完自动移除
---* widget      特效对象
---@param widget      userdata
function GUI:Effect_setAutoRemoveOnFinish(widget) end;

---设置粒子持续时间
---* widget      粒子特效
---* value       持续时间, 单位: 秒 <br> -1 表示永久
---@param widget      userdata
---@param value       number
function GUI:ParticleEffect_setDuration(widget, value) end;

---设置总粒子数量
---* widget      粒子特效
---* value       数量
---@param widget      userdata
---@param value       number
function GUI:ParticleEffect_setTotalParticles(widget, value) end;

---新增拖拽类型和拖拽事件
---* fromType    控件来自位置类型名
---* toType      控件到达位置类型名
---* fromToEvent 从fromType类型控件 拖拽到 toType类型控件 触发的函数
---* toFromEvent 从toType类型控件 拖拽到 fromType类型控件 触发的函数
---@param fromType    string
---@param toType      string
---@param fromToEvent function
---@param toFromEvent function
function GUI:AddMoveWidgetTypeEvent(fromType, toType, fromToEvent, toFromEvent) end;

---设置装备框显示自动刷新
---* widget      装备框对象
---@param widget      userdata
function GUI:EquipShow_setAutoUpdate(widget) end;

---设置坐标
---* widget   控件对象
---* x     横坐标
---* y     纵坐标
---@param widget   userdata
---@param x     number
---@param y     number
function GUI:setPosition(widget, x, y) end;

---设置横坐标
---* widget    控件对象
---* value    横坐标
---@param widget    userdata
---@param value    number
function GUI:setPositionX(widget, value) end;

---设置纵坐标
---* widget    控件对象
---* value     纵坐标
---@param widget    userdata
---@param value     number
function GUI:setPositionY(widget, value) end;

---设置控件锚点
---* widget    控件对象
---* x      横坐标
---* y      纵坐标
---@param widget    userdata
---@param x      number
---@param y      number
function GUI:setAnchorPoint(widget, x, y) end;

---设置控件尺寸大小
---* widget    控件对象
---* sizeW    宽度
---* sizeH    长度
---@param widget    userdata
---@param sizeW    number
---@param sizeH    number
function GUI:setContentSize(widget, sizeW, sizeH) end;

---设置忽略设置的自定义尺寸大小
---* widget    控件对象
---* value    是否忽略用户定义尺寸大小
---@param widget    userdata
---@param value    boolean
function GUI:setIgnoreContentAdaptWithSize(widget, value) end;

---设置控件标签
---* widget    控件对象
---* value    标签值
---@param widget    userdata
---@param value    number
function GUI:setTag(widget, value) end;

---设置控件名字
---* widget    控件对象
---* value    名字
---@param widget    userdata
---@param value    string
function GUI:setName(widget, value) end;

---设置控件置灰
---* widget    控件对象
---* isGrey    是否置灰
---@param widget    userdata
---@param isGrey    boolean
function GUI:setGrey(widget, isGrey) end;

---设置控件旋转角度
---* widget    控件对象
---* value    旋转角度（0 - 360）
---@param widget    userdata
---@param value    number
function GUI:setRotation(widget, value) end;

---设置容器内部滚动区域坐标
---* widget      容器对象
---* x      x
---* y      y
---@param widget      userdata
---@param x      number
---@param y      number
function GUI:ScrollView_setInnerContainerPosition(widget,x,y) end;

---设置列表容器内部滚动区域坐标
---* widget      容器对象
---* x      x
---* y      y
---@param widget      userdata
---@param x      number
---@param y      number
function GUI:ListView_setInnerContainerPosition(widget,x,y) end;

---设置复选框监听事件
---* widget      控件对象
---* eventCB      监听函数
---@param widget      userdata
---@param eventCB      function
function CheckBox_addOnEvent(widget,eventCB) end;

---设置控件渐变色
---* widget      控件对象
---* startColor      开始颜色
---* endColor      结束颜色
---* xPer      渐变参数（xPer，xPer<br>1，0为横向渐变<br>0，1为纵向渐变）
---* yPer      渐变参数（xPer，xPer<br>1，0为横向渐变<br>0，1为纵向渐变）
---@param widget      userdata
---@param startColor      string
---@param endColor      string
---@param xPer      number
---@param yPer      number
function GUI:Shader_GradientColor(widget, startColor, endColor, xPer, yPer) end;

---设置控件阴影
---* widget      控件对象
---@param widget      userdata
function GUI:SetShaderShadow(widget) end;

---设置控件X轴倾斜角度
---* widget    控件对象
---* value    倾斜角度（0 - 360）
---@param widget    userdata
---@param value    number
function GUI:setRotationSkewX(widget, value) end;

---设置控件Y轴倾斜角度
---* widget    控件对象
---* value    倾斜角度（0 - 360）
---@param widget    userdata
---@param value    number
function GUI:setRotationSkewY(widget, value) end;

---设置控件可见性
---* widget    控件对象
---* value    是否显示
---@param widget    userdata
---@param value    boolean
function GUI:setVisible(widget, value) end;

---设置控件不透明度
---* widget    控件对象
---* value    不透明度(0-255), 默认255
---@param widget    userdata
---@param value    number
function GUI:setOpacity(widget, value) end;

---获取控件不透明度
---* widget    控件对象
---@param widget    userdata
---@return number "返回:控件不透明度"
function GUI:getOpacity(widget) end;

---设置控件缩放
---* widget    控件对象
---* value    缩放比例, 默认1.0
---@param widget    userdata
---@param value    number
function GUI:setScale(widget, value) end;

---获取控件缩放比例
---* widget    控件对象
---@param widget    userdata
---@return number "返回:控件缩放比例"
function GUI:getScale(widget) end;

---设置控件X轴方向缩放
---* widget    控件对象
---* value    缩放比例, 默认1.0
---@param widget    userdata
---@param value    number
function GUI:setScaleX(widget, value) end;

---设置水平X轴方向翻转
---* widget    控件对象
---* value    X轴方向是否翻转
---@param widget    userdata
---@param value    boolean
function GUI:setFlippedX(widget, value) end;

---设置垂直Y轴方向翻转
---* widget    控件对象
---* value    Y轴方向是否翻转
---@param widget    userdata
---@param value    boolean
function GUI:setFlippedY(widget, value) end;

---设置控件渲染层级
---* widget    控件对象
---* value    渲染层级, 值越大显示越靠前
---@param widget    userdata
---@param value    number
function GUI:setLocalZOrder(widget, value) end;

---设置控件是否跟随父控件变化透明度
---* widget    控件对象
---* value    是否跟随
---@param widget    userdata
---@param value    boolean
function GUI:setCascadeOpacityEnabled(widget, value) end;

---设置控件的所有子控件是否跟随变化透明度
---* widget    控件对象
---* value    是否跟随
---@param widget    userdata
---@param value    boolean
function GUI:setChildrenCascadeOpacityEnabled(widget, value) end;

---设置控件是否可以触摸
---* widget    控件对象
---* value    是否触摸
---@param widget    userdata
---@param value    boolean
function GUI:setTouchEnabled(widget, value) end;

---设置延迟可触摸
---* widget    控件对象
---* delay    延迟触摸间隔
---@param widget    userdata
---@param delay    number
function GUI:delayTouchEnabled(widget, delay) end;

---设置控件是否可以鼠标触摸
---* widget    控件对象
---* value    是否鼠标触摸
---@param widget    userdata
---@param value    boolean
function GUI:setMouseEnabled(widget, value) end;

---设置控件是否触摸吞噬
---* widget    控件对象
---* value    是否吞噬
---@param widget    userdata
---@param value    boolean
function GUI:setSwallowTouches(widget, value) end;

---设置控件吞噬鼠标按键事件 [检查自身触摸吞噬时]
---* widget    控件对象
---@param widget    userdata
function GUI:setMouseRSwallowTouches(widget) end;

---设置控件点击事件
---* widget    控件对象
---* func    回调函数
---@param widget    userdata
---@param func    function
function GUI:addOnClickEvent(widget, func) end;

---设置控件触摸事件
---* widget    控件对象
---* func    回调函数
---@param widget    userdata
---@param func    function
function GUI:addOnTouchEvent(widget, func) end;

---设置控件长按触发事件
---* widget    控件对象
---* func    回调函数
---@param widget    userdata
---@param func    function
function GUI:addOnLongTouchEvent(widget, func) end;

---设置控件鼠标进入/移出事件
---* widget    控件对象
---* param    onEnterFunc: function 鼠标进入回调函数<br>onLeaveFunc: function 鼠标移出回调函数<br>onInsideFunc: function 鼠标一直在内部回调函数
---@param widget    userdata
---@param param    table
function GUI:addMouseMoveEvent(widget, param) end;

---设置鼠标按钮事件
---* widget    控件对象
---* param    onRightDownFunc: function 鼠标右键点击事件 <br> OnRightUpFunc: function 鼠标右键松开事件<br> needTouchPos: boolean 需要传入鼠标触摸位置<br>OnScrollFunc: function 鼠标滚轮滚动事件 
---@param widget    userdata
---@param param    table
function GUI:addMouseButtonEvent(widget, param) end;

---设置鼠标经过控件显示文本
---* widget    控件对象
---* str     文本
---* pos     位置
---* anr     锚点
---* param    checkCallback: function 检查接触点是否能展示[函数传入参数: pos <br>返回: true / false ]
---@param widget    userdata
---@param str     string
---@param pos     table
---@param anr     table
---@param param    table
function GUI:addMouseOverTips(widget, str, pos, anr, param) end;

---键盘监听事件
---* codeKeys   要监听的键盘键key
---* pressedCB  按下回调
---* releaseCB  松开回调(单按键时有效)
---* autoPressInterval  长按触发函数间隔 默认 1 
---* checkFullSort 兼容全顺序键盘key排列, 针对监听多键 
---@param codeKeys   string
---@param pressedCB  function
---@param releaseCB  function
---@param autoPressInterval  number
---@param checkFullSort boolean
function GUI:addKeyboardEvent(codeKeys, pressedCB, releaseCB, autoPressInterval, checkFullSort) end;

---移除键盘监听
---* codeKeys   要移除监听的键盘键key
---@param codeKeys   string
function GUI:removeKeyboardEvent(codeKeys) end;

---加载纹理图片
---* widget      图片对象
---* filepath    图片路径
---@param widget      userdata
---@param filepath    string
function GUI:Image_loadTexture(widget, filepath) end;

---设置物品放入框监听事件
---* widget      父节点对象
---* eventCB          事件处理函数
---@param widget      userdata
---@param eventCB          function
function GUI:ItemBox_AddOnEvent(widget, eventCB) end;

---设置层背景颜色
---* widget      层对象
---* value       色值(&quot;#000000&quot;)<br> ! 渐变色需传参table `{&quot;#FF0000&quot;, &quot;#FFFFFF&quot;}`
---@param widget      userdata
---@param value       string
function GUI:Layout_setBackGroundColor(widget, value) end;

---设置层背景颜色类型
---* widget      层对象
---* value       类型(1单色，2渐变色)
---@param widget      userdata
---@param value       number
function GUI:Layout_setBackGroundColorType(widget, value) end;

---设置层背景颜色不透明度
---* widget      层对象
---* value       不透明度(0-255)
---@param widget      userdata
---@param value       number
function GUI:Layout_setBackGroundColorOpacity(widget, value) end;

---设置层背景是否裁切
---* widget      层对象
---* value       是否裁切
---@param widget      userdata
---@param value       boolean
function GUI:Layout_setClippingEnabled(widget, value) end;

---设置层背景图片
---* widget      层对象
---* value       图片路径
---@param widget      userdata
---@param value       string
function GUI:Layout_setBackGroundImage(widget, value) end;

---设置层背景图片九宫格
---* widget      层对象
---* scale9l     左边比例
---* scale9r     右边比例
---* scale9t     上边比例
---* scale9b     下边比例
---@param widget      userdata
---@param scale9l     number
---@param scale9r     number
---@param scale9t     number
---@param scale9b     number
function GUI:Layout_setBackGroundImageScale9Slice(widget, scale9l, scale9r, scale9t, scale9b) end;

---移除层背景图片设置
---* widget      层对象
---@param widget      userdata
function GUI:Layout_removeBackGroundImage(widget) end;

---设置列表容器对齐方式
---* widget    容器对象
---* value    0：左对齐<br>1：右对齐<br>2：水平居中<br>3：顶对齐<br>4：底对齐<br>5：垂直居中
---@param widget    userdata
---@param value    number
function GUI:ListView_setGravity(widget, value) end;

---设置列表容器滑动方向
---* widget    容器对象
---* value    1：垂直; 2：水平
---@param widget    userdata
---@param value    number
function GUI:ListView_setDirection(widget, value) end;

---设置列表容器间隔
---* widget    容器对象
---* value    间隔大小(50像素)
---@param widget    userdata
---@param value    number
function GUI:ListView_setItemsMargin(widget, value) end;

---设置列表容器是否有裁切
---* widget    容器对象
---* value    是否有裁切
---@param widget    userdata
---@param value    boolean
function GUI:ListView_setClippingEnabled(widget, value) end;

---设置列表容器背景颜色
---* widget      tableView对象
---* value		 十六进制颜色值 例: &quot;#FFFFFF&quot;
---@param widget      userdata
---@param value		 string
function GUI:TableView_setBackGroundColor(widget, value) end;

---设置列表容器背景颜色类型
---* widget    容器对象
---* value    1：单色，2：渐变色
---@param widget    userdata
---@param value    number
function GUI:ListView_setBackGroundColorType(widget, value) end;

---设置列表容器背景透明度
---* widget    容器对象
---* value    透明度(0-255)
---@param widget    userdata
---@param value    number
function GUI:ListView_setBackGroundColorOpacity(widget, value) end;

---设置列表容器背景图片
---* widget    容器对象
---* value    图片路径
---@param widget    userdata
---@param value    string
function GUI:ListView_setBackGroundImage(widget, value) end;

---设置列表容器背景图片九宫格
---* widget    容器对象
---* scale9l   左边比例
---* scale9r   右边比例
---* scale9t   上边比例
---* scale9b   下边比例
---@param widget    userdata
---@param scale9l   number
---@param scale9r   number
---@param scale9t   number
---@param scale9b   number
function GUI:ListView_setBackGroundImageScale9Slice(widget, scale9l, scale9r, scale9t, scale9b) end;

---设置列表容器滚动事件
---* widget    容器对象
---* eventCB   事件函数
---@param widget    userdata
---@param eventCB   function
function GUI:ListView_addOnScrollEvent(widget, eventCB) end;

---设置列表容器滚动到某百分比位置(垂直方向)
---* widget    容器对象
---* percent   百分比(0-100)
---* time     时间(秒)
---* bool     是否衰减滚动速度
---@param widget    userdata
---@param percent   number
---@param time     number
---@param bool     boolean
function GUI:ListView_scrollToPercentVertical(widget, percent, time, bool) end;

---设置列表容器滚动到某百分比位置(水平方向)
---* widget    容器对象
---* percent   百分比(0-100)
---* time     时间(秒)
---* bool     是否衰减滚动速度
---@param widget    userdata
---@param percent   number
---@param time     number
---@param bool     boolean
function GUI:ListView_scrollToPercentHorizontal(widget, percent, time, bool) end;

---添加鼠标滚轮滑动列表容器事件
---* widget    容器对象
---@param widget    userdata
function GUI:ListView_addMouseScrollPercent(widget) end;

---设置滚动容器滚动范围大小
---* widget      容器对象
---* value1      宽度 或 尺寸
---* value2      高度
---@param widget      userdata
---@param value1      number
---@param value2      number
function GUI:ScrollView_setInnerContainerSize(widget, value1, value2) end;

---设置滚动容器滚动方向
---* widget      容器对象
---* value       1：垂直; 2：水平
---@param widget      userdata
---@param value       number
function GUI:ScrollView_setDirection(widget, value) end;

---设置滚动容器是否有回弹
---* widget      容器对象
---* value       是否有回弹
---@param widget      userdata
---@param value       boolean
function GUI:ScrollView_setBounceEnabled(widget, value) end;

---设置滚动容器是否有裁切
---* widget      容器对象
---* value       是否有裁切
---@param widget      userdata
---@param value       boolean
function GUI:ScrollView_setClippingEnabled(widget, value) end;

---设置滚动容器背景颜色
---* widget      容器对象
---* value       色值(&quot;#000000&quot;)<br> ! 渐变色需传参table `{&quot;#FF0000&quot;, &quot;#FFFFFF&quot;}`
---@param widget      userdata
---@param value       string
function GUI:ScrollView_setBackGroundColor(widget, value) end;

---设置滚动容器背景颜色类型
---* widget      容器对象
---* value       1：单色，2：渐变色
---@param widget      userdata
---@param value       number
function GUI:ScrollView_setBackGroundColorType(widget, value) end;

---设置滚动容器背景透明度
---* widget      容器对象
---* value       透明度(0-255)
---@param widget      userdata
---@param value       number
function GUI:ScrollView_setBackGroundOpacity(widget, value) end;

---设置滚动容器背景图片
---* widget      容器对象
---* value       图片路径
---@param widget      userdata
---@param value       string
function GUI:ScrollView_setBackGroundImage(widget, value) end;

---设置滚动器背景图片九宫格
---* widget      容器对象
---* scale9l     左边比例
---* scale9r     右边比例
---* scale9t     上边比例
---* scale9b     下边比例
---@param widget      userdata
---@param scale9l     number
---@param scale9r     number
---@param scale9t     number
---@param scale9b     number
function GUI:ScrollView_setBackGroundImageScale9Slice(widget, scale9l, scale9r, scale9t, scale9b) end;

---移除滚动容器背景图片设置
---* widget      容器对象
---@param widget      userdata
function GUI:ScrollView_removeBackGroundImage(widget) end;

---设置滚动容器滚动事件
---* widget      容器对象
---* eventCB     事件函数
---@param widget      userdata
---@param eventCB     function
function GUI:ScrollView_addOnScrollEvent(widget, eventCB) end;

---滚动容器加载子节点
---* widget      容器对象
---* value       子节点对象
---@param widget      userdata
---@param value       userdata
function GUI:ScrollView_addChild(widget, value) end;

---滚动容器删除所有子节点
---* widget      容器对象
---@param widget      userdata
function GUI:ScrollView_removeAllChildren(widget) end;

---滚动容器衰减滚动（顶部）
---* widget      容器对象
---* time        时间
---* boolvalue   是否衰减（顶部）
---@param widget      userdata
---@param time        number
---@param boolvalue   boolean
function GUI:ScrollView_scrollToTop(widget, time, boolvalue) end;

---滚动容器衰减滚动（底部）
---* widget      容器对象
---* time        时间
---* boolvalue   是否衰减（底部）
---@param widget      userdata
---@param time        number
---@param boolvalue   boolean
function GUI:ScrollView_scrollToBottom(widget, time, boolvalue) end;

---滚动容器衰减滚动（顶左）
---* widget      容器对象
---* time        时间
---* boolvalue   是否衰减（底部）
---@param widget      userdata
---@param time        number
---@param boolvalue   boolean
function GUI:ScrollView_scrollToTopLeft(widget, time, boolvalue) end;

---滚动容器衰减滚动（右边）
---* widget      容器对象
---* time        时间
---* boolvalue   是否衰减（右边）
---@param widget      userdata
---@param time        number
---@param boolvalue   boolean
function GUI:ScrollView_scrollToRight(widget, time, boolvalue) end;

---滚动容器衰减滚动（左边）
---* widget      容器对象
---* time        时间
---* boolvalue   是否衰减（左边）
---@param widget      userdata
---@param time        number
---@param boolvalue   boolean
function GUI:ScrollView_scrollToLeft(widget, time, boolvalue) end;

---滚动容器衰减滚动（垂直方向滚动）
---* widget      容器对象
---* percent     百分比
---* time        时间
---* boolvalue   是否衰减滚动速度
---@param widget      userdata
---@param percent     number
---@param time        number
---@param boolvalue   boolean
function GUI:ScrollView_scrollToPercentVertical(widget, percent, time, boolvalue) end;

---滚动容器衰减滚动（水平方向滚动）
---* widget      容器对象
---* percent     百分比
---* time        时间
---* boolvalue   是否衰减滚动速度
---@param widget      userdata
---@param percent     number
---@param time        number
---@param boolvalue   boolean
function GUI:ScrollView_scrollToPercentHorizontal(widget, percent, time, boolvalue) end;

---滚动容器添加滚动条
---* parent      父节点对象
---* param       布局参数
---@param parent      userdata
---@param param       table
function GUI:SetScrollViewVerticalBar(parent, param) end;

---设置翻页容器是否有裁切
---* widget      容器对象
---* value       是否有裁切
---@param widget      userdata
---@param value       boolean
function GUI:PageView_setClippingEnabled(widget, value) end;

---设置翻页容器背景颜色
---* widget      容器对象
---* value       色值(&quot;#000000&quot;)<br> ! 渐变色需传参table `{&quot;#FF0000&quot;, &quot;#FFFFFF&quot;}`
---@param widget      userdata
---@param value       string
function GUI:PageView_setBackGroundColor(widget, value) end;

---设置翻页容器背景颜色类型
---* widget      容器对象
---* value       1：单色，2：渐变色
---@param widget      userdata
---@param value       number
function GUI:PageView_setBackGroundColorType(widget, value) end;

---设置翻页容器背景透明度
---* widget      容器对象
---* value       透明度(0-255)
---@param widget      userdata
---@param value       number
function GUI:PageView_setBackGroundColorOpacity(widget, value) end;

---设置翻页容器滚动到子页面
---* widget      容器对象
---* index       子页面序列号
---@param widget      userdata
---@param index       number
function GUI:PageView_scrollToItem(widget, index) end;

---设置翻页容器当前子页序列号
---* widget      容器对象
---* index       子页面序列号
---@param widget      userdata
---@param index       number
function GUI:PageView_setCurrentPageIndex(widget, index) end;

---设置子cell创建方法
---* widget      tableView对象
---* func		 创建函数 传入参数(cell父节点, cell下标)
---@param widget      userdata
---@param func		 function
function GUI:TableView_setCellCreateEvent(widget, func) end;

---设置列表容器滚动方向
---* widget      tableView对象
---* value		 滚动方向 1：垂直; 2：水平
---@param widget      userdata
---@param value		 number
function GUI:TableView_setDirection(widget, value) end;

---设置列表容器内部区域偏移位置
---* widget      tableView对象
---* x			 偏移坐标X
---* y			 偏移坐标Y
---@param widget      userdata
---@param x			 number
---@param y			 number
function GUI:TableView_setContentOffset(widget, x, y) end;

---添加列表容器点击cell事件
---* widget      tableView对象
---* func		 点击cell触发回调
---@param widget      userdata
---@param func		 function
function GUI:TableView_addOnTouchedCellEvent(widget, func) end;

---列表容器滚动到某cell位置
---* widget      tableView对象
---* index		 对应cell下标
---@param widget      userdata
---@param index		 number
function GUI:TableView_scrollToCell(widget, index) end;

---添加容器滚动回调
---* widget      tableView对象
---* func		 容器滚动回调函数 param1: TableView控件
---@param widget      userdata
---@param func		 function
function GUI:TableView_addOnScrollEvent(widget, func) end;

---设置容器cell个数
---* widget      tableView对象
---* func		 cell总个数(int)/返回cell总个数的函数(func)
---@param widget      userdata
---@param func		 number
function GUI:TableView_setTableViewCellsNumHandler(widget, func) end;

---移除列表容器背景图片设置
---* widget    容器对象
---@param widget    userdata
function GUI:ListView_removeBackGroundImage(widget) end;

---列表容器加载子节点
---* widget    容器对象
---* value    子节点对象（末尾加载）
---@param widget    userdata
---@param value    userdata
function GUI:ListView_pushBackCustomItem(widget, value) end;

---列表容器加载子节点（序列号）
---* widget    容器对象
---* value    子节点对象
---* value2    序列号（index = 1）
---@param widget    userdata
---@param value    userdata
---@param value2    number
function GUI:ListView_insertCustomItem(widget, value, value2) end;

---列表容器删除所有子节点
---* widget    容器对象
---@param widget    userdata
function GUI:ListView_removeAllItems(widget) end;

---通过序列号删除列表容器子节点
---* widget    容器对象
---* index    序列号位置
---@param widget    userdata
---@param index    number
function GUI:ListView_removeItemByIndex(widget, index) end;

---列表容器删除子节点
---* widget    容器对象
---* item     子节点对象
---@param widget    userdata
---@param item     userdata
function GUI:ListView_removeChild(widget, item) end;

---跳转到列表容器序列号节点位置
---* widget    容器对象
---* value    序列号位置
---@param widget    userdata
---@param value    number
function GUI:ListView_jumpToItem(widget, value) end;

---某一时间内滑动到列表容器顶部
---* widget    容器对象
---* time     时间
---* boolvalue  滑动速度是否减弱
---@param widget    userdata
---@param time     number
---@param boolvalue  boolean
function GUI:ListView_scrollToTop(widget,time, boolvalue) end;

---某一时间内滑动到列表容器底部
---* widget    容器对象
---* time     时间
---* boolvalue  滑动速度是否减弱
---@param widget    userdata
---@param time     number
---@param boolvalue  boolean
function GUI:ListView_scrollToBottom(widget,time, boolvalue) end;

---列表容器刷新
---* widget    容器对象
---@param widget    userdata
function GUI:ListView_doLayout(widget) end;

---列表容器可见区域绘制
---* widget    容器对象
---@param widget    userdata
function GUI:ListView_paintItems(widget) end;

---列表容器可见区域自动绘制
---* widget    容器对象
---@param widget    userdata
function GUI:ListView_autoPaintItems(widget) end;

---翻页容器加载子页面
---* widget      容器对象
---* value       子页面对象
---@param widget      userdata
---@param value       userdata
function GUI:PageView_addPage(widget, value) end;

---翻页容器加监听事件
---* widget      容器对象
---* eventCB     监听事件函数
---@param widget      userdata
---@param eventCB     function
function GUI:PageView_addOnEvent(widget, eventCB) end;

---加载容器所有列表数据
---* widget      tableView对象
---@param widget      userdata
function GUI:TableView_reloadData(widget) end;

---添加容器鼠标滚动事件
---* widget      tableView对象
---* func		 鼠标滚动回调函数传参{widget = widget, x = 滚动坐标X, y = 滚动坐标Y} [不填采用官方默认添加滚动] 
---@param widget      userdata
---@param func		 function
function GUI:TableView_addMouseScrollEvent(widget, func) end;

---添加子节点到旋转容器对应下标item
---* widget      旋转容器对象
---* value       控件对象
---* index       对应下标
---@param widget      userdata
---@param value       userdata
---@param index       number
function GUI:RotateView_addChild(widget, value, index) end;

---界面弹窗特效1
---* widget    控件对象
---* timelineCB  回调函数
---@param widget    userdata
---@param timelineCB  function
function GUI:Timeline_Window1(widget, timelineCB) end;

---界面弹窗特效2
---* widget    控件对象
---* timelineCB  回调函数
---@param widget    userdata
---@param timelineCB  function
function GUI:Timeline_Window2(widget, timelineCB) end;

---界面弹窗特效3
---* widget    控件对象
---* timelineCB  回调函数
---@param widget    userdata
---@param timelineCB  function
function GUI:Timeline_Window3(widget, timelineCB) end;

---界面弹窗特效4
---* widget    控件对象
---* timelineCB  回调函数
---@param widget    userdata
---@param timelineCB  function
function GUI:Timeline_Window4(widget, timelineCB) end;

---界面弹窗特效5
---* widget    控件对象
---* timelineCB  回调函数
---@param widget    userdata
---@param timelineCB  function
function GUI:Timeline_Window5(widget, timelineCB) end;

---界面弹窗特效6
---* widget    控件对象
---* timelineCB  回调函数
---@param widget    userdata
---@param timelineCB  function
function GUI:Timeline_Window6(widget, timelineCB) end;

---设置动画标记
---* action    控件对象
---* tag     标记值
---@param action    userdata
---@param tag     number
function GUI:Timeline_SetTag(action, tag) end;

---停止所有动画
---* widget    控件对象
---@param widget    userdata
function GUI:Timeline_StopAll(widget) end;

---通过标记停止动画
---* widget    控件对象
---* tag     标记值
---@param widget    userdata
---@param tag     number
function GUI:Timeline_StopByTag(widget, tag) end;

---动画淡出效果
---* widget    控件对象
---* time     时间
---* timelineCB  回调函数
---@param widget    userdata
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_FadeOut(widget, time, timelineCB) end;

---动画淡入效果
---* widget    控件对象
---* time     时间
---* timelineCB  回调函数
---@param widget    userdata
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_FadeIn(widget, time, timelineCB) end;

---动画修改透明度到某个值
---* widget    控件对象
---* value    透明度(0-255)
---* time     时间
---* timelineCB  回调函数
---@param widget    userdata
---@param value    number
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_FadeTo(widget, value, time, timelineCB) end;

---动画放大缩小
---* widget    控件对象
---* value    缩放比例(0-100)
---* time     时间
---* timelineCB  回调函数
---@param widget    userdata
---@param value    number
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_ScaleTo(widget, value, time, timelineCB) end;

---动画放大缩小（当前大小的某个比例）
---* widget    控件对象
---* value    缩放比例(0-100)
---* time     时间
---* timelineCB  回调函数
---@param widget    userdata
---@param value    number
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_ScaleBy(widget, value, time, timelineCB) end;

---动画旋转
---* widget    控件对象
---* value    旋转角度(0-360)
---* time     时间
---* timelineCB  回调函数
---@param widget    userdata
---@param value    number
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_RotateTo(widget, value, time, timelineCB) end;

---设置渐变字文本内容
---* object   渐变字文本对象
---* txt 文本内容
---@param object  userdata
---@param txt string
function GUI:GradientColorText_setString(object, txt) end;

---设置渐变字文本渐变颜色
---* object   渐变字文本对象
---* color1 渐变颜色1
---* color2 渐变颜色2
---@param object  userdata
---@param color1 string
---@param color2 string
function GUI:GradientColorText_setColor(object, color1,color2) end;

---动画旋转（从原来角度 旋转到 某个角度）
---* widget    控件对象
---* value    旋转角度(0-360)
---* time     时间
---* timelineCB  回调函数
---@param widget    userdata
---@param value    number
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_RotateBy(widget, value, time, timelineCB) end;

---动画移动（绝对位置）
---* widget    控件对象
---* value    {x = 0, y = 0}
---* time     时间
---* timelineCB  回调函数
---@param widget    userdata
---@param value    table
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_MoveTo(widget, value, time, timelineCB) end;

---动画移动（相对位置）
---* widget    控件对象
---* value    {x = 0, y = 0}
---* time     时间
---* timelineCB  回调函数
---@param widget    userdata
---@param value    table
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_MoveTo(widget, value, time, timelineCB) end;

---动画闪烁
---* widget    控件对象
---* value    闪烁次数
---* time     时间
---* timelineCB  回调函数
---@param widget    userdata
---@param value    number
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_Blink(widget, value, time, timelineCB) end;

---动画震动
---* widget    控件对象
---* time     时间
---* x      X轴震动像素
---* y      Y轴震动像素
---* timelineCB  回调函数
---@param widget    userdata
---@param time     number
---@param x      number
---@param y      number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_Shake(widget, time, x, y, timelineCB) end;

---动画疯狂抖动
---* widget    控件对象
---* time     时间
---* angle    抖动幅度（0-360）
---@param widget    userdata
---@param time     number
---@param angle    number
function GUI:Timeline_Waggle(widget, time, angle) end;

---动画延迟播放
---* widget    控件对象
---* time     延迟时间
---* timelineCB  回调函数
---@param widget    userdata
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_DelayTime(widget, time, timelineCB) end;

---动画回调方法
---* widget    控件对象
---* time     延迟时间
---* timelineCB  回调函数
---@param widget    userdata
---@param time     number
---@param timelineCB  function
---@return userdata "返回:Action"
function GUI:Timeline_CallFunc(widget, time, timelineCB) end;

---动画延迟显示
---* widget    控件对象
---* time     延迟时间
---@param widget    userdata
---@param time     number
---@return userdata "返回:Action"
function GUI:Timeline_Show(widget, time) end;

---动画延迟隐藏
---* widget    控件对象
---* time     延迟时间
---@param widget    userdata
---@param time     number
---@return userdata "返回:Action"
function GUI:Timeline_Hide(widget, time) end;

---缓动动画（由慢到快）
---* widget    对象
---* value    目标坐标位置
---* time     动作时间
---* callback   动作执行完的回调
---@param widget    userdata
---@param value    table
---@param time     number
---@param callback   function
---@return userdata "返回:Action"
function GUI:Timeline_EaseSineIn_MoveTo(widget, value, time, callback) end;

---通过标记获取动作内容
---* widget      控件对象
---* tag         动作标记
---@param widget      userdata
---@param tag         number
---@return userdata "返回:action"
function GUI:getActionByTag(widget, tag) end;

---缓动动画（由快到慢）
---* widget    对象
---* value    目标坐标位置
---* time     动作时间
---* callback   动作执行完的回调
---@param widget    userdata
---@param value    table
---@param time     number
---@param callback   function
---@return userdata "返回:Action"
function GUI:Timeline_EaseSineOut_MoveTo(widget, value, time, callback) end;

---数字滚动动画
---* widget    对象 [ 仅限Button、Text控件、TextAtlas控件]
---* cur     当前数值
---* target    目标数值
---* interval   变动间隔（秒）
---@param widget    userdata
---@param cur     number
---@param target    number
---@param interval   number
function GUI:Timeline_DigitChange(widget, cur, target, interval) end;

---移动动作
---* time        时间
---* x           位置 横坐标
---* y           位置 纵坐标
---@param time        number
---@param x           number
---@param y           number
function GUI:ActionMoveTo(time, x, y) end;

---移动动作（相对位置）
---* time        时间
---* x           位置 横坐标
---* y           位置 纵坐标
---@param time        number
---@param x           number
---@param y           number
function GUI:ActionMoveBy(time, x, y) end;

---缩放动作
---* time        时间
---* ratio       缩放比例（百分比）
---@param time        number
---@param ratio       number
function GUI:ActionScaleTo(time, ratio, ...) end;

---缩放动作（原有基础上缩放）
---* time        时间
---* ratio       缩放比例（百分比）
---@param time        number
---@param ratio       number
function GUI:ActionScaleBy(time, ratio, ...) end;

---旋转动作
---* time        时间
---* angle       旋转角度
---@param time        number
---@param angle       number
function GUI:ActionRotateTo(time, angle) end;

---旋转动作（原有基础上旋转）
---* time        时间
---* angle       旋转角度
---@param time        number
---@param angle       number
function GUI:ActionRotateBy(time, angle) end;

---淡入动作
---* time        时间
---@param time        number
function GUI:ActionFadeIn(time) end;

---淡出动作
---* time        时间
---@param time        number
function GUI:ActionFadeOut(time) end;

---闪烁动作
---* time        时间
---* num         闪烁次数
---@param time        number
---@param num         number
function GUI:ActionBlink(time, num) end;

---动画回调函数
---* callback        回调函数
---@param callback        function
function GUI:CallFunc(callback) end;

---动作延迟
---* time    延迟时间
---@param time    number
function GUI:DelayTime(time) end;

---播放动作
---* widget      控件对象
---* value       动作内容
---@param widget      userdata
---@param value       userdata
function GUI:runAction(widget, value) end;

---停止所有动作
---* widget        控件对象
---@param widget        userdata
function GUI:stopAllActions(widget) end;

---通过标记停止动作
---* widget      控件对象
---* tag         动作标记
---@param widget      userdata
---@param tag         number
function GUI:stopActionByTag(widget, tag) end;

---动作显示
function GUI:ActionShow() end;

---动作隐藏
function GUI:ActionHide() end;

---移除自身
function GUI:ActionRemoveSelf() end;

---播放顺序
---* action      动作对象
---@param action      userdata
---@return userdata "返回:Action"
function GUI:ActionSequence(action, ...) end;

---多个动作同时播放
---* action      动作对象
---@param action      userdata
---@return userdata "返回:Action"
function GUI:ActionSpawn(action, ...) end;

---循环播放
---* action      动作对象
---* time        时间
---@param action      userdata
---@param time        number
---@return userdata "返回:Action"
function GUI:ActionRepeat(action, time) end;

---一直循环播放
---* action      动作对象（一直循环）
---@param action      userdata
---@return userdata "返回:Action"
function GUI:ActionRepeatForever(action) end;

---复合动作（加速度向右，反方向缓慢移动）
---* action      动作对象
---@param action      userdata
---@return userdata "返回:Action"
function GUI:ActionEaseBackIn(action) end;

---复合动作（快速移动到结束，然后缓慢返回到结束）
---* action      动作对象
---@param action      userdata
---@return userdata "返回:Action"
function GUI:ActionEaseBackOut(action) end;

---指数缓冲动作（缓慢开始, 加速结束）
---* action      动作对象
---@param action      userdata
---@return userdata "返回:Action"
function GUI:ActionEaseExponentialIn(action) end;

---指数缓冲动作（加速开始, 缓慢结束）
---* action      动作对象
---@param action      userdata
---@return userdata "返回:Action"
function GUI:ActionEaseExponentialOut(action) end;

---指数缓冲动作（动作缓慢开始和终止）
---* action      动作对象
---@param action      userdata
---@return userdata "返回:Action"
function GUI:ActionEaseExponentialInOut(action) end;

---通过对象关闭界面
---* widget   界面对象
---@param widget  userdata
function GUI:Win_Close(widget) end;

---通过ID关闭界面
---* ID   界面ID
---@param ID  string
function GUI:Win_CloseByID(ID) end;

---通过NPCID关闭界面
---* NPCID   NPCID
---@param NPCID  number
function GUI:Win_CloseByNPCID(NPCID) end;

---通过键盘的Esc键关闭界面
---* widget   界面对象
---* value 石否关闭
---@param widget  userdata
---@param value boolean
function GUI:Win_SetESCClose(widget, value) end;

---关闭所有界面
function GUI:Win_CloseAll() end;

---判断对象是否为空
---* widget      对象
---@param widget      userdata
---@return boolean "返回:true/false"
function GUI:Win_IsNull(widget) end;

---判断对象是否不为空
---* widget      对象
---@param widget      userdata
---@return boolean "返回:true/false"
function GUI:Win_IsNotNull(widget) end;

---禁用文本特效
---* widget    对象
---* value    特效类型：<br>0：正常<br> 1：描边<br>2：阴影<br>3：发光
---@param widget    userdata
---@param value    number
function GUI:Text_disableEffect(widget, value) end;

---禁用文本普通特效
---* widget    对象
---@param widget    userdata
function GUI:Text_disableNormal(widget) end;

---禁用文本描边特效
---* widget    对象
---@param widget    userdata
function GUI:Text_disableOutLine(widget) end;

---禁用文本阴影特效
---* widget    对象
---@param widget    userdata
function GUI:Text_disableShadow(widget) end;

---禁用文本发光特效
---* widget    对象
---@param widget    userdata
function GUI:Text_disableGlow(widget) end;

---添加自定义富文本cell
---* widget      控件对象
---* elements    [RichTextCombineCell] 单个元素控件对象 或 控件对象table 
---@param widget      userdata
---@param elements    userdata
function GUI:RichTextCombine_pushBackElements(widget, elements) end;

---添加cell完毕格式化富文本
---* widget      控件对象
---@param widget      userdata
function GUI:RichTextCombine_format(widget) end;

---添加富文本url点击触发事件
---* widget      控件对象
---* handle      触发函数 (param1: 富文本控件, param2: string 文本传递内容)
---@param widget      userdata
---@param handle      function
function GUI:RichText_setOpenUrlEvent(widget, handle) end;

---调用GUILayout/Item.lua中的函数
---* widget      物品框对象
---* funcname    GUILayout/Item.lua中的函数名字
---* ...         可变参数
---@param widget      userdata
---@param funcname    string
---@param ...         any
function GUI:ItemShow_OnRunFunc(widget, funcname, ...) end;

---清空对应ID放置框的传入数据
---* widget      物品放入框控件对象
---* boxindex    放置框 唯一ID
---@param widget      userdata
---@param boxindex    number
function GUI:ItemBox_RemoveBoxData(widget, boxindex) end;

---更新对应ID放置框的物品数据
---* widget      物品放入框控件对象
---* boxindex    放置框 唯一ID
---* itemData    填充指定的ItemData数据<br>
---@param widget      userdata
---@param boxindex    number
---@param itemData    table
function GUI:ItemBox_UpdateBoxData(widget, boxindex,itemData) end;

---关闭输入框输入
---* widget      输入框对象
---@param widget      userdata
function GUI:TextInput_closeInput(widget) end;

---特效播放
---* widget      特效对象
---* act         0 待机<br>1 走<br>2 攻击<br>3 施法 <br>4 死亡<br>5 跑步
---* dir         方向
---* isLoop      是否循环播放
---* speed       播放速度
---@param widget      userdata
---@param act         number
---@param dir         number
---@param isLoop      boolean
---@param speed       number
function GUI:Effect_play(widget, act, dir, isLoop, speed, isSequence) end;

---特效停止
---* widget      特效对象
---* frameIndex  第几帧
---* act         0 待机<br>1 走<br>2 攻击<br>3 施法 <br>4 死亡<br>5 跑步
---* dir         方向
---@param widget      userdata
---@param frameIndex  number
---@param act         number
---@param dir         number
function GUI:Effect_stop(widget, frameIndex, act, dir) end;

---特效播放完成事件
---* widget      特效对象
---* value       播放完成回调函数
---@param widget      userdata
---@param value       function
function GUI:Effect_addOnCompleteEvent(widget, value) end;

---刷新展示QuickCell
---* widget      QuickCell对象
---@param widget      userdata
function GUI:QuickCell_Refresh(widget) end;

---强制退出/ 清理内容QuickCell
---* widget      QuickCell对象
---@param widget      userdata
function GUI:QuickCell_Exit(widget) end;

---加载UI文件
---* parent   父节点对象
---* filename  文件路径
---* callback    回调函数 
---@param parent   userdata
---@param filename  string
---@param callback    function 
function GUI:LoadExport(parent, filename,callback) end;

---对应控件的节点坐标转换为世界坐标
---* widget    控件对象
---* x      节点坐标X
---* y      节点坐标Y
---@param widget    userdata
---@param x      number
---@param y      number
---@return table "返回:世界坐标"
function GUI:convertToWorldSpace(widget, x, y) end;

---世界坐标转换为对应控件的节点坐标
---* widget    控件对象
---* x      世界坐标X
---* y      世界坐标Y
---@param widget    userdata
---@param x      number
---@param y      number
---@return table "返回:对应控件的节点坐标"
function GUI:convertToNodeSpace(widget, x, y) end;

---加载子控件
---* widget    父控件对象
---* child    子控件对象)
---@param widget    userdata
---@param child    userdata
function GUI:addChild(widget, child) end;

---移除传入控件的所有子节点
---* widget    控件对象
---@param widget    userdata
function GUI:removeAllChildren(widget) end;

---将传入控件从父节点上移除
---* widget    控件对象
---@param widget    userdata
function GUI:removeFromParent(widget) end;

---通过名字删除传入控件的对应子节点
---* widget    控件对象
---* name     控件名字
---@param widget    userdata
---@param name     string
function GUI:removeChildByName(widget, name) end;

---开启定时器
---* widget    控件对象
---* callback   回调函数
---* delay    时间间隔
---@param widget    userdata
---@param callback   function
---@param delay    number
function GUI:schedule(widget, callback, delay) end;

---停止定时器
---* widget    控件对象
---@param widget    userdata
function GUI:unSchedule(widget) end;

---显示文本Tips
---* tips     显示文本
---* worldPos   世界坐标
---* anchorPoint 锚点
---@param tips     string
---@param worldPos   table
---@param anchorPoint table
function GUI:ShowWorldTips(tips, worldPos, anchorPoint) end;

---屏蔽自动修复坐标为整数
function GUI:DisableFixPosition() end;

---关闭文本Tips
function GUI:HideWorldTips() end;

---自适应布局
---* pNode     控件对象
---* param   布局参数
---@param pNode     userdata
---@param param   table 
---@return table "返回:{width = width, height = height}"
function GUI:UserUILayout(pNode, param) end;

---打开界面
---* filename      界面文件名, 目录默认GUILayout下
---@param filename      string
function GUI:Win_Open(filename) end;

---视频播放器添加监听
---* widget      播放器对象
---* eventCB     回调函数
---@param widget      userdata
---@param eventCB     function
function GUI:VideoPlayer_addEventListener(widget, eventCB) end;

---设置当前选中的背包页
---* param1      页签
---@param param1      number
function SL:Set_BAG_PAGE_CUR(param1) end;

---切换聊天频道接收状态
---* param1      聊天频道
---* param2     接收状态 [不填默认切换相反状态]
---@param param1      number
---@param param2     boolean
function SL:Set_CHAT_CHANNEL_RECEIVIND(param1,param2) end;

---设置当前邮件ID
---* param1      邮件ID
---@param param1      number
function SL:Set_MAIL_CURRENT_ID(param1) end;

---当前聊天频道
---* param1      聊天频道
---@param param1      number
function SL:Set_CUR_CHAT_CHANNEL(param1) end;

---设置捡物品数据
---* param1      设置ID
---* param2     设置值
---@param param1      number
---@param param2     table
function SL:Set_SETTING_PICK_VALUE(param1,param2) end;

---设置的数据
---* param1      设置ID
---* param2     设置值
---@param param1      number
---@param param2     table
function SL:Set_SETTING_VALUE(param1,param2) end;

---设置捡物品组数据
---* param1      设置ID
---* param2     设置值
---@param param1      number
---@param param2     table
function SL:Set_SETTING_PICK_GROUP_VALUE(param1,param2) end;

---设置排序相关数据
---* param1      设置ID
---* param2     设置值
---@param param1      number
---@param param2     table
function SL:Set_SETTING_RANK_DATA(param1,param2) end;

---设置boss提示类型
---* param1      设置值
---@param param1      table
function SL:Set_SETTING_BOSS_REMIND_TYPE(param1) end;

---设置boss提示值
---* param1      提示值
---@param param1      string
function SL:Set_SETTING_BOSS_REMIND_VALUE(param1) end;

---角色面板时装显示开关
---* param1      开关
---@param param1      boolean
function SL:Set_PLAYER_SUPEREQUIP_SHOW(param1) end;

---英雄面板时装显示开关
---* param1      开关
---@param param1      boolean
function SL:Set_HERO_SUPEREQUIP_SHOW(param1) end;

---设置技能快捷键
---* param1      技能ID
---* param2      0~16
---@param param1      number
---@param param2      number
function SL:Set_SKILL_KEY(param1,param2) end;

---英雄设置技能快捷键
---* param1      技能ID
---* param2      0~16
---@param param1      number
---@param param2      number
function SL:Set_H_SKILL_KEY(param1,param2) end;

---是否点击英雄守护按钮
---* param1      true/false
---@param param1      boolean
function SL:Set_HERO_GUARD_ISCLICK(param1) end;

---设置英雄激活的状态列表
---* param1      状态列表
---@param param1      table
function SL:Set_HERO_ACTIVES_STATES(param1) end;

---合成打开的ID
---* param1      合成表id
---@param param1      number
function SL:Set_COMPOUND_OPEN_ID(param1) end;

---选择目标ID
---* param1      目标ID
---@param param1      number
function SL:Set_SELECT_TARGET_ID(param1) end;

---PC锁定攻击状态
---* param1      锁定
---@param param1      boolean
function SL:Set_ATTACK_STATE(param1) end;

---功能菜单参数设置
---* param1      table 参数数据
---@param param1      boolean
function SL:Set_FUNCDOCK_PARAM(param1) end;

---设置剪贴板文本
---* param1      文本内容
---@param param1      string
function SL:Set_CLIPBOARD_TEXT(param1) end;

---设置 自动拾取-掉落物-飞向的世界坐标
---* param1      x坐标
---* param2      y坐标
---@param param1      number
---@param param2      number
function SL:Set_DROPITEM_FLY_WORLD_POSITION(param1,param2) end;

---设置快捷栏个数
---* param1      快捷栏个数
---@param param1      number
function SL:Set_QUICK_USE_NUM(param1) end;

---特定状况引导事件开始通知
---* param1      脚本引导父节点ID
---* param2      是否需要刷新位置
---@param param1      number
---@param param2      boolean
function SL:Set_GUIDE_EVENT_BEGAN(param1,param2) end;

---特定状况引导事件结束通知
---* param1      脚本引导父节点ID
---@param param1      number
function SL:Set_GUIDE_EVENT_END(param1) end;

---设置人物内功技能开关
---* param1      技能ID
---* param2      技能类型[2 = 人物怒内功技能 4 = 人物静内功技能]
---* param3      开关状态 0 开启 1关闭
---@param param1      number
---@param param2      number
---@param param3      number
function SL:Set_INTERNAL_SKILL_ONOFF(param1,param2,param3) end;

---设置英雄内功技能开关
---* param1      技能ID
---* param2      技能类型 [3 = 英雄怒内功技能5 = 英雄静内功技能]
---* param3      开关状态 0 开启 1关闭
---@param param1      number
---@param param2      number
---@param param3      number
function SL:Set_H_INTERNAL_SKILL_ONOFF(param1,param2,param3) end;

---修改PC端屏幕分辨率
---* param1      宽
---* param2      高
---@param param1      number
---@param param2      number
function SL:Set_WIN_DEVICE_SIZE(param1,param2) end;

---摆摊设置选中的物品唯一ID
---* param1      物品唯一ID
---@param param1      number
function SL:Set_STALL_SELECT_ID(param1) end;

---填充PC聊天输入框内容
---* LUA_EVENT_PC_FILL_CHAT_INPUT      填充PC聊天输入框内容
---* param1      文本内容
---@param LUA_EVENT_PC_FILL_CHAT_INPUT      string
---@param param1      string
function SL:onLUAEvent(LUA_EVENT_PC_FILL_CHAT_INPUT,param1) end;

---设置允许组队状态
---* param1      true/false
---@param param1      boolean
function SL:Set_TEAM_STATUS_PERMIT(param1) end;

---设置允许添加状态
---* param1      true/false
---@param param1      boolean
function SL:Set_ADD_STATUS_PERMIT(param1) end;

---设置允许交易状态
---* param1      true/false
---@param param1      boolean
function SL:Set_DEAL_STATUS_PERMIT(param1) end;

---设置允许显示状态
---* param1      true/false
---@param param1      boolean
function SL:Set_SHOW_STATUS_PERMIT(param1) end;

---设置转向方向
---* param1      方向 0 ~ 8
---@param param1      number
function SL:Set_TURN_DIR(param1) end;

---设置PC持续攻击目标ID
---* param1      actorID
---@param param1      number
function SL:Set_SELECT_SHIFT_ATTACK_ID(param1) end;

---设置是否接收该分类掉落信息
---* param1      掉落分组id
---* param2      是否接收
---@param param1      number
---@param param2      boolean
function SL:Set_CHAT_DROP_TYPE_IS_RECEIVE(param1,param2) end;

---添加自动使用弹窗
---* param1      类型 （1: 人物 2: 英雄）
---* param2      装备位
---* param3      makeIndex
---@param param1      number
---@param param2      number
---@param param3      number
function SL:Set_AUTOUSE_MAKEINDEX_BY_POS(param1,param2,param3) end;

---打印所有能获取的元变量
function SL:PrintAllMetaValue() end;

---打印所有元变量Key
function SL:PrintMetaKey() end;

---屏幕宽
---@return number "返回:屏幕的宽度"
function SL:Get_SCREEN_WIDTH() end;

---屏幕高
---@return number "返回:屏幕的高度"
function SL:Get_SCREEN_HEIGHT() end;

---是否刘海屏
---@return boolean "返回:是否刘海屏"
function SL:Get_NOTCH_PHONE_INFO() end;

---安卓平台
---@return boolean "返回:true/false"
function SL:Get_PLATFORM_ANDROID() end;

---iOS平台
---@return boolean "返回:true/false"
function SL:Get_PLATFORM_IOS() end;

---Windows平台
---@return boolean "返回:ture/false"
function SL:Get_PLATFORM_WINDOWS() end;

---手机平台(包含安卓和iOS)
---@return boolean "返回:true/false"
function SL:Get_PLATFORM_MOBILE() end;

---是否PC操作模式
---@return boolean "返回:true/false"
function SL:Get_IS_PC_OPER_MODE() end;

---操作模式(PC=1, 手机=2)
---@return number "返回:(PC=1, 手机=2)"
function SL:Get_CURRENT_OPERMODE() end;

---游戏ID
---@return string "返回:游戏ID"
function SL:Get_GAME_ID() end;

---渠道ID
---@return string "返回:渠道ID"
function SL:Get_CHANNEL_ID() end;

---APK包名
---@return string "返回:包名"
function SL:Get_PACKAGE_NAME() end;

---APK版本名
---@return string "返回:版本名"
function SL:Get_VERSION_NAME() end;

---APK版本号
---@return string "返回:版本号"
function SL:Get_VERSION_CODE() end;

---原始/本地客户端版本号
---@return string "返回:版本号"
function SL:Get_LOCAL_RES_VERSION() end;

---热更客户端版本号
---@return string "返回:版本号"
function SL:Get_REMOTE_RES_VERSION() end;

---GM资源版本号
---@return string "返回:版本号"
function SL:Get_REMOTE_GM_RES_VERSION() end;

---PC唯一设备ID
---@return string "返回:设备ID"
function SL:Get_DEVICE_UNIQUE_ID() end;

---推广员ID
---@return string "返回:推广员ID"
function SL:Get_PROMOTE_ID() end;

---游戏帧率
---@return number "返回:游戏帧率"
function SL:Get_FPS() end;

---网络类型
---@return number "返回:<br>0 : wifi<br>1 : 蜂窝<br>-1: 未识别"
function SL:Get_NET_TYPE() end;

---手机电量
---@return number "返回:（0~100）"
function SL:Get_BATTERY() end;

---获取cfg_game_data配置
---* param      表中的key值
---@param param      string
---@return number "返回:cfg_game_data配置"
function SL:Get_GAME_DATA(param) end;

---是否是SDK登录
---@return boolean "返回:是否是SDK登录 true/false"
function SL:Get_IS_SDK_LOGIN() end;

---是否是996盒子登录
---@return boolean "返回:是否是996盒子登录 true/false"
function SL:Get_BOX996_LOGIN() end;

---是否是996云真机
---@return boolean "返回:是否是996云真机 true/false"
function SL:Get_CLOUD996_DEVICE() end;

---获取易盾的反外挂数据
---@return number "返回:反外挂数据"
function SL:Get_YIDUN_DATA() end;

---PC端Y轴适配
---@return number "返回:PC端Y轴适配"
function SL:Get_PC_POS_Y() end;

---获取该组界面配置信息
---@return number "返回:该组界面配置信息"
function SL:Get_SCREEN_WIDTH() end;

---PC端 是否开启NP反外挂
---@return boolean "返回:PC端 是否开启NP反外挂 true/false"
function SL:Get_PC_NP_STATUS() end;

---获取已添加的自动使用弹窗物品唯一ID
---* playerType      类型 （1: 人物 2: 英雄）
---* equipPos      装备位
---@param playerType      number
---@param equipPos      number
---@return number "返回:已添加的自动使用弹窗物品唯一ID"
function SL:Get_AUTOUSE_MAKEINDEX_BY_POS(playerType, equipPos) end;

---服务器ID
---@return string "返回:服务器ID"
function SL:Get_SERVER_ID() end;

---服务器名字
---@return string "返回:服务器名字"
function SL:Get_SERVER_NAME() end;

---主服务器ID
---@return string "返回:主服务器ID"
function SL:Get_MAIN_SERVER_ID() end;

---开服时间戳
---@return number "返回:开服时间戳"
function SL:Get_OPEN_SERVER_TIME() end;

---开服天数
---@return number "返回:开服天数"
function SL:Get_OPEN_SERVER_DAY() end;

---合服次数
---@return number "返回:合服次数"
function SL:Get_MERGE_SERVER_COUNT() end;

---资源版本
---@return string "返回:资源版本"
function SL:Get_RES_VERSION() end;

---账号ID
---@return string "返回:账号ID"
function SL:Get_UID() end;

---登录角色信息
---@return table "返回:登录角色信息"
function SL:Get_LOGIN_DATA() end;

---可恢复角色信息
---@return table "返回:可恢复角色信息"
function SL:Get_RESTORE_ROLES() end;

---服务端下发的变量值
---* param      服务端变量名(可在M2红点中控制下发给客户端的变量)
---@param param      string
---@return string "返回:服务端下发的变量值"
function SL:Get_SERVER_VALUE(param) end;

---当前服务器时间
---@return number "返回:当前服务器时间"
function SL:Get_SERVER_TIME() end;

---合服时间戳
---@return number "返回:合服时间戳"
function SL:Get_MERGE_SERVER_TIME() end;

---合服天数
---@return number "返回:合服天数"
function SL:Get_MERGE_SERVER_DAY() end;

---是否处于跨服
---@return boolean "返回:是否处于跨服 true/false"
function SL:Get_KFSTATE() end;

---获取当前对话NPC的ID
---@return number "返回:CURRENT_TALK_NPC_ID"
function SL:Get_CURRENT_TALK_NPC_ID() end;

---获取当前对话NPC的Index
---@return number "返回:当前对话NPC的Index"
function SL:Get_CURRENT_TALK_NPC_TYPEINDEX() end;

---获取当前打开的NPC面板(txt面板)
---@return userdata "返回:当前打开的NPC面板(txt面板)"
function SL:Get_CURRENT_TALK_NPC_LAYER() end;

---M2是否禁止说话
---* param      禁止时是否需要提示
---@param param      boolean
---@return boolean "返回:M2是否禁止说话 true/false"
function SL:Get_M2_FORBID_SAY(param) end;

---服务器开关
---* param      服务器开关选项
---@param param      string
---@return number "返回:服务器开关"
function SL:Get_SERVER_OPTION(param) end;

---地图ID
---@return string "返回:地图ID"
function SL:Get_MAP_ID() end;

---地图名字
---@return string "返回:地图名字"
function SL:Get_MAP_NAME() end;

---地图数据ID
---@return string "返回:地图数据ID"
function SL:Get_MAP_DATA_ID() end;

---小地图ID
---@return number "返回:小地图ID"
function SL:Get_MINIMAP_ID() end;

---是否是安全区域
---@return boolean "返回:是否是安全区域"
function SL:Get_IN_SAFE_AREA() end;

---是否禁止职业和等级
---@return boolean "返回:是否禁止职业和等级"
function SL:Get_MAP_FORBID_LEVEL_AND_JOB() end;

---是否禁止说话
---@return boolean "返回:是否禁止说话"
function SL:Get_MAP_FORBID_SAY() end;

---是否血量显示百分比
---@return boolean "返回:是否血量显示百分比 true/false"
function SL:Get_MAP_SHOW_HPPER() end;

---是否禁止查看
---@return boolean "返回:是否禁止查看 true/false"
function SL:Get_MAP_FORBID_LOOK() end;

---是否禁止释放某技能
---@return boolean "返回:是否禁止释放某技能 true/false"
function SL:Get_MAP_FORBID_LAUNCH_SKILL() end;

---小地图资源是否有效
---@return boolean "返回:小地图资源是否有效 true/false"
function SL:Get_MINIMAP_ABLE() end;

---地图map文件是否加载(false表示正在下载中)
---@return boolean "返回:地图map文件是否加载(false表示正在下载中)"
function SL:Get_MAP_DATA_LOADED() end;

---地图横向格子数
---@return number "返回:地图横向格子数"
function SL:Get_MAP_ROWS() end;

---地图纵向格子数
---@return number "返回:地图纵向格子数"
function SL:Get_MAP_COLS() end;

---获取小地图文件路径
---@return string "返回:小地图文件路径"
function SL:Get_MINIMAP_FILE() end;

---地图获取宽度像素
---@return number "返回:地图获取宽度像素"
function SL:Get_MAP_SIZE_WIDTH_PIXEL() end;

---地图获取高度像素
---@return number "返回:地图获取高度像素"
function SL:Get_MAP_SIZE_HEIGHT_PIXEL() end;

---获取地图格子是否是阻挡
---* mapX      地图坐标X
---* mapY      地图坐标Y
---@param mapX      number
---@param mapY      number
---@return boolean "返回:获取地图格子是否是阻挡"
function SL:Get_MAP_IS_OBSTACLE(mapX, mapY) end;

---地图计算起点到终点X或者Y 变化最大的差值
---@return number "返回:地图计算起点到终点X或者Y 变化最大的差值"
function SL:Get_MAP_PATH_SIZE() end;

---地图计算路径坐标
---@return table "返回:地图计算路径坐标"
function SL:Get_MAP_PATH_POINTS() end;

---地图获取当前路径坐标index
---@return number "返回:地图获取当前路径坐标index"
function SL:Get_MAP_CURRENT_PATH_INDEX() end;

---地图获取人物坐标
---@return table "返回:人物坐标"
function SL:Get_MAP_PLAYER_POS() end;

---地图获取怪物列表位置等信息
---@return table "返回:怪物列表位置等信息"
function SL:Get_MINIMAP_MONSTERS() end;

---地图获取传送点列表位置等信息
---@return table "返回:传送点列表位置等信息"
function SL:Get_MAP_GET_PORTALS() end;

---获取视野内玩家列表
---@return table "返回:视野内玩家列表"
function SL:Get_FIND_IN_VIEW_PLAYER_LIST() end;

---获取视野内怪物列表
---* param1      是否屏蔽主玩家宠物
---* param2      是否屏蔽网络玩家宠物
---@param param1      boolean
---@param param2      boolean
---@return table "返回:视野内怪物列表"
function SL:Get_FIND_IN_VIEW_MONSTER_LIST(param1,param2) end;

---获取视野内NPC列表
---@return table "返回:获取视野内NPC列表"
function SL:Get_FIND_IN_VIEW_NPC_LIST() end;

---是否在攻城区域
---@return boolean "返回:是否在攻城区域 true/false"
function SL:Get_IN_SIEGE_AREA() end;

---获取目标地图坐标到初始地图坐标的方向
---* srcPos      初始地图坐标
---* destPos      目标地图坐标
---@param srcPos      table
---@param destPos      table
---@return number "返回:朝向 0 ~ 8"
function SL:Get_TARGET_MAPPOS_DIR(srcPos, destPos) end;

---掉落物是否可拾取
---* actorID      掉落物 actorID
---* mainPlayerID      归属ID
---@param actorID      number
---@param mainPlayerID      number
---@return boolean "返回:掉落物是否可拾取 true/false"
function SL:Get_IS_PICKABLE_DROPITEM(actorID, mainPlayerID) end;

---PC 按坐标选中actor
---* posx      世界坐标x
---* posy      世界坐标y
---@param posx      number
---@param posy      number
---@return number "返回:actor"
function SL:Get_PICK_ACTORID_BY_POS(posx,posy) end;

---是否开启英雄
---@return boolean "返回:是否开启英雄"
function SL:Get_USEHERO() end;

---是否召唤英雄
---@return boolean "返回:是否召唤英雄 true/false"
function SL:Get_HERO_IS_ALIVE() end;

---是否激活英雄
---@return boolean "返回:是否激活英雄 true/false"
function SL:Get_HERO_IS_ACTIVE() end;

---英雄ID
---@return number "返回:英雄ID"
function SL:Get_HERO_ID() end;

---英雄状态系统能设置的列表
---@return table "返回:英雄状态系统能设置的列表"
function SL:Get_HERO_STATES_SYS_VALUES() end;

---获取英雄激活的状态列表
---@return table "返回:英雄激活的状态列表"
function SL:Get_HERO_ACTIVES_STATES() end;

---获取英雄状态
---@return number "返回:0 攻击 1 跟随 2 休息"
function SL:Get_HERO_STATE() end;

---获取英雄守护状态
---@return boolean "返回:英雄守护状态 true/false"
function SL:Get_HERO_GUARDSTATE() end;

---是否点击守护按钮
---@return boolean "返回:是否点击守护按钮 true/false"
function SL:Get_HERO_GUARD_ISCLICK() end;

---是否有存活的宝宝
---@return boolean "返回:是否有存活的宝宝 true/false"
function SL:Get_PET_ALIVE() end;

---宠物锁定的目标ID
---@return string "返回:宠物锁定的目标ID"
function SL:Get_PET_LOCK_ID() end;

---获取宠物PK模式
---@return number "返回:获取宠物PK模式<br>1：跟随<br>2：战斗<br>3：锁定<br>4：休息"
function SL:Get_PET_PKMODE() end;

---获取货币数量
---* ID      货币id
---@param ID      number
---@return string "返回:货币数量"
function SL:Get_MONEY(ID) end;

---获取货币数量(包括 等价替换道具的数量)
---* id      货币id
---@param id      number
---@return string "返回:货币数量"
function SL:Get_MONEY_ASSOCIATED(id) end;

---获取所有道具信息
---@return table "返回:所有道具信息"
function SL:Get_STD_ITEMS() end;

---根据道具index获取道具信息
---* itemIndex      道具index
---@param itemIndex      number
---@return number "返回:道具信息"
function SL:Get_ITEM_DATA(itemIndex) end;

---根据道具index或者名字获取道具数量
---* itemInfo      道具index或道具名
---@param itemInfo      string
---@return number "返回:道具数量"
function SL:Get_ITEM_COUNT(itemInfo) end;

---根据道具index获取道具名字
---* itemIndex      道具index
---@param itemIndex      number
---@return string "返回:道具名字"
function SL:Get_ITEM_NAME(itemIndex) end;

---根据道具名字获取道具index
---* itemName      道具名字
---@param itemName      string
---@return number "返回:道具index"
function SL:Get_ITEM_INDEX_BY_NAME(itemName) end;

---获取道具名字颜色
---* itemIndex      道具index
---@param itemIndex      number
---@return string "返回:道具名字颜色"
function SL:Get_ITEM_NAME_COLOR(itemIndex) end;

---道具名字颜色,”#FFFFFF”格式
---* itemIndex      道具index
---@param itemIndex      number
---@return string "返回:道具名字颜色"
function SL:Get_ITEM_NAME_COLOR_VALUE(itemIndex) end;

---道具名字颜色ID, 颜色表ID
---* itemIndex      道具index
---@param itemIndex      number
---@return number "返回:道具名字颜色ID, 颜色表ID"
function SL:Get_ITEM_NAME_COLORID(itemIndex) end;

---道具表prompt解析后数据
---@return table "返回:道具表prompt解析后数据"
function SL:Get_ITEM_PROMPT_DATA() end;

---物品是否绑定
---* itemData      物品数据
---@param itemData      table
---@return boolean "返回:物品是否绑定 true/false"
function SL:Get_ITEM_IS_BIND(itemData) end;

---根据MakeIndex获取装备数据
---* param1      makeIndex
---* param2      是否是英雄
---@param param1      number
---@param param2      boolean
---@return table "返回:装备数据"
function SL:Get_EQUIP_DATA_BY_MAKEINDEX(param1, param2) end;

---根据MakeIndex获取仓库数据
---* param1      MakeIndex
---@param param1      number
---@return table "返回:仓库数据"
function SL:Get_STORAGE_DATA_BY_MAKEINDEX(param1) end;

---根据MakeIndex获取快捷栏数据
---* param1      MakeIndex
---@param param1      number
---@return table "返回:快捷栏数据"
function SL:Get_QUICKUSE_DATA_BY_MAKEINDEX(param1) end;

---根据MakeIndex获取查看他人装备数据
---* param1      makeIndex
---@param param1      number
---@return table "返回:他人装备数据"
function SL:Get_LOOKPLAYER_DATA_BY_MAKEINDEX(param1) end;

---获取快捷使用数据
---@return table "返回:快捷使用数据"
function SL:Get_QUICKUSE_DATA() end;

---检查禁止使用物品buff
---* itemIndex      物品index
---@param itemIndex      number
---@return boolean,number "返回:能否使用, buffID"
function SL:Get_CHECK_USE_ITEM_BUFF(itemIndex) end;

---物品能否自动使用
---* itemData      物品数据
---@param itemData      table
---@return boolean "返回:物品能否自动使用 true/false"
function SL:Get_ITEM_CAN_AUTOUSE(itemData) end;

---技能书能否使用
---* itemName      技能书名字
---* isHero      是否英雄
---@param itemName      string
---@param isHero      boolean
---@return boolean "返回:技能书能否使用 true/false"
function SL:Get_SKILLBOOK_CAN_USE(itemName, isHero) end;

---根据MakeIndex获取物品归属
---* makeIndex      MakeIndex
---@param makeIndex      number
---@return number "返回:物品归属"
function SL:Get_ITEM_BELONG_BY_MAKEINDEX(makeIndex) end;

---获取背包物品唯一ID
---* pos      背包位置
---* isHero      是否英雄
---@param pos      number
---@param isHero      boolean
---@return number "返回:背包物品唯一ID"
function SL:Get_BAG_MAKEINDEX_BY_POS(pos,isHero) end;

---物品规则类型枚举
---@return table "返回:物品规则类型枚举"
function SL:Get_ITEM_ARTICLE_ENUM() end;

---道具框默认缩放
---@return number "返回:缩放"
function SL:Get_ITEM_SCALE() end;

---获取背包所有物品数据
---@return table "返回:背包物品数据"
function SL:Get_BAG_DATA() end;

---根据物品唯一id获取物品数据
---* makeindex      唯一id
---@param makeindex      string
---@return table "返回:物品数据"
function SL:Get_ITEM_DATA_BY_MAKEINDEX(makeindex) end;

---是否自动挂机中
---@return boolean "返回:是否自动挂机中 true/false"
function SL:Get_BATTLE_IS_AFK() end;

---开始自动挂机
function SL:Set_BATTLE_AFK_BEGIN() end;

---结束自动挂机
function SL:Set_BATTLE_AFK_END() end;

---是否自动寻路中
---@return boolean "返回:是否自动寻路中 true/false"
function SL:Get_BATTLE_IS_AUTO_MOVE() end;

---开始自动寻路
---* mapID      地图ID
---* mapX      坐标x
---* mapY      坐标y
---* target      0：怪物    1：NPC index: 目标类型index
---* type      寻路类型
---@param mapID      string
---@param mapX      number
---@param mapY      number
---@param target      number
---@param type      number
function SL:Set_BATTLE_MOVE_BEGIN(mapID, mapX, mapY, target, type) end;

---结束自动寻路
function SL:Set_BATTLE_MOVE_END() end;

---是否是自动拾取
---@return boolean "返回:是否自动捡物中 true/false"
function SL:Get_BATTLE_IS_AUTO_PICK() end;

---开始自动捡物
function SL:Set_BATTLE_PICK_BEGIN() end;

---结束自动捡物
function SL:Set_BATTLE_PICK_END() end;

---获取PC持续攻击目标
---@return number "返回:PC持续攻击目标"
function SL:Get_SELECT_SHIFT_ATTACK_ID() end;

---主玩家actorID
---@return string "返回:主玩家actorID"
function SL:Get_USER_ID() end;

---是否是玩家
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:是否是玩家 true/false"
function SL:Get_ACTOR_IS_PLAYER(actorID) end;

---是否是网络玩家
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:是否是网络玩家 true/false"
function SL:Get_ACTOR_IS_NETPLAYER(actorID) end;

---是否是怪物
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:是否是怪物 true/false"
function SL:Get_ACTOR_IS_MONSTER(actorID) end;

---是否是NPC
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:是否是NPC true/false"
function SL:Get_ACTOR_IS_NPC(actorID) end;

---是否是英雄
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:是否是英雄 true/false"
function SL:Get_ACTOR_IS_HERO(actorID) end;

---是否是人形怪
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:是否是人形怪 true/false"
function SL:Get_ACTOR_IS_HUMAN(actorID) end;

---获取actor 名字
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return string "返回:actor 名字"
function SL:Get_ACTOR_NAME(actorID) end;

---获取 actor Hp
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor Hp"
function SL:Get_ACTOR_HP(actorID) end;

---获取actor Max Hp
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor Max Hp"
function SL:Get_ACTOR_MAXHP(actorID) end;

---获取actor Mp
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor Mp"
function SL:Get_ACTOR_MP(actorID) end;

---获取actor Max Mp
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor Max Mp"
function SL:Get_ACTOR_MAXMP(actorID) end;

---获取actor等级
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor等级"
function SL:Get_ACTOR_LEVEL(actorID) end;

---获取actor职业
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor职业"
function SL:Get_ACTOR_JOB_ID(actorID) end;

---获取actor性别
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor性别"
function SL:Get_ACTOR_SEX(actorID) end;

---actor是否死亡
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否死亡 true/false"
function SL:Get_ACTOR_IS_DEATH(actorID) end;

---获取actor归属ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return string "返回:actor归属ID"
function SL:Get_ACTOR_OWNER_ID(actorID) end;

---获取actor归属名字
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return string "返回:actor归属名字"
function SL:Get_ACTOR_OWNER_NAME(actorID) end;

---获取怪物大图标ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:怪物大图标ID"
function SL:Get_ACTOR_BIGICON_ID(actorID) end;

---选中的目标actorID或者怪物归属者
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor性别"
function SL:Get_SELECT_TARGET_ID(actorID) end;

---检查该目标是否可以攻击
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:目标是否可以攻击 true/false"
function SL:Get_TARGET_ATTACK_ENABLE(actorID) end;

---获取actor组队状态
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor组队状态 0：未组队 1：组队中"
function SL:Get_ACTOR_TEAM_STATE(actorID) end;

---获取actor行会ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return string "返回:获取actor行会ID"
function SL:Get_ACTOR_GUILD_ID(actorID) end;

---获取actor行会名字
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return string "返回:actor行会名字"
function SL:Get_ACTOR_GUILD_NAME(actorID) end;

---获取actor的typeIndex
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:typeIndex"
function SL:Get_ACTOR_TYPE_INDEX(actorID) end;

---获取actor方向
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回: actor方向"
function SL:Get_ACTOR_DIR(actorID) end;

---获取actor地图坐标X
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor地图坐标X"
function SL:Get_ACTOR_MAP_X(actorID) end;

---获取actor地图坐标Y
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor地图坐标Y"
function SL:Get_ACTOR_MAP_Y(actorID) end;

---获取actor世界坐标X
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回: actor世界坐标X"
function SL:Get_ACTOR_POSITION_X(actorID) end;

---获取actor世界坐标Y
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor世界坐标Y"
function SL:Get_ACTOR_POSITION_Y(actorID) end;

---获取actor主人ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor主人ID"
function SL:Get_ACTOR_MASTER_ID(actorID) end;

---获取actor是否有主人
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:获取actor是否有主人"
function SL:Get_ACTOR_HAVE_MASTER(actorID) end;

---获取actor阵营ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor阵营ID"
function SL:Get_ACTOR_FACTION(actorID) end;

---获取actor是否在安全区
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否在安全区 true/false"
function SL:Get_ACTOR_IN_SAFE_ZONE(actorID) end;

---获取actor的外观ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor的外观ID"
function SL:Get_ACTOR_APPR_ID(actorID) end;

---获取actor挂接点
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return userdata "返回:actor挂接点"
function SL:Get_ACTOR_MOUNT_NODE(actorID) end;

---检查英雄选中的目标是否能锁定
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:英雄选中的目标是否能锁定 true/false"
function SL:Get_ACTOR_CAN_LOCK_BY_HERO(actorID) end;

---获取actor红名灰名
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor红名灰名 白=0 咖啡=1 红=2 灰=3"
function SL:Get_ACTOR_PKLV(actorID) end;

---获取actor区服ID, 跨服时使用
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor区服ID"
function SL:Get_ACTOR_SERVER_ID(actorID) end;

---actor是否在摆摊
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:是否在摆摊 true/false"
function SL:Get_ACTOR_IS_IN_STALL(actorID) end;

---获取actor摆摊名
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return string "返回:actor摆摊名"
function SL:Get_ACTOR_STALL_NAME(actorID) end;

---获取actor是否是离线状态玩家
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否是离线状态玩家 true/false"
function SL:Get_ACTOR_IS_OFFLINE(actorID) end;

---actor是否是神秘人
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:是否是神秘人 true/false"
function SL:Get_ACTOR_IS_MYSTERY_MAN(actorID) end;

---获取actor是否拥有护身
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否拥有护身 true/false"
function SL:Get_ACTOR_IS_HUSHEN(actorID) end;

---actor是否是主玩家
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否是主玩家 true/false"
function SL:Get_ACTOR_IS_MAINPLAYER(actorID) end;

---获取actor国家ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:获取actor国家ID"
function SL:Get_ACTOR_NATION_ID(actorID) end;

---获取actor坐骑的主驾ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor坐骑的主驾ID"
function SL:Get_ACTOR_HORSE_MASTER_ID(actorID) end;

---获取actor坐骑的副驾ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor坐骑的副驾ID"
function SL:Get_ACTOR_HORSE_COPILOT_ID(actorID) end;

---actor是否是坐骑的副驾
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否是坐骑的副驾 true/false"
function SL:Get_ACTOR_IS_HORSE_COPILOT(actorID) end;

---actor是否是双人坐骑
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否是双人坐骑 true/false"
function SL:Get_ACTOR_IS_DOUBLE_HORSE(actorID) end;

---actor是否是连体坐骑
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否是连体坐骑 true/false"
function SL:Get_ACTOR_IS_BODY_HORSE(actorID) end;

---获取actor的足迹特效ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor的足迹特效ID"
function SL:Get_ACTOR_MOVE_EFFECT(actorID) end;

---获取actor的夫妻ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor的夫妻ID"
function SL:Get_ACTOR_DEAR_ID(actorID) end;

---获取actor的师徒ID
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor的师徒ID"
function SL:Get_ACTOR_MENTOR_ID(actorID) end;

---获取actor是否在附近显示
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否在附近显示 true/false"
function SL:Get_ACTOR_NEAR_SHOW(actorID) end;

---获取actor是否在移动状态
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否在移动状态 true/false"
function SL:Get_ACTOR_IS_MOVE(actorID) end;

---actor是否是骑马状态
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否是骑马状态 true/false"
function SL:Get_ACTOR_IS_HORSEBACK_RADING(actorID) end;

---获取actor(怪物)是否石化状态
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor(怪物)是否石化状态 true/false"
function SL:Get_ACTOR_STOME_MODE(actorID) end;

---获取actor(怪物) race server
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor(怪物) race server"
function SL:Get_ACTOR_RACE_SERVER(actorID) end;

---获取actor(怪物) race img
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return number "返回:actor(怪物) race img"
function SL:Get_ACTOR_RACE_IMG(actorID) end;

---获取actor(怪物)是否不显示名字
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor(怪物)是否不显示名字 true/false"
function SL:Get_ACTOR_HIDE_NAME(actorID) end;

---获取actor(怪物)是否不显示血条
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor(怪物)是否不显示血条 true/false"
function SL:Get_ACTOR_HIDE_HP_BAR(actorID) end;

---获取actor(怪物)国家模式是否可被攻击
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:获取actor(怪物)国家模式是否可被攻击 true/false"
function SL:Get_ACTOR_NATION_ENEMY_PK(actorID) end;

---获取actor的GM自定义数据
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return table "返回:actor的GM自定义数据"
function SL:Get_ACTOR_GM_DATA(actorID) end;

---actor是否出生
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否出生 true/false"
function SL:Get_ACTOR_IS_BORN(actorID) end;

---actor是否钻回洞穴
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return boolean "返回:actor是否钻回洞穴 true/false"
function SL:Get_ACTOR_IS_CAVE(actorID) end;

---actor身上所有buff数据
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---@param actorID      number
---@return table "返回:actor身上所有buff数据"
function SL:Get_ACTOR_BUFF_DATA(actorID) end;

---actor是否有某个buff
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---* buffID      buffid
---@param actorID      number
---@param buffID      number
---@return boolean "返回:actor是否有某个buff true/false"
function SL:Get_ACTOR_HAS_ONE_BUFF(actorID,buffID) end;

---获取actor身上某个buff数据
---* actorID      玩家、怪物、NPC、人形怪等对象ID(对应服务端唯一ID/UserID)
---* buffID      buffid
---@param actorID      number
---@param buffID      number
---@return table "返回:获取actor身上某个buff数据"
function SL:Get_ACTOR_BUFF_DATA_BY_ID(actorID,buffID) end;

---获取聊天表情包
---@return table "返回:聊天表情包"
function SL:Get_CHAT_EMOJI() end;

---获取聊天输入历史记录缓存
---@return table "返回:聊天输入历史记录缓存"
function SL:Get_CHAT_INPUT_CACHE() end;

---获取聊天显示的道具
---@return table "返回:聊天显示的道具"
function SL:Get_CHAT_SHOW_ITEMS() end;

---当前频道是否接受聊天信息
---@return boolean "返回:当前频道是否接受聊天信息 true/false"
function SL:Get_CHAT_CHANNEL_IS_RECEIVE() end;

---是否接收该分类掉落信息
---* param      掉落分类id 1-10
---@param param      number
---@return boolean "返回:是否接收该分类掉落信息 true/false"
function SL:Get_CHAT_DROP_TYPE_IS_RECEIVE(param) end;

---聊天 Tips使用的字体路径
---@return string "返回:聊天 Tips使用的字体路径"
function SL:Get_CHATANDTIPS_USE_FONT() end;

---获取当前聊天频道
---@return number "返回:当前聊天频道"
function SL:Get_CHAT_CUR_CHAT_CHANNEL() end;

---获取聊天目标
---@return table "返回:聊天目标{{name = 玩家名, uid = 玩家ID}, ..}"
function SL:Get_CHAT_TARGETS() end;

---获取当前聊天CD时间
---@return number "返回:当前聊天CD时间"
function SL:Get_CHAT_CUR_CD_TIME() end;

---是否关闭假掉落
---@return boolean "返回:是否关闭假掉落 true/false"
function SL:Get_CHAT_IS_CLOSE_FAKE_DROP() end;

---邮件列表
---@return table "返回:邮件列表"
function SL:Get_MAIL_LIST() end;

---根据邮件ID获取邮件
---* mailID      邮件ID
---@param mailID      number
---@return string "返回:根据邮件ID获取邮件"
function SL:Get_MAIL_BY_ID(mailID) end;

---当前邮件ID
---@return number "返回:当前邮件ID"
function SL:Get_MAIL_BY_ID() end;

---行会成员列表
---@return table "返回:行会成员列表"
function SL:Get_GUILD_MEMBER_LIST() end;

---行会申请列表
---@return table "返回:行会申请列表"
function SL:Get_GUILD_APPLY_LIST() end;

---行会结盟申请列表
---@return table "返回:行会结盟申请列表"
function SL:Get_GUILD_ALLY_APPLY_LIST() end;

---获取世界行会列表
---* page      分页ID
---@param page      number
---@return table "返回:世界行会列表"
function SL:Get_GUILD_WORLD_LIST(page) end;

---获取创建公会消耗信息
---@return table "返回:创建公会消耗信息"
function SL:Get_GUILD_CREATE() end;

---我的行会信息
---@return table "返回:我的行会信息"
function SL:Get_GUILD_INFO() end;

---获取行会职位名称
---* param      职位ID
---@param param      number
---@return string "返回:获取行会职位名称"
function SL:Get_GUILD_OFFICIAL_NAME_BY_RANK(param) end;

---通过uid获取行会成员信息
---* targetID      uid
---@param targetID      number
---@return table "返回:获取行会成员信息"
function SL:Get_GUILD_MEMBER_INFO(targetID) end;

---最大好友人数
---@return number "返回:最大好友人数"
function SL:Get_FRIEND_MAX_COUNT() end;

---根据userID获取好友信息
---* userID      用户ID
---@param userID      number
---@return table "返回:根据userID获取好友信息"
function SL:Get_FRIEND_INFO_BY_UID(userID) end;

---是否是好友
---@return boolean "返回:是否是好友 true/false"
function SL:Get_SOCIAL_IS_FRIEND() end;

---根据userName获取好友信息
---* userName      用户名
---@param userName      string
---@return table "返回:好友信息"
function SL:Get_FRIEND_INFO_BY_NAME(userName) end;

---是否在黑名单
---@return boolean "返回:是否在黑名单 true/false"
function SL:Get_SOCIAL_IS_BLICKLIST() end;

---获取好友列表
---@return table "返回:好友列表"
function SL:Get_FRIEND_LIST() end;

---获取黑名单数据
---@return table "返回:黑名单数据"
function SL:Get_FRIEND_BLACKLIST() end;

---好友申请列表
---@return table "返回:好友申请列表"
function SL:Get_FRIEND_APPLYLIST() end;

---允许添加状态
---@return boolean "返回:允许添加状态 true/false"
function SL:Get_ADD_STATUS_PERMIT() end;

---附近队伍列表
---@return table "返回:附近队伍列表"
function SL:Get_TEAM_NEAR() end;

---队伍成员列表
---@return table "返回:队伍成员列表"
function SL:Get_TEAM_MEMBER_LIST() end;

---当前队伍人数
---@return number "返回:当前队伍人数"
function SL:Get_TEAM_MEMBER_COUNT() end;

---队伍最大人数
---@return number "返回:队伍最大人数"
function SL:Get_TEAM_MEMBER_MAX_COUNT() end;

---是否是队伍成员
---@return boolean "返回:是否是队伍成员 true/false"
function SL:Get_TEAM_IS_MEMBER() end;

---允许组队状态
---@return boolean "返回:允许组队状态 true/false"
function SL:Get_TEAM_STATUS_PERMIT() end;

---入队申请列表
---@return table "返回:入队申请列表"
function SL:Get_TEAM_APPLY() end;

---func dock enum
---@return table "返回:##"
function SL:Get_DOCKTYPE_NENUM() end;

---交易的目标ID
---@return string "返回:交易的目标ID"
function SL:Get_TRADE_TARGET_ID() end;

---交易的目标名字
---@return string "返回:交易的目标名字"
function SL:Get_TRADE_TARGET_NAME() end;

---要交易的玩家信息
---@return table "返回:要交易的玩家信息"
function SL:Get_TRADE_TARGET_DATA() end;

---交易自己锁定状态
---@return boolean "返回:交易自己锁定状态 true/false"
function SL:Get_TRADE_MY_LOCK_STATUS() end;

---交易对方锁定状态
---@return boolean "返回:交易对方锁定状态 true/false"
function SL:Get_TRADE_TARGET_LOCK_STATUS() end;

---根据页签index获取排行榜数据
---* index      页签
---@param index      number
---@return table "返回:排行榜数据"
function SL:Get_RANK_DATA_BY_TYPE(index) end;

---根据任务类型/ID获取任务排序值
---* type      任务类型/ID
---@param type      number
---@return number "返回:任务排序值"
function SL:Get_MISSION_ITEM_ORDER(type) end;

---筛选技能数据
---* param1      技能类型
---* param2      职业
---* param3      是否学习
---* param4      是否不是基础技能
---@param param1      number
---@param param2      number
---@param param3      boolean
---@param param4      boolean
---@return table "返回:筛选技能数据"
function SL:Get_SKILL_INFO_FILTER(param1, param2, param3, param4) end;

---获取技能名字
---* skillID      技能ID
---@param skillID      number
---@return string "返回:获取技能名字"
function SL:Get_SKILL_NAME(skillID) end;

---获取技能图标
---* skillID      技能ID
---@param skillID      number
---@return string "返回:技能图标路径"
function SL:Get_SKILL_ICON_PATH(skillID) end;

---获取矩形技能图标
---* skillID      技能ID
---@param skillID      number
---@return number "返回:屏幕的宽度"
function SL:Get_SKILL_RECT_ICON_PATH(skillID) end;

---是否是开关型技能
---* skillID      技能ID
---@param skillID      number
---@return boolean "返回:是否是开关型技能 true/false"
function SL:Get_SKILL_IS_ONOFF_SKILL(skillID) end;

---技能是否开启
---* skillID      技能ID
---@param skillID      number
---@return boolean "返回:技能是否开启 true/false"
function SL:Get_SKILL_IS_ON_SKILL(skillID) end;

---获取已学技能
---* param1      是否排除普攻
---* param2      是否只获取主动技能
---@param param1      boolean
---@param param2      boolean
---@return table "返回:获取已学技能"
function SL:Get_LEARNED_SKILLS(param1,param2) end;

---是否是主动技能
---* skillID      技能ID
---@param skillID      number
---@return boolean "返回:是否是主动技能"
function SL:Get_SKILL_IS_ACTIVE(skillID) end;

---获取技能数据
---* skillID      技能ID
---@param skillID      number
---@return table "返回:技能数据"
function SL:Get_SKILL_DATA(skillID) end;

---获取技能的等级熟练度数据
---* skillID      技能ID
---@param skillID      number
---@return table "返回:技能的等级熟练度数据"
function SL:Get_SKILL_TRAIN_DATA(skillID) end;

---获取技能配置
---* skillID      技能ID
---@param skillID      number
---@return table "返回:技能配置"
function SL:Get_SKILL_CONFIG(skillID) end;

---获取技能快捷键
---* skillID      技能ID
---@param skillID      number
---@return number "返回:技能快捷键"
function SL:Get_SKILL_KEY(skillID) end;

---获取技能等级
---* skillID      技能ID
---@param skillID      number
---@return number "返回:技能等级"
function SL:Get_SKILL_LEVEL(skillID) end;

---背包最大格子数量
---@return number "返回:背包最大格子数量"
function SL:Get_MAX_BAG() end;

---英雄背包最大格子数量
---@return number "返回:英雄背包最大格子数量"
function SL:Get_HERO_MAX_BAG() end;

---仓库最大格子数量
---@return number "返回:仓库最大格子数量"
function SL:Get_N_MAX_BAG() end;

---当前选中的背包页签
---@return number "返回:当前选中的背包页签"
function SL:Get_BAG_CUR_PAGE() end;

---背包是否满
---* isPrompt      图片对象
---@param isPrompt      userdata
---@return boolean "返回:背包是否满 true/false"
function SL:Get_BAG_IS_FULL(isPrompt) end;

---背包剩余格子数
---@return number "返回:背包剩余格子数"
function SL:Get_BAG_REMAIN_COUNT() end;

---背包已使用格子数
---@return number "返回:背包已使用格子数"
function SL:Get_BAG_USED_COUNT() end;

---检测物品背包是否有富余格子数存放
---* param1      物品ID
---* param2      物品数量
---* param3      不足时是否需要提示
---@param param1      number
---@param param2      number
---@param param3      boolean
---@return boolean "返回:背包是否有富余格子数存放 true/false"
function SL:Get_BAG_CHECK_NEED_SPACE(param1,param2,param3) end;

---默认最低竞拍价
---@return number "返回:默认最低竞拍价"
function SL:Get_AUCTION_BIDPRICE_MIN() end;

---默认最高竞拍价
---@return number "返回:默认最高竞拍价"
function SL:Get_AUCTION_BIDPRICE_MAX() end;

---默认最低一口价
---@return number "返回:默认最低一口价"
function SL:Get_AUCTION_BUYPRICE_MIN() end;

---默认最高一口价
---@return number "返回:默认最高一口价"
function SL:Get_AUCTION_BUYPRICE_MAX() end;

---默认货架数量
---@return number "返回:默认货架数量"
function SL:Get_AUCTION_DEFAULT_SHELF() end;

---上架列表数量
---@return number "返回:上架列表数量"
function SL:Get_AUCTION_PUT_LIST_CNT() end;

---拍卖行货币
---@return table "返回:拍卖行货币"
function SL:Get_AUCTION_MONEY() end;

---是否可竞价
---* item      拍卖物品数据
---@param item      table
---@return boolean "返回:是否可竞价 true/false"
function SL:Get_AUCTION_CAN_BID(item) end;

---是否可一口价
---* item      拍卖物品数据
---@param item      table
---@return boolean "返回:是否可一口价 true/false"
function SL:Get_AUCTION_CAN_BUY(item) end;

---是否有我的竞拍物品
---@return boolean "返回:是否有我的竞拍物品 true/false"
function SL:Get_AUCTION_HAVE_MY_BIDDING() end;

---拍卖行物品状态
---* itemData      拍卖物品数据
---@param itemData      table
---@return number,string "返回:nil"
function SL:Get_AUCTION_ITEM_STATE(itemData) end;

---获取拍卖行我的展示可寄售道具
---@return table "返回:拍卖行我的展示可寄售道具"
function SL:Get_AUCTION_MY_SHOW_LIST() end;

---世界求购菜单列表
---@return table "返回:世界求购菜单列表"
function SL:Get_PURCHASE_FILTER_LIST() end;

---求购货币列表
---@return table "返回:求购货币列表"
function SL:Get_PURCHASE_CURRENCIES() end;

---对应ID 菜单栏配置
---* param      id
---@param param      number
---@return table "返回:屏幕的宽度"
function SL:Get_PURCHASE_MENU_CONFIG_BY_ID(param) end;

---分类物品列表
---* param1      一级菜单id
---* param2      二级菜单id
---@param param1      number
---@param param2      number
---@return table "返回:分类物品列表"
function SL:Get_PURCHASE_ITEM_LIST_BY_TYPE(param1,param2) end;

---设置是否生效
---* param1      内挂设置index
---@param param1      number
---@return number "返回:设置是否生效 1/0"
function SL:Get_SETTING_ENABLED(param1) end;

---获取设置的数据
---* param1      内挂设置index
---@param param1      number
---@return table "返回:设置的数据"
function SL:Get_SETTING_VALUE(param1) end;

---获取设置的配置
---* param1      内挂设置index
---@param param1      number
---@return table "返回: 设置的配置"
function SL:Get_SETTING_CONFIG(param1) end;

---获取物品拾取设置
---* param1      内挂设置index
---@param param1      number
---@return table "返回:物品拾取设置"
function SL:Get_SETTING_PICK_VALUE(param1) end;

---可以拣的物品配置
---* param1      内挂设置index
---@param param1      number
---@return table "返回:可以拣的物品配置"
function SL:Get_SETTING_PICK_CONFIG(param1) end;

---物品是否可以设置
---@return table "返回:物品是否可以设置"
function SL:Get_SETTING_IS_ITEM_PICK_CAN_SET() end;

---拾取组的数据
---* param1      内挂设置index
---@param param1      number
---@return table "返回:拾取组的数据"
function SL:Get_SETTING_PICK_GROUP_VALUE(param1) end;

---通过值获取地图缩放对应百分比
---* param1      地图缩放值
---@param param1      number
---@return number "返回:地图缩放对应百分比"
function SL:Get_SETTING_MAPSCALE_PER(param1) end;

---通过百分比获取地图缩放值
---* param1      百分比
---@param param1      number
---@return number "返回:地图缩放值"
function SL:Get_SETTING_MAPSCALE_VALUE(param1) end;

---装备Map
---@return table "返回:装备Map"
function SL:Get_EQUIPMAP_BY_STDMODE() end;

---除装备Map 显示持久的stdmode
---@return table "返回:除装备Map 显示持久的stdmode"
function SL:Get_EX_SHOWLAST_MAP() end;

---通过stdmode获取TIPS装备位列表
---* param1      装备的stdmode
---* param2      是否英雄
---@param param1      number
---@param param2      boolean
---@return table "返回:TIPS装备位列表"
function SL:Get_TIP_POSLIST_BY_STDMODE(param1,param2) end;

---是否是该玩家性别装备
---* param1      装备数据
---* param2      是否英雄
---@param param1      table
---@param param2      boolean
---@return boolean "返回:是否是该玩家性别装备 true/false"
function SL:Get_IS_SAMESEX_EQUIP(param1,param2) end;

---对cfg_custpro_caption操作 根据key获取描述
---* param1      表中的key
---@param param1      number
---@return string "返回:cfg_custpro_caption操作描述"
function SL:Get_CUSTOM_DESC(param1) end;

---对cfg_custpro_caption操作 根据key获取图片id
---* param1      表中的key
---@param param1      number
---@return string "返回:key获取图片id"
function SL:Get_CUSTOM_ICON(param1) end;

---对cfg_att_score表操作 获取属性配置
---* param1      表中的key
---@param param1      number
---@return table "返回:属性配置"
function SL:Get_ATTR_CONFIG(param1) end;

---对cfg_suit表操作 获取对应套装id配置
---* param1      表中的suitid
---@param param1      number
---@return string "返回:对应套装id配置"
function SL:Get_SUIT_CONFIG(param1) end;

---对cfg_suitex表操作 获取对应套装id配置
---* param1      表中的suitid
---@param param1      number
---@return string "返回:对应套装id配置"
function SL:Get_SUITEX_CONFIG(param1) end;

---物品类型
---@return table "返回:##"
function SL:Get_ITEMTYPE_ENUM() end;

---根据道具数据获取物品类型
---* itemData      物品数据
---@param itemData      userdata
---@return number "返回:物品类型"
function SL:Get_ITEMTYPE(itemData) end;

---自定义属性ID映射Map
---@return table "返回:自定义属性ID映射Map"
function SL:Get_CUST_ABIL_MAP() end;

---充值商品信息列表
---@return table "返回:充值商品信息列表"
function SL:Get_RECHARGE_PRODUCTS() end;

---通过商品Id获取商品信息
---* id      商品id
---@param id      number
---@return table "返回:商品信息"
function SL:Get_RECHARGE_PRODUCT_BY_ID(id) end;

---是否接入第三方SDK
---@return boolean "返回:是否接入第三方SDK true/false"
function SL:Get_IS_SDK_PAY() end;

---获取购买摊位名字
---@return string "返回:获取购买摊位名字"
function SL:Get_STALL_SELL_SHOW_NAME() end;

---获取购买摊位物品信息
---@return table "返回:获取购买摊位物品信息"
function SL:Get_STALL_ONSELL_DATA() end;

---获取我的摊位物品信息
---@return table "返回:获取我的摊位物品信息"
function SL:Get_STALL_MYSELL_DATA() end;

---是否还有重摇/开启次数
---@return boolean "返回:是否还有重摇/开启次数 true/false"
function SL:Get_HAVE_GOLDBOX_OPENTIME() end;

---是否启用新版属性加点
---@return boolean "返回:是否启用新版属性加点 true/false"
function SL:Get_IS_NEW_BOUNS() end;

---获取新版属性加点配置数据
---@return table "返回:获取新版属性加点配置数据##"
function SL:Get_NEW_BOUNS_CONFIG() end;

---获取新版属性已加点数据
---@return table "返回:获取新版属性已加点数据"
function SL:Get_NEW_BOUNS_ADD_DATA() end;

---玩家名字
---@return string "返回:玩家名字"
function SL:Get_USER_NAME() end;

---玩家职业
---@return number "返回:玩家职业<br>0：战士<br>1：法师<br>2：道士"
function SL:Get_JOB() end;

---玩家等级
---@return number "返回:玩家等级"
function SL:Get_LEVEL() end;

---玩家转生等级
---@return number "返回:玩家转生等级"
function SL:Get_RELEVEL() end;

---职业名字
---@return string "返回:职业名字"
function SL:Get_JOB_NAME() end;

---玩家性别
---@return number "返回:玩家性别<br>0：男<br>1：女"
function SL:Get_SEX() end;

---玩家真实姓名
---@return string "返回:玩家真实姓名"
function SL:Get_REAL_USER_NAME() end;

---玩家名字颜色值
---@return number "返回:玩家名字颜色值"
function SL:Get_USER_NAME_COLOR() end;

---人物方向
---@return number "返回:人物方向<br>0：上<br>1：右上<br>2：右<br>3：右下<br>4：下<br>5：左下<br>6：左<br>7：左上<br>0xff：无效位置"
function SL:Get_DIR() end;

---角色是否死亡
---@return boolean "返回:角色是否死亡 true/false"
function SL:Get_USER_IS_DIE() end;

---角色是否能复活
---@return boolean "返回:角色是否能复活 true/false"
function SL:Get_USER_IS_CANREVIVE() end;

---当前血量
---@return number "返回:当前血量"
function SL:Get_HP() end;

---最大血量
---@return number "返回:最大血量"
function SL:Get_MAXHP() end;

---当前蓝量
---@return number "返回:当前蓝量"
function SL:Get_MP() end;

---最大蓝量
---@return number "返回:最大蓝量"
function SL:Get_MAXMP() end;

---暴击几率
---@return number "返回:暴击几率"
function SL:Get_BURST() end;

---暴击伤害
---@return number "返回:暴击伤害"
function SL:Get_BURST_DAM() end;

---物伤减免
---@return number "返回:物伤减免"
function SL:Get_IMM_ATT() end;

---魔伤减免
---@return number "返回:魔伤减免"
function SL:Get_IMM_MAG() end;

---幸运
---@return number "返回:幸运"
function SL:Get_LUCK() end;

---最小物防
---@return number "返回:最小物防"
function SL:Get_AC() end;

---最大物防
---@return number "返回:最大物防"
function SL:Get_MAXAC() end;

---最小魔防
---@return number "返回:最小魔防"
function SL:Get_MAC() end;

---最大魔防
---@return number "返回:最大魔防"
function SL:Get_MAXMAC() end;

---最小物理
---@return number "返回:最小物理"
function SL:Get_DC() end;

---最大物理
---@return number "返回:最大物理"
function SL:Get_MAXDC() end;

---最小魔法
---@return number "返回:最小魔法"
function SL:Get_MC() end;

---最大魔法
---@return number "返回:最大魔法"
function SL:Get_MAXMC() end;

---最小道术
---@return number "返回:最小道术"
function SL:Get_SC() end;

---最大道术
---@return number "返回:最大道术"
function SL:Get_MAXSC() end;

---准确
---@return number "返回:准确"
function SL:Get_HIT() end;

---敏捷
---@return number "返回:敏捷"
function SL:Get_SPD() end;

---当前经验
---@return number "返回:当前经验"
function SL:Get_EXP() end;

---最大经验
---@return number "返回:最大经验"
function SL:Get_MAXEXP() end;

---攻速
---@return number "返回:攻速"
function SL:Get_HITSPD() end;

---腕力
---@return number "返回:腕力"
function SL:Get_HW() end;

---最大可穿戴腕力
---@return number "返回:最大可穿戴腕力"
function SL:Get_MAXHW() end;

---重量
---@return number "返回:重量"
function SL:Get_BW() end;

---玩家最大负重
---@return number "返回:玩家最大负重"
function SL:Get_MAXBW() end;

---穿戴负重
---@return number "返回:穿戴负重"
function SL:Get_WW() end;

---最大穿戴负重
---@return number "返回:最大穿戴负重"
function SL:Get_MAXWW() end;

---体力恢复
---@return number "返回:体力恢复"
function SL:Get_HUNGER() end;

---获取玩家身上衣服的名字
---@return string "返回:获取玩家身上衣服的名字"
function SL:Get_DRESS() end;

---获取玩家身上武器的名字
---@return string "返回:获取玩家身上武器的名字"
function SL:Get_WEAPON() end;

---获取玩家身上勋章的名字
---@return string "返回:获取玩家身上勋章的名字"
function SL:Get_RIGHTHAND() end;

---获取玩家身上头盔的名字
---@return string "返回:获取玩家身上头盔的名字"
function SL:Get_HELMET() end;

---获取玩家身上项链的名字
---@return string "返回:获取玩家身上项链的名字"
function SL:Get_NECKLACE() end;

---获取玩家身上右戒指的名字
---@return string "返回:获取玩家身上右戒指的名字"
function SL:Get_RINGR() end;

---获取玩家身上左戒指的名字
---@return string "返回:获取玩家身上左戒指的名字"
function SL:Get_RINGL() end;

---获取玩家身上右手镯的名字
---@return string "返回:获取玩家身上右手镯的名字"
function SL:Get_ARMRINGR() end;

---获取玩家身上左手镯的名字
---@return string "返回:获取玩家身上左手镯的名字"
function SL:Get_ARMRINGL() end;

---获取玩家身上护符、玉佩、宝珠的名字
---@return string "返回:获取玩家身上护符、玉佩、宝珠的名字"
function SL:Get_BUJUK() end;

---获取玩家身上腰带的名字
---@return string "返回:获取玩家身上腰带的名字"
function SL:Get_BELT() end;

---获取玩家身上鞋子的名字
---@return string "返回:获取玩家身上鞋子的名字"
function SL:Get_BOOTS() end;

---获取玩家身上宝石的名字
---@return string "返回:获取玩家身上宝石的名字"
function SL:Get_CHARM() end;

---获取玩家某一装备位的装备名
---* equipID      装备位id
---@param equipID      number
---@return string "返回:获取玩家某一装备位的装备名"
function SL:Get_EQUIPBYPOS(equipID) end;

---根据类型id获取属性值
---* typeID      类型ID
---@param typeID      number
---@return number "返回:根据类型id获取属性值"
function SL:Get_CUR_ABIL_BY_ID(typeID) end;

---获取玩家某一装备数据
---* param1      装备位id 或者 装备名称
---* param2      是否多个装备位共享
---@param param1      string
---@param param2      boolean
---@return table "返回:获取玩家某一装备数据"
function SL:Get_EQUIP_DATA(param1,param2) end;

---获取玩家对应装备位数据列表
---* param1      装备位id
---@param param1      number
---@return table "返回:获取玩家对应装备位数据列表"
function SL:Get_EQUIP_DATA_LIST(param1) end;

---获取玩家法阵数据
---@return table "返回:获取玩家法阵数据"
function SL:Get_EQUIP_EMBATTLE() end;

---玩家外观数据
---@return table "返回:玩家外观数据"
function SL:Get_FEATURE() end;

---发型ID
---@return number "返回:发型ID"
function SL:Get_HAIR() end;

---获取装备位对应MakeIndex数据
---@return table "返回:获取装备位对应MakeIndex数据"
function SL:Get_EQUIP_POS_DATAS() end;

---玩家的称号数据
---@return table "返回:玩家的称号数据"
function SL:Get_TITLES() end;

---获取玩家对应ID的称号数据
---* id      用户ID
---@param id      number
---@return table "返回:获取玩家对应ID的称号数据"
function SL:Get_TITLE_DATA_BY_ID(id) end;

---玩家激活的称号id
---@return number "返回:玩家激活的称号id"
function SL:Get_TITLE_ACTIVATE_ID() end;

---人物内功最大内力值
---* id 用户ID
---@param id number
---@return number "返回:人物内功最大内力值"
function SL:Get_MAX_ABIL_BY_ID(id) end;

---人物内功当前内力值
---* id      用户ID
---@param id      number
---@return number "返回:人物内功当前内力值"
function SL:Get_CUR_ABIL_BY_ID(id) end;

---人物内功等级
---* id 引擎固定157
---@param id number
---@return number "返回:人物内功等级"
function SL:Get_CUR_ABIL_BY_ID(id) end;

---人物内功当前斗转星移值
---* id 引擎固定105  
---@param id number
---@return number "返回:人物内功当前斗转星移值"
function SL:Get_MAX_ABIL_BY_ID(id) end;

---人物内功当前经验值
---* id 引擎固定156  
---@param id number
---@return number "返回:人物内功当前经验值"
function SL:Get_CUR_ABIL_BY_ID(id) end;

---获取人物拥有内功技能列表
---@return table "返回:获取人物拥有内功技能列表"
function SL:Get_INTERNAL_SKILLS() end;

---获取人物内功技能数据
---* skillID      内功技能ID
---* skillType      内功技能类型
---@param skillID      number
---@param skillType      number
---@return table "返回:获取人物内功技能数据"
function SL:Get_INTERNAL_SKILL_DATA(skillID, skillType) end;

---获取人物内功技能等级熟练度数据
---* skillID      内功技能ID
---* skillType      内功技能类型
---@param skillID      number
---@param skillType      number
---@return table "返回:获取人物内功技能等级熟练度数据"
function SL:Get_INTERNAL_SKILL_TRAIN_DATA(skillID, skillType) end;

---获取人物内功技能开关
---* skillID      内功技能ID
---* skillType      内功技能类型
---@param skillID      number
---@param skillType      number
---@return number "返回:获取人物内功技能开关"
function SL:Get_INTERNAL_SKILL_ONOFF(skillID, skillType) end;

---获取人物内功技能矩形图标路径
---* skillID      内功技能ID
---* skillType      内功技能类型
---@param skillID      number
---@param skillType      number
---@return string "返回:获取人物内功技能矩形图标路径"
function SL:Get_INTERNAL_SKILL_RECT_ICON_PATH(skillID, skillType) end;

---获取人物内功技能名字
---* skillID      内功技能ID
---* skillType      内功技能类型
---@param skillID      number
---@param skillType      number
---@return table "返回:获取人物内功技能名字"
function SL:Get_INTERNAL_SKILL_NAME(skillID, skillType) end;

---获取人物内功技能描述
---* skillID      内功技能ID
---* skillType      内功技能类型
---@param skillID      number
---@param skillType      number
---@return table "返回:获取人物内功技能描述"
function SL:Get_INTERNAL_SKILL_DESC(skillID, skillType) end;

---获取人物内功经络的穴位描述
---@return table "返回:获取人物内功经络的穴位描述"
function SL:Get_MERIDIAN_DESC() end;

---获取人物内功对应经络的穴位是否激活列表
---* param1      经络ID
---@param param1      number
---@return table "返回:获取人物内功对应经络的穴位是否激活列表"
function SL:Get_MERIDIAN_AUCPOINT_STATE(param1) end;

---获取人物内功经络的开关列表
---@return table "返回:获取人物内功经络的开关列表"
function SL:Get_MERIDIAN_OPEN_LIST() end;

---获取人物内功对应经络等级
---* param1      内功
---@param param1      number
---@return number "返回:获取人物内功对应经络等级"
function SL:Get_MERIDIAN_LV(param1) end;

---获取人物所有拥有的连击技能
---@return table "返回:获取人物所有拥有的连击技能"
function SL:Get_HAVE_COMBO_SKILLS() end;

---获取人物对应连击技能
---* skillID      技能ID
---@param skillID      number
---@return table "返回:获取人物对应连击技能"
function SL:Get_COMBO_SKILL_DATA(skillID) end;

---获取人物连击技能等级熟练度数据
---* skillID      技能ID
---@param skillID      number
---@return table "返回:获取人物连击技能等级熟练度数据"
function SL:Get_COMBO_SKILL_TRAIN_DATA(skillID) end;

---获取人物设置为连击的数据
---@return table "返回:获取人物设置为连击的数据"
function SL:Get_SET_COMBO_SKILLS() end;

---人物开启的连击个数
---@return number "返回:人物开启的连击个数"
function SL:Get_OPEN_COMBO_NUM() end;

---人物是否学习内功
---@return boolean "返回:人物是否学习内功 true/false"
function SL:Get_IS_LEARNED_INTERNAL() end;

---获取对应连击格子额外加暴击几率
---* param1      连击格子index(1-4)
---@param param1      number
---@return number "返回:获取对应连击格子额外加暴击几率"
function SL:Get_EXTRA_COMBO_BJRATE(param1) end;

---跑步移动格子数
---@return number "返回:跑步移动格子数"
function SL:Get_RUN_STEP() end;

---能否跑
---@return boolean "返回:能否跑 true/false"
function SL:Get_CAN_RUN_ABLE() end;

---当前查看他人角色ID
---@return string "返回:当前查看他人角色ID"
function SL:Get_LOOK_TARGET_ID() end;

---当前查看他人角色名字
---@return string "返回:当前查看他人角色名字"
function SL:Get_LOOK_TARGET_NAME() end;

---当前查看他人角色名字颜色ID
---@return number "返回:当前查看他人角色名字颜色ID"
function SL:Get_LOOK_TARGET_NAME_COLOR() end;

---玩家属性初始化完成
---@return boolean "返回:玩家属性初始化完成 true/false"
function SL:Get_PLAYER_INITED() end;

---获取当前PK模式
---@return number "返回:获取当前PK模式 <span class=&quot;hljs-string&quot;>返回：获取当前PK模式<br>0：全体<br>1：和平<br>2：夫妻<br>3：师徒<br>4：组队<br>5：公会<br>6：善恶<br>7：国家"
function SL:Get_PKMODE() end;

---该PK模式是否可以切换
---* param  PK模式   
---@param param  number
---@return boolean "返回:该PK模式是否可以切换 true/false"
function SL:Get_PKMODE_CAN_USE(param) end;

---人物当前坐标X
---@return number "返回:人物当前坐标X"
function SL:Get_X() end;

---人物当前坐标Y
---@return number "返回:人物当前坐标Y"
function SL:Get_Y() end;

---根据气泡index获取气泡数据
---* index      气泡
---@param index      userdata
---@return table "返回:根据气泡index获取气泡数据"
function SL:Get_BUBBLETIPS_INFO(index) end;

---转生属性点
---@return number "返回:转生属性点"
function SL:Get_BONUSPOINT() end;

---获取buffID的配置表数据
---* buffID buffID 无参, 则整个buff表数据
---@param buffID number
---@return table "返回:buffID的配置表数据"
function SL:Get_BUFF_CONFIG(buffID) end;

---黑夜当前状态
---@return number "返回:黑夜当前状态"
function SL:Get_DARK_STATE() end;

---内观头发偏移配置
---@return table "返回:内观头发偏移配置"
function SL:Get_UIMODEL_HAIR_OFFSET() end;

---内观装备偏移配置
---@return table "返回:内观装备偏移配置"
function SL:Get_UIMODEL_EQUIP_OFFSET() end;

---屏幕点击状态
---@return boolean "返回:屏幕点击状态"
function SL:Get_TOUCH_STATE() end;

---鼠标移动位置
---@return table "返回:鼠标移动位置"
function SL:Get_MOUSE_MOVE_POS() end;

---交易行开启状态
---@return boolean "返回:交易行开启状态 true/false"
function SL:Get_TRADINGBANK_OPENSTATUS() end;

---PC端 CTRL键是否按下
---@return boolean "返回:PC端 CTRL键是否按下 true/false"
function SL:Get_CTRL_PRESSED() end;

---当前查看玩家职业
---@return number "返回:当前查看玩家职业"
function SL:Get_L_M_JOB() end;

---当前查看玩家发型
---@return number "返回:当前查看玩家发型"
function SL:Get_L_M_HAIR() end;

---当前查看玩家等级
---@return number "返回:当前查看玩家等级"
function SL:Get_L_M_LEVEL() end;

---当前查看玩家性别
---@return number "返回:当前查看玩家性别"
function SL:Get_L_M_SEX() end;

---当前查看玩家数据
---@return table "返回:当前查看玩家数据"
function SL:Get_L_M_PLAYER_DATA() end;

---当前查看玩家某个装备位数据
---* param1      装备位id/装备名称
---@param param1      string
---@return table "返回:当前查看玩家某个装备位数据"
function SL:Get_L_M_EQUIP_DATA(param1) end;

---当前查看玩家的所有装备位数据
---@return table "返回:当前查看玩家的所有装备位数据"
function SL:Get_L_M_EQUIP_POS_DATAS() end;

---当前查看玩家的行会信息
---@return table "返回:当前查看玩家的行会信息"
function SL:Get_L_M_GUILD_INFO() end;

---当前查看玩家的称号数据
---@return table "返回:当前查看玩家的称号数据"
function SL:Get_L_M_TITLES() end;

---当前查看玩家激活的称号id
---@return number "返回:当前查看玩家激活的称号id"
function SL:Get_L_M_TITLE_ACTIVATE_ID() end;

---当前查看玩家法阵数据
---@return table "返回:当前查看玩家法阵数据"
function SL:Get_L_M_EMBATTLE() end;

---英雄名字
---@return string "返回:英雄名字"
function SL:Get_H_USERNAME() end;

---英雄等级
---@return number "返回:英雄等级"
function SL:Get_H_LEVEL() end;

---英雄转生等级
---@return number "返回:英雄转生等级"
function SL:Get_H_RELEVEL() end;

---英雄当前经验
---@return number "返回:英雄当前经验"
function SL:Get_H_EXP() end;

---英雄最大经验
---@return number "返回:英雄最大经验"
function SL:Get_H_MAXEXP() end;

---职业名称
---@return string "返回:职业名称"
function SL:Get_H_JOBNAME() end;

---英雄职业
---@return number "返回:英雄职业"
function SL:Get_H_JOB() end;

---英雄性别
---@return number "返回:英雄性别"
function SL:Get_H_SEX() end;

---英雄发型ID
---@return number "返回:英雄发型ID"
function SL:Get_H_HAIR() end;

---最大生命值
---@return number "返回:最大生命值"
function SL:Get_H_MAXHP() end;

---最大魔法值
---@return number "返回:最大魔法值"
function SL:Get_H_MAXMP() end;

---当前生命值
---@return number "返回:当前生命值"
function SL:Get_H_HP() end;

---当前魔法值
---@return number "返回:当前魔法值"
function SL:Get_H_MP() end;

---当前血量百分比
---@return number "返回:当前血量百分比"
function SL:Get_H_HPPercent() end;

---当前蓝量百分比
---@return number "返回:当前蓝量百分比"
function SL:Get_H_MPPercent() end;

---当前经验百分比
---@return number "返回:当前经验百分比"
function SL:Get_H_EXPPercent() end;

---攻击下限
---@return number "返回:攻击下限"
function SL:Get_H_MIN_ATK() end;

---攻击上限
---@return number "返回:攻击上限"
function SL:Get_H_MAX_ATK() end;

---魔攻下限
---@return number "返回:魔攻下限"
function SL:Get_H_MIN_MAT() end;

---魔攻上限
---@return number "返回:魔攻上限"
function SL:Get_H_MAX_MAT() end;

---道术下限
---@return number "返回:道术下限"
function SL:Get_H_MIN_DAO() end;

---道术上限
---@return number "返回:道术上限"
function SL:Get_H_MAX_DAO() end;

---物防下限
---@return number "返回:物防下限"
function SL:Get_H_MIN_DEF() end;

---魔防下限
---@return number "返回:魔防下限"
function SL:Get_H_MIN_MDF() end;

---魔防上限
---@return number "返回:魔防上限"
function SL:Get_H_MAX_MDF() end;

---命中
---@return number "返回:命中"
function SL:Get_H_HIT() end;

---攻击速度
---@return number "返回:攻击速度"
function SL:Get_H_HITSPD() end;

---英雄暴击几率
---@return number "返回:英雄暴击几率"
function SL:Get_H_BURST() end;

---英雄暴击伤害
---@return number "返回:英雄暴击伤害"
function SL:Get_H_BURST_DAM() end;

---英雄物伤减免
---@return number "返回:英雄物伤减免"
function SL:Get_H_IMM_ATT() end;

---英雄魔伤减免
---@return number "返回:英雄魔伤减免"
function SL:Get_H_IMM_MAG() end;

---物理穿透
---@return number "返回:物理穿透"
function SL:Get_H_IGN_DEF() end;

---吸血
---@return number "返回:吸血"
function SL:Get_H_SUCK_HP() end;

---英雄幸运
---@return number "返回:英雄幸运"
function SL:Get_H_LUCK() end;

---怪物爆率
---@return number "返回:怪物爆率"
function SL:Get_H_DROP() end;

---当前重量
---@return number "返回:当前重量"
function SL:Get_H_BW() end;

---英雄最大负重
---@return number "返回:英雄最大负重"
function SL:Get_H_MAXBW() end;

---英雄穿戴负重
---@return number "返回:英雄穿戴负重"
function SL:Get_H_WW() end;

---英雄最大穿戴负重
---@return number "返回:英雄最大穿戴负重"
function SL:Get_H_MAXWW() end;

---英雄腕力
---@return number "返回:英雄腕力"
function SL:Get_H_HW() end;

---当前最大可穿戴腕力
---@return number "返回:当前最大可穿戴腕力"
function SL:Get_H_MAXHW() end;

---当前愤怒
---@return number "返回:当前愤怒"
function SL:Get_H_ANGER() end;

---最大愤怒
---@return number "返回:最大愤怒"
function SL:Get_H_MAXANGER() end;

---英雄怒气值是否满
---@return boolean "返回:英雄怒气值是否满 true/false"
function SL:Get_H_SHAN() end;

---单次怒气增加值
---@return number "返回:单次怒气增加值"
function SL:Get_H_SPEED() end;

---怒气增加间隔时间
---@return number "返回:怒气增加间隔时间"
function SL:Get_H_DELAYT() end;

---获取英雄某一装备数据
---* param1      装备位id 或者 装备名称
---* param2      是否多个装备位共享
---@param param1      string
---@param param2      boolean
---@return table "返回:获取英雄某一装备数据"
function SL:Get_H_EQUIP_DATA(param1,param2) end;

---获取英雄对应装备位数据列表
---* param1      装备位id
---@param param1      number
---@return table "返回:获取英雄对应装备位数据列表"
function SL:Get_H_EQUIP_DATA_LIST(param1) end;

---获取英雄法阵数据
---@return table "返回:获取英雄法阵数据"
function SL:Get_H_EMBATTLE() end;

---获取英雄装备位对应MakeIndex数据
---@return table "返回:获取英雄装备位对应MakeIndex数据"
function SL:Get_H_EQUIP_POS_DATAS() end;

---英雄的称号数据
---@return table "返回:英雄的称号数据"
function SL:Get_H_TITLES() end;

---英雄激活的称号id
---@return number "返回:英雄激活的称号id"
function SL:Get_H_TITLE_ACTIVATE_ID() end;

---获取英雄技能的等级熟练度数据
---* param1      技能ID
---@param param1      number
---@return table "返回:获取英雄技能的等级熟练度数据"
function SL:Get_H_SKILL_TRAIN_DATA(param1) end;

---获取英雄技能数据
---* skillID      技能ID
---@param skillID      number
---@return table "返回:获取英雄技能数据"
function SL:Get_H_SKILL_DATA(skillID) end;

---获取技能名
---* skillID      技能ID
---@param skillID      number
---@return string "返回:获取技能名"
function SL:Get_H_SKILL_NAME(skillID) end;

---获取英雄技能快捷键
---* skillID      技能ID
---@param skillID      number
---@return number "返回:获取英雄技能快捷键"
function SL:Get_H_SKILL_KEY(skillID) end;

---获取已有技能数据
---* param1      是否排除普攻
---* param2      是否只获取主动技能
---@param param1      boolean
---@param param2      boolean
---@return table "返回:获取已有技能数据"
function SL:Get_H_LEARNED_SKILLS(param1,param2) end;

---英雄内功当前内力值
---* id 引擎固定100
---@param id number
---@return number "返回:英雄内功当前内力值"
function SL:Get_H_CUR_ABIL_BY_ID(id) end;

---英雄内功最大内力值
---* id 引擎固定100
---@param id number
---@return number "返回:英雄内功最大内力值"
function SL:Get_H_MAX_ABIL_BY_ID(id) end;

---英雄内功最大经验值
---* id 引擎固定156
---@param id number
---@return number "返回:英雄内功最大经验值"
function SL:Get_H_MAX_ABIL_BY_ID(id) end;

---英雄内功当前经验值
---* id 引擎固定156
---@param id number
---@return number "返回:英雄内功当前经验值"
function SL:Get_H_CUR_ABIL_BY_ID(id) end;

---英雄内功等级
---* id 引擎固定157
---@param id number
---@return number "返回:英雄内功等级"
function SL:Get_H_CUR_ABIL_BY_ID(id) end;

---英雄内功当前斗转星移值
---* id 引擎固定105
---@param id number
---@return number "返回:英雄内功当前斗转星移值"
function SL:Get_H_CUR_ABIL_BY_ID(id) end;

---英雄内功最大斗转星移值
---* id 引擎固定105
---@param id number
---@return number "返回:英雄内功最大斗转星移值"
function SL:Get_H_MAX_ABIL_BY_ID(id) end;

---获取英雄拥有内功技能列表
---@return table "返回:获取英雄拥有内功技能列表"
function SL:Get_H_INTERNAL_SKILLS() end;

---获取英雄内功技能数据
---* skillID      技能ID
---* skillType      技能类型
---@param skillID      number
---@param skillType      number
---@return table "返回:获取英雄内功技能数据"
function SL:Get_H_INTERNAL_SKILL_DATA(skillID,skillType) end;

---获取英雄内功技能等级熟练度数据
---* skillID      技能ID
---* skillType      技能类型
---@param skillID      number
---@param skillType      number
---@return table "返回:获取英雄内功技能等级熟练度数据"
function SL:Get_H_INTERNAL_SKILL_TRAIN_DATA(skillID,skillType) end;

---获取英雄内功技能开关
---* skillID      技能ID
---* skillType      技能类型
---@param skillID      number
---@param skillType      number
---@return number "返回:获取英雄内功技能开关"
function SL:Get_H_INTERNAL_SKILL_ONOFF(skillID,skillType) end;

---获取英雄内功技能矩形图标路径
---* skillID      技能ID
---* skillType      技能类型
---@param skillID      number
---@param skillType      number
---@return string "返回:获取英雄内功技能矩形图标路径"
function SL:Get_H_INTERNAL_SKILL_RECT_ICON_PATH(skillID,skillType) end;

---获取英雄内功技能名字
---* skillID      技能ID
---* skillType      技能类型
---@param skillID      number
---@param skillType      number
---@return table "返回:获取英雄内功技能名字"
function SL:Get_H_INTERNAL_SKILL_NAME(skillID,skillType) end;

---获取英雄内功技能描述
---* skillID      技能ID
---* skillType      技能类型
---@param skillID      number
---@param skillType      number
---@return table "返回:获取英雄内功技能描述"
function SL:Get_H_INTERNAL_SKILL_DESC(skillID,skillType) end;

---获取英雄内功对应经络的穴位是否激活列表
---* param1      经络ID
---@param param1      number
---@return table "返回:获取英雄内功对应经络的穴位是否激活列表"
function SL:Get_H_MERIDIAN_AUCPOINT_STATE(param1) end;

---获取英雄内功经络的开关列表
---@return table "返回:获取英雄内功经络的开关列表"
function SL:Get_H_MERIDIAN_OPEN_LIST() end;

---获取英雄内功对应经络等级
---* param1      经络ID
---@param param1      number
---@return number "返回:获取英雄内功对应经络等级"
function SL:Get_H_MERIDIAN_LV(param1) end;

---获取英雄所有拥有的连击技能
---@return table "返回:获取英雄所有拥有的连击技能"
function SL:Get_H_HAVE_COMBO_SKILLS() end;

---获取英雄对应连击技能
---* skillID      技能ID
---@param skillID      number
---@return table "返回:获取英雄对应连击技能"
function SL:Get_H_COMBO_SKILL_DATA(skillID) end;

---获取英雄连击技能等级熟练度数据
---* skillID      技能ID
---@param skillID      number
---@return table "返回:获取英雄连击技能等级熟练度数据"
function SL:Get_H_COMBO_SKILL_TRAIN_DATA(skillID) end;

---获取英雄设置为连击的数据
---@return table "返回:获取英雄设置为连击的数据"
function SL:Get_H_SET_COMBO_SKILLS() end;

---英雄开启的连击个数
---@return number "返回:英雄开启的连击个数"
function SL:Get_H_OPEN_COMBO_NUM() end;

---英雄是否学习内功
---@return boolean "返回:英雄是否学习内功 true/false"
function SL:Get_H_IS_LEARNED_INTERNAL() end;

---获取英雄技能图标
---* skillID      技能ID
---@param skillID      number
---@return string "返回:获取英雄技能图标"
function SL:Get_H_SKILL_ICON_PATH(skillID) end;

---获取英雄矩形技能图标
---* skillID      技能ID
---@param skillID      number
---@return string "返回:获取英雄矩形技能图标"
function SL:Get_H_SKILL_RECT_ICON_PATH(skillID) end;

---英雄属性初始化完成
---@return boolean "返回:英雄属性初始化完成 true/false"
function SL:Get_HERO_INITED() end;

---英雄锁定ActorID
---@return number "返回:英雄锁定ActorID"
function SL:Get_H_LOCK_TARGET_ID() end;

---交易行玩家名字
---@return string "返回:玩家名字"
function SL:Get_T_M_USERNAME() end;

---交易行玩家等级
---@return number "返回:玩家等级"
function SL:Get_T_M_LEVEL() end;

---交易行角色转生等级
---@return number "返回:交易行角色转生等级"
function SL:Get_T_M_RELEVEL() end;

---交易行角色当前经验
---@return number "返回:交易行角色当前经验"
function SL:Get_T_M_EXP() end;

---交易行角色最大经验
---@return number "返回:交易行角色最大经验"
function SL:Get_T_M_MAXEXP() end;

---交易行角色职业
---@return number "返回:交易行角色职业"
function SL:Get_T_M_JOB() end;

---交易行角色性别
---@return number "返回:交易行角色性别"
function SL:Get_T_M_SEX() end;

---交易行角色发型ID
---@return number "返回:交易行角色发型ID"
function SL:Get_T_M_HAIR() end;

---交易行角色最大生命值
---@return number "返回:交易行角色最大生命值"
function SL:Get_T_M_MAXHP() end;

---交易行角色最大魔法值
---@return number "返回:交易行角色最大魔法值"
function SL:Get_T_M_MAXMP() end;

---交易行角色当前生命值
---@return number "返回:交易行角色当前生命值"
function SL:Get_T_M_HP() end;

---交易行角色当前魔法值
---@return number "返回:交易行角色当前魔法值"
function SL:Get_T_M_MP() end;

---交易行角色攻击下限
---@return number "返回:交易行角色攻击下限"
function SL:Get_T_M_MIN_ATK() end;

---交易行角色攻击上限
---@return number "返回:交易行角色攻击上限"
function SL:Get_T_M_MAX_ATK() end;

---交易行角色魔攻下限
---@return number "返回:交易行角色魔攻下限"
function SL:Get_T_M_MIN_MAT() end;

---交易行角色魔攻上限
---@return number "返回:交易行角色魔攻上限"
function SL:Get_T_M_MAX_MAT() end;

---交易行角色道术下限
---@return number "返回:交易行角色道术下限"
function SL:Get_T_M_MIN_DAO() end;

---交易行角色道术上限
---@return number "返回:交易行角色道术上限"
function SL:Get_T_M_MAX_DAO() end;

---交易行角色物防下限
---@return number "返回:交易行角色物防下限"
function SL:Get_T_M_MIN_DEF() end;

---交易行角色物防上限
---@return number "返回:交易行角色物防上限"
function SL:Get_T_M_MAX_DEF() end;

---交易行角色魔防下限
---@return number "返回:交易行角色魔防下限"
function SL:Get_T_M_MIN_MDF() end;

---交易行角色魔防上限
---@return number "返回:交易行角色魔防上限"
function SL:Get_T_M_MAX_MDF() end;

---交易行角色命中
---@return number "返回:交易行角色命中"
function SL:Get_T_M_HIT() end;

---交易行角色攻击速度
---@return number "返回:交易行角色攻击速度"
function SL:Get_T_M_HITSPD() end;

---交易行角色暴击几率
---@return number "返回:交易行角色暴击几率"
function SL:Get_T_M_BURST() end;

---交易行角色暴击伤害
---@return number "返回:交易行角色暴击伤害"
function SL:Get_T_M_BURST_DAM() end;

---交易行角色物伤减免
---@return number "返回:交易行角色物伤减免"
function SL:Get_T_M_IMM_ATT() end;

---交易行角色魔伤减免
---@return number "返回:交易行角色魔伤减免"
function SL:Get_T_M_IMM_MAG() end;

---交易行角色吸血
---@return number "返回:交易行角色吸血"
function SL:Get_T_M_SUCK_HP() end;

---交易行角色幸运
---@return number "返回:交易行角色幸运"
function SL:Get_T_M_LUCK() end;

---交易行角色怪物爆率
---@return number "返回:交易行角色怪物爆率"
function SL:Get_T_M_DROP() end;

---交易行角色当前重量
---@return number "返回:交易行角色当前重量"
function SL:Get_T_M_BW() end;

---交易行角色玩家最大负重
---@return number "返回:交易行角色玩家最大负重"
function SL:Get_T_M_MAXBW() end;

---交易行角色穿戴负重
---@return number "返回:交易行角色穿戴负重"
function SL:Get_T_M_WW() end;

---交易行角色最大穿戴负重
---@return number "返回:交易行角色最大穿戴负重"
function SL:Get_T_M_MAXWW() end;

---交易行角色腕力
---@return number "返回:交易行角色腕力"
function SL:Get_T_M_HW() end;

---交易行角色当前最大可穿戴腕力
---@return number "返回:交易行角色当前最大可穿戴腕力"
function SL:Get_T_M_MAXHW() end;

---交易行角色玩家名字颜色值
---@return number "返回:交易行角色玩家名字颜色值"
function SL:Get_T_M_USERNAME_COLOR() end;

---交易行角色玩家的称号数据
---@return table "返回:交易行角色玩家的称号数据"
function SL:Get_T_M_TITLES() end;

---当前查看交易行角色玩家激活的称号id
---@return number "返回:当前查看交易行角色玩家激活的称号id"
function SL:Get_T_M_ACTIVATE_TITLE() end;

---获取交易行角色技能的等级熟练度数据
---* skillID      技能ID
---@param skillID      number
---@return table "返回:获取交易行角色技能的等级熟练度数据"
function SL:Get_T_M_SKILL_TRAIN_DATA(skillID) end;

---获取交易行角色技能数据
---* skillID      技能ID
---@param skillID      number
---@return table "返回:获取交易行角色技能数据"
function SL:Get_T_M_SKILL_DATA(skillID) end;

---获取交易行角色已有技能数据
---* param1      是否排除普攻
---* param2      是否只获取主动技能
---@param param1      number
---@param param2      number
---@return table "返回:获取交易行角色已有技能数据"
function SL:Get_T_M_LEARNED_SKILLS(param1,param2) end;

---根据类型ID获取交易行角色属性值
---* typeID      类型ID
---@param typeID      number
---@return number "返回:根据类型ID获取交易行角色属性值"
function SL:Get_T_M_ATT_BY_TYPE(typeID) end;

---当前查看交易行角色玩家的所有装备位数据
---@return table "返回:当前查看交易行角色玩家的所有装备位数据"
function SL:Get_T_M_EQUIP_POS_DATAS() end;

---当前查看交易行角色玩家的行会信息
---@return table "返回:当前查看交易行角色玩家的行会信息"
function SL:Get_T_M_GUILD_INFO() end;

---获取当前查看玩家对应装备位的装备数据
---@return table "返回:获取当前查看玩家对应装备位的装备数据"
function SL:Get_T_M_EQUIP_DATA() end;

---获取当前查看玩家对应装备位的装备数据列表
---@return table "返回:获取当前查看玩家对应装备位的装备数据列表"
function SL:Get_T_M_EQUIP_DATA_LIST() end;

---通过MakeIndex获取查看交易行他人装备数据
---@return table "返回:查看交易行他人装备数据"
function SL:Get_T_M_EQUIP_DATA_BY_MAKEINDEX() end;

---交易行英雄名字
---@return string "返回:交易行英雄名字"
function SL:Get_T_H_USERNAME() end;

---交易行英雄等级
---@return number "返回:交易行英雄等级"
function SL:Get_T_H_LEVEL() end;

---交易行英雄转生等级
---@return number "返回:交易行英雄转生等级"
function SL:Get_T_H_RELEVEL() end;

---交易行英雄当前经验
---@return number "返回:交易行英雄当前经验"
function SL:Get_T_H_EXP() end;

---交易行英雄最大经验
---@return number "返回:交易行英雄最大经验"
function SL:Get_T_H_MAXEXP() end;

---交易行英雄职业
---@return number "返回:交易行英雄职业"
function SL:Get_T_H_JOB() end;

---交易行英雄性别
---@return number "返回:交易行英雄性别"
function SL:Get_T_H_SEX() end;

---交易行英雄发型ID
---@return number "返回:交易行英雄发型ID"
function SL:Get_T_H_HAIR() end;

---交易行英雄最大生命值
---@return number "返回:交易行英雄最大生命值"
function SL:Get_T_H_MAXHP() end;

---交易行英雄最大魔法值
---@return number "返回:交易行英雄最大魔法值"
function SL:Get_T_H_MAXMP() end;

---交易行英雄当前生命值
---@return number "返回:交易行英雄当前生命值"
function SL:Get_T_H_HP() end;

---交易行英雄当前魔法值
---@return number "返回:交易行英雄当前魔法值"
function SL:Get_T_H_MP() end;

---交易行英雄攻击下限
---@return number "返回:交易行英雄攻击下限"
function SL:Get_T_H_MIN_ATK() end;

---交易行英雄攻击上限
---@return number "返回:交易行英雄攻击上限"
function SL:Get_T_H_MAX_ATK() end;

---交易行英雄魔攻下限
---@return number "返回:交易行英雄魔攻下限"
function SL:Get_T_H_MIN_MAT() end;

---交易行英雄魔攻上限
---@return number "返回:交易行英雄魔攻上限"
function SL:Get_T_H_MAX_MAT() end;

---交易行英雄道术下限
---@return number "返回:交易行英雄道术下限"
function SL:Get_T_H_MIN_DAO() end;

---交易行英雄道术上限
---@return number "返回:交易行英雄道术上限"
function SL:Get_T_H_MAX_DAO() end;

---交易行英雄物防下限
---@return number "返回:交易行英雄物防下限"
function SL:Get_T_H_MIN_DEF() end;

---交易行英雄物防上限
---@return number "返回:交易行英雄物防上限"
function SL:Get_T_H_MAX_DEF() end;

---交易行英雄魔防下限
---@return number "返回:交易行英雄魔防下限"
function SL:Get_T_H_MIN_MDF() end;

---交易行英雄魔防上限
---@return number "返回:交易行英雄魔防上限"
function SL:Get_T_H_MAX_MDF() end;

---交易行英雄命中
---@return number "返回:交易行英雄命中"
function SL:Get_T_H_HIT() end;

---交易行英雄攻击速度
---@return number "返回:交易行英雄攻击速度"
function SL:Get_T_H_HITSPD() end;

---交易行英雄暴击几率
---@return number "返回:交易行英雄暴击几率"
function SL:Get_T_H_BURST() end;

---交易行英雄暴击伤害
---@return number "返回:交易行英雄暴击伤害"
function SL:Get_T_H_BURST_DAM() end;

---交易行英雄物伤减免
---@return number "返回:交易行英雄物伤减免"
function SL:Get_T_H_IMM_ATT() end;

---交易行英雄魔伤减免
---@return number "返回:交易行英雄魔伤减免"
function SL:Get_T_H_IMM_MAG() end;

---交易行英雄吸血
---@return number "返回:交易行英雄吸血"
function SL:Get_T_H_SUCK_HP() end;

---交易行英雄幸运
---@return number "返回:交易行英雄幸运"
function SL:Get_T_H_LUCK() end;

---交易行英雄怪物爆率
---@return number "返回:交易行英雄怪物爆率"
function SL:Get_T_H_DROP() end;

---交易行英雄当前重量
---@return number "返回:交易行英雄当前重量"
function SL:Get_T_H_BW() end;

---交易行英雄最大负重
---@return number "返回:交易行英雄最大负重"
function SL:Get_T_H_MAXBW() end;

---交易行英雄穿戴负重
---@return number "返回:交易行英雄穿戴负重"
function SL:Get_T_H_WW() end;

---交易行英雄最大穿戴负重
---@return number "返回:交易行英雄最大穿戴负重"
function SL:Get_T_H_MAXWW() end;

---交易行英雄腕力
---@return number "返回:交易行英雄腕力"
function SL:Get_T_H_HW() end;

---交易行英雄当前最大可穿戴腕力
---@return number "返回:交易行英雄当前最大可穿戴腕力"
function SL:Get_T_H_MAXHW() end;

---交易行英雄的称号数据
---@return table "返回:交易行英雄的称号数据"
function SL:Get_T_H_TITLES() end;

---当前查看英雄激活的称号id
---@return number "返回:当前查看英雄激活的称号id"
function SL:Get_T_H_ACTIVATE_TITLE() end;

---获取交易行英雄技能的等级熟练度数据
---* skillID      技能ID
---@param skillID      number
---@return table "返回:获取交易行英雄技能的等级熟练度数据"
function SL:Get_T_H_SKILL_TRAIN_DATA(skillID) end;

---获取交易行英雄技能数据
---* skillID      技能ID
---@param skillID      number
---@return table "返回:获取交易行英雄技能数据"
function SL:Get_T_H_SKILL_DATA(skillID) end;

---获取交易行英雄已有技能数据
---* param1      是否排除普攻
---* param2      是否只获取主动技能
---@param param1      boolean
---@param param2      boolean
---@return table "返回:获取交易行英雄已有技能数据"
function SL:Get_T_H_LEARNED_SKILLS(param1,param2) end;

---根据类型ID获取交易行英雄属性值
---* typeID      类型ID
---@param typeID      number
---@return number "返回:根据类型ID获取交易行英雄属性值"
function SL:Get_T_H_ATT_BY_TYPE(typeID) end;

---当前查看英雄的所有装备位数据
---@return table "返回:当前查看英雄的所有装备位数据"
function SL:Get_T_H_EQUIP_POS_DATAS() end;

---获取当前查看英雄对应装备位的装备数据
---@return table "返回:获取当前查看英雄对应装备位的装备数据"
function SL:Get_T_H_EQUIP_DATA() end;

---获取当前查看英雄对应装备位的装备数据列表
---@return table "返回:获取当前查看英雄对应装备位的装备数据列表"
function SL:Get_T_H_EQUIP_DATA_LIST() end;

---通过MakeIndex获取查看交易行他人英雄装备数据
---@return table "返回:通过MakeIndex获取查看交易行他人英雄装备数据"
function SL:Get_T_H_EQUIP_DATA_BY_MAKEINDEX() end;

---日志打印
function SL:release_print(...) end;

---DEBUG下日志打印(Print)
function SL:Print(...) end;

---DEBUG下日志打印(PrintEx)
function SL:PrintEx(...) end;

---DEBUG下日志打印(PrintTraceback)
function SL:PrintTraceback(...) end;

---DEBUG下日志打印(dump)
---* data    需要打印的表
---* desciption  打印表描述
---* nesting 需要打印的深度
---@param data    table   
---@param desciption  string
---@param nesting number
function SL:dump(data, desciption, nesting) end;

---json字符串解密
---* jsonStr  json字符串             
---* isfilter  是否过滤违禁词 默认为true
---@param jsonStr  string
---@param isfilter  boolean
---@return table "返回:json table"
function SL:JsonDecode(jsonStr, isfilter) end;

---json字符串加密
---* jsonData json表                 
---* isfilter 是否过滤违禁词 默认为true
---@param jsonData table  
---@param isfilter boolean
---@return string "返回: json string"
function SL:JsonEncode(jsonData, isfilter) end;

---存储字符到本地
---* key   字段名   
---* data   数据
---@param key   any 
---@param data  number
function SL:SetLocalString(key, data) end;

---从本地读取字符
---* key   字段名   
---@param key   any 
---@return string "返回:字符"
function SL:GetLocalString(key) end;

---打开引导
---* data   数据结构
---@param data  table
---@return userdata "返回:引导对象"
function SL:StartGuide(data) end;

---关闭引导
---* guide   引导对象
---@param guide  userdata
function SL:CloseGuide(guide) end;

---表中的对应 id 的颜色转换成 RGB 格式
---* id   cfg_colour_style 表中的对应 id
---@param id   number
---@return table "返回:{r = 255, g = 255, b = 255}"
function SL:GetColorByStyleId(id) end;

---表中的对应 id 的颜色转换成 16进制 格式
---* id   cfg_colour_style 表中的对应 id
---@param id   number
---@return string "返回: 16进制 格式"
function SL:GetHexColorByStyleId(id) end;

---表中的对应 id 的颜色大小
---* id   cfg_colour_style 表中的对应 id
---@param id   number
---@return number "返回:size"
function SL:GetSizeByStyleId(id) end;

---Color3B颜色转化为hex 16进制
---* color3B   例: {r = 255, g = 255, b = 255}
---@param color3B   table  
---@return string "返回:16进制 &quot;#FFFFFF&quot;"
function SL:GetColorHexFromRGB(color3B) end;

---播放按钮点击音效
function SL:PlayBtnClickAudio() end;

---播放音效
---* id   cfg_sound表对应id
---* isLoop 是否循环
---@param id   number
---@param isLoop boolean
function SL:PlaySound(id, isLoop) end;

---播放登陆-选角音效
function SL:PlaySelectRoleAudio() end;

---播放开宝箱音效
function SL:PlayOpenBoxAudio() end;

---播放宝箱内选中音效
function SL:PlayFlashBoxAudio() end;

---停止所有音效
function SL:StopAllAudio() end;

---停止音效
---* id   cfg_sound表对应id
---@param id   number
function SL:StopSound(id) end;

---资源下载
---* path        保存的文件路径 
---* url         下载资源地址  
---* downloadCB  回调函数      
---@param path        string
---@param url         string
---@param downloadCB  function 
function SL:DownLoadRes(path, url, downloadCB) end;

---小地图资源下载
---* mapId       小地图Id 
---* callback    回调函数 
---@param mapId       number
---@param callback    function 
function SL:DownloadMiniMapRes(mapId, callback) end;

---删除GM缓存资源
---* filePath        文件路径 
---@param filePath        string
function SL:RemoveGMResFile(filePath) end;

---向服务器发送一个表单
---* filename   文件名
---* funcName   函数名
---* param     参数(最大长度4000字符)
---@param filename  string
---@param funcName  string
---@param param    string
function SL:SubmitForm(filename, funcName, param) end;

---获取文件列表
---* path   文件路径
---@param path  string
---@return table "返回:&quot;dev&quot;下的路径"
function SL:GetFilesByPath(path) end;

---获取服务端推送物品的自定义变量
---* key   物品：makeindex
---@param key  number
---@return table "返回:物品所有的自定义变量值"
function SL:GetSerCustomVar(key) end;

---颜色转换函数
---* hexStr  16进制字符                 
---@param hexStr  string
---@return table "返回:从16进制字符转为{r, g, b}"
function SL:ConvertColorFromHexString(hexStr) end;

---文件路径是否存在
---* path 文件路径                 
---@param path string
---@return boolean "返回:文件路径是否存在 true/false"
function SL:IsFileExist(path) end;

---深拷贝
---* data  需深拷贝内容                 
---@param data  table  
---@return table "返回:深拷贝内容"
function SL:CopyData(data) end;

---字符串分割
---* str  分割内容               
---* delimiter  分割字符
---@param str  string
---@param delimiter  string
---@return table "返回:拆分后字符"
function SL:Split(str, delimiter) end;

---文本提示
---* str         显示文本
---@param str         string
function SL:ShowSystemTips(str) end;

---哈希表转成按数组
---* hashTab         转换表
---* sortFunc       排序方法
---@param hashTab         table
---@param sortFunc       function
---@return table "返回:转换后table"
function SL:HashToSortArray(hashTab, sortFunc) end;

---显示提示文本框
---* str         显示文本
---* width       显示宽度, 默认: 1136
---* pos         坐标, 默认: {x = 0, y = 0}
---* anchorPoint 锚点, 默认: {x = 0, y = 1}
---@param str         string
---@param width       number
---@param pos         table
---@param anchorPoint table
function SL:SHOW_DESCTIP(str, width, pos, anchorPoint) end;

---加载文件
---* file         文件名
---@param file         string
function SL:RequireFile(file) end;

---拆解文件
---* path         文件路径
---* delimiter    指定分隔符
---* callBack     拆解回调方法 传入拆分后table参数
---@param path         string
---@param delimiter    string
---@param callBack     function
function SL:LoadTxtFile(path, delimiter, callBack) end;

---数字转换成万、亿单位
---* num          数值
---* places       显示小数点后几位数 
---@param num          number
---@param places       number
---@return string "返回:转换后数字"
function SL:GetSimpleNumber(num, places) end;

---血量单位显示
---* hp           血量数值
---* pointBit     显示小数点后几位, 默认保留后两位
---@param hp           number
---@param pointBit     number
---@return string "返回:转换后血量"
function SL:HPUnit(hp, pointBit) end;

---中文转换成竖着显示
---* str           需转换中文
---@param str           string
---@return string "返回:转换后中文字符"
function SL:ChineseToVertical(str) end;

---阿拉伯数字转中文大写
---* num           需转换阿拉伯数字
---@param num           number
---@return string "返回:大写中文数字"
function SL:NumberToChinese(num) end;

---获取字符串的byte长度
---* str           字符串
---@param str           string
---@return number "返回:字符串的byte长度"
function SL:GetUTF8ByteLen(str) end;

---时间格式化成字符串显示
---* sec          秒数
---* isToStr      是否转成字符串输出, 空或false则返回table <br>{d = 天数, h = 小时, m = 分钟, s = 秒}
---* isSimple     是否简化字符串[基于isToStr 为 true]
---@param sec          number
---@param isToStr      boolean
---@param isSimple     boolean
---@return table "返回:时间格式化成字符串 格式:xx天xx时xx分xx秒"
function SL:SecondToHMS(sec, isToStr, isSimple) end;

---数字转化为千分位字符串
---* num          数字
---@param num          number
---@return string "返回:千分位字符串无"
function SL:GetThousandSepString(num) end;

---lua table转成config配置表
---* tab          需要转换的table
---* name         转出文件名
---* destPath     文件保存的路径, 默认目录：dev/scripts/game_config/
---* sortFunc     外层排序函数
---@param tab          table
---@param name         string
---@param destPath     string
---@param sortFunc     function
function SL:SaveTableToConfig(tab, name, destPath, sortFunc) end;

---十六进制转十进制
---* hexStr          十六进制
---@param hexStr          string
---@return number "返回:十进制"
function SL:HexToInt(hexStr) end;

---MD5加密
---* str          加密字符
---@param str          string
---@return string "返回:加密后字符"
function SL:GetStrMD5(str) end;

---UTF8转GBK编码
---* str          需要转换的字符
---@param str          string
---@return string "返回:转换后字符"
function SL:UTF8ToGBK(str) end;

---GBK转UTF8编码
---* str          需要转换的字符
---@param str          string
---@return string "返回:转换后字符"
function SL:GBKToUTF8(str) end;

---计算两坐标间的平方距离
---* pt1  		  起始坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---* pt2  		  结束坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt1  		  table
---@param pt2  		  table
---@return number "返回:两坐标间的平方距离"
function SL:GetPointDistanceSQ(pt1, pt2) end;

---计算两坐标间的距离 
---* pt1  		  起始坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---* pt2  		  结束坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt1  		  table
---@param pt2  		  table
---@return number "返回:两坐标间的距离"
function SL:GetPointDistance(pt1, pt2) end;

---计算向量长度
---* pt  		  GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt  		  table
---@return number "返回:向量长度"
function SL:GetPointLength(pt) end;

---计算向量长度平方
---* pt  		  GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt  		  table
---@return number "返回:nil"
function SL:GetPointLengthSQ(pt) end;

---计算两点中心点坐标
---* pt1  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---* pt2  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt1  		  table
---@param pt2  		  table
---@return table "返回:两点中心点坐标"
function SL:GetMidPoint(pt1, pt2) end;

---计算两点相加坐标
---* pt1  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---* pt2  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt1  		  table
---@param pt2  		  table
---@return table "返回:两点相加坐标"
function SL:GetAddPoint(pt1, pt2) end;

---计算两点相减坐标
---* pt1  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---* pt2  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt1  		  table
---@param pt2  		  table
---@return table "返回:两点相减坐标"
function SL:GetSubPoint(pt1, pt2) end;

---标准向量化坐标
---* pt  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt  		  table
---@return table "返回:标准向量化坐标"
function SL:GetNormalizePoint(pt) end;

---计算两向量夹角弧度值
---* pt1  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---* pt2  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt1  		  table
---@param pt2  		  table
---@return number "返回:两向量夹角弧度值"
function SL:GetPointAngle(pt1, pt2) end;

---计算两向量夹角角度值
---* pt1  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---* pt2  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt1  		  table
---@param pt2  		  table
---@return number "返回:两向量夹角角度值"
function SL:GetPointRotate(pt1, pt2) end;

---计算自身弧度值
---* pt  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt  		  table
---@return number "返回:自身弧度值"
function SL:GetPointAngleSelf(pt) end;

---计算自身角度值
---* pt  		  坐标 GUI:p(x, y) 或 <br>{x = x, y = y}
---@param pt  		  table
---@return number "返回:自身角度值"
function SL:GetPointRotateSelf(pt) end;

---获取高16位值
---* value  		   被操作值
---@param value  		  number
---@return number "返回:高16位值"
function SL:GetH16Bit(value) end;

---获取低16位值
---* value  		  被操作值 
---@param value  		  number
---@return number "返回:高16位值"
function SL:GetL16Bit(value) end;

---跳转到某个超链
---* id  		  对应界面的跳转id
---@param id  		  number
function SL:JumpTo(id) end;

---退出到选角界面
function SL:ExitToRoleUI() end;

---退出到选角界面(强制小退)
function SL:ForceExitToRoleUI() end;

---退出到登录界面
function SL:ExitToLoginUI() end;

---退出游戏
function SL:ExitGame() end;

---发送GM命令到聊天
---* msg   gm命令
---@param msg   string
function SL:RequestSendChatGMMsg(msg) end;

---创建一个红点到节点
---* targetNode   目标控件
---* offset       偏移位置 例: {x = 5, y = 5}
---@param targetNode   userdata
---@param offset       table
---@return userdata "返回:红点"
function SL:CreateRedPoint(targetNode, offset) end;

---设置文本样式(按钮、文本)
---* widget   按钮或者文本对象
---* colorID       0 - 255 色值ID 
---@param widget   userdata
---@param colorID       number
function SL:SetColorStyle(widget, colorID) end;

---获取对应色值ID的配置
---* colorID       0 - 255 色值ID 
---@param colorID       number
---@return table "返回:对应色值ID的配置"
function SL:GetColorCfg(colorID) end;

---检查是否满足条件
---@return boolean "返回:是否满足条件 true/false"
function SL:CheckCondition(conditionStr) end;

---显示气泡提醒
---* id   气泡ID
---* path       气泡图片资源路径
---* callback   气泡点击回调
---@param id   number
---@param path       string
---@param callback   function
function SL:AddBubbleTips(id, path, callback) end;

---删除气泡提醒
---* ID   气泡ID
---@param ID   number
function SL:DelBubbleTips(ID) end;

---重新加载地图
function SL:ReloadMap() end;

---请求HTTP Get方式
---* url     链接地址
---* httpCB  回调函数 
---@param url    string
---@param httpCB function 
function SL:HTTPRequestGet(url, httpCB) end;

---请求HTTP Post方式
---* url        链接地址
---* httpCB     回调函数
---* suffix     请求信息
---* head       请求头
---@param url       string
---@param httpCB    function 
---@param suffix    string
---@param head      table    
function SL:HTTPRequestPost(url, httpCB, suffix, head) end;

---本地公告展示
---* data       具体参数配置
---@param data      table    
function SL:ShowLocalNoticeByType(data) end;

---震屏
---* time       震动时间 (毫秒)
---* distance   震动距离
---@param time      number
---@param distance  number
function SL:ShakeScene(time, distance) end;

---注册控件事件
---* widget  控件对象
---* desc   描述
---* msgtype  窗体事件id
---* callback  回调函数
---@param widget  userdata
---@param desc  string
---@param msgtype number
---@param callback function 
function SL:RegisterWndEvent(widget, desc, msgtype, callback) end;

---注销控件事件
---* widget  控件对象
---* desc   描述
---* msgtype  窗体事件id
---@param widget  userdata
---@param desc  string
---@param msgtype number
function SL:UnRegisterWndEvent(widget, desc, msgtype) end;

---添加窗体控件自定义属性
---* widget    控件对象 
---* desc      描述    
---* key       属性名称
---* value     属性值  
---@param widget    userdata
---@param desc      string
---@param key       string
---@param value     any    
function SL:AddWndProperty(widget, desc, key, value) end;

---删除窗体控件自定义属性
---* widget    控件对象 
---* desc      描述    
---* key       属性名称
---@param widget    userdata
---@param desc      string
---@param key       string
function SL:DelWndProperty(widget, desc, key ) end;

---获取窗体控件自定义属性
---* widget    控件对象 
---* desc      描述    
---* key       属性名称
---@param widget    userdata
---@param desc      string
---@param key       string
---@return any "返回:窗体控件自定义属性"
function SL:GetWndProperty(widget, desc, key ) end;

---注册游戏事件回调
---* eventID      事件ID
---* eventTag      事件描述
---* eventCB      回调
---* widget      界面对象
---@param eventID      string
---@param eventTag      string
---@param eventCB      function
---@param widget      userdata
function SL:RegisterLUAEvent(eventID, eventTag, eventCB,widget) end;

---注销游戏事件回调
---* eventID      事件ID
---* eventTag      事件描述
---@param eventID      string
---@param eventTag      string
function SL:UnRegisterLUAEvent(eventID, eventTag) end;

---开启一个定时器
---* callback    回调函数 
---* time    时间 
---@param callback    function 
---@param time    number 
---@return number "返回:定时器ID"
function SL:Schedule(callback, time) end;

---停止一个定时器
---* scheduleID    定时器ID 
---@param scheduleID    number 
function SL:UnSchedule(scheduleID) end;

---开启一个单次定时器
---* callback    回调函数 
---* time    时间 
---@param callback    function 
---@param time    number 
function SL:ScheduleOnce(callback, time) end;

---开启一个定时器, 绑定node节点
---* node    bode节点 
---* callback    回调函数 
---* time    时间 
---@param node    userdata
---@param callback    function 
---@param time    number 
function SL:schedule(node, callback, time) end;

---开启一个单次定时器, 绑定node节点
---* node    bode节点 
---* callback    回调函数 
---* time    时间 
---@param node    userdata
---@param callback    function 
---@param time    number 
function SL:scheduleOnce(node, callback, time) end;

---背包刷新
function SL:RequestRefreshBagPos() end;

---使用物品
---* Index 物品Index   
---@param Index number
function SL:RequestUseItemByIndex(Index) end;

---批量勾选背包物品
---* data 物品唯一ID 数组   
---@param data table 
function SL:RequestSetBagItemChoose(data) end;

---丢弃物品
---* itemData 装备数据   
---@param itemData table 
function SL:RequestIntoDropBagItem(itemData) end;

---检测人物是否可穿戴
---* itemData 装备数据   
---@param itemData table 
---@return boolean "返回:是否可穿戴"
function SL:CheckItemUseNeed(itemData) end;

---检测英雄是否可穿戴
---* itemData 装备数据   
---@param itemData table 
---@return boolean "返回:是否可穿戴"
function SL:CheckItemUseNeed_Hero(itemData) end;

---对比传入装备和自身穿戴的装备
---* itemData   装备数据
---* from     物品来自(界面位置)
---@param itemData   table    
---@param from     number
---@return table "返回:对比传入装备和自身穿戴的装备"
function GUIFunction:CompareEquipOnBody(itemData, from) end;

---人物装备穿戴
---* itemData   装备数据
---* pos        装备位置
---* isFromHero 是否来自英雄背包
---@param itemData   table    
---@param pos        number
---@param isFromHero boolean
function SL:RequestPlayerTakeOnEquip(itemData, pos, isFromHero) end;

---人物装备脱下
---* itemData   装备数据
---* isToHero   是否脱到英雄背包
---@param itemData   table    
---@param isToHero   boolean
function SL:RequestPlayerTakeOffEquip(itemData, isToHero) end;

---英雄装备穿戴
---* itemData   装备数据
---* pos        装备位置
---* isFromPlayer 是否来自人物背包
---@param itemData   table    
---@param pos        number
---@param isFromPlayer boolean
function SL:RequestHeroTakeOnEquip(itemData, pos, isFromPlayer) end;

---英雄装备脱下
---* itemData   装备数据
---* isToPlayer   是否脱到人物背包
---@param itemData   table    
---@param isToPlayer   boolean
function SL:RequestHeroTakeOffEquip(itemData, isToPlayer) end;

---获取已请求服务端物品所有自定义变量
---* makeIndex      唯一id
---@param makeIndex      number
---@return table "返回:自定义变量"
function SL:GetSerCustomVar(makeIndex) end;

---发送文本显示到聊天页输入框
---* LUA_EVENT_CHAT_REPLACE_INPUT 聊天输入内容替换
---* str   文本内容
---@param LUA_EVENT_CHAT_REPLACE_INPUT string
---@param str   string
function SL:onLUAEvent(LUA_EVENT_CHAT_REPLACE_INPUT, str) end;

---发送[普通消息]到聊天
---* msg  	    消息内容
---* channel    设置频道, 不设置默认当前聊天频道
---@param msg  	    string
---@param channel    number
function SL:RequestSendChatNormalMsg(msg, channel) end;

---发送[系统提示]到聊天框
---* msg 提示内容
---* FColor 字体颜色ID
---* BColor 背景颜色ID
---@param msg string
---@param FColor number
---@param BColor number
function SL:ShowSystemChat(msg, FColor, BColor) end;

---发送[装备]到聊天
---* channel    设置频道, 不设置默认当前聊天频道
---@param channel    number
function SL:RequestSendChatEquipMsg(channel) end;

---填充表情到聊天输入
---* LUA_EVENT_CHAT_PUSH_INPUT 聊天输入内容补充
---* data  表情配置      
---@param LUA_EVENT_CHAT_PUSH_INPUT string
---@param data  table 
function SL:onLUAEvent(LUA_EVENT_CHAT_PUSH_INPUT, data) end;

---私聊目标
---* LUA_EVENT_CHAT_PRIVATE_TARGET    私聊对象    
---* data     {name = targetName(目标玩家名字), uid = targetId(目标玩家ID)}    
---@param LUA_EVENT_CHAT_PRIVATE_TARGET    string
---@param data    table 
function SL:onLUAEvent(LUA_EVENT_CHAT_PRIVATE_TARGET, data) end;

---新增本地掉落消息到聊天
---* data  	    Msg: 掉落内容富文本<br> FColor: 字体颜色ID <br> BColor: 背景颜色ID <br> dropType: 掉落分类ID (1-10)
---@param data  	    table
function SL:AddDropChatMsgShow(data) end;

---请求获取邮件列表 一次十条
function SL:RequestMailList() end;

---删除已读邮件
function SL:RequestDelReadMail() end;

---读邮件
---* mailId 邮件ID
---@param mailId number
function SL:RequestReadMail(mailId) end;

---删除邮件
---* mailId 邮件ID
---@param mailId number
function SL:RequestDelMail(mailId) end;

---邮件全部提取
function SL:RequestGetAllMailItems() end;

---邮件提取
---* mailId 邮件ID
---@param mailId number
function SL:RequestGetMailItems(mailId) end;

---快速选择目标
---* data  type:<br>&amp;emsp;0: 玩家<br>&amp;emsp;50: 怪物<br>&amp;emsp;400: 英雄<br>imgNotice: 没有目标时是否创建范围圈<br>systemTips: 没有目标时是否弹提示
---@param data  table
function SL:QuickSelectTarget(data) end;

---控件加入到元变量自动刷新的组件
---* metaValue  传入已配置元变量的字符串 <br>&amp;<元变量KEY/参数>&amp; <br>例 : <br> 红点变量U91: &amp;<REDKEY/U91>&amp; <br>角色名: &amp;<USER_NAME>&amp; 
---* widget 文本控件 Text
---@param metaValue  string
---@param widget userdata
function SL:CustomAttrWidgetAdd(metaValue, widget) end;

---检测控件是否可视
---* node 控件 
---* touchPos 当前接触坐标
---@param node userdata
---@param touchPos table
---@return boolean "返回:控件是否可视 true/false"
function SL:CheckNodeCanCallBack(node, touchPos) end;

---添加提升按钮
---* id  按钮id 必须唯一!!!! (同脚本命令加的id也不能重复)
---* name 按钮展示文本
---* func 点击按钮跳转函数
---@param id  number
---@param name string
---@param func function
function SL:AddUpgradeBtn(id, name, func) end;

---删除提升按钮
---* id  按钮id 必须唯一!!!! (同脚本命令加的id也不能重复)
---@param id  number
function SL:RemoveUpgradeBtn(id) end;

---模拟左键点击事件
---* widget    控件对象
---@param widget    userdata
function SL:WinClick(widget) end;

---世界坐标转化为地图坐标
---* worldX  世界坐标X
---* worldY  世界坐标Y
---@param worldX  number
---@param worldY  number
---@return number "返回:地图坐标"
function SL:ConvertWorldPos2MapPos(worldX, worldY) end;

---地图坐标转化为世界坐标
---* mapX  地图坐标X
---* mapY  地图坐标Y
---* centerOfGrid  是否在地图格中心
---@param mapX  number
---@param mapY  number
---@param centerOfGrid boolean
---@return number "返回:世界坐标"
function SL:ConvertMapPos2WorldPos(mapX, mapY, centerOfGrid) end;

---世界坐标转化为屏幕坐标
---* worldX  世界坐标X
---* worldY  世界坐标Y
---@param worldX  number
---@param worldY  number
---@return number "返回:屏幕坐标"
function SL:ConvertWorldPos2Screen(worldX, worldY) end;

---屏幕坐标转化为世界坐标
---* screenX  屏幕坐标X
---* screenY  屏幕坐标Y
---@param screenX  number
---@param screenY  number
---@return number "返回:世界坐标"
function SL:ConvertScreen2WorldPos(screenX, screenY) end;

---打开QQ
function SL:RequestOpenQQ() end;

---加QQ
---* id  QQ号
---@param id  number
function SL:RequestJoinQQ(id) end;

---加QQ群
---* key  QQ群key
---@param key  number
function SL:RequestJoinQQGroup(key) end;

---打开微信
function SL:RequestOpenWX() end;

---添加地图特效
---* ID        该地图特效标识 必须唯一!!!! 
---* mapID     添加到的地图ID
---* sfxId     特效ID
---* x         地图坐标X
---* y         地图坐标Y
---* loop      是否循环播放特效, 不填默认循环播放
---* showType  显示位置 0:在后面 1: 在前面
---@param ID        number
---@param mapID     string
---@param sfxId     number
---@param x         number
---@param y         number
---@param loop      boolean
---@param showType  number
function SL:AddMapSpecialEffect(ID, mapID, sfxId, x, y, loop,showType) end;

---删除地图特效
---* ID        该地图特效标识 必须唯一!!!! 
---* mapID     添加到的地图ID
---@param ID        number
---@param mapID     string
function SL:RmvMapSpecialEffect(ID, mapID) end;

---添加Actor特效
---* actorID   玩家id
---* sfxID     特效ID
---* isFront   是否在模型前 默认在前面
---* offX      x偏移
---* offY      y偏移
---@param actorID   number
---@param sfxID     number
---@param isFront   boolean
---@param offX      number
---@param offY      number
function SL:AddActorEffect(actorID, sfxID, isFront, offX, offY) end;

---删除Actor特效
---* actorID   玩家id
---* sfxID     特效ID
---@param actorID   number
---@param sfxID     number
function SL:RmvActorEffect(actorID, sfxID) end;

---强攻
function SL:RequestForceAttack() end;

---拉起充值
---* payWay  1 支付宝 2 花呗 3 微信 -1不选择(手机端接入SDK不选择支付渠道)
---* currencyID 货币ID
---* price 支付金额
---* productIndex 商品索引/商品ID
---@param payWay  number
---@param currencyID number
---@param price number
---@param productIndex number
function SL:RequestPay(payWay, currencyID, price, productIndex) end;

---兑换激活码
---* cdk  激活码
---@param cdk  string
function SL:RequestCDK(cdk) end;

---请求改变PK模式
---* pkmode  pk模式
---@param pkmode  number
function SL:RequestChangePKMode(pkmode) end;

---请求改变宠物战斗模式
---* pkmode  宝宝模式
---@param pkmode  number
function SL:RequestChangePetPKMode(pkmode) end;

---请求从仓库取出道具
---* data   道具数据
---@param data  table
function SL:RequestPutOutStorageData(data) end;

---请求道具放入仓库
---* data   道具数据
---@param data  table
function SL:RequestSaveItemToNpcStorage(data) end;

---请求使用道具
---* itemData   道具数据
---@param itemData  table 
function SL:RequestUseItem(itemData) end;

---请求使用英雄道具
---* itemData   道具数据
---@param itemData  table
function SL:RequestUseHeroItem(itemData) end;

---拆分道具
---* data  道具数据
---* num   数量
---@param data  table
---@param num   number
function SL:RequestSplitItem(data, num) end;

---拆分道具(英雄)
---* data  道具数据
---* num   数量
---@param data  table 
---@param num   number
function SL:RequestSplitHeroItem(data, num) end;

---请求购买商品
---* index  商品Index
---* count    购买数量
---@param index  number
---@param count   number
function SL:RequestStoreBuy(index, count) end;

---召唤英雄或收回
function SL:RequestCallOrOutHero() end;

---请求宠物锁定
---* targetID  目标宠物ID
---@param targetID  number
function SL:RequestLockPetID(targetID) end;

---请求取消宠物锁定
---* targetID  目标宠物ID
---@param targetID  number
function SL:RequestUnLockPetID(targetID) end;

---释放技能
---* skillID  技能ID
---@param skillID  number
function SL:RequestLaunchSkill(skillID) end;

---请求施法合击
function SL:RequestMagicJointAttack() end;

---查看目标玩家信息
---* targetID  目标ID
---* notForbid 是否不判断地图禁止查看
---@param targetID  number
---@param notForbid boolean
function SL:RequestLookPlayer(targetID, notForbid) end;

---请求开关开关型技能
---* skillID  技能ID
---@param skillID  number
function SL:RequestOnOffSkill(skillID) end;

---请求行会申请列表
function SL:RequestGuildAllyApplyList() end;

---拒绝行会结盟申请
---* guildID  行会ID
---@param guildID  number
function SL:RequestGuildRejectAllyApply(guildID) end;

---请求行会成员列表
function SL:RequestGuildMemberList() end;

---请求世界行会列表
---* page  分页id
---@param page  number
function SL:RequestWorldGuildList(page) end;

---邀请玩家入会
---* uid  玩家id
---@param uid  number
function SL:RequestGuildInviteMember(uid) end;

---踢出行会
---* uid  玩家id
---@param uid  number
function SL:RequestSubGuildMember(uid) end;

---任命行会职位
---* uid  玩家id
---* rank 职位id 1-5
---@param uid  number
---@param rank number
function SL:RequestGuildAppointRank(uid, rank) end;

---请求创建队伍
function SL:RequestCreateTeam() end;

---邀请玩家入队
---* uid  玩家id
---* name 玩家昵称
---@param uid  number
---@param name string
function SL:RequestInviteJoinTeam(uid, name) end;

---拒绝组队邀请
---* uid  玩家id
---@param uid  number
function SL:RequestRefuseTeamInvite(uid) end;

---同意组队邀请
function SL:RequestAgreeTeamInvite(uid) end;

---同意申请入队
---* uid  玩家id
---@param uid  number
function SL:RequestApplyAgree(uid) end;

---请求入队申请列表
function SL:RequestApplyData() end;

---请求附近队伍
function SL:RequestNearTeam() end;

---请求加入队伍
---* uid  队长id
---@param uid  number
function SL:RequestApplyJoinTeam(uid) end;

---离开队伍
function SL:RequestLeaveTeam() end;

---保存允许组队状态
---* status   1允许 0不允许
---@param status  number
function SL:Set_TEAM_STATUS_PERMIT(status) end;

---踢出队伍
---* uid  玩家id
---@param uid  number
function SL:RequestSubTeamMember(uid) end;

---移交队长
---* uid  玩家id
---@param uid  number
function SL:RequestTransferTeamLeader(uid) end;

---请求好友列表
function SL:RequestFriendList() end;

---请求添加好友
---* uname 玩家昵称
---@param uname string
function SL:RequestAddFriend(uname) end;

---删除好友
---* uid  玩家id
---@param uid  number
function SL:RequestDelFriend(uid) end;

---好友加到黑名单
---* uname 玩家昵称
---@param uname string
function SL:RequestAddBlacklistByName(uname) end;

---移出黑名单
---* uid  玩家id
---@param uid  number
function SL:RequestOutBlacklist(uid) end;

---同意好友申请
---* uname 玩家昵称
---@param uname string
function SL:RequestAgreeFriendApply(uname) end;

---清空好友申请列表
function SL:RequestClearFriendApplyList() end;

---请求进行交易
---* uid  玩家id
---@param uid  number
function SL:RequestTrade(uid) end;

---请求获取宝箱物品奖励
function SL:RequestGetGoldBoxReward() end;

---请求再开启宝箱
function SL:RequestOpenGoldBox() end;

---请求拍卖行上架列表
---* listType 1: 表示查询自己上架的物品，2: 表示查询参与过的
---@param listType number
function SL:RequestAuctionPutList(listType) end;

---拍卖行请求上架
---* makeindex 物品唯一ID
---* count     数量
---* bidPrice  竞拍价格
---* buyPrice  一口价
---* currencyID 货币ID
---* rebate    折扣
---@param makeindex number
---@param count     number
---@param bidPrice  number
---@param buyPrice  number
---@param currencyID number
---@param rebate    number
function SL:RequestAuctionPutin(makeindex, count, bidPrice, buyPrice, currencyID, rebate) end;

---拍卖行请求下架
---* makeindex 物品唯一ID
---@param makeindex number
function SL:RequestAuctionPutout(makeindex) end;

---拍卖行请求重新上架
---* makeindex 物品唯一ID
---* count     数量
---* bidPrice  竞拍价格
---* buyPrice  一口价
---* currencyID 货币ID
---* rebate    折扣
---@param makeindex number
---@param count     number
---@param bidPrice  number
---@param buyPrice  number
---@param currencyID number
---@param rebate    number
function SL:RequestAuctionRePutin(makeindex, count, bidPrice, buyPrice, currencyID, rebate) end;

---拍卖行请求竞价
---* makeindex 物品唯一ID
---* price     竞拍价
---@param makeindex number
---@param price     number
function SL:RequestAuctionBid(makeindex, price) end;

---拍卖行请求领取竞拍成功物品
---* makeindex 物品唯一ID
---@param makeindex number
function SL:RequestAcquireBidItem(makeindex) end;

---请求求购数据
---* data      请求参数
---@param data     table 
function SL:RequestPurchaseItemList(data) end;

---请求求购出售物品
---* data      请求参数 {guid = 求购列表标识id, qty = 出售数量}
---@param data     table 
function SL:RequestPurchaseSell(data) end;

---请求上架求购物品
---* data      请求参数
---@param data     table 
function SL:RequestPurchasePutIn(data) end;

---请求下架求购物品
---* guid  求购列表标识id, 不填则全部下架
---@param guid  number
function SL:RequestPurchasePutOut(guid) end;

---请求取出求购已收物品
---* guid  求购列表标识id, 不填则全部取出
---@param guid  number
function SL:RequestPurchaseTakeOut(guid) end;

---请求点击NPC
---* npcID  NPCID
---@param npcID  number
function SL:RequestNPCTalk(npcID) end;

---请求排行榜数据
---* type 类别ID
---* selectType 选择类别
---@param type number
---@param selectType number
function SL:RequestRankData(type,selectType) end;

---请求玩家排行榜数据
---* userID   玩家ID
---* type 玩家/英雄 1玩家 2英雄
---@param userID   number
---@param type number
function SL:RequestPlayerRankData(userID, type) end;

---请求玩家称号数据
function SL:RequestTitleList() end;

---请求取下称号
function SL:RequestDisboardTitle() end;

---请求激活称号
---* titleId 称号id
---@param titleId number
function SL:RequestActivateTitle(titleId) end;

---请求确认加属性点
---* data      加点数据table `{&quot;Bonus&quot;:[{&quot;id&quot;:1,&quot;value&quot;:1}, ...]}`
---* m_nBonusPoint  剩余加点数
---@param data     table 
---@param m_nBonusPoint number
function SL:RequestAddReinAttr_N(data, m_nBonusPoint) end;

---提交任务
---* missionID 任务ID
---@param missionID number
function SL:RequestSubmitMission(missionID) end;

---请求合成
---* compoundID      合成ID
---@param compoundID      number
function SL:ResquestCompoundItem(compoundID) end;

---请求敏感词检测
---* str   需要检测的文本
---* type 文本类型 <br> 1 : 昵称类<br> 2 : 聊天类<br> 3 : 行会公告
---* callback  检测完毕的回调事件<br> 事件传入参数: param1: boolean 能否通过 param2: 文本 
---@param str  string
---@param type number
---@param callback function 
function SL:RequestCheckSensitiveWord(str, type, callback) end;

---邀请上马
---* uid  玩家id
---@param uid  number
function SL:RequestInvitePlayerInHorse(uid) end;

---切换英雄状态
---* type  状态值
---@param type  number
function SL:RequestChangeHeroMode(type) end;

---请求英雄称号数据
function SL:RequestTitleList_Hero() end;

---英雄请求取下称号
function SL:RequestDisboardTitle_Hero() end;

---英雄请求激活称号
---* titleId  称号id
---@param titleId  number
function SL:RequestActivateTitle_Hero(titleId) end;

---通知服务端 英雄时装显示开关
---* type  2 : 设置显示神魔<br> 1 : 设置时装显示
---@param type  number
function SL:SendSuperEquipSetting_Hero(type) end;

---英雄请求锁定目标
---* actorID  actorID
---* isPlayer 是否人物
---@param actorID  number
---@param isPlayer boolean
function SL:RequestLockTargetByHero(actorID, isPlayer) end;

---英雄取消锁定
function SL:RequestCancelLockByHero() end;

---请求地图组队成员数据
function SL:RequestMiniMapTeam() end;

---请求地图怪物数据
function SL:RequestMiniMapMonsters() end;

---请求内功技能数据
---* isHero   是否请求英雄
---@param isHero  boolean
function SL:RequestInternalSkillData(isHero) end;

---请求经络穴位激活
---* typeID  经络ID
---* aucPointID 穴位ID
---* isHero  是否请求英雄
---@param typeID  number
---@param aucPointID number
---@param isHero  boolean
function SL:RequestAucPointOpen(typeID, aucPointID, isHero) end;

---修炼经络
---* typeID  经络ID
---* isHero   是否请求英雄
---@param typeID  number
---@param isHero  boolean
function SL:RequestMeridianLevelUp(typeID, isHero) end;

---设置连击技能
---* key      键位 (1, 2, 3, 4)
---* skillID 技能ID
---* isHero   是否请求英雄
---@param key     number
---@param skillID number
---@param isHero  boolean
function SL:RequestSetComboSkill(key, skillID, isHero) end;

---请求设置内功条前置开关 并刷新显示
---* show     是否开启 默认true
---@param show     boolean
function SL:RequestNGHudShow(show) end;

---打开设置界面
---* pageID   页签ID 不填默认基础设置<br>1 : 基础设置<br>2 : 视距<br>3 : 战斗<br>4 : 保护<br>5 : 挂机<br>6 : 帮助
---@param pageID   number
function UIOperator:OpenSettingUI(pageID) end;

---关闭设置界面
function UIOperator:CloseSettingUI() end;

---打开行会界面
---* pageID   页签ID 不填默认行会主页<br>1 : 主页<br>2 : 成员<br>3 : 列表
---@param pageID   number
function UIOperator:OpenGuildMainUI(pageID) end;

---关闭行会界面
function UIOperator:CloseGuildMainUI() end;

---打开行会申请界面
function UIOperator:OpenGuildApplyListUI() end;

---关闭行会申请界面
function UIOperator:CloseGuildApplyListUI() end;

---打开行会创建界面
function UIOperator:OpenGuildCreateUI() end;

---关闭行会创建界面
function UIOperator:CloseGuildCreateUI() end;

---打开行会结盟申请界面
function UIOperator:OpenGuildAllyApplyUI() end;

---关闭行会结盟申请界面
function UIOperator:CloseGuildAllyApplyUI() end;

---关闭行会宣战/结盟界面
function UIOperator:CloseGuildWarAllyUI() end;

---打开人物背包
---* data   pos  : 背包打开位置 <br>bag_page : 背包打开页签ID
---@param data   table    
function UIOperator:OpenBagUI(data) end;

---关闭人物背包
function UIOperator:CloseBagUI() end;

---打开英雄背包
function UIOperator:OpenHeroBagUI() end;

---关闭英雄背包
function UIOperator:CloseHeroBagUI() end;

---打开拍卖行
function UIOperator:OpenAuctionUI() end;

---关闭拍卖行
function UIOperator:CloseAuctionUI() end;

---打开摆摊界面
function UIOperator:OpenStallLayerUI() end;

---关闭摆摊界面
function UIOperator:CloseStallLayerUI() end;

---打开玩家交易界面
function UIOperator:OpenTradeUI() end;

---关闭玩家交易界面
function SL:CloseTradeUI() end;

---打开排行榜
---* type   打开 指定页签ID
---@param type   number
function UIOperator:OpenRankUI(type) end;

---关闭排行榜
function UIOperator:CloseRankUI() end;

---打开聊天界面(手机端)
function UIOperator:OpenChatUI() end;

---关闭聊天界面(手机端)
function UIOperator:CloseChatUI() end;

---打开聊天扩展框
---* index   打开 指定分组 <br> 1 : 快捷命令<br>2 : 表情<br> 3 : 背包
---@param index   number
function UIOperator:OpenChatExtendUI(index) end;

---关闭聊天扩展框
function UIOperator:CloseChatExtendUI() end;

---打开社区帖子
function UIOperator:OpenCommunityUI() end;

---关闭社区帖子
function UIOperator:CloseCommunityUI() end;

---打开交易行
function UIOperator:OpenTradingBankUI() end;

---关闭交易行
function UIOperator:CloseTradingBankUI() end;

---打开商城
---* page   打开 商城对应分页
---@param page   number
function UIOperator:OpenStoreFrameUI(page) end;

---关闭商城
function UIOperator:CloseStoreFrameUI() end;

---打开商城商品购买框
---* storeIndex   商品index  cfg_store商城表配置的id
---* limitStr 超出限制购买的提示
---@param storeIndex   number
---@param limitStr string
function UIOperator:OpenStoreDetailUI(storeIndex, limitStr) end;

---关闭商城商品购买框
function UIOperator:CloseStoreDetailUI() end;

---打开技能配置界面
---* data   对应技能数据 打开技能快捷键配置页
---@param data   table    
function UIOperator:OpenSkillSettingUI(data) end;

---关闭技能配置界面
function UIOperator:CloseSkillSettingUI() end;

---打开社交界面
---* page   页签ID ( 不填默认1附近 )<br> 1附近玩家、2组队、3好友、4邮件
---@param page   number
function UIOperator:OpenSocialUI(page) end;

---关闭社交界面
function UIOperator:CloseSocialUI() end;

---打开分辨率修改界面(PC端)
function UIOperator:OpenResolutionSetUI() end;

---关闭分辨率修改界面(PC端)
function UIOperator:CloseResolutionSetUI() end;

---打开玩家角色界面
---* data   extent: 子页id<br> 1装备、2状态、3属性、4技能、6称号、11时装<br>isFast:  boolen 是否快捷键打开
---@param data   table    
function UIOperator:OpenMyPlayerUI(data) end;

---关闭玩家角色界面
function UIOperator:CloseMyPlayerUI() end;

---打开英雄角色界面
---* data   extent: 子页id<br> 1装备、2状态、3属性、4技能、6称号、11时装
---@param data   table    
function UIOperator:OpenMyHeroUI(data) end;

---关闭英雄角色界面
function UIOperator:CloseMyHeroUI() end;

---交易行查看他人界面
---* data   extent: 子页id<br> 1装备、2状态、3属性、4技能、6称号、11时装
---@param data   table    
function SL:CloseTradingBankHeroPageUI(data) end;

---打开首饰盒界面
---* param   param: <br>1: 自己人物<br>2：自己英雄<br>11：其他玩家人物<br>12：其他玩家英雄<br>21：交易行人物<br>22：交易行英雄
---@param param   number
function UIOperator:OpenBestRingBoxUI(param) end;

---关闭首饰盒界面
---* param   param: <br>1: 自己人物<br>2：自己英雄<br>11：其他玩家人物<br>12：其他玩家英雄<br>21：交易行人物<br>22：交易行英雄
---@param param   number
function UIOperator:CloseBestRingBoxUI(param) end;

---打开称号提示界面
---* data   id: 称号id <br> pos: Tips放置位置<br>type: 1未激活 2已激活<br>time: 时间
---@param data   table    
function UIOperator:OpenTitleTipsUI(data) end;

---关闭称号提示界面
function UIOperator:CloseTitleTipsUI() end;

---关闭交易行查看他人界面
function SL:CloseTradingBankLookInfoUI() end;

---打开邀请组队界面
function UIOperator:OpenTeamInvite() end;

---关闭邀请组队界面
function UIOperator:CloseTeamInvite() end;

---打开入队申请列表
function UIOperator:OpenTeamApply() end;

---关闭入队申请列表
function UIOperator:CloseTeamApply() end;

---打开小地图界面
function UIOperator:OpenMiniMap() end;

---关闭小地图界面
function UIOperator:CloseMiniMap() end;

---打开主界面技能按钮区域
---* param   param: <br>1: 自己人物<br>2：自己英雄<br>11：其他玩家人物<br>12：其他玩家英雄<br>21：交易行人物<br>22：交易行英雄
---@param param   number
function SL:OpenGuideEnter(param) end;

---关闭主界面技能按钮区域
function SL:CloseGuideEnter() end;

---打开转生点分配界面
function UIOperator:OpenReinAttrUI() end;

---关闭转生点分配界面
function UIOperator:CloseReinAttrUI() end;

---打开任务栏
function SL:OpenAssistUI() end;

---关闭任务栏
function SL:CloseAssistUI() end;

---打开主界面小地图收缩(手机端)
function SL:OpenMiniMapChangeUI() end;

---关闭主界面小地图收缩(手机端)
function SL:CloseMiniMapChangeUI() end;

---打开附近展示页
function UIOperator:OpenMainNearUI() end;

---关闭附近展示页
function UIOperator:CloseMainNearUI() end;

---直接调用支付
function SL:OpenCallPayUI() end;

---打开客服UI
function UIOperator:OpenKefuUI() end;

---打开PC端私聊界面
function UIOperator:OpenPCPrivateUI() end;

---关闭PC端私聊界面
function UIOperator:ClosePCPrivateUI() end;

---打开添加好友界面
function UIOperator:OpenAddFriendUI() end;

---关闭添加好友界面
function UIOperator:CloseAddFriendUI() end;

---打开添加黑名单界面
function UIOperator:OpenAddBlackListUI() end;

---关闭添加黑名单界面
function UIOperator:CloseAddBlackListUI() end;

---打开好友添加申请页
function UIOperator:OpenFriendApplyUI() end;

---关闭好友添加申请页
function UIOperator:CloseFriendApplyUI() end;

---打开拍卖行-世界拍卖/行会拍卖
---* param   1:世界拍卖<br> 2：行会拍卖 <br>3：我的竞拍 <br>4：我的上架  若隐藏行会拍卖  下标顺移 <br>即<br>2：我的竞拍 <br>3：我的上架
---@param param   number
function UIOperator:OpenAuctionUI(param) end;

---关闭拍卖行-世界拍卖/行会拍卖
function UIOperator:CloseAuctionUI() end;

---打开拍卖行上架界面
---* itemData   背包物品数据
---@param itemData   table    
function UIOperator:OpenAuctionPutinUI(itemData) end;

---关闭拍卖行上架界面
function UIOperator:CloseAuctionPutinUI() end;

---打开拍卖行下架界面
---* item   拍卖行上架的物品数据
---@param item   table    
function UIOperator:OpenAuctionPutoutUI(item) end;

---关闭拍卖行下架界面
function UIOperator:CloseAuctionPutoutUI() end;

---打开拍卖行竞拍界面
---* item   拍卖行上架的物品数据
---@param item   table    
function UIOperator:OpenAuctionBidUI(item) end;

---打开行会宣战/结盟框
function UIOperator:OpenGuildWarAllyUI() end;

---关闭角色装备
---* type   param: <br>1: 自己人物<br>2：自己英雄<br>11：其他玩家人物<br>12：其他玩家英雄<br>21：交易行人物<br>22：交易行英雄
---@param type   number
function UIOperator:CloseRoleEquipUI(type) end;

---打开 增加怪物类型 设置界面
function UIOperator:OpenAddMonsterTypeUI() end;

---关闭 增加怪物类型 设置界面
function UIOperator:CloseAddMonsterTypeUI() end;

---关闭拍卖行竞拍界面
function UIOperator:CloseAuctionBidUI() end;

---打开拍卖行一口价界面
---* item   拍卖行上架的物品数据
---@param item   table    
function UIOperator:OpenAuctionBuyUI(item) end;

---关闭拍卖行一口价界面
function UIOperator:CloseAuctionBuyUI() end;

---打开拍卖行超时界面
---* item   拍卖行上架的物品数据
---@param item   table    
function UIOperator:OpenAuctionTimeoutUI(item) end;

---关闭拍卖行超时界面
function UIOperator:CloseAuctionTimeoutUI() end;

---打开合成界面
function UIOperator:OpenCompoundItemUI() end;

---关闭合成界面
function UIOperator:CloseCompoundItemUI() end;

---打开怪物提示列表-设置界面
function UIOperator:OpenBossTipsUI() end;

---关闭怪物提示列表-设置界面
function UIOperator:CloseBossTipsUI() end;

---打开拾取列表-设置界面
function UIOperator:OpenPickSettingUI() end;

---关闭拾取列表-设置界面
function UIOperator:ClosePickSettingUI() end;

---打开仓库界面
---* data  pos 打开位置坐标<br>initPage 页签
---@param data  table  
function UIOperator:OpenNpcStorageUI(data) end;

---打开保护配置-设置界面
---* data   cfg_setup对应保护配置
---@param data   table    
function UIOperator:OpenProtectSettingUI(data) end;

---关闭保护配置-设置界面
function UIOperator:CloseProtectSettingUI() end;

---打开增加怪物名字-设置界面
---* data   ignoreName:  boolean 是否是挂机忽略名字
---@param data   table    
function UIOperator:OpenAddMonsterNameUI(data) end;

---关闭增加怪物名字-设置界面
function UIOperator:CloseAddMonsterNameUI() end;

---打开增加BOSS类型-设置界面
function UIOperator:OpenAddMonsterTypeUI() end;

---关闭增加BOSS类型-设置界面
function UIOperator:CloseAddMonsterTypeUI() end;

---打开技能排行-设置界面
---* data   cfg_setup对应保护配置
---@param data   table    
function UIOperator:OpenSkillRankPanelUI(data) end;

---关闭技能排行-设置界面
function UIOperator:CloseSkillRankPanelUI() end;

---打开新增技能-设置界面
function UIOperator:OpenSkillPanelUI() end;

---关闭新增技能-设置界面
function UIOperator:CloseSkillPanelUI() end;

---打开选择下拉框
---* list   下拉要显示的内容
---* position 初始位置 
---* cellwidth 单条cell的宽
---* cellheight 单条cell的高
---* func   回调 选中的编号1~n 0是关闭
---* extraData   额外数据
---@param list   table    
---@param position table   
---@param cellwidth number
---@param cellheight number
---@param func   function 
---@param extraData   table 
function UIOperator:OpenCommonSelectListUI(list, position, cellwidth, cellheight, func, extraData) end;

---关闭选择下拉框
function UIOperator:CloseCommonSelectListUI() end;

---打开996盒子界面
---* index 盒子打开默认分页id<br>1: 特权称号 2: 每日礼包 3: 超级礼包 4: 会员礼包 5: SVIP
---@param index number
function UIOperator:OpenBox996UI(index) end;

---关闭996盒子界面
function UIOperator:CloseBox996UI() end;

---打开英雄状态选择界面
---* data  pos<br>mode 1选择状态 2单击切换 3不能点击,滑动
---@param data  table  
function UIOperator:OpenHeroStateSelectUI(data) end;

---关闭英雄状态选择界面
function UIOperator:CloseHeroStateSelectUI() end;

---打开快捷使用框
---* itemData  真实物品数据
---* equipPos  物品为装备时装戴的装备位置
---* isBook    是否是技能书
---* isHero    是否为英雄
---@param itemData  table  
---@param equipPos  number
---@param isBook    boolean
---@param isHero    boolean
function UIOperator:OpenAutoUsePopUI(itemData, equipPos, isBook, isHero) end;

---关闭快捷使用框
---* makeIndex 物品唯一ID
---* isHero    是否为英雄
---@param makeIndex number
---@param isHero    boolean
function UIOperator:CloseAutoUsePopUI(makeIndex, isHero) end;

---打开开宝箱动画页
---* itemData  宝箱物品数据
---@param itemData  table  
function UIOperator:OpenTreasure(itemData) end;

---关闭开宝箱动画页
function UIOperator:CloseTreasure() end;

---打开宝箱奖励界面
---* itemData  宝箱物品数据
---@param itemData  table  
function UIOperator:OpenGoldBox(itemData) end;

---关闭宝箱奖励界面
function UIOperator:CLoseGoldBox() end;

---打开摇骰子界面
---* data      字段说明
---@param data      table  
function UIOperator:OpenPlayDiceUI(data) end;

---关闭要骰子界面
function UIOperator:ClosePlayDiceUI() end;

---打开求购界面
function UIOperator:OpenPurchaseUI() end;

---关闭求购界面
function UIOperator:ClosePurchaseUI() end;

---打开求购出售页
---* data   单条世界求购数据
---@param data   table    
function UIOperator:OpenPurchaseSellUI(data) end;

---关闭求购出售页
function UIOperator:ClosePurchaseSellUI() end;

---打开求购上架页
function UIOperator:OpenPurchasePutInUI() end;

---关闭求购上架页
function UIOperator:ClosePurchasePutInUI() end;

---打开通用描述Tips
---* data   str: 描述内容 <br> worldPos: 提示位置<br> width: 描述内容宽度<br> anchorPoint: 锚点<br>formatWay: 设置为1 解析富文本格式: `<font></font>`[！否则默认解析老脚本富文本`<RText/FCOLOR=254>`] 
---@param data   table    
function UIOperator:OpenCommonDescTipsUI(data) end;

---关闭通用描述Tips
function SL:CloseCommonDescTipsUI() end;

---打开通用弹窗
---* data   str: 文本<br>btnType: 按钮类型 int 1:&quot;确定&quot; 2:{&quot;确定&quot;,&quot;取消&quot;} <br> btnDesc: 按钮描述 table<br> showEdit: 是否显示输入框<br>editParams: 输入框参数table <br>```{ inputMode: 键盘编辑类型, maxLength: 可输入最大长度, str: 默认文本内容}```<br> callback: 按钮回调 [参数1: 点击的按钮id 参数2: 额外参数
---@param data   table    
function UIOperator:OpenCommonTipsUI(data) end;

---关闭通用弹窗
function SL:CloseCommonTipsUI() end;

---道具装备Tips
---* data   itemData: 物品数据 <br> pos: 提示位置<br> from:非必要 物品来自(界面位置)
---@param data   table    
function UIOperator:OpenItemTips(data) end;

---关闭道具装备Tips
function UIOperator:CloseItemTips() end;

---打开道具拆分弹窗
---* itemData   物品数据
---@param itemData   table    
function UIOperator:OpenTipsSplit(itemData) end;

---关闭道具拆分弹窗
function UIOperator:CloseTipsSplit() end;

---打开通用功能选择提示
---* data   参数说明: <br> type : 类型 可参照元变量DOCKTYPE_NENUM<br> targetId : 选中目标id<br> targetName :目标名称 <br> pos : 展示位置
---@param data   table    
function UIOperator:OpenFuncDockTips(data) end;

---关闭通用功能选择提示
function UIOperator:CloseFuncDockTips() end;

---打开NPC进度条提示
---* data   参数说明: <br> time : 时间 <br> msg : 显示内容
---@param data   table    
function UIOperator:OpenProgressBarUI(data) end;

---关闭NPC进度条提示
function UIOperator:CloseProgressBarUI() end;

---打开多条选项弹窗提示
---* data   参数说明: <br> pos : 坐标 <br> list : 多条选项列表<br>[单条数据参考: <br>{str = 文本, agreeCall = 同意按钮回调(function), disAgreeCall = 拒绝回调(function)}<br>]
---@param data   table    
function UIOperator:OpenCommonBubbleInfo(data) end;

---关闭多条选项弹窗提示
function UIOperator:CloseCommonBubbleInfo() end;

---打开好评有礼
function UIOperator:OpenReviewGift() end;

---打开网址/链接
---* url   网址/链接
---@param url   string
function SL:OpenURL(url) end;





LUA_EVENT_ROLE_PROPERTY_INITED      = "LUA_EVENT_ROLE_PROPERTY_INITED"          -- 玩家角色属性初始化完毕
LUA_EVENT_ROLE_PROPERTY_CHANGE      = "LUA_EVENT_ROLE_PROPERTY_CHANGE"          -- 玩家属性变化时

LUA_EVENT_LEVEL_CHANGE              = "LUA_EVENT_LEVEL_CHANGE"                 	-- 等级改变
LUA_EVENT_HERO_LEVEL_CHANGE         = "LUA_EVENT_HERO_LEVEL_CHANGE"            	-- 英雄等级改变
LUA_EVENT_REINLEVEL_CHANGE          = "LUA_EVENT_REINLEVEL_CHANGE"              -- 转生等级改变
LUA_EVENT_HERO_REINLEVEL_CHANGE     = "LUA_EVENT_HERO_REINLEVEL_CHANGE"         -- 英雄转生等级改变
LUA_EVENT_HPMP_CHANGE               = "LUA_EVENT_HPMP_CHANGE"                   -- HP/MP改变
LUA_EVENT_HERO_HPMP_CHANGE          = "LUA_EVENT_HERO_HPMP_CHANGE"              -- 英雄HP/MP改变
LUA_EVENT_EXP_CHANGE                = "LUA_EVENT_EXP_CHANGE"                    -- EXP改变
LUA_EVENT_HERO_EXP_CHANGE           = "LUA_EVENT_HERO_EXP_CHANGE"               -- 英雄EXP改变
LUA_EVENT_BATTERY_CHANGE            = "LUA_EVENT_BATTERY_CHANGE"                -- 电池电量改变
LUA_EVENT_NET_CHANGE                = "LUA_EVENT_NET_CHANGE"                    -- 网络状态改变
LUA_EVENT_WEIGHT_CHANGE             = "LUA_EVENT_WEIGHT_CHANGE"                 -- 负重改变

LUA_EVENT_PKMODE_CHANGE             = "LUA_EVENT_PKMODE_CHANGE"                 -- pk模式改变

LUA_EVENT_THROW_DAMAGE				= "LUA_EVENT_THROW_DAMAGE"				    -- 飘血

LUA_EVENT_AFKBEGIN                  = "LUA_EVENT_AFKBEGIN"                      -- 自动挂机开始
LUA_EVENT_AFKEND                    = "LUA_EVENT_AFKEND"                        -- 自动挂机结束
LUA_EVENT_AUTOMOVEBEGIN             = "LUA_EVENT_AUTOMOVEBEGIN"                 -- 自动寻路开始
LUA_EVENT_AUTOMOVEEND               = "LUA_EVENT_AUTOMOVEEND"                   -- 自动寻路结束
LUA_EVENT_AUTOPICKBEGIN             = "LUA_EVENT_AUTOPICKBEGIN"                 -- 自动捡物开始
LUA_EVENT_AUTOPICKEND               = "LUA_EVENT_AUTOPICKEND"                   -- 自动捡物结束

LUA_EVENT_MAIN_PICKUP_SHOW			= "LUA_EVENT_MAIN_PICKUP_SHOW"				-- 拾取按钮是否显示

LUA_EVENT_MAINPLAYER_BUFF_UPDATE    = "LUA_EVENT_MAINPLAYER_BUFF_UPDATE"     	-- 主玩家buff刷新
LUA_EVENT_BUFF_UPDATE              	= "LUA_EVENT_BUFF_UPDATE"                	-- 通用buff刷新

LUA_EVENT_TALKTONPC                 = "LUA_EVENT_TALKTONPC"                     -- 与NPC对话

LUA_EVENT_CHANGESCENE               = "LUA_EVENT_CHANGESCENE"                   -- 切换地图(包含同地图)
LUA_EVENT_MAP_INFO_CHANGE           = "LUA_EVENT_MAP_INFO_CHANGE"              	-- 切换地图(不同地图)
LUA_EVENT_MAP_INFO_INIT            	= "LUA_EVENT_MAP_INFO_INIT"                	-- 初始化地图
LUA_EVENT_MAP_STATE_CHANGE          = "LUA_EVENT_MAP_STATE_CHANGE"              -- 地图状态改变
LUA_EVENT_MAP_SIEGEAREA_CHANGE      = "LUA_EVENT_MAP_SIEGEAREA_CHANGE"          -- 是否进入攻城区域状态改变

LUA_EVENT_CLOSEWIN                  = "LUA_EVENT_CLOSEWIN"                      -- 关闭界面

LUA_EVENT_WINDOW_CHANGE             = "LUA_EVENT_WINDOW_CHANGE"                 -- 窗体尺寸改变时
LUA_EVENT_DEVICE_ROTATION_CHANGED   = "LUA_EVENT_DEVICE_ROTATION_CHANGED"       -- 设备方向改变

LUA_EVENT_MONEY_CHANGE               = "LUA_EVENT_MONEY_CHANGE"                   -- 货币变化时

LUA_EVENT_GUILD_JOIN_STATE_CHANGE	= "LUA_EVENT_GUILD_JOIN_STATE_CHANGE"		-- 加入行会状态改变
LUA_EVENT_GUILD_MAIN_INFO           = "LUA_EVENT_GUILD_MAIN_INFO"               -- 行会信息
LUA_EVENT_GUILD_MEMBER_LIST			= "LUA_EVENT_GUILD_MEMBER_LIST"				-- 行会成员列表
LUA_EVENT_GUILD_WORLDLIST           = "LUA_EVENT_GUILD_WORLDLIST"               -- 世界行会列表
LUA_EVENT_GUILD_CHILD_REMOVE		= "LUA_EVENT_GUILD_CHILD_REMOVE"			-- 行会子界面移除
LUA_EVENT_GUILD_CREATE_SUCCESS      = "LUA_EVENT_GUILD_CREATE_SUCCESS"          -- 行会创建成功
LUA_EVENT_GUILD_JOIN_SUCCESS		= "LUA_EVENT_GUILD_JOIN_SUCCESS"			-- 加入行会成功
LUA_EVENT_GUILD_APPLYLIST           = "LUA_EVENT_GUILD_APPLYLIST"               -- 入会申请列表
LUA_EVENT_GUILD_APPLY_ALLY_LIST 	= "LUA_EVENT_GUILD_APPLY_ALLY_LIST"     	-- 申请结盟列表
LUA_EVENT_GUILD_NOTICE_UPDATE		= "LUA_EVENT_GUILD_NOTICE_UPDATE"			-- 行会公告更新
LUA_EVENT_GUILD_ALLY_WAR_LIST		= "LUA_EVENT_GUILD_ALLY_WAR_LIST"			-- 联盟战争列表刷新
LUA_EVENT_GUILD_ALL_WAR_UPDATE		= "LUA_EVENT_GUILD_ALL_WAR_UPDATE"			-- 单行会联盟战争数据刷新
LUA_EVENT_GUILD_OPERATE_ERROR		= "LUA_EVENT_GUILD_OPERATE_ERROR"			-- 行会操作提示
LUA_EVENT_GUILD_SUB_MEMBER_SUCCESS  = "LUA_EVENT_GUILD_SUB_MEMBER_SUCCESS"		-- 行会删除成员成功
LUA_EVENT_GUILD_APPOINT_RANK_SUCCESS= "LUA_EVENT_GUILD_APPOINT_RANK_SUCCESS"	-- 任命成员职位成功
LUA_EVENT_GUILD_KICK_OUT			= "LUA_EVENT_GUILD_KICK_OUT"				-- 被踢出行会
LUA_EVENT_GUILD_QUIT_SUCCESS		= "LUA_EVENT_GUILD_QUIT_SUCCESS"			-- 退出行会成功
LUA_EVENT_GUILD_DISSOLVE			= "LUA_EVENT_GUILD_DISSOLVE"				-- 行会解散
LUA_EVENT_GUILD_AUTO_JOIN_STATE		= "LUA_EVENT_GUILD_AUTO_JOIN_STATE"			-- 行会自动加入状态
LUA_EVENT_GUILD_MEMBER_APPLY		= "LUA_EVENT_GUILD_MEMBER_APPLY"			-- 收到申请加入行会申请
LUA_EVENT_GUILD_ALLY_APPLY			= "LUA_EVENT_GUILD_ALLY_APPLY"				-- 收到行会联盟申请
LUA_EVENT_GUILD_JOIN_INVITE			= "LUA_EVENT_GUILD_JOIN_INVITE"				-- 收到行会加入邀请

LUA_EVENT_TRADE_REQUEST_ERROR_TIPS  = "LUA_EVENT_TRADE_REQUEST_ERROR_TIPS"      -- xx请求和你交易错误弹窗
LUA_EVENT_TRADE_FAIL_ERROR_TIPS     = "LUA_EVENT_TRADE_FAIL_ERROR_TIPS"        	-- 交易失败错误弹窗
LUA_EVENT_TRADE_CANCELED    		= "LUA_EVENT_TRADE_CANCELED"        	    -- 交易 被取消
LUA_EVENT_TRADE_TARGET_MONEY_CHANGE = "LUA_EVENT_TRADE_TARGET_MONEY_CHANGE" 	-- 对方交易货币改变
LUA_EVENT_TRADE_MYSELF_MONEY_CHANGE = "LUA_EVENT_TRADE_MYSELF_MONEY_CHANGE"     -- 自己交易货币改变
LUA_EVENT_TRADE_STATUS_CHANGE       = "LUA_EVENT_TRADE_STATUS_CHANGE"           -- 对方交易状态改变
LUA_EVENT_TRADE_MY_STATUS_CHANGE    = "LUA_EVENT_TRADE_MY_STATUS_CHANGE"        -- 自己交易状态改变
LUA_EVENT_TRADE_TRADER_ITEM_CHANGE  = "LUA_EVENT_TRADE_TRADER_ITEM_CHANGE"      --对方放入和取出物品消息  
LUA_EVENT_TRADE_MYSELF_ITEM_CHANGE  = "LUA_EVENT_TRADE_MYSELF_ITEM_CHANGE"      --自己放入和取出物品结果  
LUA_EVENT_TRADE_UNLOCK_OPERATION    = "LUA_EVENT_TRADE_UNLOCK_OPERATION"        --请解锁后再操作
LUA_EVENT_TRADE_STALL_FORBID        = "LUA_EVENT_TRADE_STALL_FORBID"            --摆摊中禁止操作
LUA_EVENT_TRADE_TARGET_MONEY_CHANGE_AUDIO = "LUA_EVENT_TRADE_TARGET_MONEY_CHANGE_AUDIO" --交易对方金币改变播放音效
--气泡
LUA_EVENT_TRADE_BUBBLE_TIPS_CHANGE  = "LUA_EVENT_TRADE_BUBBLE_TIPS_CHANGE"		--交易气泡提醒

LUA_EVENT_FIRE_WORK_HALL_SHOW		= "LUA_EVENT_FIRE_WORK_HALL_SHOW"            -- 烟花特效

-- 进入游戏公告
LUA_EVENT_GAME_WORLD_CONFIRM_UPDATE = "LUA_EVENT_GAME_WORLD_CONFIRM_UPDATE"		--更新世界公告内容

--背包里开宝箱
LUA_EVENT_GOLD_BOX_OPEN_ANIM    	= "LUA_EVENT_GOLD_BOX_OPEN_ANIM"			--开宝箱动画
LUA_EVENT_GOLD_BOX_REFRESH    	    = "LUA_EVENT_GOLD_BOX_REFRESH"				--刷新宝箱

LUA_EVENT_TREASUREBOX_DATA_REFRESH	= "LUA_EVENT_TREASUREBOX_DATA_REFRESH"		-- 宝箱数据刷新	

LUA_EVENT_SIGHT_BEAD_HIDE			= "LUA_EVENT_SIGHT_BEAD_HIDE" 				-- 隐藏准星 
LUA_EVENT_SIGHT_BEAD_SHOW 			= "LUA_EVENT_SIGHT_BEAD_SHOW"				-- 显示准星

LUA_EVENT_LAYER_MOVED_BEGIN			= "LUA_EVENT_LAYER_MOVED_BEGIN"				-- 开始拖动
LUA_EVENT_LAYER_MOVED_MOVING		= "LUA_EVENT_LAYER_MOVED_MOVING"			-- 更新拖动
LUA_EVENT_LAYER_MOVED_END			= "LUA_EVENT_LAYER_MOVED_END"				-- 结束拖动
LUA_EVENT_LAYER_MOVED_CANCEL		= "LUA_EVENT_LAYER_MOVED_CANCEL"			-- 取消拖动
LUA_EVENT_LAYER_MOVED_UP_DATA		= "LUA_EVENT_LAYER_MOVED_UP_DATA"			-- 更新部分数据

LUA_EVENT_RTOUCH_STATE_CHANGE		= "LUA_EVENT_RTOUCH_STATE_CHANGE"

LUA_EVENT_BAG_ITEM_MOVE_CANCEL		= "LUA_EVENT_BAG_ITEM_MOVE_CANCEL"			-- 背包道具移动取消
LUA_EVENT_BAG_ITEM_LIST_REFRESH    	= "LUA_EVENT_BAG_ITEM_LIST_REFRESH"         -- 刷新背包道具列表
LUA_EVENT_BAG_ITEM_CHANGE           = "LUA_EVENT_BAG_ITEM_CHANGE"               -- 背包数据发生变化时
LUA_EVENT_BAG_ITEM_POS_CHANGE       = "LUA_EVENT_BAG_ITEM_POS_CHANGE"           -- 背包道具位置发生变化时
LUA_EVENT_BAGLAYER_POS_CHANGE      	= "LUA_EVENT_BAGLAYER_POS_CHANGE"           -- 背包界面位置发生变化时
LUA_EVENT_BAG_STATE_CHANGE			= "LUA_EVENT_BAG_STATE_CHANGE"				-- 背包状态改变
LUA_EVENT_BAG_ITEM_COLLIMATOR		= "LUA_EVENT_BAG_ITEM_COLLIMATOR"			-- 道具开启准星
LUA_EVENT_BAG_ITEM_CHOOSE_STATE		= "LUA_EVENT_BAG_ITEM_CHOOSE_STATE"			-- 批量勾选背包物品

LUA_EVENT_HERO_BAG_ITEM_POS_CHANGE  = "LUA_EVENT_HERO_BAG_ITEM_POS_CHANGE"      -- 英雄背包道具位置发生变化时

LUA_EVENT_PLAYER_EQUIP_CHANGE       = "LUA_EVENT_PLAYER_EQUIP_CHANGE"           -- 角色装备数据操作
LUA_EVENT_HERO_EQUIP_CHANGE         = "LUA_EVENT_HERO_EQUIP_CHANGE"             -- 英雄装备变化
LUA_EVENT_NPC_STORAGE_CLOSE	        = "LUA_EVENT_NPC_STORAGE_CLOSE"				-- npc仓库界面 关闭

LUA_EVENT_EQUIP_STATE_CHANGE        = "LUA_EVENT_EQUIP_STATE_CHANGE"            -- 装备状态改变
LUA_EVENT_HERO_STATE_CHANGE   		= "LUA_EVENT_HERO_STATE_CHANGE"       		-- 英雄装备状态改变

LUA_EVENT_PLAYER_EMBATTLE_CHANGE	= "LUA_EVENT_PLAYER_EMBATTLE_CHANGE"		-- 装备法阵
LUA_EVENT_HERO_EMBATTLE_CHANGE		= "LUA_EVENT_HERO_EMBATTLE_CHANGE"			-- 英雄装备法阵

LUA_EVENT_HERO_BAG_ITEM_LIST_REFRESH= "LUA_EVENT_HERO_BAG_ITEM_LIST_REFRESH"    -- 刷新英雄背包道具列表
LUA_EVENT_HERO_BAG_ITEM_CHANGE      = "LUA_EVENT_HERO_BAG_ITEM_CHANGE"			-- 英雄背包数据发生变化时
LUA_EVENT_HERO_BAG_STATE_CHANGE		= "LUA_EVENT_HERO_BAG_STATE_CHANGE"			-- 英雄背包状态改变
LUA_EVENT_ITEM_MOVE_BEGIN_HERO_BAG_POS_CHANGE = "LUA_EVENT_ITEM_MOVE_BEGIN_HERO_BAG_POS_CHANGE"


LUA_EVENT_DISCONNECT                = "LUA_EVENT_DISCONNECT"                    -- 断线
LUA_EVENT_RECONNECT                 = "LUA_EVENT_RECONNECT"                     -- 重连

LUA_EVENT_TAKE_ON_EQUIP             = "LUA_EVENT_TAKE_ON_EQUIP"                 -- 玩家穿戴装备
LUA_EVENT_TAKE_OFF_EQUIP            = "LUA_EVENT_TAKE_OFF_EQUIP"                -- 玩家脱掉装备

LUA_EVENT_HERO_TAKE_ON_EQUIP        = "LUA_EVENT_HERO_TAKE_ON_EQUIP"            -- 英雄穿戴装备
LUA_EVENT_HERO_TAKE_OFF_EQUIP       = "LUA_EVENT_HERO_TAKE_OFF_EQUIP"           -- 英雄脱掉装备

LUA_EVENT_SETTING_CHANGE            = "LUA_EVENT_SETTING_CHANGE"                -- 设置项发生变化

LUA_EVENT_ACTOR_IN_OF_VIEW          = "LUA_EVENT_ACTOR_IN_OF_VIEW"              -- 进视野
LUA_EVENT_ACTOR_OUT_OF_VIEW         = "LUA_EVENT_ACTOR_OUT_OF_VIEW"             -- 出视野

LUA_EVENT_DROPITEM_IN_OF_VIEW       = "LUA_EVENT_DROPITEM_IN_OF_VIEW"           -- 掉落物进视野
LUA_EVENT_DROPITEM_OUT_OF_VIEW      = "LUA_EVENT_DROPITEM_OUT_OF_VIEW"          -- 掉落物出视野

LUA_EVENT_TARGET_CHANGE             = "LUA_EVENT_TARGET_CHANGE"                 -- 目标发生变化 
LUA_EVENT_ACTOR_OWNER_CHANGE        = "LUA_EVENT_ACTOR_OWNER_CHANGE"            -- 归属变化
LUA_EVENT_ACTOR_HP_REFRESH			= "LUA_EVENT_ACTOR_HP_REFRESH"				-- HP变化

LUA_EVENT_HERO_ANGER_CHANGE         = "LUA_EVENT_HERO_ANGER_CHANGE"             -- 英雄怒气改变 

LUA_EVENT_PLAYER_ACTION_BEGIN       = "LUA_EVENT_PLAYER_ACTION_BEGIN"           -- 主玩家行为状态改变（站立、走、跑等） 
LUA_EVENT_PLAYER_ACTION_COMPLETE    = "LUA_EVENT_PLAYER_ACTION_COMPLETE"        -- 主玩家行为状态改变（站立、走、跑等） 
LUA_EVENT_NET_PLAYER_ACTION_BEGIN   = "LUA_EVENT_NET_PLAYER_ACTION_BEGIN"       -- 网络玩家行为状态改变（站立、走、跑等） 
LUA_EVENT_NET_PLAYER_ACTION_COMPLETE= "LUA_EVENT_NET_PLAYER_ACTION_COMPLETE"    -- 网络玩家行为状态改变（站立、走、跑等） 
LUA_EVENT_MONSTER_ACTION_BEGIN      = "LUA_EVENT_MONSTER_ACTION_BEGIN"          -- 怪物行为状态改变（站立、走、跑等） 
LUA_EVENT_MONSTER_ACTION_COMPLETE   = "LUA_EVENT_MONSTER_ACTION_COMPLETE"       -- 怪物行为状态改变（站立、走、跑等） 
LUA_EVENT_ACTOR_GMDATA_UPDATE       = "LUA_EVENT_ACTOR_GMDATA_UPDATE"           -- 玩家/怪物 GM数据改变

LUA_EVENT_SKILL_INIT                = "LUA_EVENT_SKILL_INIT"                    -- 初始化技能
LUA_EVENT_SKILL_ADD                 = "LUA_EVENT_SKILL_ADD"                     -- 获得技能
LUA_EVENT_SKILL_DEL                 = "LUA_EVENT_SKILL_DEL"                     -- 删除技能
LUA_EVENT_SKILL_UPDATE              = "LUA_EVENT_SKILL_UPDATE"                  -- 更新技能

LUA_EVENT_HERO_SKILL_ADD            = "LUA_EVENT_HERO_SKILL_ADD"                -- 英雄新增普通技能
LUA_EVENT_HERO_SKILL_DEL            = "LUA_EVENT_HERO_SKILL_DEL"                -- 英雄删除普通技能
LUA_EVENT_HERO_SKILL_UPDATE         = "LUA_EVENT_HERO_SKILL_UPDATE"             -- 英雄技能更新

LUA_EVENT_SUMMON_MODE_CHANGE        = "LUA_EVENT_SUMMON_MODE_CHANGE"            -- 召唤物 状态改变
LUA_EVENT_SUMMON_ALIVE_CHANGE       = "LUA_EVENT_SUMMON_ALIVE_CHANGE"           -- 召唤物 存活状态改变

LUA_EVENT_BUBBLETIPS_STATUS_CHANGE  = "LUA_EVENT_BUBBLETIPS_STATUS_CHANGE"      -- 气泡状态改变
LUA_EVENT_PLAY_MAGICBALL_EFFECT     = "LUA_EVENT_PLAY_MAGICBALL_EFFECT"         -- 脚本魔血球动画
LUA_EVENT_AUTOFIGHT_TIPS_SHOW       = "LUA_EVENT_AUTOFIGHT_TIPS_SHOW"           -- 自动战斗提示显示与否
LUA_EVENT_AUTOMOVE_TIPS_SHOW        = "LUA_EVENT_AUTOMOVE_TIPS_SHOW"            -- 自动寻路提示显示与否
LUA_EVENT_REIN_ATTR_CHANGE          = "LUA_EVENT_REIN_ATTR_CHANGE"              -- 转生点数据变化

LUA_EVENT_ASSIST_MISSION_SHOW		= "LUA_EVENT_ASSIST_MISSION_SHOW"			-- 主界面-任务内容显示与否
LUA_EVENT_ASSIST_HIDESTATUS_CHANGE  = "LUA_EVENT_ASSIST_HIDESTATUS_CHANGE"      -- 主界面-任务栏显示和收缩状态改变
LUA_EVENT_TASK_TO_TOP               = "LUA_EVENT_TASK_TO_TOP"                   -- 主界面-辅助-任务置顶
LUA_EVENT_TASK_ADD                  = "LUA_EVENT_TASK_ADD"                      -- 主界面-辅助-任务增加
LUA_EVENT_TASK_CHANGE     			= "LUA_EVENT_TASK_CHANGE"         			-- 主界面-辅助-任务改变
LUA_EVENT_TASK_DEL                  = "LUA_EVENT_TASK_DEL"                      -- 主界面-辅助-任务移除
LUA_EVENT_TEAM_MEMBER_UPDATE        = "LUA_EVENT_TEAM_MEMBER_UPDATE"            -- 主界面-辅助-队伍刷新
LUA_EVENT_TEAM_NEAR_UPDATE          = "LUA_EVENT_TEAM_NEAR_UPDATE"              -- 附近队伍刷新
LUA_EVENT_TEAM_APPLY_UPDATE         = "LUA_EVENT_TEAM_APPLY_UPDATE"             -- 申请入队列表刷新

LUA_EVENT_RANK_PLAYER_UPDATE        = "LUA_EVENT_RANK_PLAYER_UPDATE"            -- 排行榜个人数据刷新
LUA_EVENT_RANK_DATA_UPDATE          = "LUA_EVENT_RANK_DATA_UPDATE"              -- 排行榜分类数据刷新

LUA_EVENT_BIND_MAINPLAYER           = "LUA_EVENT_BIND_MAINPLAYER"               -- 绑定主玩家
LUA_EVENT_PLAYER_MAPPOS_CHANGE      = "LUA_EVENT_PLAYER_MAPPOS_CHANGE"          -- 主玩家位置改变

LUA_EVENT_FRIEND_LIST_UPDATE        = "LUA_EVENT_FRIEND_LIST_UPDATE"            -- 好友列表刷新
LUA_EVENT_FRIEND_APPLY              = "LUA_EVENT_FRIEND_APPLY"                  -- 好友申请
LUA_EVENT_BLACK_LIST_UPDATE			= "LUA_EVENT_BLACK_LIST_UPDATE"				-- 黑名单列表刷新

-- 邮件
LUA_EVENT_MAIL_LIST_REFRESH         = "LUA_EVENT_MAIL_LIST_REFRESH"            	-- 邮件列表返回
LUA_EVENT_MAIL_DELETE_ALL_READ      = "LUA_EVENT_MAIL_DELETE_ALL_READ"          -- 邮件列表删除已读
LUA_EVENT_MAIL_UPDATE_ALL           = "LUA_EVENT_MAIL_UPDATE_ALL"               -- 邮件列表刷新
LUA_EVENT_MAIL_UPDATE               = "LUA_EVENT_MAIL_UPDATE"                   -- 邮件列表刷新
LUA_EVENT_MAIL_DELETE               = "LUA_EVENT_MAIL_DELETE"                   -- 邮件删除
LUA_EVENT_MAIL_NEW_NOTICE           = "LUA_EVENT_MAIL_NEW_NOTICE"               -- 邮件获得新邮件

LUA_EVENT_ITEMTIPS_MOUSE_SCROLL     = "LUA_EVENT_ITEMTIPS_MOUSE_SCROLL"         -- ITEMTIPS鼠标滚轮滚动

LUA_EVENT_MAIN_MINIMAP_SHOW_STATUS	= "LUA_EVENT_MAIN_MINIMAP_SHOW_STATUS"		-- 小地图显示状态改变
LUA_EVENT_MINIMAP_DOWNLOAD_SUCCESS  = "LUA_EVENT_MINIMAP_DOWNLOAD_SUCCESS"		-- 小地图下载成功

LUA_EVENT_MAIN_PLAYER_REVIVE        = "LUA_EVENT_MAIN_PLAYER_REVIVE"            -- 主玩家复活            
LUA_EVENT_NET_PLAYER_REVIVE         = "LUA_EVENT_NET_PLAYER_REVIVE"             -- 网络玩家复活
LUA_EVENT_MONSTER_REVIVE            = "LUA_EVENT_MONSTER_REVIVE"                -- 怪物复活
LUA_EVENT_MONSTER_BIRTH             = "LUA_EVENT_MONSTER_BIRTH"                 -- 怪物出生

LUA_EVENT_MAIN_PLAYER_DIE           = "LUA_EVENT_MAIN_PLAYER_DIE"               -- 主玩家死亡
LUA_EVENT_NET_PLAYER_DIE            = "LUA_EVENT_NET_PLAYER_DIE"                -- 网络玩家死亡
LUA_EVENT_MONSTER_DIE               = "LUA_EVENT_MONSTER_DIE"                   -- 怪物死亡
LUA_EVENT_MONSTER_CAVED				= "LUA_EVENT_MONSTER_CAVED"					-- 钻地下

LUA_EVENT_ACTOR_DIE					= "LUA_EVENT_ACTOR_DIE"						-- 死亡（包含所有actor）
LUA_EVENT_ACTOR_REVIVE				= "LUA_EVENT_ACTOR_REVIVE"					-- 死亡（包含所有actor）

LUA_EVENT_NPCLAYER_OPENSTATUS       = "LUA_EVENT_NPCLAYER_OPENSTATUS"           -- NPC界面打开或关闭
LUA_EVENT_NPC_TALK                  = "LUA_EVENT_NPC_TALK"                      -- NPC 说话 (打开NPC界面)
LUA_EVENT_NPC_TALK_CLOSE            = "LUA_EVENT_NPC_TALK_CLOSE"                -- NPC 界面关闭
LUA_EVENT_NPC_STORE_ITEM_REMOVE     = "LUA_EVENT_NPC_STORE_ITEM_REMOVE"         -- NPC 商城移除item
LUA_EVENT_NPC_SELL_REPAIRE_UPDATE   = "LUA_EVENT_NPC_SELL_REPAIRE_UPDATE"       -- NPC 更新出售修理界面
LUA_EVENT_NPC_MAKE_DRUG_SUCCESS     = "LUA_EVENT_NPC_MAKE_DRUG_SUCCESS"         -- NPC 药品研制成功
LUA_EVENT_NPC_MAKE_DRUG_FAILED      = "LUA_EVENT_NPC_MAKE_DRUG_FAILED"          -- NPC 药品研制失败
LUA_EVENT_NPC_STORE_BUY_RESULT_FAIL = "LUA_EVENT_NPC_STORE_BUY_RESULT_FAIL"     -- NPC 商店购买失败
LUA_EVENT_NPC_SELL_OPEN             = "LUA_EVENT_NPC_SELL_OPEN"                 -- NPC 出售界面开启
LUA_EVENT_NPC_MAKE_DRUG_OPEN        = "LUA_EVENT_NPC_MAKE_DRUG_OPEN"            -- NPC 炼药界面开启
LUA_EVENT_NPC_STORE_OPEN            = "LUA_EVENT_NPC_STORE_OPEN"                -- NPC 商店界面开启

LUA_EVENT_OPEN_PROGRESSBAR        	= "LUA_EVENT_OPEN_PROGRESSBAR"             	-- 收到打开进度条消息

LUA_EVENT_BESTRONG_BUTTON_REFRESH   = "LUA_EVENT_BESTRONG_BUTTON_REFRESH"      	-- 变强按钮刷新
LUA_EVENT_BESTRONG_LIST_REFRESH     = "LUA_EVENT_BESTRONG_LIST_REFRESH"         -- 变强列表刷新
LUA_EVENT_BESTRONG_CLOSE     		= "LUA_EVENT_BESTRONG_CLOSE"          		-- 变强关闭

-- 人物内功
LUA_EVENT_PLAYER_INTERNAL_FORCE_CHANGE  = "LUA_EVENT_PLAYER_INTERNAL_FORCE_CHANGE"  -- 内力值改变
LUA_EVENT_PLAYER_INTERNAL_EXP_CHANGE    = "LUA_EVENT_PLAYER_INTERNAL_EXP_CHANGE"    -- 内功经验值改变
LUA_EVENT_PLAYER_INTERNAL_LEVEL_CHANGE  = "LUA_EVENT_PLAYER_INTERNAL_LEVEL_CHANGE"  -- 内功等级改变
LUA_EVENT_INTERNAL_SKILL_ADD            = "LUA_EVENT_INTERNAL_SKILL_ADD"            -- 内功技能增加
LUA_EVENT_INTERNAL_SKILL_DEL            = "LUA_EVENT_INTERNAL_SKILL_DEL"            -- 内功技能删除
LUA_EVENT_INTERNAL_SKILL_UPDATE         = "LUA_EVENT_INTERNAL_SKILL_UPDATE"         -- 内功技能刷新
LUA_EVENT_PLAYER_LEARNED_INTERNAL       = "LUA_EVENT_PLAYER_LEARNED_INTERNAL"       -- 人物学习内功

LUA_EVENT_MERIDIAN_DATA_REFRESH         = "LUA_EVENT_MERIDIAN_DATA_REFRESH"         -- 内功经络数据刷新
LUA_EVENT_PLAYER_INTERNAL_DZVALUE_CHANGE= "LUA_EVENT_PLAYER_INTERNAL_DZVALUE_CHANGE"-- 内功斗转值改变/恢复

LUA_EVENT_PLAYER_COMBO_SKILL_ADD        = "LUA_EVENT_PLAYER_COMBO_SKILL_ADD"        -- 人物连击技能增加
LUA_EVENT_PLAYER_COMBO_SKILL_DEL        = "LUA_EVENT_PLAYER_COMBO_SKILL_DEL"        -- 人物连击技能删除
LUA_EVENT_PLAYER_COMBO_SKILL_UPDATE     = "LUA_EVENT_PLAYER_COMBO_SKILL_UPDATE"     -- 人物连击技能刷新
LUA_EVENT_PLAYER_SET_COMBO_REFRESH      = "LUA_EVENT_PLAYER_SET_COMBO_REFRESH"      -- 人物设置连击技能刷新
LUA_EVENT_PLAYER_COMBO_SKILLCD_STATE    = "LUA_EVENT_PLAYER_COMBO_SKILLCD_STATE"    -- 人物连击技能CD状态
LUA_EVENT_PLAYER_OPEN_COMBO_NUM         = "LUA_EVENT_PLAYER_OPEN_COMBO_NUM"         -- 人物开启连击个数

-- 英雄内功
LUA_EVENT_HERO_INTERNAL_FORCE_CHANGE    = "LUA_EVENT_HERO_INTERNAL_FORCE_CHANGE"    -- 内力值改变
LUA_EVENT_HERO_INTERNAL_EXP_CHANGE      = "LUA_EVENT_HERO_INTERNAL_EXP_CHANGE"      -- 内功经验值改变
LUA_EVENT_HERO_INTERNAL_LEVEL_CHANGE    = "LUA_EVENT_HERO_INTERNAL_LEVEL_CHANGE"    -- 内功等级改变
LUA_EVENT_HERO_INTERNAL_SKILL_ADD       = "LUA_EVENT_HERO_INTERNAL_SKILL_ADD"       -- 英雄内功技能增加
LUA_EVENT_HERO_INTERNAL_SKILL_DEL       = "LUA_EVENT_HERO_INTERNAL_SKILL_DEL"       -- 英雄内功技能删除
LUA_EVENT_HERO_INTERNAL_SKILL_UPDATE    = "LUA_EVENT_HERO_INTERNAL_SKILL_UPDATE"    -- 英雄内功技能刷新
LUA_EVENT_HERO_LEARNED_INTERNAL         = "LUA_EVENT_HERO_LEARNED_INTERNAL"         -- 英雄学习内功

LUA_EVENT_HERO_LOYAL_CHANGE				= "LUA_EVENT_HERO_LOYAL_CHANGE"				-- 英雄忠诚度改变
LUA_EVENT_HERO_CALL_BUTTON_SHOW			= "LUA_EVENT_HERO_CALL_BUTTON_SHOW"			-- 英雄召唤按钮显示与否

LUA_EVENT_HERO_DIE						= "LUA_EVENT_HERO_DIE"						-- 英雄死亡
LUA_EVENT_HERO_REVIVE					= "LUA_EVENT_HERO_REVIVE"					-- 英雄复活

LUA_EVENT_HERO_MERIDIAN_DATA_REFRESH    = "LUA_EVENT_HERO_MERIDIAN_DATA_REFRESH"    -- 英雄内功经络数据刷新
LUA_EVENT_HERO_INTERNAL_DZVALUE_CHANGE  = "LUA_EVENT_HERO_INTERNAL_DZVALUE_CHANGE"  -- 内功斗转值改变/恢复

LUA_EVENT_HERO_COMBO_SKILL_ADD          = "LUA_EVENT_HERO_COMBO_SKILL_ADD"          -- 英雄连击技能增加
LUA_EVENT_HERO_COMBO_SKILL_DEL          = "LUA_EVENT_HERO_COMBO_SKILL_DEL"          -- 英雄连击技能删除
LUA_EVENT_HERO_COMBO_SKILL_UPDATE       = "LUA_EVENT_HERO_COMBO_SKILL_UPDATE"       -- 英雄连击技能刷新
LUA_EVENT_HERO_SET_COMBO_REFRESH        = "LUA_EVENT_HERO_SET_COMBO_REFRESH"        -- 英雄设置连击技能刷新
LUA_EVENT_HERO_OPEN_COMBO_NUM           = "LUA_EVENT_HERO_OPEN_COMBO_NUM"           -- 英雄开启连击个数

LUA_EVENT_HERO_PROPERTY_CHANGE          = "LUA_EVENT_HERO_PROPERTY_CHANGE"          -- 英雄属性变化

-- 小地图
LUA_EVENT_MINIMAP_FIND_PATH             = "LUA_EVENT_MINIMAP_FIND_PATH"             -- 寻路路径
LUA_EVENT_MINIMAP_MONSTER               = "LUA_EVENT_MINIMAP_MONSTER"               -- 怪物坐标
LUA_EVENT_MINIMAP_PLAYER                = "LUA_EVENT_MINIMAP_PLAYER"                -- 人物坐标
LUA_EVENT_MINIMAP_TEAM                  = "LUA_EVENT_MINIMAP_TEAM"                  -- 队伍坐标
LUA_EVENT_OTHER_MAP_MONSTER				= "LUA_EVENT_OTHER_MAP_MONSTER"				-- 其他地图怪物数据

LUA_EVENT_MINIMAP_BEGIN               	= "LUA_EVENT_MINIMAP_BEGIN"                 -- 打开小地图

-- 消息
LUA_EVENT_NOTICE_SERVER                 = "LUA_EVENT_NOTICE_SERVER"                 -- 消息 服务 (Type4)
LUA_EVENT_NOTICE_SERVER_EVENT           = "LUA_EVENT_NOTICE_SERVER_EVENT"           -- 消息 服务 枚举值 (Type11)
LUA_EVENT_NOTICE_SYSYTEM                = "LUA_EVENT_NOTICE_SYSYTEM"                -- 消息 系统 跑马灯 (Type5)
LUA_EVENT_NOTICE_SYSYTEM_SCALE          = "LUA_EVENT_NOTICE_SYSYTEM_SCALE"          -- 消息 系统 顶端弹窗 (Type13)
LUA_EVENT_NOTICE_SYSYTEM_XY             = "LUA_EVENT_NOTICE_SYSYTEM_XY"             -- 消息 系统 设置XY 跑马灯 (Type10)
LUA_EVENT_NOTICE_SYSYTEM_TIPS           = "LUA_EVENT_NOTICE_SYSYTEM_TIPS"           -- 消息 系统 提示弹窗 警告
LUA_EVENT_NOTICE_TIMER                  = "LUA_EVENT_NOTICE_TIMER"                  -- 消息 提示 警告 (Type6)
LUA_EVENT_NOTICE_DELETE_TIMER           = "LUA_EVENT_NOTICE_DELETE_TIMER"           -- 消息 提示 警告 
LUA_EVENT_NOTICE_TIMER_XY               = "LUA_EVENT_NOTICE_TIMER_XY"               -- 消息 提示 警告 设置XY (Type14)
LUA_EVENT_NOTICE_DELETE_TIMER_XY        = "LUA_EVENT_NOTICE_DELETE_TIMER_XY"        -- 消息 提示 警告 设置XY (Type14)
LUA_EVENT_NOTICE_ITEM_TIPS              = "LUA_EVENT_NOTICE_ITEM_TIPS"              -- 飘字 物品拾取获得消耗
LUA_EVENT_NOTICE_ATTRIBUTE              = "LUA_EVENT_NOTICE_ATTRIBUTE"              -- 飘字 属性变化
LUA_EVENT_NOTICE_EXP                    = "LUA_EVENT_NOTICE_EXP"                    -- 飘字 经验值变化
LUA_EVENT_NOTICE_DROP                   = "LUA_EVENT_NOTICE_DROP"                   -- 飘字 掉落物品提示 (Type15)
LUA_EVENT_NOTICE_CHILD_ADD				= "LUA_EVENT_NOTICE_CHILD_ADD"				-- notice 添加子节点
LUA_EVENT_NOTICE_CHILD_REMOVE			= "LUA_EVENT_NOTICE_CHILD_REMOVE"			-- notice 移除子节点

-- 合成
LUA_EVENT_COMPOUND_RED_POINT            = "LUA_EVENT_COMPOUND_RED_POINT"            -- 合成红点
LUA_EVENT_COMPOUND_ITEM_RESULT         	= "LUA_EVENT_COMPOUND_ITEM_RESULT"         	-- 合成物品结果

-- richText
LUA_EVENT_RICHTEXT_OPEN_URL             = "LUA_EVENT_RICHTEXT_OPEN_URL"             -- 富文本超链(href)点击触发

LUA_EVENT_KF_STATUS_CHANGE              = "LUA_EVENT_KF_STATUS_CHANGE"              -- 跨服状态改变
LUA_EVENT_QUICKUSE_DATA_OPER            = "LUA_EVENT_QUICKUSE_DATA_OPER"            -- 快捷栏道具数据变动触发
LUA_EVENT_QUICKUSE_ITEM_REFRESH         = "LUA_EVENT_QUICKUSE_ITEM_REFRESH"         -- 快捷栏界面刷新

-- 游戏世界
LUA_EVENT_ENTER_WORLD                   = "LUA_EVENT_ENTER_WORLD"                   -- 进入游戏世界，主界面已经刷出来了
LUA_EVENT_LEAVE_WORLD                   = "LUA_EVENT_LEAVE_WORLD"                   -- 离开游戏世界 - 小退触发

-- 玩家状态刷新
LUA_EVENT_PLAYER_IN_SAFEZONE_CHANGE     = "LUA_EVENT_PLAYER_IN_SAFEZONE_CHANGE"     -- 主玩家安全区状态改变
LUA_EVENT_NET_PLAYER_IN_SAFEZONE_CHANGE = "LUA_EVENT_NET_PLAYER_IN_SAFEZONE_CHANGE" -- 网络玩家安全区状态改变

LUA_EVENT_PLAYER_STALL_STATUS_CHANGE 	= "LUA_EVENT_PLAYER_STALL_STATUS_CHANGE" 	-- 主玩家摆摊状态改变
LUA_EVENT_NET_PLAYER_STALL_STATUS_CHANGE= "LUA_EVENT_NET_PLAYER_STALL_STATUS_CHANGE"-- 网络玩家摆摊状态改变	

LUA_EVENT_PLAYER_HUSHEN_STATUS_CHANGE       = "LUA_EVENT_PLAYER_HUSHEN_STATUS_CHANGE"       -- 主玩家护身状态改变
LUA_EVENT_NET_PLAYER_HUSHEN_STATUS_CHANGE   = "LUA_EVENT_NET_PLAYER_HUSHEN_STATUS_CHANGE"   -- 网络玩家护身状态改变

LUA_EVENT_PLAYER_TEAM_STATUS_CHANGE     = "LUA_EVENT_PLAYER_TEAM_STATUS_CHANGE"     -- 主玩家组队状态改变
LUA_EVENT_NET_PLAYER_TEAM_STATUS_CHANGE = "LUA_EVENT_NET_PLAYER_TEAM_STATUS_CHANGE" -- 网络玩家组队状态改变

LUA_EVENT_MAIN_PLAYER_ACTION_ENDED      = "LUA_EVENT_MAIN_PLAYER_ACTION_ENDED"		-- 主玩家动作结束

-- 求购
LUA_EVENT_PURCHASE_ITEM_LIST_PULL       = "LUA_EVENT_PURCHASE_ITEM_LIST_PULL"       -- 求购列表返回
LUA_EVENT_PURCHASE_ITEM_LIST_COMPLETE   = "LUA_EVENT_PURCHASE_ITEM_LIST_COMPLETE"   -- 求购列表加载完成
LUA_EVENT_PURCHASE_SEARCH_ITEM_UPDATE   = "LUA_EVENT_PURCHASE_SEARCH_ITEM_UPDATE"   -- 求购搜索刷新
LUA_EVENT_PURCHASE_MYITEM_UPDATE        = "LUA_EVENT_PURCHASE_MYITEM_UPDATE"        -- 求购数据刷新(我的)
LUA_EVENT_PURCHASE_WORLDITEM_UPDATE     = "LUA_EVENT_PURCHASE_WORLDITEM_UPDATE"     -- 求购数据刷新(世界)

LUA_EVENT_FLYIN_BTN_ITEM_COMPLETE       = "LUA_EVENT_FLYIN_BTN_ITEM_COMPLETE"       -- item飞入指定按钮完成

LUA_EVENT_STORAGE_DATA_CHANGE           = "LUA_EVENT_STORAGE_DATA_CHANGE"           -- 仓库数据变动
LUA_EVENT_STORAGE_DATA_UPDATE           = "LUA_EVENT_STORAGE_DATA_UPDATE"           -- 仓库数据刷新
LUA_EVENT_STORAGE_ITEM_STATE            = "LUA_EVENT_STORAGE_ITEM_STATE"            -- 仓库状态
LUA_EVENT_STORAGE_SIZE_CHANGE           = "LUA_EVENT_STORAGE_SIZE_CHANGE"           -- 仓库格子数改变

-- 登录账号
LUA_EVENT_LOGIN_REGISTER_ACCOUNT_SUCCESS	= "LUA_EVENT_LOGIN_REGISTER_ACCOUNT_SUCCESS"	-- 账号注册成功
LUA_EVENT_LOGIN_ACCOUNT_SUCCESS				= "LUA_EVENT_LOGIN_ACCOUNT_SUCCESS"				-- 账号登录成功
LUA_EVENT_LOGIN_CHECK_TOKEN_SUCCESS			= "LUA_EVENT_LOGIN_CHECK_TOKEN_SUCCESS"			-- 账密效验成功
LUA_EVENT_LOGIN_CHECK_TOKEN_FAIL			= "LUA_EVENT_LOGIN_CHECK_TOKEN_FAIL"           	-- 账密效验失败
LUA_EVENT_LOGIN_CHANGE_PASSWORD_SUCCESS		= "LUA_EVENT_LOGIN_CHANGE_PASSWORD_SUCCESS"     -- 修改密码成功
LUA_EVENT_LOGIN_IDENTIFY_IDCARD_SUCCESS		= "LUA_EVENT_LOGIN_IDENTIFY_IDCARD_SUCCESS"     -- 实名认证成功
LUA_EVENT_LOGIN_CHANGE_MBQUESTION_SUCCESS	= "LUA_EVENT_LOGIN_CHANGE_MBQUESTION_SUCCESS"	-- 修改密保问题成功
LUA_EVENT_LOGIN_BIND_PHONE_SUCCESS			= "LUA_EVENT_LOGIN_BIND_PHONE_SUCCESS"			-- 绑定手机号成功
LUA_EVENT_LOGIN_CHANGE_BIND_PHONE_SUCCESS	= "LUA_EVENT_LOGIN_CHANGE_BIND_PHONE_SUCCESS"	-- 换绑手机号成功
LUA_EVENT_LOGIN_SHOW_IDENTIFY_UI			= "LUA_EVENT_LOGIN_SHOW_IDENTIFY_UI"			-- 实名认证界面显示
LUA_EVENT_LOGIN_SHOW_BIND_PHONE_UI			= "LUA_EVENT_LOGIN_SHOW_BIND_PHONE_UI"			-- 绑定手机号界面显示

-- 登录创角
LUA_EVENT_LOGIN_RAND_ROLE_NAME_REFRESH		= "LUA_EVENT_LOGIN_RAND_ROLE_NAME_REFRESH"		-- 创角随机角色名刷新
LUA_EVENT_LOGIN_DELETE_ROLE_SUCCESS			= "LUA_EVENT_LOGIN_DELETE_ROLE_SUCCESS"			-- 删除角色成功
LUA_EVENT_LOGIN_DELETE_ROLE_FAIL			= "LUA_EVENT_LOGIN_DELETE_ROLE_FAIL"			-- 删除角色失败
LUA_EVENT_LOGIN_CREATE_ROLE_SUCCESS			= "LUA_EVENT_LOGIN_CREATE_ROLE_SUCCESS"			-- 创建角色成功
LUA_EVENT_LOGIN_CREATE_ROLE_FAIL			= "LUA_EVENT_LOGIN_CREATE_ROLE_FAIL"			-- 创建角色失败
LUA_EVENT_LOGIN_RESTORE_ROLE_DATA_REFRESH	= "LUA_EVENT_LOGIN_RESTORE_ROLE_DATA_REFRESH"	-- 可恢复角色数据刷新
LUA_EVENT_LOGIN_SERVER_SUCCESS				= "LUA_EVENT_LOGIN_SERVER_SUCCESS"				-- 登录成功
LUA_EVENT_LOGIN_RESTORE_ROLE_SUCCESS		= "LUA_EVENT_LOGIN_RESTORE_ROLE_SUCCESS"		-- 恢复角色成功
LUA_EVENT_LOGIN_RESTORE_ROLE_FAIL			= "LUA_EVENT_LOGIN_RESTORE_ROLE_FAIL"			-- 恢复角色失败
LUA_EVENT_LOGIN_ROLE_INFO_DATA				= "LUA_EVENT_LOGIN_ROLE_INFO_DATA"				-- 登录角色数据
LUA_EVENT_LOGIN_ROLE_ENTER_GAME_DELAY		= "LUA_EVENT_LOGIN_ROLE_ENTER_GAME_DELAY"		-- 小退延迟进入游戏

-- 聊天
LUA_EVENT_CHAT_PANEL_CLOSE					= "LUA_EVENT_CHAT_PANEL_CLOSE"					-- 关闭聊天页
LUA_EVENT_CHAT_ENTER_CD						= "LUA_EVENT_CHAT_ENTER_CD"						-- 聊天进入CD
LUA_EVENT_CHAT_PRIVATE_TARGET				= "LUA_EVENT_CHAT_PRIVATE_TARGET"				-- 私聊对象
LUA_EVENT_CHAT_ITEM_ADD						= "LUA_EVENT_CHAT_ITEM_ADD"						-- 聊天页item新增

LUA_EVENT_CHATMINI_ITEM_ADD					= "LUA_EVENT_CHATMINI_ITEM_ADD"					-- 聊天主界面item新增
LUA_EVENT_CHAT_PCPRIVATE_ITEM_ADD			= "LUA_EVENT_CHAT_PCPRIVATE_ITEM_ADD"			-- PC私聊页item新增

LUA_EVENT_CHAT_MSG_ADD						= "LUA_EVENT_CHAT_MSG_ADD"						-- 聊天信息新增
LUA_EVENT_CHAT_PUSH_INPUT					= "LUA_EVENT_CHAT_PUSH_INPUT"					-- 聊天输入内容补充
LUA_EVENT_CHAT_REPLACE_INPUT				= "LUA_EVENT_CHAT_REPLACE_INPUT"				-- 聊天输入内容替换
LUA_EVENT_CHAT_TARGET_CHANGE				= "LUA_EVENT_CHAT_TARGET_CHANGE"				-- 聊天对象改变
LUA_EVENT_CHAT_EX_NOTICE_ADD				= "LUA_EVENT_CHAT_EX_NOTICE_ADD"				-- 聊天置顶消息新增	
LUA_EVENT_CHAT_FAKE_DROP_OPEN_STATUS		= "LUA_EVENT_CHAT_FAKE_DROP_OPEN_STATUS"		-- 设置聊天假掉落开关状态
LUA_EVENT_CHAT_FAKE_DROP_STATUS_CHANGE		= "LUA_EVENT_CHAT_FAKE_DROP_STATUS_CHANGE"		-- 聊天假掉落开关状态改变
LUA_EVENT_CHAT_DROP_MSG_ADD					= "LUA_EVENT_CHAT_DROP_MSG_ADD"					-- 聊天框掉落消息新增
LUA_EVENT_CHAT_FAKE_DROP_MSG_SPEED			= "LUA_EVENT_CHAT_FAKE_DROP_MSG_SPEED"			-- 假掉落速度变化
LUA_EVENT_CHAT_AUTO_SHOUT_DELAY_TIME		= "LUA_EVENT_CHAT_AUTO_SHOUT_DELAY_TIME"		-- 设置自动喊话间隙


LUA_EVENT_CHAT_CHANNEL_RECEIVIND_TIPS		= "LUA_EVENT_CHAT_CHANNEL_RECEIVIND_TIPS"		-- 设置聊天频道接收状态提示
LUA_EVENT_CHAT_SEND_ERROR_RESULT			= "LUA_EVENT_CHAT_SEND_ERROR_RESULT"			-- 聊天发送失败结果
LUA_EVENT_PC_FILL_CHAT_INPUT				= "LUA_EVENT_PC_FILL_CHAT_INPUT"				-- 填充PC聊天输入框
LUA_EVENT_CHAT_MOBILE_AUTO_SHOUT			= "LUA_EVENT_CHAT_MOBILE_AUTO_SHOUT"			-- 手机端自动汉化

LUA_EVENT_MAIN_CLOSE_KEYBOARD				= "LUA_EVENT_MAIN_CLOSE_KEYBOARD"				-- 关闭键盘

LUA_EVENT_CHAT_SET_CHANNEL_RECEIVIND		= "LUA_EVENT_CHAT_SET_CHANNEL_RECEIVIND"		-- 设置聊天频道接收状态提示


-- 聊天拓展
LUA_EVENT_CHAT_EXTEND_EXIT_ACTION			= "LUA_EVENT_CHAT_EXTEND_EXIT_ACTION"			-- 聊天拓展退出动画

-- FuncDock
LUA_EVENT_FUNC_DOCK_OPTION_CHANGE			= "LUA_EVENT_FUNC_DOCK_OPTION_CHANGE"			-- 功能开关改变
LUA_EVENT_FUNC_DOCK_LOOK_PLAYER_INFO		= "LUA_EVENT_FUNC_DOCK_LOOK_PLAYER_INFO"		-- 功能查看玩家数据

-- QuickSelect
LUA_EVENT_QUICK_SELECT_TARGET				= "LUA_EVENT_QUICK_SELECT_TARGET"				-- 快速选择目标

-- 技能释放
LUA_EVENT_USER_INPUT_LAUNCH_SKILL			= "LUA_EVENT_USER_INPUT_LAUNCH_SKILL"			-- 用户技能输入

-------------------zfs begin------------------------------------------------------------------------------------
-----摆摊
LUA_EVENT_STALL_SELF_ITEM_CHANGE			= "LUA_EVENT_STALL_SELF_ITEM_CHANGE"				-- 摆摊自己的物品改变
LUA_EVENT_STALL_ITEM_LIST_CHANGE 			= "LUA_EVENT_STALL_ITEM_LIST_CHANGE"				-- 摆摊物品改变
LUA_EVENT_DARK_STATE_CHANGE              	= "LUA_EVENT_DARK_STATE_CHANGE"             		-- 黑夜状态改变
LUA_EVENT_MONSTER_IGNORELIST_ADD         	= "LUA_EVENT_MONSTER_IGNORELIST_ADD"        		-- 设置 怪物忽略列表增加
LUA_EVENT_BOSSTIPSLIST_ADD               	= "LUA_EVENT_BOSSTIPSLIST_ADD"              		-- 设置 boss提示 增加
LUA_EVENT_MONSTER_NAME_RM                	= "LUA_EVENT_MONSTER_NAME_RM"               		-- 设置 怪物类型删除
LUA_EVENT_SKILL_RANKDATA_ADD            	= "LUA_EVENT_SKILL_RANKDATA_ADD"            		-- 设置 技能数据添加
LUA_EVENT_SKILLBUTTON_DISTANCE_CHANGE    	= "LUA_EVENT_SKILLBUTTON_DISTANCE_CHANGE"   		-- 技能边距调整 
LUA_EVENT_TRADE_STALL_FORBID    			= "LUA_EVENT_TRADE_STALL_FORBID"   					-- 摆摊中禁止交易 

LUA_EVENT_PLAYER_FRAME_NAME_RRFRESH      	= "LUA_EVENT_PLAYER_FRAME_NAME_RRFRESH"     		-- 角色框刷新名字

LUA_EVENT_PLAYER_LOOK_FRAME_PAGE_ADD     	= "LUA_EVENT_PLAYER_LOOK_FRAME_PAGE_ADD"    		-- 查看他人角色框增加子页
LUA_EVENT_PLAYER_GUILD_INFO_CHANGE       	= "LUA_EVENT_PLAYER_GUILD_INFO_CHANGE"      		-- 玩家行会信息改变

LUA_EVENT_HERO_FRAME_NAME_RRFRESH        	= "LUA_EVENT_HERO_FRAME_NAME_RRFRESH"       		-- 英雄框刷新名字

LUA_EVENT_HERO_LOOK_FRAME_PAGE_ADD       	= "LUA_EVENT_HERO_LOOK_FRAME_PAGE_ADD"      		-- 查看他人英雄框增加子页

LUA_EVENT_SERVER_VALUE_CHANGE             	= "LUA_EVENT_SERVER_VALUE_CHANGE"                 	-- 服务器下发的变量改变
LUA_EVENT_CHECK_SERVER_VALUE_CHANGE			= "LUA_EVENT_CHECK_SERVER_VALUE_CHANGE"				-- 检查服务器下发变量改变

LUA_EVENT_EQUIP_RETRIEVE_STATE_CHANGE	 	= "LUA_EVENT_EQUIP_RETRIEVE_STATE_CHANGE"			-- 背包状态改变
LUA_EVENT_ITEM_MOVE_BEGIN_BAG_POS_CHANGE	= "LUA_EVENT_ITEM_MOVE_BEGIN_BAG_POS_CHANGE"		-- 道具换位后开始拖动
LUA_EVENT_BAG_LOAD_SUCCESS					= "LUA_EVENT_BAG_LOAD_SUCCESS"						-- 背包加载完成
LUA_EVENT_HERO_BAG_LOAD_SUCCESS				= "LUA_EVENT_HERO_BAG_LOAD_SUCCESS"					-- 英雄背包加载完成
LUA_EVENT_PLAYER_IN_OF_VIEW                 = "LUA_EVENT_PLAYER_IN_OF_VIEW"                     -- 进视野
LUA_EVENT_PLAYER_OUT_OF_VIEW                = "LUA_EVENT_PLAYER_OUT_OF_VIEW"                    -- 出视野
LUA_EVENT_MAIN_NEAR_REFRESH                 = "LUA_EVENT_MAIN_NEAR_REFRESH" 

LUA_EVENT_MAIN_ADD_QUIT_TIME_TIPS			= "LUA_EVENT_MAIN_ADD_QUIT_TIME_TIPS"				-- 添加退出倒计时提示
LUA_EVENT_MAIN_DEL_QUIT_TIME_TIPS			= "LUA_EVENT_MAIN_DEL_QUIT_TIME_TIPS"				-- 移除退出倒计时提示

LUA_EVENT_MAIN_CHAT_EX_CLEAR				= "LUA_EVENT_MAIN_CHAT_EX_CLEAR"					-- 主界面ChatEx清空

LUA_EVENT_BESTRINGBOX_STATE         		= "LUA_EVENT_BESTRINGBOX_STATE"             		-- 首饰盒状态变化
LUA_EVENT_HERO_BESTRINGBOX_STATE          	= "LUA_EVENT_HERO_BESTRINGBOX_STATE"              	-- 英雄首饰盒

LUA_EVENT_PLAYER_SEX_CHANGE                 = "LUA_EVENT_PLAYER_SEX_CHANGE"                     -- 性别变化
LUA_EVENT_HERO_SEX_CHANGE					= "LUA_EVENT_HERO_SEX_CHANGE"						-- 英雄性别变化

LUA_EVENT_PLAYER_JOB_CHANGE                 = "LUA_EVENT_PLAYER_JOB_CHANGE"                     -- 人物职业变化
LUA_EVENT_HERO_JOB_CHANGE					= "LUA_EVENT_HERO_JOB_CHANGE"						-- 英雄职业变化

LUA_EVENT_SOCIAL_NRAR_PLAYER_LAYER_CLOSE	= "LUA_EVENT_SOCIAL_NRAR_PLAYER_LAYER_CLOSE"		-- 社交附近玩家关闭	
LUA_EVENT_SOCIAL_TEAM_LAYER_CLOSE			= "LUA_EVENT_SOCIAL_TEAM_LAYER_CLOSE"				-- 社交组队关闭	
LUA_EVENT_SOCIAL_FRIEND_LAYER_CLOSE			= "LUA_EVENT_SOCIAL_FRIEND_LAYER_CLOSE"				-- 社交好友关闭
LUA_EVENT_SOCIAL_MAIL_LAYER_CLOSE			= "LUA_EVENT_SOCIAL_MAIL_LAYER_CLOSE"				-- 社交邮件关闭	
LUA_EVENT_SOCIAL_RELATION_LAYER_CLOSE		= "LUA_EVENT_SOCIAL_RELATION_LAYER_CLOSE"			-- 社交关系关闭

LUA_EVENT_SOCIAL_TEAM_ERROR					= "LUA_EVENT_SOCIAL_TEAM_ERROR"						-- 组队异常
LUA_EVENT_SOCIAL_TEAM_CREATE				= "LUA_EVENT_SOCIAL_TEAM_CREATE"					-- 创建队伍
LUA_EVENT_SOCIAL_TEAM_REFUSE_APPLY			= "LUA_EVENT_SOCIAL_TEAM_REFUSE_APPLY"				-- 拒绝申请
LUA_EVENT_SOCIAL_TEAM_JOIN                  = "LUA_EVENT_SOCIAL_TEAM_JOIN"                      -- 加入队伍
LUA_EVENT_SOCIAL_TEAM_LEAVE					= "LUA_EVENT_SOCIAL_TEAM_LEAVE"						-- 离开队伍
LUA_EVENT_SOCIAL_TEAM_OUT					= "LUA_EVENT_SOCIAL_TEAM_OUT"						-- 被T出队伍
LUA_EVENT_SOCIAL_TEAM_DISMISS				= "LUA_EVENT_SOCIAL_TEAM_DISMISS"					-- 解散队伍
LUA_EVENT_SOCIAL_TEAM_OTHER_LEAVE			= "LUA_EVENT_SOCIAL_TEAM_OTHER_LEAVE"				-- 其他人离开
LUA_EVENT_SOCIAL_TEAM_REFUSE_INVITE			= "LUA_EVENT_SOCIAL_TEAM_REFUSE_INVITE"				-- 拒绝邀请
LUA_EVENT_TEAM_BEINVITED_UPDATE				= "LUA_EVENT_TEAM_BEINVITED_UPDATE"					-- 组队被邀请更新

LUA_EVENT_SOCIAL_FRIEND_ERROR				= "LUA_EVENT_SOCIAL_FRIEND_ERROR"						-- 好友异常
LUA_EVENT_SOCIAL_FRIEND_APPLY_SUCCESS		= "LUA_EVENT_SOCIAL_FRIEND_APPLY_SUCCESS"				-- 申请成功
LUA_EVENT_SOCIAL_FRIEND_ADD_SUCCESS			= "LUA_EVENT_SOCIAL_FRIEND_ADD_SUCCESS"					-- 增加成功
LUA_EVENT_SOCIAL_FRIEND_DEL_SUCCESS			= "LUA_EVENT_SOCIAL_FRIEND_DEL_SUCCESS"					-- 删除成功
LUA_EVENT_SOCIAL_FRIEND_DEL_BLACKLIST_SUCCESS	= "LUA_EVENT_SOCIAL_FRIEND_DEL_BLACKLIST_SUCCESS"	-- 删除黑名单成功
LUA_EVENT_SOCIAL_FRIEND_ADD_BLACKLIST_SUCCESS	= "LUA_EVENT_SOCIAL_FRIEND_ADD_BLACKLIST_SUCCESS"	-- 添加黑名单成功
LUA_EVENT_SOCIAL_FRIEND_REFUSE_APPLY		= "LUA_EVENT_SOCIAL_FRIEND_REFUSE_APPLY"				-- 拒绝好友申请

LUA_EVENT_SOCIAL_RELATION_INVITE_ERROR		= "LUA_EVENT_SOCIAL_RELATION_INVITE_ERROR"				-- 邀请建立关系异常
LUA_EVENT_SOCIAL_RELATION_DATA_INIT			= "LUA_EVENT_SOCIAL_RELATION_DATA_INIT"					-- 关系网数据初始化
LUA_EVENT_SOCIAL_RELATION_DATA_REFRESH		= "LUA_EVENT_SOCIAL_RELATION_DATA_REFRESH"				-- 关系网数据刷新
LUA_EVENT_SOCIAL_RELATION_NOTICE			= "LUA_EVENT_SOCIAL_RELATION_NOTICE"					-- 关系相关通知提示

LUA_EVENT_MAIN_JOYSTICKUPDATE 				= "LUA_EVENT_MAIN_JOYSTICKUPDATE"						--主界面摇杆更新
LUA_EVENT_MAIN_JOYSTICK_DISTANCE_CHANGE		= "LUA_EVENT_MAIN_JOYSTICK_DISTANCE_CHANGE"				--摇杆侧边距改变
LUA_EVENT_MAIN_ONE_DOUBLE_JOYSTICK			= "LUA_EVENT_MAIN_ONE_DOUBLE_JOYSTICK"					--单双摇杆改变设置改变

LUA_EVENT_TRADE_BANK_PLAYER_FRAME_CLOSE		= "LUA_EVENT_TRADE_BANK_PLAYER_FRAME_CLOSE"				--交易行查看他人关闭
-----------------------------------------------------------------背包网络事件
LUA_EVENT_REQ_BAGDATA						= "LUA_EVENT_REQ_BAGDATA"
LUA_EVENT_BAG_REQ_TWO_TO_ONE				= "LUA_EVENT_BAG_REQ_TWO_TO_ONE"
LUA_EVENT_BAG_REQ_NUMBER_CHANGE				= "LUA_EVENT_BAG_REQ_NUMBER_CHANGE"
LUA_EVENT_BAG_REQ_COLLIMATOR				= "LUA_EVENT_BAG_REQ_COLLIMATOR"
LUA_EVENT_BAG_REQ_CANCELCOLLIMATOR			= "LUA_EVENT_BAG_REQ_CANCELCOLLIMATOR"
LUA_EVENT_BAG_REQ_UNLOCK_BAG_SIZE			= "LUA_EVENT_BAG_REQ_UNLOCK_BAG_SIZE"

LUA_EVENT_RETURN_BAGDATA					= "LUA_EVENT_RETURN_BAGDATA"
LUA_EVENT_BAG_ADD_ITEM						= "LUA_EVENT_BAG_ADD_ITEM"
LUA_EVENT_BAG_DEL_ITEM						= "LUA_EVENT_BAG_DEL_ITEM"
LUA_EVENT_BAG_UPDATE_ITEM					= "LUA_EVENT_BAG_UPDATE_ITEM"
LUA_EVENT_BAG_ITEM_USE_SUCCESS				= "LUA_EVENT_BAG_ITEM_USE_SUCCESS"
LUA_EVENT_BAG_ITEM_USE_FAIL					= "LUA_EVENT_BAG_ITEM_USE_FAIL"
LUA_EVENT_DROP_ITEM_GET_FAIL				= "LUA_EVENT_DROP_ITEM_GET_FAIL"
LUA_EVENT_DROP_ITEM_SUCCESS					= "LUA_EVENT_DROP_ITEM_SUCCESS"
LUA_EVENT_DROP_ITEM_FAIL					= "LUA_EVENT_DROP_ITEM_FAIL"
LUA_EVENT_HUMBAG_TO_HEROBAG_FAIL			= "LUA_EVENT_HUMBAG_TO_HEROBAG_FAIL"
LUA_EVENT_RESET_BAG_POS						= "LUA_EVENT_RESET_BAG_POS"
LUA_EVENT_COLLIMATOR_RESPONSE				= "LUA_EVENT_COLLIMATOR_RESPONSE"
--hero
LUA_EVENT_HERO_BAG_REQ_TWO_TO_ONE 			= "LUA_EVENT_HERO_BAG_REQ_TWO_TO_ONE"
LUA_EVENT_HERO_BAG_REQ_NUMBER_CHANGE		= "LUA_EVENT_HERO_BAG_REQ_NUMBER_CHANGE"
LUA_EVENT_REQ_HUM_BAG_TO_HERO_BAG			= "LUA_EVENT_REQ_HUM_BAG_TO_HERO_BAG" 	
LUA_EVENT_REQ_HERO_BAG_TO_HUM_BAG			= "LUA_EVENT_REQ_HERO_BAG_TO_HUM_BAG"

LUA_EVENT_RETURN_HERO_BAGDATA				= "LUA_EVENT_RETURN_HERO_BAGDATA"
LUA_EVENT_HERO_BAG_ADD_ITEM					= "LUA_EVENT_HERO_BAG_ADD_ITEM"
LUA_EVENT_HERO_BAG_DEL_ITEM					= "LUA_EVENT_HERO_BAG_DEL_ITEM"
LUA_EVENT_HERO_BAG_UPDATE_ITEM				= "LUA_EVENT_HERO_BAG_UPDATE_ITEM"
LUA_EVENT_HERO_BAG_ITEM_USE_FAIL			= "LUA_EVENT_HERO_BAG_ITEM_USE_FAIL"
LUA_EVENT_HERO_DROP_ITEM_GET_FAIL			= "LUA_EVENT_HERO_DROP_ITEM_GET_FAIL"
LUA_EVENT_HERO_DROP_ITEM_SUCCESS			= "LUA_EVENT_HERO_DROP_ITEM_SUCCESS"
LUA_EVENT_HERO_DROP_ITEM_FAIL				= "LUA_EVENT_HERO_DROP_ITEM_FAIL"
LUA_EVENT_HERO_BAG_TO_HUMAN_BAG_FAIL		= "LUA_EVENT_HERO_BAG_TO_HUMAN_BAG_FAIL"

-- 拍卖行
LUA_EVENT_AUCTION_PUT_IN					= "LUA_EVENT_AUCTION_PUT_IN"						-- 上架
LUA_EVENT_AUCTION_WORLD_ITEM_ADD			= "LUA_EVENT_AUCTION_WORLD_ITEM_ADD"				-- 拍卖物品增加
LUA_EVENT_AUCTION_ITEM_UPDATE				= "LUA_EVENT_AUCTION_ITEM_UPDATE"					-- 拍卖物品刷新
LUA_EVENT_AUCTION_PUT_OUT					= "LUA_EVENT_AUCTION_PUT_OUT"						-- 下架
LUA_EVENT_AUCTION_PUT_LIST					= "LUA_EVENT_AUCTION_PUT_LIST"						-- 上架列表
LUA_EVENT_AUCTION_BIDDING_LIST				= "LUA_EVENT_AUCTION_BIDDING_LIST"					-- 我的竞拍列表
LUA_EVENT_AUCTION_ITEM_LIST					= "LUA_EVENT_AUCTION_ITEM_LIST"						-- 竞拍物品列表
LUA_EVENT_AUCTION_ITEM_LIST_CLEAR			= "LUA_EVENT_AUCTION_ITEM_LIST_CLEAR"				-- 清理列表
LUA_EVENT_AUCTION_WORLD_ITEM_DEL			= "LUA_EVENT_AUCTION_WORLD_ITEM_DEL"				-- 拍卖物品删除
LUA_EVENT_AUCTION_WORLD_ITEM_CHANGE			= "LUA_EVENT_AUCTION_WORLD_ITEM_CHANGE"				-- 拍卖物品改变
LUA_EVENT_AUCTION_WORLD_ITEM_SEARCH			= "LUA_EVENT_AUCTION_WORLD_ITEM_SEARCH"				-- 拍卖物品查找
LUA_EVENT_AUCTION_BID			            = "LUA_EVENT_AUCTION_BID"				            -- 竞拍
LUA_EVENT_AUCTION_BID_ERRORCODE             = "LUA_EVENT_AUCTION_BID_ERRORCODE"
LUA_EVENT_AUCTION_ACQUIRE                   = "LUA_EVENT_AUCTION_ACQUIRE"                       -- 领取竞拍物品
-------------------zfs end------------------------------------------------------------------------------------


LUA_EVENT_TARGET_BELONG_SELECT				= "LUA_EVENT_TARGET_BELONG_SELECT"					-- 快捷归属选中
LUA_EVENT_USER_INPUT_MOVE					= "LUA_EVENT_USER_INPUT_MOVE"
------------------------------------------------------------------------------------------------------------------------
LUA_EVENT_COMMONTIPS_EVENT                  = "LUA_EVENT_COMMONTIPS_EVENT"

------------------------------------------------------------------------------------------------------------------------
-- 触发
LUA_TRIGGER_CHAT_CLICK_PLAYER_NAME      = "LUA_TRIGGER_CHAT_CLICK_PLAYER_NAME"      -- 触发，聊天点击玩家名字

LUA_TRIGGER_NOTICE_SHOW_ATTRIBUTES      = "LUA_TRIGGER_NOTICE_SHOW_ATTRIBUTES"      -- 提示通知--属性通知

LUA_TRIGGER_NOTICE_SHOW_GET_ITEM        = "LUA_TRIGGER_NOTICE_SHOW_GET_ITEM"        -- 提示通知--获得物品
LUA_TRIGGER_NOTICE_SHOW_COST_ITEM       = "LUA_TRIGGER_NOTICE_SHOW_COST_ITEM"       -- 提示通知--消耗物品

LUA_TRIGGER_NOTICE_SHOW_EXP_CHANGE      = "LUA_TRIGGER_NOTICE_SHOW_EXP_CHANGE"      -- 提示通知--经验通知

------------------------------------------------------------------------------------------------------------------------

LUA_EVENT_SKILL_ON                  	= "LUA_EVENT_SKILL_ON"
LUA_EVENT_SKILL_OFF                 	= "LUA_EVENT_SKILL_OFF"
LUA_EVENT_SKILL_CHANGE_KEY          	= "LUA_EVENT_SKILL_CHANGE_KEY"              -- 技能键改变
LUA_EVENT_SKILL_DELETE_KEY          	= "LUA_EVENT_SKILL_DELETE_KEY"              -- 删除技能键

LUA_EVENT_PLAYER_EQUIP_INIT         	= "LUA_EVENT_PLAYER_EQUIP_INIT"             -- 玩家装备数据初始化
LUA_EVENT_CLEAR_SELECT_SKILL        	= "LUA_EVENT_CLEAR_SELECT_SKILL"            -- 清空选中技能
LUA_EVENT_SKILL_CD_CHANGE           	= "LUA_EVENT_SKILL_CD_CHANGE"				-- 技能CD改变
LUA_EVENT_COMBO_SKILL_CD_CHANGE			= "LUA_EVENT_COMBO_SKILL_CD_CHANGE"			-- 连击技能CD改变

LUA_EVENT_HERO_LOCK_CHANGE				= "LUA_EVENT_HERO_LOCK_CHANGE"				-- 英雄锁定状态改变

LUA_EVENT_HERO_LOGIN                	= "LUA_EVENT_HERO_LOGIN"
LUA_EVENT_HERO_LOGOUT               	= "LUA_EVENT_HERO_LOGOUT"

LUA_EVENT_GUIDE_ENTER_TRANSITION		= "LUA_EVENT_GUIDE_ENTER_TRANSITION"		-- 引导切换
LUA_EVENT_GUIDE_EVENT_BEGAN             = "LUA_EVENT_GUIDE_EVENT_BEGAN"             -- 引导事件开始
LUA_EVENT_GUIDE_EVENT_ENDED             = "LUA_EVENT_GUIDE_EVENT_ENDED"             -- 引导事件结束
LUA_EVENT_GUIDE_EXIT					= "LUA_EVENT_GUIDE_EXIT"					-- 退出引导

LUA_EVENT_EQUIP_ATTR_REFRESH			= "LUA_EVENT_EQUIP_ATTR_REFRESH"			-- 装备属性刷新

LUA_EVENT_SKILL_ADD_TO_UI_WIN32 		= "LUA_EVENT_SKILL_ADD_TO_UI_WIN32" 		-- 添加技能到界面
LUA_EVENT_SKILL_DEL_TO_UI_WIN32  		= "LUA_EVENT_SKILL_DEL_TO_UI_WIN32"			-- 从界面删除技能

LUA_EVENT_TITLE_REFRESH					= "LUA_EVENT_TITLE_REFRESH"					-- 玩家称号刷新
LUA_EVENT_HERO_TITLE_REFRESH			= "LUA_EVENT_HERO_TITLE_REFRESH"			-- 英雄称号刷新

LUA_EVENT_GAME_MEMORY_RELEASE			= "LUA_EVENT_GAME_MEMORY_RELEASE"			-- 释放内存

------------------------------------------------------------------------------------------------------------------------
LUA_EVENT_COLLECT_VISIBLE				= "LUA_EVENT_COLLECT_VISIBLE"  				-- 自动 采集相关显示
LUA_EVENT_COLLECT_BEGIN					= "LUA_EVENT_COLLECT_BEGIN"  				-- 自动 开始
LUA_EVENT_COLLECT_COMPLETED				= "LUA_EVENT_COLLECT_COMPLETED"  			-- 自动 完成
LUA_EVENT_COLLECT_VISIBLE				= "LUA_EVENT_COLLECT_VISIBLE"  				-- 自动 采集相关显示
------------------------------------------------------------------------------------------------------------------------
-- 商城
LUA_EVENT_STORE_HOT_LAYER_CLOSE	        = "LUA_EVENT_STORE_HOT_LAYER_CLOSE"		    -- 商城热销关闭
LUA_EVENT_STORE_BEAUTY_LAYER_CLOSE	    = "LUA_EVENT_STORE_BEAUTY_LAYER_CLOSE"		-- 商城装饰界面关闭
LUA_EVENT_STORE_ENGINE_LAYER_CLOSE		= "LUA_EVENT_STORE_ENGINE_LAYER_CLOSE"		-- 商城功能界面关闭	
LUA_EVENT_STORE_FESTIVAL_LAYER_CLOSE	= "LUA_EVENT_STORE_FESTIVAL_LAYER_CLOSE"	-- 商城节日界面关闭
LUA_EVENT_STORE_RECHARGE_LAYER_CLOSE	= "LUA_EVENT_STORE_RECHARGE_LAYER_CLOSE"	-- 商城充值界面关闭	
LUA_EVENT_LAYER_PAGE_STORE_REFRESH	    = "LUA_EVENT_LAYER_PAGE_STORE_REFRESH"	    -- 商城界面刷新
LUA_EVENT_STORE_BUY_CLOSE               = "LUA_EVENT_STORE_BUY_CLOSE"               -- 商城物品购买界面关闭
LUA_EVENT_RECHARGE_RECEIVED             = "LUA_EVENT_RECHARGE_RECEIVED"             -- 充值结果
LUA_EVENT_NOT_FOUND_GOODS               = "LUA_EVENT_NOT_FOUND_GOODS"               -- 未找到商品
