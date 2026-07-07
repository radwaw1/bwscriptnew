local function createConfigWindow(moduleData)
    local name = moduleData.Name
    if openConfigWindows[name] then
        openConfigWindows[name]:Destroy()
        openConfigWindows[name] = nil
        return
    end

    local configFrame = Instance.new("Frame")
    configFrame.Size = UDim2.new(0, 300, 0, 500)  -- Bigger default size
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
    content.ScrollBarThickness = 8
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.CanvasSize = UDim2.new(0,0,0,0)
    content.Parent = configFrame

    local uiList = Instance.new("UIListLayout")
    uiList.Padding = UDim.new(0,10)
    uiList.SortOrder = Enum.SortOrder.LayoutOrder
    uiList.Parent = content

    -- Config Options
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
                dropdownList.Size = UDim2.new(1,0,0,300)  -- Bigger dropdown
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