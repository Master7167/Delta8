-- loader.lua  —  Minimal lag, mobiel vriendelijk, sleepbaar
-- Auteur: jij 💚  |  Functies: Open/Close, draggable, 2 scripts (Voidware & Speed Hub X)

-- ===== Services =====
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- ===== Helpers =====
local function toast(msg, color)
    local gui = Instance.new("ScreenGui")
    gui.Name = "LoaderToast"
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local label = Instance.new("TextLabel")
    label.BackgroundColor3 = color or Color3.fromRGB(35, 35, 35)
    label.TextColor3 = Color3.new(1,1,1)
    label.TextScaled = true
    label.Size = UDim2.fromOffset(360, 54)
    label.Position = UDim2.new(0.5, -180, 0.12, 0)
    label.Text = msg
    label.Parent = gui

    task.delay(2, function()
        if gui then gui:Destroy() end
    end)
end

local function httpGetRetry(url, tries, delaySec)
    tries = tries or 3
    delaySec = delaySec or 0.5
    for i=1, tries do
        local ok, res = pcall(function()
            return game:HttpGet(url, true)
        end)
        if ok and res and #res > 0 then
            return res
        end
        task.wait(delaySec)
    end
    return nil
end

local function makeDraggable(handle, target)
    -- mobiel + pc draggable (titelbalk/open-knop)
    local dragging = false
    local dragStart, startPos

    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if not dragging then return end
        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- ===== UI Root =====
local root = Instance.new("ScreenGui")
root.Name = "Delta8Loader"
root.ResetOnSpawn = false
root.Parent = PlayerGui

-- ===== Open/Close knop (sleepbaar) =====
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Text = "Open Menu"
openBtn.TextScaled = true
openBtn.Font = Enum.Font.GothamBold
openBtn.Size = UDim2.fromOffset(140, 48)
openBtn.Position = UDim2.new(1, -160, 1, -68)
openBtn.BackgroundColor3 = Color3.fromRGB(0, 165, 90)
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.AutoButtonColor = true
openBtn.Parent = root

makeDraggable(openBtn, openBtn)

-- ===== Menu =====
local frame = Instance.new("Frame")
frame.Name = "MainMenu"
frame.Size = UDim2.fromOffset(280, 190)
frame.Position = UDim2.fromOffset(24, 24)
frame.Visible = false
frame.BackgroundColor3 = Color3.fromRGB(36, 36, 36)
frame.BorderSizePixel = 0
frame.Parent = root

local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 8); corner.Parent = frame

-- Titelbalk
local titleBar = Instance.new("TextLabel")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
titleBar.TextColor3 = Color3.new(1,1,1)
titleBar.TextScaled = true
titleBar.Font = Enum.Font.GothamSemibold
titleBar.Text = "Delta8 Loader"
titleBar.Parent = frame
local tCorner = Instance.new("UICorner"); tCorner.CornerRadius = UDim.new(0, 8); tCorner.Parent = titleBar

makeDraggable(titleBar, frame)

-- Sluit knop
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.fromOffset(34, 34)
closeBtn.Position = UDim2.new(1, -42, 0, 3)
closeBtn.BackgroundTransparency = 0.2
closeBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
closeBtn.Text = "✕"
closeBtn.TextScaled = true
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Parent = frame
local cCorner = Instance.new("UICorner"); cCorner.CornerRadius = UDim.new(0, 6); cCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    openBtn.Text = "Open Menu"
end)

-- Status label
local statusLbl = Instance.new("TextLabel")
statusLbl.Size = UDim2.new(1, -20, 0, 22)
statusLbl.Position = UDim2.fromOffset(10, 46)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = "Gereed"
statusLbl.TextScaled = true
statusLbl.Font = Enum.Font.Gotham
statusLbl.TextColor3 = Color3.fromRGB(230,230,230)
statusLbl.TextXAlignment = Enum.TextXAlignment.Left
statusLbl.Parent = frame

-- Open/Close toggle
openBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
    openBtn.Text = frame.Visible and "Sluit Menu" or "Open Menu"
end)

-- ===== Button helper =====
local function addButton(text, y, url)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 44)
    btn.Position = UDim2.fromOffset(10, y)
    btn.BackgroundColor3 = Color3.fromRGB(55,55,55)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamMedium
    btn.Text = text
    btn.AutoButtonColor = true
    btn.Parent = frame
    local bCorner = Instance.new("UICorner"); bCorner.CornerRadius = UDim.new(0, 6); bCorner.Parent = btn

    btn.MouseButton1Click:Connect(function()
        btn.Active = false
        local old = btn.Text
        btn.Text = "Laden..."
        statusLbl.Text = "Bezig: "..text

        task.spawn(function()
            local code = httpGetRetry(url, 3, 0.6)
            if not code then
                statusLbl.Text = "Fout: kon script niet ophalen"
                btn.Text = "❌ Fout"
                task.wait(1.2)
                btn.Text = old
                btn.Active = true
                return
            end

            local ok, err = pcall(function()
                local fn = loadstring(code)
                if typeof(fn) == "function" then fn() end
            end)

            if ok then
                statusLbl.Text = "Gereed: "..text
                toast("✅ "..text.." geladen", Color3.fromRGB(0,150,0))
                btn.Text = "✅ Klaar"
            else
                statusLbl.Text = "Fout: "..tostring(err)
                toast("❌ Fout bij uitvoeren", Color3.fromRGB(150,0,0))
                btn.Text = "❌ Fout"
            end

            task.wait(1.2)
            btn.Text = old
            btn.Active = true
        end)
    end)
end

-- ===== Jouw 2 scripts =====
addButton("Voidware",   78, "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua")
addButton("Speed Hub X", 128, "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua")

-- Kleine welkom-toast
toast("Loader actief", Color3.fromRGB(0,120,0))
