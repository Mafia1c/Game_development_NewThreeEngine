local Pulse_LookOBJ = {}
Pulse_LookOBJ.Name = "Pulse_LookOBJ"
Pulse_LookOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
Pulse_LookOBJ.NpcId = 71
Pulse_LookOBJ.cfg = GetConfig("PulseCfg")
local positionTab = {
    [1]={{176,346},{178,284},{150,312},{140,266},{102,258},{214,308},{242,270},{176,232},{124,146},{244,146}},
    [2]={{176,316},{152,268},{108,274},{80,214},{190,218},{236,164},{134,190},{52,164},{188,142},{284,108}},
    [3]={{244,314},{248,268},{298,358},{208,262},{286,208},{226,170},{166,124},{86,92},{306,162},{316,92}},
    [4]={{94,332},{88,284},{100,246},{130,286},{164,320},{232,338},{172,272},{168,186},{164,102},{260,330}},
    [5]={{228,362},{248,308},{288,358},{210,290},{170,316},{172,262},{96,318},{72,256},{136,186},{118,96}},
    [6]={{198,366},{178,318},{138,352},{244,320},{294,346},{158,250},{90,244},{100,162},{164,162},{166,86}},
    [7]={{196,350},{192,308},{140,290},{68,282},{238,262},{188,210},{90,158},{64,90},{304,150},{316,78}},
    [8]={{188,360},{170,312},{124,346},{214,314},{254,260},{154,236},{200,284},{200,216},{144,150},{152,66}},
    [9]={{114,328},{124,276},{90,286},{68,238},{184,262},{262,278},{124,206},{56,162},{182,142},{276,102}},
    [10]={{248,364},{186,344},{108,276},{248,292},{274,266},{260,202},{192,304},{174,222},{188,146},{206,84}},
    [11]={{232,338},{202,304},{178,346},{248,306},{290,376},{160,264},{100,290},{110,204},{160,174},{170,94}},
}


function Pulse_LookOBJ:main(look_layer)
    local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/PulseUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    self.layer = tonumber(look_layer)or 0 --#region 当前层次在表中index
    self.lineIndex = self.cfg[self.layer]["layer"] --#region 当前经脉index
    GUI:Timeline_Window4(self.ui.FrameLayout)
    GUI:runAction(self.ui.leftBg,GUI:ActionEaseExponentialInOut(GUI:ActionMoveTo(0.4,36,320)))
    self:refreshLeftBox()

    GUI:addOnClickEvent(self.ui.CloseLayout, function()
        ViewMgr.close("Pulse_LookOBJ")
    end)
    GUI:addOnClickEvent(self.ui.closeBtn, function()
        ViewMgr.close("Pulse_LookOBJ")
    end)
    GUI:addOnClickEvent(self.ui.tipsBtn,function ()
        local worldPos = GUI:getTouchEndPosition(self.ui.tipsBtn)
        GUI:ShowWorldTips(self.cfg[self.layer]["RText"], worldPos, GUI:p(1, 1))
    end)
    GUI:setVisible(self.ui.upBtn,false)
end

function Pulse_LookOBJ:refreshLeftBox()
    removeOBJ(self.ui.look_name,self)
    GUI:Text_Create(self.ui.leftBox,"look_name",250,392,16,"#ffff00", "["..SL:Get_LOOK_TARGET_NAME().."·奇经八脉]")
    GUI:setAnchorPoint(self.ui.look_name,0.5,0.5)
    GUI:Image_loadTexture(self.ui.lineImg,"res/custom/npc/09qjbm/z"..self.lineIndex..".png")
    GUI:Image_loadTexture(self.ui.acupointImg, "res/custom/npc/09qjbm/icon/"..self.layer..".png")
    GUI:Image_loadTexture(self.ui.personImg,"res/custom/npc/09qjbm/r"..self.lineIndex..".png")
    GUI:Text_setString(self.ui.acupointText,self.cfg[self.layer]["acupoint"])
    GUI:Timeline_FadeIn(self.ui.personImg, 0.5,nil)
    GUI:Timeline_FadeIn(self.ui.acupointText, 0.5,nil)
    local ball = (self.layer+1)%11
    if ball==0 then
        ball=10
    elseif self.layer==#self.cfg then
        ball=10
    else
        ball=ball-1
    end
    if ball==0 then
        GUI:removeAllChildren(self.ui.personImg)
        self.ui = GUI:ui_delegate(self._parent)
    end
    for i = 1, ball do
        if not self.ui["ballEffect"..i] then
            local effect = GUI:Effect_Create(self.ui.personImg, "ballEffect"..i, positionTab[self.lineIndex][i][1], positionTab[self.lineIndex][i][2]
            , 0, 14869, 0,0, 0, 1)
            GUI:setScale(effect,0.7)
        end
    end
    self:refreshRightNode()
end

function Pulse_LookOBJ:refreshRightNode()
    if self.layer==#self.cfg then
        for i = 1, 3 do
            GUI:Text_setString(self.ui["text1"..i.."2"],self.cfg[self.layer]["text"..i])
            GUI:Text_setString(self.ui["text2"..i.."2"],self.cfg[self.layer]["text"..i])
        end
    else
        for i = 1, 3 do
            GUI:Text_setString(self.ui["text1"..i.."2"],self.cfg[self.layer]["text"..i])
            GUI:Text_setString(self.ui["text2"..i.."2"],self.cfg[self.layer+1]["text"..i])
        end
    end
    for i = 1, 2 do
        GUI:Text_setString(self.ui["text"..i.."22"],GUI:Text_getString(self.ui["text"..i.."22"]).."%")
        GUI:UserUILayout(self.ui["textNode"..i], {dir=1,addDir=2,interval=0.5,gap = {y=6},sortfunc = function (lists)
            table.sort(lists, function (a, b)
                return tonumber(string.sub(GUI:getName(a), -1)) < tonumber(string.sub(GUI:getName(b), -1))
            end)
        end})
    end
end

return Pulse_LookOBJ