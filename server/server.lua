local ESX = nil
local QBCore = nil

CreateThread(function()
    while ESX == nil and QBCore == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        QBCore = exports['qb-core']:GetCoreObject()
        Wait(100)
    end
end)

RegisterNetEvent('SY_Notify:setMeta')
AddEventHandler('SY_Notify:setMeta', function(positiondata)
    local src = source
    local identifier = nil

    if ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        identifier = xPlayer.identifier
    elseif QBCore then
        local Player = QBCore.Functions.GetPlayer(src)
        identifier = Player.PlayerData.citizenid
    end

    if identifier then
        SetResourceKvp("sy_notify_" .. identifier, json.encode(positiondata))
    end
end)

ESX.RegisterServerCallback('SY_Notify:getMeta', function(src, cb)
    local identifier = nil

    if ESX then
        local xPlayer = ESX.GetPlayerFromId(src)
        identifier = xPlayer.identifier
    elseif QBCore then
        local Player = QBCore.Functions.GetPlayer(src)
        identifier = Player.PlayerData.citizenid
    end

    if identifier then
        local position = GetResourceKvpString("sy_notify_" .. identifier)
        if position == nil then
            position = json.encode(Config.Defaultposition)
        end
        cb(json.decode(position))
    else
        cb(Config.Defaultposition)
    end
end)
