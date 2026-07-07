local Nametags = {}

Nametags.Name = "Nametags"
Nametags.Enabled = false

local player = game:GetService("Players").LocalPlayer
local nametagBillboards = {}

Nametags.Run = function()
    Nametags.Enabled = not Nametags.Enabled

    if Nametags.Enabled then
        print("✅ Nametags Enabled")
        
        task.spawn(function()
            while Nametags.Enabled do
                for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                    if plr == player then continue end

                    local char = plr.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") or not char:FindFirstChild("Humanoid") then
                        if nametagBillboards[plr] then
                            nametagBillboards[plr]:Destroy()
                            nametagBillboards[plr] = nil
                        end
                        continue
                    end

                    local root = char.HumanoidRootPart
                    local hum = char.Humanoid

                    -- Create/Update Nametag
                    if not nametagBillboards[plr] then
                        local billboard = Instance.new("BillboardGui")
                        billboard.Size = UDim2.new(0, 200, 0, 60)
                        billboard.StudsOffset = Vector3.new(0, 4, 0)
                        billboard.AlwaysOnTop = true
                        billboard.Adornee = root
                        billboard.Parent = char

                        local textLabel = Instance.new("TextLabel")
                        textLabel.Size = UDim2.new(1,0,1,0)
                        textLabel.BackgroundTransparency = 1
                        textLabel.TextColor3 = plr.TeamColor.Color
                        textLabel.TextStrokeTransparency = 0.7
                        textLabel.Font = Enum.Font.GothamBold
                        textLabel.TextSize = 14
                        textLabel.Parent = billboard

                        nametagBillboards[plr] = billboard
                    end

                    local distance = (root.Position - player.Character.HumanoidRootPart.Position).Magnitude
                    local healthPercent = math.floor((hum.Health / hum.MaxHealth) * 100)

                    nametagBillboards[plr].TextLabel.Text = string.format(
                        "%s\n%.1f studs\n%d%%", 
                        plr.Team and plr.Team.Name or "No Team",
                        distance,
                        healthPercent
                    )
                end

                task.wait(0.1)
            end
        end)

    else
        print("❌ Nametags Disabled")
        for _, billboard in pairs(nametagBillboards) do
            billboard:Destroy()
        end
        nametagBillboards = {}
    end
end

return Nametags