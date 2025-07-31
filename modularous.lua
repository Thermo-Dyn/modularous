MODE_UTIL = {}

-- TODO: Load Util
SMODS.load_file("content/utilities.lua")()
-- TODO: Register Jokers
SMODS.load_file("content/dankpods.lua")()
SMODS.load_file("content/lcbbs.lua")()
SMODS.load_file("content/music.lua")()

SMODS.Atlas {
    key = "ModeJokers",
    path = "ModeJokers.png",
    px = 71,
    py = 95,
}