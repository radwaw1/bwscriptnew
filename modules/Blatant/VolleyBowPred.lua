local VolleyBowPred = {}

VolleyBowPred.Name = "VolleyBowPred"
VolleyBowPred.Enabled = false

local replicated = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local http = game:GetService("HttpService")
local lplr = players.LocalPlayer
local connection = nil

VolleyBowPred.Config = {
    { Name = "Keybind", Type = "Keybind", Value = Enum.KeyCode.RightControl },
    { Name = "InstaKill", Type = "Slider", Min = 0, Max = 1, Default = 1, Value = 1, Suffix = "" }
}

local rayCheck = RaycastParams.new()
rayCheck.FilterType = Enum.RaycastFilterType.Include

local function getClosestRoot()
    local distance, target = math.huge
    for _, v in players:GetPlayers() do
        if v ~= lplr and v.Team ~= lplr.Team then
            local targetChar = v.Character
            if targetChar and targetChar:FindFirstChild("Humanoid") and targetChar.Humanoid.Health > 0 then
                local selfroot = lplr.Character and lplr.Character.PrimaryPart
                local root = targetChar.PrimaryPart
                local compare = selfroot and root and (selfroot.Position - root.Position).Magnitude
                if compare and distance > compare then
                    distance = compare
                    target = root
                end
            end
        end
    end
    return target
end

local function getBow()
    for _, v in replicated.Inventories[lplr.Name]:GetChildren() do
        if v.Name:find('_bow') then
            return v
        end
    end
end

VolleyBowPred.Run = function()
    VolleyBowPred.Enabled = not VolleyBowPred.Enabled
    if VolleyBowPred.Enabled then
        print("✅ VolleyBowPred Enabled")
       
        connection = task.spawn(function()
            while VolleyBowPred.Enabled do
                local root = getClosestRoot()
                local bow = getBow()
                if root and bow then
                    local selfroot = lplr.Character and lplr.Character.PrimaryPart
                    if selfroot then
                        local ammo = 'volley_arrow'
                        if VolleyBowPred.Config[2].Value < 0.5 then
                            ammo = 'arrow'
                        end

                        rayCheck.FilterDescendantsInstances = {workspace.Map}
                        local meta = {} -- add your meta if needed
                        local projSpeed = 100
                        local gravity = 196.2

                        local calc = prediction.SolveTrajectory(
                            selfroot.Position,
                            projSpeed,
                            gravity,
                            root.Position,
                            root.Velocity,
                            workspace.Gravity,
                            nil,
                            nil,
                            rayCheck
                        )

                        if calc then
                            replicated.rbxts_include.node_modules['@rbxts'].net.out._NetManaged.ProjectileFire:InvokeServer(
                                bow,
                                ammo,
                                'arrow',
                                selfroot.Position,
                                selfroot.Position,
                                (calc - selfroot.Position).Unit * projSpeed,
                                http:GenerateGUID(false),
                                {
                                    shotId = http:GenerateGUID(false),
                                    drawDurationSec = 9e9
                                },
                                workspace:GetServerTimeNow()
                            )
                        end
                    end
                end
                task.wait(0.01)
            end
        end)
    else
        print("❌ VolleyBowPred Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return VolleyBowPred