frameworkObject = nil

local fullname,photo,car,opened,jobgarage,verify = nil, nil, nil, nil, false, false
local vehicleprice = {}
local PlayerJob = {}
local sellcar = Config.Sell
local transferCar = Config.Transfer
local repair = Config.Repair
local MileageFormat = Config.MileageFormat
local yourVehicle2
local yourVehicle
local spawnedvehicle = {}
local dist2,dist3 = nil,nil

Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject() 
end)

RegisterNetEvent(Config.QBCoreplayerLoaded, function()
    PlayerJob = frameworkObject.Functions.GetPlayerData()
    TriggerServerEvent("garage:server:getName")
end)

RegisterNetEvent(Config.QBCoreOnJobUpdate,function(JobInfo)
	PlayerJob = frameworkObject.Functions.GetPlayerData()
end)

RegisterNetEvent(Config.playerLoaded)
AddEventHandler(Config.playerLoaded, function(xPlayer)
    PlayerJob = xPlayer
    TriggerServerEvent("garage:server:getName")
end)

RegisterNetEvent(Config.setJob,function(job)
	PlayerJob = job
end)

Citizen.CreateThread(function()
    if Config.Framework == "esx" then
        Citizen.Wait(2500)
        frameworkObject = GetFrameworkObject() 
        frameworkObject.TriggerServerCallback('garage:vehicleprice', function(data)
            for k,v in pairs(data) do        
                vehicleprice[v.hash] = { price = v.price}              
            end  
        end)
    else
        for k,v in pairs(frameworkObject.Shared.Vehicles) do
            vehicleprice[v.model] = { price = v.price, brand = v.brand, name = v.name  }
        end
    end
end)

RegisterNetEvent('garage:client:open')
AddEventHandler('garage:client:open', function(job,k)
    TriggerServerEvent("garage:server:getName")
    if job == "jobgarage" then
        if Config.Framework == "esx" then
            for p, l in pairs(Config.JobGarages) do 
                Citizen.Wait(50)
                for t, v in pairs(l.cars) do
                    if frameworkObject.PlayerData.job.grade >= v.grade then
                        local carhash = GetHashKey(v.model)
                        local carname = v.model                                
                        local vehicleName = GetLabelText(carname)   
                        local vhclass = GetVehicleClassFromName(carhash)
                        local weight = Config.Weight[vhclass]
                        local carmaxspeed   = Config.GetVehicleEstimatedMaxSpeed(carhash)
                        local logo = GetLabelText(Citizen.InvokeNative(0xF7AF4F159FF99F97, carhash, Citizen.ResultAsString()))
                        local ac = GetVehicleModelAcceleration(carhash)
                        local plate = GeneratePlate()
                        local stored = 1
                        local text = Config.Text[vhclass]
                        jobgarage = true
                        if (k == p) then
                            OpenGarage(fullname,photo,plate,carmaxspeed,k,1,vhclass,carname,true,0,0,false,false,100,job,logo,weight,ac,text,MileageFormat)
                        end
                    else
                        print("no")
                    end
                end
            end
        else
            for p, l in pairs(Config.JobGarages) do 
                Citizen.Wait(50)
                for t, v in pairs(l.cars) do

                    if frameworkObject.Functions.GetPlayerData().job.grade.level >= v.grade then
                        local carhash = GetHashKey(v.model)
                        local carname = v.model                                
                        local vehicleName = GetLabelText(carname)   
                        local vhclass = GetVehicleClassFromName(carhash)
                        local weight = Config.Weight[vhclass]
                        local carmaxspeed   = Config.GetVehicleEstimatedMaxSpeed(carhash)
                        local logo = GetLabelText(Citizen.InvokeNative(0xF7AF4F159FF99F97, carhash, Citizen.ResultAsString()))
                        local ac = GetVehicleModelAcceleration(carhash)
                        local plate = GeneratePlate()
                        local stored = 1
                        local text = Config.Text[vhclass]
                        jobgarage = true
                        if (k == p) then
                            OpenGarage(fullname,photo,plate,carmaxspeed,k,1,vhclass,carname,true,0,0,false,false,100,job,logo,weight,ac,text,MileageFormat)
                        end
                    else
                        print("no")
                    end
                end
            end
        end
    else
        if Config.Framework == "esx" then
            frameworkObject.TriggerServerCallback('garage:getvehicles2', function(data)
                for r, v in pairs(data) do 
                    Citizen.Wait(150)
                    frameworkObject.TriggerServerCallback('codem-garage:changedCars', function(veri2)      
                        local carhash = v.vehicle["model"]
                        local carname = GetDisplayNameFromVehicleModel(carhash)           
                        local vehicleName = GetLabelText(carname)     
                        local vhclass = GetVehicleClassFromName(carhash)
                        local carmaxspeed   = Config.GetVehicleEstimatedMaxSpeed(carhash)
                        local logo = GetLabelText(Citizen.InvokeNative(0xF7AF4F159FF99F97, carhash, Citizen.ResultAsString()))
                        local fuel = v.vehicle["fuelLevel"]
                        local weight = Config.Weight[vhclass]
                        local ac = GetVehicleModelAcceleration(carhash)
                        local text = Config.Text[vhclass]
                        local stored = v.stored
                        if Config.Out then
                            if veri2 then
                                stored = -1
                            end
                        end
                        if vehicleprice[carhash] ~= nil then 
                            local price = vehicleprice[carhash]
                            vhprice = price.price / 2 
                        else
                            vhprice = Config.Defaultprice
                        end    
                        if Config.GarageName then
                            if (v.garage == k) then
                                OpenGarage(fullname,photo,v.vehicle["plate"],carmaxspeed,v.garage,stored,vhclass,vehicleName,false,vhprice,v.favorite,sellcar,transferCar,fuel,job,logo,weight,ac,text,MileageFormat,repair)
                            end
                        else
                            OpenGarage(fullname,photo,v.vehicle["plate"],carmaxspeed,k,stored,vhclass,vehicleName,false,vhprice,v.favorite,sellcar,transferCar,fuel,job,logo,weight,ac,text,MileageFormat,repair)
                        end
                    end,v.vehicle["plate"])
                end
            end)
        else
            frameworkObject.Functions.TriggerCallback('garage:getvehicles2', function(data)
                for r, v in pairs(data) do 
                    Citizen.Wait(150)  
                    frameworkObject.Functions.TriggerCallback('codem-garage:changedCars', function(veri2)  
                        local carhash = v.hash    
                        local cr = GetHashKey(carhash)
                        local logo = GetLabelText(Citizen.InvokeNative(0xF7AF4F159FF99F97, CR, Citizen.ResultAsString()))
                        local vhclass = GetVehicleClassFromName(carhash)
                        local carmaxspeed   = Config.GetVehicleEstimatedMaxSpeed(carhash)
                        local brand2 = vehicleprice[v.hash]
                        local vhprice = brand2.price / 2 
                        local weight = Config.Weight[vhclass]
                        local text = Config.Text[vhclass]
                        if vhprice == 0 then vhprice = Config.Defaultprice end
                        local stored = v.stored
                        if Config.Out then
                            if veri2 then
                                stored = -1
                            end
                        end
                        local ac = GetVehicleModelAcceleration(cr)
                        local fuel = v.fuel
                        if Config.GarageName then
                            if (v.garage == k) then
                                OpenGarage(fullname,photo,v.plate,carmaxspeed,v.garage,stored,vhclass,v.hash,false,vhprice,v.favorite,sellcar,transferCar,fuel,job,logo,weight,ac,text,MileageFormat,repair)
                            end
                        else
                            OpenGarage(fullname,photo,v.plate,carmaxspeed,k,stored,vhclass,v.hash,false,vhprice,v.favorite,sellcar,transferCar,fuel,job,logo,weight,ac,text,MileageFormat,repair)
                        end
                    end, v.plate)
                end
            end)
        end
    end
end)

function round(num, numDecimalPlaces)
    local mult = 100^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function OpenGarage(fullname,photo,plate2,carmaxspeed,garage2,stored2,vhclass,vehicleName,job2,vhprice,favorite2,sellcar2,transferCar2,fuel2,garage3,logo2,weight2,acce2,text2,mileageFormat2,repair2)
    SendNUIMessage({
        action  = true,
        name    = fullname,
        avatar  = photo,
        plate   = plate2,
        max     = carmaxspeed,
        garage  = garage2,
        stored  = stored2,
        vhclass = vhclass,
        carname = vehicleName,
        job = job2,
        vehprice = vhprice,
        favorite = favorite2,
        sellcar = sellcar2,
        transferCar = transferCar2,
        fuel = fuel2,
        jobgarage = garage3,
        logo = logo2,
        weight = weight2,
        acce = acce2,
        text = text2,
        mileageFormat = mileageFormat2,
        repair = repair2
    })
    SetNuiFocus(true, true)
end

Citizen.CreateThread(function()
    if Config.Framework == "esx" then
        while true do
            local sleep = 2000
            local PlayerPed = PlayerPedId()
            local PCoord = GetEntityCoords(PlayerPed)
            local GetPlayerCar = GetVehiclePedIsIn(PlayerPed)
            local inRangeGarage = false
            for k, v in pairs(Config.Garages) do
                sleep = 0
                local dist = #(PCoord - vector3(v.npc["npc"].x,v.npc["npc"].y,v.npc["npc"].z))
                if dist <= 3.0 then
                    DrawText3Ds(v.npc["npc"].x,v.npc["npc"].y,v.npc["npc"].z + 0.98,Config.DrawtextGarage)
                    inRangeGarage = true
                    if IsControlJustReleased(0,38) and not opened then
                        frameworkObject.TriggerServerCallback('garage:getvehicles', function(data)
                            if data then
                                cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                                SetCamCoord(cam, v.camera["x"], v.camera["y"], v.camera["z"])
                                SetCamRot(cam, v.camera["rotationX"], v.camera["rotationY"], v.camera["rotationZ"])
                                SetCamActive(cam, true)
                                RenderScriptCams(1, 1, 750, 1, 1)
                                TriggerEvent("garage:client:open", v.garage, k)
                                opened = true
                            else
                                Config.Notification(Config.Notifications["notgarageinvehicle"]["message"],Config.Notifications["notgarageinvehicle"]["type"])
                            end
                        end, k)
                    end
                end
                local Distance = #(PCoord - v.car["garage"]) 
                if Config.Drawmarker then
                    dist2 = Distance <= Config.DrawmarkerDistance
                else
                    dist2 = Distance <= Config.DrawtextDistance 
                end
                if dist2 then
                    if IsPedInAnyVehicle(PlayerPedId(),false) then 
                        sleep = 5
                        if Config.Drawmarker then 
                            DrawMarker(Config.drawmarkerid, v.car["garage"].x,v.car["garage"].y,v.car["garage"].z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0, 6.0, 0.20, Config.red , Config.green , Config.blue , Config.alpha , false, false, false, 1, false, false, false)
                        else
                             DrawText3Ds(v.car["garage"].x,v.car["garage"].y,v.car["garage"].z,Config.Drawtextput)
                        end
                        inRangeGarage= true
                        if IsControlJustReleased(0, 38) then
                            local vehicleProps = frameworkObject.Game.GetVehicleProperties(GetPlayerCar)
                            local CarPlate = vehicleProps.plate
                            local class = GetVehicleClass(GetPlayerCar)
                            if v.garage == "normal" then
                                if class == 8 or class == 13 or class == 7 or class == 0 or class == 1 or class == 2 or class == 3 or class == 4 or class == 5 or class == 6 or class == 7 or class == 9 or class == 10 or class == 11 or class == 12 or class == 18 then
                                    verify = true
                                else
                                    verify = false
                                end
                            elseif v.garage == "aircraft" then
                                if class == 15 or class == 16 then
                                    verify = true
                                else
                                    verify = false
                                end
                            elseif v.garage == "boat" then
                                if class == 14 then
                                    verify = true
                                else
                                    verify = false
                                end
                            end
                            frameworkObject.TriggerServerCallback('garage:vehicleOwned', function(owned)
                                if owned and verify then
                                    TriggerServerEvent('garage:saveProps', CarPlate, frameworkObject.Game.GetVehicleProperties(GetPlayerCar))
                                    TriggerServerEvent('garage:stored', CarPlate , 1)
                                    TriggerServerEvent('garage:parking', CarPlate, k)
                                    if Config.TaskLeaveVehicle then
                                        TaskLeaveVehicle(PlayerPed, GetPlayerCar, 0)
                                    end

                                    Citizen.Wait(2000)
                                    frameworkObject.Game.DeleteVehicle(GetPlayerCar)
                                else
                                    Config.Notification(Config.Notifications["vehiclenotyour"]["message"],Config.Notifications["vehiclenotyour"]["type"])
                                end
                            end, CarPlate)
                        end
                    end

                end       
            end
            for k, v in pairs(Config.JobGarages) do
                sleep = 0
                local dist = #(PCoord - vector3(v.npc["npc"].x,v.npc["npc"].y,v.npc["npc"].z))
          
                if dist <= 3.0 then
                    DrawText3Ds(v.npc["npc"].x,v.npc["npc"].y,v.npc["npc"].z + 0.98,Config.DrawtextGarage)
                    inRangeGarage = true
                    if IsControlJustReleased(0,38) and not opened and not IsPedInAnyVehicle(PlayerPed) then
                        if frameworkObject.PlayerData.job.name == v.access then
                            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                            SetCamCoord(cam, v.camera["x"], v.camera["y"], v.camera["z"])
                            SetCamRot(cam, v.camera["rotationX"], v.camera["rotationY"], v.camera["rotationZ"])
                            SetCamActive(cam, true)
                            RenderScriptCams(1, 1, 750, 1, 1)
                            TriggerEvent("garage:client:open", v.garage ,k)
                            opened = true
                        else
                            Config.Notification(Config.Notifications["requiredjob"]["message"],Config.Notifications["requiredjob"]["type"])
                        end
                    end
                end

                local Distance = #(PCoord - v.car["garage"]) 
                if Config.Drawmarker then
                    dist2 = Distance <= Config.DrawmarkerDistance
                else
                    dist2 = Distance <= Config.DrawtextDistance 
                end
                if dist2 then
                    if IsPedInAnyVehicle(PlayerPedId(),false) then 
                        sleep = 5
                        if Config.Drawmarker then 
                            DrawMarker(Config.drawmarkerid, v.car["garage"].x,v.car["garage"].y,v.car["garage"].z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0, 6.0, 0.20, Config.red , Config.green , Config.blue , Config.alpha , false, false, false, 1, false, false, false)
                        else
                             DrawText3Ds(v.car["garage"].x,v.car["garage"].y,v.car["garage"].z,Config.Drawtextput)
                        end
                        inRangeGarage= true
                        if IsControlJustReleased(0, 38) then
                            local vehicleProps = frameworkObject.Game.GetVehicleProperties(GetPlayerCar)
                            local CarPlate = vehicleProps.plate
                            local class = GetVehicleClass(GetPlayerCar)
                            if Config.TaskLeaveVehicle then
                                TaskLeaveVehicle(PlayerPed, GetPlayerCar, 0)
                            end
                            Citizen.Wait(2000)
                            frameworkObject.Game.DeleteVehicle(GetPlayerCar)
                        end
                    end
                end
     
            end
            if not inRangeGarage then
                Citizen.Wait(2500)
            end
            Citizen.Wait(sleep)
        end
    else
        while true do
            local sleep = 2000
            local PlayerPed = PlayerPedId()
            local PCoord = GetEntityCoords(PlayerPed)
            local GetPlayerCar = GetVehiclePedIsIn(PlayerPed)
            local inRangeGarage = false
            for k, v in pairs(Config.Garages) do
                sleep = 0
                local dist = #(PCoord - vector3(v.npc["npc"].x,v.npc["npc"].y,v.npc["npc"].z))
                if dist <= 3.0 then
                    DrawText3Ds(v.npc["npc"].x,v.npc["npc"].y,v.npc["npc"].z + 0.98,Config.DrawtextGarage)
                    inRangeGarage = true
                    if IsControlJustReleased(0,38) and not opened then
                        frameworkObject.Functions.TriggerCallback('garage:getvehicles', function(data)
                            if data then
                                cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                                SetCamCoord(cam, v.camera["x"], v.camera["y"], v.camera["z"])
                                SetCamRot(cam, v.camera["rotationX"], v.camera["rotationY"], v.camera["rotationZ"])
                                SetCamActive(cam, true)
                                RenderScriptCams(1, 1, 750, 1, 1)
                                TriggerEvent("garage:client:open", v.garage, k)
                                opened = true
                            else
                                Config.Notification(Config.Notifications["notgarageinvehicle"]["message"],Config.Notifications["notgarageinvehicle"]["type"])
                            end
                        end, k)
                    end
                end
                local Distance = #(PCoord - v.car["garage"]) 
                if Config.Drawmarker then
                    dist3 = Distance <= Config.DrawmarkerDistance
                else
                    dist3 = Distance <= Config.DrawtextDistance 
                end
                if dist3 then
                    if IsPedInAnyVehicle(PlayerPedId(),false) then 
                        sleep = 5
                        if not Config.Drawmarker then 
                            DrawText3Ds(v.car["garage"].x,v.car["garage"].y,v.car["garage"].z + 0.98,Config.Drawtextput)
                        else
                            DrawMarker(Config.drawmarkerid, v.car["garage"].x,v.car["garage"].y,v.car["garage"].z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0, 6.0, 0.20, Config.red , Config.green , Config.blue , Config.alpha , false, false, false, 1, false, false, false)
                        end
                        inRangeGarage= true
                        if IsControlJustReleased(0, 38) then
                            local vehicleProps = frameworkObject.Functions.GetVehicleProperties(GetPlayerCar)
                            local CarPlate = vehicleProps.plate
                            local class = GetVehicleClass(GetPlayerCar)
                            if v.garage == "normal" then
                                if class == 8 or class == 13 or class == 7 or class == 0 or class == 1 or class == 2 or class == 3 or class == 4 or class == 5 or class == 6 or class == 7 or class == 9 or class == 10 or class == 11 or class == 12 or class == 18 then
                                    verify = true
                                else
                                    verify = false
                                end
                            elseif v.garage == "aircraft" then
                                if class == 15 or class == 16 then
                                    verify = true
                                else
                                    verify = false
                                end
                            elseif v.garage == "boat" then
                                if class == 14 then
                                    verify = true
                                else
                                    verify = false
                                end
                            end
                            frameworkObject.Functions.TriggerCallback('garage:vehicleOwned', function(owned)
                                if owned and verify then
                                    TriggerServerEvent('garage:saveProps', CarPlate, frameworkObject.Functions.GetVehicleProperties(GetPlayerCar))
                                    TriggerServerEvent('garage:stored', CarPlate , 1)
                                    TriggerServerEvent('garage:parking', CarPlate, k)
                                    if Config.TaskLeaveVehicle then
                                        TaskLeaveVehicle(PlayerPed, GetPlayerCar, 0)
                                    end
                                    local fuel = Config.GetVehicleFuel(GetPlayerCar)

                                    TriggerServerEvent('garage:fuel', CarPlate , fuel)
                                    Citizen.Wait(2000)
                                    frameworkObject.Functions.DeleteVehicle(GetPlayerCar)
                                else
                                    Config.Notification(Config.Notifications["vehiclenotyour"]["message"],Config.Notifications["vehiclenotyour"]["type"])
                                end
                            end, CarPlate)
                        end
                    end
                end       
            end
            for k, v in pairs(Config.JobGarages) do
                sleep = 0
                local dist = #(PCoord - vector3(v.npc["npc"].x,v.npc["npc"].y,v.npc["npc"].z))
          
                if dist <= 3.0 then
                    DrawText3Ds(v.npc["npc"].x,v.npc["npc"].y,v.npc["npc"].z + 0.98,Config.DrawtextGarage)
                    inRangeGarage = true
                    if IsControlJustReleased(0,38) and not opened then
   
                        if frameworkObject.Functions.GetPlayerData().job.name == v.access then
                            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
                            SetCamCoord(cam, v.camera["x"], v.camera["y"], v.camera["z"])
                            SetCamRot(cam, v.camera["rotationX"], v.camera["rotationY"], v.camera["rotationZ"])
                            SetCamActive(cam, true)
                            RenderScriptCams(1, 1, 750, 1, 1)
                            TriggerEvent("garage:client:open", v.garage ,k)
                            opened = true
                        else
                            Config.Notification(Config.Notifications["requiredjob"]["message"],Config.Notifications["requiredjob"]["type"])
                        end
                    end
                end

                local Distance = #(PCoord - v.car["garage"]) 
                if Config.Drawmarker then
                    dist2 = Distance <= Config.DrawmarkerDistance
                else
                    dist2 = Distance <= Config.DrawtextDistance 
                end
                if dist2 then
                    if IsPedInAnyVehicle(PlayerPedId(),false) then 
                        sleep = 5
                        if Config.Drawmarker then 
                            DrawMarker(Config.drawmarkerid, v.car["garage"].x,v.car["garage"].y,v.car["garage"].z - 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 6.0, 6.0, 0.20, Config.red , Config.green , Config.blue , Config.alpha , false, false, false, 1, false, false, false)
                        else
                             DrawText3Ds(v.car["garage"].x,v.car["garage"].y,v.car["garage"].z,Config.Drawtextput)
                        end
                        inRangeGarage= true
                        if IsControlJustReleased(0, 38) then
                            local vehicleProps = frameworkObject.Functions.GetVehicleProperties(GetPlayerCar)
                            if Config.TaskLeaveVehicle then
                                TaskLeaveVehicle(PlayerPed, GetPlayerCar, 0)
                            end
                            Citizen.Wait(2000)
                            frameworkObject.Functions.DeleteVehicle(GetPlayerCar)
                        end
                    end
                end
     
            end
            if not inRangeGarage then
                Citizen.Wait(2500)
            end
            Citizen.Wait(sleep)
        end
    end
end)

local repaired = false

RegisterNUICallback("repairvehicle", function()
    if Config.Framework == 'esx' then
        frameworkObject.TriggerServerCallback('codem-garage:checkMoneyCars', function(hasEnoughMoney)
            if hasEnoughMoney and not repaired then
                SetVehicleEngineHealth(car, 1000)
                SetVehicleFixed(car)
                SetVehicleDirtLevel(car, 0)
                SetVehiclePetrolTankHealth(car, 1000.0)
                TriggerServerEvent('codem-garage:pay', 'repair')
                repaired = true
            else
                Config.Notification(Config.Notifications["nomoneyreapir"]["message"],Config.Notifications["nomoneyreapir"]["type"])
            end
        end, 'repair')
    else
        frameworkObject.Functions.TriggerCallback('codem-garage:checkMoneyCars', function(hasEnoughMoney)
            if hasEnoughMoney and not repaired then
                SetVehicleEngineHealth(car, 1000)
                SetVehicleFixed(car)
                SetVehicleDirtLevel(car, 0)
                SetVehiclePetrolTankHealth(car, 1000.0)
                TriggerServerEvent('codem-garage:pay', 'repair')
                repaired = true
            else
                Config.Notification(Config.Notifications["nomoneyreapir"]["message"],Config.Notifications["nomoneyreapir"]["type"])
            end
        end, 'repair')
    end
end)

RegisterNUICallback("transfervehicle", function(data)
    opened = false
    local id = tonumber(data.id)
    local plate = data.plate 
    TriggerServerEvent("garage:transfervehicle", id, plate)
end)

RegisterNUICallback("sellvehicle", function(data)
    opened = false
    local plate = data.plate 
    local price = data.price
    TriggerServerEvent("garage:sell", plate, price)
end)


RegisterNUICallback("addfavorite", function(data)
    TriggerServerEvent('garage:favorite',data.plate,data.bool)
end)

-- Vehicle Spawn
local currentlivery = nil

RegisterNUICallback("mods", function(data)
    local PlayerPed = PlayerPedId()
    local GetPlayerCar =  GetVehiclePedIsIn(PlayerPed)
    if data.mod == 'extras' then
        if IsVehicleExtraTurnedOn(GetPlayerCar, tonumber(data.count)) then
            SetVehicleExtra(GetPlayerCar, tonumber(data.count) , 1)
        else
            SetVehicleExtra(GetPlayerCar, tonumber(data.count) , 0)
        end
    elseif data.mod == 'livery' then
        SetVehicleLivery(GetPlayerCar, data.count)

        currentlivery = data.count
    end
end)

local veh_extras = {['vehicleExtras'] = {}}
local livery = 0
RegisterNUICallback("apply", function(data)
    local PlayerPed = PlayerPedId()
    local GetPlayerCar = GetVehiclePedIsIn(PlayerPed)
    if IsVehicleExtraTurnedOn(GetPlayerCar, tonumber(data.count)) then
        SetVehicleExtra(GetPlayerCar, tonumber(data.count) , 1)
    else
        SetVehicleExtra(GetPlayerCar, tonumber(data.count) , 0)
    end
	for extraID = 0, 20 do
        veh_extras.vehicleExtras[extraID] = (IsVehicleExtraTurnedOn(GetPlayerCar, extraID) == 1)
    end
    livery = GetVehicleLivery(GetPlayerCar)
end)

RegisterNUICallback("spawnvehicle", function(data)
    if Config.Framework == "esx" then
        if jobgarage then
            frameworkObject.Game.SpawnVehicle(data.carname, Config.JobGarages[data.garage]["car"].spawncar, Config.JobGarages[data.garage]["car"].spawncar.w, function(yourVehicle2)
                SetVehicleNumberPlateText(yourVehicle2, data.plate)
                car2 = yourVehicle2
                VehicleKeys(data.plate:upper())
                Config.SetVehicleFuel(yourVehicle2,100)
                SetVehicleLivery(yourVehicle2, livery)
                TaskWarpPedIntoVehicle(PlayerPedId(), yourVehicle2, -1)
                SetVehicleEngineHealth(yourVehicle2, 1000)
                SetVehicleFixed(yourVehicle2)
                SetVehicleDirtLevel(yourVehicle2, 0)
                SetVehiclePetrolTankHealth(yourVehicle2, 1000.0)
                SetEntityAsMissionEntity(yourVehicle2, true, true)
                for extraID = 0, 20 do
                    if veh_extras.vehicleExtras[extraID] == true then
                        check = 0
                    else
                        check = 1
                    end
                    SetVehicleExtra(yourVehicle2, extraID, check)
                end
            end)
            jobgarage = false
        else
            frameworkObject.TriggerServerCallback('garage:props', function(cars2)
                local props = json.decode(cars2[1].vehicle)
                frameworkObject.Game.SpawnVehicle(props.model, Config.Garages[data.garage]["car"].spawncar, Config.Garages[data.garage]["car"].spawncar.w, function(yourVehicle2)
                    SetVehicleNumberPlateText(yourVehicle2, props.plate)
                    car2 = yourVehicle2
                    Config.SetVehicleFuel(yourVehicle2,props.fuelLevel)
                    frameworkObject.Game.SetVehicleProperties(yourVehicle2,props)
                    TaskWarpPedIntoVehicle(PlayerPedId(), yourVehicle2, -1)
                    VehicleKeys(props.plate,data.plate)
                    SetEntityAsMissionEntity(yourVehicle2, true, true)
                    if repaired then
                        SetVehicleEngineHealth(yourVehicle2, 1000)
                        SetVehicleFixed(yourVehicle2)
                        SetVehicleDirtLevel(yourVehicle2, 0)
                        SetVehiclePetrolTankHealth(yourVehicle2, 1000.0)
                        repaired = false
                    end
                end)
                TriggerServerEvent('garage:stored', data.plate , 0)
                opened = false
            end, data.plate)
        end
    else
        if jobgarage then
            frameworkObject.Functions.SpawnVehicle(data.carname, function(yourVehicle2)
                SetVehicleNumberPlateText(yourVehicle2, data.plate)
                car2 = yourVehicle2
                SetPedIntoVehicle(PlayerPedId(), yourVehicle2, -1)
                Config.SetVehicleFuel(yourVehicle2,100)
                SetVehicleLivery(yourVehicle2, livery)
                VehicleKeys(frameworkObject.Functions.GetPlate(yourVehicle2))
                SetVehicleEngineHealth(yourVehicle2, 1000)
                SetVehicleFixed(yourVehicle2)
                SetVehicleDirtLevel(yourVehicle2, 0)
                SetVehiclePetrolTankHealth(yourVehicle2, 1000.0)
                SetEntityAsMissionEntity(yourVehicle2, true, true)
                for extraID = 0, 20 do
                    if veh_extras.vehicleExtras[extraID] == true then
                        check = 0
                    else
                        check = 1
                    end
                    SetVehicleExtra(yourVehicle2, extraID, check)
                    repaired = false
                end
            end, vector4(Config.JobGarages[data.garage]["car"].spawncar),true)
            jobgarage = false
        else
            frameworkObject.Functions.TriggerCallback('garage:props', function(cars2)
                local props = json.decode(cars2[1].mods)
                frameworkObject.Functions.SpawnVehicle(props.model, function(yourVehicle2)
                    SetVehicleNumberPlateText(yourVehicle2, props.plate)
                    car2 = yourVehicle2
                    frameworkObject.Functions.SetVehicleProperties(yourVehicle2,props)
                    Config.SetVehicleFuel(yourVehicle2,tonumber(data.fuel))
                    VehicleKeys(frameworkObject.Functions.GetPlate(yourVehicle2))
                    TaskWarpPedIntoVehicle(PlayerPedId(),yourVehicle2,-1)
                    SetEntityAsMissionEntity(yourVehicle2, true, true)
                    if repaired then
                        SetVehicleEngineHealth(yourVehicle2, 1000)
                        SetVehicleFixed(yourVehicle2)
                        SetVehicleDirtLevel(yourVehicle2, 0)
                        SetVehiclePetrolTankHealth(yourVehicle2, 1000.0)
                        repaired = false
                    end
                end, vector4(Config.Garages[data.garage]["car"].spawncar),true)
                TriggerServerEvent('garage:stored', data.plate , 0)
                opened = false
            end, data.plate)
        end
    end
end)

RegisterNUICallback("spawnvehiclevale", function(data)
    if Config.Framework == "esx" then
        frameworkObject.TriggerServerCallback('codem-garage:checkMoneyCars', function(hasEnoughMoney)
            if hasEnoughMoney then
                frameworkObject.TriggerServerCallback('garage:props', function(cars2)
                    local props = json.decode(cars2[1].vehicle)
                    frameworkObject.Game.SpawnVehicle(props.model, Config.Garages[data.garage]["car"].spawncar, Config.Garages[data.garage]["car"].spawncar.w, function(yourVehicle2)
                        car2 = yourVehicle2
                        SetVehicleNumberPlateText(yourVehicle2, props.plate)
                        Config.SetVehicleFuel(yourVehicle2,tonumber(data.fuel))
                        SetEntityAsMissionEntity(yourVehicle2, true, true)
                        VehicleKeys(props.plate,data.plate)
                        frameworkObject.Game.SetVehicleProperties(yourVehicle2,props)
                        TaskWarpPedIntoVehicle(PlayerPedId(),yourVehicle2,-1)
                        if repaired then
                            SetVehicleEngineHealth(yourVehicle2, 1000)
                            SetVehicleFixed(yourVehicle2)
                            SetVehicleDirtLevel(yourVehicle2, 0)
                            SetVehiclePetrolTankHealth(yourVehicle2, 1000.0)
                            repaired = false
                        end
                    end)
        
                    TriggerServerEvent('garage:stored', data.plate , 0)
                    TriggerServerEvent('codem-garage:pay', 'vale')
                    opened = false
                end, data.plate)
            else
                Config.Notification(Config.Notifications["nomoneyvale"]["message"],Config.Notifications["nomoneyvale"]["type"])
            end
        end ,'vale')
        
    else
        frameworkObject.Functions.TriggerCallback('codem-garage:checkMoneyCars', function(hasEnoughMoney)
            if hasEnoughMoney then
                frameworkObject.Functions.TriggerCallback('garage:props', function(cars2)
                    local props = json.decode(cars2[1].mods)
                    frameworkObject.Functions.SpawnVehicle(props.model, function(yourVehicle2)
                        car2 = yourVehicle2
                        SetVehicleNumberPlateText(yourVehicle2, props.plate)
                        frameworkObject.Functions.SetVehicleProperties(yourVehicle2, props)
                        Config.SetVehicleFuel(yourVehicle2,tonumber(data.fuel))
                        VehicleKeys(frameworkObject.Functions.GetPlate(yourVehicle2))
                        SetEntityAsMissionEntity(yourVehicle2, true, true)
                        TriggerServerEvent('codem-garage:pay', 'vale')
                        TaskWarpPedIntoVehicle(PlayerPedId(),yourVehicle2,-1)
                        if repaired then
                            SetVehicleEngineHealth(yourVehicle2, 1000)
                            SetVehicleFixed(yourVehicle2)
                            SetVehicleDirtLevel(yourVehicle2, 0)
                            SetVehiclePetrolTankHealth(yourVehicle2, 1000.0)
                            repaired = false
                        end
                    end, vector4(Config.Garages[data.garage]["car"].spawncar), true)
                    TriggerServerEvent('garage:stored', data.plate , 0)
                    opened = false
                end, data.plate)
            else
                Config.Notification(Config.Notifications["nomoneyvale"]["message"],Config.Notifications["nomoneyvale"]["type"])
            end
        end,'vale')
    end
end)

RegisterNUICallback("spawnlocalvehicle", function(data,cb)
    if Config.Framework == "esx" then
        if jobgarage then
            frameworkObject.Game.SpawnVehicle(data.carname, Config.JobGarages[data.garage]["car"].showcar, Config.JobGarages[data.garage]["car"].showcar.w, function(yourVehicle)
                SetVehicleNumberPlateText(yourVehicle, data.plate)
                TaskWarpPedIntoVehicle(PlayerPedId(),yourVehicle,-1)
                car = yourVehicle
                if Config.ShowVehicleDelay then
                    Citizen.Wait(Config.ShowVehicleSecond)
                    cb(true)
                end
                VehicleKeys(data.plate:upper())
                FreezeEntityPosition(yourVehicle, true)
                SetEntityCollision(yourVehicle,false)
                SetEntityVisible(yourVehicle,false)
                while true do
                    Wait(0)
                    SetEntityLocallyVisible(yourVehicle)
                end
     
            end)
            repaired = false
            if DoesEntityExist(car) then
                DeleteEntity(car)
            end
        else
            frameworkObject.TriggerServerCallback('garage:props', function(cars)
                local props = json.decode(cars[1].vehicle)
                frameworkObject.Game.SpawnVehicle(props.model, Config.Garages[data.garage]["car"].showcar, Config.Garages[data.garage]["car"].showcar.w, function(yourVehicle)
                    frameworkObject.Game.SetVehicleProperties(yourVehicle, props)
                    SetVehicleNumberPlateText(yourVehicle, props.plate)
                    car = yourVehicle
                    VehicleKeys(data.plate,props.plate)
                    if Config.ShowVehicleDelay then
                        Citizen.Wait(Config.ShowVehicleSecond)
                        cb(true)
                    end
          
                    FreezeEntityPosition(yourVehicle, true)
                    SetEntityCollision(yourVehicle,false)
                    SetEntityVisible(yourVehicle,false)
                    while true do
                        Wait(0)
                        SetEntityLocallyVisible(yourVehicle)
                    end
                end)
            end, data.plate)
            repaired = false
            if DoesEntityExist(car) then
                DeleteEntity(car)
            end   
        end
    else
        if jobgarage then  
            frameworkObject.Functions.TriggerCallback('garage:props', function(cars)
                

                frameworkObject.Functions.SpawnVehicle(data.carname, function(yourVehicle)
                    SetVehicleNumberPlateText(yourVehicle, data.plate)
                    car = yourVehicle
                    TaskWarpPedIntoVehicle(PlayerPedId(),yourVehicle,-1)
                    VehicleKeys(frameworkObject.Functions.GetPlate(yourVehicle))
                    if Config.ShowVehicleDelay then
                        Citizen.Wait(Config.ShowVehicleSecond)
                        cb(true)
                    end
            
                    FreezeEntityPosition(yourVehicle, true)
                    SetEntityCollision(yourVehicle,false)
                    SetEntityVisible(yourVehicle,false)
                    while true do
                        Wait(0)
                        SetEntityLocallyVisible(yourVehicle)
                    end
                end,vector4(Config.JobGarages[data.garage]["car"].showcar), true)
            end,data.plate)
            repaired = false
            if DoesEntityExist(car) then
                DeleteEntity(car)
            end
        else
            frameworkObject.Functions.TriggerCallback('garage:props', function(cars)
                local props = json.decode(cars[1].mods)
                frameworkObject.Functions.SpawnVehicle(props.model, function(yourVehicle)
                    frameworkObject.Functions.SetVehicleProperties(yourVehicle, props)
                    SetVehicleNumberPlateText(yourVehicle, props.plate)
                    car = yourVehicle
                    VehicleKeys(frameworkObject.Functions.GetPlate(yourVehicle))
                    if Config.ShowVehicleDelay then
                        Citizen.Wait(Config.ShowVehicleSecond)
                        cb(true)
                    end
             
                    FreezeEntityPosition(yourVehicle, true)
                    SetEntityCollision(yourVehicle,false)
                    SetEntityVisible(yourVehicle,false)
                    while true do
                        Wait(0)
                        SetEntityLocallyVisible(yourVehicle)
                    end
                end, vector4(Config.Garages[data.garage]["car"].showcar), true)

            end, data.plate)  
            repaired = false
            if DoesEntityExist(car) then
                DeleteEntity(car)
            end
        end
    end
end)

-- Avatar and Name

RegisterNetEvent("garage:client:getNameAvatar")
AddEventHandler("garage:client:getNameAvatar", function(name,avatar)
    fullname = name
    photo   = avatar
end)

-- Rotate

RegisterNUICallback("rotateright", function()
    SetEntityHeading(car, GetEntityHeading(car) - 3.0)
end)

RegisterNUICallback("rotateleft", function()
    SetEntityHeading(car, GetEntityHeading(car) + 3.0)
end)

-- Blip and Ped

Citizen.CreateThread(function()
    for _,v in pairs(Config.Garages) do    
        RequestModel(v.npc["npcModel"])
        while not HasModelLoaded(v.npc["npcModel"]) do
          Wait(1)
        end
        ped =  CreatePed(4,v.npc["npcModel"], v.npc["npc"].x,v.npc["npc"].y,v.npc["npc"].z -1, 3374176, false, true)
        SetEntityHeading(ped,v.npc["npc"].w)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        if Config.Blip then
            if v.blip["show"] then
                local blip = AddBlipForCoord(v.npc["npc"])
                SetBlipSprite(blip, v.blip["blipType"])
                SetBlipScale(blip, 0.6)
                SetBlipColour(blip, v.blip["blipColour"])
                SetBlipDisplay(blip, 4)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                if Config.GarageName == true then
                    AddTextComponentString(v["garagename"])
                else
                    AddTextComponentString(v.blip["blipName"])
                end
                EndTextCommandSetBlipName(blip)
            end
        end
    end
    for _,v in pairs(Config.JobGarages) do    
        RequestModel(v.npc["npcModel"])
        while not HasModelLoaded(v.npc["npcModel"]) do
          Wait(1)
        end
        ped =  CreatePed(4,v.npc["npcModel"], v.npc["npc"].x,v.npc["npc"].y,v.npc["npc"].z -1, 3374176, false, true)
        SetEntityHeading(ped,v.npc["npc"].w)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        if Config.Blip then
            local blip = AddBlipForCoord(v.npc["npc"])
            SetBlipSprite(blip, v.blip["blipType"])
            SetBlipScale(blip, 0.6)
            SetBlipColour(blip, v.blip["blipColour"])
            SetBlipDisplay(blip, 4)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blip["blipName"])
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Close

RegisterNUICallback("close", function(data)
    if jobgarage then
       local ped = PlayerPedId()
       Wait(50)
       SetEntityCoords(ped, Config.JobGarages[data.garage].npc["npc"], false, false, false, true)
    end
    opened = false
    jobgarage = false
    SetNuiFocus(false, false)
    DestroyCam(cam)
	RenderScriptCams(0, 1, 750, 1, 0)
    if DoesEntityExist(car) then
        DeleteEntity(car)
    end
end)

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

    if Config.PlateUseSpace then
        generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. ' ' .. GetRandomNumber(Config.PlateNumbers))
    else
        generatedPlate = string.upper(GetRandomLetter(Config.PlateLetters) .. GetRandomNumber(Config.PlateNumbers))
    end

	return generatedPlate
end

function GetRandomNumber(length)
	Wait(0)
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Wait(0)
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end