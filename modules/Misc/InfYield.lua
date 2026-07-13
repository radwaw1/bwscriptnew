local InfYield = {}

InfYield.Name = "Load InfYield"
InfYield.Enabled = false

InfYield.Run = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
end

return InfYield