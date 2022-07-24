darkrp_ls = {}
darkrp_ls.language = {}
darkrp_ls.db = "darkrp_levelsystem"
darkrp_ls.extension = "includes/extensions/player_level.lua"

----------------------------------
------------- Convars ------------
----------------------------------
if SERVER then

-- Generic convars
CreateConVar("darkrp_ls_connections", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player connects.")
CreateConVar("darkrp_ls_kills", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player kills someone.")
CreateConVar("darkrp_ls_deaths", "3", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player dies.")
CreateConVar("darkrp_ls_chats", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player talks.")
CreateConVar("darkrp_ls_physgun", "2", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player uses the physgun.")

-- DarkRP convars
CreateConVar("darkrp_ls_buy_shipment", "25", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a buys a shipment.")
CreateConVar("darkrp_ls_buy_ammo", "2", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a buys ammo.")
CreateConVar("darkrp_ls_buy_vehicle", "10", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a buys a vehicle.")
CreateConVar("darkrp_ls_buy_weapon", "5", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a buys a weapon.")
CreateConVar("darkrp_ls_buy_door", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a buys a door.")
CreateConVar("darkrp_ls_player_arrested", "2", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player is arrested.")
CreateConVar("darkrp_ls_player_arrest", "10", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player arrests someone.")
CreateConVar("darkrp_ls_player_salary", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player gets paid.")
CreateConVar("darkrp_ls_player_lockpick", "10", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player lockpick a door.")
CreateConVar("darkrp_ls_player_hit_success", "60", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player hits someone successfully.")
CreateConVar("darkrp_ls_player_hit_fail", "15", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player hits someone unsuccessfully.")
CreateConVar("darkrp_ls_player_license", "10", {FCVAR_ARCHIVE, FCVAR_NOTIFY}, "The amount of xp to get when a player gets a license.")
end

CreateClientConVar("darkrp_ls_notify", "1", true, true, "Should the player be notified when they level up?")
CreateClientConVar("darkrp_ls_notify_sound", "1", true, true, "Should the player be notified with a sound when they level up?")
CreateClientConVar("darkrp_ls_notify_chat", "0", true, true, "Should the player be notified with a chat message when they level up?")


if SERVER and not sql.TableExists(darkrp_ls.db) then
    sql.Query([[CREATE TABLE IF NOT EXISTS ]] .. darkrp_ls.db .. [[(
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        player INTEGER NOT NULL,
        plyname VARCHAR(255) NOT NULL,
        level INTEGER NOT NULL DEFAULT 1,
        xp INTEGER NOT NULL DEFAULT 0
    )]])
end

----------------------------------
------------ Functions -----------
----------------------------------

local function AddFile(file, dir)
    local prefix = string.lower(string.Left(file, 3))
    if SERVER and (prefix == "sv_") then
        include(dir .. file)
        print("[DARKRP-LS] SERVER INCLUDE: " .. file)
    elseif (prefix == "sh_") then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print("[DARKRP-LS] SHARED ADDCS: " .. file)
        end
        include(dir .. file)
        print("[DARKRP-LS] SHARED INCLUDE: " .. file)
    elseif (prefix == "cl_") then
        if SERVER then
            AddCSLuaFile(dir .. file)
            print("[DARKRP-LS] CLIENT ADDCS: " .. file)
        elseif CLIENT then
            include(dir .. file)
            print("[DARKRP-LS] CLIENT INCLUDE: " .. file)
        end
    end
end

local function AddExtension()
    local dir = "includes/extensions/darkrp_level/"
    local files = file.Find(dir .. "*.lua", "LUA")
    for _, file in pairs(files) do
        include(dir .. file)
        print("[DARKRP-LS] EXTENSION INCLUDE: " .. file)
    end
end

local function AddDir(dir)
    dir = dir .. "/"

    local files, directories = file.Find(dir .. "*", "LUA")
    for _, v in ipairs(files) do
        if string.EndsWith(v, ".lua") then
            AddFile(v, dir)
        end
    end

    for _, v in ipairs(directories) do AddDir(dir .. v) end
end
AddDir("darkrp-ls")
AddExtension()