Nearly Civilized V3 L4D1 - proportion profiles

Compile fnemotes_nearlycivilized_v3_l4d1.qc with L4D1 StudioMDL in the existing compilation directory. Keep fnemotes_nearlycivilized_v3_l4d1_anims and its dance SMDs unchanged. Copy the QC and all SMD files from this package into that directory. Output: player/kodua/fnemotes_nearlycivilized_v3_l4d1.mdl.

The original uploaded QC is an exact byte prefix of the new QC. The reference SMD is byte-for-byte unchanged (76 bones, including four Tank aliases). All 141 original sequences and source paths remain unchanged. No L4D2-only bones or corrective orientation layer. Nine unique static profile SMDs; all two-frame transforms identical. Existing Smoker 3.5 HU setback and Tank +4 HU alias offsets carried over. The eight _alveBiped helper names remain unchanged; their profile weights are zero because they do not merge by the original bone name.

Pose parameters: index 0 infected_rig reserved (always set to 0); index 1 body_profile_x; index 2 body_profile_y. All ranges 0..1. Same 4x4 grid as L4D2, with unused L4D2-only cells replaced with neutral samples. Boomette's old slot points to Boomer. No need to remap the L4D1 branches of FillPoseParams. Initialize all values to zero before selection.

Model                     rig       x       y
Francis / Louis           0         0       0
Bill                      0         2/3     0
Zoey                      0         0       1/3
Common                    0         2/3     1/3
Witch                     0         1       1/3
Smoker                    0         0       2/3
Boomer                    0         1/3     2/3
Hunter                    0         2/3     2/3
Tank                      0         1       2/3

Source: nearlycivilized_jockey_native_height.zip, latest L4D2 profiles. Translation deltas transferred by matching IDs, names, parent relationships, and parent reference rotation matrices (not fresh native L4D1 model measurements). Reference-pose height comparison in height_port_check.csv, per-bone port in translation_audit.csv. The comparison does not account for engine animation compression, runtime rotations, or compiler bone stripping. L4D1 compilation and pose parameter indexing/playback must be tested. The unused infected_rig declaration is intended to preserve indexing, not an actual animation layer. Check in HLMV after compiling that body_profile_x and body_profile_y are at indices 1 and 2.
