-- loader.lua
-- Eenvoudige, robuuste loader die uitsluitend jouw nightsintheforest.lua laadt.

local URL = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua"

local function fetch(u)
    return game:HttpGet(u, true)
end

-- 1) Haal code op
local okGet, bodyOrErr = pcall(fetch, URL)
if not okGet then
    warn("[Loader] ❌ HTTP-fout bij ophalen: " .. tostring(bodyOrErr))
    return
end

-- 2) Compileer
local fn, compileErr = loadstring(bodyOrErr)
if not fn then
    warn("[Loader] ❌ Compile-fout: " .. tostring(compileErr))
    return
end

-- 3) Voer uit
local okRun, runErr = pcall(fn)
if not okRun then
    warn("[Loader] ❌ Runtime-fout: " .. tostring(runErr))
    return
end

print("[Loader] ✅ Succesvol geladen vanaf: " .. URL)
