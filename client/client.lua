local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("police:client:UseCarTracker", function()
    local playerPed = PlayerPedId()
    local vehicle = QBCore.Functions.GetClosestVehicle()
    if DoesEntityExist(vehicle) then
        local vehicleNetId = NetworkGetNetworkIdFromEntity(vehicle)
        TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
        QBCore.Functions.Progressbar("attach_tracker", "Attaching Tracker...", Config.AttachTime, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() 
            ClearPedTasks(playerPed)
            TriggerServerEvent("police:server:AttachTracker", vehicleNetId)
        end, function()
            ClearPedTasks(playerPed)
            QBCore.Functions.Notify("Canceled", "error")
        end)
    else
        QBCore.Functions.Notify("No vehicle nearby!", "error")
    end
end)

RegisterNetEvent("police:client:TrackerAttached", function(vehicleNetId, source)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if DoesEntityExist(vehicle) then
        local trackerBlip = AddBlipForEntity(vehicle)
        SetBlipSprite(trackerBlip, Config.BlipSettings.sprite)
        SetBlipColour(trackerBlip, Config.BlipSettings.color)
        SetBlipScale(trackerBlip, Config.BlipSettings.scale)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.BlipSettings.name)
        EndTextCommandSetBlipName(trackerBlip)
        QBCore.Functions.Notify("Tracker attached successfully!", "success")

        Wait(Config.TrackerDuration)
        RemoveBlip(trackerBlip)
        TriggerServerEvent("police:server:RemoveTracker", vehicleNetId)
    end
end)

RegisterNetEvent("police:client:RemoveTracker", function(vehicleNetId)
    local vehicle = NetworkGetEntityFromNetworkId(vehicleNetId)
    if DoesEntityExist(vehicle) then
        local trackerBlip = GetBlipFromEntity(vehicle)
        if DoesBlipExist(trackerBlip) then
            RemoveBlip(trackerBlip)
            QBCore.Functions.Notify("Tracker removed.", "error")
        end
    end
end)
