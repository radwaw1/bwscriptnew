local TerraInstakill = {}

TerraInstakill.Name = "TerraInstakill"
TerraInstakill.Enabled = false

local useAbility = game:GetService("ReplicatedStorage")
    ["events-@easy-games/game-core:shared/game-core-networking@getEvents.Events"].useAbility

local tryBlockKick = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.TryBlockKick

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local connection = nil
local kickCount = 0

TerraInstakill.Config = {
    { Name = "Keybind", Type = "Keybind", Value = Enum.KeyCode.RightControl }
}

local function getClosestTarget()
    local closest, distance = nil, math.huge
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == player then continue end
        if plr.Team == player.Team then continue end

        local char = plr.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then continue end
        if char:FindFirstChild("Humanoid") and char.Humanoid.Health <= 0 then continue end

        local dist = (char.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
        if dist < distance then
            distance = dist
            closest = char.HumanoidRootPart
        end
    end
    return closest
end

TerraInstakill.Run = function()
    TerraInstakill.Enabled = not TerraInstakill.Enabled

    if TerraInstakill.Enabled then
        print("✅ TerraInstakill Enabled")
        
        connection = task.spawn(function()
            while TerraInstakill.Enabled do
                local target = getClosestTarget()
                if target then
                    local dir = (target.Position - player.Character.HumanoidRootPart.Position).Unit

                    -- Fire ability
                    pcall(function()
                        useAbility:FireServer("BLOCK_KICK")
                    end)

                    -- Fire block kick
                    pcall(function()
                        tryBlockKick:FireServer({
                            projectileRefId = "1KSXT97P",
                            direction = dir,
                            originPosition = player.Character.HumanoidRootPart.Position
                        })
                    end)

                    kickCount = kickCount + 1

                    -- Every 5 kicks, fire BLOCK_STOMP
                    if kickCount % 5 == 0 then
                        pcall(function()
                            useAbility:FireServer("BLOCK_STOMP")
                        end)
                    end
                end

                task.wait(0.1)
            end
        end)

    else
        print("❌ TerraInstakill Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
        kickCount = 0
    end
end

return TerraInstakill