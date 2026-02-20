local MagicRing_LookOBJ = {}
MagicRing_LookOBJ.Name = "MagicRing_LookOBJ"
MagicRing_LookOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
MagicRing_LookOBJ.cfg = {103,104,105}

function MagicRing_LookOBJ:main()
   	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/MagicRingUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:addOnClickEvent(self.ui.closeBtn,function ( ... )
    	ViewMgr.close("MagicRing_LookOBJ")
    end)
    GUI:addOnClickEvent(self.ui.CloseLayout,function ( ... )
    	ViewMgr.close("MagicRing_LookOBJ")
    end)
    GUI:removeAllChildren(self.ui.equipNode)
    local position={41,129,247}
    for index, value in ipairs(self.cfg) do
        if SL:Get_L_M_EQUIP_DATA(value) then
            GUI:ItemShow_Create(self.ui.equipNode,"equip"..index,position[index],41,
            {index=SL:Get_L_M_EQUIP_DATA(value).Index,look=true,itemData=SL:Get_L_M_EQUIP_DATA(value)})
        end
    end
end
return MagicRing_LookOBJ