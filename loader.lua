-- loader.lua (GitHub-hosted loader)
-- Set this to your Replit verify endpoint (example: "https://your-repl-username.your-slug.repl.co/verify")
local REPL_VERIFY_URL = "https://your-repl-username.your-repl-slug.repl.co/verify"

-- The key you asked for (for demo). For production, avoid embedding keys in public files.
local KEY = "DELTA777"

-- The remote script to run if verification passes
local REMOTE_SCRIPT_URL = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua"

local HttpService = game:GetService("HttpService")

local function postJson(url, tbl)
    local body = HttpService:JSONEncode(tbl)
    local headers = { ["Content-Type"] = "application/json" }

    -- Try syn.request (common in modern exploits)
    if syn and syn.request then
        local ok, res = pcall(function()
            return syn.request({ Url = url, Method = "POST", Headers = headers, Body = body, Timeout = 10 })
        end)
        if ok and res and res.Body then
            return res.Body, res.StatusCode or (res.Success and 200) or nil
        end
    end

    -- Try http.request
    if http and http.request then
        local ok, res = pcall(function()
            return http.request({ Url = url, Method = "POST", Headers = headers, Body = body })
        end)
        if ok and res and res.Body then
            return res.Body, res.StatusCode
        end
    end

    -- Try legacy request
    if request then
        local ok, res = pcall(function()
            return request({ Url = url, Method = "POST", Headers = headers, Body = body })
        end)
        if ok and res and res.Body then
            return res.Body, res.StatusCode
        end
    end

    return nil, nil
end

-- Contact verification server
local respBody, status = postJson(REPL_VERIFY_URL, { key = KEY })
if not respBody then
    warn("[Loader] Failed to contact verification server (" .. tostring(REPL_VERIFY_URL) .. ")")
    return
end

-- Parse response
local ok, parsed = pcall(function() return HttpService:JSONDecode(respBody) end)
if not ok or type(parsed) ~= "table" then
    warn("[Loader] Invalid JSON response from verification server.")
    return
end

if not parsed.success then
    warn("[Loader] Verification failed: " .. tostring(parsed.error or "unknown"))
    return
end

-- Verified -> fetch and run the remote script
local okFetch, fetched = pcall(function()
    return game:HttpGet(REMOTE_SCRIPT_URL, true)
end)
if not okFetch or type(fetched) ~= "string" then
    warn("[Loader] Failed to fetch remote script from GitHub:", tostring(fetched))
    return
end

local okRun, err = pcall(function()
    local f = loadstring(fetched)
    if type(f) == "function" then
        f()
    else
        error("Loaded content is not a function")
    end
end)
if not okRun then
    warn("[Loader] Error executing remote script:", tostring(err))
end
