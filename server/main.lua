-- TODO: Encapsulate all the events with checkPermissions()

ESX = nil

LastJob = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

for k, v in pairs(Config.Jobs) do
	local jobName = k
	local societyName = "society_" .. jobName
	v.Settings.societyName = societyName
	print(string.format("Registering society %s for job %s", societyName, jobName))
	TriggerEvent('esx_society:registerSociety', jobName, v.Settings.name, societyName, societyName, societyName, {type = 'public'})
	if v.Duty and v.Duty.enabled then
		jobName = "off_" .. jobName
		societyName = "society_" .. jobName
		print(string.format("Registering society %s for job %s", societyName, jobName))
		TriggerEvent('esx_society:registerSociety', jobName, v.Settings.name, societyName, societyName, societyName, {type = 'public'})
	end
	if v.PhoneContact and v.PhoneContact.enabled then
		print(string.format("Registering phone number ---> %q", k, k))
		TriggerEvent('esx_phone:registerNumber', k, v.Settings.name, true, true)
	end
	if v.Stock and v.Stock.canBuy and type(v.Stock.canBuy) == "table" then
		local newTable = {}
		for _k, _v in ipairs(v.Stock.canBuy) do
			if _v.item and _v.label and _v.price then
				local key = _v.item
				_v.item = nil
				newTable[key] = _v
			end
		end
		v.Stock.canBuy = newTable
	end
	if v.Armory and v.Armory.canBuy and type(v.Armory.canBuy) == "table" then
		local newTable = {}
		for _k, _v in ipairs(v.Armory.canBuy) do
			if _v.item and _v.price then
				local key = _v.item
				_v.item = nil
				newTable[key] = _v
			end
		end
		v.Armory.canBuy = newTable
	end
end

function getIdentity(playerId)
	local identifier = GetPlayerIdentifiers(playerId)[1]
	local result = MySQL.Sync.fetchAll("SELECT firstname, lastname, name FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identifier,
			firstname = identity['firstname'],
			lastname = identity['lastname'],
      		name = identity['name']
		}
	else
		return nil
	end
end


function getPlayerPermissions(playerId)
	local result = nil
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if Config.Jobs[xPlayer.job.name] ~= nil and Config.Jobs[xPlayer.job.name].Settings ~= nil then
		result = {
			options = {},
			gradePermissions = {}
		}
		if Config.Jobs[xPlayer.job.name].Settings.gradePermissions ~= nil then
			if Config.Jobs[xPlayer.job.name].Settings.gradePermissions[xPlayer.job.grade_name] ~= nil then
				result.job = xPlayer.job.name
	
				if Config.Jobs[xPlayer.job.name].Settings.gradePermissions[xPlayer.job.grade_name].bossMenu == true then
					Config.Jobs[xPlayer.job.name].Settings.gradePermissions[xPlayer.job.grade_name].bossMenu = Config.Permissions.default.bossMenu
					for k, v in pairs(Config.Jobs[xPlayer.job.name].Settings.gradePermissions[xPlayer.job.grade_name].bossMenu) do
						result.options[k] = v
					end
					result.gradePermissions = Config.Jobs[xPlayer.job.name].Settings.gradePermissions[xPlayer.job.grade_name]
				else
					result.gradePermissions = Config.Jobs[xPlayer.job.name].Settings.gradePermissions[xPlayer.job.grade_name]
					result.options = Config.Jobs[xPlayer.job.name].Settings.gradePermissions[xPlayer.job.grade_name].bossMenu
				end                
			elseif Config.Jobs[xPlayer.job.name].Settings.gradePermissions == nil and Config.Jobs[xPlayer.job.name].Settings.gradePermissions.default ~= nil then
				result = {
					options = {},
					gradePermissions = {}
				}
				result.job = xPlayer.job.name
	
				if Config.Jobs[xPlayer.job.name].Settings.gradePermissions.default.bossMenu == true then
					Config.Jobs[xPlayer.job.name].Settings.gradePermissions.default.bossMenu = Config.Permissions.default.bossMenu
					for k, v in pairs(Config.Jobs[xPlayer.job.name].Settings.gradePermissions.default.bossMenu) do
						result.options[k] = v
					end
					result.gradePermissions = Config.Jobs[xPlayer.job.name].Settings.gradePermissions.default
				else
					result.gradePermissions = Config.Jobs[xPlayer.job.name].Settings.gradePermissions.default
					result.options = Config.Jobs[xPlayer.job.name].Settings.gradePermissions.default.bossMenu
				end    
			end
			if Config.Jobs[xPlayer.job.name].Settings.vehicleMenu then
				result.gradePermissions.vehicleMenu = Config.Jobs[xPlayer.job.name].Settings.vehicleMenu
			end
			if Config.Jobs[xPlayer.job.name].Settings.canBuyItems then
				result.gradePermissions.canBuyItems = Config.Jobs[xPlayer.job.name].Settings.canBuyItems
			end
			if Config.Jobs[xPlayer.job.name].Settings.canBuyWeapons then
				result.gradePermissions.canBuyWeapons = Config.Jobs[xPlayer.job.name].Settings.canBuyWeapons
			end
		end
	end

	return result
end

function hasPlayerPermission(playerId, permission)
	local hasPermission = false
	local xPlayer = ESX.GetPlayerFromId(playerId)

	if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Settings and Config.Jobs[xPlayer.job.name].Settings.gradePermissions then
		if Config.Jobs[xPlayer.job.name].Settings.gradePermissions[xPlayer.job.grade_name] then
			hasPermission = toboolean(Config.Jobs[xPlayer.job.name].Settings.gradePermissions[xPlayer.job.grade_name][permission])
		else
			if Config.Jobs[xPlayer.job.name].Settings.gradePermissions.default ~= nil then
				hasPermission = toboolean(Config.Jobs[xPlayer.job.name].Settings.gradePermissions.default[permission])
			end
		end
		hasPermissions = Config.Jobs[xPlayer.job.name].Settings.gradePermissions.default
	end

	return hasPermission
end

-- Phone number subscription stuff
RegisterNetEvent("esx:setJob")
AddEventHandler(
    "esx:setJob",
	function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		local lastJob = LastJob[source]
		LastJob[source] = xPlayer.job.name

		if lastJob and Config.Jobs[lastJob] and Config.Jobs[lastJob].PhoneContact and Config.Jobs[lastJob].PhoneContact.subscribeTo and type(Config.Jobs[lastJob].PhoneContact.subscribeTo) == "table" then
			for k, v in pairs(Config.Jobs[lastJob].PhoneContact.subscribeTo) do
				TriggerEvent("esx_addons_gcphone:removeSource", v, source)
			end
		end

		if xPlayer.job then
			local job = xPlayer.job.name
			if Config.Jobs[job] and Config.Jobs[job].PhoneContact and Config.Jobs[job].PhoneContact.subscribeTo and type(Config.Jobs[job].PhoneContact.subscribeTo) == "table" then
				for k, v in pairs(Config.Jobs[job].PhoneContact.subscribeTo) do
					TriggerEvent("esx_addons_gcphone:addSource", v, source)
				end
			end
		end
    end
)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler(
    "esx:playerLoaded",
	function(source, xPlayer)
		if xPlayer.job then
			LastJob[source] = xPlayer.job.name
		end
        if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].PhoneContact and Config.Jobs[xPlayer.job.name].PhoneContact.subscribeTo and type(Config.Jobs[xPlayer.job.name].PhoneContact.subscribeTo) == "table" then
			for k, v in pairs(Config.Jobs[xPlayer.job.name].PhoneContact.subscribeTo) do
				TriggerEvent("esx_addons_gcphone:addSource", v, source)
			end
		end
    end
)

RegisterNetEvent("esx:playerDropped")
AddEventHandler(
    "esx:playerDropped",
    function(source)
		local xPlayer = ESX.GetPlayerFromId(source)
		
		if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].PhoneContact and Config.Jobs[xPlayer.job.name].PhoneContact.subscribeTo and type(Config.Jobs[xPlayer.job.name].PhoneContact.subscribeTo) == "table" then
			for k, v in pairs(Config.Jobs[xPlayer.job.name].PhoneContact.subscribeTo) do
				TriggerEvent("esx_addons_gcphone:removeSource", v, source)
			end
		end

		LastJob[source] = nil
    end
)

-- Stock stuff
RegisterNetEvent('esx_jobmanager:getStockItem')
AddEventHandler('esx_jobmanager:getStockItem', function(society, itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', society, function(inventory)

		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
			if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
				TriggerClientEvent('pNotify:SendNotification', _source, {
					text = _U("quantity_invalid"),
					type = "error",
					timeout = Config.Notification.timeout,
					layout = Config.Notification.layout,
					queue = "jobmanager"
				})
			else
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('pNotify:SendNotification', _source, {
					text = _U("have_withdrawn", count, inventoryItem.label),
					type = "success",
					timeout = Config.Notification.timeout,
					layout = Config.Notification.layout,
					queue = "jobmanager"
				})
				
				if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Webhooks and (Config.Jobs[xPlayer.job.name].Webhooks.stock or Config.Jobs[xPlayer.job.name].Webhooks.stockRemove) then
					local webhook = Config.Jobs[xPlayer.job.name].Webhooks.stockRemove and Config.Jobs[xPlayer.job.name].Webhooks.stockRemove or Config.Jobs[xPlayer.job.name].Webhooks.stock
					local identity = getIdentity(_source)
					local name = _U("stock_remove_log")
					local text = string.format("**%s %s**\n(`%s` - %s)\n%sx %s", identity.firstname, identity.lastname, xPlayer.getName(), xPlayer.getIdentifier(), count, inventoryItem.label)
					TriggerEvent('discord:log', webhook, name, Config.Discord.colorRed, text)
				end
			end
		else
			TriggerClientEvent('pNotify:SendNotification', _source, {
				text = _U("quantity_invalid"),
				type = "error",
				timeout = Config.Notification.timeout,
				layout = Config.Notification.layout,
				queue = "jobmanager"
			})
		end
	end)
end)

RegisterNetEvent('esx_jobmanager:setJob')
AddEventHandler('esx_jobmanager:setJob', function(jobName, onDuty, grade)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	if Config.Jobs[jobName] and Config.Jobs[jobName].Webhooks and Config.Jobs[jobName].Webhooks.duty then
		local webhook = Config.Jobs[jobName].Webhooks.duty
		local color = nil
		local identity = getIdentity(_source)
		local name = ""
		if onDuty then
			color = Config.Discord.colorGreen
			name = _U("duty_on")
		else
			color = Config.Discord.colorRed
			name = _U("duty_off")
		end
		local text = string.format("**%s %s**\n(`%s` - %s)\n%s", identity.firstname, identity.lastname, xPlayer.getName(), xPlayer.getIdentifier(), xPlayer.job.grade_label)
		TriggerEvent('discord:log', webhook, name, color, text)
	end

	if not onDuty then
		jobName = "off_" .. jobName
	end

	xPlayer.setJob(jobName, grade)
end)

RegisterNetEvent('esx_jobmanager:putStockItems')
AddEventHandler('esx_jobmanager:putStockItems', function(society, itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', society, function(inventory)
		if not inventory then
			TriggerClientEvent('pNotify:SendNotification', _source, {
				text = _U("internal_error"),
				type = "error",
				timeout = Config.Notification.timeout,
				layout = Config.Notification.layout,
				queue = "jobmanager"
			})
		end

		local inventoryItem = inventory.getItem(itemName)

		-- does the player have enough of the item?
		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)

			if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Webhooks and (Config.Jobs[xPlayer.job.name].Webhooks.stock or Config.Jobs[xPlayer.job.name].Webhooks.stockDeposit) then
				local webhook = Config.Jobs[xPlayer.job.name].Webhooks.stockDeposit and Config.Jobs[xPlayer.job.name].Webhooks.stockDeposit or Config.Jobs[xPlayer.job.name].Webhooks.stock
				local name = _U("stock_deposit")
				local color = Config.Discord.colorGreen
				local identity = getIdentity(_source)
				local text = string.format("**%s %s**\n(`%s` - %s)\n%sx %s", identity.firstname, identity.lastname, xPlayer.getName(), xPlayer.getIdentifier(), count, inventoryItem.label)
				TriggerEvent('discord:log', webhook, name, color, text)
			end

			TriggerClientEvent('pNotify:SendNotification', _source, {
				text = _U("have_deposited", count, inventoryItem.label),
				type = "success",
				timeout = Config.Notification.timeout,
				layout = Config.Notification.layout,
				queue = "jobmanager"
			})
		else
			TriggerClientEvent('pNotify:SendNotification', _source, {
				text = _U("quantity_invalid"),
				type = "error",
				timeout = Config.Notification.timeout,
				layout = Config.Notification.layout,
				queue = "jobmanager"
			})
		end
	end)
end)

ESX.RegisterServerCallback(
    "esx_jobmanager:getArmoryWeapons",
    function(source, cb, society)
		local xPlayer = ESX.GetPlayerFromId(source)

        TriggerEvent(
            "esx_datastore:getSharedDataStore",
            society,
            function(store)
                local weapons = store.get("weapons")

                if weapons == nil then
                    weapons = {}
                end

                cb(weapons)
            end
        )
    end
)

ESX.RegisterServerCallback(
	'esx_jobmanager:removeArmoryWeapon',
	function(source, cb, weaponName, index)
		if not index then
			return
		end
		local _index = index
		local _source = source
        local xPlayer = ESX.GetPlayerFromId(source)
		local jobName = xPlayer.job.name
		if string.sub(jobName, 1, 4) == "off_" then
			jobName = jobName:sub(5)
		end

        TriggerEvent(
            "esx_datastore:getSharedDataStore",
            "society_" .. jobName,
            function(store)
                local weapons = store.get("weapons")

                if weapons == nil then
                    weapons = {}
                end

				if weapons[weaponName] ~= nil then
					local loadout, weapon = xPlayer.getWeapon(weaponName)

					if weapon then
						TriggerClientEvent('pNotify:SendNotification', _source, {
							text = _U("already_in_inventory"),
							type = "error",
							timeout = Config.Notification.timeout,
							layout = Config.Notification.layout,
							queue = "jobmanager"
						})
						return
					end

					xPlayer.addWeapon(weaponName, weapons[weaponName][_index])

					TriggerClientEvent('pNotify:SendNotification', _source, {
						text = _U("weapon_taken"),
						type = "success",
						timeout = Config.Notification.timeout,
						layout = Config.Notification.layout,
						queue = "jobmanager"
					})

					if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Webhooks and (Config.Jobs[xPlayer.job.name].Webhooks.armory or Config.Jobs[xPlayer.job.name].Webhooks.armoryWithdraw) then
						local webhook = Config.Jobs[xPlayer.job.name].Webhooks.armoryWithdraw and Config.Jobs[xPlayer.job.name].Webhooks.armoryWithdraw or Config.Jobs[xPlayer.job.name].Webhooks.armory
						local name = _U("armory_withdraw")
						local color = Config.Discord.colorRed
						local identity = getIdentity(_source)
						local text = string.format("**%s %s**\n(`%s` - %s)\n1x %s (%s)", identity.firstname, identity.lastname, xPlayer.getName(), xPlayer.getIdentifier(), ESX.GetWeaponLabel(weaponName), weapons[weaponName][_index])
						TriggerEvent('discord:log', webhook, name, color, text)
					end
					
					table.remove(weapons[weaponName], _index)
				end

				store.set("weapons", weapons)
				
				cb()
            end
        )
	end
)

ESX.RegisterServerCallback(
	'esx_jobmanager:addArmoryWeapon',
	function(source, cb, weaponName)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(source)
		local jobName = xPlayer.job.name
		if string.sub(jobName, 1, 4) == "off_" then
			jobName = jobName:sub(5)
		end

		TriggerEvent(
			'esx_datastore:getSharedDataStore',
			"society_" .. jobName,
			function(store)
				local storeWeapons = store.get('weapons') or {}
				local loadout, weapon = xPlayer.getWeapon(weaponName)

				if not weapon then
					return
				end

				local ammo = xPlayer.loadout[loadout].ammo

				if not (storeWeapons[weaponName] and type(storeWeapons[weaponName]) == 'table') then
					storeWeapons[weaponName] = {}
				end

				table.insert(storeWeapons[weaponName], ammo)

				store.set('weapons', storeWeapons)

				xPlayer.removeWeapon(weaponName)

				TriggerClientEvent('pNotify:SendNotification', _source, {
					text = _U("weapon_deposited"),
					type = "success",
					timeout = Config.Notification.timeout,
					layout = Config.Notification.layout,
					queue = "jobmanager"
				})

				if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Webhooks and (Config.Jobs[xPlayer.job.name].Webhooks.armory or Config.Jobs[xPlayer.job.name].Webhooks.armoryDeposit) then
					local webhook = Config.Jobs[xPlayer.job.name].Webhooks.armoryDeposit and Config.Jobs[xPlayer.job.name].Webhooks.armoryDeposit or Config.Jobs[xPlayer.job.name].Webhooks.armory
					local name = _U("armory_deposit")
					local color = Config.Discord.colorGreen
					local identity = getIdentity(_source)
					local text = string.format("**%s %s**\n(`%s` - %s)\n1x %s (%s)", identity.firstname, identity.lastname, xPlayer.getName(), xPlayer.getIdentifier(), ESX.GetWeaponLabel(weaponName), ammo)
					TriggerEvent('discord:log', webhook, name, color, text)
				end

				cb()
			end
		)
	end
)

ESX.RegisterServerCallback(
	'esx_jobmanager:buyWeapon',
	function(source, cb, weaponName, count)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(source)
		local jobName = xPlayer.job.name

		if string.sub(jobName, 1, 4) == "off_" then
			jobName = jobName:sub(5)
		end

		local permissions = getPlayerPermissions(_source)
		if not (permissions and ((next(permissions.gradePermissions) ~= nil and (permissions.gradePermissions.canBuyWeapons ~= nil and permissions.gradePermissions.canBuyWeapons == true)) or permissions.options.withdraw == true)) or not (Config.Jobs[jobName] and Config.Jobs[jobName].Armory and Config.Jobs[jobName].Armory.canBuy and Config.Jobs[jobName].Armory.canBuy[weaponName] and Config.Jobs[jobName].Armory.canBuy[weaponName].price) then
			print("[esx_jobmanager] " .. xPlayer.identifier .. " tried to buy a weapon without having permissions.")
			TriggerClientEvent('pNotify:SendNotification', _source, {
				text = _U("not_allowed"),
				type = "error",
				timeout = Config.Notification.timeout,
				layout = Config.Notification.layout,
				queue = "jobmanager"
			})
			return
		end

		local price = Config.Jobs[jobName].Armory.canBuy[weaponName].price * count

		TriggerEvent('esx_addonaccount:getSharedAccount', "society_" .. jobName, function(account)
			if account.money >= price then
				TriggerEvent(
					'esx_datastore:getSharedDataStore',
					"society_" .. jobName,
					function(store)
						local storeWeapons = store.get('weapons') or {}
						local loadout, weapon = xPlayer.getWeapon(weaponName)
						local ammo = 2000
		
						if not (storeWeapons[weaponName] and type(storeWeapons[weaponName]) == 'table') then
							storeWeapons[weaponName] = {}
						end

						for i = 1, count do
							table.insert(storeWeapons[weaponName], ammo)
						end
		
						store.set('weapons', storeWeapons)
		
						account.removeMoney(price)

						local weaponLabel = Config.Jobs[jobName].Armory.canBuy[weaponName].label and Config.Jobs[jobName].Armory.canBuy[weaponName].price or ESX.GetWeaponLabel(weaponName)

						TriggerClientEvent('pNotify:SendNotification', source, {
							text = _U("weapon_bought", count, weaponLabel),
							type = "success",
							timeout = Config.Notification.timeout,
							layout = Config.Notification.layout,
							queue = "jobmanager"
						})
		
						if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Webhooks and (Config.Jobs[xPlayer.job.name].Webhooks.armory or Config.Jobs[xPlayer.job.name].Webhooks.armoryBuy) then
							local webhook = Config.Jobs[xPlayer.job.name].Webhooks.armoryBuy and Config.Jobs[xPlayer.job.name].Webhooks.armoryBuy or Config.Jobs[xPlayer.job.name].Webhooks.armory
							local name = _U("armory_buy")
							local color = Config.Discord.colorGreen
							local identity = getIdentity(_source)
							local text = string.format("**%s %s**\n(`%s` - %s)\n%sx %s *($%s)*", identity.firstname, identity.lastname, xPlayer.getName(), xPlayer.getIdentifier(), count, weaponLabel, price)
							TriggerEvent('discord:log', webhook, name, color, text)
						end
		
						cb()
					end
				)
			else
				TriggerClientEvent('pNotify:SendNotification', source, {
					text = _U("not_enough_money"),
					type = "error",
					timeout = Config.Notification.timeout,
					layout = Config.Notification.layout,
					queue = "jobmanager"
				})
				cb()
			end
		end)
	end
)

ESX.RegisterServerCallback(
	'esx_jobmanager:buyItem',
	function(source, cb, itemName, count)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local jobName = xPlayer.job.name

		if string.sub(jobName, 1, 4) == "off_" then
			jobName = jobName:sub(5)
		end

		if count < 1 then
			TriggerClientEvent('pNotify:SendNotification', _source, {
				text = _U("quantity_invalid"),
				type = "error",
				timeout = Config.Notification.timeout,
				layout = Config.Notification.layout,
				queue = "jobmanager"
			})
		end

		local permissions = getPlayerPermissions(_source)
		if not (permissions and ((next(permissions.gradePermissions) ~= nil and (permissions.gradePermissions.canBuyItems ~= nil and permissions.gradePermissions.canBuyItems == true)) or permissions.options.withdraw == true)) or not (Config.Jobs[jobName] and Config.Jobs[jobName].Stock and Config.Jobs[jobName].Stock.canBuy and Config.Jobs[jobName].Stock.canBuy[itemName] and Config.Jobs[jobName].Stock.canBuy[itemName].price) then
			print("[esx_jobmanager] " .. xPlayer.identifier .. " tried to buy an item without having permissions.")
			TriggerClientEvent('pNotify:SendNotification', _source, {
				text = _U("not_allowed"),
				type = "error",
				timeout = Config.Notification.timeout,
				layout = Config.Notification.layout,
				queue = "jobmanager"
			})
			return
		end

		local price = Config.Jobs[jobName].Stock.canBuy[itemName].price * count

		TriggerEvent('esx_addonaccount:getSharedAccount', "society_" .. jobName, function(account)
			if account.money >= price then
				TriggerEvent(
					'esx_addoninventory:getSharedInventory',
					"society_" .. jobName,
					function(inventory)
						if not inventory then
							TriggerClientEvent('pNotify:SendNotification', _source, {
								text = _U("internal_error"),
								type = "error",
								timeout = Config.Notification.timeout,
								layout = Config.Notification.layout,
								queue = "jobmanager"
							})
						end
			
						local inventoryItem = inventory.getItem(itemName)

						local itemLabel = Config.Jobs[jobName].Stock.canBuy[itemName].label and Config.Jobs[jobName].Stock.canBuy[itemName].label or inventoryItem.label
			
						account.removeMoney(price)
						inventory.addItem(itemName, count)
						
						cb()
		
						TriggerClientEvent('pNotify:SendNotification', _source, {
							text = _U("item_bought", count, itemLabel),
							type = "success",
							timeout = Config.Notification.timeout,
							layout = Config.Notification.layout,
							queue = "jobmanager"
						})
		
						if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Webhooks and (Config.Jobs[xPlayer.job.name].Webhooks.stock or Config.Jobs[xPlayer.job.name].Webhooks.stockBuy) then
							local webhook = Config.Jobs[xPlayer.job.name].Webhooks.stockBuy and Config.Jobs[xPlayer.job.name].Webhooks.stockBuy or Config.Jobs[xPlayer.job.name].Webhooks.stock
							local name = _U("item_buy")
							local color = Config.Discord.colorGreen
							local identity = getIdentity(_source)
							local text = string.format("**%s %s**\n(`%s` - %s)\n%sx %s *($%s)*", identity.firstname, identity.lastname, xPlayer.getName(), xPlayer.getIdentifier(), count, itemLabel, price)
							TriggerEvent('discord:log', webhook, name, color, text)
						end
					end
				)
			else
				TriggerClientEvent('pNotify:SendNotification', source, {
					text = _U("not_enough_money"),
					type = "error",
					timeout = Config.Notification.timeout,
					layout = Config.Notification.layout,
					queue = "jobmanager"
				})
				cb()
			end
		end)

		
	end
)

RegisterNetEvent('esx_jobmanager:getPermissions')
AddEventHandler('esx_jobmanager:getPermissions', function(cb, playerId)
	local result = getPlayerPermissions(playerId)

	cb(result)
end)

ESX.RegisterServerCallback(
	'esx_jobmanager:getPermissions',
	function(source, cb)
		local result = getPlayerPermissions(source)
	
		cb(result)
	end
)

-- Billing Log
RegisterNetEvent('esx_billing:sendBill')
AddEventHandler('esx_billing:sendBill', function(targetPlayerId, accountName, label, amount)
	accountName = accountName:gsub("society_", "")
	if Config.Jobs[accountName] and Config.Jobs[accountName].Webhooks and Config.Jobs[accountName].Webhooks.billing then
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local identity = getIdentity(_source)
		local targetIdentity = getIdentity(targetPlayerId)
		amount = ESX.Math.Round(amount);
		local text = string.format("**%s %s** (`%s` - %s)\n%s\n**$%s**\n**Předal:** %s %s (`%s` - %s)", targetIdentity.firstname, targetIdentity.lastname, GetPlayerName(targetPlayerId), targetIdentity.identifier, label, amount, identity.firstname, identity.lastname, xPlayer.getName(), xPlayer.getIdentifier())
		TriggerEvent('discord:log', Config.Jobs[accountName].Webhooks.billing, _U("billing"), Config.Discord.colorGreen, text)
	end
end)

-- Deposit Money Log
RegisterNetEvent('esx_society:depositMoney')
AddEventHandler('esx_society:depositMoney', function(accountName, amount)
	accountName = accountName:gsub("society_", "")
	if Config.Jobs[accountName] and Config.Jobs[accountName].Webhooks and (Config.Jobs[accountName].Webhooks.money or Config.Jobs[accountName].Webhooks.moneyDeposit) then
		local webhook = Config.Jobs[accountName].Webhooks.moneyDeposit and Config.Jobs[accountName].Webhooks.moneyDeposit or Config.Jobs[accountName].Webhooks.money
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local identity = getIdentity(_source)
		local text = string.format("**%s %s** (`%s` - %s)\n**$%s**", identity.firstname, identity.lastname, xPlayer.getName(), identity.identifier, amount)
		TriggerEvent('discord:log', webhook, _U("bank_deposit"), Config.Discord.colorGreen, text)
	end
end)

-- Withdraw Money Log
RegisterNetEvent('esx_society:withdrawMoney')
AddEventHandler('esx_society:withdrawMoney', function(accountName, amount)
	accountName = accountName:gsub("society_", "")
	if Config.Jobs[accountName] and Config.Jobs[accountName].Webhooks and (Config.Jobs[accountName].Webhooks.money or Config.Jobs[accountName].Webhooks.moneyWithdraw) then
		local webhook = Config.Jobs[accountName].Webhooks.moneyWithdraw and Config.Jobs[accountName].Webhooks.moneyWithdraw or Config.Jobs[accountName].Webhooks.money
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local identity = getIdentity(_source)
		local text = string.format("**%s %s** (`%s` - %s)\n**$%s**", identity.firstname, identity.lastname, xPlayer.getName(), identity.identifier, amount)
		TriggerEvent('discord:log', webhook, _U("bank_withdraw"), Config.Discord.colorRed, text)
	end
end)

ESX.RegisterServerCallback('esx_jobmanager:getStockItems', function(source, cb, society)
	TriggerEvent('esx_addoninventory:getSharedInventory', society, function(inventory)
		cb(inventory.items)
	end)
end)

ESX.RegisterServerCallback('esx_jobmanager:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb( { items = items } )
end)

ESX.RegisterServerCallback(
	'esx_jobmanager:getWeapons',
	function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)

		cb(xPlayer.getLoadout())
	end
)

ESX.RegisterServerCallback(
	'esx_jobmanager:buyVehicle',
	function(source, cb, model, vehicleProps, society, type)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local owner = society and society:gsub("society_", "") or xPlayer.identifier
		local type = type and type or "car"

		if not (Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].VehicleMenu and Config.Jobs[xPlayer.job.name].VehicleMenu.canBuy) then
			print("[esx_jobmanager] " .. xPlayer.identifier .. " tried to call esx_jobmanager:buyVehicle callback without having a jobmanager job.")
			return
		end

		if not Config.Jobs[xPlayer.job.name].VehicleMenu.canBuy[model] then
			print("[esx_jobmanager] " .. xPlayer.identifier .. " tried to buy a vehicle which hadn't been allowed to be bought.")
			return
		end

		local price = Config.Jobs[xPlayer.job.name].VehicleMenu.canBuy[model] 
		local terminate = false

		if society then
			local permissions = getPlayerPermissions(_source)
			if not (permissions and ((next(permissions.gradePermissions) ~= nil and (permissions.gradePermissions.vehicleMenu ~= nil and (permissions.gradePermissions.vehicleMenu == true or permissions.gradePermissions.vehicleMenu.canBuyVehicles))) or permissions.options.withdraw == true)) then
				print("[esx_jobmanager] " .. xPlayer.identifier .. " tried to buy a vehicle without having permissions.")
				return
			end
			TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
				if account.money >= price then
					account.removeMoney(price)
					TriggerClientEvent('pNotify:SendNotification', source, {
						text = _U("vehicle_bought"),
						type = "success",
						timeout = Config.Notification.timeout,
						layout = Config.Notification.layout,
						queue = "jobmanager"
					})
				else
					TriggerClientEvent('pNotify:SendNotification', source, {
						text = _U("not_enough_money"),
						type = "error",
						timeout = Config.Notification.timeout,
						layout = Config.Notification.layout,
						queue = "jobmanager"
					})
					cb(false)
					terminate = true
				end
			end)
		else
			local account = xPlayer.getAccount('bank_account')

			if account.money >= price then
				xPlayer.removeAccountMoney(price)
				TriggerClientEvent('pNotify:SendNotification', source, {
					text = _U("vehicle_bought"),
					type = "success",
					timeout = Config.Notification.timeout,
					layout = Config.Notification.layout,
					queue = "jobmanager"
				})
			else
				TriggerClientEvent('pNotify:SendNotification', source, {
					text = _U("not_enough_money"),
					type = "error",
					timeout = Config.Notification.timeout,
					layout = Config.Notification.layout,
					queue = "jobmanager"
				})
				cb(false)
				terminate = true
			end
		end

		if terminate then
			return
		end

		if Config.Jobs[xPlayer.job.name].Webhooks and Config.Jobs[xPlayer.job.name].Webhooks.vehiclePurchase then
			local identity = getIdentity(_source)
			local text = string.format("**%s %s** (`%s` - %s)\n**%s** ($%s)", identity.firstname, identity.lastname, xPlayer.getName(), identity.identifier, model, price)
			TriggerEvent('discord:log', Config.Jobs[xPlayer.job.name].Webhooks.vehiclePurchase, _U("vehicle_bought"), Config.Discord.colorGreen, text)
		end

		MySQL.Async.execute('INSERT INTO owned_vehicles (owner, modelname, vehicle, plate, vehicleType) VALUES (@owner, @model, @vehicle, @plate, @type)',
			{
				['@owner'] = owner,
				['@model'] = model,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate']   = vehicleProps.plate,
				['@type'] = type
			},
			function(rowsChanged)
				if rowsChanged <= 0 then
					terminate = true
					TriggerClientEvent('pNotify:SendNotification', source, {
						text = _U("internal_error"),
						type = "error",
						timeout = Config.Notification.timeout,
						layout = Config.Notification.layout,
						queue = "jobmanager"
					})
				end
				cb(not terminate)
			end
		)
	end
)

RegisterServerEvent('esx_jobmanager:setDeathStatus')
AddEventHandler('esx_jobmanager:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(isDead) ~= 'boolean' then
		print(('esx_jobmanager: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead'] = isDead
	})
end)

RegisterNetEvent('esx_jobmanager:healPlayer')
AddEventHandler('esx_jobmanager:healPlayer', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Settings and (Config.Jobs[xPlayer.job.name].Settings.medicalMenu == true or Config.Jobs[xPlayer.job.name].Settings.medicalMenu.canHeal) then
		TriggerClientEvent('esx_jobmanager:heal', target, type)
		TriggerClientEvent('pNotify:SendNotification', source, {
            text = _U("healed_player"),
            type = "success",
            timeout = Config.Notification.timeout,
            layout = Config.Notification.layout,
            queue = "jobmanager"
        })
	else
		print(('esx_jobmanager: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_jobmanager:revive')
AddEventHandler('esx_jobmanager:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Settings and (Config.Jobs[xPlayer.job.name].Settings.medicalMenu == true or Config.Jobs[xPlayer.job.name].Settings.medicalMenu.canRevive) then
		TriggerClientEvent('esx_jobmanager:revive', target)
		TriggerClientEvent('pNotify:SendNotification', source, {
            text = _U("revived_player"),
            type = "success",
            timeout = Config.Notification.timeout,
            layout = Config.Notification.layout,
            queue = "jobmanager"
        })
	else
		print(('esx_jobmanager: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent("esx_jobmanager:putInVehicle")
AddEventHandler(
    "esx_jobmanager:putInVehicle",
    function(target)
		local xPlayer = ESX.GetPlayerFromId(source)
		
		if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Settings and (Config.Jobs[xPlayer.job.name].Settings.interactionsMenu == true or Config.Jobs[xPlayer.job.name].Settings.interactionsMenu.canPutInVehicle) then
			TriggerClientEvent("esx_jobmanager:putInVehicle", target)
		else
			print(('esx_jobmanager: %s attempted to put someone in a vehicle!'):format(xPlayer.identifier))
		end
    end
)

RegisterServerEvent("esx_jobmanager:takeOutOfVehicle")
AddEventHandler(
    "esx_jobmanager:takeOutOfVehicle",
	function(target)
		local xPlayer = ESX.GetPlayerFromId(source)

		if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Settings and (Config.Jobs[xPlayer.job.name].Settings.interactionsMenu == true or Config.Jobs[xPlayer.job.name].Settings.interactionsMenu.canPutInVehicle) then
			TriggerClientEvent("esx_jobmanager:takeOutOfVehicle", target)
		else
			print(('esx_jobmanager: %s attempted to take someone out of a vehicle!'):format(xPlayer.identifier))
		end
    end
)

RegisterServerEvent("esx_jobmanager:drag")
AddEventHandler(
    "esx_jobmanager:drag",
    function(target)
		local xPlayer = ESX.GetPlayerFromId(source)
        local _source = source
		
		if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Settings and (Config.Jobs[xPlayer.job.name].Settings.interactionsMenu == true or Config.Jobs[xPlayer.job.name].Settings.interactionsMenu.canDrag) then
			TriggerClientEvent("esx_jobmanager:drag", target, _source)
		else
			print(('esx_jobmanager: %s attempted to drag someone!'):format(xPlayer.identifier))
		end
    end
)

RegisterServerEvent("esx_jobmanager:handcuff")
AddEventHandler(
    "esx_jobmanager:handcuff",
    function(target)
		local xPlayer = ESX.GetPlayerFromId(source)
		
		if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Settings and (Config.Jobs[xPlayer.job.name].Settings.interactionsMenu == true or Config.Jobs[xPlayer.job.name].Settings.interactionsMenu.canHandcuff) then
			TriggerClientEvent("esx_jobmanager:handcuff", target)
		else
			print(('esx_jobmanager: %s attempted to handcuff someone!'):format(xPlayer.identifier))
		end
    end
)

RegisterNetEvent('esx_jobmanager:search')
AddEventHandler(
	'esx_jobmanager:search',
	function(targetPlayer, targetPlayerName)
		local xPlayer = ESX.GetPlayerFromId(source)
		local _source = source

		if Config.Jobs[xPlayer.job.name] and Config.Jobs[xPlayer.job.name].Settings and (Config.Jobs[xPlayer.job.name].Settings.interactionsMenu == true or Config.Jobs[xPlayer.job.name].Settings.interactionsMenu.canSearch) then
			Citizen.CreateThread(
				function()
					TriggerClientEvent('pogressBar:drawBar', _source, 3000, _U("searching"))
					Citizen.Wait(3000)
					TriggerClientEvent("esx_inventoryhud:openPlayerInventory", _source, targetPlayer, targetPlayerName)
				end
			)
		else
			print(('esx_jobmanager: %s attempted to search someone!'):format(xPlayer.identifier))
		end
	end
)