-- Loader.lua - GUI met Speed Hub X en Voidware keuze
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ScreenGui maken
local screen = Instance.new("ScreenGui")
screen.Name = "LoaderMenu"
screen.ResetOnSpawn = false
screen.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Frame (menu) maken
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 250, 0, 150)
frame.Position = UDim2.new(0.05, 0, 0.2, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true -- zodat je het menu kan bewegen
frame.Parent = screen

-- Titel
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = " Script Loader "
title.TextColor3 = Color3.fromRGB(255,255,255)
title.BackgroundColor3 = Color3.fromRGB(20,20,20)
title.Parent = frame

-- Functie voor knoppen
local function makeButton(name, posY, scriptUrl)
    local button = Instance.new("TextButton")
    button.Text = "Laad " .. name
    button.Size = UDim2.new(0.9, 0, 0, 40)
    button.Position = UDim2.new(0.05, 0, 0, posY)
    button.BackgroundColor3 = Color3.fromRGB(60,60,60)
    button.TextColor3 = Color3.fromRGB(255,255,255)
    button.Parent = frame

    button.MouseButton1Click:Connect(function()
        button.Text = "Laden..."
        local ok, code = pcall(function()
            return game:HttpGet(scriptUrl, true)
        end)
        if ok and code then
            local fn = loadstring(code)
            if fn then
                fn()
                button.Text = "✅ " .. name .. " geladen"
            else
                button.Text = "❌ Fout bij uitvoeren"
            end
        else
            button.Text = "❌ Fout bij laden"
        end
        task.wait(2)
        button.Text = "Laad " .. name
    end)
end

-- === Scripts toevoegen ===
makeButton("Voidware", 50, "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua")
makeButton("Speed Hub X", 100, "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua")
