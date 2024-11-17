Thanks for purchasing the Codem Garage 

- First, set up the sql file.
- Set the config.framework to your own framework
- if you are using custom car edit vehicle_name.lua 
- stop qb-garages !

Only qb-core : 
qb-phone/server/main.lua
----------------------------------------------------------------

        local garageresult = MySQL.query.await('SELECT * FROM player_vehicles WHERE citizenid = ?', {Player.PlayerData.citizenid})
        if garageresult[1] ~= nil then
            for _, v in pairs(garageresult) do
                local vehicleModel = v.vehicle
                if (QBCore.Shared.Vehicles[vehicleModel] ~= nil) and (Garages[v.garage] ~= nil) then
                    v.garage = Garages[v.garage].label
                    v.vehicle = QBCore.Shared.Vehicles[vehicleModel].name
                    v.brand = QBCore.Shared.Vehicles[vehicleModel].brand
                end

            end
            PhoneData.Garage = garageresult
        end 

----------------------------------------------------------------
	replace : 
----------------------------------------------------------------
   	local garageresult = MySQL.query.await('SELECT * FROM player_vehicles WHERE citizenid = ?', {Player.PlayerData.citizenid})
        if garageresult[1] ~= nil then
            for _, v in pairs(garageresult) do
                local vehicleModel = v.vehicle
            
                if (QBCore.Shared.Vehicles[vehicleModel] ~= nil) and (Config.Garages[v.parking].garagename ~= nil) then
                    
                    v.garage = Config.Garages[v.parking].garagename
                    v.vehicle = QBCore.Shared.Vehicles[vehicleModel].name
                    v.brand = QBCore.Shared.Vehicles[vehicleModel].brand
                end

            end
            PhoneData.Garage = garageresult
          
        end
----------------------------------------------------------------
qb-phone/fxmanifest
----------------------------------------------------------------
shared_scripts {
    'config.lua',
    '@qb-apartments/config.lua',
    '@qb-garages/config.lua',
}
----------------------------------------------------------------
replace
----------------------------------------------------------------
shared_scripts {
    'config.lua',
    '@qb-apartments/config.lua',
    '@codem-garage/config.lua',
}
----------------------------------------------------------------



if you have any issues you can join our discord to get support  
https://discord.gg/zj3QsUfxWs
Author Magni#0247