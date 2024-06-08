local ESX = nil
local QBCore = nil

CreateThread(function()
    while ESX == nil and QBCore == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        QBCore = exports['qb-core']:GetCoreObject()
        Wait(100)
    end
end)

--- 
-- @param {string} title - The title of the alert
-- @param {string} message - The message of the alert
-- @param {number} time - The time the alert should be displayed (in milliseconds)
-- @param {string} messagetype - The type of the alert (e.g., 'success', 'info', 'warning', 'error')
function Alert(title, message, time, messagetype)
    local callback = function(position)
        if type(messagetype) ~= "string" then
            messagetype = 'info'
        end

        if type(time) ~= 'number' then
            time = 5000
        end

        SendNUIMessage({
            action = 'open',
            title = title,
            type = messagetype or 'info',
            message = message,
            time = time,
            position = position
        })
    end

    if ESX then
        ESX.TriggerServerCallback('SY_Notify:getMeta', callback)
    elseif QBCore then
        QBCore.Functions.TriggerCallback('SY_Notify:getMeta', callback)
    end
end

RegisterCommand(Config.Settingcommand, function()
    local callback = function(position)
        SetNuiFocus(true, true)
        SendNUIMessage({
            action = 'opensetting',
            position = position
        })
    end

    if ESX then
        ESX.TriggerServerCallback('SY_Notify:getMeta', callback)
    elseif QBCore then
        QBCore.Functions.TriggerCallback('SY_Notify:getMeta', callback)
    end
end)

RegisterNUICallback("close", function()
    SetNuiFocus(false, false)
    SendNUIMessage({ message = "hide" })
end)

RegisterNUICallback("notify-position", function(data)
    local position = data
    TriggerServerEvent('SY_Notify:setMeta', position)
end)

RegisterNetEvent('SY_Notify:Alert', Alert)
exports('Alert', Alert)

RegisterCommand('sy_notify_test', function()
    exports['SY_Notify']:Alert("SUCCESS", "This is ~g~TEST success MSG~s~", 5000, 'success')
    exports['SY_Notify']:Alert("INFORMATION", "This is TEST Info MSG", 5000, 'info')
    exports['SY_Notify']:Alert("ERROR", "This is ~r~TEST error MSG~s~", 5000, 'error')
    exports['SY_Notify']:Alert("WARNING", "This is TEST warning MSG", 5000, 'warning')
    exports['SY_Notify']:Alert("ANNOUNCEMENT", "This is TEST announcement MSG", 5000, 'announcement')
end)
