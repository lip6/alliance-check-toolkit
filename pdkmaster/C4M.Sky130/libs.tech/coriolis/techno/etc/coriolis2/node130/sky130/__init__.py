from .techno import *
from .StdCellLib import setup as StdCellLib_setup
from .StdCellLambdaLib import setup as StdCellLambdaLib_setup
from .IOLib import setup as IOLib_setup
from .MacroLib import setup as MacroLib_setup

__lib_setups__ = [StdCellLib.setup,StdCellLambdaLib.setup,IOLib.setup,MacroLib.setup]
