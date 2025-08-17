-- RobustLoader.lua
local HttpService = game:GetService("HttpService")

local URLS = {
    "https://raw.githubusercontent.com/indexeduu/BF-NewVer/main/V3New.lua", -- juiste raw
    "https://418024f4-b9de-4bba-bece-77d32f5a843a-00-ahhy1q03e8ly.worf.replit.dev/", -- jouw Replit
}

local function httpFetch(url)
    -- Probeer executors (game:HttpGet), dan Studio (HttpService:GetAsync)
    local ok, res = pcall(function()
        if typeof(game.HttpGet) == "function" then
            return game:HttpGet(url, true)
        else
            return HttpService:GetAsync(url, true)
        end
    end)
    if ok then return res end
    return nil, res
end

local function looksLikeHTML(s)
    if not s then return false end
    local h = s:sub(1, 200):lower()
    return h:find("<!doctype", 1, true) or h:find("<html", 1, true)
end

local function tryLoadFrom(url)
    print("[Loader] Fetch: " .. url)
    local body, err = httpFetch(url)
    if not body then
        warn("[Loader] HTTP-fout: " .. tostring(err))
        return false
    end
    if looksLikeHTML(body) then
        warn("[Loader] Server gaf HTML (waarschijnlijk error/redirect). Snippet:\n" .. body:sub(1, 200))
        return false
    end
    local fn, compErr = loadstring(body)
    if not fn then
        warn("[Loader] Compile error:\n" .. tostring(compErr) .. "\nSnippet:\n" .. body:sub(1, 200))
        return false
    end
    local ok, runErr = pcall(fn)
    if not ok then
        warn("[Loader] Runtime error: " .. tostring(runErr))
        return false
    end
    print("[Loader] ✅ Succesvol geladen van: " .. url)
    return true
end

local loaded = false
for _, u in ipairs(URLS) do
    if tryLoadFrom(u) then
        loaded = true
        break
    end
end

if not loaded then
    warn("[Loader] ❌ Kon geen enkele bron laden.")
    warn("[Hints] - Gebruik de GitHub raw-link (zoals hierboven).")
    warn("[Hints] - In Studio: zet 'Allow HTTP Requests' AAN en 'LoadStringEnabled' AAN.")
end
