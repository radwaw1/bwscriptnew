local Killaura = {}

Killaura.Name = "Shitaura"
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

            local selfPos = root.Position

            -- Find a sword from inventory or character
            local weapon = nil
            if player.Character then
                weapon = player.Character:FindFirstChildWhichIsA("Tool")
            end
            if not weapon then
                weapon = player.Backpack:FindFirstChildWhichIsA("Tool")
            end
            if not weapon then
                -- Try to find any sword from inventory
                local inventory = game:GetService("ReplicatedStorage").Inventories:FindFirstChild(player.Name)
                if inventory then
                    for _, item in ipairs(inventory:GetChildren()) do
                        if item.Name:find("sword") or item.Name:find("Sword") then
                            weapon = item
                            break
                        end
                    end
                end
            end

            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == player then continue end

                local targetChar = plr.Character
                local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                if not targetRoot then continue end

                local distance = (targetRoot.Position - selfPos).Magnitude
                if distance > 20 then continue end

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