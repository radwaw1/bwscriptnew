local AntiFall = {}

AntiFall.Name = "AntiFall"
AntiFall.Enabled = false

local player = game:GetService("Players").LocalPlayer

AntiFall.Config = {
    { Name = "Fall Time", Type = "Slider", Min = 0.5, Max = 3, Default = 1, Value = 1, Suffix = " seconds" },
    { Name = "Ground Distance", Type = "Slider", Min = 5, Max = 20, Default = 10, Value = 10, Suffix = " studs" }
}

AntiFall.Run = function()
    AntiFall.Enabled = not AntiFall.Enabled

    if AntiFall.Enabled then
        print("✅ AntiFall Enabled")
        
        task.spawn(function()
            local fallTimer = 0

            while AntiFall.Enabled do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                    local root = char.HumanoidRootPart
                    local hum = char.Humanoid

                    if hum:GetState() == Enum.HumanoidStateType.Freefall then
                        fallTimer = fallTimer + 0.05

                        if fallTimer > AntiFall.Config[1].Value then
                            local rayParams = RaycastParams.new()
                            rayParams.FilterDescendantsInstances = {char}
                            rayParams.FilterType = Enum.RaycastFilterType.Exclude

                            local ray = workspace:Raycast(root.Position, Vector3.new(0, -AntiFall.Config[2].Value, 0), rayParams)
                            if ray then
                                -- Reset Y velocity for a moment
                                root.Velocity = Vector3.new(root.Velocity.X, 0, root.Velocity.Z)
                                fallTimer = 0
                            end
                        end
                    else
                        fallTimer = 0
                    end
                end

                task.wait(0.05)
            end
        end)

    else
        print("❌ AntiFall Disabled")
    end
end

return AntiFall