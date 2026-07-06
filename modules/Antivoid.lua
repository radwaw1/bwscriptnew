local AntiVoid = {}

AntiVoid.Name = "AntiVoid"
AntiVoid.Enabled = false

local player = game:GetService("Players").LocalPlayer
local workspace = game:GetService("Workspace")

AntiVoid.Config = {
    { Name = "Bounce Height", Type = "Slider", Min = 50, Max = 200, Default = 200, Value = 200, Suffix = "" },
    { Name = "Void Y Level", Type = "Slider", Min = -50, Max = 25, Default = 10, Value = 10, Suffix = "" }
}

AntiVoid.Run = function()
    AntiVoid.Enabled = not AntiVoid.Enabled

    if AntiVoid.Enabled then
        print("✅ AntiVoid Enabled (Velocity Bounce)")

        task.spawn(function()
            while AntiVoid.Enabled do
                local char = player.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    local humanoid = char:FindFirstChild("Humanoid")

                    if root and humanoid and root.Position.Y < AntiVoid.Config[2].Value then
                        -- Bounce up with velocity
                        root.Velocity = Vector3.new(root.Velocity.X, AntiVoid.Config[1].Value, root.Velocity.Z)
                        print("AntiVoid: Bounced up")
                    end
                end

                task.wait(0.05)
            end
        end)

    else
        print("❌ AntiVoid Disabled")
    end
end

return AntiVoid