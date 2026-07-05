local Tpaura = {}

Tpaura.Name = "TPaura"
Tpaura.Enabled = false

local SwordHit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SwordHit

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local connection = nil

Tpaura.Run = function()
    Tpaura.Enabled = not Tpaura.Enabled

    if Tpaura.Enabled then
        print("✅ Shitaura Enabled (40 studs + TP behind + Hitreg 36)")
        
        connection = task.spawn(function()
            while Tpaura.Enabled do
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
                    if not weapon then
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
                        if distance > 40 then continue end

                        -- TP 5 studs behind target
                        local behindPos = targetRoot.Position - targetRoot.CFrame.LookVector * 5
                        root.CFrame = CFrame.lookAt(behindPos, targetRoot.Position)

                        -- Improved Hitreg (36)
                        local dir = CFrame.lookAt(selfPos, targetRoot.Position).LookVector
                        local selfValidatePos = selfPos + dir * math.max(distance - 36, 0)

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

                task.wait(0.05)
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

return Tpaura