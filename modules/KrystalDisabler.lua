local KrystalDisabler = {}

KrystalDisabler.Name = "KrystalDisabler"

KrystalDisabler.Run = function()
    task.wait(3)
    
    local KnitInit, Knit
    repeat
        KnitInit, Knit = pcall(function()
            return require(game:GetService('ReplicatedStorage').rbxts_include.node_modules["@easy-games"].knit.src).KnitClient
        end)
        if KnitInit then break end
        task.wait()
    until KnitInit

    if not debug.getupvalue(Knit.Start, 1) then
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

    -- Momentum Bypass
    local oldUpdateMomentum = bedwars.GlacialSkaterController.updateMomentum
    hookfunction(oldUpdateMomentum, function(self, ...)
        self.momentum = 9e9
        self.lastMomentumReport = 9e9
        pcall(function()
            bedwars.Client:Get("MomentumUpdate"):SendToServer({
                momentumValue = 9e9
            })
        end)
    end)

    pcall(function()
        bedwars.GlacialSkaterController:updateMomentum()
    end)

    -- Permissive SendToServer Hook
    local oldSend = hookfunction(bedwars.Client.SendToServer, function(self, remoteName, data)
        if remoteName == "MomentumUpdate" then
            return oldSend(self, remoteName, { momentumValue = 9e9 })
        end
        return oldSend(self, remoteName, data)
    end)

    print("✅ KrystalDisabler loaded (Permissive)")
end

return KrystalDisabler