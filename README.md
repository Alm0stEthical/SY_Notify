# SY_Notify

<kbd><img src="https://user-images.githubusercontent.com/89760730/236665874-97ffd5ca-6abb-4f30-8fb9-1920847baaf3.png" /></kbd>
   
<kbd><img src="https://user-images.githubusercontent.com/89760730/234043343-a3402e7b-e702-4106-88ff-c04dbe07f3e0.png" /></kbd>

# Dependency
  - [ESX](https://github.com/esx-framework/esx_core) or [QBCore](https://github.com/qbcore-framework/qb-core)
  
# Installation
  - Download the file and put it in the resource directory.
  - Rename the Folder to `SY_Notify`.
  - Add `ensure SY_Notify` in your `server.cfg`.

1. To display a notification, you should call it like below:
   1. Using Client Side:
    ```lua
       exports['SY_Notify']:Alert("Title", "Message", Time, 'type')
    ```
   2. Using Server Side:
    ```lua 
       TriggerClientEvent('SY_Notify:Alert', source, "Title", "Message", Time, 'type')
    ```

2. To set the notification display time, use:
   1. 1000 - `[1 second]`
   2. 2000 - `[2 seconds]`
   3. 5000 - `[5 seconds]`
   4. 10000 - `[10 seconds]`
   5. etc...

3. To change the type of notification, use these types of notifications:
   1. success
   2. info
   3. warning
   4. error
   5. announcement

4. To set the notification position, use the provided command in-game, and it will be saved persistently across server restarts.

5. IF YOU NEED TO ADD THIS NOTIFICATION AS DEFAULT IN ESX LEGACY, ADD THE GIVEN CODE IN `@es_extended/client/function.lua`:

```lua
   function ESX.ShowNotification(message, type, length)
      if GetResourceState("esx_notify") ~= "missing" then
         exports["esx_notify"]:Notify(type, length, message)
      else
         print("[^1ERROR^7] ^5ESX Notify^7 is Missing!")
      end
   end
```
replace it with:
```lua
   function ESX.ShowNotification(message, type, length)
      if GetResourceState("SY_Notify") ~= "missing" then
         exports['SY_Notify']:Alert("NOTIFICATION", message, length, type)
      else
         print("[^1ERROR^7] ^5SY_NOTIFY^7 is Missing!")
      end
   end
```

### Notes:
- Ensure you have the latest versions of ESX or QBCore installed.