local Spider = {}

Spider.Name = "Spider"
Spider.Enabled = false

local player = game:GetService("Players").LocalPlayer

Spider.Config = {
    { Name = "Speed", Type = "Slider", Min = 0.1, Max = 5, Default = 1.5, Value = 1.5, Suffix = "" },
    { Name = "Keybind", Type = "Keybind", Value = Enum.KeyCode.LeftControl }
}

Spider.Run = function()
    Spider.Enabled = not Spider.Enabled

    if Spider.Enabled then
        print("✅ Spider Enabled")
        
        task.spawn(function()
            while Spider.Enabled do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                    local root = char.HumanoidRootPart
                    local hum = char.Humanoid

                    if hum:GetState() == Enum.HumanoidStateType.Freefall or hum:GetState() == Enum.HumanoidStateType.Jumping then
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {char}
                        rayParams.FilterType = Enum.RaycastFilterType.Exclude

                        -- Check for wall in front
                        local ray = workspace:Raycast(root.Position, root.CFrame.LookVector * 3, rayParams)
                        if ray then
                            root.Velocity = Vector3.new(root.Velocity.X, Spider.Config[1].Value * 10, root.Velocity.Z)
                        end
                    end
                end

                task.wait(0.05)
            end
        end)

    else
        print("❌ Spider Disabled")
    end
end

return Spider