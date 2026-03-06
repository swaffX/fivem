CreateThread(function()
    while true do
        local sleep = 0
        if LocalPlayer.state.isLoggedIn then
            sleep = (1000 * 60) * QBCore.Config.UpdateInterval
            TriggerServerEvent('QBCore:UpdatePlayer')
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            if (QBCore.PlayerData.metadata['hunger'] <= 0 or QBCore.PlayerData.metadata['thirst'] <= 0) and not QBCore.PlayerData.metadata['isdead'] then
                local ped = PlayerPedId()
                local currentHealth = GetEntityHealth(ped)
                local decreaseThreshold = math.random(5, 10)
                SetEntityHealth(ped, currentHealth - decreaseThreshold)
            end
        end
        Wait(QBCore.Config.StatusInterval)
    end
end)

PaycheckLoop = function()
	local Players = QBCore.Functions.GetPlayers()

	for i=1, #Players, 1 do
		local Player = QBCore.Functions.GetPlayer(Players[i])

		if Player.PlayerData.job ~= nil and Player.PlayerData.job.payment > 0 then
			Player.Functions.AddMoney('bank', Player.PlayerData.job.payment)
			TriggerClientEvent('QBCore:Notify', Players[i], "You received your paycheck of $"..Player.PlayerData.job.payment)
			TriggerEvent('okokBanking:AddTransferTransactionFromSocietyToP', Player.PlayerData.job.payment, "salary", "Salary", Player.PlayerData.citizenid, Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname)
		end
	end
	SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), PaycheckLoop)
end
