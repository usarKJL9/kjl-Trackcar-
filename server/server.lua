local QBCore = exports['qb-core']:GetCoreObject()



QBCore.Functions.CreateUseableItem(Config.TrackerItem, function(source, item)

    local Player = QBCore.Functions.GetPlayer(source)

    if Player then

        TriggerClientEvent("police:client:UseCarTracker", source)

    end

end)



RegisterNetEvent("police:server:AttachTracker", function(vehicleNetId)

    local src = source

    local Player = QBCore.Functions.GetPlayer(src)

    if Player then

        if Player.Functions.GetItemByName(Config.TrackerItem) then

            Player.Functions.RemoveItem(Config.TrackerItem, 1)

            TriggerClientEvent("police:client:TrackerAttached", -1, vehicleNetId, src)

        else

            TriggerClientEvent("QBCore:Notify", src, "You don't have a tracker!", "error")

        end

    end

end)



RegisterNetEvent("police:server:RemoveTracker", function(vehicleNetId)

    TriggerClientEvent("police:client:RemoveTracker", -1, vehicleNetId)

end)
