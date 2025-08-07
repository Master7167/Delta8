local HttpService = game:GetService("HttpService")
local userKey = "DELTA777"

local result = HttpService:GetAsync(
    "https://7b37b730-e2fb-40a9-9d37-fd10e405ad50-00-1ef12hp3tzr3h.kirk.replit.dev/check?key=" .. userKey
)

if result == "VALID" then
    local player = game.Players.LocalPlayer
    local screen = Instance.new("ScreenGui")
    screen.Name = "MyCustomGUI"
    screen.Parent = player:WaitForChild("PlayerGui")

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, 0.5, -25)
    button.Text = "Klik mij!"
    button.Parent = screen

    button.MouseButton1Click:Connect(function()
        print("✅ Knop is ingedrukt!")
    end)
else
    warn("❌ Ongeldige sleutel.")
end
