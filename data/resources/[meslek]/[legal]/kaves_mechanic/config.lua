Config = {}

Config.Framework = "qbcore" -- esx or qbcore

Config.Settings = {
    driftMode = {
        keyCode = 21, -- drift key
    },
    performanceMode = {
        torqValue = 16.0, -- torque multiplier of the vehicle in performance mode
        engineValue = 16.0, -- engine power multiplier of the vehicle in performance mode
    },
    nitro = {
        multiplier = 1.10, -- propulsion coefficient when using nitro (don't increase it too much)
        time = 3000, -- how many seconds it will take when using nitro
        cooldown = 30000, -- cooldown for next nitro use
        keyCode = 38, -- nitro key
    },
    popcornExhaust = {
        openKeyCode = 74, -- popcorn key
    },
}

Config.Menus = {
    upgrades = {
        brakes = {
            basePrice = 1500,
            increaseby = 300,
        },
        transmission = {
            basePrice = 1500,
            increaseby = 300,
        },
        suspension = {
            basePrice = 1500,
            increaseby = 300,
        },
        engine = {
            basePrice = 2000,
            increaseby = 400,
        },
        turbo = 3000,
    },
    customization = {
        spoiler = {
            basePrice = 800,
            increaseby = 150,
        },
        skirts = {
            basePrice = 500,
            increaseby = 80,
        },
        exhausts = {
            basePrice = 700,
            increaseby = 120,
        },
        grille = {
            basePrice = 500,
            increaseby = 100,
        },
        hood = {
            basePrice = 1200,
            increaseby = 200,
        },
        fenders = {
            basePrice = 800,
            increaseby = 150,
        },
        roof = {
            basePrice = 700,
            increaseby = 150,
        },
        horn = {
            basePrice = 300,
            increaseby = 0,
        },
        engine_block = {
            basePrice = 3000,
            increaseby = 800,
        },
        air_filters = {
            basePrice = 2000,
            increaseby = 600,
        },
        struts = {
            basePrice = 1500,
            increaseby = 200,
        },
        license_plate = {
            basePrice = 300,
            increaseby = 0,
        },
        plate_holders = {
            basePrice = 300,
            increaseby = 0,
        },
        vanity_plates = {
            basePrice = 500,
            increaseby = 150,
        },
        headlights = {
            basePrice = 800,
            increaseby = 0,
        },
        front_bumper = {
            basePrice = 800,
            increaseby = 150,
        },
        rear_bumper = {
            basePrice = 800,
            increaseby = 150,
        },
        arch_cover = {
            basePrice = 500,
            increaseby = 150,
        },
        aerials = {
            basePrice = 300,
            increaseby = 100,
        },
        trim = {
            basePrice = 500,
            increaseby = 150,
        },
        tank = {
            basePrice = 400,
            increaseby = 150,
        },
        windows = {
            basePrice = 250,
            increaseby = 150,
        },
        frame = {
            basePrice = 700,
            increaseby = 150,
        },
    },
    cosmetic = {
        headlight_color = {
            basePrice = 200,
            increaseby = 0,
        },
        livery = {
            basePrice = 400,
            increaseby = 0,
        },
        neon = {
            basePrice = 200,
            increaseby = 0,
        },
        window_tint = {
            basePrice = 80,
            increaseby = 40,
        },
        tire_smoke = {
            basePrice = 200,
            increaseby = 0,
        },
        trim_design = {
            basePrice = 400,
            increaseby = 100,
        },
        ornaments = {
            basePrice = 400,
            increaseby = 0,
        },
        dashboard = {
            basePrice = 400,
            increaseby = 80,
        },
        dial_design = {
            basePrice = 400,
            increaseby = 80,
        },
        door_speaker = {
            basePrice = 200,
            increaseby = 0,
        },
        seats = {
            basePrice = 200,
            increaseby = 100,
        },
        steering_wheels = {
            basePrice = 400,
            increaseby = 150,
        },
        shifter_leavers = {
            basePrice = 400,
            increaseby = 150,
        },
        plaques = {
            basePrice = 500,
            increaseby = 150,
        },
        speakers = {
            basePrice = 400,
            increaseby = 150,
        },
        trunk = {
            basePrice = 400,
            increaseby = 150,
        },
        wheels = {
            basePrice = 2000,
            increaseby = 0
        },
    },
    fitment = {
        price = 4000,
    },
    tuning = {
        vehicle_traction = 5000,
        tuner_chip = 12000,
        nitro = 8000,
        popcorn = 8000,
    },
    paintBooth = {
        color = 400, 
        pearlescent = 400, 
        chrome = 600, 
        chameleon = 1500, 
        neon = 200, 
        smoke = 200, 
        wheel = 200,
    },
    extras = {
        price = 200
    }
}

Config.Locations = {
    ["Satılık İllegal Mechanic"] = {
        illegalMechanic = true,
        enableSociety = false,
        job = "mechanic",
        coords = {
            vector3(-655.18, -2401.98, 13.96)
        },
        showBlip = false, -- Blip kapatıldı (harita bug'ı düzeltildi)
        blipSprite = 446,
        blipColor = 4,
        blipCoords = vector3(-655.18, -2401.98, 13.96),
        bossMenu = vector3(-644.34, -2413.02, 14.21),
    }
}

Config.ExtraMenuLocations = {
    ["LSPD"] = {
        job = "police",
        coords = {
            vector3(455.23, -1020.47, 27.95)
        },
    } 
}

Config.Locale = {
    ["open_mechanic_menu"] = "~INPUT_CONTEXT~ Mechanic Menu",
    ["open_extra_menu"] = "~INPUT_CONTEXT~ Extra Menu",
    ["dont_have_money"] = "You don't have enough money",
    ["popcorn_exhaust"] = "Exhaust status: %s"
}