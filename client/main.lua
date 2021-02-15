Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

HasAlreadyEnteredMarker = false
LastMenu = nil
LastMenuNum = nil
CurrentAction = nil
CurrentActionMsg = ""
CurrentActionData = {}
LastVehicles = {}
isBusy = false
hasAlreadyJoined = false
isDead = false
IsInMarker = false
JobManager = {
	Job = {
		Config = {},
		loaded = false,
		identifier = nil,
		society = nil
	},
	Player = {
		id = GetPlayerServerId(PlayerId()),
		onDuty = true,
		handcuffed = false,
		dragged = false,
		draggedBy = nil,
		attached = false
	},
	vStancer = Config.vStancer
}
CurrentlyTowedVehicle = nil

ESX = nil

function JobManager:LoadJob()
	self.Job.Config = {}
	self.Job.loaded = false
	self.Job.identifier = nil
	self.Job.society = nil
	self.Player.onDuty = true
	self.Player.permissions = nil
	for k, v in pairs(Config.Jobs) do
		if ESX.PlayerData.job.name == k or ESX.PlayerData.job.name == "off_" .. k then
			self.Job.Config = v
			self.Job.society = "society_" .. k
			self.Player.onDuty = (ESX.PlayerData.job.name ~= "off_" .. k)
			self.Job.loaded = true
			self.Job.identifier = k
			
			local loaded = false

			ESX.TriggerServerCallback(
				'esx_jobmanager:getPermissions',
				function(result)
					loaded = true
					self.Player.permissions = result
				end
			)

			while not loaded do
				Citizen.Wait(200)
			end

			print(string.format("Loaded job %s with grade %s", ESX.PlayerData.job.name, ESX.PlayerData.job.grade_name))
		end
	end
end

function JobManager.Player:canAccessBossMenu()
	return self.permissions ~= nil and self.permissions.options ~= nil and next(self.permissions.options) ~= nil
end

Citizen.CreateThread(
	function()
		while ESX == nil do
			TriggerEvent(
				"esx:getSharedObject",
				function(obj)
					ESX = obj
				end
			)
			Citizen.Wait(0)
		end

		while ESX.GetPlayerData().job == nil do
			Citizen.Wait(10)
		end

		ESX.PlayerData = ESX.GetPlayerData()

		JobManager:LoadJob()
	end
)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
	"esx:playerLoaded",
	function(xPlayer)
		ESX.PlayerData = xPlayer
	end
)

RegisterNetEvent("esx:setJob")
AddEventHandler(
	"esx:setJob",
	function(job)
		ESX.PlayerData.job = job
		JobManager:LoadJob()
	end
)

RegisterNetEvent('esx_jobmanager:revive')
AddEventHandler('esx_jobmanager:revive', function()
	local playerPed = GetPlayerPed(-1)
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('esx_jobmanager:setDeathStatus', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end

		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}

		ESX.SetPlayerData('lastPosition', formattedCoords)

		TriggerServerEvent('esx:updateLastPosition', formattedCoords)

		RespawnPed(playerPed, formattedCoords, 0.0)

		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
	end)
end)

RegisterNetEvent('esx_jobmanager:heal')
AddEventHandler('esx_jobmanager:heal', function(healType, quiet)
	local playerPed = GetPlayerPed(-1)
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		print(playerPed, newHealth, maxHealth)
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		TriggerEvent('pNotify:SendNotification', {
			text = _U('healed'),
			type = "success",
			timeout = Config.Notification.timeout,
			layout = Config.Notification.layout,
			queue = "jobmanager"
		})
	end
end)

RegisterNetEvent("esx_jobmanager:putInVehicle")
AddEventHandler(
	"esx_jobmanager:putInVehicle",
	function()
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)

		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) and not IsPedInAnyVehicle(playerPed) then
			local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)

			if DoesEntityExist(vehicle) then
				local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
				local freeSeat = nil

				for i = maxSeats, 0, -1 do
					if IsVehicleSeatFree(vehicle, i) then
						freeSeat = i
						break
					end
				end

				if freeSeat ~= nil then
					TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
					if JobManager.Player.dragged then
						JobManager.Player.dragged = false
						JobManager.Player.draggedBy = nil
						JobManager.Player.attached = false
					end
				end
			end
		end
	end
)

RegisterNetEvent("esx_jobmanager:takeOutOfVehicle")
AddEventHandler(
	"esx_jobmanager:takeOutOfVehicle",
	function()
		local playerPed = GetPlayerPed(-1)

		if IsPedInAnyVehicle(playerPed) then
			Citizen.CreateThread(function()
				ClearPedTasksImmediately(ped)
	
				plyPos = GetEntityCoords(playerPed, true)
				local xnew = plyPos.x + 2
				local ynew = plyPos.y + 2
		
				SetEntityCoords(playerPed, xnew, ynew, plyPos.z)

				if JobManager.Player.handcuffed then
					RequestAnimDict('mp_arresting')
					while not HasAnimDictLoaded('mp_arresting') do
						Citizen.Wait(100)
					end
					
					ClearPedSecondaryTask(playerPed)
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
				end
			end)
		end
	end
)

RegisterNetEvent('esx_jobmanager:drag')
AddEventHandler('esx_jobmanager:drag', function(ped)
	JobManager.Player.dragged = not JobManager.Player.dragged
	JobManager.Player.draggedBy = ped

	if JobManager.Player.dragged then
		AttachEntityToEntity(
			GetPlayerPed(-1),
			GetPlayerPed(GetPlayerFromServerId(JobManager.Player.draggedBy)),
			11816,
			0.54,
			0.54,
			0.0,
			0.0,
			0.0,
			0.0,
			false,
			false,
			false,
			false,
			2,
			true
		)
		JobManager.Player.attached = true
	else 
		DetachEntity(GetPlayerPed(-1), true, false)
		JobManager.Player.attached = false
	end
end)

RegisterNetEvent('esx_jobmanager:handcuff')
AddEventHandler('esx_jobmanager:handcuff', function()
	JobManager.Player.handcuffed = not JobManager.Player.handcuffed

	local playerPed = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(playerPed, false)
   
	Citizen.CreateThread(function()
		if JobManager.Player.handcuffed then
			ClearPedTasks(playerPed)
			SetPedCanPlayAmbientBaseAnims(playerPed, true)

			Citizen.Wait(10)

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			RequestAnimDict('mp_arrest_paired')
			while not HasAnimDictLoaded('mp_arrest_paired') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, "mp_arrest_paired", "crook_p2_back_right", 8.0, -8, -1, 32, 0, 0, 0, 0)
			Citizen.Wait(5000)
			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, GetHashKey('WEAPON_UNARMED'), true)
			SetPedCanPlayGestureAnims(playerPed, false)
			DisplayRadar(false)
		else
			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
			DisplayRadar(true)
		end
	end)
end)

AddEventHandler(
	"playerSpawned",
	function(spawn)
		isDead = false
		if not hasAlreadyJoined then
			TriggerServerEvent("esx_jobmanager:spawned")
		end
		hasAlreadyJoined = true
	end
)

AddEventHandler(
	"esx:onPlayerDeath",
	function(data)
		isDead = true
	end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1)
            local playerPed = GetPlayerPed(-1)

            if JobManager.Player.handcuffed then
                DisableControlAction(2, 24, true) -- Attack
                DisableControlAction(2, 257, true) -- Attack 2
                DisableControlAction(2, 25, true) -- Aim
                DisableControlAction(2, 263, true) -- Melee Attack 1
                DisableControlAction(2, Keys["R"], true) -- Reload
                DisableControlAction(2, Keys["SPACE"], true) -- Jump
                DisableControlAction(2, Keys["LEFTSHIFT"], true) -- Sprint
                DisableControlAction(2, Keys["H"], true)
                DisableControlAction(2, Keys["Q"], true) -- Cover
                DisableControlAction(2, Keys["TAB"], true) -- Select Weapon
                DisableControlAction(2, Keys["F"], true) -- Also 'enter'?
                DisableControlAction(2, Keys["F1"], true) -- Disable phone
                DisableControlAction(2, Keys["F2"], true) -- Inventory
                DisableControlAction(2, Keys["F5"], true) -- Animations
                DisableControlAction(2, Keys["X"], true) -- Disable clearing animation
                DisableControlAction(2, Keys["V"], true) -- Disable changing view
                DisableControlAction(2, Keys["X"], true) -- Disable clearing animation
                DisableControlAction(2, Keys["P"], true) -- Disable pause screen
                DisableControlAction(2, 59, true) -- Disable steering in vehicle
                DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth
                DisableControlAction(0, 47, true) -- Disable weapon
                DisableControlAction(0, 264, true) -- Disable melee
                DisableControlAction(0, 257, true) -- Disable melee
                DisableControlAction(0, 140, true) -- Disable melee
                DisableControlAction(0, 141, true) -- Disable melee
                DisableControlAction(0, 142, true) -- Disable melee
                DisableControlAction(0, 143, true) -- Disable melee
                DisableControlAction(0, 75, true) -- Disable exit vehicle
                DisableControlAction(27, 75, true) -- Disable exit vehicle
                DisableControlAction(1, 323, true) -- X
                DisableControlAction(0, 26, true) -- G
                DisableControlAction(0, 29, true) -- B (point)
            else
                Citizen.Wait(1000)
            end
        end
    end
)
