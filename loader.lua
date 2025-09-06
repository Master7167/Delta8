-- 🔑 Loader met Key System (Key = DELTA777)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Maak hoofd GUI
local screen = Instance.new("ScreenGui")
screen.Name = "LoaderMenu"
screen.ResetOnSpawn = false
screen.Parent = PlayerGui

-- ⚙️ Functie om draggable te maken (werkt ook op mobiel)
local function makeDraggable(gui)
    local dragging, dragInput, startPos, startInputPos
    gui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = gui.Position
            startInputPos = input.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    gui.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startInputPos
            gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- 📌 Open-knop (altijd zichtbaar, draggable)
local openBtn = Instance.new("TextButton")
openBtn.Size = UDim2.new(0, 80, 0, 35)
openBtn.Position = UDim2.new(0, 20, 0, 200)
openBtn.Text = "📂 Open"
openBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
openBtn.TextColor3 = Color3.new(1,1,1)
openBtn.Parent = screen
makeDraggable(openBtn)

-- 📌 Key input frame
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 220, 0, 110)
keyFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
keyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
keyFrame.Visible = false
keyFrame.Parent = screen
makeDraggable(keyFrame)

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 25)
keyTitle.Text = "Enter Key"
keyTitle.BackgroundTransparency = 1
keyTitle.TextColor3 = Color3.new(1,1,1)
keyTitle.Font = Enum.Font.SourceSansBold
keyTitle.TextSize = 18
keyTitle.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -20, 0, 30)
keyBox.Position = UDim2.new(0, 10, 0, 30)
keyBox.PlaceholderText = "Voer key in..."
keyBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyFrame

local submitBtn = Instance.new("TextButton")
submitBtn.Size = UDim2.new(1, -20, 0, 25)
submitBtn.Position = UDim2.new(0, 10, 0, 70)
submitBtn.Text = "Check Key"
submitBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
submitBtn.TextColor3 = Color3.new(1,1,1)
submitBtn.Parent = keyFrame

-- 📌 Menu frame (na correcte key)
local menuFrame = Instance.new("Frame")
menuFrame.Size = UDim2.new(0, 200, 0, 120)
menuFrame.Position = UDim2.new(0.35, 0, 0.35, 0)
menuFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
menuFrame.Visible = false
menuFrame.Parent = screen
makeDraggable(menuFrame)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 60, 0, 25)
closeBtn.Position = UDim2.new(1, -70, 0, 5)
closeBtn.Text = "❌"
closeBtn.BackgroundColor3 = Color3.fromRGB(100,30,30)
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.Parent = menuFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 25)
title.Text = "🚀 Loader Menu"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.Parent = menuFrame

-- Voidware knop
local voidBtn = Instance.new("TextButton")
voidBtn.Size = UDim2.new(1, -20, 0, 35)
voidBtn.Position = UDim2.new(0, 10, 0, 40)
voidBtn.Text = "🌌 Voidware"
voidBtn.BackgroundColor3 = Color3.fromRGB(50,50,50)
voidBtn.TextColor3 = Color3.new(1,1,1)
voidBtn.Parent = menuFrame

-- 🔑 Key check
submitBtn.MouseButton1Click:Connect(function()
    if keyBox.Text == "DELTA777" then
        keyFrame.Visible = false
        menuFrame.Visible = true
    else
        keyBox.Text = "❌ Wrong Key"
    end
end)

-- 📂 Open knop → toont key input
openBtn.MouseButton1Click:Connect(function()
    if not menuFrame.Visible then
        keyFrame.Visible = not keyFrame.Visible
    end
end)

-- ❌ Close knop → sluit menu
closeBtn.MouseButton1Click:Connect(function()
    menuFrame.Visible = false
end)

-- 🌌 Voidware script loader
voidBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua", true))()
end)

print("✅ Loader geladen (Key = DELTA777)")
