SMODS.Joker { -- Tan Jacket
    key = 'tan_jacket',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            chips = 25
        }
    },
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 8,
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
    cost = 8,
    pos = { x = 1, y = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips_add, card.ability.extra.chips}}
    end,
    calculate = function (self, card, context)
        if context.card_added and context.card.ability.consumeable and not context.blueprint_card then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_add
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
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
    cost = 8,
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
            faces = 0,
            chips = 120
        }
    },
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 8,
    pos = { x = 3, y = 5 },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips}}
    end,
    calculate = function (self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint_card then
            if context.other_card:is_face() then
                card.ability.extra.faces = card.ability.extra.faces + 1
            end
        end
        if context.joker_main and card.ability.extra.faces == 5 then
            card.ability.extra.faces = 0
            return { chips = card.ability.extra.chips}
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
    cost = 8,
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
    cost = 8,
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
