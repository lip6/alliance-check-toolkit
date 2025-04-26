
import os
from   pathlib import Path
from   pdks    import ispd18

benchmark = Path( __file__ ).parts[-2]

ispd18.setup( checkToolkit=Path( '../../..' ), benchmark=benchmark )

DOIT_CONFIG = { 'verbosity' : 2 }

from   coriolis                  import CRL
from   coriolis.designflow.task  import ShellEnv, Tasks
from   coriolis.designflow.pnr   import PnR
from   coriolis.designflow.alias import Alias
from   coriolis.designflow.clean import Clean
import doDesign 

PnR.textMode      = True
doDesign.loadCell = ispd18.designStem
rulePnR     = PnR  .mkRule( 'pnr', [ ispd18.designStem + '_export.def'
                                   , ispd18.designStem + '.katana.dat'
                                   , ispd18.designStem + '.00.density.histogram.dat'
                                   , ispd18.designStem + '.00.density.histogram.plt' ]
                                 , []
                                 , doDesign.scriptMain )
ruleCgt     = PnR  .mkRule( 'cgt' )
ruleClean   = Clean.mkRule( [ 'lefRWarning.log', 'cgt.log' ] )
