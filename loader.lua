-- RobustLoader.lua
-- Loader die eerst een key check uitvoert via Replit, daarna je script van GitHub laadt.

local HttpService = game:GetService("HttpService")

-- Zet hier je key en Replit URL
local KEY = "DELTA777"
local KEY_CHECK_URL = "https://<jouw-replit-url>/?key=" .. KEY

-- Script dat je wilt laden vanaf GitHub
local SCRIPT_URL = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua"

-- Functie om HTTP requests te doen
local function httpGet(url)
    local ok, res = pcall(function()
        return game:HttpGet(url, true)
    end)
    if ok then return res end
    return nil, res
end

-- Stap 1: Key check via Replit
local body, err = httpGet(KEY_CHECK_URL)
if not body then
    warn("[Loader] ❌ Kon Replit niet bereiken: " .. tostring(err))
    return
end

local data = nil
pcall(function() data = HttpService:JSONDecode(body) end)

if not data or data.status ~= "ok" then
    warn("[Loader] ❌ Ongeldige key of verificatie mislukt.")
    return
end

print("[Loader] ✅ Key geverifieerd, laad script...")

-- Stap 2: Script laden vanaf GitHub
local success, result = pcall(function()
    return loadstring(game:HttpGet(SCRIPT_URL, true))()
end)

if success then
    print("[Loader] ✅ Script succesvol geladen.")
else
    warn("[Loader] ❌ Fout bij laden: " .. tostring(result))
end
