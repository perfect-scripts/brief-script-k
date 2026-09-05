-- brief script loader - paste this in your executor:
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/perfect-scripts/brief-script-k/main/loader.luau"))()

local SUPPORTED = {
	[13501167264] = "Build a Raft or Die",
}

local SCRIPT_URL = "https://raw.githubusercontent.com/perfect-scripts/brief-script-k/main/script.luau?v=" .. os.time()

local gameName = SUPPORTED[game.PlaceId]
if not gameName then
	warn("[brief] place " .. game.PlaceId .. " has no script support, loader stopped")
	return
end

local lp = game:GetService("Players").LocalPlayer

local ok, src = pcall(function()
	return game:HttpGet(SCRIPT_URL)
end)
if not ok or not src or src == "" then
	warn("[brief] download failed - check your internet and try again")
	return
end

local fn, compileErr = loadstring(src)
if not fn then
	warn("[brief] script failed to compile: " .. tostring(compileErr))
	return
end

local okRun, runErr = pcall(fn)
if not okRun then
	warn("[brief] script error: " .. tostring(runErr))
	return
end
