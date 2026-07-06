local Nuker = {}

Nuker.Name = "Nuker"
Nuker.Enabled = false

local DamageBlock = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@easy-games"]["block-engine"].node_modules["@rbxts"].net.out._NetManaged.DamageBlock

local connection = nil

Nuker.Run = function()
    Nuker.Enabled = not Nuker.Enabled

    if Nuker.Enabled then
        print("✅ Nuker Enabled")
        
        connection = task.spawn(function()
            while Nuker.Enabled do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local rootPos = char.HumanoidRootPart.Position

                    -- Break beds first
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

                    -- Break normal blocks
                    for _, part in ipairs(workspace:GetPartBoundsInRadius(rootPos, 30)) do
                        if part.Name == "Block" or (part.Parent and part.Parent.Name == "Blocks") then
                            local pos = part.Position
                            DamageBlock:InvokeServer({
                                blockRef = { blockPosition = pos },
                                hitPosition = pos + Vector3.new(0.5, 0.5, 0.5),
                                hitNormal = Vector3.new(0, 1, 0)
                            })
                        end
                    end
                end

                task.wait(0.1)
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