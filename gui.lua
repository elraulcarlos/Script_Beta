--[[
🧠 Script_Beta v1
Interfaz estilo macOS con menú vertical, ESPs, minimizador y restaurador
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local gui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "MacStyleUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 500, 0, 320)
frame.Position = UDim2.new(0.5, -250, 0.5, -160)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.2
frame.BorderSizePixel = 0
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.Active = true
frame.Draggable = false
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Encabezado Script_Beta v1
local scriptTitle = Instance.new("TextLabel", frame)
scriptTitle.Size = UDim2.new(1, -40, 0, 30)
scriptTitle.Position = UDim2.new(0, 20, 0, 10)
scriptTitle.BackgroundTransparency = 1
scriptTitle.Text = "🧠 Script_Beta v1"
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

-- Botón flotante para restaurar
local restoreBtn = Instance.new("TextButton", gui)
restoreBtn.Size = UDim2.new(0, 140, 0, 40)
restoreBtn.Position = UDim2.new(0, 20, 1, -60)
restoreBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
restoreBtn.TextColor3 = Color3.new(1, 1, 1)
restoreBtn.Font = Enum.Font.GothamBold
restoreBtn.TextSize = 14
restoreBtn.Text = "Abrir Script_Beta"
restoreBtn.BorderSizePixel = 0
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

-- Sidebar vertical
local sidebar = Instance.new("Frame", frame)
sidebar.Size = UDim2.new(0, 120, 1, 0)
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
sidebar.BorderSizePixel = 0
Instance.new("UICorner", sidebar).CornerRadius = UDim.new(0, 0)

-- Área de contenido
local content = Instance.new("Frame", frame)
content.Size = UDim2.new(1, -120, 1, 0)
content.Position = UDim2.new(0, 120, 0, 0)
content.BackgroundTransparency = 1

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

    local function createESPButton(text, yOffset, toggleVar)
        local btn = Instance.new("TextButton", content)
        btn.Size = UDim2.new(0, 300, 0, 40)
        btn.Position = UDim2.new(0, 20, 0, yOffset)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.Text = text
        btn.BorderSizePixel = 0
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        btn.MouseButton1Click:Connect(function()
            _G[toggleVar] = not _G[toggleVar]
            btn.Text = _G[toggleVar] and "Desactivar " .. text or text
            btn.BackgroundColor3 = _G[toggleVar] and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(50, 50, 50)
        end)
    end

    createESPButton("ESP Universal", 80, "espUniversal")
    createESPButton("ESP Minimal", 130, "espMinimal")
    createESPButton("ESP Modular", 180, "espModular")
end

createSidebarButton("Main", 20, showMain)
createSidebarButton("Visual", 70, showVisual)

-- Movimiento por deslizamiento desde arriba o abajo
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
[43dcd9a7-70db-4a1f-b0ae-981daa162054](https://github.com/cjdjmj/aaa42/tree/43ef68a79bec18dc8f122bba912145517cfbb80f/README.md?citationMarker=43dcd9a7-70db-4a1f-b0ae-981daa162054 "1")
 
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
