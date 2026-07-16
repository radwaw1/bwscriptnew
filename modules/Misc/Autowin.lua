local AutoWin = {}

AutoWin.Name = "AutoWin"
AutoWin.Enabled = false

local connection = nil
local bedNukerEnabled = false

local function getBeds()
    local beds = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:lower():find("bed") and obj:IsA("BasePart") then
            table.insert(beds, obj)
        end
    end
    return beds
end

local function getSecondNearestBed()
    local char = game.Players.LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end

    local pos = char.HumanoidRootPart.Position
    local beds = getBeds()
    local sorted = {}

    for _, bed in ipairs(beds) do
        table.insert(sorted, {bed, (bed.Position - pos).Magnitude})
    end

    table.sort(sorted, function(a, b) return a[2] < b[2] end)

    return sorted[2] and sorted[2][1] or sorted[1] and sorted[1][1]
end

AutoWin.Run = function()
    AutoWin.Enabled = not AutoWin.Enabled

    if AutoWin.Enabled then
        print("✅ AutoWin Enabled")

        -- Enable KrystalDisabler
        local krystal = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):FindFirstChild("KrystalDisabler", true))
        if krystal and krystal.Run then
            pcall(krystal.Run)
        end

        connection = task.spawn(function()
            while AutoWin.Enabled do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local root = char.HumanoidRootPart

                    -- TP to 2nd nearest bed
                    local targetBed = getSecondNearestBed()
                    if targetBed then
                        root.CFrame = targetBed.CFrame + Vector3.new(0, 5, 0)
                        print("AutoWin: Teleported to 2nd nearest bed")
                    end

                    task.wait(1)

                    -- Walk straight until void
                    local humanoid = char:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = 16
                        humanoid:MoveTo(root.Position + Vector3.new(0, -500, 0))
                    end
                end

                -- Wait for respawn
                game.Players.LocalPlayer.CharacterAdded:Wait()

                task.wait(1)

                -- TP to 2nd nearest bed again
                local newChar = game.Players.LocalPlayer.Character
                if newChar and newChar:FindFirstChild("HumanoidRootPart") then
                    local root = newChar.HumanoidRootPart
                    local targetBed = getSecondNearestBed()
                    if targetBed then
                        root.CFrame = targetBed.CFrame + Vector3.new(0, 5, 0)
                        print("AutoWin: Teleported to 2nd nearest bed after respawn")
                    end
                end

                -- Enable BedNuker
                if not bedNukerEnabled then
                    local bednuker = require(game.Players.LocalPlayer:WaitForChild("PlayerScripts"):FindFirstChild("BedNuker", true))
                    if bednuker and bednuker.Run then
                        pcall(bednuker.Run)
                        bedNukerEnabled = true
                        print("AutoWin: BedNuker enabled")
                    end
                end
            end
        end)

    else
        print("❌ AutoWin Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return AutoWin