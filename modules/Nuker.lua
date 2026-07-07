local Nuker = {}

Nuker.Name = "Nuker"
Nuker.Enabled = false

local DamageBlock = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@easy-games"]["block-engine"].node_modules["@rbxts"].net.out._NetManaged.DamageBlock

local connection = nil

Nuker.Config = {
    { Name = "Range", Type = "Slider", Min = 1, Max = 30, Default = 25, Value = 25, Suffix = " studs" },
    { Name = "Break Speed", Type = "Slider", Min = 0, Max = 0.3, Default = 0.1, Value = 0.1, Suffix = " seconds" },
    { Name = "Break Beds", Type = "Toggle", Default = true, Value = true },
    { Name = "Break Lucky Blocks", Type = "Toggle", Default = true, Value = true },
    { Name = "Break Iron Ore", Type = "Toggle", Default = true, Value = true },
    { Name = "Instant Break", Type = "Toggle", Default = false, Value = false }
}

Nuker.Run = function()
    Nuker.Enabled = not Nuker.Enabled

    if Nuker.Enabled then
        print("✅ Nuker fucking Enableadfsd")
        
        connection = task.spawn(function()
            while Nuker.Enabled do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local localPosition = char.HumanoidRootPart.Position

                    -- Break Beds First
                    if Nuker.Config[3].Value then
                        for _, obj in ipairs(workspace:GetDescendants()) do
                            if obj.Name:lower():find("bed") and obj:IsA("BasePart") then
                                local pos = obj.Position
                                DamageBlock:InvokeServer({
                                    blockRef = { blockPosition = pos },
                                    hitPosition = pos + Vector3.new(0.5, 0.5, 0.5),
                                    hitNormal = Vector3.new(0, 1, 0)
                                })
                            end
                        end
                    end

                    -- Break other blocks
                    for _, part in ipairs(workspace:GetPartBoundsInRadius(localPosition, Nuker.Config[1].Value)) do
                        local name = part.Name:lower()
                        if (Nuker.Config[4].Value and name:find("lucky")) or 
                           (Nuker.Config[5].Value and name:find("iron")) or
                           name == "block" then
                            local pos = part.Position
                            DamageBlock:InvokeServer({
                                blockRef = { blockPosition = pos },
                                hitPosition = pos + Vector3.new(0.5, 0.5, 0.5),
                                hitNormal = Vector3.new(0, 1, 0)
                            })
                        end
                    end
                end

                task.wait(Nuker.Config[2].Value)
            end
        end)

    else
        print("❌ Nuker Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return Nuker