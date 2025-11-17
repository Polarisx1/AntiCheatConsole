-- Loader snippet: load this from your executor or Studio
local URL = "https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/AntiCheatConsole/main/AntiCheatConsole.lua"

local fn, err = pcall(function()
    return loadstring(game:HttpGet(URL, true))
end)

if not fn or not fn() then
    warn("Failed to load AntiCheatConsole:", err)
    return
end

-- Initialize controller
local controller = fn()()
controller:Init({ localScript = script }) -- optional: pass your LocalScript if running inside Roblox
