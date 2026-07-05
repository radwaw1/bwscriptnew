-- Fixed guiloader.lua for Madium executor
-- Place this as LocalScript in StarterPlayer > StarterPlayerScripts

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

----------------------------------------------------------------
-- CONFIGURE YOUR REPO HERE
----------------------------------------------------------------
local REPO_USER = "radwaw1"
local REPO_NAME = "bwscriptnew"
local REPO_BRANCH = "main"
local GITHUB_FOLDER = "modules"

----------------------------------------------------------------
-- GUI CONSTRUCTION
----------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModuleHub"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 100
screenGui.Enabled = true
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 420)
mainFrame.Position = UDim2.new(0.5, -140, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 8)
uiCorner.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 36)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = titleBar

local titleFix = Instance.new("Frame")
titleFix.Size = UDim2.new(1, 0, 0, 10)
titleFix.Position = UDim2.new(0, 0, 1, -10)
titleFix.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
titleFix.BorderSizePixel = 0
titleFix.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -100, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Module Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
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
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
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
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Parent = scrollFrame

----------------------------------------------------------------
-- MODULE STORAGE
----------------------------------------------------------------
local modules = {}

----------------------------------------------------------------
-- DRAG FUNCTION (Reusable)
----------------------------------------------------------------
local function makeDraggable(frame, dragBar)
    local dragging = false
    local dragInput = nil
    local dragStart = nil
    local startPos = nil

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    dragBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
end

-- Make main GUI draggable
makeDraggable(mainFrame, titleBar)

----------------------------------------------------------------
-- SELF DESTRUCT
----------------------------------------------------------------
selfDestructBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
    print("Module Hub Self Destructed")
end)

----------------------------------------------------------------
-- CONFIG WINDOW (with dragging)
----------------------------------------------------------------
local function createConfigWindow(moduleData)
    if not moduleData.Config then
        print(moduleData.Name .. " has no settings.")
        return
    end

    local configFrame = Instance.new("Frame")
    configFrame.Size = UDim2.new(0, 260, 0, 340)
    configFrame.Position = UDim2.new(0.5, -130, 0.5, -170)
    configFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    configFrame.BorderSizePixel = 0
    configFrame.Parent = screenGui

    local cCorner = Instance.new("UICorner")
    cCorner.CornerRadius = UDim.new(0, 8)
    cCorner.Parent = configFrame

    local titleBarConfig = Instance.new("Frame")
    titleBarConfig.Size = UDim2.new(1, 0, 0, 36)
    titleBarConfig.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    titleBarConfig.Parent = configFrame

    local titleLabelConfig = Instance.new("TextLabel")
    titleLabelConfig.Size = UDim2.new(1, 0, 1, 0)
    titleLabelConfig.BackgroundTransparency = 1
    titleLabelConfig.Text = moduleData.Name .. " Settings"
    titleLabelConfig.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabelConfig.Font = Enum.Font.GothamBold
    titleLabelConfig.TextSize = 16
    titleLabelConfig.Parent = titleBarConfig

    makeDraggable(configFrame, titleBarConfig)  -- Config window is now draggable

    local y = 50
    for _, setting in ipairs(moduleData.Config) do
        if setting.Type == "Toggle" then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -20, 0, 34)
            btn.Position = UDim2.new(0, 10, 0, y)
            btn.BackgroundColor3 = setting.Value and Color3.fromRGB(40, 120, 60) or Color3.fromRGB(80, 80, 90)
            btn.Text = "  " .. setting.Name
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextXAlignment = Enum.TextXAlignment.Left
            btn.Font = Enum.Font.Gotham
            btn.TextSize = 14
            btn.Parent = configFrame

            btn.MouseButton1Click:Connect(function()
                setting.Value = not setting.Value
                btn.BackgroundColor3 = setting.Value and Color3.fromRGB(40, 120, 60) or Color3.fromRGB(80, 80, 90)
            end)
            y += 44
        end
    end

    task.delay(15, function() if configFrame.Parent then configFrame:Destroy() end end)
end

----------------------------------------------------------------
-- BUTTON CREATION
----------------------------------------------------------------
local function updateButtonVisual(button, enabled)
    button.BackgroundColor3 = enabled and Color3.fromRGB(40, 120, 60) or Color3.fromRGB(120, 40, 40)
end

local function createButtonForModule(moduleData)
    local displayName = moduleData.Name or "Unnamed"

    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, 0, 0, 42)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = scrollFrame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -48, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
    button.Text = displayName
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = buttonFrame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = button

    local settingsBtn = Instance.new("TextButton")
    settingsBtn.Size = UDim2.new(0, 40, 1, 0)
    settingsBtn.Position = UDim2.new(1, -44, 0, 0)
    settingsBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
    settingsBtn.Text = "⚙"
    settingsBtn.TextColor3 = Color3.fromRGB(220, 220, 220)
    settingsBtn.Font = Enum.Font.GothamBold
    settingsBtn.TextSize = 18
    settingsBtn.Parent = buttonFrame

    modules[displayName] = { button = button, moduleData = moduleData, enabled = false }

    button.MouseButton1Click:Connect(function()
        local mod = modules[displayName]
        local success = pcall(mod.moduleData.Run)
        if success then
            mod.enabled = not mod.enabled
            updateButtonVisual(button, mod.enabled)
        end
    end)

    settingsBtn.MouseButton1Click:Connect(function()
        createConfigWindow(modules[displayName].moduleData)
    end)

    updateButtonVisual(button, false)
end

----------------------------------------------------------------
-- MODULE LOADING
----------------------------------------------------------------
local function refreshModules()
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    modules = {}

    statusLabel.Text = "Loading modules..."

    local url = string.format("https://api.github.com/repos/%s/%s/contents/%s?ref=%s", REPO_USER, REPO_NAME, GITHUB_FOLDER, REPO_BRANCH)

    local ok, response = pcall(function() return request({Url = url, Method = "GET"}) end)
    if not ok or not response.Success then
        statusLabel.Text = "Failed to reach GitHub"
        return
    end

    local files = HttpService:JSONDecode(response.Body)
    local count = 0

    for _, file in ipairs(files) do
        if file.type == "file" and file.name:match("%.lua$") and file.download_url then
            local ok2, res = pcall(function() return request({Url = file.download_url, Method = "GET"}) end)
            if ok2 and res.Success then
                local func = loadstring(res.Body)
                if func then
                    local s, mod = pcall(func)
                    if s and mod and mod.Run then
                        createButtonForModule(mod)
                        count += 1
                    end
                end
            end
        end
    end

    statusLabel.Text = count .. " module(s) loaded"
end

reloadButton.MouseButton1Click:Connect(refreshModules)

-- Initial load
refreshModules()