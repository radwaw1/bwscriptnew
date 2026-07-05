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
local GITHUB_FOLDER = "modules"   -- change if needed

----------------------------------------------------------------
-- GUI CONSTRUCTION (unchanged)
----------------------------------------------------------------
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModuleHub"
screenGui.ResetOnSpawn = false
screenGui.DisplayOrder = 100
screenGui.Enabled = false
screenGui.Parent = playerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 260, 0, 380)
mainFrame.Position = UDim2.new(0.5, -130, 0.5, -190)
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
titleLabel.Size = UDim2.new(1, -80, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Module Hub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 16
titleLabel.Parent = titleBar

local reloadButton = Instance.new("TextButton")
reloadButton.Name = "ReloadButton"
reloadButton.Size = UDim2.new(0, 60, 0, 24)
reloadButton.Position = UDim2.new(1, -68, 0.5, -12)
reloadButton.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
reloadButton.Text = "Reload"
reloadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
reloadButton.Font = Enum.Font.Gotham
reloadButton.TextSize = 12
reloadButton.Parent = titleBar

local reloadCorner = Instance.new("UICorner")
reloadCorner.CornerRadius = UDim.new(0, 6)
reloadCorner.Parent = reloadButton

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
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
scrollFrame.Name = "ModuleList"
scrollFrame.Size = UDim2.new(1, -16, 1, -68)
scrollFrame.Position = UDim2.new(0, 8, 0, 60)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
scrollFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 6)
listLayout.SortOrder = Enum.SortOrder.Name
listLayout.Parent = scrollFrame

----------------------------------------------------------------
-- DRAGGING + TOGGLE
----------------------------------------------------------------
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = mainFrame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		mainFrame.Position = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.RightShift then
		screenGui.Enabled = not screenGui.Enabled
	end
end)

----------------------------------------------------------------
-- FIXED LOADING USING request()
----------------------------------------------------------------
local function clearModuleList()
	for _, child in ipairs(scrollFrame:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
end

local function createButtonForModule(displayName, runFunction)
	local button = Instance.new("TextButton")
	button.Name = displayName
	button.Size = UDim2.new(1, 0, 0, 36)
	button.BackgroundColor3 = Color3.fromRGB(45, 45, 52)
	button.Text = displayName
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.Font = Enum.Font.Gotham
	button.TextSize = 14
	button.AutoButtonColor = true
	button.Parent = scrollFrame

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 6)
	btnCorner.Parent = button

	button.MouseButton1Click:Connect(function()
		local success, err = pcall(runFunction)
		if not success then
			warn("[ModuleHub] Error running '" .. displayName .. "': " .. tostring(err))
		end
	end)
end

local function loadModuleFromUrl(downloadUrl, fallbackName)
	local ok, response = pcall(function()
		return request({
			Url = downloadUrl,
			Method = "GET"
		})
	end)
	
	if not ok or not response.Success then
		warn("[ModuleHub] Failed to fetch " .. downloadUrl)
		return
	end

	local source = response.Body
	local compiled, compileErr = loadstring(source)
	if not compiled then
		warn("[ModuleHub] Failed to compile " .. fallbackName .. ": " .. tostring(compileErr))
		return
	end

	local success, moduleData = pcall(compiled)
	if not success or type(moduleData) ~= "table" or type(moduleData.Run) ~= "function" then
		warn("[ModuleHub] '" .. fallbackName .. "' did not return a valid { Name, Run } table")
		return
	end

	createButtonForModule(moduleData.Name or fallbackName, moduleData.Run)
end

local function refreshModules()
	clearModuleList()
	statusLabel.Text = "Loading modules..."

	-- Use raw GitHub for folder listing instead of API
	local contentsUrl = string.format(
		"https://api.github.com/repos/%s/%s/contents/%s?ref=%s",
		REPO_USER, REPO_NAME, GITHUB_FOLDER, REPO_BRANCH
	)

	local ok, response = pcall(function()
		return request({ Url = contentsUrl, Method = "GET" })
	end)

	if not ok or not response.Success then
		statusLabel.Text = "Failed to reach GitHub"
		warn("[ModuleHub] Request failed: " .. tostring(response))
		return
	end

	local success, files = pcall(function()
		return HttpService:JSONDecode(response.Body)
	end)

	if not success or type(files) ~= "table" then
		statusLabel.Text = "Bad response from GitHub"
		return
	end

	local loadedCount = 0
	for _, fileInfo in ipairs(files) do
		if fileInfo.type == "file" and fileInfo.name:match("%.lua$") and fileInfo.download_url then
			loadModuleFromUrl(fileInfo.download_url, fileInfo.name)
			loadedCount += 1
		end
	end

	statusLabel.Text = loadedCount .. " module(s) loaded"
end

reloadButton.MouseButton1Click:Connect(refreshModules)

-- Initial load
refreshModules()