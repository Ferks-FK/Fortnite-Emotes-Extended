#if defined _fnemotes_included_
#endinput
#endif
#define _fnemotes_included_

// Enum for random emote ID (0-based) to roll: all, emotes only, dances only, or stop.
#define PERFORM_RANDOM_ALL -4
#define PERFORM_RANDOM_EMOTE -3
#define PERFORM_RANDOM_DANCE -2
#define PERFORM_STOP -1

/* Natives */

/**
 * Checks client's emote status
 *
 * @param client    Client's id
 * @return          True / False
 */
native bool fnemotes_IsClientEmoting(int client);

/**
 * Checks enity's emote status
 *
 * @param client    Entity index
 * @return          True / False
 */
native bool fnemotes_IsEntityEmoting(int entity);

/**
 * Stops the client's emote, e.g. before changing their model.
 *
 * @param client    Client's id
 * @return          True if the client was emoting, false otherwise
 */
native bool fnemotes_StopEmote(int client);

/**
 * Make entity index perform emote or dance given by 0-based ID, if they can dance.
 *
 * @param client    entity index
 * @param amount    0-based Emote ID
 * @return          true on success, false otherwise
 */
native bool fnemotes_EmoteEntity(int entity, int amount = PERFORM_RANDOM_ALL);

/* Forwards */

/**
 * Called before a client starts an emote
 *
 * @param client    Client's id
 * @return          Plugin_Continue to allow, anything else to block
 */
forward Action fnemotes_OnEmote_Pre(int client);

/**
 * When a client do a emote
 *
 * @param client    Client's id
 */
forward void fnemotes_OnEmote(int client);

public SharedPlugin __pl_fnemotes =
{
    name = "fnemotes",
    file = "fnemotes_near.smx",
    #if defined REQUIRE_PLUGIN
    required = 1,
    #else
    required = 0,
    #endif
};

#if !defined REQUIRE_PLUGIN
public void __pl_fnemotes_SetNTVOptional()
{
    MarkNativeAsOptional("fnemotes_IsClientEmoting");
    MarkNativeAsOptional("fnemotes_IsEntityEmoting");
    MarkNativeAsOptional("fnemotes_StopEmote");
    MarkNativeAsOptional("fnemotes_EmoteEntity");
}
#endif
