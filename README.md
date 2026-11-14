# Fortnite Emotes Extended

This plugin allows players to use Emotes & Dances Fortnite do with all the private emotes included.

> [!IMPORTANT]  
> The modifications in this plugin are based on [this](https://forums.alliedmods.net/showpost.php?p=2836162&postcount=276) version, which is specifically designed for L4D1/2.
The plugin only loads on L4D1 and L4D2.

**Original Version:** https://forums.alliedmods.net/showthread.php?t=318981

## Installation
Download the package for your game from the [releases](https://github.com/Ferks-FK/Fortnite-Emotes-Extended/releases): `...-l4d2-<version>.tar.gz` or `...-l4d1-<version>.tar.gz`, and extract it into `left4dead2/` or `left4dead/`.
The plugin is the same in both; only the emote model differs.

### L4D1 model
L4D1 uses `fnemotes_nearlycivilized_v2_l4d1`, generated from the L4D2 model (it renames 8 helper bones that bend the L4D1 survivors' limbs). It isn't stored in the repository: the release build generates it. After changing the model, you can generate it locally with:

```
python tools/make_l4d1_model.py
```

## Commands
- **`sm_emotes`** - User command for main menu;
- **`sm_dances`** - User command for main menu;
- **`sm_rdance`** - Performs a random dance/emote.
- **`sm_doemote`** - Permform a specific dance/emote.
- **`sm_dodance`** - Permform a specific dance/emote.
- **`sm_danceall`** - Force all players to dance. ***(ADMIN COMMAND)***
- **`sm_setemotes <#userid|name> [Emote ID]`** - Emote ID ***(ADMIN COMMAND)***;
- **`sm_setdances <#userid|name> [Emote ID]`** - Emote ID ***(ADMIN COMMAND)***;

## Changelog

V2.4.1 (14/11/2026)

- Infected can now use emotes on L4D2. Spitter, Jockey and Charger can't dance, so they are blocked by default (`sm_emotes_block_nonhumanoid`). Survivors can't see a ghost infected dancing.
- Hunters and Smokers keep the game camera while pinning someone.
- Tanks can't start an emote while throwing a rock, since it sent the rock in the wrong direction.
- Removed an unused sound entity created on every emote; the emote sound now always stops when the emote ends ([#8](https://github.com/Ferks-FK/Fortnite-Emotes-Extended/issues/8)). Thanks to gvazdas.

V2.4.0 (11/11/2026)

- Added L4D1 support: third-person camera, survivor model that follows the dance, and an L4D1 copy of the emote model without the limb distortion ([#6](https://github.com/Ferks-FK/Fortnite-Emotes-Extended/issues/6)). Based on foxhound's L4D1/2 version, with help from gvazdas.
- The plugin now refuses to load on games other than L4D1/L4D2.
- Releases now have one package per game.
- Fixed dances with an intro and a loop switching to another dance after the intro.
- Hide the emote entity before it is removed, to avoid stuck shadows ([#5](https://github.com/Ferks-FK/Fortnite-Emotes-Extended/issues/5)). Thanks to gvazdas.
- Fixed possible errors when a player/bot leaves during an emote. Thanks to gvazdas.
- Emote entity names no longer use random numbers, which could collide between players.

V2.3.0 (09/10/2026)

- Sounds are no longer downloaded/precached when `sm_emotes_sounds` is disabled, and a missing sound file now only skips that file instead of disabling all sounds. Thanks to gvazdas ([PR](https://github.com/Ferks-FK/Fortnite-Emotes-Extended/pull/1)).
- Fixed players ending up with no usable weapon after an emote while holding a carryable (propane tank, gas can, gnome...). The item is now dropped before the emote and can still be picked up or explode.
- Fixed players being left frozen and unable to switch weapons if the emote was interrupted unexpectedly.
- Weapons are only restored after an emote if the player still owns them.

V2.2.2 (19/06/2026)

- Add emote Walky Walk.
- Add emote Epic Sax Guy.
- Add taunt Quagmire.
- Animations by [Actmod](https://steamcommunity.com/sharedfiles/filedetails/?id=2538387266)

V2.2.1 (15/06/2026)

- Add emote Kung Fu Cat [Original](https://steamcommunity.com/sharedfiles/filedetails/?id=3612367206)
- Add emote Groove Battle [Original](https://steamcommunity.com/sharedfiles/filedetails/?id=2842271007)

V2.2.0 (13/06/2026)

- Add new emote (Dr Livesey Walk).

V2.1.0 (01/06/2026)

- Fix the issue where the incapacitated bot dies when switching teams.

V2.0.0 (19/05/2026)

- Removed dependencies of “LiquidHelpers” and “AutoExecConfig” includes.
- Fixed a bug where taking control of a BOT that was dancing (`sm_danceall`) would leave the player frozen and unable to move.

v1.9.0 (11/05/2026)

- The way emotes/dances, sound precaching, and menu usage have been completely revamped, instead of checking each sound or each emote/dance individually, simply loop through their respective arrays.
- Removed the emote IDs from the translations; now the plugin automatically adds them based on the emote/dance index in the array.
- Removed unused parameter of the music loop.
- Support for more than one sound per emote/dance (Hack for the “ninja_dance_01” and “dance_soldier_03” sounds has been removed).
- Fixed a server crash that occurred when interacting with the menus.
- Added the dance “California Girls” with a Spanish-language audio version.
