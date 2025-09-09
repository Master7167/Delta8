-- Roblox loader met key system
local correctKey = "DELTA777"

-- Vraag de speler om key
local Players = game:GetService("Players")
local player = Players.LocalPlayer
if not player then
    warn("LocalPlayer niet gevonden. Script kan niet draaien.")
    return
end

local success, input = pcall(function()
    return player:PromptInput("Voer je key in:", "")
end)

if not success or not input then
    warn("Kon key input niet ophalen.")
    return
end

-- Controleer key
if input == correctKey then
    print("Key correct! Script wordt geladen...")

    -- Laad extern script van GitHub
    local url = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua"
    local loadSuccess, err = pcall(function()
        loadstring(game:HttpGet(url, true))()
    end)

    if not loadSuccess then
        warn("Fout bij laden van extern script:", err)
    end
else
    warn("Ongeldige key!")
end
