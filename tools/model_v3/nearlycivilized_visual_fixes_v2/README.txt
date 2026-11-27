Nearly Civilized V3 - remove visual Jockey head lift
Baseline: nearlycivilized_head_back_fix.zip.
Only compilation file changed: rig_pose_jockey_head_neutral.smd.
Removed 4 HU model-space Z from both bip_head and bip_neck in both frames using the body profile parent rotations. Native rotation corrections and neck horizontal alignment remain unchanged. Smoker setback, QC, all other SMDs and pose parameters unchanged.
Previous audit is historical; see jockey_lift_removal_audit.csv for this revision.
Compile fnemotes_nearlycivilized_v3_l4d2.qc alongside original dance SMDs. Output player/kodua/fnemotes_nearlycivilized_v3_l4d2.mdl.
Validated all 19 corrective SMDs have identical frames. Offline reference-pose calculations only; compile and game test not performed.
