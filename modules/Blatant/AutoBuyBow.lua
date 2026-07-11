local AutoBuyBow = {}

AutoBuyBow.Name = "AutoBuyBow"
AutoBuyBow.Enabled = false

local replicated = game:GetService("ReplicatedStorage")

AutoBuyBow.Run = function()
    AutoBuyBow.Enabled = not AutoBuyBow.Enabled

    if AutoBuyBow.Enabled then
        print("✅ AutoBuyBow Enabled (Wood Bow)")
        
        task.spawn(function()
            while AutoBuyBow.Enabled do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    -- Find shop NPC
                    local npc = nil
                    for _, v in replicated:FindFirstChild("Shop") or {} do
                        if v and v.RootPart and (v.RootPart.Position - char.HumanoidRootPart.Position).Magnitude <= 20 then
                            npc = v
                            break
                        end
                    end

                    if npc then
                        -- Buy wood_bow if we have enough iron
                        local iron = 0
                        for _, item in replicated.Inventories[game.Players.LocalPlayer.Name]:GetChildren() do
                            if item.Name == "iron" then
                                iron = item.amount or 0
                                break
                            end
                        end

                        if iron >= 24 then
                            -- Buy wood_bow
                            replicated.rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsPurchaseItem:CallServerAsync({
                                shopItem = {itemType = "wood_bow", price = 24, currency = "iron"},
                                shopId = npc.Id
                            })
                            print("AutoBuyBow: Bought wood_bow")
                        end
                    end
                end

                task.wait(1)
            end
        end)

    else
        print("❌ AutoBuyBow Disabled")
    end
end

return AutoBuyBow