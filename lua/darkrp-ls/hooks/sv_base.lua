----------------------------------
----------- Connection -----------
----------------------------------
hook.Add("PlayerInitialSpawn", "DarkRPLS_connection", function(ply)
    local xp = DLS_XPValues("connection")
    DLS_checkPlayerDatabase(ply)
    DLS_addXPToPlayer(ply, xp)
    DLS_updatePlayerName(ply)

    timer.Simple(1, function()
        ply:SetNWInt("darkrp_ls_level", DLS_getPlayerLevel(ply))
        ply:SetNWInt("darkrp_ls_xp", DLS_getPlayerXP(ply))
    
        ply:setDarkRPVar("level", DLS_getPlayerLevel(ply))
        ply:setDarkRPVar("xp", DLS_getPlayerXP(ply))
    end)
end)


----------------------------------
-------------- Kills -------------
----------------------------------
hook.Add("PlayerDeath", "DarkRPLS_Death", function(victim, inflictor, attacker)
    local xp_deaths = DLS_XPValues("death")
    DLS_checkPlayerDatabase(victim)
    DLS_addXPToPlayer(victim, xp_deaths)
    DLS_updatePlayerName(victim)

    victim:SetNWInt("darkrp_ls_level", DLS_getPlayerLevel(victim))
    victim:SetNWInt("darkrp_ls_xp", DLS_getPlayerXP(victim))

    victim:setDarkRPVar("level", DLS_getPlayerLevel(victim))
    victim:setDarkRPVar("xp", DLS_getPlayerXP(victim))

    if inflictor:IsPlayer() and (victim ~= attacker) then
        local xp_kills = DLS_XPValues("kill")
        DLS_checkPlayerDatabase(attacker)
        DLS_addXPToPlayer(attacker, xp_kills)
        DLS_updatePlayerName(attacker)

        attacker:SetNWInt("darkrp_ls_level", DLS_getPlayerLevel(attacker))
        attacker:SetNWInt("darkrp_ls_xp", DLS_getPlayerXP(attacker))

        attacker:setDarkRPVar("level", DLS_getPlayerLevel(attacker))
        attacker:setDarkRPVar("xp", DLS_getPlayerXP(attacker))
    end
end)


----------------------------------
-------------- Chats -------------
----------------------------------
hook.Add("PlayerSay", "DarkRPLS_Chat", function(ply)
    local xp = DLS_XPValues("chat")
    DLS_checkPlayerDatabase(ply)
    DLS_addXPToPlayer(ply, xp)
    DLS_updatePlayerName(ply)

    ply:SetNWInt("darkrp_ls_level", DLS_getPlayerLevel(ply))
    ply:SetNWInt("darkrp_ls_xp", DLS_getPlayerXP(ply))

    ply:setDarkRPVar("level", DLS_getPlayerLevel(ply))
    ply:setDarkRPVar("xp", DLS_getPlayerXP(ply))
end)


----------------------------------
------------- Physgun ------------
----------------------------------
--[[
hook.Add("PhysgunPickup", "DarkRPLS_Physgun", function(ply, ent)
    if table.HasValue(darkrp_ls.entityWhitelist, ent:GetClass()) then
        local xp = DLS_XPValues("physgun")
        DLS_checkPlayerDatabase(ply)
        DLS_addXPToPlayer(ply, xp)
        DLS_updatePlayerName(ply)
        
        ply:SetNWInt("darkrp_ls_level", DLS_getPlayerLevel(ply))
        ply:SetNWInt("darkrp_ls_xp", DLS_getPlayerXP(ply))

        ply:setDarkRPVar("level", DLS_getPlayerLevel(ply))
        ply:setDarkRPVar("xp", DLS_getPlayerXP(ply))
    end
end)
--]]

----------------------------------
----------- NPC Killed -----------
----------------------------------
hook.Add("OnNPCKilled", "DarkRPLS_NPCKilled", function(npc, attacker, inflictor)
    if ( npc:IsNPC() or npc:IsNextBot() ) then
        local xp = DLS_XPValues("npc_killed")
        DLS_checkPlayerDatabase(attacker)
        DLS_addXPToPlayer(attacker, xp)
        DLS_updatePlayerName(attacker)

        attacker:setDarkRPVar("level", DLS_getPlayerLevel(attacker))
        attacker:setDarkRPVar("xp", DLS_getPlayerXP(attacker))

        attacker:SetNWInt("darkrp_ls_level", DLS_getPlayerLevel(attacker))
        attacker:SetNWInt("darkrp_ls_xp", DLS_getPlayerXP(attacker))
    end
end)


----------------------------------
----------- Toolgun -----------
----------------------------------
hook.Add("CanTool", "DarkRPLS_Toolgun", function(ply, _, _, _, button)
    if button == 107 then
        local xp = DLS_XPValues("toolgun")
        DLS_checkPlayerDatabase(ply)
        DLS_addXPToPlayer(ply, xp)
        DLS_updatePlayerName(ply)

        ply:setDarkRPVar("level", DLS_getPlayerLevel(ply))
        ply:setDarkRPVar("xp", DLS_getPlayerXP(ply))

        ply:SetNWInt("darkrp_ls_level", DLS_getPlayerLevel(ply))
        ply:SetNWInt("darkrp_ls_xp", DLS_getPlayerXP(ply))
    end
end)