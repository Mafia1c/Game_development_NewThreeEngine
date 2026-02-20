LoginAddStrAttrTrigger = {}

-- 登陆重置某些属性(转职和职业相关)
function LoginAddStrAttrTrigger.addStrAttr(actor)

    if IncludeNpcClass("LifeUp") then --#region 转生轮回
        IncludeNpcClass("LifeUp"):addStrInfo(actor)
    end

    local disguiseTab={"T_fashion_info","T_mount_equip","T_footprint_info","T_soul_ring_info","T_angel_wing_info","T_pet_str_info","T_warcraft_info"}
    local buff_ids = {50011,50012,50013,50014,50015,50016,50017}
    for index, value in ipairs(disguiseTab) do --#region 装扮属性
        local hasStr = VarApi.getPlayerTStrVar(actor, value)
        if hasStr ~= "" then
            OtherTrigger.AttributeTransformation(actor, hasStr, buff_ids[index])
        end
    end
end

function LoginAddStrAttrTrigger.addButton(actor)
    delaygoto(actor, 1000,"add_god_equip_btn", 0)
end

--#region 神器主界面初始化加按钮
function add_god_equip_btn(actor)
    local hasTab=json2tbl(VarApi.getPlayerTStrVar(actor,"T_godEquip_hasList")) --#region 已经配置的
    if hasTab=="" then hasTab={} end
    if #hasTab==0 then
        delbutton(actor,108,500)
        delbutton(actor,108,501)
        delbutton(actor,108,502)
        return
    end
    local iconPath={"ct_","bs_","xx_","fy_","sm_","gs_"}
    local btnTab1 = { --#region 手机
        {108, 500,"<Img|x=130|y=-290|img=custom/npc/53dyd/js/kuang.png>"},
        {108, 501,"<EquipShow|x=152|y=-280|index=90|showtips=1>"},
        -- {108, 501,"<Img|x=230|y=-264|img=custom/npc/53dyd/js/icon/%s%s.png>"},
        {108, 502,"<Button|x=156|y=-220|nimg=custom/npc/53dyd/js/an1.png|link=@_change_equip_active>"},
    }
    local btnTab2 = { --#region pc
        {108, 500,"<Img|x=240|y=-360|img=custom/npc/53dyd/js/kuang.png>"},
        {108, 501,"<EquipShow|x=262|y=-350|index=90|showtips=1>"},
        -- {108, 501,"<Img|x=270|y=-344|img=custom/npc/53dyd/js/icon/%s%s.png>"},
        {108, 502,"<Button|x=266|y=-290|nimg=custom/npc/53dyd/js/an1.png|link=@_change_equip_active>"},
    }
    local is_pc = getconst(actor,"<$CLIENTFLAG>") == "1"
    local _tab=btnTab1
    if is_pc then _tab=btnTab2 end
    for i, v in ipairs(_tab) do
        -- if i==2 then --#region 读图片
        --     local lineIndex,iconIndex=string.sub(hasTab[1],1,1),string.sub(hasTab[1],2,2)
        --     v[3]=string.format(v[3],iconPath[tonumber(lineIndex)],iconIndex)
        -- end
        delbutton(actor,v[1],v[2])
        addbutton(actor, v[1], v[2], v[3])
    end
end
function _change_equip_active(actor) --#region 切换激活的神器(属性)和按钮
    if IncludeNpcClass("GodEquip") then
        IncludeNpcClass("GodEquip"):changeActive(actor)
    end
end