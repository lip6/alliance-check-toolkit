from .techno import *
from .StdCellLib import setup as StdCellLib_setup
from .StdCell3V3Lib import setup as StdCell3V3Lib_setup
from .sg13g2_io import setup as sg13g2_io_setup

__lib_setups__ = [StdCellLib.setup,StdCell3V3Lib.setup,sg13g2_io.setup]
