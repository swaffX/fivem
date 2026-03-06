Config = {
    pedModel        = "s_m_y_airworker", -- NPC modeli
    zoneDiameter    = 10.0, -- İade bölgesi çapı
    licenseItemName = "driver_license", -- Ehliyet item adı
    rentalPaperName = "rentalpapers", -- Kiralık araç kağıdı (qb-core'da rentalpapers)
    rentalFeesPrice = 500,  -- Kağıt kaybederse ödeyeceği ücret
    carFeesPrice    = 2000, -- Araç kaybederse ödeyeceği ücret
    pzones   = { -- Kiralık araç lokasyonları
        zone1 = { --Legion Square
            pedLocation = vector4(215.29, -806.51, 30.8, 337.1),
            vehspawnloc = vector4(216.13, -801.78, 30.39, 68.31),
            pzvect      = vector3(215.24, -806.55, 30.78),
            wid         = 0.6,
            hig         = 0.6,
            heading     = 338,
            minZ        = 27.58,
            maxZ        = 31.58,
        },
        zone2 = { --Havaalanı
            pedLocation = vector4(-1031.22, -2734.73, 20.17, 21.45),
            vehspawnloc = vector4(-1030.2, -2732.12, 19.67, 241.68),
            pzvect      = vector3(-1031.25, -2734.65, 20.17),
            wid         = 0.6,
            hig         = 0.8,
            heading     = 305,
            minZ        = 16.97,
            maxZ        = 20.97,
        },
        zone3 = { --Paleto
            pedLocation = vector4(145.64, 6563.96, 32.0, 313.11),
            vehspawnloc = vector4(154.45, 6567.83, 31.42, 254.12),
            pzvect      = vector3(145.7, 6564.04, 32.0),
            wid         = 0.6,
            hig         = 0.6,
            heading     = 315,
            minZ        = 28.8,
            maxZ        = 32.8,
        },
        zone4 = { --Sandy Shores
            pedLocation = vector4(1991.19, 3778.08, 32.18, 123.61),
            vehspawnloc = vector4(1984.5, 3767.3, 31.77, 206.01),
            pzvect      = vector3(1991.09, 3778.02, 32.18),
            wid         = 0.6,
            hig         = 0.6,
            heading     = 30,
            minZ        = 28.98,
            maxZ        = 32.98,
        },
    },
    blip = { -- Harita blip ayarları
        name  = "Araç Kiralama",
        color = 5,
        id    = 757
    },
    carBlip = { -- Kiralık araç takip blip'i
        name    = "Kiralık Araç",
        color   = 5,
        carID   = 523, -- Araç blip ID
        motorID = 522  -- Motor blip ID
    },
    cars = {
        -- Kiralanabilir araçlar (QB-Core araç spawn kodları)
        { name = "Futo", id = "futo", text = "Ekonomik sedan", isCar = true, price = 150 },
        { name = "Asea", id = "asea", text = "Ucuz sedan", isCar = true, price = 100 },
        { name = "Blista", id = "blista", text = "Kompakt araç", isCar = true, price = 120 },
        { name = "Panto", id = "panto", text = "Mini araç", isCar = true, price = 80 },
        { name = "Bison", id = "bison", text = "Pickup kamyonet", isCar = true, price = 200 },
        { name = "Faggio", id = "faggio", text = "Scooter", isCar = false, price = 50 },
        { name = "Sanchez", id = "sanchez", text = "Dirt bike", isCar = false, price = 100 },
    },
}