Config = Config or {}

-- Blips
FoodProcessor = {
    targetZone = vector3(2853.98, 4557.02, 46.15),      -- qb-target vector
    targetHeading = 5,                                  -- qb-target box zone
    coords = vector4(2853.98, 4557.02, 46.15, 25.64),   -- Move Location (Ped and blip)
    SetBlipSprite = 430,                                -- Blip Icon (https://docs.fivem.net/docs/game-references/blips/)
    SetBlipDisplay = 6,                                 -- Blip Behavior (https://docs.fivem.net/natives/?_0x9029B2F3DA924928)
    SetBlipScale = 0.60,                                -- Blip Size
    SetBlipColour = 35,                                 -- Blip Color
    BlipLabel = "[1] Yemek Pişirme",                    -- Blip Label
    minZ = 43.95,                                       -- qb-target Min
    maxZ = 47.95,                                       -- qb-target Max
}
DairyProcessor = {
    targetZone = vector3(2567.92, 4684.44, 33.05),
    targetHeading = 330,
    coords = vector4(2567.92, 4684.44, 33.05, 47.10),
    SetBlipSprite = 430,
    SetBlipDisplay = 6,
    SetBlipScale = 0.60,
    SetBlipColour = 32,
    BlipLabel = "[1] Süt İşleme",
    minZ = 32.05,
    maxZ = 35.00,
}
Seller = {
    targetZone = vector3(1582.65, 6452.59, 24.32),
    targetHeading = 20.82,
    coords = vector4(1582.65, 6452.59, 24.32, 153.76),
    SetBlipSprite = 684,
    SetBlipDisplay = 6,
    SetBlipScale = 0.60,
    SetBlipColour = 17,
    BlipLabel = "[1] Çiftlik Ürünleri Satış",
    minZ = 23,
    maxZ = 25,
}
Rent = {
    targetZone = vector3(-149.15, 6315.93, 31.48),
    targetHeading = 20.06,
    coords = vector4(-149.15, 6315.93, 30.48, 247.6),
    SetBlipSprite = 36,
    SetBlipDisplay = 6,
    SetBlipScale = 0.70,
    SetBlipColour = 32,
    BlipLabel = "Araç Kirala",
    minZ = 28.3,
    maxZ = 34.0,
}
Hastane = {
    coords = vector4(-435.93, -325.79, 33.91, 154.71)
}

-- Pig Farm (Food)

Config.PigFood = 5                                      -- Food Amount (Pig Food)
Config.FoodPrice = 5                                    --  Pig Farm Food Price
PigFarmer = vector4(2166.11, 5003.84, 40.39, 312.56)    -- Ped Location
PigFarmerTargetZone = vector3(2166.11, 5003.84, 40.39)  -- QB-Target location
PigFarmerTzHeading = 305                                -- QB-Target Heading
PigFarmerMinZ = 40				        -- QB-Target MinZ
PigFarmerMaxZ = 42				        -- QB-Target MaxZ

-- Processing Items
Config.AppleProcessing = 3                              -- Trading Amount
Config.BeefProcessing = 2
Config.BaconProcesing = 3
Config.HamProcessing = 2
Config.PorkProcessing = 1
Config.SausageProcessing = 2
Config.MilkProcessing = 2
Config.PumpkinProcessing = 1
Config.CornProcessing = 2
Config.GrapeProcessing = 3
Config.ChillyProcessing = 3
Config.TomatoesProcessing = 3

-- Processed Items
Config.AppleJuice = 1                                   -- Received Amount
Config.BaconProcessed = 3
Config.HamProcessed = 2
Config.PorkProcessed = 1
Config.SausageProcessed = 2
Config.CowMeat = 2
Config.Milk = 4
Config.PumpkinBoxes = 3
Config.CornProcessed = 1
Config.GrapeProcessed = 1
Config.ChillyProcessed = 1
Config.TomatoesProcessed = 1

-- Processing time
Config.ProcessingTime = {
    ["apple_processingtime"] = 5000,                    -- MS = Seconds (5000 ms = 5 seconds)
    ["beef_processingtime"] = 10000,
    ["bacon_processingtime"] = 10000,
    ["ham_processingtime"] = 10000,
    ["pork_processingtime"] = 10000,
    ["sausage_processingtime"] = 10000,
    ["milk_tradingtime"] = 7500,
    ["pumpkin_smashingtime"] = 7500,
    ["grape_processingtime"] = 7500,
    ["chillypepper_processingtime"] = 7500,
    ["tomatoes_processingtime"] = 7500,
}


-- Sell Items
Config.Sell = {
    ["apple"] = {
        ["price"] = math.random(50, 80)                  -- Seller Price
    },
    ["apple_juice"] = {
        ["price"] = math.random(80, 120)
    },
    ["milkbucket"] = {
        ["price"] = math.random(60, 90)
    },
    ["raw_beef"] = {
        ["price"] = math.random(100, 150)
    },
    ["beef"] = {
        ["price"] = math.random(150, 200)
    },
    ["milk"] = {
        ["price"] = math.random(40, 70)
    },
    ["rawpumpkin"] = {
        ["price"] = math.random(50, 80)
    },
    ["pumpkinpiebox"] = {
        ["price"] = math.random(100, 140)
    },
    ["slicedpie"] = {
        ["price"] = math.random(120, 160)
    },
    ["corncob"] = {
        ["price"] = math.random(40, 70)
    },
    ["canofcorn"] = {
        ["price"] = math.random(80, 110)
    },
    ["grapes"] = {
        ["price"] = math.random(50, 80)
    },
    ["grapejuice"] = {
        ["price"] = math.random(90, 130)
    },
    ["greenpepper"] = {
        ["price"] = math.random(40, 60)
    },
    ["chillypepper"] = {
        ["price"] = math.random(60, 90)
    },
    ["hotsauce"] = {
        ["price"] = math.random(100, 140)
    },
    ["tomato"] = {
        ["price"] = math.random(40, 60)
    },
    ["tomatopaste"] = {
        ["price"] = math.random(80, 110)
    },
    ["raw_bacon"] = {
        ["price"] = math.random(80, 120)
    },
    ["raw_sausage"] = {
        ["price"] = math.random(70, 100)
    },
    ["raw_pork"] = {
        ["price"] = math.random(90, 130)
    },
    ["raw_ham"] = {
        ["price"] = math.random(100, 140)
    },
    ["cooked_bacon"] = {
        ["price"] = math.random(120, 170)
    },
    ["cooked_sausage"] = {
        ["price"] = math.random(110, 150)
    },
    ["cooked_pork"] = {
        ["price"] = math.random(140, 190)
    },
    ["cooked_ham"] = {
        ["price"] = math.random(150, 200)
    },
    ["pig_leather"] = {
        ["price"] = math.random(80, 120)
    },
    ["cow_leather"] = {
        ["price"] = math.random(90, 130)
    }
    
}


-- Alert Notification
Config.Alerts = {
    ['cancel'] = 'İptal Edildi',
    ['weapon'] = 'Bunu yapmak için bıçak gerekli',
    ['itemamount'] = 'Miktar geçerli değil!',

    ['apple_pickingbar'] = 'Elma toplanıyor',
    ['apple_progressbar'] = 'Elma suyu yapılıyor',
	['apple_pickingfront'] = 'Başarıyla ',
    ['apple_pickingend'] = ' adet elma topladın',
    ['apple_processing'] = 'Şu anda ' ..Config.AppleProcessing.. ' adet elma işliyorsun',
    ['apple_trader'] = 'Başarıyla çiftçiden ' ..Config.AppleJuice.. ' adet elma suyu aldın',
    ['error_appleprocessor'] = 'Bunun için elma gerekmekte, topla da gel!',

    ['cow_milking'] = 'İnek sağılıyor...',
    ['emptybucket'] = 'Boş kovan yok!',
    ['killing_cow'] = 'İnek kesiliyor...',
    ['error_rawmeat'] = 'Bunun için çiğ et gerekmekte, inek kes de gel!!',
    ['cow_processbar'] = 'İnek eti pişiriliyor...',
    ['cow_processing'] = 'Başarıyla ' ..Config.BeefProcessing.. ' adet et pişirdin',
    ['cow_diaryprocessorbar'] = 'Süt Ticareti',
    ['milk_processing'] = 'Şu anda ' ..Config.MilkProcessing.. ' kova süt işliyorsun',
    ['milk_trader'] = 'Başarıyla ' ..Config.Milk.. ' adet süt aldın',
    ['error_milkprocessor'] = 'Bunun için süt kovasına ihtiyacın var, süt sağ da gel!',
    ['error_milklocation'] = 'Çiftliğe gidip süt sağabilirsin!',

    ['picking_pumpkins'] = 'Balkabağı toplanıyor...',
    ['pumpkin_processingbar'] = 'Kabaklar Parçalanıyor',
    ['pumpkin_processing'] = 'Başarıyla ' ..Config.PumpkinProcessing.. ' adet kabak parçaladın',
    ['pumpkin_trader'] = 'Başarıyla ' ..Config.PumpkinBoxes.. ' adet pasta aldın',
    ['error_pumpkinsmashing'] = 'Bunun için balkabağı gerekmekte, topla da gel!',

    ['corn_picking'] = 'Mısır Toplanıyor',
    ['corn_progressbar'] = 'Mısır İşleniyor',
    ['corn_processing'] = 'Senden ' ..Config.CornProcessing.. ' adet mısır silindi',
    ['corn_processed'] = 'Başarıyla ' ..Config.CornProcessed.. ' adet mısır işledin',
    ['error_corncob'] = 'Bunun için mısıra ihtiyacın var, topla da gel!',

    ['grape_picking'] = 'Üzüm Toplanıyor',
    ['grape_progressbar'] = 'Üzümler Süzülüyor',
    ['grape_processing'] = 'Başarıyla ' ..Config.GrapeProcessing.. ' adet üzüm süzüldü',
    ['grape_processed'] = 'Başarıyla ' ..Config.GrapeProcessed.. ' adet üzüm suyu yapıldı',
    ['error_grape'] = 'Bunun için üzüme ihtiyacın var, topla da gel!',

    ['greenpepper_picking'] = "Yeşil Biber Toplanıyor",

    ['chillypepper_picking'] = 'Acı Biber Toplanıyor',
    ['chilly_hotsauce'] = 'Acı Sos Yapılıyor',
    ['chilly_processing'] = 'Başarıyla ' ..Config.ChillyProcessing.. ' adet biber işlendi',
    ['chilly_processed'] = 'Başarıyla ' ..Config.ChillyProcessed.. ' adet acı sos yapıldı',
    ['error_chilly'] = 'Bunun için acı bibere ihtiyacın var, topla da gel!',

    ['tomatoes_picking'] = 'Domates Toplanıyor',
    ['tomatoes_progressbar'] = 'Domates İşleniyor',
    ['tomatoes_processing'] = 'Başarıyla' ..Config.TomatoesProcessing.. ' adet domates işledin',
    ['tomatoes_processed'] = 'Başarıyla ' ..Config.TomatoesProcessed.. ' adet domates pastası yaptın',
    ['error_tomatoes'] = 'Bunun için domatese ihtiyacın var, topla da gel!',


    ['bacon_progressbar'] = 'Pastırma Pişiriliyor',
    ['bacon_processing'] = 'Başarıyla ' ..Config.BaconProcessed.. ' adet pastırma pişirildi',
    ['error_bacon'] = 'Bunun için pastırmaya ihtiyacın var, domuz kes de gel!',

    ['ham_progressbar'] = 'Jambon Pişiriliyor',
    ['ham_processing'] = 'Başarıyla ' ..Config.HamProcessed.. ' adet jambon pişirdin',
    ['error_ham'] = 'Bunun için jambona ihtiyacın var!',

    ['pork_progressbar'] = 'Domuz Eti Pişiriliyor',
    ['pork_cooking'] = 'Başarıyla ' ..Config.PorkProcessed.. ' domuz eti pişirdin',
    ['error_pork'] = 'Bunun için domuz etine ihtiyacın var, domuz kes de gel!',

    ['sausage_progressbar'] = 'Sosis Pişiriliyor',
    ['sausage_processing'] = 'Başarıyla ' ..Config.SausageProcessed.. ' adet sosis pişirdin',
    ['error_sausage'] = 'Bunun için sosise ihtiyacın var!',

    ['killing_pig'] = 'Domuz Kesiliyor',
    ['pig_reward'] = 'Domuz etlerini topladın.',
}
