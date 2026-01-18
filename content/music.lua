SMODS.Joker { -- Sometimes
    key = 'sometimes',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            odds = 3
        }
    },
    pools = {
        Music = true
    },
    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 2, y = 2 },
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.odds = card.ability.extra.odds or 3
    end,
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'identifier') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
        return { vars = { new_numerator, new_denominator } }
    end,

    calculate = function(self, card, context)
        if context.before then
            if SMODS.pseudorandom_probability(card, 'Sometimes!', 1, card.ability.extra.odds, 'j_mode_sometimes') then
                local created_consumable = false
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    created_consumable = true
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local consumable_card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'mode')
                            consumable_card:add_to_deck()
                            G.consumeables:emplace(consumable_card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                end
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
                    { message = created_consumable and localize('k_plus_tarot') or nil, colour = G.C.PURPLE })
            end
        end
    end
}

SMODS.Joker { -- Wild Planet
    key = 'wild_planet',

    pools = {
        Music = true
    },
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 5,
    pos = { x = 6, y = 2 },
    calculate = function(self, card, context)
        if context.before then
            for i, c in ipairs(context.scoring_hand) do
                if (c:get_id() == 3) or (c:get_id()) == 5 then
                    return {
                        level_up = 1,
                        level_up_hand = "Three of a Kind",
                        message = localize('k_level_up_ex')
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Joker Collection
    key = 'joker_collection',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            money = 3
        }
    },
    pools = {
        Music = true
    },
    atlas = "ModeJokers",
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    cost = 8,
    pos = { x = 7, y = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if (context.other_card:get_id() == 2 or context.other_card:get_id() == 4) then
                return {
                    dollars = card.ability.extra.money
                }
            end
        end
    end
}

SMODS.Joker { -- Electric Blue
    key = 'electric_blue',
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    pools = {
        Music = true
    },
    in_pool = function(self, args)
        for _, v in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(v, "m_bonus") or SMODS.has_enhancement(v, "m_mult") then
                return true
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
    end,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 7,
    pos = { x = 8, y = 2 },
    calculate = function(self, card, context)
        if context.check_enhancement then
            if context.other_card.ability.effect == "Bonus Card" or context.other_card.ability.effect == "Mult Card" then
                return { m_mult = true, m_bonus = true }
            end
        end
    end
}

SMODS.Joker { -- Flood
    key = 'flood',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            mult = 0,
            change = 3,
            xm = 0.5,
            max = 50
        }
    },
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pools = {
        Music = true
    },
    cost = 5,
    pos = { x = 9, y = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.change, (1 + card.ability.extra.xm), card.ability.extra.max } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            if next(context.poker_hands["Flush"]) then
                if (context.scoring_name == "Flush") then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra, -- the table that has the value you are changing in
                        ref_value = "mult",             -- the key to the value in the ref_table
                        scalar_value = "change",        -- the key to the value to scale by, in the ref_table by default,
                        scaling_message = {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.MULT
                        }
                    })
                else
                    local max = card.ability.extra.max
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra, -- the table that has the value you are changing in
                        ref_value = "mult",             -- the key to the value in the ref_table
                        scalar_value = "xm",            -- the key to the value to scale by, in the ref_table by default,
                        ---@diagnostic disable-next-line: assign-type-mismatch
                        operation = function(ref_table, ref_value, initial, change)
                            ref_table[ref_value] = initial + (math.min(change * initial, max))
                        end,
                        scaling_message = {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.MULT,
                            sound = 'multhit2'
                        }
                    })
                end
            end
        end
        if context.cardarea == G.jokers and context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker { -- Love Will Tear Us Apart
    key = 'love_will_tear_us_apart',
    unlocked = true,
    discovered = false,
    atlas = "ModeJokers",
    rarity = 2,
    pools = {
        Music = true
    },
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 4, y = 2 },
    calculate = function(self, card, context)
        if context.destroy_card then
            if (function()
                    local rankCount = 0
                    for i, c in ipairs(context.full_hand) do
                        if c:is_face() then
                            rankCount = rankCount + 1
                        end
                    end

                    return rankCount >= 2
                end)() then
                local check = function(dess) -- find her
                    for _, c in ipairs(G.play.cards) do
                        -- grub is the reason for this, but im not gonna change it because it is also funny

                        if c:is_face() and context.destroy_card == c then
                            --[[card_eval_status_text(c, 'extra', nil, nil, nil,
                            { message = "Love!", colour = G.C.RED })]]
                            if dess == true then
                                -- run over
                                return true
                            elseif dess == "msg" then
                                return "Love!"
                            elseif dess == "col" then
                                return G.C.RED
                            end
                            return true
                        end
                    end
                    return false
                end -- [[not using the dess argument but keeping it in because DRIVING IN MY CAR,  RIGHT AFTER A BEER. HEY THAT BUMP IS SHAPED LIKE A DEER. D U I? HOW ABOUT YOU DIE, ILL GO 100 MILES, IN AN HOUR. LITTLE DO YOU KNOW, IVE FILLEDD UP ON GAS, IMA GET YOUR FOUNTAIN MAKING ASS. PULVERISE THIS FUCK, WITH MY BERGENTRUCK, IT SEEMS YOUR OUT OF LUCK]]
                if check(true) then
                    return {
                        remove = true,
                        message = "Love!",
                        colour = G.C.RED
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Bonden Og Kråka
    key = 'bonden_og_kraka',
    unlocked = true,
    discovered = false,
    pools = {
        Music = true
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "modifiers", set = "Other" }
    end,
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 0, y = 2 },
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for _, c in ipairs(context.removed) do
                -- Put all enhancements into a table
                local enhancements = {}

                if c.config.center then
                    enhancements[1] = c.config.center.key
                end

                if c.edition then
                    enhancements[2] = c.edition.key
                end

                if c.seal then
                    enhancements[3] = c.seal
                end
                -- apply enhancements to random cards in deck
                local target_cards = {}
                for _, d in ipairs(G.deck.cards) do
                    table.insert(target_cards, d)
                end

                if #target_cards < 3 then
                    return
                end


                G.E_MANAGER:add_event(Event({
                    func = function()
                        local amount = pseudorandom("seed", 1, 3)
                        for i = 1, amount do
                            local playing_card, index = pseudorandom_element(target_cards, 'the_crow')
                            if enhancements[i] then
                                if not playing_card then
                                    goto continue
                                end
                                if i == 1 then
                                    playing_card:set_ability(enhancements[i])
                                end
                                if i == 2 then
                                    playing_card:set_edition(enhancements[i])
                                end
                                if i == 3 then
                                    playing_card:set_seal(enhancements[i])
                                end
                            end
                            ::continue::
                        end
                        return true
                    end
                }))
            end
        end
    end
}

SMODS.Joker { -- Electricity
    key = 'electricity',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            bonus = 1.25,
            odds = 5,
            cards_played = false
        }
    },
    pools = {
        Music = true
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
    cost = 7,
    pos = { x = 3, y = 2 },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'identifier') -- it is suggested to use an identifier so that effects that modify probabilities can target specific values
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        return { vars = { card.ability.extra.bonus, new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.get_enhancements(context.other_card)["m_bonus"] == true then
                card.ability.extra.cards_played = true
                return {
                    x_chips = card.ability.extra.bonus,
                }
            end
        end
        if context.destroy_card and card.ability.extra.cards_played and SMODS.pseudorandom_probability(card, 'group_0_fe5e38c5', 1, card.ability.extra.odds, 'group_0_fe5e38c5') then
            card.ability.extra.cards_played = false
            local target_cards = {}
            for _, card in ipairs(G.hand.cards) do
                table.insert(target_cards, card)
            end
            if #target_cards > 0 then
                local card_to_destroy = pseudorandom_element(target_cards, pseudoseed('destroy_card'))
                if context.destroy_card == card_to_destroy then
                    return {
                        remove = true,
                        message = "Electric!",
                        colour = G.C.BLUE
                    }
                else
                end
            end
        end
    end
}

SMODS.Joker { -- Blue Monday
    key = 'blue_monday',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            xchips = 2
        }
    },
    pools = {
        Music = true
    },
    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 8,
    pos = { x = 5, y = 2 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        return { vars = { card.ability.extra.xchips } }
    end,
}

--  Thanks N' for the fix!
--  At some point, I need to get it to show the 2X chips in localization
SMODS.Edition:take_ownership('foil', -- Blue Monday Foil
    {
        loc_vars = function(self, info_queue, card)
            return { vars = { card.edition.extra } }
        end,
        config = { extra = 50 },
        calculate = function(self, card, context)
            local joker = next(SMODS.find_card("j_mode_blue_monday"))
            if joker and (context.post_joker or (context.main_scoring and context.cardarea == G.play)) then
                return { xchips = 2, colour = G.C.BLUE }
            end
            if not joker and context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
                return {
                    chips = card.edition.extra
                }
            end
        end
    },
    true
)

SMODS.Joker { -- Personal Jesus (Paperback)
    dependencies = {
        "paperback"
    },
    key = 'personal_jesus',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            cashout = 0,
            add = 2,
            boss_beat = false
        }
    },
    in_pool = function(self, args)
        for _, v in ipairs(G.playing_cards or {}) do
            if v:get_id() == 'T' then
                return true
            end
        end
    end,
    atlas = "ModeJokers",
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    cost = 6,
    pos = { x = 1, y = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.add, card.ability.extra.cashout } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.individual then
            if context.other_card:get_id() == 15 then
                card.ability.extra.cashout = card.ability.extra.cashout + card.ability.extra.add
                return {
                    message = "Faith!"
                }
            end
            if context.blind_defeated and G.GAME.blind:get_type() == 'Boss' then
                card.ability.extra.boss_beat = true
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        local cashout = card.ability.extra.cashout
        if card.ability.extra.boss_beat then
            card.ability.extra.boss_beat = false
            card.ability.extra.cashout = 0
        end
        if cashout > 0 then
            return cashout
        end
    end
}

SMODS.Joker { -- Juke Box Joker
    key = 'juke_box_joker',
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            make_joker = true
        }
    },
    atlas = "ModeJokers",
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "mode_now_playing", set = "Other" }
    end,
    cost = 8,
    pos = { x = 0, y = 3 },
    calculate = function(self, card, context)
        if context.blind_defeated and G.GAME.blind:get_type() == 'Boss' then
            card.ability.extra.make_joker = true
        end
        if context.setting_blind and card.ability.extra.make_joker then
            G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local c = SMODS.add_card {
                                set = 'Music',
                                key_append = 'juke_box',
                            }
                            c:add_sticker('mode_now_playing', true)
                            G.GAME.joker_bmmmmuffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = localize('k_plus_joker'), colour = G.C.MULT },
                        context.blueprint_card or card)
                    card.ability.extra.make_joker = false
                    return true
                end)
            }))
            return nil, true
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for _, c in pairs(G.jokers.cards) do
            if c.ability.mode_now_playing then
                SMODS.Stickers.mode_now_playing:apply(c)
            end
        end
    end

}

SMODS.Sticker { -- Now Playing Sticker
    key = "now_playing",
    atlas = "ModeJokers", pos = { x = 9, y = 4 },
    should_apply = false,
    rate = 0,
    badge_colour = HEX '577379',
    apply = function(self, card, val)
        if G.jokers then
            card.ability[self.key] = val
            if card.ability[self.key] then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                card:set_cost()
            else
                G.jokers.config.card_limit = G.jokers.config.card_limit - 1
            end
        else
            card.ability[self.key] = val
        end
    end
}
