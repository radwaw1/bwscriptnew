local LongKillaura = {}

LongKillaura.Name = "LongKillaura"
LongKillaura.Enabled = false

local SwordHit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SwordHit

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local connection = nil

LongKillaura.Config = {
    { Name = "Range", Type = "Slider", Min = 10, Max = 300, Default = 120, Value = 120, Suffix = " studs" },
    { Name = "Speed", Type = "Slider", Min = 0.01, Max = 0.5, Default = 0.08, Value = 0.08, Suffix = " seconds" }
}

LongKillaura.Run = function()
    LongKillaura.Enabled = not LongKillaura.Enabled

    if LongKillaura.Enabled then
        print("✅ LongKillaura Enabled (Range Bypass + Camera Fix)")
        
        connection = task.spawn(function()
            while LongKillaura.Enabled do
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local selfPos = root.Position
                    local originalCFrame = root.CFrame
                    local originalCamCFrame = camera.CFrame

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
                        if plr == player or plr.Team == player.Team then continue end

                        local targetChar = plr.Character
                        if not targetChar or not targetChar:FindFirstChild("Humanoid") or targetChar.Humanoid.Health <= 0 then continue end

                        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
                        if not targetRoot then continue end

                        local distance = (targetRoot.Position - selfPos).Magnitude
                        if distance > LongKillaura.Config[1].Value then continue end

                        -- TP to target
                        local behindPos = targetRoot.Position - targetRoot.CFrame.LookVector * 8
                        root.CFrame = CFrame.lookAt(behindPos, targetRoot.Position)

                        -- Keep camera in place
                        camera.CFrame = originalCamCFrame

                        task.wait(0.15)  -- Increased time for attack

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

                        -- TP back + restore camera
                        root.CFrame = originalCFrame
                        camera.CFrame = originalCamCFrame
                    end
                end

                task.wait(LongKillaura.Config[2].Value)
            end
        end)

    else
        print("❌ LongKillaura Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return LongKillaura