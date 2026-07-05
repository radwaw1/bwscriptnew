local Killaura = {}

Killaura.Name = "Killaura"
Killaura.Enabled = false

local SwordHit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SwordHit

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local connection = nil

Killaura.Run = function()
    Killaura.Enabled = not Killaura.Enabled

    if Killaura.Enabled then
        print("Killaura Enabled")

        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not Killaura.Enabled then return end

            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            local selfpos = root.Position

            for _, v in ipairs(Players:GetPlayers()) do
                if v == player then continue end

                local targetChar = v.Character
                local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                if not targetRoot then continue end

                local distance = (targetRoot.Position - selfpos).Magnitude
                if distance > 20 then continue end

                local dir = CFrame.lookAt(selfpos, targetRoot.Position).LookVector
                local pos = selfpos + dir * math.max(distance - 14.4, 0)

                local weapon = player.Character:FindFirstChildWhichIsA("Tool") or player.Backpack:FindFirstChildWhichIsA("Tool")

                SwordHit:FireServer({
                    chargedAttack = { chargeRatio = 0 },
                    entityInstance = targetChar,
                    validate = {
                        selfPosition = { value = pos },
                        targetPosition = { value = targetRoot.Position }
                    },
                    weapon = weapon
                })
            end
        end)

    else
        print("Killaura Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return Killaura