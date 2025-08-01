MODE_UTIL = {}

SMODS.load_file("content/utilities.lua")()

MODE_UTIL.config = SMODS.current_mod.config
-- TODO: Register Jokers

if MODE_UTIL.config.dankpods then
    SMODS.load_file("content/dankpods.lua")()
end

if MODE_UTIL.config.lcbbs then
SMODS.load_file("content/lcbbs.lua")()
end

if MODE_UTIL.config.music then
SMODS.load_file("content/music.lua")()
end

SMODS.Atlas {
    key = "ModeJokers",
    path = "ModeJokers.png",
    px = 71,
    py = 95,
}