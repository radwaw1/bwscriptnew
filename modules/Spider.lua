local Spider = {}

Spider.Name = "Spider"
Spider.Enabled = false

local player = game:GetService("Players").LocalPlayer

Spider.Run = function()
    Spider.Enabled = not Spider.Enabled

    if Spider.Enabled then
        print("✅ Spider Enabled")
        
        task.spawn(function()
            while Spider.Enabled do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local root = char.HumanoidRootPart
                    local hum = char:FindFirstChild("Humanoid")

                    if hum then
                        -- Auto step up blocks
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {char}
                        rayParams.FilterType = Enum.RaycastFilterType.Exclude

                        local ray = workspace:Raycast(root.Position, Vector3.new(0, -3, 0), rayParams)
                        if ray then
                            local height = root.Position.Y - ray.Position.Y
                            if height > 2 and height < 6 then
                                root.CFrame = root.CFrame + Vector3.new(0, height + 1.5, 0)
                            end
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