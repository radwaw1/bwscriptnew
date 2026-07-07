local BedNuker = {}

BedNuker.Name = "BedNuker"
BedNuker.Enabled = false

local DamageBlock = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@easy-games"]["block-engine"].node_modules["@rbxts"].net.out._NetManaged.DamageBlock

local connection = nil

BedNuker.Config = {
    { Name = "Range", Type = "Slider", Min = 10, Max = 40, Default = 20, Value = 20, Suffix = " studs" }
}

BedNuker.Run = function()
    BedNuker.Enabled = not BedNuker.Enabled

    if BedNuker.Enabled then
        print("✅ BedNuker Enabled")
        
        connection = task.spawn(function()
            while BedNuker.Enabled do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local rootPos = char.HumanoidRootPart.Position

                    -- Break beds
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj.Name:lower():find("bed") and obj:IsA("BasePart") then
                            local pos = obj.Position
                            if (pos - rootPos).Magnitude < BedNuker.Config[1].Value then
                                local blockPos = pos / 3  -- BlockEngine coordinate
                                DamageBlock:InvokeServer({
                                    blockRef = {
                                        blockPosition = blockPos
                                    },
                                    hitPosition = pos + Vector3.new(0.5, 0.5, 0.5),
                                    hitNormal = Vector3.new(0, 1, 0)
                                })
                            end
                        end
                    end
                end

                task.wait(0.1)
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