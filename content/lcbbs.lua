SMODS.Joker { -- Hobby Studio
    key = 'hobby_studio',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            chips = 70
        }
    },
    pools = {
        lcbbs = true
    },
    in_pool = function(self, args)
        for _, v in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(v, "m_bonus") then
                return true
            end
        end
    end,

    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 3, y = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and SMODS.has_enhancement(context.other_card, "m_bonus") then
            return {
                chips = card.ability.extra.chips,
                card = card
            }
        end
    end
}

SMODS.Joker { -- Malware
    key = "malware",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 1,
    pools = {
        lcbbs = true
    },
    config = { extra = { destroy = false}},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 2, y = 1 },
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            card.ability.extra.destroy = true
            return {
                context.other_card:set_ability(G.P_CENTERS.m_mult),
                message = "Hacked!"
            }
        end
        if context.destroy_card then
            SMODS.destroy_cards(card)
        end
    end
}

SMODS.Joker { -- Dungeon Complete!
    key = "dungeon_complete",

    in_pool = function(self, args)
        for _, v in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(v, "m_gold") then
                return true
            end
        end
    end,

    config = {
        extra = {
            mult = 8
        }
    },
    pools = {
        lcbbs = true
    },
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
        return { vars = { card.ability.extra.mult } }
    end,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 4, y = 1 },
    calculate = function(self, card, context)
        if context.individual and SMODS.has_enhancement(context.other_card, "m_gold") and context.cardarea == G.hand and not context.end_of_round and not context.blueprint then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker { -- Solitaire
    key = "solitaire",
    config = {
        extra = {
            straight = 3,
            solitaire = 4,
            money = 0,
            sol_array = {},
        }
    },
    pos = {
        x = 0,
        y = 1
    },
    pools = {
        lcbbs = true
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ModeJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.straight, card.ability.extra.solitaire } }
    end,

    calculate = function(self, card, context)
        if context.before then
            card.ability.extra.money = 0
            card.ability.extra.sol_array = {}
        end

        if context.cardarea == G.jokers and context.joker_main then
            if next(context.poker_hands["Straight"]) then
                card.ability.extra.money = (card.ability.extra.money) + card.ability.extra.solitaire
            end
        end
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if #context.scoring_hand == 5 then
                if MODE_UTIL.check_suit(context.other_card, "light_suit") then
                    card.ability.extra.sol_array[#card.ability.extra.sol_array + 1] = 1
                end
                if MODE_UTIL.check_suit(context.other_card, "dark_suit") then
                    card.ability.extra.sol_array[#card.ability.extra.sol_array + 1] = 0
                end
            end
        end
        if context.joker_main and #context.scoring_hand == 5 then
            if ((MODE_UTIL.arrays_equal(card.ability.extra.sol_array, { 1, 0, 1, 0, 1 })) or (MODE_UTIL.arrays_equal(card.ability.extra.sol_array, { 0, 1, 0, 1, 0 }))) then
                card.ability.extra.money = (card.ability.extra.money) + card.ability.extra.straight
                card.ability.extra.sol_array = {}
            end
        end
        if context.final_scoring_step and card.ability.extra.money > 0 then
            return {
                dollars = card.ability.extra.money,
            }
        end
    end
}

SMODS.Joker { -- 20th Century Joker
    key = "20th_century",
    config = {
        extra = {
            xmult = 1.5
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    pools = {
        lcbbs = true
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ModeJokers',

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,

    calculate = function(self, card, context)
        if context.other_joker then -- this is just baseball card's code, dont @ me
            if (MODE_UTIL.is_food(context.other_joker)) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        context.other_joker:juice_up(0.5, 0.5)
                        return true
                    end
                }))
                return {
                    message = "Served!",
                    Xmult_mod = card.ability.extra.xmult
                }
            end
        end
    end

}

SMODS.Joker { -- Chipwizard Joker
    key = 'chipwizard',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            mod = 21,
            cashout = 0,
            money = 1,
            max = 25
        }
    },
    pools = {
        lcbbs = true
    },
    pos = {
        x = 5,
        y = 1
    },
    cost = 9,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = true,
    atlas = 'ModeJokers',
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mod, card.ability.extra.money, card.ability.extra.cashout, card.ability.extra.max } }
    end,

    calculate = function (self, card, context)
        if context.setting_blind then
            card.ability.extra.cashout = 0
        end
        if context.joker_main and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            card.ability.extra.cashout = math.floor(hand_chips / card.ability.extra.mod)
            if card.ability.extra.cashout > 25 then
                card.ability.extra.cashout = 25
            end
        end
    end,

    calc_dollar_bonus = function(self, card)
            return card.ability.extra.cashout
        end


}

SMODS.Joker{ -- Memo Pad
    key = "memo_pad",
    config = {
        extra = {
            trigger = false,
            triggered = false,
            enhancement = nil,
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    pools = {
        lcbbs = true
    },
    in_pool = function(self, args)
        for _, v in ipairs(G.playing_cards or {}) do
            if v.ability.set == "Enhanced" then
                return true
            end
        end
    end,
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'ModeJokers',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if (#context.full_hand == 1 and G.GAME.current_round.hands_played == 0 and context.other_card.ability.set == "Enhanced") then
                card.ability.extra.enhancement = context.other_card.config.center.key
                card.ability.extra.trigger = true
            end
        end

        if context.individual and context.cardarea == G.play and not context.blueprint and card.ability.extra.trigger and G.GAME.current_round.hands_played ~= 0 then
                card.ability.extra.triggered = true
            return {
                context.other_card:set_ability(card.ability.extra.enhancement),
            }
        end

        if context.final_scoring_step and not context.blueprint and card.ability.extra.triggered then
                return {
                    func = function()
                    card.ability.extra.trigger = false
                    card.ability.extra.triggered = false
                    card.ability.extra.enhancement = nil
                    return true
                end,
                }
        end
    end
}
