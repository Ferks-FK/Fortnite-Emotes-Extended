# Fortnite Emotes Extended

This plugin allows players to use Emotes & Dances Fortnite do with all the private emotes included.

**Original Version:** https://forums.alliedmods.net/showthread.php?t=318981

## Commands
- **`sm_emotes`** - User command for main menu;
- **`sm_dances`** - User command for main menu;
- **`sm_rdance`** - Performs a random dance/emote.
- **`sm_doemote`** - Permform a specific dance/emote.
- **`sm_dodance`** - Permform a specific dance/emote.
- **`sm_danceall`** - Force all players to dance. ***(ADMIN COMMAND)***
- **`sm_setemotes <#userid|name> [Emote ID]`** - Emote ID from 1 to 84 ***(ADMIN COMMAND)***;
- **`sm_setdances <#userid|name> [Emote ID]`** - Emote ID from 1 to 84 ***(ADMIN COMMAND)***;

## Changelog

- V2.0.0 (19/05/2026)

. Removed dependencies of “LiquidHelpers” and “AutoExecConfig” includes.

- v1.9.0 (11/05/2026)

. The way emotes/dances, sound precaching, and menu usage have been completely revamped, instead of checking each sound or each emote/dance individually, simply loop through their respective arrays.
. Removed the emote IDs from the translations; now the plugin automatically adds them based on the emote/dance index in the array.
. Removed unused parameter of the music loop.
. Support for more than one sound per emote/dance (Hack for the “ninja_dance_01” and “dance_soldier_03” sounds has been removed).
. Fixed a server crash that occurred when interacting with the menus.
. Added the dance “California Girls” with a Spanish-language audio version.
