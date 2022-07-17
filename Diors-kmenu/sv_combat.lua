RegisterNetEvent("ZERO:sv_combatSetEntityAlpha")
AddEventHandler("ZERO:sv_combatSetEntityAlpha", function(value)
    local source = source
    local entity = GetPlayerPed(source)
    TriggerClientEvent("ZERO:cl_combatSetEntityAlpha", -1, entity, value)
end)