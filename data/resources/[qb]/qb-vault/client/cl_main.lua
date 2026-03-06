local QBCore = exports['qb-core']:GetCoreObject()


CreateThread(function()
    for k, v in pairs(Config.location) do
        exports['qb-target']:AddBoxZone(v.name, v.coords, v.length, v.width, {
            name = v.name,
            heading = v.heading,
            debugPoly = v.debug,
            minZ = v.minz,
            maxZ = v.maxz,
        }, {
            options = {
                {
                  type = "client",
                  action = function(entity) 
                    TriggerEvent('re2-vault:viewStorages', k)
                  end,
                  icon = "fas fa-box-open",
                  label = "Depoyu Gör",
                },
                {
                    type = "client",
                    action = function(entity) 
                      TriggerEvent('re2-vault:createStorage', k)
                    end,
                    icon = "fas fa-boxes",
                    label = "Depo Satın Al",
                  },
            },
            distance = v.distance
        })
    end
    
  end)

AddEventHandler('re2-vault:viewStorages', function(location)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    local p = nil
    local data ={
        cid = citizenid,
        storagelocation = Config.location[location].name,
    }
    local fetchStoragePromise = function(data)
        if p then return end
        p = promise.new()
        QBCore.Functions.TriggerCallback('re2-vault:server:fetchStorage', function(result)
            p:resolve(result)
        end, data)
        return Citizen.Await(p)
    end
    
    local result = fetchStoragePromise(data)
    p = nil
    if result then
        local storagesMenu = {
            {
                header = "Şu bölgedeki depoların: "..Config.location[location].name,
                isMenuHeader = true
            }
        }

        for k, v in pairs(result) do
            storagesMenu[#storagesMenu+1] = {
                header = v.storagename,
                txt = "Kapasite : "..(v.storage_size/1000).." -- Sahip : "..v.citizenid,
                params = {
                    event = "re2-vault:openStorageMenu",
                    args = {
                        storageid = v.id
                    }
                }

            }
        end

        storagesMenu[#storagesMenu+1] = {
            header = "Menüyü Kapat",
            txt = "",
            params = {
                event = "qb-menu:client:closeMenu"
            }

        }
        exports['qb-menu']:openMenu(storagesMenu)
    else
        QBCore.Functions.Notify("Burada bir deponuz yok.", "error")
    end
end)


AddEventHandler('re2-vault:openStorageMenu', function(data)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    -- local storagename=location.."_"..citizenid
    local dialog = exports['qb-input']:ShowInput({
        header = "Depo Şifresi",
        submitText = "Gönder",
        inputs = {
            {
                text = "Şifre", -- text you want to be displayed as a place holder
                name = "password", -- name of the input should be unique otherwise it might override
                type = "password", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })

    if dialog ~= nil then
        local p = nil
        local data ={
            password = dialog.password,
            id = data.storageid
        }
        local openStoragePromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:checkThePassword', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = openStoragePromise(data)
        p = nil
        if result then
            local v = result[1]
            local storageMenu = {
                {
                    isHeader = true,
                    header = 'Depo '..v.storagename
                },
                {
                    header = '📦 | Depoyu Aç',
                    txt = 'Aç: '..v.storagename,
                    params = {
                        event = 're2-vault:openInventory',
                        args = {
                            storagename = v.storage_location..'_'..v.storagename..'_'..v.citizenid,
                            storagesize = v.storage_size
                        }
                    }
                }
            }
            if citizenid == v.citizenid then
                local addmembermenu={
                    header = '➕ | Kullanıcı Ekle',
                    txt = 'Şu depoya kişi ekle: '..v.storagename,
                    params = {
                        event = 're2-vault:addMemberToStorage',
                        args = {
                            storageid = v.id,
                        }
                    }
                }
                table.insert(storageMenu,addmembermenu)
                local removememberMenu={
                    header = '➖ | Kullanıcı Çıkar',
                    txt = 'Şu depodan kullanıcı çıkar: '..v.storagename,
                    params = {
                        event = 're2-vault:removeMemberFromStorage',
                        args = {
                            storageid = v.id
                        }
                    }
                }
                table.insert(storageMenu,removememberMenu)
                local addstorageMenu={
                    header = '🛒 | Alan Satın Al',
                    txt = 'Şu depoya 200kg ekle: '..v.storagename,
                    params = {
                        event = 're2-vault:addCapacity',
                        args = {
                            storageid = v.id
                        }
                    }
                }
                table.insert(storageMenu,addstorageMenu) 
            end
            local closeMenu={
                header = "Menüyü Kapat",
                txt = "",
                params = {
                    event = "qb-menu:client:closeMenu"
                }
            }
            table.insert(storageMenu,closeMenu) 
              exports['qb-menu']:openMenu(storageMenu)
            QBCore.Functions.Notify("Doğru Şifre", "success")
        else
            QBCore.Functions.Notify("Yanlış Şifre", "error")
        end
    end
end)

AddEventHandler('re2-vault:createStorage', function(location)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    local cpdialog = exports['qb-input']:ShowInput({
        header = "Şifre Oluştur",
        submitText = "Gönder",
        inputs = {
            {
                text = "İsim", -- text you want to be displayed as a place holder
                name = "name", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            },
            {
                text = "Şifre", -- text you want to be displayed as a place holder
                name = "password", -- name of the input should be unique otherwise it might override
                type = "password", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })
    if cpdialog ~= nil then
        if player.money['cash'] >= tonumber(Config.StorageCreationAmount) then
        local p = nil
        local data ={
            cid = citizenid,
            password = cpdialog.password,
            storagename = cpdialog.name,
            storagelocation = Config.location[location].name,
            storagesize = Config.StorageDefaultWeight
        }
        local createStoragePromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:createStorage', function(result)
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = createStoragePromise(data)
        p = nil
        if result then
            TriggerServerEvent('re2-vault:server:removeMoney',Config.StorageCreationAmount)
            QBCore.Functions.Notify("Depo Oluşturuldu", "success")
        else
            QBCore.Functions.Notify("Aynı İsimde Depo Zaten Var", "error")
        end
        -- return cb(result)
    else
        QBCore.Functions.Notify("Gerekli ücrete sahip değilsin.", "error")
    end
    end


end)


AddEventHandler('re2-vault:addMemberToStorage', function(data)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    -- local storagename=location.."_"..citizenid
    local mdialog = exports['qb-input']:ShowInput({
        header = "Kişi Ekle",
        submitText = "Gönder",
        inputs = {
            {
                text = "Kişinin IDsi", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })

    if mdialog ~= nil then
        local p = nil
        local data ={
            citizenid = mdialog.citizenid,
            id = data.storageid
        }
        local addMemberPromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:addMember', function(result)
                print(json.encode(result))
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = addMemberPromise(data)
        p = nil
        if result then
            QBCore.Functions.Notify("Kişi depoya eklendi", "success")
        else
            QBCore.Functions.Notify("Hata oluştu", "error")
        end
    end
end)

AddEventHandler('re2-vault:removeMemberFromStorage', function(data)
    local player=QBCore.Functions.GetPlayerData()
    local citizenid=player.citizenid
    -- local storagename=location.."_"..citizenid
    local mdialog = exports['qb-input']:ShowInput({
        header = "Kişiyi Kaldır",
        submitText = "Gönder",
        inputs = {
            {
                text = "Kişi IDsi", -- text you want to be displayed as a place holder
                name = "citizenid", -- name of the input should be unique otherwise it might override
                type = "text", -- type of the input
                isRequired = true -- Optional [accepted values: true | false] but will not submit the form if no value is inputted
            }
        },
    })

    if mdialog ~= nil then
        local p = nil
        local data ={
            citizenid = mdialog.citizenid,
            id = data.storageid
        }
        local removeMemberPromise = function(data)
            if p then return end
            p = promise.new()
            QBCore.Functions.TriggerCallback('re2-vault:server:removeMember', function(result)
                print(json.encode(result))
                p:resolve(result)
            end, data)
            return Citizen.Await(p)
        end
    
        local result = removeMemberPromise(data)
        p = nil
        if result then
            QBCore.Functions.Notify("Kişi Depodan Silindi", "success")
        else
            QBCore.Functions.Notify("Hata Oluştu", "error")
        end
    end
end)

AddEventHandler('re2-vault:openInventory', function(data)
        TriggerServerEvent("inventory:server:OpenInventory", "stash", data.storagename,{
            maxweight = data.storagesize,
            slots = Config.StorageSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", data.storagename)
        QBCore.Functions.Notify("Depo açılıyor...", "success")

    
end)


AddEventHandler('re2-vault:addCapacity', function(data)
    local player=QBCore.Functions.GetPlayerData()
    if player.money['cash'] >= tonumber(Config.StorageAddPrice) then
    local p = nil
    local data ={
        id = data.storageid
    }
    local addCapacityPromise = function(data)
        if p then return end
        p = promise.new()
        QBCore.Functions.TriggerCallback('re2-vault:server:addCapacity', function(result)
            print(json.encode(result))
            p:resolve(result)
        end, data)
        return Citizen.Await(p)
    end
    
    local result = addCapacityPromise(data)
    p = nil
    if result then
        TriggerServerEvent('re2-vault:server:removeMoney',Config.StorageAddPrice)
        QBCore.Functions.Notify("Başarıyla depo kapasitesi yükseltildi.", "success")
    else
        QBCore.Functions.Notify("Hata Oluştu", "error")
    end
else
    QBCore.Functions.Notify("Gerekli ücrete sahip değilsin.", "error")
end


end)



