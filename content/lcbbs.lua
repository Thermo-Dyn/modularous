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
    eternal_compat = false,
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
    discovered = false,
    atlas = 'ModeJokers',

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if (#context.full_hand == 1 and G.GAME.current_round.hands_played == 0 and context.other_card.ability.set == "Enhanced") then
                card.ability.extra.enhancement = context.other_card.config.center.key
                card.ability.extra.trigger = true
                return {
                    message = localize('k_mode_write'),
                    colour = G.C.ORANGE
                }
            end
        end

        if context.before and context.main_eval and not context.blueprint and card.ability.extra.trigger and G.GAME.current_round.hands_played ~= 0 then
            card.ability.extra.triggered = true
            for _, c in ipairs(G.play.cards) do
                c:set_ability(card.ability.extra.enhancement, nil, true)
            end
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.ORANGE
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

SMODS.Joker { -- Cribbage
    key = "cribbage",
    config = {
        extra = {
            mult = 0,
            add = 0
        }
    },
    pos = {
        x = 7,
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
        info_queue[#info_queue+1] = { key = "mode_cribbage_rules", set = "Other" }
        return { vars = { card.ability.extra.mult } }
    end,

    calculate = function(self, card, context)
        if context.before then
            if not context.blueprint_card then
                local crb_array = {}
                for index, c in ipairs(G.play.cards) do
                    table.insert(crb_array, index, c:get_id())
                end
                card.ability.extra.add = MODE_UTIL.calculate_cribbage_score(crb_array)
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra, -- the table that has the value you are changing in
                    ref_value = "mult", -- the key to the value in the ref_table
                    scalar_value = "add",
---@diagnostic disable-next-line: assign-type-mismatch
                    operation = function (ref_table, ref_value, inital, change)
                        ref_table[ref_value] = inital + change
                    end,
                    scaling_message = {
                        message = localize('k_upgrade_ex'),
                        colour = G.C.ORANGE
                    }
                })
                card.ability.extra.add = 0
            end
        end
        -- if context.individual and context.cardarea == G.play and not context.blueprint_card then
        --     card.ability.extra.crb_array[#card.ability.extra.crb_array + 1] = context.other_card:get_id()
        -- end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if context.beat_boss and card.ability.extra.mult > 0 then
                card.ability.extra.mult = 0
                return {
                    message = localize('k_reset'),
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Joker { -- J'OKER: The Hidden Path
    key = "xbpgh",
    pos = {x = 8, y = 1},
    pools = {lcbbs = true},
    in_pool = function(self, args)
        for _, v in ipairs(G.playing_cards or {}) do
            if MODE_UTIL.is_flesh(v) then
                return true
            end
        end
    end,
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    atlas = 'ModeJokers',

    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.m_mode_flesh_zygote
    end,

    calculate = function (self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            local faces = 0
            for _, scored_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(scored_card, "m_steel") then
                    faces = faces + 1
                    scored_card:set_ability('m_mode_flesh_zygote', nil, true)
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
                    message = localize('k_mode_flesh'),
                    colour = G.C.MULT
                }
            end
        end
    end
}

SMODS.Enhancement { -- Zygote
    pools = {
        Flesh = true
    },
    in_pool = function (self, args)
        return false
    end,
    key = 'flesh_zygote',
    pos = { x = 0, y = 0 },
    atlas = "ModeEnhancements",
    config = { extra = { active = false}},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play and card.ability.extra.active then
            MODE_UTIL.upgrade_flesh(card, {'m_mode_flesh_myofibril', 'm_mode_flesh_skin', 'm_mode_flesh_cartilage'})
        end
        if context.main_scoring and context.cardarea == G.hand and card.ability.extra.active then
            MODE_UTIL.spread_flesh(card, 'm_mode_flesh_zygote')
        end
        if context.after then
            card.ability.extra.active = true
        end
    end
}

SMODS.Enhancement { -- Myofibril
    pools = {
        Flesh = true
    },
    in_pool = function (self, args)
        return false
    end,
    key = 'flesh_myofibril',
    pos = { x = 1, y = 0 },
    atlas = "ModeEnhancements",
    config = { mult = 5, extra = {active = false}},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult}}
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play and card.ability.extra.active then
            MODE_UTIL.upgrade_flesh(card, {'m_mode_flesh_skeletal', 'm_mode_flesh_smooth', 'm_mode_flesh_fat', -1})
        end
        if context.main_scoring and context.cardarea == G.hand and card.ability.extra.active then
            MODE_UTIL.spread_flesh(card, 'm_mode_flesh_myofibril')
        end
        if context.after then
            card.ability.extra.active = true
        end
    end
}

SMODS.Enhancement { -- Skeletal
    pools = {
        Flesh = true
    },
    in_pool = function (self, args)
        return false
    end,
    key = 'flesh_skeletal',
    pos = { x = 2, y = 0 },
    atlas = "ModeEnhancements",
    config = { mult = 20},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult}}
    end,

}

SMODS.Enhancement { -- Smooth
    pools = {
        Flesh = true
    },
    in_pool = function (self, args)
        return false
    end,
    key = 'flesh_smooth',
    pos = { x = 3, y = 0 },
    atlas = "ModeEnhancements",
    config = { x_mult = 1.75},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x_mult}}
    end,
}

SMODS.Enhancement { -- Fat
    pools = {
        Flesh = true
    },
    in_pool = function (self, args)
        return false
    end,
    key = 'flesh_fat',
    pos = { x = 4, y = 0 },
    atlas = "ModeEnhancements",
    config = { extra = { mult = 12}},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult}}
    end,
    calculate = function (self, card, context)
        if context.initial_scoring_step and context.cardarea == G.play then
            print("haiii :3")
            return { mult = card.ability.extra.mult}
        end
    end
}

SMODS.Enhancement { -- Skin
    pools = {
        Flesh = true
    },
    in_pool = function (self, args)
        return false
    end,
    key = 'flesh_skin',
    pos = { x = 5, y = 0 },
    atlas = "ModeEnhancements",
    config = { x_chips = 1.25, extra = {active = false}},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x_chips}}
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play and card.ability.extra.active then
            MODE_UTIL.upgrade_flesh(card, {'m_mode_flesh_eye','m_mode_flesh_hair',-1})
        end
        if context.main_scoring and context.cardarea == G.hand and card.ability.extra.active then
            MODE_UTIL.spread_flesh(card, 'm_mode_flesh_skin')
        end
        if context.after then
            card.ability.extra.active = true
        end
    end
}

SMODS.Enhancement { -- Eye
    pools = {
        Flesh = true
    },
    in_pool = function (self, args)
        return false
    end,
    key = 'flesh_eye',
    pos = { x = 6, y = 0 },
    atlas = "ModeEnhancements",
    config = { x_chips = 1.75},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.x_chips}}
    end,
}

SMODS.Enhancement { -- Hair
    pools = {
        Flesh = true
    },
    in_pool = function (self, args)
        return false
    end,
    key = 'flesh_hair',
    pos = { x = 7, y = 0 },
    atlas = "ModeEnhancements",
    config = { extra = { x_chips = 1.75}},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.x_chips}}
    end,
    calculate = function (self, card, context)
        if context.final_scoring_step and context.cardarea == G.play then
            return {
                x_chips = card.ability.extra.x_chips
            }
        end
    end
}

SMODS.Enhancement { -- Cartilage
    pools = {
        Flesh = true
    },
    in_pool = function (self, args)
        return false
    end,
    key = 'flesh_cartilage',
    pos = { x = 8, y = 0 },
    atlas = "ModeEnhancements",
    config = { bonus = 25},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus }}
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play and card.ability.extra.active then
            MODE_UTIL.upgrade_flesh(card, {'m_mode_flesh_bone',-1})
        end
        if context.main_scoring and context.cardarea == G.hand and card.ability.extra.active then
            MODE_UTIL.spread_flesh(card, 'm_mode_flesh_cartilage')
        end
        if context.after then
            card.ability.extra.active = true
        end
    end
}

SMODS.Enhancement { -- Bone
    pools = {
        Flesh = true
    },
    in_pool = function (self, args)
        return false
    end,
    key = 'flesh_bone',
    pos = { x = 9, y = 0 },
    atlas = "ModeEnhancements",
    config = {bonus = 30, extra = {base = 30, add = 20}},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.base, card.ability.extra.add}}
    end,
    calculate = function (self, card, context)
        if context.before and context.cardarea == G.play then
            local count = 0
            for _, c in ipairs(G.hand.cards) do
                if MODE_UTIL.is_flesh(c) then
                    count = count + 1
                end
            end
            card.ability.bonus = card.ability.extra.add * count
        end
    end
}