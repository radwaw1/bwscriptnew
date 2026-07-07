local BedNuker = {}

BedNuker.Name = "BedNuker"
BedNuker.Enabled = false

local DamageBlock = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@easy-games"]["block-engine"].node_modules["@rbxts"].net.out._NetManaged.DamageBlock

local connection = nil

BedNuker.Config = {
    { Name = "Range", Type = "Slider", Min = 10, Max = 100, Default = 50, Value = 50, Suffix = " studs" },
    { Name = "Speed", Type = "Slider", Min = 0.05, Max = 1, Default = 0.15, Value = 0.15, Suffix = " seconds" }
}

local function getSurroundingBlocks(centerPos)
    local blocks = {}
    for x = -1, 1 do
        for y = -1, 1 do
            for z = -1, 1 do
                if x == 0 and y == 0 and z == 0 then continue end
                local pos = centerPos + Vector3.new(x, y, z) * 3
                table.insert(blocks, pos)
            end
        end
    end
    return blocks
end

BedNuker.Run = function()
    BedNuker.Enabled = not BedNuker.Enabled

    if BedNuker.Enabled then
        print("✅ Smart BedNuker Enabled")
        
        connection = task.spawn(function()
            while BedNuker.Enabled do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local rootPos = char.HumanoidRootPart.Position

                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("bed") and obj:IsA("BasePart") then
                            local bedPos = obj.Position
                            if (bedPos - rootPos).Magnitude > BedNuker.Config[1].Value then continue end

                            local blockPos = bedPos / 3

                            -- Break bed
                            DamageBlock:InvokeServer({
                                blockRef = { blockPosition = blockPos },
                                hitPosition = bedPos + Vector3.new(0.5, 0.5, 0.5),
                                hitNormal = Vector3.new(0, 1, 0)
                            })

                            -- Break surrounding blocks
                            local surrounding = getSurroundingBlocks(blockPos)
                            for _, sPos in ipairs(surrounding) do
                                DamageBlock:InvokeServer({
                                    blockRef = { blockPosition = sPos },
                                    hitPosition = sPos * 3 + Vector3.new(0.5, 0.5, 0.5),
                                    hitNormal = Vector3.new(0, 1, 0)
                                })
                            end
                        end
                    end
                end

                task.wait(BedNuker.Config[2].Value)
            end
        end)

    else
        print("❌ BedNuker Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return BedNuker