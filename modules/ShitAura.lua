local Killaura = {}

Killaura.Name = "Killaura"
Killaura.Enabled = false

local SwordHit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SwordHit

local connection = nil

Killaura.Run = function()
    Killaura.Enabled = not Killaura.Enabled

    if Killaura.Enabled then
        print("Killaura Enabled - Testing mode")
        
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not Killaura.Enabled then return end

            local character = entitylib.character
            if not character or not character.RootPart then return end

            local selfpos = character.RootPart.Position

            -- Get nearby players
            for _, v in ipairs(Players:GetPlayers()) do
                if v == player then continue end
                local targetChar = v.Character
                if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then continue end

                local targetPos = targetChar.HumanoidRootPart.Position
                local distance = (targetPos - selfpos).Magnitude

                if distance > 20 then continue end

                local dir = CFrame.lookAt(selfpos, targetPos).LookVector
                local pos = selfpos + dir * math.max(distance - 14.4, 0)

                SwordHit:FireServer({
                    chargedAttack = { chargeRatio = 0 },
                    entityInstance = targetChar,
                    validate = {
                        selfPosition = { value = pos },
                        targetPosition = { value = targetPos }
                    },
                    weapon = player.Backpack:FindFirstChildWhichIsA("Tool") or player.Character:FindFirstChildWhichIsA("Tool")
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