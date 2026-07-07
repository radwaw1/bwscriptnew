local SigridAura = {}

SigridAura.Name = "SigridAura"
SigridAura.Enabled = false

local SigridBeginCharge = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SigridBeginChargeRequest

local useAbility = game:GetService("ReplicatedStorage")
    ["events-@easy-games/game-core:shared/game-core-networking@getEvents.Events"].useAbility

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local connection = nil

SigridAura.Config = {
    { Name = "Range", Type = "Slider", Min = 10, Max = 100, Default = 50, Value = 50, Suffix = " studs" },
    { Name = "Speed", Type = "Slider", Min = 0.05, Max = 0.5, Default = 0.15, Value = 0.15, Suffix = " seconds" }
}

SigridAura.Run = function()
    SigridAura.Enabled = not SigridAura.Enabled

    if SigridAura.Enabled then
        print("✅ SigridAura Enabled")
        
        connection = task.spawn(function()
            while SigridAura.Enabled do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local selfPos = char.HumanoidRootPart.Position

                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr == player then continue end
                        if plr.Team == player.Team then continue end

                        local targetChar = plr.Character
                        if not targetChar or not targetChar:FindFirstChild("HumanoidRootPart") then continue end

                        local targetRoot = targetChar.HumanoidRootPart
                        local distance = (targetRoot.Position - selfPos).Magnitude
                        if distance > SigridAura.Config[1].Value then continue end

                        -- Begin Charge
                        pcall(function()
                            SigridBeginCharge:InvokeServer({
                                player = player
                            })
                        end)

                        -- Fire ability
                        local direction = (targetRoot.Position - selfPos).Unit

                        useAbility:FireServer(
                            "elk_antler_uppercut",
                            {
                                direction = direction
                            }
                        )
                    end
                end

                task.wait(SigridAura.Config[2].Value)
            end
        end)

    else
        print("❌ SigridAura Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return SigridAura