local Killaura = {}

Killaura.Name = "Killaura"
Killaura.Enabled = false

local SwordHit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SwordHit

local connection = nil

Killaura.Config = {
    { Name = "Range", Type = "Slider", Min = 5, Max = 25, Default = 20, Value = 20, Suffix = " studs" },
    { Name = "Max Targets", Type = "Slider", Min = 1, Max = 8, Default = 4, Value = 4 },
    { Name = "Attack Speed", Type = "Slider", Min = 10, Max = 60, Default = 20, Value = 20, Suffix = " Hz" }
}

Killaura.Run = function()
    Killaura.Enabled = not Killaura.Enabled

    if Killaura.Enabled then
        print("Killaura Enabled")
        
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not Killaura.Enabled then return end

            local range = Killaura.Config[1].Value
            local maxTargets = Killaura.Config[2].Value

            -- Fixed sword detection
            local sword = nil
            if store and store.tools and store.tools.sword then
                sword = store.tools.sword
            elseif store and store.hand and store.hand.tool then
                sword = store.hand
            end

            if not sword or not sword.tool then return end

            local targets = entitylib.AllPosition({
                Range = range,
                Wallcheck = false,
                Part = "RootPart",
                Players = true,
                NPCs = true,
                Limit = maxTargets,
                Sort = "Distance"
            })

            if #targets == 0 then return end

            local root = entitylib.character and entitylib.character.RootPart
            if not root then return end

            local selfpos = root.Position
            switchItem(sword.tool, 0)

            for _, target in ipairs(targets) do
                local actualRoot = target.Character and target.Character.PrimaryPart
                if not actualRoot then continue end

                local delta = actualRoot.Position - selfpos
                if delta.Magnitude > range then continue end

                local dir = CFrame.lookAt(selfpos, actualRoot.Position).LookVector
                local pos = selfpos + dir * math.max(delta.Magnitude - 14.4, 0)

                SwordHit:FireServer({
                    chargedAttack = { chargeRatio = 0 },
                    entityInstance = target.Character,
                    validate = {
                        selfPosition = { value = pos },
                        targetPosition = { value = actualRoot.Position }
                    },
                    weapon = sword.tool
                })
            end
        end)

    else
        print("Killaura Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return Killaura