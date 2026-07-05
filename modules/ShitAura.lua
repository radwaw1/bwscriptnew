local Killaura = {}

Killaura.Name = "Killaura"
Killaura.Enabled = false

local SwordHit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SwordHit

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local connection = nil

Killaura.Config = {
    { Name = "Range", Type = "Slider", Min = 0, Max = 30, Default = 20, Value = 20, Suffix = " studs" },
    { Name = "Max Targets", Type = "Slider", Min = 1, Max = 10, Default = 5, Value = 5 },
    { Name = "Attack Speed", Type = "Slider", Min = 1, Max = 120, Default = 60, Value = 60, Suffix = " Hz" },
    { Name = "Sword Only", Type = "Toggle", Default = false, Value = false }
}

Killaura.Run = function()
    Killaura.Enabled = not Killaura.Enabled

    if Killaura.Enabled then
        print("✅ Killaura Enabled (0.05s interval)")
        
        connection = task.spawn(function()
            while Killaura.Enabled do
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local selfPos = root.Position

                    -- Sword Only Check
                    local canAttack = true
                    if Killaura.Config[4].Value then
                        canAttack = false
                        if player.Character then
                            local tool = player.Character:FindFirstChildWhichIsA("Tool")
                            if tool and tool.Name:lower():find("sword") then
                                canAttack = true
                            end
                        end
                    end

                    if canAttack then
                        local range = Killaura.Config[1].Value
                        local maxTargets = Killaura.Config[2].Value
                        local weapon = player.Character and player.Character:FindFirstChildWhichIsA("Tool") 
                                    or player.Backpack:FindFirstChildWhichIsA("Tool")

                        local targetsAttacked = 0

                        for _, plr in ipairs(Players:GetPlayers()) do
                            if plr == player or targetsAttacked >= maxTargets then continue end

                            local targetChar = plr.Character
                            local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                            if not targetRoot then continue end

                            local distance = (targetRoot.Position - selfPos).Magnitude
                            if distance > range then continue end

                            local dir = CFrame.lookAt(selfPos, targetRoot.Position).LookVector
                            local selfValidatePos = selfPos + dir * math.max(distance - 14.4, 0)

                            SwordHit:FireServer({
                                chargedAttack = { chargeRatio = 0 },
                                entityInstance = targetChar,
                                validate = {
                                    selfPosition = { value = selfValidatePos },
                                    targetPosition = { value = targetRoot.Position }
                                },
                                weapon = weapon
                            })

                            targetsAttacked += 1
                        end
                    end
                end

                task.wait(0.05)  -- Fixed 0.05 seconds interval
            end
        end)

    else
        print("❌ Killaura Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return Killaura