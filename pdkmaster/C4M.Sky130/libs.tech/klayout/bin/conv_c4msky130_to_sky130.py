#!/bin/env python3
from typing import Any, cast
import sys

import pya as _pya
pya = cast(Any, _pya)

if len(sys.argv) != 3:
    print(sys.argv)
    print(f"Usage: {sys.argv[0]} in out", file=sys.stderr)
    exit(20)

lay = pya.Layout()
lay.read(sys.argv[1])

nwell_idx = lay.layer(64, 20)
diff_idx = lay.layer(65, 20)
tap_idx = lay.layer(65, 44)
nsdm_idx = lay.layer(93, 44)
psdm_idx = lay.layer(94, 20)

for cell in lay.each_cell():
    nwell = pya.Region(cell.shapes(nwell_idx))
    nsdm = pya.Region(cell.shapes(nsdm_idx))
    psdm = pya.Region(cell.shapes(psdm_idx))

    tap_cover = (nsdm & nwell) + (psdm - nwell)

    diff_shapes = cell.shapes(diff_idx)
    tap_shapes = cell.shapes(tap_idx)

    difftap = pya.Region(cell.shapes(diff_idx)) # Original difftap layer to be split

    tap = difftap & tap_cover
    diff = difftap - tap

    diff_shapes.clear()
    diff_shapes.insert(diff)
    tap_shapes.insert(tap)

lay.write(sys.argv[2])
