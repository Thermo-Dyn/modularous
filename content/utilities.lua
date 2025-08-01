MODE_UTIL.cfg = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
    quantum_enhancements = true,
}

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


-- Config UI, thanks paperback!
-- Create config UI
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