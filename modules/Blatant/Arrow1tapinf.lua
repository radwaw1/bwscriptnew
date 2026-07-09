local ProjectileAura = {}

ProjectileAura.Name = "ProjectileAura"
ProjectileAura.Enabled = false

local projectileRemote = {InvokeServer = function() end}
local FireDelays = {}

task.spawn(function()
    projectileRemote = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.FireProjectile.instance
end)

local function getAmmo(check)
    for _, item in game.Players.LocalPlayer.Backpack:GetChildren() do
        if check.ammoItemTypes and table.find(check.ammoItemTypes, item.Name) then
            return item.Name
        end
    end
end

local function getProjectiles()
    local items = {}
    for _, item in game.Players.LocalPlayer.Backpack:GetChildren() do
        if item:IsA("Tool") then
            local proj = {} -- simplified
            local ammo = getAmmo(proj) or ProjectileAura.Config[2].Value > 0.5 and item.Name:find('bow') and 'arrow'
            if ammo then
                table.insert(items, {
                    item,
                    ammo,
                    "arrow",
                    {}
                })
            end
        end
    end
    return items
end

ProjectileAura.Config = {
    { Name = "Range", Type = "Slider", Min = 1, Max = 50, Default = 50, Value = 50, Suffix = " studs" },
    { Name = "InstaKill", Type = "Slider", Min = 0, Max = 1, Default = 0, Value = 0, Suffix = "" }
}

ProjectileAura.Run = function()
    ProjectileAura.Enabled = not ProjectileAura.Enabled

    if ProjectileAura.Enabled then
        print("✅ ProjectileAura Enabled")
        
        task.spawn(function()
            while ProjectileAura.Enabled do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local pos = char.HumanoidRootPart.Position

                    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                        if plr == game.Players.LocalPlayer then continue end

                        local targetChar = plr.Character
                        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then continue end

                        local distance = (targetChar.HumanoidRootPart.Position - pos).Magnitude
                        if distance > ProjectileAura.Config[1].Value then continue end

                        for _, data in getProjectiles() do
                            local item, ammo, projectile, itemMeta = unpack(data)
                            if (FireDelays[item.Name] or 0) < tick() then
                                task.spawn(function()
                                    if ProjectileAura.Config[2].Value > 0.5 and ammo:find('arrow') then
                                        ammo = 'volley_arrow'
                                    end
                                    local dir = CFrame.lookAt(pos, targetChar.HumanoidRootPart.Position).LookVector
                                    local id = game:GetService("HttpService"):GenerateGUID(true)
                                    local shootPosition = pos

                                    projectileRemote:InvokeServer(item, ammo, projectile, shootPosition, pos, dir * 100, id, {drawDurationSeconds = 1, shotId = game:GetService("HttpService"):GenerateGUID(false)}, workspace:GetServerTimeNow() - 0.045)
                                end)

                                FireDelays[item.Name] = tick() + 0.5
                            end
                        end
                    end
                end

                task.wait(0.1)
            end
        end)

    else
        print("❌ ProjectileAura Disabled")
    end
end

return ProjectileAura