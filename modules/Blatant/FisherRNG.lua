local FishingRNG = {}

FishingRNG.Name = "FishingRNG"
FishingRNG.Enabled = false

FishingRNG.Run = function()
    FishingRNG.Enabled = not FishingRNG.Enabled

    if FishingRNG.Enabled then
        print("✅ FishingRNG Enabled (Diamond Fish)")

        -- Intercept FishFound
        local FishFound = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.FishFound
        for _, conn in getconnections(FishFound.OnClientEvent) do
            local old = hookfunction(conn.Function, function(...)
                local args = {...}
                if args[1] and args[1].dropData then
                    args[1].dropData = {
                        fishModel = "fish_diamond",
                        weight = 5,
                        id = "diamond_fish_2",
                        fishSizeMultiplier = 1.5,
                        drops = {
                            {
                                itemType = "diamond",
                                amount = 3
                            }
                        }
                    }
                end
                return old(...)
            end)
        end

        -- Intercept FishCaught
        local FishCaught = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.FishCaught
        for _, conn in getconnections(FishCaught.OnClientEvent) do
            local old = hookfunction(conn.Function, function(...)
                local args = {...}
                if args[1] and args[1].dropData then
                    args[1].dropData = {
                        fishModel = "fish_diamond",
                        weight = 5,
                        id = "diamond_fish_2",
                        fishSizeMultiplier = 1.5,
                        drops = {
                            {
                                itemType = "diamond",
                                amount = 3
                            }
                        }
                    }
                end
                return old(...)
            end)
        end

    else
        print("❌ FishingRNG Disabled")
    end
end

return FishingRNG