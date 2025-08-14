MODE_UTIL.cfg = SMODS.current_mod.config

SMODS.current_mod.optional_features = function ()
    return {
        quantum_enhancements = true,
        cardareas = {deck = true}
    }
end

--[[

Thank you to the Paperback Team for writing these!!
I'm stupit......

]]
-- Initialize Food pool if not existing, which may be created by other mods.
-- Any joker can add itself to this pool by adding a pools table to its definition
-- Credits to Cryptid for the idea
if not SMODS.ObjectTypes.Food then
    SMODS.ObjectType {
        key = 'Food',
        default = 'j_egg',
        cards = {},
        inject = function(self)
            SMODS.ObjectType.inject(self)
            -- Insert base game food jokers
            for k, _ in pairs(MODE_UTIL.vanilla_food) do
                self:inject_card(G.P_CENTERS[k])
            end
        end
    }
end

MODE_UTIL.vanilla_food = {
    j_gros_michel = true,
    j_egg = true,
    j_ice_cream = true,
    j_cavendish = true,
    j_turtle_bean = true,
    j_diet_cola = true,
    j_popcorn = true,
    j_ramen = true,
    j_selzer = true,
}

function MODE_UTIL.is_food(card)
    local center = type(card) == "string"
        and G.P_CENTERS[card]
        or (card.config and card.config.center)

    if not center then
        return false
    end

    -- If the center has the Food pool in its definition
    if center.pools and center.pools.Food then
        return true
    end

    -- If it doesn't, we check if this is a vanilla food joker
    return MODE_UTIL.vanilla_food[center.key]
end

if not SMODS.ObjectTypes.Music then
    SMODS.ObjectType {
        key = 'Music',
        cards = {},
        inject = function(self)
            SMODS.ObjectType.inject(self)
        end
    }
end

function MODE_UTIL.is_music(card)
    local center = type(card) == "string"
        and G.P_CENTERS[card]
        or (card.config and card.config.center)

    if not center then
        return false
    end

    -- If the center has the Music pool in its definition
    if center.pools and center.pools.Music then
        return true
    end

    return false
end

function MODE_UTIL.arrays_equal(a, b)
    if #a ~= #b then return false end
    for i = 1, #a do
        if a[i] ~= b[i] then
            return false
        end
    end
    return true
end

function MODE_UTIL.check_suit(card, key)
    local switch = function(key)
        local case = {
            ["light_suit"] = (card:is_suit("Hearts") or card:is_suit("Diamonds") or card:is_suit("paperback_Stars") or card:is_suit("bunc_Fleurons")),
            ["dark_suit"] = (card:is_suit("Spades") or card:is_suit("Clubs") or card:is_suit("paperback_Crowns") or card:is_suit("bunc_Halberds")),
            ["hearts"] = card:is_suit("Hearts"),
            ["clubs"] = card:is_suit("Clubs"),
            ["spades"] = card:is_suit("Spades"),
            ["diamonds"] = card:is_suit("Diamonds")
        }
        if case[key] then
            return case[key]
        end
        return false
    end

    return switch(key)
end

-- Thanks Paperback!
---Destroys the provided Joker
---@param card table
---@param after function?
function MODE_UTIL.destroy_joker(card, after)
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.3,
                blockable = false,
                func = function()
                    G.jokers:remove_card(card)
                    card:remove()

                    if after and type(after) == "function" then
                        after()
                    end

                    return true
                end
            }))
            return true
        end
    }))
end

function MODE_UTIL.check_joker_position(card)
    local ret = {index = 0, named_index = ''}
    for i, v in ipairs(G.jokers.cards) do
        if v == card then
            ret.index = i
            if i == 1 and #G.jokers.cards >= G.jokers.config.card_limit then
                ret.named_index = 'first'
            elseif #G.jokers.cards >= G.jokers.config.card_limit and i == #G.jokers.cards then
                ret.named_index = 'last'
            else
                ret.named_index = 'middle'
            end
            return ret
        end
    end
end

local function calc_set(set_table)
    local ret = {}
    for i, c in ipairs(set_table) do
        if i == 1 then
            ret[1] = c
            goto continue
        end
        if c == ret[i-1] then
            ret[#ret+1] = c
            goto continue
        end
        if (i+1) <= #set_table then
            if c == set_table[i+1] then
                ret[#ret+1] = c
                goto continue
            end
        end
        ::continue::
    end
    if #ret < 2 then
        return 0
    end
    return #ret
end

local function calc_run(run_table)
    local ret = 0
    local run_scored = {}
    for i = 1, #run_table, 1 do
        local seen = {}
            for j = i, #run_table, 1 do
                if seen[run_table[i]] then
                    goto con
                else
                    seen[#seen+1] = run_table[j]
                end
            end
        ::con::
        if #seen < 3 then
            goto con2
        end
        table.sort(seen)
        if #seen == (seen[#seen] - seen[1] + 1) then
            if next(run_scored) then table.remove(run_scored, #run_scored) end
            if MODE_UTIL.arrays_equal(run_scored, seen) then
                goto con2
            end
            run_scored = seen
            ret = ret + #seen
        end
        ::con2::
    end
    return ret
end


function MODE_UTIL.calculate_cribbage_score(card_table)
    local ret = 0
    if not next(card_table) then
        return ret
    end
    if card_table[1] == 11 then
        ret = ret + 1
    end
    local set_table = calc_set(card_table)
    local run_table = calc_run(card_table)
    ret = ret + set_table + run_table
    if MODE_UTIL.sum_array(card_table, true) == 15 or MODE_UTIL.sum_array(card_table, true) == 31 then
        ret = ret + 1
    end
    return ret
end

function MODE_UTIL.sum_array(table, cards)
    local sum = 0
    for i = 1, #table, 1 do
        if cards then
            if table[i] == 14 then
                sum = sum + 1
            elseif table[i] > 10 then
                sum = sum + 10
            else
                sum = sum + table[i]
            end
        else
            sum = sum + table[i]
        end
    end
    return sum
end

function MODE_UTIL.spread_flesh(card, enhancement)
    local index = 0
    for i, c in ipairs(G.hand.cards) do
        if c == card then
            index = i
        end
    end
    if G.hand.cards[index - 1] and not MODE_UTIL.is_flesh(G.hand.cards[index - 1]) then
        G.hand.cards[index - 1]:set_ability(enhancement or 'm_mode_flesh_zygote', nil, true)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand.cards[index - 1]:juice_up()
                play_sound('mode_squish', 0.96 + math.random() * 0.08)
                return true
            end
        }))
    end
    if G.hand.cards[index + 1] and not MODE_UTIL.is_flesh(G.hand.cards[index + 1]) then
        G.hand.cards[index + 1]:set_ability(enhancement or 'm_mode_flesh_zygote', nil, true)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.hand.cards[index + 1]:juice_up()
                play_sound('mode_squish', 0.96 + math.random() * 0.08)
                return true
            end
        }))
    end
end

function MODE_UTIL.upgrade_flesh(card, enhancements)
    local enhancement = pseudorandom_element(enhancements, "XBPGH")
    print(enhancement)
    if type(enhancement) == "string" then
        card:set_ability(enhancement, nil, true)
        G.E_MANAGER:add_event(Event({
            func = function()
                card:juice_up()
                play_sound('mode_squish', 0.96 + math.random() * 0.08)
                return true
            end
        }))
    end


end

function MODE_UTIL.is_flesh(card)
    local center = type(card) == "string"
        and G.P_CENTERS[card]
        or (card.config and card.config.center)
    if not center then
        return false
    end

    -- If the center has the Flesh pool in its definition
    if center.pools and center.pools.Flesh then
        return true
    end
end

-- Config UI, thanks paperback!
-- Create config UI
---@diagnostic disable-next-line: duplicate-set-field
SMODS.current_mod.config_tab = function()
  return {
    n = G.UIT.ROOT,
    config = { align = 'cm', padding = 0.05, emboss = 0.05, r = 0.1, colour = G.C.BLACK },
    nodes = {
      {
        n = G.UIT.R,
        config = { align = 'cm', minh = 1 },
        nodes = {
          {
            n = G.UIT.T,
            config = {
              text = localize('mode_ui_requires_restart'),
              colour = G.C.RED,
              scale = 0.5
            }
          }
        }
      },
      {
        n = G.UIT.R,
        config = { align = 'cm' },
        nodes = {
          {
            n = G.UIT.C,
            nodes = {
              create_toggle {
                label = localize('mode_ui_enable_dankpods'),
                ref_table = MODE_UTIL.config,
                ref_value = 'dankpods'
              },
              create_toggle {
                label = localize('mode_ui_enable_lcbbs'),
                ref_table = MODE_UTIL.config,
                ref_value = 'lcbbs',
              },
              create_toggle {
                label = localize('mode_ui_enable_music'),
                ref_table = MODE_UTIL.config,
                ref_value = 'music'
              },
              create_toggle {
                label = localize('mode_ui_enable_extra'),
                ref_table = MODE_UTIL.config,
                ref_value = 'extra',
              }
            }
          } 
        }
      }
    }
  }
end

-- Thanks Kirbio from UnStable!
--Hook into is_face to account for Eye Flesh
local card_isfaceref = Card.is_face
---@diagnostic disable-next-line: duplicate-set-field
function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
	
	if SMODS.has_enhancement(self, 'm_mode_flesh_eye') then
		return true
	end
	
	return card_isfaceref(self, from_boss)
end

local emplace_ref = CardArea.emplace
---@diagnostic disable-next-line: duplicate-set-field
function CardArea.emplace(self, card, location, stay_flipped)
local joker = SMODS.find_card("j_mode_poor_bonus")
    if next(joker) and self == G.consumeables then
        --print("-1 hand size!")
        card.config.emplaced = true
        G.hand:change_size(-joker[1].ability.extra.h_mod)
    end
    return emplace_ref(self, card, location, stay_flipped)
end

local remove = Card.remove
---@diagnostic disable-next-line: duplicate-set-field
function Card.remove(self)
    local joker = SMODS.find_card("j_mode_poor_bonus")
    if next(joker) and self.config.emplaced then
        G.hand:change_size(joker[1].ability.extra.h_mod)
    end
    return remove(self)
end

local sellable = Card.can_sell_card
---@diagnostic disable-next-line: duplicate-set-field
function Card:can_sell_card(context)
    if self.ability.mode_now_playing then
        return false
    end
    return sellable(self, context)
end

local remove_card = Card.remove_from_deck
---@diagnostic disable-next-line: duplicate-set-field
function Card:remove_from_deck(from_debuff)
    remove_card(self, from_debuff)
    if self.ability.mode_now_playing then
        SMODS.Stickers.mode_now_playing:apply(self)
    end
end

local setcost = Card.set_cost
---@diagnostic disable-next-line: duplicate-set-field
function Card:set_cost()
    setcost(self)
    if self.ability.mode_now_playing then
        self.sell_cost = 0
    end
end

-- Also from Paperback. Thanks!
local end_round_ref = end_round
---@diagnostic disable-next-line: lowercase-global
function end_round()
    for _, v in ipairs(G.jokers and G.jokers.cards or {}) do
        if v.ability.mode_now_playing and G.GAME.blind:get_type() == 'Boss' then
            MODE_UTIL.destroy_joker(v) -- destroy the joker after boss blind has been defeated
        end
    end

    return end_round_ref()
end