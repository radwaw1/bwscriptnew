local Nuker = {}

Nuker.Name = "Nuker"
Nuker.Enabled = false

local DamageBlock = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@easy-games"]["block-engine"].node_modules["@rbxts"].net.out._NetManaged.DamageBlock

local connection = nil

Nuker.Run = function()
    Nuker.Enabled = not Nuker.Enabled

    if Nuker.Enabled then
        print("✅ Smart Nuker Enabled (Beds first)")
        
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not Nuker.Enabled then return end

            local char = game.Players.LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end

            local rootPos = char.HumanoidRootPart.Position

            -- 1. Find and break beds first
            for _, bed in ipairs(workspace:GetChildren()) do
                if bed.Name:lower() == "bed" or bed.Name:find("bed") then
                    local blockPos = bed.Position

                    DamageBlock:InvokeServer({
                        blockRef = { blockPosition = blockPos },
                        hitPosition = blockPos + Vector3.new(0.5, 0.5, 0.5),
                        hitNormal = Vector3.new(0, 1, 0)
                    })
                end
            end

            -- 2. Break nearby blocks (including around beds)
            for _, part in ipairs(workspace:GetPartBoundsInRadius(rootPos, 25)) do
                if part.Name == "Block" or part.Parent.Name == "Blocks" then
                    local blockPos = part.Position

                    DamageBlock:InvokeServer({
                        blockRef = { blockPosition = blockPos },
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