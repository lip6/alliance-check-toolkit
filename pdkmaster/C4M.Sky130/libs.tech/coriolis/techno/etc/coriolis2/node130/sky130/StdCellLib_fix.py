import os
from pathlib import Path

from coriolis.CRL import Spice

def fix(lib):
    spiceDir = Path(__file__).parents[7] / 'libs.ref' / 'StdCellLib' / 'spice'
    for spiceFile in os.listdir(spiceDir):
        if spiceFile in ('StdCellLib.spi', "Gallery.spi):
            continue
        if not spiceFile.endswith('.spi'):
            continue
        Spice.load( lib, str(spiceDir / spiceFile), Spice.PIN_ORDERING )
