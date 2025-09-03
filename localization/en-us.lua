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
            },
            mode_cribbage_rules = {
                name = "Rules of Cribbage",
                text = {
                    "First played card is a {C:attention}Jack",
                    "Stack {C:attention}total{} is exactly {C:attention}15{}",
                    "Stack {C:attention}total{} is exactly {C:attention}31{}",
                    "Set of {C:attention}2+{} per card",
                    "Run of {C:attention}3+{} per card, in {C:attention}any{} order"
                }
            },
        },
        Enhanced = {
            m_mode_flesh_zygote = {
                name = "The Flesh",
                text = {"{C:mult}Spreads{} to other cards", "when held in {C:attention}hand{}", "{C:chips}Specializes{} when scored"}
            },
            m_mode_flesh_myofibril = {
                name = "The Flesh",
                text = {"{C:mult}+#1#{} Mult", "{C:mult}Spreads{} to other cards", "when held in {C:attention}hand{}", "Sometimes {C:chips}Specializes{}", "when scored"}
            },
            m_mode_flesh_skeletal = {
                name = "The Flesh",
                text = {"{C:mult}+#1#{} Mult"}
            },
            m_mode_flesh_smooth = {
                name = "The Flesh",
                text = {"{X:mult,C:white} X#1# {} Mult"}
            },
            m_mode_flesh_fat = {
                name = "The Flesh",
                text = {"{C:mult}+#1#{} Mult {C:attention}before{} cards are scored"}
            },
            m_mode_flesh_cartilage = {
                name = "The Flesh",
                text = {"{C:chips}+#1#{} Chips", "{C:mult}Spreads{} to other cards", "when held in {C:attention}hand{}", "Sometimes {C:chips}Calcifies{}", "when scored"}
            },
            m_mode_flesh_bone = {
                name = "The Flesh",
                text = {"{C:chips}+#1#{} Chips", "Increases by {C:chips}#2#{} for", "all {C:attention}Flesh{} cards held in {C:attention}hand{}"}
            },
            m_mode_flesh_skin = {
                name = "The Flesh",
                text = {"{X:chips,C:white} X#1# {} Chips", "Sometimes {C:chips}Specializes{}", "when scored"}
            },
            m_mode_flesh_eye = {
                name = "The Flesh",
                text = {"{X:chips,C:white} X#1# {} Chips", "Counts as a Face Card"}
            },
            m_mode_flesh_hair = {
                name = "The Flesh",
                text = {"{X:chips,C:white} X#1# {} Chips {C:attention}after{} scoring"}
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
                    "{C:inactive,s:0.8}(Must play 5 cards for Solitaire)"
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
            j_mode_cribbage = {
                name = "Cribbage Joker",
                text = {
                    "Gains {C:mult}Mult{} when",
                    "{C:attention}points{} are scored",
                    "according to {C:attention}Cribbage{} rules",
                    "Resets each ante",
                    "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
                }
            },
            j_mode_xbpgh = {
                name = "J'OKER: The Hidden Path",
                text = {
                    "Scored {C:attention}Steel{} Cards become",
                    "{C:mult}Flesh{} Cards",
                }
            },
            j_mode_sometimes = {
                name = "Sometimes",
                text = {
                    "{C:green}#1# in #2#{} chance to create",
                    "a {C:tarot}Tarot{} card when hand is played",
                    "{C:inactive}(must have room)"
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
                    "{C:inactive}(Currently {}{C:red}+#1#{}{C:inactive} Mult, Max of {}{C:red}+#4#{}{C:inactive} Mult added each round)"
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
                    "Resets each ante",
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
                    "{C:inactive}(Currently {C:blue}+#1#{C:inactive} Chips)"
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
                    "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)"
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
            j_mode_joker_cracker = {
                name = "Joker Cracker 9000",
                text = {
                    ""
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
                    "{C:inactive}(Currently {C:attention}#1#{C:inactive} and {C:attention}#2#{C:inactive})"
                }
            },
            j_mode_quiet = {
                name = "Quiet, Isn't It?",
                text = {
                    "Gains {C:red}+#2#{} Mult when",
                    "Booster pack is opened,",
                    "Booster packs have {C:attention}0 options",
                    "{C:inactive}(Currently {C:red}+#1#{C:inactive} Mult)"
                }
            },
            j_mode_mondassian_upgrade = {
                name = "Mondassian Upgrade",
                text = {
                    "{C:attention}Face{} cards count as",
                    "{C:attention}Steel{} cards",
                    "Destroyed if {C:attention}Gold{}",
                    "Cards or Seals are acquired"
                }
            },
            j_mode_cybermat = {
                name = "Cybermat",
                text = {
                    "All played {C:attention}Face{} cards",
                    "Become {C:attention}Steel{} cards",
                    "when scored"
                }
            },
            j_mode_sonic_screwdriver = {
                name = "Sonic Screwdriver",
                text = {
                    "Prevents played {C:attention}Gold{}",
                    "and {C:attention}Steel{} Cards from",
                    "being {C:attention}debuffed{}"
                }
            },
            j_mode_poor_bonus = {
                name = "Poor Bonus",
                text = {
                    "{C:attention}+#1#{} Hand size",
                    "{C:attention}-#2#{} per consumable"
                }
            },
            j_mode_mystery_play = {
                name = "Mystery Play",
                text = {
                    "Each hand play a",
                    "{C:attention}random{} card from the deck"
                }
            },
            j_mode_el_zoomo = {
                name = "El Zoomo!",
                text = {
                    "Played {C:attention}Enhanced{} Cards",
                    "add {X:mult,C:white} X#2# {} Mult to this card",
                    "when scored",
                    "Resets each Ante",
                    "{C:inactive}(Currently {X:mult,C:white} X#1# {C:inactive} Mult)"
                }
            },
            j_mode_smug_jug = {
                name = "Smug Jug",
                text = {
                    "Played cards add {X:chips,C:white} X#2# {} Chips",
                    "to this card when scored",
                    "Resets each Ante",
                    "{C:inactive}(Currently {X:chips,C:white} X#1# {C:inactive} Chips)"
                }
            },
            j_mode_tan_jacket = {
                name = "The Joker in the Tan Jacket",
                text = {
                    "{C:attention}Face{} cards give {C:chips}+#1#{} Chips",
                    "{C:attention}Face{} cards do not have a rank"
                }
            },
            j_mode_interlopers = {
                name = "Manual on Interlopers",
                text = {
                    "Gains {C:chips}+#1#{} when",
                    "a {C:attention}conusmable{} is added",
                    "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
                }
            },
            j_mode_faceless_old_joker = {
                name = "The Faceless Old Joker",
                text = {
                    "{C:attention}Destroys{} up to {C:mult}4{} random",
                    "cards from full deck",
                    "Adds {C:attention}half{} of chip value destroyed",
                    "to one random card"
                }
            },
            j_mode_hiram_mcdaniels = {
                name = "Hiram McDaniels",
                text = {
                    "{C:chips}+#1#{} Chips if played",
                    "hand contains exactly",
                    "5 {C:attention}Face{} cards"
                }
            },
            j_mode_pizza = {
                name = "A Slice of Big Rico's",
                text = {
                    "{C:mult}+#1#{} Mult if played",
                    "hand contains",
                    "{C:hearts}Hearts{} and {C:diamonds}Diamonds{}"
                }
            },
            j_mode_lottery = {
                name = "Night Vale Lottery",
                text = {
                    "{C:attention}Purple{} Seals give {C:money}$#1#{}",
                    "when discarded",
                    "and are {C:attention}destroyed{}"
                }
            },
            j_mode_dark_planet = {
                name = "The Dark Planet",
                text = {
                    "{C:green}#1# in #2#{} chance to create",
                    "the {C:attention}last{} used {C:attention}planet{} card",
                    "at the end of the {C:attention}shop",
                    "{C:inactive}(Currently {C:attention}#3#{C:inactive}, must have room)",
                }
            },
            j_mode_erika = {
                name = "Erika",
                text = {
                    "{C:chips}+#1#{} Chips for every",
                    "{C:money}$#2#{} you have",
                    "{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)"
                }
            },
        }
    },

    misc = {
        dictionary = {
            mode_ui_enable_dankpods = "Enable Dankpods Jokers",
            mode_ui_enable_lcbbs = "Enable Zachtronics Jokers",
            mode_ui_enable_music = "Enable Music Jokers",
            mode_ui_enable_nightvale = "Enable Night Vale Jokers",
            mode_ui_enable_extra = "Enable Miscellaneous Jokers",
            mode_ui_requires_restart = "Requires Resart",
            k_mode_mystery = "Mystery Card!",
            k_mode_steel = "Upgrade!",
            k_mode_bonus = "Bonus!",
            k_mode_flesh = "X'BPGH",
            k_mode_write = "Added to Memos!"
        },
        labels = {
            mode_now_playing = "Now Playing"
        }
    }
}