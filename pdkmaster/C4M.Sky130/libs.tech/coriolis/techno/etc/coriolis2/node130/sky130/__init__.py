from .techno import *
from .StdCellLib import setup as StdCellLib_setup
from .IOLib import setup as IOLib_setup
from .MacroLib import setup as MacroLib_setup
from .ExampleSRAMs import setup as ExampleSRAMs_setup

__lib_setups__ = [StdCellLib.setup,IOLib.setup,MacroLib.setup,ExampleSRAMs.setup]
