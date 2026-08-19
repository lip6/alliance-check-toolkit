
import os
from   pathlib import Path
from   doit    import get_var
from   pdks.ihpsg13g2_c4m import setup

setup( checkToolkit=Path('../../../..') )

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis                               import CRL
from coriolis.designflow.task               import ShellEnv, Tasks
from coriolis.designflow.copy               import Copy
from coriolis.designflow.yosys              import Yosys
from coriolis.designflow.blif2vst           import Blif2Vst
from coriolis.designflow.klayout            import Klayout
from coriolis.designflow.pnr                import PnR
from coriolis.designflow.lvx                import Lvx
from coriolis.designflow.x2y                import x2y
from coriolis.designflow.tasyagle           import TasYagle, STA, XTas
from coriolis.designflow.alias              import Alias
from coriolis.designflow.clean              import Clean
from pdks.ihpsg13g2_c4m.designflow.filler   import Filler
from pdks.ihpsg13g2_c4m.designflow.sealring import SealRing
from pdks.ihpsg13g2_c4m.designflow.drc      import DRC
import doDesign

reuseBlif          = get_var( 'reuse-blif', None )
PnR.textMode       = True
doDesign.buildChip = False
pnrSuffix          = '_cts_r'
topName            = 'arlet6502'
drcFlags           = DRC.NoDensity

if reuseBlif:
    ruleYosys = Copy.mkRule( 'yosys', 'Arlet6502.blif', './non_generateds/Arlet6502.{}.blif'.format( reuseBlif ))
else:
    ruleYosys = Yosys.mkRule( 'yosys', 'Arlet6502.v' )

if doDesign.buildChip:
    TasYagle.ClockName = 'clk_from_pad'
    # Rule for chip generation.
    ruleSeal  = SealRing.mkRule( 'sealring', targets=[ 'chip_r_seal.gds' ] , size=[2200.0, 2200.0] )
    rulePnR   = PnR.mkRule( 'gds'  , [ 'chip_r.gds'
                                     , 'chip_r.spi'
                                     , 'chip.spi'
                                     , 'corona_cts_r.spi'
                                     , 'corona.spi'
                                     , 'Arlet6502_cts.spi' ]
                                     , [ruleYosys, ruleSeal]
                                   , doDesign.scriptMain
                                   , topName=topName )
    staLayout = rulePnR.file_target( 3 )
else:
    TasYagle.ClockName = 'clk'
    # Rule for block generation.
    rulePnR = PnR.mkRule( 'gds'    , [ 'Arlet6502_cts_r.gds'
                                     , 'Arlet6502_cts_r.spi' ]
                                     , [ruleYosys]
                                   , doDesign.scriptMain
                                   , topName=topName )
    staLayout = rulePnR.file_target( 1 )

ruleDrc     = DRC    .mkRule( 'drc' , rulePnR.file_target(0), drcFlags )
ruleSTA     = STA    .mkRule( 'sta' , staLayout )
ruleXTas    = XTas   .mkRule( 'xtas', ruleSTA.file_target(0) )
ruleCgt     = PnR    .mkRule( 'cgt' )
ruleKlayout = Klayout.mkRule( 'klayout', depends=rulePnR.file_target(0) )
ruleClean   = Clean  .mkRule( [ 'lefRWarning.log', 'cgt.log' ] )
