local Killaura = {}

Killaura.Name = "Killaura"
Killaura.Enabled = false

local SwordHit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SwordHit

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local connection = nil

-- Config
Killaura.Config = {
    { Name = "Range", Type = "Slider", Min = 0, Max = 30, Default = 20, Value = 20, Suffix = " studs" },
    { Name = "Max Targets", Type = "Slider", Min = 1, Max = 10, Default = 5, Value = 5 },
    { Name = "Attack Speed", Type = "Slider", Min = 1, Max = 120, Default = 60, Value = 60, Suffix = " Hz" },
    { Name = "Sword Only", Type = "Toggle", Default = false, Value = false }
}

Killaura.Run = function()
    Killaura.Enabled = not Killaura.Enabled

    if Killaura.Enabled then
        print("✅ Killaura Enabled")
        
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not Killaura.Enabled then return end

            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            local selfPos = root.Position

            -- Sword Only Check
            if Killaura.Config[4].Value then
                local holdingSword = false
                if player.Character then
                    local tool = player.Character:FindFirstChildWhichIsA("Tool")
                    if tool and tool.Name:lower():find("sword") then
                        holdingSword = true
                    end
                end
                if not holdingSword then return end
            end

            local range = Killaura.Config[1].Value
            local maxTargets = Killaura.Config[2].Value
            local attackRate = 1 / math.max(Killaura.Config[3].Value, 1)

            local targetsAttacked = 0
            local weapon = player.Character and player.Character:FindFirstChildWhichIsA("Tool") 
                        or player.Backpack:FindFirstChildWhichIsA("Tool")

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