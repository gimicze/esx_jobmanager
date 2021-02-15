
function actionDefault()
	CurrentActionMsg = _U("press_to_open")
	CurrentActionData = {}
end

function stockAction()
	CurrentAction = "menu_stock"
	actionDefault()
end

function armoryAction()
	CurrentAction = "menu_armory"
	actionDefault()
end

function bossMenuAction()
	CurrentAction = "menu_boss_actions"
	actionDefault()
end

function dutyAction()
	CurrentAction = "menu_duty"
	actionDefault()
end

function carDisplayAction()
	CurrentAction = "menu_vehicle_display"
	actionDefault()
end

function vehicleSpawnerAction(spawner)
	CurrentAction = "menu_spawner"
	CurrentActionMsg = _U("press_to_open")
	CurrentActionData = {
		spawner = spawner
	}
end

function removePropAction(entity)
	CurrentActionMsg = _U("press_to_remove")
	CurrentActionData = {
		entity = entity
	}
	CurrentAction = "prop_remove"
end

AddEventHandler(
	"esx_jobmanager:hasEnteredMarker",
	function(part, partNum)
		if part == "Stock" then
			stockAction()
		elseif part == "BossMenu" then
			bossMenuAction()
		elseif part == "Duty" then
			dutyAction()
		elseif part == "VehicleMenu" then
			carDisplayAction()
		elseif part == "VehicleSpawner" then
			vehicleSpawnerAction(partNum)
		elseif part == "Armory" then
			armoryAction()
		end
	end
)

AddEventHandler(
	"esx_jobmanager:hasExitedMarker",
	function(part, partNum)
		ESX.UI.Menu.CloseAll()
		CurrentAction = nil
	end
)

-- Display markers
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(1)

			if JobManager.Job.loaded then
				local playerPed = PlayerPedId()
				local coords = GetEntityCoords(playerPed)
				if JobManager.Player.onDuty or JobManager.Job.Config.Duty == nil or not JobManager.Job.Config.Duty.enabled then
					if JobManager.Job.Config.BossMenu.enabled and JobManager.Player:canAccessBossMenu() then
						for k, v in ipairs(JobManager.Job.Config.BossMenu) do
							if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) > Config.MarkerSize.x then
								DrawMarker(Config.MarkerType.BossMenu, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 40, false, true, 2, true, false, false, false)
							elseif IsInMarker then
								DrawMarker(Config.MarkerType.BossMenu, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 155, true, true, 2, true, false, false, false)
								ESX.Game.Utils.DrawText3D(v + vector3(0.00, 0.00, 0.50), JobManager.Job.Config.BossMenu.text, 1.0)
							end
						end
					end
					if JobManager.Job.Config.Stock ~= nil and JobManager.Job.Config.Stock.enabled then
						for k, v in ipairs(JobManager.Job.Config.Stock) do
							if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) > Config.MarkerSize.x then
								DrawMarker(Config.MarkerType.Stock, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 40, false, true, 2, true, false, false, false)
							elseif IsInMarker then
								DrawMarker(Config.MarkerType.Stock, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 155, true, true, 2, true, false, false, false)
								ESX.Game.Utils.DrawText3D(v + vector3(0.00, 0.00, 0.50), JobManager.Job.Config.Stock.text, 1.0)
							end
						end
					end
					if JobManager.Job.Config.VehicleMenu ~= nil and JobManager.Job.Config.VehicleMenu.enabled then
						if JobManager.Job.Config.VehicleMenu.menu then
							for k, v in ipairs(JobManager.Job.Config.VehicleMenu.menu) do
								if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) > Config.MarkerSize.x then
									DrawMarker(Config.MarkerType.VehicleMenu, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 40, false, true, 2, true, false, false, false)
								elseif IsInMarker then
									DrawMarker(Config.MarkerType.VehicleMenu, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 155, true, true, 2, true, false, false, false)
									ESX.Game.Utils.DrawText3D(v + vector3(0.00, 0.00, 0.50), JobManager.Job.Config.VehicleMenu.text, 1.0)
								end
							end
						end
						if JobManager.Job.Config.VehicleMenu.spawner then
							for k, v in ipairs(JobManager.Job.Config.VehicleMenu.spawner) do
								local inVehicle = (GetVehiclePedIsIn(GetPlayerPed(-1), false) ~= 0)
								if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) > (inVehicle and Config.MarkerSize.x * 2 or Config.MarkerSize.x) then
									DrawMarker(Config.MarkerType.VehicleSpawner, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 150, false, false, 2, false, false, false, false)
								elseif IsInMarker then
									local text = inVehicle and "[E] " .. _U("vehicle_delete") or "[E] " .. _U("vehicle_spawner")
									DrawMarker(Config.MarkerType.VehicleSpawner, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 200, false, true, 2, true, false, false, false)
									ESX.Game.Utils.DrawText3D(vector3(v.x, v.y, v.z + 0.75), text, 1.0)
								end
							end
						end
					end
					if JobManager.Job.Config.Armory ~= nil and JobManager.Job.Config.Armory.enabled then
						for k, v in ipairs(JobManager.Job.Config.Armory) do
							if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) > Config.MarkerSize.x then
								DrawMarker(Config.MarkerType.Armory, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 40, false, true, 2, true, false, false, false)
							elseif IsInMarker then
								DrawMarker(Config.MarkerType.Armory, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 155, true, true, 2, true, false, false, false)
								ESX.Game.Utils.DrawText3D(v + vector3(0.00, 0.00, 0.50), JobManager.Job.Config.Armory.text, 1.0)
							end
						end
					end
				end
				if JobManager.Job.Config.Duty ~= nil and JobManager.Job.Config.Duty.enabled then
					for k, v in ipairs(JobManager.Job.Config.Duty) do
						if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) > Config.MarkerSize.x then
							DrawMarker(Config.MarkerType.Duty, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 40, false, true, 2, true, false, false, false)
						elseif IsInMarker then
							DrawMarker(Config.MarkerType.Duty, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 155, false, true, 2, true, false, false, false)
							ESX.Game.Utils.DrawText3D(v + vector3(0.00, 0.00, 0.75), JobManager.Job.Config.Duty.text, 1.0)
						end
					end
				end
			else 
				Citizen.Wait(1500)
			end
		end
	end
)

-- Enter / Exit marker events
Citizen.CreateThread(
	function()
		while true do
			Citizen.Wait(10)

			if JobManager.Job.loaded then
				local playerPed = PlayerPedId()
				local coords = GetEntityCoords(playerPed)
				local currentMenu = nil
				local currentMenuNum = nil
				IsInMarker = false

				if JobManager.Player.onDuty or JobManager.Job.Config.Duty == nil or not JobManager.Job.Config.Duty.enabled then
					if JobManager.Job.Config.BossMenu.enabled and JobManager.Player:canAccessBossMenu() then
						for k, v in ipairs(JobManager.Job.Config.BossMenu) do
							if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true ) < Config.MarkerSize.x then
								currentMenu = "BossMenu"
								currentMenuNum = i
							end
						end
					end
					
					if JobManager.Job.Config.Stock ~= nil and JobManager.Job.Config.Stock.enabled then
						for k, v in ipairs(JobManager.Job.Config.Stock) do
							if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true ) < Config.MarkerSize.x then
								currentMenu = "Stock"
								currentMenuNum = i
							end
						end
					end

					if JobManager.Job.Config.VehicleMenu ~= nil and JobManager.Job.Config.VehicleMenu.enabled then
						if JobManager.Job.Config.VehicleMenu.menu then
							for k, v in ipairs(JobManager.Job.Config.VehicleMenu.menu) do
								if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true ) < Config.MarkerSize.x then
									currentMenu = "VehicleMenu"
									currentMenuNum = i
								end
							end
						end

						if JobManager.Job.Config.VehicleMenu.spawner then
							for k, v in ipairs(JobManager.Job.Config.VehicleMenu.spawner) do
								local inVehicle = (GetVehiclePedIsIn(GetPlayerPed(-1), false) ~= 0)
								if GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true ) < (inVehicle and Config.MarkerSize.x * 2 or Config.MarkerSize.x) then
									currentMenu = "VehicleSpawner"
									currentMenuNum = k
								end
							end
						end
					end

					if JobManager.Job.Config.Armory ~= nil and JobManager.Job.Config.Armory.enabled then
						for k, v in ipairs(JobManager.Job.Config.Armory) do
							if GetDistanceBetweenCoords( coords, v.x, v.y, v.z, true ) < Config.MarkerSize.x then
								currentMenu = "Armory"
								currentMenuNum = i
							end
						end
					end
				end
				
				if JobManager.Job.Config.Duty ~= nil and JobManager.Job.Config.Duty.enabled then
					for k, v in ipairs(JobManager.Job.Config.Duty) do
						if GetDistanceBetweenCoords( coords, v.x, v.y, v.z, true ) < Config.MarkerSize.x then
							currentMenu = "Duty"
							currentMenuNum = i
						end
					end
				end

				IsInMarker = (currentMenu ~= nil)

				local hasExited = false

				if IsInMarker and (not HasAlreadyEnteredMarker or (LastMenu ~= currentMenu or LastMenuNum ~= currentMenuNum)) then
					if (LastStation ~= nil and LastMenu ~= nil and LastMenuNum ~= nil) and (LastStation ~= currentStation or LastMenu ~= currentMenu or LastMenuNum ~= currentMenuNum) then
						TriggerEvent("esx_jobmanager:hasExitedMarker", LastMenu, LastMenuNum)
						hasExited = true
					end

					HasAlreadyEnteredMarker = true
					LastMenu = currentMenu
					LastMenuNum = currentMenuNum

					TriggerEvent("esx_jobmanager:hasEnteredMarker", currentMenu, currentMenuNum)
				end

				if not hasExited and not IsInMarker and HasAlreadyEnteredMarker then
					HasAlreadyEnteredMarker = false
					TriggerEvent("esx_jobmanager:hasExitedMarker", LastMenu, LastMenuNum)
				end
			else
				Citizen.Wait(1500)
			end
		end
	end
)

-- Key Controls
Citizen.CreateThread(
    function()
        while true do
			Citizen.Wait(10)
			if JobManager.Job.loaded then
				if CurrentAction ~= nil then
					ESX.ShowHelpNotification(CurrentActionMsg)

					if IsControlJustReleased(0, Keys["E"]) then
						if JobManager.Player.onDuty then
							if CurrentAction == "menu_stock" then
								OpenStockMenu()
							elseif CurrentAction == "menu_boss_actions" then
								ESX.UI.Menu.CloseAll()
								TriggerEvent(
									"esx_society:openBossMenu",
									JobManager.Job.identifier,
									function(data, menu)
										menu.close()
										bossMenuAction()
									end
								)
							elseif CurrentAction == "menu_vehicle_display" then
								OpenVehicleMenu()
							elseif CurrentAction == "menu_spawner" then
								local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
								if vehicle ~= 0 then
									DeleteEntity(vehicle)
								else
									OpenVehicleSpawnerMenu(CurrentActionData.spawner)
								end
							elseif CurrentAction == "menu_armory" then
								OpenArmoryMenu()
							elseif CurrentAction == "prop_remove" then
								if CurrentActionData and CurrentActionData.entity then
									DeleteEntity(CurrentActionData.entity)
								end
							end
						end
						if CurrentAction == "menu_duty" then
							OpenDutyMenu()
						end
						CurrentAction = nil
					end -- CurrentAction end
				else
					if JobManager.Player.onDuty and IsControlJustReleased(0, Keys["F6"]) and not isDead and not ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), JobManager.Job.identifier) then
						OpenJobActionsMenu()
					end
				end					
			else
				Citizen.Wait(1500)
			end
		end
	end
)

-- Create job blips
Citizen.CreateThread(
	function()
		for k, v in pairs(Config.Jobs) do
			if v.Settings.Blips then
				for _k, _v in pairs(v.Settings.Blips) do
					if _v.enabled then
						local blip = AddBlipForCoord(
							_v.pos.x,
							_v.pos.y,
							_v.pos.z
						)
			
						SetBlipSprite(blip, _v.sprite)
						SetBlipDisplay(blip, _v.display)
						SetBlipScale(blip, _v.scale)
						SetBlipColour(blip, _v.colour)
						SetBlipAsShortRange(blip, true)
				
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(_v.name or v.Settings.name)
						EndTextCommandSetBlipName(blip)
					end
				end
			end
		end
	end
)

-- Prop removal
Citizen.CreateThread(
	function()
		local isNearProp = false
		local propFilter = nil
		while true do
			if JobManager.Job.loaded and JobManager.Job.Config.Settings and JobManager.Job.Config.Settings.propSpawner then
				if propFilter == nil then
					propFilter = {}
					for k, v in ipairs(JobManager.Job.Config.Settings.propSpawner) do
						table.insert(propFilter, v.prop)
					end
				end
				local coords = GetEntityCoords(GetPlayerPed(-1))
				local closestObject, objectDistance = ESX.Game.GetClosestObject(propFilter, coords)
				
				if not isNearProp and objectDistance > 0 and objectDistance <= 1.5 then
					isNearProp = true
					removePropAction(closestObject)
				elseif isNearProp and (objectDistance < 0 or objectDistance > 1.5) then
					isNearProp = false
					CurrentAction = nil
				end
				Citizen.Wait(150)
			else
				if propFilter then
					propFilter = nil
				end
				Citizen.Wait(10000)
			end
		end
	end
)