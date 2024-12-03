
from coriolis.designflow.technos import setupSky130_c4m

setupSky130_c4m( checkToolkit='../../../..'
               , pdkMasterTop='../../../../pdkmaster/C4M.Sky130' )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis.designflow.task   import Tasks
from coriolis.designflow.copy   import Copy
from coriolis.designflow.genpat import Genpat
from coriolis.designflow.asimut import Asimut
from coriolis.designflow.cougar import Cougar
from coriolis.designflow.lvx    import Lvx
from coriolis.designflow.druc   import Druc
from coriolis.designflow.pnr    import PnR
from coriolis.designflow.clean  import Clean
PnR.textMode = True

from doDesign import scriptMain

rulePnR    = PnR .mkRule  ( 'pnr'   , ['spram_256x32.gds', 'spram_256x32.vst' ]
                                    , [ 'doDesign.py' ]
                                    , scriptMain )
ruleGenpat = Genpat.mkRule( 'genpat', 'spram_256x32.pat', 'spram_256x32_pat.c' )
ruleAsimut = Asimut.mkRule( 'asimut', 'spram_256x32_sim.pat', [rulePnR.file_target(1), ruleGenpat] )
ruleCgt    = PnR   .mkRule( 'cgt' )
ruleClean  = Clean .mkRule()
