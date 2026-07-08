local BedTP = {}

BedTP.Name = "BedTP (modes with 2 teams only)"
BedTP.Enabled = false

local player = game:GetService("Players").LocalPlayer

BedTP.Config = {
    { Name = "Keybind", Type = "Keybind", Value = Enum.KeyCode.F }
}

BedTP.Run = function()
    BedTP.Enabled = not BedTP.Enabled

    if BedTP.Enabled then
        print("✅ BedTP Enabled (One-time teleport)")
        
        -- Teleport to furthest bed
        local beds = {}
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj.Name:lower():find("bed") and obj:IsA("BasePart") then
                table.insert(beds, obj)
            end
        end

        if #beds > 0 then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local rootPos = char.HumanoidRootPart.Position
                local furthestBed = beds[1]
                local maxDistance = (furthestBed.Position - rootPos).Magnitude

                for _, bed in ipairs(beds) do
                    local dist = (bed.Position - rootPos).Magnitude
                    if dist > maxDistance then
                        maxDistance = dist
                        furthestBed = bed
                    end
                end

                char.HumanoidRootPart.CFrame = furthestBed.CFrame + Vector3.new(0, 5, 0)
                print("Teleported to furthest bed")
            end
        else
            print("No beds found")
        end

        -- Auto disable after teleport
        task.wait(0.5)
        BedTP.Enabled = false
        print("❌ BedTP Disabled (Auto)")

    end
end

return BedTP