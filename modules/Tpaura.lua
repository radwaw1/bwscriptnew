local TPAura = {}

TPAura.Name = "TPAura"
TPAura.Enabled = false

local SwordHit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SwordHit

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local connection = nil

TPAura.Run = function()
    TPAura.Enabled = not TPAura.Enabled

    if TPAura.Enabled then
        print("✅ Shitaura Enabled (TP behind → Hit → Back)")
        
        connection = task.spawn(function()
            while TPAura.Enabled do
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local oldCFrame = root.CFrame  -- Save original position
                    local selfPos = root.Position

                    local weapon = player.Character and player.Character:FindFirstChildWhichIsA("Tool") 
                                or player.Backpack:FindFirstChildWhichIsA("Tool")

                    for _, plr in ipairs(Players:GetPlayers()) do
                        if plr == player then continue end

                        local targetChar = plr.Character
                        local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart")
                        if not targetRoot then continue end

                        local distance = (targetRoot.Position - selfPos).Magnitude
                        if distance > 40 then continue end

                        -- TP 8 studs behind
                        local behindPos = targetRoot.Position - targetRoot.CFrame.LookVector * 8
                        root.CFrame = CFrame.lookAt(behindPos, targetRoot.Position)

                        -- Attack
                        local dir = CFrame.lookAt(selfPos, targetRoot.Position).LookVector
                        local selfValidatePos = selfPos + dir * math.max(distance - 36, 0)

                        SwordHit:FireServer({
                            chargedAttack = { chargeRatio = 0 },
                            entityInstance = targetChar,
                            validate = {
                                selfPosition = { value = selfValidatePos },
                                targetPosition = { value = targetRoot.Position }
                            },
                            weapon = weapon
                        })

                        -- TP back immediately
                        root.CFrame = oldCFrame
                    end
                end

                task.wait(0.05)
            end
        end)

    else
        print("❌ Shitaura Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return TPAura