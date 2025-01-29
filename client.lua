local inVehicle = false
local speed = 0
local fuel = 0

-- Päälogiikka ajoneuvon nopeuden ja polttoaineen näyttämiseen
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)  -- Päivittää 10 kerran sekunnissa
        
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        -- Tarkistetaan, onko pelaaja ajoneuvossa ja kuskin paikalla
        if IsPedInAnyVehicle(playerPed, false) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
            inVehicle = true
            speed = math.ceil(GetEntitySpeed(vehicle) * 3.6) -- Muutetaan m/s -> km/h
            fuel = exports['ox_fuel']:GetFuel(vehicle) -- Haetaan polttoaineen määrä ox_fuelista
        else
            inVehicle = false
        end

        -- Lähetetään tiedot UI:lle
        SendNUIMessage({
            type = "update",
            speed = speed,
            fuel = fuel
        })
    end
end)

-- Avaa/hides UI, kun pelaaja on ajoneuvossa
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        
        if inVehicle then
            SetNuiFocus(true, true)
        else
            SetNuiFocus(false, false)
        end
    end
end)
