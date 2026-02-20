local SelectCrossWorldOBJ = {}
SelectCrossWorldOBJ.Name = "SelectCrossWorldOBJ"
SelectCrossWorldOBJ.RunAction = true
SelectCrossWorldOBJ.UiText = {
    [1] = {
        "{巅峰峡谷/FCOLOR=254} 合区后 {19:15/FCOLOR=250} 开启，报名时间 {3分钟/FCOLOR=250} {报名时间结束，关闭入口/FCOLOR=249}",
        "活动分为{“红方”/FCOLOR=249}和{“蓝方”/FCOLOR=254}两大阵营，参与玩家随机分配“{红/FCOLOR=249}{蓝/FCOLOR=254}阵营”",
        "玩家报名后，自动传送到等待地图。报名时间结束，统一传送到{“巅峰峡谷”/FCOLOR=253}>",
        "在峡谷内死亡，自动回复活点复活，优先击杀敌方{“峡谷神龙”/FCOLOR=244}的阵营即获胜！",
        "胜方成员奖励：{2000声望/FCOLOR=250}，败方成员奖励：{500声望/FCOLOR=250}",
        "发放奖励时，人物必须处于峡谷地图，否则奖励无法到账！！",
        "“巅峰峡谷”为战斗地图，死亡不掉装备，不加PK值！",
    },
    [2] = {
        "{无限战场/FCOLOR=254} 合区后 {18:15/FCOLOR=250} 开启，{18:45/FCOLOR=250} {关闭入口/FCOLOR=249}",
        "地图为 {无限厮杀模式/FCOLOR=249}，死亡自动 {满血复活/FCOLOR=251}",
        "地图内 杀人{＋3点杀戮值/FCOLOR=250}，死亡{＋1点杀戮值/FCOLOR=250}",
        "活动结束，杀戮值达到100点，奖励声望*500",
        "战斗地图，死亡不掉装备，不加PK值！",
    },
    [3] = {
        "{永夜降临/FCOLOR=254} 合区后 {21:15/FCOLOR=250} 开启，{21:25/FCOLOR=250} {关闭入口/FCOLOR=249}",
        "前3层刷新{冥界之花/FCOLOR=251}，击杀 {冥界之花/FCOLOR=251} {＋1点功勋值/FCOLOR=250}，第4层刷新{“永夜冥王·哈迪斯”/FCOLOR=249}",
        "活动开始后，人物初始获得 {100点生存值/FCOLOR=254}，{第1层、第2层：每10秒减1生存值/FCOLOR=253}",
        "第3层：每10秒减2生存值，第4层不扣生存值！生存值为{“0”/FCOLOR=249}自动退出活动地图！",
        "活动入口关闭之后，当第4层只剩下一个玩家即可领取奖励：{荣誉点*3000/FCOLOR=250}",
        "提示：{荣誉点/FCOLOR=250} 可以用来在商城兑换游戏道具！",
        "战斗地图，死亡不掉装备，不加PK值！",
    },
    [4] = {
        "{恶魔广场/FCOLOR=254} 合区后 每日定点开启 {8次/FCOLOR=250}！",
        "每日 {[３、９、15、21点]/FCOLOR=250} 刷新 {冥界守护神/FCOLOR=249} 击杀必爆 {上古·[1→3阶]·盔甲/FCOLOR=253}",
        "每日 {[６、12、19、24点]/FCOLOR=250} 刷新 {魔界守护神/FCOLOR=249} 击杀必爆 {上古·[1→3阶]·武器/FCOLOR=253}",
        "活动 {10分钟/FCOLOR=253} 后关闭入口，请各位勇士及时前往击杀！",
        "“恶魔广场”为跨服活动，需要加入行会才能进入！",
        "“恶魔广场”为战斗地图，死亡不掉装备，不加PK值！",
    }
}

function SelectCrossWorldOBJ:main(index)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/SelectCrossWorldUI", function () end)
    self.ui = GUI:ui_delegate(parent)
    self.cur_index = index

    self:initClickEvent()
    self:flushView(index)
end

function SelectCrossWorldOBJ:initClickEvent()
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close(self.Name)
    end)
    GUI:addOnClickEvent(self.ui.goBtn, function()
        SendMsgClickMainBtn("0#CrossWorld#onSelectCross#"..self.cur_index)
    end)
end

function SelectCrossWorldOBJ:flushView(index)
    local res = string.format("res/custom/npc/0kf/bg%s.png", index)
    GUI:Image_loadTexture(self.ui.FrameBG, res)

    local y = 310
    local cfg = self.UiText[index] or {}
    for key, value in ipairs(cfg) do
        local rich1 = GUI:RichTextFCOLOR_Create(self.ui["FrameLayout"], "_txt"..key, 125, y, value, 620, 16, "#ffffff")
        y = y - 30
    end

    GUI:setVisible(self.ui.Image_1, index == 2)
end

return SelectCrossWorldOBJ