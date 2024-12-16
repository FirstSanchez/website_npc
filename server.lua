ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('website_npc:openWebsite')
AddEventHandler('website_npc:openWebsite', function(url)
    local _source = source
    -- Additional checks can be added here if necessary
    TriggerClientEvent('website_npc:openBrowser', _source, url)
end)
