local ClickTP = {}

ClickTP.Name = "ClickTP"
ClickTP.Enabled = false

local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

local circle = nil
local connection = nil

ClickTP.Run = function()
    ClickTP.Enabled = not ClickTP.Enabled

    if ClickTP.Enabled then
        print("✅ ClickTP Enabled")

        -- Create visual circle
        circle = Instance.new("Part")
        circle.Size = Vector3.new(5, 0.1, 5)
        circle.Shape = Enum.PartType.Cylinder
        circle.Transparency = 0.5
        circle.Color = Color3.fromRGB(0, 170, 255)
        circle.Anchored = true
        circle.CanCollide = false
        circle.CanQuery = false
        circle.Parent = workspace

        connection = mouse.Button1Down:Connect(function()
            local targetPos = mouse.Hit.Position
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
            end
        end)

        -- Update circle position
        task.spawn(function()
            while ClickTP.Enabled do
                if circle then
                    circle.CFrame = CFrame.new(mouse.Hit.Position) * CFrame.Angles(0, 0, math.rad(90))
                end
                task.wait(0.016)
            end
        end)

    else
        print("❌ ClickTP Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
        if circle then
            circle:Destroy()
            circle = nil
        end
    end
end

return ClickTP