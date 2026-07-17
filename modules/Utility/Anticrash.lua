local AntiCrash = {}

AntiCrash.Name = "AntiCrash"
AntiCrash.Enabled = false

local hooked = {}
local otherAntiCrashHooked = {}

local function hookConnection(connection)
    local func = connection.Function
    if func and not hooked[func] then
        local old; old = hookfunction(func, newcclosure(function(...)
            local tab = select(2, ...)
            if typeof(tab) == "table" then
                local vec = tab[1]
                if typeof(vec) == "Vector3" then
                    if vec.Y > 1e7 then
                        return tab[2]:Destroy()
                    end
                end
            end
            return old(...)
        end))
        hooked[func] = true
    end
end

AntiCrash.Run = function()
    AntiCrash.Enabled = not AntiCrash.Enabled

    if AntiCrash.Enabled then
        print("✅ AntiCrash Enabled")

        -- Main Pearl Crash Protection
        local replicatedStorage = game:GetService("ReplicatedStorage")
        local zap = replicatedStorage:WaitForChild('ZAP'):WaitForChild('ZAP_RELIABLE')
        for _, connection in getconnections(zap.OnClientEvent) do
            hookConnection(connection)
        end

        -- Other Anti-Crash (Wren etc.)
        local abilityUsed = replicatedStorage:WaitForChild('events-@easy-games/game-core:shared/game-core-networking@getEvents.Events'):WaitForChild('abilityUsed')
        for _, connection in getconnections(abilityUsed.OnClientEvent) do
            local func = connection.Function
            if func and not otherAntiCrashHooked[func] then
                local old; old = hookfunction(func, newcclosure(function(...)
                    if select(2, ...) == 'close_black_market' then
                        return
                    end
                    return old(...)
                end))
                otherAntiCrashHooked[func] = true
            end
        end

    else
        print("❌ AntiCrash Disabled")

        -- Cleanup hooks
        for func in pairs(hooked) do
            pcall(function() restorefunction(func) end)
        end
        table.clear(hooked)

        for func in pairs(otherAntiCrashHooked) do
            pcall(function() restorefunction(func) end)
        end
        table.clear(otherAntiCrashHooked)
    end
end

return AntiCrash