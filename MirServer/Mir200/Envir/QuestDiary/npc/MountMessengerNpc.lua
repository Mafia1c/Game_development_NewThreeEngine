local MountMessengerNpc = {}
-- [×øÆï¼¤»î¿¨]°×ÒÂ½£ÏÉ
function MountMessengerNpc:onClickUp(actor)
    if CheckOpenState(actor, 1) then return end
    local mount_equip = VarApi.getPlayerTStrVar(actor, "T_mount_equip")
    if string.find(mount_equip, "[×øÆï]°×ÒÂ½£ÏÉ", 1, true) then
        Sendmsg9(actor, "ffffff", "ÄãÒÑ¾­ÓµÓĞ¡¾°×ÒÂ½£ÏÉ¡¿×øÆï£¡", 1)
        return
    end

    local num = getbagitemcount(actor, "»ÃÁéÊ¯", 0)
    if num < 999 then
        Sendmsg9(actor, "ff0000", "´òÔì×øÆïĞèÒª»ÃÁéÊ¯*999", 1)
        return
    end

    if not takeitem(actor, "»ÃÁéÊ¯", 999, 0, "´òÔì×øÆï¿Û³ı!") then
        Sendmsg9(actor, "ff0000", "¿Û³ıÊ§°Ü~", 1)
        return
    end
    Gives(actor, "[×øÆï¼¤»î¿¨]°×ÒÂ½£ÏÉ#1#370", "´òÔì×øÆï»ñµÃ!")
    lualib:FlushNpcUi(actor, "MountMessengerOBJ", "")
    lualib:CallFuncByClient(actor, "screffects", 14801)
end

return MountMessengerNpc