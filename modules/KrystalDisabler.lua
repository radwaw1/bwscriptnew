local KrystalDisabler = {}

KrystalDisabler.Name = "KrystalDisabler"

KrystalDisabler.Run = function()
    task.wait(3)
    
    print("KrystalDisabler: Starting...")

    local KnitInit, Knit = pcall(function()
        return require(game:GetService('ReplicatedStorage').rbxts_include.node_modules["@easy-games"].knit.src).KnitClient
    end)

    if not KnitInit then
        print("Failed to load Knit")
        return
    end

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

    -- Only momentum bypass
    local controller = bedwars.GlacialSkaterController
    if controller then
        local oldUpdate = controller.updateMomentum
        hookfunction(oldUpdate, function(self, ...)
            self.momentum = 9e9
            self.lastMomentumReport = 9e9
            pcall(function()
                bedwars.Client:Get("MomentumUpdate"):SendToServer({ momentumValue = 9e9 })
            end)
        end)

        pcall(function()
            controller:updateMomentum()
        end)
        print("Momentum bypass applied")
    end

    print("✅ KrystalDisabler loaded (Safe)")
end

return KrystalDisabler