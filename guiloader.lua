-- ModuleHub with Config Support
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

local uiCorner = Instance.new("UICorner"); uiCorner.CornerRadius = UDim.new(0,8); uiCorner.Parent = mainFrame

-- Title Bar + Self Destruct
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1,0,0,36)
titleBar.BackgroundColor3 = Color3.fromRGB(20,20,24)
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1,-100,1,0)
titleLabel.Position = UDim2.new(0,12,0,0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "my shitty script"
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

selfDestructBtn.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1,-16,1,-68)
scrollFrame.Position = UDim2.new(0,8,0,60)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 4
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0,6)
listLayout.Parent = scrollFrame

local modules = {}

local function updateButtonColor(button, enabled)
    button.BackgroundColor3 = enabled and Color3.fromRGB(40,120,60) or Color3.fromRGB(120,40,40)
end

local function createConfigWindow(moduleData)
    -- Simple config window (can be expanded)
    local configFrame = Instance.new("Frame")
    configFrame.Size = UDim2.new(0, 260, 0, 300)
    configFrame.Position = UDim2.new(0.5, -130, 0.5, -150)
    configFrame.BackgroundColor3 = Color3.fromRGB(25,25,30)
    configFrame.Parent = screenGui

    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0,8); corner.Parent = configFrame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,30)
    title.Text = moduleData.Name .. " Settings"
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 16
    title.Parent = configFrame

    local y = 40
    for _, setting in ipairs(moduleData.Config or {}) do
        if setting.Type == "Toggle" then
            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Size = UDim2.new(1,-20,0,30)
            toggleBtn.Position = UDim2.new(0,10,0,y)
            toggleBtn.BackgroundColor3 = setting.Value and Color3.fromRGB(40,120,60) or Color3.fromRGB(80,80,90)
            toggleBtn.Text = setting.Name
            toggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
            toggleBtn.Parent = configFrame

            toggleBtn.MouseButton1Click:Connect(function()
                setting.Value = not setting.Value
                toggleBtn.BackgroundColor3 = setting.Value and Color3.fromRGB(40,120,60) or Color3.fromRGB(80,80,90)
            end)
            y += 40

        elseif setting.Type == "Slider" then
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1,-20,0,20)
            label.Position = UDim2.new(0,10,0,y)
            label.BackgroundTransparency = 1
            label.Text = setting.Name .. ": " .. setting.Value .. (setting.Suffix or "")
            label.TextColor3 = Color3.fromRGB(200,200,200)
            label.Parent = configFrame

            local slider = Instance.new("TextButton")
            slider.Size = UDim2.new(1,-20,0,8)
            slider.Position = UDim2.new(0,10,0,y+22)
            slider.BackgroundColor3 = Color3.fromRGB(60,60,70)
            slider.Parent = configFrame

            -- Simple slider logic (basic version)
            setting.Value = setting.Default or setting.Min
            y += 50
        end
    end

    task.delay(8, function() if configFrame then configFrame:Destroy() end end)
end

local function createButtonForModule(moduleData)
    local displayName = moduleData.Name

    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1,0,0,42)
    buttonFrame.BackgroundTransparency = 1
    buttonFrame.Parent = scrollFrame

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1,-50,1,0)
    button.BackgroundColor3 = Color3.fromRGB(45,45,52)
    button.Text = displayName
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.Font = Enum.Font.Gotham
    button.TextSize = 14
    button.Parent = buttonFrame

    local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0,6); corner.Parent = button

    local settingsBtn = Instance.new("TextButton")
    settingsBtn.Size = UDim2.new(0,40,1,0)
    settingsBtn.Position = UDim2.new(1,-45,0,0)
    settingsBtn.BackgroundColor3 = Color3.fromRGB(55,55,65)
    settingsBtn.Text = "⚙"
    settingsBtn.TextColor3 = Color3.fromRGB(220,220,220)
    settingsBtn.Font = Enum.Font.GothamBold
    settingsBtn.TextSize = 18
    settingsBtn.Parent = buttonFrame

    modules[displayName] = { button = button, moduleData = moduleData, enabled = false }

    button.MouseButton1Click:Connect(function()
        local mod = modules[displayName]
        pcall(mod.moduleData.Run)
        mod.enabled = not mod.enabled
        updateButtonColor(button, mod.enabled)
    end)

    settingsBtn.MouseButton1Click:Connect(function()
        createConfigWindow(moduleData)
    end)

    updateButtonColor(button, false)
end

-- Loading logic (same as before, just updated)
local function refreshModules()
    for _, v in scrollFrame:GetChildren() do if v:IsA("Frame") then v:Destroy() end end
    modules = {}

    -- ... (your existing GitHub loading code)
    local contentsUrl = string.format("https://api.github.com/repos/%s/%s/contents/%s?ref=%s", REPO_USER, REPO_NAME, GITHUB_FOLDER, REPO_BRANCH)
    
    local ok, response = pcall(function() return request({Url = contentsUrl, Method = "GET"}) end)
    if not ok or not response.Success then return end

    local files = HttpService:JSONDecode(response.Body)

    for _, file in files do
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

refreshModules()