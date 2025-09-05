-- ScriptBeta GUI completo

repeat wait() until game:IsLoaded()
wait(2)

-- Notificación con sonido
pcall(function()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://9118823104"
    sound.Volume = 1
    sound.PlayOnRemove = true
    sound.Parent = game.CoreGui
    sound:Destroy()

    game.StarterGui:SetCore("SendNotification", {
        Title = "ScriptBeta",
        Text = "Interfaz cargada correctamente ✅",
        Duration = 5
    })
end)

-- GUI base
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ScriptBeta"
gui.ResetOnSpawn = false

local openBtn = Instance.new("TextButton", gui)
openBtn.Size = UDim2.new(0, 120, 0, 40)
openBtn.Position = UDim2.new(0, 20, 0, 20)
openBtn.Text = "Abrir GUI"
openBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.Font = Enum.Font.GothamBold
openBtn.TextSize = 14
openBtn.Visible = false
openBtn.Active = true
openBtn.Draggable = true

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 420, 0, 300)
main.Position = UDim2.new(0.5, -210, 0.5, -150)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.BackgroundTransparency = 0.2
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)

local header = Instance.new("Frame", main)
header.Size = UDim2.new(1, 0, 0, 30)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
header.BackgroundTransparency = 0.2
header.BorderSizePixel = 0

local title = Instance.new("TextLabel", header)
title.Size = UDim2.new(1, -30, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.Text = "ScriptBeta — Interfaz Moderna"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left

local minimizeBtn = Instance.new("TextButton", header)
minimizeBtn.Size = UDim2.new(0, 30, 1, 0)
minimizeBtn.Position = UDim2.new(1, -30, 0, 0)
minimizeBtn.Text = "_"
minimizeBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.TextSize = 14

minimizeBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    openBtn.Visible = true
end)

openBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    openBtn.Visible = false
end)

local sidebar = Instance.new("Frame", main)
sidebar.Size = UDim2.new(0, 100, 1, -30)
sidebar.Position = UDim2.new(0, 0, 0, 30)
sidebar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
sidebar.BackgroundTransparency = 0.2
sidebar.BorderSizePixel = 0

local content = Instance.new("Frame", main)
content.Size = UDim2.new(1, -100, 1, -30)
content.Position = UDim2.new(0, 100, 0, 30)
content.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
content.BackgroundTransparency = 0.2
content.BorderSizePixel = 0

local function clearContent()
    for _, child in pairs(content:GetChildren()) do
        child:Destroy()
    end
end

local sectionY = 5
local function createSection(name)
    local btn = Instance.new("TextButton", sidebar)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.Position = UDim2.new(0, 0, 0, sectionY)
    btn.Text = name
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.BackgroundTransparency = 0.2
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    sectionY = sectionY + 35

    btn.MouseButton1Click:Connect(function()
        clearContent()

        local label = Instance.new("TextLabel", content)
        label.Size = UDim2.new(1, -20, 0, 30)
        label.Position = UDim2.new(0, 10, 0, 10)
        label.Text = "Sección: " .. name
        label.TextColor3 = Color3.new(1, 1, 1)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 16
        label.BackgroundTransparency = 1

        if name == "Main" then
            local slider = Instance.new("TextButton", content)
            slider.Size = UDim2.new(0, 200, 0, 30)
            slider.Position = UDim2.new(0, 10, 0, 60)
            slider.Text = "Velocidad: 100"
            slider.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            slider.TextColor3 = Color3.new(1, 1, 1)
            slider.Font = Enum.Font.GothamBold
            slider.TextSize = 14

            local speed = 100
            slider.MouseButton1Click:Connect(function()
                speed = speed + 25
                if speed > 200 then speed = 25 end
                slider.Text = "Velocidad: " .. speed
                local lp = game.Players.LocalPlayer
                if lp.Character and lp.Character:FindFirstChild("Humanoid") then
                    lp.Character.Humanoid.WalkSpeed = speed
                end
            end)

        elseif name == "Hubs" then
            local iyBtn = Instance.new("TextButton", content)
            iyBtn.Size = UDim2.new(0, 180, 0, 30)
            iyBtn.Position = UDim2.new(0, 10, 0, 60)
            iyBtn.Text = "Ejecutar InfinityYield"
            iyBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            iyBtn.TextColor3 = Color3.new(1, 1, 1)
            iyBtn.Font = Enum.Font.GothamBold
            iyBtn.TextSize = 14

            iyBtn.MouseButton1Click:Connect(function()
                local success, err = pcall(function()
                    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
                end)

                if not success then
                    iyBtn.Text = "Error al ejecutar InfinityYield"
                    iyBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
                else
                    iyBtn.Text = "InfinityYield ejecutado ✅"
                    iyBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                end
            end)

        elseif name == "Visual" then
            local RunService = game:GetService("RunService")
            local Players = game:GetService("Players")
            local Camera = workspace.CurrentCamera
            local LocalPlayer = Players.LocalPlayer
            local ESP = {}

            local function createESP(player)
                if player == LocalPlayer then return end
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end

                local box = Drawing.new("Square")
                box.Visible = false
                box.Color = Color3.fromRGB(255, 0, 0)
                box.Thickness = 1
                box.Filled = false

                local tracer = Drawing.new("Line")
                tracer.Visible = false
                tracer.Color = Color3
          tracer.Thickness = 1

                local text = Drawing.new("Text")
                text.Visible = false
                text.Size = 14
                text.Center = true
                text.Outline = true
                text.Color = Color3.new(1, 1, 1)

                ESP[player] = {box = box, tracer = tracer, text = text}
            end

            for _, p in pairs(Players:GetPlayers()) do
                createESP(p)
            end

            Players.PlayerAdded:Connect(createESP)
            Players.PlayerRemoving:Connect(function(p)
                if ESP[p] then
                    for _, obj in pairs(ESP[p]) do obj:Remove() end
                    ESP[p] = nil
                end
            end)

            RunService.RenderStepped:Connect(function()
                for player, drawings in pairs(ESP) do
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
                        local pos, onScreen = Camera:WorldToViewportPoint(char.HumanoidRootPart.Position)
                        if onScreen then
                            local size = 50
                            drawings.box.Size = Vector2.new(size, size)
                            drawings.box.Position = Vector2.new(pos.X - size/2, pos.Y - size/2)
                            drawings.box.Visible = true

                            drawings.tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                            drawings.tracer.To = Vector2.new(pos.X, pos.Y)
                            drawings.tracer.Visible = true

                            local dist = math.floor((Camera.CFrame.Position - char.HumanoidRootPart.Position).Magnitude)
                            local hp = math.floor(char.Humanoid.Health)
                            drawings.text.Text = player.Name .. " | " .. dist .. "m | " .. hp .. "HP"
                            drawings.text.Position = Vector2.new(pos.X, pos.Y - 60)
                            drawings.text.Visible = true
                        else
                            drawings.box.Visible = false
                            drawings.tracer.Visible = false
                            drawings.text.Visible = false
                        end
                    end
                end
            end)
        end
    end)
end

-- Activar secciones
createSection("Main")
createSection("Visual")
createSection("Aura")
createSection("Hubs")

-- Perfil lateral
local profileFrame = Instance.new("Frame", sidebar)
profileFrame.Size = UDim2.new(1, 0, 0, 60)
profileFrame.AnchorPoint = Vector2.new(0, 1)
profileFrame.Position = UDim2.new(0, 0, 1, 0)
profileFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
profileFrame.BackgroundTransparency = 0.2
profileFrame.BorderSizePixel = 0

local avatar = Instance.new("ImageLabel", profileFrame)
avatar.Size = UDim2.new(0, 40, 0, 40)
avatar.Position = UDim2.new(0, 10, 0, 10)
avatar.BackgroundTransparency = 1
avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..game.Players.LocalPlayer.UserId.."&w=60&h=60"
avatar.ScaleType = Enum.ScaleType.Fit

local nameLabel = Instance.new("TextLabel", profileFrame)
nameLabel.Size = UDim2.new(1, -60, 0, 20)
nameLabel.Position = UDim2.new(0, 60, 0, 20)
nameLabel.Text = game.Players.LocalPlayer.Name
nameLabel.TextColor3 = Color3.new(1, 1, 1)
nameLabel.Font = Enum.Font.Gotham
nameLabel.TextSize = 14
nameLabel.BackgroundTransparency = 1
nameLabel.TextXAlignment = Enum.TextXAlignment.Left
