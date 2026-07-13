-- Gui to Lua
-- Version: 3.2

-- Instances:

local Script = Instance.new("ScreenGui")
Script.ResetOnSpawn = false

local Script_2 = Instance.new("Frame")
local Categories = Instance.new("Frame")
local Blatant = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint")
local UICorner = Instance.new("UICorner")
local Modules = Instance.new("ScrollingFrame")
local UIAspectRatioConstraint_2 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_3 = Instance.new("UIAspectRatioConstraint")
local Inventory = Instance.new("Frame")
local Title_2 = Instance.new("TextLabel")
local UIAspectRatioConstraint_4 = Instance.new("UIAspectRatioConstraint")
local UICorner_2 = Instance.new("UICorner")
local Modules_2 = Instance.new("ScrollingFrame")
local UIAspectRatioConstraint_5 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_6 = Instance.new("UIAspectRatioConstraint")
local Legit = Instance.new("Frame")
local Title_3 = Instance.new("TextLabel")
local UIAspectRatioConstraint_7 = Instance.new("UIAspectRatioConstraint")
local UICorner_3 = Instance.new("UICorner")
local Modules_3 = Instance.new("ScrollingFrame")
local UIAspectRatioConstraint_8 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_9 = Instance.new("UIAspectRatioConstraint")
local Render = Instance.new("Frame")
local Title_4 = Instance.new("TextLabel")
local UIAspectRatioConstraint_10 = Instance.new("UIAspectRatioConstraint")
local UICorner_4 = Instance.new("UICorner")
local Modules_4 = Instance.new("ScrollingFrame")
local UIAspectRatioConstraint_11 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_12 = Instance.new("UIAspectRatioConstraint")
local Utility = Instance.new("Frame")
local Title_5 = Instance.new("TextLabel")
local UIAspectRatioConstraint_13 = Instance.new("UIAspectRatioConstraint")
local UICorner_5 = Instance.new("UICorner")
local Modules_5 = Instance.new("ScrollingFrame")
local UIAspectRatioConstraint_14 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_15 = Instance.new("UIAspectRatioConstraint")
local World = Instance.new("Frame")
local Title_6 = Instance.new("TextLabel")
local UIAspectRatioConstraint_16 = Instance.new("UIAspectRatioConstraint")
local UICorner_6 = Instance.new("UICorner")
local Modules_6 = Instance.new("ScrollingFrame")
local UIAspectRatioConstraint_17 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_18 = Instance.new("UIAspectRatioConstraint")
local Kits = Instance.new("Frame")
local Title_7 = Instance.new("TextLabel")
local UIAspectRatioConstraint_19 = Instance.new("UIAspectRatioConstraint")
local UICorner_7 = Instance.new("UICorner")
local Modules_7 = Instance.new("ScrollingFrame")
local UIAspectRatioConstraint_20 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_21 = Instance.new("UIAspectRatioConstraint")
local Misc = Instance.new("Frame")
local Title_8 = Instance.new("TextLabel")
local UIAspectRatioConstraint_22 = Instance.new("UIAspectRatioConstraint")
local UICorner_8 = Instance.new("UICorner")
local Modules_8 = Instance.new("ScrollingFrame")
local UIAspectRatioConstraint_23 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_24 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_25 = Instance.new("UIAspectRatioConstraint")
local Notification = Instance.new("Frame")
local UICorner_9 = Instance.new("UICorner")
local Title_9 = Instance.new("TextLabel")
local UIAspectRatioConstraint_26 = Instance.new("UIAspectRatioConstraint")
local Notification_2 = Instance.new("TextLabel")
local UIAspectRatioConstraint_27 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_28 = Instance.new("UIAspectRatioConstraint")
local Main = Instance.new("Frame")
local UICorner_10 = Instance.new("UICorner")
local Title_10 = Instance.new("TextLabel")
local UICorner_11 = Instance.new("UICorner")
local UIAspectRatioConstraint_29 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_30 = Instance.new("UIAspectRatioConstraint")
local Delete = Instance.new("TextButton")
local UICorner_12 = Instance.new("UICorner")
local UIAspectRatioConstraint_31 = Instance.new("UIAspectRatioConstraint")
local Categories_2 = Instance.new("Frame")
local Blatant_2 = Instance.new("TextButton")
local UICorner_13 = Instance.new("UICorner")
local UIAspectRatioConstraint_32 = Instance.new("UIAspectRatioConstraint")
local Inventory_2 = Instance.new("TextButton")
local UICorner_14 = Instance.new("UICorner")
local UIAspectRatioConstraint_33 = Instance.new("UIAspectRatioConstraint")
local Legit_2 = Instance.new("TextButton")
local UICorner_15 = Instance.new("UICorner")
local UIAspectRatioConstraint_34 = Instance.new("UIAspectRatioConstraint")
local Render_2 = Instance.new("TextButton")
local UICorner_16 = Instance.new("UICorner")
local UIAspectRatioConstraint_35 = Instance.new("UIAspectRatioConstraint")
local World_2 = Instance.new("TextButton")
local UICorner_17 = Instance.new("UICorner")
local UIAspectRatioConstraint_36 = Instance.new("UIAspectRatioConstraint")
local Utility_2 = Instance.new("TextButton")
local UICorner_18 = Instance.new("UICorner")
local UIAspectRatioConstraint_37 = Instance.new("UIAspectRatioConstraint")
local Kits_2 = Instance.new("TextButton")
local UICorner_19 = Instance.new("UICorner")
local UIAspectRatioConstraint_38 = Instance.new("UIAspectRatioConstraint")
local Misc_2 = Instance.new("TextButton")
local UICorner_20 = Instance.new("UICorner")
local UIAspectRatioConstraint_39 = Instance.new("UIAspectRatioConstraint")
local Reload = Instance.new("TextButton")
local UICorner_21 = Instance.new("UICorner")
local UIAspectRatioConstraint_40 = Instance.new("UIAspectRatioConstraint")
local UICorner_22 = Instance.new("UICorner")
local UIAspectRatioConstraint_41 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_42 = Instance.new("UIAspectRatioConstraint")
local UIAspectRatioConstraint_43 = Instance.new("UIAspectRatioConstraint")

--Properties:

Script.Name = "Script"
Script.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Script_2.Name = "Script"
Script_2.Parent = Script
Script_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Script_2.BackgroundTransparency = 1.000
Script_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Script_2.BorderSizePixel = 0
Script_2.Size = UDim2.new(1.00036967, 0, 0.895098388, 0)

Categories.Name = "Categories"
Categories.Parent = Script_2
Categories.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Categories.BackgroundTransparency = 1.000
Categories.BorderColor3 = Color3.fromRGB(0, 0, 0)
Categories.BorderSizePixel = 0
Categories.Position = UDim2.new(0.205005556, 0, 0.035605289, 0)
Categories.Size = UDim2.new(0.563875675, 0, 0.894201398, 0)
Categories.ZIndex = 9999

Blatant.Name = "Blatant"
Blatant.Parent = Categories
Blatant.BackgroundColor3 = Color3.fromRGB(165, 165, 165)
Blatant.BackgroundTransparency = 0.600
Blatant.BorderColor3 = Color3.fromRGB(0, 0, 0)
Blatant.BorderSizePixel = 0
Blatant.Position = UDim2.new(-0.0567656755, 0, 0.0227531288, 0)
Blatant.Size = UDim2.new(0.12286593, 0, 0.990898728, 0)
Blatant.Visible = false
Blatant.ZIndex = 999999

Title.Name = "Title"
Title.Parent = Blatant
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0.0563218333, 0)
Title.ZIndex = 999999
Title.Font = Enum.Font.Unknown
Title.Text = "Blatant"
Title.TextColor3 = Color3.fromRGB(0, 0, 0)
Title.TextSize = 25.000

UIAspectRatioConstraint.Parent = Title
UIAspectRatioConstraint.AspectRatio = 3.816

UICorner.CornerRadius = UDim.new(0.147198945, 0)
UICorner.Parent = Blatant

Modules.Name = "Modules"
Modules.Parent = Blatant
Modules.Active = true
Modules.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Modules.BackgroundTransparency = 1.000
Modules.BorderColor3 = Color3.fromRGB(0, 0, 0)
Modules.BorderSizePixel = 0
Modules.Position = UDim2.new(0.0324971639, 0, 0.0574052818, 0)
Modules.Size = UDim2.new(0.935924411, 0, 0.918484509, 0)
Modules.ZIndex = 999999

UIAspectRatioConstraint_2.Parent = Modules
UIAspectRatioConstraint_2.AspectRatio = 0.219

UIAspectRatioConstraint_3.Parent = Blatant
UIAspectRatioConstraint_3.AspectRatio = 0.215

Inventory.Name = "Inventory"
Inventory.Parent = Categories
Inventory.BackgroundColor3 = Color3.fromRGB(165, 165, 165)
Inventory.BackgroundTransparency = 0.600
Inventory.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inventory.BorderSizePixel = 0
Inventory.Position = UDim2.new(0.0751598626, 0, 0.0227531288, 0)
Inventory.Size = UDim2.new(0.12286593, 0, 0.990898728, 0)
Inventory.Visible = false
Inventory.ZIndex = 999999

Title_2.Name = "Title"
Title_2.Parent = Inventory
Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_2.BackgroundTransparency = 1.000
Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title_2.BorderSizePixel = 0
Title_2.Position = UDim2.new(-0.00134861725, 0, 0, 0)
Title_2.Size = UDim2.new(1, 0, 0.0563218333, 0)
Title_2.ZIndex = 999999
Title_2.Font = Enum.Font.Unknown
Title_2.Text = "Inventory"
Title_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Title_2.TextSize = 25.000

UIAspectRatioConstraint_4.Parent = Title_2
UIAspectRatioConstraint_4.AspectRatio = 3.816

UICorner_2.CornerRadius = UDim.new(0.147198945, 0)
UICorner_2.Parent = Inventory

Modules_2.Name = "Modules"
Modules_2.Parent = Inventory
Modules_2.Active = true
Modules_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Modules_2.BackgroundTransparency = 1.000
Modules_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Modules_2.BorderSizePixel = 0
Modules_2.Position = UDim2.new(0.0311487075, 0, 0.0574052818, 0)
Modules_2.Size = UDim2.new(0.935924411, 0, 0.918484509, 0)
Modules_2.ZIndex = 999999

UIAspectRatioConstraint_5.Parent = Modules_2
UIAspectRatioConstraint_5.AspectRatio = 0.219

UIAspectRatioConstraint_6.Parent = Inventory
UIAspectRatioConstraint_6.AspectRatio = 0.215

Legit.Name = "Legit"
Legit.Parent = Categories
Legit.BackgroundColor3 = Color3.fromRGB(165, 165, 165)
Legit.BackgroundTransparency = 0.600
Legit.BorderColor3 = Color3.fromRGB(0, 0, 0)
Legit.BorderSizePixel = 0
Legit.Position = UDim2.new(0.207661584, 0, 0.0227531288, 0)
Legit.Size = UDim2.new(0.12286593, 0, 0.990898728, 0)
Legit.Visible = false
Legit.ZIndex = 999999

Title_3.Name = "Title"
Title_3.Parent = Legit
Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_3.BackgroundTransparency = 1.000
Title_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title_3.BorderSizePixel = 0
Title_3.Position = UDim2.new(-0.00270210439, 0, 0, 0)
Title_3.Size = UDim2.new(1, 0, 0.0563218333, 0)
Title_3.ZIndex = 999999
Title_3.Font = Enum.Font.Unknown
Title_3.Text = "Legit"
Title_3.TextColor3 = Color3.fromRGB(0, 0, 0)
Title_3.TextSize = 25.000

UIAspectRatioConstraint_7.Parent = Title_3
UIAspectRatioConstraint_7.AspectRatio = 3.816

UICorner_3.CornerRadius = UDim.new(0.147198945, 0)
UICorner_3.Parent = Legit

Modules_3.Name = "Modules"
Modules_3.Parent = Legit
Modules_3.Active = true
Modules_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Modules_3.BackgroundTransparency = 1.000
Modules_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
Modules_3.BorderSizePixel = 0
Modules_3.Position = UDim2.new(0.0297955461, 0, 0.0574052818, 0)
Modules_3.Size = UDim2.new(0.935924411, 0, 0.918484509, 0)
Modules_3.ZIndex = 999999

UIAspectRatioConstraint_8.Parent = Modules_3
UIAspectRatioConstraint_8.AspectRatio = 0.219

UIAspectRatioConstraint_9.Parent = Legit
UIAspectRatioConstraint_9.AspectRatio = 0.215

Render.Name = "Render"
Render.Parent = Categories
Render.BackgroundColor3 = Color3.fromRGB(165, 165, 165)
Render.BackgroundTransparency = 0.600
Render.BorderColor3 = Color3.fromRGB(0, 0, 0)
Render.BorderSizePixel = 0
Render.Position = UDim2.new(0.339587212, 0, 0.0227531288, 0)
Render.Size = UDim2.new(0.12286593, 0, 0.990898728, 0)
Render.Visible = false
Render.ZIndex = 999999

Title_4.Name = "Title"
Title_4.Parent = Render
Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_4.BackgroundTransparency = 1.000
Title_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title_4.BorderSizePixel = 0
Title_4.Position = UDim2.new(-0.00405039685, 0, 0, 0)
Title_4.Size = UDim2.new(1, 0, 0.0563218333, 0)
Title_4.ZIndex = 999999
Title_4.Font = Enum.Font.Unknown
Title_4.Text = "Render"
Title_4.TextColor3 = Color3.fromRGB(0, 0, 0)
Title_4.TextSize = 25.000

UIAspectRatioConstraint_10.Parent = Title_4
UIAspectRatioConstraint_10.AspectRatio = 3.816

UICorner_4.CornerRadius = UDim.new(0.147198945, 0)
UICorner_4.Parent = Render

Modules_4.Name = "Modules"
Modules_4.Parent = Render
Modules_4.Active = true
Modules_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Modules_4.BackgroundTransparency = 1.000
Modules_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
Modules_4.BorderSizePixel = 0
Modules_4.Position = UDim2.new(0.0284462795, 0, 0.0574052818, 0)
Modules_4.Size = UDim2.new(0.935924411, 0, 0.918484509, 0)
Modules_4.ZIndex = 999999

UIAspectRatioConstraint_11.Parent = Modules_4
UIAspectRatioConstraint_11.AspectRatio = 0.219

UIAspectRatioConstraint_12.Parent = Render
UIAspectRatioConstraint_12.AspectRatio = 0.215

Utility.Name = "Utility"
Utility.Parent = Categories
Utility.BackgroundColor3 = Color3.fromRGB(165, 165, 165)
Utility.BackgroundTransparency = 0.600
Utility.BorderColor3 = Color3.fromRGB(0, 0, 0)
Utility.BorderSizePixel = 0
Utility.Position = UDim2.new(0.469307005, 0, 0.0227531288, 0)
Utility.Size = UDim2.new(0.12286593, 0, 0.990898728, 0)
Utility.Visible = false
Utility.ZIndex = 999999

Title_5.Name = "Title"
Title_5.Parent = Utility
Title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_5.BackgroundTransparency = 1.000
Title_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title_5.BorderSizePixel = 0
Title_5.Size = UDim2.new(1, 0, 0.0563218333, 0)
Title_5.ZIndex = 999999
Title_5.Font = Enum.Font.Unknown
Title_5.Text = "Utility"
Title_5.TextColor3 = Color3.fromRGB(0, 0, 0)
Title_5.TextSize = 25.000

UIAspectRatioConstraint_13.Parent = Title_5
UIAspectRatioConstraint_13.AspectRatio = 3.816

UICorner_5.CornerRadius = UDim.new(0.147198945, 0)
UICorner_5.Parent = Utility

Modules_5.Name = "Modules"
Modules_5.Parent = Utility
Modules_5.Active = true
Modules_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Modules_5.BackgroundTransparency = 1.000
Modules_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
Modules_5.BorderSizePixel = 0
Modules_5.Position = UDim2.new(0.0324971639, 0, 0.0574052818, 0)
Modules_5.Size = UDim2.new(0.935924411, 0, 0.918484509, 0)
Modules_5.ZIndex = 999999

UIAspectRatioConstraint_14.Parent = Modules_5
UIAspectRatioConstraint_14.AspectRatio = 0.219

UIAspectRatioConstraint_15.Parent = Utility
UIAspectRatioConstraint_15.AspectRatio = 0.215

World.Name = "World"
World.Parent = Categories
World.BackgroundColor3 = Color3.fromRGB(165, 165, 165)
World.BackgroundTransparency = 0.600
World.BorderColor3 = Color3.fromRGB(0, 0, 0)
World.BorderSizePixel = 0
World.Position = UDim2.new(0.601232469, 0, 0.0227531288, 0)
World.Size = UDim2.new(0.12286593, 0, 0.990898728, 0)
World.Visible = false
World.ZIndex = 999999

Title_6.Name = "Title"
Title_6.Parent = World
Title_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_6.BackgroundTransparency = 1.000
Title_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title_6.BorderSizePixel = 0
Title_6.Position = UDim2.new(-0.00134861725, 0, 0, 0)
Title_6.Size = UDim2.new(1, 0, 0.0563218333, 0)
Title_6.ZIndex = 999999
Title_6.Font = Enum.Font.Unknown
Title_6.Text = "World"
Title_6.TextColor3 = Color3.fromRGB(0, 0, 0)
Title_6.TextSize = 25.000

UIAspectRatioConstraint_16.Parent = Title_6
UIAspectRatioConstraint_16.AspectRatio = 3.816

UICorner_6.CornerRadius = UDim.new(0.147198945, 0)
UICorner_6.Parent = World

Modules_6.Name = "Modules"
Modules_6.Parent = World
Modules_6.Active = true
Modules_6.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Modules_6.BackgroundTransparency = 1.000
Modules_6.BorderColor3 = Color3.fromRGB(0, 0, 0)
Modules_6.BorderSizePixel = 0
Modules_6.Position = UDim2.new(0.0311487075, 0, 0.0574052818, 0)
Modules_6.Size = UDim2.new(0.935924411, 0, 0.918484509, 0)
Modules_6.ZIndex = 999999

UIAspectRatioConstraint_17.Parent = Modules_6
UIAspectRatioConstraint_17.AspectRatio = 0.219

UIAspectRatioConstraint_18.Parent = World
UIAspectRatioConstraint_18.AspectRatio = 0.215

Kits.Name = "Kits"
Kits.Parent = Categories
Kits.BackgroundColor3 = Color3.fromRGB(165, 165, 165)
Kits.BackgroundTransparency = 0.600
Kits.BorderColor3 = Color3.fromRGB(0, 0, 0)
Kits.BorderSizePixel = 0
Kits.Position = UDim2.new(0.73373419, 0, 0.0227531288, 0)
Kits.Size = UDim2.new(0.12286593, 0, 0.990898728, 0)
Kits.Visible = false
Kits.ZIndex = 999999

Title_7.Name = "Title"
Title_7.Parent = Kits
Title_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_7.BackgroundTransparency = 1.000
Title_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title_7.BorderSizePixel = 0
Title_7.Position = UDim2.new(-0.00270210439, 0, 0, 0)
Title_7.Size = UDim2.new(1, 0, 0.0563218333, 0)
Title_7.ZIndex = 999999
Title_7.Font = Enum.Font.Unknown
Title_7.Text = "Kits"
Title_7.TextColor3 = Color3.fromRGB(0, 0, 0)
Title_7.TextSize = 25.000

UIAspectRatioConstraint_19.Parent = Title_7
UIAspectRatioConstraint_19.AspectRatio = 3.816

UICorner_7.CornerRadius = UDim.new(0.147198945, 0)
UICorner_7.Parent = Kits

Modules_7.Name = "Modules"
Modules_7.Parent = Kits
Modules_7.Active = true
Modules_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Modules_7.BackgroundTransparency = 1.000
Modules_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
Modules_7.BorderSizePixel = 0
Modules_7.Position = UDim2.new(0.0297955461, 0, 0.0574052818, 0)
Modules_7.Size = UDim2.new(0.935924411, 0, 0.918484509, 0)
Modules_7.ZIndex = 999999

UIAspectRatioConstraint_20.Parent = Modules_7
UIAspectRatioConstraint_20.AspectRatio = 0.219

UIAspectRatioConstraint_21.Parent = Kits
UIAspectRatioConstraint_21.AspectRatio = 0.215

Misc.Name = "Misc"
Misc.Parent = Categories
Misc.BackgroundColor3 = Color3.fromRGB(165, 165, 165)
Misc.BackgroundTransparency = 0.600
Misc.BorderColor3 = Color3.fromRGB(0, 0, 0)
Misc.BorderSizePixel = 0
Misc.Position = UDim2.new(0.865659833, 0, 0.0227531288, 0)
Misc.Size = UDim2.new(0.12286593, 0, 0.990898728, 0)
Misc.Visible = false
Misc.ZIndex = 999999

Title_8.Name = "Title"
Title_8.Parent = Misc
Title_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_8.BackgroundTransparency = 1.000
Title_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title_8.BorderSizePixel = 0
Title_8.Position = UDim2.new(-0.00405039685, 0, 0, 0)
Title_8.Size = UDim2.new(1, 0, 0.0563218333, 0)
Title_8.ZIndex = 999999
Title_8.Font = Enum.Font.Unknown
Title_8.Text = "Misc"
Title_8.TextColor3 = Color3.fromRGB(0, 0, 0)
Title_8.TextSize = 25.000

UIAspectRatioConstraint_22.Parent = Title_8
UIAspectRatioConstraint_22.AspectRatio = 3.816

UICorner_8.CornerRadius = UDim.new(0.147198945, 0)
UICorner_8.Parent = Misc

Modules_8.Name = "Modules"
Modules_8.Parent = Misc
Modules_8.Active = true
Modules_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Modules_8.BackgroundTransparency = 1.000
Modules_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
Modules_8.BorderSizePixel = 0
Modules_8.Position = UDim2.new(0.0284462795, 0, 0.0574052818, 0)
Modules_8.Size = UDim2.new(0.935924411, 0, 0.918484509, 0)
Modules_8.ZIndex = 999999

UIAspectRatioConstraint_23.Parent = Modules_8
UIAspectRatioConstraint_23.AspectRatio = 0.219

UIAspectRatioConstraint_24.Parent = Misc
UIAspectRatioConstraint_24.AspectRatio = 0.215

UIAspectRatioConstraint_25.Parent = Categories
UIAspectRatioConstraint_25.AspectRatio = 1.733

Notification.Name = "Notification"
Notification.Parent = Script_2
Notification.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
Notification.BackgroundTransparency = 0.200
Notification.BorderColor3 = Color3.fromRGB(0, 0, 0)
Notification.BorderSizePixel = 0
Notification.Position = UDim2.new(0.826682806, 0, 0.720244169, 0)
Notification.Size = UDim2.new(0.160488963, 0, 0.228720665, 0)
Notification.Visible = false
Notification.ZIndex = 99999

UICorner_9.CornerRadius = UDim.new(0.147198945, 0)
UICorner_9.Parent = Notification

Title_9.Name = "Title"
Title_9.Parent = Notification
Title_9.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_9.BackgroundTransparency = 1.000
Title_9.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title_9.BorderSizePixel = 0
Title_9.Size = UDim2.new(1, 0, 0.23222746, 0)
Title_9.ZIndex = 99999
Title_9.Font = Enum.Font.Unknown
Title_9.Text = "shitty script of doom and despair"
Title_9.TextColor3 = Color3.fromRGB(0, 0, 0)
Title_9.TextScaled = true
Title_9.TextSize = 28.000
Title_9.TextWrapped = true

UIAspectRatioConstraint_26.Parent = Title_9
UIAspectRatioConstraint_26.AspectRatio = 8.306

Notification_2.Name = "Notification"
Notification_2.Parent = Notification
Notification_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Notification_2.BackgroundTransparency = 0.700
Notification_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Notification_2.BorderSizePixel = 0
Notification_2.Position = UDim2.new(0.0245700236, 0, 0.235849053, 0)
Notification_2.Size = UDim2.new(0.948067904, 0, 0.679245353, 0)
Notification_2.ZIndex = 99999
Notification_2.Font = Enum.Font.Unknown
Notification_2.Text = "Notification: "
Notification_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Notification_2.TextSize = 30.000
Notification_2.TextWrapped = true

UIAspectRatioConstraint_27.Parent = Notification_2
UIAspectRatioConstraint_27.AspectRatio = 2.692

UIAspectRatioConstraint_28.Parent = Notification
UIAspectRatioConstraint_28.AspectRatio = 1.929
UIAspectRatioConstraint_28.AspectType = Enum.AspectType.ScaleWithParentSize

Main.Name = "Main"
Main.Parent = Script_2
Main.BackgroundColor3 = Color3.fromRGB(107, 107, 107)
Main.BackgroundTransparency = 0.300
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.0125972014, 0, 0.228292629, 0)
Main.Size = UDim2.new(0.140727177, 0, 0.841302156, 0)
Main.ZIndex = 9999999

UICorner_10.CornerRadius = UDim.new(0.103039265, 0)
UICorner_10.Parent = Main

Title_10.Name = "Title"
Title_10.Parent = Main
Title_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title_10.BackgroundTransparency = 1.000
Title_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
Title_10.BorderSizePixel = 0
Title_10.Position = UDim2.new(0.0482758582, 0, 0.00951372646, 0)
Title_10.Size = UDim2.new(0.546965182, 0, 0.0931076184, 0)
Title_10.ZIndex = 9999999
Title_10.Font = Enum.Font.Unknown
Title_10.Text = "shitty script of doom and despair"
Title_10.TextColor3 = Color3.fromRGB(0, 0, 255)
Title_10.TextScaled = true
Title_10.TextSize = 14.000
Title_10.TextWrapped = true

UICorner_11.CornerRadius = UDim.new(0.103039265, 0)
UICorner_11.Parent = Title_10

UIAspectRatioConstraint_29.Parent = Title_10
UIAspectRatioConstraint_29.AspectRatio = 2.701

UIAspectRatioConstraint_30.Parent = Main
UIAspectRatioConstraint_30.AspectRatio = 0.460

Delete.Name = "Delete"
Delete.Parent = Main
Delete.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
Delete.BorderColor3 = Color3.fromRGB(0, 0, 0)
Delete.BorderSizePixel = 0
Delete.Position = UDim2.new(0.608864665, 0, 0.0167688746, 0)
Delete.Size = UDim2.new(0.347112507, 0, 0.0779789016, 0)
Delete.ZIndex = 9999999
Delete.Font = Enum.Font.Unknown
Delete.Text = "X"
Delete.TextColor3 = Color3.fromRGB(255, 255, 255)
Delete.TextScaled = true
Delete.TextSize = 14.000
Delete.TextWrapped = true

UICorner_12.CornerRadius = UDim.new(0.147198945, 0)
UICorner_12.Parent = Delete

UIAspectRatioConstraint_31.Parent = Delete
UIAspectRatioConstraint_31.AspectRatio = 2.047

Categories_2.Name = "Categories"
Categories_2.Parent = Main
Categories_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Categories_2.BackgroundTransparency = 0.450
Categories_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Categories_2.BorderSizePixel = 0
Categories_2.Position = UDim2.new(0.0338930711, 0, 0.104044087, 0)
Categories_2.Size = UDim2.new(0.907225907, 0, 0.853688061, 0)
Categories_2.ZIndex = 9999999

Blatant_2.Name = "Blatant"
Blatant_2.Parent = Categories_2
Blatant_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Blatant_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Blatant_2.BorderSizePixel = 0
Blatant_2.Position = UDim2.new(0.0347826071, 0, 0.0254596882, 0)
Blatant_2.Size = UDim2.new(0.930434704, 0, 0.0909348354, 0)
Blatant_2.ZIndex = 199999999
Blatant_2.Font = Enum.Font.Unknown
Blatant_2.Text = "Blatant"
Blatant_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Blatant_2.TextSize = 25.000

UICorner_13.CornerRadius = UDim.new(0.147198945, 0)
UICorner_13.Parent = Blatant_2

UIAspectRatioConstraint_32.Parent = Blatant_2
UIAspectRatioConstraint_32.AspectRatio = 5.000

Inventory_2.Name = "Inventory"
Inventory_2.Parent = Categories_2
Inventory_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Inventory_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Inventory_2.BorderSizePixel = 0
Inventory_2.Position = UDim2.new(0.0347826071, 0, 0.131541729, 0)
Inventory_2.Size = UDim2.new(0.930434704, 0, 0.0909348354, 0)
Inventory_2.ZIndex = 199999999
Inventory_2.Font = Enum.Font.Unknown
Inventory_2.Text = "Inventory"
Inventory_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Inventory_2.TextSize = 25.000

UICorner_14.CornerRadius = UDim.new(0.147198945, 0)
UICorner_14.Parent = Inventory_2

UIAspectRatioConstraint_33.Parent = Inventory_2
UIAspectRatioConstraint_33.AspectRatio = 5.000

Legit_2.Name = "Legit"
Legit_2.Parent = Categories_2
Legit_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Legit_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Legit_2.BorderSizePixel = 0
Legit_2.Position = UDim2.new(0.0347826071, 0, 0.244695902, 0)
Legit_2.Size = UDim2.new(0.930434704, 0, 0.0909348354, 0)
Legit_2.ZIndex = 199999999
Legit_2.Font = Enum.Font.Unknown
Legit_2.Text = "Legit"
Legit_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Legit_2.TextSize = 25.000

UICorner_15.CornerRadius = UDim.new(0.147198945, 0)
UICorner_15.Parent = Legit_2

UIAspectRatioConstraint_34.Parent = Legit_2
UIAspectRatioConstraint_34.AspectRatio = 5.000

Render_2.Name = "Render"
Render_2.Parent = Categories_2
Render_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Render_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Render_2.BorderSizePixel = 0
Render_2.Position = UDim2.new(0.0347826071, 0, 0.355021209, 0)
Render_2.Size = UDim2.new(0.930434704, 0, 0.0909348354, 0)
Render_2.ZIndex = 199999999
Render_2.Font = Enum.Font.Unknown
Render_2.Text = "Render"
Render_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Render_2.TextSize = 25.000

UICorner_16.CornerRadius = UDim.new(0.147198945, 0)
UICorner_16.Parent = Render_2

UIAspectRatioConstraint_35.Parent = Render_2
UIAspectRatioConstraint_35.AspectRatio = 5.000

World_2.Name = "World"
World_2.Parent = Categories_2
World_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
World_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
World_2.BorderSizePixel = 0
World_2.Position = UDim2.new(0.0347826071, 0, 0.571428597, 0)
World_2.Size = UDim2.new(0.930434704, 0, 0.0909348354, 0)
World_2.ZIndex = 199999999
World_2.Font = Enum.Font.Unknown
World_2.Text = "World"
World_2.TextColor3 = Color3.fromRGB(0, 0, 0)
World_2.TextSize = 25.000

UICorner_17.CornerRadius = UDim.new(0.147198945, 0)
UICorner_17.Parent = World_2

UIAspectRatioConstraint_36.Parent = World_2
UIAspectRatioConstraint_36.AspectRatio = 5.000

Utility_2.Name = "Utility"
Utility_2.Parent = Categories_2
Utility_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Utility_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Utility_2.BorderSizePixel = 0
Utility_2.Position = UDim2.new(0.0347826071, 0, 0.463932097, 0)
Utility_2.Size = UDim2.new(0.930434704, 0, 0.0909348354, 0)
Utility_2.ZIndex = 199999999
Utility_2.Font = Enum.Font.Unknown
Utility_2.Text = "Utility"
Utility_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Utility_2.TextSize = 25.000

UICorner_18.CornerRadius = UDim.new(0.147198945, 0)
UICorner_18.Parent = Utility_2

UIAspectRatioConstraint_37.Parent = Utility_2
UIAspectRatioConstraint_37.AspectRatio = 5.000

Kits_2.Name = "Kits"
Kits_2.Parent = Categories_2
Kits_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Kits_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Kits_2.BorderSizePixel = 0
Kits_2.Position = UDim2.new(0.0347826071, 0, 0.676096261, 0)
Kits_2.Size = UDim2.new(0.930434704, 0, 0.0909348354, 0)
Kits_2.ZIndex = 199999999
Kits_2.Font = Enum.Font.Unknown
Kits_2.Text = "Kits"
Kits_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Kits_2.TextSize = 25.000

UICorner_19.CornerRadius = UDim.new(0.147198945, 0)
UICorner_19.Parent = Kits_2

UIAspectRatioConstraint_38.Parent = Kits_2
UIAspectRatioConstraint_38.AspectRatio = 5.000

Misc_2.Name = "Misc"
Misc_2.Parent = Categories_2
Misc_2.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
Misc_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Misc_2.BorderSizePixel = 0
Misc_2.Position = UDim2.new(0.0347826071, 0, 0.780763865, 0)
Misc_2.Size = UDim2.new(0.930434704, 0, 0.0909348354, 0)
Misc_2.ZIndex = 199999999
Misc_2.Font = Enum.Font.Unknown
Misc_2.Text = "Misc"
Misc_2.TextColor3 = Color3.fromRGB(0, 0, 0)
Misc_2.TextSize = 25.000

UICorner_20.CornerRadius = UDim.new(0.147198945, 0)
UICorner_20.Parent = Misc_2

UIAspectRatioConstraint_39.Parent = Misc_2
UIAspectRatioConstraint_39.AspectRatio = 5.000

Reload.Name = "Reload"
Reload.Parent = Categories_2
Reload.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Reload.BorderColor3 = Color3.fromRGB(0, 0, 0)
Reload.BorderSizePixel = 0
Reload.Position = UDim2.new(0.0347826071, 0, 0.882602632, 0)
Reload.Size = UDim2.new(0.930434704, 0, 0.105143413, 0)
Reload.ZIndex = 199999999
Reload.Font = Enum.Font.Unknown
Reload.Text = "Reload Modules"
Reload.TextColor3 = Color3.fromRGB(0, 0, 0)
Reload.TextSize = 25.000

UICorner_21.CornerRadius = UDim.new(0.147198945, 0)
UICorner_21.Parent = Reload

UIAspectRatioConstraint_40.Parent = Reload
UIAspectRatioConstraint_40.AspectRatio = 4.324

UICorner_22.CornerRadius = UDim.new(0.103039265, 0)
UICorner_22.Parent = Categories_2

UIAspectRatioConstraint_41.Parent = Categories_2
UIAspectRatioConstraint_41.AspectRatio = 0.489

UIAspectRatioConstraint_42.Parent = Main
UIAspectRatioConstraint_42.AspectRatio = 0.565

UIAspectRatioConstraint_43.Parent = Script_2
UIAspectRatioConstraint_43.AspectRatio = 2.749

-- Scripts:

local function ZPZWEX_fake_script() -- Blatant.MakeDraggable 
	local script = Instance.new('LocalScript', Blatant)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(ZPZWEX_fake_script)()
local function IYVE_fake_script() -- Inventory.MakeDraggable 
	local script = Instance.new('LocalScript', Inventory)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(IYVE_fake_script)()
local function XBYAA_fake_script() -- Legit.MakeDraggable 
	local script = Instance.new('LocalScript', Legit)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(XBYAA_fake_script)()
local function FVCVWJE_fake_script() -- Render.MakeDraggable 
	local script = Instance.new('LocalScript', Render)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(FVCVWJE_fake_script)()
local function SIIAQM_fake_script() -- Utility.MakeDraggable 
	local script = Instance.new('LocalScript', Utility)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(SIIAQM_fake_script)()
local function MSIT_fake_script() -- World.MakeDraggable 
	local script = Instance.new('LocalScript', World)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(MSIT_fake_script)()
local function IYID_fake_script() -- Kits.MakeDraggable 
	local script = Instance.new('LocalScript', Kits)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(IYID_fake_script)()
local function DRKDHLP_fake_script() -- Misc.MakeDraggable 
	local script = Instance.new('LocalScript', Misc)

	local UserInputService = game:GetService("UserInputService")
	
	local gui = script.Parent
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
	
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end
coroutine.wrap(DRKDHLP_fake_script)()
local function GBBFO_fake_script() -- Delete.LocalScript 
	local script = Instance.new('LocalScript', Delete)

	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent:Destroy()
	end)
end
coroutine.wrap(GBBFO_fake_script)()
local function IZWSGH_fake_script() -- Blatant_2.LocalScript 
	local script = Instance.new('LocalScript', Blatant_2)

	
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.Categories.Blatant.Visible = not script.Parent.Parent.Parent.Parent.Categories.Blatant.Visible
	end)
end
coroutine.wrap(IZWSGH_fake_script)()
local function ERDHQ_fake_script() -- Inventory_2.LocalScript 
	local script = Instance.new('LocalScript', Inventory_2)

	
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.Categories.Inventory.Visible = not script.Parent.Parent.Parent.Parent.Categories.Inventory.Visible
	end)
end
coroutine.wrap(ERDHQ_fake_script)()
local function MXQMOX_fake_script() -- Legit_2.LocalScript 
	local script = Instance.new('LocalScript', Legit_2)

	
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.Categories.Legit.Visible = not script.Parent.Parent.Parent.Parent.Categories.Legit.Visible
	end)
end
coroutine.wrap(MXQMOX_fake_script)()
local function BHEQ_fake_script() -- Render_2.LocalScript 
	local script = Instance.new('LocalScript', Render_2)

	
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.Categories.Render.Visible = not script.Parent.Parent.Parent.Parent.Categories.Render.Visible
	end)
end
coroutine.wrap(BHEQ_fake_script)()
local function KIGES_fake_script() -- World_2.LocalScript 
	local script = Instance.new('LocalScript', World_2)

	
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.Categories.World.Visible = not script.Parent.Parent.Parent.Parent.Categories.World.Visible
	end)
end
coroutine.wrap(KIGES_fake_script)()
local function USHNWUZ_fake_script() -- Utility_2.LocalScript 
	local script = Instance.new('LocalScript', Utility_2)

	
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.Categories.Utility.Visible = not script.Parent.Parent.Parent.Parent.Categories.Utility.Visible
	end)
end
coroutine.wrap(USHNWUZ_fake_script)()
local function GHXTLGJ_fake_script() -- Kits_2.LocalScript 
	local script = Instance.new('LocalScript', Kits_2)

	
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.Categories.Kits.Visible = not script.Parent.Parent.Parent.Parent.Categories.Kits.Visible
	end)
end
coroutine.wrap(GHXTLGJ_fake_script)()
local function ZJVXXL_fake_script() -- Misc_2.LocalScript 
	local script = Instance.new('LocalScript', Misc_2)

	
	script.Parent.MouseButton1Click:Connect(function()
		script.Parent.Parent.Parent.Parent.Categories.Misc.Visible = not script.Parent.Parent.Parent.Parent.Categories.Misc.Visible
	end)
end
coroutine.wrap(ZJVXXL_fake_script)()

-- GITHUB LOADING CODE (Load All at Once + Fixed Save + Dropdown)
local REPO_USER = "radwaw1"
local REPO_NAME = "bwscriptnew"
local REPO_BRANCH = "main"
local GITHUB_FOLDER = "modules"
local saveFile = "ModuleHub_Config.json"

local modules = {}
local categoryFrames = {
    Blatant = Modules,
    Inventory = Modules_2,
    Legit = Modules_3,
    Render = Modules_4,
    Utility = Modules_5,
    World = Modules_6,
    Kits = Modules_7,
    Misc = Modules_8
}

-- UIListLayout
for _, frame in pairs(categoryFrames) do
    local list = Instance.new("UIListLayout")
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 5)
    list.Parent = frame
end

local function updateButtonVisual(button, enabled)
    button.BackgroundColor3 = enabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
end

local saveFile = "ModuleHub_Config.json"  -- saved in executor workspace folder

local function saveConfig()
    local config = {}
    for name, mod in pairs(modules) do
        config[name] = {
            enabled = mod.enabled or false,
            settings = {}
        }
        for _, setting in ipairs(mod.moduleData.Config or {}) do
            config[name].settings[setting.Name] = setting.Value
        end
    end
    
    local success, err = pcall(function()
        writefile(saveFile, game:GetService("HttpService"):JSONEncode(config))
    end)
    
    if success then
        print("✅ Config saved to workspace (" .. saveFile .. ")")
    else
        print("❌ Save failed: " .. tostring(err))
    end
end

local function loadConfig()
    if not isfile(saveFile) then
        print("No save file found yet")
        return
    end
    
    local success, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(readfile(saveFile))
    end)
    
    if success then
        for name, cfg in pairs(data) do
            if modules[name] then
                if cfg.enabled then
                    pcall(modules[name].moduleData.Run)
                    modules[name].enabled = true
                    updateButtonVisual(modules[name].button, true)
                end
                for _, setting in ipairs(modules[name].moduleData.Config or {}) do
                    if cfg.settings and cfg.settings[setting.Name] ~= nil then
                        setting.Value = cfg.settings[setting.Name]
                    end
                end
            end
        end
        print("✅ Config loaded from workspace")
    else
        print("❌ Load failed (corrupted file)")
    end
end

local function createConfigUI(moduleFrame, modData)
    local dropdown = Instance.new("Frame")
    dropdown.Size = UDim2.new(1, 0, 0, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    dropdown.Visible = false
    dropdown.Parent = moduleFrame

    local list = Instance.new("UIListLayout")
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0, 4)
    list.Parent = dropdown

    for _, setting in ipairs(modData.Config or {}) do
        if setting.Type == "Slider" then
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 30)
            row.BackgroundTransparency = 1
            row.Parent = dropdown

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.5, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.Text = setting.Name .. ": " .. tostring(setting.Value)
            label.TextColor3 = Color3.fromRGB(255,255,255)
            label.TextSize = 14
            label.Parent = row

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(0.45, 0, 1, 0)
            btn.Position = UDim2.new(0.55, 0, 0, 0)
            btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
            btn.Text = tostring(setting.Value)
            btn.TextColor3 = Color3.fromRGB(255,255,255)
            btn.Parent = row

            btn.MouseButton1Click:Connect(function()
                local val = tonumber(prompt("Enter value for " .. setting.Name, tostring(setting.Value)))
                if val then
                    setting.Value = math.clamp(val, setting.Min or 0, setting.Max or 100)
                    label.Text = setting.Name .. ": " .. tostring(setting.Value)
                    btn.Text = tostring(setting.Value)
                    saveConfig()
                end
            end)
        end
    end

    return dropdown
end

local function refreshModules()
    -- Single call to get all categories
    local url = string.format("https://api.github.com/repos/%s/%s/contents/%s?ref=%s", REPO_USER, REPO_NAME, GITHUB_FOLDER, REPO_BRANCH)
    local ok, response = pcall(function() return request({Url = url, Method = "GET"}) end)

    if not (ok and response.Success) then
        print("Failed to fetch modules list")
        return
    end

    local folders = game:GetService("HttpService"):JSONDecode(response.Body)

    for _, folder in ipairs(folders) do
        if folder.type == "dir" then
            local category = folder.name
            local scrollingFrame = categoryFrames[category]
            if not scrollingFrame then continue end

            -- Clear previous
            for _, child in ipairs(scrollingFrame:GetChildren()) do
                if child:IsA("Frame") then child:Destroy() end
            end

            local catUrl = string.format("https://api.github.com/repos/%s/%s/contents/%s/%s?ref=%s", REPO_USER, REPO_NAME, GITHUB_FOLDER, category, REPO_BRANCH)
            local catOk, catResponse = pcall(function() return request({Url = catUrl, Method = "GET"}) end)

            if catOk and catResponse.Success then
                local files = game:GetService("HttpService"):JSONDecode(catResponse.Body)
                for _, file in ipairs(files) do
                    if file.type == "file" and file.name:match("%.lua$") then
                        local ok2, res = pcall(function() return request({Url = file.download_url, Method = "GET"}) end)
                        if ok2 and res.Success then
                            local func = loadstring(res.Body)
                            if func then
                                local s, mod = pcall(func)
                                if s and mod and mod.Run then
                                    local moduleFrame = Instance.new("Frame")
                                    moduleFrame.Size = UDim2.new(1, -10, 0, 50)
                                    moduleFrame.BackgroundTransparency = 1
                                    moduleFrame.Parent = scrollingFrame

                                    local button = Instance.new("TextButton")
                                    button.Size = UDim2.new(0.72, 0, 1, 0)
                                    button.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
                                    button.Text = mod.Name or file.name
                                    button.TextColor3 = Color3.fromRGB(255,255,255)
                                    button.TextSize = 15
                                    button.Parent = moduleFrame

                                    button.MouseButton1Click:Connect(function()
                                        pcall(mod.Run)
                                        mod.enabled = not (mod.enabled or false)
                                        updateButtonVisual(button, mod.enabled)
                                        saveConfig()
                                    end)

                                    local configBtn = Instance.new("TextButton")
                                    configBtn.Size = UDim2.new(0.25, 0, 1, 0)
                                    configBtn.Position = UDim2.new(0.76, 0, 0, 0)
                                    configBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
                                    configBtn.Text = "Config"
                                    configBtn.TextColor3 = Color3.fromRGB(255,255,255)
                                    configBtn.Parent = moduleFrame

                                    local dropdown = createConfigUI(moduleFrame, mod)

                                    configBtn.MouseButton1Click:Connect(function()
                                        dropdown.Visible = not dropdown.Visible
                                        local extra = dropdown.Visible and dropdown.AbsoluteContentSize.Y + 10 or 0
                                        moduleFrame.Size = UDim2.new(1, -10, 0, 50 + extra)
                                    end)

                                    modules[mod.Name or file.name] = {moduleData = mod, enabled = false, button = button}
                                    updateButtonVisual(button, false)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

-- Load everything at once
refreshModules()
loadConfig()
print("ModuleHub loaded with GitHub integration.")

-- RightShift Toggle
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        Script_2.Visible = not Script_2.Visible
    end
end)