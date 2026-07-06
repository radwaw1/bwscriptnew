local Lagger = {}

Lagger.Name = "Lagger"
Lagger.Enabled = false

Lagger.Run = function()
    Lagger.Enabled = not Lagger.Enabled

    if Lagger.Enabled then
        print("✅ Lagger Enabled")
        
        task.spawn(function()
            while Lagger.Enabled do
                for i = 1, 250 do
                    pcall(function()
                        game:GetService('ReplicatedStorage')['events-@easy-games/game-core:shared/game-core-networking@getEvents.Events'].useAbility:FireServer('necromancer_swap')
                    end)
                end
                task.wait(0.1)
            end
        end)

    else
        print("❌ Lagger Disabled")
    end
end

return Lagger