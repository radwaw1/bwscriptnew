local InfiniteJump = {}

InfiniteJump.Name = "InfiniteJump"
InfiniteJump.Enabled = false

local player = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")

InfiniteJump.Config = {
    { Name = "Hold to Jump", Type = "Toggle", Default = true, Value = true }
}

local connection = nil
local holdingSpace = false

InfiniteJump.Run = function()
    InfiniteJump.Enabled = not InfiniteJump.Enabled

    if InfiniteJump.Enabled then
        print("✅ InfiniteJump Enabled")

        -- Hold Space detection
        connection = UserInputService.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Space then
                holdingSpace = true
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Space then
                holdingSpace = false
            end
        end)

        -- Main Jump Loop
        task.spawn(function()
            while InfiniteJump.Enabled do
                local char = player.Character
                if char then
                    local hum = char:FindFirstChild("Humanoid")
                    if hum then
                        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                            if InfiniteJump.Config[1].Value or not holdingSpace then
                                hum:ChangeState(Enum.HumanoidStateType.Jumping)
                            end
                        end
                    end
                end
                task.wait(0.01)
            end
        end)

    else
        print("❌ InfiniteJump Disabled")
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end

return InfiniteJump