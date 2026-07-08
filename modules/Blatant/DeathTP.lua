local DeathTP = {}

DeathTP.Name = "DeathTP (fix)"
DeathTP.Enabled = false

local player = game:GetService("Players").LocalPlayer
local lastDeathPosition = nil

DeathTP.Config = {
    { Name = "Delay", Type = "Slider", Min = 1, Max = 10, Default = 5, Value = 5, Suffix = " seconds" },
    { Name = "Y Limit", Type = "Slider", Min = -100, Max = 100, Default = 0, Value = 0, Suffix = "" }
}

DeathTP.Run = function()
    DeathTP.Enabled = not DeathTP.Enabled

    if DeathTP.Enabled then
        print("✅ DeathTP Enabled (5s after death)")

        -- Track death position
        player.CharacterRemoving:Connect(function(char)
            local root = char:FindFirstChild("HumanoidRootPart")
            if root and root.Position.Y > DeathTP.Config[2].Value then
                lastDeathPosition = root.Position
            end
        end)

        -- Teleport on respawn after delay
        player.CharacterAdded:Connect(function(char)
            if lastDeathPosition then
                task.delay(DeathTP.Config[1].Value, function()
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        -- Safe teleport
                        root.CFrame = CFrame.new(lastDeathPosition + Vector3.new(0, 5, 0))
                        print("DeathTP: Teleported back after " .. DeathTP.Config[1].Value .. " seconds")
                    end
                end)
            end
        end)

    else
        print("❌ DeathTP Disabled")
        lastDeathPosition = nil
    end
end

return DeathTP