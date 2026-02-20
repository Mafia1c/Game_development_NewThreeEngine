local SysRightBtn = {}

function SysRightBtn:onClickBtn(actor, sMsg)
    if sMsg == "xunhang" then
        local class = IncludeNpcClass("MapCruise")
        if class then
            class:click(actor)
        end
    elseif sMsg=="GodEquipOBJ" then
        if IncludeNpcClass("GodEquip") then
            IncludeNpcClass("GodEquip"):click(actor)
        end
    elseif sMsg == "LifeUpOBJ" then
        if IncludeNpcClass("LifeUp") then
            IncludeNpcClass("LifeUp"):onClick(actor)
        end
    elseif sMsg == "FourCellOBJ" then
        lualib:ShowNpcUi(actor, "FourCellOBJ", "")
    elseif sMsg == "EquipMasterOBJ" then
        lualib:ShowNpcUi(actor, "EquipMasterOBJ", "")
    elseif sMsg == "DisguiseOBJ" then
        local cfg = GetConfig("DisguiseCfg")
        for i, value in ipairs(cfg) do
            if VarApi.getPlayerTStrVar(actor,value.varStr)~="" then
                break
            elseif i==#cfg then
                return Sendmsg9(actor,"FF0000","当前还未拥有任何装扮！", 1)
            end
        end
        lualib:ShowNpcUi(actor, "DisguiseOBJ", "")
    end
end

return SysRightBtn