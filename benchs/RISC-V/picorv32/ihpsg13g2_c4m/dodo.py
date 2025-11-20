
import os
from   pathlib import Path
from   doit    import get_var
import pdks.ihpsg13g2_c4m

pdks.ihpsg13g2_c4m.setup()

DOIT_CONFIG = { 'verbosity' : 2 }

from coriolis                               import CRL
from coriolis.designflow.task               import ShellEnv, Tasks
from coriolis.designflow.pnr                import PnR
from coriolis.designflow.yosys              import Yosys
from coriolis.designflow.blif2vst           import Blif2Vst
from coriolis.designflow.alias              import Alias
from coriolis.designflow.klayout            import Klayout, DRC
from coriolis.designflow.tasyagle           import TasYagle, STA, XTas
from coriolis.designflow.alias              import Alias
from coriolis.designflow.copy               import Copy
from coriolis.designflow.clean              import Clean
from pdks.ihpsg13g2_c4m.designflow.filler   import Filler
from pdks.ihpsg13g2_c4m.designflow.sealring import SealRing
from pdks.ihpsg13g2_c4m.designflow.drc      import DRC 

import doDesign


reuseBlif          = get_var( 'reuse-blif', None )
PnR.textMode       = True
pnrSuffix          = '_cts_r'
topName            = 'picorv32'
TasYagle.ClockName = 'clk'

print( 'reuseBlif', reuseBlif )
if reuseBlif:
    ruleYosys = Copy.mkRule( 'yosys', 'picorv32.blif', './non_generateds/picorv32.{}.blif'.format( reuseBlif ))
else:
    ruleYosys = Yosys   .mkRule( 'yosys', 'picorv32.v' )
# Rule for chip generation.
#ruleSeal  = SealRing.mkRule( 'sealring', targets=[ 'chip_r_seal.gds' ] , size=[1414.0, 1414.0] )
#rulePnR   = PnR     .mkRule( 'gds'  , [ 'chip_r.gds'
#                                      , 'chip_r.vst'
#                                      , 'chip_r.spi'
#                                      , 'chip.vst'
#                                      , 'chip.spi'
#                                      , 'corona_cts_r.vst'
#                                      , 'corona_cts_r.spi'
#                                      , 'corona.vst'
#                                      , 'corona.spi'
#                                      , 'picorv32_cts.spi'
#                                      , 'picorv32_cts.vst' ]
#                                      , [ruleYosys, ruleSeal]
#                                    , scriptMain
#                                    , topName=topName )
# Rule for block generation.
rulePnR   = PnR     .mkRule( 'gds'  , [ 'picorv32_cts_r.gds'
                                      , 'picorv32_cts_r.vst'
                                      , 'picorv32_cts_r.spi' ]
                                      , [ruleYosys]
                                    , doDesign.scriptMain
                                    , topName=topName )
#ruleFiller = Filler.mkRule( 'filler', depends=[ rulePnR.file_target(0) ]
#                                    , targets=[ '../gds/FMD_QNC_picorv32.gds' ]
#                                    , flags  =Filler.NoActiv
#                                    )
#ruleFMD = Copy.mkRule( 'fmd', '../gds/FMD_QNC_picorv32.gds', [rulePnR] )
#shellEnv = ShellEnv()
#shellEnv[ 'SOURCE_FILE' ] = rulePnR.file_target(0).as_posix()
#shellEnv[ 'REPORT_FILE' ] = rulePnR.file_target(0).with_suffix('.kdrc-report.txt').as_posix()
#shellEnv[ 'CELL_NAME'   ] = rulePnR.file_target(0).stem
#shellEnv.export()
#ruleDRC    = DRC   .mkRule( 'drc', rulePnR.file_target(0) )
ruleDrcMin  = DRC    .mkRule( 'drc_min', rulePnR.file_target(0), DRC.Minimal )
ruleDrcMax  = DRC    .mkRule( 'drc_max', rulePnR.file_target(0), DRC.Maximal )
ruleDrcC4M  = DRC    .mkRule( 'drc_c4m', rulePnR.file_target(0), DRC.C4M )
ruleSTA     = STA    .mkRule( 'sta'    , rulePnR.file_target(2))
ruleXTas    = XTas   .mkRule( 'xtas'   , ruleSTA.file_target(0) )

# To run individual tools in stand-alone mode.
ruleCgt     = PnR    .mkRule( 'cgt' )
ruleKlayout = Klayout.mkRule( 'klayout', depends=rulePnR.file_target(0) )
ruleClean   = Clean  .mkRule( [ 'lefRWarning.log', 'cgt.log' ] )
