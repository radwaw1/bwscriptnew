local DeathTP = {}

DeathTP.Name = "DeathTP (fix)"
DeathTP.Enabled = false

local player = game:GetService("Players").LocalPlayer
local lastDeathPos = nil

DeathTP.Config = {
    { Name = "Y Limit", Type = "Slider", Min = -100, Max = 100, Default = 0, Value = 0, Suffix = "" },
    { Name = "Keybind", Type = "Keybind", Value = Enum.KeyCode.F }
}

DeathTP.Run = function()
    DeathTP.Enabled = not DeathTP.Enabled

    if DeathTP.Enabled then
        print("✅ DeathTP Enabled")

        -- Track death position
        player.CharacterRemoving:Connect(function(char)
            local root = char:FindFirstChild("HumanoidRootPart")
            if root and root.Position.Y > DeathTP.Config[1].Value then
                lastDeathPos = root.Position
                print("DeathTP: Recorded death position at Y = " .. lastDeathPos.Y)
            end
        end)

        -- Teleport on respawn
        player.CharacterAdded:Connect(function(char)
            if lastDeathPos then
                task.wait(0.5) -- Wait for character to fully load
                local root = char:WaitForChild("HumanoidRootPart")
                root.CFrame = CFrame.new(lastDeathPos + Vector3.new(0, 5, 0))
                print("DeathTP: Teleported back to death position")
            end
        end)

    else
        print("❌ DeathTP Disabled")
        lastDeathPos = nil
    end
end

return DeathTP