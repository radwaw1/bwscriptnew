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
selfDestructBtn.Name = "SelfDestruct"
selfDestructBtn.Size = UDim2.new(0, 85, 0, 24)
selfDestructBtn.Position = UDim2.new(1, -92, 0.5, -12)
selfDestructBtn.BackgroundColor3 = Color3.fromRGB(170, 30, 30)
selfDestructBtn.Text = "Self Destruct"
selfDestructBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
selfDestructBtn.Font = Enum.Font.Gotham
selfDestructBtn.TextSize = 11
selfDestructBtn.Parent = titleBar

local sdCorner = Instance.new("UICorner")
sdCorner.CornerRadius = UDim.new(0, 6)
sdCorner.Parent = selfDestructBtn

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
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Parent = scrollFrame

----------------------------------------------------------------
-- MODULE STORAGE
----------------------------------------------------------------
local modules = {}  -- [moduleName] = {button, moduleData, enabled = false}

----------------------------------------------------------------
-- DRAGGING
----------------------------------------------------------------
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then dragging = false end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

----------------------------------------------------------------
-- SELF DESTRUCT
----------------------------------------------------------------
selfDestructBtn.MouseButton1Click:Connect(function()
    if not screenGui then return end
    screenGui:Destroy()
    print("Module Hub Self Destructed")
end)

----------------------------------------------------------------
-- BUTTON CREATION
----------------------------------------------------------------
local function updateButtonVisual(button, enabled)
    if enabled then
        button.BackgroundColor3 = Color3.fromRGB(40, 120, 60)   -- Green
    else
        button.BackgroundColor3 = Color3.fromRGB(120, 40, 40)   -- Red
    end
end

local function createButtonForModule(displayName, moduleData)
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, 0, 0, 42)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = scrollFrame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -45, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
    button.Text = displayName
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = buttonFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button

    -- Settings Button
    local settingsBtn = Instance.new("TextButton")
    settingsBtn.Size = UDim2.new(0, 36, 1, 0)
    settingsBtn.Position = UDim2.new(1, -40, 0, 0)
    settingsBtn.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
    settingsBtn.Text = "⚙"
    settingsBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    settingsBtn.Font = Enum.Font.GothamBold
    settingsBtn.TextSize = 16
    settingsBtn.Parent = buttonFrame

    local sCorner = Instance.new("UICorner")
    sCorner.CornerRadius = UDim.new(0, 6)
    sCorner.Parent = settingsBtn

    -- Store module
    modules[displayName] = {
        button = button,
        moduleData = moduleData,
        enabled = false
    }

    -- Toggle Button
    button.MouseButton1Click:Connect(function()
        local mod = modules[displayName]
        if not mod then return end

        local success, err = pcall(mod.moduleData.Run)
        if success then
            mod.enabled = not mod.enabled
            updateButtonVisual(button, mod.enabled)
        else
            warn("[ModuleHub] Error toggling " .. displayName .. ": " .. tostring(err))
        end
    end)

    -- Settings (for future config)
    settingsBtn.MouseButton1Click:Connect(function()
        -- TODO: Expand later with real config UI per module
        print("Settings clicked for: " .. displayName .. " (Config coming soon)")
    end)

    updateButtonVisual(button, false)
end

----------------------------------------------------------------
-- LOADING MODULES
----------------------------------------------------------------
local function clearModuleList()
    for _, child in ipairs(scrollFrame:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end
    modules = {}
end

local function loadModuleFromUrl(downloadUrl, fallbackName)
    local ok, response = pcall(function()
        return request({ Url = downloadUrl, Method = "GET" })
    end)
    
    if not ok or not response.Success then return end

    local source = response.Body
    local compiled = loadstring(source)
    if not compiled then return end

    local success, moduleData = pcall(compiled)
    if not success or type(moduleData) ~= "table" or type(moduleData.Run) ~= "function" then
        return
    end

    createButtonForModule(moduleData.Name or fallbackName, moduleData)
end

local function refreshModules()
    clearModuleList()
    statusLabel.Text = "Loading modules..."

    local contentsUrl = string.format(
        "https://api.github.com/repos/%s/%s/contents/%s?ref=%s",
        REPO_USER, REPO_NAME, GITHUB_FOLDER, REPO_BRANCH
    )

    local ok, response = pcall(function()
        return request({ Url = contentsUrl, Method = "GET" })
    end)

    if not ok or not response.Success then
        statusLabel.Text = "Failed to reach GitHub"
        return
    end

    local success, files = pcall(function()
        return HttpService:JSONDecode(response.Body)
    end)

    if not success then return end

    local loadedCount = 0
    for _, fileInfo in ipairs(files) do
        if fileInfo.type == "file" and fileInfo.name:match("%.lua$") and fileInfo.download_url then
            loadModuleFromUrl(fileInfo.download_url, fileInfo.name)
            loadedCount += 1
        end
    end

    statusLabel.Text = loadedCount .. " module(s) loaded"
end

reloadButton = Instance.new("TextButton") -- Re-add reload button
-- (You can copy the old reload button code here if you want it back)

reloadButton.MouseButton1Click:Connect(refreshModules)

-- Initial load
refreshModules()