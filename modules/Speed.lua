-- Speed.lua
-- Place ModuleScripts like this inside ReplicatedStorage.Modules
-- Every module MUST return a table with:
--   Name (string, optional - what shows on the button, defaults to script name)
--   Run  (function - what happens when the button is clicked)
 
local Speed = {}
 
Speed.Name = "Speed"
 
Speed.Run = function()
	local player = game:GetService("Players").LocalPlayer
	player.Character.Humanoid.WalkSpeed = 50
end
 
return Speed
 