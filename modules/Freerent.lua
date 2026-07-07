local FreeRent = {}

FreeRent.Name = "FreeRent"
FreeRent.Enabled = false

local RentKit = game:GetService("ReplicatedStorage")
    .rbxts_include.node_modules["@rbxts"].net.out._NetManaged.RentKit

FreeRent.Config = {
    { Name = "Kit", Type = "TextBox", Default = "axolotl", Value = "axolotl" }
}

FreeRent.Run = function()
    FreeRent.Enabled = not FreeRent.Enabled

    if FreeRent.Enabled then
        print("✅ FreeRent Enabled - Renting: " .. FreeRent.Config[1].Value)
        
        -- Rent the kit
        pcall(function()
            RentKit:InvokeServer(FreeRent.Config[1].Value)
        end)

    else
        print("❌ FreeRent Disabled")
    end
end

return FreeRent