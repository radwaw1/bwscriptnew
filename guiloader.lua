-- ModuleHub with Categories + RightShift Toggle
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local REPO_USER = "radwaw1"
local REPO_NAME = "bwscriptnew"
local REPO_BRANCH = "main"
local GITHUB_FOLDER = "modules"

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "shitty script of doom and despair"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 100
screenGui.Enabled = true
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 650, 0, 480)
mainFrame.Position = UDim2.new(0, 20, 0.5, -240)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner"); uiCorner.CornerRadius = UDim.new(0,8); uiCorner.Parent = mainFrame

-- Left Sidebar (Categories)
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 140, 1, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(25,25,30)
sidebar.Parent = mainFrame

local sidebarCorner = Instance.new("UICorner"); sidebarCorner.CornerRadius = UDim.new(0,8); sidebarCorner.Parent = sidebar

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1,0,0,36)
titleBar.BackgroundColor3 = Color3.fromRGB(20,20,24)
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1,-100,1,0)
titleLabel.Position = UDim2.new(0,12,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Module Hub"
titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.Parent = titleBar

local selfDestructBtn = Instance.new("TextButton")
selfDestructBtn.Size = UDim2.new(0,85,0,24)
selfDestructBtn.Position = UDim2.new(1,-92,0.5,-12)
selfDestructBtn.BackgroundColor3 = Color3.fromRGB(170,30,30)
selfDestructBtn.Text = "Self Destruct"
selfDestructBtn.TextColor3 = Color3.fromRGB(255,255,255)
selfDestructBtn.Font = Enum.Font.Gotham
selfDestructBtn.TextSize = 11
selfDestructBtn.Parent = titleBar

local reloadButton = Instance.new("TextButton")
reloadButton.Size = UDim2.new(0,60,0,24)
reloadButton.Position = UDim2.new(1,-155,0.5,-12)
reloadButton.BackgroundColor3 = Color3.fromRGB(45,45,52)
reloadButton.Text = "Reload"
reloadButton.TextColor3 = Color3.fromRGB(255,255,255)
reloadButton.Font = Enum.Font.Gotham
reloadButton.TextSize = 12
reloadButton.Parent = titleBar

-- Categories
local categories = {
    Blatant = {},
    World = {},
    Utility = {},
    Legit = {},
    Inventory = {},
    Render = {}
}

local categoryButtons = {}
local currentCategory = "Blatant"

local categoryList = Instance.new("ScrollingFrame")
categoryList.Size = UDim2.new(1,0,1,-36)
categoryList.Position = UDim2.new(0,0,0,36)
categoryList.BackgroundTransparency = 1
categoryList.ScrollBarThickness = 4
categoryList.Parent = sidebar

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0,4)
listLayout.Parent = categoryList

for catName in pairs(categories) do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,36)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,52)
    btn.Text = catName
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.Parent = categoryList

    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0,6); corner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        currentCategory = catName
        refreshModules()
    end)

    categoryButtons[catName] = btn
end

local mainContent = Instance.new("ScrollingFrame")
mainContent.Size = UDim2.new(1, -150, 1, -50)
mainContent.Position = UDim2.new(0, 150, 0, 45)
mainContent.BackgroundTransparency = 1
mainContent.ScrollBarThickness = 4
mainContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
mainContent.Parent = mainFrame

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0,6)
contentLayout.Parent = mainContent

local modules = {}
local openConfigWindows = {}

local function makeDraggable(frame, dragBar)
    local dragging = false
    local dragStart = nil
    local startPos = nil

    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    dragBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

makeDraggable(mainFrame, titleBar)

selfDestructBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

-- RightShift Toggle
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        screenGui.Enabled = not screenGui.Enabled
    end
end)

-- Keybind System
local keybinds = {}

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    for name, mod in pairs(modules) do
        if keybinds[name] and input.KeyCode == keybinds[name] then
            pcall(mod.moduleData.Run)
            mod.enabled = not mod.enabled
            updateButtonVisual(mod.button, mod.enabled)
        end
    end
end)

local function updateButtonVisual(button, enabled)
    button.BackgroundColor3 = enabled and Color3.fromRGB(40,120,60) or Color3.fromRGB(120,40,40)
end

local function createConfigWindow(moduleData)
    local name = moduleData.Name
    if openConfigWindows[name] then
        openConfigWindows[name]:Destroy()
        openConfigWindows[name] = nil
        return
    end

    local configFrame = Instance.new("Frame")
    configFrame.Size = UDim2.new(0, 300, 0, 500)
    configFrame.Position = UDim2.new(0.5, -150, 0.5, -250)
    configFrame.BackgroundColor3 = Color3.fromRGB(25,25,30)
    configFrame.Parent = screenGui

    local cCorner = Instance.new("UICorner"); cCorner.CornerRadius = UDim.new(0,8); cCorner.Parent = configFrame

    local titleBarConfig = Instance.new("Frame")
    titleBarConfig.Size = UDim2.new(1,0,0,40)
    titleBarConfig.BackgroundColor3 = Color3.fromRGB(20,20,24)
    titleBarConfig.Parent = configFrame

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1,0,1,0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = name .. " Settings"
    titleLabel.TextColor3 = Color3.fromRGB(255,255,255)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.Parent = titleBarConfig

    makeDraggable(configFrame, titleBarConfig)

    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1,-20,1,-55)
    content.Position = UDim2.new(0,10,0,45)
    content.BackgroundTransparency = 1
    content.ScrollBarThickness = 6
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Parent = configFrame

    local uiList = Instance.new("UIListLayout")
    uiList.Padding = UDim.new(0,10)
    uiList.SortOrder = Enum.SortOrder.LayoutOrder
    uiList.Parent = content

    for _, setting in ipairs(moduleData.Config or {}) do
        if setting.Type == "Toggle" then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1,0,0,40)
            btn.BackgroundColor3 = setting.Value and Color3.fromRGB(40,120,60) or Color3.fromRGB(70,70,80)
            btn.Text = "   " .. setting.Name
            btn.TextColor3 = Color3.fromRGB(255,255,255)
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 15
            btn.Parent = content

            local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0,6); corner.Parent = btn

            btn.MouseButton1Click:Connect(function()
                setting.Value = not setting.Value
                btn.BackgroundColor3 = setting.Value and Color3.fromRGB(40,120,60) or Color3.fromRGB(70,70,80)
            end)

        elseif setting.Type == "Slider" then
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1,0,0,65)
            frame.BackgroundTransparency = 1
            frame.Parent = content

            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1,0,0,20)
            label.BackgroundTransparency = 1
            label.Text = setting.Name .. ": " .. setting.Value .. (setting.Suffix or "")
            label.TextColor3 = Color3.fromRGB(220,220,220)
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.Parent = frame

            local bg = Instance.new("Frame")
            bg.Size = UDim2.new(1,0,0,12)
            bg.Position = UDim2.new(0,0,0,32)
            bg.BackgroundColor3 = Color3.fromRGB(45,45,50)
            bg.Parent = frame

            local fill = Instance.new("Frame")
            fill.BackgroundColor3 = Color3.fromRGB(0, 170, 100)
            fill.Parent = bg

            local bCorner = Instance.new("UICorner"); bCorner.CornerRadius = UDim.new(0,6); bCorner.Parent = bg
            bCorner:Clone().Parent = fill

            local function updateFill()
                local percent = (setting.Value - setting.Min) / (setting.Max - setting.Min)
                fill.Size = UDim2.new(percent, 0, 1, 0)
                label.Text = setting.Name .. ": " .. setting.Value .. (setting.Suffix or "")
            end
            updateFill()

            local dragging = false
            bg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = true
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if not dragging then return end
                if input.UserInputType == Enum.UserInputType.MouseMovement then
                    local mouseX = UserInputService:GetMouseLocation().X
                    local bgX = bg.AbsolutePosition.X
                    local bgWidth = bg.AbsoluteSize.X

                    local percent = math.clamp((mouseX - bgX) / bgWidth, 0, 1)
                    setting.Value = math.floor(setting.Min + percent * (setting.Max - setting.Min))
                    updateFill()
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

        elseif setting.Type == "Dropdown" then
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1,0,0,20)
            label.BackgroundTransparency = 1
            label.Text = setting.Name
            label.TextColor3 = Color3.fromRGB(220,220,220)
            label.Font = Enum.Font.Gotham
            label.TextSize = 14
            label.Parent = content

            local dropdownBtn = Instance.new("TextButton")
            dropdownBtn.Size = UDim2.new(1,0,0,35)
            dropdownBtn.BackgroundColor3 = Color3.fromRGB(50,50,55)
            dropdownBtn.Text = setting.Value or setting.Default
            dropdownBtn.TextColor3 = Color3.fromRGB(255,255,255)
            dropdownBtn.Font = Enum.Font.Gotham
            dropdownBtn.TextSize = 14
            dropdownBtn.Parent = content

            local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0,6); corner.Parent = dropdownBtn

            local dropdownList = nil

            dropdownBtn.MouseButton1Click:Connect(function()
                if dropdownList then
                    dropdownList:Destroy()
                    dropdownList = nil
                    return
                end

                dropdownList = Instance.new("ScrollingFrame")
                dropdownList.Size = UDim2.new(1,0,0,300)
                dropdownList.Position = UDim2.new(0,0,0,40)
                dropdownList.BackgroundColor3 = Color3.fromRGB(35,35,40)
                dropdownList.ScrollBarThickness = 6
                dropdownList.AutomaticCanvasSize = Enum.AutomaticSize.Y
                dropdownList.Parent = dropdownBtn.Parent

                local listCorner = Instance.new("UICorner"); listCorner.CornerRadius = UDim.new(0,6); listCorner.Parent = dropdownList

                local listLayout = Instance.new("UIListLayout")
                listLayout.Padding = UDim.new(0,2)
                listLayout.Parent = dropdownList

                for _, opt in ipairs(setting.Options) do
                    local optionBtn = Instance.new("TextButton")
                    optionBtn.Size = UDim2.new(1,0,0,30)
                    optionBtn.BackgroundColor3 = Color3.fromRGB(45,45,50)
                    optionBtn.Text = opt
                    optionBtn.TextColor3 = Color3.fromRGB(255,255,255)
                    optionBtn.Font = Enum.Font.Gotham
                    optionBtn.TextSize = 14
                    optionBtn.Parent = dropdownList

                    local optCorner = Instance.new("UICorner"); optCorner.CornerRadius = UDim.new(0,4); optCorner.Parent = optionBtn

                    optionBtn.MouseButton1Click:Connect(function()
                        setting.Value = opt
                        dropdownBtn.Text = opt
                        if dropdownList then
                            dropdownList:Destroy()
                            dropdownList = nil
                        end
                    end)
                end
            end)
        end
    end

    openConfigWindows[name] = configFrame
end

local function createButtonForModule(moduleData)
    local displayName = moduleData.Name or "Unnamed"

    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1,0,0,42)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = mainContent

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-48,1,0)
    button.BackgroundColor3 = Color3.fromRGB(45,45,52)
    button.Text = displayName
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = buttonFrame

    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0,6); corner.Parent = button

    local settingsBtn = Instance.new("TextButton")
    settingsBtn.Size = UDim2.new(0,40,1,0)
    settingsBtn.Position = UDim2.new(1,-44,0,0)
    settingsBtn.BackgroundColor3 = Color3.fromRGB(55,55,65)
    settingsBtn.Text = "⚙"
    settingsBtn.TextColor3 = Color3.fromRGB(220,220,220)
    settingsBtn.Font = Enum.Font.GothamBold
    settingsBtn.TextSize = 18
    settingsBtn.Parent = buttonFrame

    modules[displayName] = {button = button, moduleData = moduleData, enabled = false}

    button.MouseButton1Click:Connect(function()
        local mod = modules[displayName]
        pcall(mod.moduleData.Run)
        mod.enabled = not mod.enabled
        updateButtonVisual(button, mod.enabled)
    end)

    settingsBtn.MouseButton1Click:Connect(function()
        createConfigWindow(moduleData)
    end)

    updateButtonVisual(button, false)
end

local function refreshModules()
    for _, v in mainContent:GetChildren() do if v:IsA("Frame") then v:Destroy() end end

    local url = string.format("https://api.github.com/repos/%s/%s/contents/%s/%s?ref=%s", REPO_USER, REPO_NAME, GITHUB_FOLDER, currentCategory, REPO_BRANCH)
    local ok, response = pcall(function() return request({Url = url, Method = "GET"}) end)

    if ok and response.Success then
        local files = HttpService:JSONDecode(response.Body)
        for _, file in ipairs(files) do
            if file.type == "file" and file.name:match("%.lua$") then
                local ok2, res = pcall(function() return request({Url = file.download_url, Method = "GET"}) end)
                if ok2 and res.Success then
                    local func = loadstring(res.Body)
                    if func then
                        local s, mod = pcall(func)
                        if s and mod and mod.Run then
                            createButtonForModule(mod)
                        end
                    end
                end
            end
        end
    end
end

reloadButton.MouseButton1Click:Connect(refreshModules)
refreshModules()