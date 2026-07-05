local TPAura = {}

TPAura.Name = "TPAura"
TPAura.Enabled = false

local SwordHit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.SwordHit

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local workspace = game:GetService("Workspace")

local connection = nil

TPAura.Run = function()
    TPAura.Enabled = not TPAura.Enabled

    if TPAura.Enabled then
        print("✅ TPAura Enabled (Smart TP)")
        
        connection = task.spawn(function()
            while TPAura.Enabled do
                local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if root then
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

                        -- Try to TP 8 studs behind
                        local direction = targetRoot.CFrame.LookVector
                        local behindPos = targetRoot.Position - direction * 8

                        -- Check if position is blocked
                        local rayParams = RaycastParams.new()
                        rayParams.FilterDescendantsInstances = {player.Character}
                        rayParams.FilterType = Enum.RaycastFilterType.Exclude

                        local result = workspace:Raycast(behindPos + Vector3.new(0, 5, 0), Vector3.new(0, -10, 0), rayParams)

                        if result then
                            -- If blocked, try left or right side
                            local leftPos = targetRoot.Position - targetRoot.CFrame.RightVector * 8
                            local rightPos = targetRoot.Position + targetRoot.CFrame.RightVector * 8

                            if not workspace:Raycast(leftPos + Vector3.new(0,5,0), Vector3.new(0,-10,0), rayParams) then
                                behindPos = leftPos
                            elseif not workspace:Raycast(rightPos + Vector3.new(0,5,0), Vector3.new(0,-10,0), rayParams) then
                                behindPos = rightPos
                            end
                        end

                        -- TP to safe position
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
                    end
                end

                task.wait(0.05)
            end
        end)

    else
        print("❌ TPAura Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return TPAura