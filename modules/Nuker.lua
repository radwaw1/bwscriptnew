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
        
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not Nuker.Enabled then return end

            local char = game.Players.LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end

            local root = char.HumanoidRootPart
            local pos = root.Position

            -- Get nearby blocks
            for _, part in ipairs(workspace:GetPartBoundsInRadius(pos, 20)) do
                if part.Name == "Block" or part:FindFirstChild("Block") then
                    local blockPos = part.Position

                    DamageBlock:InvokeServer({
                        blockRef = {
                            blockPosition = blockPos
                        },
                        hitPosition = blockPos + Vector3.new(0.5, 0.5, 0.5),
                        hitNormal = Vector3.new(0, 1, 0)
                    })
                end
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