local DeathTP = {}

DeathTP.Name = "DeathTP"
DeathTP.Enabled = false

local player = game:GetService("Players").LocalPlayer
local savedPosition = nil
local deathConnection = nil
local respawnConnection = nil

DeathTP.Run = function()
    DeathTP.Enabled = not DeathTP.Enabled

    if DeathTP.Enabled then
        print("✅ DeathTP Enabled (6 second delay)")

        -- Save position before death
        deathConnection = player.CharacterAdded:Connect(function(char)
            task.wait(0.5) -- Small delay to let character load
            local root = char:WaitForChild("HumanoidRootPart", 3)
            if root then
                savedPosition = root.CFrame
            end
        end)

        -- TP back after death
        respawnConnection = player.CharacterAdded:Connect(function(char)
            task.delay(6, function()  -- 6 seconds after respawn
                if not DeathTP.Enabled then return end
                
                local root = char:WaitForChild("HumanoidRootPart", 5)
                if root and savedPosition then
                    root.CFrame = savedPosition
                    print("DeathTP: Teleported back to previous position")
                end
            end)
        end)

    else
        print("❌ DeathTP Disabled")
        if deathConnection then
            deathConnection:Disconnect()
            deathConnection = nil
        end
        if respawnConnection then
            respawnConnection:Disconnect()
            respawnConnection = nil
        end
    end
end

return DeathTP