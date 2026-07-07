local Shitaura = {}

Shitaura.Name = "Shitaura"
Shitaura.Enabled = false

local SwordHit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SwordHit

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local connection = nil

Shitaura.Config = {
    { Name = "Range", Type = "Slider", Min = 10, Max = 200, Default = 80, Value = 80, Suffix = " studs" },
    { Name = "Speed", Type = "Slider", Min = 0.01, Max = 0.1, Default = 0.03, Value = 0.03, Suffix = " seconds" }
}

Shitaura.Run = function()
    Shitaura.Enabled = not Shitaura.Enabled

    if Shitaura.Enabled then
        print("✅ Shitaura Enabled (Movement Bypass)")
        
        connection = task.spawn(function()
            while Shitaura.Enabled do
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local selfPos = root.Position

                    -- Find weapon
                    local weapon = nil
                    if player.Character then
                        weapon = player.Character:FindFirstChildWhichIsA("Tool")
                    end
                    if not weapon then
                        weapon = player.Backpack:FindFirstChildWhichIsA("Tool")
                    end

                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr == player then continue end

                        local targetChar = plr.Character
                        local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                        if not targetRoot then continue end

                        local distance = (targetRoot.Position - selfPos).Magnitude
                        if distance > Shitaura.Config[1].Value then continue end

                        -- Bypass movement check by teleporting closer
                        local behindPos = targetRoot.Position - targetRoot.CFrame.LookVector * 8
                        root.CFrame = CFrame.lookAt(behindPos, targetRoot.Position)

                        -- Attack
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
                    end
                end

                task.wait(Shitaura.Config[2].Value)
            end
        end)

    else
        print("❌ Shitaura Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return Shitaura