-- ✅ Delta Loader (Voidware only) met key systeem
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- GUI container
local screen = Instance.new("ScreenGui")
screen.Name = "DeltaLoader"
screen.ResetOnSpawn = false
screen.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Open-knop (draggable)
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 120, 0, 40)
openBtn.Position = UDim2.new(0, 20, 0, 200)
openBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
openBtn.Text = "📂 Open Loader"
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Active = true
openBtn.Draggable = true
openBtn.Parent = screen

-- Frame menu
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 260, 0, 160)
frame.Position = UDim2.new(0.3, 0, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Parent = screen

-- Titel
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundTransparency = 1
title.Text = "🔑 Delta Loader"
title.Font = Enum.Font.SourceSansBold
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 20
title.Parent = frame

-- Key invoerveld
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1,-20,0,35)
keyBox.Position = UDim2.new(0,10,0,40)
keyBox.PlaceholderText = "Voer key in..."
keyBox.Text = ""
keyBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.ClearTextOnFocus = false
keyBox.Parent = frame

-- Check knop
local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(1,-20,0,30)
submitBtn.Position = UDim2.new(0,10,0,85)
submitBtn.Text = "Check Key"
submitBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.Parent = frame

-- Loader knop (verstopt tot key geldig is)
local voidwareBtn = Instance.new("TextButton")
voidwareBtn.Size = UDim2.new(1,-20,0,40)
voidwareBtn.Position = UDim2.new(0,10,0,125)
voidwareBtn.Text = "🌌 Start Voidware"
voidwareBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
voidwareBtn.TextColor3 = Color3.new(1,1,1)
voidwareBtn.Visible = false
voidwareBtn.Parent = frame

-- Functie: check key
submitBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "DELTA777" then
        keyBox.Visible = false
        submitBtn.Visible = false
        voidwareBtn.Visible = true
        title.Text = "✅ Key correct!"
    else
        keyBox.Text = "❌ Ongeldige key"
    end
end)

-- Functie: Voidware laden
voidwareBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
end)

-- Open/close toggle
openBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

print("🔑 Loader actief - key is DELTA777")
