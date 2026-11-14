"""Generate the L4D1 copy of the emote model from the L4D2 one.

L4D1 survivors have helper bones with the same names as 8 bones of the emote
model, but a different rest pose, so bonemerge bends their limbs. This renames
those bones (same length, so nothing else moves) and re-sorts the bone-by-name
table the engine binary-searches.

Usage: python tools/make_l4d1_model.py [SRC_BASE] [DST_BASE]
Bases are paths without extension, defaults:
  models/player/kodua/fnemotes_nearlycivilized_v2
  models/player/kodua/fnemotes_nearlycivilized_v2_l4d1
"""
import shutil
import struct
import sys

SRC = sys.argv[1] if len(sys.argv) > 1 else 'models/player/kodua/fnemotes_nearlycivilized_v2'
DST = sys.argv[2] if len(sys.argv) > 2 else SRC + '_l4d1'
EXTRA = {f'ValveBiped.Bip01_{s}_{b}' for s in 'LR' for b in ('Elbow', 'Knee', 'Quadricep', 'Toe0')}

BONE_SIZE = 216          # sizeof(mstudiobone_t)
HDR_BONES = 156          # numbones, boneindex
HDR_BONE_TABLE = 364     # bonetablebynameindex


def bone_names(d):
    nb, bi = struct.unpack('<ii', d[HDR_BONES:HDR_BONES + 8])
    names = []
    for i in range(nb):
        o = bi + i * BONE_SIZE
        p = o + struct.unpack('<i', d[o:o + 4])[0]
        names.append((p, d[p:d.index(0, p)].decode()))
    return names


def sorted_table(d):
    names = [n.lower() for _, n in bone_names(d)]
    return bytes(sorted(range(len(names)), key=lambda i: names[i]))


d = bytearray(open(SRC + '.mdl', 'rb').read())
assert d[:4] == b'IDST', 'not a studio model'
table = struct.unpack('<i', d[HDR_BONE_TABLE:HDR_BONE_TABLE + 4])[0]
nb = len(bone_names(d))
assert bytes(d[table:table + nb]) == sorted_table(d), 'unexpected bone table layout'

renamed = 0
for p, name in bone_names(d):
    if name in EXTRA:
        d[p] = ord('_')
        renamed += 1
assert renamed == len(EXTRA), f'expected {len(EXTRA)} helper bones, found {renamed}'

d[table:table + nb] = sorted_table(d)

name = DST.split('models/', 1)[-1] + '.mdl'
assert len(name) < 64, 'model name too long for the header'
d[12:76] = name.encode().ljust(64, b'\0')

open(DST + '.mdl', 'wb').write(d)
for ext in ('.vvd', '.dx90.vtx'):
    shutil.copyfile(SRC + ext, DST + ext)

check = open(DST + '.mdl', 'rb').read()
assert bytes(check[table:table + nb]) == sorted_table(check)
assert not EXTRA & {n for _, n in bone_names(check)}
print(f'{DST}.mdl: renamed {renamed} bones')
