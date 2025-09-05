local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "ScriptBetaUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0.75, 0, 0.75, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local header = Instance.new("Frame", frame)
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
header.BackgroundTransparency = 0.2
header.BorderSizePixel = 0
header.Active = true
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local scriptTitle = Instance.new("TextLabel", header)
scriptTitle.Size = UDim2.new(1, -40, 1, 0)
scriptTitle.Position = UDim2.new(0, 20, 0, 0)
scriptTitle.BackgroundTransparency = 1
scriptTitle.Text = "🧠 Script_Beta v2"
scriptTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
scriptTitle.Font = Enum.Font.GothamBold
scriptTitle.TextSize = 16
scriptTitle.TextXAlignment = Enum.TextXAlignment.Left

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -40, 0.5, -15)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 14
minimizeBtn.Text = "-"
minimizeBtn.BorderSizePixel = 0
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

local restoreBtn = Instance.new("TextButton", gui)
restoreBtn.Size = UDim2.new(0, 140, 0, 40)
restoreBtn.Position = UDim2.new(0.5, -70, 0.5, -20)
restoreBtn.AnchorPoint = Vector2.new(0.5, 0.5)
restoreBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
restoreBtn.TextColor3 = Color3.new(1, 1, 1)
restoreBtn.Font = Enum.Font.GothamBold
restoreBtn.TextSize = 14
restoreBtn.Text = "Abrir Script_Beta"
restoreBtn.BorderSizePixel = 0
restoreBtn.Active = true
restoreBtn.Draggable = true
Instance.new("UICorner", restoreBtn).CornerRadius = UDim.new(0, 8)
restoreBtn.Visible = false

minimizeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    restoreBtn.Visible = true
end)

restoreBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    restoreBtn.Visible = false
end)

local dragging = false
local dragStart, startPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

header.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, 120, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 0)

local content = Instance.new("ScrollingFrame", frame)
content.Size = UDim2.new(1, -120, 1, -40)
content.Position = UDim2.new(0, 120, 0, 40)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.ScrollBarThickness = 6
content.ScrollingDirection = Enum.ScrollingDirection.Y

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        child:Destroy()
    end
end

local function createSidebarButton(name, yOffset, callback)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, yOffset)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 16
    btn.Text = name
    btn.BorderSizePixel = 0
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 70, 70)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
    end)
    btn.MouseButton1Click:Connect(callback)
end

-- Activar secciones
createSidebarButton("Main", 20, showMain)
createSidebarButton("Teleport", 70, showTeleport)
createSidebarButton("Visual", 120, showVisual)
createSidebarButton("Hubs", 170, showHubs)
createSidebarButton("Automatic", 220, showAutomatic)

-- Función: Main (Fly)
local function showMain()
    clearContent()

    local label = Instance.new("TextLabel", content)
    label.Size = UDim2.new(1, 0, 0, 40)
    label.Position = UDim2.new(0, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "Sección: Main"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20

    local flying = false
    local speed = 2
    local direction = Vector3.zero
    local flyBV, flyBG

    local function startFly()
        local HRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not HRP then return end
        flyBV = Instance.new("BodyVelocity", HRP)
        flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        flyBV.Velocity = Vector3.zero
        flyBG = Instance.new("BodyGyro", HRP)
        flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        flyBG.P = 9e4
        flyBG.CFrame = HRP.CFrame
        flying = true
    end

    local function stopFly()
        flying = false
        if flyBV then flyBV:Destroy() end
        if flyBG then flyBG:Destroy() end
    end

    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.W then direction += Vector3.new(0, 0, -1) end
        if input.KeyCode == Enum.KeyCode.S then direction += Vector3.new(0, 0, 1) end
        if input.KeyCode == Enum.KeyCode.A then direction += Vector3.new(-1, 0, 0) end
        if input.KeyCode == Enum.KeyCode.D then direction += Vector3.new(1, 0, 0) end
        if input.KeyCode == Enum.KeyCode.Space then direction += Vector3.new(0, 1, 0) end
        if input.KeyCode == Enum.KeyCode.LeftShift then direction += Vector3.new(0, -1, 0) end
    end)

    UserInputService.InputEnded:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.W then direction -= Vector3.new(0, 0, -1) end
        if input.KeyCode == Enum.KeyCode.S then direction -= Vector3.new(0, 0, 1) end
        if input.KeyCode == Enum.KeyCode.A then direction -= Vector3.new(-1, 0, 0) end
        if input.KeyCode == Enum.KeyCode.D then direction -= Vector3.new(1, 0, 0) end
        if input.KeyCode == Enum.KeyCode.Space then direction -= Vector3.new(0, 1, 0) end
        if input.KeyCode == Enum.KeyCode.LeftShift then direction -= Vector3.new(0, -1, 0) end
    end)

    RunService.RenderStepped:Connect(function()
        if flying and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local HRP = LocalPlayer.Character.HumanoidRootPart
            flyBV.Velocity = (Camera.CFrame:VectorToWorldSpace(direction) * speed)
            flyBG.CFrame = Camera.CFrame
        end
    end)

    local flyToggle = Instance.new("TextButton", content)
    flyToggle.Size = UDim2.new(1, -40, 0, 40)
    flyToggle.Position = UDim2.new(0, 20, 0, 80)
    flyToggle.BackgroundColor3 = Color3.fromRGB(0, 200, 200)
    flyToggle.TextColor3 = Color3.new(0, 0, 0)
    flyToggle.Font = Enum.Font.GothamBold
    flyToggle.TextSize = 16
    flyToggle.Text = "🛫 Activar/Desactivar Fly"
    Instance.new("UICorner", flyToggle).CornerRadius = UDim.new(0, 8)

    flyToggle.MouseButton1Click:Connect(function()
        if flying then
            stopFly()
            flyToggle.Text = "🛫 Activar Fly"
        else
            startFly()
            flyToggle.Text = "🛑 Desactivar Fly"
        end
    end)

    content.CanvasSize = UDim2.new(0, 0, 0, 140)
end

-- Función: Automatic (Fogata)
local function showAutomatic()
    clearContent()

    local label = Instance.new("TextLabel", content)
    label.Size = UDim2.new(1, 0, 0, 40)
    label.Position = UDim2.new(0, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "Sección: Automatic"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20

    local toggleFrame = Instance.new("Frame", content)
    toggleFrame.Size = UDim2.new(0, 60, 0, 24)
    toggleFrame.Position = UDim2.new(0, 20, 0, 80)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggleFrame.BorderSizePixel = 0
    Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 12)

    local knob = Instance.new("Frame", toggleFrame)
    knob.Size = UDim2.new(0, 20, 0, 20)
    knob.Position = UDim2.new(0, 2, 0, 2)
    knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    knob.BorderSizePixel = 0
    Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 10)

    local toggleLabel = Instance.new("TextLabel", content)
    toggleLabel.Size = UDim2.new(0, 200, 0, 24)
    toggleLabel.Position = UDim2.new(0, 90, 0, 80)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = "🔥 Completar fogata"
    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleLabel.Font = Enum.Font.GothamBold
    toggleLabel.TextSize = 16
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local active = false

    toggleFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            active = not active
            local goalPos = active and UDim2.new(0, 38, 0, 2) or UDim2.new(0, 2, 0, 2)
            local goalColor = active and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)
            local knobColor = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)

            TweenService:Create(knob, TweenInfo.new(0.2), {Position = goalPos}):Play()
            TweenService:Create(toggleFrame, TweenInfo.new(0.2), {BackgroundColor3 = goalColor}):Play()
            TweenService:Create(knob, TweenInfo.new(0.2), {BackgroundColor3 = knobColor}):Play()

            if active then
                local fogata = Workspace:FindFirstChild("Campfire")
                if fogata and fogata:FindFirstChild("WoodSlot") then
                    for _, item in ipairs(Workspace:GetDescendants()) do
                        if item:IsA("Tool") and item.Name == "Wood" then
                            item.Parent = fogata.WoodSlot
                        end
                    end
                end
            end
        end
    end)

    content.CanvasSize = UDim2.new(0, 0, 0, 140)
end

-- Función: Visual (ESP toggles + activador real)
local function showVisual()
    clearContent()

    local label = Instance.new("TextLabel", content)
    label.Size = UDim2.new(1, 0, 0, 40)
    label.Position = UDim2.new(0, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "Sección: Visual"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20

    local espOptions = {
        "Box", "Name", "Health", "Distance", "Tracer", "Skeleton", "Highlight"
    }

    local yOffset = 80
    for _, opt in ipairs(espOptions) do
        local toggle = Instance.new("TextButton", content)
        toggle.Size = UDim2.new(1, -40, 0, 30)
        toggle.Position = UDim2.new(0, 20, 0, yOffset)
        toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        toggle.TextColor3 = Color3.new(1, 1, 1)
        toggle.Font = Enum.Font.GothamBold
        toggle.TextSize = 14
        toggle.Text = "👁 " .. opt .. " [OFF]"
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)

        local active = false
        toggle.MouseButton1Click:Connect(function()
            active = not active
            toggle.Text = "👁 " .. opt .. (active and " [ON]" or " [OFF]")
        end)

        yOffset += 35
    end

    local espBtn = Instance.new("TextButton", content)
    espBtn.Size = UDim2.new(1, -40, 0, 40)
    espBtn.Position = UDim2.new(0, 20, 0, yOffset + 10)
    espBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    espBtn.TextColor3 = Color3.new(1, 1, 1)
    espBtn.Font = Enum.Font.GothamBold
    espBtn.TextSize = 16
    espBtn.Text = "⚡ Activar ESP real"
    Instance.new("UICorner", espBtn).CornerRadius = UDim.new(0, 8)

    espBtn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/zlc1004/robloxScript/main/esp.lua"))()
    end)

    content.CanvasSize = UDim2.new(0, 0, 0, yOffset + 80)
end

-- Función: Hubs (ejecución directa)
local function showHubs()
    clearContent()

    local label = Instance.new("TextLabel", content)
    label.Size = UDim2.new(1, 0, 0, 40)
    label.Position = UDim2.new(0, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "Sección: Hubs"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20

    local hubs = {
        ["🧠 Infinite Yield"] = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
        ["🧬 Vega X"] = "https://raw.githubusercontent.com/VegaxHub/VegaX/main/Main.lua",
        ["🛰️ Orion"] = "https://raw.githubusercontent.com/OrionHub/Main/main.lua",
        ["🏙️ CDMX"] = "https://raw.githubusercontent.com/cdmxhub/scripts/main/main.lua",
        ["🌌 HoHo Hub"] = "https://raw.githubusercontent.com/HoHoHub/Script/main/HoHoHub.lua",
        ["🌑 Darkrai X"] = "https://raw.githubusercontent.com/RandomScripter/DarkraiX/main/Main.lua",
        ["⚡ Xenon Hub"] = "https://raw.githubusercontent.com/XenonHubProject/Main/main.lua",
        ["👁️ ESP Universal"] = "https://raw.githubusercontent.com/zlc1004/robloxScript/main/esp.lua"
    }

    local yOffset = 80
    for name, url in pairs(hubs) do
        local btn = Instance.new("TextButton", content)
        btn.Size = UDim2.new(1, -40, 0, 30)
        btn.Position = UDim2.new(0, 20, 0, yOffset)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.Text = name
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        btn.MouseButton1Click:Connect(function()
            local success, err = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if not success then
                warn("Error al ejecutar " .. name .. ": " .. tostring(err))
            end
        end)

        yOffset += 35
    end

    content.CanvasSize = UDim2.new(0, 0, 0, yOffset + 60)
end
