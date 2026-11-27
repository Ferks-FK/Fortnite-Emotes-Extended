// Created by Crowbar 0.74

$modelname "player/kodua/fnemotes_nearlycivilized_v3_l4d1.mdl"

$bodygroup "studio"
{
	studio "animset_t_shared_survivor_skeleton.smd"
}


$surfaceprop "flesh"

$contents "solid"

$illumposition -1.84 -13.826 37.867

$cdmaterials "models\survivors\"

$attachment "eyes" "ValveBiped.Bip01_Head1" 2.92 -2.8 0 rotate 0 -89.37 -90
$attachment "mouth" "ValveBiped.Bip01_Head1" 0.84 -6.09 -0.16 rotate 0 -80 -90
$attachment "survivor_light" "ValveBiped.Bip01_Spine2" 6.3 25.2 0 rotate 0 0 0
$attachment "forward" "ValveBiped.forward" 0 0 0 rotate 0 0 0
$attachment "pistol" "ValveBiped.Bip01_R_Thigh" -3.48 2.17 -5.47 rotate -3.66 -0.47 96.14
$attachment "weapon_bone" "ValveBiped.weapon_bone" 0 0 0 rotate 0 0 0
$attachment "medkit" "ValveBiped.Bip01_Spine4" -1.34 -5.84 -1.37 rotate 5.03 77.16 0
$attachment "primary" "ValveBiped.Bip01_Spine4" 3.21 -5.16 -2.75 rotate -13.7 170.19 174.29
$attachment "attach_R_shoulderBladeAim" "ValveBiped.Bip01_Spine4" -11.07 -1.46 -5.33 rotate -90 -102.85 0
$attachment "attach_L_shoulderBladeAim" "ValveBiped.Bip01_Spine4" -11.07 -1.46 3.69 rotate -90 -102.85 0
$attachment "melee" "ValveBiped.Bip01_Spine4" 2.87 -5.56 5.47 rotate 24.08 175.37 97.14
$attachment "molotov" "ValveBiped.Bip01_Spine" -3.78 -2.89 8.29 rotate -63.44 -74.67 -101.41
$attachment "grenade" "ValveBiped.Bip01_Spine" -0.8 1.38 9.33 rotate -90 -175.23 0
$attachment "pills" "ValveBiped.Bip01_Spine" -3.1 0.74 -8.47 rotate -41.18 -88.48 -87.05
$attachment "lfoot" "ValveBiped.Bip01_L_Foot" 0 5.25 0 rotate 0 0 0
$attachment "rfoot" "ValveBiped.Bip01_R_Foot" 0 5.25 0 rotate 0 0 0
$attachment "muzzle_flash" "ValveBiped.Bip01_L_Hand" 0 0 0 rotate 0 0 0
$attachment "survivor_neck" "ValveBiped.Bip01_Neck1" 0 0 0 rotate 0 0 0
$attachment "forward" "ValveBiped.forward" 0 0 0 rotate 0 0 0
$attachment "bleedout" "ValveBiped.Bip01_Pelvis" 9.97 10.5 5.25 rotate 0 0 0
$attachment "survivor_light" "ValveBiped.Bip01_Spine2" 6.3 25.2 0 rotate 0 0 0
$attachment "legL_B" "ValveBiped.attachment_bandage_legL" 0 0 0 rotate -90 -90 0
$attachment "armL_B" "ValveBiped.attachment_bandage_armL" 0 0 0 rotate -90 -90 0
$attachment "armL_T" "ValveBiped.attachment_armL_T" 0 0 0 rotate -90 -90 0
$attachment "armR_T" "ValveBiped.attachment_armR_T" 0 0 0 rotate -90 -90 0
$attachment "armL" "ValveBiped.Bip01_L_Forearm" 0 0 0 rotate 0 0 0
$attachment "legL" "ValveBiped.Bip01_L_Calf" 0 0 0 rotate 0 0 0
$attachment "thighL" "ValveBiped.Bip01_L_Thigh" 0 0 0 rotate 0 0 0
$attachment "spine" "ValveBiped.Bip01_Spine" 0 0 0 rotate -90 -90 0

$cbox 0 0 0 0 0 0

$bbox -13 -13 0 13 13 72

$definebone "ValveBiped.Bip01_Pelvis" "" 0 0.542612 40.233574 0 0 89.999975 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine" "ValveBiped.Bip01_Pelvis" 0 4.246162 -0.018825 4.766603 89.999982 89.999982 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine1" "ValveBiped.Bip01_Spine" 4.195629 0 0 0 -9.852977 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine2" "ValveBiped.Bip01_Spine1" 3.883152 0.000002 0 0 -0.906997 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine4" "ValveBiped.Bip01_Spine2" 5.985943 0.00001 0 0 28.371677 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Clavicle" "ValveBiped.Bip01_Spine4" 4.268623 1.531898 -1.575 63.875308 -147.035777 -54.583286 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_UpperArm" "ValveBiped.Bip01_R_Clavicle" 5.782726 -0.000019 -0.000002 22.698469 -42.953605 82.694992 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Forearm" "ValveBiped.Bip01_R_UpperArm" 11.452713 -0.000001 -0.000019 0.000106 -7.202493 -0.000024 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Clavicle" "ValveBiped.Bip01_Spine4" 4.268612 1.531885 1.575 -63.875287 -147.035791 50.277511 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_UpperArm" "ValveBiped.Bip01_L_Clavicle" 5.782721 0.000042 -0.00001 -19.730426 -44.165424 -79.348282 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Forearm" "ValveBiped.Bip01_L_UpperArm" 11.452709 0.000008 0.000008 -0.000039 -7.202462 -0.000011 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Hand" "ValveBiped.Bip01_L_Forearm" 10.945505 0 -0.000038 6.507279 7.122698 78.669798 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Hand" "ValveBiped.Bip01_R_Forearm" 10.945517 -0.00001 0.000008 -6.507429 7.122599 -78.876998 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Thigh" "ValveBiped.Bip01_Pelvis" -3.806942 0 0 3.326304 -92.951464 -84.289083 0 0 0 0 0 0
$definebone "_alveBiped.Bip01_R_Knee" "ValveBiped.Bip01_R_Thigh" 19.253777 0 0 0 1.446719 0 0 0 0 0 0 0
$definebone "_alveBiped.Bip01_R_Quadricep" "ValveBiped.Bip01_R_Thigh" 6.694733 0 -0.000007 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck1" "ValveBiped.Bip01_Spine4" 5.620464 0.000004 0 0 14.35836 179.999841 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Head1" "ValveBiped.Bip01_Neck1" 4.684887 -0.000004 0 -0.000057 26.575554 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Calf" "ValveBiped.Bip01_R_Thigh" 19.263033 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Foot" "ValveBiped.Bip01_R_Calf" 17.58909 0 0 3.939485 -74.439534 5.084025 0 0 0 0 0 0
$definebone "_alveBiped.Bip01_R_Toe0" "ValveBiped.Bip01_R_Foot" 6.240646 0 0 1.366222 -19.288943 -6.408024 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Thigh" "ValveBiped.Bip01_Pelvis" 3.806942 0 0 3.326308 -87.048507 -95.710935 0 0 0 0 0 0
$definebone "_alveBiped.Bip01_L_Quadricep" "ValveBiped.Bip01_L_Thigh" 6.694798 0 0 0 0 0 0 0 0 0 0 0
$definebone "_alveBiped.Bip01_L_Knee" "ValveBiped.Bip01_L_Thigh" 19.253838 0 0 0 1.446891 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger4" "ValveBiped.Bip01_L_Hand" 3.147142 0.005682 -1.551351 8.213382 -12.990161 11.74243 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger41" "ValveBiped.Bip01_L_Finger4" 1.585938 0.000002 0 0.955255 -34.374679 0.653363 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger42" "ValveBiped.Bip01_L_Finger41" 0.849094 -0.000001 0 -10.048515 -17.354362 -3.121114 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger3" "ValveBiped.Bip01_L_Hand" 3.471066 0.213264 -0.574069 5.954161 -16.77824 11.337895 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger31" "ValveBiped.Bip01_L_Finger3" 1.897511 0.000008 0 -5.063417 -30.513047 -2.977622 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger32" "ValveBiped.Bip01_L_Finger31" 1.014446 0.000014 0 0.55908 -13.904547 0.138352 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger2" "ValveBiped.Bip01_L_Hand" 3.750071 0.114779 0.430057 3.893631 -14.791075 10.730331 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger21" "ValveBiped.Bip01_L_Finger2" 2.258179 0.000006 0 -3.092628 -37.967249 -2.41087 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger22" "ValveBiped.Bip01_L_Finger21" 1.2104 -0.000012 0 0.688653 -8.970449 0.108658 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger1" "ValveBiped.Bip01_L_Hand" 3.86828 -0.166626 1.490128 1.961163 -11.693712 10.352741 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger11" "ValveBiped.Bip01_L_Finger1" 1.786076 -0.00001 0 3.669072 -38.75629 2.940783 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger12" "ValveBiped.Bip01_L_Finger11" 1.044422 0.000011 0 2.209324 -1.896608 0.073111 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger0" "ValveBiped.Bip01_L_Hand" 1.121471 -1.351561 1.030993 -19.741817 -7.111182 97.051449 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger01" "ValveBiped.Bip01_L_Finger0" 1.928125 -0.000004 -0.000013 -10.778435 -10.616015 -0.000013 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Finger02" "ValveBiped.Bip01_L_Finger01" 1.285114 0.000007 -0.000004 -2.328855 11.249018 -0.000012 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Calf" "ValveBiped.Bip01_L_Thigh" 19.263132 0 0 0 0 0 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Foot" "ValveBiped.Bip01_L_Calf" 17.589096 0 0 -3.939487 -74.439534 -4.413494 0 0 0 0 0 0
$definebone "_alveBiped.Bip01_L_Toe0" "ValveBiped.Bip01_L_Foot" 6.240659 0 0 -1.587611 -19.272641 1.162817 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Ulna" "ValveBiped.Bip01_L_Forearm" 5.884344 0 0.000019 -0.000034 0.000028 -7.237044 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_L_Wrist" "ValveBiped.Bip01_L_Forearm" 11.768688 0.00001 0.000004 -0.000034 0.000028 -13.660909 0 0 0 0 0 0
$definebone "_alveBiped.Bip01_L_Elbow" "ValveBiped.Bip01_L_UpperArm" 11.679153 0.000007 0 -0.000038 -9.262329 -0.000012 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger4" "ValveBiped.Bip01_R_Hand" 3.147154 0.000069 1.551352 -8.213393 -12.989839 -11.535165 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger41" "ValveBiped.Bip01_R_Finger4" 1.585884 -0.000002 0 -0.955225 -34.374676 -0.653384 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger42" "ValveBiped.Bip01_R_Finger41" 0.849068 0.000011 0 10.048544 -17.354438 3.121092 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger3" "ValveBiped.Bip01_R_Hand" 3.471125 0.211193 0.574832 -5.954211 -16.777899 -11.130617 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger31" "ValveBiped.Bip01_R_Finger3" 1.897545 0.000008 0 5.063473 -30.512992 2.977608 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger32" "ValveBiped.Bip01_R_Finger31" 1.014439 0.00001 0 -0.559029 -13.904584 -0.13838 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger2" "ValveBiped.Bip01_R_Hand" 3.75009 0.116325 -0.429645 -3.893686 -14.790828 -10.523097 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger21" "ValveBiped.Bip01_R_Finger2" 2.258171 0.00001 0 3.092684 -37.967246 2.410838 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger22" "ValveBiped.Bip01_R_Finger21" 1.210396 0.000009 0 -0.68861 -8.970481 -0.108693 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger1" "ValveBiped.Bip01_R_Hand" 3.868292 -0.161236 -1.490732 -1.96115 -11.693403 -10.145463 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger11" "ValveBiped.Bip01_R_Finger1" 1.786076 -0.000002 0 -3.669052 -38.756232 -2.940825 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger12" "ValveBiped.Bip01_R_Finger11" 1.044434 -0.000006 0 -2.209321 -1.896572 -0.073165 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger0" "ValveBiped.Bip01_R_Hand" 1.121508 -1.347836 -1.035881 19.767314 -7.03705 -96.832917 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger01" "ValveBiped.Bip01_R_Finger0" 1.928125 0.000015 -0.000002 10.778393 -10.615967 -0.000028 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Finger02" "ValveBiped.Bip01_R_Finger01" 1.285141 0.000001 0.000011 2.328827 11.249063 -0.000037 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Wrist" "ValveBiped.Bip01_R_Forearm" 11.768715 0 -0.000034 0.000111 -0.000023 13.903719 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_R_Ulna" "ValveBiped.Bip01_R_Forearm" 5.884357 0 -0.000008 0.000111 -0.000023 7.369159 0 0 0 0 0 0
$definebone "_alveBiped.Bip01_R_Elbow" "ValveBiped.Bip01_R_UpperArm" 11.679153 0 -0.000008 0.000092 -9.262296 -0.000028 0 0 0 0 0 0
$definebone "ValveBiped.attachment_bandage_legL" "ValveBiped.Bip01_L_Calf" 7.023274 -6.879998 4.339549 -83.423261 -63.332738 150.153431 0 0 0 0 0 0
$definebone "ValveBiped.attachment_bandage_armL" "ValveBiped.Bip01_L_Forearm" 3.813801 -3.870654 0.998569 -61.285764 11.452978 89.999955 0 0 0 0 0 0
$definebone "ValveBiped.attachment_armL_T" "ValveBiped.Bip01_L_Forearm" 0.000011 -0.00001 -0.000038 6.507279 7.122698 78.669798 0 0 0 0 0 0
$definebone "ValveBiped.attachment_armR_T" "ValveBiped.Bip01_R_Forearm" 0.000023 -0.000009 -0.000034 6.507407 7.12266 78.669791 0 0 0 0 0 0
$definebone "ValveBiped.L_weapon_bone" "ValveBiped.Bip01_L_Hand" 3.348995 -1.370993 0.724998 -5.04304 89.254972 113.322018 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone" "ValveBiped.Bip01_R_Hand" 2.856867 -1.536194 -0.973804 -15.616418 -90.427784 -86.009389 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_Clip" "ValveBiped.weapon_bone" -0.000025 -0.000002 9.999981 0.000109 0 -0.000022 0 0 0 0 0 0
$definebone "ValveBiped.weapon_bone_extra" "ValveBiped.weapon_bone" 0.018887 0.665158 9.395849 0.000109 0 -0.000022 0 0 0 0 0 0
$definebone "ValveBiped.forward" "ValveBiped.Bip01_Head1" 2.000008 -3 0 0 -76 -90.000003 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine0" "ValveBiped.Bip01_Spine" 0 0 0 0 0 -0.000156 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Spine3" "ValveBiped.Bip01_Spine4" 0.000004 0 0 0 0.000028 -0.000249 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Neck0" "ValveBiped.Bip01_Neck1" 3.55756 1.828608 0.000006 0 -0.00005 -0.000217 0 0 0 0 0 0
$definebone "ValveBiped.Bip01_Head" "ValveBiped.Bip01_Head1" 3.999756 0.043834 0.000002 0.000137 -2.475808 -0.000054 0 0 0 0 0 0

$bonemerge "ValveBiped.Bip01_Pelvis"
$bonemerge "ValveBiped.Bip01_Spine"
$bonemerge "ValveBiped.Bip01_Spine1"
$bonemerge "ValveBiped.Bip01_Spine2"
$bonemerge "ValveBiped.Bip01_Spine4"
$bonemerge "ValveBiped.Bip01_R_Clavicle"
$bonemerge "ValveBiped.Bip01_R_UpperArm"
$bonemerge "ValveBiped.Bip01_R_Forearm"
$bonemerge "ValveBiped.Bip01_L_Clavicle"
$bonemerge "ValveBiped.Bip01_L_UpperArm"
$bonemerge "ValveBiped.Bip01_L_Forearm"
$bonemerge "ValveBiped.Bip01_L_Hand"
$bonemerge "ValveBiped.Bip01_R_Hand"
$bonemerge "ValveBiped.Bip01_Neck1"
$bonemerge "ValveBiped.Bip01_Head1"
$bonemerge "ValveBiped.Bip01_L_Finger4"
$bonemerge "ValveBiped.Bip01_L_Finger41"
$bonemerge "ValveBiped.Bip01_L_Finger42"
$bonemerge "ValveBiped.Bip01_L_Finger3"
$bonemerge "ValveBiped.Bip01_L_Finger31"
$bonemerge "ValveBiped.Bip01_L_Finger32"
$bonemerge "ValveBiped.Bip01_L_Finger2"
$bonemerge "ValveBiped.Bip01_L_Finger21"
$bonemerge "ValveBiped.Bip01_L_Finger22"
$bonemerge "ValveBiped.Bip01_L_Finger1"
$bonemerge "ValveBiped.Bip01_L_Finger11"
$bonemerge "ValveBiped.Bip01_L_Finger12"
$bonemerge "ValveBiped.Bip01_L_Finger0"
$bonemerge "ValveBiped.Bip01_L_Finger01"
$bonemerge "ValveBiped.Bip01_L_Finger02"
$bonemerge "ValveBiped.Bip01_L_Ulna"
$bonemerge "ValveBiped.Bip01_L_Wrist"
$bonemerge "ValveBiped.Bip01_R_Finger4"
$bonemerge "ValveBiped.Bip01_R_Finger41"
$bonemerge "ValveBiped.Bip01_R_Finger42"
$bonemerge "ValveBiped.Bip01_R_Finger3"
$bonemerge "ValveBiped.Bip01_R_Finger31"
$bonemerge "ValveBiped.Bip01_R_Finger32"
$bonemerge "ValveBiped.Bip01_R_Finger2"
$bonemerge "ValveBiped.Bip01_R_Finger21"
$bonemerge "ValveBiped.Bip01_R_Finger22"
$bonemerge "ValveBiped.Bip01_R_Finger1"
$bonemerge "ValveBiped.Bip01_R_Finger11"
$bonemerge "ValveBiped.Bip01_R_Finger12"
$bonemerge "ValveBiped.Bip01_R_Finger0"
$bonemerge "ValveBiped.Bip01_R_Finger01"
$bonemerge "ValveBiped.Bip01_R_Finger02"
$bonemerge "ValveBiped.Bip01_R_Wrist"
$bonemerge "ValveBiped.Bip01_R_Ulna"
$bonemerge "ValveBiped.L_weapon_bone"
$bonemerge "ValveBiped.weapon_bone"
$bonemerge "ValveBiped.weapon_bone_Clip"
$bonemerge "ValveBiped.weapon_bone_extra"
$bonemerge "ValveBiped.Bip01_Spine0"
$bonemerge "ValveBiped.Bip01_Spine3"
$bonemerge "ValveBiped.Bip01_Neck0"
$bonemerge "ValveBiped.Bip01_Head"


$sectionframes 30 28

$sequence "DanceMoves" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\DanceMoves.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Mask_Off_Intro" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Mask_Off_Intro.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Mask_Off_Loop" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Mask_Off_Loop.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Zippy_Dance" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Zippy_Dance.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "ElectroShuffle" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\ElectroShuffle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_AerobicChamp" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_AerobicChamp.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Bendy" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Bendy.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_BandOfTheFort" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_BandOfTheFort.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Boogie_Down_Intro" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Boogie_Down_Intro.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Boogie_Down" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Boogie_Down.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Capoeira" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Capoeira.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_KungFu_Cat" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_KungFu_Cat.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Charleston" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Charleston.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Chicken" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Chicken.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Dance_NoBones" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dance_NoBones.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Dance_Shoot" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dance_Shoot.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Dance_SwipeIt" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dance_SwipeIt.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Dance_Disco_T3" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dance_Disco_T3.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_DG_Disco" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_DG_Disco.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Dance_Worm" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dance_Worm.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Dance_Loser" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dance_Loser.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Dance_Loser_CT" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dance_Loser_CT.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Dance_Breakdance" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dance_Breakdance.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Dance_Pump" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dance_Pump.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Dance_RideThePony" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dance_RideThePony.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Dab" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Dab.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_EasternBloc_Start" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_EasternBloc_Start.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_EasternBloc" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_EasternBloc.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_FancyFeet" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_FancyFeet.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_FancyFeet_CT" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_FancyFeet_CT.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_FlossDance" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_FlossDance.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_FlippnSexy" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_FlippnSexy.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Fresh" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Fresh.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_GrooveJam" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_GrooveJam.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_guitar" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_guitar.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Hillbilly_Shuffle_Intro" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Hillbilly_Shuffle_Intro.smd"
	fadein 0.2
	fadeout 0.2
	fps 24
}

$sequence "Emote_Hillbilly_Shuffle" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Hillbilly_Shuffle.smd"
	fadein 0.2
	fadeout 0.2
	fps 24
	loop
}

$sequence "Emote_Hiphop_01" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Hiphop_01.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Hip_Hop" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Hip_Hop.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Hula_Start" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Hula_Start.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Hula" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Hula.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_InfiniDab_Intro" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_InfiniDab_Intro.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_InfiniDab_Loop" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_InfiniDab_Loop.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Intensity_Start" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Intensity_Start.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Intensity_Loop" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Intensity_Loop.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_IrishJig_Start" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_IrishJig_Start.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_IrishJig" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_IrishJig.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_KoreanEagle" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_KoreanEagle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Kpop_02" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Kpop_02.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_LivingLarge" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_LivingLarge.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Maracas" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Maracas.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_PopLock" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_PopLock.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_PopRock" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_PopRock.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_RobotDance" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_RobotDance.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_T-Rex" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_T-Rex.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_TechnoZombie" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_TechnoZombie.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Twist" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Twist.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_WarehouseDance_Start" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_WarehouseDance_Start.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_WarehouseDance_Loop" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_WarehouseDance_Loop.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Wiggle" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Wiggle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Youre_Awesome" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Youre_Awesome.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Fonzie_Pistol" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Fonzie_Pistol.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Bring_It_On" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Bring_It_On.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_ThumbsDown" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_ThumbsDown.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_ThumbsUp" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_ThumbsUp.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Celebration_Loop" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Celebration_Loop.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_BlowKiss" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_BlowKiss.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Calculated" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Calculated.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Confused" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Confused.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Chug" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Chug.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Cry" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Cry.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_DustingOffHands" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_DustingOffHands.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_DustOffShoulders" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_DustOffShoulders.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Facepalm" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Facepalm.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Fishing" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Fishing.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Flex" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Flex.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_golfclap" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_golfclap.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_HandSignals" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_HandSignals.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_HeelClick" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_HeelClick.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Hotstuff" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Hotstuff.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_IBreakYou" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_IBreakYou.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_IHeartYou" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_IHeartYou.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Kung-Fu_Salute" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Kung-Fu_Salute.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Laugh" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Laugh.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Laugh_CT" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Laugh_CT.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Luchador" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Luchador.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Make_It_Rain" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Make_It_Rain.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_NotToday" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_NotToday.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_RockPaperScissor_Paper" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_RockPaperScissor_Paper.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_RockPaperScissor_Rock" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_RockPaperScissor_Rock.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_RockPaperScissor_Scissor" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_RockPaperScissor_Scissor.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Salt" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Salt.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Salute" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Salute.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_SmoothDrive" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_SmoothDrive.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Snap" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Snap.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_StageBow" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_StageBow.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Wave2" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Wave2.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Yeet" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Yeet.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "Emote_Smooth_Moves" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Smooth_Moves.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Friday13" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Friday13.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Thanos_Twerk" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Thanos_Twerk.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Gangnam_Style" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Gangnam_Style.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
}

$sequence "Emote_InDaGhetto" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_InDaGhetto.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_BlindingLights" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_BlindingLights.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
}

$sequence "Emote_Griddy" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Griddy.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_ILikeToMoveIt" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_ILikeToMoveIt.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Macarena" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Macarena.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_NeverGonna" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_NeverGonna.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
}

$sequence "Emote_NinjaStyle" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_NinjaStyle.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_PumpkinDance" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_PumpkinDance.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
}

$sequence "Emote_PumpUpTheJam" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_PumpUpTheJam.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Renegade" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Renegade.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_RushinAround" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_RushinAround.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_SaySo" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_SaySo.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Stuck" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Stuck.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_ToosieSlide" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_ToosieSlide.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_AirShredder" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_AirShredder.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Crossbounce" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Crossbounce.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_DistractionDance" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_DistractionDance.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Headbanger" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Headbanger.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_HitchHiker" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_HitchHiker.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_ItsGoTime" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_ItsGoTime.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_KneeSlapper" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_KneeSlapper.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Showstopper" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Showstopper.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Sprinkler" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Sprinkler.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Gmod" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Gmod.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Cena" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Cena.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
}

$sequence "Emote_ChickenDance" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_ChickenDance.smd"
	fadein 0.2
	fadeout 0.2
	fps 37
	loop
}

$sequence "Emote_Ghostbusters" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Ghostbusters.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Lebron" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Lebron.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
}

$sequence "Emote_Martian" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Martian.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_RememberMe_Intro" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_RememberMe_Intro.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
}

$sequence "Emote_RememberMe_Loop" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_RememberMe_Loop.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Rollie" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Rollie.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Scenario" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Scenario.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_Tpose" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Tpose.smd"
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "Emote_DrLivesey_Walk" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_DrLivesey_Walk.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Groove_Battle" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Groove_Battle.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_Walkywalk_Walk" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_Walkywalk_Walk.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Emote_EpicSaxGuy" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Emote_EpicSaxGuy.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "Taunt_Quagmire" {
	"fnemotes_nearlycivilized_v3_l4d1_anims\Taunt_Quagmire.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$keyvalues
{
}
