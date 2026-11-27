Nearly Civilized V3 visual fixes v2

Base: nearlycivilized_height_refined
Output model path:
$modelname "player/kodua/fnemotes_nearlycivilized_v3_l4d2.mdl"

Changes in this revision:
1) body_profile_smoker.smd
   - ValveBiped.Bip01_Head1 translation changed from
     3.347193184 -3.637730277 0.000048374
     to
     2.204314642 -1.414257361 0.000054247
   - Purpose: pull Smoker head back by ~2.5 HU in the reference pose.

2) body_profile_jockey.smd
   - ValveBiped.Bip01_Head1 translation changed from
     -0.622636747 -2.341338636 -0.000006764
     to
     -2.394259830 1.105361747 0.000003644
   - bip_spine_4 translation changed from
     -2.335953633 6.368713348 -0.000005090
     to
     -2.522425507 2.362924363 -0.000006439
   - Purpose: reduce Jockey upper-back collapse and move the head upward/forward relative to the back.

Unchanged:
- QC file
- pose parameters
- rig correction SMDs
- all original dance animations
- all other body profiles
