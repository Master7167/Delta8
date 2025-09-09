-- Roblox loader met key system
local correctKey = "DELTA777"

-- Functie om key input veilig te vragen
local function getUserKey()
    local player = game:GetService("Players").LocalPlayer
    if not player then
        warn("Kan de speler niet vinden. Script kan niet draaien.")
        return nil
    end

    -- PromptInput werkt alleen bij LocalPlayer in Roblox
    local success, input = pcall(function()
        return player:PromptInput("Voer je key in:", "")
    end)

    if success then
        return tostring(input)
    else
        warn("Kon key input niet ophalen:", input)
        return nil
    end
end

-- Verkrijg de key van de gebruiker
local userKey = getUserKey()

if userKey == correctKey then
    print("Key geaccepteerd! Script wordt geladen...")

    -- URL van het externe script
    local url = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua"

    -- Probeer het externe script te laden
    local success, err = pcall(function()
        local httpGet = game:HttpGet
        if not httpGet then
            error("HttpGet niet beschikbaar. Zorg dat je een exploit gebruikt die HttpGet ondersteunt.")
        end
        loadstring(httpGet(url, true))()
    end)

    if not success then
        warn("Fout bij laden van extern script:", err)
    end
else
    warn("Ongeldige key! Je kunt dit script niet gebruiken.")
end
