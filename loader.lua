local HttpService = game:GetService("HttpService")
local userKey = "DELTA777"

local result = game:HttpGet("https://.../check?key=" .. userKey)
if result == "VALID" then
    -- GUI-code hieronder
    local player = game.Players.LocalPlayer
    local screen = Instance.new("ScreenGui", player.PlayerGui)
    local button = Instance.new("TextButton")
    button.Text = "Klik mij!"
    button.Size = UDim2.new(0, 200, 0, 50)
    button.Position = UDim2.new(0.5, -100, 0.5, -25)
    button.Parent = screen

    button.MouseButton1Click:Connect(function()
        print("Button clicked!")
    end)
else
    warn("❌ Ongeldige sleutel.")
end
