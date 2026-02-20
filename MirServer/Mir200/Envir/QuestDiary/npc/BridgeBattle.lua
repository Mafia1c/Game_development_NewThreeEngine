local BridgeBattle = {}
BridgeBattle.position1={{29,11},{24,42}}
BridgeBattle.position2={{29,14},{23,37}}
BridgeBattle.position3={{{29,15},{26,17},{27,20}},{{22,32},{17,36},{24,36}}}
BridgeBattle.mon1={"狂热双头血魔2","狂热双头金刚2","狂热牛魔王2","狂热虹魔教主2","狂热沃玛教主2","狂热祖玛教主2","狂热魔龙教主2"
,"狂热雪域魔王2","狂热尸王2","狂热骷髅精灵2","狂热黄泉教主2","狂热皇稳峰2"}
BridgeBattle.mon2={"僵尸王·十倍爆率2","僵尸王·百倍爆率2"}
BridgeBattle.mon_info={{30,14,"威武极天战士21"},{28,12,"威武极天战士31"},{32,15,"威武极天战士41"},{26,42,"威武极天战士21"},{24,41,"威武极天战士31"},{23,40,"威武极天战士41"}}

function BridgeBattle:clearMon(actor)
    killmonsters("传奇之路","*",0,true,false)
    delaygoto(actor,1000,"refresh_bridge_mon1",0)
end
function refresh_bridge_mon1(actor)
    BridgeBattle:refreshMon(actor)
end
function BridgeBattle:refreshMon(actor)
    for i = 1, 6 do
        genmon("传奇之路",self.mon_info[i][1],self.mon_info[i][2],self.mon_info[i][3],0,1,249)
    end
    for i = 1, 2 do
        genmon("传奇之路",self.position1[i][1],self.position1[i][2],"爆不爆谁知道2",2,1,249)
        for _, v in ipairs(self.mon1) do
            genmon("传奇之路",self.position2[i][1],self.position2[i][2],v,3,1,249)
        end
    end

  

    for i = 1, 2 do
        for j = 1, 3 do
            genmon("传奇之路",self.position3[i][j][1],self.position3[i][j][2],self.mon2[math.random(2)],6,33,249)
        end
    end
    release_print(getmoncount("传奇之路",-1,true))
end

return BridgeBattle