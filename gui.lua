local playerGui = script.Parent

-- === PASSWORD SCREEN GUI (only password overlay at startup) ===
local passwordScreenGui = Instance.new("ScreenGui")
passwordScreenGui.Name = "PasswordScreenGui"
passwordScreenGui.ResetOnSpawn = false
passwordScreenGui.Parent = playerGui

local passwordOverlay = Instance.new("Frame")
passwordOverlay.Name = "PasswordOverlay"
passwordOverlay.Size = UDim2.new(1, 0, 1, 0)
passwordOverlay.Position = UDim2.new(0, 0, 0, 0)
passwordOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
passwordOverlay.BackgroundTransparency = 0.5
passwordOverlay.ZIndex = 100
passwordOverlay.Parent = passwordScreenGui
passwordOverlay.Active = true

local overlayCorner = Instance.new("UICorner")
overlayCorner.CornerRadius = UDim.new(0, 24)
overlayCorner.Parent = passwordOverlay

local overlayFrame = Instance.new("Frame")
overlayFrame.Name = "OverlayFrame"
overlayFrame.Size = UDim2.new(0, 320, 0, 180)
overlayFrame.AnchorPoint = Vector2.new(0.5, 0.5)
overlayFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
overlayFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
overlayFrame.BackgroundTransparency = 0.1
overlayFrame.ZIndex = 101
overlayFrame.Parent = passwordOverlay

local overlayFrameCorner = Instance.new("UICorner")
overlayFrameCorner.CornerRadius = UDim.new(0, 24)
overlayFrameCorner.Parent = overlayFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "PasswordTitle"
titleLabel.Text = "Introduce la contraseña"
titleLabel.Font = Enum.Font.SourceSansSemibold
titleLabel.TextSize = 22
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(1, 0, 0, 40)
titleLabel.Position = UDim2.new(0, 0, 0, 12)
titleLabel.ZIndex = 102
titleLabel.Parent = overlayFrame

local passwordBox = Instance.new("TextBox")
passwordBox.Name = "PasswordBox"
passwordBox.PlaceholderText = "Contraseña"
passwordBox.Text = ""
passwordBox.Font = Enum.Font.SourceSans
passwordBox.TextSize = 20
passwordBox.TextColor3 = Color3.fromRGB(0, 0, 0)
passwordBox.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
passwordBox.BackgroundTransparency = 0.1
passwordBox.Size = UDim2.new(0.8, 0, 0, 38)
passwordBox.Position = UDim2.new(0.1, 0, 0, 62)
passwordBox.ZIndex = 103
passwordBox.Parent = overlayFrame

local passwordBoxCorner = Instance.new("UICorner")
passwordBoxCorner.CornerRadius = UDim.new(0, 12)
passwordBoxCorner.Parent = passwordBox

local continuarButton = Instance.new("TextButton")
continuarButton.Name = "ContinuarButton"
continuarButton.Text = "Continuar"
continuarButton.Font = Enum.Font.SourceSansSemibold
continuarButton.TextSize = 18
continuarButton.TextColor3 = Color3.fromRGB(255, 255, 255)
continuarButton.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
continuarButton.BackgroundTransparency = 0.1
continuarButton.Size = UDim2.new(0.8, 0, 0, 38)
continuarButton.Position = UDim2.new(0.1, 0, 0, 110)
continuarButton.ZIndex = 104
continuarButton.Parent = overlayFrame

local continuarButtonCorner = Instance.new("UICorner")
continuarButtonCorner.CornerRadius = UDim.new(0, 12)
continuarButtonCorner.Parent = continuarButton

local errorLabel = Instance.new("TextLabel")
errorLabel.Name = "ErrorLabel"
errorLabel.Text = ""
errorLabel.Font = Enum.Font.SourceSans
errorLabel.TextSize = 16
errorLabel.TextColor3 = Color3.fromRGB(220, 40, 40)
errorLabel.BackgroundTransparency = 1
errorLabel.Size = UDim2.new(1, 0, 0, 22)
errorLabel.Position = UDim2.new(0, 0, 0, 154)
errorLabel.ZIndex = 105
errorLabel.Parent = overlayFrame

-- === MAIN GUI (hidden at startup) ===
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "IOSStyleGUI"
screenGui.ResetOnSpawn = false
screenGui.Enabled = false -- Hidden at startup
screenGui.Parent = playerGui

-- === NOTIFICATION LABEL ===
local notificationLabel = Instance.new("TextLabel")
notificationLabel.Name = "NotificationLabel"
notificationLabel.Text = ""
notificationLabel.Font = Enum.Font.SourceSansSemibold
notificationLabel.TextSize = 20
notificationLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
notificationLabel.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
notificationLabel.BackgroundTransparency = 0.1
notificationLabel.Size = UDim2.new(0.6, 0, 0, 38)
notificationLabel.AnchorPoint = Vector2.new(0.5, 0)
notificationLabel.Position = UDim2.new(0.5, 0, 0.02, 0)
notificationLabel.ZIndex = 100
notificationLabel.Visible = false

local notificationCorner = Instance.new("UICorner")
notificationCorner.CornerRadius = UDim.new(0, 12)
notificationCorner.Parent = notificationLabel

-- Password logic
local PASSWORD = "2025"
local unlocked = false

local function showNotification(text)
    notificationLabel.Text = text
    notificationLabel.Visible = true
    task.spawn(function()
        task.wait(3) -- Show notification for 3 seconds
        notificationLabel.Visible = false
    end)
end

local function tryUnlock()
    if passwordBox.Text == PASSWORD then
        unlocked = true
        passwordScreenGui.Enabled = false -- Hide password overlay
        passwordScreenGui.Parent = nil -- Remove password overlay from PlayerGui
        screenGui.Enabled = true -- Show main GUI
        showNotification("¡Contraseña correcta!")
    else
        errorLabel.Text = "Contraseña incorrecta"
        passwordBox.Text = ""
    end
end

continuarButton.MouseButton1Click:Connect(tryUnlock)
passwordBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        tryUnlock()
    end
end)

-- === CONFIGURABLE IMAGE ASSET IDS ===
local customImageId = "rbxassetid://1234567890" -- Cambia este ID por el de tu imagen (mainFrame image)
local openButtonImageId = "rbxassetid://7072728341" -- Cambia este ID por el de tu imagen personalizada para el botón de abrir

-- Main iOS-style frame (responsive)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0.8, 0, 0.8, 0) -- 80% of screen width/height
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0) -- Black color
mainFrame.BorderSizePixel = 0
mainFrame.BackgroundTransparency = 0.4 -- Semi-transparent
mainFrame.ClipsDescendants = true
mainFrame.ZIndex = 1
mainFrame.Active = true -- Ensure mainFrame is Active for input events
mainFrame.Parent = screenGui

-- Attach notification label to mainFrame
notificationLabel.Parent = mainFrame

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 24)
corner.Parent = mainFrame

-- Drop shadow
local shadow = Instance.new("ImageLabel")
shadow.Name = "Shadow"
shadow.Image = "rbxassetid://1316045217"
shadow.Size = UDim2.new(1, 0, 1, 0)
shadow.Position = UDim2.new(0, 0, 0, 0)
shadow.BackgroundTransparency = 1
shadow.ImageTransparency = 0.7
shadow.Parent = mainFrame
shadow.ZIndex = 0

-- === VERTICAL SIDEBAR ===
local sidebar = Instance.new("Frame")
sidebar.Name = "Sidebar"
sidebar.Size = UDim2.new(0.18, 0, 1, 0) -- 18% width, full height of mainFrame
sidebar.Position = UDim2.new(0, 0, 0, 0)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sidebar.BackgroundTransparency = 0.3
sidebar.BorderSizePixel = 0
sidebar.ZIndex = 5
sidebar.Parent = mainFrame
sidebar.Active = true

local sidebarCorner = Instance.new("UICorner")
sidebarCorner.CornerRadius = UDim.new(0, 20)
sidebarCorner.Parent = sidebar

-- Sidebar buttons list (updated names and emoji)
local sidebarButtons = {
    {Name = "Automatic", Text = "Automatic"},
    {Name = "Main", Text = "Main"},
    {Name = "Visual", Text = "Visual"},
    {Name = "Teleport", Text = "Teleport"},
    {Name = "Hubs", Text = "Hubs"},
    {Name = "Configuracion", Text = "⚙️"}, -- Gear emoji for configuration
}

local buttonHeight = 0.09 -- 9% height per button
local buttonSpacing = 0.01 -- 1% spacing

local UserInputService = game:GetService("UserInputService")
local function isMobile()
    return UserInputService.TouchEnabled
end

-- Responsive sidebar and button layout
local function layoutSidebar()
    if isMobile() then
        sidebar.Size = UDim2.new(0.28, 0, 1, 0) -- Wider sidebar for mobile
        buttonHeight = 0.12
        buttonSpacing = 0.018
    else
        sidebar.Size = UDim2.new(0.18, 0, 1, 0)
        buttonHeight = 0.09
        buttonSpacing = 0.01
    end
end
layoutSidebar()

-- Store sidebar buttons for later reference
local sidebarButtonInstances = {}

for i, btnInfo in sidebarButtons do
    local btn = Instance.new("TextButton")
    btn.Name = btnInfo.Name .. "Button"
    btn.Text = btnInfo.Text
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = isMobile() and 20 or 18
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BackgroundTransparency = 0.2
    btn.Size = UDim2.new(0.85, 0, buttonHeight, 0)
    btn.Position = UDim2.new(0.075, 0, (i-1)*(buttonHeight+buttonSpacing)+0.04, 0)
    btn.ZIndex = 6
    btn.Parent = sidebar
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 14)
    btnCorner.Parent = btn
    sidebarButtonInstances[btnInfo.Name] = btn
end

-- === HUBS SCROLLING LIST ===
local hubNames = {
    "Infinite Yield",
    "CMD-X",
    "Fate's Admin",
    "Reviz Admin",
    "Hydra Hub",
    "DarkHub",
    "OwlHub",
    "SwagMode"
}

local hubsFrame = Instance.new("ScrollingFrame")
hubsFrame.Name = "HubsFrame"
hubsFrame.Size = UDim2.new(0.75, 0, 0.8, 0)
hubsFrame.Position = UDim2.new(0.22, 0, 0.12, 0)
hubsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
hubsFrame.BackgroundTransparency = 0.2
hubsFrame.BorderSizePixel = 0
hubsFrame.ZIndex = 20
hubsFrame.Visible = false
hubsFrame.Parent = mainFrame
hubsFrame.CanvasSize = UDim2.new(0, 0, 0, #hubNames * 54 + 12)
hubsFrame.ScrollBarThickness = 8
hubsFrame.Active = true
hubsFrame.ClipsDescendants = true

local hubsCorner = Instance.new("UICorner")
hubsCorner.CornerRadius = UDim.new(0, 18)
hubsCorner.Parent = hubsFrame

-- Add hub buttons to the scrolling frame
local hubButtonInstances = {}
for i, hubName in hubNames do
    local btn = Instance.new("TextButton")
    btn.Name = hubName .. "Button"
    btn.Text = hubName
    btn.Font = Enum.Font.SourceSansSemibold
    btn.TextSize = 18
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BackgroundTransparency = 0.2
    btn.Size = UDim2.new(0.92, 0, 0, 44)
    btn.Position = UDim2.new(0.04, 0, 0, (i-1)*54+8)
    btn.ZIndex = 21
    btn.Parent = hubsFrame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn
    hubButtonInstances[hubName] = btn
end

-- === VISUALS FRAME WITH ESP TOGGLES ===
local visualFrame = Instance.new("Frame")
visualFrame.Name = "VisualFrame"
visualFrame.Size = UDim2.new(0.75, 0, 0.8, 0)
visualFrame.Position = UDim2.new(0.22, 0, 0.12, 0)
visualFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
visualFrame.BackgroundTransparency = 0.2
visualFrame.BorderSizePixel = 0
visualFrame.ZIndex = 20
visualFrame.Visible = false
visualFrame.Parent = mainFrame
visualFrame.Active = true
visualFrame.ClipsDescendants = true

local visualCorner = Instance.new("UICorner")
visualCorner.CornerRadius = UDim.new(0, 18)
visualCorner.Parent = visualFrame

local espFeatures = {
    {Name = "Box ESP", Key = "BoxESP"},
    {Name = "Name ESP", Key = "NameESP"},
    {Name = "Health ESP", Key = "HealthESP"},
    {Name = "Distance ESP", Key = "DistanceESP"},
    {Name = "Item ESP", Key = "ItemESP"},
    {Name = "Chams", Key = "Chams"},
    {Name = "Skeleton ESP", Key = "SkeletonESP"},
    {Name = "Team Check", Key = "TeamCheck"},
    {Name = "FOV Circle", Key = "FOVCircle"},
    {Name = "ESP Lines", Key = "ESPLines"},
}

local espToggles = {}
local toggleStates = {}

for i, feature in espFeatures do
    local toggle = Instance.new("TextButton")
    toggle.Name = feature.Key .. "Toggle"
    toggle.Text = feature.Name .. ": OFF"
    toggle.Font = Enum.Font.SourceSansSemibold
    toggle.TextSize = 18
    toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    toggle.BackgroundTransparency = 0.2
    toggle.Size = UDim2.new(0.92, 0, 0, 38)
    toggle.Position = UDim2.new(0.04, 0, 0, (i-1)*44+8)
    toggle.ZIndex = 21
    toggle.Parent = visualFrame
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = toggle
    espToggles[feature.Key] = toggle
    toggleStates[feature.Key] = false
end

-- === SIDEBAR PROFILE SECTION ===
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

local profileFrame = Instance.new("Frame")
profileFrame.Name = "ProfileFrame"
profileFrame.BackgroundTransparency = 1
profileFrame.ZIndex = 7
profileFrame.Parent = sidebar

-- Avatar image
local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarImage"
avatarImage.BackgroundTransparency = 1
avatarImage.ZIndex = 8
avatarImage.Parent = profileFrame

-- Get avatar thumbnail
local thumbType = Enum.ThumbnailType.HeadShot
local thumbSize = Enum.ThumbnailSize.Size48x48
local avatarUrl = Players:GetUserThumbnailAsync(localPlayer.UserId, thumbType, thumbSize)
avatarImage.Image = avatarUrl

-- Name label (DisplayName or Name)
local nameLabel = Instance.new("TextLabel")
nameLabel.Name = "NameLabel"
nameLabel.Text = localPlayer.DisplayName and localPlayer.DisplayName or localPlayer.Name
nameLabel.Font = Enum.Font.SourceSansSemibold
nameLabel.TextSize = 16
nameLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
nameLabel.BackgroundTransparency = 1
nameLabel.ZIndex = 8
nameLabel.Parent = profileFrame

-- UserId label (smaller, below name)
local idLabel = Instance.new("TextLabel")
idLabel.Name = "IdLabel"
idLabel.Text = "ID: " .. tostring(localPlayer.UserId)
idLabel.Font = Enum.Font.SourceSans
idLabel.TextSize = 13
idLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
idLabel.BackgroundTransparency = 1
idLabel.ZIndex = 8
idLabel.Parent = profileFrame

-- Responsive profile layout
local function layoutProfile()
    if isMobile() then
        profileFrame.Size = UDim2.new(0.85, 0, 0.21, 0)
        profileFrame.Position = UDim2.new(0.075, 0, 0.79, 0) -- Anchor to bottom
        avatarImage.Size = UDim2.new(0, 54, 0, 54)
        avatarImage.Position = UDim2.new(0, 0, 0, 0.02)
        nameLabel.Size = UDim2.new(0, 110, 0, 24)
        nameLabel.Position = UDim2.new(0, 60, 0, 8)
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        idLabel.Size = UDim2.new(0, 110, 0, 18)
        idLabel.Position = UDim2.new(0, 60, 0, 32)
        idLabel.TextXAlignment = Enum.TextXAlignment.Left
    else
        profileFrame.Size = UDim2.new(0.85, 0, 0.15, 0)
        profileFrame.Position = UDim2.new(0.075, 0, 0.83, 0) -- Anchor to bottom
        avatarImage.Size = UDim2.new(0, 44, 0, 44)
        avatarImage.Position = UDim2.new(0, 0, 0, 0.08)
        nameLabel.Size = UDim2.new(0, 110, 0, 22)
        nameLabel.Position = UDim2.new(0, 50, 0, 6)
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        idLabel.Size = UDim2.new(0, 110, 0, 16)
        idLabel.Position = UDim2.new(0, 50, 0, 28)
        idLabel.TextXAlignment = Enum.TextXAlignment.Left
    end
end
layoutProfile()

-- iOS-style top bar (transparent dark gray, draggable)
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0.09, 0) -- 9% of mainFrame height
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40) -- Dark gray
topBar.BackgroundTransparency = 0.4 -- Semi-transparent
topBar.BorderSizePixel = 0
topBar.ZIndex = 2
topBar.Active = true -- Needed for input events
topBar.Parent = mainFrame

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 24)
topBarCorner.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Text = "iOS Interface"
titleLabel.Font = Enum.Font.SourceSansSemibold
titleLabel.TextSize = 22
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220) -- Light gray for readability
titleLabel.BackgroundTransparency = 1
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Parent = topBar
titleLabel.ZIndex = 3

-- Minimize button (RED)
local minimizeButton = Instance.new("ImageButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Image = "rbxassetid://7072728342" -- Use a minus icon or similar
minimizeButton.BackgroundTransparency = 0.2
minimizeButton.BackgroundColor3 = Color3.fromRGB(220, 40, 40) -- RED color
minimizeButton.AnchorPoint = Vector2.new(1, 0.5) -- Changed anchor to right side
minimizeButton.ZIndex = 4
minimizeButton.Parent = topBar

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 16)
minimizeCorner.Parent = minimizeButton

-- Responsive minimize button position
local function layoutMinimizeButton()
    if isMobile() then
        minimizeButton.Size = UDim2.new(0, 54, 0, 54)
        minimizeButton.Position = UDim2.new(1, -12, 0.5, -27) -- 12px margin from right, vertically centered
    else
        minimizeButton.Size = UDim2.new(0, 32, 0, 32)
        minimizeButton.Position = UDim2.new(1, -16, 0.5, -16) -- 16px margin from right, vertically centered
    end
end
layoutMinimizeButton()

-- Open/restore button (initially hidden)
local openButton = Instance.new("ImageButton")
openButton.Name = "OpenButton"
openButton.Image = openButtonImageId -- Use custom image for open button
openButton.BackgroundTransparency = 0.4
openButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
openButton.Size = UDim2.new(0, 48, 0, 48)
openButton.Position = UDim2.new(0.5, -24, 0.05, 0)
openButton.AnchorPoint = Vector2.new(0, 0)
openButton.ZIndex = 10
openButton.Visible = false
openButton.Parent = screenGui

local openButtonCorner = Instance.new("UICorner")
openButtonCorner.CornerRadius = UDim.new(0, 24)
openButtonCorner.Parent = openButton

-- === CUSTOM IMAGE LABEL ===
local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "CustomImage"
imageLabel.Image = customImageId
imageLabel.BackgroundTransparency = 1
imageLabel.Size = UDim2.new(0.25, 0, 0.25, 0) -- 25% width/height of mainFrame
imageLabel.Position = UDim2.new(0.22, 0, 0.15, 0) -- Adjusted to not overlap sidebar
imageLabel.ZIndex = 3
imageLabel.Parent = mainFrame

local imageCorner = Instance.new("UICorner")
imageCorner.CornerRadius = UDim.new(0, 18)
imageCorner.Parent = imageLabel

-- Main content area (REMOVED welcome text and "Continuar" button)
-- (No contentLabel or button here)

-- Responsive adjustment for PC and mobile screens
local function adjustFrame()
    local viewportSize = workspace.CurrentCamera.ViewportSize
    if isMobile() then
        -- Mobile: smaller and taller, more compact
        local minWidth, minHeight = 220, 180
        local maxWidth, maxHeight = 380, 340
        local width = math.clamp(viewportSize.X * 0.95, minWidth, maxWidth)
        local height = math.clamp(viewportSize.Y * 0.6, minHeight, maxHeight)
        mainFrame.Size = UDim2.new(0, width, 0, height)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        layoutSidebar()
        layoutProfile()
        layoutMinimizeButton()
        hubsFrame.Size = UDim2.new(0.72, 0, 0.8, 0)
        hubsFrame.Position = UDim2.new(0.28, 0, 0.12, 0)
        visualFrame.Size = UDim2.new(0.72, 0, 0.8, 0)
        visualFrame.Position = UDim2.new(0.28, 0, 0.12, 0)
    else
        -- PC/tablet: original sizing
        local minWidth, minHeight = 300, 400
        local maxWidth, maxHeight = 600, 900
        local width = math.clamp(viewportSize.X * 0.8, minWidth, maxWidth)
        local height = math.clamp(viewportSize.Y * 0.8, minHeight, maxWidth)
        mainFrame.Size = UDim2.new(0, width, 0, height)
        mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        layoutSidebar()
        layoutProfile()
        layoutMinimizeButton()
        hubsFrame.Size = UDim2.new(0.75, 0, 0.8, 0)
        hubsFrame.Position = UDim2.new(0.22, 0, 0.12, 0)
        visualFrame.Size = UDim2.new(0.75, 0, 0.8, 0)
        visualFrame.Position = UDim2.new(0.22, 0, 0.12, 0)
    end
end

adjustFrame()
game:GetService("RunService").RenderStepped:Connect(adjustFrame)

-- Drag functionality for PC and mobile
local dragging = false
local dragStart, frameStart

local function clampFramePosition(pos, frameSize, viewportSize)
    local x = math.clamp(pos.X, frameSize.X/2, viewportSize.X - frameSize.X/2)
    local y = math.clamp(pos.Y, frameSize.Y/2, viewportSize.Y - frameSize.Y/2)
    return UDim2.new(0, x, 0, y)
end

local function getFrameCenterPosition()
    local frameAbsPos = mainFrame.AbsolutePosition
    local frameAbsSize = mainFrame.AbsoluteSize
    return Vector2.new(frameAbsPos.X + frameAbsSize.X/2, frameAbsPos.Y + frameAbsSize.Y/2)
end

-- DRAG LOGIC FOR TOPBAR
topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        frameStart = getFrameCenterPosition()
        input.UserInputState = Enum.UserInputState.Begin
    end
end)

topBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- DRAG LOGIC FOR MAINFRAME (WHOLE FRAME DRAGGABLE)
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        frameStart = getFrameCenterPosition()
        input.UserInputState = Enum.UserInputState.Begin
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        local newCenter = frameStart + delta
        local viewportSize = workspace.CurrentCamera.ViewportSize
        local frameSize = mainFrame.AbsoluteSize
        local clampedPos = clampFramePosition(newCenter, frameSize, viewportSize)
        mainFrame.Position = clampedPos
    end
end)

-- Minimize/restore logic
local lastFramePosition = mainFrame.Position
minimizeButton.MouseButton1Click:Connect(function()
    lastFramePosition = mainFrame.Position
    mainFrame.Visible = false
    openButton.Visible = true
    -- Place openButton where the topBar was
    local frameAbsPos = mainFrame.AbsolutePosition
    local frameAbsSize = mainFrame.AbsoluteSize
    openButton.Position = UDim2.new(0, frameAbsPos.X + frameAbsSize.X/2 - 24, 0, frameAbsPos.Y + 8)
end)

openButton.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    openButton.Visible = false
    mainFrame.Position = lastFramePosition
end)

-- Make openButton draggable too
local openDragging = false
local openDragStart, openButtonStart

openButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        openDragging = true
        openDragStart = input.Position
        local absPos = openButton.AbsolutePosition
        openButtonStart = Vector2.new(absPos.X, absPos.Y)
        input.UserInputState = Enum.UserInputState.Begin
    end
end)

openButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        openDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if openDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - openDragStart
        local newPos = openButtonStart + delta
        local viewportSize = workspace.CurrentCamera.ViewportSize
        local btnSize = openButton.AbsoluteSize
        local x = math.clamp(newPos.X, 0, viewportSize.X - btnSize.X)
        local y = math.clamp(newPos.Y, 0, viewportSize.Y - btnSize.Y)
        openButton.Position = UDim2.new(0, x, 0, y)
    end
end)

-- === SIDEBAR BUTTON LOGIC FOR HUBS AND ALL FUNCTIONS ===
local function hideAllContentFrames()
    hubsFrame.Visible = false
    visualFrame.Visible = false
    -- Add more content frames here if needed in future
end

-- Show hubsFrame when "Hubs" button is clicked, hide when others are clicked
for name, btn in sidebarButtonInstances do
    btn.MouseButton1Click:Connect(function()
        hideAllContentFrames()
        if name == "Hubs" then
            hubsFrame.Visible = true
            showNotification("Función 'Hubs' activada")
        elseif name == "Automatic" then
            showNotification("Función 'Automatic' activada")
        elseif name == "Main" then
            showNotification("Función 'Main' activada")
        elseif name == "Visual" then
            visualFrame.Visible = true
            showNotification("Función 'Visual' activada")
        elseif name == "Teleport" then
            showNotification("Función 'Teleport' activada")
        elseif name == "Configuracion" then
            showNotification("Función 'Configuración' activada")
        else
            showNotification("Función '" .. name .. "' activada")
        end
    end)
end

-- HUB BUTTON LOGIC: Show notification when hub is activated
for hubName, btn in hubButtonInstances do
    btn.MouseButton1Click:Connect(function()
        showNotification("Hub '" .. hubName .. "' activado")
    end)
end

-- === ESP TOGGLE BUTTON LOGIC ===
for key, toggle in espToggles do
    toggle.MouseButton1Click:Connect(function()
        toggleStates[key] = not toggleStates[key]
        if toggleStates[key] then
            toggle.Text = espFeatures[table.find(espFeatures, function(f) return f.Key == key end)].Name .. ": ON"
            toggle.BackgroundColor3 = Color3.fromRGB(60, 180, 60)
            showNotification("Activado " .. espFeatures[table.find(espFeatures, function(f) return f.Key == key end)].Name)
        else
            toggle.Text = espFeatures[table.find(espFeatures, function(f) return f.Key == key end)].Name .. ": OFF"
            toggle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            showNotification("Desactivado " .. espFeatures[table.find(espFeatures, function(f) return f.Key == key end)].Name)
        end
        -- Aquí puedes agregar la lógica funcional para cada ESP
    end)
end
