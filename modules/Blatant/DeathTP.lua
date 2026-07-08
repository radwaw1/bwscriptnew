local DeathTP = {}

DeathTP.Name = "DeathTP"
DeathTP.Enabled = false

local player = game:GetService("Players").LocalPlayer
local lastDeathPos = nil

DeathTP.Config = {
    { Name = "Y Limit", Type = "Slider", Min = -50, Max = 100, Default = 0, Value = 0, Suffix = "" }
}

DeathTP.Run = function()
    DeathTP.Enabled = not DeathTP.Enabled

    if DeathTP.Enabled then
        print("✅ DeathTP Enabled")

        -- Track death position
        player.CharacterAdded:Connect(function(char)
            if lastDeathPos and lastDeathPos.Y > DeathTP.Config[1].Value then
                task.wait(4) -- Wait for character to load
                local root = char:WaitForChild("HumanoidRootPart")
                root.CFrame = CFrame.new(lastDeathPos + Vector3.new(0, 3, 0))
                print("DeathTP: Returned to death position")
            end
        end)

        player.CharacterRemoving:Connect(function(char)
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                lastDeathPos = root.Position
            end
        end)

    else
        print("❌ DeathTP Disabled")
        lastDeathPos = nil
    end
end

return DeathTP