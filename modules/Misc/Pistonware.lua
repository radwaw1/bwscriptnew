local Pistonware = {}

Pistonware.Name = "Load Pistonware"
Pistonware.Enabled = false

Pistonware.Run = function()
    shared.VapeSmoothBoot = true
    loadstring(game:HttpGet("https://raw.githubusercontent.com/pistonware/pistonware/main/NewMainScript.lua", true))()
end

return Pistonware