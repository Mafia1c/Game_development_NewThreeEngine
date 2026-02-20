local MagicRingOBJ = {}
MagicRingOBJ.Name = "MagicRingOBJ"
MagicRingOBJ.location = {offsetX = 0,offsetY = 0} --#region ui居中偏移
MagicRingOBJ.cfg = {103,104,105}

function MagicRingOBJ:main( ... )
   	local parent = GUI:Win_Create(self.Name, 0, 0, 0, 0, false, false, true, false)
    self._parent = parent
    GUI:LoadExport(parent, "npc/MagicRingUI", function () end)
    self.ui = GUI:ui_delegate(parent)

    GUI:addOnClickEvent(self.ui.closeBtn,function ( ... )
    	ViewMgr.close("MagicRingOBJ")
    end)
    GUI:addOnClickEvent(self.ui.CloseLayout,function ( ... )
    	ViewMgr.close("MagicRingOBJ")
    end)
    GUI:removeAllChildren(self.ui.equipNode)
    local position={41,129,218}
    for index, value in ipairs(self.cfg) do
        if SL:Get_EQUIPBYPOS(value)~="" then
            GUI:ItemShow_Create(self.ui.equipNode,"equip"..index,position[index],41,
            {index=SL:GetMetaValue("ITEM_INDEX_BY_NAME",SL:Get_EQUIPBYPOS(value)),look=true,itemData=SL:Get_EQUIP_DATA(value,false)})
        end
    end
end
return MagicRingOBJ