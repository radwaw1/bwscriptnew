-- Speed.lua
-- Place ModuleScripts like this inside ReplicatedStorage.Modules
-- Every module MUST return a table with:
--   Name (string, optional - what shows on the button, defaults to script name)
--   Run  (function - what happens when the button is clicked)
 
local Speed = {}

Speed.Config = {
    { WS = "Walkspeed", Type = "Slider", Min = 1, Max = 100, Default = 20, Value = 20, Suffix = " studs" }
}

Speed.Name = "Speed"
 
Speed.Run = function()
	local player = game:GetService("Players").LocalPlayer
	player.Character.Humanoid.WalkSpeed = WS
end
 
return Speed
 