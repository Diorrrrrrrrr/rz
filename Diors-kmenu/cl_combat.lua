local prevVehicle = nil
local inRedzone = false
local passive = false
local redZoneV3 = vector3(-227.3, -2622.93, 6.05)
local timers = {
    health = 0,
    armour = 0,
    bus = 0,
    invincibility = 0,
}
local cooldowns = {
    health = 15,
    armour = 15,
    bus = 60,
    invincibility = 3
}

local weapons = {
    [1] = {
        name = "AP Pistol",
        id = "weapon_appistol",
        description = "Spawn in an AP Pistol"
    },
	[2] = {
        name = "Combat Pistol",
        id = "weapon_combatpistol",
        description = "Spawn in a Combat Pistol"
    },

    [3] = {
        name = "Bandna Pistol",
        id = "weapon_pistol",
        description = "Spawn in a Bandna Pistol"
    }
}

local vehicles = {
    [1] = {
        name = "Divo",
        id = "divo1",
    },
}

local redzones = {
    [1] = {
        coords = vector3(1407.46, 3079.59, 129.12),
        heading = 0,
        name = "FFA",
    },
    [2] = {
        coords = vector3(174.04,-2608.65,6.01),
        heading = 85.45,
        name = "Opium RedZone",
    },
}

local ramps = {
    [1] = {
        coords = vector3(-1155,2678,767),
        heading = 267.07,
        name = "Water Ramps",
    },
    [2] = {
        coords = vector3(-2968.668,4815.978,425.0164),
        heading = 267.07,
        name = "Small Water Ramps",
    },
    [3] = {
        coords = vector3(-958.94,-779.92,17.84),
        heading = 231.04,
        name = "Skate Ramps",
    },
    [4] = {
        coords = vector3(-1028.97,-3358.16,14.15),
        heading = 147.72,
        name = "Airport Ramps",
    },
    [5] = {
        coords = vector3(-1198.4619,-2287.2205,13.9731),
        heading = 0,
        name = "Glass Ramps",
    },
    [6] = {
        coords = vector3(-1774.12,5699.27,223.83),
        heading = 0,
        name = "1v1 Ramps",
    },
    [7] = {
        coords = vector3(-2982.56,-3668.13,102.99),
        heading = 180.42,
        name = "Example Personal Ramp",
    },
}

local arenas = {
    [1] = {
        coords = vector3(2017.89,2784.06,51.30),
        heading = 0,
        name = "Paintball Arena",
    },
    [2] = {
        coords = vector3(-2641.31,6607.65,36.96),
        heading = 0,
        name = "Sky Arena",
    },
}

function notify(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(msg)
    DrawNotification(true, false)
end

function setInvincibility()
    timers.invincibility = cooldowns.invincibility
end

RMenu.Add('combat', 'main', RageUI.CreateMenu("","", 700, nil))
RMenu:Get('combat', 'main'):SetSubtitle("~p~ Dior | ~w~ | " .. "ID: " .. GetPlayerServerId(NetworkGetEntityOwner(GetPlayerPed(-1))))
RMenu.Add('combat', 'weapons', RageUI.CreateSubMenu(RMenu:Get('combat','main'), "", "Choose your weapon", nil, nil))
RMenu.Add('combat', 'vehicles', RageUI.CreateSubMenu(RMenu:Get('combat','main'), "", "Select a vehicle", nil, nil))
RMenu.Add('combat', 'redzones', RageUI.CreateSubMenu(RMenu:Get('combat','main'), "", "Select a RedZone to teleport to", nil, nil))
RMenu.Add('combat', 'ramps', RageUI.CreateSubMenu(RMenu:Get('combat','main'), "", "Select a Ramp to teleport to", nil, nil))
RMenu.Add('combat', 'arenas', RageUI.CreateSubMenu(RMenu:Get('combat','main'), "", "Select a Arena to teleport to", nil, nil))


RageUI.CreateWhile(1.0, RMenu:Get('combat', 'main'), 311, function()
    RageUI.IsVisible(RMenu:Get('combat', 'main'), true, false, true, function()
        if not inRedzone then

            RageUI.Button("~b~Weapon Spawner", "Select to open the weapon spawner", { RightLabel = "??" }, true, function(Hovered, Active, Selected)
                if (Selected) then end
            end, RMenu:Get('combat','weapons'))

            RageUI.Button("~r~RedZones", "Select to open the redzone teleport menu", { RightLabel = "??" }, true, function(Hovered, Active, Selected)
                if (Selected) then end
            end, RMenu:Get('combat','redzones'))

            RageUI.Button("~p~Ramps", "Select to open the ramp teleport menu", { RightLabel = "??" }, true, function(Hovered, Active, Selected)
                if (Selected) then end
            end, RMenu:Get('combat','ramps'))
          
          
            RageUI.Button("~r~Skin Menu", "Opens Skin Menu", { RightLabel = "???" }, true, function(Hovered, Active, Selected)
                if (Selected) then 
                    exports['fivem-appearance']:startPlayerCustomization(function (appearance)
                        if (appearance) then
                          TriggerServerEvent('saveCharacterCustomization', JSON.encode(appearance))
                        
   end
                    
                    end)
                end
            end)

            
            RageUI.Button("~y~Arenas", "Select to open the ramp teleport menu", { RightLabel = "??" }, true, function(Hovered, Active, Selected)
                if (Selected) then end
            end, RMenu:Get('combat','arenas'))

        --     RageUI.Button("~r~Skin Menu", "Open Skin Menu.", { RightLabel = "???" }, true, function(Hovered, Active, Selected)
        --         if (Selected) then end
        --         exports['fivem-appearance']:startPlayerCustomization(function(appearance)
		-- 			if appearance then
		-- 				TriggerServerEvent('mrz-core:server:save-skin', appearance)
		-- 			end
        --         end)
        --     end, null
        -- else
        -- end
     




            if #(GetEntityCoords(PlayerPedId())-vector3(166.68,-2607.8,6.01)) <= 40.0 then
                RageUI.Button("~o~Vehicle Spawner", "Select to open the vehicle spawner", { RightLabel = "??" }, true, function(Hovered, Active, Selected)
                    if (Selected) then end
                end, RMenu:Get('combat','vehicles'))
            else
                RageUI.Separator("Vehicles can only be spawned at Opium Redzone!")
            end
             RageUI.IsVisible(RMenu:Get('combat', 'ramps'),true,false,true,function()
        for name, values in ipairs(ramps) do
            RageUI.Button(tostring(values.name), string.format("Select to teleport to %s", values.name),{ }, true, function(Hovered, Active, Selected)
                if (Selected) then
                    local playerPed = PlayerPedId()
                    setInvincibility()
                    SetEntityCoords(playerPed, values.coords.x, values.coords.y, values.coords.z, 0, 0, 0, false)
                    SetEntityHeading(playerPed, values.heading)
                end
            end)
        end 
    end, function()
        ---Panels
    end)
    RageUI.Button("~g~Clear Loadout", "Select to reset your loadout", { RightLabel = "??" }, true, function(Hovered, Active, Selected)
        if (Selected) then
            RemoveAllPedWeapons(GetPlayerPed(-1), true)
            notify("Your loadout was cleared.")
        end
    end, nil)
else
    RageUI.Separator("You cannot use this menu in this area!")
end
end, function()
end)
RageUI.IsVisible(RMenu:Get('combat', 'weapons'),true,false,true,function()
for name, values in ipairs(weapons) do
    RageUI.Button(tostring(values.name), string.format("%s", values.description),{ }, true, function(Hovered, Active, Selected)
        if (Selected) then
            GiveWeaponToPed(PlayerPedId(), GetHashKey(values.id), 9999, false, true)
        end
    end)
end 
end, function()
---Panels
end)

RageUI.IsVisible(RMenu:Get('combat', 'vehicles'),true,false,true,function()
if #(GetEntityCoords(PlayerPedId())-vector3(166.68,-2607.8,6.01)) <= 40.0 then
for name, values in ipairs(vehicles) do
    RageUI.Button(tostring(values.name), string.format("Select to spawn a %s", values.name),{ }, true, function(Hovered, Active, Selected)
        if (Selected) then
            if (values.name == "Divo" and timers.bus <= 0) or values.name ~= "Divo" then
                if values.name == "Divo" then
                    timers.bus = cooldowns.bus
                end
                RequestModel(GetHashKey(values.id))
                while not HasModelLoaded(GetHashKey(values.id)) do
                    Citizen.Wait(100)
                end
                local playerPed = PlayerPedId()
                local pos = GetEntityCoords(playerPed)
                local vehicle = CreateVehicle(GetHashKey(values.id), pos.x, pos.y, pos.z, GetEntityHeading(playerPed), true, false)
                SetPedIntoVehicle(playerPed, vehicle, -1)
                if prevVehicle ~= nil then
                    SetEntityAsMissionEntity(prevVehicle, true, true)
                    DeleteVehicle(prevVehicle)
                end
                prevVehicle = vehicle
            else
                notify(string.format("~r~You cannot spawn another Divo for %ss",timers.bus))
                
            end
        end
    end)
end 
end
end, function()
---Panels
end)
RageUI.IsVisible(RMenu:Get('combat', 'redzones'),true,false,true,function()
for name, values in ipairs(redzones) do
    RageUI.Button(tostring(values.name), string.format("Select to teleport to %s", values.name),{ }, true, function(Hovered, Active, Selected)
        if (Selected) then
            local playerPed = PlayerPedId()
            setInvincibility()
            SetEntityCoords(playerPed, values.coords.x, values.coords.y, values.coords.z, 0, 0, 0, false)
            SetEntityHeading(playerPed, values.heading)
        end
    end)
end 
end, function()
---Panels
end)
RageUI.IsVisible(RMenu:Get('combat', 'ramps'),true,false,true,function()
for name, values in ipairs(ramps) do
    RageUI.Button(tostring(values.name), string.format("Select to teleport to %s", values.name),{ }, true, function(Hovered, Active, Selected)
        if (Selected) then
            local playerPed = PlayerPedId()
            setInvincibility()
            SetEntityCoords(playerPed, values.coords.x, values.coords.y, values.coords.z, 0, 0, 0, false)
            SetEntityHeading(playerPed, values.heading)
        end
    end)
end 
end, function()
---Panels
end)
RageUI.IsVisible(RMenu:Get('combat', 'arenas'),true,false,true,function()
for name, values in ipairs(arenas) do
    RageUI.Button(tostring(values.name), string.format("Select to teleport to %s", values.name),{ }, true, function(Hovered, Active, Selected)
        if (Selected) then
            local playerPed = PlayerPedId()
            setInvincibility()
            SetEntityCoords(playerPed, values.coords.x, values.coords.y, values.coords.z, 0, 0, 0, false)
            SetEntityHeading(playerPed, values.heading)
        end
    end)
end 
end, function()
---Panels
end)
end)

Citizen.CreateThread(function()
while true do
-- decreasing timers
for k,_ in pairs(timers) do
    timers[k] = timers[k]-1
end
-- checking of dist to redzone
local pos = GetEntityCoords(PlayerPedId())
dist = #(redZoneV3-pos)
if dist <= 190 then
    inRedzone = true
else
    inRedzone = false
end
if timers.invincibility > 0 then
    SetPlayerInvincibleKeepRagdollEnabled(PlayerId(), true)
    passive = true
    SetEntityAlpha(GetPlayerPed(-1), 155)
elseif timers.invincibility == 0 then
    SetPlayerInvincibleKeepRagdollEnabled(PlayerId(), false)
    passive = false
    SetEntityAlpha(GetPlayerPed(-1), 255)
    HudWeaponWheelIgnoreControlInput(false)
end
if passive then
    for _, i in ipairs(GetActivePlayers()) do
        if i ~= PlayerId() then
        local closestPlayerPed = GetPlayerPed(i)
        local veh = GetVehiclePedIsIn(closestPlayerPed, false)
        SetEntityNoCollisionEntity(veh, GetVehiclePedIsIn(GetPlayerPed(-1), false), false)
        end
    end
end
Wait(1)
end
end)

Citizen.CreateThread(function()
while true do
while timers.invincibility > 0 do
    HudWeaponWheelIgnoreControlInput(true)
    Wait(0)
end
Wait(400)
end
end)