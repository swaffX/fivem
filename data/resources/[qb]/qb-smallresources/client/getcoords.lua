-- Koordinat Alma Komutu
RegisterCommand('getcoords', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    
    -- vector3 formatı
    local vec3 = string.format("vector3(%.2f, %.2f, %.2f)", coords.x, coords.y, coords.z)
    
    -- vector4 formatı (heading ile)
    local vec4 = string.format("vector4(%.2f, %.2f, %.2f, %.2f)", coords.x, coords.y, coords.z, heading)
    
    -- Konsola yazdır
    print("^2========== KOORDİNATLAR ==========^0")
    print("^3vector3:^0 " .. vec3)
    print("^3vector4:^0 " .. vec4)
    print("^3X:^0 " .. coords.x)
    print("^3Y:^0 " .. coords.y)
    print("^3Z:^0 " .. coords.z)
    print("^3Heading:^0 " .. heading)
    print("^2===================================^0")
    
    -- Oyuncuya bildirim
    TriggerEvent('QBCore:Notify', "Koordinatlar F8 console'a yazdırıldı!", "success")
    
    -- Panoya kopyala (vector4)
    TriggerServerEvent('getcoords:copyToClipboard', vec4)
end, false)

-- Araç koordinatı alma
RegisterCommand('getvehcoords', function()
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    
    if veh ~= 0 then
        local coords = GetEntityCoords(veh)
        local heading = GetEntityHeading(veh)
        
        local vec3 = string.format("vector3(%.2f, %.2f, %.2f)", coords.x, coords.y, coords.z)
        local vec4 = string.format("vector4(%.2f, %.2f, %.2f, %.2f)", coords.x, coords.y, coords.z, heading)
        
        print("^2========== ARAÇ KOORDİNATLARI ==========^0")
        print("^3vector3:^0 " .. vec3)
        print("^3vector4:^0 " .. vec4)
        print("^3X:^0 " .. coords.x)
        print("^3Y:^0 " .. coords.y)
        print("^3Z:^0 " .. coords.z)
        print("^3Heading:^0 " .. heading)
        print("^2=========================================^0")
        
        TriggerEvent('QBCore:Notify', "Araç koordinatları F8 console'a yazdırıldı!", "success")
        TriggerServerEvent('getcoords:copyToClipboard', vec4)
    else
        TriggerEvent('QBCore:Notify', "Araçta değilsin!", "error")
    end
end, false)

-- Kamera baktığı yerin koordinatı
RegisterCommand('getcamcoords', function()
    local ped = PlayerPedId()
    local camCoords = GetGameplayCamCoord()
    local camRot = GetGameplayCamRot(2)
    
    local vec3 = string.format("vector3(%.2f, %.2f, %.2f)", camCoords.x, camCoords.y, camCoords.z)
    
    print("^2========== KAMERA KOORDİNATLARI ==========^0")
    print("^3vector3:^0 " .. vec3)
    print("^3X:^0 " .. camCoords.x)
    print("^3Y:^0 " .. camCoords.y)
    print("^3Z:^0 " .. camCoords.z)
    print("^3Rotation:^0 " .. camRot.z)
    print("^2===========================================^0")
    
    TriggerEvent('QBCore:Notify', "Kamera koordinatları F8 console'a yazdırıldı!", "success")
end, false)

-- Heading alma
RegisterCommand('getheading', function()
    local ped = PlayerPedId()
    local heading = GetEntityHeading(ped)
    
    print("^2========== HEADING ==========^0")
    print("^3Heading:^0 " .. heading)
    print("^2==============================^0")
    
    TriggerEvent('QBCore:Notify', "Heading: " .. string.format("%.2f", heading), "success")
end, false)
