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

    -- Original style hook but safer
    local oldUpdateMomentum = bedwars.GlacialSkaterController.updateMomentum
    hookfunction(oldUpdateMomentum, function(self, ...)
        self.momentum = 9e9
        self.lastMomentumReport = 9e9
        
        -- Very throttled send
        pcall(function()
            local remote = bedwars.Client:Get("MomentumUpdate")
            if remote and remote.SendToServer then
                remote:SendToServer({ momentumValue = 9e9 })
            end
        end)
        
        return oldUpdateMomentum(self, ...)  -- This line was causing recursion in previous versions
    end)

    -- Initial call
    pcall(function()
        bedwars.GlacialSkaterController:updateMomentum()
    end)

    print("KrystalDisabler loaded (original style)")
end

return KrystalDisabler