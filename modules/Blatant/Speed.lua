local WalkSpeed = {}

WalkSpeed.Name = "WalkSpeed"
WalkSpeed.Enabled = false

local player = game:GetService("Players").LocalPlayer
local originalSpeed = 16

WalkSpeed.Config = {
    { Name = "Speed", Type = "Slider", Min = 0, Max = 150, Default = 20, Value = 20 }
}

WalkSpeed.Run = function()
    WalkSpeed.Enabled = not WalkSpeed.Enabled

    if WalkSpeed.Enabled then
        print("WalkSpeed Enabled")
        
        task.spawn(function()
            while WalkSpeed.Enabled do
                local char = player.Character
                if char then
                    local hum = char:FindFirstChild("Humanoid")
                    if hum then
                        hum.WalkSpeed = WalkSpeed.Config[1].Value
                    end
                end
                task.wait(0.1)
            end
        end)

    else
        print(" WalkSpeed Disabled")
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = originalSpeed
            end
        end
    end
end

return WalkSpeed