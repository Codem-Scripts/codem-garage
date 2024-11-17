Config = Config or {}

-- General Settings
Config.Framework = "newqb" -- newqb, oldqb, esx
Config.BotToken = "" -- https://www.youtube.com/watch?v=-m-Z7Wav-fM&ab_channel=GAKventure
Config.SQL = "oxmysql" -- mysql-async -- oxmysql -- ghmattimysql -- pls fxmanifest and open requirement

Config.playerLoaded = "esx:playerLoaded" -- Modify your ESX-based framework here.
Config.setJob = "esx:setJob" -- Modify your ESX-based framework here.
Config.QBCoreplayerLoaded = 'QBCore:Client:OnPlayerLoaded' -- Modify your QBCore-based framework here.
Config.QBCoreOnJobUpdate = 'QBCore:Client:OnJobUpdate' -- Modify your QBCore-based framework here.

-- Marker / 3D Text Settings
Config.Drawmarker = true -- True for Marker / False for 3D Text (effects only Vehicle Storing Locations)

Config.Drawtextput = '[E] Put the vehicle in the garage'
Config.DrawtextGarage = '[E] Garage'
Config.DrawtextDistance = 3.0

Config.drawmarkerid = 1
Config.DrawmarkerDistance = 5.0
Config.red = 255
Config.green = 10
Config.blue = 20
Config.alpha = 155

-- Garage Settings
Config.Notify = false
Config.GarageName = false -- if false all garages are shared (you can get every car from every garage) / if true you can only get cars from the garage where it was stored before
Config.Sell = true -- true or false
Config.Blip = true -- true or false
Config.Transfer = true -- true or false 
Config.Repair = true -- true or false 
Config.FilterCiv = true
Config.Vehiclekey =  true -- if you are using vehiclekey please true
Config.UseLegacyFuel = false -- if you are using legacy fuel please true
Config.MileageFormat = "KM" -- "KM" "MI"
Config.GetVehicleEstimatedMaxSpeed = function(vehicle)
    if Config.MileageFormat == "MI" then
        return math.ceil(GetVehicleModelEstimatedMaxSpeed(vehicle) * 2.24) or 200
    end
    return math.ceil(GetVehicleModelEstimatedMaxSpeed(vehicle) * 3.605936) or 200
end

-- Price Settings
Config.Defaultprice = 500
Config.ValePrice = 5000
Config.RepairPrice = 3000
Config.RepairMoneyType = 'bank' 
Config.ValeMoneyType = 'bank'

-- Misc Settings
Config.TaskLeaveVehicle = true -- true or false
Config.PlateLetters  = 4
Config.PlateNumbers  = 4
Config.PlateUseSpace = true
Config.ShowVehicleDelay = true -- Something done to prevent vehicle spam, something that is not recommended to be false
Config.ShowVehicleSecond = 650
Config.Out = true -- if the vehicle is in the world it won't let me take it out

-- Garage Location Settings
Config.Garages = {
    ["Garage A"] = {
        ["garage"] = "normal",
        ["garagename"] = "Garage A",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Garage A",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      = vector4(213.15, -809.9, 31.01, 339.02)
        },
        ["car"] = {
            ["showcar"] = vector4(236.39, -779.89, 30.67,161.68),
            ["garage"] = vector3(214.984619, -790.628540, 30.830078),
            ["spawncar"] = vector4(216.67,-787.25,30.70,161.68)
        },
        ["camera"] = { 
            ["x"] = 234.57,
            ["y"] = -785.1,
            ["z"] = 30.59,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -20.0
        },
    },

    ["Garage B"] = {
        ["garage"] = "normal",
        ["garagename"] = "Garage B",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(275.95, -344.06, 45.17, 165.24)
        },
        ["car"] = {
            ["showcar"] = vector4(274.63, -330.28, 44.70, 164.27),
            ["garage"] = vector3(271.68, -341.61, 44.92),
            ["spawncar"] = vector4(292.79, -332.22, 44.92, 161.25)
        },
        ["camera"] = { 
            ["x"] = 273.08,
            ["y"] = -335.04,
            ["z"] = 44.92,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -20.0
        },
    },

    ["Garage C"] = {
        ["garage"] = "normal",
        ["garagename"] = "Garage C",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(-1183.58, -1509.04, 4.65, 116.05)
        },
        ["car"] = {
            ["showcar"] = vector4(-1190.81, -1494.48, 4.38, 212.36),
            ["garage"] = vector3(-1183.17, -1502.86, 4.38),
            ["spawncar"] = vector4(-1183.17, -1502.86, 4.38, 212.08)
        },

        ["camera"] = { 
            ["x"] = -1188.67,
            ["y"] = -1497.89,
            ["z"] = 4.38,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 29.0
        },
    },

    ["Garage D"] = {
        ["garage"] = "normal",
        ["garagename"] = "Garage D",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(68.35, 13.85, 69.21, 167.77)
        },
        ["car"] = {
            ["showcar"]  = vector4(59.35, 24.31, 69.73, 245.08),
            ["garage"]   = vector3(73.24, 11.78, 68.85),
            ["spawncar"] = vector4(73.24, 11.78, 68.85, 155.92)
        },

        ["camera"] = { 
            ["x"] = 64.78,
            ["y"] = 22.19,
            ["z"] = 69.54,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 70.0
        },
    },

    ["Garage E"] = {
        ["garage"] = "normal",
        ["garagename"] = "Garage E",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(362.6, 299.35, 103.88, 165.63)
        },
        ["car"] = {
            ["showcar"]  = vector4(376.33, 288.82, 103.2, 69.26),
            ["garage"]   = vector3(367.98, 296.57, 103.42),
            ["spawncar"] = vector4(367.98, 296.57, 103.42, 345.36)
        },
        ["camera"] = { 
            ["x"] = 371.18,
            ["y"] = 290.66,
            ["z"] = 103.31,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -110.0
        },
    },

    ["Garage F"] = {
        ["garage"] = "normal",
        ["garagename"] = "Garage F",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(-1158.51, -740.67, 19.89, 41.16)
        },
        ["car"] = {
            ["showcar"]  = vector4(-1145.2, -759.03, 18.82, 39.92),
            ["garage"]   = vector3(-1169.03, -743.49, 19.63),
            ["spawncar"] = vector4(-1169.03, -743.49, 19.63, 42.38)
        },
        ["camera"] = { 
            ["x"] = -1148.57,
            ["y"] = -754.86,
            ["z"] = 18.97,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -140.0
        },
    },

    ["Garage G"] = {
        ["garage"] = "normal",
        ["garagename"] = "Garage G",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(-795.33, -2023.8, 9.17, 66.37)
        },
        ["car"] = {
            ["showcar"]  = vector4(-763.11, -2042.28, 8.91, 37.29),
            ["garage"]   = vector3(-791.39, -2030.26, 8.87),
            ["spawncar"] = vector4(-790.11, -2022.68, 8.87, 58.85)
        },
        ["camera"] = { 
            ["x"] = -766.54,
            ["y"] = -2037.82,
            ["z"] = 8.9,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -143.0
        },
    },

    ["Garage H"] = {
        ["garage"] = "normal",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(-468.87, -819.67, 30.52, 358.04)
        },
        ["car"] = {
            ["showcar"]  = vector4(-472.02, -800.43, 30.54, 183.47),
            ["garage"]   = vector3(-453.49, -814.23, 30.58),
            ["spawncar"] = vector4(-472.16, -812.83, 30.53, 179.63)
        },
        ["camera"] = { 
            ["x"] = -472.16,
            ["y"] = -806.15,
            ["z"] = 30.54,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -3.0
        },
    },

    ["Garage I"] = {
        ["garage"] = "normal",
        ["garagename"] = "Garage I",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(1142.38, 2661.28, 38.16, 92.19)
        },
        ["car"] = {
            ["showcar"]  = vector4(1121.15, 2665.03, 38.02, 266.97),
            ["garage"]   = vector3(1137.59, 2653.02, 38.0),
            ["spawncar"] = vector4(1137.57, 2674.86, 38.25, 1.08)
        },
        ["camera"] = { 
            ["x"] = 1127.68,
            ["y"] = 2664.84,
            ["z"] = 38.02,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 88.0
        },
    },

    ["Garage J"] = {
        ["garage"] = "normal",
        ["garagename"] = "Garage J",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(83.51, 6420.3, 31.76, 313.17)
        },
        ["car"] = {
            ["showcar"]  = vector4(112.65, 6396.47, 31.31, 42.5),
            ["garage"]   = vector3(79.68, 6417.33, 31.28),
            ["spawncar"] = vector4(85.93, 6426.8, 31.34, 38.93)
        },
        ["camera"] = { 
            ["x"] = 107.37,
            ["y"] = 6402.14,
            ["z"] = 31.33,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -138.0
        },
    },

    ["Garage K"] = {
        ["garage"] = "boat",
        ["garagename"] = "Garage K",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Boat Garage",
            ["blipType"] = 356,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(-717.9, -1327.46, 1.6, 50.86)
        },
        ["car"] = {
            ["showcar"] = vector4(-723.7, -1329.22, -0.11, 229.03),
            ["garage"] = vector3(-718.03, -1334.21, 1.0),
            ["spawncar"] = vector4(-718.05, -1334.24, -0.44, 222.71)
        },
        ["camera"] = { 
            ["x"] = -719.57,
            ["y"] = -1332.72,
            ["z"] = 1.41,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 50.0
        },
    },

    ["Garage L"] = {
        ["garage"] = "aircraft",
        ["garagename"] = "Garage L",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Aircraft Garage",
            ["blipType"] = 359,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "a_m_m_prolhost_01",
            ["npc"]      =  vector4(-1251.69, -3399.94, 13.94, 59.19)
        },
        ["car"] = {
            ["showcar"] = vector4(-1273.01, -3402.28, 13.94, 331.01),
            ["garage"] = vector3(-1246.91, -3355.14, 13.95),
            ["spawncar"] = vector4(-1246.91, -3355.14, 13.95, 330.68)
        },
        ["camera"] = { 
            ["x"] = -1268.42,
            ["y"] = -3394.32,
            ["z"] = 13.94,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -210.0
        },
    }
}

Config.JobGarages = {

    ["police"] = { -- job name and logo name
        ["garage"] = "jobgarage",
        ["access"] = "police",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Police Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "ig_solomon",
            ["npc"]      = vector4(450.97, -1028.03, 28.57, 1.57)
        },
        ["car"] = {
            ["showcar"] = vector4(442.60, -1018.14, 28.67, 90.87),
            ["garage"] = vector3(447.5771, -1021.1351, 28.4547),
            ["spawncar"] = vector4(436.25, -1021.39, 28.71,94.97)
        },
        ["cars"] = {
            [1] = {
                grade = 0,
                model = "police",
            },
            [2] = {
                grade = 0,
                model = "police3",
            },
            [3] = {
                grade = 0,
                model = "police4",
            },
            [4] = {
                grade = 0,
                model = "police2",
            },
            [5] = {
                grade = 0,
                model = "polmav",
            },
        },
        ["camera"] = { 
            ["x"] = 436.81,
            ["y"] = -1018.28,
            ["z"] = 28.77,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -90.0
        },
    },

    ["police2"] = { -- job name and logo name
        ["garage"] = "jobgarage",
        ["access"] = "police",
        ["blip"] = {
            ["show"] = true,
            ["blipName"] = "Police Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "ig_solomon",
            ["npc"]      = vector4(467.2, -1024.08, 28.25, 272.04)
        },
        ["car"] = {

            ["showcar"] = vector4(477.95, -1022.49, 28.03, 268.56),
            ["garage"] = vector3(484.7, -1021.09, 27.89),
            ["spawncar"] = vector4(478.17, -1022.8, 28.03, 283.28),
        },
        ["cars"] = {
            [1] = {
                grade = 0,
                model = "police",
            },
        },
        ["camera"] = { 
            ["x"] = 484.13,
            ["y"] = -1022.32,
            ["z"] = 27.92,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = 90.0
        },
    },

    ["ambulance"] = { -- job name and logo name
        ["garage"] = "jobgarage",
        ["show"] = true,
        ["access"] = "ambulance",
        ["blip"] = {
            ["blipName"] = "Ambulance Garage",
            ["blipType"] = 357,
            ["blipColour"] =  3
        },
        ["npc"] = {
            ["npcModel"] = "ig_solomon",
            ["npc"]      = vector4(294.77, -599.60, 43.29,158.74)
        },
        ["car"] = {
            ["showcar"] = vector4(289.08, -610.98, 43.36, 70.19),
            ["garage"] = vector3(275.72, -604.91, 42.97),
            ["spawncar"] = vector4(282.78, -606.48, 43.13, 79.31)
        },
        ["cars"] = {
            [1] = {
                grade = 0,
                model = 'ambulance'
            }
        },
        ["camera"] = { 
            ["x"] = 282.93,
            ["y"] = -608.79,
            ["z"] = 43.26,
            ["rotationX"] = 0.0,
            ["rotationY"] = 0.0, 
            ["rotationZ"] = -110.0
        },
    },
}

Config.Notifications = {
    ['sell'] = {
        message = 'Vehicle successfully sold.',
        type = "success"
    },
    ['transfer'] = {
        message = 'Vehicle transferred successfully.',
        type = "success"
    },
    ['transfererror'] = {
        message = 'Vehicle transfer failed.',
        type = "error"
    },
    ['requiredjob'] = {
        message = "You don't have the required job.",
        type = "error"
    },
    ['vehiclenotyour'] = {
        message = 'The vehicle is not yours.',
        type = "error"
    },
    ['notgarageinvehicle'] = {
        message = "You don't have a car in this garage.",
        type = "error"
    },
    ['nomoneyvale'] = {
        message = "You don't have money",
        type = "error"
    },
    ['nomoneyreapir'] = {
        message = "You don't have money",
        type = "error"
    },
    ['carnotfound'] = {
        message = "An error occurred while loading the vehicle",
        type = "error"
    },
    ['parkingsuccesful'] = {
        message = "Parked it successfully",
        type = "success"
    },
}

Config.Notification = function(message, type, isServer, src) -- You can change here events for notifications
    if Config.Notify then
        if isServer then
            if Config.Framework == "esx" then
                TriggerClientEvent("esx:showNotification", src, message)
            else
                TriggerClientEvent('QBCore:Notify', src, message, type, 1500)
            end
        else
            if Config.Framework == "esx" then
                TriggerEvent("esx:showNotification", message)
            else
                TriggerEvent('QBCore:Notify', message, type, 1500)
            end
        end
    end
end 

-- Function

function VehicleKeys(plate) 
    -- vehiclkey export
    if Config.Vehiclekey then
        TriggerEvent("vehiclekeys:client:SetOwner", plate)
    end
end

DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Config.GetVehicleFuel = function(vehicle) -- you can change LegacyFuel export if you use another fuel system 
    if Config.UseLegacyFuel then
        return exports["LegacyFuel"]:GetFuel(vehicle)
    else
        return GetVehicleFuelLevel(vehicle)
    end
end

Config.SetVehicleFuel = function(vehicle,fuel_level) -- you can change LegacyFuel export if you use another fuel system 
    if Config.UseLegacyFuel then
        return exports["LegacyFuel"]:SetFuel(vehicle, fuel_level)
    else
        if fuel_level == nil then
            fuel_level = 90
        end
        return SetVehicleFuelLevel(vehicle, fuel_level + 0.0)
    end
end

Config.Weight = {
    [0] = 1000,-- Compacts  
    [1] = 1500,-- Sedans  
    [2] = 2000,-- SUVs  
    [3] = 2500,-- Coupes 
    [4] = 3000,-- Muscle 
    [5] = 4000,-- Sports Classics 
    [6] = 5000,-- Sports 
    [7] = 6000,-- Super
    [8] = 7000,-- Motorcycles  
    [9] = 8000,--  Off-road 
    [10] = 9000,-- Industrial
    [11] = 10000,-- Utility
    [12] = 11000,-- Vans  
    [13] = 12000,-- Cycles
    [14] = 13000,-- Boats  
    [15] = 14000,-- Helicopters
    [16] = 15000,-- Planes 
    [17] = 16000,-- Service
    [18] = 17000,-- Emergency 
    [19] = 18000, -- Military  
    [20] = 19000 -- Commercial  
}

Config.Text = {
    [0] = 'Compacts in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. Those cars are such as Brioso 300 Widebody, Club, Blista Kanjo, Brioso 300, Blista, Brioso R/A, Dilettante, Asbo etc.',  -- Compacts 
    [1] = 'Sedans in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For Sedans in the Grand Theft Auto series, see Sedans. Those cars are such as Emperor, Rhinehart, Tailgater S, Cinquemila, Asea, Super Diamond etc. ',  -- Sedans
    [2] = 'SUVs in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For a list of all SUVs and SUTs in the Grand Theft Auto series, see SUVs. Those cars are such as XLS, Granger 3600LX, Astron, Patriot, I-Wagen, Rebla GTS, Cavalcade, Dubsta etc. ',  -- SUVs 
    [3] = 'Coupes in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other Coupes in the Grand Theft Auto series, see Coupes. Those cars are such as Kanjo SJ, Sentinel, Previon, Postlude, Sentinel XS, F620, Oracle, Felon GT etc. ',  -- Coupes 
    [4] = 'Muscle Cars in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other muscle cars in the Grand Theft Auto series, see Muscle Cars. Those cars are such as Vigero ZX, Ruiner ZZ-8, Greenwood, Phoenix, Dominator GTT, Duke O Death, Chino, Hustler etc. ',  -- Muscle 
    [5] = 'Sports Classics Vehicles in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other classic cars in the Grand Theft Auto series, see Classic Cars. Those cars are such as Mamba, Toreador, Stirling GT, Turismo Classic, Ardent, Zion Classic, 190z, JB 700 etc.',  -- Sports Classics 
    [6] = 'Sports Cars in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other sports cars in the Grand Theft Auto series, see Sports Cars. Those cars are such as Hotring Sabre, Locust, 10F Widebody, Paragon R, Corsita, ZR-350, Imorgon, Elegy Retro Custom etc.',  -- Sports 
    [7] = 'Supercars and hypercars in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other supercars in the Grand Theft Auto series, see Super Cars. Those cars are such as LM87, Torero XO, Cyclone II, Sultan RS, Champion, Vacca, Turismo R, Vigilante etc.',  -- Super
    [8] = 'Motorcycles in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other motorcycles in the Grand Theft Auto series, see Motorcycles. Those vehicles are such as Oppressor Mk II, Hakuchou Custom, Oppressor, Bati 800, PCJ 600, Faggio etc.',  -- Motorcycles
    [9] = 'Off-Road Vehicles in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For Off-Road vehicles in the Grand Theft Auto series, see Off-Road Vehicles. Those cars are such as Dune FAV, Nightshark, Mesa Grande, Draugur, Patriot Mil-Spec, Everon etc.',  --  Off-road 
    [10] = 'Industrial Vehicles in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other Industrial Vehicles, see Industrial Vehicles. Those cars are such as Guardian, Dozer, Flatbed, Dump, Dock Handler, Mixer etc.', -- Industrial
    [11] = 'Utility Vehicles in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For utility vehicles in the entire Grand Theft Auto series, see Utility Vehicles. Those vehicles are such as Mobile Operations Center, Sadler, Towtruck, Caddy, Slamtruck, Trailer, Tractor etc.', -- Utility 
    [12] = 'Vans in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For all vans in the Grand Theft Auto series, see Vans. Those cars are such as Bison, Speedo Custom, Rumpo Custom, Journey, Surfer, Burrito, Youga Custom etc.', -- Vans
    [13] = 'Cycles (bicycles) in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other bicycles in the Grand Theft Auto series, see Bicycles. Those bicycles are such as BMX, Fixter, Scorcher, Tri-Cycles Race Bike etc.', -- Cycles 
    [14] = 'Boats in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. Those boats are such as Kosatka, Submersible, Kraken, Avisa, Marquis, Dinghy, Predator etc.', -- Boats 
    [15] = 'Helicopters in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For helicopters in the Grand Theft Auto series, see Helicopters. Those helicopters are such as Sparrow, Akula, Cargobob, Hunter, Police Maverick etc. ', -- Helicopters 
    [16] = 'Planes in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other planes/aircraft in the series, see Fixed-Wing Aircraft. Those aircrafts are such as P-996 LAZER, RO-86 Alkonost, Hydra, Volatol etc.', -- Planes  
    [17] = 'Public Service Vehicles in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. Those vehicles are such as Bus, Festival Bus, Taxi, Dune, Dashound, Trashmaster etc.', -- Service
    [18] = 'Emergency Vehicles in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other emergency vehicles in the Grand Theft Auto series, see Emergency Vehicles. Those vehicles are such as FIB Buffalo, Police Buffalo, Police Cruiser, Fire Truck, Ambulance, Police Roadcruiser, Police Riot etc. ', -- Emergency 
    [19] = 'Military Vehicles in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. For other military vehicles, see Military Vehicles. Those vehicles are such as TM-02 Khanjali, APC, Anti-Aircraft Trailer, Rhino etc. ', -- Military
    [20] = 'Commercial Vehicles in Grand Theft Auto V and Grand Theft Auto Online. These are defined by the Vehicle Class System introduced in GTA V. Those vehicles are such as Terrorbyte, Securicar, Mule, Pounder Custom, Phantom Wedge, Hauler Custom, Phantom, Mule Custom etc.'  -- Commercial 
}