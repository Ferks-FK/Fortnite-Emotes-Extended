#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <colors>
#include <fnemotes>
#undef REQUIRE_PLUGIN
#include <adminmenu>
#include <left4dhooks>

#pragma semicolon 1
#pragma newdecls required

#define PLUGIN_VERSION "3.0.0"

// TO DO
// Check movetype exploits. Let smoker grab bot and take control of bot and vice versa

public Plugin myinfo =
{
    name = "[L4D1/L4D2] Fortnite Emotes & Dances",
    author = "Kodua, Franc1sco franug, TheBO$$, Aleexxx, Foxhound, nearly civilized, Ferks-FK, gvazdas",
    description = "Emotes and dances for players, common infected and witches.",
    version = PLUGIN_VERSION,
    url = "https://github.com/Ferks-FK/Fortnite-Emotes-Extended"
};

// Entity heights in cm
#define EMOTE_MODEL_HEIGHT    182.0
#define SCALE_TANK      216.0/EMOTE_MODEL_HEIGHT
#define SCALE_SMOKER    216.0/EMOTE_MODEL_HEIGHT
#define SCALE_FRANCIS   193.0/EMOTE_MODEL_HEIGHT
#define SCALE_LOUIS     189.0/EMOTE_MODEL_HEIGHT
#define SCALE_COACH     187.0/EMOTE_MODEL_HEIGHT
#define SCALE_HUNTER    183.0/EMOTE_MODEL_HEIGHT
#define SCALE_BOOMER    183.0/EMOTE_MODEL_HEIGHT
#define SCALE_COMMON    180.0/EMOTE_MODEL_HEIGHT
#define SCALE_NICK      180.0/EMOTE_MODEL_HEIGHT
#define SCALE_BILL      179.0/EMOTE_MODEL_HEIGHT
#define SCALE_WITCH     173.0/EMOTE_MODEL_HEIGHT
#define SCALE_ELLIS     169.0/EMOTE_MODEL_HEIGHT
#define SCALE_ZOEY      168.0/EMOTE_MODEL_HEIGHT
#define SCALE_ROCHELLE  163.0/EMOTE_MODEL_HEIGHT

#define EF_NODRAW                      32
#define EF_BONEMERGE                (1 << 0)
#define EF_BONEMERGE_FASTCULL       (1 << 7)
#define EF_PARENT_ANIMATES          (1 << 9)
#define EF_NOSHADOW                 (1 << 4)
#define EF_NORECEIVESHADOW          (1 << 6)

#define HIDEHUD_CROSSHAIR           (1 << 8)

// Buttons that can be presed and emote/dance will continue (players only)
#define ALLOWEDBUTTONS (IN_BACK|IN_FORWARD|IN_LEFT|IN_RIGHT|IN_MOVELEFT|IN_MOVERIGHT|IN_RUN|IN_WALK|IN_SPEED|IN_SCORE|IN_ZOOM)

#define SOUND_BASE_PATH "kodua/fortnite_emotes/"
#define SOUND_BASE_FULL "sound/kodua/fortnite_emotes/"

#define FILE_MODEL_BASE      "models/player/kodua/fnemotes_nearlycivilized_v2"
#define FILE_MODEL_BASE_L4D1 "models/player/kodua/fnemotes_nearlycivilized_v2_l4d1"

// Fake model to make witches and common infected not render
#define FILE_MODEL_FAKE     "models/infected/anim_common.mdl"

#define MAXENTITIES 2048 // L4D2 Outbreak: 4096
#define MAXDANCERS  100

// Enum for classnames that can emote/dance
#define EMOTECLASS_INVALID  -1
#define EMOTECLASS_PLAYER    0
#define EMOTECLASS_INFECTED  1
#define EMOTECLASS_WITCH     2

#define ENTRY_SIZE 64
enum struct EmoteData
{
    char name[ENTRY_SIZE];
    char intro[ENTRY_SIZE];
    char loop[ENTRY_SIZE];
    char sound[ENTRY_SIZE];
}

static const EmoteData g_Emotes[] =
{
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
    { "Emote_RockPaperScissor_Scissor", "Emote_RockPaperScissor_Scissor",  "none",                    "",                               },
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
int TOTAL_COUNT  = sizeof(g_Emotes)+sizeof(g_Dances);

TopMenu hTopMenu;

ConVar  g_cvHidePlayers, // Players only
        g_cvFlagEmotesMenu, // Note: these flags filter menu only, all clients can always emote/dance no matter what this is set to
        g_cvFlagDancesMenu, // Note: these flags filter menu only, all clients can always emote/dance no matter what this is set to
        g_cvCooldown,
        g_cvSpeed,
        g_cvEmotesSounds,
        g_cvSoundVolume, // Sound volume
        g_cvSoundLevel,  // Sound fadeoff with distance
        g_cvHideWeapons, // Players only
        g_cvTeleportBack, // Not applied to infected and witches
        g_cvBlockNonHumanoid, // Players only
        g_cvProbabilityWitch,
        g_cvProbabilityInfected,
        g_cvMissionLost,
        g_cvMaxDancers,
        g_cvFastCull,
        g_cvTeleportFix; // Players only

Handle  CooldownTimers[MAXENTITIES+1],
        g_EmoteForward,
        g_EmoteForward_Pre;

int   g_iWeaponHandEnt[MAXPLAYERS+1] = {INVALID_ENT_REFERENCE,...};
int   g_EmotesTarget[MAXPLAYERS+1];
int   g_iModelPrecache; // modelprecache stringtable index. changes every map
int   g_iModelIndexFake; // model index for fake model for infected/witch dances

bool  g_bHooked[MAXPLAYERS+1],
      g_bSoundsCached,
      g_bL4D2,
      g_bL4DD,          // l4dhooks check. LibraryExists() is expensive
      g_bMapStarted,    // prevent emotes if map is not ready
      g_bSurvivorsLost, // infected and witch dance without interruption
      g_bFinale,        // disable infected dances
      g_bLate,          // late plugin start, for reading Finale state
      g_bRoundEnd,      // stop Survivors from emoting to not lose items
      g_bFrameNoDancers; // optimization, CreateEmote() early exit

float  g_fLastAngles[MAXPLAYERS+1][3],
       g_fLastPosition[MAXPLAYERS+1][3],
       g_fLastDance[MAXPLAYERS+1], // Restrict movetype restore only to clients who danced recently
       vOOB[3]; // Vector position outside of map bounds, for cleanup

char  g_sModelPath[PLATFORM_MAX_PATH];

enum struct Dancer
{
    int ent;            // Dancing entity. <=0 if slot is fully free and cleanup is complete (emote entity is deleted)
    int emoteRef;       // Invisible emote skeleton that does the dancing. Clients and skinRef bonemerge to it
    int skinRef;        // Commentary_dummy. Not always used
    int modelIndex;     // Entity model in modelprecache stringtable
    int amount;         // 0-based emote index
    bool sound;         // played sound
    MoveType movetype;  // restore movetype when emote is finished
}

Dancer g_Dancers[MAXDANCERS];
int g_iDancers[MAXENTITIES+1] = {-1,...}; // entity index -> g_Dancers map

// First thing that fires in the entire plugin lifecycle.
public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
    switch (GetEngineVersion())
    {
        case Engine_Left4Dead2: // FUTURE: Engine_Left4Dead2OB
        {
            g_bL4D2 = true;
        }
        case Engine_Left4Dead:
        {
            g_bL4D2 = false;
        }
        default:
        {
            strcopy(error,err_max,"Plugin only supports L4D1 and L4D2.");
		    return APLRes_Failure;
        }
    }
    RegPluginLibrary("fnemotes");
    CreateNative("fnemotes_IsClientEmoting", Native_IsClientEmoting);
    CreateNative("fnemotes_IsEntityEmoting", Native_IsEntityEmoting);
    CreateNative("fnemotes_StopEmote", Native_StopEmote);
    CreateNative("fnemotes_EmoteEntity", Native_EmoteEntity);
    g_bLate = late;
    return APLRes_Success;
}

public void OnPluginStart()
{
    LoadTranslations("common.phrases");
    LoadTranslations("fnemotes_near.phrases");

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

    HookEvent("drag_begin",                 Event_PlayerSubject,    EventHookMode_Pre);

    HookEvent("tongue_grab",                Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("choke_start",                Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("lunge_shove",                Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("lunge_pounce",               Event_PlayerVictim,     EventHookMode_Pre);
    if (g_bL4D2)
    {
    HookEvent("jockey_ride",                Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("charger_carry_start",        Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("charger_impact",             Event_PlayerVictim,     EventHookMode_Pre);
    HookEvent("charger_pummel_start",       Event_PlayerVictim,     EventHookMode_Pre);
    }

    HookEvent("player_death",               Event_PlayerDeath,      EventHookMode_Pre); // Fires for players and common infected

    HookEvent("player_spawn",               Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("ability_use",                Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_incapacitated",       Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_shoved",              Event_PlayerShoved,     EventHookMode_Pre);
    HookEvent("player_now_it",              Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_blind",               Event_PlayerUserid,     EventHookMode_Pre);
    HookEvent("player_ledge_grab",          Event_PlayerUserid,     EventHookMode_Pre);
    // if (g_bL4D2)
    // {
    // HookEvent("charger_charge_start",       Event_PlayerUserid,     EventHookMode_Pre);
    // }
    
    HookEvent("player_team",                Event_PlayerTeam,       EventHookMode_Pre);
    HookEvent("player_bot_replace",         Event_BotReplacePlayer, EventHookMode_Pre);
    HookEvent("bot_player_replace",         Event_BotReplacePlayer, EventHookMode_Pre);
    HookEvent("round_start",                Event_Start);
    HookEvent("round_end",                  Event_RoundEnd);
	HookEvent("mission_lost", 			    Event_Lost,		        EventHookMode_Pre); // survivors wiped out

    HookEvent("map_transition",             Event_Transition,       EventHookMode_Pre);

    HookEvent("finale_start", 			    Event_FinaleStart,      EventHookMode_PostNoCopy); // some finale maps won't trigger
    HookEvent("finale_radio_start", 	    Event_FinaleStart,      EventHookMode_PostNoCopy); // all finale maps trigger
    if (g_bL4D2)
        HookEvent("gauntlet_finale_start", 	Event_FinaleStart,      EventHookMode_PostNoCopy);

    g_cvEmotesSounds  = CreateConVar("sm_emotes_sounds",              "2",    "Sounds for 1:player,2:player+witch,3:all. Will activate on next map.", FCVAR_NOTIFY);
    g_cvSoundVolume  =  CreateConVar("sm_emotes_soundvol",            "1.0",  "Sound volume.", FCVAR_NOTIFY, true, 0.0, true, 1.0);
    g_cvSoundLevel  =   CreateConVar("sm_emotes_soundlvl",            "90",   "Sound level in dB [0,180].", FCVAR_NOTIFY, true, 0.0, true, 180.0);
    g_cvCooldown      = CreateConVar("sm_emotes_cooldown",            "1.0",  "Cooldown for emotes in seconds. -1 or 0 = no cooldown.", FCVAR_NOTIFY);
    g_cvFlagEmotesMenu= CreateConVar("sm_emotes_admin_flag_menu",     "",     "admin flag for emotes (empty for all players)");
    g_cvFlagDancesMenu= CreateConVar("sm_dances_admin_flag_menu",     "",     "admin flag for dances (empty for all players)");
    g_cvHideWeapons   = CreateConVar("sm_emotes_hide_weapons",        "1",    "(Players) Hide weapons when dancing", FCVAR_NOTIFY);
    g_cvHidePlayers   = CreateConVar("sm_emotes_hide_enemies",        "0",    "(Players) Hide enemy players when dancing", FCVAR_NOTIFY);
    g_cvTeleportBack  = CreateConVar("sm_emotes_teleportonend",       "1",    "(Players) Teleport back to position where dance started.", FCVAR_NOTIFY);
    g_cvSpeed         = CreateConVar("sm_emotes_speed",               "0.84", "Sets the playback speed of the animation.", FCVAR_PROTECTED);
    g_cvBlockNonHumanoid = CreateConVar("sm_emotes_block_nonhumanoid", "1",   "L4D2: block emotes for Spitter, Jockey and Charger (their skeletons can't play the dances).", FCVAR_NOTIFY);
    g_cvFastCull =      CreateConVar("sm_emotes_fastcull",             "1",   "Fastcull bonemerge. Shadows tend to cut off more but don't jump around sporadically.", FCVAR_NOTIFY);
    g_cvTeleportFix =   CreateConVar("sm_emotes_teleportfix",          "1",   "Stop emote when player teleport is detected.", FCVAR_NOTIFY);

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

    TopMenu topmenu;
    if (LibraryExists("adminmenu") && ((topmenu = GetAdminTopMenu()) != null))
        OnAdminMenuReady(topmenu);

    g_EmoteForward     = CreateGlobalForward("fnemotes_OnEmote",     ET_Ignore, Param_Cell);
    g_EmoteForward_Pre = CreateGlobalForward("fnemotes_OnEmote_Pre", ET_Event,  Param_Cell);

    AutoExecConfig(true, "fortnite_emotes_nearlycivilized");
}

public void OnEntityCreated(int entity, const char[] classname)
{
    switch (classname[0])
    {
        case 'i':
        {
            if (strcmp(classname,"infected",false)==0)
            {
                TerminateEmote(entity);
                if (g_cvProbabilityInfected.FloatValue>0.0)
                    SDKHook(entity,SDKHook_SpawnPost,SpawnPost);
            }
        }
        case 'w':
        {
            if (strcmp(classname,"witch",false)==0)
            {
                TerminateEmote(entity);
                if (g_cvProbabilityWitch.FloatValue>0.0)
                    SDKHook(entity,SDKHook_SpawnPost,SpawnPost);
            }
        }
    }
}

void SpawnPost(int entity)
{
    int EmoteClass = GetEmoteClass(entity);
    switch (EmoteClass)
    {
        case EMOTECLASS_INFECTED:
        {
            if (g_cvProbabilityInfected.FloatValue>=1.0 || g_cvProbabilityInfected.FloatValue>=GetRandomFloat())
            {
                CreateTimer(GetRandomFloat(0.25,0.5),Timer_RandomDance,EntIndexToEntRef(entity),TIMER_FLAG_NO_MAPCHANGE);
            }
        }
        case EMOTECLASS_WITCH:
        {
            if (g_cvProbabilityWitch.FloatValue>=1.0 || g_cvProbabilityWitch.FloatValue>=GetRandomFloat())
            {
                CreateTimer(GetRandomFloat(0.25,0.5),Timer_RandomDance,EntIndexToEntRef(entity),TIMER_FLAG_NO_MAPCHANGE);
            }
        }
    }
}

Action Timer_RandomDance(Handle timer, int entref)
{
    int ent = EntRefToEntIndex(entref);
    if (ent<=0 || !IsValidEntity(ent)) return Plugin_Stop;
    RandomDance(ent);
    return Plugin_Stop;
}

public void OnEntityDestroyed(int entity)
{
    TerminateEmote(entity);
}

public void OnPluginEnd()
{
    for (int i = 0; i < MAXDANCERS; i++)
    {
        StopDancer(i);
    }
    SetFrameNoDancers(false);
}

public void OnAllPluginsLoaded()
{
    g_bL4DD = LibraryExists("left4dhooks");
    // Check if Finale is active on late plugin start
    if (!g_bLate) return;
    g_bLate = false;
    if (g_bFinale || !g_bL4DD || !g_bMapStarted) return;
    if (!L4D_HasMapStarted()) return;
    g_bFinale = L4D_IsFinaleActive();
    if (g_bFinale)
    {
        // ignore "fake" VScript finales
        int entity = FindEntityByClassname(-1, "trigger_finale");
        g_bFinale = entity>0 && IsValidEntity(entity);
    }
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
    return IsEntityDancing(client);
}

int Native_IsEntityEmoting(Handle plugin, int numParams)
{
    int ent = GetNativeCell(1);
    if (ent<1 || ent>MAXENTITIES)
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid entity index %d", ent);
    return IsEntityDancing(ent);
}

int Native_StopEmote(Handle plugin, int numParams)
{
    int ent = GetNativeCell(1);
    if (ent<1 || ent>MAXENTITIES)
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid entity index %d", ent);
    bool wasEmoting = IsEntityDancing(ent);
    StopEmote(ent);
    return wasEmoting;
}

int Native_EmoteEntity(Handle plugin, int numParams)
{
    int ent = GetNativeCell(1);
    if (ent<1 || ent>MAXENTITIES)
        return ThrowNativeError(SP_ERROR_NATIVE, "Invalid entity index %d", ent);
    int amount = (numParams>1) ? GetNativeCell(2) : PERFORM_RANDOM_ALL;
    PerformEmote(ent,ent,GetAmount(amount));
    return IsEntityDancing(ent);
}

public void OnMapStart()
{    
    g_iModelIndexFake = PrecacheModel(FILE_MODEL_FAKE, true);

    char base[PLATFORM_MAX_PATH];
    char path[PLATFORM_MAX_PATH];
    strcopy(base, sizeof(base), g_bL4D2 ? FILE_MODEL_BASE : FILE_MODEL_BASE_L4D1);

    FormatEx(g_sModelPath, PLATFORM_MAX_PATH, "%s.mdl", base);
    PrecacheModel(g_sModelPath, true);

    AddFileToDownloadsTable(g_sModelPath);

    FormatEx(path, PLATFORM_MAX_PATH, "%s.vvd", base);
    AddFileToDownloadsTable(path);
    
    FormatEx(path, PLATFORM_MAX_PATH, "%s.dx90.vtx", base);
    AddFileToDownloadsTable(path);

    g_bMapStarted = true;
    g_iModelPrecache = INVALID_STRING_TABLE;
    SetFrameNoDancers(false);

    RequestFrame(GetMapBounds);
}

public void OnMapEnd()
{
    g_bMapStarted = false;
    g_iModelPrecache = INVALID_STRING_TABLE;
    g_bFinale = false;
    g_bRoundEnd = true;
    SetFrameNoDancers(false);
    OnPluginEnd();
}

public void OnConfigsExecuted()
{
    g_bSoundsCached = false;
    if (!g_cvEmotesSounds.BoolValue)
        return;

    char sound[ENTRY_SIZE];
    for (int i = 0; i < EMOTES_COUNT; i++)
    {
        strcopy(sound,ENTRY_SIZE,g_Emotes[i].sound);
        if (!StrEqual(sound, ""))
        {
            if (StrContains(sound, ",") != -1)
            {
                char sounds[8][ENTRY_SIZE];
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
        strcopy(sound,ENTRY_SIZE,g_Dances[i].sound);
        if (!StrEqual(sound, ""))
        {
            if (StrContains(sound, ",") != -1)
            {
                char sounds[8][ENTRY_SIZE];
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
    if (EmotedRecently(client))
        CreateTimer(0.1, Timer_CheckMoveType, client, TIMER_FLAG_NO_MAPCHANGE);
    if (IsValidClient(client))
    {
        ResetCam(client);
        g_iWeaponHandEnt[client] = INVALID_ENT_REFERENCE;
    }
}

public void OnClientDisconnect(int client)
{
    TerminateEmote(client);
    if (IsValidClient(client))
    {
        ResetCam(client);
    }
    if (client>0 && client<=MaxClients)
    {
        g_bHooked[client] = false;
    }
    if (EmotedRecently(client))
        CreateTimer(0.1, Timer_CheckMoveType, client, TIMER_FLAG_NO_MAPCHANGE);
}

// ============================================================
// Events
// ============================================================

public void L4D2_OnHitByVomitJar_Post(int victim, int attacker)
{
    //LogMessage("L4D2_OnHitByVomitJar_Post %d", victim);
    StopEmote(victim);
}

public void L4D2_Infected_HitByVomitJar_Post(int victim, int attacker)
{
    //LogMessage("L4D2_Infected_HitByVomitJar_Post %d", victim);
    StopEmote(victim);
}

public void L4D2_OnStagger_Post(int client, int source)
{
    //LogMessage("L4D2_OnStagger_Post %d", client);
    StopEmote(client);
}

public void L4D_OnMaterializeFromGhost(int client)
{
    //LogMessage("L4D_OnMaterializeFromGhost %d", client);
    StopEmote(client);
}

public void L4D2_OnPlayerFling_Post(int client, int attacker, const float vecDir[3])
{
    //LogMessage("L4D2_OnPlayerFling_Post %d", client);
    StopEmote(client);
}

public void L4D2_OnPounceOrLeapStumble_Post(int victim, int attacker)
{
    //LogMessage("L4D2_OnPounceOrLeapStumble_Post %d", victim);
    StopEmote(victim);
}

public void L4D_OnKnockedDown_Post(int client, int reason)
{
    //LogMessage("L4D_OnKnockedDown_Post %d", client);
    StopEmote(client);
}

public void L4D2_OnThrowImpactedSurvivor_Post(int attacker, int victim)
{
    //LogMessage("L4D2_OnThrowImpactedSurvivor_Post %d", attacker);
    StopEmote(victim);
}

public void L4D_OnFalling(int client)
{
    //LogMessage("L4D_OnFalling %d", client);
    StopEmote(client);
}

void Event_BotReplacePlayer(Event event, const char[] name, bool dontBroadcast)
{
    int player = GetClientOfUserId(event.GetInt("player"));
    int bot    = GetClientOfUserId(event.GetInt("bot"));
    //LogMessage("%s %d %d", name, player, bot);
    StopEmote(player);
    StopEmote(bot);
    if (EmotedRecently(player) || EmotedRecently(bot))
    {
        CreateTimer(0.1, Timer_CheckMoveType, player, TIMER_FLAG_NO_MAPCHANGE);
        CreateTimer(0.1, Timer_CheckMoveType, bot,    TIMER_FLAG_NO_MAPCHANGE);
    }
}

void Event_PlayerVictim(Event event, const char[] name, bool dontBroadcast)
{
    int victim = GetClientOfUserId(event.GetInt("victim"));
    //LogMessage("Event_PlayerVictim %d %s", victim, name);
    StopEmote(victim);
}

void Event_entityid(Event event, const char[] name, bool dontBroadcast)
{
    int ent = event.GetInt("entityid");
    //LogMessage("Event_entityid %d %s", ent, name);
    StopEmote(ent);
}

void Event_witchid(Event event, const char[] name, bool dontBroadcast)
{
    int ent = event.GetInt("witchid");
    //LogMessage("Event_witchid %d %s", ent, name);
    StopEmote(ent);
}

void Event_PlayerSubject(Event event, const char[] name, bool dontBroadcast)
{
    int victim = GetClientOfUserId(event.GetInt("subject"));
    //LogMessage("Event_PlayerSubject %d %s", victim, name);
    StopEmote(victim);
}

// player or infected died
void Event_PlayerDeath(Event event, const char[] name, bool dontBroadcast)
{
    int victim = event.GetInt("entityid");
    if (victim>0)
    {
        //LogMessage("Event_PlayerDeath %d %s", victim, name);
        StopEmote(victim);
        return;
    }
    victim = GetClientOfUserId(event.GetInt("userid"));
    //LogMessage("Event_PlayerDeath %d %s", victim, name);
    StopEmote(victim);
}

void Event_PlayerUserid(Event event, const char[] name, bool dontBroadcast)
{
    int victim = GetClientOfUserId(event.GetInt("userid"));
    //LogMessage("Event_PlayerUserid %d %s", victim, name);
    StopEmote(victim);
}

// Teammates can shove a dancing player without stopping the emote.
void Event_PlayerShoved(Event event, const char[] name, bool dontBroadcast)
{
    int victim = GetClientOfUserId(event.GetInt("userid"));
    int attacker = GetClientOfUserId(event.GetInt("attacker"));
    if (IsValidClient(victim) && IsValidClient(attacker) && GetClientTeam(victim) == GetClientTeam(attacker)) return;
    //LogMessage("Event_PlayerShoved %d %s", victim, name);
    StopEmote(victim);
}

void Event_PlayerTeam(Event event, const char[] name, bool dontBroadcast)
{
    int client = GetClientOfUserId(event.GetInt("userid"));
    //LogMessage("Event_PlayerTeam %d %s", client, name);
    StopEmote(client);
    if (EmotedRecently(client))
        CreateTimer(0.1, Timer_CheckMoveType, client, TIMER_FLAG_NO_MAPCHANGE);
}

void Event_Start(Event event, const char[] name, bool dontBroadcast)
{
    g_bSurvivorsLost = false;
    g_bFinale = false;
    g_bRoundEnd = false;
    OnPluginEnd();
}

void Event_RoundEnd(Event event, const char[] name, bool dontBroadcast)
{
    g_bRoundEnd = true;
    for (int i = 1; i <= MaxClients; i++)
    {
        if (!IsValidClient(i))
            continue;
        if (view_as<L4DTeam>(GetClientTeam(i)) == L4DTeam_Survivor)
        {
            // Otherwise dancing survivors will lose their items into next round
            StopEmote(i);
            continue;
        }
        if (IsFakeClient(i) && view_as<L4DTeam>(GetClientTeam(i)) == L4DTeam_Infected)
            CreateTimer(0.25, BotTaunt, i, TIMER_FLAG_NO_MAPCHANGE);
    }
}

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

void Event_FinaleStart(Event event, const char[] name, bool dontBroadcast)
{
    g_bFinale = true;
}

// Probably a good idea to avoid passing entities into the next level.
void Event_Transition(Event event, const char[] name, bool dontBroadcast)
{
    OnPluginEnd();
    g_bMapStarted = false;
    g_bRoundEnd = true;
}
public Action L4D1_OnSavingEntities(int info_changelevel, Address Kv)
{
    OnPluginEnd();
    g_bMapStarted = false;
    g_bRoundEnd = true;
    return Plugin_Continue;
}
public Action L4D2_OnSavingEntities(int info_changelevel)
{
    OnPluginEnd();
    g_bMapStarted = false;
    g_bRoundEnd = true;
    return Plugin_Continue;
}

Action BotTaunt(Handle timer, int client)
{
    if (!IsValidClient(client))
        return Plugin_Continue;
    RandomDance(client);
    return Plugin_Continue;
}

// ============================================================
// Commands
// ============================================================

// Stop dance/emote on self, or if admin or server, stop emote on targets
Action Command_Stop(int client, int args)
{
    if ( client==0 || (IsValidClient(client) && CheckCommandAccess(client,"is_a_sm_admin",ADMFLAG_GENERIC,true)) )
    {
        if (args>0)
        {
            char arg[65];
            GetCmdArg(1, arg, sizeof(arg));
            char targetName[MAX_TARGET_LENGTH];
            int targetList[MAXPLAYERS];
            int targetCount;
            bool tnIsMl;
            if ( (targetCount = ProcessTargetString(
                    arg,
                    client,
                    targetList,
                    MAXPLAYERS,
                    COMMAND_FILTER_ALIVE,
                    targetName,
                    sizeof(targetName),
                    tnIsMl)) > 0 )
            {
                for (int i = 0; i < targetCount; i++)
                {
                    StopEmote(targetList[i]);
                }
                return Plugin_Handled;
            }
            if (GetCmdArgIntEx(1,targetCount))
            {
                StopEmote(targetCount);
                return Plugin_Handled;
            }
        }
        if (client<=0) return Plugin_Handled;
    }
    StopEmote(client);
    return Plugin_Handled;
}

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
        PerformEmote(entity, entity, GetAmount(amount));
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
        PerformEmote(entity, entity, GetAmount(amount));
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
    PerformEmote(target, target, GetAmount(amount));
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
    PerformEmote(target, target, GetAmount(amount));
    return Plugin_Handled;
}

Action Command_Menu(int client, int args)
{
    if (!IsValidClient(client) || IsFakeClient(client))
        return Plugin_Handled;
    Menu_Dance(client);
    return Plugin_Handled;
}

// Force all players to dance. If args>0, include common infected and witches.
Action Command_Force_Emote(int client, int args)
{
    for (int i = 1; i <= MaxClients; i++)
    {
        if (!IsValidClient(i)) continue;
        if (!IsPlayerAlive(i)) continue;
        if (!CanPlayerDance(i,view_as<L4DTeam>(GetClientTeam(i)))) continue; 
        RandomDance(i);
    }
    if (args>0)
    {
        Command_Dance_Infected(client,0);
        Command_Dance_Witch(client,0);
    }
    return Plugin_Handled;
}

Action Command_Do_Emotes(int client, int args)
{
    int amount = PERFORM_RANDOM_ALL;
    if (args>0)
    {
        char arg[8];
        GetCmdArg(1,arg,8);
        if (strcmp(arg,"stop",false)==0)
            amount = PERFORM_STOP;
        else if (GetCmdArgIntEx(1,amount))
        {
            amount -= 1; // convert 1-based to 0-based Emote I
            if (amount<PERFORM_RANDOM_ALL || amount>=TOTAL_COUNT)
            {
                CReplyToCommand(client, "Invalid Emote ID. See sm_emoteids for IDs.");
                return Plugin_Handled;
            }
        }
    }
    PerformEmote(client, client, GetAmount(amount));
    return Plugin_Handled;
}

Action Command_Random_Emote(int client, int args)
{
    PerformEmote(client, client, GetAmount(PERFORM_RANDOM_ALL));
    return Plugin_Handled;
}

Action Command_Admin_Emotes(int client, int args)
{
    if (args < 1)
    {
        CReplyToCommand(client, "[SM] Usage: <#userid|name> [Emote ID]. See sm_emoteids for IDs.");
        return Plugin_Handled;
    }

    char arg[65];
    GetCmdArg(1, arg, sizeof(arg));

    int amount = PERFORM_RANDOM_ALL;
    if (args>1)
    {
        char arg2[8];
        GetCmdArg(2,arg2,8);
        if (strcmp(arg2,"stop",false)==0)
            amount = PERFORM_STOP;
        else
        {
            amount = GetCmdArgInt(2) - 1; // convert 1-based to 0-based
            if (amount<PERFORM_RANDOM_ALL || amount>=TOTAL_COUNT)
            {
                CReplyToCommand(client, "Usage: <#userid|name> [Emote ID]. See sm_emoteids for IDs.");
                return Plugin_Handled;
            }
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
        PerformEmote(client, target_list[i], GetAmount(amount));

    return Plugin_Handled;
}

// ============================================================
// Core: PerformEmote — single dispatch point
// ============================================================

void PerformEmote(int client, int target, int amount)
{
    if (amount==-1) // stop emote
    {
        StopEmote(target);
        return;
    }

    if ( amount<0 || amount>=TOTAL_COUNT )
    {
        if (IsValidClient(client)) CPrintToChat(client, "%t", "INVALID_EMOTE_ID", 1, EMOTES_COUNT + DANCES_COUNT);
        return;
    }

    CreateEmote(target,amount);
}

// ============================================================
// Helpers
// ============================================================

stock bool EmotedRecently(int client)
{
    if (client<=0 || client>MaxClients) return false;
    return 0.0<=(GetGameTime()-g_fLastDance[client])<=0.1;
}

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
{
    char sBuffer[32];
    g_cvFlagEmotesMenu.GetString(sBuffer, sizeof(sBuffer));
    if (IsValidClient(ent) && !CheckAdminFlags(ent, ReadFlagString(sBuffer)))
    {
        CPrintToChat(ent, "%t", "NO_EMOTES_ACCESS_FLAG");
        return;
    }
    PerformEmote(ent, ent, GetAmount(PERFORM_RANDOM_EMOTE));
}

void RandomDance(int ent)
{
    char sBuffer[32];
    g_cvFlagDancesMenu.GetString(sBuffer, sizeof(sBuffer));
    if (IsValidClient(ent) && !CheckAdminFlags(ent, ReadFlagString(sBuffer)))
    {
        CPrintToChat(ent, "%t", "NO_DANCES_ACCESS_FLAG");
        return;
    }
    PerformEmote(ent, ent, GetAmount(PERFORM_RANDOM_DANCE));
}

void PopulateEmotesMenu(Menu menu, int client)
{
    char info[8];
    for (int i = 0; i < EMOTES_COUNT; i++)
    {
        IntToString(i, info, sizeof(info));
        char name[ENTRY_SIZE], label[128];
        strcopy(name, ENTRY_SIZE, g_Emotes[i].name);
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
        char name[ENTRY_SIZE], label[128];
        strcopy(name, ENTRY_SIZE, g_Dances[i].name);
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
        case MenuAction_End:
        {
            if (param2 != MenuEnd_Selected)
                delete menu;
        }
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
        case MenuAction_End:
        {
            if (param2 != MenuEnd_Selected)
                delete menu;
        }
        case MenuAction_Select:
            HandleEmoteMenuSelect(menu, client, param2, EMOTES_COUNT);
        case MenuAction_Cancel:
        {
            if (param2 == MenuCancel_ExitBack) Menu_Dance(client);
        }
    }

    return 0;
}

Action CreateEmote(int ent, int amount)
{
    if (!g_bMapStarted)
    {
        //LogMessage("Map not started");
        return Plugin_Handled;
    }

    if (amount<0 || amount>=TOTAL_COUNT)
    {
        //LogMessage("Invalid amount");
        StopEmote(ent);
        return Plugin_Handled;
    }

    int EmoteClass = GetEmoteClass(ent);
    
    if (EmoteClass==EMOTECLASS_INVALID)
    {
        //LogMessage("EMOTECLASS_INVALID");
        StopEmote(ent);
        return Plugin_Handled;
    }
    
    bool IsClient = EmoteClass==EMOTECLASS_PLAYER;

    if (!IsEntityDancing(ent))
    {
        if (g_bFrameNoDancers)
        {
            //LogMessage("g_bFrameNoDancers");
            if (IsClient) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
            return Plugin_Handled;
        }
        if (g_cvCooldown.FloatValue>0.0 && CooldownTimers[ent])
        {
            //LogMessage("CooldownTimers");
            if (IsClient) CReplyToCommand(ent, "%t", "COOLDOWN_EMOTES");
            return Plugin_Handled;
        }
    }

    static EmoteData data;
    PopulateEmoteData(amount,data);

    if (StrEqual(data.intro, ""))
    {
        //LogMessage("Bad intro");
        if (IsClient) CReplyToCommand(ent, "%t", "AMIN_1_INVALID");
        return Plugin_Handled;
    }

    L4DTeam team = L4DTeam_Infected;

    switch (EmoteClass)
    {
        case EMOTECLASS_PLAYER:
        {
            
            if (!IsPlayerAlive(ent))
            {
                CReplyToCommand(ent, "%t", "MUST_BE_ALIVE");
                return Plugin_Handled;
            }

            if (!EmoteValidGround(ent))
            {
                if (IsClient) CReplyToCommand(ent, "%t", "STAY_ON_GROUND");
                return Plugin_Handled;
            }

            team = view_as<L4DTeam>(GetClientTeam(ent));

            // 4 = Spitter, 5 = Jockey, 6 = Charger
            if (g_bL4D2 && g_cvBlockNonHumanoid.BoolValue && team == L4DTeam_Infected
                && 4 <= GetEntProp(ent, Prop_Send, "m_zombieClass") <= 6)
            {
                CReplyToCommand(ent, "%t", "CLASS_CANNOT_EMOTE");
                return Plugin_Handled;
            }

            if (IsThrowingRock(ent))
            {
                CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
                return Plugin_Handled;
            }

            if (!CanPlayerDance(ent,team))
            {
                CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
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
    }

    if (g_EmoteForward_Pre != null)
    {
        Action res = Plugin_Continue;
        Call_StartForward(g_EmoteForward_Pre);
        Call_PushCell(ent);
        Call_Finish(res);
        if (res != Plugin_Continue)
        {
            //LogMessage("g_EmoteForward_Pre");
            return Plugin_Handled;
        }
    }

    int EmoteEnt = -1;
    int skin = -1;
    int dancer = -1;

    if (IsEntityDancing(ent))
    {
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
            if (IsClient) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
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
            if (IsClient) CReplyToCommand(ent, "%t", "CANNOT_USE_NOW");
            return Plugin_Handled;
        }
    }

    bool ghost; // player is ghost on infected team
    bool self_visible; // player is able to see their own model in third person. Only survivors in L4D2.
    if (IsClient)
    {
        switch (team)
        {
            case L4DTeam_Infected:
            {
                ghost = GetEntProp(ent, Prop_Send, "m_isGhost")>0;
            }
            case L4DTeam_Survivor:
            {
                self_visible = g_bL4D2;
            }
        }
    }

    static char model[PLATFORM_MAX_PATH];
    if (EmoteEnt<=0 || skin<=0)
    {
        if (IsClient)
            GetClientModel(ent, model, PLATFORM_MAX_PATH);
        else
            GetEntPropString(ent, Prop_Data, "m_ModelName", model, PLATFORM_MAX_PATH);
    }

    if (EmoteEnt<=0)
    {
        EmoteEnt = CreateEntityByName("prop_dynamic_override");
        if (EmoteEnt<=0 || !IsValidEntity(EmoteEnt))
        {
            //LogMessage("prop_dynamic_override failed");
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
        
        if (g_bL4D2)
        {
            float flScale = GetModelScale(model);
            if (flScale != 1.0) SetEntPropFloat(EmoteEnt,Prop_Send,"m_flModelScale",flScale);
        }

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

        if (IsClient && g_cvHidePlayers.BoolValue)
        {
            for (int i = 1; i <= MaxClients; i++)
            {
                if (IsClientInGame(i) && IsPlayerAlive(i)
                    && GetClientTeam(i) != GetClientTeam(ent)
                    && !g_bHooked[i])
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
    }
    
    g_Dancers[dancer].amount = amount;

    int effects;

    // Set entity effects
    if (IsClient)
    {
        effects = GetEntProp(ent,Prop_Send,"m_fEffects");
        effects |= EF_BONEMERGE|EF_PARENT_ANIMATES;
        if (g_cvFastCull.BoolValue) effects |= EF_BONEMERGE_FASTCULL;
        else                        effects &= ~EF_BONEMERGE_FASTCULL;
        SetEntProp(ent,Prop_Send,"m_fEffects",effects);
    }

    bool need_skin = !IsClient || (!self_visible && !IsFakeClient(ent));

    // For real players we need to draw on their client side what's missing.
    if ( need_skin && skin<=0 )
    {
        RemoveSkin(ent);
        skin = CreateEntityByName("commentary_dummy");
        if (skin>0 && IsValidEntity(skin))
        {
            DispatchKeyValue(skin, "targetname",            "emote_skin");
            DispatchKeyValue(skin, "model",                 model);
            DispatchKeyValue(skin, "solid",                 "0");
            if (IsClient)
            {
                DispatchKeyValue(skin, "disableshadows",        "1");
                DispatchKeyValue(skin, "disablereceiveshadows", "1");
            }
            DispatchKeyValue(skin, "DisableBoneFollowers",  "1"); // Save edicts
            DispatchKeyValueInt(skin, "teamnumber",         team);
            DispatchSpawn(skin);
            SetVariantString("!activator");
            AcceptEntityInput(skin, "SetParent", EmoteEnt);
            TeleportEntity(skin,{0.0,0.0,0.0},{0.0,0.0,0.0},{0.0,0.0,0.0});
            SetEntityMoveType(skin, MOVETYPE_NONE);
            SetEntPropEnt(skin, Prop_Send, "m_hOwnerEntity", ent);
            SetEntityRenderMode(skin, RENDER_TRANSALPHA);
            if (ghost)
                SetEntityRenderColor(skin, 255, 255, 255, 100);
            if (IsClient)
                SDKHook(skin, SDKHook_SetTransmit, SetTransmitOwner);
            
            // Set skin effects
            effects = GetEntProp(skin,Prop_Send,"m_fEffects")|EF_BONEMERGE|EF_PARENT_ANIMATES;
            if (IsClient) effects |= EF_NOSHADOW|EF_NORECEIVESHADOW;
            if (g_cvFastCull.BoolValue) effects |= EF_BONEMERGE_FASTCULL;
            else                        effects &= ~EF_BONEMERGE_FASTCULL;
            SetEntProp(skin,Prop_Send,"m_fEffects",effects);

            g_Dancers[dancer].skinRef = EntIndexToEntRef(skin);

            // Clone color, skin, body
            if (!ghost)
            {
                int r, g, b, a;
                GetEntityRenderColor(ent,r,g,b,a);
                SetEntityRenderColor(skin,r,g,b,a);
            }
            SetEntProp(skin, Prop_Send, "m_nBody",GetEntProp(ent, Prop_Send, "m_nBody"));
            SetEntProp(skin, Prop_Send, "m_nSkin",GetEntProp(ent, Prop_Send, "m_nSkin"));
        }
        else
        {
            skin = -1;
        }
    }
    else if (!need_skin)
    {
        RemoveSkin(ent);
        skin = -1;
    }

    CreateEmoteSound(ent,EmoteClass,ghost,data.sound);

    if (StrEqual(data.loop, "none", false))
        HookSingleEntityOutput(EmoteEnt, "OnAnimationDone", EndAnimation, true);
    else if (!StrEqual(data.loop, ""))
    {
        // Start the loop ourselves, otherwise the dance switches to DanceMoves after the intro.
        HookSingleEntityOutput(EmoteEnt, "OnAnimationDone", StartLoopAnimation, true);
    }

    SetVariantString(data.intro);
    AcceptEntityInput(EmoteEnt, "SetAnimation", -1, -1, 0);
    SetEntPropFloat(EmoteEnt, Prop_Send, "m_flPlaybackRate", g_cvSpeed.FloatValue);

    if (g_cvCooldown.FloatValue>0.0)
        CooldownTimers[ent] = CreateTimer(g_cvCooldown.FloatValue, ResetCooldown, ent);

    if (g_EmoteForward != null)
    {
        Call_StartForward(g_EmoteForward);
        Call_PushCell(ent);
        Call_Finish();
    }
    
    ////LogMessage("Create_Emote %d %d", ent, EmoteEnt);
    return Plugin_Handled;
}

Action DancerTraceAttack(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &ammotype, int hitbox, int hitgroup)
{
    if (damage<=0.0) return Plugin_Continue;
    SDKUnhook(victim,SDKHook_TraceAttack,DancerTraceAttack);
    if (IsEntityDancing(victim))
    {
        //LogMessage("StopEmote DancerTraceAttack");
        StopEmote(victim);
    }
    return Plugin_Continue;
}

Action DancerTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype)
{
    if (damage<=0.0) return Plugin_Continue;
    SDKUnhook(victim,SDKHook_OnTakeDamage,DancerTakeDamage);
    if (IsEntityDancing(victim))
    {
        //LogMessage("StopEmote DancerTakeDamage");
        StopEmote(victim);
    }
    return Plugin_Continue;
}

// Transmit skin only to its owner
Action SetTransmitOwner(int skin, int viewer)
{
    if (GetEntPropEnt(skin,Prop_Send,"m_hOwnerEntity")==viewer)
        return Plugin_Continue;
    return Plugin_Handled;
}

stock bool CanPlayerDance(const int client, L4DTeam team)
{
    if (g_bRoundEnd && team==L4DTeam_Survivor) return false; // prevent item loss
    //if (!IsPlayerAlive(client)) return false;
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

stock bool CanInfectedDance(int ent)
{
    if (GetEntProp(ent,Prop_Data,"m_iHealth")<=0)
    {
        //LogMessage("CanInfectedDance health");
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
    if (0<GetEntPropEnt(ent,Prop_Send,"m_clientLookatTarget")<=MaxClients)
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

// ============================================================
// RunCmd / animation end
// ============================================================

public Action OnPlayerRunCmd(int client, int &buttons, int &impulse)
{
    if (!IsEntityDancing(client)) return Plugin_Continue;
    if (g_cvTeleportFix.BoolValue && GetEntProp(client, Prop_Send, "moveparent")>0)
    {
        // Check if client was teleported relative to its parent
        float pos[3];
        GetEntPropVector(client, Prop_Send, "m_vecOrigin", pos); // should always be {0.0,0.0,0.0} while parented to EmoteEnt
        float dist_sq = GetVectorLength(pos,true);
        if (dist_sq>=100000.0)
        {
            ////LogMessage("Teleport detected %d dist_sq %f", client, dist_sq);
            float ang[3],vel[3];
            GetEntPropVector(client, Prop_Send, "m_angRotation", ang);
            GetEntPropVector(client, Prop_Data, "m_vecVelocity", vel);
            StopEmote(client);
            TeleportEntity(client,pos,ang,vel);
            return Plugin_Continue;
        }
    }
    if (!EmoteValidGround(client))
    {
        StopEmote(client); // Client is not on ground
        return Plugin_Continue;
    }
    if (g_Dancers[g_iDancers[client]].modelIndex!=GetEntProp(client, Prop_Send, "m_nModelIndex"))
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
    //LogMessage("EndAnimation %d %d", caller, activator);
    StopEmote(activator);
}

void StartLoopAnimation(const char[] output, int caller, int activator, float delay)
{
    int ent = GetEmoteActivator(EntIndexToEntRef(caller));
    if (ent<=0) return;
    int amount = g_Dancers[g_iDancers[ent]].amount;
    if (amount>=EMOTES_COUNT)
        SetVariantString(g_Dances[amount-EMOTES_COUNT].loop);
    else
        SetVariantString(g_Emotes[amount].loop);
    AcceptEntityInput(caller, "SetAnimation", -1, -1, 0);
    SetEntPropFloat(caller, Prop_Send, "m_flPlaybackRate", g_cvSpeed.FloatValue);
}

// Return -1 on failure, entity index otherwise
int GetEmoteActivator(int iEntRefDancer)
{
    if (iEntRefDancer == INVALID_ENT_REFERENCE)
        return -1;
    int owner = GetEntPropEnt(iEntRefDancer, Prop_Send, "m_hOwnerEntity");
    if (IsEntityDancing(owner) && g_Dancers[g_iDancers[owner]].emoteRef==iEntRefDancer)
        return owner;
    return -1;
}

// ============================================================
// Stop / Terminate emote
// ============================================================

// Full cleanup
void StopEmote(int ent)
{
    if (ent<=0 || ent>MAXENTITIES) return;
    
    int dancer = g_iDancers[ent];
    if (dancer<0) return;

    //LogMessage("StopEmote %d", ent);

    int modelIndex = g_Dancers[dancer].modelIndex;
    int EmoteClass = GetEmoteClass(ent);
    bool valid_ent = EmoteClass!=EMOTECLASS_INVALID;
    bool valid_client = EmoteClass==EMOTECLASS_PLAYER;

    int iEmoteEnt = EntRefToEntIndex(g_Dancers[dancer].emoteRef);
    if (iEmoteEnt>0 && IsValidEntity(iEmoteEnt))
    {
        // https://forums.alliedmods.net/showthread.php?t=212872
        if (g_bL4D2) SetEntPropFloat(iEmoteEnt, Prop_Send, "m_flModelScale", 1.0);
        if (valid_client) AcceptEntityInput(ent, "ClearParent");
        CleanRemoveEntity(iEmoteEnt);
        if (valid_client && g_cvTeleportBack.BoolValue)
            TeleportEntity(ent, g_fLastPosition[ent], g_fLastAngles[ent], valid_client ? NULL_VECTOR : {0.0,0.0,0.0});
    }

    if (valid_ent)
    {
        SDKUnhook(ent, SDKHook_TraceAttack,  DancerTraceAttack);
        SDKUnhook(ent, SDKHook_OnTakeDamage, DancerTakeDamage);
        SDKUnhook(ent, SDKHook_StartTouch,   DancerTouch);
        SDKUnhook(ent, SDKHook_EndTouch,     DancerTouch);
        SDKUnhook(ent, SDKHook_Touch,        DancerTouch);
        StopEmoteSound(ent);
    }

    RemoveSkin(ent);
    g_iDancers[ent] = -1;

    // Always restore the player, even if the emote prop was already removed.
    if (valid_client)
    {
        ResetCam(ent);
        WeaponUnblock(ent);
        if ( GetEntityMoveType(ent)==MOVETYPE_NONE && g_Dancers[dancer].movetype!=MOVETYPE_NONE && IsPlayerAlive(ent) && !bIsPlayerIncapped(ent) )
            SetEntityMoveType(ent, g_Dancers[dancer].movetype);
        else
            CreateTimer(0.1, Timer_CheckMoveType, ent, TIMER_FLAG_NO_MAPCHANGE);
    }
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
            {
                //SetEntityModel(ent, modelPath);
                //SetEntityModel(ent, FILE_MODEL_FAKE);
                SetEntityModel(ent, modelPath);
            }
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
}

// Less cleanup. Fires only when entities are created or destroyed
void TerminateEmote(int ent)
{
    if (ent<=0 || ent>MAXENTITIES) return;

    CooldownTimers[ent] = null;

    if (g_iDancers[ent]<0) return;

    //LogMessage("TerminateEmote %d", ent);

    int EmoteClass = GetEmoteClass(ent);
    bool valid_ent = EmoteClass!=EMOTECLASS_INVALID;
    bool valid_client = EmoteClass==EMOTECLASS_PLAYER;

    int iEmoteEnt = EntRefToEntIndex(g_Dancers[g_iDancers[ent]].emoteRef);
    if (iEmoteEnt>0 && IsValidEntity(iEmoteEnt))
    {
        // https://forums.alliedmods.net/showthread.php?t=212872
        if (g_bL4D2) SetEntPropFloat(iEmoteEnt, Prop_Send, "m_flModelScale", 1.0);
        if (valid_client) AcceptEntityInput(ent, "ClearParent");
        CleanRemoveEntity(iEmoteEnt);
    }
    
    if (valid_ent)    StopEmoteSound(ent);
    RemoveSkin(ent);
    g_iDancers[ent] = -1;

    if (0<ent<=MaxClients)
        g_fLastDance[ent] = GetGameTime();
}

stock void CreateEmoteSound(int ent, int EmoteClass, bool ghost, const char[] sound)
{
    g_Dancers[g_iDancers[ent]].sound = false;
    if (!g_cvEmotesSounds.BoolValue) return;
    if (g_cvSoundVolume.FloatValue<=0.0) return;
    if (g_cvSoundLevel.IntValue<=0.0) return;
    if (!g_bSoundsCached) return;
    if (sound[0]==0) return;
    switch (EmoteClass)
    {
        case EMOTECLASS_WITCH:
        {
            if (g_cvEmotesSounds.IntValue<2) return;
        }
        case EMOTECLASS_INFECTED:
        {
            if (g_cvEmotesSounds.IntValue<3) return;
        }
    }
    static char fullSoundPath[PLATFORM_MAX_PATH];
    GetEmoteRandomSoundPath(sound,fullSoundPath,PLATFORM_MAX_PATH);
    if (fullSoundPath[0]==0) return;
    // If ghost, emit sound selectively.
    if (ghost)
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            if (!IsClientInGame(i)) continue;
            if (view_as<L4DTeam>(GetClientTeam(i))==L4DTeam_Survivor) continue;
            EmitSoundToClient(i,fullSoundPath, ent, SNDCHAN_AUTO, g_cvSoundLevel.IntValue, SND_STOPLOOPING, g_cvSoundVolume.FloatValue);
        }
    }
    else
    {
        EmitSoundToAll(fullSoundPath, ent, SNDCHAN_AUTO, g_cvSoundLevel.IntValue, SND_STOPLOOPING, g_cvSoundVolume.FloatValue);
    }
    g_Dancers[g_iDancers[ent]].sound = true;
}

// For given sound label with possibly multiple sounds separated by commas, randomly select one.
stock void GetEmoteRandomSoundPath(const char[] sound, char[] buffer, int maxlen)
{
    if (sound[0]==0)
    {
        buffer[0]=0;
        return;
    }
    static char soundNameBuffer[ENTRY_SIZE];
    if (StrContains(sound, ",") != -1)
    {
        static char sounds[8][ENTRY_SIZE];
        int count = ExplodeString(sound, ",", sounds, sizeof(sounds), sizeof(sounds[]));
        strcopy(soundNameBuffer, ENTRY_SIZE, sounds[GetRandomInt(0, count - 1)]);
    }
    else
        strcopy(soundNameBuffer, ENTRY_SIZE, sound);

    FormatEx(buffer, maxlen,
        "%s%s.mp3", SOUND_BASE_PATH, soundNameBuffer);
}

// Stop all possible sounds associated with emote/dance
void StopEmoteSound(int ent)
{
    if (!g_Dancers[g_iDancers[ent]].sound) return;
    g_Dancers[g_iDancers[ent]].sound = false;
    static char sound[ENTRY_SIZE];
    int amount = g_Dancers[g_iDancers[ent]].amount;
    if (amount>=EMOTES_COUNT)
        strcopy(sound,ENTRY_SIZE,g_Dances[amount-EMOTES_COUNT].sound);
    else
        strcopy(sound,ENTRY_SIZE,g_Emotes[amount].sound);
    if ( sound[0]==0 || StrEqual(sound,"",false) ) return;
    if (StrContains(sound,",",false) != -1)
    {
        static char sounds[8][ENTRY_SIZE];
        int count = ExplodeString(sound, ",", sounds, sizeof(sounds), sizeof(sounds[]));
        for (int j = 0; j < count; j++)
            StopEmoteSoundSpecific(ent,sounds[j]);
    }
    else
        StopEmoteSoundSpecific(ent,sound);
}

void StopEmoteSoundSpecific(int ent, const char[] sound)
{
    static char fullSoundPath[PLATFORM_MAX_PATH];
    FormatEx(fullSoundPath, PLATFORM_MAX_PATH,
        "%s%s.mp3", SOUND_BASE_PATH, sound);
    StopSound(ent, SNDCHAN_AUTO, fullSoundPath);
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
    if (iEnt != -1)
    {
        g_iWeaponHandEnt[client] = EntIndexToEntRef(iEnt);
        SetEntPropEnt(client, Prop_Send, "m_hActiveWeapon", -1);
    }
}

// Carryables (propane, gascan, gnome...) can't be held while emoting.
bool DropCarryable(int client)
{
    int iCarry = GetPlayerWeaponSlot(client, 5);
    if (iCarry == -1 || GetEntPropEnt(client, Prop_Send, "m_hActiveWeapon") != iCarry)
        return true;

    static char sClass[64];
    for (int slot = 0; slot <= 4; slot++)
    {
        int iWeapon = GetPlayerWeaponSlot(client, slot);
        if (iWeapon == -1)
            continue;

        GetEntityClassname(iWeapon, sClass, sizeof(sClass));
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

    if (GetEmotePeople() == 0)
    {
        for (int i = 1; i <= MaxClients; i++)
        {
            if (IsClientInGame(i) && g_bHooked[i])
            {
                SDKUnhook(i, SDKHook_SetTransmit, SetTransmit);
                g_bHooked[i] = false;
            }
        }
    }

    if (IsPlayerAlive(client) && g_iWeaponHandEnt[client] != INVALID_ENT_REFERENCE)
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

void ThinkInfected(int ent)
{
    if (!IsEntityDancing(ent))
    {
        SDKUnhook(ent,SDKHook_Think,ThinkInfected);
        return;
    }
    if (!CanInfectedDance(ent))
    {
        //LogMessage("ThinkInfected %d", ent);
        StopEmote(ent);
    }
}

void ThinkWitch(int ent)
{
    if (!IsEntityDancing(ent))
    {
        SDKUnhook(ent,SDKHook_Think,ThinkWitch);
        return;
    }
    if (!CanWitchDance(ent))
    {
        //LogMessage("ThinkWitch %d", ent);
        StopEmote(ent);
    }
}

void OnPostThinkPost(int client)
{
    SetEntProp(client, Prop_Send, "m_iAddonBits", 0);
}

Action SetTransmit(int entity, int client)
{
    if (IsEntityDancing(client) && IsPlayerAlive(client) && GetClientTeam(client) != GetClientTeam(entity))
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

void RemoveSkin(int ent)
{
    if (g_iDancers[ent]<0) return;
    int skin = EntRefToEntIndex(g_Dancers[g_iDancers[ent]].skinRef);
    if (skin>0 && IsValidEntity(skin))
    {
        AcceptEntityInput(skin, "ClearParent");
        TeleportEntity(skin,vOOB,NULL_VECTOR,{0.0,0.0,0.0});
        CleanRemoveEntity(skin);
    }
}

Action ResetCooldown(Handle timer, any ent)
{
    if (CooldownTimers[ent]==timer)
        CooldownTimers[ent] = null;
    return Plugin_Stop;
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

#define MAX_CLASSNAME_TOUCH 32

Action DancerTouch(int entity, int other)
{
    if (!IsEntityDancing(entity))
    {
        SDKUnhook(entity,SDKHook_StartTouch, DancerTouch);
        SDKUnhook(entity,SDKHook_EndTouch,   DancerTouch);
        SDKUnhook(entity,SDKHook_Touch,      DancerTouch);
        return Plugin_Continue;
    }
    static char class[MAX_CLASSNAME_TOUCH];
    if (!GetEntityClassname(other,class,MAX_CLASSNAME_TOUCH))
        return Plugin_Continue;
    if (strncmp(class,"trigger",7,false)!=0)
        return Plugin_Continue;
    if (StrEqual(class, "trigger_multiple")
        || StrEqual(class, "trigger_hurt")
        || StrEqual(class, "trigger_push"))
    {
        //LogMessage("StopEmote DancerTouch");
        SDKUnhook(entity,SDKHook_StartTouch, DancerTouch);
        SDKUnhook(entity,SDKHook_EndTouch,   DancerTouch);
        SDKUnhook(entity,SDKHook_Touch,      DancerTouch);
        StopEmote(entity);
    }
    return Plugin_Continue;
}

// ============================================================
// Utilities
// ============================================================

// Make sure client does not have MOVETYPE_NONE if they are not dancing
Action Timer_CheckMoveType(Handle timer, any client)
{
    if (!IsValidClient(client)) return Plugin_Stop;
    if (IsEntityDancing(client)) return Plugin_Stop;
    if (GetEntityMoveType(client)!=MOVETYPE_NONE) return Plugin_Stop;
    if (!IsPlayerAlive(client)) return Plugin_Stop;
    if (bIsPlayerIncapped(client)) return Plugin_Stop;
    SetEntityMoveType(client, MOVETYPE_WALK);
    return Plugin_Stop;
}

// Fills EmoteData, don't use this unless you need the whole enum struct.
stock void PopulateEmoteData(int amount, EmoteData data)
{
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
stock bool EmoteValidGround(int client)
{
    //return true;
    return GetEntityFlags(client)&FL_ONGROUND;
    //return GetEntPropEnt(client, Prop_Send, "m_hGroundEntity") == 0;
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
        if (IsClientInGame(i) && IsEntityDancing(i))
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

float GetModelScale(const char[] model)
{
    if (StrContains(model, "infected", false) != -1)
    {
        if (StrContains(model, "common", false) != -1)
            return SCALE_COMMON;
        if (StrContains(model, "hunter", false) != -1)
            return SCALE_HUNTER;
        if (StrContains(model, "boome", false) != -1)
            return SCALE_BOOMER;
        if (StrContains(model, "smoker", false) != -1)
            return SCALE_SMOKER;
        if (StrContains(model, "witch", false) != -1)
            return SCALE_WITCH;
        if (StrContains(model, "hulk", false) != -1)
            return SCALE_TANK;
        return 1.0;
    }
    if (StrContains(model, "manager", false) != -1)       // Louis
        return SCALE_LOUIS;
    if (StrContains(model, "coach", false) != -1)       // Coach
        return SCALE_COACH;
    if (StrContains(model, "mechanic", false) != -1)    // Ellis 
        return SCALE_ELLIS;
    if (StrContains(model, "biker", false) != -1)       // Francis
        return SCALE_FRANCIS;
    if (StrContains(model, "teenangst", false) != -1)   // Zoey
        return SCALE_ZOEY;
    if (StrContains(model, "gambler", false) != -1)       // Nick
        return SCALE_NICK;
    if (StrContains(model, "namvet", false) != -1)       // Bill
        return SCALE_BILL;
    if (StrContains(model, "producer", false) != -1)   // Rochelle
        return SCALE_ROCHELLE;
    return 1.0;
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

stock void DISABLE_TRANSMIT_ALWAYS(int entity)
{
    SetEdictFlags(entity, GetEdictFlags(entity)&~FL_EDICT_ALWAYS);
}