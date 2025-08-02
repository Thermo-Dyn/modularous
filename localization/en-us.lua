return {
    descriptions = {
        Other = {
            modifiers = {
                name = "Modifiers",
                text = {
                    "{C:enhanced}Enhancements{}",
                    "{C:dark_edition}Editions{} and {C:spectral}Seals{}"
                }
            },
            mode_now_playing = {
                name = "Now Playing",
                text = {"Joker {C:attention}destroyed{} after",
                        "defeating {C:attention}boss blind{}",
                        "{C:dark_edition}+1{} Joker slot",
                        "Joker cannot be sold"
                    }
            }
        },

        Joker = {
            j_mode_hobby_studio = {
                name = "Hobby Studio",
                text = {
                    "{C:attention}Bonus{} cards give {C:chips}+#1#{} Chips"
                },
            },
            j_mode_malware = {
                name = "Malware Joker",
                text = {
                    "Cards held in hand",
                    "become {C:attention}Mult{} cards",
                    "{C:attention}Destroyed{} after use"
                },
            },
            j_mode_solitaire = {
                name = "Solitaire",
                text = {
                    "Gives {C:money}$#1#{} if played hand has",
                    "alternating dark and light suits",
                    "Gives {C:money}$#2#{} if hand is a straight",
                    "{C:inactive,s:0.8}(Must play 5 cards for Solitaire){}"
                }
            },
            j_mode_dungeon_complete = {
                name = "Dungeon Complete!",
                text = {
                    "{C:attention}Gold{} cards held in {C:attention}hand",
                    "Give {C:red}+#1#{} Mult"
                }
            },
            j_mode_20th_century = {
                name = "20{s:0.8}th{} Century Joker",
                text = {
                    "{C:attention}Food{} Jokers each give {X:red,C:white}X#1#{} Mult"
                }
            },
            j_mode_chipwizard = {
                name = "ChipWizard{s:0.5}TM{} Joker",
                text = {
                    "Every {C:chips}#1#{} chips scored in {C:attention}first{} hand",
                    "gives {C:money}$#2#{} at end of round",
                    "{C:inactive}(Currently {C:money}$#3#{C:inactive}, max of {C:money}$#4#{C:inactive})"
                }
            },
            j_mode_memo_pad = {
                name = "Memo Pad",
                text = {
                    "Copy {C:enhanced}Enhancement{} to all cards",
                    "of next played hand if first played",
                    "hand of round is one {C:enhanced}Enhanced{} card"
                }
            },
            j_mode_sometimes = {
                name = "Sometimes",
                text = {
                    "{C:green}#1# in #2#{} chance to create",
                    "a {C:tarot}Tarot{} card when hand is played",
                    "{C:inactive}(must have room){}"
                }
            },
            j_mode_wild_planet = {
                name = "Wild Planet",
                text = {
                    "Upgrade {C:planet}Three Of A Kind{}",
                    "If scoring hand contains a {C:attention}3{} or {C:attention}5{}"
                }
            },
            j_mode_joker_collection = {
                name = "The Joker Collection",
                text = {
                    "Scored {C:attention}2s{} and {C:attention}4s{} give {C:money}$#1#{}"
                }
            },
            j_mode_electric_blue = {
                name = "Electric Blue",
                text = {
                    "{C:attention}Mult{} cards and {C:attention}Bonus{} cards",
                    "Count as each other"
                }
            },
            j_mode_flood = {
                name = "Flood Joker",
                text = {
                    "Gains {C:red}+#2#{} Mult when a {C:attention}Flush{} is played",
                    "This Joker's Mult is multiplied by {C:red}#3#{}",
                    "if played hand is not a {C:attention}Flush{} but contains a {C:attention}Flush{}",
                    "{C:inactive}(Currently {}{C:red}+#1#{}{C:inactive} Mult){}"
                }
            },
            j_mode_love_will_tear_us_apart = {
                name = "Love Will Tear Us Apart",
                text = {
                    "If played {C:attention}hand{} contains",
                    "2 {C:attention}face{} cards, destroy them"
                }
            },

            j_mode_bonden_og_kraka = {
                name = "Bonden Og Kråka",
                -- Do not translate this name! Or, *transliterate* it.
                -- Here's the IPA transcription: /boːndɛɳ̍ oːg kroːkɑː/
                text = {
                    "{C:attention}Destroyed{} and {C:enhanced}Modified{}","cards apply {C:enhanced}Modifiers{}",
                    "to random cards in {C:attention}deck{}"
                }
            },

            j_mode_electricity = {
                name = "Electricity",
                text = {
                    "{C:attention}Bonus{} cards give {X:chips,C:white}X#1#{} Chips",
                    "{C:green}#2# in #3#{} chance to {C:attention}destroy{}",
                    "a card held in hand"
                }
            },

            j_mode_blue_monday = {
                name = "Blue Monday",
                text = {
                    "{C:dark_edition}Foil{} cards give {X:chips,C:white}X#1#{} Chips"
                }
            },
            j_mode_juke_box_joker = {
                name = "Juke Box Jokers",
                text = {
                    "Each ante play",
                    "a new {C:attention}Music{} joker"
                }
            },
            j_mode_personal_jesus = {
                name = "Personal Jesus",
                text = {
                    "{C:attention}Apostles{} held in hand",
                    "at end of round",
                    "add {C:money}$#1#{} to cashout",
                    "resets each ante",
                    "{C:inactive}(Currently {C:money}$#2#{C:inactive})"
                }
            },
            j_mode_headliner_fix = {
                name = "Headliner Fix",
                text = {
                    "If first hand of round",
                    "contains only {C:attention}1{} card",
                    "card stays in your {C:attention}hand",
                    "until end of round"
                }
            },
            j_mode_start_ya_bastard = {
                name = '"Start Ya Bastard!"',
                text = {
                    "{C:red}+#1#{} Mult before scoring",
                    "{C:red}-#2#{} Mult each hand"
                }
            },
            j_mode_j_custom = {
                name = 'J Custom Dark Ride',
                text = {
                    "This Joker gives a {C:attention}Bonus{}",
                    "depending on it's position:",
                    "Leftmost slot: {C:blue}+#1#{} Chips",
                    "Rightmost slot: {X:red,C:white}X#3#{} Mult",
                    "Otherwise: {C:red}+#2#{} Mult",
                    "{C:inactive,s:0.8}(If Joker slots are not filled, it gives +{C:red,s:0.8}#2#{C:inactive,s:0.8} Mult)"
                }
            },
            j_mode_jokepod = {
                name = "JokePod",
                text = {
                    "Gains {C:blue}+#2#{} Chips each hand",
                    "resets if another {C:attention}Joker{} is present",
                    "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips){}"
                }
            },
            j_mode_one_grit = {
                name = "One Grit",
                text = {
                    "{C:attention}Stone{} cards give {C:red}+#1#{}",
                    "Only if {C:attention}1{} {C:attention}Stone{} card in full deck"
                }
            },
            j_mode_jkcell = {
                name = "JKCELL",
                text = {
                    "Gains {C:red}+#2#{} Mult and {C:attention}shuffles{} Jokers",
                    "when a hand is played",
                    "resets if moved",
                    "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult){}"
                }
            },
            j_mode_bootleg = {
                name = "Bootleg",
                text = {
                    "{C:red}+#1#{} Mult for every played",
                    "but {C:attention}unscored{} card"
                }
            },
            j_mode_bad_engineering = {
                name = "Bad Engineering Drawing",
                text = {
                    "" -- todo
                }
            },
            j_mode_ugliest_joker = {
                name = "Ugliest Joker",
                text = {
                    "When {C:attention}Blind{} is selected,",
                    "{C:attention}#1#{} random cards in deck",
                    "gain a random {C:attention}Enhancement{}"
                }
            },
            j_mode_cow_tools = {
                name = "Cow Tools",
                text = {
                    "All played {C:clubs}Club{} cards",
                    "become {C:attention}Bonus{} cards",
                    "when scored"
                }
            },
            j_mode_jimbo_holding_2_oranges = {
                name = "Jimbo Holding 2 Oranges",
                text = {
                    "When Blind is selected",
                    "randomly chooses a",
                    "{C:attention}Positive{} and {C:attention}Negative{} effect",
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive} and {C:attention}#2#{C:inactive}){}"
                }
            },
        }
    },

    misc = {
        dictionary = {
            mode_ui_enable_dankpods = "Enable Dankpods Jokers",
            mode_ui_enable_lcbbs = "Enable Zachtronics Jokers",
            mode_ui_enable_music = "Enable Music Jokers",
            mode_ui_enable_extra = "Enable Miscellaneous Jokers",
            mode_ui_requires_restart = "Requires Resart",


            mode_k_bonus = "Bonus!"
        },
        labels = {
            mode_now_playing = "Now Playing"
        }
    }
}