#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <colors>
#undef REQUIRE_PLUGIN
#include <adminmenu>
#include <left4dhooks>

#pragma semicolon 1
#pragma newdecls required

<<<<<<< Updated upstream
=======
#define PLUGIN_VERSION "3.0.0"

// TO DO
// Check movetype exploits. Let smoker grab bot and take control of bot and vice versa
// Fix Silent Hill bug
// Check if intro cameras, after finale end nothing is bugged

public Plugin myinfo =
{
    name = "[L4D1/L4D2] Fortnite Emotes & Dances",
    author = "Kodua, Franc1sco franug, TheBO$$, Aleexxx, Foxhound, nearly civilized, Ferks-FK, gvazdas",
    description = "Emotes and dances for players, common infected and witches.",
    version = PLUGIN_VERSION,
    url = "https://github.com/Ferks-FK/Fortnite-Emotes-Extended"
};

#define ZOMBIECLASS_SPITTER 4
#define ZOMBIECLASS_JOCKEY 5
#define ZOMBIECLASS_CHARGER 6

>>>>>>> Stashed changes
#define EF_NODRAW                      32
#define EF_BONEMERGE                (1 << 0)
#define EF_NOSHADOW                 (1 << 4)
#define EF_BONEMERGE_FASTCULL       (1 << 7)
#define EF_NORECEIVESHADOW          (1 << 6)
#define EF_PARENT_ANIMATES          (1 << 9)
#define HIDEHUD_ALL                 (1 << 2)
#define HIDEHUD_CROSSHAIR           (1 << 8)

<<<<<<< Updated upstream
=======
// Buttons that can be pressed and emote/dance will continue (players only)
>>>>>>> Stashed changes
#define ALLOWEDBUTTONS (IN_BACK|IN_FORWARD|IN_LEFT|IN_RIGHT|IN_MOVELEFT|IN_MOVERIGHT|IN_RUN|IN_WALK|IN_SPEED|IN_SCORE|IN_ZOOM)

#define SOUND_BASE_PATH "kodua/fortnite_emotes/"
#define SOUND_BASE_FULL "sound/kodua/fortnite_emotes/"

#define FILE_MODEL_BASE      "models/player/kodua/fnemotes_nearlycivilized_v3_l4d2"
#define FILE_MODEL_BASE_L4D1 "models/player/kodua/fnemotes_nearlycivilized_v3_l4d1"

<<<<<<< Updated upstream
=======
// Fake model to make witches and common infected not render
#define FILE_MODEL_FAKE     "models/infected/anim_common.mdl"

#define MAXENTITIES 2048 // For static arrays
#define MAXDANCERS  100

// Enum for classnames that can emote/dance
#define EMOTECLASS_INVALID  -1
#define EMOTECLASS_PLAYER    0
#define EMOTECLASS_INFECTED  1
#define EMOTECLASS_WITCH     2

#define ENTRY_SIZE 64
>>>>>>> Stashed changes
enum struct EmoteData
{
    char name[64];
    char intro[64];
    char loop[64];
    char sound[64];
}

static const EmoteData g_Emotes[] =
{
    // name                             intro                               loop                       sound
    { "Emote_Fonzie_Pistol",            "Emote_Fonzie_Pistol",              "none",                    "",                              },
    { "Emote_Bring_It_On",              "Emote_Bring_It_On",                "none",                    "",                              },
    { "Emote_ThumbsDown",               "Emote_ThumbsDown",                 "none",                    "",                              },
    { "Emote_ThumbsUp",                 "Emote_ThumbsUp",                   "none",                    "",                              },
    { "Emote_Celebration_Loop",         "Emote_Celebration_Loop",           "",                        "jubilation",                    },
    { "Emote_BlowKiss",                 "Emote_BlowKiss",                   "none",                    "blowkiss"                       },
    { "Emote_Calculated",               "Emote_Calculated",                 "none",                    "",                              },
    { "Emote_Confused",                 "Emote_Confused",                   "none",                    "",                              },
    { "Emote_Chug",                     "Emote_Chug",                       "none",                    "gogogo"                         },
    { "Emote_Cry",                      "Emote_Cry",                        "none",                    "bananacry"                      },
    { "Emote_DustingOffHands",          "Emote_DustingOffHands",            "none",                    "",                              },
    { "Emote_DustOffShoulders",         "Emote_DustOffShoulders",           "none",                    "athena_emote_hot_music"         },
    { "Emote_Facepalm",                 "Emote_Facepalm",                   "none",                    "athena_emote_facepalm_foley_01" },
    { "Emote_Fishing",                  "Emote_Fishing",                    "none",                    "fishing"                        },
    { "Emote_Flex",                     "Emote_Flex",                       "none",                    "flexing"                        },
    { "Emote_golfclap",                 "Emote_golfclap",                   "none",                    "clapping"                       },
    { "Emote_HandSignals",              "Emote_HandSignals",                "none",                    "",                              },
    { "Emote_HeelClick",                "Emote_HeelClick",                  "none",                    "emote_heelclick"                },
    { "Emote_Hotstuff",                 "Emote_Hotstuff",                   "none",                    "emote_hotstuff"                 },
    { "Emote_IBreakYou",                "Emote_IBreakYou",                  "none",                    "",                              },
    { "Emote_IHeartYou",                "Emote_IHeartYou",                  "none",                    "iheartyou"                      },
    { "Emote_Kung-Fu_Salute",           "Emote_Kung-Fu_Salute",             "none",                    "",                              },
    { "Emote_Laugh",                    "Emote_Laugh",                      "Emote_Laugh_CT",          "emote_laugh_01"                 },
    { "Emote_Luchador",                 "Emote_Luchador",                   "none",                    "emote_luchador"                 },
    { "Emote_Make_It_Rain",             "Emote_Make_It_Rain",               "none",                    "athena_emote_makeitrain_music"  },
    { "Emote_NotToday",                 "Emote_NotToday",                   "none",                    "",                              },
    { "Emote_RockPaperScissor_Paper",   "Emote_RockPaperScissor_Paper",     "none",                    "",                              },
    { "Emote_RockPaperScissor_Rock",    "Emote_RockPaperScissor_Rock",      "none",                    "",                              },
    { "Emote_RockPaperScissor_Scissor", "Emote_RockPaperScissor_Scissor",   "none",                    "",                              },
    { "Emote_Salt",                     "Emote_Salt",                       "none",                    "",                              },
    { "Emote_Salute",                   "Emote_Salute",                     "none",                    "athena_emote_salute_foley_01"   },
    { "Emote_Snap",                     "Emote_Snap",                       "none",                    "emote_snap1"                    },
    { "Emote_StageBow",                 "Emote_StageBow",                   "none",                    "emote_stagebow"                 },
    { "Emote_Wave2",                    "Emote_Wave2",                      "none",                    "",                              },
    { "Emote_Yeet",                     "Emote_Yeet",                       "none",                    "emote_yeet"                     },
    { "Emote_Cena",                     "Emote_Cena",                       "none",                    "cant_c_me"                      },
    { "Emote_Lebron",                   "Emote_Lebron",                     "none",                    "lebronjame"                     },
};

static const EmoteData g_Dances[] =
{
    { "DanceMoves",                     "DanceMoves",                       "none",                    "ninja_dance_01,dance_soldier_03"    },
    { "Emote_Mask_Off_Intro",           "Emote_Mask_Off_Intro",             "Emote_Mask_Off_Loop",     "hip_hop_good_vibes_mix_01_loop"     },
    { "Emote_Zippy_Dance",              "Emote_Zippy_Dance",                "none",                    "emote_zippy_a"                      },
    { "ElectroShuffle",                 "ElectroShuffle",                   "none",                    "athena_emote_electroshuffle_music"  },
    { "Emote_AerobicChamp",             "Emote_AerobicChamp",               "none",                    "emote_aerobics_01"                  },
    { "Emote_Bendy",                    "Emote_Bendy",                      "none",                    "athena_music_emotes_bendy"          },
    { "Emote_BandOfTheFort",            "Emote_BandOfTheFort",              "none",                    "athena_emote_bandofthefort_music"   },
    { "Emote_Boogie_Down_Intro",        "Emote_Boogie_Down_Intro",          "Emote_Boogie_Down",       "emote_boogiedown"                   },
    { "Emote_Capoeira",                 "Emote_Capoeira",                   "none",                    "emote_capoeira"                     },
    { "Emote_KungFu_Cat",               "Emote_KungFu_Cat",                 "none",                    "kung_fu_cat"                        },
    { "Emote_Charleston",               "Emote_Charleston",                 "none",                    "athena_emote_flapper_music"         },
    { "Emote_Chicken",                  "Emote_Chicken",                    "none",                    "athena_emote_chicken_foley_01"      },
    { "Emote_Dance_NoBones",            "Emote_Dance_NoBones",              "none",                    "athena_emote_music_boneless"        },
    { "Emote_Dance_Shoot",              "Emote_Dance_Shoot",                "none",                    "athena_emotes_music_shoot_v7"       },
    { "Emote_Dance_SwipeIt",            "Emote_Dance_SwipeIt",              "none",                    "athena_emotes_music_swipeit"        },
    { "Emote_Dance_Disco_T3",           "Emote_Dance_Disco_T3",             "none",                    "athena_emote_disco"                 },
    { "Emote_DG_Disco",                 "Emote_DG_Disco",                   "none",                    "athena_emote_disco"                 },
    { "Emote_Dance_Worm",               "Emote_Dance_Worm",                 "none",                    "athena_emote_worm_music"            },
    { "Emote_Dance_Loser",              "Emote_Dance_Loser",                "Emote_Dance_Loser_CT",    "athena_music_emotes_takethel"       },
    { "Emote_Dance_Breakdance",         "Emote_Dance_Breakdance",           "none",                    "athena_emote_breakdance_music"      },
    { "Emote_Dance_Pump",               "Emote_Dance_Pump",                 "none",                    "emote_groove_jam_a"                 },
    { "Emote_Dance_RideThePony",        "Emote_Dance_RideThePony",          "none",                    "athena_emote_ridethepony_music_01"  },
    { "Emote_Dab",                      "Emote_Dab",                        "none",                    "",                                  },
    { "Emote_EasternBloc_Start",        "Emote_EasternBloc_Start",          "Emote_EasternBloc",       "eastern_bloc_musc_setup_d"          },
    { "Emote_FancyFeet",                "Emote_FancyFeet",                  "Emote_FancyFeet_CT",      "athena_emotes_lankylegs_loop_02"    },
    { "Emote_FlossDance",               "Emote_FlossDance",                 "none",                    "athena_emote_floss_music"           },
    { "Emote_FlippnSexy",               "Emote_FlippnSexy",                 "none",                    "emote_flippnsexy"                   },
    { "Emote_Fresh",                    "Emote_Fresh",                      "none",                    "athena_emote_fresh_music"           },
    { "Emote_GrooveJam",                "Emote_GrooveJam",                  "none",                    "emote_groove_jam_a"                 },
    { "Emote_guitar",                   "Emote_guitar",                     "none",                    "br_emote_shred_guitar_mix_03_loop"  },
    { "Emote_Hillbilly_Shuffle_Intro",  "Emote_Hillbilly_Shuffle_Intro",    "Emote_Hillbilly_Shuffle", "emote_hillbilly_shuffle"            },
    { "Emote_Hiphop_01",                "Emote_Hiphop_01",                  "Emote_Hip_Hop",           "s5_hiphop_breakin_132bmp_loop"      },
    { "Emote_Hula_Start",               "Emote_Hula_Start",                 "Emote_Hula",              "emote_hula_01"                      },
    { "Emote_InfiniDab_Intro",          "Emote_InfiniDab_Intro",            "Emote_InfiniDab_Loop",    "athena_emote_infinidab"             },
    { "Emote_Intensity_Start",          "Emote_Intensity_Start",            "Emote_Intensity_Loop",    "emote_intensity"                    },
    { "Emote_IrishJig_Start",           "Emote_IrishJig_Start",             "Emote_IrishJig",          "emote_irish_jig_foley_music_loop"   },
    { "Emote_KoreanEagle",              "Emote_KoreanEagle",                "none",                    "athena_music_emotes_koreaneagle"    },
    { "Emote_Kpop_02",                  "Emote_Kpop_02",                    "none",                    "emote_kpop_01"                      },
    { "Emote_LivingLarge",              "Emote_LivingLarge",                "none",                    "emote_livinglarge_a"                },
    { "Emote_Maracas",                  "Emote_Maracas",                    "none",                    "emote_samba_new_b"                  },
    { "Emote_PopLock",                  "Emote_PopLock",                    "none",                    "athena_emote_poplock"               },
    { "Emote_PopRock",                  "Emote_PopRock",                    "none",                    "emote_poprock_01"                   },
    { "Emote_RobotDance",               "Emote_RobotDance",                 "none",                    "athena_emote_robot_music"           },
    { "Emote_T-Rex",                    "Emote_T-Rex",                      "none",                    "emote_dino_complete"                },
    { "Emote_TechnoZombie",             "Emote_TechnoZombie",               "none",                    "athena_emote_founders_music"        },
    { "Emote_Twist",                    "Emote_Twist",                      "none",                    "athena_emotes_music_twist"          },
    { "Emote_WarehouseDance_Start",     "Emote_WarehouseDance_Start",       "Emote_WarehouseDance_Loop","emote_warehouse",                  },
    { "Emote_Wiggle",                   "Emote_Wiggle",                     "none",                    "wiggle_music_loop"                  },
    { "Emote_Youre_Awesome",            "Emote_Youre_Awesome",              "none",                    "youre_awesome_emote_music"          },
    { "Emote_Smooth_Moves",             "Emote_Smooth_Moves",               "none",                    "smooth_moves"                       },
    { "Emote_Friday13",                 "Emote_Friday13",                   "none",                    "california_girls"                   },
    { "Emote_Friday13_ES",              "Emote_Friday13",                   "none",                    "california_girls_es"                },
    { "Emote_Thanos_Twerk",             "Emote_Thanos_Twerk",               "none",                    "thanos_twerk"                       },
    { "Emote_DrLivesey_Walk",           "Emote_DrLivesey_Walk",             "none",                    "dr_livesey_walk_1,dr_livesey_walk_2"},
    { "Emote_Gangnam_Style",            "Emote_Gangnam_Style",              "none",                    "psychic"                            },
    { "Emote_InDaGhetto",               "Emote_InDaGhetto",                 "none",                    "emote_vivid"                        },
    { "Emote_BlindingLights",           "Emote_BlindingLights",             "none",                    "emote_autumn_tea"                   },
    { "Emote_Griddy",                   "Emote_Griddy",                     "none",                    "emote_griddles_music"               },
    { "Emote_ILikeToMoveIt",            "Emote_ILikeToMoveIt",              "none",                    "emote_jumpingjoy"                   },
    { "Emote_Macarena",                 "Emote_Macarena",                   "none",                    "emote_macaroon_music"               },
    { "Emote_NeverGonna",               "Emote_NeverGonna",                 "none",                    "emote_nevergonna"                   },
    { "Emote_NinjaStyle",               "Emote_NinjaStyle",                 "none",                    "emote_tour_bus"                     },
    { "Emote_PumpkinDance",             "Emote_PumpkinDance",               "none",                    "pumpkin_dance"                      },
    { "Emote_PumpUpTheJam",             "Emote_PumpUpTheJam",               "none",                    "deflated_emote_music"               },
    { "Emote_Renegade",                 "Emote_Renegade",                   "none",                    "emote_just_home_music"              },
    { "Emote_RushinAround",             "Emote_RushinAround",               "none",                    "emote_comrade"                      },
    { "Emote_SaySo",                    "Emote_SaySo",                      "none",                    "emote_hotpink"                      },
    { "Emote_Stuck",                    "Emote_Stuck",                      "none",                    "emote_downward"                     },
    { "Emote_ToosieSlide",              "Emote_ToosieSlide",                "none",                    "emote_art_giant"                    },
    { "Emote_AirShredder",              "Emote_AirShredder",                "none",                    "air_guitar_emote"                   },
    { "Emote_Crossbounce",              "Emote_Crossbounce",                "none",                    "emote_blaster"                      },
    { "Emote_DistractionDance",         "Emote_DistractionDance",           "none",                    "distraction"                        },
    { "Emote_Headbanger",               "Emote_Headbanger",                 "none",                    "headbanger_music"                   },
    { "Emote_HitchHiker",               "Emote_HitchHiker",                 "none",                    "hitchhiker_music"                   },
    { "Emote_ItsGoTime",                "Emote_ItsGoTime",                  "none",                    "itsgotime_music"                    },
    { "Emote_KneeSlapper",              "Emote_KneeSlapper",                "none",                    "kneeslapper_music"                  },
    { "Emote_Showstopper",              "Emote_Showstopper",                "none",                    "showstopper_music"                  },
    { "Emote_Sprinkler",                "Emote_Sprinkler",                  "none",                    "sprinkler_music"                    },
    { "Emote_Gmod",                     "Emote_Gmod",                       "none",                    "gmod_select"                        },
    { "Emote_ChickenDance",             "Emote_ChickenDance",               "none",                    "pollo_dance"                        },
    { "Emote_Ghostbusters",             "Emote_Ghostbusters",               "none",                    "toastbust"                          },
    { "Emote_Martian",                  "Emote_Martian",                    "none",                    "leave_the_door"                     },
    { "Emote_RememberMe_Intro",         "Emote_RememberMe_Intro",           "Emote_RememberMe_Loop",   "unforgettable"                      },
    { "Emote_Rollie",                   "Emote_Rollie",                     "none",                    "rollie_rollie"                      },
    { "Emote_Scenario",                 "Emote_Scenario",                   "none",                    "scenariooo"                         },
    { "Emote_Tpose",                    "Emote_Tpose",                      "none",                    ""                                   },
    { "Emote_SmoothDrive",              "Emote_SmoothDrive",                "none",                    "dropit"                             },
    { "Emote_Groove_Battle",            "Emote_Groove_Battle",              "none",                    "groove_battle_1,groove_battle_2"    },
    { "Emote_Walkywalk_Walk",           "Emote_Walkywalk_Walk",             "none",                    "emote_walkywalk"                    },
    { "Emote_EpicSaxGuy",               "Emote_EpicSaxGuy",                 "none",                    "emote_epicsaxguy"                   },
    { "Taunt_Quagmire",                 "Taunt_Quagmire",                   "none",                    "taunt_quagmire"                     }, // New "Taunt" category? im lazzy to make this now...
};

// ============================================================
// Globals
// ============================================================

int EMOTES_COUNT = sizeof(g_Emotes);
int DANCES_COUNT = sizeof(g_Dances);

TopMenu hTopMenu;

<<<<<<< Updated upstream
Handle  CooldownTimers[MAXPLAYERS+1],
=======
ConVar  g_cvHidePlayers, // Players only
        g_cvFlagEmotesMenu, // This gates menu only, all clients can always emote/dance no matter what this is set to
        g_cvFlagDancesMenu, // This gates menu only, all clients can always emote/dance no matter what this is set to
        g_cvCooldown,
        g_cvSpeed,
        g_cvSounds,
        g_cvSoundVolume, // Sound volume
        g_cvSoundLevel,  // Sound fadeoff with distance
        g_cvHideWeapons, // Players only
        g_cvTeleportBack, // Not applied to infected and witches
        g_cvProbabilityWitch,
        g_cvProbabilityInfected,
        g_cvMissionLost, // Witch+Common dance on mission_lost
        g_cvMaxDancers, // Maximum dancing entities on server
        g_cvFastCull, // BONEMERGE_FASTCULL
        g_cvSafety, // Guard entity limit
        g_cvTeleportFix; // Players only

Handle  CooldownTimers[MAXENTITIES+1],
>>>>>>> Stashed changes
        g_EmoteForward,
        g_EmoteForward_Pre;

ConVar  g_cvHidePlayers,
        g_cvFlagEmotesMenu,
        g_cvFlagDancesMenu,
        g_cvCooldown,
        g_cvSpeed,
        g_cvEmotesSounds,
        g_cvHideWeapons,
        g_cvTeleportBack,
        g_cvBlockNonHumanoid;

int   g_iEmoteEnt[MAXPLAYERS+1] =      {INVALID_ENT_REFERENCE,...}; // Emote entity, client bonemerges to it to dance, client cannot see it nor itself.
int   g_iSkinEnt[MAXPLAYERS+1] =       {INVALID_ENT_REFERENCE,...}; // Dancing entity, bonemerges to emote entity, client can see it. Not always used.
int   g_iWeaponHandEnt[MAXPLAYERS+1] = {INVALID_ENT_REFERENCE,...};
int   g_EmotesTarget[MAXPLAYERS+1];
<<<<<<< Updated upstream
int   g_iModelIndex[MAXPLAYERS+1]; // StopEmote() if player model changes.
=======
int   g_iModelPrecache; // modelprecache stringtable index. changes every map
int   g_iModelIndexFake; // model index for fake model for infected/witch dances
int   g_iMaxEntitySafe; // max safe entity index
>>>>>>> Stashed changes

char  g_sEmoteSound[MAXPLAYERS+1][PLATFORM_MAX_PATH],
      g_sEmoteLoop[MAXPLAYERS+1][64],
      g_sModelPath[PLATFORM_MAX_PATH];

bool  g_bClientDancing[MAXPLAYERS+1],
      g_bEmoteCooldown[MAXPLAYERS+1],
      g_bHooked[MAXPLAYERS+1],
      g_bSoundsCached,
      g_bL4D2,
<<<<<<< Updated upstream
      g_bL4DD, // l4dhooks check. LibraryExists() is expensive
      g_bMapStarted; // prevent emotes if map is not ready

float  g_fLastAngles[MAXPLAYERS+1][3],
       g_fLastPosition[MAXPLAYERS+1][3];
=======
      g_bL4DD,           // l4dhooks check. LibraryExists() is expensive
      g_bMapStarted,     // prevent emotes if map is not ready
      g_bSurvivorsLost,  // infected and witch dance without interruption
      g_bFinale,         // disable infected dances
      g_bLate,           // late plugin start, for reading Finale state
      g_bRoundEnd,       // stop Survivors from emoting to not lose items
      g_bFrameNoDancers; // optimization, CreateEmote() early exit

float  g_fLastAngles[MAXPLAYERS+1][3],
       g_fLastPosition[MAXPLAYERS+1][3],
       g_fLastDance[MAXPLAYERS+1], // Restrict movetype restore only to clients who danced recently
       vOOB[3]; // Vector position outside of playable bounds, for cleanup
>>>>>>> Stashed changes

public Plugin myinfo =
{
<<<<<<< Updated upstream
    name = "[L4D1/L4D2] Fortnite Emotes & Dances",
    author = "Kodua, Franc1sco franug, TheBO$$, Aleexxx, Foxhound, nearly civilized, Ferks-FK, gvazdas",
    description = "Animations from Fortnite in CS:GO/L4D2. New emotes ported by nearly civilized",
    version = "2.5.0",
    url = "https://github.com/Ferks-FK/Fortnite-Emotes-Extended"
};
=======
    int ent;            // Dancing entity. <=0 if slot is fully free and cleanup is complete (emote entref is invalid)
    int emoteRef;       // Invisible prop_dynamic that does the dancing. Clients and skinRef bonemerge to it
    int skinRef;        // commentary_dummy. Not always used
    int modelIndex;     // Entity model in modelprecache stringtable
    int amount;         // 0-based emote index
    bool sound;         // played sound
    MoveType movetype;  // restore movetype when emote is finished
}

Dancer g_Dancers[MAXDANCERS];
int g_iDancers[MAXENTITIES+1] = {-1,...}; // entity index -> g_Dancers map
// SM 1.13+: use IntMap and GetMaxEntities()
>>>>>>> Stashed changes

// First thing that fires in the entire plugin lifecycle.
public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
    switch (GetEngineVersion())
    {
        case Engine_Left4Dead2: g_bL4D2 = true;
        case Engine_Left4Dead:  g_bL4D2 = false;
        default:
        {
            strcopy(error,err_max,"Plugin only supports L4D1 and L4D2.");
		    return APLRes_Failure;
        }
    }
    RegPluginLibrary("fnemotes");
    CreateNative("fnemotes_IsClientEmoting", Native_IsClientEmoting);
    CreateNative("fnemotes_StopEmote", Native_StopEmote);
    return APLRes_Success;
}

public void OnPluginStart()
{
    LoadTranslations("common.phrases");
    LoadTranslations("fnemotes_near.phrases");

<<<<<<< Updated upstream
    RegConsoleCmd("sm_rdance",    Command_Random_Emote, "Performs a random dance or emote");
    RegConsoleCmd("sm_emotes",    Command_Menu);
    RegConsoleCmd("sm_emote",     Command_Menu);
    RegConsoleCmd("sm_dances",    Command_Menu);
    RegConsoleCmd("sm_dance",     Command_Menu);
    RegAdminCmd("sm_setemotes",   Command_Admin_Emotes, ADMFLAG_GENERIC, "[SM] Usage: sm_setemotes <#userid|name> [Emote ID]"); // -1 to StopEmote
    RegAdminCmd("sm_setemote",    Command_Admin_Emotes, ADMFLAG_GENERIC, "[SM] Usage: sm_setemotes <#userid|name> [Emote ID]"); // -1 to StopEmote
    RegAdminCmd("sm_setdances",   Command_Admin_Emotes, ADMFLAG_GENERIC, "[SM] Usage: sm_setemotes <#userid|name> [Emote ID]"); // -1 to StopEmote
    RegAdminCmd("sm_setdance",    Command_Admin_Emotes, ADMFLAG_GENERIC, "[SM] Usage: sm_setemotes <#userid|name> [Emote ID]"); // -1 to StopEmote
    RegConsoleCmd("sm_doemote",   Command_Do_Emotes,   "[SM] Usage: sm_doemote [Emote ID]"); // -1 to StopEmote
    RegConsoleCmd("sm_dodance",   Command_Do_Emotes,   "[SM] Usage: sm_dodance [Emote ID]"); // -1 to StopEmote
    RegAdminCmd("sm_danceall",    Command_Force_Emote, ADMFLAG_GENERIC, "Forces all players to dance");
    RegConsoleCmd("sm_stopemote", Command_Stop);
    RegConsoleCmd("sm_stopdance", Command_Stop);
=======
    RegAdminCmd("sm_setemotes",         Command_Admin_Emotes,       ADMFLAG_GENERIC, "sm_setemotes <#userid|name> [Emote ID]");
    RegAdminCmd("sm_setemote",          Command_Admin_Emotes,       ADMFLAG_GENERIC, "sm_setemote  <#userid|name> [Emote ID]");
    RegAdminCmd("sm_setdances",         Command_Admin_Emotes,       ADMFLAG_GENERIC, "sm_setdances <#userid|name> [Emote ID]");
    RegAdminCmd("sm_setdance",          Command_Admin_Emotes,       ADMFLAG_GENERIC, "sm_setdance  <#userid|name> [Emote ID]");
    RegAdminCmd("sm_danceall",          Command_Force_Emote,        ADMFLAG_GENERIC, "Force random dance on all players. If any extra argument is supplied, include witches and common infected.");
    RegAdminCmd("sm_emoteactive",       Command_Active_Emotes,      ADMFLAG_GENERIC, "Count active emotes.");
    RegAdminCmd("sm_dance_infected",    Command_Dance_Infected,     ADMFLAG_GENERIC, "[Emote ID] All non-busy common infected dance");
    RegAdminCmd("sm_dance_witch",       Command_Dance_Witch,        ADMFLAG_GENERIC, "[Emote ID] All non-busy witches dance");
    RegAdminCmd("sm_dance_aim",         Command_Dance_Aim,          ADMFLAG_GENERIC, "[Emote ID] Entity client is looking at will dance (if not busy)");
    RegAdminCmd("sm_dance_entity",      Command_Dance_Entity,       ADMFLAG_GENERIC, "[Emote ID] Entity index will dance (if not busy)");
    RegAdminCmd("sm_emote_debugtarget", Command_Debug_Target,       ADMFLAG_GENERIC, "Debug dancer");
    
    RegConsoleCmd("sm_rdance",          Command_Random_Emote,       "Performs a random dance or emote");
    RegConsoleCmd("sm_emotes",          Command_Menu);
    RegConsoleCmd("sm_emote",           Command_Menu);
    RegConsoleCmd("sm_dances",          Command_Menu);
    RegConsoleCmd("sm_dance",           Command_Menu);
    RegConsoleCmd("sm_doemote",         Command_Do_Emotes,          "sm_doemote [Emote ID]");
    RegConsoleCmd("sm_dodance",         Command_Do_Emotes,          "sm_dodance [Emote ID]");
    RegConsoleCmd("sm_stopemote",       Command_Stop,               "Stop emoting. If admin, targets can be provided.");
    RegConsoleCmd("sm_stopdance",       Command_Stop,               "Stop emoting. If admin, targets can be provided.");
    RegConsoleCmd("sm_emoteids",        Command_List_Emotes,        "Print all possible 1-based Emote ID values to console. Subtract 1 to convert to 0-based ID.");

    HookEvent("entity_shoved",              Event_entityid,         EventHookMode_Pre); // entityid
    
    HookEvent("witch_harasser_set",         Event_witchid,          EventHookMode_Pre); // witchid
    HookEvent("witch_spawn",                Event_witchid,          EventHookMode_Pre); // witchid
    HookEvent("witch_killed",               Event_witchid,          EventHookMode_Pre); // witchid
>>>>>>> Stashed changes

    HookEvent("drag_begin",                 Event_PlayerSubject,    EventHookMode_Pre);

    HookEvent("tongue_grab",                Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("choke_start",                Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("lunge_shove",                Event_PlayerVictim,     EventHookMode_Pre);
    if (g_bL4D2)
    {
    HookEvent("jockey_ride",                Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("charger_carry_start",        Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("charger_impact",             Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("charger_pummel_start",       Event_PlayerVictim,     EventHookMode_Pre);
    }

    HookEvent("player_spawn",               Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_death",               Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_hurt",                Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_falldamage",          Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_incapacitated",       Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_shoved",              Event_PlayerShoved,     EventHookMode_Pre);
    HookEvent("player_now_it",              Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_blind",               Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_ledge_grab",          Event_PlayerUserid,     EventHookMode_Pre);
<<<<<<< Updated upstream
    if (g_bL4D2)
    {
    HookEvent("entered_spit",               Event_PlayerUserid,     EventHookMode_Pre);
    }
=======
>>>>>>> Stashed changes
    
    HookEvent("player_team",                Event_PlayerTeam,       EventHookMode_Pre);
    HookEvent("player_bot_replace",         Event_BotReplacePlayer, EventHookMode_Pre);
    HookEvent("bot_player_replace",         Event_BotReplacePlayer, EventHookMode_Pre);
    HookEvent("round_start",                Event_RoundStart);
    HookEvent("round_end",                  Event_RoundEnd);

    HookEvent("map_transition",             Event_Transition,       EventHookMode_Pre);

<<<<<<< Updated upstream
    g_cvEmotesSounds  = CreateConVar("sm_emotes_sounds",            "1",    "Enable/Disable sounds for emotes. Sounds will activate on next map.", FCVAR_NOTIFY);
    g_cvCooldown      = CreateConVar("sm_emotes_cooldown",          "1.0",  "Cooldown for emotes in seconds. -1 or 0 = no cooldown.", FCVAR_NOTIFY);
    g_cvFlagEmotesMenu= CreateConVar("sm_emotes_admin_flag_menu",   "",     "admin flag for emotes (empty for all players)");
    g_cvFlagDancesMenu= CreateConVar("sm_dances_admin_flag_menu",   "",     "admin flag for dances (empty for all players)");
    g_cvHideWeapons   = CreateConVar("sm_emotes_hide_weapons",      "1",    "Hide weapons when dancing", FCVAR_NOTIFY);
    g_cvHidePlayers   = CreateConVar("sm_emotes_hide_enemies",      "0",    "Hide enemy players when dancing", FCVAR_NOTIFY);
    g_cvTeleportBack  = CreateConVar("sm_emotes_teleportonend",     "1",    "Teleport back to the exact position when he started to dance.", FCVAR_NOTIFY);
    g_cvSpeed         = CreateConVar("sm_emotes_speed",             "0.84", "Sets the playback speed of the animation.", FCVAR_PROTECTED);
    g_cvBlockNonHumanoid = CreateConVar("sm_emotes_block_nonhumanoid", "1", "L4D2: block emotes for Spitter, Jockey and Charger (their skeletons can't play the dances).", FCVAR_NOTIFY);
=======
    HookEvent("finale_start", 			    Event_FinaleStart,      EventHookMode_PostNoCopy); // some finale maps won't trigger
    HookEvent("finale_radio_start", 	    Event_FinaleStart,      EventHookMode_PostNoCopy); // all finale maps trigger
    if (g_bL4D2)
        HookEvent("gauntlet_finale_start", 	Event_FinaleStart,      EventHookMode_PostNoCopy);

    g_cvSounds  =       CreateConVar("sm_emotes_sounds",               "2",    "Sounds for 1:player,2:player+witch,3:all. Will activate on next map.", FCVAR_NOTIFY);
    g_cvSoundVolume  =  CreateConVar("sm_emotes_soundvol",             "1.0",  "Sound volume [0.0,1.0].", FCVAR_NOTIFY, true, 0.0, true, 1.0);
    g_cvSoundLevel  =   CreateConVar("sm_emotes_soundlvl",             "85",   "Sound level in dB [0,180].", FCVAR_NOTIFY, true, 0.0, true, 180.0);
    g_cvCooldown      = CreateConVar("sm_emotes_cooldown",             "1.0",  "Cooldown for emotes in seconds. -1 or 0 = no cooldown.", FCVAR_NOTIFY);
    g_cvFlagEmotesMenu= CreateConVar("sm_emotes_admin_flag_menu",      "",     "admin flag for emotes (empty for all players)");
    g_cvFlagDancesMenu= CreateConVar("sm_dances_admin_flag_menu",      "",     "admin flag for dances (empty for all players)");
    g_cvHideWeapons   = CreateConVar("sm_emotes_hide_weapons",         "1",    "(Players) Hide weapons when dancing", FCVAR_NOTIFY);
    g_cvHidePlayers   = CreateConVar("sm_emotes_hide_enemies",         "0",    "(Players) Hide enemy players when dancing", FCVAR_NOTIFY);
    g_cvTeleportBack  = CreateConVar("sm_emotes_teleportonend",        "1",    "(Players) Teleport back to position where dance started.", FCVAR_NOTIFY);
    g_cvSpeed         = CreateConVar("sm_emotes_speed",                "0.84", "Sets the playback speed of the animation.", FCVAR_PROTECTED);
    g_cvFastCull =      CreateConVar("sm_emotes_fastcull",             "1",   "Fastcull bonemerge. Shadows tend to cut off more but don't jump around sporadically.", FCVAR_NOTIFY);
    g_cvTeleportFix =   CreateConVar("sm_emotes_teleportfix",          "1",   "(Players) Stop emote if player teleports.", FCVAR_NOTIFY);
    g_cvSafety =        CreateConVar("sm_emotes_crashguard",           "1",   "Prevents entities from being created close to MaxEntities.", FCVAR_NOTIFY);

    g_cvProbabilityWitch = CreateConVar("sm_emotes_pwitch", "0.25",
    "Probability for Witches to do a random dance on spawn. 0 to disable.",
    FCVAR_NOTIFY, true, 0.0, true, 1.0);

    g_cvProbabilityInfected = CreateConVar("sm_emotes_pcommon", "0.10",
    "Probability for Common Infected to do a random dance on spawn. 0 to disable.",
    FCVAR_NOTIFY, true, 0.0, true, 1.0);

    g_cvMissionLost = CreateConVar("sm_emotes_lost", "1",
    "Common Infected and Witches flex on survivors if they lost.",
    FCVAR_NOTIFY, true, 0.0, true, 1.0);

    g_cvMaxDancers = CreateConVar("sm_emotes_max", "50",
    "Maximum entities emoting/dancing simultaneously.",
    FCVAR_NOTIFY, true, 0.0, true, MAXDANCERS*1.0);
>>>>>>> Stashed changes

    TopMenu topmenu;
    if (LibraryExists("adminmenu") && ((topmenu = GetAdminTopMenu()) != null))
        OnAdminMenuReady(topmenu);

    g_EmoteForward     = CreateGlobalForward("fnemotes_OnEmote",     ET_Ignore, Param_Cell);
    g_EmoteForward_Pre = CreateGlobalForward("fnemotes_OnEmote_Pre", ET_Event,  Param_Cell);

    AutoExecConfig(true, "fortnite_emotes_nearlycivilized");
}

public void OnPluginEnd()
{
    for (int i = 1; i <= MaxClients; i++)
        StopEmote(i);
}

public void OnAllPluginsLoaded()
{
    g_bL4DD = LibraryExists("left4dhooks");
<<<<<<< Updated upstream
=======
    // Check if Finale is active on late plugin start
    if (!g_bLate) return;
    g_bLate = false;
    if (g_bFinale || !g_bL4DD || !g_bMapStarted) return;
    if (!L4D_HasMapStarted()) return;
    if (!L4D_IsFinaleActive()) return;
    // ignore "fake" VScript finales
    int finale = FindEntityByClassname(-1, "trigger_finale");
    g_bFinale = finale>0 && IsValidEntity(finale);    
>>>>>>> Stashed changes
}

public void OnLibraryAdded(const char[] name)
{
    if (strcmp(name,"left4dhooks",false)==0)
        g_bL4DD = true;
}

public void OnLibraryRemoved(const char[] name)
{
    if (strcmp(name,"left4dhooks",false)==0)
        g_bL4DD = false;
}

int Native_IsClientEmoting(Handle plugin, int numParams)
{
    int client = GetNativeCell(1);
    if (client<1 || client>MaxClients)
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index %d", client);
    return g_bClientDancing[client];
}

int Native_StopEmote(Handle plugin, int numParams)
{
    int client = GetNativeCell(1);
    if (client<1 || client>MaxClients)
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid client index %d", client);
    bool wasEmoting = g_bClientDancing[client];
    StopEmote(client);
    return wasEmoting;
}

public void OnMapStart()
{
    char base[PLATFORM_MAX_PATH], path[PLATFORM_MAX_PATH];
    strcopy(base, sizeof(base), g_bL4D2 ? FILE_MODEL_BASE : FILE_MODEL_BASE_L4D1);

    FormatEx(g_sModelPath, sizeof(g_sModelPath), "%s.mdl", base);
    PrecacheModel(g_sModelPath, true);

    g_bMapStarted = true;

    AddFileToDownloadsTable(g_sModelPath);

    FormatEx(path, sizeof(path), "%s.vvd", base);
    AddFileToDownloadsTable(path);
    
    FormatEx(path, sizeof(path), "%s.dx90.vtx", base);
    AddFileToDownloadsTable(path);
<<<<<<< Updated upstream
=======

    g_iMaxEntitySafe = GetMaxEntities()-100;
    g_bMapStarted = true;
    g_iModelPrecache = INVALID_STRING_TABLE;
    SetFrameNoDancers(false);

    RequestFrame(GetMapBounds);
>>>>>>> Stashed changes
}

public void OnMapEnd()
{
    OnPluginEnd();
    g_bMapStarted = false;
}

public void OnConfigsExecuted()
{
    g_bSoundsCached = false;
    if (!g_cvSounds.BoolValue)
        return;

    char sound[64];
    for (int i = 0; i < EMOTES_COUNT; i++)
    {
        strcopy(sound, sizeof(sound), g_Emotes[i].sound);
        if (!StrEqual(sound, ""))
        {
            if (StrContains(sound, ",") != -1)
            {
                char sounds[8][64];
                int count = ExplodeString(sound, ",", sounds, sizeof(sounds), sizeof(sounds[]));
                for (int j = 0; j < count; j++)
                    PrecacheEmoteSound(sounds[j]);
            }
            else
                PrecacheEmoteSound(sound);
        }
    }
    for (int i = 0; i < DANCES_COUNT; i++)
    {
        strcopy(sound, sizeof(sound), g_Dances[i].sound);
        if (!StrEqual(sound, ""))
        {
            if (StrContains(sound, ",") != -1)
            {
                char sounds[8][64];
                int count = ExplodeString(sound, ",", sounds, sizeof(sounds), sizeof(sounds[]));
                for (int j = 0; j < count; j++)
                    PrecacheEmoteSound(sounds[j]);
            }
            else
                PrecacheEmoteSound(sound);
        }
    }
    g_bSoundsCached = true;
}

// Precache a single emote sound, skipping missing files.
void PrecacheEmoteSound(const char[] soundName)
{
    char fullPath[PLATFORM_MAX_PATH];
    FormatEx(fullPath, sizeof(fullPath), "%s%s.mp3", SOUND_BASE_FULL, soundName);
    if (!FileExists(fullPath, true))
    {
        LogError("Emote sound not found: %s", fullPath);
        return;
    }
    
    AddFileToDownloadsTable(fullPath);

    char precachePath[PLATFORM_MAX_PATH];
    FormatEx(precachePath, sizeof(precachePath), "%s%s.mp3", SOUND_BASE_PATH, soundName);
    PrecacheSound(precachePath);
}

public void OnClientPutInServer(int client)
{
    TerminateEmote(client);
    if (IsValidClient(client))
    {
        ResetCam(client);
        g_iWeaponHandEnt[client] = INVALID_ENT_REFERENCE;

        if (CooldownTimers[client] != null)
            KillTimer(CooldownTimers[client]);
    }
}

public void OnClientDisconnect(int client)
{
    TerminateEmote(client);
    if (IsValidClient(client))
    {
        ResetCam(client);
        if (CooldownTimers[client] != null)
        {
            KillTimer(CooldownTimers[client]);
            CooldownTimers[client] = null;
            g_bEmoteCooldown[client] = false;
        }
    }
    if (client>0 && client<=MaxClients)
        g_bHooked[client] = false;
}

// ============================================================
// Events
// ============================================================

public void L4D2_OnStagger_Post(int client, int source)
{
    StopEmote(client);
}

public void L4D_OnMaterializeFromGhost(int client)
{
    StopEmote(client);
}

public void L4D2_OnPlayerFling_Post(int client, int attacker, const float vecDir[3])
{
    StopEmote(client);
}

public void L4D2_OnPounceOrLeapStumble_Post(int victim, int attacker)
{
    StopEmote(victim);
}

public void L4D_OnKnockedDown_Post(int client, int reason)
{
    StopEmote(client);
}

public void L4D2_OnThrowImpactedSurvivor_Post(int attacker, int victim)
{
    StopEmote(victim);
}

public void L4D_OnFalling(int client)
{
    StopEmote(client);
}

void Event_BotReplacePlayer(Event event, const char[] name, bool dontBroadcast)
{
    int player = GetClientOfUserId(event.GetInt("player"));
    int bot    = GetClientOfUserId(event.GetInt("bot"));
    StopEmote(player);
    StopEmote(bot);
}

void Event_PlayerVictim(Event event, const char[] name, bool dontBroadcast)
{
    int victim = GetClientOfUserId(event.GetInt("victim"));
    StopEmote(victim);
}

void Event_PlayerSubject(Event event, const char[] name, bool dontBroadcast)
{
    int victim = GetClientOfUserId(event.GetInt("subject"));
    StopEmote(victim);
}

void Event_PlayerUserid(Event event, const char[] name, bool dontBroadcast)
{
    int victim = GetClientOfUserId(event.GetInt("userid"));
    StopEmote(victim);
}

// Teammates can shove a dancing player without stopping the emote.
void Event_PlayerShoved(Event event, const char[] name, bool dontBroadcast)
{
    int victim = GetClientOfUserId(event.GetInt("userid"));
    int attacker = GetClientOfUserId(event.GetInt("attacker"));
<<<<<<< Updated upstream
    if (victim && attacker && GetClientTeam(victim) == GetClientTeam(attacker)) return;
=======
    if (IsValidClient(victim) && IsValidClient(attacker) && GetClientTeam(victim) == GetClientTeam(attacker))
        return;
    //LogMessage("Event_PlayerShoved %d %s", victim, name);
>>>>>>> Stashed changes
    StopEmote(victim);
}

void Event_PlayerTeam(Event event, const char[] name, bool dontBroadcast)
{
    int client = GetClientOfUserId(event.GetInt("userid"));
    StopEmote(client);
    if (IsValidClient(client))
        CreateTimer(0.1, Timer_ResetMovetype, client, TIMER_FLAG_NO_MAPCHANGE);
}

void Event_RoundStart(Event event, const char[] name, bool dontBroadcast)
{
    for (int i = 1; i <= MaxClients; i++)
    {
        StopEmote(i);
    }
}

void Event_RoundEnd(Event event, const char[] name, bool dontBroadcast)
{
    for (int i = 0; i <= MaxClients; i++)
    {
        if (!IsValidClient(i))
            continue;
        if (IsFakeClient(i) && L4D_GetClientTeam(i) == L4DTeam_Infected)
            CreateTimer(1.0, BotTaunt, i, TIMER_FLAG_NO_MAPCHANGE);
    }
}

<<<<<<< Updated upstream
=======
void Event_Lost(Event event, const char[] name, bool dontBroadcast)
{
    g_bSurvivorsLost = true;
    g_bRoundEnd = true;
    for (int i = 1; i <= MaxClients; i++)
    {
        if (!IsValidClient(i))
            continue;
        if (view_as<L4DTeam>(GetClientTeam(i)) == L4DTeam_Survivor)
        {
            // Otherwise dancing survivors will lose their items into next round
            StopEmote(i);
        }
        if (IsFakeClient(i) && view_as<L4DTeam>(GetClientTeam(i)) == L4DTeam_Infected)
            CreateTimer(0.25, BotTaunt, i, TIMER_FLAG_NO_MAPCHANGE);
    }
    if (!g_cvMissionLost.BoolValue) return;
    ServerCommand("sm_dance_witch %d", PERFORM_RANDOM_ALL+1);
    ServerCommand("sm_dance_infected %d", PERFORM_RANDOM_ALL+1);
}

// asdf to here
void Event_FinaleStart(Event event, const char[] name, bool dontBroadcast)
{
    g_bFinale = true;
}

>>>>>>> Stashed changes
// Probably a good idea to avoid passing entities into the next level.
void Event_Transition(Event event, const char[] name, bool dontBroadcast)
{
    OnPluginEnd();
    g_bMapStarted = false;
}
public Action L4D1_OnSavingEntities(int info_changelevel, Address Kv)
{
    OnPluginEnd();
    g_bMapStarted = false;
    return Plugin_Continue;
}
public Action L4D2_OnSavingEntities(int info_changelevel)
{
    OnPluginEnd();
    g_bMapStarted = false;
    return Plugin_Continue;
}

Action BotTaunt(Handle timer, int client)
{
    if (!IsValidClient(client))
        return Plugin_Continue;
    RandomDance(client);
    return Plugin_Continue;
}

Action Timer_ResetMovetype(Handle timer, any client)
{
    if (IsValidClient(client) && IsPlayerAlive(client) && !bIsPlayerIncapped(client))
        SetEntityMoveType(client, MOVETYPE_WALK);
        
    return Plugin_Stop;
}

// ============================================================
// Commands
// ============================================================

Action Command_Stop(int client, int args)
{
    StopEmote(client);
    return Plugin_Handled;
}

<<<<<<< Updated upstream
=======
// Print 1-based Emote IDs
Action Command_List_Emotes(int client, int args)
{
    ReplyToCommand(client,"--- fnemotes_near version %s Emote IDs ---", PLUGIN_VERSION);
    ReplyToCommand(client,"%d -> random", PERFORM_RANDOM_ALL+1);
    ReplyToCommand(client,"%d -> random emote", PERFORM_RANDOM_EMOTE+1);
    ReplyToCommand(client,"%d -> random dance", PERFORM_RANDOM_DANCE+1);
    ReplyToCommand(client,"%d -> stop", PERFORM_STOP+1);
    for (int i = 0; i < TOTAL_COUNT; i++)
    {
        if (i<EMOTES_COUNT)
            ReplyToCommand(client,"%d -> %s (emote)", i+1, g_Emotes[i].name);
        else
            ReplyToCommand(client,"%d -> %s (dance)", i+1, g_Dances[i-EMOTES_COUNT].name);
    }
    return Plugin_Handled;
}

// Count number of active dancing entities
Action Command_Active_Emotes(int client, int args)
{
    int total, num_player, num_infected, num_witch;
    int emote;
    for (int i=0;i<MAXDANCERS;i++)
    {
        if (g_Dancers[i].ent<=0) continue;
        emote = EntRefToEntIndex(g_Dancers[i].emoteRef);
        if (emote<=0) continue;
        total += 1;
        switch (GetEmoteClass(g_Dancers[i].ent))
        {
            case EMOTECLASS_PLAYER:   num_player   += 1;
            case EMOTECLASS_INFECTED: num_infected += 1;
            case EMOTECLASS_WITCH:    num_witch    += 1;
        }
    }
    ReplyToCommand(client,"[SM] Players+Commons+Witches=Total | %d+%d+%d=%d",
        num_player,num_infected,num_witch,total);
    return Plugin_Handled;
}

// Command all non-busy infected to dance
Action Command_Dance_Infected(int client, int args)
{
    int entity = -1;
    int amount = PERFORM_RANDOM_DANCE;
    if (args>0)
    {
        char arg[8];
        GetCmdArg(1,arg,8);
        if (strcmp(arg,"stop",false)==0)
            amount = PERFORM_STOP;
        else if (GetCmdArgIntEx(1,amount))
            amount -= 1; // convert 1-based to 0-based Emote I
    }
    while ( ((entity = FindEntityByClassname(entity, "infected")) != -1) )
        PerformEmote(client, entity, GetAmount(amount));
    return Plugin_Handled;
}

// Command all non-busy witches to dance
Action Command_Dance_Witch(int client, int args)
{
    int entity = -1;
    int amount = PERFORM_RANDOM_DANCE;
    if (args>0)
    {
        char arg[8];
        GetCmdArg(1,arg,8);
        if (strcmp(arg,"stop",false)==0)
            amount = PERFORM_STOP;
        else if (GetCmdArgIntEx(1,amount))
            amount -= 1; // convert 1-based to 0-based Emote I
    }
    while ( ((entity = FindEntityByClassname(entity, "witch")) != -1) )
        PerformEmote(client, entity, GetAmount(amount));
    return Plugin_Handled;
}

// Command non-busy aim target to dance
Action Command_Dance_Aim(int client, int args)
{
    if (!IsValidClient(client)) return Plugin_Handled;
    int target = GetClientAimTarget(client,false);
    if (target<=0 || target==client) return Plugin_Handled;
    int amount = PERFORM_RANDOM_DANCE;
    if (args>0)
    {
        char arg[8];
        GetCmdArg(1,arg,8);
        if (strcmp(arg,"stop",false)==0)
            amount = PERFORM_STOP;
        else if (GetCmdArgIntEx(1,amount))
            amount -= 1; // convert 1-based to 0-based Emote I
    }
    PerformEmote(client, target, GetAmount(amount));
    return Plugin_Handled;
}

// Check dancer properties
Action Command_Debug_Target(int client, int args)
{
    if (!IsValidClient(client)) return Plugin_Handled;
    int target = GetClientAimTarget(client,false);
    if (target<=0) target = client;
    if (!IsEntityDancing(target))
    {
        ReplyToCommand(client,"%d is not dancing", target);
        return Plugin_Handled;
    }
    int dancer = g_iDancers[target];
    float pose_rig = GetEntPropFloat(g_Dancers[dancer].emoteRef, Prop_Send, "m_flPoseParameter", 0);
    float pose_x = GetEntPropFloat(g_Dancers[dancer].emoteRef, Prop_Send, "m_flPoseParameter", 1);
    float pose_y = GetEntPropFloat(g_Dancers[dancer].emoteRef, Prop_Send, "m_flPoseParameter", 2);
    int seq = GetEntProp(g_Dancers[dancer].emoteRef, Prop_Send, "m_nSequence");
    float cycle = GetEntPropFloat(g_Dancers[dancer].emoteRef, Prop_Send, "m_flCycle");
    ReplyToCommand(client,"%d amount %d seq %d cycle %.2f poses %.2f %.2f %.2f", target, g_Dancers[dancer].amount, seq, cycle, pose_rig,pose_x,pose_y);
    return Plugin_Handled;
}

// Command non-busy entity to dance
Action Command_Dance_Entity(int client, int args)
{
    if (args<=0) return Plugin_Handled;
    int target;
    if (!GetCmdArgIntEx(1,target)) return Plugin_Handled;
    if (target<=0 || target>MAXENTITIES) return Plugin_Handled;
    int amount = PERFORM_RANDOM_DANCE;
    if (args>1)
    {
        char arg[8];
        GetCmdArg(2,arg,8);
        if (strcmp(arg,"stop",false)==0)
            amount = PERFORM_STOP;
        else if (GetCmdArgIntEx(2,amount))
            amount -= 1; // convert 1-based to 0-based Emote I
    }
    PerformEmote(client, target, GetAmount(amount));
    return Plugin_Handled;
}

>>>>>>> Stashed changes
Action Command_Menu(int client, int args)
{
    if (!IsValidClient(client))
        return Plugin_Handled;
    Menu_Dance(client);
    return Plugin_Handled;
}

Action Command_Force_Emote(int client, int args)
{
    for (int i = 0; i <= MaxClients; i++)
    {
        if (!IsValidClient(i))
            continue;
        RandomDance(i);
    }
    return Plugin_Handled;
}

Action Command_Do_Emotes(int client, int args)
{
    if (args < 1)
    {
        CReplyToCommand(client, "[SM] Usage: sm_dodance [Emote ID]. Emote ID -1 force stops emote.");
        CReplyToCommand(client, "[SM] Usage: sm_doemote [Emote ID]. Emote ID -1 force stops emote.");
        return Plugin_Handled;
    }

    int amount = 1;
    char arg1[4];
    GetCmdArg(1, arg1, sizeof(arg1));
    if (strcmp(arg1,"-1",false)==0)
    {
        amount = 0;
    }
    else
    {
        int totalEmotes = EMOTES_COUNT + DANCES_COUNT;
        if (StringToIntEx(arg1, amount) < 1 || amount < 1 || amount > totalEmotes)
        {
            CReplyToCommand(client, "%t", "INVALID_EMOTE_ID", 1, totalEmotes);
            return Plugin_Handled;
        }
    }

    PerformEmote(client, client, amount - 1);  // convert 1-based user ID to 0-based index
    return Plugin_Handled;
}

Action Command_Random_Emote(int client, int args)
{
    int total = EMOTES_COUNT + DANCES_COUNT;
    PerformEmote(client, client, GetRandomInt(0, total - 1));
    return Plugin_Handled;
}

Action Command_Admin_Emotes(int client, int args)
{
    if (args < 1)
    {
        CReplyToCommand(client, "[SM] Usage: sm_setemotes <#userid|name> [Emote ID]. Emote ID -1 force stops emote.");
        return Plugin_Handled;
    }

    char arg[65];
    GetCmdArg(1, arg, sizeof(arg));

    int amount = 0;  // default: first emote (0-based index)
    if (args > 1)
    {
        char arg2[4];
        GetCmdArg(2, arg2, sizeof(arg2));
        if (strcmp(arg2,"-1",false)==0)
        {
            amount = -1;
            // note -1 here but 0 in Command_Do_Emotes, there might be an inconsistency.
        }
        else
        {
            int totalEmotes = EMOTES_COUNT + DANCES_COUNT;
            if (StringToIntEx(arg2, amount) < 1 || amount < 1 || amount > totalEmotes)
            {
                CReplyToCommand(client, "%t", "INVALID_EMOTE_ID", 1, totalEmotes);
                return Plugin_Handled;
            }
            amount--;  // convert 1-based user ID to 0-based index
        }
    }

    char target_name[MAX_TARGET_LENGTH];
    int target_list[MAXPLAYERS], target_count;
    bool tn_is_ml;

    if ((target_count = ProcessTargetString(
        arg, client, target_list, MAXPLAYERS,
        COMMAND_FILTER_ALIVE, target_name, sizeof(target_name), tn_is_ml)) <= 0)
    {
        ReplyToTargetError(client, target_count);
        return Plugin_Handled;
    }

    for (int i = 0; i < target_count; i++)
        PerformEmote(client, target_list[i], amount);

    return Plugin_Handled;
}

// ============================================================
// Core: PerformEmote — single dispatch point
// ============================================================

void PerformEmote(int client, int target, int amount)
{
<<<<<<< Updated upstream
    
    if (amount==-1) // stop emote
=======
    if (amount<0) // stop emote
>>>>>>> Stashed changes
    {
        StopEmote(target);
        return;
    }

    if (amount < 0 || amount >= EMOTES_COUNT + DANCES_COUNT)
    {
        CPrintToChat(client, "%t", "INVALID_EMOTE_ID", 1, EMOTES_COUNT + DANCES_COUNT);
        return;
    }

<<<<<<< Updated upstream
    char intro[64], loop[64], sound[64];

    if (amount < EMOTES_COUNT)
    {
        strcopy(intro,  sizeof(intro),  g_Emotes[amount].intro);
        strcopy(loop,   sizeof(loop),   g_Emotes[amount].loop);
        strcopy(sound,  sizeof(sound),  g_Emotes[amount].sound);
    }
    else
    {
        int idx = amount - EMOTES_COUNT;
        strcopy(intro,  sizeof(intro),  g_Dances[idx].intro);
        strcopy(loop,   sizeof(loop),   g_Dances[idx].loop);
        strcopy(sound,  sizeof(sound),  g_Dances[idx].sound);
    }

    CreateEmote(target, intro, loop, sound);
=======
    CreateEmote(target,amount,client);
>>>>>>> Stashed changes
}

// ============================================================
// Helpers
// ============================================================

<<<<<<< Updated upstream
void RandomEmote(int client)
=======
// Did client start/stop emote/dance within the last 0.1 seconds?
stock bool EmotedRecently(int client)
{
    if (client<=0 || client>MaxClients) return false;
    return 0.0<=(GetGameTime()-g_fLastDance[client])<=0.1;
}

// Tell CreateEmote no free dancers are available this frame.
stock void SetFrameNoDancers(bool state)
{
    g_bFrameNoDancers = state;
    if (state) RequestFrame(SetFrameNoDancers,false);
}

stock void StopDancer(int i)
{
    if (i<0 || i>=MAXDANCERS) return;
    StopEmote(g_Dancers[i].ent);
}

stock int GetMaxDancers()
{
    int max = g_cvMaxDancers.IntValue;
    if (max<0) return 0;
    if (max>MAXDANCERS) return MAXDANCERS;
    return max;
}

// Find free dance index. Respects dancers that are still cleaning up.
stock int GetFreeDancer()
{
    int max = GetMaxDancers();
    if (max<=0) return -1;
    int ent,emote,skin;
    for (int i=0;i<max;i++)
    {
        ent = g_Dancers[i].ent;
        if (ent<=0) return i;
        emote = EntRefToEntIndex(g_Dancers[i].emoteRef);
        skin = EntRefToEntIndex(g_Dancers[i].skinRef);
        if (emote<=0 && skin<=0)
        {
            if (g_iDancers[ent]==i) StopEmote(ent);
            g_Dancers[i].ent = -1; // Mark as fully free slot
            return i;
        }
    }
    SetFrameNoDancers(true);
    return -1;
}

stock void GetMapBounds()
{
    if (!IsValidEntity(0))
    {
        RequestFrame(GetMapBounds);
        return;
    }
    GetEntPropVector(0,Prop_Data,"m_WorldMaxs",vOOB);
    AddVectors(vOOB,{100.0,100.0,100.0},vOOB);
}

// Get random amount index (0-based)
stock int GetAmount(int amount)
{
    switch (amount)
    {
        case PERFORM_RANDOM_ALL:   return GetRandomInt(0,TOTAL_COUNT-1);
        case PERFORM_RANDOM_EMOTE: return GetRandomInt(0,EMOTES_COUNT-1);
        case PERFORM_RANDOM_DANCE: return EMOTES_COUNT + GetRandomInt(0,DANCES_COUNT-1);
        case PERFORM_STOP:         return PERFORM_STOP;
        default:
        {
            if (amount<0 || amount>=TOTAL_COUNT)
                return PERFORM_STOP;
        }
    }
    return amount;
}

void RandomEmote(int ent)
>>>>>>> Stashed changes
{
    char sBuffer[32];
    g_cvFlagEmotesMenu.GetString(sBuffer, sizeof(sBuffer));
    if (!CheckAdminFlags(client, ReadFlagString(sBuffer)))
    {
        CPrintToChat(client, "%t", "NO_EMOTES_ACCESS_FLAG");
        return;
    }
    PerformEmote(client, client, GetRandomInt(0, EMOTES_COUNT - 1));
}

void RandomDance(int client)
{
    char sBuffer[32];
    g_cvFlagDancesMenu.GetString(sBuffer, sizeof(sBuffer));
    if (!CheckAdminFlags(client, ReadFlagString(sBuffer)))
    {
        CPrintToChat(client, "%t", "NO_DANCES_ACCESS_FLAG");
        return;
    }
    PerformEmote(client, client, EMOTES_COUNT + GetRandomInt(0, DANCES_COUNT - 1));
}

void PopulateEmotesMenu(Menu menu, int client)
{
    char info[8];
    for (int i = 0; i < EMOTES_COUNT; i++)
    {
        IntToString(i, info, sizeof(info));
        char name[64], label[128];
        strcopy(name, sizeof(name), g_Emotes[i].name);
        if (TranslationPhraseExists(name))
            Format(label, sizeof(label), "[%d] %T", i + 1, name, client);
        else
            Format(label, sizeof(label), "[%d] %s", i + 1, name);
        menu.AddItem(info, label);
    }
}

void PopulateDancesMenu(Menu menu, int client, int infoOffset = 0, int idOffset = 1)
{
    char info[8];
    for (int i = 0; i < DANCES_COUNT; i++)
    {
        IntToString(infoOffset + i, info, sizeof(info));
        char name[64], label[128];
        strcopy(name, sizeof(name), g_Dances[i].name);
        if (TranslationPhraseExists(name))
            Format(label, sizeof(label), "[%d] %T", idOffset + i, name, client);
        else
            Format(label, sizeof(label), "[%d] %s", idOffset + i, name);
        menu.AddItem(info, label);
    }
}

// Called from MenuAction_Select for both Emotes and Dances menus.
// baseOffset: 0 for emotes, EMOTES_COUNT for dances (so PerformEmote gets the right index).
void HandleEmoteMenuSelect(Menu menu, int client, int param2, int baseOffset)
{
    char info[8];
    if (menu.GetItem(param2, info, sizeof(info)))
    {
        int idx = StringToInt(info);
        PerformEmote(client, client, baseOffset + idx);
    }
    menu.DisplayAt(client, GetMenuSelectionPosition(), MENU_TIME_FOREVER);
}

// ============================================================
// Main menu
// ============================================================

Action Menu_Dance(int client)
{
    Menu menu = new Menu(MenuHandler1);

    char title[65];
    Format(title, sizeof(title), "%T:", "TITLE_MAIM_MENU", client);
    menu.SetTitle(title);

    AddTranslatedMenuItem(menu, "", "RANDOM_EMOTE",  client);
    AddTranslatedMenuItem(menu, "", "RANDOM_DANCE",  client);
    AddTranslatedMenuItem(menu, "", "EMOTES_LIST",   client);
    AddTranslatedMenuItem(menu, "", "DANCES_LIST",   client);

    menu.ExitButton     = true;
    menu.ExitBackButton = false;
    menu.Display(client, MENU_TIME_FOREVER);

    return Plugin_Handled;
}

int MenuHandler1(Menu menu, MenuAction action, int param1, int param2)
{
    switch (action)
    {
        case MenuAction_Select:
        {
            int client = param1;
            switch (param2)
            {
                case 0: { RandomEmote(client); Menu_Dance(client); }
                case 1: { RandomDance(client); Menu_Dance(client); }
                case 2: EmotesMenu(client);
                case 3: DancesMenu(client);
            }
        }
        case MenuAction_End: delete menu;
    }

    return 0;
}

// ============================================================
// Emotes menu
// ============================================================

Action EmotesMenu(int client)
{
    char sBuffer[32];
    g_cvFlagEmotesMenu.GetString(sBuffer, sizeof(sBuffer));
    if (!CheckAdminFlags(client, ReadFlagString(sBuffer)))
    {
        CPrintToChat(client, "%t", "NO_EMOTES_ACCESS_FLAG");
        return Plugin_Handled;
    }

    Menu menu = new Menu(MenuHandlerEmotes);

    char title[65];
    Format(title, sizeof(title), "%T:", "TITLE_EMOTES_MENU", client);
    menu.SetTitle(title);

    PopulateEmotesMenu(menu, client);

    menu.ExitButton     = true;
    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);

    return Plugin_Handled;
}

int MenuHandlerEmotes(Menu menu, MenuAction action, int client, int param2)
{
    switch (action)
    {
        case MenuAction_Select:
            HandleEmoteMenuSelect(menu, client, param2, 0);
        case MenuAction_Cancel:
        {
            if (param2 == MenuCancel_ExitBack) Menu_Dance(client);
        }
    }

    return 0;
}

// ============================================================
// Dances menu
// ============================================================

Action DancesMenu(int client)
{
    char sBuffer[32];
    g_cvFlagDancesMenu.GetString(sBuffer, sizeof(sBuffer));
    if (!CheckAdminFlags(client, ReadFlagString(sBuffer)))
    {
        CPrintToChat(client, "%t", "NO_DANCES_ACCESS_FLAG");
        return Plugin_Handled;
    }

    Menu menu = new Menu(MenuHandlerDances);

    char title[65];
    Format(title, sizeof(title), "%T:", "TITLE_DANCES_MENU", client);
    menu.SetTitle(title);

    PopulateDancesMenu(menu, client, 0, EMOTES_COUNT + 1);

    menu.ExitButton     = true;
    menu.ExitBackButton = true;
    menu.Display(client, MENU_TIME_FOREVER);

    return Plugin_Handled;
}

int MenuHandlerDances(Menu menu, MenuAction action, int client, int param2)
{
    switch (action)
    {
        case MenuAction_Select:
            HandleEmoteMenuSelect(menu, client, param2, EMOTES_COUNT);
        case MenuAction_Cancel:
        {
            if (param2 == MenuCancel_ExitBack) Menu_Dance(client);
        }
    }

    return 0;
}

<<<<<<< Updated upstream
Action CreateEmote(int client, const char[] anim1, const char[] anim2, const char[] soundName)
=======
// Make ent dance using 0-based EmoteID amount. client is who ordered CreateEmote
Action CreateEmote(int ent, int amount, int client = 0)
>>>>>>> Stashed changes
{
    if (!g_bMapStarted || !IsValidClient(client))
        return Plugin_Handled;
    
    if (CooldownTimers[client])
    {
        CReplyToCommand(client, "%t", "COOLDOWN_EMOTES");
        return Plugin_Handled;
    }

    if (StrEqual(anim1, ""))
    {
        CReplyToCommand(client, "%t", "AMIN_1_INVALID");
        return Plugin_Handled;
    }
    
    if (!IsPlayerAlive(client))
    {
<<<<<<< Updated upstream
        CReplyToCommand(client, "%t", "MUST_BE_ALIVE");
=======
        if (g_bFrameNoDancers)
        {
            //LogMessage("g_bFrameNoDancers");
            if (IsClient && ent==client) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
            return Plugin_Handled;
        }
        if (g_cvCooldown.FloatValue>0.0 && CooldownTimers[ent])
        {
            //LogMessage("CooldownTimers");
            if (IsClient && ent==client) CReplyToCommand(ent, "%t", "COOLDOWN_EMOTES");
            return Plugin_Handled;
        }
    }

    static EmoteData data;
    PopulateEmoteData(amount,data);

    if (StrEqual(data.intro, ""))
    {
        //LogMessage("Bad intro");
        if (IsClient && ent==client) CReplyToCommand(ent, "%t", "AMIN_1_INVALID");
>>>>>>> Stashed changes
        return Plugin_Handled;
    }

    if (!ClientValidGround(client))
    {
<<<<<<< Updated upstream
        CReplyToCommand(client, "%t", "STAY_ON_GROUND");
        return Plugin_Handled;
    }

    L4DTeam team = L4D_GetClientTeam(client);
=======
        case EMOTECLASS_PLAYER:
        {
            
            if (!IsPlayerAlive(ent))
            {
                if (IsClient && ent==client) CReplyToCommand(ent, "%t", "MUST_BE_ALIVE");
                return Plugin_Handled;
            }

            if (!EmoteValidGround(ent))
            {
                if (IsClient && ent==client) CReplyToCommand(ent, "%t", "STAY_ON_GROUND");
                return Plugin_Handled;
            }

            if (!IsEntityDancing(ent) && GetEntProp(ent, Prop_Send, "moveparent")>0)
            {
                if (IsClient && ent==client) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
                return Plugin_Handled;
            }
>>>>>>> Stashed changes

    if (!PlayerCanDance(client,team))
    {
        CReplyToCommand(client, "%t", "CANNOT_USE_NOW");
        return Plugin_Handled;
    }

<<<<<<< Updated upstream
    // 4 = Spitter, 5 = Jockey, 6 = Charger
    if (g_bL4D2 && g_cvBlockNonHumanoid.BoolValue && team == L4DTeam_Infected
        && 4 <= GetEntProp(client, Prop_Send, "m_zombieClass") <= 6)
    {
        CReplyToCommand(client, "%t", "CLASS_CANNOT_EMOTE");
        return Plugin_Handled;
    }

    if (IsThrowingRock(client))
    {
        CReplyToCommand(client, "%t", "CANNOT_USE_NOW");
        return Plugin_Handled;
=======
            if (IsThrowingRock(ent))
            {
                if (IsClient && ent==client) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
                return Plugin_Handled;
            }

            if (!CanPlayerDance(ent,team))
            {
                if (IsClient && ent==client) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
                return Plugin_Handled;
            }

        }
        case EMOTECLASS_INFECTED:
        {
            if (!CanInfectedDance(ent))
            {
                //LogMessage("CanInfectedDance");
                return Plugin_Handled;
            }
        }
        case EMOTECLASS_WITCH:
        {
            if (!CanWitchDance(ent))
            {
                //LogMessage("CanWitchDance");
                return Plugin_Handled;
            }
        }
>>>>>>> Stashed changes
    }

    if (g_EmoteForward_Pre != null)
    {
        Action res = Plugin_Continue;
        Call_StartForward(g_EmoteForward_Pre);
        Call_PushCell(client);
        Call_Finish(res);
        if (res != Plugin_Continue)
            return Plugin_Handled;
    }

    StopEmote(client);

    if (GetEntityMoveType(client) == MOVETYPE_NONE || !DropCarryable(client))
    {
<<<<<<< Updated upstream
        CReplyToCommand(client, "%t", "CANNOT_USE_NOW");
        return Plugin_Handled;
    }

    int EmoteEnt = CreateEntityByName("prop_dynamic_override");
    if (EmoteEnt<=0 || !IsValidEntity(EmoteEnt)) return Plugin_Handled;
=======
        dancer = g_iDancers[ent];
        EmoteEnt = EntRefToEntIndex(g_Dancers[dancer].emoteRef);
        if (EmoteEnt>0 && IsValidEntity(EmoteEnt))
        {
            skin = EntRefToEntIndex(g_Dancers[dancer].skinRef);
            if (skin<=0 || !IsValidEntity(skin))
                skin = -1;
        }
        else
            EmoteEnt = -1;
    }
    else
    {
        dancer = GetFreeDancer();
        if (dancer<0)
        {
            if (IsClient && ent==client) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
            //LogMessage("GetFreeDancer failed");
            return Plugin_Handled;
        }
    }

    if (EmoteEnt<=0)
    {
        StopEmote(ent);
        if ( GetEntityMoveType(ent) == MOVETYPE_NONE || (IsClient && !DropCarryable(ent)) )
        {
            //LogMessage("Movetype/carryable failed");
            if (IsClient && ent==client) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
            return Plugin_Handled;
        }
    }
>>>>>>> Stashed changes

    bool ghost; // player is ghost on infected team
    bool self_visible; // player is able to see their own model in third person. Only survivors in L4D2.
    switch (team)
    {
        case L4DTeam_Infected:
        {
            ghost = GetEntProp(client, Prop_Send, "m_isGhost")>0;
        }
<<<<<<< Updated upstream
        case L4DTeam_Survivor:
=======
    }

    static char model[PLATFORM_MAX_PATH];
    float pose_rig,pose_x,pose_y;
    if (EmoteEnt<=0 || skin<=0)
    {
        if (IsClient)
            GetClientModel(ent, model, PLATFORM_MAX_PATH);
        else
            GetEntPropString(ent, Prop_Data, "m_ModelName", model, PLATFORM_MAX_PATH);
        FillPoseParams(model,pose_rig,pose_x,pose_y); // infected_rig body_profile_x body_profile_y
    }

    if (EmoteEnt<=0)
    {
        EmoteEnt = CreateEntityByName("prop_dynamic_override");
        if (EmoteEnt<=0 || !IsValidEntity(EmoteEnt))
>>>>>>> Stashed changes
        {
            self_visible = g_bL4D2;
        }
<<<<<<< Updated upstream
=======
        if (EmoteEnt>=g_iMaxEntitySafe && g_cvSafety.BoolValue)
        {
            RemoveEntity(EmoteEnt);
            StopEmote(ent);
            if (IsClient && ent==client) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
            return Plugin_Handled;
        }
        DispatchKeyValue(EmoteEnt, "targetname",            "emote");
        DispatchKeyValue(EmoteEnt, "model",                 g_sModelPath);
        DispatchKeyValue(EmoteEnt, "solid",                 "0");
        DispatchKeyValue(EmoteEnt, "rendermode",            "10"); // Don't Render
        DispatchKeyValue(EmoteEnt, "disableshadows",        "1");
        DispatchKeyValue(EmoteEnt, "disablereceiveshadows", "1");
        DispatchKeyValueInt(EmoteEnt, "teamnumber",         team);
        ActivateEntity(EmoteEnt);
        DispatchSpawn(EmoteEnt);

        // gvazdas: this is to avoid PVS related issues when a prop_dynamic_ornament or any other entity is parented to the client
        // If not set this results in very inconsistent visibility/networking in the Parent/Child hierarchy downstream
        // For example, in L4D2, attach a glowing ornament to client, go outside of that client's PVS and cycle dances on them.
        // Ornament will randomly warp to map origin until you're back in the PVS.
        SET_TRANSMIT_ALWAYS(EmoteEnt);

        g_iDancers[ent] = dancer;
        g_Dancers[dancer].ent = ent;
        g_Dancers[dancer].emoteRef = EntIndexToEntRef(EmoteEnt);
        g_Dancers[dancer].modelIndex = GetEntProp(ent, Prop_Send, "m_nModelIndex");
        g_Dancers[dancer].movetype = GetEntityMoveType(ent);

        //LogMessage("Create_Emote %d %d", ent, EmoteEnt);

        float vec[3], ang[3];
        if (IsClient)
        {
            g_fLastDance[ent] = GetGameTime();
            SetEntityMoveType(ent, MOVETYPE_NONE);
            WeaponBlock(ent);
            GetClientAbsOrigin(ent, vec);
            GetClientAbsAngles(ent, ang);
            g_fLastPosition[ent] = vec;
            g_fLastAngles[ent]   = ang;
        }
        else
        {
            GetEntPropVector(ent, Prop_Send, "m_vecOrigin", vec);
            GetEntPropVector(ent, Prop_Send, "m_angRotation", ang);
        }
        
        ang[0] = 0.0; // prevent up-down rotation
        SetEntPropEnt(EmoteEnt, Prop_Send, "m_hOwnerEntity", ent);

        if (IsClient)
        {
            // Otherwise, starting the emote while moving keeps the camera bobbing.
            TeleportEntity(ent, NULL_VECTOR, NULL_VECTOR, {0.0,0.0,0.0});
            TeleportEntity(EmoteEnt, vec, ang, NULL_VECTOR);
            SetVariantString("!activator");
            AcceptEntityInput(ent, "SetParent", EmoteEnt);
            TeleportEntity(ent,{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0});
            SetCam(ent,team);
        }
        else
        {
            TeleportEntity(EmoteEnt,vOOB,{0.0,0.0,0.0},{0.0,0.0,0.0});
            if (EmoteClass==EMOTECLASS_INFECTED)
                SDKHook(ent,SDKHook_Think,ThinkInfected);
            else
                SDKHook(ent,SDKHook_Think,ThinkWitch);
            if (g_iModelIndexFake)
                SetEntProp(ent, Prop_Send, "m_nModelIndex", g_iModelIndexFake);
            else
                SetEntityModel(ent,FILE_MODEL_FAKE);
            SetVariantString("!activator");
            AcceptEntityInput(EmoteEnt, "SetParent", ent);
            TeleportEntity(EmoteEnt,{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0});
        }

        SetEntPropFloat(EmoteEnt, Prop_Send, "m_flPoseParameter", pose_rig, 0); // infected_rig
        SetEntPropFloat(EmoteEnt, Prop_Send, "m_flPoseParameter", pose_x,   1); // body_profile_x
        SetEntPropFloat(EmoteEnt, Prop_Send, "m_flPoseParameter", pose_y,   2); // body_profile_y

        if (IsClient && g_cvHidePlayers.BoolValue)
        {
            for (int i = 1; i <= MaxClients; i++)
            {
                if ( !g_bHooked[i] && IsClientInGame(i) && IsPlayerAlive(i)
                    && GetClientTeam(i) != GetClientTeam(ent) )
                {
                    SDKHook(i, SDKHook_SetTransmit, SetTransmit);
                    g_bHooked[i] = true;
                }
            }
        }

        SDKHook(ent, SDKHook_TraceAttack,  DancerTraceAttack);
        SDKHook(ent, SDKHook_OnTakeDamage, DancerTakeDamage);
        SDKHook(ent, SDKHook_StartTouch,   DancerTouch);
        SDKHook(ent, SDKHook_EndTouch,     DancerTouch);
        SDKHook(ent, SDKHook_Touch,        DancerTouch);
        
    }
    else
    {
        UnhookSingleEntityOutput(EmoteEnt, "OnAnimationDone", EndAnimation);
        UnhookSingleEntityOutput(EmoteEnt, "OnAnimationDone", StartLoopAnimation);
        StopEmoteSound(ent);
>>>>>>> Stashed changes
    }
    
    SetEntityMoveType(client, MOVETYPE_NONE);
    WeaponBlock(client);

    float vec[3], ang[3];
    GetClientAbsOrigin(client, vec);
    GetClientAbsAngles(client, ang);

    g_fLastPosition[client] = vec;
    g_fLastAngles[client]   = ang;

    DispatchKeyValue(EmoteEnt, "targetname",            "emote");
    DispatchKeyValue(EmoteEnt, "model",                 g_sModelPath);
    DispatchKeyValue(EmoteEnt, "solid",                 "0");
    DispatchKeyValue(EmoteEnt, "rendermode",            "10"); // Don't Render
    DispatchKeyValue(EmoteEnt, "disableshadows",        "1");
    DispatchKeyValue(EmoteEnt, "disablereceiveshadows", "1");
    DispatchKeyValueInt(EmoteEnt, "teamnumber",         team);

    ActivateEntity(EmoteEnt);
    DispatchSpawn(EmoteEnt);

    static char model[PLATFORM_MAX_PATH];
    GetClientModel(client, model, sizeof(model));

    if (g_bL4D2)
    {
        float flScale = GetSurvivorModelScale(model);
        if (flScale != 1.0) SetEntPropFloat(EmoteEnt,Prop_Send,"m_flModelScale",flScale);
    }

    // gvazdas: this is to avoid PVS related issues when a prop_dynamic_ornament or any other entity is parented to the client
    // If not set this results in very inconsistent visibility/networking in the Parent/Child hierarchy downstream
    // For example, in L4D2, attach a glowing ornament to client, go outside of that client's PVS and cycle dances on them.
    // Ornament will randomly warp to map origin until you're back in the PVS.
    SET_TRANSMIT_ALWAYS(EmoteEnt);

    TeleportEntity(EmoteEnt, vec, ang, NULL_VECTOR);

    // Otherwise, starting the emote while moving keeps the camera bobbing.
    TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, {0.0,0.0,0.0});

    SetVariantString("!activator");
    AcceptEntityInput(client, "SetParent", EmoteEnt);
    TeleportEntity(client,{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0});
    
    g_iEmoteEnt[client] = EntIndexToEntRef(EmoteEnt);
    SetEntPropEnt(EmoteEnt, Prop_Send, "m_hOwnerEntity", client);

    int effects;

<<<<<<< Updated upstream
    // Set client effects
    effects = GetEntProp(client,Prop_Send,"m_fEffects")|EF_BONEMERGE|EF_PARENT_ANIMATES|EF_BONEMERGE_FASTCULL;
    SetEntProp(client,Prop_Send,"m_fEffects",effects);
=======
    // Set entity effects
    if (IsClient)
    {
        effects = GetEntProp(ent,Prop_Send,"m_fEffects");
        effects |= EF_BONEMERGE|EF_PARENT_ANIMATES|EF_BONEMERGE_FASTCULL; // need fastcull here or camera will shake
        SetEntProp(ent,Prop_Send,"m_fEffects",effects);
    }
>>>>>>> Stashed changes

    // Set emote effects
    effects = GetEntProp(EmoteEnt,Prop_Send,"m_fEffects")|EF_BONEMERGE|EF_PARENT_ANIMATES|EF_NOSHADOW|EF_NORECEIVESHADOW|EF_BONEMERGE_FASTCULL;
    SetEntProp(EmoteEnt,Prop_Send,"m_fEffects",effects);

    // For real players we need to draw on their client side what's missing.
    if (!self_visible && !IsFakeClient(client))
    {
        RemoveSkin(client);
        int skin = CreateEntityByName("commentary_dummy");
        if (skin>0 && IsValidEntity(skin))
        {
<<<<<<< Updated upstream
=======
            if (skin>=g_iMaxEntitySafe && g_cvSafety.BoolValue)
            {
                RemoveEntity(skin);
                StopEmote(ent);
                if (IsClient && ent==client) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
                return Plugin_Handled;
            }
            DispatchKeyValue(skin, "targetname",            "emote_skin");
>>>>>>> Stashed changes
            DispatchKeyValue(skin, "model",                 model);
            DispatchKeyValue(skin, "solid",                 "0");
            DispatchKeyValue(skin, "disableshadows",        "1");
            DispatchKeyValue(skin, "disablereceiveshadows", "1");
            DispatchKeyValue(skin, "DisableBoneFollowers",  "1"); // Save edicts
            DispatchKeyValueInt(skin, "teamnumber",         team);
            DispatchSpawn(skin);
            SetVariantString("!activator");
            AcceptEntityInput(skin, "SetParent", EmoteEnt);
            TeleportEntity(skin,{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0});
            SetEntityMoveType(skin, MOVETYPE_NONE);
            g_iSkinEnt[client] = EntIndexToEntRef(skin);
            SetEntPropEnt(skin, Prop_Send, "m_hOwnerEntity", client);
            SetEntityRenderMode(skin, RENDER_TRANSALPHA);
            if (ghost) SetEntityRenderColor(skin, 255, 255, 255, 100);
            SDKHook(skin, SDKHook_SetTransmit, SetTransmitOwner);

            // Set skin effects
            effects = GetEntProp(skin,Prop_Send,"m_fEffects")|EF_BONEMERGE|EF_PARENT_ANIMATES|EF_NOSHADOW|EF_NORECEIVESHADOW|EF_BONEMERGE_FASTCULL;
            SetEntProp(skin,Prop_Send,"m_fEffects",effects);
        }
    }

    // Sound
    if (g_cvEmotesSounds.BoolValue && g_bSoundsCached && !StrEqual(soundName, ""))
    {
        char soundNameBuffer[64];

        if (StrContains(soundName, ",") != -1)
        {
            char sounds[8][64];
            int count = ExplodeString(soundName, ",", sounds, sizeof(sounds), sizeof(sounds[]));
            strcopy(soundNameBuffer, sizeof(soundNameBuffer), sounds[GetRandomInt(0, count - 1)]);
        }
        else
            strcopy(soundNameBuffer, sizeof(soundNameBuffer), soundName);

        FormatEx(g_sEmoteSound[client], PLATFORM_MAX_PATH,
            "%s%s.mp3", SOUND_BASE_PATH, soundNameBuffer);

        // If ghost, emit sound selectively.
        if (ghost)
        {
            for (int i = 1; i <= MaxClients; i++)
            {
                if (!IsClientInGame(i)) continue;
                if (L4D_GetClientTeam(i)==L4DTeam_Survivor) continue;
                EmitSoundToClient(i,g_sEmoteSound[client], client, SNDCHAN_AUTO, SNDLEVEL_RAIDSIREN);
            }
        }
        else
        {
            EmitSoundToAll(g_sEmoteSound[client], client, SNDCHAN_AUTO, SNDLEVEL_RAIDSIREN);
        }
    }
    else
    {
        g_sEmoteSound[client] = "";
    }

    if (StrEqual(anim2, "none", false))
        HookSingleEntityOutput(EmoteEnt, "OnAnimationDone", EndAnimation, true);
    else if (!StrEqual(anim2, ""))
    {
        // Start the loop ourselves, otherwise the dance switches to DanceMoves after the intro.
        strcopy(g_sEmoteLoop[client], sizeof(g_sEmoteLoop[]), anim2);
        HookSingleEntityOutput(EmoteEnt, "OnAnimationDone", StartLoopAnimation, true);
    }

    SetVariantString(anim1);
    AcceptEntityInput(EmoteEnt, "SetAnimation", -1, -1, 0);

    SetCam(client,team);

    if (g_cvSpeed.FloatValue != 1.0)
        SetEntPropFloat(EmoteEnt, Prop_Send, "m_flPlaybackRate", g_cvSpeed.FloatValue);

    g_bClientDancing[client] = true;
    g_iModelIndex[client] = GetEntProp(client, Prop_Send, "m_nModelIndex");

    if (g_cvHidePlayers.BoolValue)
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            if (IsClientInGame(i) && IsPlayerAlive(i)
                && GetClientTeam(i) != GetClientTeam(client)
                && !g_bHooked[i])
            {
                SDKHook(i, SDKHook_SetTransmit, SetTransmit);
                g_bHooked[i] = true;
            }
        }
    }

    if (g_cvCooldown.FloatValue > 0.0)
        CooldownTimers[client] = CreateTimer(g_cvCooldown.FloatValue, ResetCooldown, client);

    if (g_EmoteForward != null)
    {
        Call_StartForward(g_EmoteForward);
        Call_PushCell(client);
        Call_Finish();
    }

    return Plugin_Handled;
}

// Transmit skin only to its owner
Action SetTransmitOwner(int skin, int viewer)
{
    if (GetEntPropEnt(skin,Prop_Send,"m_hOwnerEntity")==viewer)
        return Plugin_Continue;
    return Plugin_Handled;
}

stock bool PlayerCanDance(const int client, L4DTeam team)
{
    if (bIsPlayerIncapped(client)) return false;
    int buttons = GetClientButtons(client);
    if (buttons && (buttons&~ALLOWEDBUTTONS)>0) return false;
    if (team==L4DTeam_Survivor)
    {
        if (GetEntPropEnt(client, Prop_Send, "m_pounceAttacker")>0) return false;
        if (GetEntPropEnt(client, Prop_Send, "m_tongueOwner")>0) return false;
        if (g_bL4D2)
        {
            if (GetEntPropEnt(client, Prop_Send, "m_pummelAttacker")>0) return false;
            if (GetEntPropEnt(client, Prop_Send, "m_carryAttacker")>0) return false;
            if (GetEntPropEnt(client, Prop_Send, "m_jockeyAttacker")>0) return false;
        }
    }
    if (g_bL4DD && L4D_IsPlayerStaggering(client)) return false;
    return true;
}

<<<<<<< Updated upstream
=======
stock bool CanInfectedDance(int ent)
{
    if (GetEntProp(ent,Prop_Data,"m_iHealth")<=0)
    {
        //LogMessage("CanInfectedDance health");
        return false;
    }
    if (GetEntProp(ent, Prop_Send, "moveparent")>0)
    {
        //LogMessage("CanInfectedDance moveparent");
        return false;
    }
    if (g_bL4D2) // Prevent crash, if bonemerge issue is solved this can be removed
    {
        int wound1 = GetEntProp(ent,Prop_Send,"m_iRequestedWound1");
        int wound2 = GetEntProp(ent,Prop_Send,"m_iRequestedWound2");
        //LogMessage("CanInfectedDance wound1 %d wound2 %d", wound1, wound2);
        if (wound1>=0 || wound2>=0)
            return false;
    }
    if (g_bSurvivorsLost) return true;
    if (g_bFinale) return false;
    if (g_bL4DD && L4D_IsSurvivalMode()) return false;
    //if (0<GetEntPropEnt(ent,Prop_Send,"m_clientLookatTarget")<=MaxClients)
    if (GetEntProp(ent,Prop_Send,"m_clientLookatTarget")>0)
    {
        //LogMessage("CanInfectedDance look");
        return false;
    }
    if (GetEntProp(ent,Prop_Send,"m_mobRush")>0)
    {
        //LogMessage("CanInfectedDance m_mobRush");
        return false;
    }
    return true;
}

stock bool CanWitchDance(int ent)
{
    if (GetEntProp(ent,Prop_Data,"m_iHealth")<=0)
    {
        //LogMessage("CanWitchDance health");
        return false;
    }
    if (GetEntProp(ent, Prop_Send, "moveparent")>0)
    {
        //LogMessage("CanWitchDance moveparent");
        return false;
    }
    if (g_bSurvivorsLost) return true;
    if (GetEntProp(ent,Prop_Send,"m_mobRush")>0)
    {
        //LogMessage("CanWitchDance m_mobRush");
        return false;
    }
    if (GetEntPropFloat(ent,Prop_Send,"m_rage")>0.0)
    {
        //LogMessage("CanWitchDance m_rage");
        return false;
    }
    if (g_bL4D2 && GetEntPropFloat(ent,Prop_Send,"m_wanderrage")>0.0)
    {
        //LogMessage("CanWitchDance m_wanderrage");
        return false;
    }
    return true;
}

>>>>>>> Stashed changes
// ============================================================
// RunCmd / animation end
// ============================================================

public Action OnPlayerRunCmd(int client, int &buttons, int &impulse)
{
    if (!g_bClientDancing[client]) return Plugin_Continue;
    if (!ClientValidGround(client))
    {
        StopEmote(client); // Client is not on ground
        return Plugin_Continue;
    }
    if (g_iModelIndex[client]!=GetEntProp(client, Prop_Send, "m_nModelIndex"))
    {
        StopEmote(client); // Player model changed
        return Plugin_Continue;
    }
    if (buttons && (buttons&~ALLOWEDBUTTONS)>0)
    {
        // Stop Emote and block non-allowed buttons this frame.
        StopEmote(client);
        buttons &= ALLOWEDBUTTONS;
        int weapon = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
        if (weapon>0 && IsValidEntity(weapon)) // Prevent bullets going nowhere but ammo being used. Achieved with Sourse
        {
            SetEntPropFloat(weapon, Prop_Send, "m_flNextPrimaryAttack", GetGameTime() + 0.1);
            SetEntPropFloat(weapon, Prop_Send, "m_flNextSecondaryAttack", GetGameTime() + 0.1);
        }
    }
    return Plugin_Continue;
}

void EndAnimation(const char[] output, int caller, int activator, float delay)
{
    if (caller<=0) return;
    activator = GetEmoteActivator(EntIndexToEntRef(caller));
    StopEmote(activator);
}

void StartLoopAnimation(const char[] output, int caller, int activator, float delay)
{
    int client = GetEmoteActivator(EntIndexToEntRef(caller));
    if (!IsValidClient(client))
        return;

    SetVariantString(g_sEmoteLoop[client]);
    AcceptEntityInput(caller, "SetAnimation", -1, -1, 0);

    if (g_cvSpeed.FloatValue != 1.0)
        SetEntPropFloat(caller, Prop_Send, "m_flPlaybackRate", g_cvSpeed.FloatValue);
}

// Return -1 on failure, client index otherwise. Client is not validated.
int GetEmoteActivator(int iEntRefDancer)
{
    if (iEntRefDancer == INVALID_ENT_REFERENCE)
        return -1;
    for (int i = 1; i <= MaxClients; i++)
        if (g_iEmoteEnt[i] == iEntRefDancer)
            return i;
    return -1;
}

// ============================================================
// Stop / Terminate emote
// ============================================================

// Full cleanup
void StopEmote(int client)
{
    if (client<=0 || client>MaxClients) return;

    g_bClientDancing[client] = false;
    
    if (g_iEmoteEnt[client]==INVALID_ENT_REFERENCE) return;

    bool valid_client = IsValidClient(client); // Emote entity can in principle exist without valid client.

    int iEmoteEnt = EntRefToEntIndex(g_iEmoteEnt[client]); // INVALID_ENT_REFERENCE is -1
    if (iEmoteEnt>0 && IsValidEntity(iEmoteEnt))
    {
<<<<<<< Updated upstream
        // https://forums.alliedmods.net/showthread.php?t=212872
        if (g_bL4D2) SetEntPropFloat(iEmoteEnt, Prop_Send, "m_flModelScale", 1.0);
        if (valid_client) AcceptEntityInput(client, "ClearParent");
=======
        if (valid_client) AcceptEntityInput(ent, "ClearParent");
>>>>>>> Stashed changes
        CleanRemoveEntity(iEmoteEnt);
        if (valid_client && g_cvTeleportBack.BoolValue)
            TeleportEntity(client, g_fLastPosition[client], g_fLastAngles[client], NULL_VECTOR);
    }
    
    g_iEmoteEnt[client] = INVALID_ENT_REFERENCE;

    // Always restore the player, even if the emote prop was already removed.
    if (valid_client)
    {
        RemoveSkin(client);
        ResetCam(client);
        WeaponUnblock(client);
        if (IsPlayerAlive(client) && !bIsPlayerIncapped(client))
            SetEntityMoveType(client, MOVETYPE_WALK);
        StopEmoteSound(client);
    }
<<<<<<< Updated upstream
=======
    else if (valid_ent && modelIndex)
    {
        int seq = GetEntProp(ent, Prop_Send, "m_nSequence");
        float cycle = GetEntPropFloat(ent, Prop_Send, "m_flCycle");
        if (EmoteClass == EMOTECLASS_INFECTED)
        {
            // infected entities have a lot of network optimization which can make them A-pose. This does not work 100% reliably.
            int body = GetEntProp(ent, Prop_Send, "m_nBody");
            int skin = GetEntProp(ent, Prop_Send, "m_nSkin");
            static char modelPath[PLATFORM_MAX_PATH];
            if (g_iModelPrecache==INVALID_STRING_TABLE)
                g_iModelPrecache = FindStringTable("modelprecache");
            if (g_iModelPrecache!=INVALID_STRING_TABLE && ReadStringTable(g_iModelPrecache,modelIndex,modelPath,PLATFORM_MAX_PATH)>0)
                SetEntityModel(ent, modelPath);
            SetEntProp(ent, Prop_Send, "m_nBody", body);
            SetEntProp(ent, Prop_Send, "m_nSkin", skin);
        }
        SetEntProp(ent, Prop_Send, "m_nModelIndex", modelIndex);
        SetEntProp(ent, Prop_Send, "m_nSequence", 0);
        SetEntProp(ent, Prop_Data, "m_bSequenceFinished", 0);
        SetEntProp(ent, Prop_Send, "m_nSequence", seq);
        SetEntPropFloat(ent, Prop_Send, "m_flCycle", cycle);
        SetEntPropFloat(ent, Prop_Send, "m_flPlaybackRate", 1.0);
        ChangeEdictState(ent);
        SDKHooks_TakeDamage(ent, 0, 0, 0.0, DMG_GENERIC);
    }

    if (0<ent<=MaxClients)
        g_fLastDance[ent] = GetGameTime();
>>>>>>> Stashed changes
}

void StopEmoteSound(int client)
{
    if (g_sEmoteSound[client][0])
    {
        StopSound(client, SNDCHAN_AUTO, g_sEmoteSound[client]);
        g_sEmoteSound[client][0] = '\0';
    }
}

// Less cleanup. Fires only in OnClientPutInServer() and OnClientDisconnect()
void TerminateEmote(int client)
{
    if (client<=0 || client>MaxClients) return;

    g_bClientDancing[client] = false;

    if (g_iEmoteEnt[client]==INVALID_ENT_REFERENCE) return;

    bool valid_client = IsValidClient(client); // Emote entity can in principle exist without valid client.

    int iEmoteEnt = EntRefToEntIndex(g_iEmoteEnt[client]);
    if (iEmoteEnt>0 && IsValidEntity(iEmoteEnt))
    {
<<<<<<< Updated upstream
        // https://forums.alliedmods.net/showthread.php?t=212872
        if (g_bL4D2) SetEntPropFloat(iEmoteEnt, Prop_Send, "m_flModelScale", 1.0);
        if (valid_client) AcceptEntityInput(client, "ClearParent");
=======
        if (valid_client) AcceptEntityInput(ent, "ClearParent");
>>>>>>> Stashed changes
        CleanRemoveEntity(iEmoteEnt);
    }
    
    g_iEmoteEnt[client] = INVALID_ENT_REFERENCE;

<<<<<<< Updated upstream
    if (valid_client)
    {
        RemoveSkin(client);
        StopEmoteSound(client);
=======
    if (0<ent<=MaxClients)
        g_fLastDance[ent] = GetGameTime();
}

stock void CreateEmoteSound(int ent, int EmoteClass, bool ghost, const char[] sound)
{
    g_Dancers[g_iDancers[ent]].sound = false;
    if (!g_cvSounds.BoolValue) return;
    if (g_cvSoundVolume.FloatValue<=0.0) return;
    if (g_cvSoundLevel.IntValue<=0.0) return;
    if (!g_bSoundsCached) return;
    if (sound[0]==0) return;
    switch (EmoteClass)
    {
        case EMOTECLASS_WITCH:
        {
            if (g_cvSounds.IntValue<2) return;
        }
        case EMOTECLASS_INFECTED:
        {
            if (g_cvSounds.IntValue<3) return;
        }
>>>>>>> Stashed changes
    }
}

// ============================================================
// Weapon block / unblock
// ============================================================

void WeaponBlock(int client)
{
    SDKHook(client, SDKHook_WeaponCanUse,  WeaponCanUseSwitch);
    SDKHook(client, SDKHook_WeaponSwitch,  WeaponCanUseSwitch);

    if (g_cvHideWeapons.BoolValue)
        SDKHook(client, SDKHook_PostThinkPost, OnPostThinkPost);

    g_iWeaponHandEnt[client] = INVALID_ENT_REFERENCE;

    int iEnt = GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon");
    if (iEnt>0 && IsValidEntity(iEnt))
    {
        g_iWeaponHandEnt[client] = EntIndexToEntRef(iEnt);
        SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", -1);
    }
}

// Carryables (propane, gascan, gnome...) can't be held while emoting.
bool DropCarryable(int client)
{
    int iCarry = GetPlayerWeaponSlot(client, 5);
    if (iCarry<=0 || GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon") != iCarry)
        return true;

    char sClass[64];
    for (int slot = 0; slot <= 4; slot++)
    {
        int iWeapon = GetPlayerWeaponSlot(client, slot);
        if (iWeapon<=0)
            continue;
        if (!GetEntityClassname(iWeapon, sClass, sizeof(sClass)))
            continue;
        FakeClientCommand(client, "use %s", sClass);
        break;
    }

    return GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon") != iCarry;
}

void WeaponUnblock(int client)
{
    SDKUnhook(client, SDKHook_WeaponCanUse,  WeaponCanUseSwitch);
    SDKUnhook(client, SDKHook_WeaponSwitch,  WeaponCanUseSwitch);
    SDKUnhook(client, SDKHook_PostThinkPost, OnPostThinkPost);

    if (GetEmotePeople()<=0)
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            if (g_bHooked[i] && IsClientInGame(i))
            {
                SDKUnhook(i, SDKHook_SetTransmit, SetTransmit);
                g_bHooked[i] = false;
            }
        }
    }

    if (g_iWeaponHandEnt[client] != INVALID_ENT_REFERENCE && IsPlayerAlive(client))
    {
        // Only restore a weapon the player still owns, otherwise the game picks the next one.
        int iEnt = EntRefToEntIndex(g_iWeaponHandEnt[client]);
        if (iEnt>0 && IsValidEntity(iEnt) && GetEntPropEnt(iEnt, Prop_Send, "m_hOwner") == client)
            SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", iEnt);
    }

    g_iWeaponHandEnt[client] = INVALID_ENT_REFERENCE;
}

Action WeaponCanUseSwitch(int client, int weapon)
{
    return Plugin_Stop;
}

void OnPostThinkPost(int client)
{
    SetEntProp(client, Prop_Send, "m_iAddonBits", 0);
}

Action SetTransmit(int entity, int client)
{
    if (g_bClientDancing[client] && IsPlayerAlive(client) && GetClientTeam(client) != GetClientTeam(entity))
        return Plugin_Handled;
    return Plugin_Continue;
}

// ============================================================
// Camera
// ============================================================

void SetCam(int client, L4DTeam team)
{
    if (g_bL4D2 && team!=L4DTeam_Infected)
        SetEntPropFloat(client, Prop_Send, "m_TimeForceExternalView", 99999.3);
    else if (!IsPinning(client,team))
    {
        // L4D1 has no third-person view, and L4D2 infected ignore it.
        SetEntPropEnt(client, Prop_Send, "m_hObserverTarget", client);
        SetEntProp(client, Prop_Send, "m_iObserverMode", 1);
    }
    SetEntProp(client, Prop_Send, "m_iHideHUD", GetEntProp(client, Prop_Send, "m_iHideHUD") | HIDEHUD_CROSSHAIR);
}

// The game already shows a Hunter/Smoker/Charger/Jockey in third person while pinning someone.
// Shamelessly stolen from lef4dhooks_silver.inc
bool IsPinning(int client, L4DTeam team)
{
    if (team!=L4DTeam_Infected) return false;
    if (!IsPlayerAlive(client)) return false;
    if (GetEntProp(client,Prop_Send,"m_isGhost")) return false;
    int class = GetEntProp(client, Prop_Send, "m_zombieClass");
	int victim;
	if(g_bL4D2)
	{
		switch(class)
		{
			case 1:		victim = GetEntPropEnt(client, Prop_Send, "m_tongueVictim");
			case 3:		victim = GetEntPropEnt(client, Prop_Send, "m_pounceVictim");
			case 5:		victim = GetEntPropEnt(client, Prop_Send, "m_jockeyVictim");
			case 6:
			{
				        victim = GetEntPropEnt(client, Prop_Send, "m_pummelVictim");
		   if(victim<1) victim = GetEntPropEnt(client, Prop_Send, "m_carryVictim");
			}
		}
	}
	else
	{
		switch(class)
		{
			case 1:		victim = GetEntPropEnt(client, Prop_Send, "m_tongueVictim");
			case 3:		victim = GetEntPropEnt(client, Prop_Send, "m_pounceVictim");
		}
	}
	if(victim>0) return true;
    return false;
}

// Emoting during a throw sends the rock in the wrong direction.
bool IsThrowingRock(int client)
{
    char cls[32];
    int ability = GetEntPropEnt(client, Prop_Send, "m_customAbility");
    if (ability <= MaxClients || !IsValidEntity(ability)
        || !GetEntityClassname(ability, cls, sizeof(cls)) || !StrEqual(cls, "ability_throw"))
        return false;

    // The rock only appears halfway through the throw, so also check when the throw started.
    static int timer = -2;
    if (timer == -2)
        timer = FindSendPropInfo("CThrow", "m_nextActivationTimer");
    if (timer > 0 && GetGameTime() - (GetEntDataFloat(ability, timer + 8) - GetEntDataFloat(ability, timer + 4)) < 1.5)
        return true;

    // Rock still in the Tank's hand.
    int rock = -1;
    float vel[3];
    while ((rock = FindEntityByClassname(rock, "tank_rock")) != -1)
    {
        GetEntPropVector(rock, Prop_Data, "m_vecAbsVelocity", vel);
        if (GetEntPropEnt(rock, Prop_Send, "m_hOwnerEntity") == client && GetVectorLength(vel) < 100.0)
            return true;
    }
    return false;
}

void ResetCam(int client)
{
    if (g_bL4D2)
        SetEntPropFloat(client, Prop_Send, "m_TimeForceExternalView", 0.0);
    if ( IsPlayerAlive(client) && GetEntProp(client, Prop_Send, "m_iObserverMode")==1 )
    {
        // Don't touch the camera of a player who died during the emote.
        SetEntPropEnt(client, Prop_Send, "m_hObserverTarget", -1);
        SetEntProp(client, Prop_Send, "m_iObserverMode", 0);
    }
    SetEntProp(client, Prop_Send, "m_iHideHUD", GetEntProp(client, Prop_Send, "m_iHideHUD") & ~HIDEHUD_CROSSHAIR);
}

void RemoveSkin(int client)
{
    int skin = EntRefToEntIndex(g_iSkinEnt[client]);
    if (skin>0 && IsValidEntity(skin))
        CleanRemoveEntity(skin);
    g_iSkinEnt[client] = INVALID_ENT_REFERENCE;
}

Action ResetCooldown(Handle timer, any client)
{
    CooldownTimers[client] = null;
    return Plugin_Continue;
}

// ============================================================
// Admin top menu
// ============================================================

public void OnAdminMenuReady(Handle aTopMenu)
{
    TopMenu topmenu = TopMenu.FromHandle(aTopMenu);
    if (topmenu == hTopMenu)
        return;
    hTopMenu = topmenu;

    TopMenuObject player_commands = hTopMenu.FindCategory(ADMINMENU_PLAYERCOMMANDS);
    if (player_commands != INVALID_TOPMENUOBJECT)
        hTopMenu.AddItem("sm_setemotes", AdminMenu_Emotes, player_commands, "sm_setemotes", ADMFLAG_SLAY);
}

void AdminMenu_Emotes(TopMenu topmenu, TopMenuAction action, TopMenuObject object_id, int param, char[] buffer, int maxlength)
{
    if (action == TopMenuAction_DisplayOption)
        Format(buffer, maxlength, "%T", "EMOTE_PLAYER", param);
    else if (action == TopMenuAction_SelectOption)
        DisplayEmotePlayersMenu(param);
}

void DisplayEmotePlayersMenu(int client)
{
    Menu menu = new Menu(MenuHandler_EmotePlayers);

    char title[65];
    Format(title, sizeof(title), "%T:", "EMOTE_PLAYER", client);
    menu.SetTitle(title);
    menu.ExitBackButton = true;

    AddTargetsToMenu(menu, client, true, true);
    menu.Display(client, MENU_TIME_FOREVER);
}

int MenuHandler_EmotePlayers(Menu menu, MenuAction action, int param1, int param2)
{
    if (action == MenuAction_End)
    {
        delete menu;
    }
    else if (action == MenuAction_Cancel)
    {
        if (param2 == MenuCancel_ExitBack && hTopMenu)
            hTopMenu.Display(param1, TopMenuPosition_LastCategory);
    }
    else if (action == MenuAction_Select)
    {
        char info[32];
        int userid, target;

        menu.GetItem(param2, info, sizeof(info));
        userid = StringToInt(info);

        if ((target = GetClientOfUserId(userid)) == 0)
            CPrintToChat(param1, "[SM] %t", "Player no longer available");
        else if (!CanUserTarget(param1, target))
            CPrintToChat(param1, "[SM] %t", "Unable to target");
        else
        {
            g_EmotesTarget[param1] = userid;
            DisplayEmotesAmountMenu(param1);
            return 0;
        }

        if (IsClientInGame(param1) && !IsClientInKickQueue(param1))
            DisplayEmotePlayersMenu(param1);
    }

    return 0;
}

void DisplayEmotesAmountMenu(int client)
{
    Menu menu = new Menu(MenuHandler_EmotesAmount);

    char title[65];
    Format(title, sizeof(title), "%T: %N", "SELECT_EMOTE", client, GetClientOfUserId(g_EmotesTarget[client]));
    menu.SetTitle(title);
    menu.ExitBackButton = true;

    // Emotes (IDs 1..N) then dances (IDs N+1..N+M)
    // Info value encodes the global PerformEmote index (0-based)
    PopulateEmotesMenu(menu, client);

    // Dances: info encodes global PerformEmote index (EMOTES_COUNT+i), IDs start at EMOTES_COUNT+1
    PopulateDancesMenu(menu, client, EMOTES_COUNT, EMOTES_COUNT + 1);

    menu.Display(client, MENU_TIME_FOREVER);
}

int MenuHandler_EmotesAmount(Menu menu, MenuAction action, int param1, int param2)
{
    if (action == MenuAction_End)
    {
        delete menu;
    }
    else if (action == MenuAction_Cancel)
    {
        if (param2 == MenuCancel_ExitBack && hTopMenu)
            hTopMenu.Display(param1, TopMenuPosition_LastCategory);
    }
    else if (action == MenuAction_Select)
    {
        char info[32];
        int amount, target;

        menu.GetItem(param2, info, sizeof(info));
        amount = StringToInt(info);

        if ((target = GetClientOfUserId(g_EmotesTarget[param1])) == 0)
            CPrintToChat(param1, "[SM] %t", "Player no longer available");
        else if (!CanUserTarget(param1, target))
            CPrintToChat(param1, "[SM] %t", "Unable to target");
        else
            PerformEmote(param1, target, amount);

        if (IsClientInGame(param1) && !IsClientInKickQueue(param1))
            DisplayEmotePlayersMenu(param1);
    }

    return 0;
}

// ============================================================
// Triggers
// ============================================================

public void OnEntityCreated(int entity, const char[] classname)
{
    if (StrEqual(classname, "trigger_multiple")
        || StrEqual(classname, "trigger_hurt")
        || StrEqual(classname, "trigger_push"))
    {
        SDKHook(entity, SDKHook_StartTouch, OnTrigger);
        SDKHook(entity, SDKHook_EndTouch,   OnTrigger);
        SDKHook(entity, SDKHook_Touch,      OnTrigger);
    }
}

Action OnTrigger(int entity, int other)
{
    StopEmote(other);
    return Plugin_Continue;
}

// ============================================================
// Utilities
// ============================================================


// Check if client is on valid ground for emoting.
stock bool ClientValidGround(int client)
{
<<<<<<< Updated upstream
    return GetEntityFlags(client)&FL_ONGROUND;
=======
    if (amount>=EMOTES_COUNT)
        data = g_Dances[amount-EMOTES_COUNT];
    else
        data = g_Emotes[amount];
}

stock bool IsEntityDancing(const int ent)
{
    if (ent<=0 || ent>MAXENTITIES) return false;
    return g_iDancers[ent]>=0 && g_Dancers[g_iDancers[ent]].ent==ent;
}

// Check if entity can dance
stock int GetEmoteClass(const int ent)
{
    if (ent>0 && ent<=MaxClients)
    {
        if (!IsValidClient(ent)) return EMOTECLASS_INVALID;
        return EMOTECLASS_PLAYER;
    }
    if (ent<=0 || ent>MAXENTITIES || !IsValidEntity(ent) || !IsValidEdict(ent))
        return EMOTECLASS_INVALID;
    #define MAX_CLASSNAME 16
    char class[MAX_CLASSNAME];
    if (!GetEntityClassname(ent,class,MAX_CLASSNAME))
        return EMOTECLASS_INVALID;
    switch (class[0])
    {
        case 'w':
        {
            if (strcmp(class,"witch",false)==0)
                return EMOTECLASS_WITCH;
        }
        case 'i':
        {
            if (strcmp(class,"infected",false)==0)
                return EMOTECLASS_INFECTED;
        }
    }
    return EMOTECLASS_INVALID;
}

// Check if entity is on valid ground for emoting.
stock bool EmoteValidGround(int ent)
{
    //return true;
    return GetEntityFlags(ent)&FL_ONGROUND;
    //return GetEntPropEnt(ent, Prop_Send, "m_hGroundEntity") == 0;
>>>>>>> Stashed changes
}

void AddTranslatedMenuItem(Menu menu, const char[] opt, const char[] phrase, int client)
{
    char buffer[128];
    Format(buffer, sizeof(buffer), "%T", phrase, client);
    menu.AddItem(opt, buffer);
}

bool CheckAdminFlags(int client, int iFlag)
{
    int iUserFlags = GetUserFlagBits(client);
    return (iUserFlags & ADMFLAG_ROOT || (iUserFlags & iFlag) == iFlag);
}

int GetEmotePeople()
{
    int count;
    for (int i = 1; i <= MaxClients; i++)
        if (IsClientInGame(i) && g_bClientDancing[i])
            count++;
    return count;
}

stock bool bIsPlayerIncapped(int client)
{
    return view_as<bool>(GetEntProp(client, Prop_Send, "m_isIncapacitated", 1)) || view_as<bool>(GetEntProp(client, Prop_Send, "m_isHangingFromLedge", 1));
}

stock bool IsValidClient(int client, bool replaycheck = true)
{
    if (client <= 0 || client > MaxClients || !IsClientInGame(client))
        return false;
        
    if (replaycheck && (IsClientSourceTV(client) || IsClientReplay(client)))
        return false;
        
    return true;
}

<<<<<<< Updated upstream
float GetSurvivorModelScale(const char[] model)
{
    if (StrContains(model, "producer", false) != -1)   // Rochelle
        return 0.888;
    if (StrContains(model, "teenangst", false) != -1)   // Zoey
        return 0.888;
    if (StrContains(model, "coach", false) != -1)       // Coach
        return 1.05;
    if (StrContains(model, "mechanic", false) != -1)    // Ellis
        return 0.955;
    return 1.0; // Nick, Bill, Francis, Louis
=======
// infected_rig body_profile_x body_profile_y
stock void FillPoseParams(const char[] model, float &pose_rig, float &pose_x, float &pose_y)
{
    if (StrContains(model, "infected", false) != -1)
    {
        if (StrContains(model, "common", false) != -1)
            {  pose_x = 2.0/3.0; pose_y=1.0/3.0;  return;    }
        if (StrContains(model, "hunter", false) != -1)
            {  pose_x = 2.0/3.0; pose_y=2.0/3.0;  return;    }
        if (StrContains(model, "boome", false) != -1)
            {  pose_x = 1.0/3.0; pose_y=2.0/3.0;  return;    }
        if (StrContains(model, "smoker", false) != -1)
            { pose_y = 2.0/3.0; return;    }
        if (StrContains(model, "witch", false) != -1)
            {  pose_x = 1.0; pose_y=1.0/3.0;  return;    }
        if (StrContains(model, "hulk", false) != -1)
            {  pose_x = 1.0; pose_y=2.0/3.0;  return;    }
        if (g_bL4D2)
        {
            if (StrContains(model, "charger", false) != -1)
                { pose_y = 1.0; return;    }
            if (StrContains(model, "spitter", false) != -1)
                { pose_x = 1.0/3.0; pose_y = 1.0; pose_rig = 0.5; return;    }
            if (StrContains(model, "jockey", false) != -1)
                { pose_x = 2.0/3.0; pose_y = 1.0; pose_rig = 1.0; return;    }
        }
        return;
    }
    if (StrContains(model, "manager", false) != -1)     // Louis
        {    return;    }
    if (StrContains(model, "biker", false) != -1)       // Francis
        {    return;    }
    if (StrContains(model, "teenangst", false) != -1)   // Zoey
        { pose_y=1.0/3.0;   return;    }
    if (StrContains(model, "namvet", false) != -1)      // Bill
        { pose_x=2.0/3.0;   return;    }
    if (g_bL4D2)
    {
        if (StrContains(model, "coach", false) != -1)    // Coach
            {    return;    }
        if (StrContains(model, "gambler", false) != -1)  // Nick
            { pose_x=1.0/3.0;   return;    }
        if (StrContains(model, "mechanic", false) != -1) // Ellis
            { pose_x=1.0;   return;    }
        if (StrContains(model, "producer", false) != -1) // Rochelle
            {  pose_x = 1.0/3.0; pose_y=pose_x;  return;    }
    }
>>>>>>> Stashed changes
}

// Entity,Input,Parameter,Delay,OnlyOnce
#define KILLCOMMAND "!self,Kill,,0.1,-1"

// Stop drawing entity, send packets to all clients, then kill 0.1 seconds later.
stock void CleanRemoveEntity(const int entity)
{
    SetEntProp(entity,Prop_Send,"m_fEffects",
        GetEntProp(entity,Prop_Send,"m_fEffects")|EF_NODRAW|EF_NOSHADOW|EF_NORECEIVESHADOW);
    SetEntityRenderMode(entity, view_as<RenderMode>(RENDER_NONE));
    SET_TRANSMIT_ALWAYS(entity);
    DispatchKeyValue(entity, "OnUser1", KILLCOMMAND);
    AcceptEntityInput(entity, "FireUser1");
}

// Transmit to all clients always. Skips SetTransmit completely.
stock void SET_TRANSMIT_ALWAYS(int entity)
{
    SetEdictFlags(entity, GetEdictFlags(entity)|FL_EDICT_ALWAYS);
}