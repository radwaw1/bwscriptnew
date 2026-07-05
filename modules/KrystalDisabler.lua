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
        repeat
            task.wait()
        until debug.getupvalue(Knit.Start, 1)
    end

    local bedwars = setmetatable({
        Client = require(game:GetService('ReplicatedStorage').TS.remotes).default.Client
    }, {
        __index = function(self, ind)
            rawset(self, ind, Knit.Controllers[ind])
            return rawget(self, ind)
        end
    })

    -- Safe hook for updateMomentum
    local oldUpdateMomentum = bedwars.GlacialSkaterController.updateMomentum
    if oldUpdateMomentum then
        hookfunction(oldUpdateMomentum, function(self, ...)
            self.momentum = 9e9
            self.lastMomentumReport = 9e9
            
            -- Safe SendToServer with pcall
            local momentumRemote = bedwars.Client:Get("MomentumUpdate")
            if momentumRemote and momentumRemote.SendToServer then
                pcall(function()
                    momentumRemote:SendToServer({
                        momentumValue = 9e9
                    })
                end)
            end
            
            return oldUpdateMomentum(self, ...)
        end)
    end

    -- Safe hook for SendToServer
    local momentumEvent = bedwars.Client:Get("MomentumUpdate")
    if momentumEvent and momentumEvent.SendToServer then
        local oldSendToServer = momentumEvent.SendToServer
        hookfunction(oldSendToServer, function(self, data)
            if type(data) == "table" and data.momentumValue == 9e9 then
                return pcall(oldSendToServer, self, { momentumValue = 9e9 })
            end
            return pcall(oldSendToServer, self, data)
        end)
    end

    -- Initial call
    pcall(function()
        bedwars.GlacialSkaterController:updateMomentum()
    end)

    print("KrystalDisabler loaded successfully")
end

return KrystalDisabler