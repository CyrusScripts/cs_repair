QBCore = exports['qb-core']:GetCoreObject()

local repairing = false

RegisterNetEvent('cs_repair:useRepairKit', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local vehicle = GetClosestVehicle(coords, 5.0, 0, 71) -- Detect the nearest vehicle within 5 meters

    if repairing then
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'You are already repairing!'})
        return
    end

    if not vehicle or vehicle == 0 then
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'No vehicle nearby to repair!'})
        return
    end

    local damage = GetVehicleEngineHealth(vehicle)
    if damage > 900.0 then
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'This vehicle doesn\'t need repairs!'})
        return
    end

    -- Ensure the player is outside the vehicle
    if IsPedInAnyVehicle(ped, true) then
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'You must be outside the vehicle to repair it!'})
        return
    end

    -- Check if the player is in front of the vehicle
    local vehicleCoords = GetEntityCoords(vehicle)
    local vehicleForward = GetEntityForwardVector(vehicle)
    local playerToVehicle = coords - vehicleCoords
    local dotProduct = DotProduct(vehicleForward, playerToVehicle)

    if dotProduct < 0 then
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'You must be in front of the vehicle to repair it!'})
        return
    end

    repairing = true

    -- Start animation
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_BUM_BIN", 0, true)

    -- ox_lib progress bar
    local progress = lib.progressBar({
        duration = 10000, -- Repair time in ms (10 seconds)
        label = 'Repairing vehicle...',
        useWhileDead = false,
        canCancel = true,
        disable = {
            car = true,
            move = true,
            combat = true
        }
    })

    -- Stop animation and handle repair completion
    ClearPedTasksImmediately(ped)

    if progress then
        -- Successfully repaired
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleEngineHealth(vehicle, 1000.0)
        SetVehiclePetrolTankHealth(vehicle, 1000.0)
        TriggerEvent('ox_lib:notify', {type = 'success', description = 'Vehicle repaired successfully!'})

        -- Remove the repair item
        TriggerServerEvent('ox_inventory:removeItem', 'repairitem', 1)
    else
        TriggerEvent('ox_lib:notify', {type = 'error', description = 'Repair cancelled!'})
    end

    repairing = false
end)

-- Helper function to calculate dot product
function DotProduct(vec1, vec2)
    return vec1.x * vec2.x + vec1.y * vec2.y + vec1.z * vec2.z
end
