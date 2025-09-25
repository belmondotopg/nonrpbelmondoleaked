AddEventHandler('esx:playerLoaded', function(_, xPlayer)
    local result = MySQL.query.await('SELECT items, money FROM deposits WHERE identifier = ?', {xPlayer.identifier})
    if not result[1] then
        MySQL.insert.await('INSERT INTO deposits (identifier) VALUES (?)', {xPlayer.identifier})
    end
end)

--         if xPlayer.get('premiumgroup') then

ESX.RegisterServerCallback('non_deposits:getDepositInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	local result = MySQL.query.await('SELECT items, money FROM deposits WHERE identifier = ?', {xPlayer.identifier})

    moneyCallback = result[1].money
    itemsCallback = json.decode(result[1].items)

    cb({
        money      = moneyCallback,
        items      = itemsCallback,
    })
end)

ESX.RegisterServerCallback('non_deposits:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local money = xPlayer.getAccount('money').money

	cb({
		money = money,
		items = xPlayer.inventory
	})
end)

ESX.RegisterCommand('schowek', 'user', function(xPlayer, args, showError)
    if xPlayer.getGroup() == 'vip' or xPlayer.get('premiumgroup') or xPlayer.getGroup() == 'wspolwlasciciel' or xPlayer.getGroup() == 'wlasciciel' then
		xPlayer.triggerEvent('PaT:JEBACCIE')
    else
        xPlayer.showNotification("Nie posiadasz Rangi [VIP].")
    end
end, false)


RegisterServerEvent('non_deposits:putItem')
AddEventHandler('non_deposits:putItem', function(type, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type == 'item_standard' then
		local playerItem = xPlayer.getInventoryItem(item)

		if playerItem.count >= count and count > 0 then
			MySQL.query('SELECT items FROM deposits WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier
			}, function(result)
				local InsertItems = {}
				local founditem = false

				if result[1].items then
					InsertItems = json.decode(result[1].items)
				end

				for k, v in pairs(InsertItems) do
					if v.item == item then
						v.count = v.count + count
						founditem = true
						break
					end
				end

				if not founditem then
					table.insert(InsertItems, {item = item, label = playerItem.label, count = count})
				end

                MySQL.update('UPDATE deposits SET items = @items WHERE identifier = @identifier', {
                    ['@items'] = json.encode(InsertItems),
                    ['@identifier'] = xPlayer.identifier
                }, function(rowsChanged)
                    xPlayer.removeInventoryItem(item, count)
                    xPlayer.showNotification('~y~Schowano: ' .. count .. 'x ' .. playerItem.label)
					exports['non']:SendLog(xPlayer.source, string.format('Schowal przedmiot: %s X%d', playerItem.label, count), 'schowek')
                end)
			end)
		else
			xPlayer.showNotification('~r~Nieprawidłowa ilość')
		end
	elseif type == 'item_account' then
		if xPlayer.getAccount(item).money >= count and count > 0 then
			MySQL.query('SELECT money FROM deposits WHERE identifier = @identifier', {
				['@identifier'] = xPlayer.identifier
			}, function(result)
				local money = 0

				if result[1] and result[1].money then
					money = result[1].money + count
				end

                MySQL.Async.execute('UPDATE deposits SET money = @money WHERE identifier = @identifier', {
                    ['@money'] = money,
                    ['@identifier'] = xPlayer.identifier
                }, function(rowsChanged)
                    xPlayer.removeAccountMoney('money', count)
                    xPlayer.showNotification('~g~Schowano '..count..'$ pieniędzy')
					exports['non']:SendLog(xPlayer.source, string.format('Schowal pieniadze: %d', count), 'schowek')
                end)
			end)
		else
			xPlayer.showNotification('~r~Nieprawidłowa ilość')
		end
	end
end)

RegisterServerEvent('non_deposits:getItem')
AddEventHandler('non_deposits:getItem', function(type, item, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type == 'item_standard' then
		MySQL.Async.fetchAll('SELECT items FROM deposits WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			local InsertItems = {}
			local itemlabel = nil
			local cangetitem = false
			if result[1] and result[1].items then
				InsertItems = json.decode(result[1].items)
				for k, v in pairs(InsertItems) do
					if v.item == item then
						if count > 0 and v.count >= count then
							if xPlayer.canCarryItem(item, count) then
								v.count = v.count - count
								itemlabel = v.label
								if v.count == 0 then
									table.remove(InsertItems, k)
								end
								cangetitem = true
								break
							else
								xPlayer.showNotification('~r~Nie dasz rady tyle unieść')
								break
							end
						else
							xPlayer.showNotification('~r~Nie ma wystarczającej ilości tego przedmiotu w schowku')
							break
						end
					end
				end
				if cangetitem then
					MySQL.Async.execute('UPDATE deposits SET items = @items WHERE identifier = @identifier', {
						['@items'] = json.encode(InsertItems),
						['@identifier'] = xPlayer.identifier
					}, function(rowsChanged)
						xPlayer.addInventoryItem(item, count)
						xPlayer.showNotification('~y~Wyjęto: ' .. count .. 'x ' .. itemlabel)
						exports['non']:SendLog(xPlayer.source, string.format('Wyjęto przedmiot\nPrzedmiot: %s (%d)', itemlabel, count), 'schowek')
					end)
				end
			end
		end)
	elseif type == 'item_account' then
		MySQL.Async.fetchAll('SELECT money FROM deposits WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		}, function(result)
			if result[1] and result[1].money then
				if result[1].money >= count then
					money = result[1].money - count
					MySQL.Async.execute('UPDATE deposits SET money = @money WHERE identifier = @identifier', {
						['@money'] = money,
						['@identifier'] = xPlayer.identifier
					}, function(rowsChanged)
						xPlayer.addAccountMoney(item, count)
						xPlayer.showNotification('~y~Wyjęto: '..count..'$')
						exports['non']:SendLog(xPlayer.source, string.format('Wyjęto pieniądze\nIlość: %d$', count), 'schowek')
					end)
				else
					xPlayer.showNotification('~r~Nieprawidłowa ilość')
				end
			end
		end)
	end
end)