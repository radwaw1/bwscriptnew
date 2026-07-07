local ShopTierBypass = {}

ShopTierBypass.Name = "ShopTierBypass"
ShopTierBypass.Enabled = false

local tiered = {}
local nexttier = {}

-- CONFIG OPTIONS (will appear in GUI)
ShopTierBypass.Config = {
    {
        Name = "Wait For Shop Load",
        Type = "Toggle",
        Default = true,
        Value = true
    },
    {
        Name = "Max Wait Time",
        Type = "Slider",
        Min = 1,
        Max = 15,
        Default = 5,
        Value = 5,
        Suffix = " seconds"
    }
}

ShopTierBypass.Run = function()
    ShopTierBypass.Enabled = not ShopTierBypass.Enabled

    if ShopTierBypass.Enabled then
        print("ShopTierBypass Enabled")
        
        local waitForShop = ShopTierBypass.Config[1].Value
        local maxWait = ShopTierBypass.Config[2].Value

        if waitForShop then
            local start = tick()
            repeat task.wait() until (store and store.shopLoaded) or (tick() - start > maxWait) or not ShopTierBypass.Enabled
        end

        if ShopTierBypass.Enabled and bedwars and bedwars.Shop and bedwars.Shop.ShopItems then
            for _, v in bedwars.Shop.ShopItems do
                tiered[v] = v.tiered
                nexttier[v] = v.nextTier
                v.nextTier = nil
                v.tiered = nil
            end
        end
    else
        print("ShopTierBypass Disabled")
        for i, v in tiered do
            if i then i.tiered = v end
        end
        for i, v in nexttier do
            if i then i.nextTier = v end
        end
        table.clear(nexttier)
        table.clear(tiered)
    end
end

return ShopTierBypass