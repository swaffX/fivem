--[[
    ['Innocence'] = {
    settings = {
        label = 'Bennys Motorworks', -- Text label for anything that wants it
        welcomeLabel = "Welcome to Benny's Motorworks!", -- Welcome label in the UI
        enabled = true, -- If the location can be used at all
    },
    blip = {
        label = 'Bennys Motorworks',
        coords = vector3(-205.6992, -1312.7377, 31.1588),
        sprite = 72,
        scale = 0.65,
        color = 0,
        display = 4,
        enabled = true,
    },
    categories = { -- Only include the categories you want. A category not listed defaults to FALSE.
        mods = true, -- Performance Mods
        repair = true,
        armor = true,
        respray = true,
        liveries = true,
        wheels = true,
        tint = true,
        plate = true,
        extras = true,
        neons = true,
        xenons = true,
        horn = true,
        turbo = true,
        cosmetics = true, -- Cosmetic Mods
    },
    drawtextui = {
        text = "Bennys Motorworks",
    },
    restrictions = { -- A person must pass ALL the restriction checks. Remove an item below to automatically pass that check.
        job = "any", -- Allowed job. Can be an array of strings for multiple jobs. Any for all jobs
        gang = "any", -- Allowed gang. Can be an array of strings for multiple gangs. Any for all gangs
        allowedClasses = {}, -- Array of allowed classes. Empty will allow any but denied classes.
        deniedClasses = {}, -- Array of denied classes.
    },
    zones = {
        { coords = vector3(-212.55, -1320.56, 31.0), length = 6.0, width = 4.0, heading = 270.0, minZ = 29.88, maxZ = 33.48 },
        { coords = vector3(-222.47, -1329.73, 31.0), length = 6.0, width = 4.4, heading = 270.0, minZ = 29.88, maxZ = 33.48 },
    }
},

Vehicle Classes:
0: Compacts     1: Sedans       2: SUVs         3: Coupes       4: Muscle       5: Sports Classics
6: Sports       7: Super        8: Motorcycles  9: Off-road     10: Industrial  11: Utility
12: Vans        13: Cycles      14: Boats       15: Helicopters 16: Planes      17: Service
18: Emergency   19: Military    20: Commercial  21: Trains
 ]]

Config = Config or {}

Config.Locations = {
    ['Innocence'] = {
        settings = {
            label = 'Bennys Motorworks',
            welcomeLabel = "Welcome to Benny's Motorworks!",
            enabled = true,
        },
        categories = {
            mods = true,
            turbo = true,
            repair = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "Bennys Motorworks"
        },
    restrictions = { 
        job = "mechanic", 
        gang = "any", 
        allowedClasses = {}, 
        deniedClasses = {}, 
    },
        zones = {
            { coords = vector3(-34.09, -1052.35, 28.4), length = 6.0, width = 4.0, heading = 90.226478, minZ = 20.88, maxZ = 33.48 },
			{ coords = vector3(-31.89, -1067.12, 28.4), length = 6.0, width = 4.0, heading = 90.226478, minZ = 20.88, maxZ = 33.48 },
        }
    },

    ['Power'] = {
        settings = {
            label = 'Bennys Motorworks',
            welcomeLabel = "Welcome to Benny's Motorworks!",
            enabled = true,
        },
        categories = {
            mods = true,
            turbo = true,
            repair = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "Bennys Motorworks"
        },
    restrictions = { 
        job = "mechanic", 
        gang = "any", 
        allowedClasses = {}, 
        deniedClasses = {}, 
    },
        zones = {
            { coords = vector3(-210.07, -1323.22, 30.89), length = 6.0, width = 4.0, heading = 162.74078, minZ = 27.0, maxZ = 34.0 },
			{ coords = vector3(-223.75, -1328.95, 30.89), length = 6.0, width = 4.0, heading = 162.74078, minZ = 27.0, maxZ = 34.0 },
        }
    },

    ['Popular'] = {
        settings = {
            label = 'Customs Motorworks',
            welcomeLabel = "Welcome to Customs Motorworks!",
            enabled = true,
        },
        categories = {
            mods = true,
            turbo = true,
            repair = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "Customs Motorworks"
        },
       restrictions = { 
        job = "mechanic", 
        gang = "any", 
        allowedClasses = {}, 
        deniedClasses = {}, 
    },
        zones = {
            { coords = vector3(-582.57, -931.8, 23.89), length = 6.0, width = 4.0, heading = 210.91831, minZ = 30.0, maxZ = 38.0 },
        }
    },

    ['Harmony'] = {
        settings = {
            label = 'Harmony Motorworks',
            welcomeLabel = "Welcome to Harmony Motorworks!",
            enabled = true,
        },
        categories = {
            mods = true,
            turbo = true,
            repair = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "Harmony Motorworks"
        },
       restrictions = { 
        job = "mechanic", 
        gang = "any", 
        allowedClasses = {}, 
        deniedClasses = {}, 
    },
        zones = {
            { coords = vector3(-321.15, -128.78, 39.02), length = 6.0, width = 4.0, heading = 69.504318, minZ = 36.0, maxZ = 40.0 },
			{ coords = vector3(-323.14, -134.01, 39.02), length = 6.0, width = 4.0, heading = 69.504318, minZ = 36.0, maxZ = 40.0 },
			{ coords = vector3(-325.5, -139.17, 39.02), length = 6.0, width = 4.0, heading = 69.504318, minZ = 36.0, maxZ = 40.0 },
			{ coords = vector3(-326.64, -144.24, 39.02), length = 6.0, width = 4.0, heading = 69.504318, minZ = 36.0, maxZ = 40.0 },
        }
    },

    ['Hayes'] = {
        settings = {
            label = 'Hayes Motorworks',
            welcomeLabel = "Welcome to Hayes Motorworks!",
            enabled = true,
        },
        categories = {
            repair = true,
            turbo = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "Hayes Motorworks"
        },
        restrictions = { 
        job = "mechanic", 
        gang = "any", 
        allowedClasses = {}, 
        deniedClasses = {}, 
    },
        zones = {
            { coords = vector3(167.34, -1686.31, 29.78), length = 6.0, width = 4.0, heading = 228.61129, minZ = 25.0, maxZ = 34.0 },
			{ coords = vector3(170.33, -1682.36, 29.78), length = 6.0, width = 4.0, heading = 228.61129, minZ = 25.0, maxZ = 34.0 },
			{ coords = vector3(164.09, -1689.85, 29.78), length = 6.0, width = 4.0, heading = 228.61129, minZ = 25.0, maxZ = 34.0 },
        }
    },

    ['Paleto'] = {
        settings = {
            label = 'Billys Motorworks',
            welcomeLabel = "Welcome to Billys Motorworks!",
            enabled = true,
        },
        categories = {
            mods = true,
            turbo = true,
            repair = true,
            respray = true,
            liveries = true,
            wheels = true,
            tint = true,
            plate = true,
            extras = true,
            neons = true,
            xenons = true,
            horn = true,
            cosmetics = true,
        },
        drawtextui = {
            text = "Billys Motorworks"
        },
       restrictions = { 
        job = "mechanic", 
        gang = "any", 
        allowedClasses = {}, 
        deniedClasses = {}, 
    },
        zones = {
            { coords = vector3(-674.91, -2386.46, 13.83), length = 6.0, width = 4.0, heading = 179.5278, minZ = 3.5, maxZ = 10.5 },
        }
    },

}