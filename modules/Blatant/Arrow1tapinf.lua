local ProjectileAuraOP = {}

ProjectileAuraOP.Name = "ProjectileAuraOP"
ProjectileAuraOP.Enabled = false

local projectileRemote = {InvokeServer = function() end}
local FireDelays = {}

task.spawn(function()
    local remotes = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged
    projectileRemote = remotes.FireProjectile or remotes.ProjectileFire
end)

ProjectileAuraOP.Config = {
    { Name = "Range", Type = "Slider", Min = 1, Max = 50, Default = 50, Value = 50, Suffix = " studs" },
    { Name = "InstaKill", Type = "Slider", Min = 0, Max = 1, Default = 0, Value = 0, Suffix = "" }
}

ProjectileAuraOP.Run = function()
    ProjectileAuraOP.Enabled = not ProjectileAuraOP.Enabled

    if ProjectileAuraOP.Enabled then
        print("✅ ProjectileAuraOP Enabled")
        
        task.spawn(function()
            while ProjectileAuraOP.Enabled do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local pos = char.HumanoidRootPart.Position

                    for _, plr in ipairs(game:GetService("Players"):GetPlayers()) do
                        if plr == game.Players.LocalPlayer then continue end

                        local targetChar = plr.Character
                        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then continue end

                        local distance = (targetChar.HumanoidRootPart.Position - pos).Magnitude
                        if distance > ProjectileAuraOP.Config[1].Value then continue end

                        for _, item in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                            if item:IsA("Tool") then
                                local projType = "arrow"
                                local instaKill = ProjectileAuraOP.Config[2].Value > 0.5
                                if instaKill and item.Name:find("bow") then
                                    projType = "volley_arrow"
                                end

                                local dir = (targetChar.HumanoidRootPart.Position - pos).Unit
                                local id = game:GetService("HttpService"):GenerateGUID(true)

                                pcall(function()
                                    projectileRemote:InvokeServer(item, projType, "arrow", pos, pos, dir * 100, id, {}, workspace:GetServerTimeNow())
                                end)
                            end
                        end
                    end
                end

                task.wait(0.1)
            end
        end)

    else
        print("❌ ProjectileAuraOP Disabled")
    end
end

return ProjectileAuraOP