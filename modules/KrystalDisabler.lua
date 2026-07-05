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

    -- === ONLY HOOK MOMENTUM (safest way) ===
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

    -- Force initial update
    pcall(function()
        bedwars.GlacialSkaterController:updateMomentum()
    end)

    -- Selective Momentum Remote Hook (only momentum packets)
    local momentumRemote = bedwars.Client:Get("MomentumUpdate")
    if momentumRemote then
        local oldSend = momentumRemote.SendToServer
        hookfunction(oldSend, function(self, data)
            if type(data) == "table" and data.momentumValue ~= nil then
                return oldSend(self, { momentumValue = 9e9 })
            end
            -- Let ALL other packets pass through normally
            return oldSend(self, data)
        end)
    end

    print("✅ KrystalDisabler loaded (safe version)")
end

return KrystalDisabler