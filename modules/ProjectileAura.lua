local ProjectileAura = {}

ProjectileAura.Name = "ProjectileAura"
ProjectileAura.Enabled = false

local projectileRemote = {InvokeServer = function() end}

task.spawn(function()
    projectileRemote = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.FireProjectile.instance
end)

local FireDelays = {}

ProjectileAura.Config = {
    { Name = "Range", Type = "Slider", Min = 1, Max = 50, Default = 50, Value = 50, Suffix = " studs" },
    { Name = "Projectiles", Type = "TextList", Default = {"arrow", "snowball"} },
    { Name = "Custom Projectiles", Type = "TextList", Default = {"meteor_shower", "star", "black_hole"} }
}

ProjectileAura.Run = function()
    ProjectileAura.Enabled = not ProjectileAura.Enabled

    if ProjectileAura.Enabled then
        print("✅ ProjectileAura Enabled")
        
        task.spawn(function()
            while ProjectileAura.Enabled do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local root = char.HumanoidRootPart
                    local pos = root.Position

                    -- Find targets
                    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                        if plr == game.Players.LocalPlayer then continue end

                        local targetChar = plr.Character
                        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then continue end

                        local distance = (targetChar.HumanoidRootPart.Position - pos).Magnitude
                        if distance > ProjectileAura.Config[1].Value then continue end

                        -- Get projectiles
                        for _, item in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if item:IsA("Tool") then
                                local projType = "arrow" -- default
                                if ProjectileAura.Config[2].Value and table.find(ProjectileAura.Config[2].Value, projType) then
                                    local meta = {} -- simplified
                                    local dir = (targetChar.HumanoidRootPart.Position - pos).Unit
                                    local id = game:GetService("HttpService"):GenerateGUID(true)

                                    pcall(function()
                                        projectileRemote:InvokeServer(item, projType, "arrow", pos, pos, dir * 100, id, {}, workspace:GetServerTimeNow())
                                    end)
                                end
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