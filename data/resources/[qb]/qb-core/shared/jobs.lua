QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true -- true: Force duty state to jobdefaultDuty | false: set duty state from database last saved
QBShared.Jobs = {
	['unemployed'] = {
		label = 'Civilian',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'İşsiz',
                payment = 500
            },
        },
	},
	['police'] = {
		label = 'Police Departmant',
        type = "leo",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Stajyer',
                payment = 500
            },
			['1'] = {
                name = 'Memur I',
                payment = 800
            },
			['2'] = {
                name = 'Memur II',
                payment = 1000
            },
			['3'] = {
                name = 'Memur III',
                payment = 1200
            },
			['4'] = {
                name = 'Memur III+1',
                payment = 1400
            },
        	['5'] = {
                name = 'Çavuş I',
                payment = 1600
            },
		    ['6'] = {
                name = 'Çavuş II',
                payment = 1800
            },
			['7'] = {
                name = 'Teğmen I-II',
                payment = 2000
            },
			['8'] = {
                name = 'Yüzbaşı I-II-III',
                payment = 2500
            },
			['9'] = {
                name = 'Polis Şefi Asistanı',
                payment = 3000
            },
			['11'] = {
                name = 'Polis Şefi Yardımcısı',
                payment = 3500
            },
			['12'] = {
                name = 'Polis Şefi',
				isboss = true,
                payment = 5000
            },
		},
	},
	['sheriff'] = {
		label = 'Sheriff',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 500
            },
			['1'] = {
                name = 'Deputy I',
                payment = 700
            },
            ['2'] = {
                name = 'Deputy II',
                payment = 900
            },
            ['3'] = {
                name = 'Deputy III',
                payment = 1100
            },
            ['4'] = {
                name = 'Investigator',
                payment = 1300
            },
			['5'] = {
                name = 'master investigator',
                payment = 1500
            },
			['6'] = {
                name = 'Sergant',
                payment = 1700
            },
			['7'] = {
                name = 'lieuitenant',
                payment = 2000
            },
            ['8'] = {
                name = 'captain',
                payment = 2300
            },
            ['9'] = {
                name = 'chief deputy',
                payment = 2600
            },
            ['10'] = {
                name = 'assistant sheriff',
                payment = 2900
            },
            ['11'] = {
                name = 'undersheriff',
				isboss = true,
                payment = 3200
            },
            ['12'] = {
                name = 'Sheriff',
				isboss = true,
                payment = 3500
            },
        },
	},
		['sasp'] = {
		label = 'Sasp',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 500
            },
			['1'] = {
                name = 'Deputy I',
                payment = 700
            },
            ['2'] = {
                name = 'Deputy II',
                payment = 900
            },
            ['3'] = {
                name = 'Deputy III',
                payment = 1100
            },
            ['4'] = {
                name = 'Investigator',
                payment = 1300
            },
			['5'] = {
                name = 'master investigator',
                payment = 1500
            },
			['6'] = {
                name = 'Sergant',
                payment = 1700
            },
			['7'] = {
                name = 'lieuitenant',
                payment = 2000
            },
            ['8'] = {
                name = 'captain',
                payment = 2300
            },
            ['9'] = {
                name = 'chief deputy',
                payment = 2600
            },
            ['10'] = {
                name = 'assistant sheriff',
                payment = 2900
            },
            ['11'] = {
                name = 'undersheriff',
				isboss = true,
                payment = 3200
            },
            ['12'] = {
                name = 'Sheriff',
				isboss = true,
                payment = 3500
            },
        },
	},
		['fbi'] = {
		label = 'FBİ',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Recruit',
                payment = 500
            },
			['1'] = {
                name = 'Deputy I',
                payment = 700
            },
            ['2'] = {
                name = 'Deputy II',
                payment = 900
            },
            ['3'] = {
                name = 'Deputy III',
                payment = 1100
            },
            ['4'] = {
                name = 'Investigator',
                payment = 1300
            },
			['5'] = {
                name = 'master investigator',
                payment = 1500
            },
			['6'] = {
                name = 'Sergant',
                payment = 1700
            },
			['7'] = {
                name = 'lieuitenant',
                payment = 2000
            },
            ['8'] = {
                name = 'captain',
                payment = 2300
            },
            ['9'] = {
                name = 'chief deputy',
                payment = 2600
            },
            ['10'] = {
                name = 'assistant sheriff',
                payment = 2900
            },
            ['11'] = {
                name = 'undersheriff',
				isboss = true,
                payment = 3200
            },
            ['12'] = {
                name = 'Sheriff',
				isboss = true,
                payment = 3500
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Stajyer',
                payment = 500
            },
			['1'] = {
                name = 'Sağlık görevlisi',
                payment = 1000
            },
			['2'] = {
                name = 'Doktor',
                payment = 1500
            },
			['3'] = {
                name = 'Cerrah',
                payment = 2000
            },
			['4'] = {
                name = 'Baş Hekim',
				isboss = true,
                payment = 3000
            },
        },
	},
	['realestate'] = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Çırak',
                payment = 400
            },
			['1'] = {
                name = 'Ev satıcısı',
                payment = 800
            },
			['2'] = {
                name = 'Ev yöneticisi',
                payment = 1200
            },
			['3'] = {
                name = 'Müdür',
                payment = 1600
            },
			['4'] = {
                name = 'Yönetici',
				isboss = true,
                payment = 2000
            },
        },
	},
	['taxi'] = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Çaycı',
                payment = 300
            },
			['1'] = {
                name = 'Şöför',
                payment = 600
            },
			['2'] = {
                name = 'Usta şöför',
                payment = 900
            },
			['3'] = {
                name = 'Durak sorumlusu',
                payment = 1200
            },
			['4'] = {
                name = 'Yönetici',
				isboss = true,
                payment = 1500
            },
        },
	},
     ['bus'] = {
		label = 'Otobüs Şöförü',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sürücü',
                payment = 400
            },
		},
	},
	['cardealer'] = {
		label = 'Galeri',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Stajyer',
                payment = 400
            },
			['1'] = {
                name = 'Araç Sorumlusu',
                payment = 800
            },
			['2'] = {
                name = 'Müdür Yardımcısı',
                payment = 1200
            },
			['3'] = {
                name = 'Müdür',
                payment = 1600
            },
			['4'] = {
                name = 'Yönetici',
				isboss = true,
                payment = 2000
            },
        },
	},
	['mechanic'] = {
		label = 'Mechanic',
        type = "mechanic",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Stajyer',
                payment = 400
            },
			['1'] = {
                name = 'Çırak',
                payment = 800
            },
			['2'] = {
                name = 'Kalfa',
                payment = 1200
            },
			['3'] = {
                name = 'Usta',
                payment = 1600
            },
			['4'] = {
                name = 'Yönetici',
				isboss = true,
                payment = 2000
            },
        },
	},
	['judge'] = {
		label = 'Honorary',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Judge',
                payment = 100
            },
        },
	},
	['lawyer'] = {
		label = 'Avukat Bürosu',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Avukat',
                payment = 50
            },
        },
	},
	['reporter'] = {
		label = 'Haber Ajansı',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Gazeteci',
                payment = 50
            },
        },
	},
	['trucker'] = {
		label = 'Kargocu',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sürücü',
                payment = 50
            },
        },
	},
	['tow'] = {
		label = 'Çekici',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sürücü',
                payment = 50
            },
        },
	},
	['garbage'] = {
		label = 'Çöpçü',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'İşçi',
                payment = 50
            },
        },
	},
	['vineyard'] = {
		label = 'Üzüm Çalışanı',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Toplayıcı',
                payment = 50
            },
        },
	},
	['hotdog'] = {
		label = 'Hotdog',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 50
            },
        },
	},
    ['lumberjack'] = {
		label = 'Oduncu',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Sales',
                payment = 50
            },
        },
	},
    ['mekanik1'] = {
		label = 'Mekanik',
        type = "mekanik",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Çalışan',
                payment = 400
            },
			['2'] = {
                name = 'Patron',
                payment = 800
            },
        },
	},
    ['mekanik2'] = {
		label = 'Mekanik',
        type = "mekanik",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Çalışan',
                payment = 400
            },
			['2'] = {
                name = 'Patron',
                payment = 800
            },
        },
	},
    ['mekanik3'] = {
		label = 'Mekanik',
        type = "mekanik",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Çalışan',
                payment = 400
            },
			['2'] = {
                name = 'Patron',
                payment = 800
            },
        },
	},
    ['mekanik4'] = {
		label = 'Mekanik',
        type = "mekanik",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Çalışan',
                payment = 400
            },
			['2'] = {
                name = 'Patron',
                payment = 800
            },
        },
	},
    ['mekanik5'] = {
		label = 'Mekanik',
        type = "mekanik",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Çalışan',
                payment = 400
            },
			['2'] = {
                name = 'Patron',
                payment = 800
            },
        },
	},
    ['mekanik6'] = {
		label = 'Mekanik',
        type = "mekanik",
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['1'] = {
                name = 'Çalışan',
                payment = 400
            },
			['2'] = {
                name = 'Patron',
                payment = 800
            },
        },
	},
}
