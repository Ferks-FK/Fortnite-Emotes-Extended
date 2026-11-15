#if defined _fnemotes_included_
#endinput
#endif
#define _fnemotes_included_

/* Natives */

/**
 * Checks client's emote status
 *
 * @param client    Client's id
 * @return          True / False
 */
native bool fnemotes_IsClientEmoting(int client);

/**
 * Stops the client's emote, e.g. before changing their model.
 *
 * @param client    Client's id
 * @return          True if the client was emoting, false otherwise
 */
native bool fnemotes_StopEmote(int client);

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
    MarkNativeAsOptional("fnemotes_StopEmote");
}
#endif
