local DeathTP = {}

DeathTP.Name = "DeathTP"
DeathTP.Enabled = false

local player = game:GetService("Players").LocalPlayer
local savedCFrame = nil

local deathConn = nil
local respawnConn = nil

DeathTP.Run = function()
    DeathTP.Enabled = not DeathTP.Enabled

    if DeathTP.Enabled then
        print("✅ DeathTP Enabled (6s delay)")

        -- Save position when character dies
        deathConn = player.CharacterAdded:Connect(function(char)
            task.wait(0.3)
            local root = char:WaitForChild("HumanoidRootPart", 2)
            if root then
                savedCFrame = root.CFrame
            end
        end)

        -- Teleport back after respawn
        respawnConn = player.CharacterAdded:Connect(function(char)
            task.delay(6, function() -- 6 seconds after respawn
                if not DeathTP.Enabled or not savedCFrame then return end

                local root = char:WaitForChild("HumanoidRootPart", 3)
                if root then
                    root.CFrame = savedCFrame
                    print("DeathTP: Teleported back")
                end
            end)
        end)

    else
        print("❌ DeathTP Disabled")
        if deathConn then deathConn:Disconnect() end
        if respawnConn then respawnConn:Disconnect() end
        deathConn = nil
        respawnConn = nil
    end
end

return DeathTP