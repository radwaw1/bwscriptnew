local KrystalDisabler = {}
KrystalDisabler.Name = "Krystal Disabler"

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

    -- Main hook
    local oldUpdateMomentum = bedwars.GlacialSkaterController.updateMomentum
    if oldUpdateMomentum then
        hookfunction(oldUpdateMomentum, function(self, ...)
            self.momentum = 9e9
            self.lastMomentumReport = 9e9

            -- Throttle sending to server (max once every 0.3 seconds)
            local now = tick()
            if momentumRemote and momentumRemote.SendToServer and (now - lastSend > 0.3) then
                pcall(function()
                    momentumRemote:SendToServer({ momentumValue = 9e9 })
                end)
                lastSend = now
            end

            return oldUpdateMomentum(self, ...)
        end)
    end

    -- Optional: Also hook SendToServer as backup
    if momentumRemote and momentumRemote.SendToServer then
        local oldSend = momentumRemote.SendToServer
        hookfunction(oldSend, function(self, data)
            if type(data) == "table" and data.momentumValue == 9e9 then
                return pcall(oldSend, self, { momentumValue = 9e9 })
            end
            return pcall(oldSend, self, data)
        end)
    end

    -- One initial call
    pcall(function()
        bedwars.GlacialSkaterController:updateMomentum()
    end)

    print("KrystalDisabler loaded (throttled version)")
end

return KrystalDisabler