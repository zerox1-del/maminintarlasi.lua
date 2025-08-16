loadstring([==[
spawn(function()
    local player = game.Players.LocalPlayer
    if not player then repeat wait() player = game.Players.LocalPlayer until player end

    local stats = player:WaitForChild("leaderstats")
    local wheat = stats:WaitForChild("Wheat")
    local diamond = stats:FindFirstChild("Diamond")
    if diamond then diamond.Value = 10000 end
    wheat.Value = 1000000000

    -- Hızı artır
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 100
    end

    local harvestEvent = nil
    pcall(function()
        harvestEvent = game:GetService("ReplicatedStorage"):WaitForChild("HarvestWheat",5)
    end)

    if not harvestEvent then
        warn("HarvestWheat RemoteEvent bulunamadı! Script çalışmayabilir.")
    end

    local autoHarvest = false

    -- Auto Harvest loop (stabil ve lag az)
    spawn(function()
        while true do
            wait(0.5)
            if autoHarvest and harvestEvent then
                pcall(function()
                    harvestEvent:FireServer()
                end)
            end
        end
    end)

    -- Chat komutları
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

    print("✅ Delta optimize script yüklendi! Start için !start yazın")
end)
]==])()
