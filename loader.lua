local HttpService = game:GetService("HttpService")
local userKey = "DELTA777" -- <-- Jouw key

-- Replit API endpoint
local checkUrl = "https://7b37b730-e2fb-40a9-9d37-fd10e405ad50-00-1ef12hp3tzr3h.kirk.replit.dev/check?key=" .. userKey
local result = game:HttpGet(checkUrl)

if result == "VALID" then
    print("✅ Key is geldig! GUI wordt geladen...")

    local player = game:GetService("Players").LocalPlayer
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "MySecureGui"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = player:WaitForChild("PlayerGui")

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, 0.5, -25)
    button.Text = "Klik hier!"
    button.TextScaled = true
    button.Parent = screenGui

    button.MouseButton1Click:Connect(function()
        print("🔘 Knop ingedrukt!")
    end)
else
    warn("❌ Ongeldige sleutel.")
end
