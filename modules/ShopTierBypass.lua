local ShopTierBypass = {}

ShopTierBypass.Name = "ShopTierBypass"

local tiered = {}
local nexttier = {}

ShopTierBypass.Run = function(enabled)
	if enabled then
		-- === ENABLED ===
		repeat task.wait() until (store and store.shopLoaded) or not ShopTierBypass.Enabled
		
		if ShopTierBypass.Enabled and bedwars and bedwars.Shop and bedwars.Shop.ShopItems then
			for _, v in bedwars.Shop.ShopItems do
				tiered[v] = v.tiered
				nexttier[v] = v.nextTier
				v.nextTier = nil
				v.tiered = nil
			end
			print("Shop Tier Bypass Enabled")
		end
		
	else
		-- === DISABLED ===
		for i, v in tiered do
			if i then i.tiered = v end
		end
		for i, v in nexttier do
			if i then i.nextTier = v end
		end
		
		table.clear(nexttier)
		table.clear(tiered)
		
		print("Shop Tier Bypass Disabled")
	end
end

return ShopTierBypass