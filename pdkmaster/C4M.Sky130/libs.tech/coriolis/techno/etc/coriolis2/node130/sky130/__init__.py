from .techno import *
from .StdCellLib import setup as StdCellLib_setup
from .StdCell5V0Lib import setup as StdCell5V0Lib_setup
from .IOLib import setup as IOLib_setup
from .MacroLib import setup as MacroLib_setup

__lib_setups__ = [StdCellLib.setup,StdCell5V0Lib.setup,IOLib.setup,MacroLib.setup]
