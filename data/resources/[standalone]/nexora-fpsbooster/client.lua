-- Nexora RP FPS Booster
-- Bu script FPS'i artırmak için optimize edilmiştir

CreateThread(function()
    while true do
        Wait(0)
        
        -- Uzak araçları gizle (200 metreden uzak) - AZALTILDI
        SetVehicleDensityMultiplierThisFrame(0.3) -- 0.5 → 0.3 (daha az araç)
        SetPedDensityMultiplierThisFrame(0.3) -- 0.4 → 0.3 (daha az NPC)
        SetRandomVehicleDensityMultiplierThisFrame(0.3) -- 0.5 → 0.3 (daha az rastgele araç)
        SetParkedVehicleDensityMultiplierThisFrame(0.2) -- 0.5 → 0.2 (daha az park edilmiş araç)
        SetScenarioPedDensityMultiplierThisFrame(0.2, 0.2) -- 0.3 → 0.2 (daha az senaryo NPC'si)
        
        -- Uzak araç ışıklarını kapat
        SetDistantCarsEnabled(false)
        
        -- Gereksiz AI'ları kapat - AZALTILDI
        SetAmbientVehicleRangeMultiplierThisFrame(0.3) -- 0.5 → 0.3
        SetAmbientPedRangeMultiplierThisFrame(0.3) -- 0.5 → 0.3
        
        -- Rastgele olayları azalt
        SetRandomEventFlag(false)
        SetDeepOceanScaler(0.0)
    end
end)

-- Gereksiz NPC'leri spawn etme
CreateThread(function()
    while true do
        Wait(0)
        
        -- Polis, ambulans, itfaiye spawn'ını kapat
        for i = 1, 15 do
            EnableDispatchService(i, false)
        end
        
        -- Wanted level sistemini kapat
        SetMaxWantedLevel(0)
        
        -- Rastgele polis kontrollerini kapat
        SetPoliceIgnorePlayer(PlayerId(), true)
        
        -- Rastgele çeteleri kapat
        SetCreateRandomCops(false)
        SetCreateRandomCopsNotOnScenarios(false)
        SetCreateRandomCopsOnScenarios(false)
    end
end)

-- Uzak nesneleri optimize et
CreateThread(function()
    while true do
        Wait(1000) -- Her saniye kontrol et
        
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        -- Uzak araçları sil (300 metreden uzak ve içinde kimse yok)
        for vehicle in EnumerateVehicles() do
            local vehicleCoords = GetEntityCoords(vehicle)
            local distance = #(playerCoords - vehicleCoords)
            
            if distance > 300.0 then
                if not IsPedAPlayer(GetPedInVehicleSeat(vehicle, -1)) then
                    SetEntityAsMissionEntity(vehicle, true, true)
                    DeleteVehicle(vehicle)
                end
            end
        end
        
        -- Uzak NPC'leri sil (200 metreden uzak)
        for ped in EnumeratePeds() do
            if not IsPedAPlayer(ped) then
                local pedCoords = GetEntityCoords(ped)
                local distance = #(playerCoords - pedCoords)
                
                if distance > 200.0 then
                    SetEntityAsMissionEntity(ped, true, true)
                    DeletePed(ped)
                end
            end
        end
    end
end)

-- Grafik optimizasyonları
CreateThread(function()
    while true do
        Wait(0)
        
        -- Uzak ışıkları kapat
        SetArtificialLightsState(false)
        
        -- Ekstra detayları kapat
        SetTimecycleModifier("default")
        ClearTimecycleModifier()
        
        -- Gölgeleri optimize et (Eski FiveM versiyonları için)
        -- CascadeShadowsClearShadowSampleType()
        -- CascadeShadowsSetType("CSMT_PD")
    end
end)

-- Gereksiz oyun özelliklerini kapat
CreateThread(function()
    -- Bir kere çalışması yeterli
    
    -- Bulutları kapat
    SetCloudHatOpacity(0.0)
    
    -- Uzak LOD ışıklarını kapat
    SetDistantCarsEnabled(false)
    
    -- Ekstra detayları kapat
    SetExtraTimecycleModifier("default")
    
    -- Rastgele trenleri kapat
    SwitchTrainTrack(0, false)
    SwitchTrainTrack(3, false)
    SetRandomTrains(false)
    
    -- Rastgele tekneleri kapat
    SetRandomBoats(false)
    SetGarbageTrucks(false)
    
    -- Helikopter seslerini azalt
    DistantCopCarSirens(false)
end)

-- Entity enumeration fonksiyonları
function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
end

function EnumerateEntities(initFunc, moveFunc, disposeFunc)
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

entityEnumerator = {
    __gc = function(enum)
        if enum.destructor and enum.handle then
            enum.destructor(enum.handle)
        end
    end
}

-- FPS Monitoring (F10 tuşu ile aç/kapat)
local showFPS = false
local fpsData = {
    current = 0,
    average = 0,
    samples = {}
}

CreateThread(function()
    while true do
        Wait(1000)
        
        local fps = GetFrameCount()
        table.insert(fpsData.samples, fps)
        
        if #fpsData.samples > 10 then
            table.remove(fpsData.samples, 1)
        end
        
        local sum = 0
        for _, v in ipairs(fpsData.samples) do
            sum = sum + v
        end
        
        fpsData.current = fps
        fpsData.average = math.floor(sum / #fpsData.samples)
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        
        if IsControlJustPressed(0, 57) then -- F10
            showFPS = not showFPS
            if showFPS then
                print('^2[Nexora FPS]^7 FPS göstergesi açıldı')
            else
                print('^2[Nexora FPS]^7 FPS göstergesi kapatıldı')
            end
        end
        
        if showFPS then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            
            -- Yakındaki entity sayılarını hesapla
            local nearbyVehicles = 0
            local nearbyPeds = 0
            
            for vehicle in EnumerateVehicles() do
                local vehicleCoords = GetEntityCoords(vehicle)
                if #(playerCoords - vehicleCoords) < 100.0 then
                    nearbyVehicles = nearbyVehicles + 1
                end
            end
            
            for ped in EnumeratePeds() do
                if not IsPedAPlayer(ped) then
                    local pedCoords = GetEntityCoords(ped)
                    if #(playerCoords - pedCoords) < 100.0 then
                        nearbyPeds = nearbyPeds + 1
                    end
                end
            end
            
            -- FPS bilgilerini ekrana yazdır
            SetTextFont(4)
            SetTextProportional(1)
            SetTextScale(0.35, 0.35)
            SetTextColour(0, 255, 0, 255)
            SetTextDropshadow(0, 0, 0, 0, 255)
            SetTextEdge(1, 0, 0, 0, 255)
            SetTextDropShadow()
            SetTextOutline()
            SetTextEntry("STRING")
            AddTextComponentString(string.format(
                "~g~Nexora FPS Booster~w~\n" ..
                "FPS: ~g~%d~w~ | Ort: ~y~%d~w~\n" ..
                "Araçlar (100m): ~b~%d~w~\n" ..
                "NPC'ler (100m): ~o~%d~w~\n" ..
                "~s~F10: Kapat",
                fpsData.current,
                fpsData.average,
                nearbyVehicles,
                nearbyPeds
            ))
            DrawText(0.01, 0.01)
        end
    end
end)

print('^2[Nexora FPS Booster]^7 FPS optimizasyonu aktif!')
print('^2[Nexora FPS Booster]^7 F10 tuşu ile FPS göstergesini açabilirsiniz')
