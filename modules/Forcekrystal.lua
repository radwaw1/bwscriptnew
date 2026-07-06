local ForceKit = {}

ForceKit.Name = "ForceKit"
ForceKit.Enabled = false

local player = game:GetService("Players").LocalPlayer

ForceKit.Config = {
    { 
        Name = "Kit", 
        Type = "Dropdown", 
        Options = {
            "aery", "agni", "airbender", "alchemist", "angel", "archer", "axolotl", 
            "baker", "barbarian", "battery", "beast", "beekeeper", "berserker", 
            "bigman", "black_market_trader", "block_kicker", "blood_assassin", 
            "bounty_hunter", "builder", "cactus", "card", "cat", "conqueror", 
            "cowgirl", "cyber", "dasher", "davey", "defender", "dino_tamer", 
            "disruptor", "dragon_slayer", "dragon_sword", "drill", "elektra", 
            "elk_master", "ember", "falconer", "farmer_cletus", "fisherman", 
            "frosty", "frosty_hammer", "ghost_catcher", "gingerbread_man", 
            "glacial_skater", "grim_reaper", "gun_blade", "hannah", "harpoon", 
            "hatter", "ice_mage", "ice_queen", "ignis", "infected", 
            "infected_disruptor", "infected_prowler", "infected_rush", 
            "infected_tank", "jade", "jailor", "jellyfish", "lumen", "lyla", 
            "mage", "melody", "merchant", "metal_detector", "midnight", "mimic", 
            "miner", "nazar", "necromancer", "ninja", "nyoka", "oasis", 
            "oil_man", "owl", "paladin", "pinata", "pyro", "queen_bee", 
            "random", "raven", "rebellion_leader", "regent", "santa", "scarab", 
            "seahorse", "sheep_herder", "shielder", "skeleton", "slime_tamer", 
            "smoke", "sorcerer", "soul_broker", "spearman", "spider_queen", 
            "spirit_assassin", "spirit_catcher", "spirit_gardener", 
            "spirit_summoner", "star_collector", "steam_engineer", "styx", 
            "summoner", "super_infected", "sword_shield", "taliyah", "tinker", 
            "trapper", "triple_shot", "void_dragon", "void_hunter", 
            "void_knight", "void_walker", "vulcan", "warlock", "warrior", 
            "wind_walker", "wizard", "yeti"
        }, 
        Default = "random", 
        Value = "random" 
    }
}

ForceKit.Run = function()
    ForceKit.Enabled = not ForceKit.Enabled

    if ForceKit.Enabled then
        print("✅ ForceKit Enabled - " .. ForceKit.Config[1].Value)
        
        -- Force the kit
        local kitName = ForceKit.Config[1].Value
        if kitName then
            pcall(function()
                game:GetService("ReplicatedStorage").TS.kit["bedwars-kit"].setKit:FireServer(kitName)
            end)
        end

    else
        print("❌ ForceKit Disabled")
    end
end

return ForceKit