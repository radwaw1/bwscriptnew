local Killaura = {}

Killaura.Name = "ShitAura"
Killaura.Enabled = false

local AttackRemote = { FireServer = function() end }

task.spawn(function()
    if bedwars and bedwars.Client then
        AttackRemote = bedwars.Client:Get(remotes.AttackEntity).instance
    end
end)

local connection

Killaura.Run = function()
    Killaura.Enabled = not Killaura.Enabled
    
    if Killaura.Enabled then
        print("Killaura Enabled (20 studs)")
        
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not Killaura.Enabled then return end
            
            local sword = store.tools.sword or store.hand
            if not sword or not sword.tool then return end

            local targets = entitylib.AllPosition({
                Range = 20,
                Wallcheck = false,
                Part = "RootPart",
                Players = true,
                NPCs = true,
                Limit = 4,
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
                local distance = delta.Magnitude

                if distance > 20 then continue end

                local dir = CFrame.lookAt(selfpos, actualRoot.Position).LookVector
                local pos = selfpos + dir * math.max(distance - 14.4, 0)

                bedwars.SwordController.lastAttack = workspace:GetServerTimeNow()

                AttackRemote:FireServer({
                    weapon = sword.tool,
                    chargedAttack = { chargeRatio = 0 },
                    entityInstance = target.Character,
                    validate = {
                        raycast = {
                            cameraPosition = { value = pos },
                            cursorDirection = { value = dir }
                        },
                        targetPosition = { value = actualRoot.Position },
                        selfPosition = { value = pos }
                    }
                })
            end
        end)
        
    else
        print("Killaura Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
        store.KillauraTarget = nil
    end
end

return Killaura