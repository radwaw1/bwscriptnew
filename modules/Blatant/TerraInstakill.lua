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

TerraInstakill.Config = {
    { Name = "Keybind", Type = "Keybind", Value = Enum.KeyCode.RightControl }
}

TerraInstakill.Run = function()
    TerraInstakill.Enabled = not TerraInstakill.Enabled

    if TerraInstakill.Enabled then
        print("✅ TerraInstakill Enabled")
        
        connection = task.spawn(function()
            while TerraInstakill.Enabled do
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local root = char.HumanoidRootPart
                    local dir = root.CFrame.LookVector

                    -- Fire ability
                    pcall(function()
                        useAbility:FireServer("BLOCK_KICK")
                    end)

                    -- Fire block kick
                    pcall(function()
                        tryBlockKick:FireServer({
                            projectileRefId = "1KSXT97P",
                            direction = dir,
                            blockType = "grass",
                            originPosition = root.Position
                        })
                    end)
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
    end
end

return TerraInstakill