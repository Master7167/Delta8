-- loader.lua (GitHub-hosted loader)
-- Replace with your Replit verification endpoint (POST { "key": "<key>" })
local REPL_VERIFY_URL = "https://your-repl-username.your-repl-slug.repl.co/verify"

-- The requested key (you asked for DELTA777)
local KEY = "DELTA777"

-- The remote script you specified (unchanged)
local REMOTE_SCRIPT_URL = "https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/nightsintheforest.lua"

local HttpService = game:GetService("HttpService")

-- perform a POST JSON request using common exploit http functions
local function postJson(url, tbl, timeout)
    local body = HttpService:JSONEncode(tbl)
    local headers = { ["Content-Type"] = "application/json" }

    -- try syn.request
    if syn and syn.request then
        local ok, res = pcall(function()
            return syn.request({
                Url = url,
                Method = "POST",
                Headers = headers,
                Body = body,
                Timeout = timeout or 10
            })
        end)
        if ok and res and res.Body then
            return res.Body, res.StatusCode or (res.Success and 200) or nil
        end
    end

    -- try http.request
    if (http and http.request) then
        local ok, res = pcall(function()
            return http.request({
                Url = url,
                Method = "POST",
                Headers = headers,
                Body = body
            })
        end)
        if ok and res and res.Body then
            -- http.request returns table {Body = ..., StatusCode = ...} on many runtimes
            return res.Body, res.StatusCode
        end
    end

    -- try old request
    if request then
        local ok, res = pcall(function()
            return request({
                Url = url,
                Method = "POST",
                Headers = headers,
                Body = body
            })
        end)
        if ok and res and res.Body then
            return res.Body, res.StatusCode
        end
    end

    return nil, nil
end

-- contact verification server
local respBody, status = postJson(REPL_VERIFY_URL, { key = KEY })
if not respBody then
    warn("[Loader] Failed to contact verification server (" .. tostring(REPL_VERIFY_URL) .. ")")
    return
end

-- parse response
local ok, parsed = pcall(function() return HttpService:JSONDecode(respBody) end)
if not ok or type(parsed) ~= "table" then
    warn("[Loader] Invalid JSON response from verification server.")
    return
end

if not parsed.success then
    warn("[Loader] Verification failed: " .. tostring(parsed.error or "unknown"))
    return
end

-- Verified -> fetch and run the remote script (same line you asked for)
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
