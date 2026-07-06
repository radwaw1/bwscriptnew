local ProjectileAura = {}

ProjectileAura.Name = "ProjectileAura"
ProjectileAura.Enabled = false

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local httpService = game:GetService("HttpService")

local connection = nil

ProjectileAura.Config = {
    { Name = "Range", Type = "Slider", Min = 1, Max = 50, Default = 50, Value = 50, Suffix = " studs" },
    { Name = "Projectile Type", Type = "TextBox", Default = "meteor_shower", Value = "meteor_shower" }
}

ProjectileAura.Run = function()
    ProjectileAura.Enabled = not ProjectileAura.Enabled

    if ProjectileAura.Enabled then
        print("✅ ProjectileAura Enabled")
        
        connection = task.spawn(function()
            while ProjectileAura.Enabled do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local root = char.HumanoidRootPart
                    local pos = root.CFrame.Position + Vector3.new(0, 2, 0)

                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr == player then continue end

                        local targetChar = plr.Character
                        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then continue end

                        local targetRoot = targetChar.HumanoidRootPart
                        local distance = (targetRoot.Position - pos).Magnitude
                        if distance > ProjectileAura.Config[1].Value then continue end

                        local direction = (targetRoot.Position - pos).Unit

                        -- Your preferred call
                        pcall(function()
                            local tool = char:FindFirstChildWhichIsA("Tool") or player.Backpack:FindFirstChildWhichIsA("Tool")
                            if tool then
                                local itemProjs = {} -- You can expand this if needed
                                ProjFire:CallServerAsync(
                                    tool,
                                    itemProjs[tool.Name] or "arrow",
                                    ProjectileAura.Config[2].Value,  -- Custom projectile
                                    pos,
                                    pos,
                                    direction,
                                    httpService:GenerateGUID(false),
                                    {
                                        shotId = httpService:GenerateGUID(false),
                                        drawDurationSec = 1,
                                    },
                                    workspace:GetServerTimeNow()
                                )
                            end
                        end)
                    end
                end

                task.wait(0.1)
            end
        end)

    else
        print("❌ ProjectileAura Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return ProjectileAura