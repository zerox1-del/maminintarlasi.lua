loadstring([==[
spawn(function()
    local player = game.Players.LocalPlayer
    if not player then repeat wait() player = game.Players.LocalPlayer until player end

    local stats = player:WaitForChild("leaderstats")
    local wheat = stats:WaitForChild("Wheat")
    wheat.Value = 1000000000

    local harvestEvent = nil
    pcall(function()
        harvestEvent = game:GetService("ReplicatedStorage"):WaitForChild("HarvestWheat",5)
    end)

    if not harvestEvent then
        warn("HarvestWheat RemoteEvent bulunamadı! Script çalışmayabilir.")
    end

    local autoHarvest = true

    game:GetService("RunService").Heartbeat:Connect(function()
        if autoHarvest and harvestEvent then
            pcall(function()
                harvestEvent:FireServer()
            end)
        end
    end)

    player.Chatted:Connect(function(msg)
        msg = msg:lower()
        if msg == "!stop" then
            autoHarvest = false
            print("✅ Otomatik hasat durduruldu")
        elseif msg == "!start" then
            autoHarvest = true
            print("✅ Otomatik hasat başlatıldı")
        end
    end)

    print("✅ Delta script yüklendi ve çalışıyor!")
end)
]==])()
