local KrystalDisabler = {}
KrystalDisabler.Name = "Disables Anticheat"

KrystalDisabler.Run = function()
    local KnitInit, Knit
    repeat
        KnitInit, Knit = pcall(function()
            return require(game:GetService('ReplicatedStorage').rbxts_include.node_modules["@easy-games"].knit.src).KnitClient
        end)
        if KnitInit then break end
        task.wait()
    until KnitInit

    if true and not debug.getupvalue(Knit.Start, 1) then
        repeat task.wait() until debug.getupvalue(Knit.Start, 1)
    end

    local bedwars = setmetatable({
        Client = require(game:GetService('ReplicatedStorage').TS.remotes).default.Client
    }, {
        __index = function(self, ind)
            rawset(self, ind, Knit.Controllers[ind])
            return rawget(self, ind)
        end
    })

    local momentumRemote = bedwars.Client:Get("MomentumUpdate")
    local lastSend = 0

    -- Better hook - avoid recursion
    local controller = bedwars.GlacialSkaterController
    if controller then
        local oldUpdateMomentum = controller.updateMomentum
        
        controller.updateMomentum = function(self, ...)
            -- Force high momentum locally
            self.momentum = 9e9
            self.lastMomentumReport = 9e9

            -- Throttled server update
            local now = tick()
            if momentumRemote and momentumRemote.SendToServer and (now - lastSend > 0.4) then
                pcall(function()
                    momentumRemote:SendToServer({ momentumValue = 9e9 })
                end)
                lastSend = now
            end

            -- Call original safely
            if oldUpdateMomentum then
                return oldUpdateMomentum(self, ...)
            end
        end

        print("Momentum hook applied successfully")
    end

    -- One-time boost
    pcall(function()
        if controller then
            controller:updateMomentum()
        end
    end)

    print("KrystalDisabler loaded")
end

return KrystalDisabler