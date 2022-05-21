import os
import os.path
from   pathlib   import Path
from   Hurricane import Net
from   CRL       import Spice

def fix(lib):
    for cell in lib.getCells():
        for net in cell.getNets():
            if net.getName() == 'vdd':
                net.setType( Net.Type.POWER )
                net.setDirection( Net.Direction.IN )
            elif net.getName() == 'vss':
                net.setType( Net.Type.GROUND )
                net.setDirection( Net.Direction.IN )
            elif net.getName() == 'ck':
                net.setType( Net.Type.CLOCK )
                net.setDirection( Net.Direction.IN )
            elif net.getName() in ('nq', "q", 'zero', 'one'):
                net.setDirection( Net.Direction.OUT )
            else:
                net.setDirection( Net.Direction.IN )
    spiceDir = Path( __file__ ).resolve().parents[7] / 'libs.ref' / 'StdCellLib' / 'spice'
    for spiceFile in os.listdir(spiceDir):
        if spiceFile == 'StdCellLib.spi': continue
        if not spiceFile.endswith('.spi'): continue
        Spice.load( lib, str(spiceDir / spiceFile), Spice.PIN_ORDERING )
