local KitRender = {}

KitRender.Name = "KitRender"
KitRender.Enabled = false

local Players = game:GetService("Players")
local player = Players.LocalPlayer

KitRender.Run = function()
    KitRender.Enabled = not KitRender.Enabled

    if KitRender.Enabled then
        print("✅ KitRender Enabled")

        -- Print current kits
        task.spawn(function()
            while KitRender.Enabled do
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr == player then continue end
                    if plr.Team == player.Team then continue end

                    local kitValue = plr:FindFirstChild("PlayingAsKits") or plr:FindFirstChild("Kit")
                    if kitValue then
                        print(plr.Name .. " is using kit: " .. tostring(kitValue.Value))
                    else
                        print(plr.Name .. " has no kit info")
                    end
                end
                task.wait(5)  -- Print every 5 seconds
            end
        end)

    else
        print("❌ KitRender Disabled")
    end
end

return KitRender