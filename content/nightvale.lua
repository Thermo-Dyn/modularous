SMODS.Joker { -- Tan Jacket
    key = 'tan_jacket',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            chips = 50
        }
    },
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 0, y = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips}}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:is_face() then
                return { chips = card.ability.extra.chips}
            end
        end
    end
}

SMODS.Joker { -- Manual On Interlopers
    key = 'interlopers',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            chips_add = 8,
            chips = 0
        }
    },
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 5,
    pos = { x = 1, y = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips_add, card.ability.extra.chips}}
    end,
    calculate = function (self, card, context)
        if context.card_added and context.card.ability.consumeable and not context.blueprint_card then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra, -- the table that has the value you are changing in
                ref_value = "chips", -- the key to the value in the ref_table
                scalar_value = "chips_add", -- the key to the value to scale by, in the ref_table by default,
                scaling_message = {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.CHIPS
                }
            })
        end
        if context.joker_main then
            return {chips = card.ability.extra.chips}
        end
    end
}

SMODS.Joker { -- Faceless old Joker
    key = 'faceless_old_joker',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            max_destroy = 4
        }
    },
    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 2, y = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips_add, card.ability.extra.chips}}
    end,
    calculate = function (self, card, context)
        if context.setting_blind then
            local chips_to_add = 0
            local cards_to_destroy = {}
            local count = pseudorandom("faceless", 1, math.min(card.ability.extra.max_destroy, #G.playing_cards))
            for i = 1, count, 1 do
                cards_to_destroy[i] = pseudorandom_element(G.playing_cards, "faceless")
            end
            for _, v in ipairs(cards_to_destroy) do
                chips_to_add = chips_to_add + v:get_chip_bonus()
            end
            SMODS.destroy_cards(cards_to_destroy)
            local recieving_card = pseudorandom_element(G.playing_cards, "faceless")
            if not recieving_card then
                return
            end
            recieving_card.ability.perma_bonus = (recieving_card.ability.perma_bonus or 0) + math.ceil(chips_to_add/2)
            return {
                message = "killed :)"
            }
        end
    end
    }

SMODS.Joker { -- Hiram McDaniels
    key = 'hiram_mcdaniels',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            chips = 120
        }
    },
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 5,
    pos = { x = 3, y = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips}}
    end,
    calculate = function (self, card, context)
        if context.joker_main then
            local face_count = 0
            for _, v in ipairs(G.play.cards) do
                if v:is_face() then
                    face_count = face_count + 1
                end
            end
            if face_count == 5 then
                return { chips = card.ability.extra.chips}
            end
        end
    end
}

SMODS.Joker { -- Pizza
    key = 'pizza',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            hearts = 0,
            diamonds = 0,
            mult = 12
        }
    },
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 4,
    pos = { x = 4, y = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult}}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint_card then
            if MODE_UTIL.check_suit(context.other_card, "hearts") then
                card.ability.extra.hearts = card.ability.extra.hearts + 1
            end
            if MODE_UTIL.check_suit(context.other_card, "diamonds") then
                card.ability.extra.diamonds = card.ability.extra.diamonds + 1
            end
        end
        if context.joker_main and card.ability.extra.hearts > 0 and card.ability.extra.diamonds > 0 then
            card.ability.extra.diamonds = 0
            card.ability.extra.hearts = 0
            return { mult = card.ability.extra.mult}
        end
    end
}

SMODS.Joker { -- Night Vale Lottery
    key = 'lottery',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            dollars = 12
        }
    },
    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 5, y = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.dollars}}
    end,
    calculate = function (self, card, context)
        if context.discard and not context.blueprint_card then
            if context.other_card:get_seal() == 'Purple' then
                return { remove = true, dollars = card.ability.extra.dollars }
            end
        end
    end
}

SMODS.Joker { -- Dark Planet
    key = 'dark_planet',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            odds = 3,
            last_planet = 'c_mode_no_planet',
            last_name = 'None'
        }
    },
    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = {x = 6, y = 5},
    loc_vars = function (self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'identifier') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
        return { vars = { new_numerator, new_denominator, card.ability.extra.last_name } }
    end,
    calculate = function (self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == "Planet" then
            card.ability.extra.last_planet = context.consumeable.config.center_key
            card.ability.extra.last_name = context.consumeable.ability.name
        end
        if context.ending_shop and card.ability.extra.last_planet ~= "c_mode_no_planet" then
            if SMODS.pseudorandom_probability(card, 'Titan', 1, card.ability.extra.odds, 'j_mode_dark_planet') then
                local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local consumable_card = create_card('Planet', G.consumeables, nil, nil, nil, nil, card.ability.extra.last_planet, 'mode')
                            consumable_card:add_to_deck()
                            G.consumeables:emplace(consumable_card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                    { message = created_consumable and localize('k_plus_planet') or nil, colour = G.C.BLUE })
            end
        end
    end
}

SMODS.Joker { -- Erika
    key = 'erika',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            money = 10,
            chips = 40
        }
    },
    atlas = "ModeJokers",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 10,
    pos = { x = 7, y = 5},
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.money, card.ability.extra.chips*(math.floor(G.GAME.dollars/10)) } }
    end,
    calculate =  function (self, card, context)
        if context.joker_main and G.GAME.dollars >= card.ability.extra.money then
            return {chips = card.ability.extra.chips*(math.floor(G.GAME.dollars/10))}
        end
    end
}