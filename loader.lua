local http = game:GetService("HttpService")
local yourKey = "DELTA777"
local validKeys = {
    ["DELTA777"] = true,
}

if validKeys[yourKey] then
    print("✅ Toegang verleend. Script wordt geladen...")
    
    local scriptUrl = "https://raw.githubusercontent.com/wefwef127382/inkgames.github.io/refs/heads/main/ringta.lua"
    local code = game:HttpGet(scriptUrl)
    loadstring(code)()
else
    warn("❌ Ongeldige sleutel. Script wordt niet uitgevoerd.")
end
