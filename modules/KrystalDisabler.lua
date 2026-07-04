-- ExampleModule.lua
-- Place ModuleScripts like this inside ReplicatedStorage.Modules
-- Every module MUST return a table with:
--   Name (string, optional - what shows on the button, defaults to script name)
--   Run  (function - what happens when the button is clicked)

local ExampleModule = {}

ExampleModule.Name = "Disables Anticheat using Krystal Kit (OP!)"

ExampleModule.Run = function()
	local KnitInit, Knit
    repeat
        KnitInit, Knit = pcall(function()
            return require(game:GetService('ReplicatedStorage').rbxts_include.node_modules["@easy-games"].knit.src).KnitClient
        end)
        if KnitInit then
            break
        end
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
    old = clonefunction(bedwars.GlacialSkaterController.updateMomentum)
    hookfunction(bedwars.GlacialSkaterController.updateMomentum, function(self, ...)
        self.momentum = 9e9
        self.lastMomentumReport = 9e9
        bedwars.Client:Get("MomentumUpdate"):SendToServer({
            momentumValue = 9e9
        })
    end)
    bedwars.GlacialSkaterController:updateMomentum()
end

return ExampleModule