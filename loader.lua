local http = game:GetService("HttpService")
local userKey = "DELTA777"  -- Of laat gebruiker dit invullen

-- 🔐 Jouw eigen API-link hieronder
local checkUrl = "https://7b37b730-e2fb-40a9-9d37-fd10e405ad50-00-1ef12hp3tzr3h.kirk.replit.dev/check?key=" .. userKey
local result = game:HttpGet(checkUrl)

if result == "VALID" then
    print("✅ Toegang verleend via Replit API 🔐")
    local scriptUrl = "https://raw.githubusercontent.com/wefwef127382/inkgames.github.io/refs/heads/main/ringta.lua"
    local code = game:HttpGet(scriptUrl)
    loadstring(code)()
else
    warn("❌ Ongeldige sleutel.")
end
