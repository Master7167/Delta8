-- Loader.lua
-- Key: DELTA777
-- Mobile-compatible GUI
-- Script loader voor Speed Hub X en Voidware

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- Key System
local correctKey = "DELTA777"
local keyGui
local mainGui
local isGuiOpen = false

-- Scripts info
local scripts = {
    ["Speed Hub X"] = "https://raw.githubusercontent.com/AhmadV99/Speed-Hub-X/main/Speed%20Hub%20X.lua",
    ["Voidware"] = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua"
}

-- Function to create Key GUI
local function createKeyGui()
    keyGui = Instance.new("ScreenGui")
    keyGui.Name = "KeyGui"
    keyGui.ResetOnSpawn = false
    keyGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = keyGui

    local textbox = Instance.new("TextBox")
    textbox.PlaceholderText = "Enter Key"
    textbox.Size = UDim2.new(0, 280, 0, 50)
    textbox.Position = UDim2.new(0, 10, 0, 20)
    textbox.BackgroundColor3 = Color3.fromRGB(50,50,50)
    textbox.TextColor3 = Color3.new(1,1,1)
    textbox.ClearTextOnFocus = true
    textbox.Parent = frame

    local button = Instance.new("TextButton")
    button.Text = "Submit"
    button.Size = UDim2.new(0, 280, 0, 40)
    button.Position = UDim2.new(0, 10, 0, 80)
    button.BackgroundColor3 = Color3.fromRGB(70,70,70)
    button.TextColor3 = Color3.new(1,1,1)
    button.Parent = frame

    button.MouseButton1Click:Connect(function()
        if textbox.Text == correctKey then
            keyGui:Destroy()
            createMainGui()
        else
            textbox.Text = ""
            textbox.PlaceholderText = "Wrong Key!"
        end
    end)
end

-- Function to create main GUI
function createMainGui()
    mainGui = Instance.new("ScreenGui")
    mainGui.Name = "LoaderGui"
    mainGui.ResetOnSpawn = false
    mainGui.Parent = player:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 200)
    frame.Position = UDim2.new(0.5, -150, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel = 0
    frame.Parent = mainGui

    local title = Instance.new("TextLabel")
    title.Text = "Loader Menu"
    title.Size = UDim2.new(1,0,0,30)
    title.BackgroundTransparency = 1
    title.TextColor3 = Color3.new(1,1,1)
    title.TextScaled = true
    title.Parent = frame

    local yPos = 40
    for name, url in pairs(scripts) do
        local btn = Instance.new("TextButton")
        btn.Text = name
        btn.Size = UDim2.new(0, 280, 0, 40)
        btn.Position = UDim2.new(0, 10, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Parent = frame
        yPos = yPos + 50

        btn.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet(url, true))()
        end)
    end
end

-- Toggle GUI on Mobile or via keyboard
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightControl then -- Toggle GUI with Right Ctrl
        if mainGui then
            mainGui.Enabled = not mainGui.Enabled
        end
    end
end)

createKeyGui()
