function StockVehicle(vehicle, callback)
	local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

	TriggerEvent('pNotify:SendNotification', {
		text = _U('storing_vehicle'),
		type = "info",
		timeout = Config.Notification.timeout / 2,
		layout = Config.Notification.layout,
		queue = "jobmanager"
	})

	ESX.TriggerServerCallback(
		"eden_garage:stockv",
		function(response)
			if response then
				TriggerEvent("core:leftVehicle", vehicle)
				Citizen.Wait(200)
				ESX.Game.DeleteVehicle(vehicle)
				TriggerServerEvent("eden_garage:modifystored", vehicleProps, true)

				Citizen.Wait(200)
				if callback then
					callback(true)
				end
			elseif callback then
				callback(false)
			end
		end,
		vehicleProps,
		vehicleProps.model
	)
end

function RepairNearestVehicle()
	local vehicle = ESX.Game.GetClosestVehicle()

	if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(vehicle)) < 4.0 then
		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleUndriveable(vehicle, false)

		TriggerServerEvent('discord:logSystem', "Repaired a vehicle.")
		TriggerEvent('pNotify:SendNotification', {
			text = _U('vehicle_repaired'),
			type = "success",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
	else
		TriggerEvent('pNotify:SendNotification', {
			text = _U('no_vehicle_nearby'),
			type = "error",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
	end
end

function CleanNearestVehicle()
	local vehicle   = ESX.Game.GetClosestVehicle()

	if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(vehicle)) < 4.0 then
		SetVehicleDirtLevel(vehicle, 0)

		TriggerServerEvent('discord:logSystem', "Cleaned a vehicle.")
		TriggerEvent('pNotify:SendNotification', {
			text = _U('vehicle_cleaned'),
			type = "success",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
	else
		TriggerEvent('pNotify:SendNotification', {
			text = _U('no_vehicle_nearby'),
			type = "error",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
	end
end

function UnlockNearestVehicle()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetClosestVehicle()

	if IsPedSittingInAnyVehicle(playerPed) then
		TriggerEvent('pNotify:SendNotification', {
			text = _U('inside_vehicle'),
			type = "error",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
		return
	end

	if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(vehicle)) < 4.0 then
		isBusy = true
		TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)     
		Citizen.CreateThread(function()
			Citizen.Wait(10000)

			SetVehicleDoorsLocked(vehicle, 0)
			SetVehicleDoorsLockedForAllPlayers(vehicle, false)
			ClearPedTasksImmediately(playerPed)

			TriggerEvent('pNotify:SendNotification', {
				text = _U('vehicle_unlocked'),
				type = "success",
				timeout = Config.Notification.timeout,
				layout = Config.Notification.layout,
				queue = "jobmanager"
			})
			TriggerServerEvent('discord:logSystem', "Unlocked a vehicle.")
			isBusy = false
		end)
	else
		TriggerEvent('pNotify:SendNotification', {
			text = _U('no_vehicle_nearby'),
			type = "error",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
	end
end

function RemoveNearestVehicle()
	local playerPed = PlayerPedId()
	local vehicle = nil

	if IsPedSittingInAnyVehicle(playerPed) then
		vehicle = GetVehiclePedIsIn(playerPed)
	else
		vehicle = ESX.Game.GetClosestVehicle()
	end

	if DoesEntityExist(vehicle) and GetDistanceBetweenCoords(GetEntityCoords(vehicle), GetEntityCoords(playerPed)) < 4.0 then
		DeleteEntity(vehicle)
		TriggerEvent('pNotify:SendNotification', {
			text = _U('vehicle_removed'),
			type = "success",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
	else
		TriggerEvent('pNotify:SendNotification', {
			text = _U('no_vehicle_nearby'),
			type = "error",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
	end
end

function TowVehicle()
	if not Config.TowVehicles then
		TriggerEvent('pNotify:SendNotification', {
			text = _U('no_tow_vehicles'),
			type = "error",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
	end

	local playerPed = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerPed, true)

	local isVehicleTow = false
	local vehicleData = nil

	for k, v in pairs(Config.TowVehicles) do
		isVehicleTow = IsVehicleModel(vehicle, GetHashKey(k))
		if isVehicleTow then
			vehicleData = v
			break
		end
	end

	if isVehicleTow then
		local towCoords = GetOffsetFromEntityInWorldCoords(vehicle, vehicleData.loadOffset.x, vehicleData.loadOffset.y, vehicleData.loadOffset.z)
		local vehiclesInArea = ESX.Game.GetVehiclesInArea(towCoords, 10.0)
		local minDistance = nil
		local targetVehicle = nil

		for k, v in pairs(vehiclesInArea) do
			if v ~= vehicle then
				local distance = GetDistanceBetweenCoords(towCoords, GetEntityCoords(v))
				if minDistance == nil then
					minDistance = distance
					targetVehicle = v
				else
					if distance < minDistance then
						minDistance = distance
						targetVehicle = v
					end
				end
			end
		end

		local closestVehicle = ESX.Game.GetClosestVehicle(GetOffsetFromEntityInWorldCoords(vehicle, vehicleData.towOffset.x, vehicleData.towOffset.y, vehicleData.towOffset.z))
		local towedVehicle = nil

		if IsEntityAttachedToEntity(closestVehicle, vehicle) then
			towedVehicle = closestVehicle
		end

		if towedVehicle == 0 or towedVehicle == nil then
			if targetVehicle == nil or targetVehicle == 0 then
				TriggerEvent('pNotify:SendNotification', {
					text = _U('no_vehicle_nearby'),
					type = "error",
					timeout = Config.Notification.timeout,
					layout = Config.Notification.layout,
					queue = "jobmanager"
				})
			else
				if vehicle ~= targetVehicle then
					AttachEntityToEntity(targetVehicle, vehicle, 20, vehicleData.towOffset.x, vehicleData.towOffset.y, vehicleData.towOffset.z, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					CurrentlyTowedVehicle = targetVehicle
					TriggerEvent('pNotify:SendNotification', {
						text = _U('vehicle_attached'),
						type = "success",
						timeout = Config.Notification.timeout,
						layout = Config.Notification.layout,
						queue = "jobmanager"
					})
				end
			end
		else
			local closestVehicle = ESX.Game.GetClosestVehicle(towCoords)
			if closestVehicle ~= towedVehicle and GetDistanceBetweenCoords(towCoords, GetEntityCoords(closestVehicle)) < 3.0 then
				TriggerEvent('pNotify:SendNotification', {
					text = _U('spawn_blocked'),
					type = "error",
					timeout = Config.Notification.timeout,
					layout = Config.Notification.layout,
					queue = "jobmanager"
				})
				return
			end
			AttachEntityToEntity(towedVehicle, vehicle, 20, vehicleData.unloadOffset.x, vehicleData.unloadOffset.y, vehicleData.unloadOffset.z, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			DetachEntity(towedVehicle, true, true)

			CurrentlyTowedVehicle = nil
			TriggerEvent('pNotify:SendNotification', {
				text = _U('vehicle_detached'),
				type = "success",
				timeout = Config.Notification.timeout,
				layout = Config.Notification.layout,
				queue = "jobmanager"
			})
		end
	else
		TriggerEvent('pNotify:SendNotification', {
			text = _U('not_a_tow'),
			type = "error",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
	end		
end

function SpawnVehicleOnPoint(hash, point)
	if not (JobManager.Job.Config.VehicleMenu and JobManager.Job.Config.VehicleMenu.displayPoints and JobManager.Job.Config.VehicleMenu.displayPoints[point]) then
		return
	end

	local unblockControls = BlockControls()
	local pointVector = JobManager.Job.Config.VehicleMenu.displayPoints[point]
	local pointCoords = vector3(pointVector.x, pointVector.y, pointVector.z)

	TriggerEvent('pNotify:SendNotification', {
		text = _U('loading_model'),
		type = "info",
		timeout = Config.Notification.timeout / 2,
		layout = Config.Notification.layout,
		queue = "jobmanager"
	})

	ESX.Game.SpawnVehicle(
		hash,
		pointCoords,
		pointVector.w,
		function(vehicle)
			TriggerEvent('pNotify:SendNotification', {
				text = _U('vehicle_on_display'),
				type = "success",
				timeout = Config.Notification.timeout,
				layout = Config.Notification.layout,
				queue = "jobmanager"
			})
			LastVehicles[point] = false
			unblockControls()
			if JobManager.Job.Config.VehicleMenu.freezeVehicles ~= false then
				Citizen.Wait(500)
				FreezeEntityPosition(vehicle, true)
			end
		end
	)
end

function SpawnVehicle(hash, coords, heading, warpPedIntoVehicle)
	local hash = (type(hash) == "number") and hash or GetHashKey(hash)
	local warpPedIntoVehicle = warpPedIntoVehicle and warpPedIntoVehicle or true
	local unblockControls = BlockControls()

	ESX.Game.SpawnVehicle(
		hash,
		coords,
		heading,
		function(vehicle)
			unblockControls()
			if warpPedIntoVehicle then
				SetPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
			end
		end
	)
end

function BlockControls()
	local blockControls = true

	Citizen.CreateThread(
		function()
			BeginTextCommandBusyspinnerOn("STRING")
			AddTextComponentSubstringPlayerName(_U("loading"))
			EndTextCommandBusyspinnerOn(4)
			
			while blockControls == true do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			BusyspinnerOff()
		end
	)

	return function()
		blockControls = false
	end
end