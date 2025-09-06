-- 🔑 Loader.lua - Voidware only (met key systeem)
-- Key = DELTA777

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ScreenGui
local screen = Instance.new("ScreenGui")
screen.Name = "LoaderGUI"
screen.ResetOnSpawn = false
screen.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- === Key Input Frame ===
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 260, 0, 120)
keyFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
keyFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
keyFrame.Active = true
keyFrame.Draggable = true
keyFrame.Parent = screen

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 30)
keyTitle.BackgroundTransparency = 1
keyTitle.Text = "Enter Key"
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.Font = Enum.Font.SourceSansBold
keyTitle.TextSize = 20
keyTitle.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -20, 0, 35)
keyBox.Position = UDim2.new(0, 10, 0, 40)
keyBox.PlaceholderText = "Voer key in..."
keyBox.Text = ""
keyBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyFrame

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(1, -20, 0, 30)
submitBtn.Position = UDim2.new(0, 10, 0, 85)
submitBtn.Text = "Check Key"
submitBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.Parent = keyFrame

-- === Menu Frame (na key) ===
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 200, 0, 100)
menuFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
menuFrame.Active = true
menuFrame.Draggable = true
menuFrame.Visible = false
menuFrame.Parent = screen

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = "Loader Menu"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Parent = menuFrame

-- Knop voor Voidware
local voidBtn = Instance.new("TextButton")
voidBtn.Size = UDim2.new(1, -20, 0, 40)
voidBtn.Position = UDim2.new(0, 10, 0, 40)
voidBtn.Text = "🌌 Voidware"
voidBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
voidBtn.TextColor3 = Color3.new(1,1,1)
voidBtn.Parent = menuFrame

voidBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
end)

-- === Open/Close knop ===
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 80, 0, 35)
toggleBtn.Position = UDim2.new(0, 20, 0, 200)
toggleBtn.Text = "Open Menu"
toggleBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Active = true
toggleBtn.Draggable = true
toggleBtn.Visible = false
toggleBtn.Parent = screen

toggleBtn.MouseButton1Click:Connect(function()
    menuFrame.Visible = not menuFrame.Visible
end)

-- === Key check ===
submitBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "DELTA777" then
        keyFrame.Visible = false
        menuFrame.Visible = true
        toggleBtn.Visible = true
    else
        keyBox.Text = "❌ Fout, probeer opnieuw"
    end
end)

print("✅ Loader actief met key & Voidware script")
