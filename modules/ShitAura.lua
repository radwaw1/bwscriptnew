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
        print("Killaura Enabled - 20 studs")
        
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not Killaura.Enabled then return end

            local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if not rootPart then return end

            local selfPos = rootPart.Position

            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == player then continue end

                local targetChar = plr.Character
                local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                if not targetRoot then continue end

                local distance = (targetRoot.Position - selfPos).Magnitude
                if distance > 20 then continue end

                -- Calculate positions like the example
                local dir = CFrame.lookAt(selfPos, targetRoot.Position).LookVector
                local selfValidatePos = selfPos + dir * math.max(distance - 14.4, 0)

                local weapon = player.Character:FindFirstChildWhichIsA("Tool") 
                           or player.Backpack:FindFirstChildWhichIsA("Tool")

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