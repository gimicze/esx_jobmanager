Config = {}

Config.DrawDistance = 20.0

Config.MarkerType = {
	Armory = 21,
	BossMenu = 29,
	Duty = 23,
	Stock = 20,
	VehicleMenu = 20,
	VehicleSpawner = 27
}

Config.MarkerSize = { x = 1.5, y = 1.5, z = 1.5 }
Config.MarkerColor = { r = 50, g = 50, b = 204 }

Config.Notification = {
	layout = "bottomCenter",
	timeout = 3000
}

Config.Menu = {
	layout = "top-left"
}

Config.Discord = {
	colorGreen = 0xa5ff4a,
	colorRed = 0xff2d2d
}

Config.Permissions = {
	default = {
		bossMenu = {
			withdraw  = true,
			deposit   = true,
			wash      = false,
			employees = true,
			grades    = true,
			billing   = true
		}
	}
}

Config.vStancer = true -- Enable vStancer ?

Config.Locale = 'cs'

Config.TowVehicles = {
	flatbed = {
		towOffset = vector3(-0.5, -5.5, 1.0), -- The offset to which the vehicle will be attached to
		unloadOffset = vector3(-0.5, -12.5, 0.0), -- The offset which will be used to calculate the unload coordinates
		loadOffset = vector3(-0.5, -12.5, 0.3) -- The loading zone offset relative to the vehicle
	},

	tow = {
		towOffset = vector3(0.0, -2.8, 0.7),
		unloadOffset = vector3(0.0, -12.5, 0.0),
		loadOffset = vector3(0.0, -12.5, 0.3)
	}
}

Config.Jobs = {
	pizza = {
		Settings = {
			Blips = {
				Pizza = {
					enabled = false,
					pos = {x = 442.09, y = 146.18, z = 99.9},
					sprite = 93,
					display = 4,
					scale = 0.8,
					colour = 38
				}
			},
			name = "Guido's Pizza",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(442.09, 146.18, 99.9) -- Add more vector3()s to add the menu to different locations
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(447.25, 148.20, 99.21) -- Add more vector3()s to add the menu to different locations
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			canBuy = {
				{item = "male_jidlo", label = "Malé jídlo", price = 100},
				{item = "stredni_jidlo", label = "Střední jídlo", price = 200},
				{item = "velke_jidlo", label = "Velké jídlo", price = 400}
			},
			vector3(448.18, 143.92, 100.20) -- Add more vector3()s to add the menu to different locations
		},

		PhoneContact = {
			enabled = true
		},

		Webhooks = {
			duty = 'https://discordapp.com/api/webhooks/739229588525285418/lL8BDZk72UvFwqIIksaGoRssRfYLywhFy8tRM-5PKYwhtUcjyplmlFg50uN1mdqJvx89',
			billing = 'https://discordapp.com/api/webhooks/741037239768711199/3ZHmmZirxzF9TEWlDOMR52rqU4m6w-PAHdk_VJE4avpYvyxgM0V38dEqp5zTDaF2lMu5'
		}
	},

	mosley = {
		Settings = {
			Blips = {
				Mosley = {
					enabled = false,
					pos = {x = -26.37, y = -1660.66, z = 29.48},
					sprite = 147,
					display = 4,
					scale = 0.8,
					colour = 71
				}
			},
			name = "Mosley's Car Service",
			mechanicMenu = true,
			gradePermissions = {
				majitel = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-33.84, -1669.44, 29.48),
			vector3(-15.6, -1658.51, 33.04)			-- Add more vector3()s to add the menu to different locations
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(-9.69, -1658.66, 29.48) -- Add more vector3()s to add the menu to different locations
		},
		
		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(-36.68, -1671.55, 28.49) -- Add more vector3()s to add the menu to different locations
		},

		VehicleMenu = {
			enabled = true,
			text = "[E] " .. _U("vehicle_display"),
			menu = {
				vector3(-24.62, -1657.69, 29.48)
			},
			displayPoints = {
				vector4(-21.98, -1643.18, 29.48, 181.93),
				vector4(-19.17, -1645.37, 29.48, 148.41),
				vector4(-24.44, -1645.76, 29.48, 233.19)
			},
			canBuy = {
				bmwe = 120000,
				['350z'] = 190000,
				nis13 = 180000
			}
		},

		Webhooks = {
			duty = 'https://discordapp.com/api/webhooks/740944334580613150/70ADipsKJcc5fCsmNxlzkGY2bMrHXxekfIzCqapTb9is0-Ah_tpPY68MafH1nO3Vdk5C',
			billing = 'https://discordapp.com/api/webhooks/741039046888914945/lnp2BDTlw8ftm-y432GQaeVsyz5rPg3nYPN1QfKooEeNkXNroLg0NeydXVaKm6OUm7JA',
			vehiclePurchase = 'https://discordapp.com/api/webhooks/739853895991427124/TvYfU9t57WZYdhy8VrSnzmrAcf4fx7VsZB9YWAf3jISbm5C8Vl5_h7hVufC6Iz5lSYTD'
		}
	},

	casey = {
		Settings = {
			Blips = {
				Casey = {
					enabled = false,
					pos = {x = 799.72, y = -740.29, z = 27.01},
					sprite = 93,
					display = 4,
					scale = 0.8,
					colour = 71
				}
			},
			name = "Casey's Diner",
			gradePermissions = {
				reditel = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(799.72, -740.29, 28.01) -- Add more vector3()s to add the menu to different locations
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(797.46, -729.35, 27.01) -- Add more vector3()s to add the menu to different locations
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			canBuy = {
				{item = "male_jidlo", label = "Malé jídlo", price = 100},
				{item = "stredni_jidlo", label = "Střední jídlo", price = 200},
				{item = "velke_jidlo", label = "Velké jídlo", price = 400}
			},
			vector3(801.72, -733.77, 28.01) -- Add more vector3()s to add the menu to different locations
		},

		PhoneContact = {
			enabled = true
		},

		Webhooks = {
			duty = 'https://discordapp.com/api/webhooks/740928059783381044/UwUv4TXBOr9AeBi-3VCP421fhWVfVBaSYXUA7OWzKZ-dyzX5jkB4Diyc_tZMRutqgfeI',
			billing = 'https://discordapp.com/api/webhooks/741037616979509308/ZfFEvlPeWHBaW07Lw0vfWOa4RdkdiRlNGtDgXMSUHOgvyhutmHw_4gpZ9jNN9KKikBX_'
		}
	},

	drusillas = {
		Settings = {
			Blips = {
				Restaurant = {
					enabled = true,
					pos = {x = 287.89, y = -976.74, z = 29.87},
					sprite = 93,
					display = 4,
					scale = 0.8,
					colour = 64
				}
			},
			name = "Drusilla's",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(279.42, -979.40, 29.86)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(284.21, -979.68, 28.89)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			canBuy = {
				{item = "male_jidlo", label = "Malé jídlo", price = 100},
				{item = "stredni_jidlo", label = "Střední jídlo", price = 200},
				{item = "velke_jidlo", label = "Velké jídlo", price = 400}
			},
			vector3(277.41, -977.02, 29.87)
		},
		
		PhoneContact = {
			enabled = true
		},

		Webhooks = {
			duty = 'https://discordapp.com/api/webhooks/743760628942110820/n-ef35OW6DTnl8GC5tHzr0xlF8-_lmqWke4v-0DpA7GuekUX7D9skbQRHjQv3IJaT9BP',
			billing = 'https://discordapp.com/api/webhooks/743760254336106526/SCMYyHkjdD6h7mfUcB8kmzZuwl1AyckdMio1jo4aWz0Tk3dLGJD-Rc9PfVS84eddHMxo',
			money = 'https://discordapp.com/api/webhooks/743760254336106526/SCMYyHkjdD6h7mfUcB8kmzZuwl1AyckdMio1jo4aWz0Tk3dLGJD-Rc9PfVS84eddHMxo'
		}
	},

	core = {
		Settings = {
			Blips = {
				Service = {
					enabled = true,
					pos = vector3(946.06, -986.69, 39.41),
					sprite = 89,
					display = 4,
					scale = 0.8,
					colour = 38,
					name = "CORE Automotive"
				},
				Service2 = {
					enabled = true,
					pos = vector3(-358.66, -134.94, 39.01),
					sprite = 446,
					display = 4,
					scale = 0.8,
					colour = 38,
					name = "Los Santos Customs"
				}
			},
			name = "CORE Automotive",
			mechanicMenu = true,
			gradePermissions = {
				boss = {
					bossMenu = true
				},
				manazer = {
					bossMenu = {
						withdraw  = true,
						deposit   = true,
						wash      = false,
						employees = true,
						grades    = false,
						billing   = true
					}
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(951.30, -968.41, 39.51)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(952.11, -963.75, 38.51),
			vector3(-347.14, -133.45, 38.03)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(947.39, -970.45, 39.50),
			vector3(-321.56, -138.18, 39.01)
		},
		
		PhoneContact = {
			enabled = true
		},

		Webhooks = {
			duty = 'https://discordapp.com/api/webhooks/706136495832170568/J6p8Z02tzOIGGPNWyq25jPq5TEGPg_cJzIwApyfYPEf-13zzWB4VuiZb0543vIqjBnU6',
			billing = 'https://discordapp.com/api/webhooks/706140203781455902/YOc5TXhi2A_0enSx4g2CVnLeB2v3BrwfALLQUzRiTbywQImxvD-622cDG2sQanaRx7a5',
			money = 'https://discordapp.com/api/webhooks/741860781481525258/h42jxaAY4qH5ma0eLZ2thyuVISIXhKA2l-5BTOuG2P1FW7wYQIta5B9dOqkngGr_xg4E'
		}
	},

	desantos = {
		Settings = {
			Blips = {
				club = {
					enabled = false,
					pos = vector3(-1817.10, -1193.75, 14.31),
					sprite = 93,
					display = 4,
					scale = 0.8,
					colour = 38,
					name = "Pearls & Captain Jack"
				}
			},
			interactionsMenu = true,
			name = "De Santos",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-1832.35, -1197.40, 19.42)
		},

		Duty = {
			enabled = false,
			text = "[E] " .. _U("duty"),
			vector3(-1845.79, -1188.58, 13.32)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			canBuy = {
				{item = "male_jidlo", label = "Malé jídlo", price = 100},
				{item = "stredni_jidlo", label = "Střední jídlo", price = 200},
				{item = "velke_jidlo", label = "Velké jídlo", price = 400}
			},
			vector3(-1833.30, -1193.62, 19.19),
			vector3(-1841.27, -1190.36, 14.31),
			vector3(1087.51, -3199.09, -38.99)
		},
		
		Armory = {
			enabled = false,
			text = "[E] " .. _U("armory"),
			vector3(908.22, -3211.53, -98.22)
		},

		PhoneContact = {
			enabled = true
		}

	},

	cherenkov = {
		Settings = {
			Blips = {
				Service = {
					enabled = true,
					pos = vector3(723.51, -1088.58, 22.22),
					sprite = 446,
					display = 4,
					scale = 0.8,
					colour = 1
				}
			},
			mechanicMenu = {
				canRepairVehicles = true,
				canCleanVehicles = true,
				canUnlockVehicles = true,
				canRemoveVehicles = true,
				canLoadVehicle = true,
				vStancer = false
			},
			name = "Cherenkov's Service",
			gradePermissions = {
				majitel = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(725.91, -1071.38, 28.31)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(726.19, -1084.84, 21.18)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(724.65, -1072.15, 23.13)
		},

		PhoneContact = {
			enabled = true
		}
	},

	diamond = {
		Settings = {
			Blips = {
				Restaurant = {
					enabled = true,
					pos = vector3(118.11, -1039.34, 29.27),
					sprite = 617,
					display = 4,
					scale = 0.8,
					colour = 27
				}
			},
			name = "Diamond Restaurant",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(141.15, -1061.99, 22.95)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(114.91, -1041.13, 28.27)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			canBuy = {
				{item = "male_jidlo", label = "Malé jídlo", price = 100},
				{item = "stredni_jidlo", label = "Střední jídlo", price = 200},
				{item = "velke_jidlo", label = "Velké jídlo", price = 400}
			},
			vector3(137.26, -1061.53, 22.96)
		},
		
		PhoneContact = {
			enabled = true
		},

		Webhooks = {
			duty = "https://discordapp.com/api/webhooks/750333531372388352/JlrGV5VNzcG6Z1ASo5NsBx06OB9lBlPyLIxr25Gt_MBL761k5yM141kDXDwxkGD-GVsk",
			billing = "https://discordapp.com/api/webhooks/750333269731442710/NFtq9US3mm51BuIPhf22h-z6-DNy9Ah4YydO-fbQTfUEsH0QUwhATt4HFhZ2TI_vnQZO",
			money = "https://discordapp.com/api/webhooks/750333714646564864/4dbq9BD0nt5wI6qhuZT5bfn-ldhLWYNiueceze8gvJFA3jfwek9rm_UFaMn4WbKSqjUe"
		}
	},
	
	hell = {
		Settings = {
			Blips = {
				Restaurant = {
					enabled = false,
					pos = vector3(44.51, -1004.45, 29.29),
					sprite = 93,
					display = 4,
					scale = 0.8,
					colour = 49
				}
			},
			name = "Hell Fast Food",
			gradePermissions = {
				majitel = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(40.41, -1004.81, 29.29)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(39.38, -1002.85, 28.50)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			canBuy = {
				{item = "male_jidlo", label = "Malé jídlo", price = 100},
				{item = "stredni_jidlo", label = "Střední jídlo", price = 200},
				{item = "velke_jidlo", label = "Velké jídlo", price = 400}
			},
			vector3(43.69, -1008.1, 29.29)
		},

		PhoneContact = {
			enabled = true
		},
		Webhooks = {
			duty = "https://discordapp.com/api/webhooks/751104643454599278/8WkDHgSYFhOM7HspOWBcPs1Pcij0yXHi58jwRgdPcGklQX14UvnVk7M4tGHQdU5xSH5O",
			billing = "https://discordapp.com/api/webhooks/751104817958486077/C4RSGAU2pyWlOEcA_KmPlaGYueAK_jhhU5ZCKt5JP23aFQ2lg79L-C-uRr4q_W92GgfU",
		}
	},
	
	royal = {
		Settings = {
			Blips = {
				Yacht = {
					enabled = true,
					pos = vector3(-2063.41, -1025.04, 11.91),
					sprite = 455,
					display = 4,
					scale = 0.99,
					colour = 46,
					name = "Royal Club"
				},
				dock = {
					enabled = true,
					pos = vector3(-1718.88, -1010.58, 5.45),
					sprite = 356,
					display = 4,
					scale = 0.8,
					colour = 46,
					name = "Royal Club - nastupiste"
				},
			},
			interactionsMenu = true,
			name = "London Royal Famillies",
			gradePermissions = {
				boss = {
					bossMenu = true
				},
				lieutenant = {
					bossMenu = {
						withdraw  = false,
						deposit   = true,
						wash      = false,
						employees = true,
						grades    = true,
						billing   = true
					}
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(289.22, -987.05, -92.79)
		},

		Duty = {
			enabled = false,
			text = "[E] " .. _U("duty"),
			vector3(287.57, -993.2, -93.70),
			vector3(16.03, -1113.20, 28.81) -- Ammunition
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(1016.97, -3199.26, -38.99),
			vector3(-1091.56, 346.75, -46.69),
			vector3(-2061.25, -1020.10, 11.90),
			vector3(14.28, -1105.92, 29.81) -- Ammunition
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			canBuy = {
				{item = "WEAPON_COMBATPISTOL", price = 5000},
				{item = "WEAPON_HEAVYPISTOL", price = 6000},
				{item = "WEAPON_REVOLVER", price = 5000},
				{item = "WEAPON_REVOLVER_MK2", price = 7000},
				{item = "WEAPON_MARKSMANPISTOL", price = 4000},
				{item = "WEAPON_PISTOL", price = 3000},
				{item = "WEAPON_PISTOL_MK2", price = 4000},
				{item = "WEAPON_PISTOL50", price = 10000},
				{item = "WEAPON_SNSPISTOL", price = 3000},
				{item = "WEAPON_SNSPISTOL_MK2", price = 4000},
				{item = "WEAPON_DOUBLEACTION", price = 5000},
				{item = "WEAPON_NAVYREVOLVER", price = 5000},
				{item = "WEAPON_MUSKET", price = 15000},
				{item = "WEAPON_PUMPSHOTGUN", price = 20000},
				{item = "WEAPON_PUMPSHOTGUN_MK2", price = 25000},
				{item = "WEAPON_BULLPUPSHOTGUN", price = 25000},
				{item = "WEAPON_DBSHOTGUN", price = 25000},
				{item = "WEAPON_SNIPERRIFLE", price = 200000},
				{item = "WEAPON_KNUCKLE", price = 2000},
				{item = "WEAPON_HAMMER", price = 1000},
				{item = "WEAPON_BAT", price = 1000},
				{item = "WEAPON_DAGGER", price = 2000},
				{item = "WEAPON_FLASHLIGHT", price = 500},
				{item = "WEAPON_MACHETE", price = 3000},
			},
			vector3(292.38, -991.38, -92.78),
			vector3(-2071.17, -1018.57, 3.05),
			vector3(22.72, -1105.25, 29.80) -- Ammunition
		},
		
		PhoneContact = {
			enabled = true
		},

		Webhooks = {
			armory = 'https://discordapp.com/api/webhooks/737998386745049098/wTD0rOySJUPPIHKrXrc4FkBam-GoeRV6LRcFeQy1DrFzmtWyzaG2Ddie0TCyu_jsiwR1'
		}
	},
	
	gsf = {
		Settings = {			
			mechanicMenu = {
				canRepairVehicles = false,
				canCleanVehicles = true,
				canUnlockVehicles = false,
				canRemoveVehicles = false,
				canLoadVehicle = false,
				vStancer = false
			},

			interactionsMenu = true,
			name = "Grove Street Famillies",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-31.168, -1399.121, 29.508)
		},

		Duty = {
			enabled = false,
			text = "[E] " .. _U("duty"),
			vector3(287.57, -993.2, -93.70)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(-23.99, -1403.1, 24.56),
			vector3(-318.05, -1349.86, 24.90)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(-27.283, -1397.224, 24.560)
		},

		
		Webhooks = {
			armoryDeposit = 'https://ptb.discordapp.com/api/webhooks/686220702948392983/tpDgbAIhvUGDs9ebTSp9JfCmRhb4grfUE1nqUp9V2-_dQh71nQruvGsGd5h2bM1cBWFx',
			armoryWithdraw = 'https://ptb.discordapp.com/api/webhooks/686233017207095369/uY0nGtU-k2m0efsfpvjQ7VGcX8GEPa_Q_kgLghpzJSk4FutcyAzyvwIFGp9TTD2EWTC1',
			stock = 'https://ptb.discordapp.com/api/webhooks/686241240009932922/wV92E1-O9wlwTllaEpoRimvy4onLA3HRPyC0mJzFnVwyblVOPLMbrT4gQxIwLwDrKn6o'
		}
	},
	
	sokudo = {
		Settings = {
			Blips = {
				Service = {
					enabled = true,
					pos = vector3(-205.67, -1310.97, 31.29),
					sprite = 72,
					display = 4,
					scale = 0.8,
					colour = 75
				}
			},
			
			mechanicMenu = {
				canRepairVehicles = true,
				canCleanVehicles = true,
				canUnlockVehicles = true,
				canRemoveVehicles = true,
				canLoadVehicle = true,
				vStancer = true
			},
			name = "Sokudo Chasers",
			gradePermissions = {
				majitel = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-206.68, -1331.53, 34.89)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(-211.86, -1340.17, 33.89)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(-213.38, -1312.80, 30.89)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(-213.84, -1334.27, 30.89)
		},

		
		Webhooks = {
			armory = 'https://discordapp.com/api/webhooks/765205733225660436/zcgdNNRWkF8_gXydgLjAaYeXVh45aG1dguOxh_W7M1XnTPsBl7sXpbK3g2v3atILAxKK',
			duty = 'https://discordapp.com/api/webhooks/765205813316812811/dClVt4QSj-5kLw4HqU2NiJHehkpSH-VbXyG3NJumrAnj9u7yarTZzyE-wDzTI4xDquwT',
			stock = 'https://discordapp.com/api/webhooks/765205582621704222/BerM4Wmk-ODH9c_cDtZbF49C_CvNbYSZPItiLrHlA_gBHdSQisrOOFT_Wd1wxBF17rwN',
			money = 'https://discordapp.com/api/webhooks/765205953414168597/fHieRxEsrcALlJ13_1LGn1sYxrFFYNF_Ayyaj3jz40avgG2rfMDOyRd1JFDqQjO45SUs',
			billing = 'https://discordapp.com/api/webhooks/765206061908099083/S9CXpfeA8dIIg3PUb8mvng1g-I4iia0nVzwPdxaLepAPY5fQhwgUROvTC2yNHlc1h1_l'
		}
	},
	
	unicorn = {
		Settings = {
			Blips = {
				Vanilla = {
					enabled = true,
					pos = vector3(128.92, -1298.89, 29.23),
					sprite = 121,
					display = 4,
					scale = 0.8,
					colour = 27
				}
			},
			interactionsMenu = true,
			name = "Vanilla Unicorn",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(96.82, -1291.86, 29.27)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(106.60, -1299.67, 27.78)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(130.87, -1283.75, 29.27)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(93.35, -1291.69, 29.27)
		},
		
		Webhooks = {
			stock = 'https://discordapp.com/api/webhooks/769317034039181372/ggSXQNImrRAkEeV_ZoE760uhbJMK1itFtKNDPNR02taHItyofuZtQiQvdcJjg0jq5l9X',
			billing = 'https://discordapp.com/api/webhooks/769316929554481173/lyxKfl_jkrMmGce2GfsMr4hq_GnOGILT1XMLIlSDndte4cqkRdUDXV0rnpg60My6fJBQ'
		}
		
	},
	
	Crypto = {
		Settings = {
			Blips = {
				Gruppe = {
					enabled = true,
					pos = vector3(-195.24,-830.79,30.79),
					sprite = 507,
					display = 4,
					scale = 0.8,
					colour = 2
				}
			},
			interactionsMenu = true,
			name = "Gruppe6",
			gradePermissions = {
				boss = {
					bossMenu = {
						withdraw  = true,
						deposit   = true,
						wash      = false,
						employees = true,
						grades    = true,
						billing   = true
					}
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-307.47, -1001.58, 4.60)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(-317.49, -1006.34, 3.61)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(-314.41, -1008.05, 4.60)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(-307.4, -1005.11, 4.60)
		},
		
		PhoneContact = {
			enabled = true
		},

		Webhooks = {
			armoryDeposit = 'https://ptb.discordapp.com/api/webhooks/686220702948392983/tpDgbAIhvUGDs9ebTSp9JfCmRhb4grfUE1nqUp9V2-_dQh71nQruvGsGd5h2bM1cBWFx',
			armoryWithdraw = 'https://ptb.discordapp.com/api/webhooks/686233017207095369/uY0nGtU-k2m0efsfpvjQ7VGcX8GEPa_Q_kgLghpzJSk4FutcyAzyvwIFGp9TTD2EWTC1',
			duty = 'https://discordapp.com/api/webhooks/741399980996034631/g6_fQN-GcjTMA9DahsimMJYvqdcuuhHFedvImPx8TuKHiZ5xYv_s4b4vJinm1pvqA7-K',
			billing = 'https://discordapp.com/api/webhooks/741353213852385432/CPIUf0zWHEWxfLnrzV6GgZRVpOslV3NWVL3hgvzkZOKg3RcXLmOS_kfu9dp03sElWSMO',
			money = 'https://discordapp.com/api/webhooks/741353213852385432/CPIUf0zWHEWxfLnrzV6GgZRVpOslV3NWVL3hgvzkZOKg3RcXLmOS_kfu9dp03sElWSMO',
			stock = 'https://ptb.discordapp.com/api/webhooks/686241240009932922/wV92E1-O9wlwTllaEpoRimvy4onLA3HRPyC0mJzFnVwyblVOPLMbrT4gQxIwLwDrKn6o'
		}
	},
	
	dungeon = {
		Settings = {
			Blips = {
				Marshall = { --Marshall Corporation
					enabled = true,
					pos = vector3(-291.34619140625, -818.68090820313, 32.415786743164),
					sprite = 78,
					display = 4,
					scale = 0.8,
					colour = 24
				},
				Galaxy = { --Galaxy
					enabled = true,
					pos = vector3(355.38577270508,302.13223266602,103.75422668457),
					sprite = 93,
					display = 4,
					scale = 0.8,
					colour = 24,
					name = "Galaxy"
				}
			},
			interactionsMenu = true,
			name = "Marshall Corporation",
			gradePermissions = {
				boss = {
					bossMenu = true
				},
				uber = {
					bossMenu = {
						withdraw  = true,
						deposit   = true,
						wash      = false,
						employees = true,
						grades    = true,
						billing   = true
					}
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(389.18, 272.54, 94.99)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(390.95, 269.86, 94.00)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(384.16, 280.09, 94.99),
			vector3(356.44, 282.67, 94.19),
			vector3(351.36, 288.46, 91.19)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(379.22, 258.43, 92.19)
		},
		
		Webhooks = {
			billing = 'https://discordapp.com/api/webhooks/675813636228382734/zbNYnR69WF9eVOZ9QeYZw5Mv21uij5BU-8nmyVmSMR4nQBwliIZWbU8qMPwe2DsFwG9B',
		}
	},
	
	redwood = {
		Settings = {
			Blips = {
				Redwood = {
					enabled = false,
					pos = {x = 421.23, y = 6473.78, z = 28.81},
					sprite = 93,
					display = 4,
					scale = 0.8,
					colour = 38
				}
			},
			name = "Redwood Cigarettes",
			gradePermissions = {
				majitel = {
					bossMenu = true
				},
				manager = {
					bossMenu = {
						withdraw  = false,
						deposit   = false,
						wash      = false,
						employees = false,
						grades    = false,
						billing   = true
					}
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(445.77, 6462.42, 28.80) -- Add more vector3()s to add the menu to different locations
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(423.62, 6477.29, 27.83) -- Add more vector3()s to add the menu to different locations
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(434.16, 6473.22, 28.77) -- Add more vector3()s to add the menu to different locations
		},
		
		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(441.59, 6459.68, 35.86)
		},

		PhoneContact = {
			enabled = true
		},
		
		Webhooks = {
			billing = 'https://discordapp.com/api/webhooks/752872860480962661/TNjCWkI6jfP2XD23lXymCkiLv2z1REt7duSP0kYIqHOpx2A3oQGrTiOjWpFyIDIt0iLI',
		}

	},
	
	lowsociety = {
		Settings = {
			Blips = {
				Service = {
					enabled = true,
					pos = vector3(-355.49,6067.99,31.50),
					sprite = 72,
					display = 4,
					scale = 0.8,
					colour = 75,
					name = "Low Society Garage"
				},
				Center = {
					enabled = true,
					pos = vector3(-812.95,-1348.91,5.22),
					sprite = 596,
					display = 4,
					scale = 0.8,
					colour = 38,
					name = "LS Driving Reeducation Centre"
				}
			},
			mechanicMenu = {
				canRepairVehicles = true,
				canCleanVehicles = true,
				canUnlockVehicles = true,
				canRemoveVehicles = true,
				canLoadVehicle = true,
				vStancer = false
			},
			name = "Low Society",
			gradePermissions = {
				leader = {
					bossMenu = true
				},
				member = {
					bossMenu = {
						withdraw  = true,
						deposit   = true,
						wash      = false,
						employees = false,
						grades    = false,
						billing   = true
					}
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(1116.24,-3160.62,-36.87),
			vector3(-804.19,-1370.51,5.22)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(103.05,6617.69,31.45)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(105.82,6627.43,31.79),
			vector3(1121.24,-3152.68,-37.07)
		},

		Armory = {
			enabled = false,
			text = "[E] " .. _U("armory"),
			vector3(109.23,6631.48,31.79)
		},

	},
	
	sealife = {
		Settings = {
			Blips = {
				Prodejna = {
					enabled = true,
					pos = vector3(-737.09, -1322.96, 1.57),
					sprite = 410,
					display = 4,
					scale = 0.8,
					colour = 38,
					name = "Sea Life Sails"
				}
			},
			name = "Sea Life Sails",
			gradePermissions = {
				majitel = {
					bossMenu = true
				}
			}
		},
		
		VehicleMenu = {
			enabled = true,
			type = "boat",
			text = "[E] " .. _U("vehicle_display"),
			menu = {
				vector3(-731.06, -1340.67, 1.59)
			},
			displayPoints = {
				vector4(-721.30, -1317.89, 0.28, 229.46),
				vector4(-724.44, -1328.43, 0.28, 229.46),
			    vector4(-732.20, -1333.85, -1.28, 229.46),
				vector4(-750.69, -1353.85, -1.28, 229.46)
			},
			canBuy = {
				seashark = 7500,
				seashark3 = 7500,
				suntrap = 10000,
				jetmax = 45000,
				tropic2 = 65000,
				dinghy2 = 32500,
				speeder = 85000,
				speeder2 = 85000,
				toro = 200000,
				toto2 = 200000,
				marguis = 250000,
				rboat = 200000,
				yacht2 = 500000,
				sr650fly = 700000
				
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-734.76, -1346.82, 1.57)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(-736.04, -1325.92, 0.69)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(-762.23, -1354.45, 1.59)

		},
		
		Armory = {
			enabled = false,
			text = "[E] " .. _U("armory"),
			vector3(-764.31, -1356.61, 1.59)
		},

		PhoneContact = {
			enabled = true
		}

	},

	elysian = {
		Settings = {
			mechanicMenu = true,
			interactionsMenu = true,
			medicalMenu = true,
			name = "Maze Bank",
			propSpawner = {
				{prop = "xm_prop_x17_bag_med_01a", name = "Medibag"},
				{prop = "prop_byard_net02", name = "Kužel"},
				{prop = "prop_barrier_work02a", name = "Zábrana (se světlem)"},
				{prop = "prop_generator_01a", name = "Agregát"},
				{prop = "xm_prop_smug_crate_s_medical", name = "Medical box"}
			},
			gradePermissions = {
				developer = {
					bossMenu = true
				}
			},
		},

		VehicleMenu = {
			enabled = true,
			type = "car",
			text = "[E] " .. _U("vehicle_display"),
			menu = {
				vector3(-1396.80, -470.51, 78.20)
			},
			displayPoints = {
			    vector4(-1384.40, -469.65, 77.60, 96.75),
				vector4(-1383.56, -475.23, 77.60, 95.64)
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-1370.08, -462.42, 72.04),
			vector3(-1577.91, -565.41, 108.52)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(39.38, -1002.85, 28.50)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			canBuy = {
				{item = "male_jidlo", label = "Malé jídlo", price = 100},
				{item = "stredni_jidlo", label = "Střední jídlo", price = 200},
				{item = "velke_jidlo", label = "Velké jídlo", price = 400}
			},
			vector3(-1375.54, -480.59, 72.04),
			vector3(-1575.19, -566.12, 108.52)
		},
		
		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			canBuy = {
				{item = "WEAPON_COMBATPISTOL", price = 150}
			},
			vector3(-1376.80, -473.66, 72.04),
			vector3(-1577.92, -568.37, 108.52)
		},

		PhoneContact = {
			subscribeTo = {
				"ambulance"
			}
		},

		Webhooks = {
			money = 'https://discordapp.com/api/webhooks/739853895991427124/TvYfU9t57WZYdhy8VrSnzmrAcf4fx7VsZB9YWAf3jISbm5C8Vl5_h7hVufC6Iz5lSYTD',
			billing = 'https://discordapp.com/api/webhooks/739853895991427124/TvYfU9t57WZYdhy8VrSnzmrAcf4fx7VsZB9YWAf3jISbm5C8Vl5_h7hVufC6Iz5lSYTD',
			armory = 'https://discordapp.com/api/webhooks/739853895991427124/TvYfU9t57WZYdhy8VrSnzmrAcf4fx7VsZB9YWAf3jISbm5C8Vl5_h7hVufC6Iz5lSYTD',
			duty = 'https://discordapp.com/api/webhooks/739853895991427124/TvYfU9t57WZYdhy8VrSnzmrAcf4fx7VsZB9YWAf3jISbm5C8Vl5_h7hVufC6Iz5lSYTD',
			stock = 'https://discordapp.com/api/webhooks/739853895991427124/TvYfU9t57WZYdhy8VrSnzmrAcf4fx7VsZB9YWAf3jISbm5C8Vl5_h7hVufC6Iz5lSYTD'
		}
	},
	
	bazar = {
		Settings = {
			Blips = {
				Prodejna = {
					enabled = true,
					pos = vector3(286.78, -1148.72, 29.29),
					sprite = 488,
					display = 4,
					scale = 0.8,
					colour = 28,
					name = "Country Service"
				}
			},
			mechanicMenu = {
				canRepairVehicles = true,
				canCleanVehicles = true,
				canUnlockVehicles = true,
				canRemoveVehicles = true,
				canLoadVehicle = true,
				vStancer = false
			},
			interactionsMenu = true,
			name = "Country Service",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},
		
		VehicleMenu = {
			enabled = true,
			type = "car",
			text = "[E] " .. _U("vehicle_display"),
			menu = {
				vector3(290.09, -1156.04, 29.24)
			},
			displayPoints = {
				vector4(283.13, -1150.29, 28.89, 266.88),
				vector4(290.48, -1150.23, 28.89, 267.70),
			    vector4(295.02, -1150.13, 28.89, 269.54),
				vector4(302.41, -1150.18, 28.89, 59.37),
				vector4(298.91, -1150.19, 28.89, 302.78)
			}
		},
		
		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(289.77, -1166.88, 29.24)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(292.66, -1157.92, 28.28)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(1972.96, 3819.27, 33.43),
			vector3(293.52, -1166.58, 29.24),
			vector3(-564.673, 287.212, 85.377),
			vector3(-562.250, 285.065, 82.176)

		},
	
		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(1978.29, 3819.77, 33.45),
			vector3(282.40, -1159.70, 29.24)
		},

		PhoneContact = {
			enabled = true
		}

	},

	sadoes = {
		Settings = {
			Blips = {
				Vanilla = {
					enabled = false,
					pos = vector3(128.92, -1298.89, 29.23),
					sprite = 121,
					display = 4,
					scale = 0.8,
					colour = 27
				}
			},
			mechanicMenu = true,
			interactionsMenu = true,
			medicalMenu = true,
			name = "San Andreas Department of Emergency Services",
			gradePermissions = {
				boss = {
					bossMenu = true
				},
				deputy = {
					bossMenu = {
						withdraw  = false,
						deposit   = false,
						wash      = false,
						employees = true,
						grades    = true,
						billing   = false
					}
				},
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-611.95, 887.02, 157.76),
			vector3(-1555.28, -577.23, 108.52)
		},

		Duty = {
			enabled = false,
			text = "[E] " .. _U("duty"),
			vector3(106.60, -1299.67, 27.78)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(-611.82, 892.20, 165.37),
			vector3(-1559.67, -573.91, 108.52)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(-615.74, 890.75, 157.76),
			vector3(-1561.33, -569.51, 108.52)
		}
		
	},

	motoclub = {
		Settings = {
			Blips = {
				club = {
					enabled = true,
					pos = vector3(-1353.05, -752.77, 22.30),
					sprite = 559,
					display = 4,
					scale = 0.8,
					colour = 66
				}
			},
			mechanicMenu = {
				canRepairVehicles = true,
				canCleanVehicles = true,
				canUnlockVehicles = false,
				canRemoveVehicles = false,
				canLoadVehicle = true,
				vStancer = false
			},
			interactionsMenu = true,
			name = "MC MOTOCYCLE CLUB",
			gradePermissions = {
				boss = {
					bossMenu = {
						withdraw  = true,
						deposit   = true,
						wash      = false,
						employees = true,
						grades    = true,
						billing   = true
					}
				},
				manager = {
					bossMenu = {
						withdraw  = false,
						deposit   = false,
						wash      = false,
						employees = true,
						grades    = true,
						billing   = false
					}
				},
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(1008.50, -3171.40, -38.89)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(1007.84, -3168.55, -39.87)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(1014.51, -3160.91, -38.91)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(1004.68, -3149.06, -38.91)
		}
		
	},

	suomi = {
		Settings = {
			Blips = {
				Service = {
					enabled = true,
					pos = {x = -1415.39, y = -666.45, z = 34.48},
					sprite = 120,
					display = 4,
					scale = 0.8,
					colour = 38
				}
			},
			name = "Suomi Motors",
			mechanicMenu  = {
				canRepairVehicles = true,
				canCleanVehicles = true,
				canUnlockVehicles = true,
				canRemoveVehicles = true,
				canLoadVehicle = true,
				vStancer = true
			},
			gradePermissions = {
				majitel = {
					bossMenu = true
				},
				manager = {
					bossMenu = {
						withdraw  = false,
						deposit   = true,
						wash      = false,
						employees = true,
						grades    = true,
						billing   = true
					}
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-1415.39, -666.45, 34.48)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(-1405.58, -687.29, 27.59)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(-1400.07, -675.99, 28.58)
		},
		
		PhoneContact = {
			enabled = true
		},

		Webhooks = {
			duty = 'https://discordapp.com/api/webhooks/760581097158606859/z2FFGsavQgK5OWMECiUUHAGXZYjAP5XWk0Yge40KL_M5XUFRpRRZu0-unIZjMiCOiWG1',
			billing = 'https://discordapp.com/api/webhooks/760580741431033876/4rbed64u0kTNBMetDkuvzs6LTQVuJ7NmNVvOsU1iLLG5LUXbORD_9Z3WHfdX0_NykMhC',
			money = 'https://discordapp.com/api/webhooks/762726157127909397/aE9y_J4QDwmjQhnH5pSA7cQD2NvFdqEZ6g4EYYB0uYPkJsjBFTrI1HUkOTb7fjuq4Gbx',
		}

	},

	floydspeed = {
		Settings = {
			Blips = {
				Service = {
					enabled = true,
					pos = vector3(1186.67, 2637.17, 43.16),
					sprite = 446,
					display = 4,
					scale = 0.8,
					colour = 47
				}
			},
			
			mechanicMenu = {
				canRepairVehicles = true,
				canCleanVehicles = true,
				canUnlockVehicles = true,
				canRemoveVehicles = true,
				canLoadVehicle = true,
				vStancer = false
			},
			name = "Floyd&Speed Service",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(1186.45,2636.71,38.40)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(1189.32,2643.60,37.41)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(1189.61,2637.77,38.40)
		},

		Armory = {
			enabled = false,
			text = "[E] " .. _U("armory"),
			vector3(1172.33,2635.59,37.80)
		},
		
		PhoneContact = {
			enabled = true
		},

	},

	bmc = {
		Settings = {
			Blips = {
				coffee = {
					enabled = true,
					pos = {x = -626.43, y = 239.13, z = 81.89},
					sprite = 214,
					display = 4,
					scale = 0.8,
					colour = 56
				}
			},
			name = "Bean Machine Coffee",
			gradePermissions = {
				majitel = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-627.67, 223.97, 81.88) -- Add more vector3()s to add the menu to different locations
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(-630.38, 230.07, 80.89) -- Add more vector3()s to add the menu to different locations
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			canBuy = {
				{item = "male_jidlo", label = "Malé jídlo", price = 100},
				{item = "stredni_jidlo", label = "Střední jídlo", price = 200}
			},
			vector3(-635.94, 233.86, 81.88) -- Add more vector3()s to add the menu to different locations
		},

		PhoneContact = {
			enabled = true
		},

	},

	faa = {
		Settings = {
			Blips = {
				office = {
					enabled = true,
					pos = {x = -81.15, y = -799.24, z = 243.39},
					sprite = 578,
					display = 4,
					scale = 0.8,
					colour = 77,
					name = "FAA Office"
				},
				airport = {
					enabled = true,
					pos = {x = -960.68, y = -2793.31, z = 13.96},
					sprite = 578,
					display = 4,
					scale = 0.9,
					colour = 77,
					name = "LSIA"
				}
			},
			name = "FAA",
			gradePermissions = {
				supervisor = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-81.15, -799.24, 243.39)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(-74.36, -814.66, 242.40),
			vector3(-922.49, -2938.38, 12.96)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(-79.54, -808.15, 243.39),
			vector3(-937.84, -2931.96, 13.95)
		},

		PhoneContact = {
			enabled = true
		},

	},

	atomic = {
		Settings = {
			Blips = {
				office = {
					enabled = true,
					pos = {x = -788.53, y = -1347.68, z = 5.21},
					sprite = 127,
					display = 4,
					scale = 0.8,
					colour = 70,
					name = "Atomic"
				},
				dilna = {
					enabled = false,
					pos = {x = -1145.87, y = -1991.17, z = 13.18},
					sprite = 127,
					display = 4,
					scale = 0.8,
					colour = 70,
					name = "Atomic Dílna"
				}
			},
			mechanicMenu = {
				canRepairVehicles = true,
				canCleanVehicles = true,
				canUnlockVehicles = true,
				canRemoveVehicles = true,
				canLoadVehicle = true,
				vStancer = false
			},
			name = "Atomic",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-812.40, -1356.29, 5.22),
			vector3(-1146.35, -2003.58, 13.18)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(-1148.37, -1999.64, 12.19)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(-1139.95, -2005.79, 13.18)
		},

		PhoneContact = {
			enabled = true
		},

	},

	Tm = {
		Settings = {
			interactionsMenu = true,
			mechanicMenu = {
				canRepairVehicles = false,
				canCleanVehicles = false,
				canUnlockVehicles = true,
				canRemoveVehicles = true,
				canLoadVehicle = false,
				vStancer = false
			},
			name = "Tm",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-571.59, 671.80, 138.23)
		},

		Duty = {
			enabled = false,
			text = "[E] " .. _U("duty"),
			vector3(-74.36, -814.66, 242.40),
			vector3(-922.49, -2938.38, 12.96)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(-566.27, 670.92, 138.23)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(-567.60,667.18,138.23)
		},

	},

	lscfd = {
		Settings = {
			Blips = {
				stanice7 = {
					enabled = true,
					pos = vector3(1200.61, -1464.60, 34.89),
					sprite = 436,
					display = 4,
					scale = 0.8,
					colour = 75,
					name = "Stanice 7"
				},
				staniceDavis = {
					enabled = true,
					pos = vector3(212.16, -1643.61, 29.82),
					sprite = 436,
					display = 4,
					scale = 0.8,
					colour = 75,
					name = "Davis Fire Station"
				}
			},
			mechanicMenu = true,
			interactionsMenu = true,
			medicalMenu = true,
			propSpawner = {
				{prop = "xm_prop_x17_bag_med_01a", name = "Medibag"},
				{prop = "prop_byard_net02", name = "Kužel"},
				{prop = "prop_barrier_work02a", name = "Zábrana (se světlem)"},
				{prop = "prop_generator_01a", name = "Agregát"},
				{prop = "xm_prop_smug_crate_s_medical", name = "Medical box"}
			},
			name = "Los Santos County Fire Department",
			gradePermissions = {
				captain = {
					bossMenu = true
				},
				battalion = {
					bossMenu = {
						withdraw  = false,
						deposit   = false,
						wash      = false,
						employees = true,
						grades    = true,
						billing   = false
					}
				},
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(1179.19, -1491.60, 35.07),
			vector3(1169.07, -1466.03, 35.07)
		},

		Duty = {
			enabled = true,
			text = "[E] " .. _U("duty"),
			vector3(1222.09, -1492.83, 34.08),
			vector3(306.11, -594.94, 42.29)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(1219.32, -1489.51, 35.07),
			vector3(1187.37, -1495.50, 35.07),
			vector3(1221.49, -1469.53, 35.07),
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(1218.29, -1469.72, 35.07)
		},
		
		VehicleMenu = {
			enabled = true,
			text = "[E] " .. _U("vehicle_display"),
			menu = {
				vector3(1194.96, -1483.41, 34.86)
			},
			displayPoints = {
				vector4(1201.31, -1503.20, 34.69, 358.12)
			},
			canBuy = {
				firecharger = 10
			},
			spawner = {
				vehicles = {
					{model = "stretcher", label = "Nosítka"} -- If label starts with "--", it will be used as a spacer
				},
				vector4(1220.27, -1523.80, 33.72, 0.0)
			}
		},
		
		PhoneContact = {
			subscribeTo = {
				"ambulance"
			}
		},
		
		Webhooks = {
			duty = 'https://discordapp.com/api/webhooks/768752016854876160/j2AZA8m0BrMjBKxEOdYngkpmPaX1xD5wAb34N6uqjxIy1S8f761wJmWcdUsh7wfTQUle',
			billing = 'https://discordapp.com/api/webhooks/768752387284008990/AYMRvVdNEOGz6SEM0sSbmwrG_wgIZTsnSJGoZQtXmLso7YMa7W-O06l_9TrmNZTR3nlM',
			money = 'https://discordapp.com/api/webhooks/768752387284008990/AYMRvVdNEOGz6SEM0sSbmwrG_wgIZTsnSJGoZQtXmLso7YMa7W-O06l_9TrmNZTR3nlM',
			stock = 'https://discordapp.com/api/webhooks/768753867755487242/IlHls90p1ZG6o-QkogUBebgwZs4x0PiAWjjMlozBB039gUo8Xq_bml4BZ1sB1xZ0OIrb',
			armory = 'https://discordapp.com/api/webhooks/768753867755487242/IlHls90p1ZG6o-QkogUBebgwZs4x0PiAWjjMlozBB039gUo8Xq_bml4BZ1sB1xZ0OIrb',
		}
	},

	lsv = {
		Settings = {
			Blips = {
				Taco = {
					enabled = true,
					pos = vector3(10.91, -1608.32, 29.38),
					sprite = 208,
					display = 4,
					scale = 0.8,
					colour = 5,
					name = "Taco Bomb"
				}
			},
			interactionsMenu = true,
			canBuyItems = true,
			name = "Los Santos Vagos",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(362.18, -2038.42, 25.59),
			vector3(16.83, -1606.64, 29.39)
		},

		Duty = {
			enabled = false,
			text = "[E] " .. _U("duty"),
			vector3(14.61, -1597.26, 29.38)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			canBuy = {
				{item = "male_jidlo", label = "Malé jídlo", price = 100},
				{item = "stredni_jidlo", label = "Střední jídlo", price = 200}
			},
			vector3(14.61, -1597.26, 29.38),
			vector3(367.87, -2040.68, 22.39),
			vector3(470.82, -1896.64, 26.10)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(471.36, -1901.10, 25.96),
			vector3(336.69, -2014.98, 22.39)
		},

		Webhooks = {
			armory = 'https://discordapp.com/api/webhooks/770270212456710205/0pkigrxxl53QxxX3a-v7yEZiYlFRFOJV-LAwp_Cbk7-l72KsSOSJoTJ5DiZd1__9WiOQ'
		}
	},

	falcone = {
		Settings = {
			interactionsMenu = true,
			canBuyWeapons = true,
			name = "Falcone",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(-57.168, 982.099, 234.577)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			canBuy = {
				{item = "WEAPON_SWITCHBLADE", price = 1000},
				{item = "WEAPON_APPISTOL", price = 15000},
				{item = "WEAPON_HEAVYPISTOL", price = 6000},
				{item = "WEAPON_PISTOL_MK2", price = 4000},
				{item = "WEAPON_COMBATPDW", price = 35000},
				{item = "WEAPON_MICROSMG", price = 15000},
				{item = "WEAPON_CARBINERIFLE", price = 85000},
				{item = "WEAPON_CARBINERIFLE_MK2", price = 115000},
				{item = "WEAPON_SPECIALCARBINE", price = 95000},
				{item = "WEAPON_SPECIALCARBINE_MK2", price = 105000},
				{item = "WEAPON_MOLOTOV", price = 10000},
				{item = "WEAPON_STICKYBOMB", price = 600000},
				{item = "WEAPON_HEAVYSNIPER", price = 450000},
				{item = "WEAPON_SNIPERRIFLE", price = 200000},
			},
			vector3(-84.877, 996.680, 230.607)
		}
	},

	balas = {
		Settings = {
			interactionsMenu = true,
			name = "Ballas",
			gradePermissions = {
				boss = {
					bossMenu = true
				}
			}
		},

		BossMenu = {
			enabled = true,
			text = "[E] " .. _U("manage"),
			vector3(119.68, -1968.39, 21.33),
			vector3(256.70, -1813.02, 26.91)
		},

		Stock = {
			enabled = true,
			text = "[E] " .. _U("stock"),
			vector3(116.76, -1972.61, 21.33),
			vector3(583.78, -427.51, 17.62)
		},

		Armory = {
			enabled = true,
			text = "[E] " .. _U("armory"),
			vector3(106.41, -1982.82, 20.96),
			vector3(260.73, -1808.94, 26.81),
			vector3(1450.30, -1666.15, 66.13),
			vector3(336.65, -2014.79, 22.39)
		},

		Webhooks = {
			armory = 'https://ptb.discordapp.com/api/webhooks/686233017207095369/uY0nGtU-k2m0efsfpvjQ7VGcX8GEPa_Q_kgLghpzJSk4FutcyAzyvwIFGp9TTD2EWTC1',
			stock = 'https://ptb.discordapp.com/api/webhooks/686241240009932922/wV92E1-O9wlwTllaEpoRimvy4onLA3HRPyC0mJzFnVwyblVOPLMbrT4gQxIwLwDrKn6o',
			duty = 'https://ptb.discordapp.com/api/webhooks/686241240009932922/wV92E1-O9wlwTllaEpoRimvy4onLA3HRPyC0mJzFnVwyblVOPLMbrT4gQxIwLwDrKn6o'
		}
	},
}

