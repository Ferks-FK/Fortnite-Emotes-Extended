// Optional SourcePawn example. Call after model assignment and animation start.
// These are profile IDs, not pose parameter indices.
enum EmoteBodyProfile
{
    EmoteBody_Default,
    EmoteBody_Nick,
    EmoteBody_Bill,
    EmoteBody_Ellis,
    EmoteBody_Zoey,
    EmoteBody_Rochelle,
    EmoteBody_Common,
    EmoteBody_Witch,
    EmoteBody_Smoker,
    EmoteBody_Boomer,
    EmoteBody_Hunter,
    EmoteBody_Tank,
    EmoteBody_Charger,
    EmoteBody_Spitter,
    EmoteBody_Jockey,
    EmoteBody_Boomette
};

void ApplyEmoteBodyProfile(int carrier, EmoteBodyProfile profile)
{
    int i = view_as<int>(profile);
    if (i < 0 || i > 15)
        i = 0;

    // Equivalent major body profiles: Bill for Nick, Boomer for Boomette.
    if (i == 1) i = 2;
    if (i == 15) i = 9;

    float rig = 0.0;
    if (i == 13) // Spitter
        rig = 0.5;
    else if (i == 14) // Jockey
        rig = 1.0;

    SetEntPropFloat(carrier, Prop_Send, "m_flPoseParameter", rig, 0);
    SetEntPropFloat(carrier, Prop_Send, "m_flPoseParameter", float(i % 4) / 3.0, 1);
    SetEntPropFloat(carrier, Prop_Send, "m_flPoseParameter", float(i / 4) / 3.0, 2);
}
