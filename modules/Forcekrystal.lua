local ForceKrystal = {}

ForceKrystal.Name = "ForceKrystal"
ForceKrystal.Enabled = false



ForceKrystal.Run = function()
        game:GetService("ReplicatedStorage").rbxts_include.node_modules["@rbxts"].net.out._NetManaged.BedwarsActivateKit:InvokeServer({kit = 'glacial_skater'})
end

return ForceKrystal