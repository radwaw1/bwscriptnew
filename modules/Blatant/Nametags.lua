local Nametags = {}

Nametags.Name = "Nametags"
Nametags.Enabled = true

local player = game:GetService("Players").LocalPlayer
local nametagBillboards = {}

local function createNametag(plr)
    local char = plr.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end

    if nametagBillboards[plr] then
        nametagBillboards[plr]:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Size = UDim2.new(0, 220, 0, 70)
    billboard.StudsOffset = Vector3.new(0, 4.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Adornee = char.HumanoidRootPart
    billboard.Parent = char

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1,0,1,0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = plr.TeamColor.Color
    textLabel.TextStrokeTransparency = 0.5
    textLabel.TextStrokeColor3 = Color3.new(0,0,0)
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 15
    textLabel.Text = string.format("%s\n%.1f studs\n%d%% HP", plr.Name, 0, 100)
    textLabel.Parent = billboard

    nametagBillboards[plr] = billboard
end

Nametags.Run = function()
    Nametags.Enabled = not Nametags.Enabled

    if Nametags.Enabled then
        print("✅ Nametags Enabled")
        
        -- Handle existing players
        for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
            if plr == player then continue end
            createNametag(plr)
        end

        -- Handle respawns
        for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
            if plr == player then continue end
            plr.CharacterAdded:Connect(function()
                task.wait(0.5)
                createNametag(plr)
            end)
        end

        -- Update loop
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

                    if nametagBillboards[plr] then
                        local distance = (root.Position - (player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart.Position or Vector3.new())).Magnitude
                        local healthPercent = math.floor((hum.Health / hum.MaxHealth) * 100)

                        nametagBillboards[plr].TextLabel.Text = string.format(
                            "%s\n%.1f studs\n%d%% HP", 
                            plr.Name,
                            distance,
                            healthPercent
                        )
                    end
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