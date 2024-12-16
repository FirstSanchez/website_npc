ESX = exports["es_extended"]:getSharedObject()

local npcs = {}

local function SpawnNPC(npcData, index)
    RequestModel(GetHashKey(npcData.model))
    while not HasModelLoaded(GetHashKey(npcData.model)) do
        Wait(1)
    end

    npcs[index] = CreatePed(4, GetHashKey(npcData.model), npcData.coords.x, npcData.coords.y, npcData.coords.z - 1, npcData.heading, false, true)
    FreezeEntityPosition(npcs[index], true)
    SetEntityInvincible(npcs[index], true)
    SetBlockingOfNonTemporaryEvents(npcs[index], true)
    
    SetModelAsNoLongerNeeded(GetHashKey(npcData.model))
end

local function SpawnAllNPCs()
    for i, npcData in ipairs(Config.NPCs) do
        SpawnNPC(npcData, i)
    end
end

CreateThread(function()
    SpawnAllNPCs()
    
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId())
        local isNearNPC = false
        
        for i, npcData in ipairs(Config.NPCs) do
            local dist = #(playerCoords - npcData.coords)
            
            if dist < 2.0 then
                isNearNPC = true
                ESX.ShowHelpNotification(npcData.label)
                
                if IsControlJustReleased(0, 38) then -- E
                    TriggerServerEvent('website_npc:openWebsite', npcData.website)
                end
            end
        end
        if isNearNPC then
            Wait(0)
        else
            Wait(500)
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    
    for _, npc in pairs(npcs) do
        if DoesEntityExist(npc) then
            DeletePed(npc)
        end
    end
end)

RegisterNetEvent('website_npc:openBrowser')
AddEventHandler('website_npc:openBrowser', function(url)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "openWebsite",
        link = url
    })
end)

RegisterNUICallback('closeWebsite', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, 177) then 
            SetNuiFocus(false, false)
        end
    end
end)
