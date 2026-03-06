isOpen, TestDriveTime, SpawnCoords, Coords, TestDrive, lastPlayerCoords, Framework, currentVeh, originalPlayerPos = {}, true, nil, nil, nil, nil, nil, nil, nil

EYES = {} -- EYES tablosunu tanımla

print("^2[GALER DEBUG]^7 Global değişkenler tanımlandı, currentVeh = " .. tostring(currentVeh))

RegisterNUICallback("TestDrive", function(data, cb)
    SetEntityVisible(PlayerPedId(), 1)

    local hash = GetHashKey(data.car)
    lastPlayerCoords = GetEntityCoords(PlayerPedId())
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(10)
    end
    local testDriveEntity = CreateVehicle(hash, vector4(TestDrive), 1, 1)
    SetPedIntoVehicle(PlayerPedId(), testDriveEntity, -1)
    SetVehicleNumberPlateText(testDriveEntity, "TestCar")
    local Plate = Trim(GetVehicleNumberPlateText(testDriveEntity))
    SetVehicleCustomPrimaryColour(testDriveEntity, data.color.R, data.color.G, data.color.B)
    SetVehicleCustomSecondaryColour(testDriveEntity, data.color.R, data.color.G, data.color.B)
    Config.Carkeys(Plate)

    startCountDown = true
    local timeGG = GetGameTimer()

    Citizen.CreateThread(function()
        while startCountDown do
            SendNUIMessage({type = "close"})
            Citizen.Wait(1)
            
            -- ESC ile çıkış kontrolü
            if IsControlJustPressed(0, 322) then -- ESC tuşu
                DeleteEntity(testDriveEntity)
                SetEntityCoords(PlayerPedId(), lastPlayerCoords)
                startCountDown = false
                TriggerEvent('QBCore:Notify', 'Test sürüşü iptal edildi', 'error')
                break
            end
            
            if GetGameTimer() < timeGG + tonumber(1000*TestDriveTime) then
                drawTxt(' ~r~ TEST DRIVE:' .. math.ceil(TestDriveTime - (GetGameTimer() - timeGG)/1000) .. ' ~w~| ~y~ESC ile çık' ,4,0.5,0.93,0.50,255,255,255,180)
            else
                DeleteEntity(testDriveEntity)
                SetEntityCoords(PlayerPedId(), lastPlayerCoords)
                startCountDown = false
            end
        end
    end)
end)

    function Draw3DText(x, y, z, text)
        local onScreen, _x, _y = World3dToScreen2d(x, y, z)
        local px,py,pz=table.unpack(GetGameplayCamCoords())
        if onScreen then
            SetTextScale(0.35, 0.35)
            SetTextFont(4)
            SetTextProportional(1)
            SetTextColour(255, 255, 255, 215)
            SetTextDropShadow(0, 0, 0, 55)
            SetTextEdge(0, 0, 0, 150)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            SetTextCentre(1)
            AddTextComponentString(text)
            DrawText(_x,_y)
        end
    end


    RegisterNUICallback("rotateright", function()
        SetEntityHeading(currentVeh, GetEntityHeading(currentVeh) - 2)
    end)

    RegisterNUICallback("rotateleft", function()
        SetEntityHeading(currentVeh, GetEntityHeading(currentVeh) + 2)
    end)

      RegisterNUICallback("Vehicle",function(data, cb)
        print("^3[GALER DEBUG]^7 Vehicle callback çağrıldı: " .. data.vehicle)
        print("^3[GALER DEBUG]^7 currentVeh değeri: " .. tostring(currentVeh))
        
        local ped = PlayerPedId()
        
        -- Oyuncuyu araçtan çıkar ve uzağa ışınla
        if IsPedInAnyVehicle(ped, false) then
            local veh = GetVehiclePedIsIn(ped, false)
            TaskLeaveVehicle(ped, veh, 16) -- 16 = instant exit
            Wait(50)
            print("^3[GALER DEBUG]^7 Oyuncu araçtan çıkarıldı")
        end
        
        -- Oyuncuyu araç spawn noktasından uzağa taşı (mHud ve otomatik binme sorunu için)
        local safePos = vector3(Coords.x + 5.0, Coords.y + 5.0, Coords.z)
        SetEntityCoords(ped, safePos.x, safePos.y, safePos.z, false, false, false, false)
        FreezeEntityPosition(ped, true) -- Oyuncuyu dondur
        print("^3[GALER DEBUG]^7 Oyuncu güvenli konuma taşındı ve donduruldu")
        
        -- Eski aracı sil
        if currentVeh ~= nil then
            print("^3[GALER DEBUG]^7 currentVeh nil değil: " .. tostring(currentVeh))
            if DoesEntityExist(currentVeh) then
                print("^3[GALER DEBUG]^7 Eski araç mevcut, siliniyor: " .. tostring(currentVeh))
                local oldVeh = currentVeh
                SetEntityAsMissionEntity(oldVeh, false, true)
                DeleteEntity(oldVeh)
                DeleteVehicle(oldVeh)
                Wait(100)
                if DoesEntityExist(oldVeh) then
                    print("^1[GALER ERROR]^7 Eski araç hala mevcut, zorla siliniyor!")
                    SetEntityCoords(oldVeh, 0.0, 0.0, -1000.0)
                else
                    print("^2[GALER DEBUG]^7 Eski araç başarıyla silindi")
                end
            else
                print("^3[GALER DEBUG]^7 Eski araç entity mevcut değil (zaten silinmiş)")
            end
            currentVeh = nil
        else
            print("^3[GALER DEBUG]^7 currentVeh zaten nil")
        end
        
        Wait(100)
        
        local model = GetHashKey(data.vehicle)
        local vehClass = GetVehicleClassFromName(model)
        print("^3[GALER DEBUG]^7 Model hash: " .. tostring(model) .. ", Class: " .. tostring(vehClass))
        
        RequestModel(model)
        local modelLoadTimeout = 0
        while not HasModelLoaded(model) and modelLoadTimeout < 100 do
            Wait(10)
            modelLoadTimeout = modelLoadTimeout + 1
        end
        
        if not HasModelLoaded(model) then
            print("^1[GALER ERROR]^7 Model yüklenemedi: " .. data.vehicle)
            FreezeEntityPosition(ped, false) -- Oyuncuyu serbest bırak
            cb({maxSpeed = 0, Fuel = 0, Handling = 0, Acceleration = 0, Brake = 0})
            return
        end
        
        print("^3[GALER DEBUG]^7 Model yüklendi, araç oluşturuluyor...")
        print("^3[GALER DEBUG]^7 Coords: " .. tostring(Coords))
        
        -- Yeni aracı oluştur (network = false, mission entity = true)
        currentVeh = CreateVehicle(model, Coords.x, Coords.y, Coords.z, Coords.w, false, false)
        print("^3[GALER DEBUG]^7 CreateVehicle çağrıldı, entity: " .. tostring(currentVeh))
        
        -- Aracın oluşmasını bekle
        local timeout = 0
        while not DoesEntityExist(currentVeh) and timeout < 50 do
            Wait(10)
            timeout = timeout + 1
        end
        
        if DoesEntityExist(currentVeh) then
            print("^2[GALER DEBUG]^7 Araç başarıyla oluşturuldu! Entity ID: " .. tostring(currentVeh))
            
            -- Araç ayarları (SIRALAMA ÖNEMLİ!)
            SetEntityAsMissionEntity(currentVeh, true, true)
            SetEntityInvincible(currentVeh, true)
            SetVehicleDoorsLocked(currentVeh, 4) -- 4 = VEHLOCK_LOCKED_PLAYER_INSIDE (kimse giremez)
            SetVehicleDoorsLockedForAllPlayers(currentVeh, true)
            SetVehicleUndriveable(currentVeh, true)
            SetVehicleEngineOn(currentVeh, false, false, true)
            FreezeEntityPosition(currentVeh, true)
            SetEntityCollision(currentVeh, false, false)
            
            -- Renk ayarları
            SetVehicleCustomPrimaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
            SetVehicleCustomSecondaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
            
            print("^2[GALER DEBUG]^7 Araç ayarları tamamlandı (invincible, locked, undriveable, frozen)")
            
            if vehClass == 14 then 
                print("^2[GALER DEBUG]^7 Tekne tespit edildi")
            end
            
            -- Araç modeline göre sabit fuel kapasitesi (her araca özel)
            local vehicleFuelCapacity = {
                -- SEDAN
                ['asea'] = 50.0,
                ['emperor'] = 55.0,
                ['fugitive'] = 65.0,
                ['comet7'] = 60.0,
                ['granger2'] = 75.0,
                ['iwagen'] = 70.0,
                
                -- JEEP/SUV
                ['bifta'] = 45.0,
                ['brawler'] = 70.0,
                ['rancherxl'] = 80.0,
                ['rebel2'] = 75.0,
                ['mesa3'] = 65.0,
                ['patriot3'] = 85.0,
                
                -- SPORT
                ['buffalo4'] = 60.0,
                ['ignus'] = 65.0,
                ['deity'] = 70.0,
                ['cinquemila'] = 65.0,
                ['astron'] = 60.0,
                ['champion'] = 62.0,
                
                -- MOTORCYCLE
                ['bati'] = 15.0,
                ['sanchez'] = 12.0,
                ['reever'] = 18.0,
                ['shinobi'] = 20.0,
                ['avarus'] = 16.0,
                
                -- TRUNK/CLASSIC
                ['hermes'] = 60.0,
                ['hotknife'] = 55.0,
                ['moonbeam'] = 70.0,
                ['blade'] = 58.0,
                ['buccaneer'] = 62.0,
                ['injection'] = 50.0,
                
                -- LUXURY/SUPERCAR
                ['zentorno'] = 80.0,
                ['gtr'] = 75.0,
                ['m3g80'] = 70.0,
                ['sl63amg22'] = 85.0,
                
                -- BOAT
                ['seashark2'] = 100.0,
                ['seashark3'] = 100.0,
                ['submersible2'] = 200.0,
                ['dinghy4'] = 120.0,
                ['dinghy'] = 120.0,
                ['toro'] = 150.0,
                
                -- AIRCRAFT
                ['cargobob'] = 1000.0,
                ['maverick'] = 800.0,
                ['valkyrie2'] = 1200.0,
                ['swift2'] = 900.0,
                
                -- ARMOR (Police)
                ['police'] = 70.0,
                ['police2'] = 75.0,
                ['police3'] = 80.0,
            }
            
            -- Araç modeline göre fuel kapasitesi al, yoksa class'a göre varsayılan
            local fuelCapacity = vehicleFuelCapacity[data.vehicle:lower()]
            
            if not fuelCapacity then
                -- Model bulunamazsa class'a göre varsayılan değer
                if vehClass == 0 then fuelCapacity = 45.0 -- Compacts
                elseif vehClass == 1 then fuelCapacity = 65.0 -- Sedans
                elseif vehClass == 2 then fuelCapacity = 80.0 -- SUVs
                elseif vehClass == 3 then fuelCapacity = 65.0 -- Coupes
                elseif vehClass == 4 then fuelCapacity = 70.0 -- Muscle
                elseif vehClass == 5 then fuelCapacity = 45.0 -- Sports Classics
                elseif vehClass == 6 then fuelCapacity = 60.0 -- Sports
                elseif vehClass == 7 then fuelCapacity = 80.0 -- Super
                elseif vehClass == 8 then fuelCapacity = 20.0 -- Motorcycles
                elseif vehClass == 9 then fuelCapacity = 80.0 -- Off-road
                elseif vehClass == 10 then fuelCapacity = 45.0 -- Industrial
                elseif vehClass == 11 then fuelCapacity = 65.0 -- Utility
                elseif vehClass == 12 then fuelCapacity = 100.0 -- Vans
                elseif vehClass == 14 then fuelCapacity = 200.0 -- Boats
                elseif vehClass == 15 then fuelCapacity = 500.0 -- Helicopters
                elseif vehClass == 16 then fuelCapacity = 1000.0 -- Planes
                elseif vehClass == 17 then fuelCapacity = 65.0 -- Service
                elseif vehClass == 18 then fuelCapacity = 45.0 -- Emergency
                elseif vehClass == 19 then fuelCapacity = 200.0 -- Military
                elseif vehClass == 20 then fuelCapacity = 100.0 -- Commercial
                else fuelCapacity = 65.0 -- Varsayılan
                end
                print("^3[GALER DEBUG]^7 Model fuel bulunamadı, class varsayılanı kullanılıyor: " .. fuelCapacity)
            else
                print("^2[GALER DEBUG]^7 Model fuel bulundu: " .. data.vehicle .. " = " .. fuelCapacity)
            end
            
            -- Tüm stats değerlerini sabit tut (GetVehicle* fonksiyonları değişken değer dönebiliyor)
            local stats = {
               maxSpeed = 100.0, -- Sabit değer (UI'da sadece gösterim için)
               Fuel = fuelCapacity, -- Model bazlı sabit değer
               Handling = 50.0, -- Sabit değer
               Acceleration = 50.0, -- Sabit değer
               Brake = 50.0 -- Sabit değer
            }
            print("^2[GALER DEBUG]^7 Araç istatistikleri (SABİT): Model=" .. data.vehicle .. ", Fuel=" .. stats.Fuel)
            print("^2[GALER DEBUG]^7 currentVeh kaydedildi: " .. tostring(currentVeh))
            
            -- Son kontrol: Oyuncu kesinlikle araçta olmamalı
            if IsPedInVehicle(ped, currentVeh, false) then
                ClearPedTasksImmediately(ped)
                SetEntityCoords(ped, safePos.x, safePos.y, safePos.z, false, false, false, false)
                print("^1[GALER WARNING]^7 Oyuncu araçtaydı, zorla çıkarıldı!")
            end
            
            cb(stats)
        else
            print("^1[GALER ERROR]^7 Araç oluşturulamadı! Timeout: " .. timeout)
            FreezeEntityPosition(ped, false) -- Oyuncuyu serbest bırak
            currentVeh = nil
            cb({maxSpeed = 0, Fuel = 0, Handling = 0, Acceleration = 0, Brake = 0})
        end
    end
)           
         RegisterNUICallback("Delete",function()
                 EYESDeleteVehicle(currentVeh)
             end
         )

         function EYESDeleteVehicle(vehicle)
          SetEntityAsMissionEntity(vehicle, true, true)
          DeleteVehicle(vehicle)
      end

      RegisterNUICallback("SelectColor", function(data)
          if currentVeh ~= nil and DoesEntityExist(currentVeh) then
              RGB = data.color
              SetVehicleCustomPrimaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
              SetVehicleCustomSecondaryColour(currentVeh, data.color.R, data.color.G, data.color.B)
              print("^2[GALER DEBUG]^7 Renk değiştirildi: R=" .. data.color.R .. " G=" .. data.color.G .. " B=" .. data.color.B)
          else
              print("^1[GALER ERROR]^7 Renk değiştirilemedi, currentVeh mevcut değil")
          end
      end)
      


     function OpenNui(data)
          print("^2[GALER DEBUG]^7 OpenNui çağrıldı")
          
          -- Oyuncunun orijinal pozisyonunu kaydet
          local ped = PlayerPedId()
          originalPlayerPos = GetEntityCoords(ped)
          print("^2[GALER DEBUG]^7 Oyuncu orijinal pozisyonu kaydedildi: " .. tostring(originalPlayerPos))
          
          -- mHud'u gizle (event ile)
          TriggerEvent("mHud:HideHud")
          print("^2[GALER DEBUG]^7 mHud:HideHud eventi tetiklendi")
          
          -- HUD'u kapat
          DisplayHud(false)
          DisplayRadar(false)
          print("^2[GALER DEBUG]^7 DisplayHud ve DisplayRadar kapatıldı")
          
          SetDisplay(true)
          print("^2[GALER DEBUG]^7 SetDisplay(true) çağrıldı, hudHidden = " .. tostring(hudHidden))
          
          local cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA",data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ,data.NuiCarViewCameraPosition.rotX, data.NuiCarViewCameraPosition.rotY, data.NuiCarViewCameraPosition.rotZ,data.NuiCarViewCameraPosition.fov,true,0)
          RequestCollisionAtCoord(data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ)
          RenderScriptCams(true, true, 1, true, true)
          PointCamAtCoord(cam, data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ)
          SetFocusPosAndVel(data.NuiCarViewCameraPosition.posX, data.NuiCarViewCameraPosition.posY, data.NuiCarViewCameraPosition.posZ, 0.0, 0.0, 0.0)
          CustomizeCamera(isOpen)
          print("^2[GALER DEBUG]^7 Kamera ayarlandı")
      end


 function CloseNui()
    print("^2[GALER DEBUG]^7 CloseNui çağrıldı")
    Citizen.Wait(1)
     
     SetDisplay(false)
     print("^2[GALER DEBUG]^7 SetDisplay(false) çağrıldı, hudHidden = " .. tostring(hudHidden))
     
     DestroyAllCams(true)
     RenderScriptCams(false, true, 75, true, false, false)
     SetFocusEntity(GetPlayerPed(PlayerId()))
     EYESDeleteVehicle(currentVeh)
     
     -- Oyuncuyu serbest bırak ve orijinal pozisyona geri götür
     local ped = PlayerPedId()
     FreezeEntityPosition(ped, false)
     
     if originalPlayerPos ~= nil then
         SetEntityCoords(ped, originalPlayerPos.x, originalPlayerPos.y, originalPlayerPos.z, false, false, false, false)
         print("^2[GALER DEBUG]^7 Oyuncu orijinal pozisyona geri götürüldü: " .. tostring(originalPlayerPos))
     else
         print("^1[GALER WARNING]^7 originalPlayerPos nil, oyuncu mevcut konumda kaldı")
     end
     
     print("^2[GALER DEBUG]^7 Oyuncu dondurması kaldırıldı")
     
     -- HUD'u aç ama Radar'ı KAPALI tut (araçta değiliz)
     DisplayHud(true)
     DisplayRadar(false) -- Radar kapalı kalmalı
     print("^2[GALER DEBUG]^7 DisplayHud açıldı, DisplayRadar KAPALI (araçta değiliz)")
     
     -- mHud'u göster (event ile)
     TriggerEvent("mHud:ShowHud")
     print("^2[GALER DEBUG]^7 mHud:ShowHud eventi tetiklendi")
     
     -- CustomizeCamera'yı EN SON çağır (DisplayRadar'ı override etmesin)
     CustomizeCamera(isOpen)
     
     -- Radar'ı tekrar kapat (CustomizeCamera açmış olabilir)
     Wait(100)
     DisplayRadar(false)
     print("^2[GALER DEBUG]^7 DisplayRadar tekrar kapatıldı (final)")
 end
 
 -- Oyuncunun araca binmesini sürekli engelle (mHud sorunu için)
 Citizen.CreateThread(function()
     while true do
         Citizen.Wait(0)
         if display and currentVeh ~= nil then
             local ped = PlayerPedId()
             if IsPedInAnyVehicle(ped, false) then
                 local veh = GetVehiclePedIsIn(ped, false)
                 if veh == currentVeh then
                     ClearPedTasksImmediately(ped)
                     local safePos = vector3(Coords.x + 5.0, Coords.y + 5.0, Coords.z)
                     SetEntityCoords(ped, safePos.x, safePos.y, safePos.z, false, false, false, false)
                     print("^1[GALER ANTI-ENTER]^7 Oyuncu araca girmeye çalıştı, engellendi!")
                 end
             end
         else
             Citizen.Wait(500) -- Menü kapalıyken daha az kontrol et
         end
     end
 end)


 if Config.Framework == "ESX" or Config.Framework == "NewESX" then
    Citizen.CreateThread(function()
      Framework = GetFramework()
      while Framework == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) Framework = obj end)
        while Framework.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
        Framework.PlayerData = Framework.GetPlayerData()
      end

      Citizen.CreateThread(function()
        Framework.PlayerData = Framework.GetPlayerData()
        while Framework.GetPlayerData().job == nil do
            Citizen.Wait(0)
            Framework.PlayerData = Framework.GetPlayerData()
        end
      end)
  

        RegisterNetEvent('esx:setJob')
        AddEventHandler('esx:setJob', function(job)
          Framework.PlayerData.job = job
        end)


      Citizen.CreateThread(function()
        Framework.PlayerData = Framework.GetPlayerData()
        while true do
          Citizen.Wait(0)
          local getPed = PlayerPedId()
          local entity = GetEntityCoords(getPed)
    
          for k,v in pairs(Config.Locations) do
            local dist = #(entity - v.coords)

            if dist < 10 then
              if dist < 3 then
                x = v.coords[1]
                y = v.coords[2]
                z = v.coords[3]
                DrawText3D(x,y,z+2.2,v.marker, 1.2, 1)
                DrawText3D(x,y,z+2.05, "~w~[E]", 1.5, 1)
                if IsControlJustPressed(0,38) then
                  if v.job == Framework.PlayerData.job.name or v.job == 'all' then
                    SendNUIMessage({
                      type = "ui",
                      vehicle = Config.Vehicles.Car[v.type],
                      color = Config.Vehicles.Color[v.type],
                      category = Config.Vehicles.Category[v.type]
                    })
    
                    Coords = v.NuiCarViewSpawnPosition
                    TestDrive = v.TestDriveSpawnPosition
                    TestDriveTime = v.TestDriveTime
                    SpawnCoords = v.BuyCarSpawnPositions
    
                    OpenNui(v)
                  end
                end
              end
            end
          end
        end
      end)

      function sellVehicle(model, plate)
        local car = GetVehiclePedIsIn(PlayerPedId())
        for _,v in pairs(Config.Vehicles.Car['car']) do
            if v.model == model then
                Framework.TriggerServerCallback("SellVehicles", function(result, cb)
                    if result then
                        Framework.ShowNotification("The gallery owner has agreed to buy your vehicle! You have received $"..v.price * (Config.RefundPercent * 0.01))
                        DeleteVehicle(car)
                    else
                        Framework.ShowNotification("This vehicle does not belong to you! ("..plate..")")
                    end
                end, plate, v.price, Config.RefundPercent)
            end
        end
    end
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            local vehicle = GetVehiclePedIsIn(PlayerPedId())
            if IsPedInVehicle(PlayerPedId(), vehicle, true) and GetPedInVehicleSeat(vehicle, -1) then
                local entity = GetEntityCoords(PlayerPedId())
                for _,v in pairs(Config.SellVehicles) do
                    local dist = #(entity - v)
                    if dist <= 5.0 then
                        DrawText3D(v.x, v.y, v.z + 0.4, '~g~SELL ~w~YOUR VEHICLE ~r~')
                        DrawMarker(2, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 255, 255, 255, 255, false, false, false, true, false, false, false)
                        if IsControlJustPressed(0,38) then
                            local model = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)):lower()
                            local plate = GetVehicleNumberPlateText(vehicle)
                            sellVehicle(model, plate)
                        end
                        break
                    end
                end
            end
        end
    end)


   RegisterNUICallback("Buy", function(data, cb)
    Framework.TriggerServerCallback("isPrice", function(result)
        if result then 
        local hash = GetHashKey(data.model)
        local coords = konumfor(SpawnCoords)
        if coords ~= nil then
        if not HasModelLoaded(hash) then RequestModel(hash) while not HasModelLoaded(hash) do Citizen.Wait(10) end end
        local buycar = CreateVehicle(hash, coords.x,coords.y,coords.z, coords.w, true, false)
        local netid = NetworkGetNetworkIdFromEntity(buycar)
        local NewPlate = CustomizePlate()
        SetPedIntoVehicle(PlayerPedId(), buycar, -1)
        SetVehicleNumberPlateText(buycar, NewPlate)
        SetVehicleCustomPrimaryColour(buycar,  data.color.R, data.color.G, data.color.B)
        SetVehicleCustomSecondaryColour(buycar, data.color.R, data.color.G, data.color.B)
        SetPedIntoVehicle(PlayerPedId(), buycar, -1)
        SetVehicleHasBeenOwnedByPlayer(buycar, true)
        SetNetworkIdCanMigrate(netid, true)
        SetVehicleNeedsToBeHotwired(buycar, false)
        SetVehRadioStation(buycar, 'OFF')
        local Plate = GetVehicleNumberPlateText(buycar)
        Plate = Trim(GetVehicleNumberPlateText(buycar))
        CloseNui()
        CustomizeCamera(isOpen)
        TriggerServerEvent("vehicleshop:setVehicleOwned", Plate, Framework.Game.GetVehicleProperties(buycar), data.model)
        SendNUIMessage({type = "close"})
        Config.Carkeys(Plate)
    end
else
    TriggerEvent('QBCore:Notify', 'Yetersiz para!', 'error')
    end
end, data.price)
end)


end)

elseif Config.Framework == 'QBCore' or Config.Framework == 'OLDQBCore'  then
     if Config.Framework == "OLDQBCore" then
          while Framework == nil do
               TriggerEvent('QBCore:GetObject', function(obj) Framework = obj end)
               Citizen.Wait(4)
          end
          Framework.PlayerData = Framework.Functions.GetPlayerData()
     else  Framework = exports['qb-core']:GetCoreObject() end

     Citizen.CreateThread(function()
        Framework.PlayerData = Framework.Functions.GetPlayerData()
        while Framework.Functions.GetPlayerData().job == nil do
            Citizen.Wait(0)
            Framework.PlayerData = Framework.Functions.GetPlayerData()
        end
      end)
    

            Citizen.CreateThread(function()
                while true do
                    Citizen.Wait(0)
                    local getPed = PlayerPedId()
                    local entity = GetEntityCoords(getPed)
                    for k, v in pairs(Config.Locations) do
                        local dist = #(entity - v.coords)
                        if dist < 10 then
                            if dist < 3 then
                                local x, y, z = v.coords[1], v.coords[2], v.coords[3]
                                DrawText3D(x, y, z + 2.2, v.marker, 1.2, 1)
                                DrawText3D(x, y, z + 2.05, "~w~[E]", 1.5, 1)
                                if IsControlJustPressed(0, 38) then
                                    if v.job == Framework.PlayerData.job.name or v.job == 'all' then
                                        SendNUIMessage({
                                            type = "ui",
                                            vehicle = Config.Vehicles.Car[v.type],
                                            color = Config.Vehicles.Color[v.type],
                                            category = Config.Vehicles.Category[v.type]
                                        })
                                        Coords = v.NuiCarViewSpawnPosition
                                        TestDrive = v.TestDriveSpawnPosition
                                        TestDriveTime = v.TestDriveTime
                                        SpawnCoords = v.BuyCarSpawnPositions
                                        OpenNui(v)
                                    end
                                end
                            end
                        end
                    end
                end
        end)  

        RegisterNUICallback("Buy", function(data, cb)
            Framework.Functions.TriggerCallback("isPrice", function(result)
                if not result then
                    TriggerEvent('QBCore:Notify', 'Yetersiz para!', 'error')
                    return
                end
        
                local hash = GetHashKey(data.model)
                local coords = konumfor(SpawnCoords)
                if coords == nil then 
                    TriggerEvent('QBCore:Notify', 'Spawn noktası bulunamadı!', 'error')
                    return 
                end
        
                RequestModel(hash)
                while not HasModelLoaded(hash) do
                    Citizen.Wait(10)
                end
        
                local buycar = CreateVehicle(hash, coords.x, coords.y, coords.z, coords.w, true, false)
                local netid = NetworkGetNetworkIdFromEntity(buycar)
                SetPedIntoVehicle(PlayerPedId(), buycar, -1)
                SetVehicleNumberPlateText(buycar, CustomizePlate())
                SetVehicleCustomPrimaryColour(buycar, data.color.R, data.color.G, data.color.B)
                SetVehicleCustomSecondaryColour(buycar, data.color.R, data.color.G, data.color.B)
                SetVehicleHasBeenOwnedByPlayer(buycar, true)
                SetNetworkIdCanMigrate(netid, true)
                SetVehicleNeedsToBeHotwired(buycar, false)
                SetVehRadioStation(buycar, 'OFF')
        
                local Plate = Trim(GetVehicleNumberPlateText(buycar))
                CloseNui()
                CustomizeCamera(isOpen)
                Config.Carkeys(Plate)
                TriggerServerEvent("vehicleshop:setVehicleOwned", Plate, Framework.Functions.GetVehicleProperties(buycar), data.model)
                SendNUIMessage({type = "close"})
                TriggerEvent('QBCore:Notify', 'Araç satın alındı!', 'success')
            end, data.price)
        end)

     end


 function randomNumber(length)
	local res = ""
	for i = 1, length do res = res .. string.char(math.random(48,  57)) end
	return res
end

function randomCharacter(length)
	local res = ""
	for i = 1, length do res = res .. string.char(math.random(97, 122))	end
	return res
end


 function Trim(value)
    return (string.gsub(value, '^%s*(.-)%s*$', '%1'))
end

local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end
		local enum = {handle = iter, destructor = disposeFunc}
		setmetatable(enum, entityEnumerator)
		local next = true
		repeat
			coroutine.yield(id)
			next, id = moveFunc(iter)
		until not next
		enum.destructor, enum.handle = nil, nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumerateEntitiesWithinDistance(entities, isPlayerEntities, coords, maxDistance)
	local nearbyEntities = {}
	if coords then
		coords = vector3(coords.x, coords.y, coords.z)
	else
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end
	for k,entity in pairs(entities) do
		local distance = #(coords - GetEntityCoords(entity))
		if distance <= maxDistance then
			table.insert(nearbyEntities, isPlayerEntities and k or entity)
		end
	end
	return nearbyEntities
end

function GetVehicles()
	local vehicles = {}
	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end
	return vehicles
end

function konumfor(getkonum)
    for k, v in pairs(getkonum) do
        local konum = EnumerateEntitiesWithinDistance(GetVehicles(), false, v, 2.5)
        Wait(4)
        if konum[1] == nil then
            return v
        end
    end
end
 
 local display = false
 local hudHidden = false
 
 -- HUD gizleme thread'i
 Citizen.CreateThread(function()
     print("^2[GALER DEBUG]^7 HUD gizleme thread'i başlatıldı")
     while true do
         Citizen.Wait(0)
         if hudHidden then
             -- Tüm HUD componentlerini gizle
             for i = 0, 22 do
                 HideHudComponentThisFrame(i)
             end
             DisplayHud(false)
             DisplayRadar(false)
         end
     end
 end)
 
 RegisterNUICallback("exit", function(data)
     CloseNui()
 end)
 
 function SetDisplay(bool)
     print("^2[GALER DEBUG]^7 SetDisplay çağrıldı: " .. tostring(bool))
     display = bool
     hudHidden = bool
     SetNuiFocus(bool, bool)
     print("^2[GALER DEBUG]^7 hudHidden değeri: " .. tostring(hudHidden))
     
     if not bool then
         -- NUI kapatılırken HUD'u aç
         DisplayHud(true)
         DisplayRadar(true)
         print("^2[GALER DEBUG]^7 HUD açıldı (SetDisplay false)")
     else
         -- NUI açılırken HUD'u kapat
         DisplayHud(false)
         DisplayRadar(false)
         print("^2[GALER DEBUG]^7 HUD kapatıldı (SetDisplay true)")
     end
 end


 _RequestModel = function(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
    Wait(0)
    end
end


EYES.Create = function()
    local locations = Config.Locations
    for i=1, #locations do
        local pedHash = GetHashKey(locations[i].hash)
        if DoesEntityExist(pedHash) then
            DeletePed(pedHash)
            SetPedAsNoLongerNeeded(pedHash)
        end
    end
end

EYES.Functions = {}

EYES.Functions.CreateBlips = function()
    print("^2[GALER DEBUG]^7 CreateBlips fonksiyonu çağrıldı")
    for k, v in pairs(Config.Locations) do
        -- Hem yeni hem eski blip formatını destekle
        local blipActive = false
        local blipSprite, blipColor, blipScale, blipLabel
        
        if v.blip then
            -- Yeni format kontrolü
            if v.blip.active ~= nil then
                blipActive = v.blip.active
                blipSprite = v.blip.sprite
                blipColor = v.blip.color
                blipScale = v.blip.scale or 0.8
                blipLabel = v.blip.label or "Galeri"
            -- Eski format kontrolü
            elseif v.blip["active"] ~= nil then
                blipActive = v.blip["active"]
                blipSprite = v.blip["id"]
                blipColor = v.blip["colour"]
                blipScale = 0.5
                blipLabel = v.blip["name"] or "Galeri"
            -- Sprite varsa aktif kabul et
            elseif v.blip.sprite then
                blipActive = true
                blipSprite = v.blip.sprite
                blipColor = v.blip.color or 3
                blipScale = v.blip.scale or 0.8
                blipLabel = v.blip.label or "Galeri"
            end
        end
        
        if blipActive and blipSprite then
            local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
            SetBlipSprite(blip, blipSprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, blipScale)
            SetBlipColour(blip, blipColor)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(blipLabel)
            EndTextCommandSetBlipName(blip)
            print("^2[GALER DEBUG]^7 Blip oluşturuldu: " .. blipLabel .. " (" .. v.coords.x .. ", " .. v.coords.y .. ")")
        else
            print("^3[GALER DEBUG]^7 Blip ayarları eksik veya aktif değil: " .. (v.marker or "Unknown"))
        end
    end
end

Citizen.CreateThread(function()
    EYES.Functions.CreateBlips()
    local locations = Config.Locations
    for i=1, #locations do
        local pedHash = GetHashKey(locations[i].hash)
        local coords = locations[i].coords
        local heading = locations[i].heading
        if pedHash then
            _RequestModel(pedHash)
            if not DoesEntityExist(pedHash) then
                local ped = CreatePed(4, pedHash, coords.x, coords.y, coords.z, heading, false, false)
                
                -- PED PERSİSTENCE - Asla kaybolmasın!
                SetEntityAsMissionEntity(ped, true, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                FreezeEntityPosition(ped, true)
                SetEntityInvincible(ped, true)
                SetPedCanRagdoll(ped, false)
                SetPedCanBeTargetted(ped, false)
                SetPedCanBeDraggedOut(ped, false)
                SetPedFleeAttributes(ped, 0, false)
                SetPedCombatAttributes(ped, 17, true)
                
                -- Network ayarları - Ped'in despawn olmaması için
                local netId = NetworkGetNetworkIdFromEntity(ped)
                SetNetworkIdCanMigrate(netId, false)
                SetNetworkIdExistsOnAllMachines(netId, true)
                
                print("^2[GALER DEBUG]^7 Ped oluşturuldu (persistence aktif): " .. locations[i].marker .. " - Entity: " .. ped)
            end
            -- Model'i NO LONGER NEEDED yapma - ped despawn olabilir!
            -- SetModelAsNoLongerNeeded(pedHash)
        end
    end
end)


AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        print(GetCurrentResourceName() .. ' [PED] New pads added, old pad data deleted!')
        EYES.Create()
    end
end)


 
 DrawText3D = function(x, y, z, text)
     SetTextScale(0.35, 0.35)
     SetTextFont(2)
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

 

 function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(5)
     SetTextFont(8)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

