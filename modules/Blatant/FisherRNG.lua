local FishingRNG = {}

FishingRNG.Name = "Fishin mangRNG"
FishingRNG.Enabled = false

FishingRNG.Run = function()
    FishingRNG.Enabled = not FishingRNG.Enabled

    if FishingRNG.Enabled then
        print("✅ FishingRNG Enabled (Gold Fish)")

        local FishFound = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.FishFound
        local FishCaught = game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.FishCaught

        -- Ultra safe hook for FishFound
        for _, conn in getconnections(FishFound.OnClientEvent) do
            if conn.Function then
                local old = hookfunction(conn.Function, function(...)
                    pcall(function()
                        local args = {...}
                        if args[1] and args[1].dropData then
                            args[1].dropData = {
                                fishModel = "fish_gold",
                                weight = 5,
                                id = "gold_fish",
                                fishSizeMultiplier = 1.5,
                                drops = args[1].dropData.drops or {}
                            }
                        end
                    end)
                    return old(...)
                end)
            end
        end

        -- Ultra safe hook for FishCaught
        for _, conn in getconnections(FishCaught.OnClientEvent) do
            if conn.Function then
                local old = hookfunction(conn.Function, function(...)
                    pcall(function()
                        local args = {...}
                        if args[1] and args[1].dropData then
                            args[1].dropData = {
                                fishModel = "fish_gold",
                                weight = 5,
                                id = "gold_fish",
                                fishSizeMultiplier = 1.5,
                                drops = args[1].dropData.drops or {}
                            }
                        end
                    end)
                    return old(...)
                end)
            end
        end

    else
        print("❌ FishingRNG Disabled")
    end
end

return FishingRNG