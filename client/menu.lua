
function OpenDutyMenu()
	if not JobManager.Job.Config.Duty.enabled then
		return 
	end
	
	local elements = {}

	if string.sub(ESX.PlayerData.job.name, 1, 4) == "off_" then
		table.insert(elements, {label = _U("duty_on"), value = "duty_on"})
	else
		table.insert(elements, {label = _U("duty_off"), value = "duty_off"})
	end
	
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"jobmanager_duty",
		{
			title = _U("duty"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			if data.current.value == "duty_on" then
				JobManager.Player.onDuty = true
				TriggerServerEvent("esx_jobmanager:setJob", JobManager.Job.identifier, JobManager.Player.onDuty, ESX.PlayerData.job.grade)
				menu.close()
				dutyAction()
			elseif data.current.value == "duty_off" then
				JobManager.Player.onDuty = false
				TriggerServerEvent("esx_jobmanager:setJob", JobManager.Job.identifier, JobManager.Player.onDuty, ESX.PlayerData.job.grade)
				menu.close()
				dutyAction()
			end
		end,
		function(data, menu)
			menu.close()
			dutyAction()
		end
	)
end

function OpenStockMenu()
	local elements = {
		{label = _U("remove_object"), value = "get_stock"},
		{label = _U("deposit_object"), value = "put_stock"}
	}

	if JobManager.Job.Config.Stock.canBuy and JobManager.Player.permissions and ((JobManager.Player.permissions.gradePermissions and JobManager.Player.permissions.gradePermissions.canBuyItems == true) or (JobManager.Player.permissions.options and JobManager.Player.permissions.options.withdraw)) then
		table.insert(
			elements,
			{
				label = _U("buy_item"),
				value = "buy_item"
			}
		)
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		"stock",
		{
			title = _U("stock"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			if data.current.value == "put_stock" then
				OpenPutStocksMenu()
			elseif data.current.value == "get_stock" then
				OpenGetStocksMenu()
			elseif data.current.value == "buy_item" then
				OpenBuyItemMenu()
			end
		end,
		function(data, menu)
			menu.close()

			stockAction()
		end
	)
end

function OpenJobActionsMenu()

	elements = {
		{label = _U("billing"), value = 'billing'}
	}

	local checkPermissions = JobManager.Player.permissions and JobManager.Player.permissions.gradePermissions

	if JobManager.Job.Config.Settings.mechanicMenu or (checkPermissions and JobManager.Player.permissions.gradePermissions.mechanicMenu) then
		table.insert(elements, {label = _U("mechanic_menu"), value = 'mechanic_menu'})
	end

	if JobManager.Job.Config.Settings.medicalMenu or (checkPermissions and JobManager.Player.permissions.gradePermissions.medicalMenu) then
		table.insert(elements, {label = _U("medical_menu"), value = 'medical_menu'})
	end

	if JobManager.Job.Config.Settings.interactionsMenu or (checkPermissions and JobManager.Player.permissions.gradePermissions.interactionsMenu) then
		table.insert(elements, {label = _U("interactions_menu"), value = 'interactions_menu'})
	end

	if JobManager.Job.Config.Settings.propSpawner then
		table.insert(elements, {label = _U("prop_spawner"), value = 'prop_spawner'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier,
		{
			title = JobManager.Job.Config.Settings.name,
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			if data.current.value == "billing" then
				OpenBillingMenu()
			elseif data.current.value == "mechanic_menu" then
				OpenMechanicMenu()
			elseif data.current.value == "medical_menu" then
				OpenMedicalMenu()
			elseif data.current.value == "interactions_menu" then
				OpenInteracionsMenu()
			elseif data.current.value == "prop_spawner" then
				OpenPropSpawnerMenu()
			else
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenPropSpawnerMenu()
	local elements = {}

	if not JobManager.Job.Config.Settings.propSpawner then
		return
	end

	for k, v in ipairs(JobManager.Job.Config.Settings.propSpawner) do
		if v.name and v.prop and IsModelInCdimage(GetHashKey(v.prop)) then
			table.insert(
				elements,
				{
					label = v.name,
					value = v.prop
				}
			)
		end
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_prop_spawner",
		{
			title = _U("spawn_prop"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			local playerPed = GetPlayerPed(-1)
			local coords = GetEntityCoords(playerPed) + GetEntityForwardVector(playerPed)

			local unblockControls = BlockControls()

			ESX.Game.SpawnObject(
				data.current.value,
				coords,
				function(entity)
					unblockControls()
					PlaceObjectOnGroundProperly(entity)
				end
			)
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenMechanicMenu()
	local elements = {}
	local globalSetting = false

	local checkPermissions = JobManager.Player.permissions and JobManager.Player.permissions.gradePermissions and JobManager.Player.permissions.gradePermissions.mechanicMenu

	if not JobManager.Job.Config.Settings.mechanicMenu then
		return
	else
		globalSetting = JobManager.Job.Config.Settings.mechanicMenu == true or (checkPermissions and JobManager.Player.permissions.gradePermissions.mechanicMenu == true)
	end

	if globalSetting or JobManager.Job.Config.Settings.mechanicMenu.canRepairVehicles or (checkPermissions and JobManager.Player.permissions.gradePermissions.mechanicMenu.canRepairVehicles) then
		table.insert(elements, {label = _U("repair_vehicle"), value = 'repair_vehicle'})
	end

	if globalSetting or JobManager.Job.Config.Settings.mechanicMenu.canCleanVehicles or (checkPermissions and JobManager.Player.permissions.gradePermissions.mechanicMenu.canCleanVehicles) then
		table.insert(elements, {label = _U("clean_vehicle"), value = 'clean_vehicle'})
	end

	if globalSetting or JobManager.Job.Config.Settings.mechanicMenu.canUnlockVehicles or (checkPermissions and JobManager.Player.permissions.gradePermissions.mechanicMenu.canUnlockVehicles) then
		table.insert(elements, {label = _U("unlock_vehicle"), value = 'unlock_vehicle'})
	end

	if globalSetting or JobManager.Job.Config.Settings.mechanicMenu.canRemoveVehicles or (checkPermissions and JobManager.Player.permissions.gradePermissions.mechanicMenu.canRemoveVehicles) then
		table.insert(elements, {label = _U("remove_vehicle"), value = 'remove_vehicle'})
	end

	if globalSetting or JobManager.Job.Config.Settings.mechanicMenu.canLoadVehicle or (checkPermissions and JobManager.Player.permissions.gradePermissions.mechanicMenu.canLoadVehicle) then
		table.insert(elements, {label = _U("tow_vehicle"), value = 'tow_vehicle'})
	end

	if JobManager.vStancer and (globalSetting or JobManager.Job.Config.Settings.mechanicMenu.vStancer or (checkPermissions and JobManager.Player.permissions.gradePermissions.mechanicMenu.vStancer)) then
		table.insert(elements, {label = _("vstancer"), value = 'vstancer'})
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_mechanic",
		{
			title = _U("mechanic_menu"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			if data.current.value == "repair_vehicle" then
				RepairNearestVehicle()
			elseif data.current.value == "clean_vehicle" then
				CleanNearestVehicle()
			elseif data.current.value == "unlock_vehicle" then
				UnlockNearestVehicle()
			elseif data.current.value == "remove_vehicle" then
				RemoveNearestVehicle()
			elseif data.current.value == "tow_vehicle" then
				TowVehicle()
			elseif data.current.value == "vstancer" then
				ESX.UI.Menu.CloseAll()
				TriggerEvent('vstancer:toggleMenu', playerId)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenMedicalMenu()
	local elements = {}
	local globalSetting = false

	local checkPermissions = JobManager.Player.permissions and JobManager.Player.permissions.gradePermissions and JobManager.Player.permissions.gradePermissions.medicalMenu

	if not JobManager.Job.Config.Settings.medicalMenu then
		return
	else
		globalSetting = JobManager.Job.Config.Settings.medicalMenu == true or (checkPermissions and JobManager.Player.permissions.gradePermissions.medicalMenu == true)
	end
	
	if globalSetting or JobManager.Job.Config.Settings.medicalMenu.canHeal or (checkPermissions and JobManager.Player.permissions.gradePermissions.medicalMenu.canHeal) then
		table.insert(elements, {label = _U("heal_small"), value = 'heal_small'})
		table.insert(elements, {label = _U("heal_big"), value = 'heal_big'})
	end

	if globalSetting or JobManager.Job.Config.Settings.medicalMenu.canRevive or (checkPermissions and JobManager.Player.permissions.gradePermissions.medicalMenu.canRevive) then
		table.insert(elements, {label = _U("revive"), value = 'revive'})
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_medical",
		{
			title = _U("medical_menu"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			if data.current.value == "heal_small" or data.current.value == "heal_big" or data.current.value == "revive" then
				OpenMedicalActionMenu(data.current.value)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenInteracionsMenu()
	local elements = {}
	local globalSetting = false
	
	local checkPermissions = JobManager.Player.permissions and JobManager.Player.permissions.gradePermissions.interactionsMenu

	if not JobManager.Job.Config.Settings.interactionsMenu then
		return
	else
		globalSetting = JobManager.Job.Config.Settings.interactionsMenu == true or (checkPermissions and JobManager.Player.permissions.gradePermissions.interactionsMenu == true)
	end

	if globalSetting or JobManager.Job.Config.Settings.interactionsMenu.canHandcuff or (checkPermissions and JobManager.Player.permissions.gradePermissions.interactionsMenu.canHandcuff) then
		table.insert(elements, {label = _U("handcuff"), value = 'handcuff'})
	end

	if globalSetting or JobManager.Job.Config.Settings.interactionsMenu.canPutInVehicle or (checkPermissions and JobManager.Player.permissions.gradePermissions.interactionsMenu.canPutInVehicle) then
		table.insert(elements, {label = _U("put_in_vehicle"), value = 'put_in_vehicle'})
		table.insert(elements, {label = _U("take_out_of_vehicle"), value = 'take_out_of_vehicle'})
	end

	if globalSetting or JobManager.Job.Config.Settings.interactionsMenu.canDrag or (checkPermissions and JobManager.Player.permissions.gradePermissions.interactionsMenu.canDrag) then
		table.insert(elements, {label = _U("drag"), value = 'drag'})
	end

	if globalSetting or JobManager.Job.Config.Settings.interactionsMenu.canSearch or (checkPermissions and JobManager.Player.permissions.gradePermissions.interactionsMenu.canSearch) then
		table.insert(elements, {label = _U("search"), value = 'search'})
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_interactions",
		{
			title = _U("interactions_menu"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			local player, distance = ESX.Game.GetClosestPlayer()

			if player == -1 or distance > 3.0 then
				TriggerEvent('pNotify:SendNotification', {
					text = _U('no_players_nearby'),
					type = "error",
					timeout = Config.Notification.timeout,
					layout = Config.Notification.layout,
					queue = "jobmanager"
				})
			else
				if data.current.value == "handcuff" then
					if IsPedCuffed(GetPlayerPed(player)) then
						TaskPlayAnim(GetPlayerPed(-1), "mp_arresting", "a_uncuff", 8.0, -8, 5000, 49, 0, 0, 0, 0)
					else
						TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, 4000, 48, 0, 0, 0, 0)
					end
	
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 4.0, "busted", 1.0)
					TriggerServerEvent("esx_jobmanager:handcuff", GetPlayerServerId(player))
				elseif data.current.value == "put_in_vehicle" then
					TriggerServerEvent('esx_jobmanager:putInVehicle', GetPlayerServerId(player))
				elseif data.current.value == "take_out_of_vehicle" then
					TriggerServerEvent('esx_jobmanager:takeOutOfVehicle', GetPlayerServerId(player))
				elseif data.current.value == "drag" then
					TriggerServerEvent('esx_jobmanager:drag', GetPlayerServerId(player))
				elseif data.current.value == "search" then
					TriggerServerEvent('esx_jobmanager:search', GetPlayerServerId(player), GetPlayerName(player))
				else
					menu.close()
				end
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenMedicalActionMenu(type)
	if not type then
		print('MedicalActionMenu: no type specified')
		return
	end

	local playersInArea = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 5.0)

	elements = {}

	for i = 1, #playersInArea, 1 do
		if playersInArea[i] ~= PlayerId() then
			table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
		end
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_medical_players",
		{
			title = _U("players_nearby"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			menu.close()

			local playerId = GetPlayerServerId(data.current.value)

			if type == "heal_small" then
				TriggerServerEvent('esx_jobmanager:healPlayer', playerId, "small")
			elseif type == "heal_big" then
				TriggerServerEvent('esx_jobmanager:healPlayer', playerId, "big")
			elseif type == "revive" then
				TriggerServerEvent('esx_jobmanager:revive', playerId)
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', coords.x, coords.y, coords.z)
	ClearPedBloodDamage(ped)

	ESX.UI.Menu.CloseAll()
end

function OpenBillingMenu()
	local playersInArea = ESX.Game.GetPlayersInArea(GetEntityCoords(GetPlayerPed(-1)), 5.0)

	elements = {}

	for i = 1, #playersInArea, 1 do
		if playersInArea[i] ~= PlayerId() then
			table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
		end
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_billing",
		{
			title = _U("billing"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			menu.close()

			ESX.UI.Menu.Open(
				"dialog",
				GetCurrentResourceName(),
				"billing",
				{
					title = _U("billing_amount")
				},
				function(_data, _menu)
					local amount = tonumber(_data.value)
					local player = data.current.value
					_menu.close()

					if amount == nil then
						TriggerEvent('pNotify:SendNotification', {
							text = _U('amount_invalid'),
							type = "error",
							timeout = Config.Notification.timeout,
							layout = Config.Notification.layout,
							queue = "jobmanager"
						})
					else
						ESX.UI.Menu.Open(
							"dialog",
							GetCurrentResourceName(),
							JobManager.Job.identifier .. "_billing_text",
							{
								title = _U("billing_text")
							},
							function (data2, menu2)
								menu2.close()

								local text = tostring(data2.value)
								TriggerServerEvent(
									"esx_billing:sendBill",
									GetPlayerServerId(player),
									JobManager.Job.society,
									text,
									amount
								)
							end,
							function (data2, menu2)
								menu2.close()
							end
						)
					end
				end,
				function(_data, _menu)
					_menu.close()
				end
			)
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenBuyItemMenu()
	local elements = {}

	if not JobManager.Job.Config.Stock.canBuy then
		return
	end

	for k, v in ipairs(JobManager.Job.Config.Stock.canBuy) do
		table.insert(
			elements,
			{
				label = v.label .. "($" .. v.price .. ")",
				value = v.item
			}
		)
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_buy_item",
		{
			title = _U("buy_item"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			menu.close()

			ESX.UI.Menu.Open(
				"dialog",
				GetCurrentResourceName(),
				"billing",
				{
					title = _U("quantity")
				},
				function(_data, _menu)
					local quantity = tonumber(_data.value)
					_menu.close()

					if quantity == nil then
						TriggerEvent('pNotify:SendNotification', {
							text = _U('quantity_invalid'),
							type = "error",
							timeout = Config.Notification.timeout,
							layout = Config.Notification.layout,
							queue = "jobmanager"
						})
					else
						local unblockControls = BlockControls()
						ESX.TriggerServerCallback(
							'esx_jobmanager:buyItem',
							function()
								unblockControls()
							end,
							data.current.value,
							quantity
						)
					end
				end,
				function(_data, _menu)
					_menu.close()
				end
			)        
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback(
		"esx_jobmanager:getStockItems",
		function(items)
			local elements = {}

			for i = 1, #items, 1 do
				if items[i].count > 0 then
					table.insert(elements, {label = "x" .. items[i].count .. " " .. items[i].label, value = items[i].name})
				end
			end

			ESX.UI.Menu.Open(
				"default",
				GetCurrentResourceName(),
				"stocks_menu",
				{
					title = _U("remove_object"),
					align = Config.Menu.layout,
					elements = elements
				},
				function(data, menu)
					local itemName = data.current.value

					ESX.UI.Menu.Open(
						"dialog",
						GetCurrentResourceName(),
						"stocks_menu_get_item_count",
						{
							title = _U("quantity")
						},
						function(data2, menu2)
							local count = tonumber(data2.value)

							if count == nil then
								TriggerEvent('pNotify:SendNotification', {
									text = _U('quantity_invalid'),
									type = "error",
									timeout = Config.Notification.timeout,
									layout = Config.Notification.layout,
									queue = "jobmanager"
								})
							else
								menu2.close()
								menu.close()
								TriggerServerEvent("esx_jobmanager:getStockItem", JobManager.Job.society, itemName, count)

								Citizen.Wait(300)
								OpenGetStocksMenu()
							end
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end,
				function(data, menu)
					menu.close()
				end
			)
		end,
		JobManager.Job.society
	)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback(
		"esx_jobmanager:getPlayerInventory",
		function(inventory)
			local elements = {}

			for i = 1, #inventory.items, 1 do
				local item = inventory.items[i]

				if item.count > 0 then
					table.insert(
						elements,
						{label = item.label .. " x" .. item.count, type = "item_standard", value = item.name}
					)
				end
			end

			ESX.UI.Menu.Open(
				"default",
				GetCurrentResourceName(),
				"stocks_menu",
				{
					title = _U("deposit_object"),
					align = Config.Menu.layout,
					elements = elements
				},
				function(data, menu)
					local itemName = data.current.value

					ESX.UI.Menu.Open(
						"dialog",
						GetCurrentResourceName(),
						"stocks_menu_put_item_count",
						{
							title = _U("quantity")
						},
						function(data2, menu2)
							local count = tonumber(data2.value)

							if count == nil then
								TriggerEvent('pNotify:SendNotification', {
									text = _U('quantity_invalid'),
									type = "error",
									timeout = Config.Notification.timeout,
									layout = Config.Notification.layout,
									queue = "jobmanager"
								})
							else
								menu2.close()
								menu.close()
								TriggerServerEvent("esx_jobmanager:putStockItems", JobManager.Job.society, itemName, count)

								Citizen.Wait(300)
								OpenPutStocksMenu()
							end
						end,
						function(data2, menu2)
							menu2.close()
						end
					)
				end,
				function(data, menu)
					menu.close()
				end
			)
		end
	)
end

function OpenVehicleMenu()
	local elements = {}

	if JobManager.Job.Config.VehicleMenu.displayPoints then
		table.insert(elements, {label = _U("vehicle_display"), value = "display"})
		if JobManager.Job.Config.VehicleMenu.canBuy then
			table.insert(elements, {label = _U("buy_vehicle"), value = "buy"})
		end
	else
		table.insert(elements, {label = _U("no_options"), value = "close"})
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_vehicle_display",
		{
			title = _U("vehicle_management"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			if data.current.value == "display" then
				local type = JobManager.Job.Config.VehicleMenu and JobManager.Job.Config.VehicleMenu.type and JobManager.Job.Config.VehicleMenu.type or "car"
				OpenVehicleList(type)
			elseif data.current.value == "buy" then
				OpenBuyVehicleMenu()
			else
				menu.close()
				carDisplayAction()
			end
		end,
		function(data, menu)
			menu.close()
			carDisplayAction()
		end
	)
end

function OpenVehicleList(type)
	local type = type or "car"
	local elements = {}
	local options = {}
	
	ESX.TriggerServerCallback(
		'eden_garage:getVehicles',
		function(vehicles)
			if #vehicles == 0 then
				print("No vehicles")
				table.insert(elements, {label = _U("no_vehicles"), value = "close"})
			else
				table.insert(options, ('<span color="#D3D3D3">%s</span>'):format(_U("choose_vehicle")))

				for k, v in pairs(vehicles) do
					if IsModelInCdimage(v.vehicle.model) then
						local icon = v.stored and "✅" or "❌"
						table.insert(options, ('<span>%s [%s] %s</span>'):format(GetDisplayNameFromVehicleModel(v.vehicle.model), v.vehicle.plate, icon))
					else
						table.remove(vehicles, k)
					end
				end

				if next(options) ~= nil then
					for k, v in pairs(JobManager.Job.Config.VehicleMenu.displayPoints) do
						table.insert(elements, {
							name = k,
							label = _U("point", k),
							value = 0,
							type = 'slider',
							max = #vehicles,
							options = options
						})
					end
				else
					table.insert(elements, {label = _U("no_vehicles"), value = "close"})
				end
			end

			ESX.UI.Menu.Open(
				"default",
				GetCurrentResourceName(),
				JobManager.Job.identifier .. "_vehicle_display_list",
				{
					title = _U("vehicle_display"),
					align = Config.Menu.layout,
					elements = elements
				},
				function(data, menu)
					if data.current.value == "close" then
						menu.close()
                    else
                        local coords = vector3(JobManager.Job.Config.VehicleMenu.displayPoints[data.current.name].x, JobManager.Job.Config.VehicleMenu.displayPoints[data.current.name].y, JobManager.Job.Config.VehicleMenu.displayPoints[data.current.name].z)
                        local closestVehicle = ESX.Game.GetClosestVehicle(coords)
						if data.current.value > 0 then
							menu.close()
							local unblockControls = BlockControls()
							local closestVehicleCoords = GetEntityCoords(closestVehicle)
							local spawn = false

							if GetDistanceBetweenCoords(coords, closestVehicleCoords) > 2.0 or LastVehicles[data.current.name] == false then
								if LastVehicles[data.current.name] == false then
									LastVehicles[data.current.name] = nil
									DeleteEntity(closestVehicle)
								end

								ESX.TriggerServerCallback(
									'cr_garage:getVehicleData',
									function(vehicleData)
										if vehicleData then
											TriggerEvent(
												'cr_garage:spawnVehicle',
												vehicleData.vehicle,
												coords,
												JobManager.Job.Config.VehicleMenu.displayPoints[data.current.name].w,
												function(callbackVehicle)
													TriggerEvent('pNotify:SendNotification', {
														text = _U('vehicle_out'),
														type = "success",
														timeout = Config.Notification.timeout,
														layout = Config.Notification.layout,
														queue = "jobmanager"
													})
													LastVehicles[data.current.name] = vehicleData.vehicle.plate
													OpenVehicleList(type)
                                                    if JobManager.Job.Config.VehicleMenu.freezeVehicles == nil or JobManager.Job.Config.VehicleMenu.freezeVehicles ~= false then
                                                        Citizen.Wait(750)
                                                        FreezeEntityPosition(callbackVehicle, true)
                                                    end
												end,
												vehicleData.vStancer,
												false
											)
										else
											TriggerEvent('pNotify:SendNotification', {
												text = _U('vehicle_is_out'),
												type = "error",
												timeout = Config.Notification.timeout,
												layout = Config.Notification.layout,
												queue = "jobmanager"
											})
										end
										unblockControls()
									end,
									vehicles[data.current.value].vehicle.plate,
									"society"
								)
							elseif LastVehicles[data.current.name] and LastVehicles[data.current.name] == GetVehicleNumberPlateText(closestVehicle) then
								StockVehicle(
									closestVehicle,
									function(success)
										if success then
											ESX.TriggerServerCallback(
												'cr_garage:getVehicleData',
												function(vehicleData)
													if vehicleData then
														TriggerEvent(
															'cr_garage:spawnVehicle',
															vehicleData.vehicle,
															coords,
															JobManager.Job.Config.VehicleMenu.displayPoints[data.current.name].w,
															function(callbackVehicle)
																TriggerEvent('pNotify:SendNotification', {
																	text = _U('vehicle_out'),
																	type = "success",
																	timeout = Config.Notification.timeout,
																	layout = Config.Notification.layout,
																	queue = "jobmanager"
																})
																LastVehicles[data.current.name] = vehicleData.vehicle.plate
																if JobManager.Job.Config.VehicleMenu.freezeVehicles == nil or JobManager.Job.Config.VehicleMenu.freezeVehicles ~= false then
																	Citizen.Wait(1500)
																	FreezeEntityPosition(callbackVehicle, true)
																end
															end,
															vehicleData.vStancer,
															false
														)
													else
														TriggerEvent('pNotify:SendNotification', {
															text = _U('vehicle_is_out'),
															type = "error",
															timeout = Config.Notification.timeout,
															layout = Config.Notification.layout,
															queue = "jobmanager"
														})
													end
													unblockControls()
												end,
												vehicles[data.current.value].vehicle.plate,
												"society"
											)
										else
											TriggerEvent('pNotify:SendNotification', {
												text = _U('no_vehicle'),
												type = "error",
												timeout = Config.Notification.timeout,
												layout = Config.Notification.layout,
												queue = "jobmanager"
											})
										end
									end
								)
							else
								TriggerEvent('pNotify:SendNotification', {
									text = _U('spawn_blocked'),
									type = "error",
									timeout = Config.Notification.timeout,
									layout = Config.Notification.layout,
									queue = "jobmanager"
								})
								unblockControls()
							end

						else
							if LastVehicles[data.current.name] == false then
								LastVehicles[data.current.name] = nil
								DeleteEntity(closestVehicle)
							else
								local unblockControls = BlockControls()
								StockVehicle(
									closestVehicle,
									function(success)
										if success then
											menu.close()
											TriggerEvent('pNotify:SendNotification', {
												text = _U('vehicle_inside'),
												type = "success",
												timeout = Config.Notification.timeout,
												layout = Config.Notification.layout,
												queue = "jobmanager"
											})
											OpenVehicleList(type)
										else
											TriggerEvent('pNotify:SendNotification', {
												text = _U('no_vehicle'),
												type = "error",
												timeout = Config.Notification.timeout,
												layout = Config.Notification.layout,
												queue = "jobmanager"
											})
										end
										unblockControls()
									end
								)
							end
						end
					end
				end,
				function(data, menu)
					menu.close()
				end
				-- TODO: Add marker highlighting when hovering over specific spawn points
			)
		end,
		"society",
		type
	)
end

function OpenBuyVehicleMenu()
	local elements = {}
	local empty = true

	for k, v in pairs(JobManager.Job.Config.VehicleMenu.canBuy) do
		local hashKey = GetHashKey(k)
		if IsModelInCdimage(hashKey) then
			table.insert(
				elements,
				{
					label = GetDisplayNameFromVehicleModel(hashKey),
					value = "buy",
					model = k,
					hash = hashKey,
					price = v
				}
			)
			if empty then
				empty = false
			end
		end
	end

	if empty then
		table.insert(elements, {label = _U("no_options"), value = "close"})
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_vehicles_buy",
		{
			title = _U("buy_vehicle"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			if data.current.value == "buy" then
				local options = {
					("<span>%s</span>"):format(_U("choose_vehicle"))
				}

				for k, v in ipairs(JobManager.Job.Config.VehicleMenu.displayPoints) do
					table.insert(options, ("<span>%s</span>"):format(_U("point", k)))
				end

				local _elements = {
					{
						name = "display",
						label = _U("vehicle_display"),
						value = 0,
						type = 'slider',
						max = #options - 1,
						options = options
					}
				}

				if JobManager.Player.permissions and ((JobManager.Player.permissions.gradePermissions and (JobManager.Player.permissions.gradePermissions.vehicleMenu == true or (JobManager.Player.permissions.gradePermissions.vehicleMenu and JobManager.Player.permissions.gradePermissions.vehicleMenu.canBuyVehicles))) or (JobManager.Player.permissions.options and JobManager.Player.permissions.options.withdraw == true)) then
					table.insert(
						_elements,
						{
							name = "buy_society",
							label = _U("buy_vehicle_society", data.current.price)
						}
					)
				end

				ESX.UI.Menu.Open(
					"default",
					GetCurrentResourceName(),
					JobManager.Job.identifier .. "_vehicle_buy",
					{
						title = data.current.label,
						align = Config.Menu.layout,
						elements = _elements
					},
					function(_data, _menu)
						if _data.current.name == "display" then
							if _data.current.value < 1 then
								return
							end
							
							local point = JobManager.Job.Config.VehicleMenu.displayPoints[_data.current.value]
							local pointCoords = vector3(point.x, point.y, point.z)
							local closestVehicle = ESX.Game.GetClosestVehicle(pointCoords)

							local vehicleCoords = GetEntityCoords(closestVehicle)
							if GetDistanceBetweenCoords(vehicleCoords, pointCoords) > 2.0 then
								SpawnVehicleOnPoint(data.current.hash, _data.current.value)
							elseif LastVehicles[_data.current.value] ~= nil then
								if LastVehicles[_data.current.value] ~= false then
									StockVehicle(
										closestVehicle,
										function(success)
											if success then
												SpawnVehicleOnPoint(data.current.hash, _data.current.value)
											else
												TriggerEvent('pNotify:SendNotification', {
													text = _U('spawn_blocked'),
													type = "error",
													timeout = Config.Notification.timeout,
													layout = Config.Notification.layout,
													queue = "jobmanager"
												})
											end
										end
									)
								else
									DeleteEntity(closestVehicle)
								end
							else
								TriggerEvent('pNotify:SendNotification', {
									text = _U('spawn_blocked'),
									type = "error",
									timeout = Config.Notification.timeout,
									layout = Config.Notification.layout,
									queue = "jobmanager"
								})
							end
						elseif _data.current.name == "buy_society" then
							ESX.Game.SpawnLocalVehicle(
								data.current.hash,
								GetEntityCoords(GetPlayerPed()),
								0.0,
								function(vehicle)
									SetEntityVisible(vehicle, false)
									SetEntityCollision(vehicle, false, false)

									local blockControls = true

									ESX.TriggerServerCallback(
										'esx_jobmanager:buyVehicle',
										function(_success)
											blockControls = false
											DeleteEntity(vehicle)
											_menu.close()
										end,
										data.current.model,
										ESX.Game.GetVehicleProperties(vehicle),
										JobManager.Job.society,
										JobManager.Job.Config.VehicleMenu.type
									)
		
									Citizen.CreateThread(
										function()
											while blockControls == true do
												Citizen.Wait(0)
												DisableControlAction(1, Keys["ENTER"])
											end
										end
									)
								end
							)							
						else
							_menu.close()
						end
					end,
					function(_data, _menu)
						_menu.close()
					end
				)
			else
				menu.close()
			end
		end,
		function(data, menu)
			menu.close()
		end
	)
end


function OpenArmoryMenu()
	local elements = {
		{label = _U("remove_object"), value = "get_weapon"},
		{label = _U("deposit_object"), value = "put_weapon"}
	}

	if JobManager.Job.Config.Armory.canBuy and JobManager.Player.permissions and ((JobManager.Player.permissions.gradePermissions and JobManager.Player.permissions.gradePermissions.canBuyWeapons == true) or (JobManager.Player.permissions.options and JobManager.Player.permissions.options.withdraw)) then
		table.insert(
			elements,
			{
				label = _U("buy_weapon"),
				value = "buy_weapon"
			}
		)
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_armory",
		{
			title = _U("armory"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			if data.current.value == "put_weapon" then
				OpenPutWeaponMenu()
			elseif data.current.value == "get_weapon" then
				OpenGetWeaponMenu()
			elseif data.current.value == "buy_weapon" then
				OpenBuyWeaponMenu()
			end
		end,
		function(data, menu)
			menu.close()

			armoryAction()
		end
	)
end

function OpenPutWeaponMenu()
    local elements = {}
    local playerPed = GetPlayerPed(-1)
    local weaponList = ESX.GetWeaponList()

    for i = 1, #weaponList, 1 do
        local weaponHash = GetHashKey(weaponList[i].name)

        if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= "WEAPON_UNARMED" then
            local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
            table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
        end
    end

    ESX.UI.Menu.Open(
        "default",
        GetCurrentResourceName(),
        JobManager.Job.identifier .. "_weapon_put",
        {
            title = _U("put_weapon_menu"),
            align = Config.Menu.layout,
            elements = elements
        },
        function(data, menu)
            menu.close()
			ESX.TriggerServerCallback(
				"esx_jobmanager:addArmoryWeapon",
				function()
					OpenPutWeaponMenu()
				end,
				data.current.value
			)
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenGetWeaponMenu()
	ESX.TriggerServerCallback(
		'esx_jobmanager:getArmoryWeapons',
		function(weapons)
			if weapons then
				local elements = {}
	
				for k, v in pairs(weapons) do
					if #v > 0 then
						table.insert(
							elements,
							{
								label = #v .. "x " .. ESX.GetWeaponLabel(k),
								value = k
							}
						)
					end
				end

				ESX.UI.Menu.Open(
					"default",
					GetCurrentResourceName(),
					JobManager.Job.identifier .. "_weapon_get",
					{
						title = _U("get_weapon_menu"),
						align = Config.Menu.layout,
						elements = elements
					},
					function(data, menu)
						local _elements = {}

						for i, ammo in pairs(weapons[data.current.value]) do
							table.insert(
								_elements,
								{
									label = _U("bullets", ammo),
									value = i
								}
							)
						end

						ESX.UI.Menu.Open(
							"default",
							GetCurrentResourceName(),
							JobManager.Job.identifier .. "_weapon_get_final",
							{
								title = ESX.GetWeaponLabel(data.current.value),
								align = Config.Menu.layout,
								elements = _elements
							},
							function(_data, _menu)
								_menu.close()
								menu.close()
								ESX.TriggerServerCallback(
									"esx_jobmanager:removeArmoryWeapon",
									function()
										OpenGetWeaponMenu()
									end,
									data.current.value,
									_data.current.value
								)
							end,
							function(_data, _menu)
								_menu.close()
							end
						)
					end,
					function(data, menu)
						menu.close()
					end
				)
			end
		end,
		JobManager.Job.society
	)
end

function OpenBuyWeaponMenu()
	local elements = {}

	if not JobManager.Job.Config.Armory.canBuy then
		return
	end

	for k, v in ipairs(JobManager.Job.Config.Armory.canBuy) do
		local weaponName = v.label and v.label or ESX.GetWeaponLabel(v.item)
		if weaponName then
			table.insert(
				elements,
				{
					label = weaponName .. " ($" .. v.price .. ")",
					value = v.item
				}
			)
		end
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_buy_weapon",
		{
			title = _U("buy_weapon"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			menu.close()

			ESX.UI.Menu.Open(
				"dialog",
				GetCurrentResourceName(),
				"billing",
				{
					title = _U("quantity")
				},
				function(_data, _menu)
					local quantity = tonumber(_data.value)
					_menu.close()

					if quantity == nil then
						TriggerEvent('pNotify:SendNotification', {
							text = _U('quantity_invalid'),
							type = "error",
							timeout = Config.Notification.timeout,
							layout = Config.Notification.layout,
							queue = "jobmanager"
						})
					else
						local unblockControls = BlockControls()
						ESX.TriggerServerCallback(
							'esx_jobmanager:buyWeapon',
							function()
								unblockControls()
							end,
							data.current.value,
							quantity
						)
					end
				end,
				function(_data, _menu)
					_menu.close()
				end
			)        
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function OpenVehicleSpawnerMenu(spawner)
	if not (JobManager.Job.Config and JobManager.Job.Config.VehicleMenu and JobManager.Job.Config.VehicleMenu.spawner and JobManager.Job.Config.VehicleMenu.spawner[spawner] and JobManager.Job.Config.VehicleMenu.spawner.vehicles) then
		return
	end

	local coords = vector3(JobManager.Job.Config.VehicleMenu.spawner[spawner].x, JobManager.Job.Config.VehicleMenu.spawner[spawner].y, JobManager.Job.Config.VehicleMenu.spawner[spawner].z)
	local heading = JobManager.Job.Config.VehicleMenu.spawner[spawner].w

	local elements = {}

	for k, v in pairs(JobManager.Job.Config.VehicleMenu.spawner.vehicles) do
		if v.label:sub(1,2) == "--" then
			table.insert(
				elements,
				{
					label = v.label,
					value = "-"
				}
			)
		elseif v.model then
			local hash = GetHashKey(v.model)
			if IsModelInCdimage(hash) then
				local label = v.label and v.label or GetDisplayNameFromVehicleModel(v.model)
				table.insert(
					elements,
					{
						label = label,
						value = hash
					}
				)
			end
		end
	end

	ESX.UI.Menu.Open(
		"default",
		GetCurrentResourceName(),
		JobManager.Job.identifier .. "_vehicle_spawner",
		{
			title = _U("vehicle_spawner"),
			align = Config.Menu.layout,
			elements = elements
		},
		function(data, menu)
			if data.current.value ~= "-" then
				SpawnVehicle(data.current.value, coords, heading)
			end
			menu.close()
			vehicleSpawnerAction(spawner)
		end,
		function(data, menu)
			menu.close()
		end
	)
end