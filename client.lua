ESX = exports["es_extended"]:getSharedObject()

local npcs = {}

local function SpawnNPC(npcData, index)
	if npcData.useMarker then return end

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
		local sleep = 500
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isNearLocation = false

		for i, locationData in ipairs(Config.NPCs) do
			local dist = #(playerCoords - locationData.coords)

			-- Only process if within range
			if dist < 10.0 then
				sleep = 0

				-- Draw marker if useMarker is true
				if locationData.useMarker then
					DrawMarker(21, locationData.coords.x, locationData.coords.y, locationData.coords.z - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 209, 134, 0, 155, false, true, 2, true, false, false, false)
				end

				-- Show interaction prompt and handle input when very close
				if dist < 2.0 then
					isNearLocation = true
					ESX.ShowHelpNotification(locationData.label)

					if IsControlJustReleased(0, 38) then -- E
						TriggerServerEvent('website_npc:openWebsite', locationData.website)
					end
				end
			end
		end

		Wait(sleep)
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
