local InstantKillV2 = {}

InstantKillV2.Name = "Volleybow V2"
InstantKillV2.Enabled = false

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

-- Fixed values (no config)
local Range = 500
local FastHit = true  -- Always on

local projectileRemote = {InvokeServer = function() end}
local FireDelays = {}

task.spawn(function()
    projectileRemote = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.ProjectileFire
end)

local function getProjectiles()
    local items = {}
    local inventory = game:GetService("ReplicatedStorage").Inventories:FindFirstChild(player.Name)
    if not inventory then return items end

    for _, item in ipairs(inventory:GetChildren()) do
        local itemType = item.Name
        if itemType:find("bow") or itemType:find("arrow") or itemType:find("snowball") then
            table.insert(items, item)
        end
    end
    return items
end

local connection = nil

InstantKillV2.Run = function()
    InstantKillV2.Enabled = not InstantKillV2.Enabled

    if InstantKillV2.Enabled then
        print("✅ InstantKill V2 Enabled (500 studs)")

        connection = task.spawn(function()
            while InstantKillV2.Enabled do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local root = char.HumanoidRootPart
                    local pos = root.Position

                    for _, item in ipairs(getProjectiles()) do
                        if (FireDelays[item.Name] or 0) < tick() then
                            -- Find closest target
                            local closest, closestDist = nil, math.huge
                            for _, plr in ipairs(Players:GetPlayers()) do
                                if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                                    local targetRoot = plr.Character.HumanoidRootPart
                                    local dist = (targetRoot.Position - pos).Magnitude
                                    if dist < Range and dist < closestDist then
                                        closestDist = dist
                                        closest = targetRoot
                                    end
                                end
                            end

                            if closest then
                                local itemMeta = {} -- placeholder, adjust if needed
                                local ammo = "arrow"
                                if FastHit then ammo = "volley_arrow" end

                                local dir = (closest.Position - pos).Unit
                                local id = HttpService:GenerateGUID(false)

                                pcall(function()
                                    projectileRemote:InvokeServer(
                                        item,
                                        ammo,
                                        ammo,
                                        pos,
                                        pos,
                                        dir * 200,
                                        id,
                                        { drawDurationSec = 9e9, shotId = HttpService:GenerateGUID(false) },
                                        workspace:GetServerTimeNow()
                                    )
                                end)

                                FireDelays[item.Name] = tick() + 0.1
                            end
                        end
                    end
                end
                task.wait(0.05)
            end
        end)

    else
        print("❌ InstantKill V2 Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
        FireDelays = {}
    end
end

return InstantKillV2