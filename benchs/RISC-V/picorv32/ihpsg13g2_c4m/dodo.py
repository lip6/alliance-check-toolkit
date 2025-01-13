
import os
from   pathlib import Path
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
from coriolis.designflow.copy               import Copy
from coriolis.designflow.clean              import Clean
from pdks.ihpsg13g2_c4m.designflow.filler   import Filler
from pdks.ihpsg13g2_c4m.designflow.sealring import SealRing
from doDesign                               import scriptMain


PnR.textMode = True
pnrSuffix    = '_cts_r'
topName      = 'picorv32'

ruleYosys = Yosys   .mkRule( 'yosys', 'picorv32.v' )
ruleB2V   = Blif2Vst.mkRule( 'b2v'  , 'picorv32.vst', [ruleYosys], flags=0 )
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
#                                      , [ruleB2V, ruleSeal]
#                                    , scriptMain
#                                    , topName=topName )
# Rule for block generation.
rulePnR   = PnR     .mkRule( 'gds'  , [ 'picorv32_cts_r.gds'
                                      , 'picorv32_cts_r.vst'
                                      , 'picorv32_cts_r.spi' ]
                                      , [ruleB2V]
                                    , scriptMain
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

# To run individual tools in stand-alone mode.
ruleCgt     = PnR    .mkRule( 'cgt' )
ruleKlayout = Klayout.mkRule( 'klayout', depends=rulePnR.file_target(0) )
ruleClean   = Clean  .mkRule( [ 'lefRWarning.log', 'cgt.log' ] )
