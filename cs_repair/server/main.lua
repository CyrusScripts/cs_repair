QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("repairitem", function(source, item)
    TriggerClientEvent('cs_repair:useRepairKit', source)
end)
