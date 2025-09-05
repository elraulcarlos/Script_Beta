--[[ 🧠 Script_Beta v2 — Parte 1 ]]
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "MacStyleUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0.6, 0, 0.5, 0)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Encabezado
local scriptTitle = Instance.new("TextLabel", frame)
scriptTitle.Size = UDim2.new(1, -40, 0, 30)
scriptTitle.Position = UDim2.new(0, 20, 0, 10)
scriptTitle.BackgroundTransparency = 1
scriptTitle.Text = "🧠 Script_Beta v2"
scriptTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
scriptTitle.Font = Enum.Font.GothamBold
scriptTitle.TextSize = 16
scriptTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Botón minimizar
local minimizeBtn = Instance.new("TextButton", frame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -40, 0, 10)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 14
minimizeBtn.Text = "-"
minimizeBtn.BorderSizePixel = 0
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 6)

-- Botón flotante restaurar (movible)
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

-- Sidebar
local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 0)

-- Área de contenido con scroll
local content = Instance.new("ScrollingFrame", frame)
content.Size = UDim2.new(1, -120, 1, 0)
content.Position = UDim2.new(0, 120, 0, 0)
content.BackgroundTransparency = 1
content.CanvasSize = UDim2.new(0, 0, 0, 1000)
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
end

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

    local function createESPToggle(name, yOffset, toggleVar)
        local container = Instance.new("Frame", content)
        container.Size = UDim2.new(0, 300, 0, 40)
        container.Position = UDim2.new(0, 20, 0, yOffset)
        container.BackgroundTransparency = 1

        local label = Instance.new("TextLabel", container)
        label.Size = UDim2.new(0.6, 0, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(255, 255, 255)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 16
        label.TextXAlignment = Enum.TextXAlignment.Left

        local toggle = Instance.new("Frame", container)
        toggle.Size = UDim2.new(0, 60, 0, 24)
        toggle.Position = UDim2.new(1, -70, 0.5, -12)
        toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        toggle.BorderSizePixel = 0
        toggle.Name = "Toggle"
        Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 12)

        local knob = Instance.new("Frame", toggle)
        knob.Size = UDim2.new(0, 20, 0, 20)
        knob.Position = UDim2.new(0, 2, 0, 2)
        knob.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        knob.BorderSizePixel = 0
        Instance.new("UICorner", knob).CornerRadius = UDim.new(0, 10)

        local active = false
        _G[toggleVar] = false

        toggle.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                active = not active
                _G[toggleVar] = active

                local goalPos = active and UDim2.new(0, 38, 0, 2) or UDim2.new(0, 2, 0, 2)
                local goalColor = active and Color3.fromRGB(0, 200, 100) or Color3.fromRGB(60, 60, 60)
                local knobColor = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)

                TweenService:Create(knob, TweenInfo.new(0.2), {Position = goalPos}):Play()
                TweenService:Create(toggle, TweenInfo.new(0.2), {BackgroundColor3 = goalColor}):Play()
                TweenService:Create(knob, TweenInfo.new(0.2), {BackgroundColor3 = knobColor}):Play()
            end
        end)
    end

    -- 🔲 Básico
    createESPToggle("Box ESP", 80, "espBox")
    createESPToggle("Name ESP", 130, "espName")
    createESPToggle("Health ESP", 180, "espHealth")

    -- 📏 Avanzado
    createESPToggle("Distance ESP", 230, "espDistance")
    createESPToggle("Tracer ESP", 280, "espTracer")
    createESPToggle("Skeleton ESP", 330, "espSkeleton")

    -- 🧠 Combinado
    createESPToggle("Nombre + Distancia + Vida", 380, "espCombo")

    -- 🧪 Estético
    createESPToggle("Highlight ESP", 430, "espHighlight")
end

createSidebarButton("Main", 20, showMain)
createSidebarButton("Visual", 70, showVisual)

-- Movimiento por deslizamiento
local dragging = false
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        if input.Position.Y <= frame.AbsolutePosition.Y + 40 or input.Position.Y >= frame.AbsolutePosition.Y + frame.AbsoluteSize.Y - 40 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end
end)

frame.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement) then
        update(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)
