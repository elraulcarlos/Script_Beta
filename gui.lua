repeat wait() until game:IsLoaded()
wait(2)

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
            local hubs = {
                {name = "InfinityYield", url = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"},
                {name = "CMD-X", url = "https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source"},
                {name = "DarkHub", url = "https://raw.githubusercontent.com/RandomAdamYT/DarkHub/master/Init"},
                {name = "OwlHub", url = "https://raw.githubusercontent.com/CriShoux/OwlHub/master/OwlHub.txt"}
            }

            local y = 60
            for _, hub in ipairs(hubs) do
                local btn = Instance.new("TextButton", content)
                btn.Size = UDim2.new(0, 180, 0, 30)
                btn.Position = UDim2.new(0, 10, 0, y)
                btn.Text = "Ejecutar " .. hub.name
                btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                btn.TextColor3 = Color3.new(1, 1, 1)
                btn.Font = Enum.Font.GothamBold
                btn.TextSize = 14

                btn.MouseButton1Click:Connect(function()
                    local success, err = pcall(function()
                        loadstring(game:HttpGet(hub.url))()
                    end)

                    if not success then
                        btn.Text = hub.name .. " Error"
                        btn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    else
                        btn.Text = hub.name .. " Cargado"
                        btn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                    end
                end)

                y = y + 40
            end
        end
    end)
end
elseif name == "Visual" then
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local camera = workspace.CurrentCamera
            local localPlayer = Players.LocalPlayer

            local drawings = {}
            local espUniversal = false
            local espMinimal = false
            local espModular = {box = false, tracer = false, name = false}

            local function createESP(player)
                if player == localPlayer then return end
                local char = player.Character
                if not char or not char:FindFirstChild("HumanoidRootPart") then return end

                local box = Drawing.new("Square")
                box.Thickness = 1
                box.Color = Color3.fromRGB(0, 255, 0)
                box.Filled = false
                box.Visible = false

                local tracer = Drawing.new("Line")
                tracer.Thickness = 1
                tracer.Color = Color3.fromRGB(255, 255, 0)
                tracer.Visible = false

                local nameTag = Drawing.new("Text")
                nameTag.Size = 14
                nameTag.Color = Color3.fromRGB(255, 255, 255)
                nameTag.Center = true
                nameTag.Outline = true
                nameTag.Visible = false

                drawings[player] = {box = box, tracer = tracer, nameTag = nameTag}
            end

            for _, p in pairs(Players:GetPlayers()) do
                createESP(p)
            end

            Players.PlayerAdded:Connect(createESP)
            Players.PlayerRemoving:Connect(function(p)
                if drawings[p] then
                    for _, d in pairs(drawings[p]) do
                        d:Remove()
                    end
                    drawings[p] = nil
                end
            end)

            RunService.RenderStepped:Connect(function()
                for player, objs in pairs(drawings) do
                    local char = player.Character
                    if not char or not char:FindFirstChild("HumanoidRootPart") then
                        objs.box.Visible = false
                        objs.tracer.Visible = false
                        objs.nameTag.Visible = false
                    else
                        local root = char.HumanoidRootPart
                        local pos, onScreen = camera:WorldToViewportPoint(root.Position)

                        if onScreen then
                            local hp = char:FindFirstChildOfClass("Humanoid") and math.floor(char:FindFirstChildOfClass("Humanoid").Health) or 0
                            local size = Vector2.new(50, 100)

                            objs.box.Size = size
                            objs.box.Position = Vector2.new(pos.X - size.X/2, pos.Y - size.Y/2)
                            objs.tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
                            objs.tracer.To = Vector2.new(pos.X, pos.Y)
                            objs.nameTag.Text = player.Name .. " [" .. hp .. " HP]"
                            objs.nameTag.Position = Vector2.new(pos.X, pos.Y - 60)

                            objs.box.Visible = espUniversal or espModular.box
                            objs.tracer.Visible = espUniversal or espModular.tracer
                            objs.nameTag.Visible = espUniversal or espMinimal or espModular.name
                        else
                            objs.box.Visible = false
                            objs.tracer.Visible = false
                            objs.nameTag.Visible = false
                        end
                    end
                end
            end)

            local btn1 = Instance.new("TextButton", content)
            btn1.Size = UDim2.new(0, 180, 0, 30)
            btn1.Position = UDim2.new(0, 10, 0, 60)
            btn1.Text = "ESP Universal"
            btn1.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            btn1.TextColor3 = Color3.new(1, 1, 1)
            btn1.Font = Enum.Font.GothamBold
            btn1.TextSize = 14
            btn1.MouseButton1Click:Connect(function()
                espUniversal = not espUniversal
                btn1.Text = espUniversal and "Desactivar Universal" or "ESP Universal"
                btn1.BackgroundColor3 = espUniversal and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(0, 200, 0)
            end)

            local btn2 = Instance.new("TextButton", content)
            btn2.Size = UDim2.new(0, 180, 0, 30)
            btn2.Position = UDim2.new(0, 10, 0, 100)
            btn2.Text = "ESP Minimal"
            btn2.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            btn2.TextColor3 = Color3.new(1, 1, 1)
            btn2.Font = Enum.Font.GothamBold
            btn2.TextSize = 14
            btn2.MouseButton1Click:Connect(function()
                espMinimal = not espMinimal
                end) -- cierre de MouseButton1Click
end   -- cierre de createSection(name)

createSection("Main")
createSection("Visual")
createSection("Hubs")
                end -- cierre de createSection(name)
                end)

            local btn3 = Instance.new("TextButton", content)
            btn3.Size = UDim2.new(0, 180, 0, 30)
            btn3.Position = UDim2.new(0, 10, 0, 140)
            btn3.Text = "ESP Modular"
            btn3.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
            btn3.TextColor3 = Color3.new(1, 1, 1)
            btn3.Font = Enum.Font.GothamBold
            btn3.TextSize = 14
            btn3.MouseButton1Click:Connect(function()
                espModular.box = not espModular.box
                espModular.tracer = not espModular.tracer
                espModular.name = not espModular.name
                btn3.Text = espModular.box and "Desactivar Modular" or "ESP Modular"
                btn3.BackgroundColor3 = espModular.box and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(0, 200, 0)
            end)
        end
    end)
end

createSection("Main")
createSection("Visual")
createSection("Hubs")

main.Visible = true
openBtn.Visible = false

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

local btn3 = Instance.new("TextButton", content)
btn3.Size = UDim2.new(0, 180, 0, 30)
btn3.Position = UDim2.new(0, 10, 0, 140)
btn3.Text = "ESP Modular"
btn3.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
btn3.TextColor3 = Color3.new(1, 1, 1)
btn3.Font = Enum.Font.GothamBold
btn3.TextSize = 14
btn3.MouseButton1Click:Connect(function()
    espModular.box = not espModular.box
    espModular.tracer = not espModular.tracer
    espModular.name = not espModular.name
    btn3.Text = espModular.box and "Desactivar Modular" or "ESP Modular"
    btn3.BackgroundColor3 = espModular.box and Color3.fromRGB(255, 60, 60) or Color3.fromRGB(0, 200, 0)
end)
