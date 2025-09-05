-- GUI base
local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "ScriptBetaUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

-- Marco principal
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

-- Encabezado
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

-- Minimizar
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

-- Restaurar
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

-- Movimiento desde encabezado
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

-- Sidebar
local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, 120, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 0)

-- Área de contenido
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
    -- [Ya está integrada en tu script actual, no se repite aquí]
end

-- Función: Teleport
local function showTeleport()
    clearContent()

    local label = Instance.new("TextLabel", content)
    label.Size = UDim2.new(1, 0, 0, 40)
    label.Position = UDim2.new(0, 0, 0, 20)
    label.BackgroundTransparency = 1
    label.Text = "Sección: Teleport"
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 20

    local locations = {
        ["Fortaleza"] = Vector3.new(-1200, 80, 450),
        ["Templo del Alba"] = Vector3.new(120, 50, -300),
        ["Torre del Eclipse"] = Vector3.new(-450, 80, 220),
        ["Ruinas del Silencio"] = Vector3.new(30, 40, 600),
        ["Santuario del Viento"] = Vector3.new(-200, 60, -150)
    }

    local yOffset = 80
    for name, pos in pairs(locations) do
        local btn = Instance.new("TextButton", content)
        btn.Size = UDim2.new(1, -40, 0, 30)
        btn.Position = UDim2.new(0, 20, 0, yOffset)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.new(1, 1, 1)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 14
        btn.Text = "📍 " .. name
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        btn.MouseButton1Click:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 5, 0))
            end
        end)

        yOffset += 40
    end
end

-- Función: Visual (ESP toggles)
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
            -- Aquí puedes integrar tu sistema ESP real si lo tienes modular
        end)

        yOffset += 35
    end
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
        ["🏙️ CDMX"] = "https://raw.githubusercontent.com/cdmxhub/scripts/main/main.lua"
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
            loadstring(game:HttpGet(url))()
        end)

        yOffset += 35
    end
end
