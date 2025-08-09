SMODS.Joker { -- Headliner Fix
    key = "headliner_fix",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 3,
    pools = {
        dank = true
    },
    config = { extra = { pinned_card = nil}},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 8,
    pos = { x = 0, y = 0 },
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if (#context.full_hand == 1 and G.GAME.current_round.hands_played == 0) then
                card.ability.extra.pinned_card = context.other_card.sort_id
                print(card.ability.extra.pinned_card)
            end
        end
        if context.end_of_round then
            card.ability.extra.pinned_card = nil
        end
    end
}

SMODS.Joker { -- "Start Ya Bastard!"
    key = "start_ya_bastard",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 1,
    pools = {
        dank = true
    },
    config = {
        extra = {
            mult = 21,
            use = 7
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 1, y = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.mult, card.ability.extra.use} }
    end,
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            return {
                mult = card.ability.extra.mult,
                message = "Come on!"
            }
        end
        if context.after and not context.blueprint_card then
            card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.use
            if card.ability.extra.mult <= 0 then
                SMODS.destroy_cards(card)
            end
        end
    end
}

SMODS.Joker { -- J Custom Dark Ride
    key = "j_custom",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    pools = {
        dank = true
    },
    config = { extra = {
        chips = 100,
        mult = 10,
        xmult = 2
    }},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 2, y = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult, card.ability.extra.xmult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local pos = MODE_UTIL.check_joker_position(card).named_index
            if pos == 'first' then
                return {chips = card.ability.extra.chips}
            elseif pos == 'last' then
                return {xmult = card.ability.extra.xmult}
            else
                return {mult = card.ability.extra.mult}
            end

        end
    end
}

SMODS.Joker { -- JokePod
    key = "jokepod",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 1,
    pools = {
        dank = true
    },
    config = { extra = {
        chips = 0,
        add = 35
    }},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 5,
    pos = { x = 3, y = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.chips, card.ability.extra.add}}
    end,
    calculate = function(self, card, context)
        if context.before and #G.jokers.cards == 1 and not context.blueprint_card then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.add
            return { message = "Upgrade!"}
        end
        if context.before and #G.jokers.cards > 1 and not context.blueprint_card then
            card.ability.extra.chips = 0
            return { message = "Reset!"}
        end
        if context.joker_main and card.ability.extra.chips > 0 then
            return {chips = card.ability.extra.chips}
        end
    end
}

SMODS.Joker { -- One Grit
    key = "one_grit",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 1,
    pools = {
        dank = true
    },
    config = { extra = { mult = 20}},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 4, y = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local stone_count = 0
            for _, v in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(v, "m_stone") then
                    stone_count = stone_count + 1
                end
            end
            if stone_count == 1 and SMODS.has_enhancement(context.other_card, "m_stone") then
                return { mult = card.ability.extra.mult}
            end
        end
    end
}

SMODS.Joker { -- JKCELL
    key = "jkcell",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    pools = {
        dank = true
    },
    config = { extra = {
        mult = 0,
        add = 3,
        last_index = 0,
    } },
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 5, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.add } }
    end,
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and not context.blueprint_card then
            local message = ""
            if card.ability.extra.last_index == MODE_UTIL.check_joker_position(card).index then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
                message = "Upgrade!"
            else
                card.ability.extra.mult = 0
                message = "Oh no my JKCELL!"
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                delay = 0.2,
                func = function()
                    G.jokers:shuffle("jkcell")
                    play_sound('cardSlide1', 0.85)
                    card.ability.extra.last_index = MODE_UTIL.check_joker_position(card).index
                    return true
                end
            }))
            return { message = message}
        end
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
    end
}

SMODS.Joker { -- Bootleg
    key = "bootleg",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 1,
    pools = {
        dank = true
    },
    config = { extra = { mult = 5}},
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 6, y = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.mult}}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult * (#context.full_hand - #context.scoring_hand)
            }
        end
    end
}

--[[
SMODS.Joker { -- Bad Engineering Drawing
    key = "bad_engineering",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = ,
    pools = {
        dank = true
    },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 7, y = 0 },
    loc_vars = function (self, info_queue, card)
    end,
    calculate = function(self, card, context)
    end
}
]]

SMODS.Joker { -- Ugliest Joker
    key = "ugliest_joker",
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    pools = {
        dank = true
    },
    config = { extra = {
        count = 2
    }},
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 8, y = 0 },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.count}}
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                    func = function()
                        for i = 1, (math.min(card.ability.extra.count, #G.playing_cards, 2)) do
                            local playing_card = pseudorandom_element(G.playing_cards, 'ugly')
                            if playing_card then
                            playing_card:set_ability(SMODS.poll_enhancement({guaranteed = true}))
                            end
                        end
                        return true
                    end
            }))
            return {message = "Goo!"}
        end
    end
}

