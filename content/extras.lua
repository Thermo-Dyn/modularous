
SMODS.Joker { -- Cow Tools
    key = "cow_tools",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 5,
    pos = { x = 1, y = 3 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local clubs = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if MODE_UTIL.check_suit(scored_card, "clubs") then
                    clubs = clubs + 1
                    scored_card:set_ability('m_bonus', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if clubs > 0 then
                return {
                    message = localize('mode_k_bonus'),
                    colour = G.C.BLUE
                }
            end
        end
    end
}

--[[
SMODS.Joker { -- El Zoomo!
    key = "el_zoomo",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 2, y = 3 },
    loc_vars = function (self, info_queue, card)
    end,
    calculate = function(self, card, context)
    end
}
]]

SMODS.Joker { -- Jimbo Holding 2 Oranges
    key = "jimbo_holding_2_oranges",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    config = { extra = {
        loc_good_effects = {
            "+100 Chips",
            "+20 Mult",
            "X2 Mult"
        },
        loc_bad_effects = {
            "-75 Chips",
            "-8 Mult",
            "X0.75 Mult"
        },
        good_effects = {
            100,
            20,
            2,
        },
        bad_effects = {
            -75,
            -8,
            0.75,
        },
        active_effects = {1,1}
    }},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 3, y = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = {
            card.ability.extra.loc_good_effects[card.ability.extra.active_effects[1]],
            card.ability.extra.loc_bad_effects[card.ability.extra.active_effects[2]]
        }}
    end,

    calculate = function(self, card, context)
        local chips = 0
        local mult = 0
        local xmult = 1
        if context.setting_blind and not context.blueprint_card then
            card.ability.extra.active_effects[1] = pseudorandom("good", 1, 3)
            card.ability.extra.active_effects[2] = pseudorandom("bad", 1, 3)
        end
        if context.cardarea == G.jokers and context.joker_main then
            local chips = 0
            local mult = 0
            local xmult = 1
            if card.ability.extra.active_effects[1] == 1 then
                chips = chips + card.ability.extra.good_effects[1]
            elseif card.ability.extra.active_effects[1] == 2 then
                mult = mult + card.ability.extra.good_effects[2]
            elseif card.ability.extra.active_effects[1] == 3 then
                xmult = xmult * card.ability.extra.good_effects[3]
            end

            if card.ability.extra.active_effects[2] == 1 then
                chips = chips + card.ability.extra.bad_effects[1]
            elseif card.ability.extra.active_effects[2] == 2 then
                mult = mult + card.ability.extra.bad_effects[2]
            elseif card.ability.extra.active_effects[2] == 3 then
                xmult = xmult * card.ability.extra.bad_effects[3]
            end
        
            return {
            chips = chips,
            mult = mult,
            xmult = xmult
        }

        end

    end
}


SMODS.Joker { -- Quiet, Isn't It?
    key = "quiet",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    config = { extra = {mult = 0, bonus = 7}},
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 4, y = 3 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.bonus}}
    end,
    calculate = function(self, card, context)
        if context.open_booster and not context.blueprint_card then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.bonus
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.bonus } },
                colour = G.C.RED,
            }
        end
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
    end
}

--[[
SMODS.Joker { -- Sonic Screwdriver
    key = "sonic_screwdriver",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 5, y = 3 },
    loc_vars = function (self, info_queue, card)
    end,
    calculate = function(self, card, context)
    end
}
]]

SMODS.Joker { -- Mondassian Upgrade
    key = "mondassian_upgrade",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 6, y = 3 },
    loc_vars = function (self, info_queue, card)
    end,
    calculate = function(self, card, context)
        if context.check_enhancement then
            if SMODS.Ranks[context.other_card.base.value].face then
                return { m_steel = true }
            end
            if context.other_card.ability.effect == "Gold Card" or context.other_card:get_seal(false) == "Gold" or card.ability["paperback_gold_clip"] then
                SMODS.destroy_cards(card)
            end
        end
    end
}


SMODS.Joker { -- Cybermat
    key = "cybermat",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 7, y = 3 },
    loc_vars = function (self, info_queue, card)
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_face() then
                    faces = faces + 1
                    scored_card:set_ability('m_steel', nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if faces > 0 then
                return {
                    message = localize('k_steel'),
                    colour = G.C.GREY
                }
            end
        end
    end
}

--[[
SMODS.Joker { -- Poor Bonus
    key = "poor_bonus",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    config = { extra = {
        h_size = 4
    }},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 8, y = 3 },
    loc_vars = function (self, info_queue, card)
    end,
    calculate = function(self, card, context)
    end,
    update = function (self, card, dt)
        if not (card.ability.extra.h_size - #G.consumeables.cards + (G.hand.config.last_poll_size or 0) == #G.hand.cards) then
            local difference = card.ability.extra.h_size - #G.consumeables.cards + (G.hand.config.last_poll_size or 0) - #G.hand.cards
            G.hand:change_size(difference)
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.h_size - #G.consumeables.cards)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-(card.ability.extra.h_size - #G.consumeables.cards))
    end
} ]]


--[[
SMODS.Joker { -- Mystery Play
    key = "mystery_play",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 9, y = 3 },
    loc_vars = function (self, info_queue, card)
    end,
    calculate = function(self, card, context)
    end
}
]]
--[[
SMODS.Joker { -- Smug Jug
    key = "smug_jug",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 5,
    pos = { x = 0, y = 4 },
    loc_vars = function (self, info_queue, card)
    end,
    calculate = function(self, card, context)
    end
}
]]
