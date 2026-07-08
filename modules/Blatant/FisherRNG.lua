local FishingRNG = {}

FishingRNG.Name = "FishingRNG"
FishingRNG.Enabled = false

FishingRNG.Run = function()
    FishingRNG.Enabled = not FishingRNG.Enabled

    if FishingRNG.Enabled then
        print("✅ FishingRNG Enabled (Gold Fish)")

        local FishFound = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.FishFound
        local FishCaught = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.FishCaught

        -- Hook FishFound safely
        for _, conn in getconnections(FishFound.OnClientEvent) do
            if conn.Function then
                local old = hookfunction(conn.Function, function(data)
                    if data and data.dropData then
                        data.dropData = {
                            fishModel = "fish_gold",
                            weight = 5,
                            id = "gold_fish",
                            fishSizeMultiplier = 1.5,
                            drops = data.dropData.drops or {}
                        }
                    end
                    return old(data)
                end)
            end
        end

        -- Hook FishCaught safely
        for _, conn in getconnections(FishCaught.OnClientEvent) do
            if conn.Function then
                local old = hookfunction(conn.Function, function(data)
                    if data and data.dropData then
                        data.dropData = {
                            fishModel = "fish_gold",
                            weight = 5,
                            id = "gold_fish",
                            fishSizeMultiplier = 1.5,
                            drops = data.dropData.drops or {}
                        }
                    end
                    return old(data)
                end)
            end
        end

    else
        print("❌ FishingRNG Disabled")
    end
end

return FishingRNG