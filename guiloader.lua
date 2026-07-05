-- ModuleHub with Fixed Dragging + Keybinds
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
screenGui.Name = "ModuleHub"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 100
screenGui.Enabled = true
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 280, 0, 420)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Module Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.Parent = titleBar

local selfDestructBtn = Instance.new("TextButton")
selfDestructBtn.Size = UDim2.new(0, 85, 0, 24)
selfDestructBtn.Position = UDim2.new(1, -92, 0.5, -12)
selfDestructBtn.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
selfDestructBtn.Text = "Self Destruct"
selfDestructBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
selfDestructBtn.Font = Enum.Font.Gotham
selfDestructBtn.TextSize = 11
selfDestructBtn.Parent = titleBar

local reloadButton = Instance.new("TextButton")
reloadButton.Size = UDim2.new(0, 60, 0, 24)
reloadButton.Position = UDim2.new(1, -155, 0.5, -12)
reloadButton.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
reloadButton.Text = "Reload"
reloadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
reloadButton.Font = Enum.Font.Gotham
reloadButton.TextSize = 12
reloadButton.Parent = titleBar

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -16, 0, 18)
statusLabel.Position = UDim2.new(0, 8, 0, 40)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "Loading modules..."
statusLabel.TextColor3 = Color3.fromRGB(160, 160, 165)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 12
statusLabel.Parent = mainFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -16, 1, -68)
scrollFrame.Position = UDim2.new(0, 8, 0, 60)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 4
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.Parent = scrollFrame

local modules = {}
local openConfigWindows = {}
local keybinds = {}

-- FIXED DRAGGING
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

selfDestructBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Keybind System
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    for name, mod in pairs(modules) do
        if keybinds[name] and input.KeyCode == keybinds[name] then
            local success = pcall(mod.moduleData.Run)
            if success then
                mod.enabled = not mod.enabled
                mod.button.BackgroundColor3 = mod.enabled and Color3.fromRGB(40,120,60) or Color3.fromRGB(120,40,40)
            end
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
    configFrame.Size = UDim2.new(0, 280, 0, 400)
    configFrame.Position = UDim2.new(0.5, -140, 0.5, -200)
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

    -- Keybind
    local keybindLabel = Instance.new("TextLabel")
    keybindLabel.Size = UDim2.new(1,-20,0,30)
    keybindLabel.Position = UDim2.new(0,10,0,50)
    keybindLabel.BackgroundTransparency = 1
    keybindLabel.Text = "Keybind: None"
    keybindLabel.TextColor3 = Color3.fromRGB(200,200,200)
    keybindLabel.Font = Enum.Font.Gotham
    keybindLabel.TextSize = 14
    keybindLabel.Parent = configFrame

    local keybindBtn = Instance.new("TextButton")
    keybindBtn.Size = UDim2.new(1,-20,0,30)
    keybindBtn.Position = UDim2.new(0,10,0,85)
    keybindBtn.BackgroundColor3 = Color3.fromRGB(50,50,55)
    keybindBtn.Text = "Click to set keybind"
    keybindBtn.TextColor3 = Color3.fromRGB(255,255,255)
    keybindBtn.Font = Enum.Font.Gotham
    keybindBtn.TextSize = 14
    keybindBtn.Parent = configFrame

    keybindBtn.MouseButton1Click:Connect(function()
        keybindBtn.Text = "Press any key..."
        local conn
        conn = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                keybinds[name] = input.KeyCode
                keybindBtn.Text = "Key: " .. input.KeyCode.Name
                keybindLabel.Text = "Keybind: " .. input.KeyCode.Name
                conn:Disconnect()
            end
        end)
    end)

    openConfigWindows[name] = configFrame
end

local function createButtonForModule(moduleData)
    local displayName = moduleData.Name or "Unnamed"

    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1,0,0,42)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = scrollFrame

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
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    modules = {}

    statusLabel.Text = "Loading modules..."

    local url = string.format("https://api.github.com/repos/%s/%s/contents/%s?ref=%s", REPO_USER, REPO_NAME, GITHUB_FOLDER, REPO_BRANCH)

    local ok, response = pcall(function() return request({Url = url, Method = "GET"}) end)

    if ok and response.Success then
        local files = HttpService:JSONDecode(response.Body)
        for _, file in ipairs(files) do
            if file.type == "file" and file.name:match("%.lua$") then
                local ok2, res = pcall(function() return request({Url = file.download_url, Method = "GET"}) end)
                if ok2 and res.Success then
                    local func = loadstring(res.Body)
                    if func then
                        local success, mod = pcall(func)
                        if success and mod and mod.Run then
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