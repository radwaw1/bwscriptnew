local DeathEscape = {}

DeathEscape.Name = "DeathEscape"
DeathEscape.Enabled = false

local player = game:GetService("Players").LocalPlayer
local workspace = game:GetService("Workspace")

DeathEscape.Config = {
    { Name = "Health Threshold", Type = "Slider", Min = 1, Max = 100, Default = 30, Value = 30, Suffix = "%" },
    { Name = "Escape Distance", Type = "Slider", Min = 10, Max = 50, Default = 30, Value = 30, Suffix = " studs" }
}

DeathEscape.Run = function()
    DeathEscape.Enabled = not DeathEscape.Enabled

    if DeathEscape.Enabled then
        print("✅ DeathEscape Enabled")

        task.spawn(function()
            while DeathEscape.Enabled do
                local char = player.Character
                if char then
                    local humanoid = char:FindFirstChild("Humanoid")
                    local root = char:FindFirstChild("HumanoidRootPart")

                    if humanoid and root and humanoid.Health > 0 then
                        local healthPercent = (humanoid.Health / humanoid.MaxHealth) * 100

                        if healthPercent <= DeathEscape.Config[1].Value then
                            local selfPos = root.Position
                            local targetPos = nil

                            -- 1. Check for teammate with >60 HP
                            for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                                if plr ~= player and plr.Team == player.Team then
                                    local targetChar = plr.Character
                                    local targetHum = targetChar and targetChar:FindFirstChild("Humanoid")
                                    local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                                    if targetHum and targetHum.Health > 60 and targetRoot then
                                        targetPos = targetRoot.Position + Vector3.new(0, 3, 0)
                                        break
                                    end
                                end
                            end

                            -- 2. If no good teammate, escape from enemies
                            if not targetPos then
                                local escapeDir = nil
                                for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                                    if plr ~= player and plr.Team ~= player.Team then
                                        local targetChar = plr.Character
                                        local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                                        if targetRoot then
                                            local dir = (selfPos - targetRoot.Position).Unit
                                            escapeDir = (escapeDir or dir) + dir
                                        end
                                    end
                                end

                                if escapeDir then
                                    escapeDir = escapeDir.Unit
                                    targetPos = selfPos + escapeDir * DeathEscape.Config[2].Value

                                    -- Raycast to solid ground
                                    local rayParams = RaycastParams.new()
                                    rayParams.FilterDescendantsInstances = {char}
                                    rayParams.FilterType = Enum.RaycastFilterType.Exclude

                                    local rayResult = workspace:Raycast(targetPos + Vector3.new(0, 10, 0), Vector3.new(0, -50, 0), rayParams)
                                    if rayResult then
                                        targetPos = rayResult.Position + Vector3.new(0, 3, 0)
                                    end
                                end
                            end

                            if targetPos then
                                root.CFrame = CFrame.new(targetPos)
                                print("DeathEscape: Teleported to safety")
                            end
                        end
                    end
                end

                task.wait(0.1)
            end
        end)

    else
        print("❌ DeathEscape Disabled")
    end
end

return DeathEscape